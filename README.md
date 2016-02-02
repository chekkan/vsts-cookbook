# vsts-cookbook
Visual Studio Team Service Cookbook

```
vsts_build_artifact 'drop' do
  instance 'fabrikam.visualstudio.com'
  project_id 'Fabrikam-Fiber-Git'
  username 'vso-user'
  access_token 'access_token'
  build_id 391
  action :download
  destination 'C:\\drops'
  path 'drop/subfolder'
end
```
