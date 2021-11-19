Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2B74569C0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 06:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhKSFfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 00:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhKSFfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 00:35:52 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE9BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 21:32:51 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so37697266edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 21:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FV7+rMAoyljvYMTPHC7pNClfY1H+TXN5fmbjkfoYhr8=;
        b=C4hROw/gfKCEP4BGVXOlNBcY3Nj2tGQm1gALbKevPo2qjWKnkl+1QN4ScQXamOtewN
         8cxqv2wCmR1FhDLUGsKXkqoMTo4bW12UQLdXhTd3mSDM3AGeSBsFXUD+vNT78BI5L8om
         TqQZ8Xy9j1FWSuLaGJp9Cm7JtTyCiO7qBPBKhTQIgU65J1jncX4gTnYDr1CIF/HtYl6I
         s5m5z50ZNgQXoH5Q/Zco2Hatd8PehpmmlhuwsvEgbSKrsqr73rNBNJERlFXmzBDSJSMJ
         wgmsiVPUVaSdJN9rV1wCwgI4lQJtOR8oGva/J16wkCjceKHRcoSsQInwTfLEr0IxDnm0
         1juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FV7+rMAoyljvYMTPHC7pNClfY1H+TXN5fmbjkfoYhr8=;
        b=Jd9qKbSNGnW34YjYJ0TseNM9XyTi32PqE0M8gSklJ5IXYdH6Oafu3HHyfFAB1TFvIK
         eQo5ZM75dWU66sviR2UOM0NrY3K1PmrTMQTgMprluYrCPD2rcIFYs4SNt9lLAG+1hoTC
         vnxEdz26ktRvNx+e3cB38KTC1PpURKM4M4QHO1Y8ljOjEg3dNt5Ax0k9+vYDyB0soggP
         f4WVm0jAlJNAswRjmgZ6gaXlFrVICxi4EYkbewvSDu0rTwQKXIm2QhsUFvXBQPsSwKy3
         If+JodKqy0+n7alx255qF/kuCWgGhHDLG6BcO7ivLePLVgSyDtVUZYYTeLoiI12gHhzV
         K2Vw==
X-Gm-Message-State: AOAM530NO5y6oxQ+zwToY5XnCaiCb4xUeis37llc10C54ToUsc5mWFSr
        bOplO70/21+9AWBAZrVlybTFzAaLaB7MGnvELUxjD5B/gfk=
X-Google-Smtp-Source: ABdhPJxIZEQlWoCFMBLGzHJYPINtNPB0RFZsIKcTaYQwodmmrI8sMifvo1fJ+af0qsXljf+C1BxWcq40T7MM3Ng1zJU=
X-Received: by 2002:a05:6402:50cf:: with SMTP id h15mr19968102edb.90.1637299969651;
 Thu, 18 Nov 2021 21:32:49 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Nov 2021 15:32:38 +1000
Message-ID: <CAPM=9twL3jV37TWqwTUDfCdqMEeQDO6Zrgx+rkWNir8Q8eOqWw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.16-rc2
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

This week's fixes, pretty quiet, about right for rc2. amdgpu is the
bulk of them but the scheduler ones have been reported in a few places
I think.

Otherwise just some minor i915 fixes and a few other scattered around.

Dave.

drm-fixes-2021-11-19:
drm fixes for 5.16-rc2

scheduler:
- two refcounting fixes

cma-helper:
- use correct free path for noncoherent

efifb:
- probing fix

amdgpu:
- Better debugging info for SMU msgs
- Better error reporting when adding IP blocks
- Fix UVD powergating regression on CZ
- Clock reporting fix for navi1x
- OLED panel backlight fix
- Fix scaling on VGA/DVI for non-DC display code
- Fix GLFCLK handling for RGP on some APUs
- fix potential memory leak

amdkfd:
- GPU reset fix

i915:
- return error handling fix
- ADL-P display fix
- TGL DSI display clocks fix

nouveau:
- infoframe corruption fix

sun4i:
- Kconfig fix
The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf=
:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-11-19

for you to fetch changes up to 7d51040a695b53d4060349c7a895ef4a763887ef:

  Merge tag 'amd-drm-fixes-5.16-2021-11-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-11-19
14:23:14 +1000)

----------------------------------------------------------------
drm fixes for 5.16-rc2

scheduler:
- two refcounting fixes

cma-helper:
- use correct free path for noncoherent

efifb:
- probing fix

amdgpu:
- Better debugging info for SMU msgs
- Better error reporting when adding IP blocks
- Fix UVD powergating regression on CZ
- Clock reporting fix for navi1x
- OLED panel backlight fix
- Fix scaling on VGA/DVI for non-DC display code
- Fix GLFCLK handling for RGP on some APUs
- fix potential memory leak

amdkfd:
- GPU reset fix

i915:
- return error handling fix
- ADL-P display fix
- TGL DSI display clocks fix

nouveau:
- infoframe corruption fix

sun4i:
- Kconfig fix

----------------------------------------------------------------
Bernard Zhao (1):
      drm/amd/amdgpu: fix potential memleak

Christian K=C3=B6nig (1):
      drm/scheduler: fix drm_sched_job_add_implicit_dependencies

Dan Carpenter (1):
      drm/i915/guc: fix NULL vs IS_ERR() checking

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2021-11-18' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-11-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.16-2021-11-17' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Evan Quan (1):
      drm/amd/pm: avoid duplicate powergate/ungate setting

Guchun Chen (1):
      drm/amdgpu: add error print when failing to add IP block(v2)

Hans Verkuil (1):
      drm/nouveau: hdmigv100.c: fix corrupted HDMI Vendor InfoFrame

Javier Martinez Canillas (1):
      fbdev: Prevent probing generic drivers if a FB is already registered

Julian Braha (1):
      drm/sun4i: fix unmet dependency on RESET_CONTROLLER for
PHY_SUN6I_MIPI_DPHY

Lijo Lazar (1):
      drm/amd/pm: Remove artificial freq level on Navi1x

Luben Tuikov (1):
      drm/amd/pm: Enhanced reporting also for a stuck command

Maxime Ripard (1):
      Merge drm/drm-fixes into drm-misc-fixes

Perry Yuan (1):
      drm/amd/pm: add GFXCLK/SCLK clocks level print support for APUs

Rob Clark (1):
      drm/scheduler: fix drm_sched_job_add_implicit_dependencies harder

Roman Li (1):
      drm/amd/display: Fix OLED brightness control on eDP

Thomas Zimmermann (1):
      drm/cma-helper: Release non-coherent memory with dma_free_noncoherent=
()

Vandita Kulkarni (2):
      Revert "drm/i915/tgl/dsi: Gate the ddi clocks after pll mapping"
      drm/i915/dsi/xelpd: Fix the bit mask for wakeup GB

hongao (1):
      drm/amdgpu: fix set scaling mode Full/Full aspect/Center not
works on vga and dvi connectors

shaoyunl (1):
      drm/amd/amdkfd: Fix kernel panic when reset failed and been
triggered again

 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c      | 36 ++++++++++++++++++=
++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |  1 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  5 +++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 +-
 drivers/gpu/drm/amd/include/amd_shared.h           |  3 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                | 10 ++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h            |  8 +++++
 .../drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c    | 22 +++++++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    | 13 +++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   | 26 ++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c   | 27 ++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.h   |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |  8 +++--
 drivers/gpu/drm/drm_gem_cma_helper.c               |  9 ++++--
 drivers/gpu/drm/i915/display/icl_dsi.c             | 13 +++-----
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |  4 +--
 drivers/gpu/drm/i915/i915_reg.h                    |  4 ++-
 .../gpu/drm/nouveau/nvkm/engine/disp/hdmigv100.c   |  1 -
 drivers/gpu/drm/scheduler/sched_main.c             |  6 +++-
 drivers/gpu/drm/sun4i/Kconfig                      |  1 +
 drivers/video/fbdev/efifb.c                        | 11 +++++++
 drivers/video/fbdev/simplefb.c                     | 11 +++++++
 24 files changed, 200 insertions(+), 27 deletions(-)
