Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253EA34A048
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhCZDeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhCZDeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:34:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD9C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:34:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so6311170ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Pz3gi7M6tKZ1q1WQC3HX6aCYweNL/qRxtsFxLRv392w=;
        b=vdadOYi41ZiL4qVVAfKh2ya8cgIaxkWOlD/NCDu28J1n/do6SB7BEQrMHoqe1kArmT
         qHlbZ+6rS2CZv/wDbeHRq3kU+iq3NEFBS3JosQ9J9mEi9TzYo00bfN+UflRFr9+WGHZN
         BepuD/nTGP/3D2bDhYWjueqp8Wxa7Kmj5UHroUQhTURS7EAxvOp33ihckvszxPNu7p1F
         5Z3V/InCUuq5EJXA2da7ccuzDAAR6g9kEDje/cTVyv4htxQ+H3tDAq91vEaj0fGIu3v6
         Mx367n3mOZWO6kkJbuqc6NhU0LWk+gbkNQZvL3nI4hV/sF7KtMcl84jPGCalBWM8FKN3
         5V7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=Pz3gi7M6tKZ1q1WQC3HX6aCYweNL/qRxtsFxLRv392w=;
        b=DS1da0XMZw+2Fr61nuTbtkReXldUs/lr1wFexl0S4COD9EPSukXlOC/3LR/WBbFTlg
         2BMNJRqmMluQhMN67v1q+WjrQdxN7nXTwg1lBh1y8+Ny+N+3nw/TnN+XJunGwLOyiUM7
         hFXfxcInt4hp1mAzPZQwe2KRAMHWwx16Rn5OyrWpqEtwUAIwye+MlLHjAxf4hUcaFdtB
         e1w0GsSznRf+6rdZaKBUCQ19ZSlWQKeFvm9Qbj1He43l3XOQw2J8kNWTKoqyfRVifoLp
         Lq/+MIzMZB2kYjjtbsjx3b5NlO8LYoSFcFNYQzTeeKm6kmz2ama4lj7Hu8D2QCUKnG0o
         /YEw==
X-Gm-Message-State: AOAM532XBNvzggDMTKj+h7kmtLJXGsVx4ctWqLEK94zvz6eEsxsoQyX4
        akdRzVRveFIzZVTz/tX+viFANTy6lS7K+YyLqJo=
X-Google-Smtp-Source: ABdhPJzlf3xpQ/SsC+WgpomJbpsn6e+VwqFCZYG2/CJJMFJEldAz/seH56VnWmxgdOprqTHVqYpntZyYXz5y79rBaL4=
X-Received: by 2002:a17:906:af97:: with SMTP id mj23mr13475622ejb.419.1616729654146;
 Thu, 25 Mar 2021 20:34:14 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 26 Mar 2021 13:34:03 +1000
Message-ID: <CAPM=9twkAXygrutCExSdhRh69Vvnr0X7HagQw8WQGZgC_UdTGA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12-rc5
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

As expected last week things were overly quiet so this week things
seem to have caught up. It still isn't too major.

msm and amdgpu lead the size here, the msm fixes are pretty varied
across the driver, the amdgpu one is mostly the S0ix fixes with some
other minor ones. Otherwise there are a few i915 fixes and one each
for nouveau, etnaviv and rcar-du.

Dave.

drm-fixes-2021-03-26:
drm fixes for 5.12-rc5

msm:
- pll fixes
- shutdown hook fix
- runtime resume fix
- clear_oob fix
- kms locking fix
- display aux retry fix

rcar-du:
- warn_on in encoder init fix

etnaviv:
- Use FOLL_FORCE and FOLL_LONGTERM

i915:
- DisplayPort LTTPR fixes around link training and limiting it
  according to supported spec version.
- Fix enabled_planes bitmask to really represent only logically
  enabled planes.
- Fix DSS CTL registers for ICL DSI transcoders
- Fix the GT fence revocation runtime PM logic.

nouveau:
- cursor size regression fix

amdgpu:
- S0ix fixes
- Add PCI ID
- Polaris PCIe DPM fix
- Display fix for high refresh rate monitors
The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b=
:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-03-26

for you to fetch changes up to 09d78dde88ef95a27b54a6e450ee700ccabdf39d:

  Merge tag 'drm-msm-fixes-2021-02-25' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2021-03-26
13:04:17 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc5

msm:
- pll fixes
- shutdown hook fix
- runtime resume fix
- clear_oob fix
- kms locking fix
- display aux retry fix

rcar-du:
- warn_on in encoder init fix

etnaviv:
- Use FOLL_FORCE and FOLL_LONGTERM

i915:
- DisplayPort LTTPR fixes around link training and limiting it
  according to supported spec version.
- Fix enabled_planes bitmask to really represent only logically
  enabled planes.
- Fix DSS CTL registers for ICL DSI transcoders
- Fix the GT fence revocation runtime PM logic.

nouveau:
- cursor size regression fix

amdgpu:
- S0ix fixes
- Add PCI ID
- Polaris PCIe DPM fix
- Display fix for high refresh rate monitors

----------------------------------------------------------------
Alex Deucher (11):
      drm/amdgpu: rework S3/S4/S0ix state handling
      drm/amdgpu: don't evict vram on APUs for suspend to ram (v4)
      drm/amdgpu: clean up non-DC suspend/resume handling
      drm/amdgpu: move s0ix check into amdgpu_device_ip_suspend_phase2 (v3)
      drm/amdgpu: re-enable suspend phase 2 for S0ix
      drm/amdgpu/swsmu: skip gfx cgpg on s0ix suspend
      drm/amdgpu: update comments about s0ix suspend/resume
      drm/amdgpu: drop S0ix checks around CG/PG in suspend
      drm/amdgpu: skip kfd suspend/resume for S0ix
      drm/amdgpu: Add additional Sienna Cichlid PCI ID
      drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x

Daniel Vetter (2):
      drm/etnaviv: Use FOLL_FORCE for userptr
      drm/etnaviv: User FOLL_LONGTERM in userptr

Dave Airlie (6):
      Merge tag 'du-fixes-20210316' of
git://linuxtv.org/pinchartl/media into drm-fixes
      Merge tag 'drm-misc-fixes-2021-03-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-03-25-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge branch 'linux-5.12' of git://github.com/skeggsb/linux into drm-=
fixes
      Merge tag 'amd-drm-fixes-5.12-2021-03-24' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-msm-fixes-2021-02-25' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Dmitry Baryshkov (4):
      drm/msm/dsi: fix check-before-set in the 7nm dsi_pll code
      drm/msm/dsi_pll_7nm: Solve TODO for multiplier frac_bits assignment
      drm/msm/dsi_pll_7nm: Fix variable usage for pll_lockdet_rate
      drm/msm: fix shutdown hook in case GPU components failed to bind

Douglas Anderson (1):
      drm/msm: Fix speed-bin support not to access outside valid memory

Fabio Estevam (1):
      drm/msm: Fix suspend/resume on i.MX5

Imre Deak (4):
      drm/i915/ilk-glk: Fix link training on links with LTTPRs
      drm/i915: Disable LTTPR support when the DPCD rev < 1.4
      drm/i915: Disable LTTPR support when the LTTPR rev < 1.4
      drm/i915: Fix the GT fence revocation runtime PM logic

Jani Nikula (1):
      drm/i915/dsc: fix DSS CTL register usage for ICL DSI transcoders

Jonathan Marek (1):
      drm/msm: fix a6xx_gmu_clear_oob

Jordan Crouse (1):
      drm/msm: a6xx: Make sure the SQE microcode is safe

Kalyan Thota (1):
      drm/msm/disp/dpu1: icc path needs to be set before dpu runtime resume

Kenneth Feng (1):
      drm/amd/pm: workaround for audio noise issue

Kieran Bingham (1):
      drm: rcar-du: Use drmm_encoder_alloc() to manage encoder

Konrad Dybcio (1):
      drm/msm/adreno: a5xx_power: Don't apply A540 lm_setup to other GPUs

Lyude Paul (1):
      drm/nouveau/kms/nve4-nv108: Limit cursors to 128x128

Pratik Vishwakarma (1):
      drm/amdgpu: skip CG/PG for gfx during S0ix

Prike Liang (1):
      drm/amdgpu: fix the hibernation suspend with s0ix

Rob Clark (1):
      drm/msm: Ratelimit invalid-fence message

Stephen Boyd (2):
      drm/msm/kms: Use nested locking for crtc lock instead of custom class=
es
      drm/msm/dp: Restore aux retry tuning logic

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Fix enabled_planes bitmask

 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 132 ++++++-----------=
----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  89 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h        |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  31 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   7 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |   9 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |   9 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |   8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |   9 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |  15 ++-
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c  |   3 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  54 +++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  74 ++++++++++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  24 ++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  25 ++++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   5 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem.c              |   3 +-
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |   5 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   4 +-
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |   7 ++
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  75 +++++++++---
 .../gpu/drm/i915/display/intel_dp_link_training.h  |   2 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |  10 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |  13 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |  29 ++++-
 drivers/gpu/drm/i915/intel_runtime_pm.h            |   5 +
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 108 +++++++++++------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  12 +-
 drivers/gpu/drm/msm/dp/dp_aux.c                    |   7 ++
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.c              |   2 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.h              |   6 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c          |  11 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |   7 +-
 drivers/gpu/drm/msm/msm_drv.c                      |  12 ++
 drivers/gpu/drm/msm/msm_fence.c                    |   2 +-
 drivers/gpu/drm/msm/msm_kms.h                      |   8 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  13 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |  31 +----
 41 files changed, 617 insertions(+), 266 deletions(-)
