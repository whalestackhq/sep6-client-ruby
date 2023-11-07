require 'rest-client'
require 'json'
require 'time'
require 'sep6_client/config'
require 'uri'
require 'openssl'

 # Ruby implementation of a REST client for the Whalestack Merchant API
 # see https://www.whalestack.com/en/api-docs
module Sep6Client

  class Client

    # Initializes the Sep-6 Client
    # @param transfer_server; the SEP-6 transfer server
    # @param log_file; optional log file path
    # @constructor
    def initialize(transfer_server = nil, log_file = nil)

      # @string Used in the HTTP user agent (leave it as is)
      @client_name = Sep6Client::CLIENT_NAME

      # @string The current version of this SDK, used in the HTTP user agent (leave it as is)
      @client_version = Sep6Client::CLIENT_VERSION

      # @string Whalestack connect url
      @transfer_server = transfer_server ? transfer_server : Sep6Client::TRANSFER_SERVER

      # @string|nil Specifies the log file to which to write, if any.
      @log_file = log_file ? log_file : nil

    end

    # Use this method to communicate with GET endpoints
    # @param endpoint (string), e.g. GET /customer
    # @param params (hash), a list of GET parameters to be included in the request
    # @return RestClient::Response, https://github.com/rest-client/rest-client/blob/2c72a2e77e2e87d25ff38feba0cf048d51bd5eca/lib/restclient/response.rb
    def get(endpoint, params = {})

      path = build_connect_url(endpoint) + '?' +  URI.encode_www_form(params)
      headers = build_headers(endpoint, 'GET', params)

      log "GET " + path
      log headers.to_s

      begin
        response = RestClient::Request.execute(method: :get, url: path, headers: headers, timeout: 180)
      rescue RestClient::ExceptionWithResponse => e
        log e.http_code.to_s + " " + e.response.to_s
        return e.response
      end

      log response.code.to_s + " " + response.to_s

      response

    end

    # Use this method to communicate with POST endpoints
    # @param endpoint (string), e.g. POST /checkout/hosted
    # @param params (hash), a list of GET parameters to be included in the request
    # @return RestClient::Response, https://github.com/rest-client/rest-client/blob/2c72a2e77e2e87d25ff38feba0cf048d51bd5eca/lib/restclient/response.rb
    def post(endpoint, params = {})

      path = build_connect_url(endpoint)
      headers = build_headers(endpoint, 'POST', params)

      log "POST " + path + " " + params.to_s
      log headers.to_s

      begin
        response = RestClient::Request.execute(method: :post, url: path, payload: params.to_json, headers: headers, timeout: 180)
      rescue RestClient::ExceptionWithResponse => e
        log e.http_code.to_s + " " + e.response.to_s
        return e.response
      end

      log response.code.to_s + " " + response.to_s

      response

    end

    # Use this method to communicate with PUT endpoints
    # @param endpoint (string), e.g. PUT /customer
    # @param params (hash), a list of GET parameters to be included in the request
    # @return RestClient::Response, https://github.com/rest-client/rest-client/blob/2c72a2e77e2e87d25ff38feba0cf048d51bd5eca/lib/restclient/response.rb
    def put(endpoint, params = {})

      path = build_connect_url(endpoint)
      headers = build_headers(endpoint, 'PUT', params)

      log "PUT " + path + " " + params.to_s
      log headers.to_s

      begin
        response = RestClient::Request.execute(method: :put, url: path, payload: params.to_json, headers: headers, timeout: 180)
      rescue RestClient::ExceptionWithResponse => e
        log e.http_code.to_s + " " + e.response.to_s
        return e.response
      end

      log response.code.to_s + " " + response.to_s

      response

    end

    # Use this method to communicate with PUT endpoints
    # @param endpoint (string), e.g. PUT /customer
    # @param params (hash), a list of GET parameters to be included in the request
    # @return RestClient::Response, https://github.com/rest-client/rest-client/blob/2c72a2e77e2e87d25ff38feba0cf048d51bd5eca/lib/restclient/response.rb
    def delete(endpoint, params = {})

      path = build_connect_url(endpoint)
      headers = build_headers(endpoint, 'DELETE', params)

      log "DELETE " + path + " " + params.to_s
      log headers.to_s

      begin
        response = RestClient::Request.execute(method: :delete, url: path, payload: params.to_json, headers: headers, timeout: 180)
      rescue RestClient::ExceptionWithResponse => e
        log e.http_code.to_s + " " + e.response.to_s
        return e.response
      end

      log response.code.to_s + " " + response.to_s

      response

    end

    # private class to generate connect url on Whalestack servers
    private
    def build_connect_url(endpoint)
      "https://" + @transfer_server + endpoint
    end

    # private class to generate authentication headers
    private
    def build_headers(endpoint, method, params)
      {
          :"User-Agent" => @client_name + " " + @client_version
      }
    end


    private
    def log(text)

      if @log_file == nil
        return
      end

      File.open(@log_file, 'a') { |f| f.write(Time.now.utc.rfc822 + " [Whalestack] " + text + "\n") }
      # print Time.now.utc.rfc822 + " [Whalestack] " + text + "\n"

    end

  end

end
