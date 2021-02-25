Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F88C32569D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 20:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbhBYT07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbhBYTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 14:24:54 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ACEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:24:08 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d8so10753144ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 11:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/Z4k1oLR2zEbGG8x+xifCQPmkVHmiWfhHSn+WZvhyTQ=;
        b=bHjovVtAFkPg/UJ92MhEQtv4+7Mix6Hp+U4j7Mn+LM4XWpgEPRKEggL3wQ6CgnSA8A
         7O6A9+AoW/5pXF5b/mik2npTWZ3OwXY6k50w0Yymk94iRHzY4DgvVSIRcgomtjCh/wPp
         RKvaIWCFO1uqT9+Sn+9ICtdzV+qjwh7nauD+xkKEDL7UykxWH6nmJvepwJ9S0y6d6Vns
         HcmHgZdfgXvSWqd027o4a4yex3FC2ZrtgXzgcvXwQ3D/oWqotGRMCcw+gBLyRUft8Rlh
         hPOJJjGZrcP4aG42esCEJHFQ1yzKCGcx2NoiHHJOTCfTqgE0/xg8QEJFOd40DnlmtoHs
         00rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=/Z4k1oLR2zEbGG8x+xifCQPmkVHmiWfhHSn+WZvhyTQ=;
        b=lUxeu+kbTXh1KO8rMxXAxrDZQtLUz9uQF1tWkinP2PK87WkQDgJD8YwfQLHVxwcSk2
         7rGv14e7xO/mwZHQwsmbt0+jvPosTlWyHLazoTtnOHg+/R0A+IDcldtJSXdw6b/5kXjx
         +d2pT28uvQQvIQE8X27L+1q5IVlzDZiCzqmsSqTww6qjmJyGmQ3IDXjhtAcAg2NuK2Kq
         FGkYoCi8p35apRs52Y9XSH/tBaPkj7ifxE7yFefHa1ArJgaOsErKRS5N2b4xR1ivQO/G
         mH1yKrOYhOQSdqBMLdVKA/eDPpAnnHnnx93Gi4J1R/h86x+1Z3H1GFT1T/COW+XGdZjR
         fGzQ==
X-Gm-Message-State: AOAM531jIRsdokHgrXgJnE8f/TjlWYla+oaFS11XWtyZKzbLGKQchqbU
        FLXaUUMh+DVDyS90cCHUN0xfRzKJR+k6kXUEO5W6ZP51tIk=
X-Google-Smtp-Source: ABdhPJz6Ujmk4jr4S43LLBDYV0I2LYbpQJJRzgoZyv0qN3jt4Un/d20Hx+PAhbz/b0saoiEAYXPVVK18z0qjbptZn4w=
X-Received: by 2002:a17:907:1b02:: with SMTP id mp2mr4257418ejc.419.1614281045247;
 Thu, 25 Feb 2021 11:24:05 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 26 Feb 2021 05:23:53 +1000
Message-ID: <CAPM=9tyht2VHck6c0oh21+H=b_M=h1dvm4BNqe6AkPYZ+Ph_Uw@mail.gmail.com>
Subject: [git pull] drm fixes + msm-next for 5.12-rc1
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

Hope power/internet are back on fully!

This is fixes but I missed msm-next pull last week. It's been in
drm-next anyways so shouldn't be a problem.

Otherwise it's a selection of i915, amdgpu and misc fixes, one TTM
memory leak, nothing really major stands out otherwise.

Dave.

drm-next-2021-02-26:
drm fixes for 5.12-rc1 + msm-next

core:
- vblank fence timing improvements

dma-buf:
- improve error handling

ttm:
- memory leak fix

msm:
- a6xx speedbin support
- a508, a509, a512 support
- various a5xx fixes
- various dpu fixes
- qseed3lite support for sm8250
- dsi fix for msm8994
- mdp5 fix for framerate bug with cmd mode panels
- a6xx GMU OOB race fixes that were showing up in CI
- various addition and removal of semicolons
- gem submit fix for legacy userspace relocs path

amdgpu:
- Clang warning fix
- S0ix platform shutdown/poweroff fix
- Misc display fixes

i915:
- color format fix
- -Wuninitialised reenabled
- GVT ww locking, cmd parser fixes

atyfb:
- fix build

rockchip:
- AFBC modifier fix
The following changes since commit f730f39eb981af249d57336b47cfe3925632a7fd=
:

  Merge tag 'drm-intel-next-fixes-2021-02-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2021-02-19
13:55:07 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-02-26

for you to fetch changes up to d153e8c156dafeb847fd655f416cf81c007e8706:

  Merge tag 'drm-intel-next-fixes-2021-02-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2021-02-26
05:08:51 +1000)

----------------------------------------------------------------
drm fixes for 5.12-rc1 + msm-next

core:
- vblank fence timing improvements

dma-buf:
- improve error handling

ttm:
- memory leak fix

msm:
- a6xx speedbin support
- a508, a509, a512 support
- various a5xx fixes
- various dpu fixes
- qseed3lite support for sm8250
- dsi fix for msm8994
- mdp5 fix for framerate bug with cmd mode panels
- a6xx GMU OOB race fixes that were showing up in CI
- various addition and removal of semicolons
- gem submit fix for legacy userspace relocs path

amdgpu:
- Clang warning fix
- S0ix platform shutdown/poweroff fix
- Misc display fixes

i915:
- color format fix
- -Wuninitialised reenabled
- GVT ww locking, cmd parser fixes

atyfb:
- fix build

rockchip:
- AFBC modifier fix

----------------------------------------------------------------
Akhil P Oommen (1):
      drm/msm: Add speed-bin support to a618 gpu

Alyssa Rosenzweig (1):
      drm/rockchip: Require the YTR modifier for AFBC

AngeloGioacchino Del Regno (16):
      drm/msm/a5xx: Allow all patchid for A540 chip
      drm/msm/a5xx: Remove overwriting A5XX_PC_DBG_ECO_CNTL register
      drm/msm/a5xx: Separate A5XX_PC_DBG_ECO_CNTL write from main branch
      drm/msm/a5xx: Add support for Adreno 508, 509, 512 GPUs
      drm/msm/a5xx: Reset VBIF before PC only on A510 and A530
      drm/msm/dpu: Fix VBIF_XINL_QOS_LVL_REMAP_000 register offset
      drm/msm/dpu: Move DPU_SSPP_QOS_8LVL bit to SDM845 and SC7180 masks
      drm/msm/dpu: Add prog_fetch_lines_worst_case to INTF_BLK macro
      drm/msm/dpu: Allow specifying features and sblk in DSPP_BLK macro
      drm/msm/dpu: Disable autorefresh in command mode
      drm/msm/dpu: Correctly configure vsync tearcheck for command mode
      drm/msm/dpu: Remove unused call in wait_for_commit_done
      drm/msm/dsi_pll_10nm: Fix dividing the same numbers twice
      drm/msm/dsi_pll_10nm: Solve TODO for multiplier frac_bits assignment
      drm/msm/dsi_pll_10nm: Fix variable usage for pll_lockdet_rate
      drm/msm/dsi_pll_10nm: Convert pr_err prints to DRM_DEV_ERROR

Anson Jacob (1):
      Revert "drm/amd/display: reuse current context instead of recreating =
one"

Bernard Zhao (1):
      drm/msm: remove unneeded variable: "rc"

Bjorn Andersson (1):
      dt-bindings: dp-connector: Drop maxItems from -supply

Chris Wilson (2):
      drm/i915/gvt: Parse default state to update reg whitelist
      drm/i915/gvt: Purge dev_priv->gt

Dave Airlie (4):
      Merge tag 'drm-msm-next-2021-02-07' of
https://gitlab.freedesktop.org/drm/msm into drm-next
      Merge tag 'drm-misc-next-fixes-2021-02-25' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-fixes-5.12-2021-02-24' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2021-02-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Dmitry Baryshkov (1):
      drm/msm/dpu1: add support for qseed3lite used on sm8250

Eric Anholt (3):
      drm/msm: Fix race of GPU init vs timestamp power management.
      drm/msm: Fix races managing the OOB state for timestamp vs timestamps=
.
      drm/msm: Clean up GMU OOB set/clear handling.

Eric Bernstein (1):
      drm/amd/display: Remove Assert from dcn10_get_dig_frontend

Heiko Stuebner (1):
      drm/panel: kd35t133: allow using non-continuous dsi clock

Iskren Chernev (2):
      drm/msm: Fix MSM_INFO_GET_IOVA with carveout
      drm/msm/mdp5: Fix wait-for-commit for cmd panels

Jiapeng Zhong (1):
      drm/msm: remove redundant NULL check

John Stultz (2):
      dma-buf: system_heap: Make sure to return an error if we abort
      dma-buf: heaps: Rework heap allocation hooks to return struct
dma_buf instead of fd

Judy Hsiao (1):
      drm/msm/dp: trigger unplug event in msm_dp_display_disable

Konrad Dybcio (5):
      drm/msm/a5xx: Fix VPC protect value in gpu_write()
      drm/msm/a5xx: Disable flat shading optimization
      drm/msm/a5xx: Disable UCHE global filter
      drm/msm/dsi: Correct io_start for MSM8994 (20nm PHY)
      drm/msm/disp/mdp5: mdp5_cfg: Fix msm8974v2 max_clk

Kuogee Hsieh (2):
      drm/msm/dp: unplug interrupt missed after irq_hpd handler
      drm/msm/dp: reset dp controller only at boot up and pm_resume

Nathan Chancellor (2):
      drm/amd/pm/swsmu: Avoid using structure_size uninitialized in
smu_cmn_init_soft_gpu_metrics
      drm/i915: Enable -Wuninitialized

Prike Liang (1):
      drm/amdgpu: fix shutdown and poweroff process failed with s0ix

Qingqing Zhuo (1):
      drm/amd/display: Fix system hang after multiple hotplugs (v3)

Randy Dunlap (1):
      fbdev: atyfb: add stubs for aty_{ld,st}_lcd()

Rob Clark (1):
      drm/msm: Fix legacy relocs path

Rodrigo Siqueira (1):
      drm/amd/display: Add vupdate_no_lock interrupts for DCN2.1

Rodrigo Vivi (1):
      Merge tag 'gvt-next-fixes-2021-02-22' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Sai Prakash Ranjan (2):
      drm/msm: Add proper checks for GPU LLCC support
      drm/msm/a6xx: Create an A6XX GPU specific address space

Stephen Boyd (2):
      drm/msm/kms: Make a lock_class_key for each crtc mutex
      drm/msm/dp: Add a missing semi-colon

Veera Sundaram Sankaran (2):
      dma-fence: allow signaling drivers to set fence timestamp
      drm/drm_vblank: set the dma-fence timestamp during send_vblank_event

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Nuke INTEL_OUTPUT_FORMAT_INVALID

Xu Wang (2):
      drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c: Remove unneeded semicolon
      drm/msm/dp/dp_ctrl: Remove unneeded semicolon

Zhi Wang (1):
      drm/i915/gvt: Introduce per object locking in GVT scheduler.

xinhui pan (1):
      drm/ttm: Fix a memory leak

 .../bindings/display/connector/dp-connector.yaml   |   1 -
 drivers/dma-buf/dma-fence.c                        |  70 +++++++-
 drivers/dma-buf/dma-heap.c                         |  14 +-
 drivers/dma-buf/heaps/cma_heap.c                   |  22 +--
 drivers/dma-buf/heaps/system_heap.c                |  25 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   9 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 101 ++++++++---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  27 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  27 +--
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_link_encoder.c  |   1 -
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c |   2 +
 .../amd/display/dc/irq/dcn21/irq_service_dcn21.c   |  22 +++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c             |   2 +-
 drivers/gpu/drm/drm_file.c                         |  68 +++++--
 drivers/gpu/drm/drm_vblank.c                       |   9 +-
 drivers/gpu/drm/i915/Makefile                      |   1 -
 drivers/gpu/drm/i915/display/intel_crtc.c          |   1 -
 drivers/gpu/drm/i915/display/intel_display.c       |   3 +-
 drivers/gpu/drm/i915/display/intel_display_types.h |   1 -
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |  93 +++-------
 drivers/gpu/drm/i915/gvt/execlist.c                |   8 +-
 drivers/gpu/drm/i915/gvt/scheduler.c               |  52 ++++--
 drivers/gpu/drm/msm/adreno/a5xx.xml.h              |   2 +
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c              | 195 +++++++++++++++++=
+---
 drivers/gpu/drm/msm/adreno/a5xx_power.c            |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 105 ++++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |  49 ++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 139 ++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |   2 +
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  54 +++++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  23 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  22 ++-
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c   |  90 ++++++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  87 ++++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c    |  26 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h    |  14 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c        |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.h        |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        |  73 +++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_vbif.c        |   9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c          |   1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c           |   2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_crtc.c          |   2 +-
 drivers/gpu/drm/msm/dp/dp_aux.c                    |   7 -
 drivers/gpu/drm/msm/dp/dp_catalog.c                |  24 +++
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   |  15 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |   2 +-
 drivers/gpu/drm/msm/dp/dp_display.c                |  24 ++-
 drivers/gpu/drm/msm/dp/dp_panel.c                  |   3 +-
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_20nm.c         |   2 +-
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c         |  21 +--
 drivers/gpu/drm/msm/msm_drv.c                      |   3 +-
 drivers/gpu/drm/msm/msm_gem.c                      |   3 +-
 drivers/gpu/drm/msm/msm_gem_submit.c               |   2 +
 drivers/gpu/drm/msm/msm_kms.h                      |   8 +-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c       |   3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h        |  11 ++
 drivers/gpu/drm/ttm/ttm_bo.c                       |   9 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   9 +
 include/drm/drm_file.h                             |   3 +
 include/linux/dma-fence.h                          |   3 +
 include/linux/dma-heap.h                           |  12 +-
 68 files changed, 1223 insertions(+), 423 deletions(-)
