# Docker Jenkins

All Jenkins data lives in `/var/jenkins_home` (including plugins and configuration), so we use a persistent volume:

```
docker run --name oeg-jenkins -p 8080:8080 -p 50000:50000 -v /your/home:/var/jenkins_home cbadenes/jenkins
```

This will store the jenkins data in `/your/home` on the host. Ensure that `/your/home` is accessible by the jenkins user in container (jenkins user - uid 1000) or use `-u some_other_user` parameter with `docker run`.

## First-Time Configuration

### Manage Jenkins/Configure System

#### JDK Installation
Select `Add JDK`:  **first time you need to enter username/password for Oracle Account, after that reload the page**
- **Name**: Java 8_51
- **Install automatically**: true
- **Version**: Java SE Development Kit 8u51
- **I agree to the Java SE Development Kit License Agreement**: true

#### Maven Installation
Select `Add Maven`:  
- **Name**: Maven 3.3.3
- **Install automatically**: true
- **Version**: 3.3.3

#### Jenkins Location
Set local ip and system email address.

#### EMail Notification
Define SMTP settings to send emails from Jenkins when a compilation fails.


#### GitHub Web Hook
Select `Let Jenkins auto-manage hook URLs` and create a new *Github Credential* for each github user. Only include the *username* and the *oauth token*. This token is obtained from GitHub/Settings/Personal Access Tokens. Then `Generate new token` named *Jenkins* and select only *notification*. The value generated (e.g. 15c3568f424d3de925d7ad7dbe2c93709390a413) is copied and pasted in Jenkins.  
This plugin requires that you have an HTTP URL reachable from GitHub, which means it's reachable from the whole internet.

### Credentials

Select `Global credentials/Add Credentials` to add username/password for Github accounts.

## Add Jobs

Now, you can add a new git repository to be handled by Jenkins. These are the steps:
1. Select `New Item`
2. Introduce the name of the project and select the type of project (usually *Maven Project*)
3. Select `Discard Old Builds` and set the Max number of builds to keep (usually 5)
4. Enter the URL of the `GitHub project`.
4. Select `Git` as `Source Code Management`
    1. Introduce the url from github
    2. Select the credential
5. In the `Build Triggers` section, select *Build whenever a SNAPSHOT dependency is built* and *Build when a change is pushed to GitHub*
5. In the `Build` section, introduce the following `Goals and options`: *clean deploy*
6. Select `Email Notification` and include the recipients  

1. Select `New Item`
2. Introduce the name of the project and select the type of project (usually *Maven Project*)
3. Select `Discard Old Builds` and set the Max number of builds to keep (usually 5)
4. Enter the URL of the `GitHub project`.
5. Select `Git` as `Source Code Management`
  1. Introduce the url from github
  2. Select the credential
2. In the `Build Triggers` section, select *Build whenever a SNAPSHOT dependency is built* and *Build when a change is pushed to GitHub*
3. In the `Build` section, introduce the following `Goals and options`: *clean deploy*
4. Select `Email Notification` and include the recipients


Then, when you push code to master branch in Github, a new build execution is created in Jenkins automatically.

