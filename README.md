# vsts-cookbook
Visual Studio Team Service Cookbook

```
vsts_build_artifact 'drop' do
  instance 'fabrikam.visualstudio.com'
  project_id 'Fabrikam-Fiber-Git'
  build_id 391
  action :download
  path 'C:\\drops'
end
```
