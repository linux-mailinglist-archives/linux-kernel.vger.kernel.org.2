Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8111841F28F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355160AbhJAQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJAQ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:59:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AD1C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:57:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso7213963wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 09:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=4x7EKxvorCT1RCVWUarLNZQ1CgJpkUEGTDbAAfD+Md4=;
        b=aTFzNFFIoH2mE9ZYNfLVdmdXh154/LLuGzr9Vvsx6ojp2cBzQNH5F0l1iWoVe2VytW
         JDf/4rsFonE5kFxf7tw2S/I3v96XU9BhZILHrCGcOZcBi4LAf6JucaHLSn+sSnjwww5U
         taNEo2LO6k+26qVpLCrImXoFxKrLdNwHthrBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=4x7EKxvorCT1RCVWUarLNZQ1CgJpkUEGTDbAAfD+Md4=;
        b=yXJHomi4IORI9pC11jIBBTrYFvWouLldhVuxl/HNYBOQQsfa5CdEwFFGzleSKdN53N
         GDgDrhFYOPiDlzY+RWLa3OhxkT9X1w9Lmft9tkQ7z1W6aZq+Uru4ngv2ZTrdS8eND3an
         m8cqrqMDdmXVYER3eV1mWMfRYbvFFg9MumtI5Vn3m0Z3Hd8NUj7v4FO8r/Ve3QahP3ty
         qvFwJup9WgX6t+yaW2qdZVX5waG4Wchox72jqbnPld0G+/dfo8z9gXl8h9EzkfQfTJVg
         1gQ01UCi2iJilEK7ism3umSm2TC1fA0liEJ9Supjdp3gofUmSGdIPSidgIyU6IbaNsF4
         /e3g==
X-Gm-Message-State: AOAM531ueIJ9864D7ZGoq1m5ymBGoyZSN6KYVkRI9vcJ2aQDak5qfzuM
        qAUpmavFqSE2laZnoBcYyan2vw==
X-Google-Smtp-Source: ABdhPJzHGF3V96wlr11Apd+ycgHlcyFMWaSZxKmiqqFdKbcHdbtqHkunM6oQIuyRwzza+SqLDWy+YA==
X-Received: by 2002:a05:600c:5103:: with SMTP id o3mr5726874wms.12.1633107434321;
        Fri, 01 Oct 2021 09:57:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c9sm8605752wmb.41.2021.10.01.09.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 09:57:13 -0700 (PDT)
Date:   Fri, 1 Oct 2021 18:57:06 +0200
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PULL] drm-fixes
Message-ID: <YVc94kx7GVHwt+uc@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Dave is out on a long w/e, should be back next week. Nothing nefarious,
just a bunch of driver fixes.

Cheers, Daniel

drm-fixes-2021-10-01:
drm fixes for -rc4:

amdgpu, i915, tegra, and one exynos driver fix

Cheers, Daniel

The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:

  Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-01

for you to fetch changes up to 78ea81417944fe03f48648eddeb8e8a8e513c4ad:

  Merge tag 'exynos-drm-fixes-for-v5.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-fixes (2021-10-01 18:14:39 +0200)

----------------------------------------------------------------
drm fixes for -rc4:

amdgpu, i915, tegra, and one exynos driver fix

----------------------------------------------------------------
Akira Yokosawa (1):
      drm/i915/guc, docs: Fix pdfdocs build error by removing nested grid

Cai Huoqing (1):
      drm/exynos: Make use of the helper function devm_platform_ioremap_resource()

Charlene Liu (1):
      drm/amd/display: Pass PCI deviceid into DC

Daniel Vetter (3):
      Merge tag 'drm-intel-fixes-2021-09-30' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.15-2021-09-29' of https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v5.15-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into drm-fixes

Dave Airlie (1):
      Merge tag 'drm/tegra/for-5.15-rc3' of ssh://git.freedesktop.org/git/tegra/linux into drm-fixes

Dmitry Osipenko (3):
      drm/tegra: dc: Remove unused variables
      drm/tegra: uapi: Fix wrong mapping end address in case of disabled IOMMU
      gpu/host1x: fence: Make spinlock static

Hawking Zhang (1):
      drm/amdgpu: correct initial cp_hqd_quantum for gfx9

Jani Nikula (1):
      Merge tag 'gvt-fixes-2021-09-18' of https://github.com/intel/gvt-linux into drm-intel-fixes

Josip Pavic (1):
      drm/amd/display: initialize backlight_ramping_override to false

Leslie Shi (1):
      drm/amdgpu: fix gart.bo pin_count leak

Matthew Auld (1):
      drm/i915/request: fix early tracepoints

Praful Swarnakar (1):
      drm/amd/display: Fix Display Flicker on embedded panels

Prike Liang (1):
      drm/amdgpu: force exit gfxoff on sdma resume for rmb s0ix

Simon Ser (1):
      drm/amdgpu: check tiling flags when creating FB on GFX8-

Tejas Upadhyay (1):
      drm/i915: Remove warning from the rps worker

Thierry Reding (1):
      gpu: host1x: Plug potential memory leak

Zhi A Wang (1):
      drm/i915/gvt: fix the usage of ww lock in gvt scheduler.

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        | 31 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  8 ++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 15 +++++------
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_fimc.c           |  5 +---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |  5 +---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |  6 +----
 drivers/gpu/drm/exynos/exynos_drm_rotator.c        |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_scaler.c         |  4 +--
 drivers/gpu/drm/exynos/exynos_hdmi.c               |  4 +--
 drivers/gpu/drm/i915/gt/intel_rps.c                |  2 --
 .../drm/i915/gt/uc/abi/guc_communication_ctb_abi.h | 10 +++----
 .../i915/gt/uc/abi/guc_communication_mmio_abi.h    | 10 +++----
 drivers/gpu/drm/i915/gvt/scheduler.c               |  4 +--
 drivers/gpu/drm/i915/i915_request.c                | 11 ++------
 drivers/gpu/drm/tegra/dc.c                         |  3 ---
 drivers/gpu/drm/tegra/dc.h                         |  6 -----
 drivers/gpu/drm/tegra/uapi.c                       |  2 +-
 drivers/gpu/host1x/fence.c                         |  6 +++--
 25 files changed, 81 insertions(+), 77 deletions(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
