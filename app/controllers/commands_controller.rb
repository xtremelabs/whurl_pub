class CommandsController < ApplicationController
  def new
    @command = Command.new
  end

  def create
    @command = Command.new(params['command'])
    @command.send_request
    @response_headers = @command.header_html
    respond_to do |format|
      format.html do
        @api_response = @command.response_html({:line_numbers => :table})
        render :edit
      end
      format.iphone do
        @api_response = @command.response_html({:line_numbers => nil})
        render :edit
      end
    end
  end

  def edit
#    @api_url = params.delete("url")
#    @method = params.delete("method")
#    params['header_keys'] = params['header_keys'].select {|k| k.present?} if params['header_keys'].present?
#    params['header_values'] = params['header_values'].select {|v| v.present?} if params['header_values'].present?
#    params['param_keys'] = params['param_keys'].select {|k| k.present?} if params['param_keys'].present?
#    params['param_values'] = params['param_values'].select {|v| v.present?} if params['param_values'].present?
#    redirect_to new_whurl_commands_path and return unless @api_url.present?
    @command = Command.new(params['command'])
    @command.send_request
    @response_headers = @command.header_html
    respond_to do |format|
      format.html do
        @api_response = @command.response_html({:line_numbers => :table})
      end
      format.iphone do
        @api_response = @command.response_html({:line_numbers => nil})
      end
    end

  rescue Exception => e
    @api_response = e.message
  end

end

