Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6259A3E2325
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 08:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbhHFGDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 02:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhHFGD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 02:03:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1872BC061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 23:03:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b128so4835244wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 23:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6H+0hcm8l7aLIS2xe0QY8OrUwt8WXy+M0IZiWZTDT/4=;
        b=ijo0XQNguBvEBbqPFuapHSzDKkdhBjs4bMQanuaouAtLj2nd/+YcxB6WjU+Bn82y4/
         vf7kk4i3Sgjrb7u22jcQBE2wbsAvOjajQabWl7h2nHynd++3ZfL+XRHD6Odj1HOpMQxf
         IGXJTXMHgDFPJGNSLjtbWJ4CwMv96GJZMaVKGc0SnY0Hu+qjQnepTByrWBxr5rJvLEfA
         jJyRf3+vwDC1D7icTLOaGxU2Yotmgyg7FmOsWeI+B+ykp2kwPOSx3ytXCVSvK+yc8Lmd
         9wq1n4UNG1K5kCIxVc0qqRlwOjCvf0aBR3AfaJ1coZs5ycHyZBuMj2uurpW1qvzjhO1f
         +j6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6H+0hcm8l7aLIS2xe0QY8OrUwt8WXy+M0IZiWZTDT/4=;
        b=VyEl9MUdA+h9Wa8lvz4KpIe9ZmsjlZInKB/uz3VvPrRVGJMtQ1TND9vXCovtDwbTC2
         X1EvLhg0fzUWRO6PDH2sRuneaQZGa7/bqULODye7WKAwKcNXpCV5zQ8ZCMM7WUSTZja9
         g/Ew9NlSBSvoSYO+kA+Z8ZHorT5ku4Z691KF+nod1E6Bi8bLQZe1CT0hOclB+SIhBtpx
         iMNEBUd2NcEq+FI4mCaeEO4wQspKh9PgVddcI4cBf84Jy1Im4lEsSrn9MHEDBLE8mFwl
         HP5/ExfAmwSFx27CI7n9FCuLYqnT+laEFTupdZbkesle1ej3NcCoDpihJ3e0jafgFST7
         M+Yw==
X-Gm-Message-State: AOAM532mcgF7FqPZMx+cIEmrO1sZplqDMKsZx6cE/EhIhOlG2lBWqZTj
        SUck6BAkYjxPROR3Q7hN6AjMEsj0d7CTYQpP0alo6dW9O7zA7Q==
X-Google-Smtp-Source: ABdhPJype5gSl8B6cXIO8ZkqsC+9SfaYUqWVDfxpeoT5UvlPOUQsZIqgz5McybWazUHKmZTP0YNXosncKH5oDz/tGhg=
X-Received: by 2002:a1c:a709:: with SMTP id q9mr18222417wme.23.1628229791651;
 Thu, 05 Aug 2021 23:03:11 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 6 Aug 2021 16:03:00 +1000
Message-ID: <CAPM=9txE4jnHDV9B2PWfieMJjdFv0C7=Zc=MovOtJ6sKN2AuYg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.14-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Regular weekly fixes pull, live from a Brisbane lockdown with kids at home.

A big bunch of scattered amdgpu fixes, but they are all pretty small,
minor i915 fixes, kmb, and one vmwgfx regression fixes, all pretty
quiet for this time.

Dave.

drm-fixes-2021-08-06:
drm fixes for 5.14-rc5

amdgpu:
- Fix potential out-of-bounds read when updating GPUVM mapping
- Renoir powergating fix
- Yellow Carp updates
- 8K fix for navi1x
- Beige Goby updates and new DIDs
- Fix DMUB firmware version output
- EDP fix
- pmops config fix

i915:
- Call i915_globals_exit if pci_register_device fails
- (follow on fix for section mismatch)
- Correct SFC_DONE register offset

kmb:
- DMA fix
- driver date/version macros

vmwgfx:
- Fix I/O memory access on 64-bit systems
The following changes since commit c500bee1c5b2f1d59b1081ac879d73268ab0ff17:

  Linux 5.14-rc4 (2021-08-01 17:04:17 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-08-06

for you to fetch changes up to d186f9c28008810d8f984d6bdd1c07757048ed63:

  Merge tag 'amd-drm-fixes-5.14-2021-08-05' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-08-06
11:22:09 +1000)

----------------------------------------------------------------
drm fixes for 5.14-rc5

amdgpu:
- Fix potential out-of-bounds read when updating GPUVM mapping
- Renoir powergating fix
- Yellow Carp updates
- 8K fix for navi1x
- Beige Goby updates and new DIDs
- Fix DMUB firmware version output
- EDP fix
- pmops config fix

i915:
- Call i915_globals_exit if pci_register_device fails
- (follow on fix for section mismatch)
- Correct SFC_DONE register offset

kmb:
- DMA fix
- driver date/version macros

vmwgfx:
- Fix I/O memory access on 64-bit systems

----------------------------------------------------------------
Bing Guo (2):
      drm/amd/display: Fix Dynamic bpp issue with 8K30 with Navi 1X
      drm/amd/display: Increase stutter watermark for dcn303

Chengming Gui (1):
      drm/amdgpu: add DID for beige goby

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2021-08-04' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-08-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.14-2021-08-05' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Edmund Dea (2):
      drm/kmb: Enable LCD DMA for low TVDDCV
      drm/kmb: Define driver date and major/minor version

Jason Ekstrand (1):
      drm/i915: Call i915_globals_exit() if pci_register_device() fails

Jude Shih (1):
      drm/amd/display: Fix resetting DCN3.1 HW when resuming from S4

Matt Roper (1):
      drm/i915: Correct SFC_DONE register offset

Qingqing Zhuo (1):
      drm/amd/display: workaround for hard hang on HPD on native DP

Randy Dunlap (2):
      drm/i915: fix i915_globals_exit() section mismatch error
      drm/amdgpu: fix checking pmops when PM_SLEEP is not enabled

Shirish S (1):
      drm/amdgpu/display: fix DMUB firmware version info

Wesley Chalmers (1):
      drm/amd/display: Assume LTTPR interop for DCN31+

Xiaomeng Hou (1):
      drm/amd/pm: update yellow carp pmfw interface version

Yifan Zhang (1):
      drm/amdgpu: fix the doorbell missing when in CGPG issue for renoir.

Zack Rusin (1):
      drm/vmwgfx: Fix a 64bit regression on svga3

xinhui pan (1):
      drm/amdgpu: Fix out-of-bounds read when update mapping

 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h     |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 21 ++++++++++++++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   | 21 ++-------------------
 drivers/gpu/drm/amd/display/dc/dc.h                |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  | 20 ++++++++++++++++++++
 .../drm/amd/display/dc/dcn303/dcn303_resource.c    |  4 ++--
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  | 16 ++++++++++++++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c  |  8 +++++---
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             |  2 +-
 drivers/gpu/drm/i915/i915_globals.c                |  4 ++--
 drivers/gpu/drm/i915/i915_pci.c                    |  1 +
 drivers/gpu/drm/i915/i915_reg.h                    |  2 +-
 drivers/gpu/drm/kmb/kmb_drv.c                      | 22 ++++++++++++++++++----
 drivers/gpu/drm/kmb/kmb_drv.h                      |  5 +++++
 drivers/gpu/drm/kmb/kmb_plane.c                    | 15 +++++++++++++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |  2 +-
 21 files changed, 124 insertions(+), 41 deletions(-)
