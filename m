Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE1310255
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 02:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhBEBoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 20:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbhBEBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 20:44:43 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65163C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 17:44:02 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s11so6845064edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 17:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=WEHMSZIy6ul6MahYj9RsQ6f+Nc3iqCoCYk4MH9tcDmM=;
        b=Hk21NzawTxmPOOtq0p+YazWOIH9M5/gRHEoUxVRhtzL5lySHTPhyjagrugC2QOpg0X
         wEGyLmEyW0/v3m3uY/VjIl8AgDafnL2im93QXJBDWSJ7Pl2TxtNEEW0Rx5QqSrCnXfZ3
         5UMGZ3kCjqZ7cduEsETruyQOcQnQaJEuTeNVSyzfgUedv89M8pM05MWVPOah99qDtXzd
         PqKEsMp1tKWoBoVE8IsH1KJV/jrhUav5MJvGNzwaatSNO80fRueir/f0O3Vimdrnmgqz
         M1eAPFADIqO6gM4Z4L2EN+ey+y2hdxiqVUhJWi5auxkYmV4tDFqo7oGvek2c4eF1rUyS
         p2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=WEHMSZIy6ul6MahYj9RsQ6f+Nc3iqCoCYk4MH9tcDmM=;
        b=kGXF3YCUnU44017SEMqw09iXtTrWRG/iA7Kt0zb4xup9j9maJcZKr4Q7GnW/4TLMVC
         xHMEX6NAOF41mblFd7kVRl/AHgADTOW6+v9A3ckl+G155F0D5l74MLbg9yAyfr7iCdKf
         jXwwAKU9pkRouFFwjQllswRY0hNj0ivjTUbu3G1aD0VNaJesBmDfwbDSb/K6/NXkVXjq
         XxV+uFX8SX8VwxFkenq/tjsauVc3RvJPhDJpQH57d+1a2lp2TCqMolQLUkkFcQFrOaj6
         7F80Ok6cksJjFgeQejpsE31nY0L9JXSNJEXKhgPi9cQLI73HVpJUesNauSPm7lArCH8q
         U7+A==
X-Gm-Message-State: AOAM533R/DmnPsuhhuLteD9DYbQmBpzZxQLozxSwTann/11y0HxMnNMB
        4mxVssOCu0kDw6sss9eu5Scq1v1aQ/9prXIxrxk=
X-Google-Smtp-Source: ABdhPJz07QIrg7CdCVAiaFplMVdOuWYkaaYNMzbANPgteyWe03ORNcU1ESe67H537FgIOLra29N7Px1bu9YmL3y3Wng=
X-Received: by 2002:aa7:ce93:: with SMTP id y19mr1282161edv.119.1612489441020;
 Thu, 04 Feb 2021 17:44:01 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 5 Feb 2021 11:43:49 +1000
Message-ID: <CAPM=9twvv9LRSTW4t_Q=OLfei1DsXn-fsjO8ad3cSsZ3KeDNhQ@mail.gmail.com>
Subject: [git pull] drm fixes for 5.11-rc7
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

Fixes for rc7, bit bigger than I'd like at this stage, but most of the
i915 stuff and some amdgpu is destined for staging and I'd rather not
hold it up, the i915 changes also pulled in a few precusor code
movement patches to make things cleaner, but nothing seems that
horrible, and I've checked over all of it.

Otherwise there is a nouveau dma-api warning regression, and a ttm
page allocation warning fix,
and some fixes for a bridge chip,

Dave.

drm-fixes-2021-02-05-1:
drm fixes for 5.11-rc7

ttm:
- fix huge page warning regression

i915:
- Skip vswing programming for TBT
- Power up combo PHY lanes for HDMI
- Fix double YUV range correction on HDR planes
- Fix the MST PBN divider calculation
- Fix LTTPR vswing/pre-emp setting in non-transparent mode
- Move the breadcrumb to the signaler if completed upon cancel
- Close race between enable_breadcrumbs and cancel_breadcrumbs
- Drop lru bumping on display unpinning

amdgpu:
- Fix retry in gem create
- Vangogh fixes
- Fix for display from shared buffers
- Various display fixes

amdkfd:
- Fix regression in buffer free

nouveau:
- fix DMA API warning regression

drm/bridge/lontium-lt9611uxc:
- EDID fixes
- Don't handle hotplug events in IRQ handler
The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac=
:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-02-05-1

for you to fetch changes up to 59854811c08cfbdf52d79231666e7c07c46ff338:

  Merge tag 'drm-intel-fixes-2021-02-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2021-02-05
11:03:28 +1000)

----------------------------------------------------------------
drm fixes for 5.11-rc7

ttm:
- fix huge page warning regression

i915:
- Skip vswing programming for TBT
- Power up combo PHY lanes for HDMI
- Fix double YUV range correction on HDR planes
- Fix the MST PBN divider calculation
- Fix LTTPR vswing/pre-emp setting in non-transparent mode
- Move the breadcrumb to the signaler if completed upon cancel
- Close race between enable_breadcrumbs and cancel_breadcrumbs
- Drop lru bumping on display unpinning

amdgpu:
- Fix retry in gem create
- Vangogh fixes
- Fix for display from shared buffers
- Various display fixes

amdkfd:
- Fix regression in buffer free

nouveau:
- fix DMA API warning regression

drm/bridge/lontium-lt9611uxc:
- EDID fixes
- Don't handle hotplug events in IRQ handler

----------------------------------------------------------------
Andres Calderon Jaramillo (1):
      drm/i915/display: Prevent double YUV range correction on HDR planes

Bhawanpreet Lakha (1):
      drm/amd/display: reuse current context instead of recreating one

Chris Wilson (3):
      drm/i915/gt: Move the breadcrumb to the signaler if completed upon ca=
ncel
      drm/i915/gt: Close race between enable_breadcrumbs and cancel_breadcr=
umbs
      drm/i915/gem: Drop lru bumping on display unpinning

Christian K=C3=B6nig (1):
      drm/amdgpu: enable freesync for A+A configs

Dave Airlie (4):
      drm/nouveau: fix dma syncing warning with debugging on.
      Merge tag 'drm-misc-fixes-2021-02-02' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.11-2021-02-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2021-02-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Dmitry Baryshkov (3):
      drm/bridge/lontium-lt9611uxc: fix waiting for EDID to become availabl=
e
      drm/bridge/lontium-lt9611uxc: fix get_edid return code
      drm/bridge/lontium-lt9611uxc: move HPD notification out of IRQ handle=
r

George Shen (1):
      drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Huang Rui (2):
      drm/amdgpu: fix the issue that retry constantly once the buffer
is oversize
      drm/amdkfd: fix null pointer panic while free buffer in kfd

Imre Deak (4):
      drm/dp/mst: Export drm_dp_get_vc_payload_bw()
      drm/i915: Fix the MST PBN divider calculation
      drm/i915/dp: Move intel_dp_set_signal_levels() to intel_dp_link_train=
ing.c
      drm/i915/dp: Fix LTTPR vswing/pre-emp setting in non-transparent mode

Michel D=C3=A4nzer (1):
      drm/ttm: Use __GFP_NOWARN for huge pages in ttm_pool_alloc_page

Mikita Lipski (1):
      drm/amd/display: Release DSC before acquiring

Stylon Wang (1):
      drm/amd/display: Revert "Fix EDID parsing after resume from suspend"

Sung Lee (1):
      drm/amd/display: Add more Clock Sources to DCN2.1

Victor Lu (3):
      drm/amd/display: Fix dc_sink kref count in emulated_link_detect
      drm/amd/display: Free atomic state after drm_atomic_commit
      drm/amd/display: Decrement refcount of dc_sink before reassignment

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Skip vswing programming for TBT
      drm/i915: Extract intel_ddi_power_up_lanes()
      drm/i915: Power up combo PHY lanes for for HDMI as well

Xiaojian Du (1):
      drm/amd/pm: fill in the data member of v2 gpu metrics table for vango=
gh

chen gong (1):
      drm/amdgpu/gfx10: update CGTS_TCC_DISABLE and
CGTS_USER_TCC_DISABLE register offsets for VGH

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   | 16 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             | 18 +++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 47 +++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 27 ++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  6 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |  3 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  | 10 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  3 +
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         | 57 +++++++++++++++---=
-
 drivers/gpu/drm/drm_dp_mst_topology.c              | 24 ++++++--
 drivers/gpu/drm/i915/display/intel_ddi.c           | 43 ++++++++------
 drivers/gpu/drm/i915/display/intel_display.c       |  9 ++-
 drivers/gpu/drm/i915/display/intel_dp.c            | 20 +------
 drivers/gpu/drm/i915/display/intel_dp.h            |  3 -
 .../gpu/drm/i915/display/intel_dp_link_training.c  | 25 ++++++++-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |  3 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  4 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |  4 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        | 65 ++++--------------=
----
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         | 45 ---------------
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |  1 -
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        | 47 +++++++++-------
 drivers/gpu/drm/nouveau/nouveau_bo.c               | 35 ++++++++++--
 drivers/gpu/drm/ttm/ttm_pool.c                     |  2 +-
 include/drm/drm_dp_mst_helper.h                    |  1 +
 29 files changed, 285 insertions(+), 251 deletions(-)
