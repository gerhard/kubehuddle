This repository has all the code used for [You're holding it wrong](https://kubehuddle.com/2022/#speaker-gerhard-lazu), my KubeHuddle talk - Oct. 3, 2022.

You will find:
- Dagger.io v0.2.x pipeline config: [kubehuddle.cue](kubehuddle.cue)
- Dagger.io v0.2.x code to manage a Civo.com K8s cluster: [civo/k8s.cue](civo/k8s.cue)
- K8s manifests used for bootstraping a newly created Civo.com K8s cluster: [bootstrap](bootstrap)
- K8s app manifests used by ArgoCD to automatically keep the app in sync: [app/yaml](app/yaml)
- GitHub Action that uses Dagger.io to build, publish the app image & auto-commits: [.github/workflows/dagger.yml](.github/workflows/dagger.yml)
- 💡 App image uses `cosign` verification: [kubehuddle.cue#L110-L128](kubehuddle.cue#L110-L128)
- GitHub Action workflow runs: [Dagger](actions/workflows/dagger.yml)
- ArgoCD config that auto-deploys when the repository updates: [bootstrap/3.argocd-app.yml](bootstrap/3.argocd-app.yml)

Slides are publicly available: [🗂 TBA](#)

The talk has been recorded Oct. 3, 2022 and can be watched here: [🎬 TBA](#)

## Abstract

| Format       | Duration   | Level    |
| :--          | :--        | :--      |
| Presentation | 20 minutes | Advanced |

CI/CD is what gets your code from your laptop to your Kubernetes.

If that is not the case, this talk is not for you. What if I told you that you've been holding CI/CD wrong all this time?
If you cannot run it locally, need to wait more than 5 minutes to see if a change works, and get goose bumps when someone on your team mentions migrating CI/CD, you're holding it wrong.

After decades thinking about this problem, this is what holding it right means to me.
Kubernetes is a small piece of the puzzle, and contrary to what many think, it should not be used to solve all problems.
I learned this from someone else, and also... Join me if you are curious to see where this goes.

## Checklist

- [x] Extract code in this standalone repository
- [x] Check that GitHub workflow works
- [x] Make `kubehuddle` package (container) public
- [x] Link this repository to `kubehuddle` package
- [ ] Check that code works on a clean workstation (`hannibal`)
- [ ] Link to slides
- [ ] Link to video
- [ ] Tag `2022` & update links in README.md
