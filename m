Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85E4308457
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 04:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbhA2Drh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 22:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhA2Dr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 22:47:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C11C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:46:46 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id l9so10997594ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 19:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hp4LmEBw8ZJdLLiSuVq/l9Tumx/V32XIRi5N9lrM6Zw=;
        b=ZzYrZZcRCXiZLYaSmVHMU869ecK+wri+U2b4udYil5XZnTisGIglouELzgdv5U6NvV
         VWIGQkXVbmTiOWdn4R09dOte1MOV9nXkgxS0GsfUNvNRqzIHi3XZFAZ887ab5j7EBAEs
         TPcGvpp+ZWqzp4/FOw5ndvxklQ1JoB8IZWpiC+weW+QiUhjuD/8KCLJZCox3fnkeGsRQ
         qt/nU3Md2AoNfmTU04Y4CXbHndGWPEzFnMu8NqXdGxmapqsejWyIbUoe6NzEXZ3/Br42
         iT7Nfeghp6Zabkn2nzzmNpuzBhv3gFOD3SbqG6cD3W4v52UYQVkJzbULFd2P2gV7stqC
         vEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=hp4LmEBw8ZJdLLiSuVq/l9Tumx/V32XIRi5N9lrM6Zw=;
        b=kSUqbbv8SoHx5M2fZjR8wcBwsZQ8RdYdpZVVFZgRWNIKgQKgSs+OB0ncoSCbe8iBdC
         lP8IQ7YfItTZJBu8Y8L11M15mL/T5xHdzMRV7fCsjkTcXDWNRy34Be5yjglBcf7dhr4F
         4wKXKk9cB/dgilNBjOAoO8nR22a4EXeCWy6bMHaQggao9jrckkrfATlD/w+MgGhdFO54
         bIqGvcfT/I7BSPvIijHhRlk/jeVs9AOdG2LpXjEQL/Mbw1XouFCmglJWWi+QBYr39dPs
         TAgowg7VfLjV4BmglnPN4+t12MgAay4kDkgMht2YfQHawOjnLcJqn67fLzeVURKZ8/KN
         cXzg==
X-Gm-Message-State: AOAM530odNLZy38cRasGycDu/1l/Y8TUgwGhbOFswPUKF+kLcvcreUqT
        rPVunR/KrFQXqebwgxcLXEq0r0JTGNFz6hA7+RZXBfo63CHe3A==
X-Google-Smtp-Source: ABdhPJzOXxH5mmtFFDqqzbP6D3+5w5D5FY38X/VaRYwkZe3Mc02WbaZXyqVHPcJTpL+QNSDos6pXsQT5HiyNEFkV3kQ=
X-Received: by 2002:a17:906:5608:: with SMTP id f8mr2627357ejq.101.1611892005510;
 Thu, 28 Jan 2021 19:46:45 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 29 Jan 2021 13:46:34 +1000
Message-ID: <CAPM=9tyS8E3cL0s0jQ7fgV+uRrxPOxsG6n_4MpZEOa6AzXSZnQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.11-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

Weekly fixes for graphics, nothing too major, nouveau has a few
regression fixes for various fallout from header changes previously,
vc4 has two fixes, two amdgpu, and a smattering of i915 fixes.

All seems on course for a quieter rc7, fingers crossed.

Dave.

drm-fixes-2021-01-29:
drm fixes for 5.11-rc6

nouveau:
- fix svm init conditions
- fix nv50 modesetting regression
- fix cursor plane modifiers
- fix > 64x64 cursor regression

vc4:
- Fix LBM size calculation
- Fix high resolutions for hvs5

i915:
- Fix ICL MG PHY vswing
- Fix subplatform handling
- Fix selftest memleak
- Clear CACHE_MODE prior to clearing residuals
- Always flush the active worker before returning from the wait
- Always try to reserve GGTT address 0x0

amdgpu:
- Fix a fan control regression on some boards
- Fix clang warning
The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04=
:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-01-29

for you to fetch changes up to e0ecafede87eb1a3d1e708f0365fad0d59489285:

  Merge tag 'amd-drm-fixes-5.11-2021-01-28' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-01-29
11:36:38 +1000)

----------------------------------------------------------------
drm fixes for 5.11-rc6

nouveau:
- fix svm init conditions
- fix nv50 modesetting regression
- fix cursor plane modifiers
- fix > 64x64 cursor regression

vc4:
- Fix LBM size calculation
- Fix high resolutions for hvs5

i915:
- Fix ICL MG PHY vswing
- Fix subplatform handling
- Fix selftest memleak
- Clear CACHE_MODE prior to clearing residuals
- Always flush the active worker before returning from the wait
- Always try to reserve GGTT address 0x0

amdgpu:
- Fix a fan control regression on some boards
- Fix clang warning

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)"

Arnd Bergmann (1):
      amdgpu: fix clang build warning

Bastian Beranek (1):
      drm/nouveau/dispnv50: Restore pushing of all data.

Ben Skeggs (1):
      drm/nouveau/nvif: fix method count when pushing an array

Chris Wilson (3):
      drm/i915/gt: Clear CACHE_MODE prior to clearing residuals
      drm/i915: Always flush the active worker before returning from the wa=
it
      drm/i915/gt: Always try to reserve GGTT address 0x0

Dave Airlie (4):
      Merge branch '04.01-ampere-lite' of
git://github.com/skeggsb/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2021-01-27' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-01-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.11-2021-01-28' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Dom Cobley (2):
      drm/vc4: Correct lbm size and calculation
      drm/vc4: Correct POS1_SCL for hvs5

Karol Herbst (1):
      drm/nouveau/svm: fail NOUVEAU_SVM_INIT ioctl on unsupported devices

Lyude Paul (3):
      drivers/nouveau/kms/nv50-: Reject format modifiers for cursor planes
      drm/nouveau/kms/nv50-: Report max cursor size to userspace
      drm/nouveau/kms/gk104-gp1xx: Fix > 64x64 cursors

Pan Bian (1):
      drm/i915/selftest: Fix potential memory leak

Umesh Nerlige Ramappa (1):
      drm/i915: Check for all subplatform bits

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix ICL MG PHY vswing handling

 drivers/gpu/drm/amd/display/dc/dcn30/Makefile      |   6 +-
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile     |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile     |   3 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |   1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |   3 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   9 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   1 +
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |  31 ++-
 drivers/gpu/drm/i915/display/intel_ddi.c           |   7 +-
 drivers/gpu/drm/i915/gt/gen7_renderclear.c         |  12 ++
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |  47 +++--
 drivers/gpu/drm/i915/i915_active.c                 |  28 +--
 drivers/gpu/drm/i915/i915_drv.h                    |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |   2 +-
 drivers/gpu/drm/nouveau/dispnv50/base507c.c        |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/base827c.c        |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   8 +
 drivers/gpu/drm/nouveau/dispnv50/head917d.c        |  28 ++-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |  17 +-
 .../gpu/drm/nouveau/include/nvhw/class/cl917d.h    |   4 +
 drivers/gpu/drm/nouveau/include/nvif/push.h        | 216 ++++++++++-------=
----
 drivers/gpu/drm/nouveau/nouveau_svm.c              |   4 +
 drivers/gpu/drm/vc4/vc4_hvs.c                      |   8 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |  11 +-
 26 files changed, 300 insertions(+), 165 deletions(-)
