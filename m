Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5C36F49E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 05:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhD3Dv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 23:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhD3DvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 23:51:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B0C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 20:50:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r12so103127573ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 20:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0pQY+vIbx8Y+YUwQJUfnVfqBBsx7bNVC3V4MgXurjEI=;
        b=PuxTN/uCxUTNk/saiQU2SRizkKNkGlqbLG4owPZ5ki94oE2ZdJR88av3NBFVMgWO2m
         PtAqTDetZOKoA6C1tSaO9iMkN/WFkqR5YiYOtCJtxj0pSYo3QKSthXsw2toR60XuGAoR
         enV4mMLw8ra+cwbEaJzr+CEt+jqeHPpNirLvKpu2qROQZ+bAZjPOSt0dGfnpGWb1xoCI
         t7N5ifiq3qrC9blNnUqazFQqrCECa3xEY9Ek8FbForEIP7q43qVjkBwHV7cvQd9eGAmE
         V6lAMY1hlpC6PLm5AZknNIuHdT0YIntx8gqoaJiK4/d0T4fF0BhODYrTR467oooaqlt6
         UUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=0pQY+vIbx8Y+YUwQJUfnVfqBBsx7bNVC3V4MgXurjEI=;
        b=WhUxGwOyJJP25XUnJpZ88Zv7Wgp18tDwOXGHxKlfugiJCM9o1yz1ryydGyUpPInpEG
         Czt/lwRW73zeGjxTenpzzHbGqLmcI+SrerUQqD3RDZt6bDNgxKi6rbmh1gyOy6yyGLD9
         0vcXtdr2fNu7LJzGGn6Z8r+Fg6xS32Tl3VXL6fmVhq+HE4jNwPCq2xv+TI1y9aZhdx3O
         G4PpT5m6P53aivHh/4QfNqh7SZ05F4A8Ps5GOO2CG1IAOO3ZhYXG8lyxvzIPAOuRK8xy
         myV7f0zX5fqj37ZyaurjweD+9k05FBYmrwHZXN0i4pOAHA/gUtRA1Y/p2Lswrd7bYFmZ
         JZYA==
X-Gm-Message-State: AOAM532XPVjkYhGiiw7uf8ZpKklLsaP3BhQV8a/Zk0g4FarWKEQmw/4U
        G2ZUJrPh3g4MgMY5p2kZnBNnNXFTWhWHBj6BM6QXi+9Nxp8=
X-Google-Smtp-Source: ABdhPJz99jrP5kYPuwTrUNYFTVbNgq2PiNyvpIOPlaN6POotwICFHKxbJWfVGv3Pw99ic4XhcditieaHyHcUMWO5InU=
X-Received: by 2002:a17:906:1fd1:: with SMTP id e17mr1866855ejt.419.1619754636312;
 Thu, 29 Apr 2021 20:50:36 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 30 Apr 2021 13:50:25 +1000
Message-ID: <CAPM=9tyW43hM-K18AP+eTEVKnrnoAWR_yqqmNDs9SVgG+MxX0g@mail.gmail.com>
Subject: [git pull] drm tegra-next + fixes for 5.13-rc1
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

Looks like I missed a tegra feature request for next, but should still
be fine since it's pretty self contained. It does contain one
fixes->next merge with no merge justification so I've pushed back on
Thierry about not doing that in the future, but let it go now as
rebasing might be worse.

Apart from that got a set of i915 and amdgpu fixes as per usual along
with a few misc fixes.

Dave.

drm-next-2021-04-30:
drm tegra-next + fixes for 5.13-rc1

tegra:
- Tegra186 hardware cursor support
- better capability reporting for different SoC
- better framebuffer modifier support
- host1x fixes

ttm:
- fix unswappable BO handling

efifb:
- check for PCI before using it

amdgpu:
- Fixes for Aldebaran
- Display LTTPR fixes
- eDP fixes
- Fixes for Vangogh
- RAS fixes
- ASPM support
- Renoir SMU fixes
- Modifier fixes
- Misc code cleanups
- Freesync fixes

i915:
- Several fixes to GLK handling in recent display refactoring
- Rare watchdog timer race fix
- Cppcheck redundant condition fix
- Overlay error code propagation fix
- Documentation fix
- gvt: Remove one unused function warning
- gvt: Fix intel_gvt_init_device() return type
- gvt: Remove one duplicated register accessible check
The following changes since commit a1a1ca70deb3ec600eeabb21de7f3f48aaae5695=
:

  Merge tag 'drm-misc-next-fixes-2021-04-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2021-04-23
13:53:07 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2021-04-30

for you to fetch changes up to 1cd6b4a04f038eb24fd18c8010e763d1140a9c7a:

  Merge tag 'drm-intel-next-fixes-2021-04-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2021-04-30
10:42:03 +1000)

----------------------------------------------------------------
drm tegra-next + fixes for 5.13-rc1

tegra:
- Tegra186 hardware cursor support
- better capability reporting for different SoC
- better framebuffer modifier support
- host1x fixes

ttm:
- fix unswappable BO handling

efifb:
- check for PCI before using it

amdgpu:
- Fixes for Aldebaran
- Display LTTPR fixes
- eDP fixes
- Fixes for Vangogh
- RAS fixes
- ASPM support
- Renoir SMU fixes
- Modifier fixes
- Misc code cleanups
- Freesync fixes

i915:
- Several fixes to GLK handling in recent display refactoring
- Rare watchdog timer race fix
- Cppcheck redundant condition fix
- Overlay error code propagation fix
- Documentation fix
- gvt: Remove one unused function warning
- gvt: Fix intel_gvt_init_device() return type
- gvt: Remove one duplicated register accessible check

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/gmc9: remove dummy read workaround for newer chips

Anthony Koo (3):
      drm/amd/display: [FW Promotion] Release 0.0.60
      drm/amd/display: [FW Promotion] Release 0.0.61
      drm/amd/display: [FW Promotion] Release 0.0.62

Anthony Wang (3):
      drm/amd/display: Force vsync flip when reconfiguring MPCC
      drm/amd/display: Add DSC check to seamless boot validation
      drm/amd/display: disable seamless boot for external DP

Aric Cyr (3):
      drm/amd/display: 3.2.131
      drm/amd/display: Fix FreeSync when RGB MPO in use
      drm/amd/display: 3.2.132

Bing Guo (1):
      drm/amd/display: add helper for enabling mst stream features

Dan Carpenter (4):
      drm/i915/gvt: Fix error code in intel_gvt_init_device()
      drm/amdgpu: fix an error code in init_pmu_entry_by_type_and_add()
      drm/amd/pm: fix error code in smu_set_power_limit()
      drm/i915: fix an error code in intel_overlay_do_put_image()

Dave Airlie (4):
      Merge tag 'drm/tegra/for-5.13-rc1' of
ssh://git.freedesktop.org/git/tegra/linux into drm-next
      Merge tag 'drm-misc-next-fixes-2021-04-29' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-next-5.13-2021-04-23' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2021-04-27' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

David Galiffi (1):
      drm/amd/display: Fixed typo in function name.

Dennis Li (2):
      drm/amdkfd: add edc error interrupt handle for poison propogate mode
      drm/amdgpu: fix a error injection failed issue

Dillon Varone (2):
      drm/amd/display: Fix call to pass bpp in 16ths of a bit
      drm/amd/display: Report Proper Quantization Range in AVI Infoframe

Dingchen (David) Zhang (2):
      drm/amd/display: update hdcp display using correct CP type.
      drm/amd/display: add handling for hdcp2 rx id list validation

Eric Huang (1):
      drm/amdkfd: change MTYPEs for Aldebaran's HW requirement

Felix Kuehling (1):
      drm/amdkfd: Remove legacy code not acquiring VMs

Harry Wentland (1):
      drm/amd/display: Add debugfs to repress HPD and HPR_RX IRQs

Hawking Zhang (3):
      drm/amdgpu: correct default gfx wdt timeout setting
      drm/amdgpu: only harvest gcea/mmea error status in arcturus
      drm/amdgpu: only harvest gcea/mmea error status in aldebaran

Huang Rui (1):
      drm/amdgpu: enable tmz on renoir asics

Hugo Hu (1):
      drm/amd/display: treat memory as a single-channel for asymmetric memo=
ry v2

Jack Zhang (1):
      drm/amd/sriov no need to config GECC for sriov

Jake Wang (1):
      drm/amd/display: Added support for multiple eDP BL control

Jani Nikula (1):
      Merge tag 'gvt-next-fixes-2021-04-21' of
https://github.com/intel/gvt-linux into drm-intel-next-fixes

Jiansong Chen (1):
      drm/amdgpu: fix GCR_GENERAL_CNTL offset for dimgrey_cavefish

Jiapeng Chong (1):
      drm/i915/gvt: remove useless function

Jinzhou Su (2):
      drm/amdgpu: Add graphics cache rinse packet for sdma
      drm/amdgpu: Add mem sync flag for IB allocated by SA

John Clements (3):
      drm/amdgpu: update mmhub 1.7 ras error reporting
      drm/amdgpu: update gfx 9.4.2 ras error reporting
      drm/amdgpu: resolve erroneous gfx_v9_4_2 prints

Jon Hunter (1):
      gpu: host1x: Fix Tegra194 syncpt interrupt threshold

Joseph Greathouse (1):
      drm/amdgpu: Copy MEC FW version to MEC2 if we skipped loading MEC2

Jos=C3=A9 Roberto de Souza (1):
      drm/i915/display/psr: Fix cppcheck warnings

Kai-Heng Feng (1):
      efifb: Check efifb_pci_dev before using it

Kenneth Feng (3):
      drm/amd/amdgpu: enable ASPM on navi1x
      drm/amd/amdgpu: enable ASPM on vega
      drm/amd/amdgpu: add ASPM support on polaris

Kent Russell (1):
      drm/amdgpu: Ensure dcefclk isn't created on Aldebaran

Lewis Huang (1):
      drm/amd/display: wait vblank when stream enabled and update dpp clock

Lijo Lazar (2):
      drm/amd/pm: Use VBIOS PPTable for aldebaran
      drm/amd/pm: Show updated clocks on aldebaran

Luben Tuikov (5):
      drm/amdgpu: Fix a bug for input with double sscanf
      drm/amdgpu: Fix a bug in checking the result of reserve page
      drm/amdgpu: Add bad_page_cnt_threshold to debugfs
      drm/amdgpu: Fix kernel-doc for the RAS sysfs interface
      drm/amdgpu: Add double-sscanf but invert

Maarten Lankhorst (1):
      drm/i915: Fix docbook descriptions for i915_gem_shrinker

Michael Strauss (4):
      drm/amd/display: Add debug flag to enable eDP ILR by default
      drm/amd/display: Disable boot optimizations if ILR optimzation is req=
uired
      drm/amd/display: Remove static property from decide_edp_link_settings
      drm/amd/display: Add link rate optimization logs for ILR

Mike Hsieh (1):
      drm/amd/display: Fix DSC enable sequence

Mikita Lipski (2):
      drm/amd/display: Remove unused flag from stream state
      drm/amd/display: Connect clock optimization function to dcn301

Mikko Perttunen (8):
      gpu: host1x: Allow syncpoints without associated client
      gpu: host1x: Show number of pending waiters in debugfs
      gpu: host1x: Remove cancelled waiters immediately
      gpu: host1x: Use HW-equivalent syncpoint expiration check
      gpu: host1x: Cleanup and refcounting for syncpoints
      gpu: host1x: Reset max value when freeing a syncpoint
      gpu: host1x: Reserve VBLANK syncpoints at initialization
      gpu: host1x: Assign intr waiter inside lock

Mukul Joshi (2):
      drm/amdgpu: Reset RAS error count and status regs
      drm/amdgpu: Fix SDMA RAS error reporting on Aldebaran

Nicholas Kazlauskas (2):
      drm/amd/display: Fix DML validation of simple vs native 422 modes
      drm/amd/display: Always poll for rxstatus in authenticate

Oak Zeng (4):
      drm/amdgpu: Introduce functions for vram physical addr calculation
      drm/amdgpu: Calling address translation functions to simplify codes
      drm/amdgpu: Introduce new SETUP_TMR interface
      Revert "drm/amdgpu: workaround the TMR MC address issue (v2)"

Qingqing Zhuo (2):
      drm/amd/display: Update modifier list for gfx10_3
      Revert "Revert "drm/amdgpu: Ensure that the modifier requested
is supported by plane.""

Ramesh Errabolu (1):
      drm/amdgpu: Use iterator methods exposed by amdgpu_res_cursor.h
in building SG_TABLE's for a VRAM BO

Robin Singh (2):
      drm/amd/display: fixed divide by zero kernel crash during dsc enablem=
ent
      drm/amd/display: removed unused function dc_link_reallocate_mst_paylo=
ad.

Roman Li (1):
      drm/amd/display: Fix hangs with psr enabled on dcn3.xx

Shashank Sharma (1):
      drm/amdgpu/dm: Fix NULL pointer crash during DP MST hotplug

Shiwu Zhang (1):
      drm/ttm: fix error handling if no BO can be swapped out v4

Simon Ser (1):
      amd/display: allow non-linear multi-planar formats

Thierry Reding (9):
      Merge branch 'drm/tegra/fixes' into drm/tegra/for-next
      gpu: host1x: Add early init and late exit callbacks
      drm/tegra: dc: Inherit DMA mask
      drm/tegra: dc: Parameterize maximum resolution
      drm/tegra: dc: Implement hardware cursor on Tegra186 and later
      drm/tegra: fb: Add diagnostics for framebuffer modifiers
      drm/tegra: gem: Add a clarifying comment
      drm/tegra: Count number of display controllers at runtime
      drm/tegra: Support sector layout on Tegra194

Tian Tao (1):
      drm/radeon/cik: remove set but not used variables

Tvrtko Ursulin (1):
      drm/i915: Take request reference before arming the watchdog timer

Ville Syrj=C3=A4l=C3=A4 (3):
      drm/i915: Restore lost glk FBC 16bpp w/a
      drm/i915: Restore lost glk ccs w/a
      drm/i915: Disable LTTPR detection on GLK once again

Wesley Chalmers (2):
      drm/amd/display: Set LTTPR mode to non-LTTPR if no repeaters found
      drm/amd/display: Unconditionally clear training pattern set after lt

Xiaojian Du (6):
      drm/amd/pm: update the driver interface header for vangogh
      drm/amd/pm: add support for new smu metrics table for vangogh
      drm/amd: update the atomfirmware header for smu12
      drm/amd/pm: add the callback to get the bootup values for renoir
      drm/amd/pm: remove the "set" function of pp_dpm_mclk for vangogh
      drm/amd/pm: revise two names of sensor values for vangogh

Yang Li (1):
      drm/radeon/si: Fix inconsistent indenting

Zhenyu Wang (1):
      drm/i915/gvt: Remove duplicated register accessible check

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h         |   4 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c   |  63 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c        |  13 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c             |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  41 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h            |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  82 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |  34 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              |   3 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c              |  16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c            |  32 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c           |  24 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c           |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c             |   3 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              |   9 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c            |  24 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            |   3 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c            |  11 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             | 128 +++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             | 125 +++++++
 drivers/gpu/drm/amd/amdgpu/nv.c                    |  10 +-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h            |  11 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4.c             |  35 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |  28 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |   7 +-
 drivers/gpu/drm/amd/amdgpu/vi.c                    | 193 ++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c    | 129 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  27 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  38 ++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   3 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  |  35 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  25 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   9 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  58 +++-
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  37 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |  87 ++---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  63 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c  |  33 +-
 drivers/gpu/drm/amd/display/dc/dc.h                |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h           |   1 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h         |   1 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c      |   2 +
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  10 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  15 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |   2 +
 .../gpu/drm/amd/display/dc/dcn301/dcn301_init.c    |   2 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h        |   2 +
 drivers/gpu/drm/amd/display/dc/inc/dc_link_dp.h    |   8 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  31 +-
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |   2 -
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |   2 -
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |   2 +
 .../drm/amd/include/asic_reg/gc/gc_9_4_1_sh_mask.h |  16 +
 drivers/gpu/drm/amd/include/atomfirmware.h         |  41 +++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c                 |   4 +-
 .../gpu/drm/amd/pm/inc/smu11_driver_if_vangogh.h   |  40 ++-
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |   2 +-
 drivers/gpu/drm/amd/pm/inc/smu_v12_0.h             |   2 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   | 378 +++++++++++++++++=
++--
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |   1 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c     | 123 +++++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c |  55 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     |   2 -
 drivers/gpu/drm/i915/display/intel_display.c       |   3 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |   2 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |   2 +-
 drivers/gpu/drm/i915/display/intel_overlay.c       |   4 +-
 drivers/gpu/drm/i915/display/intel_psr.c           |   3 +-
 drivers/gpu/drm/i915/gem/i915_gem_shrinker.c       |   1 +
 drivers/gpu/drm/i915/gvt/cmd_parser.c              |   5 -
 drivers/gpu/drm/i915/gvt/gtt.c                     |   6 -
 drivers/gpu/drm/i915/gvt/gvt.c                     |   8 +-
 drivers/gpu/drm/i915/i915_request.c                |   3 +-
 drivers/gpu/drm/radeon/cik.c                       |   4 -
 drivers/gpu/drm/radeon/si.c                        |   2 +-
 drivers/gpu/drm/tegra/dc.c                         | 113 +++++-
 drivers/gpu/drm/tegra/dc.h                         |   6 +
 drivers/gpu/drm/tegra/drm.c                        |  27 +-
 drivers/gpu/drm/tegra/drm.h                        |   5 +
 drivers/gpu/drm/tegra/fb.c                         |  10 +
 drivers/gpu/drm/tegra/gem.h                        |   6 +
 drivers/gpu/drm/tegra/gr2d.c                       |   4 +-
 drivers/gpu/drm/tegra/gr3d.c                       |   4 +-
 drivers/gpu/drm/tegra/hub.c                        |  41 ++-
 drivers/gpu/drm/tegra/plane.c                      |  32 ++
 drivers/gpu/drm/tegra/vic.c                        |   4 +-
 drivers/gpu/drm/ttm/ttm_device.c                   |   2 +-
 drivers/gpu/drm/ttm/ttm_tt.c                       |   2 +
 drivers/gpu/drm/vmwgfx/ttm_memory.c                |   2 +-
 drivers/gpu/host1x/bus.c                           |  31 ++
 drivers/gpu/host1x/cdma.c                          |  11 +-
 drivers/gpu/host1x/debug.c                         |  14 +-
 drivers/gpu/host1x/dev.c                           |   6 +
 drivers/gpu/host1x/dev.h                           |  13 +-
 drivers/gpu/host1x/hw/cdma_hw.c                    |   2 +-
 drivers/gpu/host1x/hw/channel_hw.c                 |  10 +-
 drivers/gpu/host1x/hw/debug_hw.c                   |   2 +-
 drivers/gpu/host1x/hw/hw_host1x07_vm.h             |   2 +-
 drivers/gpu/host1x/intr.c                          |  28 +-
 drivers/gpu/host1x/intr.h                          |   4 +-
 drivers/gpu/host1x/job.c                           |   5 +-
 drivers/gpu/host1x/syncpt.c                        | 202 ++++++-----
 drivers/gpu/host1x/syncpt.h                        |   4 +-
 drivers/staging/media/tegra-video/vi.c             |   6 +-
 drivers/video/fbdev/efifb.c                        |   6 +-
 include/linux/host1x.h                             |  18 +-
 121 files changed, 2337 insertions(+), 621 deletions(-)
