Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE62E3B37AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhFXUT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhFXUT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:19:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EACC061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:17:35 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hq39so11419889ejc.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 13:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=EfSHQRlvaEgpVUWXkzLg8PjnVC4z8USfK0FstMn9aAg=;
        b=H9X5EFeM2RA8c73WDTTHjkI2Ch9pZ98aopuFblhijJBbmxCvfaO4bUvBIWDX7FQThL
         jbeUzx6Lo2VsdEwTIFUm3EjGKmg1DlNWS1TkxlK3oojDL31h/w0fQfQaODN4rZPSjDDM
         sw2vq+X8I9hKcmSb9HipTfyI2QCppQcuGV8ouvlriEYmKxyeJBlNqEgei39JpVcCmdzk
         CE8C9XBj3k9fPGLKdoJkT5a3tIUu0UCymkNQx/4zdIKJtxL5TpGMNqDTe1m493PpxhdT
         wv8Pc+mK4IvAbb+eLbnJ24fOOllZI8uMgKlQuIfPAdzuFYSp52T24wqSiKPyHbmws5fD
         n/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=EfSHQRlvaEgpVUWXkzLg8PjnVC4z8USfK0FstMn9aAg=;
        b=CCZnftVjs5I+D4PBF+ua8PIaXxMuYqI9jOk3L6spl5UL3FTMPDLHbjFSJdzWdgEvCd
         qqYpP1KrUL1xubkn6ucrgXW24vdOoMuX+xveBoVFfYB9CWBYY+wA8PQiy+eCZ6CL5+SL
         CQZM4Kr7SVZKv4pXWrwazp26UCg9rCUlPdl+shsHeIMd/3w3Na8b39qiqPPKw1YnMgPO
         nhPzUgvD5EKBxtxkMBUp5skTsBpqg7mGrA7ey6Ig321lhQ7ckGnui0SWjiqQhKa7gQmM
         fFobtXAi6TE3LaD8eGPqd1d4GQww9jQv/ApQSxETphy+c11uohHat5Gp+06Sw89k4lb1
         4t1Q==
X-Gm-Message-State: AOAM532EI61fciwuX2L9Xu8xKA74kx8ip6CSt/C9oDuUvQWG6+ZKMSCW
        hpxDCmklSMsG/CVgn7mG4NJdos8pMQ5BZkLxqw8=
X-Google-Smtp-Source: ABdhPJwQa4Ju0tf4msAPgZCRDlWCxSjjyeuZ/aYP0npu0K9cZUgs7CvxAcjQwcEFGvZ5E6YPcQ7rwbH6waCHs5kpaWg=
X-Received: by 2002:a17:906:af08:: with SMTP id lx8mr7170446ejb.317.1624565853470;
 Thu, 24 Jun 2021 13:17:33 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 25 Jun 2021 06:17:22 +1000
Message-ID: <CAPM=9ty9+nYh5JC-gw5Pf8u1QaYwr2PFcOKobohQz-RGaCP3mw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc8/final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a bit bigger than I'd like at this stage, and I guess last
week was extra quiet, but it's mostly one fix across 3 drivers to wait
for buffer move pinning to complete. There was one locking change that
got reverted so it's just noise. Otherwise the amdgpu/nouveau changes
are for known regressions, and otherwise it's just misc changes in
kmb/atmel/vc4 drivers.

I'm off for a few days (have email for some of it), but I'll be back
mid next week for hopefully the next PR.

Dave.

drm-fixes-2021-06-25:
drm fixes for 5.13-rc8/final

radeon/nouveau/amdgpu/ttm:
- same fix in 3 drivers to wait for BO to be pinned after
  moving it.

core:
- auth locking change + brown paper bag revert

amdgpu:
- Revert GFX9, 10 doorbell fixes, we just
  end up trading one bug for another
- Potential memory corruption fix in framebuffer handling

nouveau:
- fix regression checking dma addresses

kmb:
- error return fix

atmel-hlcdc:
- fix kernel warnings at boot
- enable async flips

vc4:
- fix CPU hang due to power management
The following changes since commit 13311e74253fe64329390df80bed3f07314ddd61=
:

  Linux 5.13-rc7 (2021-06-20 15:03:15 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-06-25

for you to fetch changes up to 5e0e7a407675d9f50f1d840214beaec42293b79b:

  Merge tag 'drm-misc-fixes-2021-06-24' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2021-06-25
06:05:13 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc8/final

radeon/nouveau/amdgpu/ttm:
- same fix in 3 drivers to wait for BO to be pinned after
  moving it.

core:
- auth locking change + brown paper bag revert

amdgpu:
- Revert GFX9, 10 doorbell fixes, we just
  end up trading one bug for another
- Potential memory corruption fix in framebuffer handling

nouveau:
- fix regression checking dma addresses

kmb:
- error return fix

atmel-hlcdc:
- fix kernel warnings at boot
- enable async flips

vc4:
- fix CPU hang due to power management

----------------------------------------------------------------
Christian K=C3=B6nig (4):
      drm/nouveau: wait for moving fence after pinning v2
      drm/radeon: wait for moving fence after pinning
      drm/amdgpu: wait for moving fence after pinning
      drm/nouveau: fix dma_address check for CPU/GPU sync

Dan Sneddon (2):
      drm: atmel_hlcdc: Enable the crtc vblank prior to crtc usage.
      drm/atmel-hlcdc: Allow async page flips

Daniel Vetter (1):
      Revert "drm: add a locked version of drm_is_current_master"

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.13-2021-06-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2021-06-24' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Desmond Cheong Zhi Xi (1):
      drm: add a locked version of drm_is_current_master

Krzysztof Kozlowski (1):
      drm/panel: ld9040: reference spi_device_id table

Maxime Ripard (2):
      drm/vc4: hdmi: Move the HSM clock enable to runtime_pm
      drm/vc4: hdmi: Make sure the controller is powered in detect

Michel D=C3=A4nzer (1):
      drm/amdgpu: Call drm_framebuffer_init last for framebuffer init

Yifan Zhang (2):
      Revert "drm/amdgpu/gfx10: enlarge CP_MEC_DOORBELL_RANGE_UPPER to
cover full doorbell."
      Revert "drm/amdgpu/gfx9: fix the doorbell missing when in CGPG issue.=
"

Zhen Lei (1):
      drm/kmb: Fix error return code in kmb_hw_init()

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c    | 12 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c    | 14 +++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         |  6 +---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          |  6 +---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 17 ++++++----
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c   |  1 +
 drivers/gpu/drm/kmb/kmb_drv.c                  |  1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c           |  4 +--
 drivers/gpu/drm/nouveau/nouveau_prime.c        | 17 +++++++++-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c   |  1 +
 drivers/gpu/drm/radeon/radeon_prime.c          | 16 ++++++++--
 drivers/gpu/drm/vc4/vc4_hdmi.c                 | 44 ++++++++++++++++++++--=
----
 12 files changed, 100 insertions(+), 39 deletions(-)
