Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759C0338332
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 02:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbhCLBgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 20:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhCLBfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 20:35:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19224C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 17:35:47 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id c10so50209247ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 17:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=cbgBFf+BEA9xs4Z7rCDOKTIFOgdpu3jcVQ672BqRb0Q=;
        b=mryrvoSzymEiw7kiNIes9XS4UStg997NHG7vwovJf/sd7khHJGjzf+ZPz+ev62QofL
         sb/2agaBU229XuvRI+D01VCQRUJh28YY0TN7I3uUdWK0p43V9VV+DYNfSdEgJI0/xZAT
         NvfNll0B00OnkyQ8zCjM49LYmXVNTjXZjsvDz2MyGOWw3IaSTVGpqMZzJmuL5hOAd+zr
         HtwXCwpQ1v7J9rH/YFcZf8cdtIZhhmQuIdNQJmCw9f4Mhb5RgfR31YbpLo+tHCCQkDcB
         +MddgzB6sLpIf08EmNWtzSEDFdHlAogNrmoRrYExVbeXyO5vVxhbXMkiEn/5+1T/CBJg
         y+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=cbgBFf+BEA9xs4Z7rCDOKTIFOgdpu3jcVQ672BqRb0Q=;
        b=CmZry/j1lJysOIYx4AMJ/locoWmTHvYPDO5Y6iHcbnSnynJGJiKf2SWN38thkGMEju
         T8d/xifm9IWH5FuJJ0ZIpPlHXpN9vCpwrNToifI7vdw0rk9508p+nO9LDL/mAnqHhWM9
         8iCsa5b64IWyRCHySEIJuhBQo8AT1UCPr655+v5X0PV5wU7CSUg2vJ/MhUfzdZQIf+f9
         YapKmflBiu4ewL3ylIQdn9GHnobMTFasCqQuz4AjanC3oQ5VxNlsymj8DtCJpDfM+FS7
         +46PnPZy6l+rxE2Q4PEbQKoY0Tbb8RJJW6I1zVF0QAPlBeXOoX9tISqyRY7BZz7Utkno
         XI1w==
X-Gm-Message-State: AOAM530t8JDF/gNh1WKYj2mUu6BLXiQIOvdkgajGkC3UrW9CA8Ewlw9Y
        45AIVFmDjuvugRHWKPKrTwSR4y7BTfeQjVVe3zDQc45Tfr4=
X-Google-Smtp-Source: ABdhPJwUphkl1Z3MNf5inuSvFRT7d4jByhZeBPXpESv7o9mueqYXpUIvJyOzelfskC9fkqPsiz9HehIpRUUBZpDf7nQ=
X-Received: by 2002:a17:906:ad96:: with SMTP id la22mr6124304ejb.237.1615512945694;
 Thu, 11 Mar 2021 17:35:45 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 12 Mar 2021 11:35:33 +1000
Message-ID: <CAPM=9txMJH051Yr3pgYaq-vOjCj18DuUKQivSxVZoAB=z3w5Jg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.12-rc3
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

Regular fixes for rc3. The i915 pull was based on the rc1 tag so I
just cherry-picked the single fix from there to avoid it. The misc and
amd trees seem to be on okay bases.

It's a bunch of fixes across the tree, amdgpu has most of them a few
ttm fixes around qxl, and nouveau.

Dave.

drm-fixes-2021-03-12-1:
drm fixes for 5.12-rc3

core:
- Clear holes when converting compat ioctl's between 32-bits and 64-bits.

docs:
- Use gitlab for drm bugzilla now.

ttm:
- Fix ttm page pool accounting.

fbdev:
- Fix oops in drm_fbdev_cleanup()

shmem:
- Assorted fixes for shmem helpers.

qxl:
- unpin qxl bos created as pinned when freeing them,
  and make ttm only warn once on this behavior.
- Zero head.surface_id correctly in qxl.

atyfb:
- Use LCD management for atyfb on PPC_MAC.

meson:
- Shutdown kms poll helper in meson correctly.

nouveau:
- fix regression in bo syncing

i915:
- Wedge the GPU if command parser setup fails

amdgpu:
- Fix aux backlight control
- Add a backlight override parameter
- Various display fixes
- PCIe DPM fix for vega
- Polaris watermark fixes
- Additional S0ix fix

radeon:
- Fix GEM regression
- Fix AGP dependency handling
The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15=
:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-03-12-1

for you to fetch changes up to 4042160c2e5433e0759782c402292a90b5bf458d:

  drm/nouveau: fix dma syncing for loops (v2) (2021-03-12 11:21:47 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc3

core:
- Clear holes when converting compat ioctl's between 32-bits and 64-bits.

docs:
- Use gitlab for drm bugzilla now.

ttm:
- Fix ttm page pool accounting.

fbdev:
- Fix oops in drm_fbdev_cleanup()

shmem:
- Assorted fixes for shmem helpers.

qxl:
- unpin qxl bos created as pinned when freeing them,
  and make ttm only warn once on this behavior.
- Zero head.surface_id correctly in qxl.

atyfb:
- Use LCD management for atyfb on PPC_MAC.

meson:
- Shutdown kms poll helper in meson correctly.

nouveau:
- fix regression in bo syncing

i915:
- Wedge the GPU if command parser setup fails

amdgpu:
- Fix aux backlight control
- Add a backlight override parameter
- Various display fixes
- PCIe DPM fix for vega
- Polaris watermark fixes
- Additional S0ix fix

radeon:
- Fix GEM regression
- Fix AGP dependency handling

----------------------------------------------------------------
Alex Deucher (4):
      drm/amdgpu/display: simplify backlight setting
      drm/amdgpu/display: don't assert in set backlight function
      drm/amdgpu/display: handle aux backlight in backlight_get_brightness
      drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=3Dm

Anthony DeRossi (1):
      drm/ttm: Fix TTM page pool accounting

Artem Lapkin (1):
      drm: meson_drv add shutdown function

Christian K=C3=B6nig (3):
      drm/radeon: also init GEM funcs in radeon_gem_prime_import_sg_table
      drm/radeon: fix AGP dependency
      drm/ttm: soften TTM warnings

Colin Ian King (1):
      qxl: Fix uninitialised struct field head.surface_id

Daniel Vetter (1):
      drm/compat: Clear bounce structures

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2021-03-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.12-2021-03-10' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes
      drm/nouveau: fix dma syncing for loops (v2)

Dillon Varone (1):
      drm/amd/display: Enabled pipe harvesting in dcn30

Evan Quan (1):
      drm/amd/pm: correct the watermark settings for Polaris

Gerd Hoffmann (2):
      drm/qxl: unpin release objects
      drm/qxl: fix lockdep issue in qxl_alloc_release_reserved

Holger Hoffst=C3=A4tte (2):
      drm/amd/display: Fix nested FPU context in dcn21_validate_bandwidth()
      drm/amdgpu/display: use GFP_ATOMIC in dcn21_validate_bandwidth_fp()

Kenneth Feng (1):
      drm/amd/pm: bug fix for pcie dpm

Neil Roberts (2):
      drm/shmem-helper: Check for purged buffers in fault handler
      drm/shmem-helper: Don't remove the offset in vm_area_struct pgoff

Nirmoy Das (1):
      drm/amdgpu: fb BO should be ttm_bo_type_device

Noralf Tr=C3=B8nnes (1):
      drm/shmem-helpers: vunmap: Don't put pages for dma-buf

Pavel Turinsk=C3=BD (1):
      MAINTAINERS: update drm bug reporting URL

Qingqing Zhuo (1):
      drm/amd/display: Enable pflip interrupt upon pipe enable

Randy Dunlap (2):
      fbdev: atyfb: always declare aty_{ld,st}_lcd()
      fbdev: atyfb: use LCD management functions for PPC_PMAC also

Sung Lee (1):
      drm/amd/display: Revert dram_clock_change_latency for DCN2.1

Takashi Iwai (1):
      drm/amd/display: Add a backlight module option

Thomas Zimmermann (1):
      drm: Use USB controller's DMA mask when importing dmabufs

Tong Zhang (1):
      drm/fb-helper: only unmap if buffer not null

Tvrtko Ursulin (1):
      drm/i915: Wedge the GPU if command parser setup fails

Zhan Liu (1):
      drm/amdgpu/display: Use wm_table.entries for dcn301 calculate_wm

 Documentation/gpu/todo.rst                         | 21 +++++
 MAINTAINERS                                        |  2 +-
 drivers/gpu/drm/Kconfig                            |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 50 ++++++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  1 -
 drivers/gpu/drm/amd/display/dc/dc.h                |  1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  | 11 +++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |  6 ++
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |  7 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  6 ++
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  8 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c  |  1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  | 31 +++++++
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    | 96 ++++++++++++++++++=
+++-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |  2 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  8 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  | 48 +++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  | 66 +++++++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  | 48 ++++++-----
 drivers/gpu/drm/drm_fb_helper.c                    |  2 +-
 drivers/gpu/drm/drm_gem_shmem_helper.c             | 32 +++++---
 drivers/gpu/drm/drm_ioc32.c                        | 11 +++
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  7 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             | 19 +++--
 drivers/gpu/drm/i915/i915_drv.h                    |  2 +-
 drivers/gpu/drm/meson/meson_drv.c                  | 11 +++
 drivers/gpu/drm/nouveau/nouveau_bo.c               |  6 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |  1 +
 drivers/gpu/drm/qxl/qxl_release.c                  | 12 ++-
 drivers/gpu/drm/radeon/radeon.h                    |  2 +
 drivers/gpu/drm/radeon/radeon_gem.c                |  4 +-
 drivers/gpu/drm/radeon/radeon_prime.c              |  2 +
 drivers/gpu/drm/tiny/gm12u320.c                    | 44 ++++++++--
 drivers/gpu/drm/ttm/ttm_bo.c                       |  8 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |  4 +-
 drivers/gpu/drm/udl/udl_drv.c                      | 17 ++++
 drivers/gpu/drm/udl/udl_drv.h                      |  1 +
 drivers/gpu/drm/udl/udl_main.c                     | 10 +++
 drivers/usb/core/usb.c                             | 32 ++++++++
 drivers/video/fbdev/aty/atyfb.h                    |  3 -
 drivers/video/fbdev/aty/atyfb_base.c               |  9 +-
 include/linux/usb.h                                |  2 +
 48 files changed, 566 insertions(+), 100 deletions(-)
