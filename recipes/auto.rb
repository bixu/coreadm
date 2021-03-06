#
# Cookbook Name:: coreadm
# Recipe:: default
#
# Copyright 2013, Wanelo, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
directory "#{node['coreadm']['path']}" do
  action :create
end

global_pattern = node['coreadm']['global_pattern']
                 .sub('<path>', node['coreadm']['path'])
                 .sub('<name>', node['coreadm']['name_pattern'])

init_pattern = node['coreadm']['init_pattern']
               .sub('<path>', node['coreadm']['path'])
               .sub('<name>', node['coreadm']['name_pattern'])

helper = Coreadm::Current.new

execute 'Configure global coreadm settings' do
  command global_pattern
  not_if { helper.global_pattern == global_pattern }
end

execute 'configure coreadm settings for init child processes' do
  command init_pattern
  not_if { helper.init_pattern == init_pattern }
end
