# # encoding: utf-8

# Inspec test for recipe hms::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe file('/etc/yum.repos.d/epel.repo') do
  it { should be_file }
end

pkg_list = %w(atop htop bind-utils wget vim-enhanced)
pkg_list.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

dir_list = %w(/home/plex /home/media /home/media/tv /home/media/movies /home/media/music /home/deluge /home/downloads /home/downloads/incomplete /home/downloads/completed /home/downloads/seeds /home/radarr /home/jackett /home/sonarr /home/plexpy /home/headphones /home/sabnzbd)
dir_list.each do |dir|
  describe directory(dir) do
    it { should exist }
  end
end

describe group('mediaadmins') do
  it { should exist }
  its('gid') { should eq 1001 }
end

usr_list = %w(deluge plex radarr sonarr jackett plexpy headphones sabnzbd)
usr_list.each do |usr|
  describe user(usr) do
    it { should exist }
    its('shell') { should eq '/sbin/nologin' }
    its('groups') { should eq [usr, 'mediaadmins'] }
  end
end

describe package('docker') do
  it { should be_installed }
end

describe service('docker') do
  it { should be_running }
  it { should be_enabled }
end

describe docker_container('plex') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'plexinc/pms-docker' }
  its('tag') { should eq 'latest' }
end

describe docker_container('radarr') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/radarr' }
  its('tag') { should eq 'latest' }
end

describe docker_container('jackett') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/jackett' }
  its('tag') { should eq 'latest' }
end

describe docker_container('sonarr') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/sonarr' }
  its('tag') { should eq 'latest' }
end

describe docker_container('plexpy') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/plexpy' }
  its('tag') { should eq 'latest' }
end

describe docker_container('headphones') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/headphones' }
  its('tag') { should eq 'latest' }
end

describe docker_container('pia') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'colinhebert/pia-openvpn' }
  its('tag') { should eq 'latest' }
end

describe docker_container('deluge') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/deluge' }
  its('tag') { should eq 'latest' }
end

describe docker_container('sabnzbd') do
  it { should exist }
  it { should be_running }
  its('repo') { should eq 'linuxserver/sabnzbd' }
  its('tag') { should eq 'latest' }
end

port_list = %w(8080 32400 32401 8181 32469 22 32600 8989 9117 7878 8112 9090)
port_list.each do |prt|
  describe port(prt) do
    it { should be_listening }
  end
end
