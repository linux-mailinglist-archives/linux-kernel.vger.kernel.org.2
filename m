Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF31942633F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbhJHDou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbhJHDos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:44:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE0C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 20:42:53 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g8so30987202edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 20:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gzfRCng/ob32UAdS59rgRVkD8sP1P5E1PemtGQSpK3Q=;
        b=KhuPhs1dTdgJyiZffQ0ttkquY8w/UI7Q8m4krceYAF9q0HjPWJNWzEz1kLtFnm9H5i
         6FoZ7XqrQ2kIhW9u7/VYjDdlXd4/oehXIpLxgGYddQzKvFGjpc3cA4HBRWSZA8MGZwa4
         un8qrAF12KfZ7wlj1qzDwjMyp5WpNFPh7JPnmxBinN6cBc8lQ9OnnpOp7hTgOgOP9SdR
         01VN9JiWenM8ty4ai0TOt/46gC9Op81G0WBeGpYKIyWiuGgjvQSph+2qBmCs5MBIHeG/
         00Z154HrFkHXYnnqri/towwwcZlsJTzVIdXA0Y2ZY6sDyrVnKP5RXfuXILjgDED9AWEW
         ET5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gzfRCng/ob32UAdS59rgRVkD8sP1P5E1PemtGQSpK3Q=;
        b=MiXPspyswef3ydjyu3OgY0yNkn0qZhoXYKz4kJJ3BqGNi2bNIz6gluz1VCO8eQn7Eq
         P2M3zQdrVT/Docdz+p1MHldxGHit1VugzYQvttr0yBzex18Xj7vhRLv0rO5OkSJFTyKj
         eC4XYE1iyyEwu0z11WmnZiYbnWp2uCcKiorhKjfrz5eeU9nKl1upoLnIXLaAx3G/k4B0
         v5fHUjzZSZfmZAvh9DrkKEtTCGN3z58CjxChxux/acSTc5sd+fO2DqB0WLJvNLLfeECx
         +MIImGhOaklBc+11cG4Pu9GTllRp+Ivh3dvvmWYAv2fOENx8U5+O0huccFpBrXlqO50u
         G45g==
X-Gm-Message-State: AOAM5306MCfAbbogGcf5qhU3eOYfr7pNIrVtNBMdgQ0+cgKANv8ihoSk
        VRarP4RW4U7vR1FIhi93tjn31VWntkN34mMayhxhHj/RSaKfbQ==
X-Google-Smtp-Source: ABdhPJyp+qZpg6yASkIJ5hdiLxk+3WaECOlbvCwut9OczSlrFHn2Y6OwIZqLgesVbLPWLSpUHayHR564cExXFxxPVvA=
X-Received: by 2002:a17:907:1199:: with SMTP id uz25mr1130137ejb.470.1633664572140;
 Thu, 07 Oct 2021 20:42:52 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 8 Oct 2021 13:42:41 +1000
Message-ID: <CAPM=9txCVSSAQF8f_wR41sEBh_NjT-VSkbod6Pxcwb4dHu=WBw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.15-rc5
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

I've returned from my tropical island retreat, even managed to bring
one of my kids on a dive with some turtles. Thanks to Daniel for doing
last week's work.

Otherwise this is the weekly fixes pull, it's a bit bigger because the
vc4 reverts in your tree caused some problems with fixes in the
drm-misc tree so it got left out last week, so this week has the misc
fixes rebased without the vc4 pieces. Otherwise it's i915, amdgpu with
the usual fixes and a scattering over other drivers.

I expect things should calm down a bit more next week.

Regards,
Dave.

drm-fixes-2021-10-08:
drm fixes for 5.15-rc5

core:
- Kconfig fix for fb_simple vs simpledrm.

i915:
- Fix RKL HDMI audio
- Fix runtime pm imbalance on i915_gem_shrink() error path
- Fix Type-C port access before hw/sw state sync
- Fix VBT backlight struct version/size check
- Fix VT-d async flip on SKL/BXT with plane stretch workaround

amdgpu:
- DCN 3.1 DP alt mode fixes
- S0ix gfxoff fix
- Fix DRM_AMD_DC_SI dependencies
- PCIe DPC handling fix
- DCN 3.1 scaling fix
- Documentation fix

amdkfd:
- Fix potential memory leak
- IOMMUv2 init fixes

vc4:
- compiler fix
- (there were some hdmi fixes but things got reverted, sort it out later)

nouveau:
- Cursor fix
- Fix ttm buffer moves for ampere gpu's by adding minimal acceleration supp=
ort.
- memory leak fixes

rockchip:
- crtc/clk fixup

panel:
- ili9341 Fix DT bindings indent
- y030xx067a - yellow tint init seq fix

gbefb:
- Fix gbefb when built with COMPILE_TEST.
The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896=
:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-10-08

for you to fetch changes up to bf79045e0ef5f0fb2a0619f9d0782665d07b2d66:

  Merge tag 'amd-drm-fixes-5.15-2021-10-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-10-08
11:40:21 +1000)

----------------------------------------------------------------
drm fixes for 5.15-rc5

core:
- Kconfig fix for fb_simple vs simpledrm.

i915:
- Fix RKL HDMI audio
- Fix runtime pm imbalance on i915_gem_shrink() error path
- Fix Type-C port access before hw/sw state sync
- Fix VBT backlight struct version/size check
- Fix VT-d async flip on SKL/BXT with plane stretch workaround

amdgpu:
- DCN 3.1 DP alt mode fixes
- S0ix gfxoff fix
- Fix DRM_AMD_DC_SI dependencies
- PCIe DPC handling fix
- DCN 3.1 scaling fix
- Documentation fix

amdkfd:
- Fix potential memory leak
- IOMMUv2 init fixes

vc4:
- compiler fix
- (there were some hdmi fixes but things got reverted, sort it out later)

nouveau:
- Cursor fix
- Fix ttm buffer moves for ampere gpu's by adding minimal acceleration supp=
ort.
- memory leak fixes

rockchip:
- crtc/clk fixup

panel:
- ili9341 Fix DT bindings indent
- y030xx067a - yellow tint init seq fix

gbefb:
- Fix gbefb when built with COMPILE_TEST.

----------------------------------------------------------------
Alex Deucher (2):
      Documentation/gpu: remove spurious "+" in amdgpu.rst
      drm/amdgpu/display: fix dependencies for DRM_AMD_DC_SI

Arnd Bergmann (1):
      fbdev: simplefb: fix Kconfig dependencies

Ben Skeggs (3):
      drm/nouveau/kms/tu102-: delay enabling cursor until after assign_wind=
ows
      drm/nouveau/ga102-: support ttm buffer moves via copy engine
      drm/nouveau/fifo/ga102: initialise chid on return from channel creati=
on

Chris Morgan (1):
      drm/rockchip: Update crtc fixup to account for fractional clk change

Christophe Branchereau (1):
      drm/panel: abt-y030xx067a: yellow tint fix

Dave Airlie (3):
      Merge tag 'drm-intel-fixes-2021-10-07' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2021-10-06' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'amd-drm-fixes-5.15-2021-10-06' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Edmund Dea (1):
      drm/kmb: Enable alpha blended second plane

George Shen (1):
      drm/amd/display: Skip override for preferred link settings
during link training

Guchun Chen (1):
      drm/amdgpu: handle the case of pci_channel_io_frozen only in
amdgpu_pci_resume

Hansen (1):
      drm/amd/display: Fix detection of 4 lane for DPALT

Imre Deak (1):
      drm/i915/tc: Fix TypeC port init/resume time sanitization

Jeremy Cline (1):
      drm/nouveau: avoid a use-after-free when BO init fails

Jernej Skrabec (1):
      drm/sun4i: dw-hdmi: Fix HDMI PHY clock setup

Jude Shih (1):
      drm/amd/display: USB4 bring up set correct address

Kai-Heng Feng (1):
      drm/i915/audio: Use BIOS provided value for RKL HDA link

Krzysztof Kozlowski (1):
      dt-bindings: panel: ili9341: correct indentation

Lang Yu (1):
      drm/amdkfd: fix a potential ttm->sg memory leak

Lijo Lazar (1):
      drm/amdgpu: During s0ix don't wait to signal GFXOFF

Liu, Zhan (2):
      drm/amd/display: Fix B0 USB-C DP Alt mode
      drm/amd/display: Fix DCN3 B0 DP Alt Mapping

Lukasz Majczak (1):
      drm/i915/bdb: Fix version check

Maarten Lankhorst (1):
      drm/i915: Fix runtime pm handling in i915_gem_shrink

Mark Brown (1):
      video: fbdev: gbefb: Only instantiate device when built for IP32

Maxime Ripard (1):
      drm/vc4: hdmi: Remove unused struct

Nikola Cornij (1):
      drm/amd/display: Limit display scaling to up to 4k for DCN 3.1

Randy Dunlap (1):
      DRM: delete DRM IRQ legacy midlayer docs

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Extend the async flip VT-d w/a to skl/bxt

Yang Yingliang (2):
      drm/nouveau/kms/nv50-: fix file release memory leak
      drm/nouveau/debugfs: fix file release memory leak

Yifan Zhang (2):
      drm/amdkfd: remove redundant iommu cleanup code
      drm/amdgpu: init iommu after amdkfd device init

 .../bindings/display/panel/ilitek,ili9341.yaml     |   2 +-
 Documentation/gpu/amdgpu.rst                       |   4 +-
 Documentation/gpu/drm-internals.rst                |   9 -
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c            |  14 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |   8 +-
 drivers/gpu/drm/amd/display/Kconfig                |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |   6 -
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.h  |   1 +
 .../amd/display/dc/dcn31/dcn31_dio_link_encoder.c  |  66 ++++-
 .../amd/display/dc/dcn31/dcn31_dio_link_encoder.h  |  14 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_resource.c  |   8 +-
 drivers/gpu/drm/amd/display/include/dal_asic_id.h  |   2 +-
 .../amd/include/asic_reg/dpcs/dpcs_4_2_0_offset.h  |  27 ++
 drivers/gpu/drm/i915/display/icl_dsi.c             |  10 +-
 drivers/gpu/drm/i915/display/intel_audio.c         |   5 +-
 drivers/gpu/drm/i915/display/intel_bios.c          |  22 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |   8 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  20 +-
 drivers/gpu/drm/i915/display/intel_vbt_defs.h      |   5 +
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   7 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   5 +
 drivers/gpu/drm/i915/intel_pm.c                    |  12 +
 drivers/gpu/drm/kmb/kmb_drv.c                      |   8 +-
 drivers/gpu/drm/kmb/kmb_drv.h                      |   5 +
 drivers/gpu/drm/kmb/kmb_plane.c                    |  81 +++++-
 drivers/gpu/drm/kmb/kmb_plane.h                    |   5 +-
 drivers/gpu/drm/kmb/kmb_regs.h                     |   3 +
 drivers/gpu/drm/nouveau/dispnv50/crc.c             |   1 +
 drivers/gpu/drm/nouveau/dispnv50/head.c            |   2 +-
 drivers/gpu/drm/nouveau/include/nvif/class.h       |   2 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/fifo.h |   1 +
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   1 +
 drivers/gpu/drm/nouveau/nouveau_chan.c             |   6 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c          |   1 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   4 +
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   4 +-
 drivers/gpu/drm/nouveau/nv84_fence.c               |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |   3 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/Kbuild    |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c   | 311 +++++++++++++++++=
++++
 drivers/gpu/drm/nouveau/nvkm/subdev/top/ga100.c    |   7 +-
 drivers/gpu/drm/panel/panel-abt-y030xx067a.c       |   4 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c        |  26 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |   7 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h              |   4 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c             |  97 ++++---
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   8 -
 drivers/of/base.c                                  |   1 +
 drivers/video/fbdev/Kconfig                        |   5 +-
 drivers/video/fbdev/gbefb.c                        |   2 +-
 53 files changed, 712 insertions(+), 163 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/ga102.c
