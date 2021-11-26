Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C816F45E3D2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbhKZA6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhKZA4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:56:41 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E01C061758
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:52:17 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id e3so31936212edu.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4cukbLGM00mmGR5pILYZRAbHPvNf+KpqSNLk4+sIbJY=;
        b=Mbtund93TL16No+50+l4W37cFpU7y1ws2chxqkdlIO6yvd/EsIJUGCviQlzqgObIuE
         iZzkR2wxUViiWrbSzkSBhTZyB4fR0g4T+V9dAoPrCsFF64Z/lyXjawrgSflgvVCGsw31
         oeHy23RGBf1CnowIkwd6SSj2J6P4XwSmJ/O0nygAOhWFYvY9yApTsgmm1QEtKK4mcTxf
         r7TPDj2v7ZLuNvIRfRD+D4bos8MxN9H7XOhf83ilbgNsXkBUeKumC4clC/olqCYP/IhS
         CLIGlWPqd3NW79B/xdgRpQ2ihV/tUAw3LrkhMw9FDI1QwvaTm43DUvct9cN/O7SPoj0Q
         388Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4cukbLGM00mmGR5pILYZRAbHPvNf+KpqSNLk4+sIbJY=;
        b=j/Yb9e8PeSg4Hffe5qufU5EEsseJtWxRLNQhAUNlIMK8B8NjvvWVaD2Ote6bMI4z87
         XB320D2KNF0LPghvB9K4wOB9RlrHaCKzWBZkWpPgVgb1wJWaZCNx9vwJejShxlQfJiMa
         nFR/3sny6AqtiMvTtnmjHD6NmeGzvrS1n0xpZviJ+91Ko5z/wlzef3dxsNvLyB2NA+90
         IK2Uo46RegwLPwM13LlBm+AitfJpRe+QXKfLaFt9d0gbS+fgJtc7rt07CNm4Z2PC0yrk
         MgyGpT74NJyZdzdPV8tQax6kHnU4wTs/R8pJo7yFzf06+6LWh3ZRdvFFQ9cpHwdT5yNb
         ilCA==
X-Gm-Message-State: AOAM532/mbCml2XLzyoTmjD8YWu79e9Jnk6ZJ8L2ZuQTjR5lu48AaaLh
        f5qUDMFRtCBYqp8efjfZgB5wAP8VgJ5EmO/j6TmkzuDUyTI=
X-Google-Smtp-Source: ABdhPJyuZAf5LOCTL7jvEU0DH37vpr3btzx2DgFXRjQ+7qxjcNIEOAZFm8F4wsT7GY/76P+myqGB86eGP7PbHRVoKjI=
X-Received: by 2002:a17:906:5d06:: with SMTP id g6mr36699935ejt.3.1637887935566;
 Thu, 25 Nov 2021 16:52:15 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 26 Nov 2021 10:52:04 +1000
Message-ID: <CAPM=9twJOj8+cfEPArF7N_TZpVM8vN+S4s2mMM7phsS-ZOgmJA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.16-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Linus,

No idea if turkey comes before pull request processing, but here's the
regular week's fixes. A bunch for amdgpu, nouveau adds support for a
new GPU (like a PCI ID addition), and a scattering of fixes across
i915/hyperv/aspeed/vc4.

Dave.

drm-fixes-2021-11-26:
drm fixes for 5.16-rc3

amdgpu:
- SRIOV fixes
- dma-buf double free fix
- Display fixes for GPU resets
- Fix DSC powergating regression
- GPU TSC fixes
- Interrupt handler overflow fixes
- Endian fix in IP discovery table handling
- Aldebaran ASPM fix
- Fix overclocking regression on older asics
- Backlight/ACPI fix

amdkfd:
- SVM fixes
- VMA removal race fix

hyperv:
- removal fix

aspeed:
- vga_pw sysfs file fix

vc4:
- error checking fix

nouveau:
- support GA106
- fix a few error checks

i915:
- fix wakeref handling around PXP suspend
The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-26

for you to fetch changes up to fc026c8b926835b46509a2757732bfa38a2162f1:

  Merge tag 'drm-intel-fixes-2021-11-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-11-26
10:36:33 +1000)

----------------------------------------------------------------
drm fixes for 5.16-rc3

amdgpu:
- SRIOV fixes
- dma-buf double free fix
- Display fixes for GPU resets
- Fix DSC powergating regression
- GPU TSC fixes
- Interrupt handler overflow fixes
- Endian fix in IP discovery table handling
- Aldebaran ASPM fix
- Fix overclocking regression on older asics
- Backlight/ACPI fix

amdkfd:
- SVM fixes
- VMA removal race fix

hyperv:
- removal fix

aspeed:
- vga_pw sysfs file fix

vc4:
- error checking fix

nouveau:
- support GA106
- fix a few error checks

i915:
- fix wakeref handling around PXP suspend

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu/gfx10: add wraparound gpu counter check for APUs as well
      drm/amdgpu/gfx9: switch to golden tsc registers for renoir+
      drm/amdgpu/pm: fix powerplay OD interface
      drm/amd/display: update bios scratch when setting backlight

Ben Skeggs (1):
      drm/nouveau: recognise GA106

Dan Carpenter (2):
      drm/nouveau/acr: fix a couple NULL vs IS_ERR() checks
      drm/vc4: fix error code in vc4_create_object()

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.16-2021-11-24' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2021-11-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-11-24' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Felix Kuehling (1):
      drm/amdgpu: Fix MMIO HDP flush on SRIOV

Joel Stanley (1):
      drm/aspeed: Fix vga_pw sysfs output

Lijo Lazar (1):
      drm/amdgpu: Skip ASPM programming on aldebaran

Mohammed Gamal (1):
      drm/hyperv: Fix device removal on Gen1 VMs

Nicholas Kazlauskas (3):
      drm/amd/display: Fix DPIA outbox timeout after GPU reset
      drm/amd/display: Set plane update flags for all planes in reset
      drm/amd/display: Reset link encoder assignments for GPU reset

Philip Yang (6):
      drm/amdgpu: IH process reset count when restart
      drm/amdkfd: process exit and retry fault race
      drm/amdkfd: handle VMA remove race
      drm/amdkfd: simplify drain retry fault
      drm/amdgpu: enable Navi 48-bit IH timestamp counter
      drm/amdgpu: enable Navi retry fault wptr overflow

Tejas Upadhyay (1):
      drm/i915/gt: Hold RPM wakelock during PXP suspend

Yang Wang (1):
      drm/amdgpu: fix byteorder error in amdgpu discovery

Yi-Ling Chen (1):
      drm/amd/display: Fixed DSC would not PG after removing DSC stream

shaoyunl (1):
      drm/amdgpu: move kfd post_reset out of reset_sriov function

xinhui pan (1):
      drm/amdgpu: Fix double free of dmabuf

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   6 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |  12 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      |  12 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  15 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  46 +++++++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |  34 +++----
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c             |   4 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |   7 +-
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   8 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               | 111 +++++++++++++--------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  24 ++++-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c |   2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |  20 ++--
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  24 ++---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |   6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |  28 +++---
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |  10 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |  58 ++++++-----
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |   2 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |  19 +++-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |   7 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_pm.c            |  37 +++++--
 drivers/gpu/drm/i915/pxp/intel_pxp_pm.h            |  19 +++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  22 ++++
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c    |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c    |   6 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |   2 +-
 37 files changed, 375 insertions(+), 210 deletions(-)
