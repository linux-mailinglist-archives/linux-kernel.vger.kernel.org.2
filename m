Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E0636D0E2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 05:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhD1DdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 23:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbhD1DdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 23:33:00 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E87C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:32:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g14so12749073edy.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nF2BTZbaAKV+Ar+TOMcOpvhqNiphiHcM8VG3C6BnXr8=;
        b=B2u4Kg0XJzrgue6HWk21ursnC+4OkIL72ByH2pxyms8+SG8Cx+yfBU9UWpQN/caTTA
         3jSMHtzespRLTxzPip798MIQA8XCKhVRHAuDHu9cYl2t34l599ud1tQIA1mjbRN+qJUT
         ag/WNS6NPdBjyBUj1vGJdSqIvq49iuYoEh1CTgDY24aalCIDgfkvw9DofzhU7V8hsANU
         6vxi+DlIDu6XewTjMjzGZSmB5ii0icmjnrBqjuSJBVrIZs7kGiRVtqkYfOkhUCUJnLmz
         7GZq09cH6ZJJvAqvSn4zFLlKvI9J7HHKdIl56QgPew9Y9wmDD12ToG0nyxjURNqpm9qs
         RuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nF2BTZbaAKV+Ar+TOMcOpvhqNiphiHcM8VG3C6BnXr8=;
        b=UNbS3L7poLd5C3f1gWDzu53kb+3VwKX3As63fTYWZNQotdFtPbs/VSHBSOdeZClBpC
         4Lk6ydSTJcakvANoy2tyYfpJ2DE4/01QN6eZyqU/DnIXgzfxFzGO+6xXPdMpDsBsxFBH
         gOZaETj0nfvSK2jZzTu4CuRsFklQOit1wPPik8gvX0HGKqu+Nkw5IEMsDwnEVDbYACpH
         Yf4P2mkbKRnEfm+U+qknpkQZkFHYq7ACR7XvE8z4dNVr4u8WsC+eZMgh/v4iirPVxC6u
         hOB1Rp4yjA76JF5/tl8t+/zRf9XxzZetzwx6EAdfrnYg/S/OoTjcxJBlaacQEXohxXi6
         IZCA==
X-Gm-Message-State: AOAM5327fxVloQfWevT5o5xOz307fhs6UfaWk/d19V1TWprCvI8pZ19w
        RiKZ0OAy3gbjMM7RpZYqvU21SNo1z7Rjp8DSEtDQfde2LWc=
X-Google-Smtp-Source: ABdhPJzAn9Ccq24FDK+wWLtdXKB2MBZ7rpL3LbVD61iwM2u+xmE/46Lk0tYI0XEAyMCHpx7DnwJUHi2E61YWtDaVSLo=
X-Received: by 2002:a05:6402:441:: with SMTP id p1mr8214150edw.298.1619580732180;
 Tue, 27 Apr 2021 20:32:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 28 Apr 2021 13:31:59 +1000
Message-ID: <CAPM=9txMo5f9QvPqdzt8g3CmUpyDFf2Q_0XS4V1FyjHX8WQPRA@mail.gmail.com>
Subject: [git pull] drm for 5.13-rc1
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

This is the main drm pull request for 5.13. The usual lots of work all
over the place.

i915 has gotten some Alderlake work and prelim DG1 code, along with a
major locking rework over the GEM code, and brings back the property
of timing out long running jobs using a watchdog.
amdgpu has some Alderbran support (new GPU), freesync HDMI support
along with a lot other fixes.

Outside of the drm, there is a new printf specifier added which should
have all the correct acks/sobs.

There aren't a massive amount of conflicts, only with vmwgfx when I
did a test merge into your master yesterday, I think you should be
able to handle them yourself, but let me know if you want me to push a
merged tree somewhere (or if I missed something).

Dave.


drm-next-2021-04-28:
drm for 5.13-rc1

- printk fourcc modifier support added %p4cc

core:
- drm_crtc_commit_wait
- atomic plane state helpers reworked for full state
- dma-buf heaps API rework
- edid: rework and improvements for displayid

dp-mst:
 - better topology logging

bridge:
- Chipone ICN6211
- Lontium LT8912B
- anx7625 regulator support

panel:
- fix lt9611 4k panels handling

simple-kms:
- add plane state helpers

ttm:
- debugfs support
- removal of unused sysfs
- ignore signaled moved fences
- ioremap buffer according to mem caching

i915:
- Alderlake S enablement
- Conversion to dma_resv_locking
- Bring back watchdog timeout support
- legacy ioctl cleanups
- add GEM TDDO and RFC process
- DG1 LMEM preparation work
- intel_display.c refactoring
- Gen9/TGL PCH combination support
- eDP MSO Support
- multiple PSR instance support
- Link training debug updates
- Disable PSR2 support on JSL/EHL
- DDR5/LPDDR5 support for bw calcs
- LSPCON limited to gen9/10 platforms
- HSW/BDW async flip/VTd corruption workaround
=3D SAGV watermakr fixes
- SNB hard hang on ring resume fix
- Limit imported dma-buf size
- move to use new tasklet API
- refactor KBL/TGL/ADL-S display/gt steppings
- refactoring legacy DP/HDMI, FB plane code out

amdgpu:
- uapi: add ioctl to query video capabilities
- Iniital AMD Freesync HDMI support
- Initial Adebaran support
- 10bpc dithering improvements
- DCN secure display support
- Drop legacy IO BAR requirements
- PCIE/S0ix/RAS/Prime/Reset fixes
- Display ASSR support
- SMU gfx busy queues for RV/PCO
- Initial LTTPR display work

amdkfd:
- MMU notifier fixes
- APU fixes

radeon:
- debugfs cleanps
- fw error handling ifix
- Flexible array cleanups

msm:
- big DSI phy/pll cleanup
- sc7280 initial support
- commong bandwidth scaling path
- shrinker locking contention fixes
- unpin/swap support for GEM objcets

ast:
- cursor plane handling reworked

tegra:
- don't register DP AUX channels before connectors

zynqmp:
- fix OOB struct padding memset

gma500:
- drop ttm and medfield support

exynos:
- request_irq cleanup function

mediatek:
- fine tune line time for EOTp
- MT8192 dpi support
- atomic crtc config updates
- don't support HDMI connector creation

mxsdb:
- imx8mm support

panfrost:
-=3D MMU IRQ handling rework

qxl:
- locking fixes
- resource deallocation changes

sun4i:
- add alpha properties to UI/VI layers

vc4:
- RPi4 CEC support

vmwgfx:
- doc cleanups

arc:
- moved to drm/tiny
The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef=
:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-04-28

for you to fetch changes up to a1a1ca70deb3ec600eeabb21de7f3f48aaae5695:

  Merge tag 'drm-misc-next-fixes-2021-04-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2021-04-23
13:53:07 +1000)

----------------------------------------------------------------
drm for 5.13-rc1

- printk fourcc modifier support added %p4cc

core:
- drm_crtc_commit_wait
- atomic plane state helpers reworked for full state
- dma-buf heaps API rework
- edid: rework and improvements for displayid

dp-mst:
 - better topology logging

bridge:
- Chipone ICN6211
- Lontium LT8912B
- anx7625 regulator support

panel:
- fix lt9611 4k panels handling

simple-kms:
- add plane state helpers

ttm:
- debugfs support
- removal of unused sysfs
- ignore signaled moved fences
- ioremap buffer according to mem caching

i915:
- Alderlake S enablement
- Conversion to dma_resv_locking
- Bring back watchdog timeout support
- legacy ioctl cleanups
- add GEM TDDO and RFC process
- DG1 LMEM preparation work
- intel_display.c refactoring
- Gen9/TGL PCH combination support
- eDP MSO Support
- multiple PSR instance support
- Link training debug updates
- Disable PSR2 support on JSL/EHL
- DDR5/LPDDR5 support for bw calcs
- LSPCON limited to gen9/10 platforms
- HSW/BDW async flip/VTd corruption workaround
=3D SAGV watermakr fixes
- SNB hard hang on ring resume fix
- Limit imported dma-buf size
- move to use new tasklet API
- refactor KBL/TGL/ADL-S display/gt steppings
- refactoring legacy DP/HDMI, FB plane code out

amdgpu:
- uapi: add ioctl to query video capabilities
- Iniital AMD Freesync HDMI support
- Initial Adebaran support
- 10bpc dithering improvements
- DCN secure display support
- Drop legacy IO BAR requirements
- PCIE/S0ix/RAS/Prime/Reset fixes
- Display ASSR support
- SMU gfx busy queues for RV/PCO
- Initial LTTPR display work

amdkfd:
- MMU notifier fixes
- APU fixes

radeon:
- debugfs cleanps
- fw error handling ifix
- Flexible array cleanups

msm:
- big DSI phy/pll cleanup
- sc7280 initial support
- commong bandwidth scaling path
- shrinker locking contention fixes
- unpin/swap support for GEM objcets

ast:
- cursor plane handling reworked

tegra:
- don't register DP AUX channels before connectors

zynqmp:
- fix OOB struct padding memset

gma500:
- drop ttm and medfield support

exynos:
- request_irq cleanup function

mediatek:
- fine tune line time for EOTp
- MT8192 dpi support
- atomic crtc config updates
- don't support HDMI connector creation

mxsdb:
- imx8mm support

panfrost:
-=3D MMU IRQ handling rework

qxl:
- locking fixes
- resource deallocation changes

sun4i:
- add alpha properties to UI/VI layers

vc4:
- RPi4 CEC support

vmwgfx:
- doc cleanups

arc:
- moved to drm/tiny

----------------------------------------------------------------
Abdiel Janulgue (1):
      drm/i915: introduce mem->reserved

Abhinav Kumar (3):
      drm/msm/dp: Fix indentation kbot warnings in DP driver
      drm/msm/dp: Fix incorrect NULL check kbot warnings in DP driver
      drm/msm/dp: delete unnecessary debugfs error handling

Aditya Swarup (8):
      drm/i915/tgl: Use TGL stepping info for applying WAs
      drm/i915/adl_s: Configure DPLL for ADL-S
      drm/i915/adl_s: Configure Port clock registers for ADL-S
      drm/i915/adl_s: Initialize display for ADL-S
      drm/i915/adl_s: Add adl-s ddc pin mapping
      drm/i915/adl_s: Add vbt port and aux channel settings for adls
      drm/i915/adl_s: Add display WAs for ADL-S
      drm/i915/adl_s: Add GT and CTX WAs for ADL-S

Adrien Grassein (3):
      dt-bindings: display: bridge: Add documentation for LT8912B
      drm/bridge: Introduce LT8912B DSI to HDMI bridge
      drm/bridge: lt8912b: fix incorrect handling of of_* return values

Ahmed S. Darwish (2):
      video: omap: Remove in_interrupt() usage.
      video: omapfb: Remove WARN_ON(in_interrupt()).

Akhil P Oommen (2):
      drm/msm/a6xx: Fix perfcounter oob timeout
      drm/msm: Select CONFIG_NVMEM

Alex Deucher (43):
      drm/amdgpu: add asic callback for querying video codec info (v3)
      drm/amdgpu: add video decode/encode cap tables and asic callbacks (v3=
)
      drm/amdgpu: add INFO ioctl support for querying video caps (v4)
      drm/amdgpu: bump driver version for new video codec INFO ioctl query
      drm/amdgpu/codec: drop the internal codec index
      drm/amdgpu/pm: make unsupported power profile messages debug
      drm/amdgpu/swsmu/vangogh: Only use RLCPowerNotify msg for disable
      drm/amdgpu: Only check for S0ix if AMD_PMC is configured
      drm/amdgpu: enable BACO runpm by default on sienna cichlid and
navy flounder
      drm/amdgpu: enable TMZ by default on Raven asics
      drm/amdgpu/dc: fill in missing call to atom cmd table for pll adjust =
v2
      drm/amdgpu/display: simplify backlight setting
      drm/amdgpu/display: don't assert in set backlight function
      drm/amdgpu/display: handle aux backlight in backlight_get_brightness
      drm/amdgpu: add mmhub client ids for aldebaran
      drm/amdgpu: fix S0ix handling when the CONFIG_AMD_PMC=3Dm
      drm/amdgpu/powerplay/smu10: add support for gpu busy query (v2)
      drm/amdgpu/smu8: return an error rather than 50% if busy query fails
      drm/amdgpu: drop legacy IO bar support
      drm/amdgpu: drop extraneous hw_status update
      drm/amdgpu/display: properly guard dc_dsc_stream_bandwidth_in_kbps
      drm/amdgpu/display/dm: add missing parameter documentation
      drm/amdgpu: Add additional Sienna Cichlid PCI ID
      drm/amdgpu: add a dev_pm_ops prepare callback (v2)
      drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
DPM_FLAG_SMART_SUSPEND flags (v2)
      drm/amdgpu: disentangle HG systems from vgaswitcheroo
      drm/amdgpu: rework S3/S4/S0ix state handling
      drm/amdgpu: don't evict vram on APUs for suspend to ram (v4)
      drm/amdgpu: clean up non-DC suspend/resume handling
      drm/amdgpu: move s0ix check into amdgpu_device_ip_suspend_phase2 (v3)
      drm/amdgpu: re-enable suspend phase 2 for S0ix
      drm/amdgpu/swsmu: skip gfx cgpg on s0ix suspend
      drm/amdgpu: update comments about s0ix suspend/resume
      drm/amdgpu: drop S0ix checks around CG/PG in suspend
      drm/amdgpu: skip kfd suspend/resume for S0ix
      drm/amdgpu/display: restore AUX_DPHY_TX_CONTROL for DCN2.x
      drm/amdgpu/display: fix memory leak for dimgrey cavefish
      drm/amdgpu/pm: mark pcie link/speed arrays as const
      drm/amdgpu/pm: bail on sysfs/debugfs queries during platform suspend
      drm/amdgpu/vangogh: don't check for dpm in is_dpm_running when in sus=
pend
      drm/amdgpu/display: fix warning on 32 bit in dmub
      drm/amdgpu: drop some unused atombios functions
      drm/amdgpu/smu7: fix CAC setting on TOPAZ

Alex Sierra (6):
      drm/amdgpu: UTLC1 RB SDMA timeout on Aldebaran
      drm/amdgpu: enable 48-bit IH timestamp counter
      drm/amdgpu: update mmhub client ids for Aldebaran
      drm/amdgpu: use pd addr based on gart level page table
      drm/amdgpu: replace per_device_list by array
      drm/amdgpu: ih reroute for newer asics than vega20

Alvin Lee (1):
      drm/amd/display: Change input parameter for set_drr

Amber Lin (2):
      drm/amdgpu: Aldebaran doesn't use semaphore
      drm/amdkfd: Avoid null pointer in SMI event

AngeloGioacchino Del Regno (2):
      drm/msm/dsi: Uncomment core_mmss clock for MSM8996
      drm/msm/mdp5: Disable pingpong autorefresh at tearcheck init

Ankit Nautiyal (4):
      drm/i915: Fix HAS_LSPCON macro for platforms between GEN9 and GEN10
      drm/i915/display: Remove FRL related code from disable DP
sequence for older platforms
      drm/dp_helper: Define options for FRL training for HDMI2.1 PCON
      drm/i915/display: Configure HDMI2.1 Pcon for FRL only if Src-Ctl
mode is available

Anshuman Gupta (7):
      drm/i915/debugfs: HDCP capability enc NULL check
      drm/i915/hdcp: mst streams type1 capability check
      drm/i915/hdcp: HDCP2.2 MST Link failure recovery
      drm/i915/hdcp: link hdcp2 recovery on link enc stopped
      drm/i915/hdcp: return correct error code
      drm/i915/hdcp: Add DP HDCP2.2 timeout to read entire msg
      drm/hdcp: DP HDCP2.2 errata LC_Send_L_Prime=3D16

Anson Jacob (7):
      Revert "drm/amd/display: reuse current context instead of recreating =
one"
      drm/amdkfd: Fix UBSAN shift-out-of-bounds warning
      Revert "drm/amd/display: remove duplicate include in amdgpu_dm.c"
      drm/amd/display: remove duplicate include in amdgpu_dm.c
      drm/amd/display: Fix UBSAN warning for not a valid value for type '_B=
ool'
      drm/amd/display: Fix UBSAN: shift-out-of-bounds warning
      drm/amd/display: Removing unused code from dmub_cmd.h

Anthony Koo (8):
      drm/amd/display: [FW Promotion] Release 0.0.52
      drm/amd/display: [FW Promotion] Release 0.0.53
      drm/amd/display: [FW Promotion] Release 0.0.54
      drm/amd/display: [FW Promotion] Release 0.0.55
      drm/amd/display: [FW Promotion] Release 0.0.56
      drm/amd/display: [FW Promotion] Release 0.0.57
      drm/amd/display: [FW Promotion] Release 0.0.58
      drm/amd/display: [FW Promotion] Release 0.0.59

Anthony Wang (2):
      drm/amd/display: disable seamless boot for DP MST
      drm/amd/display: enable audio on DP seamless boot

Anusha Srivatsa (4):
      drm/i915/adl_s: Add PCH support
      drm/i915/adl_s: Add Interrupt Support
      drm/i915/adl_s: Add PHYs for Alderlake S
      drm/i915/adl_s: Load DMC

Aric Cyr (13):
      drm/amd/display: 3.2.123
      drm/amd/display: Don't optimize bandwidth before disabling planes
      drm/amd/display: reduce scope for local var
      drm/amd/display: 3.2.124
      drm/amd/display: 3.2.125
      drm/amd/display: 3.2.126
      drm/amd/display: 3.2.126.1
      drm/amd/display: System black screen hangs on driver load
      drm/amd/display: DCHUB underflow counter increasing in some scenarios
      drm/amd/display: 3.2.127
      drm/amd/display: 3.2.128
      drm/amd/display: 3.2.129
      drm/amd/display: 3.2.130

Arnd Bergmann (7):
      drm/amd/display: Fix an uninitialized index variable
      fbdev: omapfb: avoid -Wempty-body warning
      vgaarb: avoid -Wempty-body warnings
      drm/omap: fix misleading indentation in pixinc()
      amdgpu: avoid incorrect %hu format string
      amdgpu: fix gcc -Wrestrict warning
      amdgpu: securedisplay: simplify i2c hexdump output

Arunpravin (1):
      drm/amd/pm/swsmu: clean up user profile function

Asher.Song (1):
      drm/amdgpu:disable VCN for Navi12 SKU

Ashutosh Dixit (1):
      drm/i915: Disable pread/pwrite ioctl's for future platforms (v3)

Atufa Khan (1):
      drm/amd/display: Separate caps for maximum RGB and YUV plane counts

Aurabindo Pillai (6):
      drm/amd/display: Old sequence for HUBP blank
      drm/amd/display: Add module parameter for freesync video mode
      drm/amd/display: Add freesync video modes based on preferred modes
      drm/amd/display: Skip modeset for front porch change
      Revert freesync video patches temporarily
      drm/amd/display: Add debugfs entry for LTTPR register status

Bernard Zhao (4):
      drm/vc4: remove unneeded variable: "ret"
      gpu/drm/msm: remove redundant pr_err() when devm_kzalloc failed
      drm/amd: use kmalloc_array over kmalloc with multiply
      drm/amd: cleanup coding style a bit

Bhaskar Chowdhury (12):
      drm/i915/gvt: Fixed couple of spellings in the file gtt.c
      drm: Few typo fixes
      drm/i915/display: Fix a typo
      drm/meson: Fix few typo
      drm/amd/pm: Mundane typo fixes in the file amdgpu_pm.c
      drivers: gpu: drm: msn: disp: dpu1: Fixed couple of spellings in
the file dpu_hw_top.h
      drm/amdgpu: Fix a typo
      drm/amdgpu: Fix a typo
      drm/atomic: Couple of typo fixes
      drm/radeon/r600_cs: Few typo fixes
      drm/amd/amdgpu/gfx_v7_0: Trivial typo fixes
      drm/amd: Fix a typo in two different sentences

Bindu Ramamurthy (1):
      drm/amd/display: Allow idle optimization based on vblank.

Bjorn Andersson (2):
      dt-bindings: dp-connector: Drop maxItems from -supply
      drm/msm: Remove need for reiterating the compatibles

Boris Brezillon (4):
      drm/panfrost: Clear MMU irqs before handling the fault
      drm/panfrost: Don't try to map pages that are already mapped
      drm/panfrost: Stay in the threaded MMU IRQ handler until we've
handled all IRQs
      drm/mediatek: Add missing MODULE_DEVICE_TABLE()

CQ Tang (1):
      drm/i915: reserve stolen for LMEM region

Calvin Hou (1):
      drm/amd/display: Correct algorithm for reversed gamma

Carsten Haitzler (1):
      drm/komeda: Fix bit check to import to value of proper type

Caz Yokoyama (2):
      drm/i915/adl_s: Add ADL-S platform info and PCI ids
      x86/gpu: Add Alderlake-S stolen memory support

Changfeng (1):
      drm/amdgpu: decline max_me for mec2_fw remove in renoir/arcturus

Chen Li (4):
      drm/radeon: Use kvmalloc for CS chunks
      drm/amdgpu: Use kvmalloc for CS chunks
      drm/amdgpu: correct DRM_ERROR for kvmalloc_array
      radeon: use kvcalloc for relocs and chunks

Chen Lin (1):
      drm/radeon: Remove unused function pointer typedef radeon_packet3_che=
ck_t

Chengming Gui (1):
      drm/amd/amdgpu: set MP1 state to UNLOAD before reload its FW for
vega20/ALDEBARAN

Chris Park (2):
      drm/amd/display: AVMUTE simplification
      drm/amd/display: Disable MALL when SMU not present

Chris Wilson (23):
      drm/i915: Strip out internal priorities
      drm/i915: Remove I915_USER_PRIORITY_SHIFT
      drm/i915/gt: Call stop_ring() from ring resume, again
      drm/i915/gt: SPDX cleanup
      drm/i915/gt: Add some missing blank lines after declaration
      drm/i915/gt: Remove repeated words from comments
      drm/i915/gt: Fixup misaligned function parameters
      drm/i915/gt: Remove a bonus newline
      drm/i915/gt: Wrap macro arg in ()
      drm/i915/gt: Insert spaces into GEN3_L3LOG_SIZE/4
      drm/i915/gt: Replace unnecessary ',' with '; '
      drm/i915/gt: Add a space before '('
      drm/i915/gt: Replace 'return' with a fall-through
      drm/i915/selftests: Check for engine-reset errors in the middle
of workarounds
      drm/i915/gt: Move the defer_request waiter active assertion
      drm/i915: Protect against request freeing during cancellation on wedg=
ing
      drm/i915/selftests: Use a single copy of the mocs table
      drm/i915/gt: Retire unexpected starting state error dumping
      drm/i915/selftests: Restore previous heartbeat interval
      drm/i915/gt: Double check heartbeat timeout before resetting
      drm/i915/selftest: Synchronise with the GPU timestamp
      drm/i915/gt: Always flush the submission queue on checking for idle
      drm/i915: Individual request cancellation

Christian Hewitt (1):
      drm/lima: add governor data with pre-defined thresholds

Christian K=C3=B6nig (42):
      drm/ttm: add debugfs directory v2
      drm/ttm: add a debugfs file for the global page pools
      drm/ttm: add debugfs entry to test pool shrinker v2
      drm/ttm: optimize ttm pool shrinker a bit
      drm/syncobj: make lockdep complain on WAIT_FOR_SUBMIT v3
      drm/ttm: device naming cleanup
      drm/v3d/v3d_sched: fix scheduler callbacks return status
      drm/scheduler: provide scheduler score externally
      drm/ttm: fix removal of bo_count sysfs file
      drm/ttm: rework ttm_tt page limit v4
      drm/ttm: move memory accounting into vmwgfx v4
      drm/ttm: drop sysfs directory
      drm/vram-helper: cleanup drm_gem_vram_bo_driver_move_notify
      drm/sched: select new rq even if there is only one v3
      drm/qxl: clean up qxl_bo_move_notify
      drm/nouveau: clean up nouveau_bo_move_ntfy
      drm/vmwgfx: clean up vmw_move_notify v2
      drm/radeon: also init GEM funcs in radeon_gem_prime_import_sg_table
      drm/radeon: fix AGP dependency
      drm/radeon: keep __user during cast
      drm/amdgpu: new resource cursor (v2)
      drm/amdgpu: use the new cursor in amdgpu_ttm_copy_mem_to_mem
      drm/amdgpu: use the new cursor in amdgpu_fill_buffer
      drm/amdgpu: use new cursor in amdgpu_ttm_io_mem_pfn
      drm/amdgpu: use the new cursor in amdgpu_ttm_access_memory
      drm/amdgpu: use new cursor in amdgpu_mem_visible
      drm/amdgpu: use the new cursor in amdgpu_ttm_bo_eviction_valuable
      drm/amdgpu: use the new cursor in the VM code
      drm/amdgpu: nuke the ih reentrant lock
      drm/amdgpu: revert "use the new cursor in the VM code"
      drm/amdgpu: revert "reserve backup pages for bad page retirment"
      drm/ttm: move swapout logic around v3
      drm/ttm: remove swap LRU v3
      drm/ttm: switch to per device LRU lock
      drm/ttm: fix invalid NULL deref
      drm/ttm: switch back to static allocation limits for now
      drm/sched: add missing member documentation
      drm/amdgpu: remove irq_src->data handling
      drm/amdgpu: add the sched_score to amdgpu_ring_init
      drm/amdgpu: share scheduler score on VCN3 instances
      drm/amdgpu: load balance VCN3 decode as well v8
      drm/ttm: fix return value check

Chun-Kuang Hu (1):
      drm/mediatek: crtc: Make config-updating atomic

Clint Taylor (1):
      drm/i915/display: support ddr5 mem types

Colin Ian King (11):
      drm/i915/display: fix spelling mistake "Couldnt" -> "Couldn't"
      drm/mgag200: make a const array static, makes object smaller
      drm/amd/pm: fix spelling mistake in various messages
"power_dpm_force_perfomance_level"
      drm/amd/display: fix the return of the uninitialized value in ret
      drm/radeon: fix copy of uninitialized variable back to userspace
      drm/amd/display: remove redundant initialization of variable status
      drm/amdgpu/display: remove redundant continue statement
      drm/amdgpu: Fix spelling mistake "disabed" -> "disabled"
      drm/amd/pm: Fix spelling mistake "disble" -> "disable"
      drm/amd/display: remove redundant initialization of variable result
      drm/msm: Fix spelling mistake "Purgable" -> "Purgeable"

Colin Xu (2):
      drm/i915/gvt: Get accurate vGPU virtual display refresh rate from vre=
g
      drm/i915/gvt: Refactor GVT vblank emulator for vGPU virtual display

Dafna Hirschfeld (5):
      MAINTAINERS: Add linux-mediatek ML for drm Mediatek drivers
      drm: Fix 3 typos in the inline doc
      drm/mediatek: Switch the hdmi bridge ops to the atomic versions
      drm/mediatek: Don't support hdmi connector creation
      drm/bridge: fix typo in Kconfig

Dan Carpenter (4):
      drm/vmwgfx/vmwgfx_drv: Fix an error path in vmw_setup_pci_resources()
      drm/virtio: fix an error code in virtio_gpu_init()
      drm/amd/display: Fix off by one in hdmi_14_process_transaction()
      drm: xlnx: zynqmp: fix a memset in zynqmp_dp_train()

Daniel Gomez (2):
      drm/amdgpu/ttm: Fix memory leak userptr pages
      drm/radeon/ttm: Fix memory leak userptr pages

Daniel Vetter (35):
      drm: Update todo.rst
      drm/todo: Add entry for moving to dma_resv_lock
      drm/vblank: Document drm_crtc_vblank_restore constraints
      drm/tidss: Annotate dma-fence critical section in commit path
      drm/tegra: Annotate dma-fence critical section in commit path
      drm/omapdrm: Annotate dma-fence critical section in commit path
      drm/atmel: Use drm_atomic_helper_commit
      drm/malidp: Annotate dma-fence critical section in commit path
      drm/komeda: Annotate dma-fence critical section in commit path
      drm/vkms: Annotate vblank timer
      drm/arc: Switch to devm_drm_dev_alloc
      drm/arc: Stop using drm_device->dev_private
      drm/arc: Delete arcpgu_priv->fb
      drm/arc: Embedded a drm_simple_display_pipe
      drm/arc: Embedd a drm_connector for sim case
      drm/arc: Drop surplus connector registration
      drm/arc: Use drmm_mode_config_cleanup
      drm/arc: Align with simple pipe helpers
      drm/arc: Convert to drm_simple_kms_pipe_helper
      drm/arc: Drop crtc check in arc_pgu_update
      drm/arc: Inline arcpgu_crtc.c
      drm/arc: Inline arcpgu_drm_hdmi_init
      drm/arc: Inline remaining files
      drm/arc: Initialize sim connector before display pipe
      drm/arc: Move to drm/tiny
      drm/compat: Clear bounce structures
      drm/compat: more dummy implementations
      drm/arcpgu: Really delete file
      dma-fence: Document recoverable page fault implications
      drm/i915: add gem/gt TODO
      drm/doc: Add RFC section
      Merge tag 'amd-drm-next-5.13-2021-03-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'amd-drm-next-5.13-2021-04-12' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge drm/drm-fixes into drm-next
      Merge tag 'drm-msm-next-2021-04-11' of
https://gitlab.freedesktop.org/drm/msm into drm-next

Dario Binacchi (4):
      drm/tilcdc: fix raster control register setting
      drm/tilcdc: rename req_rate to pclk_rate
      drm/tilcdc: fix LCD pixel clock setting
      drm/tilcdc: fix pixel clock setting warning message

Darren Powell (8):
      amdgpu/pm: Powerplay API for smu , added get_performance_level
      amdgpu/pm: Powerplay API for smu , changed 6 dpm reset functions
to use API
      amdgpu/pm: Powerplay API for smu , changed 6 pm hwmon fan
functions to use API
      amdgpu/pm: Powerplay API for smu , changed 9 pm power functions to us=
e API
      amdgpu/pm: Powerplay API for smu , changed 5 dpm powergating &
sensor functions to use API
      amdgpu/pm: Powerplay API for smu , changes to clock and profile
mode functions
      amdgpu/pm: Powerplay API for smu , changed 4 dpm functions to use API
      amdgpu/pm: Powerplay API for smu , updates to some pm functions

Dave Airlie (20):
      drm/i915: refactor ddi translations into a separate file (v2)
      drm/i915: migrate hsw fdi code to new file.
      drm/i915: migrate skl planes code new file (v5)
      drm/i915: move pipe update code into crtc. (v2)
      drm/i915: split fb scalable checks into g4x and skl versions
      drm/i915: move is_ccs_modifier to an inline
      drm/i915: migrate pll enable/disable code to intel_dpll.[ch]
      drm/i915: migrate i9xx plane get config
      drm/i915: refactor skylake scaler code into new file.
      Merge tag 'drm-misc-next-2021-03-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-intel-next-2021-03-16' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-next-20210322' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'topic/i915-gem-next-2021-03-26' of
ssh://git.freedesktop.org/git/drm/drm into drm-next
      Merge tag 'exynos-drm-next-for-v5.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-next
      Merge tag 'drm-misc-next-2021-04-01' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'mediatek-drm-next-5.13' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-next
      Merge tag 'drm-intel-gt-next-2021-04-06' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-intel-next-2021-04-01' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-misc-next-2021-04-09' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'drm-misc-next-fixes-2021-04-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

David (Dingchen) Zhang (1):
      drm/amd/display: use MST downstream AUX to dump DPRX CRCs

David Galiffi (1):
      drm/amd/display: Fixed Clock Recovery Sequence

David Stevens (1):
      drm/syncobj: use newly allocated stub fences

Dennis Li (8):
      drm/amdgpu: reserve backup pages for bad page retirment
      drm/amdgpu: remove unnecessary reading for epprom header
      drm/amdgpu: enable sram initialization for aldebaran
      drm/amdgpu: add ras support for gfx of aldebaran
      drm/amdgpu: refine ras codes for GC utc of aldebaran
      drm/amdgpu: enable watchdog feature for SQ of aldebaran
      drm/amdgpu: harvest edc status when connected to host via xGMI
      drm/amdgpu: add codes to capture invalid hardware access when recover=
y

Diego Viola (1):
      drm/amd/display: fix typo: liason -> liaison

Dillon Varone (4):
      drm/amd/display: Fix HSplit causing increase in DSC Slice Count
      drm/amd/display: Enabled pipe harvesting in dcn30
      drm/amd/display: Add changes for dsc bpp in 16ths and unify bw
calculations
      drm/amd/display: Remove MPC gamut remap logic for DCN30

Dmitry Baryshkov (27):
      clk: mux: provide devm_clk_hw_register_mux()
      clk: divider: add devm_clk_hw_register_divider
      drm/msm/dsi: replace PHY's init callback with configurable data
      drm/msm/dsi: fuse dsi_pll_* code into dsi_phy_* code
      drm/msm/dsi: drop multiple pll enable_seq support
      drm/msm/dsi: move all PLL callbacks into PHY config struct
      drm/msm/dsi: drop global msm_dsi_phy_type enumaration
      drm/msm/dsi: move min/max PLL rate to phy config
      drm/msm/dsi: remove msm_dsi_pll_set_usecase
      drm/msm/dsi: push provided clocks handling into a generic code
      drm/msm/dsi: use devm_clk_*register to registe DSI PHY clocks
      drm/msm/dsi: use devm_of_clk_add_hw_provider
      drm/msm/dsi: make save/restore_state phy-level functions
      drm/msm/dsi: drop vco_delay setting from 7nm, 10nm, 14nm drivers
      drm/msm/dsi: simplify vco_delay handling in dsi_phy_28nm driver
      drm/msi/dsi: inline msm_dsi_pll_helper_clk_prepare/unprepare
      drm/msm/dsi: make save_state/restore_state callbacks accept msm_dsi_p=
hy
      drm/msm/dsi: drop msm_dsi_pll abstraction
      drm/msm/dsi: drop PLL accessor functions
      drm/msm/dsi: move ioremaps to dsi_phy_driver_probe
      drm/msm/dsi: remove duplicate fields from dsi_pll_Nnm instances
      drm/msm/dsi: remove temp data from global pll structure
      drm/msm/dsi: inline msm_dsi_phy_set_src_pll
      drm/msm/dsi: stop passing src_pll_id to the phy_enable call
      drm/msm/dpu: enable DPU_SSPP_QOS_8LVL for SM8250
      drm/msm/dpu: fill missing details in hw catalog for sdm845 and sm8[12=
]50
      drm/msm/dpu: always use mdp device to scale bandwidth

Dmitry Vyukov (1):
      drm/vkms: fix misuse of WARN_ON

Dmytro Laktyushkin (6):
      drm/amd/display: use max lb for latency hiding
      drm/amd/display: fix dml prefetch validation
      drm/amd/display: fix dcn3+ bw validation soc param update sequence
      drm/amd/display: hide VGH asic specific structs
      drm/amd/display: revert max lb lines change
      drm/amd/display: revert max lb use by default for n10

Dom Cobley (5):
      drm/vc4: hdmi: Move hdmi reset to bind
      drm/vc4: hdmi: Fix register offset with longer CEC messages
      drm/vc4: hdmi: Fix up CEC registers
      drm/vc4: hdmi: Restore cec physical address on reconnect
      drm/vc4: hdmi: Remove cec_available flag

Douglas Anderson (6):
      drm/panel-simple: Undo enable if HPD never asserts
      drm/panel-simple: Don't wait longer for HPD than hpd_absent_delay
      drm/panel-simple: Retry if we timeout waiting for HPD
      dt-bindings: dt-bindings: display: simple: Add N116BCA-EA1
      drm/panel-simple: Add N116BCA-EA1
      drm: panel: simple: Set enable delay for BOE NV110WTM-N61

Edmund Dea (1):
      drm/i915/display: Remove PSR2 on JSL and EHL

Emil Renner Berthing (1):
      drm/i915/gt: use new tasklet API for execution list

Emily Deng (2):
      drm/amdgpu: Fix some unload driver issues
      drm/amdgpu: Fix some unload driver issues

Eric Bernstein (2):
      drm/amd/display: Implement transmitter control v1.7
      drm/amd/display: Remove Assert from dcn10_get_dig_frontend

Eric Huang (6):
      drm/amdgpu: new cache coherence change for Aldebaran
      drm/amdkfd: add new flag for uncached GPU mapping
      drm/amdgpu: set CPU mapping of vram as cached for A+A mode
      drm/amdgpu: set snoop bit in pde/pte entries for A+A
      drm/amdkfd: apply uncached flag for aldebaran
      drm/amd/pm: add a new sysfs entry for default power limit

Eryk Brol (4):
      drm/amd/display: Check for DSC support instead of ASIC revision
      drm/amd/display: Add max bpc debugfs
      drm/mst: Enhance MST topology logging
      drm/amd/display: Fix MST topology debugfs

Evan Quan (16):
      drm/amd/pm: correct Arcturus mmTHM_BACO_CNTL register address
      drm/amd/pm: bump Navi1x driver if version and related data structures=
 V2
      drm/amd/pm: optimize the link width/speed retrieving V2
      drm/amd/pm: correct gpu metrics related data structures V3
      drm/amd/pm: update existing gpu_metrics interfaces V2
      drm/amd/pm: correct the watermark settings for Polaris
      drm/amd/pm: correct the gpu metrics version
      drm/amd/pm: fix Navi1x runtime resume failure V2
      drm/amd/pm: make DAL communicate with SMU through unified interfaces
      drm/amd/pm: label these APIs used internally as static
      drm/amd/pm: drop redundant and unneeded BACO APIs V2
      drm/amd/pm: no need to force MCLK to highest when no display connecte=
d
      drm/amd/pm: unify the interface for loading SMU microcode
      drm/amd/pm: fix missing static declarations
      drm/amd/pm: unify the interface for power gating
      drm/amd/pm: unify the interface for gfx state setting

Fangzhi Zuo (1):
      drm/amd/display: Fix debugfs link_settings entry

Feifei Xu (12):
      drm/amdgpu: simplify the sdma 4_x MGCG/MGLS logic.
      drm/amdgpu: add sdma 4_x interrupts printing
      drm/amdgpu: Add DID for aldebaran
      drm/amdgpu:add smu mode1/2 support for aldebaran
      drm/amdgpu:return true for mode1_reset_support on aldebaran
      drm/amdgpu: correct vram_info for HBM2E
      drm/amd/pm:add aldebaran support for getting bootup values
      drm/amdgpu: update atom_firmware_info_v3_4 (v2)
      drm/amdpgu: add ATOM_DGPU_VRAM_TYPE_HBM2E vram type
      drm/amdgpu:disable XGMI TA unload for A+A aldebaran
      drm/amdgpu: Use dev_info if VFCT table not valid
      drm/amdgpu: skip PP_MP1_STATE_UNLOAD on aldebaran

Felix Kuehling (11):
      drm/amdkfd: Use mmu_notifier_get
      drm/amdkfd: Cleanup kfd_process if init_cwsr_apu fails
      drm/amdkfd: Use a new capability bit for SRAM ECC
      drm/amdgpu: Let KFD use more VMIDs on Aldebaran
      drm/amdgpu: Make noretry the default on Aldebaran
      drm/amdkfd: fix build error with AMD_IOMMU_V2=3Dm
      drm/amdkfd: Fix recursive lock warnings
      drm/amdgpu: Mark Aldebaran HW support as experimental
      drm/amdkfd: Bump KFD API version
      drm/ttm: Ignore signaled move fences
      drm/ttm: Don't count pages in SG BOs against pages_limit

Gerd Hoffmann (20):
      Revert "drm/qxl: do not run release if qxl failed to init"
      drm/qxl: use drmm_mode_config_init
      drm/qxl: unpin release objects
      drm/qxl: release shadow on shutdown
      drm/qxl: properly pin/unpin shadow
      drm/qxl: handle shadow in primary destroy
      drm/qxl: properly free qxl releases
      drm/qxl: simplify qxl_fence_wait
      drm/qxl: allocate dumb buffers in ram
      drm/qxl: properly handle device init failures
      drm/qxl: more fence wait rework
      drm/qxl: use ttm bo priorities
      drm/qxl: fix lockdep issue in qxl_alloc_release_reserved
      drm/qxl: rename qxl_bo_kmap -> qxl_bo_vmap_locked
      drm/qxl: add qxl_bo_vmap/qxl_bo_vunmap
      drm/qxl: fix prime vmap
      drm/qxl: fix monitors object vmap
      drm/qxl: move shadow handling to new qxl_prepare_shadow()
      drm/qxl: rework cursor plane
      drm/qxl: add lock asserts to qxl_bo_vmap_locked + qxl_bo_vunmap_locke=
d

Guchun Chen (6):
      drm/amd/pm: fix MP1 state setting failure in s3 test
      drm/amd/pm: fix gpu reset failure by MP1 state setting
      drm/amd/display: add DMCUB trace irq support for DCN302
      drm/amdgpu: fix NULL pointer dereference
      drm/amdgpu: fix compiler warning(v2)
      drm/radeon: avoid potential null pointer access

Guobin Huang (1):
      gma500: Use DEFINE_SPINLOCK() for spinlock

Gustavo A. R. Silva (4):
      drm/amd/pm: Replace one-element array with flexible-array in
struct SISLANDS_SMC_SWSTATE
      drm/amd/pm: Replace one-element array with flexible-array in
struct _ATOM_Vega10_GFXCLK_Dependency_Table
      drm/radeon/nislands_smc.h: Replace one-element array with
flexible-array member in struct NISLANDS_SMC_SWSTATE
      drm/radeon/si_dpm: Replace one-element array with flexible-array
in struct SISLANDS_SMC_SWSTATE

Gwan-gyeong Mun (3):
      drm/i915/display: Support PSR Multiple Instances
      drm/i915/display: Support Multiple Transcoders' PSR status on debugfs
      drm/i915/display: Do not allow DC3CO if PSR SF is enabled

Harish Kasiviswanathan (2):
      drm/amdgpu: update default timeout of Aldebaran SQ watchdog
      Revert "drm/amdgpu: During compute disable GFXOFF for Sienna_Cichlid"

Harry VanZyllDeJong (1):
      drm/amd/display: Fixed corruption on 4K tvs

Harry Wentland (2):
      drm/amd/display: Add debug prints for SMU messages
      drm/amd/display: Add dc_debug flag to disable min fclk

Hawking Zhang (66):
      drm/amdgpu: add gc v9_4_2 ip headers (v3)
      drm/amdgpu: add mmhub v1_7 ip headers (v3)
      drm/amdgpu: add mp v13_0_2 ip headers (v3)
      drm/amdgpu: add smuio v13_0_2 ip headers (v3)
      drm/amdgpu: add sdma v4_4_0 ip headers (v2)
      drm/amdgpu: add thm v13_0_2 ip headers (v3)
      drm/amdgpu: add umc v6_7_0 ip headers (v3)
      drm/amdgpu: add vcn v2_6_0 ip headers (v3)
      drm/amd/include: add ip offset header for aldebaran (v5)
      drm/amdgpu: init sos microcode for psp v13
      drm/amdgpu: add kdb loading support for psp v13
      drm/amdgpu: add sys_drv loading support for psp v13
      drm/amdgpu: add tOS loading support for psp v13
      drm/amdgpu: add psp v13 ring support
      drm/amdgpu: init psp v13 ip function
      drm/amdgpu: fix incorrect EP_STRAP reg offset for aldebaran
      drm/amdgpu: load pmfw prior to other non-psp fw for aldebaran
      drm/amdgpu: detect sriov capability for aldebaran
      drm/amdgpu: bypass gc_9_x_common golden settings
      drm/amdgpu: enable psp v13 ip block for aldebaran
      drm/amdgpu: add new smuio callbacks for aldebaran
      drm/amdgpu: implement smuio v13_0 callbacks
      drm/amdgpu: initialize smuio callbacks for aldebaran
      drm/amdgpu: skip MEC2_JT initialization for aldebaran
      drm/amdgpu: initialize ta firmware for aldebaran
      drm/amdgpu: comments out vcn/jpeg ip blocks for aldebaran
      drm/amdgpu: initialize external rev_id for aldebaran
      drm/amdgpu: declare smuio v13_0 callbacks as static
      drm/amdgpu: support get_vram_info atomfirmware i/f for aldebaran
      drm/amdgpu: init gds for aldebaran
      drm/amdgpu: skip gds ras workaround for aldebaran
      drm/amdgpu: use physical_node_id to calculate aper_base
      drm/amdgpu: apply sdma golden settings for aldebaran
      drm/amdgpu: add sdma v4_4 ras function
      drm/amdgpu: add sdma ras error query callback for aldebaran
      drm/amdgpu: add sdma ras error reset callback for aldebaran
      drm/amdgpu: add mmhub ras error query callback for aldebaran
      drm/amdgpu: add mmhub ras error reset callback for aldebaran
      drm/amdgpu: add mmhub error status query callback for aldebaran
      drm/amdgpu: correct IH_CHICKEN programming for aldebaran
      drm/amdgpu: switch to vega20 ih block for aldebaran
      drm/amdgpu: disallow use semaphore on aldebaran
      drm/amdgpu: query aldebaran gfx_config through atomfirmware i/f
      drm/amdgpu: retire aldebaran gpu_info firmware
      drm/amdgpu: bypass hdp read cache invalidation for aldebaran (v2)
      drm/amdgpu: switch to cached noretry setting for aldebaran
      drm/amdgpu: apply new pmfw loading sequence to arcturus and onwards
      drm/amdgpu: allow use psp to load firmware (v2)
      drm/amdgpu: apply gc v9_4_2 golden settings for aldebaran
      drm/amdgpu: add common gc golden settings for aldebaran
      drm/amdgpu: update TCP_CHAN_STEER_1 golden value for aldebaran
      drm/amdgpu: update umc_info v3_3 structure for ECC
      drm/amdgpu: support query ecc cap for SIENNA_CICHLID
      drm/amdgpu: update ecc query support for arcturus
      drm/amdgpu: initialze ras caps per paltform config
      drm/amdgpu: create umc_v6_7_funcs for aldebaran
      drm/amdgpu: add helper funtion to query umc ras error
      drm/amdgpu: implement umc query error count callback
      drm/amdgpu: implement query_ras_error_address callback
      drm/amdgpu: split nbio callbacks into ras and non-ras ones
      drm/amdgpu: move xgmi ras functions to xgmi_ras_funcs
      drm/amdgpu: split umc callbacks to ras and non-ras ones
      drm/amdgpu: do not register df_mca interrupt in certain config
      drm/amdgpu: split mmhub callbacks into ras and non-ras ones
      drm/amdgpu: split gfx callbacks into ras and non-ras ones
      drm/amdgpu: move mmhub ras_func init to ip specific file

Holger Hoffst=C3=A4tte (2):
      drm/amd/display: Fix nested FPU context in dcn21_validate_bandwidth()
      drm/amdgpu/display: use GFP_ATOMIC in dcn21_validate_bandwidth_fp()

Horace Chen (2):
      drm/amdgpu: enable one vf mode on sienna cichlid vf
      drm/amdgpu: move vram recover into sriov full access

Hsin-Yi Wang (2):
      dt-bindings: drm/bridge: anx7625: Add power supplies
      drm/bridge: anx7625: disable regulators when power off

Huacai Chen (1):
      drm/amdgpu: Set a suitable dev_info.gart_page_size

Huang Rui (1):
      drm/amd/pm: do not issue message while write "r" into pp_od_clk_volta=
ge

Hugo Hu (1):
      drm/amd/display: treat memory as a single-channel for asymmetric memo=
ry

Imre Deak (37):
      drm/dp_mst: Don't cache EDIDs for physical ports
      drm/dp_mst: Remove redundant tile property setting
      drm/dp_mst: Use DP_MST_LOGICAL_PORT_0 instead of magic number
      drm/i915: Disable runtime power management during shutdown
      drm/i915/tgl+: Make sure TypeC FIA is powered up when initializing it
      drm/dp_mst: Tune down the WARN modesetting a port with full_pbn=3D0
      drm/i915/tgl+: Sanitize the DDI LANES/IO and AUX power domain names
      drm/i915/ilk-glk: Fix link training on links with LTTPRs
      drm/i915: Disable LTTPR support when the DPCD rev < 1.4
      drm/i915: Disable LTTPR support when the LTTPR rev < 1.4
      drm/i915: Fix the GT fence revocation runtime PM logic
      drm/i915/dg1: Reserve first 1MB of local memory
      drm/i915: Fix rotation setup during plane HW readout
      drm/i915/selftest: Fix error handling in igt_vma_remapped_gtt()
      drm/i915/selftest: Fix debug message in igt_vma_remapped_gtt()
      drm/i915: Make sure i915_ggtt_view is inited when creating an FB
      drm/i915/selftest: Make sure to init i915_ggtt_view in
igt_vma_rotate_remap()
      drm/i915/intel_fb: Pull FB plane functions from intel_display_types.h
      drm/i915/intel_fb: Pull FB plane functions from skl_universal_plane.c
      drm/i915/intel_fb: Pull is_surface_linear() from
intel_display.c/skl_universal_plane.c
      drm/i915/intel_fb: Pull FB plane functions from intel_sprite.c
      drm/i915/intel_fb: Pull FB plane functions from intel_display.c
      drm/i915/intel_fb: Unexport intel_fb_check_stride()
      drm/i915/intel_fb: s/dev_priv/i915/
      drm/i915/intel_fb: Factor out convert_plane_offset_to_xy()
      drm/i915/intel_fb: Factor out calc_plane_aligned_offset()
      drm/i915/intel_fb: Factor out calc_plane_normal_size()
      drm/i915: Unify the FB and plane state view information into one stru=
ct
      drm/i915: Store the normal view FB pitch in FB's intel_fb_view
      drm/i915: Simplify copying the FB view state to the plane state
      drm/i915/intel_fb: Factor out calc_plane_remap_info()
      drm/i915: Shrink the size of intel_remapped_plane_info struct
      drm/i915/selftest: Unify use of intel_remapped_plane_info in
igt_vma_rotate_remap()
      drm/i915: s/stride/src_stride/ in the intel_remapped_plane_info struc=
t
      drm/i915: Add support for FBs requiring a POT stride alignment
      drm/i915/selftest: Add remap/rotate vma subtests when
dst_stride!=3Dwidth/height
      drm/i915: Fix docbook header for __intel_runtime_pm_get_if_active()

Inki Dae (1):
      Merge tag 'irq-no-autoen-2021-03-25' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into
exynos-drm-next

Jack Zhang (1):
      drm/amd/amdgpu implement tdr advanced mode

Jagan Teki (3):
      drm/stm: ltdc: Use simple encoder
      dt-bindings: display: bridge: Add Chipone ICN6211 bindings
      drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge

Jake Wang (5):
      drm/amd/display: Refactored DC interfaces to support multiple eDP
      drm/amd/display: Added multi instance support for panel control
      drm/amd/display: Bypass sink detect when there are no eDPs connected
      drm/amd/display: Use pwrseq instance to determine eDP instance
      drm/amd/display: Added dc_edp_id_count to dc_context

James Zhu (9):
      drm/amdgpu: add Aldebaran to the VCN family
      drm/amdgpu/vcn2.6: Add vcn2.6 support
      drm/amdgpu/jpeg2.6: Add jpeg2.6 support
      drm/amdgpu/nbio: add aldebaran support
      drm/amdgpu/vcn: enable VCN on aldebaran
      drm/amdgpu/jpeg: enable JPEG on aldebaran
      drm/amdgpu: enable vcn and jpeg on aldebaran
      drm/amdgpu: enable vcn dpg mode on aldebaran
      drm/amdgpu: enable dpg indirect sram mode on aldebaran

Jan Beulich (1):
      drm/xen: adjust Kconfig

Jani Nikula (45):
      drm/i915/bios: tidy up child device debug logging
      Merge tag 'topic/adl-s-enabling-2021-02-01-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next
      Merge tag 'topic/drm-device-pdev-2021-02-02' of
git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next
      drm/dp: add MSO related DPCD registers
      drm/i915/edp: reject modes with dimensions other than fixed mode
      drm/i915/edp: always add fixed mode to probed modes in ->get_modes()
      drm/i915/edp: read sink MSO configuration for eDP 1.4+
      drm/i915/reg: add stream splitter configuration definitions
      drm/i915/mso: add splitter state readout for platforms that support i=
t
      drm/i915/mso: add splitter state check
      drm/i915/edp: modify fixed and downclock modes for MSO
      drm/i915/edp: enable eDP MSO during link training
      Merge drm/drm-next into drm-intel-next
      Merge tag 'gvt-next-2021-03-16' of
https://github.com/intel/gvt-linux into drm-intel-next
      drm/i915: remove unused ADLS_REVID_* macros
      drm/i915/bios: mass convert dev_priv to i915
      drm/i915/bios: store bdb version in i915
      drm/i915/bios: reduce indent in sanitize_ddc_pin and sanitize_aux_ch
      drm/i915/bios: move aux ch and ddc checks at a lower level
      drm/i915/bios: limit default outputs by platform on missing VBT
      drm/i915/bios: limit default outputs to ports A through F
      drm/i915/bios: create fake child devices on missing VBT
      drm/i915/bios: rename display_device_data to intel_bios_encoder_data
      drm/i915/bios: add i915 backpointer to intel_bios_encoder_data
      drm/i915/bios: add helper functions to check output support
      drm/i915/bios: save a higher level pointer in ddi_vbt_port_info[]
      drm/i915/bios: start using the intel_bios_encoder_data directly
      drm/i915/bios: start using intel_bios_encoder_data for Type-C USB and=
 TBT
      drm/i915/bios: add intel_bios_encoder_data to encoder, use for iboost
      drm/i915/dsc: fix DSS CTL register usage for ICL DSI transcoders
      drm/i915: split out stepping info to a new file
      drm/i915: add new helpers for accessing stepping info
      drm/i915: switch KBL to the new stepping scheme
      drm/i915: switch TGL and ADL to the new stepping scheme
      drm/i915: rename DISP_STEPPING->DISPLAY_STEP and GT_STEPPING->GT_STEP
      drm/i915: rename disp_stepping->display_step and gt_stepping->gt_step
      drm/i915: rename i915_rev_steppings->intel_step_info
      drm/edid: make a number of functions, parameters and variables const
      drm/displayid: add separate drm_displayid.c
      drm/displayid: add new displayid section/block iterators
      drm/edid: use the new displayid iterator for detailed modes
      drm/edid: use the new displayid iterator for finding CEA extension
      drm/edid: use the new displayid iterator for tile info
      drm/displayid: allow data blocks with 0 payload length
      drm/displayid: rename displayid_hdr to displayid_header

Jared Baldridge (1):
      drm: Added orientation quirk for OneGX1 Pro

Jason Ekstrand (2):
      drm/i915/gem: Drop legacy execbuffer support (v2)
      drm/i915/gem: Drop relocation support on all new hardware (v6)

Jay Cornwall (2):
      drm/amdkfd: Move set_trap_handler out of dqm->ops
      drm/amdkfd: Add aldebaran trap handler support

Jia-Ju Bai (1):
      drm/amdgpu/swsmu: fix error return code of smu_v11_0_set_allowed_mask=
()

Jianhui Zhao (1):
      docs: gpu: fix typo

Jiapeng Chong (14):
      drm/amdgpu/swsmu/navi1x: Remove unnecessary conversion to bool
      drm/amd/display/dc/core/dc_link_ddc: Remove unnecessary conversion to=
 bool
      drm/amdgpu/sdma5.2: Remove unnecessary conversion to bool
      drm/amdgpu: Remove unnecessary conversion to bool
      drm/amd/display: remove unnecessary conversion to bool
      drm/amd/pm/swsmu: Remove unnecessary conversion to bool
      drm/amd/display/dc/dce/dmub_psr: Remove unnecessary conversion to boo=
l
      drm/amd/display: Remove unnecessary conversion to bool
      drm/amdgpu: Remove unnecessary conversion to bool
      drm/amdgpu/display: Remove unnecessary conversion to bool
      drm/amd/display: Remove unnecessary conversion to bool
      drm/amd/display: Remove unnecessary conversion to bool
      drm/amd/display: Remove unnecessary conversion to bool
      drm: bridge: convert sysfs sprintf/snprintf family to sysfs_emit

Jimmy Kizito (3):
      drm/amd/display: Update link encoder object creation
      drm/amd/display: Add dynamic link encoder selection.
      drm/amd/display: Update display endpoint control path.

Jingwen Chen (2):
      drm/amd/amdgpu: move inc gpu_reset_counter after drm_sched_stop
      drm/amd/amdgpu: add fini virt data exchange to ip_suspend

Jinzhou Su (1):
      drm/amdgpu: update secure display TA header

Jitao Shi (3):
      drm/mediatek: dsi: Use symbolized register definition
      drm/mediatek: dsi: Fine tune the line time caused by EOTp
      dt-bindings: mediatek,dpi: add mt8192 to mediatek,dpi

Joe Perches (1):
      dma-buf: Avoid comma separated statements

Joel Stanley (2):
      drm/aspeed: Look up syscon by phandle
      drm/aspeed: Use dt matching for default register values

John Clements (10):
      drm/amdgpu: disable mec2 fw bin loading
      drm/amdgpu: updated host to psp mailbox cmd (v2)
      drm/amdgpu: added register list driver ctx (v2)
      drm/amdgpu: added support for register list loading (v2)
      drm/amdgpu: update host to psp interface
      drm/amdgpu: added support for dynamic GECC
      drm/amdgpu: add ras aldebaran ras eeprom driver
      drm/amdgpu: RAS harvest on driver load
      drm/amdgpu: enable ras eeprom on aldebaran
      drm/amdgpu: page retire over debugfs mechanism

John Stultz (4):
      dma-buf: system_heap: Make sure to return an error if we abort
      dma-buf: heaps: Rework heap allocation hooks to return struct
dma_buf instead of fd
      dma-buf: dma-heap: Provide accessor to get heap name
      dma-buf: heaps: Fix the name used when exporting dmabufs to be
the actual heap name

Jonathan Kim (5):
      drm/amdgpu: add missing df counter disable write
      drm/amdgpu: mask the xgmi number of hops reported from psp to kfd
      drm/amdkfd: add aldebaran kfd2kgd callbacks to kfd device (v2)
      drm/amdgpu: restore aldebaran save ttmp and trap config on init (v2)
      drm/amdgpu: add ih waiter on process until checkpoint

Jonathan Marek (1):
      drm/msm: add compatibles for sm8150/sm8250 display

Joseph Schulte (1):
      drm: replace drm_modeset_lock_all() in drm_client_modeset_dpms_legacy=
()

Joshua Aberback (2):
      drm/amd/display: Align cursor cache address to 2KB
      drm/amd/display: Update DCN302 SR Exit Latency

Jos=C3=A9 Roberto de Souza (9):
      drm/i915/display: Add HAS_D12_PLANE_MINIMIZATION
      drm/i915: Make psr_safest_params and enable_psr2_sel_fetch
parameters read only
      drm/i915/display: Add DDR5 and LPDDR5 BW buddy page entries
      drm/i915: Remove dead code from skl_pipe_wm_get_hw_state()
      drm/i915/display: Allow PSR2 selective fetch to be enabled at run-tim=
e
      drm/i915/display: Rename for_each_intel_encoder.*_can_psr to
for_each_intel_encoder.*_with_psr
      drm/i915/display: Only write to register in
intel_psr2_program_trans_man_trk_ctl()
      drm/i915/display: Remove some redundancy around CAN_PSR()
      drm/i915/display: Set source_support even if panel do not support PSR

Jude Shih (1):
      drm/amdgpu: add DMUB outbox event IRQ source define/complete/debug fl=
ag

Julia Lawall (1):
      drm: use getter/setter functions

Julian Braha (1):
      drivers: gpu: drm: bridge: fix kconfig dependency on DRM_KMS_HELPER

Jun Lei (1):
      drm/amd/display: Increase precision for bpp in DSC calculations

Juston Li (1):
      drm/i915/hdcp: disable the QSES check for HDCP2.2 over MST

Kai Vehmanen (1):
      drm/i915/audio: set HDA link parameters in driver

Kai-Heng Feng (1):
      efifb: Ensure graphics device for efifb stays at PCI D0

Kalyan Thota (2):
      drm/msm/disp/dpu1: turn off vblank irqs aggressively in dpu driver
      drm/msm/disp/dpu1: fix display underruns during modeset.

Kenneth Feng (4):
      drm/amd/pm: add new data in metrics table
      drm/amd/pm: bug fix for pcie dpm
      drm/amd/pm: workaround for audio noise issue
      drm/amd/pm: fix workload mismatch on vega10

Kevin Wang (16):
      drm/amdgpu: add RAP TA version print in amdgpu_firmware_info
      drm/amdgpu: correct TA RAP firmware information print error
      drm/amdgpu: refine PSP TA firmware info print in debugfs
      drm/amdgpu: add SECURE DISPLAY TA firmware info in debugfs
      drm/amdgpu: fix parameter error of RREG32_PCIE() in amdgpu_regs_pcie
      drm/amdgpu: add aldebaran sdma firmware support (v2)
      drm/amdgpu: switch to use reg distance member for mmhub v1_7
      drm/amd/swsmu: add aldebaran smu driver if header (v2)
      drm/amd/swsmu: add aldebaran smu13 ip support (v3)
      drm/amdgpu: declare sdma firmware binary file for aldebaran
      drm/amd/pm: remove aldebaran serial number support
      drm/amdgpu: add gc powerbrake support (v2)
      drm/amd/pm: add aldebaran serial number support
      drm/amdgpu: change psp_rap_invoke() function return value
      drm/amdgpu: add psp RAP L0 check support
      Revert "drm/amdgpu: add psp RAP L0 check support"

Krishna Manikandan (7):
      drm/msm/disp/dpu1: add support for display for SC7280 target
      drm/msm/disp/dpu1: add intf offsets for SC7280 target
      drm/msm/disp/dpu1: add support to program fetch active in ctl path
      drm/msm/disp/dpu1: enable DATA_HCTL_EN for sc7280 target
      drm/msm/disp/dpu1: increase the range of interrupts in dpu_irq_map
      drm/msm/disp/dpu1: add vsync and underrun irqs for INTF_5
      drm/msm/disp/dpu1: add flags to indicate obsolete irqs

Krunoslav Kovac (1):
      drm/amd/display: Rename fs_params to hdr_tm_params

Laurent Morichetti (1):
      drm/amdkfd: Fix saving the ACC vgprs for Aldebaran

Laurent Pinchart (9):
      dt-bindings: display: mxsfb: Convert binding to YAML
      dt-bindings: display: mxsfb: Add and fix compatible strings
      dt-bindings: display: renesas,du: Convert binding to YAML
      dt-bindings: display: bridge: Add YAML schema for Synopsys DW-HDMI
      dt-bindings: display: bridge: renesas,dw-hdmi: Convert binding to YAM=
L
      dt-bindings: display: imx: hdmi: Convert binding to YAML
      dt-bindings: display: rockchip: dw-hdmi: Convert binding to YAML
      dt-bindings: display: sun8i-a83t-dw-hdmi: Reference dw-hdmi YAML sche=
ma
      dt-bindings: display: bridge: Remove deprecated dw_hdmi.txt

Lauri Kasanen (1):
      video: fbdev: simplefb: Add "r5g5b5a1" mode

Le Ma (11):
      drm/amdgpu: add aldebaran asic type
      drm/amdgpu: add register base init for aldebaran (v2)
      drm/amdgpu: add gpu_info fw parse support for aldebaran
      drm/amdgpu: add soc15 common ip block support for aldebaran
      drm/amdgpu: add mmhub support for aldebaran (v3)
      drm/amdgpu: add gmc v9 block support for Aldebaran
      drm/amdgpu: set fw load type for aldebaran
      drm/amdgpu: add gfx v9 block support for aldebaran
      drm/amdgpu: add sdma block support for aldebaran
      drm/amdgpu: correct mmBIF_SDMA4_DOORBELL_RANGE address for aldebaran
      drm/amdgpu: set ip blocks for aldebaran

Lee Jones (35):
      drm/vmwgfx/vmwgfx_execbuf: Fix some kernel-doc related issues
      drm/vmwgfx/vmwgfx_kms: Remove unused variable 'ret' from
'vmw_du_primary_plane_atomic_check()'
      drm/vmwgfx/vmwgfx_kms: Mark vmw_{cursor,primary}_plane_formats
as __maybe_unused
      drm/vmwgfx/vmwgfx_drv: Fix some kernel-doc misdemeanours
      drm/vmwgfx/vmwgfx_ioctl: Provide missing '@' sign required by kernel-=
doc
      drm/vmwgfx/vmwgfx_resource: Fix worthy function headers demote some o=
thers
      drm/vmwgfx/vmwgfx_ttm_buffer: Supply some missing parameter descripti=
ons
      drm/vmwgfx/vmwgfx_fifo: Demote non-conformant kernel-doc header
      drm/vmwgfx/vmwgfx_ldu: Supply descriptions for 'state' function param=
eter
      drm/vmwgfx/vmwgfx_kms: Update worthy function headers and demote othe=
rs
      drm/vmwgfx/vmwgfx_overlay: Demote kernel-doc abuses to standard
comment blocks
      drm/vmwgfx/vmwgfx_fence: Add, remove and demote various
documentation params/headers
      drm/vmwgfx/vmwgfx_bo: Remove superfluous param description and
supply another
      drm/vmwgfx/vmwgfx_context: Demote kernel-doc abuses
      drm/vmwgfx/vmwgfx_scrn: Demote unworthy kernel-doc headers and
update others
      drm/vmwgfx/vmwgfx_surface: Fix some kernel-doc related issues
      drm/vmwgfx/vmwgfx_cmdbuf_res: Rename param description and remove ano=
ther
      drm/vmwgfx/vmwgfx_shader: Demote kernel-doc abuses and fix-up
worthy headers
      drm/vmwgfx/vmwgfx_cmdbuf: Fix a bunch of missing or incorrectly
formatted/named params
      drm/vmwgfx/vmwgfx_cmdbuf_res: Remove unused variable 'ret'
      drm/vmwgfx/vmwgfx_stdu: Add some missing param/member descriptions
      drm/vmwgfx/vmwgfx_cmdbuf: Fix misnaming of 'headers' should be plural
      drm/vmwgfx/vmwgfx_cotable: Fix a couple of simple documentation probl=
ems
      drm/vmwgfx/vmwgfx_so: Add description for 'vmw_view's 'rcu' member
      drm/vmwgfx/vmwgfx_binding: Provide some missing param
descriptions and remove others
      drm/vmwgfx/vmwgfx_msg: Fix misspelling of 'msg'
      drm/vmwgfx/vmwgfx_blit: Add description for 'vmw_bo_cpu_blit's
'diff' param
      drm/vmwgfx/vmwgfx_validation: Add some missing struct
member/function param descriptions
      drm/vmwgfx/ttm_object: Demote half-assed headers and fix-up another
      drm/vmwgfx/vmwgfx_thp: Add description for 'vmw_thp_manager's
member 'manager'
      drm/vmwgfx/ttm_object: Reorder header to immediately precede its stru=
ct
      drm/amd/display/dc/dce/dce_aux: Remove duplicate line causing
'field overwritten' issue
      drm/amd/display/dc/dce80/dce80_resource: Make local functions static
      drm/amd/display/dc/calcs/dce_calcs: Move some large variables
from the stack to the heap
      drm/amd/display/dc/calcs/dce_calcs: Remove some large variables
from the stack

Lee Shawn C (1):
      drm/i915/vbt: update DP max link rate table

Leo (Hanghong) Ma (5):
      drm/amdgpu: add DMUB trace event IRQ source define
      drm/amd/display: Fix typo for helpers function name
      drm/amd/display: Add debugfs to control DMUB trace buffer events
      drm/amd/display: Log DMCUB trace buffer events
      drm/amd/display: Fix static checker warnings on tracebuff_fb

Leo Li (1):
      drm/amd/display: Move vupdate keepout programming from DCN20 to DCN10

Lewis Huang (1):
      drm/amd/display: remove global optimize seamless boot stream count

Liam Howlett (1):
      i915_vma: Rename vma_lookup to i915_vma_lookup

Lijo Lazar (35):
      drm/amd/pm: Add atom_smc_dpm_info_v4_10 for aldebaran
      drm/amd/amdgpu: Add smu_pptable module parameter
      drm/amd/pm: Add support to override pptable id for aldebaran
      drm/amd/pm: Remove CPU virtual address notification in aldebaran
      drm/amd/pm: Set no fan control flag as needed.
      drm/amdgpu: Enable swsmu block on aldebaran
      drm/amdgpu: Add clock gating support for aldebaran
      drm/amdgpu/pm: Remove unsupported MP1 messages from aldebaran
      drm/amdgpu/pm: Fix reset message mapping on aldebaran
      drm/amdgpu/pm: Remove redundant generic message index
      drm/amdgpu: Enable CP idle interrupts
      drm/amdgpu: Fix aldebaran MMHUB CG/LS logic
      drm/amd/pm: Fix power limit query on aldebaran
      drm/amd/pm: Add DCBTC support for aldebaran
      drm/amd/pm: Enable performance determinism on aldebaran
      drm/amd/pm: Correct msg status check for powerlimit
      drm/amd/pm: Enable user min/max gfxclk on aldebaran
      drm/amd/pm: Enable pp_od_clk_voltage node on aldebaran
      drm/amd/pm: Remove min/max overload of pp_dpm_sclk
      drm/amdgpu: Check if FB BAR is enabled for ROM read
      drm/amdgpu: Free PDB0 bo before bo_fini
      drm/amdgpu: Enable VCN/JPEG CG on aldebaran
      drm/amd/pm: Update aldebaran pmfw interface
      drm/amd/pm: Modify mode2 msg sequence on aldebaran
      drm/amd/pm: Add function to wait for smu events
      drm/amd/pm: Add support for reset completion on aldebaran
      drm/amdgpu: Add reset control to amdgpu_device
      drm/amdgpu: Add reset control handling to reset workflow
      drm/amdgpu: Add PSP public function to load a list of FWs
      drm/amdgpu: Make set PG/CG state functions public
      drm/amdgpu: Add mode2 reset support for aldebaran
      drm/amdgpu: Enable recovery on aldebaran
      drm/amdgpu: Fix build warnings
      drm/amd/pm: Fix DPM level count on aldebaran
      drm/amdgpu: Reset error code for 'no handler' case

Linus Walleij (1):
      drm/mcde/panel: Inverse misunderstood flag

Lionel Landwerlin (1):
      drm: fix drm_mode_create_blob comment

Luben Tuikov (3):
      drm/scheduler: Job timeout handler returns status (v3)
      drm/amd/display: Use appropriate DRM_DEBUG_... level
      drm/amdgpu: Fix check for RAS support

Lucas De Marchi (6):
      drm/i915/adl_s: Add power wells
      drm/i915/display: fix comment on skl straps
      drm/i915: stop registering if drm_dev_register() fails
      drm/i915: group display-related register calls
      drm/i915/display: move register functions to display/
      drm/i915: move intel_init_audio_hooks inside display

Lukasz Luba (2):
      drm/panfrost: Add governor data with pre-defined thresholds
      drm/lima: Use delayed timer as default in devfreq profile

Lyude Paul (18):
      drm/i915/gen9_bc: Recognize TGP PCH + CML combos
      drm/i915/gen9_bc: Introduce TGP PCH DDC pin mappings
      drm/i915/gen9_bc: Introduce HPD pin mappings for TGP PCH + CML combos
      drm/i915/gen9_bc: Add W/A for missing STRAP config on TGP PCH + CML c=
ombos
      drm/i915/icp+: Use icp_hpd_irq_setup() instead of spt_hpd_irq_setup()
      drm/bridge/tc358767: Don't register DP AUX channel until bridge
is attached
      drm/bridge/ti-sn65dsi86: (Un)register aux device on bridge attach/det=
ach
      drm/bridge/analogix/anx78xx: Add missing drm_dp_aux_unregister() call
      drm/bridge/analogix/anx78xx: Setup encoder before registering connect=
or
      drm/bridge/analogix/anx78xx: Cleanup on error in anx78xx_bridge_attac=
h()
      drm/bridge/analogix/anx6345: Add missing drm_dp_aux_unregister() call
      drm/bridge/analogix/anx6345: Don't link encoder until after
connector registration
      drm/bridge/analogix/anx6345: Cleanup on errors in anx6345_bridge_atta=
ch()
      drm/bridge/analogix/dp_core: Unregister DP AUX channel on error
in analogix_dp_probe()
      drm/dp: Fixup kernel docs for struct drm_dp_aux
      drm/tegra: Don't register DP AUX channels before connectors
      drm/print: Fixup DRM_DEBUG_KMS_RATELIMITED()
      drm/dp_mst: Drop DRM_ERROR() on kzalloc() fail in
drm_dp_mst_handle_up_req()

Maarten Lankhorst (62):
      drm/i915: Do not share hwsp across contexts any more, v8.
      drm/i915: Pin timeline map after first timeline pin, v4.
      drm/i915: Move cmd parser pinning to execbuffer
      drm/i915: Add missing -EDEADLK handling to execbuf pinning, v2.
      drm/i915: Ensure we hold the object mutex in pin correctly.
      drm/i915: Add gem object locking to madvise.
      drm/i915: Move HAS_STRUCT_PAGE to obj->flags
      drm/i915: Rework struct phys attachment handling
      drm/i915: Convert i915_gem_object_attach_phys() to ww locking, v2.
      drm/i915: make lockdep slightly happier about execbuf.
      drm/i915: Disable userptr pread/pwrite support.
      drm/i915: No longer allow exporting userptr through dma-buf
      drm/i915: Reject more ioctls for userptr, v2.
      drm/i915: Reject UNSYNCHRONIZED for userptr, v2.
      drm/i915: Make compilation of userptr code depend on MMU_NOTIFIER.
      drm/i915: Fix userptr so we do not have to worry about obj->mm.lock, =
v7.
      drm/i915: Flatten obj->mm.lock
      drm/i915: Populate logical context during first pin.
      drm/i915: Make ring submission compatible with obj->mm.lock removal, =
v2.
      drm/i915: Handle ww locking in init_status_page
      drm/i915: Rework clflush to work correctly without obj->mm.lock.
      drm/i915: Pass ww ctx to intel_pin_to_display_plane
      drm/i915: Add object locking to vm_fault_cpu
      drm/i915: Move pinning to inside engine_wa_list_verify()
      drm/i915: Take reservation lock around i915_vma_pin.
      drm/i915: Make lrc_init_wa_ctx compatible with ww locking, v3.
      drm/i915: Make __engine_unpark() compatible with ww locking.
      drm/i915: Take obj lock around set_domain ioctl
      drm/i915: Defer pin calls in buffer pool until first use by caller.
      drm/i915: Fix pread/pwrite to work with new locking rules.
      drm/i915: Fix workarounds selftest, part 1
      drm/i915: Add igt_spinner_pin() to allow for ww locking around spinne=
r.
      drm/i915: Add ww locking around vm_access()
      drm/i915: Increase ww locking for perf.
      drm/i915: Lock ww in ucode objects correctly
      drm/i915: Add ww locking to dma-buf ops, v2.
      drm/i915: Add missing ww lock in intel_dsb_prepare.
      drm/i915: Fix ww locking in shmem_create_from_object
      drm/i915: Use a single page table lock for each gtt.
      drm/i915/selftests: Prepare huge_pages testcases for obj->mm.lock rem=
oval.
      drm/i915/selftests: Prepare client blit for obj->mm.lock removal.
      drm/i915/selftests: Prepare coherency tests for obj->mm.lock removal.
      drm/i915/selftests: Prepare context tests for obj->mm.lock removal.
      drm/i915/selftests: Prepare dma-buf tests for obj->mm.lock removal.
      drm/i915/selftests: Prepare execbuf tests for obj->mm.lock removal.
      drm/i915/selftests: Prepare mman testcases for obj->mm.lock removal.
      drm/i915/selftests: Prepare object tests for obj->mm.lock removal.
      drm/i915/selftests: Prepare object blit tests for obj->mm.lock remova=
l.
      drm/i915/selftests: Prepare igt_gem_utils for obj->mm.lock removal
      drm/i915/selftests: Prepare context selftest for obj->mm.lock removal
      drm/i915/selftests: Prepare hangcheck for obj->mm.lock removal
      drm/i915/selftests: Prepare execlists and lrc selftests for
obj->mm.lock removal
      drm/i915/selftests: Prepare mocs tests for obj->mm.lock removal
      drm/i915/selftests: Prepare ring submission for obj->mm.lock removal
      drm/i915/selftests: Prepare timeline tests for obj->mm.lock removal
      drm/i915/selftests: Prepare i915_request tests for obj->mm.lock remov=
al
      drm/i915/selftests: Prepare memory region tests for obj->mm.lock remo=
val
      drm/i915/selftests: Prepare cs engine tests for obj->mm.lock removal
      drm/i915/selftests: Prepare gtt tests for obj->mm.lock removal
      drm/i915: Finally remove obj->mm.lock.
      drm/i915: Keep userpointer bindings if seqcount is unchanged, v2.
      drm/i915: Move gt_revoke() slightly

Marek Vasut (2):
      dt-bindings: display: mxsfb: Add compatible for i.MX8MM
      drm/stm: Fix bus_flags handling

Marijn Suijten (2):
      drm/msm/mdp5: Configure PP_SYNC_HEIGHT to double the vtotal
      drm/msm/mdp5: Do not multiply vclk line count by 100

Mario Kleiner (2):
      drm: Fix HDMI_STATIC_METADATA_TYPE1 constant
      drm/amd/display: Allow spatial dither to 10 bpc on all DCE

Mark Yacoub (2):
      drm/amdgpu: Verify bo size can fit framebuffer size on init.
      drm/amdgpu: Ensure that the modifier requested is supported by plane.

Martin Leung (3):
      drm/amd/display: changing sr exit latency
      drm/amd/display: Skip powerstate DC hw access if virtual dal
      drm/amd/display: Fix typo when retrieving dppclk from UEFI config

Matt Roper (11):
      drm/i915/adl_s: Update combo PHY master/slave relationships
      drm/i915/adl_s: Update PHY_MISC programming
      drm/i915/adl_s: Re-use TGL GuC/HuC firmware
      drm/i915: FPGA_DBG is display-specific
      drm/i915: Try to detect sudden loss of MMIO access
      drm/i915/display: Convert gen5/gen6 tests to IS_IRONLAKE/IS_SANDYBRID=
GE
      drm/i915: Add DISPLAY_VER() and related macros
      drm/i915/display: Eliminate most usage of INTEL_GEN()
      drm/i915: Convert INTEL_GEN() to DISPLAY_VER() as appropriate in
intel_pm.c
      drm/i915: Convert INTEL_GEN() to DISPLAY_VER() as appropriate in
i915_irq.c
      drm/i915/display: Simplify GLK display version tests

Matthew Auld (11):
      drm/i915/gem: don't trust the dma_buf->size
      drm/i915/gem: consolidate 2big error checking for object sizes
      drm/i915/buddy: document the unused header bits
      drm/i915: make local-memory probing a GT operation
      drm/i915: setup the LMEM region
      drm/i915: allocate context from LMEM
      drm/i915: move engine scratch to LMEM
      drm/i915/gtt/dg1: add PTE_LM plumbing for ppGTT
      drm/i915/gtt/dg1: add PTE_LM plumbing for GGTT
      drm/i915: cleanup the region class/instance encoding
      drm/i915: give stolen system memory its own class

Matthew Wilcox (Oracle) (1):
      fb_defio: Remove custom address_space_operations

Max.Tseng (1):
      drm/amd/display: Add flag for building infopacket

Maxime Ripard (21):
      drm: Introduce a drm_crtc_commit_wait helper
      drm/vc4: hdmi: Compute the CEC clock divider from the clock rate
      drm/vc4: hdmi: Update the CEC clock divider on HSM rate change
      drm/vc4: hdmi: Introduce a CEC clock
      drm/vc4: hdmi: Split the interrupt handlers
      drm/vc4: hdmi: Support BCM2711 CEC interrupt setup
      drm/vc4: hdmi: Don't register the CEC adapter if there's no interrupt=
s
      dt-binding: display: bcm2711-hdmi: Add CEC and hotplug interrupts
      drm/atomic: Pass the full state to planes async atomic check and upda=
te
      drm: Rename plane atomic_check state names
      drm/atmel-hlcdc: Rename custom plane state variable
      drm/atomic: Pass the full state to planes atomic_check
      drm: Use the state pointer directly in planes atomic_check
      drm: Use state helper instead of plane state pointer in atomic_check
      drm: Store new plane state in a variable for atomic_update and disabl=
e
      drm: Rename plane->state variables in atomic update and disable
      drm/atomic: Pass the full state to planes atomic disable and update
      drm: Use state helper instead of the plane state pointer
      drm/todo: Remove the drm_atomic_state todo item
      Merge drm/drm-next into drm-misc-next
      drm/rockchip: Remove unused variable

Meenakshikumar Somasundaram (2):
      drm/amd/display: Support for DMUB AUX
      drm/amd/display: Fix for outbox1 ring buffer typecasting issue

Menglong Dong (1):
      drm/omap: dsi: fix unreachable code in dsi_vc_send_short()

Michel Thierry (1):
      drm/i915: allocate cmd ring in lmem

Mikita Lipski (4):
      drm/amd/display: Set initial value to a divider
      drm/amd/display: Directly retrain link from debugfs
      drm/amd/display: Add MST capability to trigger_hotplug interface
      drm/amd/display: Determine synchronization edge based on master's vsy=
nc

Nathan Chancellor (2):
      drm/i915: Enable -Wuninitialized
      drm/amd/pm/swsmu: Avoid using structure_size uninitialized in
smu_cmn_init_soft_gpu_metrics

Nicholas Kazlauskas (3):
      drm/amd/display: Add dc_dmub_srv helpers for in/out DMCUB commands
      drm/amd/display: Fix MPC OGAM power on/off sequence
      drm/amd/display: Cleanup DML DSC input bpc validation

Nikola Cornij (3):
      drm/amd/display: Add debug out when viewport too small
      drm/amdgpu/display: re-enable freesync video patches
      drm/amd/display: Fix black screen with scaled modes on some eDP panel=
s

Nirmoy Das (20):
      drm/amdgpu: do not keep debugfs dentry
      drm/radeon: cleanup debugfs
      drm/amdgpu: remove CONFIG_DRM_AMDGPU_GART_DEBUGFS
      drm/amd/display: do not use drm middle layer for debugfs
      drm/amd/pm: do not use drm middle layer for debugfs
      drm/amdgpu: do not use drm middle layer for debugfs
      drm/radeon: add rdev in ring struct
      drm/radeon: do not use drm middle layer for debugfs (v2)
      drm/amdgpu: mark local function as static
      drm/amdgpu: remove unused variable from struct amdgpu_bo
      drm/amdgpu: fb BO should be ttm_bo_type_device
      drm/amdgpu: wrap kiq ring ops with kiq spinlock
      drm/amd/display: use GFP_ATOMIC in dcn20_resource_construct
      drm/amdgpu: fix amdgpu_res_first()
      drm/amdgpu: allow variable BO struct creation
      drm/amdgpu: introduce struct amdgpu_bo_user
      drm/amdgpu: use amdgpu_bo_create_user() for when possible
      drm/amdgpu: use amdgpu_bo_user bo for metadata and tiling flag
      drm/amdgpu: make BO type check less restrictive
      drm/amdgpu: fix offset calculation in amdgpu_vm_bo_clear_mappings()

Noralf Tr=C3=B8nnes (4):
      drm/shmem-helpers: vunmap: Don't put pages for dma-buf
      drm/uapi: Add USB connector type
      drm/probe-helper: Check epoch counter in output_poll_execute()
      drm: Add GUD USB Display driver

Oak Zeng (23):
      drm/amdgpu: Fix IH client ID naming table
      drm/amdgpu: Clean up mmhub functions for aldebaran
      drm/amdgpu: pre-map device buffer as cached for A+A config
      drm/amdgpu: Don't do FB resize under A+A config
      drm/amdgpu: Use free system memory size for kfd memory accounting
      drm/amdgpu: Don't reserve vram as WC for A+A
      drm/amdgpu: Use physical translation mode to access page table
      drm/amdgpu: Moved gart_size calculation to mc_init functions
      drm/amdgpu: Modify comments of vram_start/end
      drm/amdgpu: Placement of gart and vram in sysvm aperture
      drm/amdgpu: Use different gart table parameters for 2-level gart tabl=
e
      drm/amdgpu: Add function to allocate and fill PDB0
      drm/amdgpu: Set up vmid0 PDB0
      drm/amdgpu: HW setup of 2-level vmid0 page table
      drm/amdgpu: workaround the TMR MC address issue (v2)
      drm/amdgpu: Fix GART page table s-bit
      drm/amdgpu: Fix the comment in amdgpu_gmc.h
      drm/amdkfd: Add kernel parameter to stop queue eviction on vm fault
      drm/amdkfd: Check HIQ's MQD for queue preemption status
      drm/amdgpu: Increase PSP runtime TMR region size
      drm/amdgpu: fix compile error on architecture s390 (v2)
      drm/amdgpu: fix a few compiler warnings
      drm/ttm: ioremap buffer according to TTM mem caching setting

Patrik Jakobsson (6):
      drm/gma500/cdv: Remove unused code for crt init
      drm/gma500: Remove unused DPST support
      drm/gma500/cdv: Remove unused tv out paths
      drm/gma500: Unify crtc helpers
      drm/gma500: psb_spank() doesn't need it's own file
      drm/gma500: Never wait for blits

Paul Cercueil (4):
      drm/ingenic: Fix non-OSD mode
      drm: bridge/panel: Cleanup connector on bridge detach
      drm/encoder: Add macro drmm_plain_encoder_alloc()
      drm/ingenic: Register devm action to cleanup encoders

Peng Ju Zhou (4):
      drm/amdgpu: indirect register access for nv12 sriov
      drm/amdgpu: indirect register access for nv12 sriov
      drm/amdgpu: indirect register access for nv12 sriov
      drm/amdgpu: indirect register access for nv12 sriov

Peter Robinson (1):
      video: fbdev: simplefb: Fix info message during probe

Philip Cox (1):
      drm/amdgpu: Set amdgpu.noretry=3D1 for Arcturus

Philip Yang (2):
      drm/amdgpu: enable retry fault wptr overflow
      drm/amdgpu: reserve fence slot to update page table

Po-Ting Chen (1):
      drm/amd/display: Change ABM sample rate

Pratik Vishwakarma (1):
      drm/amdgpu: skip CG/PG for gfx during S0ix

Prike Liang (2):
      drm/amdgpu: fix shutdown and poweroff process failed with s0ix
      drm/amdgpu: fix the hibernation suspend with s0ix

Qinglang Miao (1):
      drm/lima: fix reference leak in lima_pm_busy

Qingqing Zhuo (9):
      drm/amd/display: Fix system hang after multiple hotplugs (v3)
      drm/amd/display: Enable pflip interrupt upon pipe enable
      drm/amd/display: Fix warning
      drm/amd/display: Remove unused defines
      drm/amd/display: Fix potential memory leak
      drm/amd/display: enable DP DSC Compliance automation
      drm/amd/display: add log for automated test
      drm/amd/display: Add missing mask for DCN3
      Revert "drm/amdgpu: Ensure that the modifier requested is
supported by plane."

Qu Huang (2):
      drm/amdkfd: Fix cat debugfs hang_hws file causes system crash bug
      drm/amdkfd: dqm fence memory corruption

Quanyang Wang (1):
      drm/tilcdc: send vblank event when disabling crtc

Rajneesh Bhardwaj (4):
      drm/amdgpu: enable xgmi support for Aldebaran
      drm/amdgpu: define address map for host xgmi link (v3)
      drm/amdgpu: support get xgmi information for Aldebaran
      drm/amdkfd: expose host gpu link via sysfs (v2)

Ramesh Errabolu (1):
      drm/amdgpu: Remove amdgpu_device arg from free_sgt api (v2)

Randy Dunlap (2):
      drm: bridge: fix ANX7625 use of mipi_dsi_() functions
      drm: bridge: fix LONTIUM use of mipi_dsi_() functions

Rex-BC Chen (2):
      drm/mediatek: dpi: Add check for max clock rate in mode_valid
      drm/mediatek: dpi: Add config for mt8192

Rikard Falkeborn (3):
      drm/amdgpu/ttm: constify static vm_operations_struct
      drm/radeon/ttm: constify static vm_operations_struct
      drm/nouveau/ttm: constify static vm_operations_struct

Rob Clark (16):
      Merge tag 'drm-msm-fixes-2021-04-02' into msm-next
      drm/msm: Remove unused freed llist node
      drm/msm: Avoid mutex in shrinker_count()
      drm/msm: Fix debugfs deadlock
      drm/msm: Improved debugfs gem stats
      drm/msm: Drop mm_lock in scan loop
      drm/msm: Fix spelling "purgable" -> "purgeable"
      drm/msm: Add param for userspace to query suspend count
      drm/msm: ratelimit GEM related WARN_ON()s
      drm/msm: Reorganize msm_gem_shrinker_scan()
      drm/msm: Clear msm_obj->sgt in put_pages()
      drm/msm: Split iova purge and close
      drm/msm: Add $debugfs/gem stats on resident objects
      drm/msm: Track potentially evictable objects
      drm/msm: Small msm_gem_purge() fix
      drm/msm: Support evicting GEM objects to swap

Rob Herring (1):
      dt-bindings: display: mediatek, dpi: Convert to use graph schema

Robert Foss (2):
      MAINTAINERS: Update Maintainers of DRM Bridge Drivers
      drm/bridge: lt9611: Fix handling of 4k panels

Robin Singh (1):
      drm/amd/display: add NULL check to avoid kernel crash in DC.

Rodrigo Siqueira (2):
      drm/amd/display: Add vupdate_no_lock interrupts for DCN2.1
      drm/amd/display: Add refresh rate trace

Rohit Khaire (1):
      drm/amdgpu: Add new PF2VF flags for VF register access method

Roland Scheidegger (1):
      drm/vmwgfx: add some 16:9 / 16:10 default resolutions

Roman Li (1):
      drm/amd/display: Populate socclk entries for dcn2.1

Roman Stratiienko (2):
      drm/sun4i: Add alpha property for sun8i UI layer
      drm/sun4i: Add alpha property for sun8i and sun50i VI layer

Sakari Ailus (3):
      lib/vsprintf: Add support for printing V4L2 and DRM fourccs
      v4l: ioctl: Use %p4cc printk modifier to print FourCC codes
      drm: Switch to %p4cc format modifier

Sean Paul (2):
      drm/i915/dp_link_training: Add newlines to debug messages
      drm/i915/dp_link_training: Convert DRM_DEBUG_KMS to drm_dbg_kms

Sebastian Andrzej Siewior (5):
      drm/gma500: Remove in_atomic() usage.
      video: fbdev: amba-clcd: Always use msleep() for waiting
      drm/amdgpu: Replace in_interrupt() usage in gmc_v*_process_interrupt(=
)
      drm/amdgpu: Remove in_interrupt() usage in gfx_v9_0_kiq_read_clock()
      drm/amdgpu: Replace in_task() in gfx_v8_0_parse_sq_irq()

Sefa Eyeoglu (1):
      drm/amd/display: check fb of primary plane

Shaokun Zhang (1):
      drm/amd/display: Fix the Wunused-function warning

Shashank Sharma (2):
      drm/amdgpu: clean-up unused variable
      drm/amdgpu: Set GTT_USWC flag to enable freesync v2

Shirish S (2):
      amdgpu/pm: read_sensor() report failure apporpriately
      drm/amdgpu/powerplay/smu10: refactor AMDGPU_PP_SENSOR_GPU_LOAD

Simon Ser (3):
      drm/doc: fix drm_plane_type docs
      drm/doc: document the type plane property
      drm/uapi: document kernel capabilities

Sonny Jiang (1):
      drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share memory

Souptick Joarder (1):
      drm/amdgpu/display: initialize the variable 'i'

Stanley.Yang (2):
      drm/amdgpu: fix send ras disable cmd when asic not support ras
      drm/amdgpu: support sdma error injection

Stylon Wang (4):
      drm/amd/display: Add Freesync HDMI support to DM
      drm/amd/display: Refactor debugfs entries for all connectors
      drm/amd/display: Enable ASSR in DM
      drm/amd/display: Guard ASSR with internal display flag

Sung Lee (3):
      drm/amd/display: Populate dcn2.1 bounding box before state duplicatio=
n
      drm/amd/display: Copy over soc values before bounding box creation
      drm/amd/display: Revert dram_clock_change_latency for DCN2.1

Takashi Iwai (1):
      drm/amd/display: Add a backlight module option

Tao Zhou (1):
      drm/amdgpu: fix wrong executable setting for dimgrey_cavefish_reg_ini=
t.c

Tejas Upadhyay (3):
      drm/i915/adl_s: Update memory bandwidth parameters
      drm/i915/rkl: Remove require_force_probe protection
      drm/i915/gen9bc: Handle TGP PCH during suspend/resume

Thomas Hellstr=C3=B6m (1):
      drm/i915: Prepare for obj->mm.lock removal, v2.

Thomas Zimmermann (30):
      drm/vmwgfx: Remove reference to struct drm_device.pdev
      drm/gma500: Remove Medfield support
      drm/gma500: Drop DRM_GMA3600 config option
      drm/gma500: Remove CONFIG_X86 conditionals from source files
      drm/gma500: Remove dependency on TTM
      drm/i915: Remove references to struct drm_device.pdev
      drm/i915/gt: Remove references to struct drm_device.pdev
      drm/i915/gvt: Remove references to struct drm_device.pdev
      drm/simple-kms: Add plane-state helpers
      drm/gem: Export drm_gem_vmap() and drm_gem_vunmap()
      drm: Add additional atomic helpers for shadow-buffered planes
      drm/mgag200: Move vmap out of commit tail
      drm/cirrus: Move vmap out of commit tail
      drm/gm12u320: Move vmap out of commit tail
      drm/udl: Move vmap out of commit tail
      drm/gma500: Drop DRM_GMA600 config option
      drm/gem: Export helpers for shadow-buffered planes
      drm/vboxvideo: Implement cursor plane with struct drm_shadow_plane_st=
ate
      drm/ast: Add constants for VGACRCB register bits
      drm/ast: Fix invalid usage of AST_MAX_HWC_WIDTH in cursor atomic_chec=
k
      drm/ast: Initialize planes in helper functions
      drm/ast: Allocate HW cursor BOs during cursor-plane initialization
      drm/ast: Inline ast cursor-update functions into modesetting code
      drm/ast: Add cursor-plane data structure
      drm/ast: Store cursor BOs in cursor plane
      drm/ast: Map HW cursor BOs permanently
      drm/ast: Store each HW cursor offset after pinning the rsp BO
      drm/ast: Move all of the cursor-update functionality to atomic_update
      drm/gem: Move drm_gem_fb_prepare_fb() to GEM atomic helpers
      drm/amdgpu: Remove unused function amdgpu_bo_fbdev_mmap()

Tian Tao (11):
      drm/tilcdc: replace spin_lock_irqsave by spin_lock in hard IRQ
      drm/drv: Remove initialization of static variables
      drm/vboxvideo: Use managed VRAM-helper initialization
      drm/sysfs: Convert sysfs sprintf/snprintf family to sysfs_emit
      drm/exynos: move to use request_irq by IRQF_NO_AUTOEN flag
      drm/komeda: Convert sysfs sprintf/snprintf family to sysfs_emit
      drm/panel: Convert sysfs sprintf/snprintf family to sysfs_emit
      drm/radeon/radeon_pm: Convert sysfs sprintf/snprintf family to sysfs_=
emit
      drm/amdgpu: Convert sysfs sprintf/snprintf family to sysfs_emit
      drm/amd/pm: Convert sysfs sprintf/snprintf family to sysfs_emit
      drm/radeon/r600: Fix variables that are not used after assignment

Tom St Denis (2):
      drm/amd/amdgpu: Add missing BASE_IDX to dcn register
      drm/amd/amdgpu: Add CP_IB1_BASE_* to gc_10_3_0 headers

Tong Zhang (3):
      drm/qxl: do not run release if qxl failed to init
      drm/ast: fix memory leak when unload the driver
      drm/radeon: don't evict if not initialized

Tvrtko Ursulin (7):
      drm/i915: Decrease number of subplatform bits
      drm/i915: Extract active lookup engine to a helper
      drm/i915: Restrict sentinel requests further
      drm/i915: Handle async cancellation in sentinel assert
      drm/i915: Request watchdog infrastructure
      drm/i915: Fail too long user submissions by default
      drm/i915: Allow configuring default request expiry via modparam

Uma Shankar (1):
      drm/i915/display: Handle lane polarity for DDI port

Umesh Nerlige Ramappa (5):
      i915/perf: Store a mask of valid OA formats for a platform
      i915/perf: Move OA formats to single array
      i915/perf: Add additional OA formats for gen12
      i915/perf: Drop the check for report reason in OA
      i915/perf: Start hrtimer only if sampling the OA buffer

Veera Sundaram Sankaran (2):
      dma-fence: allow signaling drivers to set fence timestamp
      drm/drm_vblank: set the dma-fence timestamp during send_vblank_event

Victor Lu (4):
      drm/amd/display: Free local data after use
      drm/amd/display: Deallocate IRQ handlers on amdgpu_dm_irq_fini
      drm/amd/display: Use pr_debug in DM to prevent dmesg flooding
      drm/amd/display: Add function and debugfs to dump DCC_EN bit

Ville Syrj=C3=A4l=C3=A4 (65):
      drm/i915: Skip vswing programming for TBT
      drm/i915: Extract intel_ddi_power_up_lanes()
      drm/i915: Power up combo PHY lanes for for HDMI as well
      drm/i915: Move HDMI vswing programming to the right place
      drm/i915: Don't check tc_mode unless dealing with a TC PHY
      drm/i915: Reject 446-480MHz HDMI clock on GLK
      drm/i915: Index min_{cdclk,voltage_level}[] with pipe
      drm/i915: Use intel_hdmi_port_clock() more
      drm/i915: Disallow plane x+w>stride on ilk+ with X-tiling
      drm/i915: Fix overlay frontbuffer tracking
      drm/i915: Warn when releasing a frontbuffer while in use
      drm/i915: Use intel_ddi_clk_select() for FDI
      drm/i915: Introduce .{enable,disable}_clock() encoder vfuncs
      drm/i915: Extract hsw_ddi_{enable,disable}_clock()
      drm/i915: Extract skl_ddi_{enable,disable}_clock()
      drm/i195: Extract cnl_ddi_{enable,disable}_clock()
      drm/i915: Convert DG1 over to .{enable,disable}_clock()
      drm/i915: Extract icl+ .{enable,disable}_clock() vfuncs
      drm/i915: Use intel_de_rmw() for DDI clock routing
      drm/i915: Sprinkle a few missing locks around shared DDI clock regist=
ers
      drm/i915: Sprinkle WARN(!pll) into icl/dg1 .clock_enable()
      drm/i915: Extract _cnl_ddi_{enable,disable}_clock()
      drm/i915: Split adl-s/rkl from icl_ddi_combo_{enable,disable}_clock()
      drm/i915: Use .disable_clock() for pll sanitation
      drm/i915: Relocate icl_sanitize_encoder_pll_mapping()
      drm/i915: s/dev_priv/i915/ for the remainder of DDI clock routing
      drm/i915: Nuke INTEL_OUTPUT_FORMAT_INVALID
      drm/i915: Wait for scanout to stop when sanitizing planes
      drm/i915: Readout conn_state->max_bpc
      drm/i915: Fix TGL+ plane SAGV watermark programming
      drm/i915: Zero out SAGV wm when we don't have enough DDB for it
      drm/i915: Print wm changes if sagv_wm0 changes
      drm/i915: Stuff SAGV watermark into a sub-structure
      drm/i915: Introduce SAGV transtion watermark
      drm/i915: Check tgl+ SAGV watermarks properly
      drm/i915: Clean up verify_wm_state()
      drm/i915: Move pipe enable/disable tracepoints to
intel_crtc_vblank_{on,off}()
      drm/i915: Don't try to query the frame counter for disabled pipes
      drm/i915: Return zero as the scanline counter for disabled pipes
      drm/i915: Fix DSI TE max_vblank_count handling
      drm/i915: Call primary encoder's .get_config() from MST .get_config()
      drm/i915: Do intel_dpll_readout_hw_state() after encoder readout
      drm/i915: Use pipes instead crtc indices in PLL state tracking
      drm/i915: Move DDI clock readout to encoder->get_config()
      drm/i915: Add encoder->is_clock_enabled()
      drm/i915: Extend icl_sanitize_encoder_pll_mapping() to all DDI platfo=
rms
      drm/i915: Tolerate bogus DPLL selection
      drm/i915: Workaround async flip + VT-d corruption on HSW/BDW
      drm/i915: Tighten SAGV constraint for pre-tgl
      drm/i915: Check SAGV wm min_ddb_alloc rather than plane_res_b
      drm/i915: Calculate min_ddb_alloc for trans_wm
      drm/i915: Extract skl_check_wm_level() and skl_check_nv12_wm_level()
      drm/i915: s/plane_res_b/blocks/ etc.
      drm/i915: Remove dead TPS3->TPS2 fallback code
      drm/i915: Remove dead signal level debugs
      drm/i915: Relocate intel_dp_program_link_training_pattern()
      drm/i915: Split intel_ddi_encoder_reset() from intel_dp_encoder_reset=
()
      drm/i915: Introduce g4x_dp.c
      drm/i915: Introduce g4x_hdmi.c
      drm/i915: Give g4x_{dp,hdmi}.c g4x_ namespace
      drm/i915: Fix enabled_planes bitmask
      drm/i915: Fix transposed arguments to skl_plane_wm_level()
      drm/i915: Stop adding planes to the commit needlessly
      drm: Refuse to create zero width/height cmdline modes
      drm/vblank: Do not store a new vblank timestamp in drm_vblank_restore=
()

Vladimir Stempen (4):
      drm/amd/display: Synchronize displays with different timings
      drm/amd/display: Fix 64 bit divisions on 32 bit platforms by
using div64 API
      drm/amd/display: Fix 64 bit modulus operation using div64 API
      drm/amd/display: Fix typo for variable name

Wan Jiabing (5):
      drm/omap: Remove duplicate declaration
      drm/i915: Remove repeated declaration
      drm/drm_internal.h: Remove repeated struct declaration
      drivers: gpu: Remove duplicate include of amdgpu_hdp.h
      amd: display: modules: Remove repeated struct declaration

Wang Qing (1):
      drm/mediatek: dpi: Delete redundant printing of return value

Wayne Lin (13):
      drm/dp_mst: Revise broadcast msg lct & lcr
      drm/dp_mst: Set CLEAR_PAYLOAD_ID_TABLE as broadcast
      drm/amd/display: Fix crc_src is not thread safe
      drm/amd/display: Support crc on specific region
      drm/amd/display: Process crc window at DMCU
      drm/amd/display: Change to set crc window by dmcu fw
      drm/amd/display: Use PSP TA to read out crc
      drm/amd/display: Fix secure display lock problems
      drm/amd/display: Fix no previous prototype warning
      drm/amd/display: Fix vertical interrupt 0 registering issue
      drm/amd/display: Support vertical interrupt 0 for all dcn ASIC
      drm/amd/display: Add kernel doc to crc_rd_wrk field
      drm/amd/display: Tweak the kernel doc for crc_rd_wrk

Wenjing Liu (2):
      drm/amd/display: define mod_hdcp_display_disable_option struct
      drm/amd/display: add mod hdcp interface for supporting
encryption state query

Werner Sembach (1):
      drm/amd/display: Try YCbCr420 color when YCbCr444 fails

Wesley Chalmers (8):
      Revert "drm/amd/display: New path for enabling DPG"
      Revert "drm/amd/display: Unblank hubp based on plane visibility"
      drm/amd/display: BIOS LTTPR Caps Interface
      drm/amd/display: Interface for LTTPR interop
      drm/amd/display: Enumerate LTTPR modes
      drm/amd/display: LTTPR config logic
      drm/amd/display: New path for enabling DPG
      drm/amd/display: Set max TTU on DPG enable

Wyatt Wood (3):
      drm/amd/display: Return invalid state if GPINT times out
      drm/amd/display: Retry getting PSR state if command times out
      drm/amd/display: Add delay in dmub_srv_send_gpint_command

Xiaogang Chen (1):
      drm/amdgpu/display: buffer INTERRUPT_LOW_IRQ_CONTEXT interrupt work

Xiaojian Du (3):
      drm/amd/pm: correct the name of one function for vangogh
      Revert "drm/amdgpu: disable gpu reset on Vangogh for now"
      drm/amd/pm: add the callback to get vbios bootup values for vangogh

X=E2=84=B9 Ruoyao (1):
      drm/amdgpu: check alignment on CPU page for bo map

Yang Li (5):
      drm/amd/display: Simplify bool conversion
      drm/amdgpu: Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRI=
BUTE
      drm/gma500: use NULL instead of using plain integer as pointer
      drm/tilcdc: panel: fix platform_no_drv_owner.cocci warnings
      drm/omap: dsi: Add missing IRQF_ONESHOT

Yannick Fertre (1):
      drm/stm: dsi: Avoid printing errors for -EPROBE_DEFER

Yao Wang1 (1):
      drm/amd/display: add a func to disable accelerated mode

Ye Bin (1):
      drm/nouveau: remove set but not used variable =E2=80=98pdev=E2=80=99 =
in nouveau_bios_init

Yingjie Wang (1):
      drm/radeon: Fix a missing check bug in radeon_dp_mst_detect()

Yong Zhao (3):
      drm/amdkfd: Add Aldebaran KFD support
      drm/amdgpu: Print the IH client ID name when vm fault happens
      drm/amdgpu: Fix an omission when adding Aldebaran support

Yongqiang Sun (6):
      drm/amd/display: move trace buffer to uncached memory.
      drm/amd/display: Implement dmub trace event
      drm/amd/display: Move define from internal header to dmub_cmd.h
      drm/amd/display: Fix dmub trace event not update issue
      drm/amd/display: Read all the trace entry if it is not empty
      drm/amd/display: Fixed read/write pointer issue for get dmub trace

Zack Rusin (5):
      drm/vmwgfx: Make sure we unpin no longer needed buffers
      drm/vmwgfx: Fix some memory leaks on errors
      drm/vmwgfx: Correctly set the name of the preferred mode
      drm/vmwgfx: Remove pointless code
      drm/vmwgfx: Bump the minor version and cleanup logging

Zbigniew Kempczy=C5=84ski (1):
      drm/i915: Distinction of memory regions

Zhan Liu (2):
      drm/amdgpu/display: Use wm_table.entries for dcn301 calculate_wm
      drm/amdgpu/display: Implement functions to let DC allocate GPU memory

Zhang Jianhua (1):
      drm/bridge: lt8912b: Add header file <linux/gpio/consumer.h>

Zhang Yunkai (2):
      drm/amd/display: remove duplicate include in amdgpu_dm.c
      drm/amd/display: remove duplicate include in dcn21 and gpio

charles sun (2):
      drm/amdgpu/display: drop dcn301_calculate_wm_and_dl for now
      drm/amd/pm: increase time out value when sending msg to SMU

kernel test robot (2):
      drm/gud: fix sizeof use
      drm/gud: Remove unneeded semicolon

shaoyunl (11):
      drm/amdgpu: Add kfd init_complete flag to check from amdgpu side
      drm/amdgpu: Init the cp MQD if it's not be initialized before
      drm/amdgpu: Add reset_list for device list used for reset
      drm/amdgpu: Reset the devices in the XGMI hive duirng probe
      drm/amdgpu : Fix asic reset regression issue introduce by 8f211fe8ac7=
c4f
      drm/amdgpu: skip read eeprom for device that pending on XGMI reset
      drm/amd/pm: Add LightSBR SMU MSG support
      drm/amdgpu: Enable light SBR for SMU on passthrough and XGMI configur=
ation
      drm/amdgpu: Enable light SBR in XGMI+passthrough configuration
      drm/amdgpu: Keep pending_reset valid during smu reset the ASIC
      drm/amd/pm: Use BACO reset arg 0 on XGMI configuration

tangchunyou (1):
      drm/mediatek: cec: Delete redundant printing of return value

xinhui pan (5):
      drm/ttm: Do not add non-system domain BO into swap list
      drm/amdgpu: Fix memory leak
      drm/amdgpu: Use correct size when access vram
      drm/amdgpu: Fix size overflow
      drm/radeon: Fix size overflow

xndcn (1):
      drm/virtio: fix possible leak/unlock virtio_gpu_object_array

 Documentation/core-api/printk-formats.rst          |    18 +
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |     4 +-
 .../bindings/display/brcm,bcm2711-hdmi.yaml        |     2 +-
 .../bindings/display/bridge/analogix,anx7625.yaml  |    15 +
 .../bindings/display/bridge/chipone,icn6211.yaml   |    99 +
 .../devicetree/bindings/display/bridge/dw_hdmi.txt |    33 -
 .../bindings/display/bridge/lontium,lt8912b.yaml   |   102 +
 .../bindings/display/bridge/renesas,dw-hdmi.txt    |    88 -
 .../bindings/display/bridge/renesas,dw-hdmi.yaml   |   125 +
 .../bindings/display/bridge/synopsys,dw-hdmi.yaml  |    55 +
 .../devicetree/bindings/display/fsl,lcdif.yaml     |   110 +
 .../bindings/display/imx/fsl,imx6-hdmi.yaml        |   126 +
 .../devicetree/bindings/display/imx/hdmi.txt       |    65 -
 .../bindings/display/mediatek/mediatek,dpi.yaml    |    12 +-
 .../devicetree/bindings/display/mxsfb.txt          |    87 -
 .../bindings/display/panel/panel-simple.yaml       |     2 +
 .../devicetree/bindings/display/renesas,du.txt     |   145 -
 .../devicetree/bindings/display/renesas,du.yaml    |   831 +
 .../bindings/display/rockchip/dw_hdmi-rockchip.txt |    74 -
 .../display/rockchip/rockchip,dw-hdmi.yaml         |   156 +
 Documentation/driver-api/dma-buf.rst               |    76 +
 Documentation/gpu/drm-kms-helpers.rst              |    12 +
 Documentation/gpu/index.rst                        |     1 +
 Documentation/gpu/rfc/index.rst                    |    17 +
 Documentation/gpu/todo.rst                         |    76 +-
 MAINTAINERS                                        |    30 +-
 arch/x86/kernel/early-quirks.c                     |     1 +
 drivers/clk/clk-mux.c                              |    35 +
 drivers/dma-buf/dma-fence.c                        |    27 +-
 drivers/dma-buf/dma-heap.c                         |    12 +
 drivers/dma-buf/heaps/cma_heap.c                   |     1 +
 drivers/dma-buf/heaps/system_heap.c                |     1 +
 drivers/gpu/drm/Kconfig                            |     4 +-
 drivers/gpu/drm/Makefile                           |     7 +-
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |     9 -
 drivers/gpu/drm/amd/amdgpu/Makefile                |    21 +-
 drivers/gpu/drm/amd/amdgpu/aldebaran.c             |   407 +
 drivers/gpu/drm/amd/amdgpu/aldebaran.h             |    32 +
 drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c    |    54 +
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    70 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |     1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c   |    47 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |    16 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h    |    30 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    53 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   196 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h       |    12 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c   |    73 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c      |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   184 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h        |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   555 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |    72 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    29 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   193 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c          |   101 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c           |    30 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h           |     3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    28 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |    21 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   189 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |    40 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |    23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |    54 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h            |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   143 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.h          |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h           |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |    19 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |   136 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   146 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rap.c            |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |   423 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     |    51 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h     |   105 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c          |    98 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h          |    85 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h            |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h           |     5 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c  |    13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_smuio.h          |     2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c           |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   498 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |    11 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c          |     1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c            |    17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |     8 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |    14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |    11 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h           |    28 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |    25 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |    36 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    43 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h           |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h        |    17 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/atom.c                  |     4 +-
 drivers/gpu/drm/amd/amdgpu/atom.h                  |     2 -
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    77 +
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c             |     5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c             |     5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c               |     4 +-
 .../gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c |     0
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   151 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |    26 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    15 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   224 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              |    20 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.h              |    12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |  1297 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h            |    35 +
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |    75 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_1.c           |    54 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |     9 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   186 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c              |     3 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c             |    67 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.h             |     1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |     3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |     6 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c            |  1333 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h            |    29 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |     1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |     1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |     8 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.h            |     1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |    64 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.h             |     1 +
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   251 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |    26 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c             |   378 +
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.h             |    30 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |   185 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c             |   232 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h             |    28 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |     8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |     9 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |   111 +
 drivers/gpu/drm/amd/amdgpu/si_dma.c                |     5 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c           |   121 +
 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h           |    30 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   376 +-
 drivers/gpu/drm/amd/amdgpu/soc15.h                 |    12 +
 drivers/gpu/drm/amd/amdgpu/soc15_common.h          |    63 +-
 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h   |     1 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h              |     2 +-
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c              |   281 +
 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h              |    37 +
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/umc_v8_7.h              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c              |     5 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c              |     2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c              |     4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c              |   103 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.h              |     1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |   167 +-
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |    32 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |    55 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    |   190 +
 drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c   |     5 +-
 drivers/gpu/drm/amd/amdkfd/cwsr_trap_handler.h     |   492 +
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx8.asm  |     1 +
 .../gpu/drm/amd/amdkfd/cwsr_trap_handler_gfx9.asm  |   204 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   122 +-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |    17 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c           |     7 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |    27 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |    57 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     5 -
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |     5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c             |    14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h             |     9 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h       |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |     8 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c   |     8 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c    |     8 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c    |     8 +
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c    |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |    29 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |   174 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c        |     2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |     1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |     5 +-
 drivers/gpu/drm/amd/display/Kconfig                |    14 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   934 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    81 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c  |   295 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h  |    37 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |   696 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.h  |     5 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |     6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |    54 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |   185 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_irq_params.h   |     9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |    17 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |   134 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_trace.h    |    40 +
 drivers/gpu/drm/amd/display/dc/Makefile            |     3 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.c  |    20 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |   195 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.c   |     5 +-
 .../drm/amd/display/dc/bios/bios_parser_helper.h   |     2 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    21 +
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |    93 +-
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |     3 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |  1154 +-
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c   |   137 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |     2 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |    13 +
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |    11 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c |    29 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |   105 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h |    28 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   347 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |    48 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |     5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   193 +-
 .../gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c  |   303 +
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |    24 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    50 +
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c      |    64 +
 drivers/gpu/drm/amd/display/dc/dc.h                |    28 +-
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |     9 +-
 drivers/gpu/drm/amd/display/dc/dc_ddc_types.h      |    10 -
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c       |    34 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h       |     8 +
 drivers/gpu/drm/amd/display/dc/dc_dsc.h            |    11 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    38 +-
 drivers/gpu/drm/amd/display/dc/dc_stat.h           |    42 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    15 +
 drivers/gpu/drm/amd/display/dc/dc_types.h          |    19 +-
 drivers/gpu/drm/amd/display/dc/dce/Makefile        |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c       |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |    40 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |     4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    52 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |    90 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |    10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c   |    60 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h   |    33 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    32 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |   100 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |     2 +
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |    16 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |   324 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |    15 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    16 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |     5 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c  |     2 +
 .../amd/display/dc/dcn10/dcn10_stream_encoder.c    |     1 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dccg.c  |     2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |    15 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |     3 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c  |   140 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.h  |     3 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |    38 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |     4 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |    15 +-
 .../display/dc/dcn30/dcn30_dio_stream_encoder.c    |     1 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c   |     4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c    |     4 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb_cm.c    |     2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   100 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h |     4 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c   |    26 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |    23 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.h  |     1 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.c    |     4 +-
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |     7 +-
 .../drm/amd/display/dc/dcn302/dcn302_resource.c    |     7 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |     2 +
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |     1 +
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |     1 +
 .../display/dc/dml/dcn20/display_rq_dlg_calc_20.c  |    28 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c        |    28 +-
 .../display/dc/dml/dcn21/display_rq_dlg_calc_21.c  |    28 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |     2 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |    28 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_lib.c  |     2 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |     4 +-
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |    11 +-
 .../amd/display/dc/dml/dml1_display_rq_dlg_calc.c  |    28 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c        |   105 +-
 .../amd/display/dc/gpio/dce110/hw_factory_dce110.c |     4 -
 drivers/gpu/drm/amd/display/dc/hdcp/hdcp_msg.c     |     9 +-
 drivers/gpu/drm/amd/display/dc/inc/clock_source.h  |     5 +
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |    42 +
 drivers/gpu/drm/amd/display/dc/inc/dc_link_ddc.h   |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/aux_engine.h |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr.h    |    10 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    21 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hw_shared.h  |     1 +
 .../gpu/drm/amd/display/dc/inc/hw/link_encoder.h   |    13 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |    12 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |    12 +-
 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h  |    86 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h      |     5 +
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |    31 +
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |    63 +-
 .../amd/display/dc/irq/dcn30/irq_service_dcn30.c   |    63 +-
 .../amd/display/dc/irq/dcn302/irq_service_dcn302.c |    60 +
 drivers/gpu/drm/amd/display/dc/irq_types.h         |     3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h        |    55 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv_stat.h   |    41 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  1471 +-
 .../drm/amd/display/dmub/inc/dmub_trace_buffer.h   |     3 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile      |     2 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |    57 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |    35 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  |     7 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |   182 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv_stat.c   |   105 +
 drivers/gpu/drm/amd/display/include/logger_types.h |     3 +
 .../drm/amd/display/modules/color/color_gamma.c    |     6 +-
 .../drm/amd/display/modules/color/color_gamma.h    |     4 +-
 .../drm/amd/display/modules/freesync/freesync.c    |    69 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.c    |    10 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |     4 +-
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |    37 +-
 .../amd/display/modules/hdcp/hdcp1_transition.c    |     6 +-
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |    10 +-
 .../amd/display/modules/hdcp/hdcp2_transition.c    |    10 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |    10 +
 .../gpu/drm/amd/display/modules/inc/mod_freesync.h |    10 +-
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |    12 +-
 drivers/gpu/drm/amd/include/aldebaran_ip_offset.h  |  1738 +
 .../amd/include/asic_reg/dcn/dcn_3_0_0_offset.h    |     2 +-
 .../drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h |     6 +
 .../amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h    |     9 +
 .../drm/amd/include/asic_reg/gc/gc_9_4_2_offset.h  |  7683 +++++
 .../drm/amd/include/asic_reg/gc/gc_9_4_2_sh_mask.h | 32949 +++++++++++++++=
++++
 .../amd/include/asic_reg/mmhub/mmhub_1_7_offset.h  |  5125 +++
 .../amd/include/asic_reg/mmhub/mmhub_1_7_sh_mask.h | 32178 +++++++++++++++=
+++
 .../drm/amd/include/asic_reg/mp/mp_13_0_2_offset.h |   361 +
 .../amd/include/asic_reg/mp/mp_13_0_2_sh_mask.h    |   531 +
 .../amd/include/asic_reg/sdma/sdma_4_4_0_offset.h  |  5224 +++
 .../amd/include/asic_reg/sdma/sdma_4_4_0_sh_mask.h | 13922 ++++++++
 .../include/asic_reg/smuio/smuio_13_0_2_offset.h   |   516 +
 .../include/asic_reg/smuio/smuio_13_0_2_sh_mask.h  |  1163 +
 .../amd/include/asic_reg/thm/thm_13_0_2_offset.h   |   346 +
 .../amd/include/asic_reg/thm/thm_13_0_2_sh_mask.h  |  1297 +
 .../amd/include/asic_reg/umc/umc_6_7_0_offset.h    |  2620 ++
 .../amd/include/asic_reg/umc/umc_6_7_0_sh_mask.h   | 10796 ++++++
 .../amd/include/asic_reg/vcn/vcn_2_6_0_offset.h    |  1462 +
 .../amd/include/asic_reg/vcn/vcn_2_6_0_sh_mask.h   |  4535 +++
 drivers/gpu/drm/amd/include/atombios.h             |     4 +-
 drivers/gpu/drm/amd/include/atomfirmware.h         |   167 +-
 .../drm/amd/include/ivsrcid/dcn/irqsrcs_dcn_1_0.h  |     4 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |   141 +-
 drivers/gpu/drm/amd/include/soc15_ih_clientid.h    |     9 +-
 drivers/gpu/drm/amd/include/vi_structs.h           |    32 +-
 drivers/gpu/drm/amd/pm/Makefile                    |     1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                |   236 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |  1130 +-
 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h       |   127 +
 drivers/gpu/drm/amd/pm/inc/amdgpu_pm.h             |     2 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |   141 +-
 drivers/gpu/drm/amd/pm/inc/arcturus_ppsmc.h        |     7 +
 drivers/gpu/drm/amd/pm/inc/rv_ppsmc.h              |     1 +
 .../gpu/drm/amd/pm/inc/smu11_driver_if_navi10.h    |    98 +-
 .../gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h |   519 +
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |    29 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |    19 +-
 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h             |   275 +
 drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h     |   165 +
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c   |    12 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |    45 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |     4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    |     9 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |     4 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_pptable.h    |     6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |     6 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |     6 +-
 drivers/gpu/drm/amd/pm/powerplay/kv_dpm.c          |     2 +-
 drivers/gpu/drm/amd/pm/powerplay/si_dpm.c          |     8 +-
 drivers/gpu/drm/amd/pm/powerplay/sislands_smc.h    |    10 +-
 drivers/gpu/drm/amd/pm/swsmu/Makefile              |     2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   717 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |    19 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |   646 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |    62 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |    27 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |    63 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |    30 +-
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile        |    30 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  1826 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h |    72 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |  1839 ++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |    50 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |     5 +
 drivers/gpu/drm/arc/Kconfig                        |    10 -
 drivers/gpu/drm/arc/Makefile                       |     3 -
 drivers/gpu/drm/arc/arcpgu.h                       |    37 -
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |   217 -
 drivers/gpu/drm/arc/arcpgu_drv.c                   |   224 -
 drivers/gpu/drm/arc/arcpgu_hdmi.c                  |    48 -
 drivers/gpu/drm/arc/arcpgu_regs.h                  |    31 -
 drivers/gpu/drm/arc/arcpgu_sim.c                   |   108 -
 drivers/gpu/drm/arm/display/include/malidp_utils.h |     3 -
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |     6 +-
 .../drm/arm/display/komeda/komeda_format_caps.h    |    11 -
 .../drm/arm/display/komeda/komeda_framebuffer.c    |     4 +-
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |     3 +
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |    16 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |    19 +-
 drivers/gpu/drm/arm/display/komeda/komeda_plane.c  |    21 +-
 drivers/gpu/drm/arm/hdlcd_crtc.c                   |    30 +-
 drivers/gpu/drm/arm/malidp_drv.c                   |     3 +
 drivers/gpu/drm/arm/malidp_mw.c                    |     7 +-
 drivers/gpu/drm/arm/malidp_planes.c                |    79 +-
 drivers/gpu/drm/armada/armada_overlay.c            |   113 +-
 drivers/gpu/drm/armada/armada_plane.c              |   115 +-
 drivers/gpu/drm/armada/armada_plane.h              |     2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx.h                |     8 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c           |    15 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c            |    69 +-
 drivers/gpu/drm/ast/Makefile                       |     3 +-
 drivers/gpu/drm/ast/ast_cursor.c                   |   286 -
 drivers/gpu/drm/ast/ast_drv.c                      |     2 +
 drivers/gpu/drm/ast/ast_drv.h                      |    47 +-
 drivers/gpu/drm/ast/ast_mode.c                     |   388 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c       |   107 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |     7 -
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c    |   135 +-
 drivers/gpu/drm/bridge/Kconfig                     |    33 +-
 drivers/gpu/drm/bridge/Makefile                    |     2 +
 drivers/gpu/drm/bridge/analogix/Kconfig            |     1 +
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |    27 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |    27 +-
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |     1 +
 drivers/gpu/drm/bridge/analogix/anx7625.c          |    34 +
 drivers/gpu/drm/bridge/analogix/anx7625.h          |     1 +
 .../gpu/drm/bridge/cadence/cdns-mhdp8546-core.c    |     2 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c           |   293 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   768 +
 drivers/gpu/drm/bridge/lontium-lt9611.c            |     8 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |     2 +-
 drivers/gpu/drm/bridge/panel.c                     |    12 +
 drivers/gpu/drm/bridge/tc358767.c                  |    20 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |    18 +-
 drivers/gpu/drm/drm_atomic.c                       |    51 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    90 +-
 drivers/gpu/drm/drm_connector.c                    |     1 +
 drivers/gpu/drm/drm_crtc.c                         |     7 +-
 drivers/gpu/drm/drm_displayid.c                    |   132 +
 drivers/gpu/drm/drm_dp_helper.c                    |    24 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    99 +-
 drivers/gpu/drm/drm_drv.c                          |     2 +-
 drivers/gpu/drm/drm_edid.c                         |   171 +-
 drivers/gpu/drm/drm_framebuffer.c                  |    11 +-
 drivers/gpu/drm/drm_gem.c                          |     2 +
 drivers/gpu/drm/drm_gem_atomic_helper.c            |   432 +
 drivers/gpu/drm/drm_gem_framebuffer_helper.c       |    63 -
 drivers/gpu/drm/drm_gem_vram_helper.c              |    42 +-
 drivers/gpu/drm/drm_internal.h                     |     1 -
 drivers/gpu/drm/drm_ioc32.c                        |    15 +-
 drivers/gpu/drm/drm_mipi_dbi.c                     |     5 +-
 drivers/gpu/drm/drm_modes.c                        |     3 +
 drivers/gpu/drm/drm_panel_orientation_quirks.c     |    14 +
 drivers/gpu/drm/drm_plane.c                        |    66 +-
 drivers/gpu/drm/drm_probe_helper.c                 |     7 +-
 drivers/gpu/drm/drm_property.c                     |     4 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    50 +-
 drivers/gpu/drm/drm_syncobj.c                      |    37 +-
 drivers/gpu/drm/drm_sysfs.c                        |     9 +-
 drivers/gpu/drm/drm_vblank.c                       |    28 +-
 drivers/gpu/drm/etnaviv/etnaviv_sched.c            |     9 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |     4 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |     7 +-
 drivers/gpu/drm/exynos/exynos_drm_plane.c          |    20 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c        |    24 +-
 drivers/gpu/drm/gma500/Kconfig                     |    11 +-
 drivers/gpu/drm/gma500/Makefile                    |    17 +-
 drivers/gpu/drm/gma500/accel_2d.c                  |    60 -
 drivers/gpu/drm/gma500/blitter.c                   |    43 -
 drivers/gpu/drm/gma500/blitter.h                   |    16 -
 drivers/gpu/drm/gma500/cdv_device.c                |     2 +-
 drivers/gpu/drm/gma500/cdv_device.h                |     1 -
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |    15 +-
 drivers/gpu/drm/gma500/cdv_intel_display.c         |    23 +-
 drivers/gpu/drm/gma500/gtt.c                       |    11 -
 drivers/gpu/drm/gma500/intel_gmbus.c               |     4 +-
 drivers/gpu/drm/gma500/oaktrail_device.c           |     2 +-
 drivers/gpu/drm/gma500/power.c                     |     3 +-
 drivers/gpu/drm/gma500/psb_device.c                |     2 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |    38 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |     6 +-
 drivers/gpu/drm/gma500/psb_intel_display.c         |     2 +-
 drivers/gpu/drm/gma500/psb_intel_reg.h             |    32 -
 drivers/gpu/drm/gma500/psb_irq.c                   |   110 -
 drivers/gpu/drm/gma500/psb_irq.h                   |     4 -
 drivers/gpu/drm/gud/Kconfig                        |    14 +
 drivers/gpu/drm/gud/Makefile                       |     4 +
 drivers/gpu/drm/gud/gud_connector.c                |   729 +
 drivers/gpu/drm/gud/gud_drv.c                      |   661 +
 drivers/gpu/drm/gud/gud_internal.h                 |   154 +
 drivers/gpu/drm/gud/gud_pipe.c                     |   552 +
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |    39 +-
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c    |    47 +-
 drivers/gpu/drm/i915/Kconfig.profile               |    14 +
 drivers/gpu/drm/i915/Makefile                      |    10 +-
 drivers/gpu/drm/i915/TODO.txt                      |    41 +
 drivers/gpu/drm/i915/display/g4x_dp.c              |  1432 +
 drivers/gpu/drm/i915/display/g4x_dp.h              |    30 +
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |   616 +
 drivers/gpu/drm/i915/display/g4x_hdmi.h            |    19 +
 drivers/gpu/drm/i915/display/i9xx_plane.c          |   196 +-
 drivers/gpu/drm/i915/display/i9xx_plane.h          |     4 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |    42 +-
 drivers/gpu/drm/i915/display/intel_atomic.c        |     9 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |    48 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  1248 +-
 drivers/gpu/drm/i915/display/intel_bios.h          |    19 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |    32 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |    88 +-
 drivers/gpu/drm/i915/display/intel_color.c         |    32 +-
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |    31 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |    18 +-
 drivers/gpu/drm/i915/display/intel_crt.h           |     1 -
 drivers/gpu/drm/i915/display/intel_crtc.c          |   290 +-
 drivers/gpu/drm/i915/display/intel_csr.c           |    16 +-
 drivers/gpu/drm/i915/display/intel_cursor.c        |    29 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  2789 +-
 drivers/gpu/drm/i915/display/intel_ddi.h           |    23 +-
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c |  1394 +
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.h |   100 +
 drivers/gpu/drm/i915/display/intel_display.c       |  4514 +--
 drivers/gpu/drm/i915/display/intel_display.h       |    56 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |   209 +-
 drivers/gpu/drm/i915/display/intel_display_power.c |   283 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |    32 +
 drivers/gpu/drm/i915/display/intel_display_types.h |   179 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  1802 +-
 drivers/gpu/drm/i915/display/intel_dp.h            |    11 -
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |    12 +-
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       |   115 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |    52 +-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |     3 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |    23 +-
 drivers/gpu/drm/i915/display/intel_dpll.c          |   519 +-
 drivers/gpu/drm/i915/display/intel_dpll.h          |    18 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c      |   117 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h      |     9 +-
 drivers/gpu/drm/i915/display/intel_dsb.c           |     2 +-
 drivers/gpu/drm/i915/display/intel_dsi_vbt.c       |     6 +-
 drivers/gpu/drm/i915/display/intel_fb.c            |   962 +
 drivers/gpu/drm/i915/display/intel_fb.h            |    54 +
 drivers/gpu/drm/i915/display/intel_fbc.c           |    68 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |     4 +-
 drivers/gpu/drm/i915/display/intel_fdi.c           |   144 +-
 drivers/gpu/drm/i915/display/intel_fdi.h           |     3 +
 drivers/gpu/drm/i915/display/intel_fifo_underrun.c |     8 +-
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |     2 +
 drivers/gpu/drm/i915/display/intel_gmbus.c         |     4 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |    54 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   714 +-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |     3 -
 drivers/gpu/drm/i915/display/intel_lpe_audio.c     |     5 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |    12 +-
 drivers/gpu/drm/i915/display/intel_opregion.c      |     6 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |    48 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |    22 +-
 drivers/gpu/drm/i915/display/intel_pipe_crc.c      |    16 +-
 drivers/gpu/drm/i915/display/intel_pps.c           |     8 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   654 +-
 drivers/gpu/drm/i915/display/intel_psr.h           |    10 +-
 drivers/gpu/drm/i915/display/intel_quirks.c        |     2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          |    10 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |  1792 +-
 drivers/gpu/drm/i915/display/intel_sprite.h        |     8 -
 drivers/gpu/drm/i915/display/intel_tc.c            |     8 +-
 drivers/gpu/drm/i915/display/intel_tv.c            |     8 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |    27 +-
 drivers/gpu/drm/i915/display/intel_vdsc.c          |    12 +-
 drivers/gpu/drm/i915/display/intel_vga.c           |    12 +-
 drivers/gpu/drm/i915/display/intel_vrr.h           |     1 -
 drivers/gpu/drm/i915/display/skl_scaler.c          |   556 +
 drivers/gpu/drm/i915/display/skl_scaler.h          |    29 +
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  2218 ++
 drivers/gpu/drm/i915/display/skl_universal_plane.h |    35 +
 drivers/gpu/drm/i915/display/vlv_dsi.c             |     1 +
 drivers/gpu/drm/i915/gem/i915_gem_clflush.c        |    15 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |    79 +-
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |     4 +
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c         |    67 +-
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |    72 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   335 +-
 drivers/gpu/drm/i915/gem/i915_gem_fence.c          |    95 -
 drivers/gpu/drm/i915/gem/i915_gem_internal.c       |     6 +-
 drivers/gpu/drm/i915/gem/i915_gem_ioctls.h         |     2 -
 drivers/gpu/drm/i915/gem/i915_gem_lmem.c           |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |    35 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |    10 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   122 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |     6 +
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |    23 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |   109 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |   116 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |     2 +-
 drivers/gpu/drm/i915/gem/i915_gem_region.c         |    16 +-
 drivers/gpu/drm/i915/gem/i915_gem_region.h         |     3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |    41 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |    39 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.h       |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |    18 +-
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |     2 -
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   918 +-
 .../gpu/drm/i915/gem/selftests/huge_gem_object.c   |     4 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |    38 +-
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |     8 +-
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |    14 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_context.c  |    10 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_dmabuf.c   |     2 +-
 .../drm/i915/gem/selftests/i915_gem_execbuffer.c   |     2 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |    21 +-
 .../gpu/drm/i915/gem/selftests/i915_gem_object.c   |     2 +-
 .../drm/i915/gem/selftests/i915_gem_object_blt.c   |    10 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_phys.c |    10 +-
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |     2 +-
 drivers/gpu/drm/i915/gt/debugfs_gt.c               |     2 +-
 drivers/gpu/drm/i915/gt/gen2_engine_cs.c           |     2 +-
 drivers/gpu/drm/i915/gt/gen6_engine_cs.c           |     8 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.h               |     4 +-
 drivers/gpu/drm/i915/gt/gen6_renderstate.c         |    20 +-
 drivers/gpu/drm/i915/gt/gen7_renderstate.c         |    20 +-
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |    15 +-
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |    13 +-
 drivers/gpu/drm/i915/gt/gen8_renderstate.c         |    20 +-
 drivers/gpu/drm/i915/gt/gen9_renderstate.c         |    20 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |    23 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |     3 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |     3 +-
 drivers/gpu/drm/i915/gt/intel_context_param.h      |    11 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h      |     7 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |    73 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |    27 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.h   |     3 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |     7 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.h          |     3 +-
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |     3 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.c        |     3 +-
 drivers/gpu/drm/i915/gt/intel_engine_user.h        |     3 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |   146 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.h   |     2 +
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |   102 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |    23 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.h       |    21 +-
 drivers/gpu/drm/i915/gt/intel_gpu_commands.h       |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |    47 +-
 drivers/gpu/drm/i915/gt/intel_gt.h                 |     3 +
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c     |    47 +-
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h     |     5 +
 .../gpu/drm/i915/gt/intel_gt_buffer_pool_types.h   |     4 +-
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c     |     1 -
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.h             |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_irq.c          |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_pm_irq.h          |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |    31 +-
 drivers/gpu/drm/i915/gt/intel_gt_requests.h        |     3 +-
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |    11 +-
 drivers/gpu/drm/i915/gt/intel_gtt.c                |    52 +-
 drivers/gpu/drm/i915/gt/intel_gtt.h                |    13 +
 drivers/gpu/drm/i915/gt/intel_llc.c                |     3 +-
 drivers/gpu/drm/i915/gt/intel_llc.h                |     3 +-
 drivers/gpu/drm/i915/gt/intel_llc_types.h          |     3 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |    55 +-
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |     5 +-
 drivers/gpu/drm/i915/gt/intel_mocs.c               |    21 +-
 drivers/gpu/drm/i915/gt/intel_mocs.h               |    22 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c              |     9 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |     8 +-
 drivers/gpu/drm/i915/gt/intel_rc6.h                |     3 +-
 drivers/gpu/drm/i915/gt/intel_rc6_types.h          |     3 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c        |   105 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.h        |     6 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.c        |    29 +-
 drivers/gpu/drm/i915/gt/intel_renderstate.h        |    20 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |    33 +-
 drivers/gpu/drm/i915/gt/intel_reset.h              |     3 +-
 drivers/gpu/drm/i915/gt/intel_reset_types.h        |     2 +-
 drivers/gpu/drm/i915/gt/intel_ring.c               |     8 +-
 drivers/gpu/drm/i915/gt/intel_ring.h               |     4 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   330 +-
 drivers/gpu/drm/i915/gt/intel_ring_types.h         |     3 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |     3 +-
 drivers/gpu/drm/i915/gt/intel_rps.h                |     3 +-
 drivers/gpu/drm/i915/gt/intel_rps_types.h          |     3 +-
 drivers/gpu/drm/i915/gt/intel_sseu.c               |     3 +-
 drivers/gpu/drm/i915/gt/intel_sseu.h               |     3 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   429 +-
 drivers/gpu/drm/i915/gt/intel_timeline.h           |    23 +-
 drivers/gpu/drm/i915/gt/intel_timeline_types.h     |    20 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   105 +-
 drivers/gpu/drm/i915/gt/intel_workarounds.h        |     3 +-
 drivers/gpu/drm/i915/gt/intel_workarounds_types.h  |     3 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |    51 +-
 drivers/gpu/drm/i915/gt/mock_engine.h              |    21 +-
 drivers/gpu/drm/i915/gt/selftest_context.c         |     7 +-
 drivers/gpu/drm/i915/gt/selftest_engine.c          |     3 +-
 drivers/gpu/drm/i915/gt/selftest_engine.h          |     3 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c       |    12 +-
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |    17 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |    11 +-
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |    77 +-
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |     4 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |    29 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c             |     3 +-
 drivers/gpu/drm/i915/gt/selftest_llc.h             |     3 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |    19 +-
 drivers/gpu/drm/i915/gt/selftest_mocs.c            |    40 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c             |     3 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.h             |     3 +-
 drivers/gpu/drm/i915/gt/selftest_ring_submission.c |     4 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |   180 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |   101 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c              |     2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |     2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_log.c         |     4 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |    16 +-
 drivers/gpu/drm/i915/gt/uc/intel_huc.c             |     2 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |     6 +-
 drivers/gpu/drm/i915/gvt/cfg_space.c               |     5 +-
 drivers/gpu/drm/i915/gvt/display.c                 |   107 +-
 drivers/gpu/drm/i915/gvt/display.h                 |    14 +-
 drivers/gpu/drm/i915/gvt/dmabuf.c                  |     2 +-
 drivers/gpu/drm/i915/gvt/firmware.c                |    10 +-
 drivers/gpu/drm/i915/gvt/gtt.c                     |    16 +-
 drivers/gpu/drm/i915/gvt/gvt.c                     |    31 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |    13 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |   261 +-
 drivers/gpu/drm/i915/gvt/interrupt.c               |    37 -
 drivers/gpu/drm/i915/gvt/interrupt.h               |     7 -
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |     4 +-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |     2 -
 drivers/gpu/drm/i915/i915_active.c                 |    20 +-
 drivers/gpu/drm/i915/i915_buddy.c                  |     3 +
 drivers/gpu/drm/i915/i915_buddy.h                  |     7 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |   104 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |    22 +-
 drivers/gpu/drm/i915/i915_drv.c                    |    95 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   204 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   258 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |     7 +-
 drivers/gpu/drm/i915/i915_getparam.c               |     5 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |     2 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   168 +-
 drivers/gpu/drm/i915/i915_memcpy.c                 |     2 +-
 drivers/gpu/drm/i915/i915_memcpy.h                 |     2 +-
 drivers/gpu/drm/i915/i915_params.c                 |     5 +
 drivers/gpu/drm/i915/i915_params.h                 |     5 +-
 drivers/gpu/drm/i915/i915_pci.c                    |    23 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   140 +-
 drivers/gpu/drm/i915/i915_perf_types.h             |     8 +
 drivers/gpu/drm/i915/i915_pmu.c                    |     2 +-
 drivers/gpu/drm/i915/i915_priolist_types.h         |    11 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    55 +-
 drivers/gpu/drm/i915/i915_request.c                |   142 +-
 drivers/gpu/drm/i915/i915_request.h                |    49 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |    52 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |    16 +-
 drivers/gpu/drm/i915/i915_selftest.h               |     2 +
 drivers/gpu/drm/i915/i915_suspend.c                |     4 +-
 drivers/gpu/drm/i915/i915_switcheroo.c             |     4 +-
 drivers/gpu/drm/i915/i915_vgpu.c                   |     2 +-
 drivers/gpu/drm/i915/i915_vma.c                    |    30 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    20 +-
 drivers/gpu/drm/i915/i915_vma_types.h              |    12 +-
 drivers/gpu/drm/i915/intel_device_info.c           |    13 +-
 drivers/gpu/drm/i915/intel_device_info.h           |    12 +-
 drivers/gpu/drm/i915/intel_dram.c                  |     6 +
 drivers/gpu/drm/i915/intel_memory_region.c         |    54 +-
 drivers/gpu/drm/i915/intel_memory_region.h         |    22 +-
 drivers/gpu/drm/i915/intel_pch.c                   |    11 +-
 drivers/gpu/drm/i915/intel_pch.h                   |     3 +
 drivers/gpu/drm/i915/intel_pm.c                    |   542 +-
 drivers/gpu/drm/i915/intel_pm.h                    |     5 +
 drivers/gpu/drm/i915/intel_runtime_pm.c            |     4 +-
 drivers/gpu/drm/i915/intel_step.c                  |   106 +
 drivers/gpu/drm/i915/intel_step.h                  |    40 +
 drivers/gpu/drm/i915/intel_uncore.c                |    20 +-
 drivers/gpu/drm/i915/selftests/i915_buddy.c        |    48 +
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |    94 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |   211 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |   219 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |   136 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.h       |     5 +
 .../gpu/drm/i915/selftests/intel_memory_region.c   |    95 +-
 drivers/gpu/drm/i915/selftests/mock_gtt.c          |     2 +-
 drivers/gpu/drm/i915/selftests/mock_region.c       |     4 +-
 drivers/gpu/drm/imx/dcss/dcss-plane.c              |    64 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |    92 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    83 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c              |    77 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |    50 +-
 drivers/gpu/drm/lima/lima_devfreq.c                |    11 +-
 drivers/gpu/drm/lima/lima_devfreq.h                |     2 +
 drivers/gpu/drm/lima/lima_sched.c                  |     6 +-
 drivers/gpu/drm/mcde/mcde_display.c                |    10 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |     2 +-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |     6 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    32 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |    23 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h            |     2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |     1 +
 drivers/gpu/drm/mediatek/mtk_drm_plane.c           |   103 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |     9 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   175 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c            |     1 +
 drivers/gpu/drm/meson/meson_overlay.c              |    31 +-
 drivers/gpu/drm/meson/meson_plane.c                |    51 +-
 drivers/gpu/drm/meson/meson_venc.c                 |     2 +-
 drivers/gpu/drm/mgag200/mgag200_mode.c             |    25 +-
 drivers/gpu/drm/msm/Kconfig                        |     9 +-
 drivers/gpu/drm/msm/Makefile                       |     9 -
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |    12 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |     3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c       |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c      |     1 -
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |    96 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |    30 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |    11 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |     1 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c   |    26 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   195 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |    10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c         |    27 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h         |     3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |   793 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |     5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |    12 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |     1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h         |     4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |    11 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c           |    54 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |    54 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.h          |     2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_plane.c         |    18 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c   |    19 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_plane.c         |    57 +-
 drivers/gpu/drm/msm/dp/dp_debug.c                  |    33 +-
 drivers/gpu/drm/msm/dp/dp_hpd.c                    |     4 +-
 drivers/gpu/drm/msm/dp/dp_power.c                  |     2 +-
 drivers/gpu/drm/msm/dsi/dsi.h                      |    60 +-
 drivers/gpu/drm/msm/dsi/dsi_cfg.c                  |     6 +-
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |     6 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |    30 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   161 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |    41 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_10nm.c         |   747 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c         |   939 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c         |    16 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c         |   654 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c    |   479 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |   774 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.c              |   184 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll.h              |   132 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |   881 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c         |  1096 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c         |   643 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c    |   526 -
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c          |   913 -
 drivers/gpu/drm/msm/msm_atomic.c                   |     4 +-
 drivers/gpu/drm/msm/msm_debugfs.c                  |    14 +-
 drivers/gpu/drm/msm/msm_drv.c                      |    23 +-
 drivers/gpu/drm/msm/msm_drv.h                      |    29 +-
 drivers/gpu/drm/msm/msm_fb.c                       |     3 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   212 +-
 drivers/gpu/drm/msm/msm_gem.h                      |   126 +-
 drivers/gpu/drm/msm/msm_gem_shrinker.c             |   166 +-
 drivers/gpu/drm/msm/msm_gpu.c                      |     2 +
 drivers/gpu/drm/msm/msm_gpu.h                      |     2 +
 drivers/gpu/drm/msm/msm_gpu_trace.h                |    13 +
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |    23 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |     8 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    40 +-
 drivers/gpu/drm/nouveau/nouveau_bo.h               |     2 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |     9 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |     3 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |     6 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c              |    12 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.h              |     8 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |     5 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |     3 +-
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |     9 +-
 drivers/gpu/drm/omapdrm/omap_drv.c                 |     9 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |    56 +-
 drivers/gpu/drm/panel/panel-lvds.c                 |     2 +-
 drivers/gpu/drm/panel/panel-novatek-nt35510.c      |     3 +-
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |     4 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0-dsi.c  |     1 -
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c        |     4 +-
 drivers/gpu/drm/panel/panel-simple.c               |    87 +-
 drivers/gpu/drm/panel/panel-sony-acx424akp.c       |     3 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c       |     4 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |    10 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.h        |     2 +
 drivers/gpu/drm/panfrost/panfrost_job.c            |    11 +-
 drivers/gpu/drm/panfrost/panfrost_mmu.c            |    39 +-
 drivers/gpu/drm/pl111/pl111_display.c              |     4 +-
 drivers/gpu/drm/qxl/qxl_cmd.c                      |     3 +-
 drivers/gpu/drm/qxl/qxl_display.c                  |   368 +-
 drivers/gpu/drm/qxl/qxl_draw.c                     |     8 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |     6 +-
 drivers/gpu/drm/qxl/qxl_dumb.c                     |     2 +-
 drivers/gpu/drm/qxl/qxl_gem.c                      |     2 +-
 drivers/gpu/drm/qxl/qxl_image.c                    |     2 +-
 drivers/gpu/drm/qxl/qxl_irq.c                      |     1 +
 drivers/gpu/drm/qxl/qxl_kms.c                      |    30 +-
 drivers/gpu/drm/qxl/qxl_object.c                   |    57 +-
 drivers/gpu/drm/qxl/qxl_object.h                   |     7 +-
 drivers/gpu/drm/qxl/qxl_prime.c                    |     4 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |    77 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |    35 +-
 drivers/gpu/drm/radeon/atombios_crtc.c             |    10 +-
 drivers/gpu/drm/radeon/nislands_smc.h              |    10 +-
 drivers/gpu/drm/radeon/r100.c                      |    84 +-
 drivers/gpu/drm/radeon/r300.c                      |    33 +-
 drivers/gpu/drm/radeon/r420.c                      |    28 +-
 drivers/gpu/drm/radeon/r600.c                      |    29 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |     6 +-
 drivers/gpu/drm/radeon/radeon.h                    |    31 +-
 drivers/gpu/drm/radeon/radeon_asic.h               |     8 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |    12 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    47 +-
 drivers/gpu/drm/radeon/radeon_dp_mst.c             |    23 +-
 drivers/gpu/drm/radeon/radeon_fence.c              |    42 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |    20 +-
 drivers/gpu/drm/radeon/radeon_ib.c                 |    26 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |     1 +
 drivers/gpu/drm/radeon/radeon_mode.h               |     2 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    12 +-
 drivers/gpu/drm/radeon/radeon_pm.c                 |    68 +-
 drivers/gpu/drm/radeon/radeon_ring.c               |    80 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |   135 +-
 drivers/gpu/drm/radeon/rs400.c                     |    25 +-
 drivers/gpu/drm/radeon/rs600.c                     |     8 +-
 drivers/gpu/drm/radeon/rv515.c                     |    56 +-
 drivers/gpu/drm/radeon/si_dpm.c                    |     5 +-
 drivers/gpu/drm/radeon/sislands_smc.h              |    10 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |    17 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |    20 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |    79 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |     2 +-
 drivers/gpu/drm/scheduler/sched_entity.c           |     8 +-
 drivers/gpu/drm/scheduler/sched_main.c             |   125 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |    41 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |    77 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |    75 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c              |     9 +-
 drivers/gpu/drm/stm/ltdc.c                         |    96 +-
 drivers/gpu/drm/sun4i/sun4i_backend.c              |     6 +-
 drivers/gpu/drm/sun4i/sun4i_layer.c                |    15 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c             |    59 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.h             |     5 +
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |    78 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.h             |    11 +
 drivers/gpu/drm/tegra/dc.c                         |   116 +-
 drivers/gpu/drm/tegra/dpaux.c                      |    11 +-
 drivers/gpu/drm/tegra/drm.c                        |     3 +
 drivers/gpu/drm/tegra/hub.c                        |    62 +-
 drivers/gpu/drm/tegra/plane.c                      |     4 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |     4 +
 drivers/gpu/drm/tidss/tidss_plane.c                |    53 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               |    39 +-
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              |     1 -
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |    46 +-
 drivers/gpu/drm/tiny/Kconfig                       |    10 +
 drivers/gpu/drm/tiny/Makefile                      |     1 +
 drivers/gpu/drm/tiny/arcpgu.c                      |   434 +
 drivers/gpu/drm/tiny/cirrus.c                      |    43 +-
 drivers/gpu/drm/tiny/gm12u320.c                    |    28 +-
 drivers/gpu/drm/tiny/hx8357d.c                     |     4 +-
 drivers/gpu/drm/tiny/ili9225.c                     |     4 +-
 drivers/gpu/drm/tiny/ili9341.c                     |     4 +-
 drivers/gpu/drm/tiny/ili9486.c                     |     4 +-
 drivers/gpu/drm/tiny/mi0283qt.c                    |     4 +-
 drivers/gpu/drm/tiny/repaper.c                     |     3 +-
 drivers/gpu/drm/tiny/st7586.c                      |     4 +-
 drivers/gpu/drm/tiny/st7735r.c                     |     4 +-
 drivers/gpu/drm/ttm/Makefile                       |     7 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |     2 +-
 drivers/gpu/drm/ttm/ttm_bo.c                       |   427 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    40 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |    24 +-
 drivers/gpu/drm/ttm/ttm_device.c                   |   268 +
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |     8 +-
 drivers/gpu/drm/ttm/ttm_module.c                   |    54 +-
 drivers/gpu/drm/ttm/ttm_module.h                   |     8 +-
 drivers/gpu/drm/ttm/ttm_pool.c                     |   157 +-
 drivers/gpu/drm/ttm/ttm_range_manager.c            |     4 +-
 drivers/gpu/drm/ttm/ttm_resource.c                 |    11 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |   114 +-
 drivers/gpu/drm/tve200/tve200_display.c            |     4 +-
 drivers/gpu/drm/udl/udl_modeset.c                  |    34 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |    42 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c              |    82 +-
 drivers/gpu/drm/vboxvideo/vbox_ttm.c               |     7 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |    17 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |    74 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c             |     2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c            |     1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c             |    19 +-
 drivers/gpu/drm/vkms/vkms_crtc.c                   |    11 +-
 drivers/gpu/drm/vkms/vkms_plane.c                  |    30 +-
 drivers/gpu/drm/vkms/vkms_writeback.c              |     7 +-
 drivers/gpu/drm/vmwgfx/Makefile                    |     2 +-
 drivers/gpu/drm/{ttm =3D> vmwgfx}/ttm_memory.c       |    23 +-
 .../ttm =3D> drivers/gpu/drm/vmwgfx}/ttm_memory.h    |     5 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c                |    25 +-
 drivers/gpu/drm/vmwgfx/ttm_object.h                |     3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |     5 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |    28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmd.c                |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |    14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf_res.c         |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |     3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |    45 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |    20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |    18 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   103 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h                |    10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |    14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |     4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |     2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |    16 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |    21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    20 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |    10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |     1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |    21 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c                |     1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |    69 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.c         |     5 +-
 drivers/gpu/drm/xen/Kconfig                        |    10 +-
 drivers/gpu/drm/xen/xen_drm_front_kms.c            |     3 +-
 drivers/gpu/drm/xlnx/zynqmp_disp.c                 |    32 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c                   |     2 +-
 drivers/gpu/drm/zte/zx_plane.c                     |    49 +-
 drivers/media/v4l2-core/v4l2-ioctl.c               |    85 +-
 drivers/video/fbdev/amba-clcd.c                    |    17 +-
 drivers/video/fbdev/core/fb_defio.c                |    35 -
 drivers/video/fbdev/core/fbmem.c                   |     4 -
 drivers/video/fbdev/efifb.c                        |     3 +
 drivers/video/fbdev/omap/hwa742.c                  |    42 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |     2 -
 drivers/video/fbdev/omap2/omapfb/omapfb.h          |     2 +-
 drivers/video/fbdev/simplefb.c                     |     5 +-
 include/drm/amd_asic_type.h                        |    15 +-
 include/drm/drm_atomic.h                           |     4 +
 include/drm/drm_displayid.h                        |    30 +-
 include/drm/drm_dp_helper.h                        |    55 +-
 include/drm/drm_drv.h                              |     2 +-
 include/drm/drm_edid.h                             |     3 +
 include/drm/drm_encoder.h                          |    18 +
 include/drm/drm_gem_atomic_helper.h                |   113 +
 include/drm/drm_gem_framebuffer_helper.h           |     7 -
 include/drm/drm_gem_vram_helper.h                  |     6 +-
 include/drm/drm_hdcp.h                             |     5 +-
 include/drm/drm_modeset_helper_vtables.h           |    31 +-
 include/drm/drm_plane.h                            |    25 +-
 include/drm/drm_print.h                            |    20 +-
 include/drm/drm_simple_kms_helper.h                |    29 +-
 include/drm/drm_vblank.h                           |     1 -
 include/drm/gpu_scheduler.h                        |    27 +-
 include/drm/gud.h                                  |   333 +
 include/drm/i915_pciids.h                          |    11 +
 include/drm/ttm/ttm_bo_api.h                       |    50 +-
 include/drm/ttm/ttm_bo_driver.h                    |   330 +-
 include/drm/ttm/ttm_device.h                       |   317 +
 include/drm/ttm/ttm_resource.h                     |     4 +-
 include/drm/ttm/ttm_tt.h                           |    14 +-
 include/linux/clk-provider.h                       |    30 +
 include/linux/dma-fence.h                          |     1 +
 include/linux/dma-heap.h                           |     9 +
 include/linux/fb.h                                 |     3 -
 include/linux/hdmi.h                               |     2 +-
 include/linux/interrupt.h                          |     4 +
 include/linux/lockdep.h                            |     5 +
 include/linux/platform_data/simplefb.h             |     1 +
 include/linux/vgaarb.h                             |     4 +-
 include/uapi/drm/amdgpu_drm.h                      |    34 +
 include/uapi/drm/drm.h                             |   125 +-
 include/uapi/drm/drm_mode.h                        |     3 +-
 include/uapi/drm/i915_drm.h                        |     1 +
 include/uapi/drm/msm_drm.h                         |     1 +
 include/uapi/linux/kfd_ioctl.h                     |     4 +-
 kernel/irq/manage.c                                |    11 +-
 lib/test_printf.c                                  |    18 +
 lib/vsprintf.c                                     |    39 +
 scripts/checkpatch.pl                              |     6 +-
 1147 files changed, 182648 insertions(+), 31933 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/bridge/chipone,icn6211.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/dw_hdm=
i.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 delete mode 100644
Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
 create mode 100644
Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
 create mode 100644
Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
 create mode 100644 Documentation/devicetree/bindings/display/fsl,lcdif.yam=
l
 create mode 100644
Documentation/devicetree/bindings/display/imx/fsl,imx6-hdmi.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/imx/hdmi.txt
 delete mode 100644 Documentation/devicetree/bindings/display/mxsfb.txt
 delete mode 100644 Documentation/devicetree/bindings/display/renesas,du.tx=
t
 create mode 100644 Documentation/devicetree/bindings/display/renesas,du.ya=
ml
 delete mode 100644
Documentation/devicetree/bindings/display/rockchip/dw_hdmi-rockchip.txt
 create mode 100644
Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
 create mode 100644 Documentation/gpu/rfc/index.rst
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/aldebaran_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
 mode change 100755 =3D> 100644
drivers/gpu/drm/amd/amdgpu/dimgrey_cavefish_reg_init.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/umc_v6_7.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_stat.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stat.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_outbox.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/dmub_srv_stat.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
 create mode 100644 drivers/gpu/drm/amd/include/aldebaran_ip_offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_offset=
.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_4_2_sh_mas=
k.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_7_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_1_7_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_offse=
t.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_2_sh_ma=
sk.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/sdma/sdma_4_4_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_2_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_13_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/thm/thm_13_0_2_off=
set.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/thm/thm_13_0_2_sh_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/umc/umc_6_7_0_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_6_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_2_6_0_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/aldebaran_ppsmc.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu13_driver_if_aldebaran.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/inc/smu_v13_0_pptable.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
 delete mode 100644 drivers/gpu/drm/arc/Kconfig
 delete mode 100644 drivers/gpu/drm/arc/Makefile
 delete mode 100644 drivers/gpu/drm/arc/arcpgu.h
 delete mode 100644 drivers/gpu/drm/arc/arcpgu_crtc.c
 delete mode 100644 drivers/gpu/drm/arc/arcpgu_drv.c
 delete mode 100644 drivers/gpu/drm/arc/arcpgu_hdmi.c
 delete mode 100644 drivers/gpu/drm/arc/arcpgu_regs.h
 delete mode 100644 drivers/gpu/drm/arc/arcpgu_sim.c
 delete mode 100644 drivers/gpu/drm/ast/ast_cursor.c
 create mode 100644 drivers/gpu/drm/bridge/chipone-icn6211.c
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt8912b.c
 create mode 100644 drivers/gpu/drm/drm_displayid.c
 create mode 100644 drivers/gpu/drm/drm_gem_atomic_helper.c
 delete mode 100644 drivers/gpu/drm/gma500/accel_2d.c
 delete mode 100644 drivers/gpu/drm/gma500/blitter.c
 delete mode 100644 drivers/gpu/drm/gma500/blitter.h
 create mode 100644 drivers/gpu/drm/gud/Kconfig
 create mode 100644 drivers/gpu/drm/gud/Makefile
 create mode 100644 drivers/gpu/drm/gud/gud_connector.c
 create mode 100644 drivers/gpu/drm/gud/gud_drv.c
 create mode 100644 drivers/gpu/drm/gud/gud_internal.h
 create mode 100644 drivers/gpu/drm/gud/gud_pipe.c
 create mode 100644 drivers/gpu/drm/i915/TODO.txt
 create mode 100644 drivers/gpu/drm/i915/display/g4x_dp.c
 create mode 100644 drivers/gpu/drm/i915/display/g4x_dp.h
 create mode 100644 drivers/gpu/drm/i915/display/g4x_hdmi.c
 create mode 100644 drivers/gpu/drm/i915/display/g4x_hdmi.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_fb.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_fb.h
 create mode 100644 drivers/gpu/drm/i915/display/skl_scaler.c
 create mode 100644 drivers/gpu/drm/i915/display/skl_scaler.h
 create mode 100644 drivers/gpu/drm/i915/display/skl_universal_plane.c
 create mode 100644 drivers/gpu/drm/i915/display/skl_universal_plane.h
 delete mode 100644 drivers/gpu/drm/i915/gem/i915_gem_fence.c
 create mode 100644 drivers/gpu/drm/i915/intel_step.c
 create mode 100644 drivers/gpu/drm/i915/intel_step.h
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll.c
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll.h
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm.c
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_28nm_8960.c
 delete mode 100644 drivers/gpu/drm/msm/dsi/pll/dsi_pll_7nm.c
 create mode 100644 drivers/gpu/drm/tiny/arcpgu.c
 create mode 100644 drivers/gpu/drm/ttm/ttm_device.c
 rename drivers/gpu/drm/{ttm =3D> vmwgfx}/ttm_memory.c (97%)
 rename {include/drm/ttm =3D> drivers/gpu/drm/vmwgfx}/ttm_memory.h (97%)
 create mode 100644 include/drm/drm_gem_atomic_helper.h
 create mode 100644 include/drm/gud.h
 create mode 100644 include/drm/ttm/ttm_device.h
