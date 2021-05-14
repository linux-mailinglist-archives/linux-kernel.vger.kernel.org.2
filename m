Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A90F381284
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhENVGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 17:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhENVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 17:06:05 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07AC061760
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:02:56 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f1so73127edt.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ProY55k5ekiZ8lOnAY4fJDoMbyGsmSug4xwolpHstgY=;
        b=RIjK/rkqtB7BQ4HcjQDYq/sHK0SVPr8GXSNY1nXO4C0hDtZ4lnwAOsOc2PaVwJKuRA
         nS7L7KXf1lygsL/PDuaeGzhN4FPFU539jnps2JiQpZzz08A1RiUwea4fnXNToMipzULl
         wzwmuKR8/kZQ4dEWKYSHPBIc19j9v2iUUy8e+sa6Fg1gXZf8n/RhXDdHbtc/auELaAZ8
         vklGuRMZYlfHkhAyeFt3YqL6hGKzcELYq4PF65+fDVtf7BvW5BYvkpnRgNrT0aWgmhn+
         wjEvipPB9Mkp4771cy7uHspENGmSnO9jCMcBeou2PBhSGTVF2MhTbghNcWtz88q3jdZw
         l4xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ProY55k5ekiZ8lOnAY4fJDoMbyGsmSug4xwolpHstgY=;
        b=NyHuTFO2QgmPCZfkZzSCmKhjBnB0PPLqvgTb5fGjkDFBzMGa4wWoNS+dSMqq/LtATH
         gfnzf3UNMwVvbqfH3UBFIMmc0cRC0hWB/HJdK0h868t09EG92BBspIq/Rg6ogytzpxbR
         5Aok+zh0CgDcMv90Twuk6x4iaka/FLIefhQO5xh9iCgPA8GKm8Sc4ZPzmhN85O+vHhK7
         7aKpyXsFjBS6B7PK1t9Fpm7xX2wPQ+MRSgTyQ+F7CbJZopAJPTvqC8PjCc+t4sji0Hfa
         KKD6GIBrRvidWg6Yvns4I4pbR6oHO7yuWJmJD7Y1vPePq1Mlbym9BuAseJQU6gI6weGy
         VDJg==
X-Gm-Message-State: AOAM531F8HVggVR6oV3GhmRGPYvDtmIofhPR8c3CUPj5Mo7XlI6misOY
        zeX9EhK9mYk6JRN5Fm5DkhenfdzBBXTbJDLLtrI=
X-Google-Smtp-Source: ABdhPJwkjffJer2TwFDBA4jdDZ2QpUBoL1vVxFiJIQNI52ubpGqhn/brKjvnj4e4NwrB9PQo2kHTxICndbzHh3C4vVY=
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr58502908edw.298.1621026175577;
 Fri, 14 May 2021 14:02:55 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 15 May 2021 07:02:44 +1000
Message-ID: <CAPM=9tyEzE01K43mAfz3Wv+M0Q7n+3rHriNboSWcjEERy1Hxig@mail.gmail.com>
Subject: [git pull] drm fixes for 5.13-rc2 (part two)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Looks like I wasn't the only one not fully switched on this week, the
msm pull has a missing tag so I missed it, and i915 team were a bit
late. In my defence I did have a day with the roof of my home office
removed, so was sitting at my kids desk.

Dave.

drm-fixes-2021-05-15:
drm fixes for 5.13-rc2 (part two)

msm:
- dsi regression fix
- dma-buf pinning fix
- displayport fixes
- llc fix

i915:
- Fix active callback alignment annotations and subsequent crashes
- Retract link training strategy to slow and wide, again
- Avoid division by zero on gen2
- Use correct width reads for C0DRB3/C1DRB3 registers
- Fix double free in pdp allocation failure path
- Fix HDMI 2.1 PCON downstream caps check
The following changes since commit 08f0cfbf739a5086995f0779bbcb607163128a9a=
:

  Merge tag 'amd-drm-fixes-5.13-2021-05-13' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-05-14
09:20:04 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-05-15

for you to fetch changes up to 5dce58de4be8a4c9f2af3beed3ee9813933a0583:

  Merge tag 'drm-msm-fixes-2021-05-09' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes (2021-05-15
06:52:15 +1000)

----------------------------------------------------------------
drm fixes for 5.13-rc2 (part two)

msm:
- dsi regression fix
- dma-buf pinning fix
- displayport fixes
- llc fix

i915:
- Fix active callback alignment annotations and subsequent crashes
- Retract link training strategy to slow and wide, again
- Avoid division by zero on gen2
- Use correct width reads for C0DRB3/C1DRB3 registers
- Fix double free in pdp allocation failure path
- Fix HDMI 2.1 PCON downstream caps check

----------------------------------------------------------------
Ankit Nautiyal (1):
      drm/i915: Use correct downstream caps for check Src-Ctl mode for PCON

Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2021-05-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-msm-fixes-2021-05-09' of
https://gitlab.freedesktop.org/drm/msm into drm-fixes

Dmitry Baryshkov (2):
      drm/msm/dsi: dsi_phy_28nm_8960: fix uninitialized variable access
      drm/msm/dsi: fix msm_dsi_phy_get_clk_provider return code

Jonathan Marek (2):
      drm/msm: fix LLC not being enabled for mmu500 targets
      drm/msm: fix minor version to indicate MSM_PARAM_SUSPENDS support

Kai-Heng Feng (1):
      drm/i915/dp: Use slow and wide link training for everything

Kuogee Hsieh (2):
      drm/msm/dp: check sink_count before update is_connected status
      drm/msm/dp: initialize audio_comp when audio starts

Lv Yunlong (1):
      drm/i915/gt: Fix a double free in gen8_preallocate_top_level_pdp

Rob Clark (1):
      drm/msm: Do not unpin/evict exported dma-buf's

St=C3=A9phane Marchesin (1):
      drm/i915: Fix crash in auto_retire

Tvrtko Ursulin (1):
      drm/i915/overlay: Fix active retire callback alignment

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Avoid div-by-zero on gen2
      drm/i915: Read C0DRB3/C1DRB3 as 16 bits again

 drivers/gpu/drm/i915/display/intel_dp.c         | 61 +++------------------=
----
 drivers/gpu/drm/i915/display/intel_overlay.c    |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c        |  2 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c            |  1 -
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c    |  4 +-
 drivers/gpu/drm/i915/i915_active.c              |  3 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c           |  9 ++--
 drivers/gpu/drm/msm/dp/dp_audio.c               |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c             | 26 +++++++----
 drivers/gpu/drm/msm/dp/dp_display.h             |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c           |  2 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c |  4 ++
 drivers/gpu/drm/msm/msm_drv.c                   |  2 +-
 drivers/gpu/drm/msm/msm_gem.c                   | 16 ++++++-
 drivers/gpu/drm/msm/msm_gem.h                   |  4 +-
 15 files changed, 59 insertions(+), 79 deletions(-)
