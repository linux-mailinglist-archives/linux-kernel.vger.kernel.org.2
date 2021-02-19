Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321EB31F4FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhBSGH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhBSGHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:07:15 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B1FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 22:06:34 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ly28so10150505ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 22:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vK+r8UOY7RBuEhV79d8NfdwCJ3gKygd8k1BvS5p7UwI=;
        b=FNIJQlp9mz5lXTMSxgZf18Qb9OtN3mK3gvFZlCVuSvu/F4zBQEybu7i7onWIGMyftj
         /gt45nzubBF6Ya/+wxQJ442+S+DUFffjk3wYZ2dZmQQeggBXdzeUMs3Oi7AqXMOy18ta
         Rqcoe56OmeIDSVqefaw7OdW9gbDz9H+qYV2LBK6hJN5Hh90XMR4WJf17y3q8PrfeUUZP
         YdGOy0ctK2ZCRObLhocsg+QPRvvmgxKJUpi5pIi3wUzgrT2zzv01Kd5WLLlZjElfJlUL
         4erNbJuBDFaSg0f/CjaiUWu90KZJkcMWpm5hty+Ul8A8NVr/gtMzLde35yo3LmdjXZ2I
         VCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=vK+r8UOY7RBuEhV79d8NfdwCJ3gKygd8k1BvS5p7UwI=;
        b=kb/oQqthdx9levtcZ2g2CQdJDm1we775kIiRbrTpn/l69lGwJUEhr5UplIe1ljwiW/
         +N1AYL6QjUJUr52mSnLic1uxKhZuKLF8WbexSt3Cujwe2nUXkrKJLFiydNQTHHTgbUtO
         cWC+V47zSXpX7pLA6q70z5gKWP8j66Fvhzj46+SZP9lucJUUTrYxxjyg3SZroFmBcjLW
         Q+Au+ae7WPdfYdkug1LcQ8q94YeTb4GYWufE0qB+OA7tfyfp07OhvmLz/6rUx6s5EkW9
         ED7DHagJd0Fd7V3Sm28aIJ3FK4MNdSubTuYZam42Oh2LrRDBMcOLrh5EVUT0WBU7JuCX
         vTWA==
X-Gm-Message-State: AOAM530cPCl6Jc+ziRtTqfy5WwBB9UfjFfSwHK9WUXjQvDoulQqBmY6H
        Dujqli4dRivdfYXmTageecCOjEKeV+bUUHe13T0=
X-Google-Smtp-Source: ABdhPJzZfppE9wJdBpE5GTFNHBSL0G/a1cHOeYMLX5dtk0iiYNjU+LHK/4KxICUawx5QJGBQJTVLiEY0z1o7Cl6c2aM=
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr7530623ejc.419.1613714792106;
 Thu, 18 Feb 2021 22:06:32 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 19 Feb 2021 16:06:19 +1000
Message-ID: <CAPM=9txd-x1NKWK9BBqVTDNOR00zNqcXgs76YJrDfL94eMLYqQ@mail.gmail.com>
Subject: [git pull] drm for 5.12-rc1
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

This is the main drm pull request for 5.12-rc1. Hopefully you get
power/internet back soon to process it.

There are a bunch of conflicts but mostly trivial, I've place a merged tree=
 at
https://cgit.freedesktop.org/~airlied/linux/log/?h=3Ddrm-next-5.11-merged
However I merged a couple of fixes after this but I don't think they
should affect the merge resolutions.

Otherwise it's a pretty normal tree, lots of refactoring across the
board, ttm, i915, nouveau, and bunch of features in various drivers.

Let me know if there are any issues,

Regards,
Dave.

drm-next-2021-02-19:
drm pull for 5.12-rc1

docs:
- lots of updated docs

core:
- require crtc to have unique primary plane
- fourcc macro fix
- PCI bar quirk for bar resizing
- don't sent hotplug on error
- move vm code to legacy
- nuke hose only used on old oboslete alpha

dma-buf:
- kernel doc updates
- improved lock tracking

dp/hdmi:
- DP-HDMI2.1 protocol converter support

ttm:
- bo size handling cleanup
- release a pinned bo warning
- cleanup lru handler
- avoid using pages with drm_prime_sg_to_page_addr_arrays

cma-helper:
- prime/mmap fixes

bridge:
- add DP support

gma500:
- remove gma3600 support

i915:
- try eDP fast/narrow link again with fallback
- Intel eDP backlight control
- replace display register read/write macros
- refactor intel_display.c
- display power improvements
- HPD code cleanup
- Rocketlake display fixes
- Power/backlight/RPM fixes
- DG1 display fix
- IVB/BYT clear residuals security fix again
- make i915 mitigations options via parameter
- HSW GT1 GPU hangs fixes
- DG1 workaround hang fixes
- TGL DMAR hang avoidance
- Lots of GT fixes
- follow on fixes for residuals clear
- gen7 per-engine-reset support
- HDCP2.2 + HDCP1.4 GEN12 DP MST support
- TGL clear color support
- backlight refactoring
- VRR/Adaptive sync enabling on DP/EDP for TGL+
- async flips for all ilk+

amdgpu:
- rework IH ring handling (Vega/Navi)
- rework HDP handling (Vega/Navi)
- swSMU updates for renoir/vangogh
- Sienna Cichild overdrive support
- FP16 on DCE8-11 support
- GPU reset on navy flounder/vangogh
- SMU profile fixes for APU
- SR-IOV fixes
- Vangogh SMU fixes
- fan speed control fixes

amdkfd:
- config handling fix
- buffer free fix
- recursive lock warnings fix

nouveau:
- Turing MMU fault recovery fixes
- mDP connectors reporting fix
- audio locking fixes
- rework engines/instances code to support new scheme

tegra:
- VIC newer firmware support
- display/gr2d fixes for older tegra
- pm reference leak fix

mediatek:
- SOC MT8183 support
- decouple sub driver + share mtk mutex driver

radeon:
- PCI resource fix for some platforms

ingenic:
- pm support
- 8-bit delta RGB panels

vmwgfx:
- managed driver helpers

vc4:
- BCM2711 DSI1 support
- converted to atomic helpers
- enable 10/12 bpc outputs
- gem prime mmap helpers
- CEC fix

omap:
- use degamma table
- CTM support
- rework DSI support

imx:
- stack usage fixes
- drm managed support
- imx-tve clock provider leak fix

rcar-du:
- default mode fixes
- conversion to managed API

hisilicon:
- use simple encoder

vkms:
- writeback connector support

d3:
- BT2020 support
The following changes since commit 6ee1d745b7c9fd573fba142a2efdad76a9f1cb04=
:

  Linux 5.11-rc5 (2021-01-24 16:47:14 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-02-19

for you to fetch changes up to f730f39eb981af249d57336b47cfe3925632a7fd:

  Merge tag 'drm-intel-next-fixes-2021-02-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2021-02-19
13:55:07 +1000)

----------------------------------------------------------------
drm pull for 5.12-rc1

docs:
- lots of updated docs

core:
- require crtc to have unique primary plane
- fourcc macro fix
- PCI bar quirk for bar resizing
- don't sent hotplug on error
- move vm code to legacy
- nuke hose only used on old oboslete alpha

dma-buf:
- kernel doc updates
- improved lock tracking

dp/hdmi:
- DP-HDMI2.1 protocol converter support

ttm:
- bo size handling cleanup
- release a pinned bo warning
- cleanup lru handler
- avoid using pages with drm_prime_sg_to_page_addr_arrays

cma-helper:
- prime/mmap fixes

bridge:
- add DP support

gma500:
- remove gma3600 support

i915:
- try eDP fast/narrow link again with fallback
- Intel eDP backlight control
- replace display register read/write macros
- refactor intel_display.c
- display power improvements
- HPD code cleanup
- Rocketlake display fixes
- Power/backlight/RPM fixes
- DG1 display fix
- IVB/BYT clear residuals security fix again
- make i915 mitigations options via parameter
- HSW GT1 GPU hangs fixes
- DG1 workaround hang fixes
- TGL DMAR hang avoidance
- Lots of GT fixes
- follow on fixes for residuals clear
- gen7 per-engine-reset support
- HDCP2.2 + HDCP1.4 GEN12 DP MST support
- TGL clear color support
- backlight refactoring
- VRR/Adaptive sync enabling on DP/EDP for TGL+
- async flips for all ilk+

amdgpu:
- rework IH ring handling (Vega/Navi)
- rework HDP handling (Vega/Navi)
- swSMU updates for renoir/vangogh
- Sienna Cichild overdrive support
- FP16 on DCE8-11 support
- GPU reset on navy flounder/vangogh
- SMU profile fixes for APU
- SR-IOV fixes
- Vangogh SMU fixes
- fan speed control fixes

amdkfd:
- config handling fix
- buffer free fix
- recursive lock warnings fix

nouveau:
- Turing MMU fault recovery fixes
- mDP connectors reporting fix
- audio locking fixes
- rework engines/instances code to support new scheme

tegra:
- VIC newer firmware support
- display/gr2d fixes for older tegra
- pm reference leak fix

mediatek:
- SOC MT8183 support
- decouple sub driver + share mtk mutex driver

radeon:
- PCI resource fix for some platforms

ingenic:
- pm support
- 8-bit delta RGB panels

vmwgfx:
- managed driver helpers

vc4:
- BCM2711 DSI1 support
- converted to atomic helpers
- enable 10/12 bpc outputs
- gem prime mmap helpers
- CEC fix

omap:
- use degamma table
- CTM support
- rework DSI support

imx:
- stack usage fixes
- drm managed support
- imx-tve clock provider leak fix
-

rcar-du:
- default mode fixes
- conversion to managed API

hisilicon:
- use simple encoder

vkms:
- writeback connector support

d3:
- BT2020 support

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3

Abaci Team (1):
      drm/amd/display: Simplify bool conversion

Aditya Swarup (3):
      drm/i915/tgl: Fix REVID macros for TGL to fetch correct stepping
      drm/i915/tgl: Add bound checks and simplify TGL REVID macros
      drm/i915/display/dp: Attach and set drm connector VRR property

Alex Deucher (30):
      drm/amdgpu: fix handling of irq domains on soc15 and newer GPUs
      drm/amdkfd: check both client id and src id in interrupt handlers
      drm/amdgpu: take runtime pm reference when we attach a buffer
      drm/amdgpu/display: drop DCN support for aarch64
      Revert "drm/amd/display: Fix memory leaks in S3 resume"
      drm/amdgpu/display: fix build with CONFIG_DRM_AMD_DC_DCN disabled
      MAINTAINERS: update radeon/amdgpu/amdkfd git trees
      drm/amdgpu: add mode2 reset support for vangogh
      drm/amdgpu/nv: add mode2 reset handling
      drm/amdgpu: fix mode2 reset sequence for vangogh
      drm/amdgpu: Enable GPU reset for vangogh
      drm/amdgpu: disable gpu reset on Vangogh for now
      Revert "drm/amdgpu/swsmu: drop set_fan_speed_percent (v2)"
      drm/amdgpu/swsmu: use percent rather than rpm for manual fan control =
(v2)
      Revert "drm/amd/display: fix unused variable warning"
      drm/amdgpu/smu12: fix power reporting on renoir
      drm/amdgpu/gmc9: fix mmhub client mapping for arcturus
      drm/amdgpu/si: minor clean up of reset code
      drm/amdgpu/cik: minor clean up of reset code
      drm/amdgpu/vi: minor clean up of reset code
      drm/amdgpu: add generic pci reset as an option
      drm/amdgpu/si: add PCI reset support
      drm/amdgpu/soc15: add PCI reset support
      drm/amdgpu/nv: add PCI reset support
      drm/amdgpu: drop extra drm_kms_helper_poll_enable/disable calls
      drm/amdgpu: use runpm flag rather than fbcon for kfd runtime suspend =
(v2)
      drm/amdgpu: reset runpm flag if device suspend fails
      Revert "drm/amd/display: Update NV1x SR latency values"
      drm/radeon: OLAND boards don't have VCE
      drm/amdgpu: Set reference clock to 100Mhz on Renoir (v2)

Alexandre Demers (1):
      drm/amdgpu: fix DRM_INFO flood if display core is not supported
(bug 210921)

Alistair Popple (5):
      drm/nouveau/mc/tu102: Fix MMU fault interrupts on Turing
      drm/nouveau/mc/tu102: Remove Turing interrupt hack
      drm/nouveau/fifo/tu102: Move Turing specific FIFO functions
      drm/nouveau/fifo/tu102: FIFO interrupt fixes for Turing
      drm/nouveau/fifo/tu102: Turing channel preemption fix

Andres Calderon Jaramillo (1):
      drm/i915/display: Prevent double YUV range correction on HDR planes

Andrey Grodzovsky (2):
      drm: Unamp the entire device address space on device unplug
      drm/sched: Cancel and flush all outstanding jobs before finish.

Ankit Nautiyal (11):
      drm/edid: Parse DSC1.2 cap fields from HFVSDB block
      drm/dp_helper: Add Helpers for FRL Link Training support for
DP-HDMI2.1 PCON
      drm/dp_helper: Add support for Configuring DSC for HDMI2.1 Pcon
      drm/dp_helper: Add helpers to configure PCONs RGB-YCbCr Conversion
      drm/i915: Capture max frl rate for PCON in dfp cap structure
      drm/i915: Add support for starting FRL training for HDMI2.1 via PCON
      drm/i915: Check for FRL training before DP Link training
      drm/i915: Read DSC capabilities of the HDMI2.1 PCON encoder
      drm/i915: Add helper functions for calculating DSC parameters for HDM=
I2.1
      drm/i915/display: Configure PCON for DSC1.1 to DSC1.2 encoding
      drm/i915/display: Let PCON convert from RGB to YCbCr if it can

Anshuman Gupta (22):
      drm/i915/pps: Reuse POWER_DOMAIN_DISPLAY_CORE in pps_{lock, unlock}
      drm/i915/hdcp: Update CP property in update_pipe
      drm/i915/hdcp: Get conn while content_type changed
      drm/i915/hotplug: Handle CP_IRQ for DP-MST
      drm/i915/hdcp: No HDCP when encoder is't initialized
      drm/i915/hdcp: DP MST transcoder for link and stream
      drm/i915/hdcp: Move HDCP enc status timeout to header
      drm/i915/hdcp: HDCP stream encryption support
      drm/i915/hdcp: Configure HDCP1.4 MST steram encryption status
      drm/i915/hdcp: Enable Gen12 HDCP 1.4 DP MST support
      drm/i915/hdcp: Pass dig_port to intel_hdcp_init
      drm/i915/hdcp: Encapsulate hdcp_port_data to dig_port
      misc/mei/hdcp: Fix AUTH_STREAM_REQ cmd buffer len
      drm/hdcp: Max MST content streams
      drm/i915/hdcp: MST streams support in hdcp port_data
      drm/i915/hdcp: Pass connector to check_2_2_link
      drm/i915/hdcp: Add HDCP 2.2 stream register
      drm/i915/hdcp: Support for HDCP 2.2 MST shim callbacks
      drm/i915/hdcp: Configure HDCP2.2 MST steram encryption status
      drm/i915/hdcp: Enable HDCP 2.2 MST support
      drm/i915/hdcp: Fix WARN_ON(data->k > INTEL_NUM_PIPES)
      drm/i915/hdcp: Fix uninitialized symbol

Anthony Koo (5):
      drm/amd/display: [FW Promotion] Release 0.0.48
      drm/amd/display: [FW Promotion] Release 0.0.49
      drm/amd/display: fix calculation for the pwl backlight curve
      drm/amd/display: [FW Promotion] Release 0.0.50
      drm/amd/display: [FW Promotion] Release 0.0.51

Aric Cyr (7):
      drm/amd/display: 3.2.117
      drm/amd/display: 3.2.118
      drm/amd/display: Allow PSTATE chnage when no displays are enabled
      drm/amd/display: 3.2.119
      drm/amd/display: 3.2.120
      drm/amd/display: 3.2.121
      drm/amd/display: 3.2.122

Arnd Bergmann (5):
      drm/kmb: fix array bounds warning
      drm/i915: fix shift warning
      drm/amd/display: Fix unused variable warning
      amdgpu: fix clang build warning
      drm/amd/display: fix unused variable warning

Arunpravin (1):
      drm/amd/pm: store and reinstate swsmu user power configurations

Ben Skeggs (90):
      drm/nouveau/kms/nv50-gp1xx: wait for less EVO pushbuf space for
core updates without notify
      drm/nouveau/kms/gv100-: wait for less NVD pushbuf space for core
updates without notify
      drm/nouveau/kms/nv50-: add module option to select EVO/NVD push
buffer location
      drm/nouveau/engine: use refcount_t + private mutex
      drm/nouveau/fb: protect comptags with private mutex
      drm/nouveau/fb: protect vram mm with private mutex
      drm/nouveau/instmem: protect mm/lru with private mutex
      drm/nouveau/ltc: serialise cbc operations with private mutex
      drm/nouveau/mmu: serialise mmu invalidations with private mutex
      drm/nouveau/pmu: serialise send() with private mutex
      drm/nouveau/disp: use private spinlock to control exclusive access to=
 disp
      drm/nouveau/fifo: private mutex
      drm/nouveau/perfmon: use private spinlock to control exclusive
access to perfmon
      drm/nouveau/subdev: remove nvkm_subdev.mutex
      drm/nouveau/subdev: store subdevs in list
      drm/nouveau/subdev: store full subdev name in struct
      drm/nouveau/subdev: track type+instance separately
      drm/nouveau/device: pass instance id when looking up a subdev/engine
      drm/nouveau/nvkm: add macros for subdev layout
      drm/nouveau/acr: switch to instanced constructor
      drm/nouveau/bar: switch to instanced constructor
      drm/nouveau/bios: switch to instanced constructor
      drm/nouveau/bus: switch to instanced constructor
      drm/nouveau/clk: switch to instanced constructor
      drm/nouveau/devinit: switch to instanced constructor
      drm/nouveau/fault: switch to instanced constructor
      drm/nouveau/fb: switch to instanced constructor
      drm/nouveau/fuse: switch to instanced constructor
      drm/nouveau/gpio: switch to instanced constructor
      drm/nouveau/gsp: switch to instanced constructor
      drm/nouveau/i2c: switch to instanced constructor
      drm/nouveau/ibus: switch to instanced constructor
      drm/nouveau/iccsense: switch to instanced constructor
      drm/nouveau/instmem: switch to instanced constructor
      drm/nouveau/ltc: switch to instanced constructor
      drm/nouveau/top: store device type and instance separately
      drm/nouveau/top: expose parsed device info more directly
      drm/nouveau/mc: switch to instanced constructor
      drm/nouveau/mc: lookup subdev interrupt handlers with split type+inst
      drm/nouveau/mc: use split type+inst in device reset APIs
      drm/nouveau/mc: use split type+inst in interrupt masking API
      drm/nouveau/mc: use split type+inst when handling dev_top interrupts
      drm/nouveau/mmu: switch to instanced constructor
      drm/nouveau/mmu: index engref by subdev type
      drm/nouveau/mxm: switch to instanced constructor
      drm/nouveau/pci: switch to instanced constructor
      drm/nouveau/pmu: switch to instanced constructor
      drm/nouveau/therm: switch to instanced constructor
      drm/nouveau/therm/gk104: use split subdev type+inst in cg engine list=
s
      drm/nouveau/tmr: switch to instanced constructor
      drm/nouveau/top: switch to instanced constructor
      drm/nouveau/volt: switch to instanced constructor
      drm/nouveau/bsp,vp: switch to instanced constructor
      drm/nouveau/falcon: use split type+inst when looking up PRI addr
      drm/nouveau/ce: switch to instanced constructor
      drm/nouveau/ce: make use of nvkm_subdev.inst
      drm/nouveau/cipher: switch to instanced constructor
      drm/nouveau/disp: switch to instanced constructor
      drm/nouveau/dma: switch to instanced constructor
      drm/nouveau/fifo: switch to instanced constructor
      drm/nouveau/fifo: add engine_id hook
      drm/nouveau/fifo: index base engctx by engine id
      drm/nouveau/fifo: index backend engctx by engine id
      drm/nouveau/fifo: add id_engine hook
      drm/nouveau/fifo: turn chan subdev mask into engine mask
      drm/nouveau/fifo: use type+inst to determine context pointer offsets
      drm/nouveau/fifo/gf100: use fifo engine id for engine recovery mask
      drm/nouveau/fifo/gf100-: switch static mmu fault id list to type+inst
      drm/nouveau/fifo/gk104-: switch dev_top fault handling to type+inst
      drm/nouveau/fifo/gk104-: remove use of subdev index in runlist
topology info
      drm/nouveau/gr: switch to instanced constructor
      drm/nouveau/ifb: switch to instanced constructor
      drm/nouveau/me: switch to instanced constructor
      drm/nouveau/mpeg: switch to instanced constructor
      drm/nouveau/msenc: switch to instanced constructor
      drm/nouveau/mspdec: switch to instanced constructor
      drm/nouveau/msppp: switch to instanced constructor
      drm/nouveau/msvld: switch to instanced constructor
      drm/nouveau/nvdec: switch to instanced constructor
      drm/nouveau/nvenc: switch to instanced constructor
      drm/nouveau/pm: switch to instanced constructor
      drm/nouveau/sec: switch to instanced constructor
      drm/nouveau/sec2: switch to instanced constructor
      drm/nouveau/sw: switch to instanced constructor
      drm/nouveau/vic: switch to instanced constructor
      drm/nouveau/nvkm: determine subdev id/order from layout
      drm/nouveau/nvkm: remove nvkm_subdev.index
      drm/nouveau/privring: rename from ibus
      drm/nouveau/top: add ioctrl/nvjpg
      drm/nouveau/top/ga100: initial support

Bernard Zhao (3):
      via/via_irq: use __func__ to replace string function name
      amd/display: remove unneeded variable: "pattern"
      drm/vc4: remove unneeded variable: "ret"

Bhawanpreet Lakha (8):
      drm/amd/display: enable idle optimizations for linux (MALL stutter)
      drm/amd/display: enable HUBP blank behaviour
      drm/amd/display: Fix deadlock during gpu reset v3
      drm/amd/display: Enable programing of MALL watermarks
      drm/amd/display: Dynamic cursor cache size for MALL eligibility check
      drm/amd/display: Update dcn30_apply_idle_power_optimizations() code
      drm/amd/display: reuse current context instead of recreating one
      drm/amd/display: Fix unused variable warning

Bing Guo (2):
      drm/amd/display: Change function decide_dp_link_settings to
avoid infinite looping
      drm/amd/display: Fix
dml20v2_ModeSupportAndSystemConfigurationFull() to check DesiredBPP.

Brendan Steve Leder (1):
      drm/amd/display: initialize i2c speed if not initialized in
dcnxxx__resource.c

CK Hu (15):
      drm/mediatek: Separate getting larb device to a function
      drm/mediatek: Move clk info from struct mtk_ddp_comp to sub
driver private data
      drm/mediatek: Move regs info from struct mtk_ddp_comp to sub
driver private data
      drm/mediatek: Remove irq in struct mtk_ddp_comp
      drm/mediatek: Use struct cmdq_client_reg to gather cmdq variable
      drm/mediatek: Move cmdq_reg info from struct mtk_ddp_comp to sub
driver private data
      drm/mediatek: Change sub driver interface from mtk_ddp_comp to device
      drm/mediatek: Register vblank callback function
      drm/mediatek: DRM driver directly refer to sub driver's function
      drm/mediatek: Move mtk_ddp_comp_init() from sub driver to DRM driver
      drm/mediatek: Remove redundant file including
      drm/mediatek: Rename file mtk_drm_ddp to mtk_mutex
      drm/mediatek: Change disp/ddp term to mutex in mtk mutex driver
      drm/mediatek: Automatically search unclaimed mtk mutex in mtk_mutex_g=
et()
      soc / drm: mediatek: Move mtk mutex driver to soc folder

CQ Tang (1):
      drm/i915/error: Fix object page offset within a region

Charlene Liu (1):
      drm/amd/display: change SMU repsonse timeout to 2s

Chen Li (2):
      drm/radeon: use writel to avoid gcc optimization v3
      drm/amdgpu: use GTT for uvd_get_create/destory_msg

Chenyang Li (1):
      drm/amdgpu: Fix macro name _AMDGPU_TRACE_H_ in preprocessor if condit=
ion

Chia-I Wu (3):
      drm/virtio: align blob resources to page sizes
      drm/virtio: make sure context is created in gem open
      drm/virtio: fix prime export for vram objects

Chiawen Huang (1):
      drm/amd/display: removed unnecessary check when dpp clock increasing

Chris Wilson (164):
      drm/i915/gt: Ignore dt=3D=3D0 for reporting underflows
      drm/i915/gt: Remember to free the virtual breadcrumbs
      drm/i915/gvt: Remove incorrect kerneldoc marking
      drm/i915/gt: Include semaphore status in print_request()
      drm/i915: Lift i915_request_show()
      drm/i915/gt: Update request status flags for debug pretty-printer
      drm/i915/gt: Show all active timelines for debugging
      drm/i915: Lift waiter/signaler iterators
      drm/i915/gem: Remove incorrect early dbg print
      drm/i915/selftests: Improve granularity for mocs reset checks
      drm/i915/selftests: Small tweak to put the termination conditions tog=
ether
      drm/i915/gt: Plug IPS into intel_rps_set
      drm/i915/gt: Defer enabling the breadcrumb interrupt to after submiss=
ion
      drm/i915/gt: Track signaled breadcrumbs outside of the breadcrumb spi=
nlock
      drm/i915/gt: Don't cancel the interrupt shadow too early
      drm/i915/gt: Free stale request on destroying the virtual engine
      drm/i915/gt: Program mocs:63 for cache eviction on gen9
      drm/i915/gt: Decouple completed requests on unwind
      drm/i915/gt: Check for a completed last request once
      drm/i915/gt: Protect context lifetime with RCU
      drm/i915/gt: Split the breadcrumb spinlock between global and context=
s
      drm/i915/gt: Move the breadcrumb to the signaler if completed upon ca=
ncel
      drm/i915/gt: Declare gen9 has 64 mocs entries!
      Revert "drm/i915: re-order if/else ladder for hpd_irq_setup"
      drm/i915/display: Suppress "Combo PHY A HW state changed unexpectedly=
"
      drm/i915/gt: Limit frequency drop to RPe on parking
      drm/i915/gem: Differentiate oom failures from invalid map types
      drm/i915/gem: Report error for vmap() failure
      drm/i915/selftests: Tidy prng constructor for client blits
      drm/i915/gem: Limit lmem scatterlist elements to UINT_MAX
      Revert "drm/i915/lmem: Limit block size to 4G"
      drm/i915/display: Record the plane update times for debugging
      drm/i915/gem: Spring clean debugfs
      drm/i915/gem: Propagate error from cancelled submit due to context cl=
osure
      drm/i915/gt: Ignore repeated attempts to suspend request flow across =
reset
      drm/i915/gt: Cancel the preemption timeout on responding to it
      drm/i915/gt: Include reset failures in the trace
      drm/i915/gt: Clear the execlists timers upon reset
      drm/i915: Disable outputs during unregister
      drm/i915/selftests: Improve error reporting for igt_mock_max_segment
      drm/i915/gem: Drop false !i915_vma_is_closed assertion
      drm/i915: Remove livelock from "do_idle_maps" vtd w/a
      drm/i915: Sleep around performing iommu unmaps on Tigerlake
      drm/i915/gt: Remove uninterruptible parameter from intel_gt_wait_for_=
idle
      drm/i915/gt: Move move context layout registers and offsets to lrc_re=
g.h
      drm/i915/gt: Rename lrc.c to execlists_submission.c
      drm/i915/gt: Mark legacy ring context as lost
      drm/i915/gt: Wean workaround selftests off GEM context
      drm/i915: Fix mismatch between misplaced vma check and vma insert
      drm/i915/gem: Drop free_work for GEM contexts
      drm/i915/gt: Move gen8 CS emitters into gen8_engine_cs.h
      drm/i915: Encode fence specific waitqueue behaviour into the wait.fla=
gs
      drm/i915/gt: Drain the breadcrumbs just once
      drm/i915/gt: Track the overall awake/busy time
      drm/i915: Check for rq->hwsp validity after acquiring RCU lock
      drm/i915/gt: Another tweak for flushing the tasklets
      drm/i915/gt: Split logical ring contexts from execlist submission
      drm/i915/gt: Provide a utility to create a scratch buffer
      drm/i915/gt: Track all timelines created using the HWSP
      drm/i915/selftests: Kick timeslice until selftest yields
      drm/i915/selftests: Flush the preemption request before waiting
      drm/i915/selftests: Be paranoid and flush the tasklet before
checking status
      drm/i915: Use cmpxchg64 for 32b compatilibity
      drm/i915/uc: Squelch load failure error message
      drm/i915/selftests: Remove redundant live_context for eviction
      drm/i915/selftests: Confirm CS_TIMESTAMP / CTX_TIMESTAMP share a cloc=
k
      drm/i915/gt: Consolidate the CS timestamp clocks
      drm/i915/gt: Prefer recycling an idle fence
      drm/i915/gem: Optimistically prune dma-resv from the shrinker.
      drm/i915/gt: Replace direct submit with direct call to tasklet
      drm/i915/gt: Use virtual_engine during execlists_dequeue
      drm/i915/gt: Decouple inflight virtual engines
      drm/i915/gt: Defer schedule_out until after the next dequeue
      drm/i915/gt: Remove virtual breadcrumb before transfer
      drm/i915/gt: Shrink the critical section for irq signaling
      drm/i915/gt: Resubmit the virtual engine on schedule-out
      drm/i915/gt: Simplify virtual engine handling for execlists_hold()
      drm/i915/gt: ce->inflight updates are now serialised
      drm/i915/gt: Refactor heartbeat request construction and submission
      drm/i915/gt: Define guc firmware blob for older Cometlakes
      drm/i915/gem: Peek at the inflight context
      drm/i915/gt: Taint the reset mutex with the shrinker
      drm/i915/dp: Track pm_qos per connector
      drm/i915/gt: Cancel submitted requests upon context reset
      drm/i915/gt: Pull context closure check from request submit to schedu=
le-in
      drm/i915: Drop i915_request.lock requirement for intel_rps_boost()
      drm/i915/gt: Rearrange snb workarounds
      drm/i915/gt: Rearrange hsw workarounds
      drm/i915/selftests: Guard against redifinition of SZ_8G
      drm/i915/selftests: Set error returns
      drm/i915: Set rawclk earlier during mmio probe
      drm/i915/gt: Allow failed resets without assertion
      drm/i915/gt: Check the virtual still matches upon locking
      drm/i915/selftests: Switch 4k kmalloc to use get_free_page for alignm=
ent
      drm/i915/selftests: Break out of the lrc layout test after
register mismatch
      drm/i915/selftests: Improve handling of iomem around stolen
      drm/i915: Wrap our timer_list.expires checking
      drm/i915/gt: Remove timeslice suppression
      drm/i915: Disable RPM wakeref assertions during driver shutdown
      drm/i915/gt: Prevent use of engine->wa_ctx after error
      drm/i915/selftests: Skip unstable timing measurements
      drm/i915/selftests: Rearrange ktime_get to reduce latency against CS
      drm/i915/gt: Restore ce->signal flush before releasing virtual engine
      drm/i915/gt: Only retire on the last breadcrumb if the last request
      drm/i915/gt: Only disable preemption on gen8 render engines
      drm/i915/gt: Disable arbitration on no-preempt requests
      drm/i915/gt: Exercise lrc_wa_ctx initialisation failure
      drm/i915/gt: Remove unused function 'dword_in_page'
      drm/i915/gt: Mark up a debug-only function
      drm/i915: Refactor marking a request as EIO
      drm/i915/gt: Disable arbitration around Braswell's pdp updates
      drm/i915/selftests: Include engine name after reset failure
      drm/i915/gt: Limit VFE threads based on GT
      drm/i915/gt: Restore clear-residual mitigations for Ivybridge, Baytra=
il
      drm/i915: Allow the sysadmin to override security mitigations
      drm/i915/gem: Remove stolen node before releasing the region
      drm/i915/selftests: Allow huge_gem_object to kick the shrinker
      drm/i915/gt: Check for arbitration after writing start seqno
      drm/i915/gt: Perform an arbitration check before busywaiting
      drm/i915/selftests: Force a failed engine reset
      drm/i915/selftests: Bump the scheduling error threshold for fast
heartbeats
      drm/i915/gt: Replace open-coded intel_engine_stop_cs()
      drm/i915/gt: Rearrange vlv workarounds
      drm/i915/gt: Rearrange ivb workarounds
      drm/i915/gt: Reapply ppgtt enabling after engine resets
      drm/i915/gt: Prune 'inline' from execlists
      drm/i915/gt: Prune inlines
      drm/i915: Mark up protected uses of 'i915_request_completed'
      drm/i915: Drop i915_request.lock serialisation around await_start
      drm/i915/gem: Reduce ctx->engine_mutex for reading the clone source
      drm/i915/gem: Reduce ctx->engines_mutex for get_engines()
      drm/i915: Reduce test_and_set_bit to set_bit in i915_request_submit()
      drm/i915/display: Bitwise or the conversion colour specifier together
      drm/i915/gt: Drop atomic for engine->fw_active tracking
      drm/i915/gt: Extract busy-stats for ring-scheduler
      drm/i915/gt: Convert stats.active to plain unsigned int
      drm/i915/gt: Clear CACHE_MODE prior to clearing residuals
      drm/i915/gt: Add arbitration check before semaphore wait
      drm/i915: Add DEBUG_GEM to the recommended CI config
      drm/i915: Make GEM errors non-fatal by default
      drm/i915/gt: One more flush for Baytrail clear residuals
      drm/i915/selftests: Prepare the selftests for engine resets with
ring submission
      drm/i915/gt: Lift stop_ring() to reset_prepare
      drm/i915/gt: Disable the ring before resetting HEAD/TAIL
      drm/i915/gt: Pull ring submission resume under its caller forcewake
      drm/i915: Mark per-engine-reset as supported on gen7
      drm/i915/gem: Remove per-client stats from debugfs/i915_gem_objects
      drm/i915/gem: Make i915_gem_object_flush_write_domain() static
      drm/i915/display: Apply interactive priority to explicit flip fences
      drm/i915/gt: Close race between enable_breadcrumbs and cancel_breadcr=
umbs
      drm/i915/gem: Almagamate clflushes on suspend
      drm/i915/gem: Almagamate clflushes on freeze
      drm/i915/gem: Move stolen node into GEM object union
      drm/i915/gem: Use shrinkable status for unknown swizzle quirks
      drm/i915/gem: Protect used framebuffers from casual eviction
      drm/i915/gem: Drop lru bumping on display unpinning
      drm/i915/gt: Do not suspend bonded requests if one hangs
      drm/i915/gt: Skip over completed active execlists, again
      drm/i915/gvt: Add missing forward decl of intel_vgpu for HDRTEST
      drm/i915: Restrict DRM_I915_DEBUG to developer builds
      drm/i915/gem: Move freeze/freeze_late next to suspend/suspend_late
      drm/i915: Disable atomics in L3 for gen9
      drm/i915/gt: Flush before changing register state
      drm/i915/gt: Correct surface base address for renderclear

Christian K=C3=B6nig (14):
      drm/radeon: fix check order in radeon_bo_move
      drm/radeon: stop using pages with drm_prime_sg_to_page_addr_arrays v2
      drm/amdgpu: stop using pages with drm_prime_sg_to_page_addr_arrays
      drm/nouveau: stop using pages with drm_prime_sg_to_page_addr_arrays v=
2
      drm/vmwgfx: switch to ttm_sg_tt_init
      drm/qxl: switch to ttm_sg_tt_init
      drm/ttm: nuke ttm_dma_tt_init
      drm/prime: split array import functions v4
      drm/ttm/drivers: remove unecessary ttm_module.h include v2
      drm/ttm: stop destroying pinned ghost object
      drm/ttm: cleanup BO size handling v3
      drm/ttm: use pin_count more extensively
      drm/ttm: cleanup LRU handling further
      drm/amdgpu: enable freesync for A+A configs

Chuhong Yuan (1):
      drm/fb-helper: Add missed unlocks in setcmap_legacy()

Chun-Kuang Hu (2):
      drm/mediatek: Get CMDQ client register for all ddp component
      drm/mediatek: Use correct device pointer to get CMDQ client register

Colin Ian King (5):
      drm/i915: fix size_t greater or equal to zero comparison
      drm/amdgpu: Add missing BOOTUP_DEFAULT to profile_name[]
      drm/vkms: Fix missing kmalloc allocation failure check
      drm/amd/display: Fix spelling mistake of function name
      drm/amdgpu: Fix masking binary not operator on two mask operations

Dafna Hirschfeld (2):
      drm/rockchip: for error print, use the correct device pointer
      drm/rockchip: fix typo in Kconfig 's/HDMI/dsi/'

Dale Zhao (1):
      drm/amd/display: fix type mismatch error for return variable

Dan Carpenter (11):
      drm/kmb: Remove an unnecessary NULL check
      gma500: clean up error handling in init
      drm/i915/gem: Check the correct variable in selftest
      drm/panel: khadas: Fix error code in khadas_ts050_panel_add()
      drm/i915/selftests: Fix some error codes
      drm/amd/display: Fix a potential NULL dereference
      drm/amdgpu: Prevent shift wrapping in amdgpu_read_mask()
      drm/i915/gvt: fix uninitialized return in intel_gvt_update_reg_whitel=
ist()
      drm/i915/gem: Fix oops in error handling code
      drm/vmwgfx/vmwgfx_drv: Fix an error path in vmw_setup_pci_resources()
      drm/virtio: fix an error code in virtio_gpu_init()

Daniel Vetter (23):
      drm/ttm: Warn on pinning without holding a reference
      drm/nouveau: Drop mutex_lock_nested for atomic
      dma-buf: Fix kerneldoc formatting
      drm/vkms: Unset preferred_depth
      drm/amdkfd: fix ttm size refactor fallout
      dma-buf: Remove kmap kerneldoc vestiges
      dma-buf: some kerneldoc formatting fixes
      dma-buf: begin/end_cpu might lock the dma_resv lock
      dma-buf: doc polish for pin/unpin
      drm/fb-helper: Add a FIXME that generic_setup is very confusing
      Merge tag 'drm-misc-next-2020-12-17' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'topic/dp-hdmi-2.1-pcon-2020-12-23' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'imx-drm-next-2021-01-04' of
git://git.pengutronix.de/git/pza/linux into drm-next
      Merge tag 'drm-intel-next-2021-01-04' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'du-next-20210105' of
git://linuxtv.org/pinchartl/media into drm-next
      Merge tag 'drm-misc-next-2021-01-06' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      drm/vmwgfx: Drop svga_lock
      drm/vmwgfx: Always evict vram _before_ disabling it
      drm/ttm: WARN_ON non-empty lru when disabling a resource manager
      dma-buf: Add debug option
      Merge tag 'drm-misc-next-2021-01-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.12-2021-01-20' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      drm/todo: Add entry for moving to dma_resv_lock

Daniele Ceraolo Spurio (4):
      drm/i915: split gen8+ flush and bb_start emission functions
      drm/i915/guc: do not dump execlists state with GuC submission
      drm/i915/guc: init engine directly in GuC submission mode
      drm/i915/guc: stop calling execlists_set_default_submission

Darren Salt (1):
      PCI: Export pci_rebar_get_possible_sizes()

Dave Airlie (25):
      drm/i915: refactor panel backlight control functions. (v2)
      drm/i915/display: move needs_modeset to an inline in header
      drm/i915/display: move to_intel_frontbuffer to header
      drm/i915/display: fix misused comma
      drm/i915: refactor cursor code out of i915_display.c
      drm/i915: refactor i915 plane code into separate file.
      Merge tag 'amd-drm-next-5.12-2021-01-08' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-2021-01-12' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'drm-intel-gt-next-2021-01-14' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'imx-drm-next-2021-01-08' of
git://git.pengutronix.de/git/pza/linux into drm-next
      drm/i915: refactor some crtc code out of intel display. (v2)
      drm/i915: refactor pll code out into intel_dpll.c
      drm/i915: split fdi code out from intel_display.c
      Merge tag 'drm-intel-gt-next-2021-01-21-1' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'v5.11-rc5' of git://git.kernel.org/.../torvalds/linux
into drm-next
      Merge tag 'drm-intel-next-2021-01-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge branch 'linux-5.12' of git://github.com/skeggsb/linux into drm-=
next
      Merge tag 'drm/tegra/for-5.12-rc1' of
ssh://git.freedesktop.org/git/tegra/linux into drm-next
      Merge tag 'drm-intel-next-2021-01-29' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next
      Merge tag 'mediatek-drm-next-5.12' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-next
      Merge tag 'amd-drm-next-5.12-2021-02-03' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge branch '00.00-inst' of git://github.com/skeggsb/linux into drm-=
next
      Merge tag 'drm-misc-next-fixes-2021-02-11' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.12-2021-02-18' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2021-02-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Dave Stevenson (4):
      drm/vc4: dsi: Correct DSI register definition
      drm/vc4: dsi: Add support for DSI0
      dt-bindings: Add compatible for BCM2711 DSI1
      drm/vc4: dsi: Add configuration for BCM2711 DSI1

Deepak R Varma (1):
      drm/i915/perf: replace idr_init() by idr_init_base()

Defang Bo (1):
      drm/amdgpu: Add check to prevent IH overflow

Dennis Li (3):
      drm/amdgpu: fix a memory protection fault when remove amdgpu device
      drm/amdgpu: fix a GPU hang issue when remove device
      drm/amdgpu: fix no bad_pages issue after umc ue injection

Derek Lai (1):
      drm/amd/display: Add DIG_CLOCK_PATTERN in the transmitter control

Dmitry Osipenko (3):
      drm/tegra: dc: Enable display controller driver for Tegra114
      drm/tegra: gr2d: Correct swapped device-tree compatibles
      drm/tegra: gr2d: Add compatible for Tegra114

Dom Cobley (5):
      drm/vc4: hdmi: Move hdmi reset to bind
      drm/vc4: hdmi: Fix register offset with longer CEC messages
      drm/vc4: hdmi: Fix up CEC registers
      drm/vc4: hdmi: Restore cec physical address on reconnect
      drm/vc4: hdmi: Remove cec_available flag

Douglas Anderson (7):
      drm: panel: simple: Fixup the struct panel_desc kernel doc
      drm: panel: simple: Defer unprepare delay till next prepare to shorte=
n it
      drm: panel: simple: Allow specifying the delay from prepare to enable
      dt-bindings: dt-bindings: display: simple: Add BOE NV110WTM-N61
      drm: panel: simple: Add BOE NV110WTM-N61
      drm: panel: Fully transition panel_desc kerneldoc to inline style
      drm: panel: add flags to BOE NV110WTM-N61

Emily.Deng (3):
      drm/amdgpu: Add new mode 2560x1440
      drm/amdgpu: Correct the read sclk for navi10
      drm/amdgpu: Decrease compute timeout to 10 s for sriov multiple VF

Enrico Weigelt, metux IT consult (1):
      drivers: gpu: drm: virtio: fix dependency of DRM_VIRTIO_GPU on VIRTIO

Eric Yang (1):
      drm/amd/display: move edp sink present detection to hw init

Evan Quan (5):
      drm/amd/pm: populate Sienna Cichlid default overdrive table settings
      drm/amd/pm: enable Sienna Cichlid overdrive support
      drm/amd/pm: support overdrive vddgfx offset setting(V2)
      Revert "Revert "drm/amdgpu: Fix NULL dereference in dpm sysfs handler=
s""
      drm/amd/pm: correct string parsing for extra separator characters cas=
e

Fabrizio Castro (1):
      dt-bindings: display: bridge: renesas,lvds: RZ/G2E needs
renesas,companion too

Fangzhi Zuo (1):
      drm/amd/display: Add return code instead of boolean for future use

Feifei Xu (1):
      drm/amdgpu:Add pcie gen5 support in pcie capability.

Felix Kuehling (3):
      drm/amdkfd: Enable userptr support when KFD is enabled
      drm/amdgpu: Make contiguous pinning optional
      drm/amdkfd: Fix recursive lock warnings

Frantisek Hrbata (1):
      drm/nouveau: bail out of nouveau_channel_new if channel init fails

George Shen (2):
      drm/amd/display: Log link/connector info provided in BIOS object tabl=
e
      drm/amd/display: Fix DPCD translation for LTTPR AUX_RD_INTERVAL

Giulio Benetti (1):
      drm/sun4i: tcon: fix inverted DCLK polarity

Guchun Chen (1):
      drm/amdgpu: toggle on DF Cstate after finishing xgmi injection

Guido G=C3=BCnther (6):
      drm/panel: st7703: Use dev_err_probe
      drm/panel: mantix: Tweak init sequence
      drm/panel: mantix: Allow to specify default mode for different panels
      drm/panel: mantix: Support panel from Shenzhen Yashi Changhua
Intelligent Technology Co
      dt-bindings: vendor-prefixes: Add ys vendor prefix
      dt-bindings: display: mantix: Add compatible for panel from YS

Gurchetan Singh (3):
      drm/virtio: virtio_{blah} --> virtio_gpu_{blah}
      drm/virtio: rework virtio_fence_signaled
      drm/virtio: consider dma-fence context when signaling

Gustavo A. R. Silva (1):
      drm/amd/display: Fix potential integer overflow

Hans de Goede (1):
      drm/i915/dsi: Use unconditional msleep for the panel_on_delay
when there is no reset-deassert MIPI-sequence

Hawking Zhang (33):
      drm/amdgpu: add amdgpu_ih_regs structure
      drm/amdgpu: add helper to init ih ring regs for vega10
      drm/amdgpu: add helper to enable an ih ring for vega10
      drm/amdgpu: add helper to toggle ih ring interrupts for vega10
      drm/amdgpu: switch to ih_init_register_offset for vega10
      drm/amdgpu: switch to ih_toggle_interrupts for vega10
      drm/amdgpu: switch to ih_enable_ring for vega10
      drm/amdgpu: use cached ih rb control reg offsets for vega10
      drm/amdgpu: correct ih cg programming for vega10 ih block
      drm/amdgpu: add helper to init ih ring regs for navi10
      drm/amdgpu: add helper to enable an ih ring for navi10
      drm/amdgpu: add helper to toggle ih ring interrupts for navi10
      drm/amdgpu: switch to ih_init_register_offset for navi10
      drm/amdgpu: switch to ih_toggle_interrupts for navi10
      drm/amdgpu: switch to ih_enable_ring for navi10
      drm/amdgpu: use cached ih rb control reg offsets for navi10
      drm/amdgpu: add a helper function to decode iv
      drm/amdgpu: switch to common decode iv helper
      drm/amdgpu: add osssys v4_2 ip headers (v2)
      drm/amdgpu: create vega20 ih blocks
      drm/amdgpu: reroute vmc/utcl2 interrupts to ih ring 1 for arcturus
      drm/amdgpu: switch to vega20 ih block for vega20/arcturus
      drm/amdgpu: retire the vega20 code path from navi10 ih block
      drm/amdgpu: correct ih_chicken programming for vega10/vega20 ih block=
s
      drm/amdgpu: drop IH_CHICKEN programming from vega10 ih block
      drm/amdgpu: drop ih reroute function from psp v11
      drm/amdgpu: don't create ih ring 1 and ring 2 for APU
      drm/amdgpu: enable software ih ring for vega20 ih block
      drm/amdgpu: set ih soft ring enabled flag for vega and navi
      drm/amdgpu: de-initialize software ih ring
      drm/amdgpu: drop psp ih programming for sriov guest on navi
      drm/amdgpu: switched to cached noretry setting for vangogh
      drm/amdgpu: add amdgpu_hdp structure

Heiko Stuebner (1):
      drm/panel: panel-simple: add bus-format and connector-type to
Innolux n116bge

Horace Chen (1):
      drm/amdgpu: race issue when jobs on 2 ring timeout

Hsin-Yi Wang (2):
      drm/mediatek: mtk_dpi: Create connector for bridges
      drm/mediatek: Add mtk_dither_set_common() function

Huang Rui (17):
      drm/amd/pm: remove vcn/jpeg powergating feature checking for vangogh
      drm/amd/pm: enhance the real response for smu message (v2)
      drm/amd/pm: clean up get_allowed_feature_mask function
      drm/amd/pm: initial feature_enabled/feature_support bitmap for vangog=
h
      drm/amd/pm: don't mark all apu as true on feature mask
      drm/amdgpu: revise the mode2 reset for vangogh
      drm/amd/pm: fix the return value of pm message
      drm/amd/pm: implement the processor clocks which read by metric
      drm/amd/pm: implement processor fine grain feature for vangogh (v3)
      drm/amdgpu: fix vram type and bandwidth error for DDR5 and DDR4
      drm/amd/display: fix the system memory page fault because of copy ove=
rflow
      drm/amd/display: fix the coding style issue of integrated_info
      drm/amdgpu: fix build error without x86 kconfig (v2)
      drm/amd/pm: print the timeout of smc message
      drm/amdgpu: remove gpu info firmware of green sardine
      drm/amdgpu: fix the issue that retry constantly once the buffer
is oversize
      drm/amdkfd: fix null pointer panic while free buffer in kfd

Imre Deak (17):
      drm/i915: Use CRTC index consistently during getting/putting
CRTC power domains
      drm/i915: Factor out helpers to get/put a set of tracked power domain=
s
      drm/i915: Track power references taken for enabled CRTCs
      drm/i915/ddi: Track power reference taken for encoder DDI IO use
      drm/i915/ddi: Track power reference taken for encoder main lane AUX u=
se
      drm/i915: Track power reference taken for eDP VDD
      drm/i915: Rename power_domains.wakeref to init_wakeref
      drm/i915: Track power reference taken to disable power well functiona=
lity
      drm/i915: Make intel_display_power_put_unchecked() an
internal-only function
      drm/i915/icl: Fix initing the DSI DSC power refcount during HW readou=
t
      drm/i915/dp: Move intel_dp_set_signal_levels() to intel_dp_link_train=
ing.c
      drm/i915/dp: Fix LTTPR vswing/pre-emp setting in non-transparent mode
      drm/i915/gem: Add a helper to read data from a GEM object page
      drm/dp/mst: Export drm_dp_get_vc_payload_bw()
      drm/i915: Fix the MST PBN divider calculation
      drm/i915/dp: Prevent setting the LTTPR LT mode if no LTTPRs are detec=
ted
      drm/dp_mst: Don't cache EDIDs for physical ports

Jack Zhang (1):
      drm/amdgpu/sriov Stop data exchange for wholegpu reset

Jacky Liao (1):
      drm/amd/display: Fix assert being hit with GAMCOR memory shut down

Jake Wang (1):
      drm/amd/display: Update dram_clock_change_latency for DCN2.1

Jan Kokem=C3=BCller (1):
      drm/amd/display: Add FPU wrappers to dcn21_validate_bandwidth()

Jani Nikula (48):
      drm/i915/debugfs: remove RPS autotuning details from i915_rps_boost_i=
nfo
      drm/i915: remove last traces of I915_READ_FW() and I915_WRITE_FW()
      drm/i915/cdclk: prefer intel_de_write() over I915_WRITE()
      drm/i915/debugfs: remove the i915_cache_sharing debugfs file
      drm/i915/debugfs: replace I915_READ() with intel_uncore_read()
      drm/i915/suspend: replace I915_READ()/WRITE() with intel_de_read()/wr=
ite()
      drm/i915/pm: replace I915_READ()/WRITE() with intel_uncore_read()/wri=
te()
      drm/i915/irq: replace I915_READ()/WRITE() with intel_uncore_read()/wr=
ite()
      drm/i915/gvt: replace I915_WRITE with intel_uncore_write
      drm/i915: remove last traces of I915_READ(), I915_WRITE() and
POSTING_READ()
      drm/i915/gvt: avoid useless use of inline
      drm/dsc: use rc_model_size from DSC config for PPS
      drm/i915/dsc: configure hardware using specified rc_model_size
      drm/i915/dsc: make rc_model_size an encoder defined value
      drm/dsc: add helper for calculating rc buffer size from DPCD
      drm/i915/bios: fill in DSC rc_model_size from VBT
      drm/i915/gvt: make execlist.h self-contained
      drm/i915/gvt: make fb_decoder.h self-contained
      drm/i915/gvt: make gtt.h self-contained
      drm/i915/gvt: make interrupt.h self-contained
      drm/i915/gvt: make mmio_context.h self-contained
      drm/i915/gvt: make gvt.h self-contained
      drm/i915/gvt: make scheduler.h self-contained
      drm/i915/gvt: make mpt.h self-contained
      drm/i915/backlight: fix CPU mode backlight takeover on LPT
      drm/i915/region: make intel_region_map static
      drm/i915/lmem: make intel_region_lmem_ops static
      drm/i915/display: remove useless use of inline
      drm/i915/display: fix the uint*_t types that have crept in
      drm/i915/pps: abstract panel power sequencer from intel_dp.c
      drm/i915/pps: rename pps_{,un}lock -> intel_pps_{,un}lock
      drm/i915/pps: rename intel_edp_backlight_* to intel_pps_backlight_*
      drm/i915/pps: rename intel_edp_panel_* to intel_pps_*
      drm/i915/pps: rename edp_panel_* to intel_pps_*_unlocked
      drm/i915/pps: abstract intel_pps_vdd_off_sync
      drm/i915/pps: add higher level intel_pps_init() call
      drm/i915/pps: abstract intel_pps_encoder_reset()
      drm/i915/pps: rename intel_dp_check_edp to intel_pps_check_power_unlo=
cked
      drm/i915/pps: rename intel_power_sequencer_reset to intel_pps_reset_a=
ll
      drm/i915/pps: add locked intel_pps_wait_power_cycle
      drm/i915/pps: rename vlv_init_panel_power_sequencer to vlv_pps_init
      drm/i915/pps: rename intel_dp_init_panel_power_sequencer* functions
      drm/i915/selftests: fix the uint*_t types that have crept in
      drm/i915/pps: refactor init abstractions
      drm/i915/pps: move pps code over from intel_display.c and refactor
      drm/i915/dp: abstract struct intel_dp pps members to a sub-struct
      drm/i915/dp: split out aux functionality to intel_dp_aux.c
      drm/msm/dp: fix build after dp quirk helper change

Jeremy Cline (1):
      drm/amdkfd: Fix out-of-bounds read in kdf_create_vcrat_image_cpu()

Jernej Skrabec (3):
      drm/sun4i: csc: Rework DE3 CSC macros
      drm/sun4i: de2/de3: Remove redundant CSC matrices
      drm/sun4i: Add support for BT2020 to DE3

Jialin Zhang (1):
      drm/gma500: Fix error return code in psb_driver_load()

Jiansong Chen (3):
      drm/amdgpu: remove unnecessary asic check for sdma5.2
      drm/amdgpu: enable gpu recovery for navy_flounder
      drm/amd/pm: update driver if version for navy_flounder

Jiapeng Chong (2):
      drm/amd/display: Simplify bool comparison
      drm/radeon: Simplify bool comparison

Jiapeng Zhong (1):
      drm/amdgpu: Assign boolean values to a bool variable

Jiawei Gu (3):
      drm/amdgpu: fix potential NULL pointer when check_atom_bios() fails
      drm/amdgpu: fix potential memory leak during navi12 deinitialization
      drm/amdgpu: extend MAX_KIQ_REG_TRY to 1000

Jingwen Chen (2):
      drm/amd/amdgpu: remove redundant flush_delayed_work
      drm/amd/amdgpu: add error handling to amdgpu_virt_read_pf2vf_data

Jinzhou Su (10):
      drm/amd/pm: Add interface for request WGPs
      drm/amd/pm: Add GFXOFF interface for Vangogh
      drm/amd/pm: Enable GfxOff for Vangogh
      drm/amdgpu: Add Secure Display TA header file
      drm/amdgpu: Add secure display TA interface
      drm/amdgpu: Remove GFXOFF MASK for Vangogh
      drm/amdgpu: modify GCR_GENERAL_CNTL for Vangogh
      drm/amdgpu: Add RLC_PG_DELAY_3 for Vangogh
      drm/amdgpu: Allow GfxOff on Vangogh as default
      drm/amd/pm: Disable GFXOFF when GFX DPM or PG disabled

Jitao Shi (1):
      drm/mediatek: dsi: Use IRQF_TRIGGER_NONE for dsi irq trigger type

Joe Perches (1):
      dma-buf: Avoid comma separated statements

John Clements (3):
      drm/amd/pm: updated PM to I2C controller port on sienna cichlid
      drm/amdgpu: enable ras eeprom support for sienna cichlid
      drm/amdgpu: updated fw attestation interface

John Harrison (2):
      drm/i915: Correct location of Wa_1408615072
      drm/i915/uc: Add function to define defaults for GuC/HuC enable

Jonathan Gray (1):
      drm/amd/display: change license of color_table.c

Jonathan Liu (1):
      drm/rockchip: dw_hdmi: fix incorrect clock in vpll clock error messag=
e

Jonathan Neusch=C3=A4fer (1):
      drm/mipi-dbi: Switch to new kerneldoc syntax for named variable
macro argument

Joonas Lahtinen (2):
      Merge drm/drm-next into drm-intel-gt-next
      Merge tag 'gvt-gt-next-2021-01-18' of
https://github.com/intel/gvt-linux into drm-intel-gt-next

Joseph Schulte (1):
      drm: replace drm_modeset_lock_all() in drm_client_modeset_dpms_legacy=
()

Joshua Aberback (3):
      drm/amd/display: Update idle optimization handling
      drm/amd/display: Create and Destroy PSR resources for DCN302
      drm/amd/display: Better handling of dummy p-state table

Jos=C3=A9 Roberto de Souza (11):
      drm/i915/display/psr: Calculate selective fetch plane registers
      doc: Fix build of documentation after i915 file rename
      drm: Add function to convert rect in 16.16 fixed format to regular fo=
rmat
      drm/i915/display/psr: Use plane damage clips to calculate damaged are=
a
      drm/i915/display: Split and export main surface calculation from
skl_check_main_surface()
      drm/i915/display/psr: Program plane's calculated offset to plane
SF register
      drm/i915: Fix HTI port checking
      drm/i915/dg1: Apply WA 1409120013 and 14011059788
      drm/i915: Nuke not needed members of dram_info
      drm/i915/gen11+: Only load DRAM information from pcode
      drm/i915: Rename is_16gb_dimm to wm_lv_0_adjust_needed

Jun Lei (3):
      drm/amd/display: implement T12 compliance
      drm/amd/display: implement support for DID2.0 dsc passthrough
      drm/amd/display: revert support for DID2.0 dsc passthrough

Jyri Sarha (2):
      drm/omap: Implement CTM property for CRTC using OVL managers CPR matr=
ix
      drm/omap: Enable COLOR_ENCODING and COLOR_RANGE properties for planes

Karol Herbst (1):
      drm/nouveau/kms: handle mDP connectors

Kenneth Feng (3):
      drm/amd/pm: enable ACDC feature
      drm/amd/pm: enable DCS
      drm/amd/pm: enable LCLK DS

Kent Russell (1):
      drm/amdkfd: Get unique_id dynamically v2

Kevin Wang (4):
      drm/amd/display: fix sysfs amdgpu_current_backlight_pwm NULL pointer =
issue
      drm/amd/pm: remove unused message SMU_MSG_SpareX
      drm/amd/pm/swsmu: unify the init soft gpu metrics function
      drm/amdgpu: optimize list operation in amdgpu_xgmi

Krzysztof Kozlowski (2):
      drm/ingenic: depend on COMMON_CLK to fix compile tests
      drm/imx: depend on COMMON_CLK to fix compile tests

Kui Wen (1):
      drm/i915: Fix the sgt.pfn sanity check

Lang Yu (3):
      drm/amd/display: fix 64-bit division issue on 32-bit OS
      drm/amd/amdkfd: adjust dummy functions' placement
      drm/amd/display: fix 64bit division issue on 32bit OS

Laurent Pinchart (21):
      drm: Remove drmm_add_final_kfree() declaration from public headers
      dt-bindings: display: bridge: thc63lvd1024: Document dual-output mode
      drm: Add default modes for connectors in unknown state
      drm: rcar-du: Fix crash when using LVDS1 clock for CRTC
      drm: rcar-du: Release vsp device reference in all error paths
      drm: rcar-du: Drop unneeded encoder cleanup in error path
      drm: rcar-du: Use DRM-managed allocation for VSP planes
      drm: rcar-du: Use DRM-managed allocation for encoders
      drm: rcar-du: Embed drm_device in rcar_du_device
      drm: rcar-du: Replace dev_private with container_of
      drm: rcar-du: Skip encoder allocation for LVDS1 in dual-link mode
      drm: rcar-du: Drop local encoder variable
      drm: rcar-du: Fix leak of CMM platform device reference
      drm: arc: Remove unnecessary drm_plane_cleanup() wrapper
      drm: sti: Remove unnecessary drm_plane_cleanup() wrapper
      drm: vc4: Remove unnecessary drm_plane_cleanup() wrapper
      drm: zte: Remove unnecessary drm_plane_cleanup() wrapper
      drm: Don't export the drm_gem_dumb_destroy() function
      drm: Move legacy device list out of drm_driver
      drm: Use a const drm_driver for legacy PCI devices
      drm: Constify drm_driver in drivers that don't modify it

Lee Jones (124):
      gpu/ipu-v3/ipu-di: Strip out 2 unused 'di_sync_config' entries
      drm/amd/amdgpu/amdgpu_ih: Update 'amdgpu_ih_decode_iv_helper()'s
function header
      drm/amd/amdgpu/vega20_ih: Add missing descriptions for 'ih' and
fix spelling error
      drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0: Provide
description of 'call_back_func'
      drm/amd/pm/powerplay/hwmgr/ppatomctrl: Fix documentation for 'mpll_pa=
ram'
      drm/amd/pm/powerplay/hwmgr/vega12_hwmgr: Fix legacy function
header formatting
      drm/amd/pm/powerplay/hwmgr/vega20_hwmgr: Fix legacy function
header formatting
      drm/amd/pm/powerplay/hwmgr/smu7_hwmgr: Fix formatting and spelling is=
sues
      drm/amd/pm/powerplay/hwmgr/hwmgr: Move prototype into shared header
      drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Fix a bunch of
kernel-doc formatting issues
      drm/amd/display/dc/basics/conversion: Demote obvious kernel-doc abuse
      drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs: Demote
non-kernel-doc comment blocks
      drm/amd/display/dc/bios/command_table_helper: Fix kernel-doc formatti=
ng
      drm/amd/display/dc/bios/command_table_helper2: Fix legacy
formatting problems
      drm/amd/display/dc/bios/bios_parser: Make local functions static
      drm/amd/display/dc/bios/bios_parser: Fix a whole bunch of legacy
doc formatting
      drm/amd/display/dc/bios/bios_parser2: Fix some formatting issues
and missing parameter docs
      drm/amd/display/dc/dce/dce_audio: Make function invoked by
reference static
      drm/amd/display/dc/dce/dce_stream_encoder: Remove unused variable 're=
gval'
      drm/amd/display/dc/dce/dce_link_encoder: Make functions invoked
by reference static
      drm/amd/display/dc/dce/dce_clock_source: Fix formatting/spelling
of worthy function headers
      drm/amd/pm/powerplay/hwmgr/vega10_hwmgr: Fix worthy function
headers, demote barely documented one
      drm/amd/display/dc/dce/dce_transform: Remove 3 unused/legacy variable=
s
      drm/amd/display/dc/dce/dce_dmcu: Staticify local function call
'dce_dmcu_load_iram'
      drm/amd/display/dc/dce/dce_dmcu: Move 'abm_gain_stepsize' to
only source file it's used in
      drm/amd/display/dc/dce/dce_opp: Make local functions and ones
invoked by reference static
      drm/amd/display/dc/dce/dce_aux: Remove unused function 'get_engine_ty=
pe'
      drm/amd/display/dc/bios/bios_parser: Fix misspelling of function para=
meter
      drm/amd/display/dc/dce/dce_i2c_hw: Make functions called by
reference static
      drm/amd/display/dc/dce/dce_i2c_sw: Make a bunch of local functions st=
atic
      drm/amd/display/dc/dce/dce_panel_cntl: Remove unused variables
'bl_pwm_cntl' and 'pwm_period_cntl'
      drm/amd/display/dc/dce/dmub_psr: Demote non-conformant kernel-doc hea=
ders
      drm/amd/display/dc/gpio/hw_factory: Delete unused function
'dal_hw_factory_destroy'
      drm/amd/display/dc/dce/dce_aux: Mark 'dce_aux_transfer_raw' as
__maybe_unused
      drm/amd/display/dc/dce/dce_link_encoder: Remove unused variable 'valu=
e0'
      drm/amd/display/dc/gpio/hw_ddc: Remove unused variable 'reg2'
      drm/amd/display/dc/dce/dce_opp: Demote non-compliant kernel-doc heade=
rs
      drm/amd/display/dc/dce/dce_transform: Demote kernel-doc abuse
      drm/amd/display/dc/gpio/diagnostics/hw_translate_diag: Include
our own header containing prototypes
      drm/amd/display/dc/irq/irq_service: Make local function static
      drm/amd/display/dc/gpio/diagnostics/hw_factory_diag: Fix struct
declared inside parameter list error
      drm/amd/display/dc/gpio/diagnostics/hw_factory_diag: Include our
own header containing prototypes
      drm/amd/display/dc/dce120/dce120_hw_sequencer: Encompass defines
in same clause as their use
      drm/amd/display/dc/dce120/dce120_timing_generator:
      drm/amd/display/dc/dce120/Makefile: Ignore -Woverride-init warning
      drm/amd/display/dc/dce120/dce120_resource: Staticify local functions
      drm/amd/display/dc/dce120/dce120_timing_generator: Demote
non-kerneldoc headers
      drm/amd/display/dc/dce/dce_aux: Remove duplicate line causing
'field overwritten' issue
      drm/amd/display/dc/dce112/Makefile: Ignore -Woverride-init warning
      drm/amd/display/dc/dce/dce_opp: Remove duplicate entries causing
'field overwritten' issues
      drm/amd/display/dc/dce110/dce110_timing_generator: Remove unused
variable 'value_crtc_vtotal'
      drm/amd/display/dc/dce110/dce110_compressor: Remove unused
function 'dce110_get_required_compressed_surfacesize
      drm/amd/display/dc/dce110/dce110_hw_sequencer: Demote
non-conformant kernel-doc header
      drm/amd/display/dc/dce110/dce110_mem_input_v: Make local functions st=
atic
      drm/amd/display/dc/dce120/dce120_timing_generator: Remove unused
function 'dce120_timing_generator_get_position'
      drm/amd/display/dc/dce110/dce110_timing_generator: Demote
kernel-doc abuses to standard function headers
      drm/amd/display/dc/dce110/dce110_compressor: Strip out unused
function 'controller_id_to_index'
      drm/amd/display/dc/dce112/dce112_resource: Make local functions
and ones called by reference static
      drm/amd/display/dc/dce110/dce110_timing_generator_v: Demote
kernel-doc abuse and line up comments
      drm/amd/display/dc/dce110/dce110_mem_input_v: Include our own
header, containing prototypes
      drm/amd/display/dc/dce110/Makefile: Ignore -Woverride-init warning
      drm/amd/display/dc/dce110/dce110_resource: Make local functions
invoked by reference static
      drm/amd/display/dc/dce110/dce110_transform_v: Demote kernel-doc abuse
      drm/amd/display/dc/dce60/dce60_timing_generator: Make
'dce60_configure_crc' invoked by reference static
      drm/amd/display/dc/dce100/dce100_resource: Make local functions
and ones called by reference static
      drm/amd/display/dc/dce60/dce60_resource: Make local functions static
      drm/amd/display/dc/core/dc_surface: Demote kernel-doc abuse
      drm/amd/display/dc/core/dc_stream: Demote non-conformant
kernel-doc headers
      drm/amd/display/dc/calcs/dce_calcs: Remove unused variables
'v_filter_init_mode' and 'sclk_lvl'
      drm/amd/display/dc/calcs/dce_calcs: Demote non-conformant
kernel-doc function headers
      drm/amd/display/dc/dc_helper: Include our own header, containing
prototypes
      drm/amd/include/renoir_ip_offset: Mark top-level IP_BASE as __maybe_u=
nused
      drm/amd/display/dmub/src/dmub_dcn30: Include our own header
containing prototypes
      drm/amd/display/modules/power/power_helpers: Staticify local function=
s
      drm/amd/display/modules/info_packet/info_packet: Correct
kernel-doc formatting
      drm/amd/display/dc/core/dc_resource: Staticify local functions
      drm/amd/display/dc/core/dc_link: Remove unused variable 'status'
      drm/amd/display/dc/core/dc_link_dp: Staticify local function
'linkRateInKHzToLinkRateMultiplier'
      drm/amd/display/dc/dce112/dce112_resource: Include our own
header file containing prototypes
      drm/amd/display/dc/core/dc: Staticise local function
'apply_ctx_interdependent_lock'
      drm/amd/display/dc/dce100/Makefile: Ignore -Woverride-init warning
      drm/amd/display/dc/dce100/dce100_resource: Include our own
header containing prototypes
      drm/amd/display/dc/dce60/Makefile: Ignore -Woverride-init warning
      drm/amd/display/dc/dce80/Makefile: Ignore -Woverride-init warning
      drm/amd/display/dc/dce80/dce80_resource: Include our own header
containing prototypes
      drm/amd/display/dc/dce60/dce60_resource: Include our own header
containing prototypes
      drm/amd/display/dc/core/dc_link: Move some local data from the
stack to the heap
      drm/amd/display/dc/core/dc_link_dp: Mark
'result_write_min_hblank' as __maybe_unused
      drm/amd/display/dc/core/dc: Fix a bunch of documentation misdemeanour=
s
      drm/amd/display/dc/core/dc_resource: Demote some kernel-doc abuses
      drm/amd/display/dc/core/dc_link: Fix a couple of function
documentation issues
      drm/r128/r128_ioc32: Document headers do not make good
kernel-doc candidates
      drm/mga/mga_ioc32: Document headers do not make good kernel-doc candi=
dates
      drm/r128/r128_ioc32: Fix formatting issues in
'r128_compat_ioctl()'s header
      drm/mga/mga_ioc32: Fix some formatting issues in
'mga_compat_ioctl's header
      drm/gma500/framebuffer: Fix some possible doc-rot issues
      drm/gma500/gem: Add and rename some function parameter descriptions
      drm/gma500/intel_bios: Demote non-conformant kernel-doc header
      drm/gma500/intel_i2c: Remove superflouous parameter description
and rename another
      drm/gma500/mmu: Make local function 'psb_mmu_pt_alloc_map_lock()' sta=
tic
      drm/gma500/power: Fix a bunch of *dev documentation issues
      drm/gma500/gma_display: Demote kernel-doc abuses to standard
comment blocks
      drm/gma500/gma_device: Include our own header containing prototypes
      drm/gma500/psb_intel_display: Demote kernel-doc formatting abuse
      drm/gma500/psb_intel_lvds: Supply description for 'mode_dev'
      drm/gma500/psb_intel_modes: Provide missing descriptions for
function param 'adapter'
      drm/gma500/gem: Do not rely on consumers to include
drm/drm_device.h before gem.h
      drm/gma500/gem: Include our own header containing prototypes
      drm/gma500/mmu: Remove unused function 'psb_get_default_pd_addr'
      drm/gma500/power: Remove excess param description 'state'
      drm/gma500/mmu: Actually return an error if one occurs
      drm/gma500/psb_intel_sdvo: Demote kernel-doc abuses
      drm/gma500/psb_irq: Demote kernel-doc abuse
      drm/drm_dp_helper: Fix spelling issue and add missing
description for 'enable_frl_ready_hpd'
      drm/gma500/cdv_intel_crt: Demote kernel-doc abuse in
'cdv_intel_crt_detect_hotplug()'s header
      drm/gma500/cdv_intel_display: Demote kernel-doc abuse in
'cdv_intel_panel_fitter_pipe()'s header
      drm/gma500/cdv_intel_lvds: Demote unworthy headers to standard
blocks and fix another
      drm/gma500/cdv_intel_dp: Demote one unworthy header fix another
      drm/gma500/oaktrail_lvds_i2c: Remove unused variables 'tmp'
      drm/gma500/oaktrail_lvds: Demote one documentation header fix another
      drm/gma500/oaktrail_crtc: Demote unworthy kernel-doc headers
      drm/gma500/mdfld_dsi_output: Demote a couple of kernel-doc
formatting abuses
      drm/gma500/mdfld_intel_display: Demote three kernel-doc formatting ab=
uses
      drm/drm_agpsupport: Strip out obviously wrong descriptions and
demote to standard headers

Lee Shawn C (2):
      drm/i915/rkl: new rkl ddc map for different PCH
      drm/i915: support two CSC module on gen11 and later

Lewis Huang (2):
      drm/amd/display: Separate fec debug flag and monitor patch
      drm/amd/display: Set power_gated to true for seamless boot pipe init

Li, Roman (1):
      drm/amd/display: disable dcn10 pipe split by default

Likun Gao (12):
      drm/amdgpu: add hdp version 4 functions
      drm/amdgpu: add hdp version 5 functions
      drm/amdgpu: switch hdp callback functions for hdp v4
      drm/amdgpu: switch hdp callback functions for hdp v5
      drm/amdgpu: remove redundant logic related HDP
      drm/amdgpu: remove redundant include of navi10_enum
      drm/amdgpu: set power brake sequence
      drm/amdgpu: support ASPM for some specific ASIC
      drm/amdgpu: add SMUIO 11.0.6 register headers
      drm/amdgpu: implement smuio v11_0_6 callbacks
      drm/amdgpu: switch to use smuio callbacks for NV family
      drm/amdgpu: support rom clockgating related function for NV family

Linus Walleij (4):
      dt-bindings: display: mcde: Convert to YAML schema
      drm/panel: s6e63m0: Fix init sequence again
      drm/panel: s6e63m0: Support max-brightness
      dt-bindings: display: Augment s6e63m0 bindings

Lionel Landwerlin (1):
      drm/i915/perf: also include Gen11 in OATAILPTR workaround

Luben Tuikov (5):
      drm/scheduler: "node" --> "list"
      gpu/drm: ring_mirror_list --> pending_list
      drm/scheduler: Essentialize the job done callback
      drm/sched: Add missing structure comment
      drm/scheduler: Job timeout handler returns status (v3)

Lucas De Marchi (7):
      drm/i915/dg1: make Wa_22010271021 permanent
      drm/i915: remove WA_SET_BIT_MASKED()
      drm/i915: remove WA_CLR_BIT_MASKED()
      drm/i915: remove WA_SET_FIELD_MASKED()
      drm/i915/gt: stop ignoring read with wa_masked_field_set
      drm/i915/gt: rename wa_write_masked_or()
      drm/i915/gt: document masked registers

Lukas Bulwahn (1):
      drm/amd/display: tweak the kerneldoc for active_vblank_irq_count

Lukasz Luba (1):
      drm/panfrost: Use delayed timer as default in devfreq profile

Lyude Paul (21):
      drm/i915/dp: Program source OUI on eDP panels
      drm/i915: Rename pwm_* backlight callbacks to ext_pwm_*
      drm/i915: Pass down brightness values to enable/disable
backlight callbacks
      drm/i915/dp: Rename eDP VESA backlight interface functions
      drm/i915/dp: Add register definitions for Intel HDR backlight interfa=
ce
      drm/ttm: Remove pinned bos from LRU in ttm_bo_move_to_lru_tail() v2
      drm/i915: Pass port to intel_panel_bl_funcs.get()
      drm/i915: Keep track of pwm-related backlight hooks separately
      drm/i915/dp: Enable Intel's HDR backlight interface (only SDR for now=
)
      drm/i915/dp: Allow forcing specific interfaces through
enable_dpcd_backlight
      drm/dp: Revert "drm/dp: Introduce EDID-based quirks"
      drm/i915/dp: Don't use DPCD backlights that need PWM enable/disable
      drm/nouveau/kms/nv50-: Don't call HEAD_SET_CRC_CONTROL in head907d_mo=
de()
      drm/nouveau/kms/nv50-: Log SOR/PIOR caps
      drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in
->disable callbacks
      drm/nouveau/kms/nv50-: Rename encoder->atomic_(enable|disable) callba=
cks
      drm/nouveau/kms/nv50-: s/armh/asyh/ in nv50_msto_atomic_enable()
      drm/nouveau/kms/nv50-: Reverse args for
nv50_outp_get_(old|new)_connector()
      drm/nouveau/kms/nv50-: Lookup current encoder/crtc from atomic state
      drm/nouveau/kms/nv50-: Use nouveau_encoder->crtc in get_eld callback
      drm/nouveau/kms/nv50-: Fix locking for audio callbacks

Maarten Lankhorst (5):
      Merge drm/drm-next into drm-misc-next
      drm/i915: Populate logical context during first pin.
      Merge drm/drm-next into drm-misc-next
      drm/amdgpu: Remove accidentally added small unused hunk.
      Revert "drm/scheduler: Job timeout handler returns status (v3)"

Manasi Navare (12):
      drm/i915: Add VRR_CTL_LINE_COUNT field to VRR_CTL register def
      drm/i915/dp: No need to poll FEC Enable Live bit
      drm/i915/display/dp: Compute the correct slice count for VDSC on DP
      drm/i915/display/vrr: Create VRR file and add VRR capability check
      drm/i915/display/dp: Compute VRR state in atomic_check
      drm/i915/display/dp: Do not enable PSR if VRR is enabled
      drm/i915/display/vrr: Configure and enable VRR in modeset enable
      drm/i915/display/vrr: Send VRR push to flip the frame
      drm/i915/display/vrr: Disable VRR in modeset disable path
      drm/i915/display/vrr: Set IGNORE_MSA_PAR state in DP Sink
      drm/i915/display: Add HW state readout for VRR
      drm/i915/display/vrr: Skip the VRR HW state readout on DSI transcoder

Marek Ol=C5=A1=C3=A1k (1):
      drm/amdgpu: fix CGTS_TCC_DISABLE register offset on gfx10.3

Mario Kleiner (4):
      drm/amd/display: Check plane scaling against format specific hw
plane caps.
      drm/amd/display: Enable fp16 also on DCE-8/10/11.
      drm/amd/display: Fix 10/12 bpc setup in DCE output bit depth reductio=
n.
      drm/amd/display: Fix HDMI deep color output for DCE 6-11.

Mark Brown (1):
      drm/bridge: thc63lvd1024: Fix regulator_get_optional() misuse

Markus Elfring (2):
      drm/amd/display: Return directly after a failed kzalloc() in dc_creat=
e()
      drm/amd/display: Use common error handling code in dc_create()

Matt Coffin (1):
      drm/amdgpu/pm: Account for extra separator characters in sysfs interf=
ace

Matt Roper (3):
      drm/i915: Clarify error message on failed workaround
      drm/i915/rkl: Add DP vswing programming tables
      drm/i915/dg1: Update voltage swing tables for DP

Matthew Auld (12):
      drm/i915/selftest: also consider non-contiguous objects
      drm/i915/selftest: assert we get 2M GTT pages
      drm/i915: clear the shadow batch
      drm/i915: clear the gpu reloc batch
      drm/i915: move region_lmem under gt
      drm/i915/gem: split gem_create into own file
      drm/i915/gem: sanity check object size in gem_create
      drm/i915/region: convert object_create into object_init
      drm/i915: add back static declaration
      drm/i915: move i915_map_type into i915_gem_object_types.h
      drm/i915/pool: constrain pool objects by mapping type
      drm/i915/region: don't leak the object on error

Matthew Brost (1):
      drm/i915/guc: Delete GuC code unused in future patches

Mauro Carvalho Chehab (1):
      drm: drm_crc: fix a kernel-doc markup

Maxime Ripard (27):
      drm/vc4: hdmi: Don't poll for the infoframes status on setup
      drm/vc4: drv: Remove the DSI pointer in vc4_drv
      drm/vc4: dsi: Use snprintf for the PHY clocks instead of an array
      drm/vc4: dsi: Introduce a variant structure
      drm: Introduce an atomic_commit_setup function
      drm: Document use-after-free gotcha with private objects
      drm/vc4: Simplify a bit the global atomic_check
      drm/vc4: kms: Wait on previous FIFO users before a commit
      drm/vc4: kms: Remove unassigned_channels from the HVS state
      drm/vc4: kms: Remove async modeset semaphore
      drm/vc4: kms: Convert to atomic helpers
      drm/vc4: hvs: Align the HVS atomic hooks to the new API
      drm/vc4: Pass the atomic state to encoder hooks
      drm/vc4: hdmi: Take into account the clock doubling flag in atomic_ch=
eck
      drm/vc4: hdmi: Don't access the connector state in reset if kmalloc f=
ails
      drm/vc4: hdmi: Create a custom connector state
      drm/vc4: hdmi: Store pixel frequency in the connector state
      drm/vc4: hdmi: Use the connector state pixel rate for the PHY
      drm/vc4: hdmi: Limit the BCM2711 to the max without scrambling
      drm/vc4: hdmi: Enable 10/12 bpc output
      drm/vc4: hdmi: Compute the CEC clock divider from the clock rate
      drm/vc4: hdmi: Update the CEC clock divider on HSM rate change
      drm/vc4: hdmi: Introduce a CEC clock
      drm/vc4: hdmi: Split the interrupt handlers
      drm/vc4: hdmi: Support BCM2711 CEC interrupt setup
      drm/vc4: hdmi: Don't register the CEC adapter if there's no interrupt=
s
      dt-binding: display: bcm2711-hdmi: Add CEC and hotplug interrupts

Michael Strauss (1):
      drm/amd/display: Add null pointer check to is_dig_enabled func

Mike Hsieh (2):
      drm/amd/display: Remove unused P010 debug flag
      drm/amd/display: disable FEC while using eDP

Mikita Lipski (1):
      drm/amd/display: Release DSC before acquiring

Mikko Perttunen (2):
      drm/tegra: falcon: Support newer VIC firmware
      drm/tegra: vic: Add comments on STREAMID registers

Neil Armstrong (2):
      dt-bindings: panel-simple-dsi: add Khadas TS050 panel bindings
      drm: panel: add Khadas TS050 panel driver

Nicholas Kazlauskas (6):
      drm/amd/display: Use hardware sequencer functions for PG control
      drm/amd/display: Allow dmub srv hardware reset before HW init
      drm/amd/display: Guard against NULL pointer deref when get_i2c_info f=
ails
      drm/amd/display: Fix reset sequence with driver direct DMCUB fw load
      drm/amd/display: Drop SOC bounding box hookup in DM/DC
      drm/amd/display: Fix CW4 programming for dmub30 cached inbox

Nicolas Saenz Julienne (1):
      drm/v3d: Use platform_get_irq_optional() to get optional IRQs

Nikola Cornij (2):
      drm/amd/display: Add a missing DCN3.01 API mapping
      drm/amd/display: Reject too small viewport size when validating plane

Nirmoy Das (11):
      drm/amdgpu: clean up bo in vce and vcn test
      PCI: Add pci_rebar_bytes_to_size()
      PCI: Add a REBAR size quirk for Sapphire RX 5600 XT Pulse
      drm/amdgpu: Resize BAR0 to the maximum available size, even if
it doesn't cover VRAM
      drm/amdgpu: Remove unused variable
      drm/amdgpu: cleanup struct amdgpu_ring
      drm/amdgpu: enable only one high prio compute queue
      drm/amdgpu: add wave limit functionality for gfx8,9
      drm/amdgpu: enable gfx wave limiting for high priority compute jobs
      drm/amdgpu: enable wave limit on non high prio cs pipes
      drm/amdgpu/display: remove hdcp_srm sysfs on device removal

Ori Messinger (1):
      amdgpu: Add Missing Sienna Cichlid DID

Paul Cercueil (4):
      drm/ingenic: Add basic PM support
      drm/ingenic: Compute timings according to adjusted_mode->crtc_*
      drm/ingenic: Properly compute timings when using a 3x8-bit panel
      drm/ingenic: Add support for serial 8-bit delta-RGB panels

Phil Elwell (2):
      drm/v3d: Set dma_mask as well as coherent_dma_mask
      drm/v3d: Don't clear MMU control bits on exception

Philipp Zabel (21):
      drm/encoder: make encoder control functions optional
      drm: add drmm_encoder_alloc()
      drm/simple_kms_helper: add drmm_simple_encoder_alloc()
      drm/plane: add drmm_universal_plane_alloc()
      drm/crtc: add drmm_crtc_alloc_with_planes()
      drm/imx: dw_hdmi-imx: move initialization into probe
      drm/imx: imx-ldb: use local connector variable
      drm/imx: imx-ldb: move initialization into probe
      drm/imx: imx-tve: use local encoder and connector variables
      drm/imx: imx-tve: move initialization into probe
      drm/imx: imx-tve: use devm_clk_register
      drm/imx: parallel-display: use local bridge and connector variables
      drm/imx: parallel-display: move initialization into probe
      drm/imx: dw_hdmi-imx: use drm managed resources
      drm/imx: imx-ldb: use drm managed resources
      drm/imx: imx-tve: use drm managed resources
      drm/imx: parallel-display: use drm managed resources
      drm/imx: ipuv3-plane: use drm managed resources
      drm/imx: ipuv3-crtc: use drm managed resources
      drm/imx: dw_hdmi-imx: depend on OF to fix randconfig compile
tests on x86_64
      drm/modes: add non-OF stub for of_get_drm_display_mode

Pratik Vishwakarma (1):
      Revert "drm/amd/display: Tune min clk values for MPO for RV"

Prike Liang (2):
      drm/amdgpu: add green_sardine device id (v2)
      drm/amdgpu/pm: no need GPU status set since
mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL added in FSDL

Qinglang Miao (3):
      drm: rcar-du: Fix PM reference leak in rcar_cmm_enable()
      drm/tegra: Fix reference leak when pm_runtime_get_sync() fails
      drm/lima: fix reference leak in lima_pm_busy

Qingqing Zhuo (2):
      drm/amd/display: NULL pointer hang
      drm/amd/display: DP HDCP Compliance 1A-08/09 tests fail

Radhakrishna Sripada (2):
      drm/framebuffer: Format modifier for Intel Gen 12 render
compression with Clear Color
      drm/i915/tgl: Add Clear Color support for TGL Render Decompression

Ramesh Errabolu (1):
      drm/amdgpu: Limit the maximum size of contiguous VRAM that can
be encapsulated by an instance of DRM memory node

Randy Dunlap (1):
      fbdev: aty: SPARC64 requires FB_ATY_CT

Raymond Yang (1):
      drm/amd/display: fix seamless boot stream adding algorithm

Rob Herring (1):
      dt-bindings: display: Use OF graph schema

Rodrigo Siqueira (4):
      Revert "drm/amd/display: Fixed Intermittent blue screen on OLED panel=
"
      Revert "drm/amd/display: Fix unused variable warning"
      Revert "drm/amdgpu/disply: fix documentation warnings in display mana=
ger"
      Revert "drm/amd/display: Expose new CRC window property"

Rodrigo Vivi (3):
      Merge tag 'gvt-next-fixes-2020-12-25' of
https://github.com/intel/gvt-linux into drm-intel-next
      Merge drm/drm-next into drm-intel-next
      Merge drm/drm-next into drm-intel-next

Roland Scheidegger (1):
      drm/vmwgfx: add Zack Rusin as maintainer

Ryan Taylor (1):
      drm/amd/pm: add pptable_funcs documentation (v3)

Sam Ravnborg (35):
      video: Fix kernel-doc warnings in of_display_timing + of_videomode
      video: fbcon: Fix warnings by using pr_debug() in fbcon
      video: fbdev: s1d13xxxfb: Fix kernel-doc and set but not used warning=
s
      video: fbdev: aty: Delete unused variable in radeon_monitor
      video: fbdev: aty: Fix set but not used warnings
      video: fbdev: aty: Fix set but not used warnings in mach64_ct
      video: fbdev: sis: Fix defined but not used warnings
      video: fbdev: sis: Fix defined but not used warning of SiS_TVDelay
      video: fbdev: sis: Fix set but not used warnings in init.c
      video: fbdev: sis: Fix set but not used warnings in sis_main
      video: fbdev: via: Fix set but not used warning for mode_crt_table
      video: fbdev: tdfx: Fix set but not used warning in att_outb()
      video: fbdev: riva: Fix kernel-doc and set but not used warnings
      video: fbdev: pm2fb: Fix kernel-doc warnings
      video: fbdev: tgafb: Fix kernel-doc and set but not used warnings
      video: fbdev: mx3fb: Fix kernel-doc, set but not used and string warn=
ings
      video: fbdev: sstfb: Updated logging to fix set but not used warnings
      video: fbdev: neofb: Fix set but not used warning for CursorMem
      video: fbdev: nvidia: Fix set but not used warnings
      video: fbdev: omapfb: Fix set but not used warnings in dsi
      video: fbdev: s3c-fb: Fix kernel-doc and set but not used warnings
      video: fbdev: uvesafb: Fix string related warnings
      video: fbdev: cirrusfb: Fix kernel-doc and set but not used warnings
      video: fbdev: hgafb: Fix kernel-doc warnings
      video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
      video: fbdev: omapfb: Fix set but not used warnings in hdmi*_core
      video: fbdev: uvesafb: Fix set but not used warning
      video: fbdev: sparc drivers: fix kernel-doc warnings for blank_mode
      video: fbdev: mmp: Fix kernel-doc warning for lcd_spi_write
      video: fbdev: wmt_ge_rops: Fix function not declared warnings
      video: fbdev: goldfishfb: Fix defined but not used warning
      video: fbdev: gbefb: Fix set but not used warning
      video: fbdev: efifb: Fix set but not used warning for screen_pitch
      video: fbdev: controlfb: Fix set but not used warnings
      video: fbdev: sis: Drop useless call to SiS_GetResInfo()

Samson Tam (1):
      drm/amd/display: fix initial bounding box values for dcn3.02

Sean Paul (2):
      drm/i915/display/tc: Only WARN once for bogus tc port flag
      drm/i915/hdcp: Disable the QSES check for HDCP 1.4 over MST

Sebastian Reichel (50):
      Revert "drm/omap: dss: Remove unused omap_dss_device operations"
      drm/omap: drop unused dsi.configure_pins
      drm/omap: dsi: use MIPI_DSI_FMT_* instead of OMAP_DSS_DSI_FMT_*
      drm/omap: constify write buffers
      drm/omap: dsi: add generic transfer function
      drm/omap: panel-dsi-cm: convert to transfer API
      drm/omap: dsi: unexport specific data transfer functions
      drm/omap: dsi: drop virtual channel logic
      drm/omap: dsi: simplify write function
      drm/omap: dsi: simplify read functions
      drm/omap: dsi: switch dsi_vc_send_long/short to mipi_dsi_msg
      drm/omap: dsi: introduce mipi_dsi_host
      drm/omap: panel-dsi-cm: use DSI helpers
      drm/omap: dsi: request VC via mipi_dsi_attach
      drm/omap: panel-dsi-cm: drop hardcoded VC
      drm/omap: panel-dsi-cm: use common MIPI DCS 1.3 defines
      drm/omap: dsi: drop unused memory_read()
      drm/omap: dsi: drop unused get_te()
      drm/omap: dsi: drop unused enable_te()
      drm/omap: dsi: drop useless sync()
      drm/omap: dsi: use pixel-format and mode from attach
      drm/omap: panel-dsi-cm: use bulk regulator API
      drm/omap: dsi: lp/hs switching support for transfer()
      drm/omap: dsi: move TE GPIO handling into core
      drm/omap: dsi: drop custom enable_te() API
      drm/omap: dsi: do bus locking in host driver
      drm/omap: dsi: untangle ulps ops from enable/disable
      drm/omap: dsi: do ULPS in host driver
      drm/omap: dsi: move panel refresh function to host
      drm/omap: dsi: Reverse direction of the DSS device
enable/disable operations
      drm/omap: dsi: drop custom panel capability support
      drm/omap: dsi: convert to drm_panel
      drm/omap: drop omapdss-boot-init
      drm/omap: dsi: implement check timings
      drm/omap: panel-dsi-cm: use DEVICE_ATTR_RO
      drm/omap: panel-dsi-cm: support unbinding
      drm/omap: panel-dsi-cm: fix remove()
      drm/omap: remove global dss_device variable
      drm/panel: Move OMAP's DSI command mode panel driver
      drm/omap: dsi: Register a drm_bridge
      drm/omap: remove legacy DSS device operations
      drm/omap: remove unused omap_connector
      drm/omap: simplify omap_display_id
      drm/omap: drop unused DSS next pointer
      drm/omap: drop DSS ops_flags
      drm/omap: drop dssdev display field
      drm/omap: simplify DSI manual update code
      drm/omap: dsi: simplify pin config
      ARM: omap2plus_defconfig: Update for moved DSI command mode panel
      video: omapfb2: Make standard and custom DSI command mode panel
driver mutually exclusive

Simon Ser (19):
      drm: document that user-space should force-probe connectors
      drm: fix typos in plane and CRTC overviews
      drm: rework description of primary and cursor planes
      drm: validate possible_crtcs for primary and cursor planes
      drm: require a non_NULL drm_crtc.primary
      drm/doc: rename FB_DAMAGE_CLIPS section
      drm/doc: move composition function docs to new section
      drm/doc: move damage tracking functions to new section
      drm/doc: move color management functions under CRTC section
      drm/doc: the KMS properties section is for user-space devs
      drm/doc: introduce new section for standard plane properties
      drm/doc: fix reference to drm_format_modifier_blob
      drm: require each CRTC to have a unique primary plane
      drm/doc: atomic implicitly enables other caps
      drm: warn if cursor plane is set with legacy funcs
      drm/doc: re-format drm.h file comment
      drm/doc: demote old doc-comments in drm.h
      drm/doc: render drm.h uapi docs
      drm/fourcc: fix Amlogic format modifier masks

Souptick Joarder (1):
      drm: amdgpu: pm: Mark vangogh_clk_dpm_is_enabled() as static

Stylon Wang (4):
      drm/amd/display: Report Freesync to vrr_range debugfs entry in DRM
      drm/amd/display: Revert "Fix EDID parsing after resume from suspend"
      drm/amd/display: Enable "trigger_hotplug" debugfs on all outputs
      drm/amd/display: Add Freesync HDMI support to DMCU

Sumera Priyadarsini (5):
      drm/vkms: Add setup and testing information
      drm/vkms: Add vkms_config type
      drm/vkms: Add support for writeback module
      drm/vkms: Add information about module options
      drm/vblank: Fix typo in docs

Sung Lee (2):
      drm/amd/display: DCN2X Find Secondary Pipe properly in MPO + ODM Case
      drm/amd/display: Add more Clock Sources to DCN2.1

Swathi Dhanavanthri (2):
      drm/i915/tgl, rkl, dg1: Apply WA_1406941453 to TGL, RKL and DG1
      drm/i915/dg1: Implement WA_16011163337

Swati Sharma (4):
      drm/edid: Add additional HFVSDB fields for HDMI2.1
      drm/edid: Parse MAX_FRL field from HFVSDB block
      drm/dp_helper: Add support for link failure detection
      drm/i915: Add support for enabling link status and recovery

Taimur Hassan (1):
      drm/amd/display: Workaround for some legacy DP-VGA dongles

Tao Zhou (2):
      drm/amdkfd: check more client ids in interrupt handler
      drm/amdgpu: enable gpu recovery for dimgrey_cavefish

Thomas Zimmermann (38):
      drm/cma-helper: Remove prime infix from GEM object functions
      drm/cma-helper: Implement mmap as GEM CMA object functions
      drm/ast: Don't pin cursor source BO explicitly during update
      drm/ast: Only map cursor BOs during updates
      drm/ast: Remove references to struct drm_device.pdev
      drm/bochs: Remove references to struct drm_device.pdev
      drm/cirrus: Remove references to struct drm_device.pdev
      drm/gma500: Fix trailing whitespaces
      drm/gma500: Remove references to struct drm_device.pdev
      drm/mgag200: Remove references to struct drm_device.pdev
      drm/qxl: Remove references to struct drm_device.pdev
      drm/radeon: Fix trailing whitespaces
      drm/radeon: Remove references to struct drm_device.pdev
      drm/vboxvideo: Remove references to struct drm_device.pdev
      drm/virtgpu: Remove references to struct drm_device.pdev
      drm/vmwgfx: Remove references to struct drm_device.pdev
      drm/amdgpu: Fix trailing whitespaces
      drm/amdgpu: Remove references to struct drm_device.pdev
      drm/hibmc: Remove references to struct drm_device.pdev
      drm/nouveau: Remove references to struct drm_device.pdev
      drm/vc4: Use drm_gem_cma_vmap() directly
      drm/vc4: Make several BO functions static
      drm/vc4: Move mmap implementation into GEM object function
      drm: Inline AGP wrappers into their only callers
      drm: Implement drm_need_swiotlb() in drm_cache.c
      drm: Build drm_memory.o only for legacy drivers
      drm: Merge CONFIG_DRM_VM into CONFIG_DRM_LEGACY
      drm/radeon: Store PCI controller in struct radeon_device.hose
      drm: Move struct drm_device.hose to legacy section
      drm: Include <linux/mem_encrypt.h> in drm_cache.c
      drm/hisilicon/hibmc: Remove hibmc_ttm.c
      drm/vc4: Initialize vc4_drm_driver with CMA helper defaults
      drm: Set vm_ops to GEM object's values during mmap
      drm: Upcast struct drm_device.dev to struct pci_device; replace pdev
      drm/gma500: Remove Medfield support
      drm/gma500: Drop DRM_GMA3600 config option
      drm/gma500: Remove CONFIG_X86 conditionals from source files
      drm/gma500: Remove dependency on TTM

Tian Tao (23):
      drm/hisilicon: Code refactoring for hibmc_drm_drv
      drm/irq: Add the new api to install irq
      drm/hisilicon: Use the new api devm_drm_irq_install
      drm/hisilicon: Use managed VRAM-helper initialization
      drm/hisilicon: Delete the entire file hibmc_ttm.c
      drm/drv: switch to using devm_add_action_or_reset()
      drm/hisilicon: Use managed mode-config init
      drm/hisilicon: Delete unused local parameters
      drm/drv: Remove invalid assignments
      drm/hisilicon: Fix use-after-free
      drm/hisilicon: Fix rmmod hibmc_drm failed
      drm/qxl: use flexible-array member instead of zero-length array
      drm/hisilicon: Use pcim_enable_device()
      drm/hisilicon: Remove drm_dev_put in hibmc
      drm/tve200: remove unused including <linux/version.h>
      drm/amd/display: remove unused including <linux/version.h>
      drm/amd/display: remove useless else if
      drm/amd/display: fix comparison pointer to bool warning in dc.c
      drm/hisilicon: Use simple encoder
      drm/hisilicon: Delete the empty function mode_valid
      drm/hisilicon: Use drm_crtc_mask()
      drm/hisilicon: Fix build error
      drm/amdgpu: fix unnecessary NULL check warnings

Tom Rix (2):
      drm/i915: remove trailing semicolon in macro definition
      omapfb: fbcon: remove trailing semicolon in macro definition

Tomi Valkeinen (42):
      dt-bindings: dp-connector: add binding for DisplayPort connector
      drm/bridge: display-connector: add DP support
      drm: automatic legacy gamma support
      drm: add legacy support for using degamma for gamma
      drm/omap: use degamma property for gamma table
      drm/omap: rearrange includes in omapdss.h
      drm/omap: squash omapdrm sub-modules into one
      drm/omap: remove unused display.c
      drm/omap: drop unused owner field
      drm/omap: remove dispc_ops
      drm/omap: remove dss_mgr_ops
      drm/panel: panel-dsi-cm: use MIPI_DCS_GET_ERROR_COUNT_ON_DSI
      drm/panel: panel-dsi-cm: cleanup tear enable
      ARM: dts: omap5: add address-cells & size-cells to dsi
      drm/omap: pll: fix iteration loop check
      drm/omap: dsi: set trans_mode according to client mode_flags
      drm/panel: panel-dsi-cm: set column & page at setup
      drm/omap: dsi: send nop instead of page & column
      drm/omap: dsi: simplify VC handling
      drm/omap: dsi: drop useless channel checks
      drm/omap: dsi: cleanup dispc channel usage
      drm/omap: dsi: rename 'channel' to 'vc'
      drm/omap: dsi: pass vc and channel to various functions
      drm/omap: dsi: untangle vc & channel
      drm/omap: dsi: skip dsi_vc_enable_hs when already in correct mode
      drm/omap: dsi: enable HS before sending the frame
      drm/omap: dsi: use separate VCs for cmd and video
      drm/panel: panel-dsi-cm: remove extra 'if'
      drm/panel: panel-dsi-cm: add panel database to driver
      drm/panel: panel-dsi-cm: drop unneeded includes
      drm/omap: dsi: move structs & defines to dsi.h
      drm/omap: dsi: move enable/disable to bridge enable/disable
      drm/omap: dsi: display_enable cleanup
      drm/omap: dsi: display_disable cleanup
      drm/omap: dsi: rename dsi_display_* functions
      drm/omap: dsi: cleanup initial vc setup
      drm/omap: dsi: split video mode enable/disable into separate func
      drm/omap: dsi: fix and cleanup ddr_clk_always_on
      drm/omap: dsi: remove ulps support
      drm/omap: dsi: fix DCS_CMD_ENABLE
      drm/omap: dsi: allow DSI commands to be sent early
      MAINTAINERS: Update addresses for TI display drivers

Tvrtko Ursulin (8):
      drm/i915: Avoid memory leak with more than 16 workarounds on a list
      drm/i915: Show timeline dependencies for debug
      drm/i915/guc: Use correct lock for accessing guc->mmio_msg
      drm/i915/guc: Use correct lock for CT event handler
      drm/i915/pmu: Deprecate I915_PMU_LAST and optimize state tracking
      drm/i915/pmu: Don't grab wakeref when enabling events
      drm/i915/pmu: Use raw clock for rc6 estimation
      drm/i915/pmu: Remove !CONFIG_PM code

Uma Shankar (15):
      drm/i915/display: Add HDR Capability detection for LSPCON
      drm/i915/display: Enable HDR on gen9 devices with MCA Lspcon
      drm/i915/display: Attach HDR property for capable Gen9 devices
      drm/i915/display: Fixes quantization range for YCbCr output
      drm/i915/display: Add a WARN for invalid output range and format
      drm/i915/display: Attach content type property for LSPCON
      drm/i915/display: Enable colorspace programming for LSPCON devices
      drm/i915/display: Nuke bogus lspcon check
      drm/i915/display: Enable HDR for Parade based lspcon
      drm/i915/lspcon: Create separate infoframe_enabled helper
      drm/i915/display: Implement infoframes readback for LSPCON
      drm/i915/display: Implement DRM infoframe read for LSPCON
      drm/i915/lspcon: Do not send DRM infoframes to non-HDMI sinks
      drm/i915/display/tgl: Disable FBC with PSR2
      Revert "drm/i915/display/fbc: Disable fbc by default on TGL"

Venkata Ramana Nayana (1):
      drm/i915/gt: Retain default context state across shrinking

Venkata Sandeep Dhanalakota (1):
      drm/i915/lmem: Limit block size to 4G

Victor Lu (3):
      drm/amd/display: Fix dc_sink kref count in emulated_link_detect
      drm/amd/display: Free atomic state after drm_atomic_commit
      drm/amd/display: Decrement refcount of dc_sink before reassignment

Victor Zhao (1):
      drm/amdgpu/psp: fix psp gfx ctrl cmds

Ville Syrj=C3=A4l=C3=A4 (46):
      drm/i915: Split intel_attach_colorspace_property() into HDMI vs.
DP variants
      drm/i915: Track logically enabled planes for hw state
      drm/i915: Add intel_atomic_add_affected_planes()
      drm/i915: Properly flag modesets for all bigjoiner pipes
      drm/i915: Call kill_bigjoiner_slave() earlier
      drm/i915: Reduce duplicated switch cases in hpd code
      drm/i915: Fix checkpatch warns in cursor code
      drm/i915: Try to use fast+narrow link on eDP again and fall back
to the old max strategy on failure
      drm/modes: Switch to 64bit maths to avoid integer overflow
      drm/i915: Drop one more useless master_transcoder assignment
      drm/i915: Only enable DFP 4:4:4->4:2:0 conversion when
outputting YCbCr 4:4:4
      drm/i915: Disable TRAINING_PATTERN_SET before stopping the TPS
transmission
      drm/i915: Fix the training pattern debug print
      drm/i915: Fix the PHY compliance test vs. hotplug mishap
      drm/i915: Drop redundant parens
      drm/i915: Generalize the async flip capability check
      drm/i915: Add plane vfuncs to enable/disable flip_done interrupt
      drm/i915: Move the async_flip bit setup into the .async_flip() hook
      drm/i915: Reuse the async_flip() hook for the async flip disable w/a
      drm/i915: Fix ICL MG PHY vswing handling
      drm/i915: Unify the sanity checks for the buf trans tables
      drm/i915: Store framestart_delay in dev_priv
      drm/i915: Extract intel_mode_vblank_start()
      drm/i915: Extract intel_crtc_scanlines_since_frame_timestamp()
      drm/i915/display: VRR + DRRS cannot be enabled together
      drm/i915: Rename VRR_CTL reg fields
      drm/i915/display: Helpers for VRR vblank min and max start
      drm/i915: Add vrr state dump
      drm/i915: Fix vblank timestamps with VRR
      drm/i915: Fix vblank evasion with vrr
      drm/i915: Extract intel_crtc_ddb_weight()
      drm/i915: Pass the crtc to skl_compute_dbuf_slices()
      drm/i915: Introduce intel_dbuf_slice_size()
      drm/i915: Introduce skl_ddb_entry_for_slices()
      drm/i915: Add pipe ddb entries into the dbuf state
      drm/i915: Extract intel_crtc_dbuf_weights()
      drm/i915: Encapsulate dbuf state handling harder
      drm/i915: Do a bit more initial readout for dbuf
      drm/i915: WARN if plane src coords are too big
      drm/i915: Limit plane stride to below TILEOFF.x limit
      drm/i915: Implement async flips for bdw
      drm/i915: Implement async flip for ivb/hsw
      drm/i915: Implement async flip for ilk/snb
      drm/i915: Implement async flips for vlv/chv
      drm/i915: Reject 446-480MHz HDMI clock on GLK
      drm/i915: Disallow plane x+w>stride on ilk+ with X-tiling

Vladimir Stempen (1):
      drm/amd/display: Fixed corruptions on HPDRX link loss restore

Wang Xiaojun (1):
      drm: rcar-du: Fix the return check of of_parse_phandle and
of_find_device_by_node

Wayne Lin (3):
      drm/amd/display: Fix to be able to stop crc calculation
      drm/amdgpu: Add otg vertical IRQ Source
      drm/amd/display: Add otg vertical interrupt0 support in DCN1.0

Wenjing Liu (2):
      drm/amd/display: correct some hdcp variable naming
      drm/amd/display: remove unused force_ignore_link_settings debug optio=
n

Wesley Chalmers (6):
      drm/amd/display: Initialize stack variable
      drm/amd/display: HUBP_IN_BLANK for DCN30
      drm/amd/display: Unblank hubp based on plane visibility
      drm/amd/display: New path for enabling DPG
      drm/amd/display: New sequence for HUBP blank
      drm/amd/display: DIO Supported for virtual displays

Wyatt Wood (2):
      drm/amd/display: Allow dmu_stg to support cached inbox for dmub
      drm/amd/display: Initialize dmub_rb_cmd unions to 0

Xiaogang Chen (1):
      drm: distinguish return value of drm_dp_check_and_send_link_address

Xiaojian Du (24):
      drm/amd/pm: correct the sensor value of power for vangogh
      drm/amd/pm: add support to umd P-state "fetch" function for vangogh
      drm/amd/pm: add new feature map macros to resolve duplicate name
      drm/amd/pm: add two new sysfs nodes for vangogh
      drm/amd/pm: enable the "fetch" function of pp_dpm_vclk/dclk for vango=
gh
      drm/amd/pm: improve the fine grain tuning function for RV/RV2/PCO
      drm/amd/pm: add the fine grain tuning function for renoir
      drm/amd/pm: enable the fine grain tuning function for renoir
      drm/amd/pm: add some basic functions to support umd P-state
function for vangogh.
      drm/amd/pm: add some basic functions to support umd P-state
function for vangogh.
      drm/amd/pm: add support to umd P-state function for vangogh
      drm/amd/pm: fix the failure when change power profile for renoir
      drm/amd/pm: enable dclk/vclk dpm function in "auto" power
profile for vangogh
      drm/amd/pm: improve the fine grain tuning function for RV/RV2/PCO
      drm/amd/pm: add the parameters of power profiles for vangogh
      drm/amd/pm: modify the fine grain tuning function for Renoir
      drm/amd/pm: support the function to change power profile mode for van=
gogh
      drm/amd/pm: fix one superfluous error for renoir
      drm/amd/pm: add the workload map for vangogh
      drm/amd/pm: modify the fine grain tuning function for Renoir
      drm/amd/pm: modify the fine grain tuning function for vangogh
      drm/amd/pm: fill in the data member of v2 gpu metrics table for vango=
gh
      drm/amd/pm: remove some useless code for vangogh
      drm/amd/pm: make the error log more clear for fine grain tuning funct=
ion

Xiaomeng Hou (3):
      drm/amd/pm: update the smu v11.5 smc header for vangogh
      drm/amd/pm: modify the power limit level parameter from bool to enum =
type
      drm/amd/pm: add support for hwmon control of slow and fast PPT
limit on vangogh

Xu Wang (2):
      drm: bridge: dw-hdmi: Remove redundant null check before
clk_disable_unprepare
      drm: bridge: adv7511: Remove redundant null check before
clk_disable_unprepare

Yan Zhao (11):
      drm/i915/gvt: parse init context to update cmd accessible reg whiteli=
st
      drm/i915/gvt: scan VM ctx pages
      drm/i915/gvt: filter cmds "srm" and "lrm" in cmd_handler
      drm/i915/gvt: filter cmds "lrr-src" and "lrr-dst" in cmd_handler
      drm/i915/gvt: filter cmd "pipe-ctrl" in cmd_handler
      drm/i915/gvt: export find_mmio_info
      drm/i915/gvt: make width of mmio_attribute bigger
      drm/i915/gvt: introduce a new flag F_CMD_WRITE_PATCH
      drm/i915/gvt: statically set F_CMD_WRITE_PATCH flag
      drm/i915/gvt: update F_CMD_WRITE_PATCH flag when parsing init ctx
      drm/i915/gvt: unify lri cmd handler and mmio handlers

Yang Li (4):
      drm/amd/display: Simplify bool comparison
      drm/amd/display: Simplify bool comparison
      drm/amd/display: Simplify bool comparison
      drm/amd/display: Simplify bool comparison

Ye Bin (1):
      drm/nouveau: remove set but not used variable =E2=80=98pdev=E2=80=99 =
in nouveau_bios_init

Yongqiang Niu (15):
      dt-bindings: mediatek: add description for mt8183 display
      dt-bindings: mediatek: add description for mt8192 display
      drm/mediatek: Check if fb is null
      dt-bindings: mediatek: add rdma-fifo-size description for mt8183 disp=
lay
      dt-bindings: mediatek: add description for postmask
      drm/mediatek: Fix aal size config
      drm/mediatek: Add fifo_size into rdma private data
      drm/mediatek: Separate gamma module
      drm/mediatek: Add has_dither private data for gamma
      drm/mediatek: Add support for SoC MT8183
      drm/mediatek: Enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
      drm/mediatek: Enable dither function
      drm/mediatek: Separate ccorr module
      drm/mediatek: Fix ccorr size config
      drm/mediatek: Add matrix_bits private data for ccorr

Yu-ting Shen (1):
      drm/amd/display: doesn't reprogram AMD OUI

Yue Zou (1):
      vgaarb: Remove unneeded semicolons

Zack Rusin (8):
      drm/vmwgfx: Remove stealth mode
      drm/vmwgfx: Switch to a managed drm device
      drm/vmwgfx: Cleanup fifo mmio handling
      drm/vmwgfx: Cleanup pci resource allocation
      drm/vmwgfx: Remove the throttling code
      drm/vmwgfx: Cleanup the cmd/fifo split
      drm/vmwgfx: Fix display register usage for some older configs
      drm/vmwgfx: Fix some memory leaks on errors

Zhang Xiaoxu (2):
      drm/i915/selftests: Fix wrong return value of perf_series_engines()
      drm/i915/selftests: Fix wrong return value of perf_request_latency()

Zhaoge Zhang (2):
      drm: Removes invalid function return value comment information
      drm: Fix macro name DRM_MODE_PROP_OBJECT in code comment

Zheng Yongjun (3):
      drm/omap: Delete useless kfree code
      gpu: drm: imx: convert comma to semicolon
      gpu/drm/radeon: use DIV_ROUND_UP macro to do calculation

Zhenyu Wang (1):
      drm/i915: Try to guess PCH type even without ISA bridge

ZhiJie.Zhang (2):
      drm/amdgpu: Repeat assignment to max_slave_planes
      drm/amdgpu/display: these forward declarations are not used

Zqiang (1):
      udlfb: Fix memory leak in dlfb_usb_probe

chen gong (2):
      drm/amdgpu/gfx10: add updated GOLDEN_TSC_COUNT_UPPER/LOWER
register offsets for VGH
      drm/amdgpu/gfx10: update CGTS_TCC_DISABLE and
CGTS_USER_TCC_DISABLE register offsets for VGH

mengwang (1):
      drm/amdgpu: add new device id for Renior

pengzhou (1):
      drm/amdgpu: do optimization for psp command submit

xinhui pan (1):
      drm/amdgpu: Fix a false positive when pin non-VRAM memory

 .../allwinner,sun4i-a10-display-backend.yaml       |    23 +-
 .../allwinner,sun4i-a10-display-frontend.yaml      |    19 +-
 .../bindings/display/allwinner,sun4i-a10-hdmi.yaml |    19 +-
 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |    25 +-
 .../display/allwinner,sun4i-a10-tv-encoder.yaml    |     6 +-
 .../bindings/display/allwinner,sun6i-a31-drc.yaml  |    19 +-
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |     6 +-
 .../display/allwinner,sun8i-a83t-de2-mixer.yaml    |    19 +-
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |    19 +-
 .../display/allwinner,sun8i-r40-tcon-top.yaml      |   110 +-
 .../bindings/display/allwinner,sun9i-a80-deu.yaml  |    19 +-
 .../bindings/display/amlogic,meson-dw-hdmi.yaml    |     4 +-
 .../bindings/display/amlogic,meson-vpu.yaml        |     4 +-
 .../bindings/display/brcm,bcm2711-hdmi.yaml        |    20 +-
 .../bindings/display/brcm,bcm2835-dpi.yaml         |     7 +-
 .../bindings/display/brcm,bcm2835-dsi0.yaml        |     1 +
 .../bindings/display/bridge/analogix,anx7625.yaml  |     6 +-
 .../bindings/display/bridge/analogix,anx7814.yaml  |    19 +-
 .../bindings/display/bridge/anx6345.yaml           |    18 +-
 .../bindings/display/bridge/cdns,mhdp8546.yaml     |    22 +-
 .../bindings/display/bridge/chrontel,ch7033.yaml   |     6 +-
 .../bindings/display/bridge/intel,keembay-dsi.yaml |    14 +-
 .../bindings/display/bridge/ite,it6505.yaml        |     2 +-
 .../bindings/display/bridge/lontium,lt9611.yaml    |    70 +-
 .../bindings/display/bridge/lvds-codec.yaml        |    18 +-
 .../bindings/display/bridge/nwl-dsi.yaml           |    41 +-
 .../devicetree/bindings/display/bridge/ps8640.yaml |    24 +-
 .../bindings/display/bridge/renesas,lvds.yaml      |    24 +-
 .../bindings/display/bridge/simple-bridge.yaml     |    18 +-
 .../bindings/display/bridge/snps,dw-mipi-dsi.yaml  |     7 +-
 .../display/bridge/thine,thc63lvd1024.yaml         |    35 +-
 .../bindings/display/bridge/ti,sn65dsi86.yaml      |    45 +-
 .../bindings/display/bridge/ti,tfp410.yaml         |    24 +-
 .../bindings/display/bridge/toshiba,tc358762.yaml  |    52 +-
 .../bindings/display/bridge/toshiba,tc358768.yaml  |    48 +-
 .../bindings/display/bridge/toshiba,tc358775.yaml  |    19 +-
 .../display/connector/analog-tv-connector.yaml     |     1 +
 .../bindings/display/connector/dp-connector.yaml   |    56 +
 .../bindings/display/connector/dvi-connector.yaml  |     1 +
 .../bindings/display/connector/hdmi-connector.yaml |     1 +
 .../bindings/display/connector/vga-connector.yaml  |     1 +
 .../bindings/display/imx/nxp,imx8mq-dcss.yaml      |     2 +-
 .../devicetree/bindings/display/ingenic,ipu.yaml   |     5 +-
 .../devicetree/bindings/display/ingenic,lcd.yaml   |    10 +-
 .../bindings/display/intel,keembay-display.yaml    |     2 +-
 .../bindings/display/mediatek/mediatek,disp.txt    |    12 +-
 .../display/panel/advantech,idk-2121wr.yaml        |    21 +-
 .../display/panel/mantix,mlaf057we51-x.yaml        |     1 +
 .../bindings/display/panel/panel-common.yaml       |    11 +-
 .../bindings/display/panel/panel-simple-dsi.yaml   |     2 +
 .../bindings/display/panel/panel-simple.yaml       |     2 +
 .../bindings/display/panel/samsung,s6e63m0.yaml    |     4 +-
 .../display/rockchip/rockchip,rk3066-hdmi.yaml     |    16 +-
 .../bindings/display/rockchip/rockchip-vop.yaml    |     5 +-
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |    12 +-
 .../devicetree/bindings/display/st,stm32-ltdc.yaml |     8 +-
 .../devicetree/bindings/display/ste,mcde.txt       |   104 -
 .../devicetree/bindings/display/ste,mcde.yaml      |   168 +
 .../bindings/display/ti/ti,am65x-dss.yaml          |    19 +-
 .../bindings/display/ti/ti,j721e-dss.yaml          |    23 +-
 .../devicetree/bindings/display/ti/ti,k2g-dss.yaml |     3 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |     2 +
 Documentation/gpu/drm-kms.rst                      |    52 +-
 Documentation/gpu/drm-uapi.rst                     |     3 +
 Documentation/gpu/i915.rst                         |     2 +-
 Documentation/gpu/todo.rst                         |    19 +
 Documentation/gpu/vkms.rst                         |    82 +
 MAINTAINERS                                        |    11 +-
 arch/arm/boot/dts/omap5.dtsi                       |     6 +
 arch/arm/configs/omap2plus_defconfig               |     2 +-
 drivers/dma-buf/Kconfig                            |     8 +
 drivers/dma-buf/dma-buf.c                          |   120 +-
 drivers/dma-buf/st-dma-fence.c                     |     7 +-
 drivers/gpu/drm/Kconfig                            |     5 -
 drivers/gpu/drm/Makefile                           |     6 +-
 drivers/gpu/drm/amd/amdgpu/Makefile                |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c         |    87 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   138 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c |     1 -
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c   |     1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |    24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c           |     5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   144 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |    18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |    20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fw_attestation.c |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |    15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h            |    40 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |     9 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c             |    45 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h             |    17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |     3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |    10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h           |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c         |    12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h         |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |   195 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h            |    17 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c           |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h           |     7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c  |   176 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h  |    36 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h          |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |    16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h          |     4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c            |     2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |     9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c           |     8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c             |     4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |     3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c           |    10 +-
 drivers/gpu/drm/amd/amdgpu/athub_v2_0.c            |     1 -
 drivers/gpu/drm/amd/amdgpu/athub_v2_1.c            |     1 -
 drivers/gpu/drm/amd/amdgpu/cik.c                   |    33 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c                 |    37 +-
 drivers/gpu/drm/amd/amdgpu/dce_virtual.c           |     5 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |    50 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c              |    72 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |    73 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |    14 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   105 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c              |   137 +
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h              |    31 +
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c              |   212 +
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h              |    31 +
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c            |    36 +-
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c             |     2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |     4 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c              |     1 +
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c             |   478 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c             |   124 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |    23 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |    10 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c             |    10 -
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |    10 -
 drivers/gpu/drm/amd/amdgpu/nv.c                    |   254 +-
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c             |    12 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |    38 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c             |     1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |    31 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |    42 +-
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c         |    77 +
 drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.h         |    30 +
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   126 +-
 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h   |   154 +
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c              |    37 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              |     1 -
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c             |   483 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c             |   703 +
 drivers/gpu/drm/amd/amdgpu/vega20_ih.h             |    30 +
 drivers/gpu/drm/amd/amdgpu/vi.c                    |    36 +-
 drivers/gpu/drm/amd/amdkfd/Kconfig                 |     2 +
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |     4 +-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    |    54 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |     6 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h          |     1 -
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   194 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |    14 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |    14 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |    10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h |     2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |     9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |    22 +
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |     7 +-
 drivers/gpu/drm/amd/display/dc/Makefile            |     4 +-
 drivers/gpu/drm/amd/display/dc/basics/conversion.c |     9 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.c  |    20 +-
 drivers/gpu/drm/amd/display/dc/basics/dc_common.h  |     4 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser.c  |   119 +-
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |    29 +-
 .../gpu/drm/amd/display/dc/bios/command_table.c    |    61 +
 .../drm/amd/display/dc/bios/command_table_helper.c |    20 +-
 .../amd/display/dc/bios/command_table_helper2.c    |    20 +-
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c   |    13 +-
 .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr.c |    30 +-
 .../amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c   |     3 +-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |    18 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c |     2 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |     3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   159 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   104 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c  |    19 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |    55 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |    46 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |     5 +-
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c   |     2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |    22 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h       |     3 +
 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c    |    80 +
 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h    |    44 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c         |     1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |     1 +
 drivers/gpu/drm/amd/display/dc/dc_link.h           |    10 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |    14 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c     |     2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c       |     8 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h       |     1 -
 .../gpu/drm/amd/display/dc/dce/dce_clock_source.c  |    73 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c      |   126 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.h      |    13 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_hw.c    |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c    |     9 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |     9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c       |    24 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h       |     2 -
 .../gpu/drm/amd/display/dc/dce/dce_panel_cntl.c    |     8 +-
 .../drm/amd/display/dc/dce/dce_stream_encoder.c    |     4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c |    23 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |     3 +
 .../gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c  |     3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |    28 +-
 drivers/gpu/drm/amd/display/dc/dce100/Makefile     |     2 +
 .../drm/amd/display/dc/dce100/dce100_resource.c    |    20 +-
 drivers/gpu/drm/amd/display/dc/dce110/Makefile     |     2 +
 .../drm/amd/display/dc/dce110/dce110_compressor.c  |    55 -
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |    33 +-
 .../drm/amd/display/dc/dce110/dce110_mem_input_v.c |    17 +-
 .../drm/amd/display/dc/dce110/dce110_resource.c    |    19 +-
 .../display/dc/dce110/dce110_timing_generator.c    |    76 +-
 .../display/dc/dce110/dce110_timing_generator_v.c  |    19 +-
 .../drm/amd/display/dc/dce110/dce110_transform_v.c |    19 +-
 drivers/gpu/drm/amd/display/dc/dce112/Makefile     |     2 +
 .../drm/amd/display/dc/dce112/dce112_resource.c    |    20 +-
 drivers/gpu/drm/amd/display/dc/dce120/Makefile     |     2 +
 .../amd/display/dc/dce120/dce120_hw_sequencer.c    |     2 +-
 .../drm/amd/display/dc/dce120/dce120_resource.c    |     6 +-
 .../display/dc/dce120/dce120_timing_generator.c    |    99 +-
 drivers/gpu/drm/amd/display/dc/dce60/Makefile      |     2 +
 .../gpu/drm/amd/display/dc/dce60/dce60_resource.c  |    18 +-
 .../amd/display/dc/dce60/dce60_timing_generator.c  |     4 +-
 drivers/gpu/drm/amd/display/dc/dce80/Makefile      |     2 +
 .../gpu/drm/amd/display/dc/dce80/dce80_resource.c  |     4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c    |     2 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  |    39 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h  |     5 +
 .../display/dc/dcn10/dcn10_hw_sequencer_debug.c    |     2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c  |     1 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |    15 +
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |    11 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c  |    11 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.h  |     1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |    12 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c  |     1 +
 .../drm/amd/display/dc/dcn20/dcn20_link_encoder.c  |     2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   122 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |     4 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c  |     1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |    30 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile      |     6 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp_cm.c    |     7 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h  |     1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   261 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h |     7 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  |     3 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c  |     1 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_resource.c  |   147 +-
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile     |     3 +-
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.c    |     1 +
 .../drm/amd/display/dc/dcn301/dcn301_resource.c    |   107 +-
 drivers/gpu/drm/amd/display/dc/dcn302/Makefile     |     3 +-
 .../drm/amd/display/dc/dcn302/dcn302_resource.c    |   188 +-
 .../drm/amd/display/dc/dcn302/dcn302_resource.h    |     2 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h         |     7 +-
 .../amd/display/dc/dml/dcn20/display_mode_vba_20.c |     9 +-
 .../display/dc/dml/dcn20/display_mode_vba_20v2.c   |   124 +-
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c |    51 +-
 .../amd/display/dc/dml/dcn30/display_mode_vba_30.c |     8 +-
 .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  |    32 +-
 .../drm/amd/display/dc/dml/display_mode_structs.h  |     1 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.c  |     2 +
 .../gpu/drm/amd/display/dc/dml/display_mode_vba.h  |     1 +
 .../display/dc/gpio/diagnostics/hw_factory_diag.c  |     1 +
 .../display/dc/gpio/diagnostics/hw_factory_diag.h  |     2 +
 .../dc/gpio/diagnostics/hw_translate_diag.c        |     1 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c       |     7 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   |    14 -
 drivers/gpu/drm/amd/display/dc/inc/core_types.h    |     1 +
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h   |     4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h       |    10 +
 .../drm/amd/display/dc/inc/hw/timing_generator.h   |     1 +
 drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h  |     8 +
 .../amd/display/dc/irq/dcn10/irq_service_dcn10.c   |    31 +
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c   |     2 +-
 drivers/gpu/drm/amd/display/dc/irq_types.h         |     1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |    35 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c  |    11 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h  |     2 +
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn30.c  |     3 +-
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    |     9 +-
 .../drm/amd/display/modules/color/color_table.c    |    26 +-
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h    |     2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |     4 +-
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h |     4 +-
 .../amd/display/modules/info_packet/info_packet.c  |    13 +-
 .../drm/amd/display/modules/power/power_helpers.c  |     8 +-
 drivers/gpu/drm/amd/include/amd_pcie.h             |     2 +
 drivers/gpu/drm/amd/include/amd_shared.h           |     1 +
 .../amd/include/asic_reg/oss/osssys_4_2_0_offset.h |   345 +
 .../include/asic_reg/oss/osssys_4_2_0_sh_mask.h    |  1300 ++
 .../include/asic_reg/smuio/smuio_11_0_6_offset.h   |    35 +
 .../include/asic_reg/smuio/smuio_11_0_6_sh_mask.h  |    41 +
 drivers/gpu/drm/amd/include/kgd_pp_interface.h     |     5 +-
 drivers/gpu/drm/amd/include/renoir_ip_offset.h     |     2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   259 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h            |   584 +-
 .../gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h   |     1 -
 drivers/gpu/drm/amd/pm/inc/smu_types.h             |     9 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |    22 +-
 drivers/gpu/drm/amd/pm/inc/smu_v11_5_ppsmc.h       |     6 +-
 drivers/gpu/drm/amd/pm/inc/smu_v12_0.h             |     2 -
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/hwmgr.c     |     2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c    |     4 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |     1 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |     2 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |     4 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c  |   137 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.h  |     1 +
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c  |    11 +-
 .../gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c  |    11 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   222 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  |    30 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c    |    32 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   371 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   122 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  1304 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.h   |    26 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   226 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     |    12 -
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |    93 +-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h             |     4 +
 drivers/gpu/drm/arc/arcpgu_crtc.c                  |     9 +-
 drivers/gpu/drm/arc/arcpgu_drv.c                   |     2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c   |     1 -
 drivers/gpu/drm/arm/malidp_crtc.c                  |     1 -
 drivers/gpu/drm/armada/armada_crtc.c               |     1 -
 drivers/gpu/drm/ast/ast_cursor.c                   |    55 +-
 drivers/gpu/drm/ast/ast_drv.c                      |     4 +-
 drivers/gpu/drm/ast/ast_drv.h                      |     2 -
 drivers/gpu/drm/ast/ast_main.c                     |    25 +-
 drivers/gpu/drm/ast/ast_mm.c                       |    17 +-
 drivers/gpu/drm/ast/ast_mode.c                     |     6 +-
 drivers/gpu/drm/ast/ast_post.c                     |     8 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     |     1 -
 drivers/gpu/drm/bochs/bochs_drv.c                  |     1 -
 drivers/gpu/drm/bochs/bochs_hw.c                   |     4 +-
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |     6 +-
 drivers/gpu/drm/bridge/display-connector.c         |    46 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |     6 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |     2 +-
 drivers/gpu/drm/drm_agpsupport.c                   |    67 +-
 drivers/gpu/drm/drm_atomic_helper.c                |    79 +-
 drivers/gpu/drm/drm_blend.c                        |     6 -
 drivers/gpu/drm/drm_bufs.c                         |     4 +-
 drivers/gpu/drm/drm_cache.c                        |    33 +
 drivers/gpu/drm/drm_client_modeset.c               |     7 +-
 drivers/gpu/drm/drm_color_mgmt.c                   |   125 +-
 drivers/gpu/drm/drm_crtc.c                         |   130 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   650 +-
 drivers/gpu/drm/drm_dp_mst_topology.c              |    32 +-
 drivers/gpu/drm/drm_drv.c                          |    16 +-
 drivers/gpu/drm/drm_dsc.c                          |    30 +-
 drivers/gpu/drm/drm_dumb_buffers.c                 |     8 +-
 drivers/gpu/drm/drm_edid.c                         |   110 +-
 drivers/gpu/drm/drm_encoder.c                      |   113 +-
 drivers/gpu/drm/drm_fb_helper.c                    |    25 +-
 drivers/gpu/drm/drm_file.c                         |     8 +-
 drivers/gpu/drm/drm_gem.c                          |    31 +-
 drivers/gpu/drm/drm_gem_cma_helper.c               |   141 +-
 drivers/gpu/drm/drm_internal.h                     |     3 +
 drivers/gpu/drm/drm_irq.c                          |    44 +-
 drivers/gpu/drm/drm_legacy.h                       |     2 +-
 drivers/gpu/drm/drm_memory.c                       |    51 -
 drivers/gpu/drm/drm_mode_config.c                  |    51 +-
 drivers/gpu/drm/drm_modes.c                        |     4 +-
 drivers/gpu/drm/drm_pci.c                          |    59 +-
 drivers/gpu/drm/drm_plane.c                        |   170 +-
 drivers/gpu/drm/drm_prime.c                        |    66 +-
 drivers/gpu/drm/drm_probe_helper.c                 |     3 +-
 drivers/gpu/drm/drm_simple_kms_helper.c            |    14 +-
 drivers/gpu/drm/drm_vblank.c                       |     2 +-
 drivers/gpu/drm/drm_vm.c                           |     2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c        |     3 +-
 drivers/gpu/drm/gma500/Kconfig                     |    17 +-
 drivers/gpu/drm/gma500/Makefile                    |    37 +-
 drivers/gpu/drm/gma500/cdv_device.c                |    30 +-
 drivers/gpu/drm/gma500/cdv_intel_crt.c             |     5 +-
 drivers/gpu/drm/gma500/cdv_intel_display.c         |     2 +-
 drivers/gpu/drm/gma500/cdv_intel_dp.c              |     4 +-
 drivers/gpu/drm/gma500/cdv_intel_hdmi.c            |     4 -
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |    11 +-
 drivers/gpu/drm/gma500/framebuffer.c               |    15 +-
 drivers/gpu/drm/gma500/gem.c                       |     6 +-
 drivers/gpu/drm/gma500/gem.h                       |     2 +
 drivers/gpu/drm/gma500/gma_device.c                |     4 +-
 drivers/gpu/drm/gma500/gma_display.c               |    12 +-
 drivers/gpu/drm/gma500/gtt.c                       |    20 +-
 drivers/gpu/drm/gma500/intel_bios.c                |     8 +-
 drivers/gpu/drm/gma500/intel_gmbus.c               |     4 +-
 drivers/gpu/drm/gma500/intel_i2c.c                 |     5 +-
 drivers/gpu/drm/gma500/mdfld_device.c              |   562 -
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |  1017 --
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.h             |    79 -
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |   603 -
 drivers/gpu/drm/gma500/mdfld_dsi_output.h          |   377 -
 drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c      |   679 -
 drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.h      |    80 -
 drivers/gpu/drm/gma500/mdfld_intel_display.c       |   966 --
 drivers/gpu/drm/gma500/mdfld_output.c              |    74 -
 drivers/gpu/drm/gma500/mdfld_output.h              |    76 -
 drivers/gpu/drm/gma500/mdfld_tmd_vid.c             |   197 -
 drivers/gpu/drm/gma500/mdfld_tpo_vid.c             |    83 -
 drivers/gpu/drm/gma500/mid_bios.c                  |     9 +-
 drivers/gpu/drm/gma500/mmu.c                       |    36 +-
 drivers/gpu/drm/gma500/oaktrail_crtc.c             |     6 +-
 drivers/gpu/drm/gma500/oaktrail_device.c           |     5 +-
 drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c         |    22 +-
 drivers/gpu/drm/gma500/oaktrail_lvds.c             |     5 +-
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c         |    10 +-
 drivers/gpu/drm/gma500/opregion.c                  |     3 +-
 drivers/gpu/drm/gma500/power.c                     |    21 +-
 drivers/gpu/drm/gma500/psb_drv.c                   |    34 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |    72 +-
 drivers/gpu/drm/gma500/psb_intel_display.c         |     2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |     7 +-
 drivers/gpu/drm/gma500/psb_intel_modes.c           |     3 +-
 drivers/gpu/drm/gma500/psb_intel_reg.h             |    12 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c            |     8 +-
 drivers/gpu/drm/gma500/psb_irq.c                   |    75 +-
 drivers/gpu/drm/gma500/psb_irq.h                   |     2 -
 drivers/gpu/drm/gma500/psb_reg.h                   |    14 -
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c         |   805 --
 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.h         |    38 -
 drivers/gpu/drm/hisilicon/hibmc/Makefile           |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c     |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |   104 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h    |    10 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c    |     2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c   |    20 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c        |    61 -
 drivers/gpu/drm/i915/Kconfig.debug                 |    24 +-
 drivers/gpu/drm/i915/Makefile                      |    26 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |   926 ++
 drivers/gpu/drm/i915/display/i9xx_plane.h          |    24 +
 drivers/gpu/drm/i915/display/icl_dsi.c             |     3 +
 drivers/gpu/drm/i915/display/intel_atomic_plane.c  |     5 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |    21 +-
 drivers/gpu/drm/i915/display/intel_bw.c            |    80 +-
 drivers/gpu/drm/i915/display/intel_cdclk.c         |     7 +-
 drivers/gpu/drm/i915/display/intel_color.c         |    16 +
 drivers/gpu/drm/i915/display/intel_combo_phy.c     |    20 +-
 drivers/gpu/drm/i915/display/intel_connector.c     |    29 +-
 drivers/gpu/drm/i915/display/intel_connector.h     |     3 +-
 drivers/gpu/drm/i915/display/intel_crtc.c          |   325 +
 drivers/gpu/drm/i915/display/intel_crtc.h          |    22 +
 drivers/gpu/drm/i915/display/intel_cursor.c        |   806 ++
 drivers/gpu/drm/i915/display/intel_cursor.h        |    17 +
 drivers/gpu/drm/i915/display/intel_ddi.c           |   247 +-
 drivers/gpu/drm/i915/display/intel_ddi.h           |     6 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 12881 +++++++--------=
----
 drivers/gpu/drm/i915/display/intel_display.h       |    27 +-
 .../gpu/drm/i915/display/intel_display_debugfs.c   |   133 +-
 .../gpu/drm/i915/display/intel_display_debugfs.h   |     3 +
 drivers/gpu/drm/i915/display/intel_display_power.c |   133 +-
 drivers/gpu/drm/i915/display/intel_display_power.h |    37 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   202 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  3126 ++---
 drivers/gpu/drm/i915/display/intel_dp.h            |    14 +-
 drivers/gpu/drm/i915/display/intel_dp_aux.c        |   692 +
 drivers/gpu/drm/i915/display/intel_dp_aux.h        |    18 +
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |   404 +-
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       |   178 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |    74 +-
 .../gpu/drm/i915/display/intel_dp_link_training.h  |     3 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |    16 +-
 drivers/gpu/drm/i915/display/intel_dpll.c          |  1363 ++
 drivers/gpu/drm/i915/display/intel_dpll.h          |    23 +
 .../gpu/drm/i915/display/intel_dsi_dcs_backlight.c |    23 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |     4 -
 drivers/gpu/drm/i915/display/intel_fbc.c           |    21 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c         |     4 +-
 drivers/gpu/drm/i915/display/intel_fdi.c           |   683 +
 drivers/gpu/drm/i915/display/intel_fdi.h           |    22 +
 drivers/gpu/drm/i915/display/intel_frontbuffer.c   |     4 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |   300 +-
 drivers/gpu/drm/i915/display/intel_hdcp.h          |     8 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |   284 +-
 drivers/gpu/drm/i915/display/intel_hdmi.h          |     7 +
 drivers/gpu/drm/i915/display/intel_lspcon.c        |   162 +-
 drivers/gpu/drm/i915/display/intel_lspcon.h        |    12 +
 drivers/gpu/drm/i915/display/intel_overlay.c       |     5 +-
 drivers/gpu/drm/i915/display/intel_panel.c         |   552 +-
 drivers/gpu/drm/i915/display/intel_panel.h         |     4 +
 drivers/gpu/drm/i915/display/intel_pps.c           |  1406 ++
 drivers/gpu/drm/i915/display/intel_pps.h           |    52 +
 drivers/gpu/drm/i915/display/intel_psr.c           |   143 +-
 drivers/gpu/drm/i915/display/intel_sprite.c        |   213 +-
 drivers/gpu/drm/i915/display/intel_sprite.h        |    10 +
 drivers/gpu/drm/i915/display/intel_tc.c            |     2 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |     2 +
 drivers/gpu/drm/i915/display/intel_vdsc.c          |     4 +-
 drivers/gpu/drm/i915/display/intel_vrr.c           |   209 +
 drivers/gpu/drm/i915/display/intel_vrr.h           |    33 +
 drivers/gpu/drm/i915/dma_resv_utils.c              |    17 +
 drivers/gpu/drm/i915/dma_resv_utils.h              |    13 +
 drivers/gpu/drm/i915/gem/i915_gem_context.c        |   132 +-
 drivers/gpu/drm/i915/gem/i915_gem_context.h        |     1 -
 drivers/gpu/drm/i915/gem/i915_gem_context_types.h  |     1 -
 drivers/gpu/drm/i915/gem/i915_gem_create.c         |   113 +
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |   104 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |    24 +-
 drivers/gpu/drm/i915/gem/i915_gem_lmem.c           |    15 +-
 drivers/gpu/drm/i915/gem/i915_gem_lmem.h           |     8 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c         |   112 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |    44 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_blt.c     |     9 +-
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |    19 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c          |    51 +-
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           |     4 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.c             |    76 +-
 drivers/gpu/drm/i915/gem/i915_gem_pm.h             |     3 +
 drivers/gpu/drm/i915/gem/i915_gem_region.c         |    52 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c          |    28 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |     3 +
 drivers/gpu/drm/i915/gem/i915_gem_stolen.c         |    79 +-
 drivers/gpu/drm/i915/gem/i915_gem_stolen.h         |     2 +
 drivers/gpu/drm/i915/gem/i915_gem_tiling.c         |    12 +-
 drivers/gpu/drm/i915/gem/i915_gem_wait.c           |    54 +-
 .../gpu/drm/i915/gem/selftests/huge_gem_object.c   |     2 +-
 drivers/gpu/drm/i915/gem/selftests/huge_pages.c    |    22 +
 .../drm/i915/gem/selftests/i915_gem_client_blt.c   |     4 +-
 .../drm/i915/gem/selftests/i915_gem_coherency.c    |     1 +
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |     1 +
 drivers/gpu/drm/i915/gem/selftests/igt_gem_utils.c |     1 +
 drivers/gpu/drm/i915/gt/debugfs_gt_pm.c            |    27 +-
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c               |    15 +-
 drivers/gpu/drm/i915/gt/gen7_renderclear.c         |    26 +-
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c           |   635 +
 drivers/gpu/drm/i915/gt/gen8_engine_cs.h           |   127 +
 drivers/gpu/drm/i915/gt/gen8_ppgtt.c               |    13 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |   106 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.h        |    17 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h  |     7 +-
 drivers/gpu/drm/i915/gt/intel_context.h            |    11 +-
 drivers/gpu/drm/i915/gt/intel_context_sseu.c       |     1 -
 drivers/gpu/drm/i915/gt/intel_context_types.h      |    25 +-
 drivers/gpu/drm/i915/gt/intel_engine.h             |    93 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   167 +-
 drivers/gpu/drm/i915/gt/intel_engine_heartbeat.c   |    59 +-
 drivers/gpu/drm/i915/gt/intel_engine_pm.c          |    22 +-
 drivers/gpu/drm/i915/gt/intel_engine_stats.h       |    60 +
 drivers/gpu/drm/i915/gt/intel_engine_types.h       |    22 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |  3896 ++++++
 .../gpu/drm/i915/gt/intel_execlists_submission.h   |    47 +
 drivers/gpu/drm/i915/gt/intel_ggtt.c               |    18 +-
 drivers/gpu/drm/i915/gt/intel_ggtt_fencing.c       |    22 +-
 drivers/gpu/drm/i915/gt/intel_gt.c                 |     4 +-
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.c     |    12 +-
 drivers/gpu/drm/i915/gt/intel_gt_buffer_pool.h     |     3 +-
 .../gpu/drm/i915/gt/intel_gt_buffer_pool_types.h   |     4 +-
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.c     |   197 +-
 drivers/gpu/drm/i915/gt/intel_gt_clock_utils.h     |     8 +-
 drivers/gpu/drm/i915/gt/intel_gt_irq.c             |     1 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.c              |    49 +
 drivers/gpu/drm/i915/gt/intel_gt_pm.h              |     2 +
 drivers/gpu/drm/i915/gt/intel_gt_requests.c        |     7 +-
 drivers/gpu/drm/i915/gt/intel_gt_types.h           |    25 +
 drivers/gpu/drm/i915/gt/intel_gtt.c                |    29 +
 drivers/gpu/drm/i915/gt/intel_gtt.h                |     3 +
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  6881 ++--------
 drivers/gpu/drm/i915/gt/intel_lrc.h                |   167 +-
 drivers/gpu/drm/i915/gt/intel_lrc_reg.h            |    41 +
 drivers/gpu/drm/i915/gt/intel_mocs.c               |     4 +-
 drivers/gpu/drm/i915/gt/intel_ppgtt.c              |     2 +-
 drivers/gpu/drm/i915/gt/intel_rc6.c                |     2 +-
 drivers/gpu/drm/i915/{ =3D> gt}/intel_region_lmem.c  |     4 +-
 drivers/gpu/drm/i915/{ =3D> gt}/intel_region_lmem.h  |     2 -
 drivers/gpu/drm/i915/gt/intel_renderstate.c        |     3 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   101 +-
 drivers/gpu/drm/i915/gt/intel_reset.h              |     2 +
 drivers/gpu/drm/i915/gt/intel_ring.c               |     4 +-
 drivers/gpu/drm/i915/gt/intel_ring_submission.c    |   272 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |    61 +-
 drivers/gpu/drm/i915/gt/intel_rps_types.h          |     2 +-
 drivers/gpu/drm/i915/gt/intel_timeline.c           |   103 +-
 drivers/gpu/drm/i915/gt/intel_timeline.h           |    25 +-
 drivers/gpu/drm/i915/gt/intel_timeline_types.h     |     2 +
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |   654 +-
 drivers/gpu/drm/i915/gt/mock_engine.c              |    15 +-
 drivers/gpu/drm/i915/gt/selftest_context.c         |     2 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c       |     1 +
 .../gpu/drm/i915/gt/selftest_engine_heartbeat.c    |    13 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |   203 +
 drivers/gpu/drm/i915/gt/selftest_execlists.c       |  4741 +++++++
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c           |     8 +-
 drivers/gpu/drm/i915/gt/selftest_hangcheck.c       |   173 +-
 drivers/gpu/drm/i915/gt/selftest_lrc.c             |  4771 +------
 drivers/gpu/drm/i915/gt/selftest_mocs.c            |    80 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c             |     1 +
 drivers/gpu/drm/i915/gt/selftest_reset.c           |    28 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c             |     5 +-
 drivers/gpu/drm/i915/gt/selftest_timeline.c        |    14 +-
 drivers/gpu/drm/i915/gt/selftest_workarounds.c     |   196 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c              |     2 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.c             |    16 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |     7 -
 drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c         |     1 +
 drivers/gpu/drm/i915/gt/uc/intel_guc_fw.c          |    13 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.c  |   457 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc_submission.h  |     1 +
 drivers/gpu/drm/i915/gt/uc/intel_uc.c              |    54 +-
 drivers/gpu/drm/i915/gt/uc/intel_uc_fw.c           |     7 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   337 +-
 drivers/gpu/drm/i915/gvt/cmd_parser.h              |     5 +
 drivers/gpu/drm/i915/gvt/execlist.h                |     3 -
 drivers/gpu/drm/i915/gvt/fb_decoder.h              |     6 +-
 drivers/gpu/drm/i915/gvt/gtt.h                     |    11 +-
 drivers/gpu/drm/i915/gvt/gvt.h                     |    41 +-
 drivers/gpu/drm/i915/gvt/handlers.c                |    22 +-
 drivers/gpu/drm/i915/gvt/interrupt.h               |     5 +-
 drivers/gpu/drm/i915/gvt/mmio.h                    |     3 +
 drivers/gpu/drm/i915/gvt/mmio_context.c            |     1 +
 drivers/gpu/drm/i915/gvt/mmio_context.h            |    12 +
 drivers/gpu/drm/i915/gvt/mpt.h                     |     2 +
 drivers/gpu/drm/i915/gvt/reg.h                     |     2 +
 drivers/gpu/drm/i915/gvt/scheduler.c               |    24 +-
 drivers/gpu/drm/i915/gvt/scheduler.h               |     5 +
 drivers/gpu/drm/i915/gvt/vgpu.c                    |     4 +-
 drivers/gpu/drm/i915/i915_active.c                 |     7 +-
 drivers/gpu/drm/i915/i915_cmd_parser.c             |     3 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |   763 +-
 drivers/gpu/drm/i915/i915_drv.c                    |    17 +-
 drivers/gpu/drm/i915/i915_drv.h                    |   120 +-
 drivers/gpu/drm/i915/i915_gem.c                    |   163 +-
 drivers/gpu/drm/i915/i915_gem.h                    |     9 +-
 drivers/gpu/drm/i915/i915_gem_evict.c              |    13 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |    25 +-
 drivers/gpu/drm/i915/i915_getparam.c               |     2 +-
 drivers/gpu/drm/i915/i915_gpu_error.c              |     6 +-
 drivers/gpu/drm/i915/i915_irq.c                    |   475 +-
 drivers/gpu/drm/i915/i915_irq.h                    |     3 -
 drivers/gpu/drm/i915/i915_mm.c                     |     2 +-
 drivers/gpu/drm/i915/i915_params.c                 |     2 +-
 drivers/gpu/drm/i915/i915_params.h                 |     1 +
 drivers/gpu/drm/i915/i915_pci.c                    |     7 +-
 drivers/gpu/drm/i915/i915_perf.c                   |    17 +-
 drivers/gpu/drm/i915/i915_pmu.c                    |    95 +-
 drivers/gpu/drm/i915/i915_pmu.h                    |    35 +-
 drivers/gpu/drm/i915/i915_reg.h                    |    81 +-
 drivers/gpu/drm/i915/i915_request.c                |   178 +-
 drivers/gpu/drm/i915/i915_request.h                |    10 +-
 drivers/gpu/drm/i915/i915_scheduler.c              |    32 +-
 drivers/gpu/drm/i915/i915_scheduler.h              |     7 +
 drivers/gpu/drm/i915/i915_scheduler_types.h        |    10 +
 drivers/gpu/drm/i915/i915_suspend.c                |    33 +-
 drivers/gpu/drm/i915/i915_sw_fence.c               |    25 +-
 drivers/gpu/drm/i915/i915_utils.c                  |     2 +-
 drivers/gpu/drm/i915/i915_utils.h                  |     7 +-
 drivers/gpu/drm/i915/i915_vma.h                    |    15 +
 drivers/gpu/drm/i915/i915_vma_types.h              |     3 +
 drivers/gpu/drm/i915/intel_device_info.c           |   159 +-
 drivers/gpu/drm/i915/intel_device_info.h           |     4 -
 drivers/gpu/drm/i915/intel_dram.c                  |   136 +-
 drivers/gpu/drm/i915/intel_memory_region.c         |     2 +-
 drivers/gpu/drm/i915/intel_memory_region.h         |    13 +-
 drivers/gpu/drm/i915/intel_pch.c                   |    39 +-
 drivers/gpu/drm/i915/intel_pm.c                    |  1108 +-
 drivers/gpu/drm/i915/intel_pm.h                    |     7 +-
 drivers/gpu/drm/i915/intel_sideband.c              |     4 +-
 drivers/gpu/drm/i915/intel_uncore.c                |     4 +-
 drivers/gpu/drm/i915/intel_uncore.h                |     6 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |     1 +
 drivers/gpu/drm/i915/selftests/i915_gem_evict.c    |    28 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c      |     1 +
 drivers/gpu/drm/i915/selftests/i915_perf.c         |     2 +-
 drivers/gpu/drm/i915/selftests/i915_request.c      |     9 +-
 drivers/gpu/drm/i915/selftests/igt_spinner.c       |     4 +
 .../gpu/drm/i915/selftests/intel_memory_region.c   |   110 +-
 drivers/gpu/drm/i915/selftests/mock_gem_device.c   |     2 -
 drivers/gpu/drm/i915/selftests/mock_region.c       |    19 +-
 drivers/gpu/drm/imx/Kconfig                        |     3 +-
 drivers/gpu/drm/imx/dw_hdmi-imx.c                  |    95 +-
 drivers/gpu/drm/imx/imx-ldb.c                      |   109 +-
 drivers/gpu/drm/imx/imx-tve.c                      |   109 +-
 drivers/gpu/drm/imx/ipuv3-crtc.c                   |   131 +-
 drivers/gpu/drm/imx/ipuv3-plane.c                  |    69 +-
 drivers/gpu/drm/imx/ipuv3-plane.h                  |     3 -
 drivers/gpu/drm/imx/parallel-display.c             |    93 +-
 drivers/gpu/drm/ingenic/Kconfig                    |     1 +
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |    60 +-
 drivers/gpu/drm/ingenic/ingenic-drm.h              |    14 +
 drivers/gpu/drm/kmb/kmb_drv.c                      |     4 +-
 drivers/gpu/drm/kmb/kmb_plane.c                    |     3 +
 drivers/gpu/drm/lima/lima_sched.c                  |     2 +-
 drivers/gpu/drm/mediatek/Makefile                  |     5 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c          |   223 +
 drivers/gpu/drm/mediatek/mtk_disp_color.c          |    89 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h            |    92 +
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c          |   197 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |   254 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |   194 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |    57 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   108 +-
 drivers/gpu/drm/mediatek/mtk_drm_crtc.h            |     1 -
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |    28 -
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |   503 +-
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |   100 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |    88 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h             |     5 +-
 drivers/gpu/drm/mediatek/mtk_drm_gem.c             |     2 +-
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |    50 +-
 drivers/gpu/drm/mga/mga_ioc32.c                    |    14 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c              |    20 +-
 drivers/gpu/drm/mgag200/mgag200_i2c.c              |     2 +-
 drivers/gpu/drm/mgag200/mgag200_mm.c               |    10 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |     6 +-
 drivers/gpu/drm/msm/msm_gem.c                      |     2 +-
 drivers/gpu/drm/nouveau/dispnv04/arb.c             |    12 +-
 drivers/gpu/drm/nouveau/dispnv04/dfp.c             |     5 +-
 drivers/gpu/drm/nouveau/dispnv04/disp.h            |    14 +-
 drivers/gpu/drm/nouveau/dispnv04/hw.c              |    10 +-
 drivers/gpu/drm/nouveau/dispnv50/core507d.c        |     2 +-
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c        |     2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   230 +-
 drivers/gpu/drm/nouveau/dispnv50/head.c            |     2 -
 drivers/gpu/drm/nouveau/dispnv50/head907d.c        |    11 +-
 drivers/gpu/drm/nouveau/include/nvif/cl0080.h      |    52 +-
 drivers/gpu/drm/nouveau/include/nvif/fifo.h        |     6 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h |   191 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/engine.h |    13 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/enum.h   |     1 +
 drivers/gpu/drm/nouveau/include/nvkm/core/falcon.h |    10 +-
 drivers/gpu/drm/nouveau/include/nvkm/core/layout.h |    53 +
 drivers/gpu/drm/nouveau/include/nvkm/core/subdev.h |    31 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/bsp.h  |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/ce.h   |    18 +-
 .../gpu/drm/nouveau/include/nvkm/engine/cipher.h   |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h |    41 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/dma.h  |    10 +-
 .../gpu/drm/nouveau/include/nvkm/engine/falcon.h   |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h |    42 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/gr.h   |    80 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/mpeg.h |    10 +-
 .../gpu/drm/nouveau/include/nvkm/engine/mspdec.h   |     8 +-
 .../gpu/drm/nouveau/include/nvkm/engine/msppp.h    |     6 +-
 .../gpu/drm/nouveau/include/nvkm/engine/msvld.h    |    10 +-
 .../gpu/drm/nouveau/include/nvkm/engine/nvdec.h    |     2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/nvenc.h    |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/pm.h   |    23 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/sec.h  |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/sec2.h |     6 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/sw.h   |     8 +-
 drivers/gpu/drm/nouveau/include/nvkm/engine/vp.h   |     2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/xtensa.h   |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/acr.h  |    12 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bar.h  |    14 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bios.h |     2 +-
 .../drm/nouveau/include/nvkm/subdev/bios/conn.h    |     1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/bus.h  |    10 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/clk.h  |    20 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/devinit.h  |    35 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/fault.h    |     8 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |    75 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fuse.h |     6 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gpio.h |    12 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h  |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/i2c.h  |    18 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/ibus.h |    12 -
 .../gpu/drm/nouveau/include/nvkm/subdev/iccsense.h |     2 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/instmem.h  |    13 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/ltc.h  |    16 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mc.h   |    40 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mmu.h  |    32 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mxm.h  |     2 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h  |    22 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pmu.h  |    25 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/privring.h |    12 +
 .../gpu/drm/nouveau/include/nvkm/subdev/therm.h    |    18 +-
 .../gpu/drm/nouveau/include/nvkm/subdev/timer.h    |     8 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/top.h  |    27 +-
 drivers/gpu/drm/nouveau/include/nvkm/subdev/volt.h |    12 +-
 drivers/gpu/drm/nouveau/nouveau_abi16.c            |    21 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |     2 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |     9 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c               |    20 +-
 drivers/gpu/drm/nouveau/nouveau_chan.c             |     3 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |    11 +-
 drivers/gpu/drm/nouveau/nouveau_display.c          |     8 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |     7 +-
 drivers/gpu/drm/nouveau/nouveau_drv.h              |     2 +-
 drivers/gpu/drm/nouveau/nouveau_encoder.h          |    13 +-
 drivers/gpu/drm/nouveau/nouveau_fbcon.c            |     6 +-
 drivers/gpu/drm/nouveau/nouveau_prime.c            |     4 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c            |     2 +-
 drivers/gpu/drm/nouveau/nouveau_vga.c              |    20 +-
 drivers/gpu/drm/nouveau/nv17_fence.c               |     2 +-
 drivers/gpu/drm/nouveau/nv50_fence.c               |     2 +-
 drivers/gpu/drm/nouveau/nvif/fifo.c                |    30 +-
 drivers/gpu/drm/nouveau/nvkm/core/engine.c         |    51 +-
 drivers/gpu/drm/nouveau/nvkm/core/memory.c         |    18 +-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |   110 +-
 drivers/gpu/drm/nouveau/nvkm/engine/bsp/g84.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gf100.c     |    17 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gk104.c     |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gm107.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gm200.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gp100.c     |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gp102.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gt215.c     |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/gv100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/ce/tu102.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/cipher/g84.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  4599 ++++---
 drivers/gpu/drm/nouveau/nvkm/engine/device/priv.h  |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  |    40 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c    |    27 +-
 .../gpu/drm/nouveau/nvkm/engine/disp/channv50.c    |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g84.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/g94.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gf119.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gk104.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gk110.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gm107.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gm200.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gp100.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gp102.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt200.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gt215.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp77.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/mcp89.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv04.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c    |     9 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/priv.h    |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/base.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/gf100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/gf119.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/gv100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/nv04.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/nv50.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/dma/priv.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/falcon.c       |    11 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/base.c    |    10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c    |    38 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.h    |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/chang84.c |    63 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/changf100.h   |    11 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/changk104.h   |     6 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/channv04.h    |     6 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/channv50.c    |    28 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/channv50.h    |    22 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/dmanv04.c |    16 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/dmanv10.c |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/dmanv17.c |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/dmanv40.c |    32 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/g84.c     |    75 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c   |    99 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   |   207 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.h   |    35 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk110.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk208.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk20a.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm107.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm200.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gm20b.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gp100.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gp10b.c   |     5 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/gpfifogf100.c |    53 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/gpfifogk104.c |    60 +-
 .../gpu/drm/nouveau/nvkm/engine/fifo/gpfifogv100.c |    27 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gv100.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.c    |    44 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv04.h    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv10.c    |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv17.c    |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv40.c    |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv50.c    |    15 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/nv50.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/priv.h    |    11 +-
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/tu102.c   |   365 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/base.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/g84.c       |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c     |    10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf104.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf108.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf110.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf117.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf119.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk104.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk110b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk208.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gk20a.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm107.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm200.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gm20b.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp102.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp104.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp107.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp108.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gp10b.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gt200.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gt215.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gv100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/mcp79.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/mcp89.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv04.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv10.c      |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv10.h      |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv15.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv17.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv20.c      |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv20.h      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv25.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv2a.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv30.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv34.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv35.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv40.c      |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv40.h      |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv44.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv50.c      |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/nv50.h      |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/priv.h      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/gr/tu102.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/g84.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv31.c    |    10 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv31.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv40.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv44.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mpeg/nv50.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/base.c  |     7 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/g98.c   |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/gf100.c |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/gk104.c |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/gt215.c |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/mspdec/priv.h  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/base.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/g98.c    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/gf100.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/gt215.c  |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msppp/priv.h   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/base.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/g98.c    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/gf100.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/gk104.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/gt215.c  |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/mcp89.c  |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/msvld/priv.h   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/base.c   |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/gm107.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvdec/priv.h   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/base.c   |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/gm107.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/nvenc/priv.h   |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c      |    23 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/g84.c       |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gf100.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gf100.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gf108.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gf117.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gk104.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gt200.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/gt215.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/nv40.c      |     8 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/nv40.h      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/nv50.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/pm/priv.h      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec/g98.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/base.c    |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp102.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/gp108.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/priv.h    |     2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sec2/tu102.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/base.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv04.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv10.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/priv.h      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/engine/vp/g84.c       |     6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/xtensa.c       |     9 +-
 drivers/gpu/drm/nouveau/nvkm/falcon/base.c         |    14 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/Kbuild         |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/base.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm200.c    |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gm20b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp102.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp108.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/gp10b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/priv.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/acr/tu102.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/base.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/g84.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c    |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.h    |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gk20a.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gm107.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gm20b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.c     |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/nv50.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/priv.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/tu102.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/base.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/base.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/g94.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/gf100.c    |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv04.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv31.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/nv50.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bus/priv.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/g84.c      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gf100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk104.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.c    |    16 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gk20a.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c    |    17 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/gt215.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/mcp77.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv04.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv40.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.c     |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/nv50.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/clk/priv.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/base.c |    11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g84.c  |    18 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/g98.c  |    16 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/ga100.c    |     5 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c    |    20 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm107.c    |    12 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |     6 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gt215.c    |    16 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gv100.c    |     6 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/mcp89.c    |    18 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv04.c |    11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv04.h |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv05.c |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv10.c |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv1a.c |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv20.c |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.c |    17 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/nv50.h |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h |     3 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/tu102.c    |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/base.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gp100.c  |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gp10b.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/gv100.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/priv.h   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fault/tu102.c  |    25 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/base.c      |    18 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/g84.c       |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga102.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf100.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gf108.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk104.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk110.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gk20a.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm107.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm200.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gm20b.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp102.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gp10b.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gt215.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/mcp77.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/mcp89.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv04.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv10.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv1a.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv20.c      |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv25.c      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv30.c      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv35.c      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv36.c      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv40.c      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv41.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv44.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv46.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv47.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv49.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv4e.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv50.c      |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/nv50.h      |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.c       |    12 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c  |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/base.c    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/gf100.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/gm107.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/nv50.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fuse/priv.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/base.c    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/g94.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/ga102.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/gf119.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/gk104.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/nv10.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/nv50.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/priv.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/gv100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/priv.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/base.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/g94.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gf117.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gf119.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gk104.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gk110.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/gm200.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nv04.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nv4e.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/nv50.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/i2c/priv.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/Kbuild    |     7 -
 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/priv.h    |     9 -
 .../gpu/drm/nouveau/nvkm/subdev/iccsense/base.c    |     8 +-
 .../gpu/drm/nouveau/nvkm/subdev/iccsense/gf100.c   |     4 +-
 .../gpu/drm/nouveau/nvkm/subdev/iccsense/priv.h    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/base.c |    14 +-
 .../gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c    |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv04.c |    15 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv40.c |    15 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |    34 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/base.c     |    10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gf100.c    |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gk104.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gm107.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gm200.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp102.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/gp10b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/ltc/priv.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/base.c      |    67 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/g84.c       |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/g98.c       |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gf100.c     |    16 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gk104.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gk20a.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gp100.c     |    10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gp10b.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/gt215.c     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/nv04.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/nv11.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/nv17.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/nv44.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/nv50.c      |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/priv.h      |    14 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/tu102.c     |   115 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/base.c     |    10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/g84.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gf100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gk104.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gk20a.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gm200.c    |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gm20b.c    |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gp100.c    |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gp10b.c    |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/gv100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/mcp77.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/nv04.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/nv41.c     |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/nv44.c     |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/nv50.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/priv.h     |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/tu102.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmgf100.c |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv41.c  |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmnv50.c  |     9 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c |     7 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/base.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/nv50.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mxm/priv.h     |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/g84.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/g92.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c      |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gf100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gf106.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/nv04.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/nv40.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/nv46.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/nv4c.c     |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h     |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/base.c     |    16 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gf100.c    |    11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gf119.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk104.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk110.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk208.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gk20a.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm107.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm200.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gm20b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp102.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gp10b.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/gt215.c    |    11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/pmu/priv.h     |     8 +-
 .../gpu/drm/nouveau/nvkm/subdev/privring/Kbuild    |     7 +
 .../nouveau/nvkm/subdev/{ibus =3D> privring}/gf100.c |    44 +-
 .../nouveau/nvkm/subdev/{ibus =3D> privring}/gf117.c |    16 +-
 .../nouveau/nvkm/subdev/{ibus =3D> privring}/gk104.c |    46 +-
 .../nouveau/nvkm/subdev/{ibus =3D> privring}/gk20a.c |    30 +-
 .../nouveau/nvkm/subdev/{ibus =3D> privring}/gm200.c |    10 +-
 .../nouveau/nvkm/subdev/{ibus =3D> privring}/gp10b.c |    18 +-
 .../gpu/drm/nouveau/nvkm/subdev/privring/priv.h    |     8 +
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/base.c   |    10 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/g84.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gf119.c  |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.c  |    43 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gk104.h  |     3 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gm107.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gm200.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gp100.c  |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/gt215.c  |     6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv40.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/nv50.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/therm/priv.h   |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/base.c   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/gk20a.c  |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/nv04.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/nv40.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/nv41.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/timer/priv.h   |     4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/Kbuild     |     1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/top/base.c     |    70 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/ga100.c    |   107 +
 drivers/gpu/drm/nouveau/nvkm/subdev/top/gk104.c    |    46 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/top/priv.h     |    15 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/base.c    |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf100.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gf117.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk104.c   |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.c   |     8 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gk20a.h   |     2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/gm20b.c   |    11 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/nv40.c    |     5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/volt/priv.h    |     8 +-
 drivers/gpu/drm/omapdrm/Kconfig                    |   120 +-
 drivers/gpu/drm/omapdrm/Makefile                   |    19 +-
 drivers/gpu/drm/omapdrm/displays/Kconfig           |    10 -
 drivers/gpu/drm/omapdrm/displays/Makefile          |     2 -
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c    |  1385 --
 drivers/gpu/drm/omapdrm/dss/Kconfig                |   135 -
 drivers/gpu/drm/omapdrm/dss/Makefile               |    20 -
 drivers/gpu/drm/omapdrm/dss/base.c                 |    87 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c                |   202 +-
 drivers/gpu/drm/omapdrm/dss/display.c              |    60 -
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |     1 -
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |  1949 ++-
 drivers/gpu/drm/omapdrm/dss/dsi.h                  |   456 +
 drivers/gpu/drm/omapdrm/dss/dss.c                  |    28 +-
 drivers/gpu/drm/omapdrm/dss/dss.h                  |    72 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                |     1 -
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                |     1 -
 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c    |   229 -
 drivers/gpu/drm/omapdrm/dss/omapdss.h              |   347 +-
 drivers/gpu/drm/omapdrm/dss/output.c               |    57 +-
 drivers/gpu/drm/omapdrm/dss/pll.c                  |     6 +
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |     1 -
 drivers/gpu/drm/omapdrm/dss/venc.c                 |     2 -
 drivers/gpu/drm/omapdrm/omap_connector.c           |   157 -
 drivers/gpu/drm/omapdrm/omap_connector.h           |    28 -
 drivers/gpu/drm/omapdrm/omap_crtc.c                |   153 +-
 drivers/gpu/drm/omapdrm/omap_crtc.h                |     2 -
 drivers/gpu/drm/omapdrm/omap_drv.c                 |    73 +-
 drivers/gpu/drm/omapdrm/omap_drv.h                 |     3 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c             |    59 +-
 drivers/gpu/drm/omapdrm/omap_gem.c                 |     3 +-
 drivers/gpu/drm/omapdrm/omap_irq.c                 |    34 +-
 drivers/gpu/drm/omapdrm/omap_plane.c               |    41 +-
 drivers/gpu/drm/omapdrm/tcm-sita.c                 |     1 -
 drivers/gpu/drm/panel/Kconfig                      |    20 +
 drivers/gpu/drm/panel/Makefile                     |     2 +
 drivers/gpu/drm/panel/panel-dsi-cm.c               |   665 +
 drivers/gpu/drm/panel/panel-khadas-ts050.c         |   870 ++
 drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c   |    39 +-
 drivers/gpu/drm/panel/panel-samsung-s6e63m0.c      |    59 +-
 drivers/gpu/drm/panel/panel-simple.c               |   223 +-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c      |    24 +-
 drivers/gpu/drm/panfrost/panfrost_devfreq.c        |     1 +
 drivers/gpu/drm/pl111/pl111_drv.c                  |     2 +-
 drivers/gpu/drm/qxl/qxl_dev.h                      |    16 +-
 drivers/gpu/drm/qxl/qxl_drv.c                      |     2 +-
 drivers/gpu/drm/qxl/qxl_drv.h                      |     1 -
 drivers/gpu/drm/qxl/qxl_ioctl.c                    |     3 +-
 drivers/gpu/drm/qxl/qxl_irq.c                      |     3 +-
 drivers/gpu/drm/qxl/qxl_kms.c                      |     1 -
 drivers/gpu/drm/qxl/qxl_object.h                   |     2 +-
 drivers/gpu/drm/qxl/qxl_release.c                  |     2 +-
 drivers/gpu/drm/qxl/qxl_ttm.c                      |     1 -
 drivers/gpu/drm/r128/r128_ioc32.c                  |    14 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |     6 +-
 drivers/gpu/drm/radeon/r100.c                      |    27 +-
 drivers/gpu/drm/radeon/r600_cs.c                   |     4 +-
 drivers/gpu/drm/radeon/radeon.h                    |    36 +-
 drivers/gpu/drm/radeon/radeon_asic.c               |     3 +
 drivers/gpu/drm/radeon/radeon_atombios.c           |    89 +-
 drivers/gpu/drm/radeon/radeon_bios.c               |     6 +-
 drivers/gpu/drm/radeon/radeon_combios.c            |    55 +-
 drivers/gpu/drm/radeon/radeon_cs.c                 |     6 +-
 drivers/gpu/drm/radeon/radeon_device.c             |    17 +-
 drivers/gpu/drm/radeon/radeon_display.c            |     2 +-
 drivers/gpu/drm/radeon/radeon_drv.c                |     7 +-
 drivers/gpu/drm/radeon/radeon_fb.c                 |     2 +-
 drivers/gpu/drm/radeon/radeon_gem.c                |     6 +-
 drivers/gpu/drm/radeon/radeon_i2c.c                |     2 +-
 drivers/gpu/drm/radeon/radeon_irq_kms.c            |     2 +-
 drivers/gpu/drm/radeon/radeon_kms.c                |    24 +-
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |     6 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    13 +-
 drivers/gpu/drm/radeon/radeon_object.h             |     4 +-
 drivers/gpu/drm/radeon/radeon_prime.c              |     4 +-
 drivers/gpu/drm/radeon/radeon_trace.h              |     2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |    15 +-
 drivers/gpu/drm/radeon/radeon_uvd.c                |    38 +-
 drivers/gpu/drm/radeon/radeon_vce.c                |     1 -
 drivers/gpu/drm/radeon/rs690.c                     |     2 +-
 drivers/gpu/drm/radeon/rs780_dpm.c                 |     7 +-
 drivers/gpu/drm/radeon/vce_v1_0.c                  |     1 -
 drivers/gpu/drm/rcar-du/rcar_cmm.c                 |     2 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |    13 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |    33 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |    16 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |    98 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |     2 -
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |    42 +-
 drivers/gpu/drm/rcar-du/rcar_du_plane.c            |     8 +-
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c              |    28 +-
 drivers/gpu/drm/rcar-du/rcar_du_writeback.c        |     2 +-
 drivers/gpu/drm/rockchip/Kconfig                   |     2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c    |     2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |     2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |     1 -
 drivers/gpu/drm/scheduler/sched_main.c             |   123 +-
 drivers/gpu/drm/sti/sti_cursor.c                   |     9 +-
 drivers/gpu/drm/sti/sti_gdp.c                      |     9 +-
 drivers/gpu/drm/sti/sti_hqvdp.c                    |     9 +-
 drivers/gpu/drm/stm/ltdc.c                         |     1 -
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |    21 +-
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 |     1 +
 drivers/gpu/drm/sun4i/sun8i_csc.c                  |   109 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.h                |     6 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c             |     2 +
 drivers/gpu/drm/tdfx/tdfx_drv.c                    |     2 +-
 drivers/gpu/drm/tegra/dc.c                         |     2 +-
 drivers/gpu/drm/tegra/drm.c                        |     2 +
 drivers/gpu/drm/tegra/dsi.c                        |     2 +-
 drivers/gpu/drm/tegra/falcon.c                     |     9 +-
 drivers/gpu/drm/tegra/gr2d.c                       |     9 +-
 drivers/gpu/drm/tegra/hdmi.c                       |     2 +-
 drivers/gpu/drm/tegra/hub.c                        |     2 +-
 drivers/gpu/drm/tegra/sor.c                        |     2 +-
 drivers/gpu/drm/tegra/vic.c                        |    35 +-
 drivers/gpu/drm/tiny/cirrus.c                      |     1 -
 drivers/gpu/drm/ttm/ttm_agp_backend.c              |     1 -
 drivers/gpu/drm/ttm/ttm_bo.c                       |   105 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |    16 +-
 drivers/gpu/drm/ttm/ttm_bo_vm.c                    |     7 +-
 drivers/gpu/drm/ttm/ttm_execbuf_util.c             |     4 +-
 drivers/gpu/drm/ttm/ttm_memory.c                   |     3 +-
 drivers/gpu/drm/ttm/ttm_module.c                   |     3 +-
 {include =3D> drivers/gpu}/drm/ttm/ttm_module.h      |     0
 drivers/gpu/drm/ttm/ttm_range_manager.c            |     1 -
 drivers/gpu/drm/ttm/ttm_tt.c                       |    15 +-
 drivers/gpu/drm/tve200/tve200_display.c            |     1 -
 drivers/gpu/drm/tve200/tve200_drv.c                |     1 -
 drivers/gpu/drm/v3d/v3d_drv.c                      |     4 +-
 drivers/gpu/drm/v3d/v3d_irq.c                      |     7 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c               |    11 +-
 drivers/gpu/drm/vboxvideo/vbox_irq.c               |     4 +-
 drivers/gpu/drm/vboxvideo/vbox_main.c              |     8 +-
 drivers/gpu/drm/vboxvideo/vbox_ttm.c               |     7 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |   111 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                     |    38 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |    19 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |    30 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   111 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |     3 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   388 +-
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |    34 +-
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                 |     8 +-
 drivers/gpu/drm/vc4/vc4_hdmi_regs.h                |    13 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                      |    18 +-
 drivers/gpu/drm/vc4/vc4_kms.c                      |   248 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |     7 +-
 drivers/gpu/drm/vc4/vc4_txp.c                      |    11 +-
 drivers/gpu/drm/vgem/vgem_drv.c                    |     3 +-
 drivers/gpu/drm/via/via_irq.c                      |     2 +-
 drivers/gpu/drm/virtio/Kconfig                     |     3 +-
 drivers/gpu/drm/virtio/virtgpu_debugfs.c           |    24 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c               |     1 -
 drivers/gpu/drm/virtio/virtgpu_drv.h               |     1 +
 drivers/gpu/drm/virtio/virtgpu_fence.c             |    81 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c               |     8 +-
 drivers/gpu/drm/virtio/virtgpu_kms.c               |     1 +
 drivers/gpu/drm/virtio/virtgpu_vram.c              |     3 +
 drivers/gpu/drm/vkms/vkms_drv.c                    |    54 +-
 drivers/gpu/drm/vkms/vkms_drv.h                    |    12 +-
 drivers/gpu/drm/vkms/vkms_output.c                 |    13 +-
 drivers/gpu/drm/vmwgfx/Makefile                    |     6 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c                |     1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c            |    52 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_blit.c               |     4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |     6 +-
 .../gpu/drm/vmwgfx/{vmwgfx_fifo.c =3D> vmwgfx_cmd.c} |   126 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |    22 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_context.c            |    40 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c            |    14 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c                |   240 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h                |    94 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            |    26 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                 |    12 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c              |    28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmr.c                |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ioctl.c              |    15 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_irq.c                |    10 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |    76 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |     9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_marker.c             |   155 -
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c                |    16 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c            |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c         |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |     6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |    28 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |    27 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_so.c                 |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |    36 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c       |     8 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |    47 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_thp.c                |     1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_ttm_buffer.c         |    10 +-
 drivers/gpu/drm/xen/xen_drm_front_gem.c            |     4 +-
 drivers/gpu/drm/zte/zx_plane.c                     |     7 +-
 drivers/gpu/ipu-v3/ipu-di.c                        |     4 -
 drivers/misc/mei/hdcp/mei_hdcp.c                   |     3 +-
 drivers/pci/pci.c                                  |    12 +-
 drivers/pci/pci.h                                  |     1 -
 drivers/soc/mediatek/Makefile                      |     1 +
 .../mtk_drm_ddp.c =3D> soc/mediatek/mtk-mutex.c}     |   328 +-
 drivers/video/fbdev/Kconfig                        |     2 +-
 drivers/video/fbdev/aty/atyfb_base.c               |    11 +-
 drivers/video/fbdev/aty/mach64_ct.c                |    15 +-
 drivers/video/fbdev/aty/radeon_monitor.c           |     4 +-
 drivers/video/fbdev/bw2.c                          |     2 +-
 drivers/video/fbdev/cg3.c                          |     2 +-
 drivers/video/fbdev/cg6.c                          |     2 +-
 drivers/video/fbdev/cirrusfb.c                     |    20 +-
 drivers/video/fbdev/controlfb.c                    |     4 +-
 drivers/video/fbdev/core/fb_notify.c               |     7 +
 drivers/video/fbdev/core/fbcon.c                   |    25 +-
 drivers/video/fbdev/core/fbmon.c                   |     2 +-
 drivers/video/fbdev/efifb.c                        |     3 +-
 drivers/video/fbdev/ffb.c                          |     2 +-
 drivers/video/fbdev/gbefb.c                        |     4 +-
 drivers/video/fbdev/goldfishfb.c                   |     2 +
 drivers/video/fbdev/hgafb.c                        |    10 +-
 drivers/video/fbdev/leo.c                          |     2 +-
 drivers/video/fbdev/mmp/hw/mmp_spi.c               |     2 +-
 drivers/video/fbdev/mx3fb.c                        |    13 +-
 drivers/video/fbdev/neofb.c                        |     4 -
 drivers/video/fbdev/nvidia/nv_setup.c              |     7 +-
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |     1 +
 .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |     2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |    14 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |     4 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c  |     4 +-
 drivers/video/fbdev/p9100.c                        |     2 +-
 drivers/video/fbdev/pm2fb.c                        |     8 +-
 drivers/video/fbdev/riva/fbdev.c                   |     9 +-
 drivers/video/fbdev/riva/riva_hw.c                 |    28 +-
 drivers/video/fbdev/s1d13xxxfb.c                   |     3 +-
 drivers/video/fbdev/s3c-fb.c                       |    11 +-
 drivers/video/fbdev/sis/init.c                     |    33 +-
 drivers/video/fbdev/sis/oem310.h                   |     2 +
 drivers/video/fbdev/sis/sis.h                      |     1 -
 drivers/video/fbdev/sis/sis_main.c                 |     9 +-
 drivers/video/fbdev/sstfb.c                        |     2 +-
 drivers/video/fbdev/tcx.c                          |     2 +-
 drivers/video/fbdev/tdfxfb.c                       |     4 +-
 drivers/video/fbdev/tgafb.c                        |     7 +-
 drivers/video/fbdev/udlfb.c                        |     1 +
 drivers/video/fbdev/uvesafb.c                      |     6 +-
 drivers/video/fbdev/via/lcd.c                      |     4 +-
 drivers/video/fbdev/wmt_ge_rops.c                  |     1 +
 drivers/video/of_display_timing.c                  |     1 +
 drivers/video/of_videomode.c                       |     6 +-
 include/drm/drm_agpsupport.h                       |    18 -
 include/drm/drm_atomic.h                           |    20 +
 include/drm/drm_atomic_helper.h                    |     4 -
 include/drm/drm_connector.h                        |    49 +
 include/drm/drm_crtc.h                             |    33 +
 include/drm/drm_device.h                           |    23 +-
 include/drm/drm_dp_helper.h                        |   239 +-
 include/drm/drm_dp_mst_helper.h                    |     1 +
 include/drm/drm_drv.h                              |     2 -
 include/drm/drm_dsc.h                              |     1 +
 include/drm/drm_edid.h                             |    30 +
 include/drm/drm_encoder.h                          |    32 +-
 include/drm/drm_gem.h                              |     3 -
 include/drm/drm_gem_cma_helper.h                   |    14 +-
 include/drm/drm_hdcp.h                             |     8 +-
 include/drm/drm_irq.h                              |     2 +-
 include/drm/drm_legacy.h                           |    10 +-
 include/drm/drm_managed.h                          |     2 -
 include/drm/drm_mipi_dbi.h                         |     2 +-
 include/drm/drm_modes.h                            |    10 +
 include/drm/drm_modeset_helper_vtables.h           |    29 +-
 include/drm/drm_plane.h                            |    42 +
 include/drm/drm_prime.h                            |     7 +-
 include/drm/drm_property.h                         |     2 +-
 include/drm/drm_rect.h                             |    13 +
 include/drm/drm_simple_kms_helper.h                |    24 +
 include/drm/gpu_scheduler.h                        |    14 +-
 include/drm/ttm/ttm_bo_api.h                       |    13 +-
 include/drm/ttm/ttm_bo_driver.h                    |     6 +-
 include/drm/ttm/ttm_resource.h                     |     5 +-
 include/drm/ttm/ttm_tt.h                           |     2 -
 include/linux/dma-buf.h                            |    45 +-
 include/linux/pci.h                                |     9 +
 include/linux/soc/mediatek/mtk-mutex.h             |    26 +
 include/linux/vgaarb.h                             |     6 +-
 include/uapi/drm/drm.h                             |    97 +-
 include/uapi/drm/drm_fourcc.h                      |    23 +-
 include/uapi/drm/drm_mode.h                        |    13 +-
 include/uapi/drm/i915_drm.h                        |     3 +-
 include/video/sstfb.h                              |     4 +-
 1555 files changed, 56660 insertions(+), 49558 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/display/connector/dp-connector.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/ste,mcde.txt
 create mode 100644 Documentation/devicetree/bindings/display/ste,mcde.yaml
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/smuio_v11_0_6.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ta_secureDisplay_if.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vega20_ih.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vega20_ih.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_edid_parser.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/oss/osssys_4_2_0_sh_mask.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_11_0_6_offset.h
 create mode 100644
drivers/gpu/drm/amd/include/asic_reg/smuio/smuio_11_0_6_sh_mask.h
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_device.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_dsi_dpi.h
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_dsi_output.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_dsi_output.h
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_dsi_pkg_sender.h
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_intel_display.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_output.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_output.h
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_tmd_vid.c
 delete mode 100644 drivers/gpu/drm/gma500/mdfld_tpo_vid.c
 delete mode 100644 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.c
 delete mode 100644 drivers/gpu/drm/gma500/tc35876x-dsi-lvds.h
 delete mode 100644 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
 create mode 100644 drivers/gpu/drm/i915/display/i9xx_plane.c
 create mode 100644 drivers/gpu/drm/i915/display/i9xx_plane.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_crtc.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_crtc.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_cursor.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_cursor.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_dp_aux.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dp_aux.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_dpll.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dpll.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_fdi.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_fdi.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_pps.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_pps.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_vrr.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_vrr.h
 create mode 100644 drivers/gpu/drm/i915/dma_resv_utils.c
 create mode 100644 drivers/gpu/drm/i915/dma_resv_utils.h
 create mode 100644 drivers/gpu/drm/i915/gem/i915_gem_create.c
 create mode 100644 drivers/gpu/drm/i915/gt/gen8_engine_cs.c
 create mode 100644 drivers/gpu/drm/i915/gt/gen8_engine_cs.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_engine_stats.h
 create mode 100644 drivers/gpu/drm/i915/gt/intel_execlists_submission.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_execlists_submission.h
 rename drivers/gpu/drm/i915/{ =3D> gt}/intel_region_lmem.c (96%)
 rename drivers/gpu/drm/i915/{ =3D> gt}/intel_region_lmem.h (80%)
 create mode 100644 drivers/gpu/drm/i915/gt/selftest_execlists.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_drv.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_gamma.c
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_drm_ddp.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/core/layout.h
 delete mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/ibus.h
 create mode 100644 drivers/gpu/drm/nouveau/include/nvkm/subdev/privring.h
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/Kbuild
 delete mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/ibus/priv.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/privring/Kbuild
 rename drivers/gpu/drm/nouveau/nvkm/subdev/{ibus =3D> privring}/gf100.c (7=
1%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/{ibus =3D> privring}/gf117.c (7=
9%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/{ibus =3D> privring}/gk104.c (7=
1%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/{ibus =3D> privring}/gk20a.c (7=
3%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/{ibus =3D> privring}/gm200.c (8=
3%)
 rename drivers/gpu/drm/nouveau/nvkm/subdev/{ibus =3D> privring}/gp10b.c (7=
8%)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/privring/priv.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/top/ga100.c
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/Kconfig
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/Makefile
 delete mode 100644 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
 delete mode 100644 drivers/gpu/drm/omapdrm/dss/Kconfig
 delete mode 100644 drivers/gpu/drm/omapdrm/dss/Makefile
 delete mode 100644 drivers/gpu/drm/omapdrm/dss/display.c
 create mode 100644 drivers/gpu/drm/omapdrm/dss/dsi.h
 delete mode 100644 drivers/gpu/drm/omapdrm/dss/omapdss-boot-init.c
 delete mode 100644 drivers/gpu/drm/omapdrm/omap_connector.c
 delete mode 100644 drivers/gpu/drm/omapdrm/omap_connector.h
 create mode 100644 drivers/gpu/drm/panel/panel-dsi-cm.c
 create mode 100644 drivers/gpu/drm/panel/panel-khadas-ts050.c
 rename {include =3D> drivers/gpu}/drm/ttm/ttm_module.h (100%)
 rename drivers/gpu/drm/vmwgfx/{vmwgfx_fifo.c =3D> vmwgfx_cmd.c} (82%)
 delete mode 100644 drivers/gpu/drm/vmwgfx/vmwgfx_marker.c
 rename drivers/{gpu/drm/mediatek/mtk_drm_ddp.c =3D>
soc/mediatek/mtk-mutex.c} (53%)
 create mode 100644 include/linux/soc/mediatek/mtk-mutex.h
