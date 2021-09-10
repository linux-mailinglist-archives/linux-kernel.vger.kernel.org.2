Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8784407399
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhIJWxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhIJWx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:53:27 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C1BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:52:14 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g14so3185429pfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoUWl3rslXgtLhiiednQQfftXE/VIn0uoNZFxjymzyU=;
        b=gbwDt4rMRnnTmcjjzcWyYZko0NOB/aCYb1yTpVfvnGPWm5i+ITszY3kG2pyhq6EVYW
         07sO9eAuUedUG5JKSutYTW2ODVZV+Z5fnVuDaSuqUJZNZ1ug3tTuxHLVn87IPb0UmdxS
         5esj0zu2GlIOprbF7EKIoh0gOH/G/zEWLF2no=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZoUWl3rslXgtLhiiednQQfftXE/VIn0uoNZFxjymzyU=;
        b=1KuAZyCK7q5dbb+KX0I/tJ/YOYKErw97zoXtz5ASom57HBZD3HFcLQzg3PlGz3IJep
         RlqpYcp8Csjze1LV1izqFttxocxxNGEjid6maQxvhkmUi2j4z3r7x45XVB7sbZoKAZ6Q
         ZSsY2nxCDuYArH28EfMEaH6/ughbC+pdZKzNJuZGvsHhALqSFb8dICUp5ZGzrmO2edq6
         +lvpBktdF1WrFkGQ2XCjjdt+owyVbj+k5LnObkIJ0R141hXxOLBPMpLoydC+8vcm5FNT
         DePM7cPQsW0Ljh/EPkZlyL0J/JU1y51J1KRK8aZX6Qo35z2YOff5cnSTK63T81tyEO0Y
         PUUw==
X-Gm-Message-State: AOAM533zcoOmy1pvDgcNr+6RavZPyHEqwmG+4QYnWjAcHklVzfySaKFJ
        rDQeVIHH8EdmWx+SOWZc7shE/w==
X-Google-Smtp-Source: ABdhPJwHIP0WRyBRTI9GaJLX3RM8gJjYA63v7oULug3MeiskR6GfmDCeNyJVj+hEAG/yKuA8SZ5p1w==
X-Received: by 2002:a63:d806:: with SMTP id b6mr23180pgh.395.1631314332916;
        Fri, 10 Sep 2021 15:52:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v9sm6085981pga.82.2021.09.10.15.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 15:52:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] treewide: Remove unnamed static initializations to 0
Date:   Fri, 10 Sep 2021 15:52:07 -0700
Message-Id: <20210910225207.3272766-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=797114; h=from:subject; bh=m2XyFgJvKyRgTG2oWC6soLlktzGzyXBM2/8qdvEABOA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhO+GWPDGJN2tA+A+/ROifyWcW3w+COEAAtwLR1PqJ eaf+CnOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYTvhlgAKCRCJcvTf3G3AJtPpD/ 9Hy6wl+6eRc7Dqs33lKW7z9OSS27DFIKUOOrf5BiEvSe+c5TW4dssa0Hg/4lnKgiAwElNvz2Ej0HBZ L/J8dApEJzoflTwNyNNZWY6S8y0hp6f8w8llKY23Qx9Si/gsA3Za6sLW67ASVCMKsW/vpQhUYKRZrE 6ybm+24uIyUC9xVjsBNv8lymQ/XuntLXYQd9ymtl8kehvnfiQvg6n/oQz2nYu8fnYGi/2fRCI4kpr2 EiAU8+3IvqrPIX4h/+WJwYXTOYyYS2/55rPbvQ/Os2/ffgbBfw6NeQx5Qs6bmRSbIYFSHHO7BLQNb6 pgGL4uTtXNoDmaWFY+HnSq00TmBW89kBVkOHjz0F8p/zM5XfRNTMJL4By6qgoDNcZ918CydWayoZp4 VI/gP1+jjliNXNRwkzqF5s82ZZVSbLha4m8CyqSXooMfQ+RjrcYAnXWPPn/RjZf0XtzDJ9Rh9vBTRQ +dDyQx+iACk34xDqitdL5E0fLg9UWMRESAgqYtM2ywgvWK9BL4X3iAU0+nA/qeKNdcpbM3fjQ1Bf7A 6C1ZMu8KDin4KQonDbWjl9bLsAQ+9G+KFf2FXtwBCzmTrdPKbiiDl1BbiW2+CuqlZjF+pTyXcpeMsF YOdkqwVF5e9kcnpRTvibhD6PhAuplmox+ERM3won10W/wjTZ6ent5WYqsGuA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4.9 does not like having struct assignments to 0 when members may be
compound types. For example, there are 186 instances of these kinds of
errors:

drivers/virtio/virtio_vdpa.c:146:9: error: missing braces around initializer [-Werror=missing-braces ]
drivers/cxl/core/regs.c:40:17: error: missing braces around initializer [-Werror=missing-braces]

Since "= { 0 }" and "= { }" have the same meaning ("incomplete
initializer") they will both initialize the given variable to zero
(modulo padding games).

After this change, I can almost build the "allmodconfig" target with
GCC 4.9 again.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
With this patch and the following three, I can build with gcc 4.9 again:
https://lore.kernel.org/lkml/20210910223332.3224851-1-keescook@chromium.org/
https://lore.kernel.org/lkml/20210910223409.3225001-1-keescook@chromium.org/
https://lore.kernel.org/lkml/20210910223613.3225685-1-keescook@chromium.org/
I look forward to raising our minimum GCC version again! :)
---
 arch/alpha/kernel/err_marvel.c                |   2 +-
 arch/alpha/kernel/osf_sys.c                   |   4 +-
 arch/arm/mach-omap2/clock.c                   |   2 +-
 arch/arm/mach-s3c/mach-mini2440.c             |   2 +-
 arch/arm/mach-s3c/mach-mini6410.c             |   2 +-
 arch/arm/mach-s3c/mach-real6410.c             |   2 +-
 arch/arm/mach-sunxi/mc_smp.c                  |   2 +-
 arch/mips/kernel/branch.c                     |   2 +-
 arch/parisc/kernel/inventory.c                |   2 +-
 arch/powerpc/include/asm/hw_breakpoint.h      |   2 +-
 arch/powerpc/kernel/dawr.c                    |   4 +-
 arch/powerpc/kernel/hw_breakpoint.c           |   2 +-
 arch/powerpc/kernel/mce_power.c               |   2 +-
 arch/powerpc/kernel/process.c                 |   4 +-
 arch/powerpc/kvm/book3s_hv_nested.c           |   2 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/platforms/pseries/ras.c          |   2 +-
 arch/riscv/kernel/machine_kexec.c             |   2 +-
 arch/riscv/kernel/sbi.c                       |   4 +-
 arch/s390/kernel/machine_kexec_file.c         |   2 +-
 arch/s390/kvm/interrupt.c                     |   4 +-
 arch/s390/kvm/kvm-s390.c                      |   2 +-
 arch/s390/kvm/priv.c                          |   2 +-
 arch/s390/pci/pci.c                           |   8 +-
 arch/s390/pci/pci_irq.c                       |   8 +-
 arch/s390/tools/gen_opcode_table.c            |   2 +-
 arch/sparc/kernel/smp_32.c                    |   2 +-
 arch/um/drivers/random.c                      |   2 +-
 arch/x86/hyperv/hv_init.c                     |   4 +-
 arch/x86/kernel/apic/x2apic_uv_x.c            |   2 +-
 arch/x86/kernel/cpu/microcode/amd.c           |   4 +-
 arch/x86/kernel/cpu/microcode/intel.c         |   2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |   4 +-
 arch/x86/kernel/dumpstack.c                   |   2 +-
 arch/x86/kernel/fpu/xstate.c                  |   2 +-
 arch/x86/kernel/unwind_frame.c                |   2 +-
 arch/x86/kvm/lapic.c                          |   2 +-
 arch/x86/kvm/mmu/mmu.c                        |   6 +-
 arch/x86/platform/efi/quirks.c                |   4 +-
 arch/x86/xen/pmu.c                            |   2 +-
 arch/xtensa/kernel/ptrace.c                   |   2 +-
 crypto/jitterentropy.c                        |   2 +-
 crypto/rsa.c                                  |   4 +-
 crypto/testmgr.c                              |   4 +-
 drivers/acpi/acpi_processor.c                 |   4 +-
 drivers/acpi/cppc_acpi.c                      |   2 +-
 drivers/acpi/nfit/core.c                      |   2 +-
 drivers/acpi/processor_pdc.c                  |   2 +-
 drivers/acpi/processor_perflib.c              |   2 +-
 drivers/base/property.c                       |   2 +-
 drivers/block/rbd.c                           |  10 +-
 drivers/block/virtio_blk.c                    |   2 +-
 drivers/bus/fsl-mc/dpbp.c                     |  12 +-
 drivers/bus/fsl-mc/dpcon.c                    |  14 +--
 drivers/bus/fsl-mc/dpmcp.c                    |   6 +-
 drivers/bus/fsl-mc/dprc.c                     |  32 ++---
 drivers/bus/fsl-mc/fsl-mc-bus.c               |   2 +-
 drivers/char/virtio_console.c                 |   2 +-
 drivers/clk/baikal-t1/clk-ccu-div.c           |   2 +-
 drivers/clk/baikal-t1/clk-ccu-pll.c           |   2 +-
 drivers/clk/bcm/clk-kona-setup.c              |   2 +-
 drivers/clk/qcom/clk-rcg.c                    |   8 +-
 drivers/clk/qcom/clk-rcg2.c                   |   6 +-
 drivers/clk/qcom/clk-rpmh.c                   |   4 +-
 drivers/clk/ti/clkctrl.c                      |   4 +-
 drivers/clk/xilinx/xlnx_vcu.c                 |   2 +-
 drivers/clk/zynqmp/clkc.c                     |  12 +-
 drivers/clk/zynqmp/divider.c                  |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                |   4 +-
 drivers/crypto/caam/caamalg_qi2.c             |   2 +-
 drivers/crypto/caam/dpseci.c                  |  28 ++---
 drivers/crypto/cavium/cpt/cptpf_main.c        |   6 +-
 .../crypto/marvell/octeontx/otx_cptpf_main.c  |   6 +-
 .../marvell/octeontx2/otx2_cptpf_main.c       |   2 +-
 drivers/crypto/sa2ul.c                        |  24 ++--
 drivers/cxl/core/regs.c                       |   4 +-
 drivers/dma/fsl-dpaa2-qdma/dpdmai.c           |  22 ++--
 drivers/dma/ti/k3-udma.c                      |  20 +--
 drivers/extcon/extcon.c                       |   2 +-
 drivers/firmware/efi/fake_mem.c               |   2 +-
 drivers/firmware/qcom_scm-legacy.c            |   2 +-
 drivers/firmware/qcom_scm-smc.c               |   2 +-
 drivers/firmware/xilinx/zynqmp-debug.c        |   2 +-
 drivers/fpga/dfl-n3000-nios.c                 |   4 +-
 drivers/gpio/gpio-sl28cpld.c                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c         |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 ++---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  18 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   6 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   4 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  10 +-
 .../amd/display/dc/bios/bios_parser_common.c  |   2 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  10 +-
 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |   8 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   4 +-
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        |   2 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  10 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   2 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   2 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  16 +--
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  10 +-
 .../amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  16 +--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  26 ++--
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  36 +++---
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |   2 +-
 .../drm/amd/display/dc/core/dc_link_hwss.c    |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   4 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   4 +-
 .../gpu/drm/amd/display/dc/dce/dce_clk_mgr.c  |   6 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c  |   2 +-
 .../drm/amd/display/dc/dce/dce_link_encoder.c |  22 ++--
 .../amd/display/dc/dce/dce_stream_encoder.c   |  10 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |   4 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  20 +--
 .../amd/display/dc/dce110/dce110_resource.c   |   4 +-
 .../display/dc/dce110/dce110_transform_v.c    |   6 +-
 .../amd/display/dc/dce112/dce112_resource.c   |   8 +-
 .../amd/display/dc/dce120/dce120_resource.c   |   6 +-
 .../amd/display/dc/dce60/dce60_hw_sequencer.c |   4 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  32 ++---
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   8 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |  14 +--
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   2 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   8 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +--
 .../amd/display/dc/dcn20/dcn20_link_encoder.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  10 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   8 +-
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c |   2 +-
 .../display/dc/dcn30/dcn30_dio_link_encoder.c |   2 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   6 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   4 +-
 .../dc/dcn301/dcn301_dio_link_encoder.c       |   2 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |   4 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_reg.c   |   4 +-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   2 +-
 .../gpu/drm/amd/display/include/fixed31_32.h  |   2 +-
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |   2 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   2 +-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |   2 +-
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   |   4 +-
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  10 +-
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c |   2 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |   2 +-
 .../drm/amd/pm/powerplay/smumgr/ci_smumgr.c   |   2 +-
 .../amd/pm/powerplay/smumgr/iceland_smumgr.c  |   2 +-
 .../pm/powerplay/smumgr/polaris10_smumgr.c    |   2 +-
 .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c |   4 +-
 .../drm/amd/pm/powerplay/smumgr/smu8_smumgr.c |   4 +-
 .../amd/pm/powerplay/smumgr/vega10_smumgr.c   |   2 +-
 .../amd/pm/powerplay/smumgr/vega12_smumgr.c   |   2 +-
 .../amd/pm/powerplay/smumgr/vega20_smumgr.c   |   2 +-
 .../amd/pm/powerplay/smumgr/vegam_smumgr.c    |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   2 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |   2 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   2 +-
 drivers/gpu/drm/drm_dp_helper.c               |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_vidi.c      |   2 +-
 drivers/gpu/drm/gma500/psb_intel_sdvo.c       |   2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c  |   4 +-
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c |   2 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c     |   2 +-
 drivers/gpu/drm/i915/gvt/handlers.c           |   2 +-
 drivers/gpu/drm/lima/lima_drv.c               |   2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  10 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c         |  20 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |   8 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c  |   4 +-
 .../drm/msm/disp/dpu1/dpu_encoder_phys_vid.c  |   8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c     |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c              |   2 +-
 drivers/gpu/drm/msm/dp/dp_link.c              |   6 +-
 drivers/gpu/drm/msm/msm_gem_submit.c          |   4 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c   |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c |   2 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c             |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c           |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4_core.c      |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c           |   2 +-
 drivers/gpu/drm/omapdrm/omap_crtc.c           |   2 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c      |   2 +-
 drivers/gpu/drm/omapdrm/omap_encoder.c        |   2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c          |   2 +-
 drivers/gpu/drm/panel/panel-dsi-cm.c          |   2 +-
 drivers/gpu/drm/radeon/cik.c                  |   2 +-
 drivers/gpu/drm/radeon/cypress_dpm.c          |   2 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |   2 +-
 .../drm/selftests/test-drm_dp_mst_helper.c    |   2 +-
 drivers/gpu/drm/tegra/fb.c                    |   2 +-
 drivers/gpu/drm/vc4/vc4_render_cl.c           |   2 +-
 drivers/gpu/drm/virtio/virtgpu_gem.c          |   2 +-
 drivers/gpu/drm/virtio/virtgpu_ioctl.c        |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |   4 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_mob.c           |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c          |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c       |   2 +-
 drivers/gpu/drm/xlnx/zynqmp_dp.c              |   2 +-
 drivers/hid/hid-logitech-hidpp.c              |   2 +-
 drivers/hid/hid-quirks.c                      |   2 +-
 drivers/hid/hid-sensor-custom.c               |   4 +-
 drivers/hid/hid-uclogic-params.c              |   4 +-
 drivers/hid/intel-ish-hid/ishtp/hbm.c         |   8 +-
 drivers/hwmon/sbrmi.c                         |   6 +-
 drivers/hwtracing/coresight/coresight-etb10.c |   2 +-
 .../coresight/coresight-etm3x-core.c          |   2 +-
 .../coresight/coresight-etm4x-core.c          |   4 +-
 .../hwtracing/coresight/coresight-funnel.c    |   2 +-
 .../coresight/coresight-replicator.c          |   2 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   2 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c  |   2 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |   2 +-
 drivers/i2c/busses/i2c-cp2615.c               |   2 +-
 drivers/i2c/busses/i2c-mlxbf.c                |   2 +-
 drivers/i2c/busses/i2c-tegra.c                |   2 +-
 drivers/iio/adc/at91-sama5d2_adc.c            |   2 +-
 drivers/infiniband/core/uverbs_cmd.c          |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c          |  16 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c    |   2 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |   2 +-
 drivers/infiniband/hw/mlx4/qp.c               |   2 +-
 drivers/infiniband/hw/mlx5/main.c             |   2 +-
 drivers/infiniband/hw/qedr/qedr_iw_cm.c       |   2 +-
 drivers/infiniband/hw/qedr/verbs.c            |   2 +-
 .../infiniband/hw/vmw_pvrdma/pvrdma_verbs.c   |   2 +-
 .../infiniband/ulp/opa_vnic/opa_vnic_vema.c   |   2 +-
 drivers/input/mouse/alps.c                    |   4 +-
 drivers/input/rmi4/rmi_driver.c               |   4 +-
 drivers/input/touchscreen/wacom_i2c.c         |   2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |   4 +-
 drivers/iommu/intel/debugfs.c                 |   2 +-
 drivers/iommu/iommu.c                         |   6 +-
 drivers/md/bcache/debug.c                     |   2 +-
 drivers/md/dm-verity-target.c                 |   2 +-
 drivers/md/md-cluster.c                       |  10 +-
 drivers/media/dvb-core/dvb_frontend.c         |   2 +-
 drivers/media/dvb-frontends/as102_fe.c        |   6 +-
 drivers/media/i2c/adv7842.c                   |   2 +-
 drivers/media/i2c/ccs/ccs-data.c              |   4 +-
 drivers/media/i2c/imx290.c                    |   2 +-
 drivers/media/i2c/imx334.c                    |   4 +-
 drivers/media/i2c/imx335.c                    |   4 +-
 drivers/media/i2c/imx412.c                    |   4 +-
 drivers/media/i2c/ov5645.c                    |   2 +-
 drivers/media/i2c/ov9282.c                    |   4 +-
 drivers/media/i2c/ov9640.c                    |   2 +-
 drivers/media/pci/cobalt/cobalt-v4l2.c        |   2 +-
 .../media/platform/qcom/camss/camss-csid.c    |   2 +-
 drivers/media/platform/qcom/camss/camss-vfe.c |   8 +-
 drivers/media/platform/qcom/venus/helpers.c   |   4 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c  |   4 +-
 drivers/media/platform/qcom/venus/hfi_venus.c |   2 +-
 drivers/media/platform/qcom/venus/vdec.c      |   2 +-
 drivers/media/platform/rcar-vin/rcar-csi2.c   |   2 +-
 .../platform/sunxi/sun6i-csi/sun6i_video.c    |   2 +-
 drivers/media/platform/vsp1/vsp1_drm.c        |   2 +-
 drivers/media/radio/tea575x.c                 |   2 +-
 drivers/media/usb/em28xx/em28xx-video.c       |   2 +-
 drivers/media/usb/uvc/uvc_driver.c            |   2 +-
 drivers/media/v4l2-core/v4l2-common.c         |   2 +-
 drivers/memstick/core/mspro_block.c           |   2 +-
 drivers/mfd/rsmu_spi.c                        |   4 +-
 drivers/misc/cxl/file.c                       |   2 +-
 drivers/misc/habanalabs/common/debugfs.c      |   2 +-
 .../misc/habanalabs/common/habanalabs_ioctl.c |  30 ++---
 drivers/mmc/host/mtk-sd.c                     |  10 +-
 drivers/mmc/host/sdhci-of-aspeed.c            |   2 +-
 drivers/mmc/host/sh_mmcif.c                   |   2 +-
 .../mtd/nand/raw/cadence-nand-controller.c    |   2 +-
 drivers/net/bonding/bond_main.c               |   2 +-
 drivers/net/bonding/bond_options.c            |   2 +-
 drivers/net/can/usb/etas_es58x/es581_4.c      |   2 +-
 drivers/net/can/usb/etas_es58x/es58x_fd.c     |   2 +-
 drivers/net/dsa/b53/b53_common.c              |   2 +-
 drivers/net/dsa/hirschmann/hellcreek.c        |   8 +-
 drivers/net/dsa/lantiq_gswip.c                |  20 +--
 drivers/net/dsa/mt7530.c                      |   2 +-
 drivers/net/dsa/mv88e6xxx/global1_atu.c       |   2 +-
 drivers/net/dsa/qca8k.c                       |   2 +-
 drivers/net/dsa/sja1105/sja1105_clocking.c    |  10 +-
 .../net/dsa/sja1105/sja1105_dynamic_config.c  |   8 +-
 drivers/net/dsa/sja1105/sja1105_main.c        |  16 +--
 drivers/net/dsa/sja1105/sja1105_ptp.c         |   8 +-
 drivers/net/dsa/sja1105/sja1105_spi.c         |   2 +-
 .../net/dsa/sja1105/sja1105_static_config.c   |   4 +-
 drivers/net/dsa/sja1105/sja1105_tas.c         |   2 +-
 .../ethernet/aquantia/atlantic/aq_macsec.c    |  14 +--
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |   4 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_dcb.c   |  10 +-
 .../ethernet/broadcom/bnx2x/bnx2x_ethtool.c   |   4 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |   8 +-
 .../net/ethernet/broadcom/bnx2x/bnx2x_sriov.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c  |   2 +-
 drivers/net/ethernet/broadcom/cnic.c          |   2 +-
 .../ethernet/cavium/liquidio/lio_ethtool.c    |   2 +-
 .../net/ethernet/chelsio/cxgb4/cudbg_lib.c    |  84 ++++++-------
 .../net/ethernet/chelsio/cxgb4/cudbg_zlib.c   |   2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c  |   4 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |   4 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |   2 +-
 .../chelsio/inline_crypto/chtls/chtls_main.c  |   2 +-
 drivers/net/ethernet/emulex/benet/be_cmds.c   |  12 +-
 drivers/net/ethernet/emulex/benet/be_main.c   |  20 +--
 .../ethernet/freescale/dpaa2/dpaa2-eth-dcb.c  |   4 +-
 .../freescale/dpaa2/dpaa2-eth-devlink.c       |   2 +-
 .../net/ethernet/freescale/dpaa2/dpaa2-eth.c  |  20 +--
 .../ethernet/freescale/dpaa2/dpaa2-ethtool.c  |   6 +-
 .../freescale/dpaa2/dpaa2-switch-ethtool.c    |   4 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |  26 ++--
 drivers/net/ethernet/freescale/dpaa2/dpmac.c  |  10 +-
 drivers/net/ethernet/freescale/dpaa2/dpni.c   | 116 +++++++++---------
 drivers/net/ethernet/freescale/dpaa2/dprtc.c  |  16 +--
 drivers/net/ethernet/freescale/dpaa2/dpsw.c   | 102 +++++++--------
 drivers/net/ethernet/freescale/enetc/enetc.c  |   4 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   |   2 +-
 .../net/ethernet/huawei/hinic/hinic_devlink.c |   2 +-
 .../net/ethernet/huawei/hinic/hinic_ethtool.c |  28 ++---
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c |   2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_dev.c  |   2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c  |   2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_io.c   |   2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_mbox.c |   6 +-
 .../net/ethernet/huawei/hinic/hinic_main.c    |   4 +-
 .../net/ethernet/huawei/hinic/hinic_port.c    |  50 ++++----
 drivers/net/ethernet/huawei/hinic/hinic_rx.c  |   2 +-
 .../net/ethernet/huawei/hinic/hinic_sriov.c   |  20 +--
 drivers/net/ethernet/huawei/hinic/hinic_tx.c  |   2 +-
 drivers/net/ethernet/intel/fm10k/fm10k_iov.c  |   2 +-
 .../net/ethernet/intel/fm10k/fm10k_netdev.c   |   4 +-
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c  |   4 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  10 +-
 drivers/net/ethernet/intel/ice/ice_base.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |  12 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   8 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.c     |   2 +-
 drivers/net/ethernet/intel/ice/ice_fltr.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |   2 +-
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   6 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   2 +-
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   4 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  24 ++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  14 +--
 .../marvell/octeontx2/af/rvu_switch.c         |  20 +--
 .../marvell/prestera/prestera_flower.c        |   2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c      |   2 +-
 .../net/ethernet/mellanox/mlx4/en_dcb_nl.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx4/fw.c       |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   2 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |  10 +-
 .../ethernet/mellanox/mlx5/core/fpga/ipsec.c  |   4 +-
 .../ethernet/mellanox/mlx5/core/fpga/tls.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |   2 +-
 .../ethernet/mellanox/mlx5/core/lib/hv_vhca.c |   2 +-
 .../net/ethernet/mellanox/mlx5/core/port.c    |   2 +-
 .../mellanox/mlxsw/core_acl_flex_actions.c    |   2 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_dpipe.c  |  24 ++--
 .../ethernet/mellanox/mlxsw/spectrum_ipip.c   |   2 +-
 .../ethernet/mellanox/mlxsw/spectrum_nve.c    |   6 +-
 drivers/net/ethernet/mscc/ocelot.c            |   6 +-
 drivers/net/ethernet/mscc/ocelot_net.c        |   4 +-
 drivers/net/ethernet/mscc/ocelot_police.c     |   4 +-
 drivers/net/ethernet/mscc/ocelot_vcap.c       |   6 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c    |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c     |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_l2.c      |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_sriov.c   |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_fp.c    |   2 +-
 drivers/net/ethernet/qlogic/qede/qede_main.c  |   2 +-
 drivers/net/ethernet/sfc/ef100.c              |   2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   6 +-
 drivers/net/macsec.c                          |  10 +-
 drivers/net/tap.c                             |   2 +-
 drivers/net/tun.c                             |   4 +-
 drivers/net/wireless/admtek/adm8211.c         |   2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c      |   8 +-
 drivers/net/wireless/ath/ath10k/htt_tx.c      |   4 +-
 drivers/net/wireless/ath/ath10k/mac.c         |   8 +-
 drivers/net/wireless/ath/ath11k/ce.c          |   2 +-
 drivers/net/wireless/ath/ath11k/dbring.c      |   2 +-
 drivers/net/wireless/ath/ath11k/debugfs.c     |   4 +-
 .../wireless/ath/ath11k/debugfs_htt_stats.c   |   4 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |   2 +-
 drivers/net/wireless/ath/ath11k/dp.c          |   2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  12 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c       |   8 +-
 drivers/net/wireless/ath/ath11k/mac.c         |   8 +-
 drivers/net/wireless/ath/ath11k/spectral.c    |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.c         |  12 +-
 drivers/net/wireless/ath/ath9k/dfs_debug.c    |   2 +-
 drivers/net/wireless/ath/wil6210/pmc.c        |   4 +-
 drivers/net/wireless/atmel/at76c50x-usb.c     |   2 +-
 .../broadcom/brcm80211/brcmfmac/sdio.c        |   4 +-
 drivers/net/wireless/intel/iwlegacy/4965.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
 drivers/net/wireless/mac80211_hwsim.c         |   4 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |   2 +-
 .../wireless/realtek/rtl818x/rtl8180/dev.c    |   2 +-
 .../wireless/realtek/rtl818x/rtl8187/dev.c    |   2 +-
 drivers/net/wireless/realtek/rtlwifi/base.c   |   2 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c    |   4 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c    |   4 +-
 drivers/net/wireless/realtek/rtw88/coex.c     |  12 +-
 drivers/net/wireless/realtek/rtw88/debug.c    |   2 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |   2 +-
 drivers/net/wireless/realtek/rtw88/pci.c      |   4 +-
 drivers/net/wireless/realtek/rtw88/phy.c      |   6 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   4 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |   4 +-
 drivers/net/wireless/st/cw1200/sta.c          |   2 +-
 drivers/net/wwan/iosm/iosm_ipc_imem.c         |   2 +-
 drivers/net/wwan/iosm/iosm_ipc_imem_ops.c     |   2 +-
 drivers/net/xen-netback/netback.c             |   2 +-
 drivers/nvme/host/core.c                      |   2 +-
 drivers/nvme/target/admin-cmd.c               |   2 +-
 drivers/nvmem/rave-sp-eeprom.c                |   2 +-
 drivers/pci/msi.c                             |   2 +-
 drivers/pci/switch/switchtec.c                |   4 +-
 drivers/phy/cadence/cdns-dphy.c               |   4 +-
 .../phy/freescale/phy-fsl-imx8-mipi-dphy.c    |   4 +-
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c         |   2 +-
 drivers/pinctrl/pinctrl-zynqmp.c              |  12 +-
 drivers/platform/mellanox/mlxbf-bootctl.c     |   2 +-
 .../platform/x86/intel/int1092/intel_sar.c    |   2 +-
 .../int3472/intel_skl_int3472_tps68470.c      |   2 +-
 drivers/platform/x86/intel/pmt/class.c        |   2 +-
 drivers/platform/x86/thinkpad_acpi.c          |   2 +-
 drivers/power/supply/bq27xxx_battery.c        |   2 +-
 drivers/power/supply/cw2015_battery.c         |   2 +-
 drivers/power/supply/power_supply_core.c      |   8 +-
 drivers/regulator/bd718x7-regulator.c         |   2 +-
 drivers/regulator/bd9576-regulator.c          |   2 +-
 drivers/s390/cio/vfio_ccw_cp.c                |   2 +-
 drivers/s390/crypto/ap_bus.c                  |   2 +-
 drivers/s390/crypto/ap_queue.c                |   2 +-
 drivers/s390/net/qeth_core_main.c             |   2 +-
 drivers/s390/net/qeth_l3_main.c               |   2 +-
 drivers/s390/scsi/zfcp_qdio.c                 |   2 +-
 drivers/scsi/be2iscsi/be_main.c               |   2 +-
 drivers/scsi/bfa/bfad.c                       |   2 +-
 drivers/scsi/cxlflash/cxl_hw.c                |   2 +-
 drivers/scsi/cxlflash/main.c                  |   2 +-
 drivers/scsi/cxlflash/superpipe.c             |   4 +-
 drivers/scsi/elx/efct/efct_hw.c               |   4 +-
 drivers/scsi/elx/libefc_sli/sli4.c            |   6 +-
 drivers/scsi/lpfc/lpfc_attr.c                 |   2 +-
 drivers/scsi/lpfc/lpfc_init.c                 |   2 +-
 drivers/scsi/myrs.c                           |   2 +-
 drivers/scsi/qedf/qedf_io.c                   |   2 +-
 drivers/scsi/qla2xxx/qla_edif.c               |   2 +-
 drivers/scsi/scsi_transport_sas.c             |   2 +-
 drivers/scsi/sd.c                             |   2 +-
 drivers/scsi/sd_zbc.c                         |   2 +-
 drivers/scsi/smartpqi/smartpqi_init.c         |   2 +-
 drivers/scsi/ufs/ufshcd.c                     |  18 +--
 drivers/scsi/ufs/ufshpb.c                     |   2 +-
 drivers/scsi/vmw_pvscsi.c                     |  10 +-
 drivers/slimbus/qcom-ctrl.c                   |   2 +-
 drivers/slimbus/qcom-ngd-ctrl.c               |   8 +-
 drivers/soc/fsl/dpio/dpio.c                   |  16 +--
 drivers/soc/qcom/pdr_interface.c              |   2 +-
 drivers/soc/ti/k3-ringacc.c                   |   8 +-
 .../soundwire/generic_bandwidth_allocation.c  |   2 +-
 drivers/spi/spi-altera-dfl.c                  |   2 +-
 drivers/spi/spi-dw-dma.c                      |   2 +-
 drivers/spi/spi-tegra114.c                    |   2 +-
 drivers/spi/spi-tegra210-quad.c               |   2 +-
 drivers/staging/fbtft/fb_ssd1351.c            |   2 +-
 drivers/staging/fbtft/fb_watterott.c          |   2 +-
 drivers/staging/fbtft/fbtft-core.c            |   2 +-
 drivers/staging/greybus/sdio.c                |   2 +-
 .../staging/media/atomisp/pci/atomisp_acc.c   |   4 +-
 .../staging/media/atomisp/pci/atomisp_cmd.c   |  36 +++---
 .../media/atomisp/pci/atomisp_compat_css20.c  |   8 +-
 .../staging/media/atomisp/pci/atomisp_fops.c  |   6 +-
 .../staging/media/atomisp/pci/atomisp_ioctl.c |   6 +-
 .../media/atomisp/pci/atomisp_subdev.c        |   4 +-
 .../staging/media/atomisp/pci/sh_css_params.c |   2 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c    |   2 +-
 drivers/staging/media/ipu3/ipu3-css-pool.c    |   2 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c        |   4 +-
 .../staging/media/meson/vdec/vdec_helpers.c   |   2 +-
 drivers/staging/r8188eu/hal/HalPwrSeqCmd.c    |   2 +-
 .../bcm2835-camera/bcm2835-camera.c           |   2 +-
 drivers/staging/vt6655/dpc.c                  |   2 +-
 drivers/tee/amdtee/call.c                     |  10 +-
 drivers/thunderbolt/ctl.c                     |  12 +-
 drivers/thunderbolt/path.c                    |   2 +-
 drivers/tty/vcc.c                             |   2 +-
 drivers/usb/dwc2/drd.c                        |   2 +-
 drivers/usb/dwc3/gadget.c                     |   2 +-
 drivers/usb/gadget/udc/s3c-hsudc.c            |   2 +-
 drivers/usb/host/xhci-ext-caps.c              |   2 +-
 drivers/usb/mtu3/mtu3_dr.c                    |   2 +-
 drivers/usb/musb/mediatek.c                   |   2 +-
 drivers/vfio/pci/vfio_pci_core.c              |   2 +-
 drivers/vfio/vfio_iommu_type1.c               |   2 +-
 drivers/video/fbdev/aty/atyfb_base.c          |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c    |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c  |   2 +-
 .../video/fbdev/omap2/omapfb/dss/hdmi4_core.c |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c  |   2 +-
 .../video/fbdev/omap2/omapfb/dss/hdmi5_core.c |   2 +-
 drivers/video/fbdev/smscufx.c                 |   4 +-
 drivers/video/fbdev/tmiofb.c                  |   2 +-
 drivers/video/fbdev/udlfb.c                   |   2 +-
 drivers/virtio/virtio_vdpa.c                  |   2 +-
 drivers/xen/events/events_base.c              |   2 +-
 drivers/xen/xen-acpi-processor.c              |   2 +-
 fs/9p/acl.c                                   |   2 +-
 fs/btrfs/check-integrity.c                    |   4 +-
 fs/btrfs/extent-tree.c                        |  12 +-
 fs/btrfs/extent_io.c                          |  10 +-
 fs/btrfs/file.c                               |   8 +-
 fs/btrfs/inode.c                              |  10 +-
 fs/btrfs/ioctl.c                              |   4 +-
 fs/btrfs/reflink.c                            |   2 +-
 fs/btrfs/relocation.c                         |   6 +-
 fs/btrfs/send.c                               |   2 +-
 fs/btrfs/tree-checker.c                       |   2 +-
 fs/btrfs/tree-log.c                           |   8 +-
 fs/cifs/connect.c                             |  10 +-
 fs/cifs/file.c                                |   4 +-
 fs/cifs/inode.c                               |   8 +-
 fs/cifs/link.c                                |   8 +-
 fs/cifs/smb1ops.c                             |   2 +-
 fs/cifs/smb2ops.c                             |   4 +-
 fs/crypto/policy.c                            |   2 +-
 fs/direct-io.c                                |   4 +-
 fs/ext4/ioctl.c                               |   4 +-
 fs/f2fs/data.c                                |  12 +-
 fs/f2fs/segment.c                             |   2 +-
 fs/ioctl.c                                    |   2 +-
 fs/ksmbd/smb2pdu.c                            |   4 +-
 fs/ksmbd/vfs.c                                |   6 +-
 fs/nfs/callback_xdr.c                         |   2 +-
 fs/nfs/nfs4proc.c                             |   2 +-
 fs/ocfs2/alloc.c                              |   2 +-
 fs/ocfs2/cluster/tcp.c                        |   2 +-
 fs/orangefs/orangefs-debugfs.c                |   4 +-
 fs/ubifs/debug.c                              |   4 +-
 fs/ubifs/dir.c                                |   4 +-
 fs/ubifs/journal.c                            |   2 +-
 fs/ubifs/orphan.c                             |   2 +-
 fs/ubifs/tnc.c                                |   2 +-
 fs/ubifs/xattr.c                              |   4 +-
 fs/verity/enable.c                            |   2 +-
 fs/xfs/libxfs/xfs_da_btree.c                  |   2 +-
 fs/xfs/libxfs/xfs_ialloc.c                    |   2 +-
 fs/xfs/libxfs/xfs_log_rlimit.c                |   2 +-
 fs/xfs/libxfs/xfs_refcount.c                  |   4 +-
 fs/xfs/libxfs/xfs_rmap.c                      |   2 +-
 fs/xfs/scrub/quota.c                          |   2 +-
 fs/xfs/scrub/repair.c                         |   4 +-
 fs/xfs/xfs_file.c                             |   2 +-
 fs/xfs/xfs_fsmap.c                            |   4 +-
 fs/xfs/xfs_icache.c                           |   2 +-
 fs/xfs/xfs_inode.c                            |   2 +-
 fs/xfs/xfs_ioctl.c                            |   4 +-
 fs/xfs/xfs_trans.c                            |   2 +-
 include/linux/btf_ids.h                       |   4 +-
 include/linux/dma/ti-cppi5.h                  |   2 +-
 include/linux/icmpv6.h                        |   2 +-
 include/net/icmp.h                            |   2 +-
 include/net/sch_generic.h                     |   2 +-
 kernel/bpf/verifier.c                         |   2 +-
 kernel/events/hw_breakpoint.c                 |   2 +-
 kernel/time/timekeeping.c                     |   4 +-
 lib/kunit/test.c                              |   6 +-
 lib/vsprintf.c                                |   6 +-
 mm/damon/vaddr-test.h                         |   2 +-
 mm/damon/vaddr.c                              |   2 +-
 mm/memory-failure.c                           |   2 +-
 net/bluetooth/ecdh_helper.c                   |   2 +-
 net/bridge/br_sysfs_br.c                      |   2 +-
 net/bridge/br_sysfs_if.c                      |   2 +-
 net/ceph/auth_x.c                             |   2 +-
 net/core/drop_monitor.c                       |   2 +-
 net/core/gen_stats.c                          |   4 +-
 net/dsa/port.c                                |   4 +-
 net/dsa/slave.c                               |   2 +-
 net/dsa/switch.c                              |   2 +-
 net/dsa/tag_sja1105.c                         |   2 +-
 net/ethtool/eeprom.c                          |   6 +-
 net/ipv4/devinet.c                            |   2 +-
 net/ipv4/fib_trie.c                           |   2 +-
 net/ipv4/icmp.c                               |   2 +-
 net/ipv4/netfilter/arp_tables.c               |   4 +-
 net/ipv4/netfilter/ip_tables.c                |   4 +-
 net/ipv4/tcp.c                                |  10 +-
 net/ipv6/ip6_icmp.c                           |   2 +-
 net/ipv6/netfilter/ip6_tables.c               |   4 +-
 net/iucv/af_iucv.c                            |   2 +-
 net/l2tp/l2tp_core.c                          |   4 +-
 net/l2tp/l2tp_netlink.c                       |   4 +-
 net/l2tp/l2tp_ppp.c                           |   2 +-
 net/mac80211/main.c                           |   2 +-
 net/mac80211/util.c                           |   2 +-
 net/mptcp/pm_netlink.c                        |   2 +-
 net/netfilter/ipset/ip_set_hash_ip.c          |   4 +-
 net/netfilter/xt_l2tp.c                       |   4 +-
 net/netfilter/xt_rateest.c                    |   2 +-
 net/openvswitch/actions.c                     |   2 +-
 net/packet/af_packet.c                        |   4 +-
 net/rds/ib_stats.c                            |   2 +-
 net/rds/stats.c                               |   2 +-
 net/rds/tcp_stats.c                           |   2 +-
 net/rxrpc/input.c                             |   6 +-
 net/rxrpc/local_object.c                      |   2 +-
 net/sched/cls_api.c                           |   2 +-
 net/sched/sch_cake.c                          |   2 +-
 net/sched/sch_fq_codel.c                      |   2 +-
 net/sched/sch_frag.c                          |   2 +-
 net/sched/sch_mqprio.c                        |   6 +-
 net/sched/sch_netem.c                         |   2 +-
 net/sched/sch_red.c                           |   2 +-
 net/sched/sch_sfq.c                           |   4 +-
 net/sched/sch_taprio.c                        |   2 +-
 net/sctp/protocol.c                           |   2 +-
 net/sunrpc/xprtsock.c                         |   2 +-
 net/tipc/socket.c                             |   2 +-
 net/tipc/udp_media.c                          |  10 +-
 samples/acrn/vm-sample.c                      |   4 +-
 samples/binderfs/binderfs_example.c           |   2 +-
 samples/bpf/cookie_uid_helper_example.c       |   4 +-
 samples/bpf/hbm.c                             |   2 +-
 samples/bpf/xdp_rxq_info_user.c               |   2 +-
 security/apparmor/policy_unpack.c             |   2 +-
 security/selinux/hooks.c                      |  22 ++--
 sound/core/compress_offload.c                 |   2 +-
 sound/firewire/amdtp-stream.c                 |   6 +-
 sound/firewire/fireworks/fireworks_command.c  |   6 +-
 sound/pci/asihpi/hpioctl.c                    |   2 +-
 sound/pci/ca0106/ca0106_mixer.c               |   2 +-
 sound/pci/ctxfi/ctatc.c                       |  30 ++---
 sound/pci/ctxfi/ctdaio.c                      |   2 +-
 sound/pci/ctxfi/cthw20k1.c                    |   8 +-
 sound/pci/ctxfi/cthw20k2.c                    |  10 +-
 sound/pci/ctxfi/ctmixer.c                     |   4 +-
 sound/pci/ice1712/juli.c                      |   2 +-
 sound/pci/ice1712/quartet.c                   |   2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |   4 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c  |   4 +-
 sound/soc/intel/skylake/cnl-sst.c             |   2 +-
 sound/soc/intel/skylake/skl-messages.c        |   8 +-
 sound/soc/intel/skylake/skl-pcm.c             |   6 +-
 sound/soc/intel/skylake/skl-sst-ipc.c         |  48 ++++----
 sound/soc/intel/skylake/skl-topology.c        |   2 +-
 sound/soc/qcom/qdsp6/q6afe.c                  |   8 +-
 sound/soc/sof/intel/hda-dai.c                 |   2 +-
 sound/usb/mixer_s1810c.c                      |   2 +-
 tools/bpf/bpftool/prog.c                      |   4 +-
 tools/include/linux/btf_ids.h                 |   4 +-
 tools/lib/bpf/libbpf.c                        |   2 +-
 tools/objtool/orc_gen.c                       |   2 +-
 tools/perf/util/arm-spe.c                     |   2 +-
 tools/perf/util/bpf_counter.c                 |   2 +-
 .../x86/intel-speed-select/isst-config.c      |   2 +-
 .../selftests/bpf/prog_tests/perf_branches.c  |   4 +-
 .../selftests/bpf/prog_tests/sk_lookup.c      |  12 +-
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |   2 +-
 .../selftests/bpf/prog_tests/sockmap_listen.c |   4 +-
 .../selftests/bpf/progs/test_sk_assign.c      |   6 +-
 .../selftests/bpf/progs/test_xdp_vlan.c       |   8 +-
 tools/testing/selftests/bpf/test_sockmap.c    |   6 +-
 .../selftests/bpf/test_tcpnotify_user.c       |   2 +-
 tools/testing/selftests/bpf/xdping.c          |   4 +-
 .../selftests/cgroup/test_memcontrol.c        |   2 +-
 .../filesystems/binderfs/binderfs_test.c      |   2 +-
 .../filesystems/epoll/epoll_wakeup_test.c     |  82 ++++++-------
 .../selftests/kvm/demand_paging_test.c        |   2 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |   2 +-
 .../selftests/kvm/x86_64/hyperv_clock.c       |   2 +-
 .../selftests/kvm/x86_64/hyperv_features.c    |   2 +-
 .../selftests/kvm/x86_64/kvm_pv_test.c        |   4 +-
 tools/testing/selftests/net/ip_defrag.c       |   4 +-
 tools/testing/selftests/net/ipv6_flowlabel.c  |   8 +-
 tools/testing/selftests/net/msg_zerocopy.c    |   2 +-
 tools/testing/selftests/net/psock_fanout.c    |   2 +-
 tools/testing/selftests/net/psock_snd.c       |   6 +-
 .../selftests/net/reuseport_addr_any.c        |  12 +-
 tools/testing/selftests/net/so_txtime.c       |  10 +-
 .../selftests/net/tcp_fastopen_backup_key.c   |  12 +-
 tools/testing/selftests/net/toeplitz.c        |   4 +-
 tools/testing/selftests/net/udpgso.c          |   8 +-
 tools/testing/selftests/net/udpgso_bench_rx.c |   4 +-
 tools/testing/selftests/net/udpgso_bench_tx.c |  10 +-
 .../selftests/pidfd/pidfd_fdinfo_test.c       |   4 +-
 .../selftests/uevent/uevent_filtering.c       |   2 +-
 tools/testing/selftests/vm/gup_test.c         |   2 +-
 tools/testing/selftests/vm/userfaultfd.c      |   6 +-
 tools/testing/vsock/vsock_test.c              |   8 +-
 745 files changed, 1885 insertions(+), 1885 deletions(-)

diff --git a/arch/alpha/kernel/err_marvel.c b/arch/alpha/kernel/err_marvel.c
index c0c0ccefc467..be1daa1a8fa1 100644
--- a/arch/alpha/kernel/err_marvel.c
+++ b/arch/alpha/kernel/err_marvel.c
@@ -1049,7 +1049,7 @@ marvel_machine_check(unsigned long vector, unsigned long la_ptr)
 	struct el_subpacket *el_ptr = (struct el_subpacket *)la_ptr;
 	int (*process_frame)(struct ev7_lf_subpackets *, int) = NULL;
 	struct ev7_lf_subpackets subpacket_collection = { NULL, };
-	struct ev7_pal_io_subpacket scratch_io_packet = { 0, };
+	struct ev7_pal_io_subpacket scratch_io_packet = { };
 	struct ev7_lf_subpackets *lf_subpackets = NULL;
 	int disposition = MCHK_DISPOSITION_UNKNOWN_ERROR;
 	char *saved_err_prefix = err_print_prefix;
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 8bbeebb73cf0..9dd27ad40776 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -276,7 +276,7 @@ struct osf_statfs64 {
 static int
 linux_to_osf_stat(struct kstat *lstat, struct osf_stat __user *osf_stat)
 {
-	struct osf_stat tmp = { 0 };
+	struct osf_stat tmp = { };
 
 	tmp.st_dev	= lstat->dev;
 	tmp.st_mode	= lstat->mode;
@@ -324,7 +324,7 @@ static int
 linux_to_osf_statfs64(struct kstatfs *linux_stat, struct osf_statfs64 __user *osf_stat,
 		      unsigned long bufsiz)
 {
-	struct osf_statfs64 tmp_stat = { 0 };
+	struct osf_statfs64 tmp_stat = { };
 
 	tmp_stat.f_type = linux_stat->f_type;
 	tmp_stat.f_fsize = linux_stat->f_frsize;
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 3c1d12dc8ff3..5023d58acf6c 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -83,7 +83,7 @@ int __init omap2_clk_setup_ll_ops(void)
  */
 void __init ti_clk_init_features(void)
 {
-	struct ti_clk_features features = { 0 };
+	struct ti_clk_features features = { };
 	/* Fint setup for DPLLs */
 	if (cpu_is_omap3430()) {
 		features.fint_min = OMAP3430_DPLL_FINT_BAND1_MIN;
diff --git a/arch/arm/mach-s3c/mach-mini2440.c b/arch/arm/mach-s3c/mach-mini2440.c
index 551ec660ab59..2deec8d14ace 100644
--- a/arch/arm/mach-s3c/mach-mini2440.c
+++ b/arch/arm/mach-s3c/mach-mini2440.c
@@ -704,7 +704,7 @@ static void __init mini2440_parse_features(
 
 static void __init mini2440_init(void)
 {
-	struct mini2440_features_t features = { 0 };
+	struct mini2440_features_t features = { };
 	int i;
 
 	pr_info("MINI2440: Option string mini2440=%s\n",
diff --git a/arch/arm/mach-s3c/mach-mini6410.c b/arch/arm/mach-s3c/mach-mini6410.c
index 741fa1f09694..4d21f76fc99e 100644
--- a/arch/arm/mach-s3c/mach-mini6410.c
+++ b/arch/arm/mach-s3c/mach-mini6410.c
@@ -311,7 +311,7 @@ static void mini6410_parse_features(
 static void __init mini6410_machine_init(void)
 {
 	u32 cs1;
-	struct mini6410_features_t features = { 0 };
+	struct mini6410_features_t features = { };
 
 	printk(KERN_INFO "MINI6410: Option string mini6410=%s\n",
 			mini6410_features_str);
diff --git a/arch/arm/mach-s3c/mach-real6410.c b/arch/arm/mach-s3c/mach-real6410.c
index 9d218a53d631..750bb76f38b0 100644
--- a/arch/arm/mach-s3c/mach-real6410.c
+++ b/arch/arm/mach-s3c/mach-real6410.c
@@ -281,7 +281,7 @@ static void real6410_parse_features(
 static void __init real6410_machine_init(void)
 {
 	u32 cs1;
-	struct real6410_features_t features = { 0 };
+	struct real6410_features_t features = { };
 
 	printk(KERN_INFO "REAL6410: Option string real6410=%s\n",
 			real6410_features_str);
diff --git a/arch/arm/mach-sunxi/mc_smp.c b/arch/arm/mach-sunxi/mc_smp.c
index 26cbce135338..8b2c99cdb539 100644
--- a/arch/arm/mach-sunxi/mc_smp.c
+++ b/arch/arm/mach-sunxi/mc_smp.c
@@ -779,7 +779,7 @@ static const struct sunxi_mc_smp_data sunxi_mc_smp_data[] __initconst = {
 
 static int __init sunxi_mc_smp_init(void)
 {
-	struct sunxi_mc_smp_nodes nodes = { 0 };
+	struct sunxi_mc_smp_nodes nodes = { };
 	struct device_node *node;
 	struct resource res;
 	void __iomem *addr;
diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 0216ff24c392..c6c90048374a 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -265,7 +265,7 @@ int __microMIPS_compute_return_epc(struct pt_regs *regs)
 	u16 halfword;
 	unsigned int word;
 	unsigned long contpc;
-	struct mm_decoded_insn mminsn = { 0 };
+	struct mm_decoded_insn mminsn = { };
 
 	mminsn.micro_mips_mode = 1;
 
diff --git a/arch/parisc/kernel/inventory.c b/arch/parisc/kernel/inventory.c
index 7ab2f2a54400..a1f2c3fc15ee 100644
--- a/arch/parisc/kernel/inventory.c
+++ b/arch/parisc/kernel/inventory.c
@@ -645,7 +645,7 @@ void __init do_device_inventory(void)
 
 #if defined(CONFIG_FW_CFG_SYSFS)
 	if (running_on_qemu) {
-		struct resource res[3] = {0,};
+		struct resource res[3] = {};
 		unsigned int base;
 
 		base = ((unsigned long long) PAGE0->pad0[2] << 32)
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index abebfbee5b1c..d4483d7c0e9d 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -93,7 +93,7 @@ extern void ptrace_triggered(struct perf_event *bp,
 static inline void hw_breakpoint_disable(void)
 {
 	int i;
-	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint null_brk = {};
 
 	if (!ppc_breakpoint_available())
 		return;
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index 64e423d2fe0f..c3f12856381d 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -51,7 +51,7 @@ int set_dawr(int nr, struct arch_hw_breakpoint *brk)
 
 static void disable_dawrs_cb(void *info)
 {
-	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint null_brk = {};
 	int i;
 
 	for (i = 0; i < nr_wp_slots(); i++)
@@ -62,7 +62,7 @@ static ssize_t dawr_write_file_bool(struct file *file,
 				    const char __user *user_buf,
 				    size_t count, loff_t *ppos)
 {
-	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint null_brk = {};
 	size_t rc;
 
 	/* Send error to user if they hypervisor won't allow us to write DAWR */
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 91a3be14808b..29aa96b7f80e 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -100,7 +100,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
  */
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint null_brk = {};
 	struct perf_event **slot;
 	int i;
 
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index c2f55fe7092d..4ee302d5b58f 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -698,7 +698,7 @@ static long mce_handle_error(struct pt_regs *regs,
 		const struct mce_derror_table dtable[],
 		const struct mce_ierror_table itable[])
 {
-	struct mce_error_info mce_err = { 0 };
+	struct mce_error_info mce_err = { };
 	uint64_t addr, phys_addr = ULONG_MAX;
 	long handled;
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 50436b52c213..814845de5385 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -626,7 +626,7 @@ void do_send_trap(struct pt_regs *regs, unsigned long address,
 
 static void do_break_handler(struct pt_regs *regs)
 {
-	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint null_brk = {};
 	struct arch_hw_breakpoint *info;
 	struct ppc_inst instr = ppc_inst(0);
 	int type = 0;
@@ -770,7 +770,7 @@ static void set_breakpoint(int i, struct arch_hw_breakpoint *brk)
 static void set_debug_reg_defaults(struct thread_struct *thread)
 {
 	int i;
-	struct arch_hw_breakpoint null_brk = {0};
+	struct arch_hw_breakpoint null_brk = {};
 
 	for (i = 0; i < nr_wp_slots(); i++) {
 		thread->hw_brk[i] = null_brk;
diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3s_hv_nested.c
index ed8a2c9f5629..d6d97dbae89c 100644
--- a/arch/powerpc/kvm/book3s_hv_nested.c
+++ b/arch/powerpc/kvm/book3s_hv_nested.c
@@ -291,7 +291,7 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
 	long int err, r;
 	struct kvm_nested_guest *l2;
 	struct pt_regs l2_regs, saved_l1_regs;
-	struct hv_guest_state l2_hv = {0}, saved_l1_hv;
+	struct hv_guest_state l2_hv = {}, saved_l1_hv;
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 	u64 hv_ptr, regs_ptr;
 	u64 hdec_exp, lpcr;
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 6bc9425acb32..d66e922a63ea 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -687,7 +687,7 @@ static int kvmppc_handle_pagefault(struct kvm_vcpu *vcpu,
 	int r = RESUME_GUEST;
 	int relocated;
 	int page_found = 0;
-	struct kvmppc_pte pte = { 0 };
+	struct kvmppc_pte pte = { };
 	bool dr = (kvmppc_get_msr(vcpu) & MSR_DR) ? true : false;
 	bool ir = (kvmppc_get_msr(vcpu) & MSR_IR) ? true : false;
 	u64 vsid;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 56092dccfdb8..161bbd2e5dcf 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -556,7 +556,7 @@ static int mce_handle_err_virtmode(struct pt_regs *regs,
 				   struct pseries_mc_errorlog *mce_log,
 				   int disposition)
 {
-	struct mce_error_info mce_err = { 0 };
+	struct mce_error_info mce_err = { };
 	int initiator = rtas_error_initiator(errp);
 	int severity = rtas_error_severity(errp);
 	unsigned long eaddr = 0, paddr = 0;
diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machine_kexec.c
index e6eca271a4d6..1742774a6b8a 100644
--- a/arch/riscv/kernel/machine_kexec.c
+++ b/arch/riscv/kernel/machine_kexec.c
@@ -53,7 +53,7 @@ int
 machine_kexec_prepare(struct kimage *image)
 {
 	struct kimage_arch *internal = &image->arch;
-	struct fdt_header fdt = {0};
+	struct fdt_header fdt = {};
 	void *control_code_buffer = NULL;
 	unsigned int control_code_buffer_sz = 0;
 	int i = 0;
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 7402a417f38e..219f55fb2e03 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -215,7 +215,7 @@ static int __sbi_send_ipi_v02(const unsigned long *hart_mask)
 {
 	unsigned long hartid, hmask_val, hbase;
 	struct cpumask tmask;
-	struct sbiret ret = {0};
+	struct sbiret ret = {};
 	int result;
 
 	if (!hart_mask || !(*hart_mask)) {
@@ -260,7 +260,7 @@ static int __sbi_rfence_v02_call(unsigned long fid, unsigned long hmask_val,
 				 unsigned long size, unsigned long arg4,
 				 unsigned long arg5)
 {
-	struct sbiret ret = {0};
+	struct sbiret ret = {};
 	int ext = SBI_EXT_RFENCE;
 	int result = 0;
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index f9e4baa64b67..a4cdc08433cc 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -216,7 +216,7 @@ void *kexec_file_add_components(struct kimage *image,
 				int (*add_kernel)(struct kimage *image,
 						  struct s390_load_data *data))
 {
-	struct s390_load_data data = {0};
+	struct s390_load_data data = {};
 	int ret;
 
 	data.report = ipl_report_init(&ipl_block);
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 16256e17a544..c69eb3a0105e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -81,7 +81,7 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 		struct esca_block *sca = vcpu->kvm->arch.sca;
 		union esca_sigp_ctrl *sigp_ctrl =
 			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-		union esca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
+		union esca_sigp_ctrl new_val = {}, old_val = *sigp_ctrl;
 
 		new_val.scn = src_id;
 		new_val.c = 1;
@@ -93,7 +93,7 @@ static int sca_inject_ext_call(struct kvm_vcpu *vcpu, int src_id)
 		struct bsca_block *sca = vcpu->kvm->arch.sca;
 		union bsca_sigp_ctrl *sigp_ctrl =
 			&(sca->cpu[vcpu->vcpu_id].sigp_ctrl);
-		union bsca_sigp_ctrl new_val = {0}, old_val = *sigp_ctrl;
+		union bsca_sigp_ctrl new_val = {}, old_val = *sigp_ctrl;
 
 		new_val.scn = src_id;
 		new_val.c = 1;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 752a0ffab9bf..413e7944db26 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1151,7 +1151,7 @@ static int kvm_s390_set_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 
 static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	struct kvm_s390_vm_tod_clock gtod = { 0 };
+	struct kvm_s390_vm_tod_clock gtod = { };
 
 	if (copy_from_user(&gtod.tod, (void __user *)attr->addr,
 			   sizeof(gtod.tod)))
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 53da4ceb16a3..3026b6575f91 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -84,7 +84,7 @@ int kvm_s390_handle_e3(struct kvm_vcpu *vcpu)
 /* Handle SCK (SET CLOCK) interception */
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
-	struct kvm_s390_vm_tod_clock gtod = { 0 };
+	struct kvm_s390_vm_tod_clock gtod = { };
 	int rc;
 	u8 ar;
 	u64 op2;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index e7e6788d75a8..8f041f45177c 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -112,7 +112,7 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 		       u64 base, u64 limit, u64 iota)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, dmaas, ZPCI_MOD_FC_REG_IOAT);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 cc, status;
 
 	WARN_ON_ONCE(iota & 0x3fff);
@@ -129,7 +129,7 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, dmaas, ZPCI_MOD_FC_DEREG_IOAT);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 cc, status;
 
 	cc = zpci_mod_fc(req, &fib, &status);
@@ -142,7 +142,7 @@ int zpci_unregister_ioat(struct zpci_dev *zdev, u8 dmaas)
 int zpci_fmb_enable_device(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 cc, status;
 
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
@@ -171,7 +171,7 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 int zpci_fmb_disable_device(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 cc, status;
 
 	if (!zdev->fmb)
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 3823e159bf74..dd5c02bcefe8 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -39,7 +39,7 @@ static struct airq_iv **zpci_ibv;
 static int zpci_set_airq(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_REG_INT);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 status;
 
 	fib.fmt0.isc = PCI_ISC;
@@ -57,7 +57,7 @@ static int zpci_set_airq(struct zpci_dev *zdev)
 static int zpci_clear_airq(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_DEREG_INT);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 cc, status;
 
 	cc = zpci_mod_fc(req, &fib, &status);
@@ -72,7 +72,7 @@ static int zpci_clear_airq(struct zpci_dev *zdev)
 static int zpci_set_directed_irq(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_REG_INT_D);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 status;
 
 	fib.fmt = 1;
@@ -86,7 +86,7 @@ static int zpci_set_directed_irq(struct zpci_dev *zdev)
 static int zpci_clear_directed_irq(struct zpci_dev *zdev)
 {
 	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_DEREG_INT_D);
-	struct zpci_fib fib = {0};
+	struct zpci_fib fib = {};
 	u8 cc, status;
 
 	fib.fmt = 1;
diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index a1bc02b29c81..3977081a8498 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -317,7 +317,7 @@ static void print_opcode_table_offsets(struct gen_opcode *desc)
 
 int main(int argc, char **argv)
 {
-	struct gen_opcode _desc = { 0 };
+	struct gen_opcode _desc = { };
 	struct gen_opcode *desc = &_desc;
 
 	read_instructions(desc);
diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 22b148e5a5f8..903d468005f3 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -118,7 +118,7 @@ void cpu_panic(void)
 	panic("SMP bolixed\n");
 }
 
-struct linux_prom_registers smp_penguin_ctable = { 0 };
+struct linux_prom_registers smp_penguin_ctable = { };
 
 void smp_send_reschedule(int cpu)
 {
diff --git a/arch/um/drivers/random.c b/arch/um/drivers/random.c
index 433a3f8f2ef3..a003d2a9d461 100644
--- a/arch/um/drivers/random.c
+++ b/arch/um/drivers/random.c
@@ -28,7 +28,7 @@
  * protects against a module being loaded twice at the same time.
  */
 static int random_fd = -1;
-static struct hwrng hwrng = { 0, };
+static struct hwrng hwrng = { };
 static DECLARE_COMPLETION(have_data);
 
 static int rng_dev_read(struct hwrng *rng, void *buf, size_t max, bool block)
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 708a2712a516..497a81fa13c3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -44,7 +44,7 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 
 static int hv_cpu_init(unsigned int cpu)
 {
-	union hv_vp_assist_msr_contents msr = { 0 };
+	union hv_vp_assist_msr_contents msr = { };
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	int ret;
 
@@ -181,7 +181,7 @@ static int hv_cpu_die(unsigned int cpu)
 	hv_common_cpu_die(cpu);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
-		union hv_vp_assist_msr_contents msr = { 0 };
+		union hv_vp_assist_msr_contents msr = { };
 		if (hv_root_partition) {
 			/*
 			 * For root partition the VP assist page is mapped to
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index f5a48e66e4f5..e606c5fd20df 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1681,7 +1681,7 @@ static __init int uv_system_init_hubless(void)
 
 static void __init uv_system_init_hub(void)
 {
-	struct uv_hub_info_s hub_info = {0};
+	struct uv_hub_info_s hub_info = {};
 	int bytes, cpu, nodeid;
 	unsigned short min_pnode = 9999, max_pnode = 0;
 	char *hub = is_uv5_hub() ? "UV500" :
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 3d4a48336084..c2167ff9d1d6 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -417,7 +417,7 @@ static int __apply_microcode_amd(struct microcode_amd *mc)
 static bool
 apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_patch)
 {
-	struct cont_desc desc = { 0 };
+	struct cont_desc desc = { };
 	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
 	u32 rev, dummy, *new_rev;
@@ -542,7 +542,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size);
 
 int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 {
-	struct cont_desc desc = { 0 };
+	struct cont_desc desc = { };
 	enum ucode_state ret;
 	struct cpio_data cp;
 
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 7e8e07bddd5f..b9094f62ece6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -346,7 +346,7 @@ static int collect_cpu_info_early(struct ucode_cpu_info *uci)
 {
 	unsigned int val[2];
 	unsigned int family, model;
-	struct cpu_signature csig = { 0 };
+	struct cpu_signature csig = { };
 	unsigned int eax, ebx, ecx, edx;
 
 	memset(uci, 0, sizeof(*uci));
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index db813f819ad6..c6d7bf2af00f 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1051,7 +1051,7 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 static int measure_l2_residency(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
-	struct residency_counts counts = {0};
+	struct residency_counts counts = {};
 
 	/*
 	 * Non-architectural event for the Goldmont Microarchitecture
@@ -1089,7 +1089,7 @@ static int measure_l2_residency(void *_plr)
 static int measure_l3_residency(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
-	struct residency_counts counts = {0};
+	struct residency_counts counts = {};
 
 	/*
 	 * On Broadwell Microarchitecture the MEM_LOAD_UOPS_RETIRED event
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ea4fe192189d..664c5bf46181 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -187,7 +187,7 @@ static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
-	struct stack_info stack_info = {0};
+	struct stack_info stack_info = {};
 	unsigned long visit_mask = 0;
 	int graph_idx = 0;
 	bool partial = false;
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8def1b7f8fb..b4bd8dc9b773 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1052,7 +1052,7 @@ void copy_xstate_to_uabi_buf(struct membuf to, struct task_struct *tsk,
 			membuf_zero(&to, xstate_offsets[i] - zerofrom);
 
 		if (i == XFEATURE_PKRU) {
-			struct pkru_state pkru = {0};
+			struct pkru_state pkru = {};
 			/*
 			 * PKRU is not necessarily up to date in the
 			 * thread's XSAVE buffer.  Fill this part from the
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index d7c44b257f7f..ad84d12cc15f 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -33,7 +33,7 @@ static void unwind_dump(struct unwind_state *state)
 	static bool dumped_before = false;
 	bool prev_zero, zero = false;
 	unsigned long word, *sp;
-	struct stack_info stack_info = {0};
+	struct stack_info stack_info = {};
 	unsigned long visit_mask = 0;
 
 	if (dumped_before)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 76fb00921203..ee367e4392c8 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -628,7 +628,7 @@ int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 		    unsigned long icr, int op_64_bit)
 {
 	struct kvm_apic_map *map;
-	struct kvm_lapic_irq irq = {0};
+	struct kvm_lapic_irq irq = {};
 	int cluster_size = op_64_bit ? 64 : 32;
 	int count;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 2d7e61122af8..40706f8567fe 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4664,7 +4664,7 @@ static void paging32_init_context(struct kvm_mmu *context)
 static union kvm_mmu_extended_role kvm_calc_mmu_role_ext(struct kvm_vcpu *vcpu,
 							 struct kvm_mmu_role_regs *regs)
 {
-	union kvm_mmu_extended_role ext = {0};
+	union kvm_mmu_extended_role ext = {};
 
 	if (____is_cr0_pg(regs)) {
 		ext.cr0_pg = 1;
@@ -4687,7 +4687,7 @@ static union kvm_mmu_role kvm_calc_mmu_role_common(struct kvm_vcpu *vcpu,
 						   struct kvm_mmu_role_regs *regs,
 						   bool base_only)
 {
-	union kvm_mmu_role role = {0};
+	union kvm_mmu_role role = {};
 
 	role.base.access = ACC_ALL;
 	if (____is_cr0_pg(regs)) {
@@ -4865,7 +4865,7 @@ static union kvm_mmu_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 				   bool execonly, u8 level)
 {
-	union kvm_mmu_role role = {0};
+	union kvm_mmu_role role = {};
 
 	/* SMM flag is inherited from root_mmu */
 	role.base.smm = vcpu->arch.root_mmu.mmu_role.base.smm;
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index b15ebfe40a73..6ea8cc0c43ad 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -244,7 +244,7 @@ EXPORT_SYMBOL_GPL(efi_query_variable_store);
  */
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
 {
-	struct efi_memory_map_data data = { 0 };
+	struct efi_memory_map_data data = { };
 	struct efi_mem_range mr;
 	efi_memory_desc_t md;
 	int num_entries;
@@ -397,7 +397,7 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
 
 void __init efi_free_boot_services(void)
 {
-	struct efi_memory_map_data data = { 0 };
+	struct efi_memory_map_data data = { };
 	efi_memory_desc_t *md;
 	int num_entries = 0;
 	void *new, *new_md;
diff --git a/arch/x86/xen/pmu.c b/arch/x86/xen/pmu.c
index e13b0b49fcdf..93efd0e3694f 100644
--- a/arch/x86/xen/pmu.c
+++ b/arch/x86/xen/pmu.c
@@ -485,7 +485,7 @@ static void xen_convert_regs(const struct xen_pmu_regs *xen_regs,
 irqreturn_t xen_pmu_irq_handler(int irq, void *dev_id)
 {
 	int err, ret = IRQ_NONE;
-	struct pt_regs regs = {0};
+	struct pt_regs regs = {};
 	const struct xen_pmu_data *xenpmu_data = get_xenpmu_data();
 	uint8_t xenpmu_flags = get_xenpmu_flags();
 
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index bb3f4797d212..0e84a509b458 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -71,7 +71,7 @@ static int gpr_set(struct task_struct *target,
 		   const void *kbuf, const void __user *ubuf)
 {
 	int ret;
-	struct user_pt_regs newregs = {0};
+	struct user_pt_regs newregs = {};
 	struct pt_regs *regs;
 	const u32 ps_mask = PS_CALLINC_MASK | PS_OWB_MASK;
 
diff --git a/crypto/jitterentropy.c b/crypto/jitterentropy.c
index a11b3208760f..948c883b52c2 100644
--- a/crypto/jitterentropy.c
+++ b/crypto/jitterentropy.c
@@ -704,7 +704,7 @@ int jent_entropy_init(void)
 	int time_backwards = 0;
 	int count_mod = 0;
 	int count_stuck = 0;
-	struct rand_data ec = { 0 };
+	struct rand_data ec = { };
 
 	/* Required for RCT */
 	ec.osr = 1;
diff --git a/crypto/rsa.c b/crypto/rsa.c
index 4cdbec95d077..baf0718e9732 100644
--- a/crypto/rsa.c
+++ b/crypto/rsa.c
@@ -157,7 +157,7 @@ static int rsa_set_pub_key(struct crypto_akcipher *tfm, const void *key,
 			   unsigned int keylen)
 {
 	struct rsa_mpi_key *mpi_key = akcipher_tfm_ctx(tfm);
-	struct rsa_key raw_key = {0};
+	struct rsa_key raw_key = {};
 	int ret;
 
 	/* Free the old MPI key if any */
@@ -191,7 +191,7 @@ static int rsa_set_priv_key(struct crypto_akcipher *tfm, const void *key,
 			    unsigned int keylen)
 {
 	struct rsa_mpi_key *mpi_key = akcipher_tfm_ctx(tfm);
-	struct rsa_key raw_key = {0};
+	struct rsa_key raw_key = {};
 	int ret;
 
 	/* Free the old MPI key if any */
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 70f69f0910c9..3678dd5b5213 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -1645,7 +1645,7 @@ static int test_hash_vs_generic_impl(const char *generic_driver,
 	struct crypto_shash *generic_tfm = NULL;
 	struct shash_desc *generic_desc = NULL;
 	unsigned int i;
-	struct hash_testvec vec = { 0 };
+	struct hash_testvec vec = { };
 	char vec_name[64];
 	struct testvec_config *cfg;
 	char cfgname[TESTVEC_CONFIG_NAMELEN];
@@ -2963,7 +2963,7 @@ static int test_skcipher_vs_generic_impl(const char *generic_driver,
 	struct crypto_skcipher *generic_tfm = NULL;
 	struct skcipher_request *generic_req = NULL;
 	unsigned int i;
-	struct cipher_testvec vec = { 0 };
+	struct cipher_testvec vec = { };
 	char vec_name[64];
 	struct testvec_config *cfg;
 	char cfgname[TESTVEC_CONFIG_NAMELEN];
diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 6737b1cbf6d6..1a2950e93804 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -216,7 +216,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object = { };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
@@ -621,7 +621,7 @@ static acpi_status __init acpi_processor_ids_walk(acpi_handle handle,
 	acpi_status status;
 	acpi_object_type acpi_type;
 	unsigned long long uid;
-	union acpi_object object = { 0 };
+	union acpi_object object = { };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 
 	status = acpi_get_type(handle, &acpi_type);
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index a4d4eebba1da..d3134ef2d557 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -155,7 +155,7 @@ static ssize_t show_feedback_ctrs(struct kobject *kobj,
 		struct kobj_attribute *attr, char *buf)
 {
 	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
-	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_perf_fb_ctrs fb_ctrs = {};
 	int ret;
 
 	ret = cppc_get_perf_ctrs(cpc_ptr->cpu_id, &fb_ctrs);
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a3ef6cce644c..c5b16b78aaca 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1792,7 +1792,7 @@ static bool acpi_nvdimm_has_method(struct acpi_device *adev, char *method)
 __weak void nfit_intel_shutdown_status(struct nfit_mem *nfit_mem)
 {
 	struct device *dev = &nfit_mem->adev->dev;
-	struct nd_intel_smart smart = { 0 };
+	struct nd_intel_smart smart = { };
 	union acpi_object in_buf = {
 		.buffer.type = ACPI_TYPE_BUFFER,
 		.buffer.length = 0,
diff --git a/drivers/acpi/processor_pdc.c b/drivers/acpi/processor_pdc.c
index 8c3f82c9fff3..bd0ff19597bd 100644
--- a/drivers/acpi/processor_pdc.c
+++ b/drivers/acpi/processor_pdc.c
@@ -23,7 +23,7 @@ static bool __init processor_physically_present(acpi_handle handle)
 	acpi_status status;
 	acpi_object_type acpi_type;
 	unsigned long long tmp;
-	union acpi_object object = { 0 };
+	union acpi_object object = { };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 
 	status = acpi_get_type(handle, &acpi_type);
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index 757a98f6d7a2..7f9cdeb89889 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -192,7 +192,7 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *pct = NULL;
-	union acpi_object obj = { 0 };
+	union acpi_object obj = { };
 
 	status = acpi_evaluate_object(pr->handle, "_PCT", NULL, &buffer);
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/base/property.c b/drivers/base/property.c
index 453918eb7390..c36b27bebb9a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1190,7 +1190,7 @@ fwnode_graph_get_endpoint_by_id(const struct fwnode_handle *fwnode,
 	bool enabled_only = !(flags & FWNODE_GRAPH_DEVICE_DISABLED);
 
 	while ((ep = fwnode_graph_get_next_endpoint(fwnode, ep))) {
-		struct fwnode_endpoint fwnode_ep = { 0 };
+		struct fwnode_endpoint fwnode_ep = { };
 		int ret;
 
 		if (enabled_only) {
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index e65c9d706f6f..2aaac6f9bfab 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4177,7 +4177,7 @@ static void maybe_kick_acquire(struct rbd_device *rbd_dev)
 static void rbd_handle_acquired_lock(struct rbd_device *rbd_dev, u8 struct_v,
 				     void **p)
 {
-	struct rbd_client_id cid = { 0 };
+	struct rbd_client_id cid = { };
 
 	if (struct_v >= 2) {
 		cid.gid = ceph_decode_64(p);
@@ -4206,7 +4206,7 @@ static void rbd_handle_acquired_lock(struct rbd_device *rbd_dev, u8 struct_v,
 static void rbd_handle_released_lock(struct rbd_device *rbd_dev, u8 struct_v,
 				     void **p)
 {
-	struct rbd_client_id cid = { 0 };
+	struct rbd_client_id cid = { };
 
 	if (struct_v >= 2) {
 		cid.gid = ceph_decode_64(p);
@@ -4241,7 +4241,7 @@ static int rbd_handle_request_lock(struct rbd_device *rbd_dev, u8 struct_v,
 				   void **p)
 {
 	struct rbd_client_id my_cid = rbd_get_cid(rbd_dev);
-	struct rbd_client_id cid = { 0 };
+	struct rbd_client_id cid = { };
 	int result = 1;
 
 	if (struct_v >= 2) {
@@ -5709,7 +5709,7 @@ static int get_parent_info(struct rbd_device *rbd_dev,
 static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 {
 	struct rbd_spec *parent_spec;
-	struct parent_image_info pii = { 0 };
+	struct parent_image_info pii = { };
 	int ret;
 
 	parent_spec = rbd_spec_alloc();
@@ -6418,7 +6418,7 @@ static int rbd_add_parse_args(const char *buf,
 	const char *mon_addrs;
 	char *snap_name;
 	size_t mon_addrs_size;
-	struct rbd_parse_opts_ctx pctx = { 0 };
+	struct rbd_parse_opts_ctx pctx = { };
 	int ret;
 
 	/* The first four tokens are required */
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 57c6ae7debd9..d5d7a3cc97df 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -490,7 +490,7 @@ static int init_vq(struct virtio_blk *vblk)
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
 	struct virtio_device *vdev = vblk->vdev;
-	struct irq_affinity desc = { 0, };
+	struct irq_affinity desc = { };
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
diff --git a/drivers/bus/fsl-mc/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
index 9003cd3698a5..202258a1c642 100644
--- a/drivers/bus/fsl-mc/dpbp.c
+++ b/drivers/bus/fsl-mc/dpbp.c
@@ -30,7 +30,7 @@ int dpbp_open(struct fsl_mc_io *mc_io,
 	      int dpbp_id,
 	      u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpbp_cmd_open *cmd_params;
 	int err;
 
@@ -67,7 +67,7 @@ int dpbp_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_CLOSE, cmd_flags,
@@ -90,7 +90,7 @@ int dpbp_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_ENABLE, cmd_flags,
@@ -113,7 +113,7 @@ int dpbp_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_DISABLE,
@@ -136,7 +136,7 @@ int dpbp_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPBP_CMDID_RESET,
@@ -162,7 +162,7 @@ int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpbp_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpbp_rsp_get_attributes *rsp_params;
 	int err;
 
diff --git a/drivers/bus/fsl-mc/dpcon.c b/drivers/bus/fsl-mc/dpcon.c
index 97b6fa605e62..a0042e2bc6b0 100644
--- a/drivers/bus/fsl-mc/dpcon.c
+++ b/drivers/bus/fsl-mc/dpcon.c
@@ -30,7 +30,7 @@ int dpcon_open(struct fsl_mc_io *mc_io,
 	       int dpcon_id,
 	       u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpcon_cmd_open *dpcon_cmd;
 	int err;
 
@@ -68,7 +68,7 @@ int dpcon_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_CLOSE,
@@ -92,7 +92,7 @@ int dpcon_enable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_ENABLE,
@@ -116,7 +116,7 @@ int dpcon_disable(struct fsl_mc_io *mc_io,
 		  u32 cmd_flags,
 		  u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_DISABLE,
@@ -140,7 +140,7 @@ int dpcon_reset(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPCON_CMDID_RESET,
@@ -165,7 +165,7 @@ int dpcon_get_attributes(struct fsl_mc_io *mc_io,
 			 u16 token,
 			 struct dpcon_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpcon_rsp_get_attr *dpcon_rsp;
 	int err;
 
@@ -203,7 +203,7 @@ int dpcon_set_notification(struct fsl_mc_io *mc_io,
 			   u16 token,
 			   struct dpcon_notification_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpcon_cmd_set_notification *dpcon_cmd;
 
 	/* prepare command */
diff --git a/drivers/bus/fsl-mc/dpmcp.c b/drivers/bus/fsl-mc/dpmcp.c
index 5fbd0dbde24a..57834f5cb5ac 100644
--- a/drivers/bus/fsl-mc/dpmcp.c
+++ b/drivers/bus/fsl-mc/dpmcp.c
@@ -30,7 +30,7 @@ int dpmcp_open(struct fsl_mc_io *mc_io,
 	       int dpmcp_id,
 	       u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpmcp_cmd_open *cmd_params;
 	int err;
 
@@ -66,7 +66,7 @@ int dpmcp_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPMCP_CMDID_CLOSE,
@@ -88,7 +88,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPMCP_CMDID_RESET,
diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index d129338b8bc0..03f6409a633b 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -32,7 +32,7 @@ int dprc_open(struct fsl_mc_io *mc_io,
 	      int container_id,
 	      u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_open *cmd_params;
 	int err;
 
@@ -69,7 +69,7 @@ int dprc_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPRC_CMDID_CLOSE, cmd_flags,
@@ -115,7 +115,7 @@ int dprc_reset_container(struct fsl_mc_io *mc_io,
 			 int child_container_id,
 			 u32 options)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_reset_container *cmd_params;
 	u32 cmdid = DPRC_CMDID_RESET_CONT;
 	int err;
@@ -167,7 +167,7 @@ int dprc_set_irq(struct fsl_mc_io *mc_io,
 		 u8 irq_index,
 		 struct dprc_irq_cfg *irq_cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_set_irq *cmd_params;
 
 	/* prepare command */
@@ -205,7 +205,7 @@ int dprc_set_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_set_irq_enable *cmd_params;
 
 	/* prepare command */
@@ -241,7 +241,7 @@ int dprc_set_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 mask)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_set_irq_mask *cmd_params;
 
 	/* prepare command */
@@ -273,7 +273,7 @@ int dprc_get_irq_status(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u32 *status)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_get_irq_status *cmd_params;
 	struct dprc_rsp_get_irq_status *rsp_params;
 	int err;
@@ -315,7 +315,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
 			  u8 irq_index,
 			  u32 status)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_clear_irq_status *cmd_params;
 
 	/* prepare command */
@@ -343,7 +343,7 @@ int dprc_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dprc_attributes *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_rsp_get_attributes *rsp_params;
 	int err;
 
@@ -381,7 +381,7 @@ int dprc_get_obj_count(struct fsl_mc_io *mc_io,
 		       u16 token,
 		       int *obj_count)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_rsp_get_obj_count *rsp_params;
 	int err;
 
@@ -423,7 +423,7 @@ int dprc_get_obj(struct fsl_mc_io *mc_io,
 		 int obj_index,
 		 struct fsl_mc_obj_desc *obj_desc)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_get_obj *cmd_params;
 	struct dprc_rsp_get_obj *rsp_params;
 	int err;
@@ -478,7 +478,7 @@ int dprc_set_obj_irq(struct fsl_mc_io *mc_io,
 		     u8 irq_index,
 		     struct dprc_irq_cfg *irq_cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_set_obj_irq *cmd_params;
 
 	/* prepare command */
@@ -519,7 +519,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 			u8 region_index,
 			struct dprc_region_desc *region_desc)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dprc_cmd_get_obj_region *cmd_params;
 	struct dprc_rsp_get_obj_region *rsp_params;
 	int err;
@@ -601,7 +601,7 @@ int dprc_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *major_ver,
 			 u16 *minor_ver)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -631,7 +631,7 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  int *container_id)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -674,7 +674,7 @@ int dprc_get_connection(struct fsl_mc_io *mc_io,
 {
 	struct dprc_cmd_get_connection *cmd_params;
 	struct dprc_rsp_get_connection *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err, i;
 
 	/* prepare command */
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8fd4a356a86e..764de5c84584 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -530,7 +530,7 @@ static int mc_get_version(struct fsl_mc_io *mc_io,
 			  u32 cmd_flags,
 			  struct fsl_mc_version *mc_ver_info)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpmng_rsp_get_version *rsp_params;
 	int err;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..a32b5056f256 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1381,7 +1381,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->cons.vtermno = 0;
 
 	port->host_connected = port->guest_connected = false;
-	port->stats = (struct port_stats) { 0 };
+	port->stats = (struct port_stats) { };
 
 	port->outvq_full = false;
 
diff --git a/drivers/clk/baikal-t1/clk-ccu-div.c b/drivers/clk/baikal-t1/clk-ccu-div.c
index f141fda12b09..6f38a0bfb33c 100644
--- a/drivers/clk/baikal-t1/clk-ccu-div.c
+++ b/drivers/clk/baikal-t1/clk-ccu-div.c
@@ -378,7 +378,7 @@ static int ccu_div_clk_register(struct ccu_div_data *data)
 
 	for (idx = 0; idx < data->divs_num; ++idx) {
 		const struct ccu_div_info *info = &data->divs_info[idx];
-		struct ccu_div_init_data init = {0};
+		struct ccu_div_init_data init = {};
 
 		init.id = info->id;
 		init.name = info->name;
diff --git a/drivers/clk/baikal-t1/clk-ccu-pll.c b/drivers/clk/baikal-t1/clk-ccu-pll.c
index 2445d4b12baf..75027564fee3 100644
--- a/drivers/clk/baikal-t1/clk-ccu-pll.c
+++ b/drivers/clk/baikal-t1/clk-ccu-pll.c
@@ -146,7 +146,7 @@ static int ccu_pll_clk_register(struct ccu_pll_data *data)
 
 	for (idx = 0; idx < CCU_PLL_NUM; ++idx) {
 		const struct ccu_pll_info *info = &pll_info[idx];
-		struct ccu_pll_init_data init = {0};
+		struct ccu_pll_init_data init = {};
 
 		init.id = info->id;
 		init.name = info->name;
diff --git a/drivers/clk/bcm/clk-kona-setup.c b/drivers/clk/bcm/clk-kona-setup.c
index e65eeef9cbaf..e1a82ee4a91c 100644
--- a/drivers/clk/bcm/clk-kona-setup.c
+++ b/drivers/clk/bcm/clk-kona-setup.c
@@ -801,7 +801,7 @@ of_clk_kona_onecell_get(struct of_phandle_args *clkspec, void *data)
 void __init kona_dt_ccu_setup(struct ccu_data *ccu,
 			struct device_node *node)
 {
-	struct resource res = { 0 };
+	struct resource res = { };
 	resource_size_t range;
 	unsigned int i;
 	int ret;
diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index a9d181d6be21..ccc5374e0163 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -293,7 +293,7 @@ static int clk_dyn_rcg_set_parent(struct clk_hw *hw, u8 index)
 	struct clk_dyn_rcg *rcg = to_clk_dyn_rcg(hw);
 	u32 ns, md, reg;
 	int bank;
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	bool banked_mn = !!rcg->mn[1].width;
 	bool banked_p = !!rcg->p[1].pre_div_width;
 
@@ -550,7 +550,7 @@ static int clk_rcg_bypass2_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	u32 ns, src;
 	int i, ret, num_parents = clk_hw_get_num_parents(hw);
 
@@ -621,7 +621,7 @@ static int clk_rcg_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 	int delta = 100000;
 	const struct frac_entry *frac = pixel_table;
 	unsigned long request;
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	u32 ns, src;
 	int i, ret, num_parents = clk_hw_get_num_parents(hw);
 
@@ -692,7 +692,7 @@ static int clk_rcg_esc_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
 	struct clk_rcg *rcg = to_clk_rcg(hw);
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	int pre_div_max = BIT(rcg->p.pre_div_width);
 	int div;
 	u32 ns;
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..132ba706eb3f 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -672,7 +672,7 @@ static int clk_byte2_set_rate(struct clk_hw *hw, unsigned long rate,
 			 unsigned long parent_rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	unsigned long div;
 	int i, num_parents = clk_hw_get_num_parents(hw);
 	u32 mask = BIT(rcg->hid_width) - 1;
@@ -750,7 +750,7 @@ static int clk_pixel_set_rate(struct clk_hw *hw, unsigned long rate,
 		unsigned long parent_rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	const struct frac_entry *frac = frac_table_pixel;
 	unsigned long request;
 	int delta = 100000;
@@ -1232,7 +1232,7 @@ static int clk_rcg2_dp_set_rate(struct clk_hw *hw, unsigned long rate,
 			unsigned long parent_rate)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	struct freq_tbl f = { 0 };
+	struct freq_tbl f = { };
 	u32 mask = BIT(rcg->hid_width) - 1;
 	u32 hid_div, cfg;
 	int i, num_parents = clk_hw_get_num_parents(hw);
diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 441d7a20e6f3..eda8326e9d8b 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -154,7 +154,7 @@ static int clk_rpmh_send(struct clk_rpmh *c, enum rpmh_state state,
 
 static int clk_rpmh_send_aggregate_command(struct clk_rpmh *c)
 {
-	struct tcs_cmd cmd = { 0 };
+	struct tcs_cmd cmd = { };
 	u32 cmd_state, on_val;
 	enum rpmh_state state = RPMH_SLEEP_STATE;
 	int ret;
@@ -257,7 +257,7 @@ static const struct clk_ops clk_rpmh_ops = {
 
 static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 {
-	struct tcs_cmd cmd = { 0 };
+	struct tcs_cmd cmd = { };
 	u32 cmd_state;
 	int ret = 0;
 
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 864c484bde1b..8499e959b8db 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -139,7 +139,7 @@ static int _omap4_clkctrl_clk_enable(struct clk_hw *hw)
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	u32 val;
 	int ret;
-	union omap4_timeout timeout = { 0 };
+	union omap4_timeout timeout = { };
 
 	if (clk->clkdm) {
 		ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
@@ -180,7 +180,7 @@ static void _omap4_clkctrl_clk_disable(struct clk_hw *hw)
 {
 	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
 	u32 val;
-	union omap4_timeout timeout = { 0 };
+	union omap4_timeout timeout = { };
 
 	if (!clk->enable_bit)
 		goto exit;
diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index d66b1315114e..58662e8ffe64 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -521,7 +521,7 @@ static void xvcu_clk_hw_unregister_leaf(struct clk_hw *hw)
 static int xvcu_register_clock_provider(struct xvcu_device *xvcu)
 {
 	struct device *dev = xvcu->dev;
-	struct clk_parent_data parent_data[2] = { 0 };
+	struct clk_parent_data parent_data[2] = { };
 	struct clk_hw_onecell_data *data;
 	struct clk_hw **hws;
 	struct clk_hw *hw;
diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
index eb25303eefed..78d46c52bedd 100644
--- a/drivers/clk/zynqmp/clkc.c
+++ b/drivers/clk/zynqmp/clkc.c
@@ -200,7 +200,7 @@ static int zynqmp_get_clock_type(u32 clk_id, u32 *type)
  */
 static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -225,7 +225,7 @@ static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks)
 static int zynqmp_pm_clock_get_name(u32 clock_id,
 				    struct name_resp *response)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 
 	qdata.qid = PM_QID_CLOCK_GET_NAME;
@@ -257,7 +257,7 @@ static int zynqmp_pm_clock_get_name(u32 clock_id,
 static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index,
 					struct topology_resp *response)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -309,7 +309,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 {
 	u32 mult, div;
 	struct clk_hw *hw;
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 	unsigned long flag;
@@ -354,7 +354,7 @@ struct clk_hw *zynqmp_clk_register_fixed_factor(const char *name, u32 clk_id,
 static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index,
 				       struct parents_resp *response)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -380,7 +380,7 @@ static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index,
 static int zynqmp_pm_clock_get_attributes(u32 clock_id,
 					  struct attr_resp *response)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index cb49281f9cf9..4f0079a10f51 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -271,7 +271,7 @@ static const struct clk_ops zynqmp_clk_divider_ro_ops = {
  */
 static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index d4c27022b9c9..ec5c83783d19 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -101,7 +101,7 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 static void cppc_scale_freq_workfn(struct kthread_work *work)
 {
 	struct cppc_freq_invariance *cppc_fi;
-	struct cppc_perf_fb_ctrs fb_ctrs = {0};
+	struct cppc_perf_fb_ctrs fb_ctrs = {};
 	struct cppc_cpudata *cpu_data;
 	unsigned long local_freq_scale;
 	u64 perf;
@@ -614,7 +614,7 @@ static int cppc_perf_from_fbctrs(struct cppc_cpudata *cpu_data,
 
 static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
-	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
+	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {}, fb_ctrs_t1 = {};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 	u64 delivered_perf;
diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 8b8ed77d8715..51dd949aa9c2 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -4923,7 +4923,7 @@ static int dpaa2_dpseci_poll(struct napi_struct *napi, int budget)
 static int dpaa2_dpseci_congestion_setup(struct dpaa2_caam_priv *priv,
 					 u16 token)
 {
-	struct dpseci_congestion_notification_cfg cong_notif_cfg = { 0 };
+	struct dpseci_congestion_notification_cfg cong_notif_cfg = { };
 	struct device *dev = priv->dev;
 	int err;
 
diff --git a/drivers/crypto/caam/dpseci.c b/drivers/crypto/caam/dpseci.c
index 039df6c5790c..154091c7578b 100644
--- a/drivers/crypto/caam/dpseci.c
+++ b/drivers/crypto/caam/dpseci.c
@@ -27,7 +27,7 @@
 int dpseci_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpseci_id,
 		u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_cmd_open *cmd_params;
 	int err;
 
@@ -58,7 +58,7 @@ int dpseci_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpseci_id,
  */
 int dpseci_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSECI_CMDID_CLOSE,
 					  cmd_flags,
@@ -76,7 +76,7 @@ int dpseci_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpseci_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSECI_CMDID_ENABLE,
 					  cmd_flags,
@@ -94,7 +94,7 @@ int dpseci_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpseci_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSECI_CMDID_DISABLE,
 					  cmd_flags,
@@ -113,7 +113,7 @@ int dpseci_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpseci_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSECI_CMDID_RESET,
 					  cmd_flags,
@@ -133,7 +133,7 @@ int dpseci_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 int dpseci_is_enabled(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		      int *en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_rsp_is_enabled *rsp_params;
 	int err;
 
@@ -162,7 +162,7 @@ int dpseci_is_enabled(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpseci_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			  struct dpseci_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_rsp_get_attributes *rsp_params;
 	int err;
 
@@ -197,7 +197,7 @@ int dpseci_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpseci_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 queue, const struct dpseci_rx_queue_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_cmd_queue *cmd_params;
 
 	cmd.header = mc_encode_cmd_header(DPSECI_CMDID_SET_RX_QUEUE,
@@ -231,7 +231,7 @@ int dpseci_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpseci_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 queue, struct dpseci_rx_queue_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_cmd_queue *cmd_params;
 	int err;
 
@@ -271,7 +271,7 @@ int dpseci_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpseci_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 queue, struct dpseci_tx_queue_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_cmd_queue *cmd_params;
 	struct dpseci_rsp_get_tx_queue *rsp_params;
 	int err;
@@ -304,7 +304,7 @@ int dpseci_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpseci_get_sec_attr(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			struct dpseci_sec_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_rsp_get_sec_attr *rsp_params;
 	int err;
 
@@ -351,7 +351,7 @@ int dpseci_get_sec_attr(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpseci_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 			   u16 *major_ver, u16 *minor_ver)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_rsp_get_api_version *rsp_params;
 	int err;
 
@@ -381,7 +381,7 @@ int dpseci_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 int dpseci_set_congestion_notification(struct fsl_mc_io *mc_io, u32 cmd_flags,
 	u16 token, const struct dpseci_congestion_notification_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_cmd_congestion_notification *cmd_params;
 
 	cmd.header = mc_encode_cmd_header(
@@ -416,7 +416,7 @@ int dpseci_set_congestion_notification(struct fsl_mc_io *mc_io, u32 cmd_flags,
 int dpseci_get_congestion_notification(struct fsl_mc_io *mc_io, u32 cmd_flags,
 	u16 token, struct dpseci_congestion_notification_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpseci_cmd_congestion_notification *rsp_params;
 	int err;
 
diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index 8c32d0eb8fcf..0373026c248e 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -349,7 +349,7 @@ static void cpt_reset(struct cpt_device *cpt)
 
 static void cpt_find_max_enabled_cores(struct cpt_device *cpt)
 {
-	union cptx_pf_constants pf_cnsts = {0};
+	union cptx_pf_constants pf_cnsts = {};
 
 	pf_cnsts.u = cpt_read_csr64(cpt->reg_base, CPTX_PF_CONSTANTS(0));
 	cpt->max_se_cores = pf_cnsts.s.se;
@@ -358,7 +358,7 @@ static void cpt_find_max_enabled_cores(struct cpt_device *cpt)
 
 static u32 cpt_check_bist_status(struct cpt_device *cpt)
 {
-	union cptx_pf_bist_status bist_sts = {0};
+	union cptx_pf_bist_status bist_sts = {};
 
 	bist_sts.u = cpt_read_csr64(cpt->reg_base,
 				    CPTX_PF_BIST_STATUS(0));
@@ -368,7 +368,7 @@ static u32 cpt_check_bist_status(struct cpt_device *cpt)
 
 static u64 cpt_check_exe_bist_status(struct cpt_device *cpt)
 {
-	union cptx_pf_exe_bist_status bist_sts = {0};
+	union cptx_pf_exe_bist_status bist_sts = {};
 
 	bist_sts.u = cpt_read_csr64(cpt->reg_base,
 				    CPTX_PF_EXE_BIST_STATUS(0));
diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_main.c b/drivers/crypto/marvell/octeontx/otx_cptpf_main.c
index 14a42559f81d..ebcaec40f875 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_main.c
@@ -41,7 +41,7 @@ static void otx_cpt_reset(struct otx_cpt_device *cpt)
 
 static void otx_cpt_find_max_enabled_cores(struct otx_cpt_device *cpt)
 {
-	union otx_cptx_pf_constants pf_cnsts = {0};
+	union otx_cptx_pf_constants pf_cnsts = {};
 
 	pf_cnsts.u = readq(cpt->reg_base + OTX_CPT_PF_CONSTANTS);
 	cpt->eng_grps.avail.max_se_cnt = pf_cnsts.s.se;
@@ -50,7 +50,7 @@ static void otx_cpt_find_max_enabled_cores(struct otx_cpt_device *cpt)
 
 static u32 otx_cpt_check_bist_status(struct otx_cpt_device *cpt)
 {
-	union otx_cptx_pf_bist_status bist_sts = {0};
+	union otx_cptx_pf_bist_status bist_sts = {};
 
 	bist_sts.u = readq(cpt->reg_base + OTX_CPT_PF_BIST_STATUS);
 	return bist_sts.u;
@@ -58,7 +58,7 @@ static u32 otx_cpt_check_bist_status(struct otx_cpt_device *cpt)
 
 static u64 otx_cpt_check_exe_bist_status(struct otx_cpt_device *cpt)
 {
-	union otx_cptx_pf_exe_bist_status bist_sts = {0};
+	union otx_cptx_pf_exe_bist_status bist_sts = {};
 
 	bist_sts.u = readq(cpt->reg_base + OTX_CPT_PF_EXE_BIST_STATUS);
 	return bist_sts.u;
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index 146a55ac4b9b..22835addd407 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -590,7 +590,7 @@ static void cptpf_check_block_implemented(struct otx2_cptpf_dev *cptpf)
 
 static int cptpf_device_init(struct otx2_cptpf_dev *cptpf)
 {
-	union otx2_cptx_af_constants1 af_cnsts1 = {0};
+	union otx2_cptx_af_constants1 af_cnsts1 = {};
 	int ret = 0;
 
 	/* check if 'implemented' bit is set for block BLKADDR_CPT1 */
diff --git a/drivers/crypto/sa2ul.c b/drivers/crypto/sa2ul.c
index 544d7040cfc5..bcd08b2783e2 100644
--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -946,7 +946,7 @@ static int sa_cipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			     unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 	/* Convert the key size (16/24/32) to the key size index (0/1/2) */
 	int key_idx = (keylen >> 3) - 2;
 
@@ -966,7 +966,7 @@ static int sa_aes_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_aes_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			     unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 	/* Convert the key size (16/24/32) to the key size index (0/1/2) */
 	int key_idx = (keylen >> 3) - 2;
 
@@ -984,7 +984,7 @@ static int sa_aes_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_3des_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			      unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 
 	ad.mci_enc = mci_cbc_3des_enc_array;
 	ad.mci_dec = mci_cbc_3des_dec_array;
@@ -998,7 +998,7 @@ static int sa_3des_cbc_setkey(struct crypto_skcipher *tfm, const u8 *key,
 static int sa_3des_ecb_setkey(struct crypto_skcipher *tfm, const u8 *key,
 			      unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 
 	ad.mci_enc = mci_ecb_3des_enc_array;
 	ad.mci_dec = mci_ecb_3des_dec_array;
@@ -1298,7 +1298,7 @@ static int sa_cipher_run(struct skcipher_request *req, u8 *iv, int enc)
 	struct sa_tfm_ctx *ctx =
 	    crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
 	struct crypto_alg *alg = req->base.tfm->__crt_alg;
-	struct sa_req sa_req = { 0 };
+	struct sa_req sa_req = { };
 
 	if (!req->cryptlen)
 		return 0;
@@ -1402,7 +1402,7 @@ static int sa_sha_run(struct ahash_request *req)
 {
 	struct sa_tfm_ctx *ctx = crypto_ahash_ctx(crypto_ahash_reqtfm(req));
 	struct sa_sha_req_ctx *rctx = ahash_request_ctx(req);
-	struct sa_req sa_req = { 0 };
+	struct sa_req sa_req = { };
 	size_t auth_len;
 
 	auth_len = req->nbytes;
@@ -1625,7 +1625,7 @@ static int sa_sha_export(struct ahash_request *req, void *out)
 
 static int sa_sha1_cra_init(struct crypto_tfm *tfm)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	sa_sha_cra_init_alg(tfm, "sha1");
@@ -1641,7 +1641,7 @@ static int sa_sha1_cra_init(struct crypto_tfm *tfm)
 
 static int sa_sha256_cra_init(struct crypto_tfm *tfm)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	sa_sha_cra_init_alg(tfm, "sha256");
@@ -1657,7 +1657,7 @@ static int sa_sha256_cra_init(struct crypto_tfm *tfm)
 
 static int sa_sha512_cra_init(struct crypto_tfm *tfm)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 	struct sa_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
 
 	sa_sha_cra_init_alg(tfm, "sha512");
@@ -1883,7 +1883,7 @@ static int sa_aead_setauthsize(struct crypto_aead *tfm, unsigned int authsize)
 static int sa_aead_cbc_sha1_setkey(struct crypto_aead *authenc,
 				   const u8 *key, unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 
 	ad.ealg_id = SA_EALG_ID_AES_CBC;
 	ad.aalg_id = SA_AALG_ID_HMAC_SHA1;
@@ -1896,7 +1896,7 @@ static int sa_aead_cbc_sha1_setkey(struct crypto_aead *authenc,
 static int sa_aead_cbc_sha256_setkey(struct crypto_aead *authenc,
 				     const u8 *key, unsigned int keylen)
 {
-	struct algo_data ad = { 0 };
+	struct algo_data ad = { };
 
 	ad.ealg_id = SA_EALG_ID_AES_CBC;
 	ad.aalg_id = SA_AALG_ID_HMAC_SHA2_256;
@@ -1910,7 +1910,7 @@ static int sa_aead_run(struct aead_request *req, u8 *iv, int enc)
 {
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	struct sa_tfm_ctx *ctx = crypto_aead_ctx(tfm);
-	struct sa_req sa_req = { 0 };
+	struct sa_req sa_req = { };
 	size_t auth_size, enc_size;
 
 	enc_size = req->cryptlen;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 41de4a136ecd..d6958ba9802a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -37,7 +37,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 	int cap, cap_count;
 	u64 cap_array;
 
-	*map = (struct cxl_component_reg_map) { 0 };
+	*map = (struct cxl_component_reg_map) { };
 
 	/*
 	 * CXL.cache and CXL.mem registers are at offset 0x1000 as defined in
@@ -106,7 +106,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 	int cap, cap_count;
 	u64 cap_array;
 
-	*map = (struct cxl_device_reg_map){ 0 };
+	*map = (struct cxl_device_reg_map){ };
 
 	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
 	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
diff --git a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
index 878662aaa1c2..5dcd0aab23bd 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpdmai.c
@@ -68,7 +68,7 @@ static inline u64 mc_enc(int lsoffset, int width, u64 val)
 int dpdmai_open(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		int dpdmai_id, u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	__le64 *cmd_dpdmai_id;
 	int err;
 
@@ -104,7 +104,7 @@ EXPORT_SYMBOL_GPL(dpdmai_open);
  */
 int dpdmai_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_CLOSE,
@@ -140,7 +140,7 @@ EXPORT_SYMBOL_GPL(dpdmai_close);
 int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
 		  const struct dpdmai_cfg *cfg, u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -169,7 +169,7 @@ int dpdmai_create(struct fsl_mc_io *mc_io, u32 cmd_flags,
  */
 int dpdmai_destroy(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DESTROY,
@@ -190,7 +190,7 @@ EXPORT_SYMBOL_GPL(dpdmai_destroy);
  */
 int dpdmai_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_ENABLE,
@@ -211,7 +211,7 @@ EXPORT_SYMBOL_GPL(dpdmai_enable);
  */
 int dpdmai_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_DISABLE,
@@ -232,7 +232,7 @@ EXPORT_SYMBOL_GPL(dpdmai_disable);
  */
 int dpdmai_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_RESET,
@@ -256,7 +256,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 			  u16 token, struct dpdmai_attr *attr)
 {
 	struct dpdmai_rsp_get_attributes *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -294,7 +294,7 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 priority, const struct dpdmai_rx_queue_cfg *cfg)
 {
 	struct dpdmai_cmd_queue *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPDMAI_CMDID_SET_RX_QUEUE,
@@ -328,7 +328,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 priority, struct dpdmai_rx_queue_attr *attr)
 {
 	struct dpdmai_cmd_queue *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -370,7 +370,7 @@ int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io, u32 cmd_flags,
 {
 	struct dpdmai_rsp_get_tx_queue *rsp_params;
 	struct dpdmai_cmd_queue *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index a35858610780..c4e3f2bcd263 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1835,8 +1835,8 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
 
 	/* Non synchronized - mem to mem type of transfer */
 	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
-	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
-	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { };
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { };
 
 	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
 		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, tchan->id);
@@ -1886,7 +1886,7 @@ static int bcdma_tisci_m2m_channel_config(struct udma_chan *uc)
 	struct udma_dev *ud = uc->ud;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
-	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { };
 	struct udma_bchan *bchan = uc->bchan;
 	u8 burst_size = 0;
 	int ret;
@@ -1921,7 +1921,7 @@ static int udma_tisci_tx_channel_config(struct udma_chan *uc)
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_tchan *tchan = uc->tchan;
 	int tc_ring = k3_ringacc_get_ring_id(tchan->tc_ring);
-	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { };
 	u32 mode, fetch_size;
 	int ret;
 
@@ -1963,7 +1963,7 @@ static int bcdma_tisci_tx_channel_config(struct udma_chan *uc)
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_tchan *tchan = uc->tchan;
-	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
+	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { };
 	int ret;
 
 	req_tx.valid_params = TISCI_BCDMA_TCHAN_VALID_PARAMS;
@@ -1994,8 +1994,8 @@ static int udma_tisci_rx_channel_config(struct udma_chan *uc)
 	struct udma_rchan *rchan = uc->rchan;
 	int fd_ring = k3_ringacc_get_ring_id(uc->rflow->fd_ring);
 	int rx_ring = k3_ringacc_get_ring_id(uc->rflow->r_ring);
-	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
-	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { };
+	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { };
 	u32 mode, fetch_size;
 	int ret;
 
@@ -2073,7 +2073,7 @@ static int bcdma_tisci_rx_channel_config(struct udma_chan *uc)
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
 	struct udma_rchan *rchan = uc->rchan;
-	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { };
 	int ret;
 
 	req_rx.valid_params = TISCI_BCDMA_RCHAN_VALID_PARAMS;
@@ -2092,8 +2092,8 @@ static int pktdma_tisci_rx_channel_config(struct udma_chan *uc)
 	struct udma_dev *ud = uc->ud;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
-	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
-	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { 0 };
+	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { };
+	struct ti_sci_msg_rm_udmap_flow_cfg flow_req = { };
 	int ret;
 
 	req_rx.valid_params = TISCI_BCDMA_RCHAN_VALID_PARAMS;
diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index e7a9561a826d..b9fcd32be12e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -620,7 +620,7 @@ int extcon_get_property(struct extcon_dev *edev, unsigned int id,
 	unsigned long flags;
 	int index, ret = 0;
 
-	*prop_val = (union extcon_property_value){0};
+	*prop_val = (union extcon_property_value){};
 
 	if (!edev)
 		return -EINVAL;
diff --git a/drivers/firmware/efi/fake_mem.c b/drivers/firmware/efi/fake_mem.c
index 6e0f34a38171..56a99c9e2938 100644
--- a/drivers/firmware/efi/fake_mem.c
+++ b/drivers/firmware/efi/fake_mem.c
@@ -36,7 +36,7 @@ static int __init cmp_fake_mem(const void *x1, const void *x2)
 
 static void __init efi_fake_range(struct efi_mem_range *efi_range)
 {
-	struct efi_memory_map_data data = { 0 };
+	struct efi_memory_map_data data = { };
 	int new_nr_map = efi.memmap.nr_map;
 	efi_memory_desc_t *md;
 	void *new_memmap;
diff --git a/drivers/firmware/qcom_scm-legacy.c b/drivers/firmware/qcom_scm-legacy.c
index 1829ba220576..026631b4ab2a 100644
--- a/drivers/firmware/qcom_scm-legacy.c
+++ b/drivers/firmware/qcom_scm-legacy.c
@@ -136,7 +136,7 @@ int scm_legacy_call(struct device *dev, const struct qcom_scm_desc *desc,
 	unsigned int i;
 	struct scm_legacy_command *cmd;
 	struct scm_legacy_response *rsp;
-	struct arm_smccc_args smc = {0};
+	struct arm_smccc_args smc = {};
 	struct arm_smccc_res smc_res;
 	const size_t cmd_len = arglen * sizeof(__le32);
 	const size_t resp_len = MAX_QCOM_SCM_RETS * sizeof(__le32);
diff --git a/drivers/firmware/qcom_scm-smc.c b/drivers/firmware/qcom_scm-smc.c
index d111833364ba..693d003cb081 100644
--- a/drivers/firmware/qcom_scm-smc.c
+++ b/drivers/firmware/qcom_scm-smc.c
@@ -92,7 +92,7 @@ int __scm_smc_call(struct device *dev, const struct qcom_scm_desc *desc,
 	u32 qcom_smccc_convention = (qcom_convention == SMC_CONVENTION_ARM_32) ?
 				    ARM_SMCCC_SMC_32 : ARM_SMCCC_SMC_64;
 	struct arm_smccc_res smc_res;
-	struct arm_smccc_args smc = {0};
+	struct arm_smccc_args smc = {};
 
 	smc.args[0] = ARM_SMCCC_CALL_VAL(
 		smccc_call_type,
diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
index 99606b34975e..b6d2c847d63c 100644
--- a/drivers/firmware/xilinx/zynqmp-debug.c
+++ b/drivers/firmware/xilinx/zynqmp-debug.c
@@ -87,7 +87,7 @@ static int process_api_request(u32 pm_id, u64 *pm_api_arg, u32 *pm_api_ret)
 {
 	u32 pm_api_version;
 	int ret;
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 
 	switch (pm_id) {
 	case PM_GET_API_VERSION:
diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
index 9ddf1d1d392f..b70426a86601 100644
--- a/drivers/fpga/dfl-n3000-nios.c
+++ b/drivers/fpga/dfl-n3000-nios.c
@@ -414,8 +414,8 @@ static struct spi_board_info m10_n3000_info = {
 
 static int create_altera_spi_controller(struct n3000_nios *nn)
 {
-	struct altera_spi_platform_data pdata = { 0 };
-	struct platform_device_info pdevinfo = { 0 };
+	struct altera_spi_platform_data pdata = { };
+	struct platform_device_info pdevinfo = { };
 	void __iomem *base = nn->base;
 	u64 v;
 
diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
index 52404736ac86..8d8a624b46b6 100644
--- a/drivers/gpio/gpio-sl28cpld.c
+++ b/drivers/gpio/gpio-sl28cpld.c
@@ -88,7 +88,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
 
 static int sl28cpld_gpio_probe(struct platform_device *pdev)
 {
-	struct gpio_regmap_config config = {0};
+	struct gpio_regmap_config config = {};
 	enum sl28cpld_gpio_type type;
 	struct regmap *regmap;
 	u32 base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 23efdc672502..02393495568b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -191,8 +191,8 @@ static bool psp_get_runtime_db_entry(struct amdgpu_device *adev,
 				     void *db_entry)
 {
 	uint64_t db_header_pos, db_dir_pos;
-	struct psp_runtime_data_header db_header = {0};
-	struct psp_runtime_data_directory db_dir = {0};
+	struct psp_runtime_data_header db_header = {};
+	struct psp_runtime_data_directory db_dir = {};
 	bool ret = false;
 	int i;
 
@@ -2911,7 +2911,7 @@ int psp_rlc_autoload_start(struct psp_context *psp)
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size)
 {
-	struct amdgpu_firmware_info ucode = {0};
+	struct amdgpu_firmware_info ucode = {};
 
 	ucode.ucode_id = inst_idx ? AMDGPU_UCODE_ID_VCN1_RAM :
 		AMDGPU_UCODE_ID_VCN0_RAM;
diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c b/drivers/gpu/drm/amd/amdgpu/cik.c
index 54f28c075f21..1f488fc1446f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik.c
@@ -1338,7 +1338,7 @@ static void kv_restore_regs_for_reset(struct amdgpu_device *adev,
  */
 static int cik_asic_pci_config_reset(struct amdgpu_device *adev)
 {
-	struct kv_reset_save_regs kv_save = { 0 };
+	struct kv_reset_save_regs kv_save = { };
 	u32 i;
 	int r = -EINVAL;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 16dbe593cba2..155641954de2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8857,7 +8857,7 @@ static int gfx_v10_0_ring_preempt_ib(struct amdgpu_ring *ring)
 static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct v10_ce_ib_state ce_payload = {0};
+	struct v10_ce_ib_state ce_payload = {};
 	uint64_t csa_addr;
 	int cnt;
 
@@ -8887,7 +8887,7 @@ static void gfx_v10_0_ring_emit_ce_meta(struct amdgpu_ring *ring, bool resume)
 static void gfx_v10_0_ring_emit_de_meta(struct amdgpu_ring *ring, bool resume)
 {
 	struct amdgpu_device *adev = ring->adev;
-	struct v10_de_ib_state de_payload = {0};
+	struct v10_de_ib_state de_payload = {};
 	uint64_t csa_addr, gds_addr;
 	int cnt;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 603c259b073b..ea14b89a05b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5523,7 +5523,7 @@ static void gfx_v9_ring_emit_sb(struct amdgpu_ring *ring)
 
 static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
 {
-	struct v9_ce_ib_state ce_payload = {0};
+	struct v9_ce_ib_state ce_payload = {};
 	uint64_t csa_addr;
 	int cnt;
 
@@ -5542,7 +5542,7 @@ static void gfx_v9_0_ring_emit_ce_meta(struct amdgpu_ring *ring)
 
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring)
 {
-	struct v9_de_ib_state de_payload = {0};
+	struct v9_de_ib_state de_payload = {};
 	uint64_t csa_addr, gds_addr;
 	int cnt;
 
@@ -6411,7 +6411,7 @@ static int gfx_v9_0_ras_error_inject(struct amdgpu_device *adev,
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
-	struct ta_ras_trigger_error_input block_info = { 0 };
+	struct ta_ras_trigger_error_input block_info = { };
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
index b4789dfc2bb9..c24e1492e038 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
@@ -976,7 +976,7 @@ static int gfx_v9_4_ras_error_inject(struct amdgpu_device *adev,
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
-	struct ta_ras_trigger_error_input block_info = { 0 };
+	struct ta_ras_trigger_error_input block_info = { };
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 00a2b36a24b3..0b3ccb87bfde 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -1699,7 +1699,7 @@ static int gfx_v9_4_2_ras_error_inject(struct amdgpu_device *adev, void *inject_
 {
 	struct ras_inject_if *info = (struct ras_inject_if *)inject_if;
 	int ret;
-	struct ta_ras_trigger_error_input block_info = { 0 };
+	struct ta_ras_trigger_error_input block_info = { };
 
 	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__GFX))
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 12d91e53556c..92e2aadf6865 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -259,7 +259,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
 		   client_id == SOC15_IH_CLIENTID_VMC1 ||
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
-		struct kfd_vm_fault_info info = {0};
+		struct kfd_vm_fault_info info = {};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
 
 		info.vmid = vmid;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index c021519af810..05cd99a21d7f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -98,7 +98,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		uint32_t *se_mask)
 {
 	struct kfd_cu_info cu_info;
-	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
+	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {};
 	int i, se, sh, cu;
 	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 491373fcdb38..d8004ca1e06b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2715,7 +2715,7 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 {
 	uint64_t last = start + size - 1UL;
 	struct svm_range_list *svms;
-	struct svm_range new = {0};
+	struct svm_range new = {};
 	struct svm_range *prange;
 	unsigned long left = 0;
 	int r = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 816723691d51..8b35f97288ac 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -632,7 +632,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	struct common_irq_params *irq_params = interrupt_params;
 	struct amdgpu_device *adev = irq_params->adev;
 	struct amdgpu_display_manager *dm = &adev->dm;
-	struct dmcub_trace_buf_entry entry = { 0 };
+	struct dmcub_trace_buf_entry entry = { };
 	uint32_t count = 0;
 
 	if (dc_enable_dmub_notifications(adev->dm.dc)) {
@@ -2033,8 +2033,8 @@ amdgpu_dm_find_first_crtc_matching_connector(struct drm_atomic_state *state,
 
 static void emulated_link_detect(struct dc_link *link)
 {
-	struct dc_sink_init_data sink_init_data = { 0 };
-	struct display_sink_capability sink_caps = { 0 };
+	struct dc_sink_init_data sink_init_data = { };
+	struct display_sink_capability sink_caps = { };
 	enum dc_edid_status edid_status;
 	struct dc_context *dc_ctx = link->ctx;
 	struct dc_sink *sink = NULL;
@@ -2868,7 +2868,7 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	struct drm_connector *connector;
 	struct amdgpu_dm_connector *aconnector;
 	const struct dc_link *dc_link;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
 	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -2907,7 +2907,7 @@ static int dce60_register_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 	int r;
 	int i;
 	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
@@ -2989,7 +2989,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 	int r;
 	int i;
 	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
@@ -3095,7 +3095,7 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 	int r;
 	int i;
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
@@ -3248,7 +3248,7 @@ static int register_outbox_irq_handlers(struct amdgpu_device *adev)
 {
 	struct dc *dc = adev->dm.dc;
 	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
+	struct dc_interrupt_params int_params = {};
 	int r, i;
 
 	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
@@ -3601,7 +3601,7 @@ static void
 amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
 {
 	char bl_name[16];
-	struct backlight_properties props = { 0 };
+	struct backlight_properties props = { };
 
 	amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
 	dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;
@@ -5116,8 +5116,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
 {
 	enum amdgpu_rmx_type rmx_type;
 
-	struct rect src = { 0 }; /* viewport in composition space*/
-	struct rect dst = { 0 }; /* stream addressable area */
+	struct rect src = { }; /* viewport in composition space*/
+	struct rect dst = { }; /* stream addressable area */
 
 	/* no mode. nothing to be done */
 	if (!mode)
@@ -5496,7 +5496,7 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 static struct dc_sink *
 create_fake_sink(struct amdgpu_dm_connector *aconnector)
 {
-	struct dc_sink_init_data sink_init_data = { 0 };
+	struct dc_sink_init_data sink_init_data = { };
 	struct dc_sink *sink = NULL;
 	sink_init_data.link = aconnector->dc_link;
 	sink_init_data.sink_signal = aconnector->dc_link->connector_signal;
@@ -8155,7 +8155,7 @@ static void handle_cursor_update(struct drm_plane *plane,
 	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	uint64_t address = afb ? afb->address : 0;
-	struct dc_cursor_position position = {0};
+	struct dc_cursor_position position = {};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
@@ -8236,7 +8236,7 @@ static void update_freesync_state_on_stream(
 	u32 flip_timestamp_in_us)
 {
 	struct mod_vrr_params vrr_params;
-	struct dc_info_packet vrr_infopacket = {0};
+	struct dc_info_packet vrr_infopacket = {};
 	struct amdgpu_device *adev = dm->adev;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(new_crtc_state->base.crtc);
 	unsigned long flags;
@@ -9412,7 +9412,7 @@ static void get_freesync_config_for_crtc(
 	struct dm_crtc_state *new_crtc_state,
 	struct dm_connector_state *new_con_state)
 {
-	struct mod_freesync_config config = {0};
+	struct mod_freesync_config config = {};
 	struct amdgpu_dm_connector *aconnector =
 			to_amdgpu_dm_connector(new_con_state->base.connector);
 	struct drm_display_mode *mode = &new_crtc_state->base.mode;
@@ -10760,7 +10760,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	bool freesync_capable = false;
-	struct amdgpu_hdmi_vsdb_info vsdb_info = {0};
+	struct amdgpu_hdmi_vsdb_info vsdb_info = {};
 
 	if (!connector->state) {
 		DRM_ERROR("%s - Connector has no state", __func__);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a022e5bb30a5..69a8dac429d7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -195,7 +195,7 @@ static int __set_legacy_tf(struct dc_transfer_func *func,
 			   bool has_rom)
 {
 	struct dc_gamma *gamma = NULL;
-	struct calculate_buffer cal_buffer = {0};
+	struct calculate_buffer cal_buffer = {};
 	bool res;
 
 	ASSERT(lut && lut_size == MAX_COLOR_LEGACY_LUT_ENTRIES);
@@ -224,7 +224,7 @@ static int __set_output_tf(struct dc_transfer_func *func,
 			   bool has_rom)
 {
 	struct dc_gamma *gamma = NULL;
-	struct calculate_buffer cal_buffer = {0};
+	struct calculate_buffer cal_buffer = {};
 	bool res;
 
 	ASSERT(lut && lut_size == MAX_COLOR_LUT_ENTRIES);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 87daa78a32b8..7f6aca78c522 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -1295,7 +1295,7 @@ static ssize_t dp_dsc_clock_en_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 10;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -1482,7 +1482,7 @@ static ssize_t dp_dsc_slice_width_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -1667,7 +1667,7 @@ static ssize_t dp_dsc_slice_height_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -1848,7 +1848,7 @@ static ssize_t dp_dsc_bits_per_pixel_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -2024,7 +2024,7 @@ static ssize_t dp_dsc_pic_width_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -2081,7 +2081,7 @@ static ssize_t dp_dsc_pic_height_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -2153,7 +2153,7 @@ static ssize_t dp_dsc_chunk_size_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -2225,7 +2225,7 @@ static ssize_t dp_dsc_slice_bpg_offset_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
 	struct display_stream_compressor *dsc;
-	struct dcn_dsc_state dsc_state = {0};
+	struct dcn_dsc_state dsc_state = {};
 	const uint32_t rd_buf_size = 100;
 	struct pipe_ctx *pipe_ctx;
 	ssize_t result = 0;
@@ -2982,7 +2982,7 @@ static ssize_t dtn_log_read(
 {
 	struct amdgpu_device *adev = file_inode(f)->i_private;
 	struct dc *dc = adev->dm.dc;
-	struct dc_log_buffer_ctx log_ctx = { 0 };
+	struct dc_log_buffer_ctx log_ctx = { };
 	ssize_t result = 0;
 
 	if (!buf || !size)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1bcba6943fd7..044c384dca4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -466,7 +466,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 				       struct amdgpu_dm_connector *aconnector,
 				       int link_index)
 {
-	struct dc_link_settings max_link_enc_cap = {0};
+	struct dc_link_settings max_link_enc_cap = {};
 
 	aconnector->dm_dp_aux.aux.name =
 		kasprintf(GFP_KERNEL, "AMDGPU DM aux hw bus %d",
@@ -764,7 +764,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 
 	/* Set up params */
 	for (i = 0; i < dc_state->stream_count; i++) {
-		struct dc_dsc_policy dsc_policy = {0};
+		struct dc_dsc_policy dsc_policy = {};
 
 		stream = dc_state->streams[i];
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index eba270121698..dd34a471b91e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -299,8 +299,8 @@ bool dm_pp_get_clock_levels_by_type(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct amd_pp_clocks pp_clks = { 0 };
-	struct amd_pp_simple_clock_info validation_clks = { 0 };
+	struct amd_pp_clocks pp_clks = { };
+	struct amd_pp_simple_clock_info validation_clks = { };
 	uint32_t i;
 
 	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_clock_by_type) {
@@ -371,7 +371,7 @@ bool dm_pp_get_clock_levels_by_type_with_latency(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct pp_clock_levels_with_latency pp_clks = { 0 };
+	struct pp_clock_levels_with_latency pp_clks = { };
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret;
 
@@ -395,7 +395,7 @@ bool dm_pp_get_clock_levels_by_type_with_voltage(
 {
 	struct amdgpu_device *adev = ctx->driver_context;
 	void *pp_handle = adev->powerplay.pp_handle;
-	struct pp_clock_levels_with_voltage pp_clk_info = {0};
+	struct pp_clock_levels_with_voltage pp_clk_info = {};
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret;
 
@@ -447,7 +447,7 @@ bool dm_pp_apply_clock_for_voltage_request(
 	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct pp_display_clock_request pp_clock_request = {0};
+	struct pp_display_clock_request pp_clock_request = {};
 	int ret = 0;
 
 	pp_clock_request.clock_type = dc_to_pp_clock_type(clock_for_voltage_req->clk_type);
@@ -470,7 +470,7 @@ bool dm_pp_get_static_clocks(
 	struct dm_pp_static_clock_info *static_clk_info)
 {
 	struct amdgpu_device *adev = ctx->driver_context;
-	struct amd_pp_clock_info pp_clk_info = {0};
+	struct amd_pp_clock_info pp_clk_info = {};
 	int ret = 0;
 
 	if (adev->powerplay.pp_funcs && adev->powerplay.pp_funcs->get_current_clocks)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index 70a554f1e725..6f1e06a08e24 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -65,8 +65,8 @@ void amdgpu_dm_set_psr_caps(struct dc_link *link)
 bool amdgpu_dm_link_setup_psr(struct dc_stream_state *stream)
 {
 	struct dc_link *link = NULL;
-	struct psr_config psr_config = {0};
-	struct psr_context psr_context = {0};
+	struct psr_config psr_config = {};
+	struct psr_context psr_context = {};
 	bool ret = false;
 
 	if (stream == NULL)
@@ -101,7 +101,7 @@ bool amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 {
 	struct dc_link *link = stream->link;
 	unsigned int vsync_rate_hz = 0;
-	struct dc_static_screen_params params = {0};
+	struct dc_static_screen_params params = {};
 	/* Calculate number of static frames before generating interrupt to
 	 * enter PSR.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 9b8ea6e9a2b9..9396e96d1737 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -2021,7 +2021,7 @@ static uint32_t get_src_obj_list(struct bios_parser *bp, ATOM_OBJECT *object,
 static struct device_id device_type_from_device_id(uint16_t device_id)
 {
 
-	struct device_id result_device_id = {0};
+	struct device_id result_device_id = {};
 
 	switch (device_id) {
 	case ATOM_DEVICE_LCD1_SUPPORT:
@@ -2844,7 +2844,7 @@ static bool bios_parser_construct(
 	uint16_t *rom_header_offset = NULL;
 	ATOM_ROM_HEADER *rom_header = NULL;
 	ATOM_OBJECT_HEADER *object_info_tbl;
-	struct atom_data_revision tbl_rev = {0};
+	struct atom_data_revision tbl_rev = {};
 
 	if (!init)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 6dbde74c1e06..d8c656268bb5 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -198,7 +198,7 @@ static enum bp_result bios_parser_get_src_obj(struct dc_bios *dcb,
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	unsigned int i;
 	enum bp_result  bp_result = BP_RESULT_BADINPUT;
-	struct graphics_object_id obj_id = {0};
+	struct graphics_object_id obj_id = {};
 	struct object_info_table *tbl = &bp->object_info_tbl;
 
 	if (!src_object_id)
@@ -256,7 +256,7 @@ static struct atom_display_object_path_v2 *get_bios_object(
 		struct graphics_object_id id)
 {
 	unsigned int i;
-	struct graphics_object_id obj_id = {0};
+	struct graphics_object_id obj_id = {};
 
 	switch (id.type) {
 	case OBJECT_TYPE_ENCODER:
@@ -294,7 +294,7 @@ static enum bp_result bios_parser_get_i2c_info(struct dc_bios *dcb,
 	struct atom_display_object_path_v2 *object;
 	struct atom_common_record_header *header;
 	struct atom_i2c_record *record;
-	struct atom_i2c_record dummy_record = {0};
+	struct atom_i2c_record dummy_record = {};
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 
 	if (!info)
@@ -2601,7 +2601,7 @@ static uint16_t bios_parser_pack_data_tables(
 	struct atom_common_table_header *data_tbl_header = NULL;
 	struct atom_master_list_of_data_tables_v2_1 *data_tbl_list = NULL;
 	struct atom_master_data_table_v2_1 *packed_master_data_tbl = NULL;
-	struct atom_data_revision tbl_rev = {0};
+	struct atom_data_revision tbl_rev = {};
 	uint16_t *rom_header_offset = NULL;
 	const uint8_t *bios = bp->base.bios;
 	uint8_t *bios_dst = (uint8_t *)dst;
@@ -2841,7 +2841,7 @@ static bool bios_parser2_construct(
 	uint16_t *rom_header_offset = NULL;
 	struct atom_rom_header_v2_2 *rom_header = NULL;
 	struct display_object_info_table_v1_4 *object_info_tbl;
-	struct atom_data_revision tbl_rev = {0};
+	struct atom_data_revision tbl_rev = {};
 
 	if (!init)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
index a8cb039d2572..bd1fc08dd978 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_common.c
@@ -267,7 +267,7 @@ struct graphics_object_id object_id_from_bios_object_id(uint32_t bios_object_id)
 {
 	enum object_type type;
 	enum object_enum_id enum_id;
-	struct graphics_object_id go_id = { 0 };
+	struct graphics_object_id go_id = { };
 
 	type = object_type_from_bios_object_id(bios_object_id);
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index f1f672a997d7..05f985bb3ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -135,7 +135,7 @@ static enum bp_result encoder_control_digx_v1_5(
 	struct bp_encoder_control *cntl)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	struct dig_encoder_stream_setup_parameters_v1_5 params = {0};
+	struct dig_encoder_stream_setup_parameters_v1_5 params = {};
 
 	params.digid = (uint8_t)(cntl->engine_id);
 	params.action = bp->cmd_helper->encoder_action_to_atom(cntl->action);
@@ -338,7 +338,7 @@ static enum bp_result transmitter_control_v1_7(
 {
 	enum bp_result result = BP_RESULT_FAILURE;
 	const struct command_table_helper *cmd = bp->cmd_helper;
-	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7 = {0};
+	struct dmub_dig_transmitter_control_data_v1_7 dig_v1_7 = {};
 
 	dig_v1_7.phyid = cmd->phy_id_to_atom(cntl->transmitter);
 	dig_v1_7.action = (uint8_t)cntl->action;
@@ -568,7 +568,7 @@ static enum bp_result set_crtc_using_dtd_timing_v3(
 	struct bp_hw_crtc_timing_parameters *bp_params)
 {
 	enum bp_result result = BP_RESULT_FAILURE;
-	struct set_crtc_using_dtd_timing_parameters params = {0};
+	struct set_crtc_using_dtd_timing_parameters params = {};
 	uint8_t atom_controller_id;
 
 	if (bp->cmd_helper->controller_id_to_atom(
@@ -687,7 +687,7 @@ static enum bp_result enable_crtc_v1(
 	bool enable)
 {
 	bool result = BP_RESULT_FAILURE;
-	struct enable_crtc_parameters params = {0};
+	struct enable_crtc_parameters params = {};
 	uint8_t id;
 
 	if (bp->cmd_helper->controller_id_to_atom(controller_id, &id))
@@ -955,7 +955,7 @@ static void init_get_smu_clock_info(struct bios_parser *bp)
 
 static unsigned int get_smu_clock_info_v3_1(struct bios_parser *bp, uint8_t id)
 {
-	struct atom_get_smu_clock_info_parameters_v3_1 smu_input = {0};
+	struct atom_get_smu_clock_info_parameters_v3_1 smu_input = {};
 	struct atom_get_smu_clock_info_output_parameters_v3_1 smu_output;
 
 	smu_input.command = GET_SMU_CLOCK_INFO_V3_1_GET_PLLVCO_FREQ;
diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
index 0e18df1283b6..1d0ac068b141 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dcn_calcs.c
@@ -459,8 +459,8 @@ static void dcn_bw_calc_rq_dlg_ttu(
 	struct _vcs_dpi_display_dlg_regs_st *dlg_regs = &pipe->dlg_regs;
 	struct _vcs_dpi_display_ttu_regs_st *ttu_regs = &pipe->ttu_regs;
 	struct _vcs_dpi_display_rq_regs_st *rq_regs = &pipe->rq_regs;
-	struct _vcs_dpi_display_rq_params_st rq_param = {0};
-	struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param = {0};
+	struct _vcs_dpi_display_rq_params_st rq_param = {};
+	struct _vcs_dpi_display_dlg_sys_params_st dlg_sys_param = {};
 	struct _vcs_dpi_display_e2e_pipe_params_st input = { { { 0 } } };
 	float total_active_bw = 0;
 	float total_prefetch_bw = 0;
@@ -1483,7 +1483,7 @@ static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage *clks)
 void dcn_bw_update_from_pplib(struct dc *dc)
 {
 	struct dc_context *ctx = dc->ctx;
-	struct dm_pp_clock_levels_with_voltage fclks = {0}, dcfclks = {0};
+	struct dm_pp_clock_levels_with_voltage fclks = {}, dcfclks = {};
 	bool res;
 	unsigned vmin0p65_idx, vmid0p72_idx, vnom0p8_idx, vmax0p9_idx;
 
@@ -1546,7 +1546,7 @@ void dcn_bw_update_from_pplib(struct dc *dc)
 void dcn_bw_notify_pplib_of_wm_ranges(struct dc *dc)
 {
 	struct pp_smu_funcs_rv *pp = NULL;
-	struct pp_smu_wm_range_sets ranges = {0};
+	struct pp_smu_wm_range_sets ranges = {};
 	int min_fclk_khz, min_dcfclk_khz, socclk_khz;
 	const int overdrive = 5000000; /* 5 GHz to cover Overdrive */
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index b210f8e9d592..865877ee0f53 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -231,7 +231,7 @@ int dce_set_clock(
 	int requested_clk_khz)
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct bp_pixel_clock_parameters pxl_clk_params = { 0 };
+	struct bp_pixel_clock_parameters pxl_clk_params = { };
 	struct dc_bios *bp = clk_mgr_base->ctx->dc_bios;
 	int actual_clock = requested_clk_khz;
 	struct dmcu *dmcu = clk_mgr_dce->base.ctx->dc->res_pool->dmcu;
@@ -436,7 +436,7 @@ void dce_clk_mgr_construct(
 		struct clk_mgr_internal *clk_mgr)
 {
 	struct clk_mgr *base = &clk_mgr->base;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	memcpy(clk_mgr->max_clks_by_state,
 		dce80_max_clks_by_state,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
index 5399b8cf6b75..a181db65cb39 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
@@ -86,7 +86,7 @@ static void dce12_update_clocks(struct clk_mgr *clk_mgr_base,
 			bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dm_pp_clock_for_voltage_req clock_voltage_req = {0};
+	struct dm_pp_clock_for_voltage_req clock_voltage_req = {};
 	int max_pix_clk = dce_get_max_pixel_clock_for_all_paths(context);
 	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 6185f9475fa2..a0b386c31b86 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -299,7 +299,7 @@ static void rn_dump_clk_registers_internal(struct rn_clk_internal *internal, str
 static void rn_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
-	struct rn_clk_internal internal = {0};
+	struct rn_clk_internal internal = {};
 	char *bypass_clks[5] = {"0x0 DFS", "0x1 REFCLK", "0x2 ERROR", "0x3 400 FCH", "0x4 600 FCH"};
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = log_info->bufSize;
@@ -432,8 +432,8 @@ static void rn_dump_clk_registers(struct clk_state_registers_and_bypass *regs_an
 /* This function produce translated logical clk state values*/
 void rn_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
 {
-	struct clk_state_registers_and_bypass sb = { 0 };
-	struct clk_log_info log_info = { 0 };
+	struct clk_state_registers_and_bypass sb = { };
+	struct clk_log_info log_info = { };
 
 	rn_dump_clk_registers(&sb, clk_mgr_base, &log_info);
 
@@ -931,7 +931,7 @@ void rn_clk_mgr_construct(
 		struct dccg *dccg)
 {
 	struct dc_debug_options *debug = &ctx->dc->debug;
-	struct dpm_clocks clock_table = { 0 };
+	struct dpm_clocks clock_table = { };
 	enum pp_smu_status status = 0;
 	int is_green_sardine = 0;
 
@@ -958,7 +958,7 @@ void rn_clk_mgr_construct(
 		dcn21_funcs.update_clocks = dcn2_update_clocks_fpga;
 		clk_mgr->base.dentist_vco_freq_khz = 3600000;
 	} else {
-		struct clk_log_info log_info = {0};
+		struct clk_log_info log_info = {};
 
 		clk_mgr->periodic_retraining_disabled = rn_vbios_smu_is_periodic_retraining_disabled(clk_mgr);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index 1861a147a7fa..10c5fe8e1728 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -553,7 +553,7 @@ void dcn3_clk_mgr_construct(
 		clk_mgr->base.dentist_vco_freq_khz = 3650000;
 
 	} else {
-		struct clk_state_registers_and_bypass s = { 0 };
+		struct clk_state_registers_and_bypass s = { };
 
 		/* integer part is now VCO frequency in kHz */
 		clk_mgr->base.dentist_vco_freq_khz = dcn30_get_vco_frequency_from_reg(clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
index 6ea642615854..e53a90b03cd8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/dcn301_smu.c
@@ -210,7 +210,7 @@ void dcn301_smu_set_display_idle_optimization(struct clk_mgr_internal *clk_mgr,
 
 void dcn301_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable)
 {
-	union display_idle_optimization_u idle_info = { 0 };
+	union display_idle_optimization_u idle_info = { };
 
 	if (enable) {
 		idle_info.idle_info.df_request_disabled = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
index 7046da14bb2a..a3a8dd528c13 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
@@ -115,7 +115,7 @@ void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 			display_count = vg_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
 			if (display_count == 0 && !IS_DIAG_DC(dc->ctx->dce_environment)) {
-				union display_idle_optimization_u idle_info = { 0 };
+				union display_idle_optimization_u idle_info = { };
 
 				idle_info.idle_info.df_request_disabled = 1;
 				idle_info.idle_info.phy_ref_clk_off = 1;
@@ -128,7 +128,7 @@ void vg_update_clocks(struct clk_mgr *clk_mgr_base,
 	} else {
 		/* check that we're not already in D0 */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
-			union display_idle_optimization_u idle_info = { 0 };
+			union display_idle_optimization_u idle_info = { };
 
 			dcn301_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
 			/* update power state */
@@ -237,7 +237,7 @@ static void vg_dump_clk_registers_internal(struct dcn301_clk_internal *internal,
 static void vg_dump_clk_registers(struct clk_state_registers_and_bypass *regs_and_bypass,
 		struct clk_mgr *clk_mgr_base, struct clk_log_info *log_info)
 {
-	struct dcn301_clk_internal internal = {0};
+	struct dcn301_clk_internal internal = {};
 	char *bypass_clks[5] = {"0x0 DFS", "0x1 REFCLK", "0x2 ERROR", "0x3 400 FCH", "0x4 600 FCH"};
 	unsigned int chars_printed = 0;
 	unsigned int remaining_buffer = log_info->bufSize;
@@ -371,8 +371,8 @@ static void vg_dump_clk_registers(struct clk_state_registers_and_bypass *regs_an
 void vg_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
 {
 
-	struct clk_state_registers_and_bypass sb = { 0 };
-	struct clk_log_info log_info = { 0 };
+	struct clk_state_registers_and_bypass sb = { };
+	struct clk_log_info log_info = { };
 
 	vg_dump_clk_registers(&sb, clk_mgr_base, &log_info);
 
@@ -704,7 +704,7 @@ static struct vg_dpm_clocks dummy_clocks = {
 		}
 };
 
-static struct watermarks dummy_wms = { 0 };
+static struct watermarks dummy_wms = { };
 
 static void vg_get_dpm_table_from_smu(struct clk_mgr_internal *clk_mgr,
 		struct smu_dpm_clks *smu_dpm_clks)
@@ -732,7 +732,7 @@ void vg_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
-	struct smu_dpm_clks smu_dpm_clks = { 0 };
+	struct smu_dpm_clks smu_dpm_clks = { };
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &vg_funcs;
@@ -776,7 +776,7 @@ void vg_clk_mgr_construct(
 		vg_funcs.update_clocks = dcn2_update_clocks_fpga;
 		clk_mgr->base.base.dentist_vco_freq_khz = 3600000;
 	} else {
-		struct clk_log_info log_info = {0};
+		struct clk_log_info log_info = {};
 
 		clk_mgr->base.smu_ver = dcn301_smu_get_smu_version(&clk_mgr->base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 4a4894e9d9c9..81d75d35e7ef 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -154,7 +154,7 @@ static void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 			display_count = dcn31_get_active_display_cnt_wa(dc, context);
 			/* if we can go lower, go lower */
 			if (display_count == 0) {
-				union display_idle_optimization_u idle_info = { 0 };
+				union display_idle_optimization_u idle_info = { };
 				idle_info.idle_info.df_request_disabled = 1;
 				idle_info.idle_info.phy_ref_clk_off = 1;
 				dcn31_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
@@ -176,7 +176,7 @@ static void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 
 		/* check that we're not already in D0 */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
-			union display_idle_optimization_u idle_info = { 0 };
+			union display_idle_optimization_u idle_info = { };
 			dcn31_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
 			/* update power state */
 			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_MISSION_MODE;
@@ -399,7 +399,7 @@ static struct wm_table lpddr5_wm_table = {
 
 static DpmClocks_t dummy_clocks;
 
-static struct dcn31_watermarks dummy_wms = { 0 };
+static struct dcn31_watermarks dummy_wms = { };
 
 static void dcn31_build_watermark_ranges(struct clk_bw_params *bw_params, struct dcn31_watermarks *table)
 {
@@ -619,7 +619,7 @@ void dcn31_clk_mgr_construct(
 		struct pp_smu_funcs *pp_smu,
 		struct dccg *dccg)
 {
-	struct dcn31_smu_dpm_clks smu_dpm_clks = { 0 };
+	struct dcn31_smu_dpm_clks smu_dpm_clks = { };
 
 	clk_mgr->base.base.ctx = ctx;
 	clk_mgr->base.base.funcs = &dcn31_funcs;
@@ -662,7 +662,7 @@ void dcn31_clk_mgr_construct(
 	if (IS_FPGA_MAXIMUS_DC(ctx->dce_environment)) {
 		clk_mgr->base.base.funcs = &dcn3_fpga_funcs;
 	} else {
-		struct clk_log_info log_info = {0};
+		struct clk_log_info log_info = {};
 
 		clk_mgr->base.smu_ver = dcn31_smu_get_smu_version(&clk_mgr->base);
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index 8c2b77eb9459..ce2eede258dd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -237,7 +237,7 @@ void dcn31_smu_set_display_idle_optimization(struct clk_mgr_internal *clk_mgr, u
 
 void dcn31_smu_enable_phy_refclk_pwrdwn(struct clk_mgr_internal *clk_mgr, bool enable)
 {
-	union display_idle_optimization_u idle_info = { 0 };
+	union display_idle_optimization_u idle_info = { };
 
 	if (!clk_mgr->smu_present)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c798c65d4276..7102bcbbe8c1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -208,7 +208,7 @@ static bool create_links(
 		num_virtual_links);
 
 	for (i = 0; i < connectors_num; i++) {
-		struct link_init_data link_init_params = {0};
+		struct link_init_data link_init_params = {};
 		struct dc_link *link;
 
 		DC_LOG_DC("BIOS object table - printing link object info for connector number: %d, link_index: %d", i, dc->link_count);
@@ -231,7 +231,7 @@ static bool create_links(
 
 	for (i = 0; i < num_virtual_links; i++) {
 		struct dc_link *link = kzalloc(sizeof(*link), GFP_KERNEL);
-		struct encoder_init_data enc_init = {0};
+		struct encoder_init_data enc_init = {};
 
 		if (link == NULL) {
 			BREAK_TO_DEBUGGER();
@@ -1358,7 +1358,7 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
 	struct timing_generator *tg;
 	struct stream_encoder *se = NULL;
 
-	struct dc_crtc_timing hw_crtc_timing = {0};
+	struct dc_crtc_timing hw_crtc_timing = {};
 
 	struct dc_link *link = sink->link;
 	unsigned int i, enc_inst, tg_inst = 0;
@@ -2705,8 +2705,8 @@ static void commit_planes_for_stream(struct dc *dc,
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
 		if (top_pipe_to_program->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (should_use_dmub_lock(stream->link)) {
-				union dmub_hw_lock_flags hw_locks = { 0 };
-				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+				union dmub_hw_lock_flags hw_locks = { };
+				struct dmub_hw_lock_inst_flags inst_flags = { };
 
 				hw_locks.bits.lock_dig = 1;
 				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
@@ -2891,8 +2891,8 @@ static void commit_planes_for_stream(struct dc *dc,
 					CRTC_STATE_VACTIVE);
 
 			if (stream && should_use_dmub_lock(stream->link)) {
-				union dmub_hw_lock_flags hw_locks = { 0 };
-				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+				union dmub_hw_lock_flags hw_locks = { };
+				struct dmub_hw_lock_inst_flags inst_flags = { };
 
 				hw_locks.bits.lock_dig = 1;
 				inst_flags.dig_inst = top_pipe_to_program->stream_res.tg->inst;
@@ -3450,7 +3450,7 @@ bool dc_process_dmub_aux_transfer_async(struct dc *dc,
 				struct aux_payload *payload)
 {
 	uint8_t action;
-	union dmub_rb_cmd cmd = {0};
+	union dmub_rb_cmd cmd = {};
 	struct dc_dmub_srv *dmub_srv = dc->ctx->dmub_srv;
 
 	ASSERT(payload->length <= 16);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 8bd7f42a8053..8d225f949f1b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -821,8 +821,8 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 static bool dc_link_detect_helper(struct dc_link *link,
 				  enum dc_detect_reason reason)
 {
-	struct dc_sink_init_data sink_init_data = { 0 };
-	struct display_sink_capability sink_caps = { 0 };
+	struct dc_sink_init_data sink_init_data = { };
+	struct display_sink_capability sink_caps = { };
 	uint32_t i;
 	bool converter_disable_audio = false;
 	struct audio_support *aud_support = &link->dc->res_pool->audio_support;
@@ -1384,12 +1384,12 @@ static bool dc_link_construct(struct dc_link *link,
 	uint8_t i;
 	struct ddc_service_init_data ddc_service_init_data = { { 0 } };
 	struct dc_context *dc_ctx = init_params->ctx;
-	struct encoder_init_data enc_init_data = { 0 };
-	struct panel_cntl_init_data panel_cntl_init_data = { 0 };
+	struct encoder_init_data enc_init_data = { };
+	struct panel_cntl_init_data panel_cntl_init_data = { };
 	struct integrated_info *info;
 	struct dc_bios *bios = init_params->dc->ctx->dc_bios;
 	const struct dc_vbios_funcs *bp_funcs = bios->funcs;
-	struct bp_disp_connector_caps_info disp_connect_caps_info = { 0 };
+	struct bp_disp_connector_caps_info disp_connect_caps_info = { };
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
@@ -1721,7 +1721,7 @@ static enum dc_status enable_link_dp(struct dc_state *state,
 	enum dc_status status;
 	bool skip_video_pattern;
 	struct dc_link *link = stream->link;
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = {};
 	bool fec_enable;
 	int i;
 	bool apply_seamless_boot_optimization = false;
@@ -1932,8 +1932,8 @@ static bool get_ext_hdmi_settings(struct pipe_ctx *pipe_ctx,
 static bool i2c_write(struct pipe_ctx *pipe_ctx,
 		uint8_t address, uint8_t *buffer, uint32_t length)
 {
-	struct i2c_command cmd = {0};
-	struct i2c_payload payload = {0};
+	struct i2c_command cmd = {};
+	struct i2c_payload payload = {};
 
 	memset(&payload, 0, sizeof(payload));
 	memset(&cmd, 0, sizeof(cmd));
@@ -2314,7 +2314,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	enum dc_color_depth display_color_depth;
 	enum engine_id eng_id;
-	struct ext_hdmi_settings settings = {0};
+	struct ext_hdmi_settings settings = {};
 	bool is_over_340mhz = false;
 	bool is_vga_mode = (stream->timing.h_addressable == 640)
 			&& (stream->timing.v_addressable == 480);
@@ -3026,7 +3026,7 @@ enum dc_status dc_link_allocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	struct link_encoder *link_encoder = link->link_enc;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dp_mst_stream_allocation_table proposed_table = {};
 	struct fixed31_32 avg_time_slots_per_mtp;
 	struct fixed31_32 pbn;
 	struct fixed31_32 pbn_per_slot;
@@ -3113,7 +3113,7 @@ static enum dc_status deallocate_mst_payload(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	struct link_encoder *link_encoder = link->link_enc;
 	struct stream_encoder *stream_encoder = pipe_ctx->stream_res.stream_enc;
-	struct dp_mst_stream_allocation_table proposed_table = {0};
+	struct dp_mst_stream_allocation_table proposed_table = {};
 	struct fixed31_32 avg_time_slots_per_mtp = dc_fixpt_from_int(0);
 	uint8_t i;
 	bool mst_mode = (link->type == dc_connection_mst_branch);
@@ -3191,7 +3191,7 @@ static void update_psp_stream_config(struct pipe_ctx *pipe_ctx, bool dpms_off)
 {
 	struct cp_psp *cp_psp = &pipe_ctx->stream->ctx->cp_psp;
 	if (cp_psp && cp_psp->funcs.update_stream_config) {
-		struct cp_psp_stream_config config = {0};
+		struct cp_psp_stream_config config = {};
 		enum dp_panel_mode panel_mode =
 				dp_get_panel_mode(pipe_ctx->stream->link);
 
@@ -3428,7 +3428,7 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 		deallocate_mst_payload(pipe_ctx);
 
 	if (dc_is_hdmi_signal(pipe_ctx->stream->signal)) {
-		struct ext_hdmi_settings settings = {0};
+		struct ext_hdmi_settings settings = {};
 		enum engine_id eng_id = pipe_ctx->stream_res.stream_enc->id;
 
 		unsigned short masked_chip_caps = link->chip_caps &
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index ba6b56f20269..79703e73f5c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -578,7 +578,7 @@ bool dal_ddc_service_query_ddc_data(
 			success = dal_ddc_submit_aux_command(ddc, &payload);
 		}
 	} else {
-		struct i2c_command command = {0};
+		struct i2c_command command = {};
 		struct i2c_payloads payloads;
 
 		if (!dal_ddc_i2c_payloads_create(ddc->ctx, &payloads, payloads_num))
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index cd025c12f17b..2dac6e70cf34 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2021,7 +2021,7 @@ bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_
 
 static struct dc_link_settings get_max_link_cap(struct dc_link *link)
 {
-	struct dc_link_settings max_link_cap = {0};
+	struct dc_link_settings max_link_cap = {};
 
 	/* get max link encoder capability */
 	link->link_enc->funcs->get_max_link_cap(link->link_enc, &max_link_cap);
@@ -2176,10 +2176,10 @@ bool dp_verify_link_cap(
 	struct dc_link_settings *known_limit_link_setting,
 	int *fail_count)
 {
-	struct dc_link_settings max_link_cap = {0};
-	struct dc_link_settings cur_link_setting = {0};
+	struct dc_link_settings max_link_cap = {};
+	struct dc_link_settings cur_link_setting = {};
 	struct dc_link_settings *cur = &cur_link_setting;
-	struct dc_link_settings initial_link_settings = {0};
+	struct dc_link_settings initial_link_settings = {};
 	bool success;
 	bool skip_link_training;
 	bool skip_video_pattern;
@@ -2327,7 +2327,7 @@ bool dp_verify_link_cap_with_retries(
 bool dp_verify_mst_link_cap(
 	struct dc_link *link)
 {
-	struct dc_link_settings max_link_cap = {0};
+	struct dc_link_settings max_link_cap = {};
 
 	max_link_cap = get_max_link_cap(link);
 	link->verified_link_cap = get_common_supported_link_settings(
@@ -2341,7 +2341,7 @@ static struct dc_link_settings get_common_supported_link_settings(
 		struct dc_link_settings link_setting_a,
 		struct dc_link_settings link_setting_b)
 {
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = {};
 
 	link_settings.lane_count =
 		(link_setting_a.lane_count <=
@@ -2802,7 +2802,7 @@ static bool handle_hpd_irq_psr_sink(struct dc_link *link)
 
 static void dp_test_send_link_training(struct dc_link *link)
 {
-	struct dc_link_settings link_settings = {0};
+	struct dc_link_settings link_settings = {};
 
 	core_link_read_dpcd(
 			link,
@@ -3074,9 +3074,9 @@ static void dp_test_send_link_test_pattern(struct dc_link *link)
 
 static void dp_test_get_audio_test_data(struct dc_link *link, bool disable_video)
 {
-	union audio_test_mode            dpcd_test_mode = {0};
-	struct audio_test_pattern_type   dpcd_pattern_type = {0};
-	union audio_test_pattern_period  dpcd_pattern_period[AUDIO_CHANNELS_COUNT] = {0};
+	union audio_test_mode            dpcd_test_mode = {};
+	struct audio_test_pattern_type   dpcd_pattern_type = {};
+	union audio_test_pattern_period  dpcd_pattern_period[AUDIO_CHANNELS_COUNT] = {};
 	enum dp_test_pattern test_pattern = DP_TEST_PATTERN_AUDIO_OPERATOR_DEFINED;
 
 	struct pipe_ctx *pipes = link->dc->current_state->res_ctx.pipe_ctx;
@@ -3687,7 +3687,7 @@ static bool retrieve_link_cap(struct dc_link *link)
 	struct dp_device_vendor_id sink_id;
 	union down_stream_port_count down_strm_port_count;
 	union edp_configuration_cap edp_config_cap;
-	union dp_downstream_port_present ds_port = { 0 };
+	union dp_downstream_port_present ds_port = { };
 	enum dc_status status = DC_ERROR_UNEXPECTED;
 	uint32_t read_dpcd_retry_cnt = 3;
 	int i;
@@ -3930,7 +3930,7 @@ bool dp_overwrite_extended_receiver_cap(struct dc_link *link)
 	uint8_t dpcd_data[16];
 	uint32_t read_dpcd_retry_cnt = 3;
 	enum dc_status status = DC_ERROR_UNEXPECTED;
-	union dp_downstream_port_present ds_port = { 0 };
+	union dp_downstream_port_present ds_port = { };
 	union down_stream_port_count down_strm_port_count;
 	union edp_configuration_cap edp_config_cap;
 
@@ -4454,8 +4454,8 @@ bool dc_link_dp_set_test_pattern(
 
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_enable) {
 			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
-				union dmub_hw_lock_flags hw_locks = { 0 };
-				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+				union dmub_hw_lock_flags hw_locks = { };
+				struct dmub_hw_lock_inst_flags inst_flags = { };
 
 				hw_locks.bits.lock_dig = 1;
 				inst_flags.dig_inst = pipe_ctx->stream_res.tg->inst;
@@ -4498,8 +4498,8 @@ bool dc_link_dp_set_test_pattern(
 
 		if (pipe_ctx->stream_res.tg->funcs->lock_doublebuffer_disable) {
 			if (pipe_ctx->stream && should_use_dmub_lock(pipe_ctx->stream->link)) {
-				union dmub_hw_lock_flags hw_locks = { 0 };
-				struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+				union dmub_hw_lock_flags hw_locks = { };
+				struct dmub_hw_lock_inst_flags inst_flags = { };
 
 				hw_locks.bits.lock_dig = 1;
 				inst_flags.dig_inst = pipe_ctx->stream_res.tg->inst;
@@ -4731,8 +4731,8 @@ void dpcd_set_source_specific_data(struct dc_link *link)
 {
 	if (!link->dc->vendor_signature.is_valid) {
 		enum dc_status __maybe_unused result_write_min_hblank = DC_NOT_SUPPORTED;
-		struct dpcd_amd_signature amd_signature = {0};
-		struct dpcd_amd_device_id amd_device_id = {0};
+		struct dpcd_amd_signature amd_signature = {};
+		struct dpcd_amd_device_id amd_device_id = {};
 
 		amd_device_id.device_id_byte1 =
 				(uint8_t)(link->ctx->asic_id.chip_id);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index de80a9ea4cfa..c754531d823e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -42,7 +42,7 @@ static bool is_dig_link_enc_stream(struct dc_stream_state *stream)
 				((uint32_t)stream->signal & link_enc->output_signals)) {
 			if (dc_is_dp_signal(stream->signal)) {
 				/* DIGs do not support DP2.0 streams with 128b/132b encoding. */
-				struct dc_link_settings link_settings = {0};
+				struct dc_link_settings link_settings = {};
 
 				decide_link_settings(stream, &link_settings);
 				if ((link_settings.link_rate >= LINK_RATE_LOW) &&
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 9c51cd09dcf1..773d8efa7719 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -302,7 +302,7 @@ void dp_set_hw_test_pattern(
 	uint8_t *custom_pattern,
 	uint32_t custom_pattern_size)
 {
-	struct encoder_set_dp_phy_pattern_param pattern_param = {0};
+	struct encoder_set_dp_phy_pattern_param pattern_param = {};
 	struct link_encoder *encoder;
 
 	/* Access link encoder based on whether it is statically
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index a60396d5be44..a8874b217883 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -305,7 +305,7 @@ bool resource_construct(
 	const struct resource_caps *caps = pool->res_cap;
 	int i;
 	unsigned int num_audio = caps->num_audio;
-	struct resource_straps straps = {0};
+	struct resource_straps straps = {};
 
 	if (create_funcs->read_dce_straps)
 		create_funcs->read_dce_straps(dc->ctx, &straps);
@@ -1962,7 +1962,7 @@ static int acquire_resource_from_hw_enabled_state(
 
 			// Read DPP->MPCC->OPP Pipe from HW State
 			if (pool->mpc->funcs->read_mpcc_state) {
-				struct mpcc_state s = {0};
+				struct mpcc_state s = {};
 
 				pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
 
@@ -2240,7 +2240,7 @@ static void set_avi_info_frame(
 	uint8_t *check_sum = NULL;
 	uint8_t byte_index = 0;
 	union hdmi_info_packet hdmi_info;
-	union display_content_support support = {0};
+	union display_content_support support = {};
 	unsigned int vic = pipe_ctx->stream->timing.vic;
 	enum dc_timing_3d_format format;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 360f3199ea6f..bcbe39dcb9a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -228,7 +228,7 @@ bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv, struct dmu
 
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 {
-	struct dmub_diagnostic_data diag_data = {0};
+	struct dmub_diagnostic_data diag_data = {};
 
 	if (!dc_dmub_srv || !dc_dmub_srv->dmub) {
 		DC_LOG_ERROR("%s: invalid parameters.", __func__);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
index ab6bc5d79012..40289c94d49e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
@@ -245,7 +245,7 @@ uint32_t generic_reg_update_ex(const struct dc_context *ctx,
 		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
 		...)
 {
-	struct dc_reg_value_masks field_value_mask = {0};
+	struct dc_reg_value_masks field_value_mask = {};
 	uint32_t reg_val;
 	va_list ap;
 
@@ -273,7 +273,7 @@ uint32_t generic_reg_set_ex(const struct dc_context *ctx,
 		uint8_t shift1, uint32_t mask1, uint32_t field_value1,
 		...)
 {
-	struct dc_reg_value_masks field_value_mask = {0};
+	struct dc_reg_value_masks field_value_mask = {};
 	va_list ap;
 
 	va_start(ap, field_value1);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index 7866cf2a668f..f4b488109229 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -784,7 +784,7 @@ void dce_aud_wall_dto_setup(
 {
 	struct dce_audio *aud = DCE_AUD(audio);
 
-	struct azalia_clock_info clock_info = { 0 };
+	struct azalia_clock_info clock_info = { };
 
 	if (dc_is_hdmi_tmds_signal(signal)) {
 		uint32_t src_sel;
@@ -876,7 +876,7 @@ static void dce60_aud_wall_dto_setup(
 {
 	struct dce_audio *aud = DCE_AUD(audio);
 
-	struct azalia_clock_info clock_info = { 0 };
+	struct azalia_clock_info clock_info = { };
 
 	if (dc_is_hdmi_signal(signal)) {
 		uint32_t src_sel;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
index 1435d7bc1f21..56818a434856 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clk_mgr.c
@@ -248,7 +248,7 @@ static int dce_set_clock(
 	int requested_clk_khz)
 {
 	struct dce_clk_mgr *clk_mgr_dce = TO_DCE_CLK_MGR(clk_mgr);
-	struct bp_pixel_clock_parameters pxl_clk_params = { 0 };
+	struct bp_pixel_clock_parameters pxl_clk_params = { };
 	struct dc_bios *bp = clk_mgr->ctx->dc_bios;
 	int actual_clock = requested_clk_khz;
 	struct dmcu *dmcu = clk_mgr_dce->base.ctx->dc->res_pool->dmcu;
@@ -753,7 +753,7 @@ static void dce12_update_clocks(struct clk_mgr *clk_mgr,
 			bool safe_to_lower)
 {
 	struct dce_clk_mgr *clk_mgr_dce = TO_DCE_CLK_MGR(clk_mgr);
-	struct dm_pp_clock_for_voltage_req clock_voltage_req = {0};
+	struct dm_pp_clock_for_voltage_req clock_voltage_req = {};
 	int max_pix_clk = get_max_pixel_clock_for_all_paths(context);
 	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
 
@@ -814,7 +814,7 @@ static void dce_clk_mgr_construct(
 	const struct clk_mgr_mask *clk_mask)
 {
 	struct clk_mgr *base = &clk_mgr_dce->base;
-	struct dm_pp_static_clock_info static_clk_info = {0};
+	struct dm_pp_static_clock_info static_clk_info = {};
 
 	base->ctx = ctx;
 	base->funcs = &dce_funcs;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 2c7eb982eabc..c20821deb46f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -399,7 +399,7 @@ static bool pll_adjust_pix_clk(
 	uint32_t actual_pix_clk_100hz = 0;
 	uint32_t requested_clk_100hz = 0;
 	struct bp_adjust_pixel_clock_parameters bp_adjust_pixel_clock_params = {
-							0 };
+	};
 	enum bp_result bp_result;
 	switch (pix_clk_params->signal_type) {
 	case SIGNAL_TYPE_HDMI_TYPE_A: {
@@ -629,7 +629,7 @@ static uint32_t dce112_get_pix_clk_dividers(
 static bool disable_spread_spectrum(struct dce110_clk_src *clk_src)
 {
 	enum bp_result result;
-	struct bp_spread_spectrum_parameters bp_ss_params = {0};
+	struct bp_spread_spectrum_parameters bp_ss_params = {};
 
 	bp_ss_params.pll_id = clk_src->base.id;
 
@@ -711,7 +711,7 @@ static bool enable_spread_spectrum(
 		struct dce110_clk_src *clk_src,
 		enum signal_type signal, struct pll_settings *pll_settings)
 {
-	struct bp_spread_spectrum_parameters bp_params = {0};
+	struct bp_spread_spectrum_parameters bp_params = {};
 	struct delta_sigma_data d_s_data;
 	const struct spread_spectrum_data *ss_data = NULL;
 
@@ -843,7 +843,7 @@ static bool dce110_program_pix_clk(
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
-	struct bp_pixel_clock_parameters bp_pc_params = {0};
+	struct bp_pixel_clock_parameters bp_pc_params = {};
 
 	/* First disable SS
 	 * ATOMBIOS will enable by default SS on PLL for DP,
@@ -916,7 +916,7 @@ static bool dce112_program_pix_clk(
 		struct pll_settings *pll_settings)
 {
 	struct dce110_clk_src *clk_src = TO_DCE110_CLK_SRC(clock_source);
-	struct bp_pixel_clock_parameters bp_pc_params = {0};
+	struct bp_pixel_clock_parameters bp_pc_params = {};
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (IS_FPGA_MAXIMUS_DC(clock_source->ctx->dce_environment)) {
@@ -977,7 +977,7 @@ static bool dce110_clock_source_power_down(
 {
 	struct dce110_clk_src *dce110_clk_src = TO_DCE110_CLK_SRC(clk_src);
 	enum bp_result bp_result;
-	struct bp_pixel_clock_parameters bp_pixel_clock_params = {0};
+	struct bp_pixel_clock_parameters bp_pixel_clock_params = {};
 
 	if (clk_src->dp_clk_src)
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
index dd41736bb5c4..c7435ead0ccd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
@@ -31,7 +31,7 @@ bool dce_i2c_submit_command(
 	struct i2c_command *cmd)
 {
 	struct dce_i2c_hw *dce_i2c_hw;
-	struct dce_i2c_sw dce_i2c_sw = {0};
+	struct dce_i2c_sw dce_i2c_sw = {};
 
 	if (!ddc) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 1e77ffee71b3..1ea759050a69 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -815,7 +815,7 @@ void dce110_link_encoder_construct(
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
@@ -963,7 +963,7 @@ void dce110_link_encoder_hw_init(
 	struct link_encoder *enc)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	cntl.action = TRANSMITTER_CONTROL_INIT;
@@ -1056,7 +1056,7 @@ void dce110_link_encoder_enable_tmds_output(
 	uint32_t pixel_clock)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1092,7 +1092,7 @@ void dce110_link_encoder_enable_lvds_output(
 	uint32_t pixel_clock)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1124,7 +1124,7 @@ void dce110_link_encoder_enable_dp_output(
 	enum clock_source_id clock_source)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1163,7 +1163,7 @@ void dce110_link_encoder_enable_dp_mst_output(
 	enum clock_source_id clock_source)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1203,7 +1203,7 @@ static void dce60_link_encoder_enable_dp_output(
 	enum clock_source_id clock_source)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1242,7 +1242,7 @@ static void dce60_link_encoder_enable_dp_mst_output(
 	enum clock_source_id clock_source)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1284,7 +1284,7 @@ void dce110_link_encoder_disable_output(
 	enum signal_type signal)
 {
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	if (!dce110_is_dig_enabled(enc)) {
@@ -1329,7 +1329,7 @@ void dce110_link_encoder_dp_set_lane_settings(
 	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
 	union dpcd_training_lane_set training_lane_set = { { 0 } };
 	int32_t lane = 0;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 
 	if (!link_settings) {
 		BREAK_TO_DEBUGGER();
@@ -1715,7 +1715,7 @@ void dce60_link_encoder_construct(
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 8d4263da59f2..c170113f3c9d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -555,7 +555,7 @@ static void dce110_stream_encoder_hdmi_set_stream_attribute(
 	bool enable_audio)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc110->base.id;
@@ -669,7 +669,7 @@ static void dce110_stream_encoder_dvi_set_stream_attribute(
 	bool is_dual_link)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc110->base.id;
@@ -694,7 +694,7 @@ static void dce110_stream_encoder_lvds_set_stream_attribute(
 	struct dc_crtc_timing *crtc_timing)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc110->base.id;
@@ -1134,7 +1134,7 @@ static const struct audio_clock_info audio_clock_info_table_48bpc[14] = {
 static union audio_cea_channels speakers_to_channels(
 	struct audio_speaker_flags speaker_flags)
 {
-	union audio_cea_channels cea_channels = {0};
+	union audio_cea_channels cea_channels = {};
 
 	/* these are one to one */
 	cea_channels.channels.FL = speaker_flags.FL_FR;
@@ -1276,7 +1276,7 @@ static void dce110_se_setup_hdmi_audio(
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 
-	struct audio_clock_info audio_clock_info = {0};
+	struct audio_clock_info audio_clock_info = {};
 	uint32_t max_packets_per_line;
 
 	/* For now still do calculation, although this field is ignored when
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index d9fd4ec60588..3addb923ca9a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -430,7 +430,7 @@ static void dce_transform_set_scaler(
 
 	if (is_scaling_required) {
 		/* 3. Calculate and program ratio, filter initialization */
-		struct scl_ratios_inits inits = { 0 };
+		struct scl_ratios_inits inits = { };
 
 		calculate_inits(xfm_dce, data, &inits);
 
@@ -513,7 +513,7 @@ static void dce60_transform_set_scaler(
 
 	if (is_scaling_required) {
 		/* 3. Calculate and program ratio, DCE6 filter initialization */
-		struct sclh_ratios_inits inits = { 0 };
+		struct sclh_ratios_inits inits = { };
 
 		/* DCE6 has specific calculate_inits() function */
 		dce60_calculate_inits(xfm_dce, data, &inits);
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index 9baf8ca0a920..7d0128c08d78 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -55,7 +55,7 @@ void dmub_hw_lock_mgr_cmd(struct dc_dmub_srv *dmub_srv,
 void dmub_hw_lock_mgr_inbox0_cmd(struct dc_dmub_srv *dmub_srv,
 		union dmub_inbox0_cmd_lock_hw hw_lock_cmd)
 {
-	union dmub_inbox0_data_register data = { 0 };
+	union dmub_inbox0_data_register data = { };
 	data.inbox0_cmd_lock_hw = hw_lock_cmd;
 	dc_dmub_srv_send_inbox0_cmd(dmub_srv, data);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 62d595ded866..c11045fc2937 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -284,7 +284,7 @@ dce110_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	struct input_pixel_processor *ipp = pipe_ctx->plane_res.ipp;
 	const struct dc_transfer_func *tf = NULL;
-	struct ipp_prescale_params prescale_params = { 0 };
+	struct ipp_prescale_params prescale_params = { };
 	bool result = true;
 
 	if (ipp == NULL)
@@ -801,7 +801,7 @@ void dce110_edp_power_control(
 		bool power_up)
 {
 	struct dc_context *ctx = link->ctx;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result bp_result;
 	uint8_t panel_instance;
 
@@ -971,7 +971,7 @@ void dce110_edp_backlight_control(
 		bool enable)
 {
 	struct dc_context *ctx = link->ctx;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	uint8_t panel_instance;
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
@@ -1337,7 +1337,7 @@ static void build_audio_output(
 static void program_scaler(const struct dc *dc,
 		const struct pipe_ctx *pipe_ctx)
 {
-	struct tg_color color = {0};
+	struct tg_color color = {};
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	/* TOFPGA */
@@ -1383,7 +1383,7 @@ static enum dc_status dce110_enable_stream_timing(
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *pipe_ctx_old = &dc->current_state->res_ctx.
 			pipe_ctx[pipe_ctx->pipe_idx];
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 
 	if (!pipe_ctx_old->stream) {
 
@@ -1436,7 +1436,7 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 		struct dc *dc)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct drr_params params = {0};
+	struct drr_params params = {};
 	unsigned int event_triggers = 0;
 	struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
 	struct dce_hwseq *hws = dc->hwseq;
@@ -1848,7 +1848,7 @@ static void set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, struct dc_crtc_timing_adjust adjust)
 {
 	int i = 0;
-	struct drr_params params = {0};
+	struct drr_params params = {};
 	// DRR should set trigger event to monitor surface update event
 	unsigned int event_triggers = 0x80;
 	// Note DRR trigger events are generated regardless of whether num frames met.
@@ -2259,7 +2259,7 @@ enum dc_status dce110_apply_ctx_to_hw(
  ******************************************************************************/
 static void set_default_colors(struct pipe_ctx *pipe_ctx)
 {
-	struct default_adjustment default_adjust = { 0 };
+	struct default_adjustment default_adjust = { };
 
 	default_adjust.force_hw_default = false;
 	default_adjust.in_color_space = pipe_ctx->plane_state->color_space;
@@ -2433,7 +2433,7 @@ static void dce110_enable_timing_synchronization(
 		struct pipe_ctx *grouped_pipes[])
 {
 	struct dc_context *dc_ctx = dc->ctx;
-	struct dcp_gsl_params gsl_params = { 0 };
+	struct dcp_gsl_params gsl_params = { };
 	int i;
 
 	DC_SYNC_INFO("GSL: Setting-up...\n");
@@ -2478,7 +2478,7 @@ static void dce110_enable_per_frame_crtc_position_reset(
 		struct pipe_ctx *grouped_pipes[])
 {
 	struct dc_context *dc_ctx = dc->ctx;
-	struct dcp_gsl_params gsl_params = { 0 };
+	struct dcp_gsl_params gsl_params = { };
 	int i;
 
 	gsl_params.gsl_group = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index ef56eab4e5da..f0f0bcaa16d8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -1142,7 +1142,7 @@ static struct pipe_ctx *dce110_acquire_underlay(
 	pipe_ctx->stream = stream;
 
 	if (!dc->current_state->res_ctx.pipe_ctx[underlay_idx].stream) {
-		struct tg_color black_color = {0};
+		struct tg_color black_color = {};
 		struct dc_bios *dcb = dc->ctx->dc_bios;
 
 		hws->funcs.enable_display_power_gating(
@@ -1280,7 +1280,7 @@ static bool underlay_create(struct dc_context *ctx, struct resource_pool *pool)
 
 static void bw_calcs_data_update_from_pplib(struct dc *dc)
 {
-	struct dm_pp_clock_levels clks = {0};
+	struct dm_pp_clock_levels clks = {};
 
 	/*do system clock*/
 	dm_pp_get_clock_levels_by_type(
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
index 45bca0db5e5e..5fe1d0cf521c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
@@ -528,8 +528,8 @@ static void dce110_xfmv_set_scaler(
 	bool is_scaling_required = false;
 	bool filter_updated = false;
 	const uint16_t *coeffs_v, *coeffs_h, *coeffs_h_c, *coeffs_v_c;
-	struct rect luma_viewport = {0};
-	struct rect chroma_viewport = {0};
+	struct rect luma_viewport = {};
+	struct rect chroma_viewport = {};
 
 	dce110_xfmv_power_up_line_buffer(xfm);
 	/* 1. Calculate viewport, viewport programming should happen after init
@@ -547,7 +547,7 @@ static void dce110_xfmv_set_scaler(
 	if (is_scaling_required) {
 		/* 4. Calculate and program ratio, filter initialization */
 
-		struct sclv_ratios_inits inits = { 0 };
+		struct sclv_ratios_inits inits = { };
 
 		calculate_inits(
 			xfm_dce,
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index ee55cda854bf..19411a932d60 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -1058,10 +1058,10 @@ static const struct resource_funcs dce112_res_pool_funcs = {
 
 static void bw_calcs_data_update_from_pplib(struct dc *dc)
 {
-	struct dm_pp_clock_levels_with_latency eng_clks = {0};
-	struct dm_pp_clock_levels_with_latency mem_clks = {0};
-	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {0};
-	struct dm_pp_clock_levels clks = {0};
+	struct dm_pp_clock_levels_with_latency eng_clks = {};
+	struct dm_pp_clock_levels_with_latency mem_clks = {};
+	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {};
+	struct dm_pp_clock_levels clks = {};
 	int memory_type_multiplier = MEMORY_TYPE_MULTIPLIER_CZ;
 
 	if (dc->bw_vbios && dc->bw_vbios->memory_type == bw_def_hbm)
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index c65e4d125c8e..fede7d2dec2f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -912,9 +912,9 @@ static const struct resource_funcs dce120_res_pool_funcs = {
 
 static void bw_calcs_data_update_from_pplib(struct dc *dc)
 {
-	struct dm_pp_clock_levels_with_latency eng_clks = {0};
-	struct dm_pp_clock_levels_with_latency mem_clks = {0};
-	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {0};
+	struct dm_pp_clock_levels_with_latency eng_clks = {};
+	struct dm_pp_clock_levels_with_latency mem_clks = {};
+	struct dm_pp_wm_sets_with_clock_ranges clk_ranges = {};
 	int i;
 	unsigned int clk;
 	unsigned int latency;
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
index 920c7ae29d53..d7a8506447b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
@@ -142,7 +142,7 @@ static void dce60_enable_fbc(
 
 static void dce60_set_default_colors(struct pipe_ctx *pipe_ctx)
 {
-	struct default_adjustment default_adjust = { 0 };
+	struct default_adjustment default_adjust = { };
 
 	default_adjust.force_hw_default = false;
 	default_adjust.in_color_space = pipe_ctx->plane_state->color_space;
@@ -232,7 +232,7 @@ static void dce60_get_surface_visual_confirm_color(const struct pipe_ctx *pipe_c
 static void dce60_program_scaler(const struct dc *dc,
 		const struct pipe_ctx *pipe_ctx)
 {
-	struct tg_color color = {0};
+	struct tg_color color = {};
 
 	/* DCE6 skips DCN TOFPGA check for transform_set_pixel_storage_depth == NULL */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index df8a7718a85f..b4b4b87f2e19 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -292,7 +292,7 @@ void dcn10_log_hw_state(struct dc *dc,
 			"C31 C32   C33 C34\n");
 	for (i = 0; i < pool->pipe_count; i++) {
 		struct dpp *dpp = pool->dpps[i];
-		struct dcn_dpp_state s = {0};
+		struct dcn_dpp_state s = {};
 
 		dpp->funcs->dpp_read_state(dpp, &s);
 
@@ -333,7 +333,7 @@ void dcn10_log_hw_state(struct dc *dc,
 
 	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE\n");
 	for (i = 0; i < pool->pipe_count; i++) {
-		struct mpcc_state s = {0};
+		struct mpcc_state s = {};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
 		if (s.opp_id != 0xf)
@@ -348,7 +348,7 @@ void dcn10_log_hw_state(struct dc *dc,
 
 	for (i = 0; i < pool->timing_generator_count; i++) {
 		struct timing_generator *tg = pool->timing_generators[i];
-		struct dcn_otg_state s = {0};
+		struct dcn_otg_state s = {};
 		/* Read shared OTG state registers for all DCNx */
 		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
 
@@ -402,7 +402,7 @@ void dcn10_log_hw_state(struct dc *dc,
 	DTN_INFO("DSC: CLOCK_EN  SLICE_WIDTH  Bytes_pp\n");
 	for (i = 0; i < pool->res_cap->num_dsc; i++) {
 		struct display_stream_compressor *dsc = pool->dscs[i];
-		struct dcn_dsc_state s = {0};
+		struct dcn_dsc_state s = {};
 
 		dsc->funcs->dsc_read_state(dsc, &s);
 		DTN_INFO("[%d]: %-9d %-12d %-10d\n",
@@ -418,7 +418,7 @@ void dcn10_log_hw_state(struct dc *dc,
 			"  VBID6_LINE_REFERENCE  VBID6_LINE_NUM  SEC_GSP7_ENABLE  SEC_STREAM_ENABLE\n");
 	for (i = 0; i < pool->stream_enc_count; i++) {
 		struct stream_encoder *enc = pool->stream_enc[i];
-		struct enc_state s = {0};
+		struct enc_state s = {};
 
 		if (enc->funcs->enc_read_state) {
 			enc->funcs->enc_read_state(enc, &s);
@@ -439,7 +439,7 @@ void dcn10_log_hw_state(struct dc *dc,
 	for (i = 0; i < dc->link_count; i++) {
 		struct link_encoder *lenc = dc->links[i]->link_enc;
 
-		struct link_enc_state s = {0};
+		struct link_enc_state s = {};
 
 		if (lenc->funcs->read_state) {
 			lenc->funcs->read_state(lenc, &s);
@@ -811,7 +811,7 @@ enum dc_status dcn10_enable_stream_timing(
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 
 	/* by upper caller loop, pipe0 is parent pipe and be called first.
 	 * back end is set up by for pipe0. Other children pipe share back end
@@ -1847,8 +1847,8 @@ void dcn10_cursor_lock(struct dc *dc, struct pipe_ctx *pipe, bool lock)
 		delay_cursor_until_vupdate(dc, pipe);
 
 	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
-		union dmub_hw_lock_flags hw_locks = { 0 };
-		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+		union dmub_hw_lock_flags hw_locks = { };
+		struct dmub_hw_lock_inst_flags inst_flags = { };
 
 		hw_locks.bits.lock_cursor = 1;
 		inst_flags.opp_inst = pipe->stream_res.opp->inst;
@@ -1986,7 +1986,7 @@ int dcn10_align_pixel_clocks(
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	int i, master = -1, embedded = -1;
-	struct dc_crtc_timing hw_crtc_timing[MAX_PIPES] = {0};
+	struct dc_crtc_timing hw_crtc_timing[MAX_PIPES] = {};
 	uint64_t phase[MAX_PIPES];
 	uint64_t modulo[MAX_PIPES];
 	unsigned int pclk;
@@ -2411,7 +2411,7 @@ void dcn10_program_output_csc(struct dc *dc,
 
 static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
 {
-	struct dc_bias_and_scale bns_params = {0};
+	struct dc_bias_and_scale bns_params = {};
 
 	// program the input csc
 	dpp->funcs->dpp_setup(dpp,
@@ -2699,7 +2699,7 @@ void dcn10_blank_pixel_data(
 		bool blank)
 {
 	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 	struct stream_resource *stream_res = &pipe_ctx->stream_res;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 
@@ -2957,7 +2957,7 @@ void dcn10_set_drr(struct pipe_ctx **pipe_ctx,
 		int num_pipes, struct dc_crtc_timing_adjust adjust)
 {
 	int i = 0;
-	struct drr_params params = {0};
+	struct drr_params params = {};
 	// DRR set trigger event mapped to OTG_TRIG_A (bit 11) for manual control flow
 	unsigned int event_triggers = 0x800;
 	// Note DRR trigger events are generated regardless of whether num frames met.
@@ -3051,7 +3051,7 @@ static void dcn10_config_stereo_parameters(
 
 void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 {
-	struct crtc_stereo_flags flags = { 0 };
+	struct crtc_stereo_flags flags = { };
 	struct dc_stream_state *stream = pipe_ctx->stream;
 
 	dcn10_config_stereo_parameters(stream, &flags);
@@ -3430,7 +3430,7 @@ void dcn10_set_cursor_sdr_white_level(struct pipe_ctx *pipe_ctx)
 {
 	uint32_t sdr_white_level = pipe_ctx->stream->cursor_attributes.sdr_white_level;
 	struct fixed31_32 multiplier;
-	struct dpp_cursor_attributes opt_attr = { 0 };
+	struct dpp_cursor_attributes opt_attr = { };
 	uint32_t hw_scale = 0x3c00; // 1.0 default multiplier
 	struct custom_float_format fmt;
 
@@ -3638,7 +3638,7 @@ enum dc_status dcn10_set_clock(struct dc *dc,
 			uint32_t stepping)
 {
 	struct dc_state *context = dc->current_state;
-	struct dc_clock_config clock_cfg = {0};
+	struct dc_clock_config clock_cfg = {};
 	struct dc_clocks *current_clocks = &context->bw_ctx.bw.dcn.clk;
 
 	if (!dc->clk_mgr || !dc->clk_mgr->funcs->get_clock)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index e8b6065fffad..67d7c0c830d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -340,7 +340,7 @@ static unsigned int dcn10_get_cm_states(struct dc *dc, char *pBuf, unsigned int
 
 	for (i = 0; i < pool->pipe_count; i++) {
 		struct dpp *dpp = pool->dpps[i];
-		struct dcn_dpp_state s = {0};
+		struct dcn_dpp_state s = {};
 
 		dpp->funcs->dpp_read_state(dpp, &s);
 
@@ -392,7 +392,7 @@ static unsigned int dcn10_get_mpcc_states(struct dc *dc, char *pBuf, unsigned in
 	pBuf += chars_printed;
 
 	for (i = 0; i < pool->pipe_count; i++) {
-		struct mpcc_state s = {0};
+		struct mpcc_state s = {};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
 
@@ -425,7 +425,7 @@ static unsigned int dcn10_get_otg_states(struct dc *dc, char *pBuf, unsigned int
 
 	for (i = 0; i < pool->timing_generator_count; i++) {
 		struct timing_generator *tg = pool->timing_generators[i];
-		struct dcn_otg_state s = {0};
+		struct dcn_otg_state s = {};
 		int pix_clk = 0;
 
 		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
@@ -492,7 +492,7 @@ static void dcn10_clear_otpc_underflow(struct dc *dc)
 
 	for (i = 0; i < pool->timing_generator_count; i++) {
 		struct timing_generator *tg = pool->timing_generators[i];
-		struct dcn_otg_state s = {0};
+		struct dcn_otg_state s = {};
 
 		optc1_read_otg_state(DCN10TG_FROM_TG(tg), &s);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index e4701825b5a0..90cfdba36eeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -677,7 +677,7 @@ void dcn10_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 
@@ -832,7 +832,7 @@ void dcn10_link_encoder_hw_init(
 	struct link_encoder *enc)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	cntl.action = TRANSMITTER_CONTROL_INIT;
@@ -926,7 +926,7 @@ void dcn10_link_encoder_enable_tmds_output(
 	uint32_t pixel_clock)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -977,7 +977,7 @@ void dcn10_link_encoder_enable_dp_output(
 	enum clock_source_id clock_source)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1016,7 +1016,7 @@ void dcn10_link_encoder_enable_dp_mst_output(
 	enum clock_source_id clock_source)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	/* Enable the PHY */
@@ -1056,7 +1056,7 @@ void dcn10_link_encoder_disable_output(
 	enum signal_type signal)
 {
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 	enum bp_result result;
 
 	if (!dcn10_is_dig_enabled(enc)) {
@@ -1105,7 +1105,7 @@ void dcn10_link_encoder_dp_set_lane_settings(
 	struct dcn10_link_encoder *enc10 = TO_DCN10_LINK_ENC(enc);
 	union dpcd_training_lane_set training_lane_set = { { 0 } };
 	int32_t lane = 0;
-	struct bp_transmitter_control cntl = { 0 };
+	struct bp_transmitter_control cntl = { };
 
 	if (!link_settings) {
 		BREAK_TO_DEBUGGER();
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index 37848f4577b1..db356431bd1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -1319,7 +1319,7 @@ bool optc1_is_stereo_left_eye(struct timing_generator *optc)
 bool optc1_get_hw_timing(struct timing_generator *tg,
 		struct dc_crtc_timing *hw_crtc_timing)
 {
-	struct dcn_otg_state s = {0};
+	struct dcn_otg_state s = {};
 
 	if (tg == NULL || hw_crtc_timing == NULL)
 		return false;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index cf364ae93138..a4a6f94fa6a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -494,7 +494,7 @@ void enc1_stream_encoder_hdmi_set_stream_attribute(
 	bool enable_audio)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc1->base.id;
@@ -611,7 +611,7 @@ void enc1_stream_encoder_dvi_set_stream_attribute(
 	bool is_dual_link)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
-	struct bp_encoder_control cntl = {0};
+	struct bp_encoder_control cntl = {};
 
 	cntl.action = ENCODER_CONTROL_SETUP;
 	cntl.engine_id = enc1->base.id;
@@ -1103,7 +1103,7 @@ static const struct audio_clock_info audio_clock_info_table_48bpc[14] = {
 static union audio_cea_channels speakers_to_channels(
 	struct audio_speaker_flags speaker_flags)
 {
-	union audio_cea_channels cea_channels = {0};
+	union audio_cea_channels cea_channels = {};
 
 	/* these are one to one */
 	cea_channels.channels.FL = speaker_flags.FL_FR;
@@ -1224,7 +1224,7 @@ static void enc1_se_setup_hdmi_audio(
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	struct audio_clock_info audio_clock_info = {0};
+	struct audio_clock_info audio_clock_info = {};
 
 	/* HDMI_AUDIO_PACKET_CONTROL */
 	REG_UPDATE(HDMI_AUDIO_PACKET_CONTROL,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
index 5adf42a7cc27..163ab4bbc7ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
@@ -1292,9 +1292,9 @@ void hubp2_validate_dml_output(struct hubp *hubp,
 		struct _vcs_dpi_display_ttu_regs_st *dml_ttu_attr)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
-	struct _vcs_dpi_display_rq_regs_st rq_regs = {0};
-	struct _vcs_dpi_display_dlg_regs_st dlg_attr = {0};
-	struct _vcs_dpi_display_ttu_regs_st ttu_attr = {0};
+	struct _vcs_dpi_display_rq_regs_st rq_regs = {};
+	struct _vcs_dpi_display_dlg_regs_st dlg_attr = {};
+	struct _vcs_dpi_display_ttu_regs_st ttu_attr = {};
 	DC_LOGGER_INIT(ctx->logger);
 	DC_LOG_DEBUG("DML Validation | Running Validation");
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a47ba1d45be9..4349de14f080 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -277,7 +277,7 @@ void dcn20_init_blank(
 {
 	struct dce_hwseq *hws = dc->hwseq;
 	enum dc_color_space color_space;
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 	struct output_pixel_processor *opp = NULL;
 	struct output_pixel_processor *bottom_opp = NULL;
 	uint32_t num_opps, opp_id_src0, opp_id_src1;
@@ -642,7 +642,7 @@ enum dc_status dcn20_enable_stream_timing(
 {
 	struct dce_hwseq *hws = dc->hwseq;
 	struct dc_stream_state *stream = pipe_ctx->stream;
-	struct drr_params params = {0};
+	struct drr_params params = {};
 	unsigned int event_triggers = 0;
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
@@ -990,7 +990,7 @@ void dcn20_blank_pixel_data(
 		struct pipe_ctx *pipe_ctx,
 		bool blank)
 {
-	struct tg_color black_color = {0};
+	struct tg_color black_color = {};
 	struct stream_resource *stream_res = &pipe_ctx->stream_res;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	enum dc_color_space color_space = stream->output_color_space;
@@ -1227,8 +1227,8 @@ void dcn20_pipe_control_lock(
 	    dcn20_setup_gsl_group_as_lock(dc, pipe, false);
 
 	if (pipe->stream && should_use_dmub_lock(pipe->stream->link)) {
-		union dmub_hw_lock_flags hw_locks = { 0 };
-		struct dmub_hw_lock_inst_flags inst_flags = { 0 };
+		union dmub_hw_lock_flags hw_locks = { };
+		struct dmub_hw_lock_inst_flags inst_flags = { };
 
 		hw_locks.bits.lock_pipe = 1;
 		inst_flags.otg_inst =  pipe->stream_res.tg->inst;
@@ -1439,7 +1439,7 @@ static void dcn20_update_dchubp_dpp(
 			plane_state->update_flags.bits.input_csc_change ||
 			plane_state->update_flags.bits.color_space_change ||
 			plane_state->update_flags.bits.coeff_reduction_change) {
-		struct dc_bias_and_scale bns_params = {0};
+		struct dc_bias_and_scale bns_params = {};
 
 		// program the input csc
 		dpp->funcs->dpp_setup(dpp,
@@ -2003,7 +2003,7 @@ void dcn20_enable_stream_gating(struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 void dcn20_set_dmdata_attributes(struct pipe_ctx *pipe_ctx)
 {
-	struct dc_dmdata_attributes attr = { 0 };
+	struct dc_dmdata_attributes attr = { };
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
 
 	attr.dmdata_mode = DMDATA_HW_MODE;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
index 2f9bfaeaba8d..875c44c18174 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_link_encoder.c
@@ -397,7 +397,7 @@ void dcn20_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 	struct dcn10_link_encoder *enc10 = &enc20->enc10;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e3e01b17c164..0edf5fc02c87 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -450,7 +450,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 	.use_urgent_burst_bw = 0
 };
 
-static struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
+static struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { };
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
@@ -2015,7 +2015,7 @@ int dcn20_populate_dml_pipes_from_context(
 		unsigned int v_total;
 		unsigned int front_porch;
 		int output_bpc;
-		struct audio_check aud_check = {0};
+		struct audio_check aud_check = {};
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -3644,7 +3644,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (pool->base.pp_smu) {
-		struct pp_smu_nv_clock_table max_clocks = {0};
+		struct pp_smu_nv_clock_table max_clocks = {};
 		unsigned int uclk_states[8] = {0};
 		unsigned int num_states = 0;
 		enum pp_smu_status status;
@@ -3689,7 +3689,7 @@ static bool dcn20_resource_construct(
 	int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
-	struct ddc_service_init_data ddc_init_data = {0};
+	struct ddc_service_init_data ddc_init_data = {};
 	struct _vcs_dpi_soc_bounding_box_st *loaded_bb =
 			get_asic_rev_soc_bb(ctx->asic_id.hw_internal_rev);
 	struct _vcs_dpi_ip_params_st *loaded_ip =
@@ -3863,7 +3863,7 @@ static bool dcn20_resource_construct(
 	dml_init_instance(&dc->dml, loaded_bb, loaded_ip, dml_project_version);
 
 	if (!dc->debug.disable_pplib_wm_range) {
-		struct pp_smu_wm_range_sets ranges = {0};
+		struct pp_smu_wm_range_sets ranges = {};
 		int i = 0;
 
 		ranges.num_reader_wm_sets = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
index 3de1bcf9b3d8..f7ac97272ddd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
@@ -255,9 +255,9 @@ void hubp21_validate_dml_output(struct hubp *hubp,
 		struct _vcs_dpi_display_ttu_regs_st *dml_ttu_attr)
 {
 	struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
-	struct _vcs_dpi_display_rq_regs_st rq_regs = {0};
-	struct _vcs_dpi_display_dlg_regs_st dlg_attr = {0};
-	struct _vcs_dpi_display_ttu_regs_st ttu_attr = {0};
+	struct _vcs_dpi_display_rq_regs_st rq_regs = {};
+	struct _vcs_dpi_display_dlg_regs_st dlg_attr = {};
+	struct _vcs_dpi_display_ttu_regs_st ttu_attr = {};
 	DC_LOGGER_INIT(ctx->logger);
 	DC_LOG_DEBUG("DML Validation | Running Validation");
 
@@ -702,7 +702,7 @@ bool hubp21_program_surface_flip_and_addr(
 		const struct dc_plane_address *address,
 		bool flip_immediate)
 {
-	struct surface_flip_registers flip_regs = { 0 };
+	struct surface_flip_registers flip_regs = { };
 
 	flip_regs.vmid = address->vmid;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
index aa46c35b05a2..a4f4d2958cbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_link_encoder.c
@@ -339,7 +339,7 @@ void dcn21_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 	struct dcn10_link_encoder *enc10 = &enc21->enc10;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
index fa981cd04dd0..e29ce056b994 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_afmt.c
@@ -82,7 +82,7 @@ static void afmt3_setup_hdmi_audio(
 static union audio_cea_channels speakers_to_channels(
 	struct audio_speaker_flags speaker_flags)
 {
-	union audio_cea_channels cea_channels = {0};
+	union audio_cea_channels cea_channels = {};
 
 	/* these are one to one */
 	cea_channels.channels.FL = speaker_flags.FL_FR;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
index 46ea39f5ef8d..e628ca237a31 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
@@ -99,7 +99,7 @@ void dcn30_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 	struct dcn10_link_encoder *enc10 = &enc20->enc10;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 8487516819ef..9fbc9a727b14 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -491,7 +491,7 @@ void enc3_stream_encoder_dvi_set_stream_attribute(
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	if (!enc->ctx->dc->debug.avoid_vbios_exec_table) {
-		struct bp_encoder_control cntl = {0};
+		struct bp_encoder_control cntl = {};
 
 		cntl.action = ENCODER_CONTROL_SETUP;
 		cntl.engine_id = enc1->base.id;
@@ -538,7 +538,7 @@ static void enc3_stream_encoder_hdmi_set_stream_attribute(
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
 	if (!enc->ctx->dc->debug.avoid_vbios_exec_table) {
-		struct bp_encoder_control cntl = {0};
+		struct bp_encoder_control cntl = {};
 
 		cntl.action = ENCODER_CONTROL_SETUP;
 		cntl.engine_id = enc1->base.id;
@@ -715,7 +715,7 @@ static void enc3_se_setup_hdmi_audio(
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
 
-	struct audio_clock_info audio_clock_info = {0};
+	struct audio_clock_info audio_clock_info = {};
 
 	/* Setup audio in AFMT - program AFMT block associated with DIO */
 	ASSERT (enc->afmt);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index fafed1e4a998..664fd77e0602 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -263,7 +263,7 @@ bool dcn30_mmhubbub_warmup(
 {
 	struct dwbc *dwb;
 	struct mcif_wb *mcif_wb;
-	struct mcif_warmup_params warmup_params = {0};
+	struct mcif_warmup_params warmup_params = {};
 	unsigned int  i, i_buf;
 	/*make sure there is no active DWB eanbled */
 	for (i = 0; i < num_dwb; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index a0de309475a9..f05836b4990d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -1735,7 +1735,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	dcn20_patch_bounding_box(dc, loaded_bb);
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = {0};
+		struct bp_soc_bb_info bb_info = {};
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
 			if (bb_info.dram_clock_change_latency_100ns > 0)
@@ -2555,7 +2555,7 @@ static bool dcn30_resource_construct(
 	int i;
 	struct dc_context *ctx = dc->ctx;
 	struct irq_service_init_data init_data;
-	struct ddc_service_init_data ddc_init_data = {0};
+	struct ddc_service_init_data ddc_init_data = {};
 	uint32_t pipe_fuses = read_pipe_fuses(ctx);
 	uint32_t num_pipes = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c
index c9fbaed23965..fed5809aabb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c
@@ -86,7 +86,7 @@ void dcn301_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 	struct dcn10_link_encoder *enc10 = &enc20->enc10;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 912285fdce18..b8afa4915b35 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -1507,7 +1507,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	dcn20_patch_bounding_box(dc, loaded_bb);
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = {0};
+		struct bp_soc_bb_info bb_info = {};
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
 			if (bb_info.dram_clock_change_latency_100ns > 0)
@@ -1528,7 +1528,7 @@ static void set_wm_ranges(
 		struct pp_smu_funcs *pp_smu,
 		struct _vcs_dpi_soc_bounding_box_st *loaded_bb)
 {
-	struct pp_smu_wm_range_sets ranges = {0};
+	struct pp_smu_wm_range_sets ranges = {};
 	int i;
 
 	ranges.num_reader_wm_sets = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 7d3ff5d44402..90421665e86a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1104,7 +1104,7 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	dcn20_patch_bounding_box(dc, loaded_bb);
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = { 0 };
+		struct bp_soc_bb_info bb_info = { };
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
 			    dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index dc7823d23ba8..ec08a1710d1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1030,7 +1030,7 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	dcn20_patch_bounding_box(dc, loaded_bb);
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
-		struct bp_soc_bb_info bb_info = { 0 };
+		struct bp_soc_bb_info bb_info = { };
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
 			    dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
index 90127c1f9e35..0e07b9de1558 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_dio_link_encoder.c
@@ -230,7 +230,7 @@ void dcn31_link_encoder_construct(
 	const struct dcn10_link_enc_shift *link_shift,
 	const struct dcn10_link_enc_mask *link_mask)
 {
-	struct bp_encoder_cap_info bp_cap_info = {0};
+	struct bp_encoder_cap_info bp_cap_info = {};
 	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
 	enum bp_result result = BP_RESULT_OK;
 	struct dcn10_link_encoder *enc10 = &enc20->enc10;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
index d1656c9d50df..60ab6a1cf759 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h
@@ -86,7 +86,7 @@ struct bw_fixed bw_frc_to_fixed(int64_t num, int64_t denum);
 
 static inline struct bw_fixed fixed31_32_to_bw_fixed(int64_t raw)
 {
-	struct bw_fixed result = { 0 };
+	struct bw_fixed result = { };
 
 	if (raw < 0) {
 		raw = -raw;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index a6540e27044d..cd48192f62ad 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -390,7 +390,7 @@ union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
 
 void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
-	union dmub_fw_boot_options boot_options = {0};
+	union dmub_fw_boot_options boot_options = {};
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index fc667cb17eb0..60028e248559 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -335,7 +335,7 @@ union dmub_fw_boot_status dmub_dcn31_get_fw_boot_status(struct dmub_srv *dmub)
 
 void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
-	union dmub_fw_boot_options boot_options = {0};
+	union dmub_fw_boot_options boot_options = {};
 
 	boot_options.bits.z10_disable = params->disable_z10;
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
index ca0c8a54b635..2d16d57a9786 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_reg.c
@@ -72,7 +72,7 @@ static inline uint32_t get_reg_field_value_ex(uint32_t reg_value, uint32_t mask,
 void dmub_reg_update(struct dmub_srv *srv, uint32_t addr, int n, uint8_t shift1,
 		     uint32_t mask1, uint32_t field_value1, ...)
 {
-	struct dmub_reg_value_masks field_value_mask = { 0 };
+	struct dmub_reg_value_masks field_value_mask = { };
 	uint32_t reg_val;
 	va_list ap;
 
@@ -89,7 +89,7 @@ void dmub_reg_update(struct dmub_srv *srv, uint32_t addr, int n, uint8_t shift1,
 void dmub_reg_set(struct dmub_srv *srv, uint32_t addr, uint32_t reg_val, int n,
 		  uint8_t shift1, uint32_t mask1, uint32_t field_value1, ...)
 {
-	struct dmub_reg_value_masks field_value_mask = { 0 };
+	struct dmub_reg_value_masks field_value_mask = { };
 	va_list ap;
 
 	va_start(ap, field_value1);
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
index 70766d534c9c..7b5c5240c82d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv_stat.c
@@ -51,7 +51,7 @@ enum dmub_status dmub_srv_stat_get_notification(struct dmub_srv *dmub,
 	 * we shall not modify any dmub variables, only dmub->outbox1_rb
 	 * is exempted as it is exclusively accessed by this function
 	 */
-	union dmub_rb_out_cmd cmd = {0};
+	union dmub_rb_out_cmd cmd = {};
 
 	if (!dmub->hw_init) {
 		notify->type = DMUB_NOTIFICATION_NO_DATA;
diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 22053d7ea6ce..01ea0720dddd 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -64,7 +64,7 @@ struct fixed31_32 {
  * Useful constants
  */
 
-static const struct fixed31_32 dc_fixpt_zero = { 0 };
+static const struct fixed31_32 dc_fixpt_zero = { };
 static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
 static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
 static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2d55627b05b1..f6542a10c769 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -452,7 +452,7 @@ static ssize_t amdgpu_get_pp_cur_state(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	struct pp_states_info data = {0};
+	struct pp_states_info data = {};
 	enum amd_pm_state_type pm = 0;
 	int i = 0, ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 321215003643..6c0254f28bd3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1105,7 +1105,7 @@ static int pp_get_display_power_level(void *handle,
 static int pp_get_current_clocks(void *handle,
 		struct amd_pp_clock_info *clocks)
 {
-	struct amd_pp_simple_clock_info simple_clocks = { 0 };
+	struct amd_pp_simple_clock_info simple_clocks = { };
 	struct pp_clock_info hw_clocks;
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 1de3ae77e03e..61e46d30add1 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -188,7 +188,7 @@ static int smu10_construct_boot_state(struct pp_hwmgr *hwmgr)
 
 static int smu10_set_clock_limit(struct pp_hwmgr *hwmgr, const void *input)
 {
-	struct PP_Clocks clocks = {0};
+	struct PP_Clocks clocks = {};
 	struct pp_display_clock_request clock_req;
 
 	clocks.dcefClock = hwmgr->display_config->min_dcef_set_clk;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 465ff8d2a01a..eb51fd390283 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3262,7 +3262,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				cast_phw_smu7_power_state(&request_ps->hardware);
 	uint32_t sclk;
 	uint32_t mclk;
-	struct PP_Clocks minimum_clocks = {0};
+	struct PP_Clocks minimum_clocks = {};
 	bool disable_mclk_switching;
 	bool disable_mclk_switching_for_frame_lock;
 	bool disable_mclk_switching_for_display;
@@ -4018,7 +4018,7 @@ static int smu7_find_dpm_states_clocks_in_dpm_table(struct pp_hwmgr *hwmgr, cons
 	struct smu7_single_dpm_table *mclk_table = &(data->dpm_table.mclk_table);
 	uint32_t mclk = smu7_ps->performance_levels
 			[smu7_ps->performance_level_count - 1].memory_clock;
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	uint32_t i;
 
 	for (i = 0; i < sclk_table->count; i++) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index c152a61ddd2c..d8f943cdfc41 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -311,7 +311,7 @@ static int vega10_odn_initial_default_setting(struct pp_hwmgr *hwmgr)
 	struct phm_ppt_v1_voltage_lookup_table *vddc_lookup_table;
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_table[3];
 	struct phm_ppt_v1_clock_voltage_dependency_table *od_table[3];
-	struct pp_atomfwctrl_avfs_parameters avfs_params = {0};
+	struct pp_atomfwctrl_avfs_parameters avfs_params = {};
 	uint32_t i;
 	int result;
 
@@ -2167,7 +2167,7 @@ static int vega10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 			(struct phm_ppt_v2_information *)(hwmgr->pptable);
 	struct phm_ppt_v1_clock_voltage_dependency_table *dep_table =
 			table_info->vdd_dep_on_sclk;
-	struct pp_atomfwctrl_avfs_parameters avfs_params = {0};
+	struct pp_atomfwctrl_avfs_parameters avfs_params = {};
 	int result = 0;
 	uint32_t i;
 
@@ -2398,7 +2398,7 @@ static int vega10_populate_gpio_parameters(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
-	struct pp_atomfwctrl_gpio_parameters gpio_params = {0};
+	struct pp_atomfwctrl_gpio_parameters gpio_params = {};
 	int result;
 
 	result = pp_atomfwctrl_get_gpio_information(hwmgr, &gpio_params);
@@ -3241,7 +3241,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				cast_phw_vega10_power_state(&request_ps->hardware);
 	uint32_t sclk;
 	uint32_t mclk;
-	struct PP_Clocks minimum_clocks = {0};
+	struct PP_Clocks minimum_clocks = {};
 	bool disable_mclk_switching;
 	bool disable_mclk_switching_for_frame_lock;
 	bool disable_mclk_switching_for_vr;
@@ -4044,7 +4044,7 @@ static int vega10_notify_smc_display_config_after_ps_adjustment(
 			(struct phm_ppt_v2_information *)hwmgr->pptable;
 	struct phm_ppt_v1_clock_voltage_dependency_table *mclk_table = table_info->vdd_dep_on_mclk;
 	uint32_t idx;
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	uint32_t i;
 	struct pp_display_clock_request clock_req;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 8558718e15a8..0603a74f4cfa 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1586,7 +1586,7 @@ static int vega12_notify_smc_display_config_after_ps_adjustment(
 {
 	struct vega12_hwmgr *data =
 			(struct vega12_hwmgr *)(hwmgr->backend);
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	struct pp_display_clock_request clock_req;
 
 	if ((hwmgr->display_config->num_display > 1) &&
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 0cf39c1244b1..cbffc4b595d9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2339,7 +2339,7 @@ static int vega20_notify_smc_display_config_after_ps_adjustment(
 			(struct vega20_hwmgr *)(hwmgr->backend);
 	struct vega20_single_dpm_table *dpm_table =
 			&data->dpm_table.mem_table;
-	struct PP_Clocks min_clocks = {0};
+	struct PP_Clocks min_clocks = {};
 	struct pp_display_clock_request clock_req;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 93a1c7248e26..f81fc4f7c2b8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2314,7 +2314,7 @@ static int ci_load_smc_ucode(struct pp_hwmgr *hwmgr)
 	uint8_t *src;
 	uint32_t data;
 
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	cgs_get_firmware_info(hwmgr->device, CGS_UCODE_ID_SMU, &info);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 03df35dee8ba..54971bf1414c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -184,7 +184,7 @@ static int iceland_upload_smc_firmware_data(struct pp_hwmgr *hwmgr,
 static int iceland_smu_upload_firmware_image(struct pp_hwmgr *hwmgr)
 {
 	uint32_t val;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index 45214a364baa..85839d262118 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -1774,7 +1774,7 @@ static int polaris10_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 
 	SMU74_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
 	int result = 0;
-	struct pp_atom_ctrl__avfs_parameters avfs_params = {0};
+	struct pp_atom_ctrl__avfs_parameters avfs_params = {};
 	AVFS_meanNsigma_t AVFS_meanNsigma = { {0} };
 	AVFS_Sclk_Offset_t AVFS_SclkOffset = { {0} };
 	uint32_t tmp, i;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
index aae25243eb10..4dc109640fda 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
@@ -289,7 +289,7 @@ static int smu7_populate_single_firmware_entry(struct pp_hwmgr *hwmgr,
 						struct SMU_Entry *entry)
 {
 	int result = 0;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	result = cgs_get_firmware_info(hwmgr->device,
 				smu7_convert_fw_type_to_cgs(fw_type),
@@ -473,7 +473,7 @@ int smu7_upload_smu_firmware_image(struct pp_hwmgr *hwmgr)
 	int result = 0;
 	struct smu7_smumgr *smu_data = (struct smu7_smumgr *)(hwmgr->smu_backend);
 
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	if (smu_data->security_hard_key == 1)
 		cgs_get_firmware_info(hwmgr->device,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c
index 76d4f12ceedf..0b816f93caa2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu8_smumgr.c
@@ -176,7 +176,7 @@ static int smu8_load_mec_firmware(struct pp_hwmgr *hwmgr)
 	uint32_t reg_data;
 	uint32_t tmp;
 	int ret = 0;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	if (hwmgr == NULL || hwmgr->device == NULL)
 		return -EINVAL;
@@ -550,7 +550,7 @@ static int smu8_smu_populate_firmware_entries(struct pp_hwmgr *hwmgr)
 	uint32_t i;
 	int ret;
 	enum cgs_ucode_id ucode_id;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	smu8_smu->driver_buffer_length = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index a70d73896649..24af01d43f17 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -206,7 +206,7 @@ static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 	struct vega10_smumgr *priv;
 	unsigned long tools_size;
 	int ret;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	ret = cgs_get_firmware_info(hwmgr->device,
 					CGS_UCODE_ID_SMU,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
index b52ce135d84d..a5ce168d4bc8 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
@@ -213,7 +213,7 @@ static int vega12_smu_init(struct pp_hwmgr *hwmgr)
 {
 	struct vega12_smumgr *priv;
 	unsigned long tools_size;
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 	int ret;
 
 	ret = cgs_get_firmware_info(hwmgr->device, CGS_UCODE_ID_SMU,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index 741fbc87467f..103e6d7bcbdd 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -422,7 +422,7 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
 	int ret = 0;
 	struct amdgpu_device *adev = hwmgr->adev;
 
-	struct cgs_firmware_info info = {0};
+	struct cgs_firmware_info info = {};
 
 	ret = cgs_get_firmware_info(hwmgr->device,
 				smu7_convert_fw_type_to_cgs(UCODE_ID_SMU),
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
index 7d024d3facef..0c2650ec4c50 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vegam_smumgr.c
@@ -1566,7 +1566,7 @@ static int vegam_populate_avfs_parameters(struct pp_hwmgr *hwmgr)
 
 	SMU75_Discrete_DpmTable  *table = &(smu_data->smc_state_table);
 	int result = 0;
-	struct pp_atom_ctrl__avfs_parameters avfs_params = {0};
+	struct pp_atom_ctrl__avfs_parameters avfs_params = {};
 	AVFS_meanNsigma_t AVFS_meanNsigma = { {0} };
 	AVFS_Sclk_Offset_t AVFS_SclkOffset = { {0} };
 	uint32_t tmp, i;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index f96681700c41..03df2d03399c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1883,7 +1883,7 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 
 static int navi10_notify_smc_display_config(struct smu_context *smu)
 {
-	struct smu_clocks min_clocks = {0};
+	struct smu_clocks min_clocks = {};
 	struct pp_display_clock_request clock_req;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 5e292c3f5050..348c16124e4d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1565,7 +1565,7 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 
 static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 {
-	struct smu_clocks min_clocks = {0};
+	struct smu_clocks min_clocks = {};
 	struct pp_display_clock_request clock_req;
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 87b055466a33..22d4f2c90ab3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -521,7 +521,7 @@ static int smu_v11_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
 					    uint8_t syspll_id,
 					    uint32_t *clk_freq)
 {
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
+	struct atom_get_smu_clock_info_parameters_v3_1 input = {};
 	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
 	int ret, index;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index d60b8c5e8715..d2f7c9081022 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -285,7 +285,7 @@ static int smu_v12_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
 					    uint8_t syspll_id,
 					    uint32_t *clk_freq)
 {
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
+	struct atom_get_smu_clock_info_parameters_v3_1 input = {};
 	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
 	int ret, index;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a0e50f23b1dd..73cf0c927529 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -481,7 +481,7 @@ static int smu_v13_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
 					    uint8_t syspll_id,
 					    uint32_t *clk_freq)
 {
-	struct atom_get_smu_clock_info_parameters_v3_1 input = {0};
+	struct atom_get_smu_clock_info_parameters_v3_1 input = {};
 	struct atom_get_smu_clock_info_output_parameters_v3_1 *output;
 	int ret, index;
 
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 6d0f2c447f3b..43ef727adab7 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -3530,7 +3530,7 @@ static const struct backlight_ops dp_aux_bl_ops = {
 int drm_panel_dp_aux_backlight(struct drm_panel *panel, struct drm_dp_aux *aux)
 {
 	struct dp_aux_backlight *bl;
-	struct backlight_properties props = { 0 };
+	struct backlight_properties props = { };
 	u16 current_level;
 	u8 current_mode;
 	u8 edp_dpcd[EDP_DISPLAY_CTL_CAP_SIZE];
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 5147f5929be7..b0294bbd3338 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -105,7 +105,7 @@ static int exynos_drm_fbdev_create(struct drm_fb_helper *helper,
 	struct exynos_drm_fbdev *exynos_fbdev = to_exynos_fbdev(helper);
 	struct exynos_drm_gem *exynos_gem;
 	struct drm_device *dev = helper->dev;
-	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
+	struct drm_mode_fb_cmd2 mode_cmd = { };
 	unsigned long size;
 	int ret;
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index e5662bdcbbde..ed54b42b9e3f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -382,7 +382,7 @@ static int vidi_bind(struct device *dev, struct device *master, void *data)
 	struct drm_device *drm_dev = data;
 	struct drm_encoder *encoder = &ctx->encoder;
 	struct exynos_drm_plane *exynos_plane;
-	struct exynos_drm_plane_config plane_config = { 0 };
+	struct exynos_drm_plane_config plane_config = { };
 	unsigned int i;
 	int ret;
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_sdvo.c b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
index 355da2856389..5f566b9ddf95 100644
--- a/drivers/gpu/drm/gma500/psb_intel_sdvo.c
+++ b/drivers/gpu/drm/gma500/psb_intel_sdvo.c
@@ -582,7 +582,7 @@ psb_intel_sdvo_get_value(struct psb_intel_sdvo *psb_intel_sdvo, u8 cmd, void *va
 
 static bool psb_intel_sdvo_set_target_input(struct psb_intel_sdvo *psb_intel_sdvo)
 {
-	struct psb_intel_sdvo_set_target_input_args targets = {0};
+	struct psb_intel_sdvo_set_target_input_args targets = {};
 	return psb_intel_sdvo_set_value(psb_intel_sdvo,
 				    SDVO_CMD_SET_TARGET_INPUT,
 				    &targets, sizeof(targets));
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 89bed78f1466..f06f913a925b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -232,7 +232,7 @@ hibmc_crtc_mode_valid(struct drm_crtc *crtc,
 static u32 format_pll_reg(void)
 {
 	u32 pllreg = 0;
-	struct hibmc_display_panel_pll pll = {0};
+	struct hibmc_display_panel_pll pll = {};
 
 	/*
 	 * Note that all PLL's have the same format. Here,
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 134a6acbd8fb..39accb0859f4 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -1757,7 +1757,7 @@ intel_alloc_initial_plane_obj(struct intel_crtc *crtc,
 {
 	struct drm_device *dev = crtc->base.dev;
 	struct drm_i915_private *dev_priv = to_i915(dev);
-	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
+	struct drm_mode_fb_cmd2 mode_cmd = { };
 	struct drm_framebuffer *fb = &plane_config->fb->base;
 	struct i915_vma *vma;
 
@@ -9215,7 +9215,7 @@ verify_mpllb_state(struct intel_atomic_state *state,
 		   struct intel_crtc_state *new_crtc_state)
 {
 	struct drm_i915_private *i915 = to_i915(state->base.dev);
-	struct intel_mpllb_state mpllb_hw_state = { 0 };
+	struct intel_mpllb_state mpllb_hw_state = { };
 	struct intel_mpllb_state *mpllb_sw_state = &new_crtc_state->mpllb_state;
 	struct intel_crtc *crtc = to_intel_crtc(new_crtc_state->uapi.crtc);
 	struct intel_encoder *encoder;
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index 5c91d125a337..cc15efe1ad69 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -1572,7 +1572,7 @@ static bool skl_ddi_hdmi_pll_dividers(struct intel_crtc_state *crtc_state)
 {
 	struct drm_i915_private *i915 = to_i915(crtc_state->uapi.crtc->dev);
 	u32 ctrl1, cfgcr1, cfgcr2;
-	struct skl_wrpll_params wrpll_params = { 0, };
+	struct skl_wrpll_params wrpll_params = { };
 
 	/*
 	 * See comment in intel_dpll_hw_state to understand why we always use 0
diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
index 6cb27599ea03..e5e425c89ed3 100644
--- a/drivers/gpu/drm/i915/display/intel_sdvo.c
+++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
@@ -653,7 +653,7 @@ intel_sdvo_get_value(struct intel_sdvo *intel_sdvo, u8 cmd, void *value, int len
 
 static bool intel_sdvo_set_target_input(struct intel_sdvo *intel_sdvo)
 {
-	struct intel_sdvo_set_target_input_args targets = {0};
+	struct intel_sdvo_set_target_input_args targets = {};
 	return intel_sdvo_set_value(intel_sdvo,
 				    SDVO_CMD_SET_TARGET_INPUT,
 				    &targets, sizeof(targets));
diff --git a/drivers/gpu/drm/i915/gvt/handlers.c b/drivers/gpu/drm/i915/gvt/handlers.c
index cde0a477fb49..6acfc2712728 100644
--- a/drivers/gpu/drm/i915/gvt/handlers.c
+++ b/drivers/gpu/drm/i915/gvt/handlers.c
@@ -541,7 +541,7 @@ static u32 bxt_vgpu_get_dp_bitrate(struct intel_vgpu *vgpu, enum port port)
 	int refclk = vgpu->gvt->gt->i915->dpll.ref_clks.nssc;
 	enum dpio_phy phy = DPIO_PHY0;
 	enum dpio_channel ch = DPIO_CH0;
-	struct dpll clock = {0};
+	struct dpll clock = {};
 	u32 temp;
 
 	/* Port to PHY mapping is fixed, see bxt_ddi_phy_info{} */
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 7b8d7178d09a..2000c04fbcda 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -107,7 +107,7 @@ static int lima_ioctl_gem_submit(struct drm_device *dev, void *data, struct drm_
 	struct lima_sched_pipe *pipe;
 	struct lima_sched_task *task;
 	struct lima_ctx *ctx;
-	struct lima_submit submit = {0};
+	struct lima_submit submit = {};
 	size_t size;
 	int err = 0;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 4554e2de1430..83bbde16888b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -452,11 +452,11 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 	struct mtk_dpi_yc_limit limit;
 	struct mtk_dpi_polarities dpi_pol;
 	struct mtk_dpi_sync_param hsync;
-	struct mtk_dpi_sync_param vsync_lodd = { 0 };
-	struct mtk_dpi_sync_param vsync_leven = { 0 };
-	struct mtk_dpi_sync_param vsync_rodd = { 0 };
-	struct mtk_dpi_sync_param vsync_reven = { 0 };
-	struct videomode vm = { 0 };
+	struct mtk_dpi_sync_param vsync_lodd = { };
+	struct mtk_dpi_sync_param vsync_leven = { };
+	struct mtk_dpi_sync_param vsync_rodd = { };
+	struct mtk_dpi_sync_param vsync_reven = { };
+	struct videomode vm = { };
 	unsigned long pll_rate;
 	unsigned int factor;
 
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 5e2750eb3810..bdc4d1c3ae68 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1491,7 +1491,7 @@ static const struct {
 static void a5xx_gpu_state_get_hlsq_regs(struct msm_gpu *gpu,
 		struct a5xx_gpu_state *a5xx_state)
 {
-	struct a5xx_crashdumper dumper = { 0 };
+	struct a5xx_crashdumper dumper = { };
 	u32 offset, count = 0;
 	u64 *ptr;
 	int i;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index e8f65cd8eca6..483608729536 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -919,7 +919,7 @@ static void a6xx_get_indexed_registers(struct msm_gpu *gpu,
 
 struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 {
-	struct a6xx_crashdumper _dumper = { 0 }, *dumper = NULL;
+	struct a6xx_crashdumper _dumper = { }, *dumper = NULL;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gpu_state *a6xx_state = kzalloc(sizeof(*a6xx_state),
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index d4c65bf0a1b7..0f758ade457b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -187,7 +187,7 @@ static int a6xx_hfi_send_msg(struct a6xx_gmu *gmu, int id,
 
 static int a6xx_hfi_send_gmu_init(struct a6xx_gmu *gmu, int boot_state)
 {
-	struct a6xx_hfi_msg_gmu_init_cmd msg = { 0 };
+	struct a6xx_hfi_msg_gmu_init_cmd msg = { };
 
 	msg.dbg_buffer_addr = (u32) gmu->debug.iova;
 	msg.dbg_buffer_size = (u32) gmu->debug.size;
@@ -199,7 +199,7 @@ static int a6xx_hfi_send_gmu_init(struct a6xx_gmu *gmu, int boot_state)
 
 static int a6xx_hfi_get_fw_version(struct a6xx_gmu *gmu, u32 *version)
 {
-	struct a6xx_hfi_msg_fw_version msg = { 0 };
+	struct a6xx_hfi_msg_fw_version msg = { };
 
 	/* Currently supporting version 1.1 */
 	msg.supported_version = (1 << 28) | (1 << 16);
@@ -210,7 +210,7 @@ static int a6xx_hfi_get_fw_version(struct a6xx_gmu *gmu, u32 *version)
 
 static int a6xx_hfi_send_perf_table_v1(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_msg_perf_table_v1 msg = { 0 };
+	struct a6xx_hfi_msg_perf_table_v1 msg = { };
 	int i;
 
 	msg.num_gpu_levels = gmu->nr_gpu_freqs;
@@ -232,7 +232,7 @@ static int a6xx_hfi_send_perf_table_v1(struct a6xx_gmu *gmu)
 
 static int a6xx_hfi_send_perf_table(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_msg_perf_table msg = { 0 };
+	struct a6xx_hfi_msg_perf_table msg = { };
 	int i;
 
 	msg.num_gpu_levels = gmu->nr_gpu_freqs;
@@ -452,7 +452,7 @@ static void a6xx_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
 
 static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_msg_bw_table msg = { 0 };
+	struct a6xx_hfi_msg_bw_table msg = { };
 	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 
@@ -475,7 +475,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
 
 static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_msg_test msg = { 0 };
+	struct a6xx_hfi_msg_test msg = { };
 
 	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_TEST, &msg, sizeof(msg),
 		NULL, 0);
@@ -483,7 +483,7 @@ static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
 
 static int a6xx_hfi_send_start(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_msg_start msg = { 0 };
+	struct a6xx_hfi_msg_start msg = { };
 
 	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_START, &msg, sizeof(msg),
 		NULL, 0);
@@ -491,7 +491,7 @@ static int a6xx_hfi_send_start(struct a6xx_gmu *gmu)
 
 static int a6xx_hfi_send_core_fw_start(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_msg_core_fw_start msg = { 0 };
+	struct a6xx_hfi_msg_core_fw_start msg = { };
 
 	return a6xx_hfi_send_msg(gmu, HFI_H2F_MSG_CORE_FW_START, &msg,
 		sizeof(msg), NULL, 0);
@@ -499,7 +499,7 @@ static int a6xx_hfi_send_core_fw_start(struct a6xx_gmu *gmu)
 
 int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index)
 {
-	struct a6xx_hfi_gx_bw_perf_vote_cmd msg = { 0 };
+	struct a6xx_hfi_gx_bw_perf_vote_cmd msg = { };
 
 	msg.ack_type = 1; /* blocking */
 	msg.freq = index;
@@ -511,7 +511,7 @@ int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, int index)
 
 int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu)
 {
-	struct a6xx_hfi_prep_slumber_cmd msg = { 0 };
+	struct a6xx_hfi_prep_slumber_cmd msg = { };
 
 	/* TODO: should freq and bw fields be non-zero ? */
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 748665232d29..944efa2e1c20 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -925,7 +925,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct adreno_platform_config *config = dev->platform_data;
-	struct msm_gpu_config adreno_gpu_config  = { 0 };
+	struct msm_gpu_config adreno_gpu_config  = { };
 	struct msm_gpu *gpu = &adreno_gpu->base;
 
 	adreno_gpu->funcs = funcs;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
index 60fe06018581..2b5a1b729680 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_perf.c
@@ -209,7 +209,7 @@ int dpu_core_perf_crtc_check(struct drm_crtc *crtc,
 static int _dpu_core_perf_crtc_update_bus(struct dpu_kms *kms,
 		struct drm_crtc *crtc)
 {
-	struct dpu_core_perf_params perf = { 0 };
+	struct dpu_core_perf_params perf = { };
 	enum dpu_crtc_client_type curr_client_type
 					= dpu_crtc_get_client_type(crtc);
 	struct drm_crtc *tmp_crtc;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 768012243b44..d04e237038c5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -917,7 +917,7 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 	int multirect_count = 0;
 	const struct drm_plane_state *pipe_staged[SSPP_MAX];
 	int left_zpos_cnt = 0, right_zpos_cnt = 0;
-	struct drm_rect crtc_rect = { 0 };
+	struct drm_rect crtc_rect = { };
 
 	pstates = kzalloc(sizeof(*pstates) * DPU_STAGE_MAX * 4, GFP_KERNEL);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 0e9d3fa1544b..71a275a14be1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -216,7 +216,7 @@ static u32 dither_matrix[DITHER_MATRIX_SZ] = {
 
 static void _dpu_encoder_setup_dither(struct dpu_hw_pingpong *hw_pp, unsigned bpc)
 {
-	struct dpu_hw_dither_cfg dither_cfg = { 0 };
+	struct dpu_hw_dither_cfg dither_cfg = { };
 
 	if (!hw_pp->ops.setup_dither)
 		return;
@@ -485,7 +485,7 @@ void dpu_encoder_helper_split_config(
 		enum dpu_intf interface)
 {
 	struct dpu_encoder_virt *dpu_enc;
-	struct split_pipe_cfg cfg = { 0 };
+	struct split_pipe_cfg cfg = { };
 	struct dpu_hw_mdp *hw_mdptop;
 	struct msm_display_info *disp_info;
 
@@ -534,7 +534,7 @@ static struct msm_display_topology dpu_encoder_get_topology(
 			struct dpu_kms *dpu_kms,
 			struct drm_display_mode *mode)
 {
-	struct msm_display_topology topology = {0};
+	struct msm_display_topology topology = {};
 	int i, intf_count = 0;
 
 	for (i = 0; i < MAX_PHYS_ENCODERS_PER_VIRTUAL; i++)
@@ -648,7 +648,7 @@ static int dpu_encoder_virt_atomic_check(
 static void _dpu_encoder_update_vsync_source(struct dpu_encoder_virt *dpu_enc,
 			struct msm_display_info *disp_info)
 {
-	struct dpu_vsync_source_cfg vsync_cfg = { 0 };
+	struct dpu_vsync_source_cfg vsync_cfg = { };
 	struct msm_drm_private *priv;
 	struct dpu_kms *dpu_kms;
 	struct dpu_hw_mdp *hw_mdptop;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index aa01698d6b25..343a00fbd2ba 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -60,7 +60,7 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
 	struct dpu_encoder_phys_cmd *cmd_enc =
 			to_dpu_encoder_phys_cmd(phys_enc);
 	struct dpu_hw_ctl *ctl;
-	struct dpu_hw_intf_cfg intf_cfg = { 0 };
+	struct dpu_hw_intf_cfg intf_cfg = { };
 
 	ctl = phys_enc->hw_ctl;
 	if (!ctl->ops.setup_intf_cfg)
@@ -324,7 +324,7 @@ static void dpu_encoder_phys_cmd_tearcheck_config(
 {
 	struct dpu_encoder_phys_cmd *cmd_enc =
 		to_dpu_encoder_phys_cmd(phys_enc);
-	struct dpu_hw_tear_check tc_cfg = { 0 };
+	struct dpu_hw_tear_check tc_cfg = { };
 	struct drm_display_mode *mode;
 	bool tc_enable = true;
 	u32 vsync_hz;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
index 185379b18572..20253de27329 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_vid.c
@@ -196,7 +196,7 @@ static u32 programmable_fetch_get_num_lines(
 static void programmable_fetch_config(struct dpu_encoder_phys *phys_enc,
 				      const struct intf_timing_params *timing)
 {
-	struct intf_prog_fetch f = { 0 };
+	struct intf_prog_fetch f = { };
 	u32 vfp_fetch_lines = 0;
 	u32 horiz_total = 0;
 	u32 vert_total = 0;
@@ -242,11 +242,11 @@ static void dpu_encoder_phys_vid_setup_timing_engine(
 		struct dpu_encoder_phys *phys_enc)
 {
 	struct drm_display_mode mode;
-	struct intf_timing_params timing_params = { 0 };
+	struct intf_timing_params timing_params = { };
 	const struct dpu_format *fmt = NULL;
 	u32 fmt_fourcc = DRM_FORMAT_RGB888;
 	unsigned long lock_flags;
-	struct dpu_hw_intf_cfg intf_cfg = { 0 };
+	struct dpu_hw_intf_cfg intf_cfg = { };
 
 	if (!phys_enc->hw_ctl->ops.setup_intf_cfg) {
 		DPU_ERROR("invalid encoder %d\n", phys_enc != NULL);
@@ -650,7 +650,7 @@ static int dpu_encoder_phys_vid_get_line_count(
 static int dpu_encoder_phys_vid_get_frame_count(
 		struct dpu_encoder_phys *phys_enc)
 {
-	struct intf_status s = {0};
+	struct intf_status s = {};
 	u32 fetch_start = 0;
 	struct drm_display_mode mode = phys_enc->cached_mode;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index c989621209aa..e5492b473ed9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -957,7 +957,7 @@ static int dpu_plane_atomic_check(struct drm_plane *plane,
 	struct dpu_plane_state *pstate = to_dpu_plane_state(new_plane_state);
 	const struct drm_crtc_state *crtc_state = NULL;
 	const struct dpu_format *fmt;
-	struct drm_rect src, dst, fb_rect = { 0 };
+	struct drm_rect src, dst, fb_rect = { };
 	uint32_t min_src_size, max_linewidth;
 
 	if (new_plane_state->crtc)
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 62e75dc8afc6..19af6491eed9 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1229,7 +1229,7 @@ static int dp_ctrl_link_train(struct dp_ctrl_private *ctrl,
 {
 	int ret = 0;
 	u8 encoding = DP_SET_ANSI_8B10B;
-	struct dp_link_info link_info = {0};
+	struct dp_link_info link_info = {};
 
 	dp_ctrl_config_ctrl(ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index a5bdfc5029de..2826c613186e 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -992,10 +992,10 @@ static bool dp_link_is_audio_pattern_requested(struct dp_link_private *link)
 
 static void dp_link_reset_data(struct dp_link_private *link)
 {
-	link->request = (const struct dp_link_request){ 0 };
-	link->dp_link.test_video = (const struct dp_link_test_video){ 0 };
+	link->request = (const struct dp_link_request){ };
+	link->dp_link.test_video = (const struct dp_link_test_video){ };
 	link->dp_link.test_video.test_bit_depth = DP_TEST_BIT_DEPTH_UNKNOWN;
-	link->dp_link.test_audio = (const struct dp_link_test_audio){ 0 };
+	link->dp_link.test_audio = (const struct dp_link_test_audio){ };
 	link->dp_link.phy_params.phy_test_pattern_sel = 0;
 	link->dp_link.sink_request = 0;
 	link->dp_link.test_response = 0;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index fdc5367aecaa..bfe143e37940 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -552,7 +552,7 @@ static struct drm_syncobj **msm_parse_deps(struct msm_gem_submit *submit,
                                            struct msm_ringbuffer *ring)
 {
 	struct drm_syncobj **syncobjs = NULL;
-	struct drm_msm_gem_submit_syncobj syncobj_desc = {0};
+	struct drm_msm_gem_submit_syncobj syncobj_desc = {};
 	int ret = 0;
 	uint32_t i, j;
 
@@ -631,7 +631,7 @@ static struct msm_submit_post_dep *msm_parse_post_deps(struct drm_device *dev,
                                                        size_t syncobj_stride)
 {
 	struct msm_submit_post_dep *post_deps;
-	struct drm_msm_gem_submit_syncobj syncobj_desc = {0};
+	struct drm_msm_gem_submit_syncobj syncobj_desc = {};
 	int ret = 0;
 	uint32_t i, j;
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index 1cbd71abc80a..e75fa3884b4d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -353,7 +353,7 @@ nouveau_backlight_init(struct drm_connector *connector)
 	struct nouveau_encoder *nv_encoder = NULL;
 	struct nvif_device *device = &drm->client.device;
 	char backlight_name[BL_NAME_SIZE];
-	struct backlight_properties props = {0};
+	struct backlight_properties props = {};
 	const struct backlight_ops *ops;
 	int ret;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
index bbfde1cb3a17..e6bc6e043175 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgt215.c
@@ -161,7 +161,7 @@ gt215_link_train(struct gt215_ram *ram)
 	struct nvkm_clk *clk = device->clk;
 	u32 *result, r1700;
 	int ret, i;
-	struct nvbios_M0205T M0205T = { 0 };
+	struct nvbios_M0205T M0205T = { };
 	u8 ver, hdr, cnt, len, snr, ssz;
 	unsigned int clk_current;
 	unsigned long flags;
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 5f1722b040f4..c3014c9fb54e 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -3631,7 +3631,7 @@ static void print_dispc_vm(const char *str, const struct videomode *vm)
 static void print_dsi_dispc_vm(const char *str,
 		const struct omap_dss_dsi_videomode_timings *t)
 {
-	struct videomode vm = { 0 };
+	struct videomode vm = { };
 	unsigned long byteclk = t->hsclk / 4;
 	unsigned long pck;
 	u64 dsi_tput;
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index 35b750cebaeb..b3fd02937f26 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -147,7 +147,7 @@ static int hdmi_power_on_full(struct omap_hdmi *hdmi)
 	int r;
 	const struct videomode *vm;
 	struct hdmi_wp_data *wp = &hdmi->wp;
-	struct dss_pll_clock_info hdmi_cinfo = { 0 };
+	struct dss_pll_clock_info hdmi_cinfo = { };
 	unsigned int pc;
 
 	r = hdmi_power_on_core(hdmi);
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
index 35faa7f028c4..7992a1a8cfb7 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4_core.c
@@ -261,7 +261,7 @@ void hdmi4_configure(struct hdmi_core_data *core,
 	struct hdmi_video_format video_format;
 	/* HDMI core */
 	struct hdmi_core_video_config v_core_cfg;
-	struct hdmi_core_packet_enable_repeat repeat_cfg = { 0 };
+	struct hdmi_core_packet_enable_repeat repeat_cfg = { };
 
 	hdmi_core_init(&v_core_cfg);
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index 65085d886da5..467d119a6e80 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -145,7 +145,7 @@ static int hdmi_power_on_full(struct omap_hdmi *hdmi)
 {
 	int r;
 	const struct videomode *vm;
-	struct dss_pll_clock_info hdmi_cinfo = { 0 };
+	struct dss_pll_clock_info hdmi_cinfo = { };
 	unsigned int pc;
 
 	r = hdmi_power_on_core(hdmi);
diff --git a/drivers/gpu/drm/omapdrm/omap_crtc.c b/drivers/gpu/drm/omapdrm/omap_crtc.c
index 06a719c104f4..30205fa668c9 100644
--- a/drivers/gpu/drm/omapdrm/omap_crtc.c
+++ b/drivers/gpu/drm/omapdrm/omap_crtc.c
@@ -502,7 +502,7 @@ static enum drm_mode_status omap_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct omap_drm_private *priv = crtc->dev->dev_private;
 	struct omap_crtc *omap_crtc = to_omap_crtc(crtc);
-	struct videomode vm = {0};
+	struct videomode vm = {};
 	int r;
 
 	drm_display_mode_to_videomode(mode, &vm);
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index ed770caf55c2..460479fdf231 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -777,7 +777,7 @@ static int omap_dmm_remove(struct platform_device *dev)
 static int omap_dmm_probe(struct platform_device *dev)
 {
 	int ret = -EFAULT, i;
-	struct tcm_area area = {0};
+	struct tcm_area area = {};
 	u32 hwinfo, pat_geom;
 	struct resource *mem;
 
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 4dd05bc732da..e461d5eec42b 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -78,7 +78,7 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 	struct drm_device *dev = encoder->dev;
 	struct drm_connector *connector;
 	struct drm_bridge *bridge;
-	struct videomode vm = { 0 };
+	struct videomode vm = { };
 	u32 bus_flags;
 
 	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index 42eac6ad12bd..5f679d426cf1 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -96,7 +96,7 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	struct drm_framebuffer *fb = NULL;
 	union omap_gem_size gsize;
 	struct fb_info *fbi = NULL;
-	struct drm_mode_fb_cmd2 mode_cmd = {0};
+	struct drm_mode_fb_cmd2 mode_cmd = {};
 	dma_addr_t dma_addr;
 	int ret;
 
diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index da4a69067e18..aed3720989e0 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -551,7 +551,7 @@ static int dsicm_probe(struct mipi_dsi_device *dsi)
 		       DRM_MODE_CONNECTOR_DSI);
 
 	if (ddata->use_dsi_backlight) {
-		struct backlight_properties props = { 0 };
+		struct backlight_properties props = { };
 		props.max_brightness = 255;
 		props.type = BACKLIGHT_RAW;
 
diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 81b4de7be9f2..cb75d368b5f2 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -5136,7 +5136,7 @@ static void kv_restore_regs_for_reset(struct radeon_device *rdev,
 static void cik_gpu_pci_config_reset(struct radeon_device *rdev)
 {
 	struct evergreen_mc_save save;
-	struct kv_reset_save_regs kv_save = { 0 };
+	struct kv_reset_save_regs kv_save = { };
 	u32 tmp, i;
 
 	dev_info(rdev->dev, "GPU pci config reset\n");
diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index fdddbbaecbb7..00097008d43e 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -1070,7 +1070,7 @@ static int cypress_initialize_mc_reg_table(struct radeon_device *rdev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(rdev);
 	u8 module_index = rv770_get_memory_module_index(rdev);
-	struct atom_memory_clock_range_table range_table = { 0 };
+	struct atom_memory_clock_range_table range_table = { };
 	int ret;
 
 	ret = radeon_atom_get_mclk_range_table(rdev,
diff --git a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
index ea7e39d03545..e9c3cd9b861e 100644
--- a/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
+++ b/drivers/gpu/drm/rcar-du/rcar_du_crtc.c
@@ -220,7 +220,7 @@ static void rcar_du_crtc_set_display_timing(struct rcar_du_crtc *rcrtc)
 
 	if (rcdu->info->dpll_mask & (1 << rcrtc->index)) {
 		unsigned long target = mode_clock;
-		struct dpll_info dpll = { 0 };
+		struct dpll_info dpll = { };
 		unsigned long extclk;
 		u32 dpllcr;
 		u32 div = 0;
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index 2fdc455c4ad7..a85b6c9755a7 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -40,7 +40,7 @@ static int rockchip_drm_fbdev_create(struct drm_fb_helper *helper,
 				     struct drm_fb_helper_surface_size *sizes)
 {
 	struct rockchip_drm_private *private = to_drm_private(helper);
-	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
+	struct drm_mode_fb_cmd2 mode_cmd = { };
 	struct drm_device *dev = helper->dev;
 	struct rockchip_gem_object *rk_obj;
 	struct drm_framebuffer *fb;
diff --git a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
index 6b4759ed6bfd..8d6dc83619ca 100644
--- a/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
+++ b/drivers/gpu/drm/selftests/test-drm_dp_mst_helper.c
@@ -176,7 +176,7 @@ sideband_msg_req_encode_decode(struct drm_dp_sideband_msg_req_body *in)
 
 int igt_dp_mst_sideband_msg_req_decode(void *unused)
 {
-	struct drm_dp_sideband_msg_req_body in = { 0 };
+	struct drm_dp_sideband_msg_req_body in = { };
 	u8 data[] = { 0xff, 0x0, 0xdd };
 	int i;
 
diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index cae8b8cbe9dd..76ded7bc83dd 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -217,7 +217,7 @@ static int tegra_fbdev_probe(struct drm_fb_helper *helper,
 	struct tegra_fbdev *fbdev = to_tegra_fbdev(helper);
 	struct tegra_drm *tegra = helper->dev->dev_private;
 	struct drm_device *drm = helper->dev;
-	struct drm_mode_fb_cmd2 cmd = { 0 };
+	struct drm_mode_fb_cmd2 cmd = { };
 	unsigned int bytes_per_pixel;
 	struct drm_framebuffer *fb;
 	unsigned long offset;
diff --git a/drivers/gpu/drm/vc4/vc4_render_cl.c b/drivers/gpu/drm/vc4/vc4_render_cl.c
index 3c918eeaf56e..05b30c120480 100644
--- a/drivers/gpu/drm/vc4/vc4_render_cl.c
+++ b/drivers/gpu/drm/vc4/vc4_render_cl.c
@@ -593,7 +593,7 @@ vc4_rcl_render_config_surface_setup(struct vc4_exec_info *exec,
 
 int vc4_get_rcl(struct drm_device *dev, struct vc4_exec_info *exec)
 {
-	struct vc4_rcl_setup setup = {0};
+	struct vc4_rcl_setup setup = {};
 	struct drm_vc4_submit_cl *args = exec->args;
 	bool has_bin = args->bin_cl_size != 0;
 	int ret;
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 2de61b63ef91..2ea3af744278 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -63,7 +63,7 @@ int virtio_gpu_mode_dumb_create(struct drm_file *file_priv,
 				struct drm_mode_create_dumb *args)
 {
 	struct drm_gem_object *gobj;
-	struct virtio_gpu_object_params params = { 0 };
+	struct virtio_gpu_object_params params = { };
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	int ret;
 	uint32_t pitch;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5c1ad1596889..e65c330b2d4b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -245,7 +245,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 	struct virtio_gpu_object *qobj;
 	struct drm_gem_object *obj;
 	uint32_t handle = 0;
-	struct virtio_gpu_object_params params = { 0 };
+	struct virtio_gpu_object_params params = { };
 
 	if (vgdev->has_virgl_3d) {
 		virtio_gpu_create_context(dev, file);
@@ -600,7 +600,7 @@ static int virtio_gpu_resource_create_blob_ioctl(struct drm_device *dev,
 	bool host3d_blob = false;
 	struct drm_gem_object *obj;
 	struct virtio_gpu_object *bo;
-	struct virtio_gpu_object_params params = { 0 };
+	struct virtio_gpu_object_params params = { };
 	struct virtio_gpu_device *vgdev = dev->dev_private;
 	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
 	struct drm_virtgpu_resource_create_blob *rc_blob = data;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 74fa41909213..238114e35b46 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1150,7 +1150,7 @@ static int vmw_create_bo_proxy(struct drm_device *dev,
 			       struct vmw_buffer_object *bo_mob,
 			       struct vmw_surface **srf_out)
 {
-	struct vmw_surface_metadata metadata = {0};
+	struct vmw_surface_metadata metadata = {};
 	uint32_t format;
 	struct vmw_resource *res;
 	unsigned int bytes_pp;
@@ -1452,7 +1452,7 @@ static int vmw_kms_check_display_memory(struct drm_device *dev,
 					struct drm_rect *rects)
 {
 	struct vmw_private *dev_priv = vmw_priv(dev);
-	struct drm_rect bounding_box = {0};
+	struct drm_rect bounding_box = {};
 	u64 total_pixels = 0, pixel_mem, bb_mem;
 	int i;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
index f9394207dd3c..7e3fac565ddf 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_mob.c
@@ -505,7 +505,7 @@ static void vmw_mob_pt_setup(struct vmw_mob *mob,
 {
 	unsigned long num_pt_pages = 0;
 	struct ttm_buffer_object *bo = mob->pt_bo;
-	struct vmw_piter save_pt_iter = {0};
+	struct vmw_piter save_pt_iter = {};
 	struct vmw_piter pt_iter;
 	const struct vmw_sg_table *vsgt;
 	int ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index d85310b2608d..87530721591f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -1072,7 +1072,7 @@ vmw_stdu_primary_plane_prepare_fb(struct drm_plane *plane,
 		new_content_type = SEPARATE_SURFACE;
 
 	if (new_content_type != SAME_AS_DISPLAY) {
-		struct vmw_surface_metadata metadata = {0};
+		struct vmw_surface_metadata metadata = {};
 
 		/*
 		 * If content buffer is a buffer object, then we have to
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 5d53a5f9d123..9b04419f207a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -1454,7 +1454,7 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 	struct ttm_object_file *tfile = vmw_fpriv(file_priv)->tfile;
 	struct vmw_private *dev_priv = vmw_priv(dev);
 	struct vmw_user_surface *user_srf;
-	struct vmw_surface_metadata metadata = {0};
+	struct vmw_surface_metadata metadata = {};
 	struct vmw_surface *srf;
 	struct vmw_resource *res;
 	struct vmw_resource *tmp;
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
index 6f588dc09ba6..a3eb0cb77752 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
@@ -658,7 +658,7 @@ static int zynqmp_dp_update_vs_emph(struct zynqmp_dp *dp)
 
 	for (i = 0; i < dp->mode.lane_cnt; i++) {
 		u32 reg = ZYNQMP_DP_SUB_TX_PHY_PRECURSOR_LANE_0 + i * 4;
-		union phy_configure_opts opts = { 0 };
+		union phy_configure_opts opts = { };
 		u8 train = dp->train_set[i];
 
 		opts.dp.voltage[0] = (train & DP_TRAIN_VOLTAGE_SWING_MASK)
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 81de88ab2ecc..5955241ac134 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2814,7 +2814,7 @@ static int wtp_raw_event(struct hid_device *hdev, u8 *data, int size)
 static int wtp_get_config(struct hidpp_device *hidpp)
 {
 	struct wtp_data *wd = hidpp->private_data;
-	struct hidpp_touchpad_raw_info raw_info = {0};
+	struct hidpp_touchpad_raw_info raw_info = {};
 	u8 feature_type;
 	int ret;
 
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 2e104682c22b..693416877a1c 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -1155,7 +1155,7 @@ static void hid_remove_all_dquirks(__u16 bus)
  */
 int hid_quirks_init(char **quirks_param, __u16 bus, int count)
 {
-	struct hid_device_id id = { 0 };
+	struct hid_device_id id = { };
 	int n = 0, m;
 	unsigned short int vendor, product;
 	u32 quirks;
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 32c2306e240d..88adf88b11d2 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -768,8 +768,8 @@ static int get_luid_table_index(unsigned char *usage_str)
 
 static int get_known_custom_sensor_index(struct hid_sensor_hub_device *hsdev)
 {
-	struct hid_sensor_hub_attribute_info sensor_manufacturer = { 0 };
-	struct hid_sensor_hub_attribute_info sensor_luid_info = { 0 };
+	struct hid_sensor_hub_attribute_info sensor_manufacturer = { };
+	struct hid_sensor_hub_attribute_info sensor_luid_info = { };
 	int report_size;
 	int ret;
 	static u16 w_buf[HID_CUSTOM_MAX_FEATURE_BYTES];
diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 3d67b748a3b9..6154569cf134 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -712,7 +712,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 	bool found;
 	/* The resulting parameters (noop) */
-	struct uclogic_params p = {0, };
+	struct uclogic_params p = {};
 	static const char transition_ver[] = "HUION_T153_160607";
 	char *ver_ptr = NULL;
 	const size_t ver_len = sizeof(transition_ver) + 1;
@@ -840,7 +840,7 @@ int uclogic_params_init(struct uclogic_params *params,
 	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 	bool found;
 	/* The resulting parameters (noop) */
-	struct uclogic_params p = {0, };
+	struct uclogic_params p = {};
 
 	/* Check arguments */
 	if (params == NULL || hdev == NULL ||
diff --git a/drivers/hid/intel-ish-hid/ishtp/hbm.c b/drivers/hid/intel-ish-hid/ishtp/hbm.c
index 9c031a06e4c4..712c11caca22 100644
--- a/drivers/hid/intel-ish-hid/ishtp/hbm.c
+++ b/drivers/hid/intel-ish-hid/ishtp/hbm.c
@@ -127,7 +127,7 @@ int ishtp_hbm_start_wait(struct ishtp_device *dev)
 int ishtp_hbm_start_req(struct ishtp_device *dev)
 {
 	struct ishtp_msg_hdr hdr;
-	struct hbm_host_version_request start_req = { 0 };
+	struct hbm_host_version_request start_req = { };
 
 	ishtp_hbm_hdr(&hdr, sizeof(start_req));
 
@@ -164,7 +164,7 @@ int ishtp_hbm_start_req(struct ishtp_device *dev)
 void ishtp_hbm_enum_clients_req(struct ishtp_device *dev)
 {
 	struct ishtp_msg_hdr hdr;
-	struct hbm_host_enum_request enum_req = { 0 };
+	struct hbm_host_enum_request enum_req = { };
 
 	/* enumerate clients */
 	ishtp_hbm_hdr(&hdr, sizeof(enum_req));
@@ -189,7 +189,7 @@ void ishtp_hbm_enum_clients_req(struct ishtp_device *dev)
 static int ishtp_hbm_prop_req(struct ishtp_device *dev)
 {
 	struct ishtp_msg_hdr hdr;
-	struct hbm_props_request prop_req = { 0 };
+	struct hbm_props_request prop_req = { };
 	unsigned long next_client_index;
 	uint8_t client_num;
 
@@ -239,7 +239,7 @@ static int ishtp_hbm_prop_req(struct ishtp_device *dev)
 static void ishtp_hbm_stop_req(struct ishtp_device *dev)
 {
 	struct ishtp_msg_hdr hdr;
-	struct hbm_host_stop_request stop_req = { 0 } ;
+	struct hbm_host_stop_request stop_req = { } ;
 
 	ishtp_hbm_hdr(&hdr, sizeof(stop_req));
 
diff --git a/drivers/hwmon/sbrmi.c b/drivers/hwmon/sbrmi.c
index 7bf0c3fba75f..11f143a9dc85 100644
--- a/drivers/hwmon/sbrmi.c
+++ b/drivers/hwmon/sbrmi.c
@@ -192,7 +192,7 @@ static int sbrmi_read(struct device *dev, enum hwmon_sensor_types type,
 		      u32 attr, int channel, long *val)
 {
 	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct sbrmi_mailbox_msg msg = { };
 	int ret;
 
 	if (type != hwmon_power)
@@ -226,7 +226,7 @@ static int sbrmi_write(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long val)
 {
 	struct sbrmi_data *data = dev_get_drvdata(dev);
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct sbrmi_mailbox_msg msg = { };
 
 	if (type != hwmon_power && attr != hwmon_power_cap)
 		return -EINVAL;
@@ -284,7 +284,7 @@ static const struct hwmon_chip_info sbrmi_chip_info = {
 
 static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
 {
-	struct sbrmi_mailbox_msg msg = { 0 };
+	struct sbrmi_mailbox_msg msg = { };
 	int ret;
 
 	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index f775cbee12b8..1ed546351743 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -734,7 +734,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata = NULL;
 	struct etb_drvdata *drvdata;
 	struct resource *res = &adev->res;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 
 	desc.name = coresight_alloc_device_name(&etb_devs, dev);
 	if (!desc.name)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index cf64ce73a741..8d1549f967c2 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -826,7 +826,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata = NULL;
 	struct etm_drvdata *drvdata;
 	struct resource *res = &adev->res;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index e24252eaf8e4..80afeb90d1b4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1878,8 +1878,8 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
 	int ret;
 	struct coresight_platform_data *pdata = NULL;
 	struct etmv4_drvdata *drvdata;
-	struct coresight_desc desc = { 0 };
-	struct etm4_init_arg init_arg = { 0 };
+	struct coresight_desc desc = { };
+	struct etm4_init_arg init_arg = { };
 	u8 major, minor;
 	char *type_name;
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b363dd6bc510..4296bf889943 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -211,7 +211,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	void __iomem *base;
 	struct coresight_platform_data *pdata = NULL;
 	struct funnel_drvdata *drvdata;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 
 	if (is_of_node(dev_fwnode(dev)) &&
 	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index b86acbc74cf0..d1bb4282ff35 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -223,7 +223,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	int ret = 0;
 	struct coresight_platform_data *pdata = NULL;
 	struct replicator_drvdata *drvdata;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 	void __iomem *base;
 
 	if (is_of_node(dev_fwnode(dev)) &&
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 58062a5a8238..7da2c2aa4c5b 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -863,7 +863,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct resource ch_res;
 	size_t bitmap_size;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 
 	desc.name = coresight_alloc_device_name(&stm_devs, dev);
 	if (!desc.name)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 74c6323d4d6a..107053b2d27e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -441,7 +441,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata = NULL;
 	struct tmc_drvdata *drvdata;
 	struct resource *res = &adev->res;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 	struct coresight_dev_list *dev_list = NULL;
 
 	ret = -ENOMEM;
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 34d37abd2c8d..6fd2867fea5c 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -121,7 +121,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	struct coresight_platform_data *pdata = NULL;
 	struct tpiu_drvdata *drvdata;
 	struct resource *res = &adev->res;
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 
 	desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
 	if (!desc.name)
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 176868496879..aee31d04d2a8 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -863,7 +863,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 {
 	struct trbe_cpudata *cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
 	struct coresight_device *trbe_csdev = coresight_get_percpu_sink(cpu);
-	struct coresight_desc desc = { 0 };
+	struct coresight_desc desc = { };
 	struct device *dev;
 
 	if (WARN_ON(trbe_csdev))
diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 3ded28632e4c..48c042aac9a0 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -216,7 +216,7 @@ cp2615_i2c_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 	struct usb_interface *usbif = adap->algo_data;
 	int i = 0, ret = 0;
 	struct i2c_msg *msg;
-	struct cp2615_i2c_transfer i2c_w = {0};
+	struct cp2615_i2c_transfer i2c_w = {};
 
 	dev_dbg(&usbif->dev, "Doing %d I2C transactions\n", num);
 
diff --git a/drivers/i2c/busses/i2c-mlxbf.c b/drivers/i2c/busses/i2c-mlxbf.c
index 8716032f030a..94714da548d4 100644
--- a/drivers/i2c/busses/i2c-mlxbf.c
+++ b/drivers/i2c/busses/i2c-mlxbf.c
@@ -2045,7 +2045,7 @@ static s32 mlxbf_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
 				u8 command, int size,
 				union i2c_smbus_data *data)
 {
-	struct mlxbf_i2c_smbus_request request = { 0 };
+	struct mlxbf_i2c_smbus_request request = { };
 	struct mlxbf_i2c_priv *priv;
 	bool read, pec;
 	u8 byte_cnt;
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c883044715f3..dcf31e49afb5 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -974,7 +974,7 @@ static irqreturn_t tegra_i2c_isr(int irq, void *dev_id)
 static void tegra_i2c_config_fifo_trig(struct tegra_i2c_dev *i2c_dev,
 				       size_t len)
 {
-	struct dma_slave_config slv_config = {0};
+	struct dma_slave_config slv_config = {};
 	u32 val, reg, dma_burst, reg_offset;
 	struct dma_chan *chan;
 	int err;
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index ea5ca163d879..76770e4eed5a 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1456,7 +1456,7 @@ static void at91_adc_dma_init(struct platform_device *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct at91_adc_state *st = iio_priv(indio_dev);
-	struct dma_slave_config config = {0};
+	struct dma_slave_config config = {};
 	/*
 	 * We make the buffer double the size of the fifo,
 	 * such that DMA uses one half of the buffer (full fifo size)
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 740e6b2efe0e..d2d976f3f7a9 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3585,7 +3585,7 @@ static int ib_uverbs_ex_query_device(struct uverbs_attr_bundle *attrs)
 {
 	struct ib_uverbs_ex_query_device_resp resp = {};
 	struct ib_uverbs_ex_query_device  cmd;
-	struct ib_device_attr attr = {0};
+	struct ib_device_attr attr = {};
 	struct ib_ucontext *ucontext;
 	struct ib_device *ib_dev;
 	int err;
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 66268e41b470..c9816672ab5c 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -457,7 +457,7 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 				 u16 fw_ring_id, int type)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_ring_free_input req = {0};
+	struct hwrm_ring_free_input req = {};
 	struct hwrm_ring_free_output resp;
 	struct bnxt_fw_msg fw_msg;
 	int rc = -EINVAL;
@@ -487,7 +487,7 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
 				  u16 *fw_ring_id)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_ring_alloc_input req = {0};
+	struct hwrm_ring_alloc_input req = {};
 	struct hwrm_ring_alloc_output resp;
 	struct bnxt_fw_msg fw_msg;
 	int rc = -EINVAL;
@@ -523,7 +523,7 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 				      u32 fw_stats_ctx_id)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_stat_ctx_free_input req = {0};
+	struct hwrm_stat_ctx_free_input req = {};
 	struct bnxt_fw_msg fw_msg;
 	int rc = -EINVAL;
 
@@ -552,8 +552,8 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 				       u32 *fw_stats_ctx_id)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx = rdev->chip_ctx;
-	struct hwrm_stat_ctx_alloc_output resp = {0};
-	struct hwrm_stat_ctx_alloc_input req = {0};
+	struct hwrm_stat_ctx_alloc_output resp = {};
+	struct hwrm_stat_ctx_alloc_input req = {};
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct bnxt_fw_msg fw_msg;
 	int rc = -EINVAL;
@@ -1091,7 +1091,7 @@ static void bnxt_re_dispatch_event(struct ib_device *ibdev, struct ib_qp *qp,
 static int bnxt_re_query_hwrm_pri2cos(struct bnxt_re_dev *rdev, u8 dir,
 				      u64 *cid_map)
 {
-	struct hwrm_queue_pri2cos_qcfg_input req = {0};
+	struct hwrm_queue_pri2cos_qcfg_input req = {};
 	struct bnxt *bp = netdev_priv(rdev->netdev);
 	struct hwrm_queue_pri2cos_qcfg_output resp;
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
@@ -1283,8 +1283,8 @@ static int bnxt_re_setup_qos(struct bnxt_re_dev *rdev)
 static void bnxt_re_query_hwrm_intf_version(struct bnxt_re_dev *rdev)
 {
 	struct bnxt_en_dev *en_dev = rdev->en_dev;
-	struct hwrm_ver_get_output resp = {0};
-	struct hwrm_ver_get_input req = {0};
+	struct hwrm_ver_get_output resp = {};
+	struct hwrm_ver_get_input req = {};
 	struct bnxt_fw_msg fw_msg;
 	int rc = 0;
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 5d384def5e5f..85cab6ba2909 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -780,7 +780,7 @@ static void bnxt_qplib_start_rcfw(struct bnxt_qplib_rcfw *rcfw)
 	struct bnxt_qplib_cmdq_ctx *cmdq;
 	struct bnxt_qplib_creq_ctx *creq;
 	struct bnxt_qplib_cmdq_mbox *mbox;
-	struct cmdq_init init = {0};
+	struct cmdq_init init = {};
 
 	cmdq = &rcfw->cmdq;
 	creq = &rcfw->creq;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index e0f59b8d7d5d..85bf168a4e38 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -775,7 +775,7 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct device *dev = &hr_dev->pdev->dev;
 	struct ib_cq_init_attr cq_init_attr;
-	struct ib_qp_attr attr = { 0 };
+	struct ib_qp_attr attr = { };
 	struct hns_roce_qp *hr_qp;
 	struct ib_cq *cq;
 	struct ib_pd *pd;
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 8662f462e2a5..f320a9fc1ad0 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -3334,7 +3334,7 @@ static void set_tunnel_datagram_seg(struct mlx4_ib_dev *dev,
 				    enum mlx4_ib_qp_type qpt)
 {
 	union mlx4_ext_av *av = &to_mah(wr->ah)->av;
-	struct mlx4_av sqp_av = {0};
+	struct mlx4_av sqp_av = {};
 	int port = *((u8 *) &av->ib.port_pd) & 0x3;
 
 	/* force loopback */
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 8664bcf6d3f5..a4d385c243c1 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -2934,7 +2934,7 @@ static int mlx5_port_immutable(struct ib_device *ibdev, u32 port_num,
 	struct ib_port_attr attr;
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	enum rdma_link_layer ll = mlx5_ib_port_link_layer(ibdev, port_num);
-	struct mlx5_hca_vport_context rep = {0};
+	struct mlx5_hca_vport_context rep = {};
 	int err;
 
 	err = ib_query_port(ibdev, port_num, &attr);
diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index 1715fbe0719d..3054352445d7 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -209,7 +209,7 @@ static void qedr_iw_disconnect_worker(struct work_struct *work)
 {
 	struct qedr_discon_work *dwork =
 	    container_of(work, struct qedr_discon_work, work);
-	struct qed_rdma_modify_qp_in_params qp_params = { 0 };
+	struct qed_rdma_modify_qp_in_params qp_params = { };
 	struct qedr_iw_ep *ep = dwork->ep;
 	struct qedr_dev *dev = ep->dev;
 	struct qedr_qp *qp = ep->qp;
diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
index 3fbf172dbbef..adea16c8db51 100644
--- a/drivers/infiniband/hw/qedr/verbs.c
+++ b/drivers/infiniband/hw/qedr/verbs.c
@@ -2463,7 +2463,7 @@ int qedr_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		   int attr_mask, struct ib_udata *udata)
 {
 	struct qedr_qp *qp = get_qedr_qp(ibqp);
-	struct qed_rdma_modify_qp_in_params qp_params = { 0 };
+	struct qed_rdma_modify_qp_in_params qp_params = { };
 	struct qedr_dev *dev = get_qedr_dev(&qp->dev->ibdev);
 	const struct ib_global_route *grh = rdma_ah_read_grh(&attr->ah_attr);
 	enum ib_qp_state old_qp_state, new_qp_state;
diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
index 19176583dbde..769892a81e84 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
@@ -433,7 +433,7 @@ int pvrdma_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)
 	union pvrdma_cmd_resp rsp = {};
 	struct pvrdma_cmd_create_pd *cmd = &req.create_pd;
 	struct pvrdma_cmd_create_pd_resp *resp = &rsp.create_pd_resp;
-	struct pvrdma_alloc_pd_resp pd_resp = {0};
+	struct pvrdma_alloc_pd_resp pd_resp = {};
 	int ret;
 	struct pvrdma_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct pvrdma_ucontext, ibucontext);
diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
index cecf0f7cadf9..687c8338f350 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.c
@@ -970,7 +970,7 @@ static int vema_register(struct opa_vnic_ctrl_port *cport)
  */
 static void opa_vnic_ctrl_config_dev(struct opa_vnic_ctrl_port *cport, bool en)
 {
-	struct ib_port_modify pm = { 0 };
+	struct ib_port_modify pm = { };
 	int i;
 
 	if (en)
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4a6b33bbe7ea..9935b1631861 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -393,8 +393,8 @@ static int alps_process_bitmap(struct alps_data *priv,
 			       struct alps_fields *fields)
 {
 	int i, fingers_x = 0, fingers_y = 0, fingers, closest;
-	struct alps_bitmap_point x_low = {0,}, x_high = {0,};
-	struct alps_bitmap_point y_low = {0,}, y_high = {0,};
+	struct alps_bitmap_point x_low = {}, x_high = {};
+	struct alps_bitmap_point y_low = {}, y_high = {};
 	struct input_mt_pos corner[4];
 
 	if (!fields->x_map || !fields->y_map)
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395..52346ef493d9 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -189,7 +189,7 @@ static irqreturn_t rmi_irq_fn(int irq, void *dev_id)
 {
 	struct rmi_device *rmi_dev = dev_id;
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi4_attn_data attn_data = {0};
+	struct rmi4_attn_data attn_data = {};
 	int ret, count;
 
 	count = kfifo_get(&drvdata->attn_fifo, &attn_data);
@@ -912,7 +912,7 @@ void rmi_disable_irq(struct rmi_device *rmi_dev, bool enable_wake)
 {
 	struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi4_attn_data attn_data = {0};
+	struct rmi4_attn_data attn_data = {};
 	int irq = pdata->irq;
 	int retval, count;
 
diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index 22826c387da5..0cb51625a816 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -150,7 +150,7 @@ static int wacom_i2c_probe(struct i2c_client *client,
 	struct device *dev = &client->dev;
 	struct wacom_i2c *wac_i2c;
 	struct input_dev *input;
-	struct wacom_features features = { 0 };
+	struct wacom_features features = { };
 	int error;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a388e318f86e..98c0311807fc 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -80,7 +80,7 @@ DEFINE_MUTEX(arm_smmu_asid_lock);
  * Special value used by SVA when a process dies, to quiesce a CD without
  * disabling it.
  */
-struct arm_smmu_ctx_desc quiet_cd = { 0 };
+struct arm_smmu_ctx_desc quiet_cd = { };
 
 static struct arm_smmu_option_prop arm_smmu_options[] = {
 	{ ARM_SMMU_OPT_SKIP_PREFETCH, "hisilicon,broken-prefetch-cmd" },
@@ -903,7 +903,7 @@ static int arm_smmu_page_response(struct device *dev,
 				  struct iommu_fault_event *unused,
 				  struct iommu_page_response *resp)
 {
-	struct arm_smmu_cmdq_ent cmd = {0};
+	struct arm_smmu_cmdq_ent cmd = {};
 	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	int sid = master->streams[0].id;
 
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index 62e23ff3c987..4c7ac1aed5f4 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -222,7 +222,7 @@ static void ctx_tbl_walk(struct seq_file *m, struct intel_iommu *iommu, u16 bus)
 	u64 pasid_dir_ptr;
 
 	for (devfn = 0; devfn < 256; devfn++) {
-		struct tbl_walk tbl_wlk = {0};
+		struct tbl_walk tbl_wlk = {};
 
 		/*
 		 * Scalable mode root entry points to upper scalable mode
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3303d707bab4..03cc51efd6cf 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2085,7 +2085,7 @@ static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
 int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
 				void __user *uinfo)
 {
-	struct iommu_cache_invalidate_info inv_info = { 0 };
+	struct iommu_cache_invalidate_info inv_info = { };
 	u32 minsz;
 	int ret;
 
@@ -2195,7 +2195,7 @@ static int iommu_sva_prepare_bind_data(void __user *udata,
 int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			       void __user *udata)
 {
-	struct iommu_gpasid_bind_data data = { 0 };
+	struct iommu_gpasid_bind_data data = { };
 	int ret;
 
 	if (unlikely(!domain->ops->sva_bind_gpasid))
@@ -2222,7 +2222,7 @@ EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
 int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
 				 void __user *udata)
 {
-	struct iommu_gpasid_bind_data data = { 0 };
+	struct iommu_gpasid_bind_data data = { };
 	int ret;
 
 	if (unlikely(!domain->ops->sva_bind_gpasid))
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index 116edda845c3..19eb477638de 100644
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -109,7 +109,7 @@ void bch_data_verify(struct cached_dev *dc, struct bio *bio)
 {
 	struct bio *check;
 	struct bio_vec bv, cbv;
-	struct bvec_iter iter, citer = { 0 };
+	struct bvec_iter iter, citer = { };
 
 	check = bio_kmalloc(GFP_NOIO, bio_segments(bio));
 	if (!check)
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 22a5ac82446a..adf503ef1d6c 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -1042,7 +1042,7 @@ static int verity_parse_opt_args(struct dm_arg_set *as, struct dm_verity *v,
 static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
 {
 	struct dm_verity *v;
-	struct dm_verity_sig_opts verify_args = {0};
+	struct dm_verity_sig_opts verify_args = {};
 	struct dm_arg_set as;
 	unsigned int num;
 	unsigned long long num_ll;
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 7fbd41e156c9..2a75870bca1a 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -978,7 +978,7 @@ static void load_bitmaps(struct mddev *mddev, int total_slots)
 static void resync_bitmap(struct mddev *mddev)
 {
 	struct md_cluster_info *cinfo = mddev->cluster_info;
-	struct cluster_msg cmsg = {0};
+	struct cluster_msg cmsg = {};
 	int err;
 
 	cmsg.type = cpu_to_le32(BITMAP_NEEDS_SYNC);
@@ -1107,7 +1107,7 @@ static void metadata_update_cancel(struct mddev *mddev)
 static int update_bitmap_size(struct mddev *mddev, sector_t size)
 {
 	struct md_cluster_info *cinfo = mddev->cluster_info;
-	struct cluster_msg cmsg = {0};
+	struct cluster_msg cmsg = {};
 	int ret;
 
 	cmsg.type = cpu_to_le32(BITMAP_RESIZE);
@@ -1335,7 +1335,7 @@ static int resync_info_update(struct mddev *mddev, sector_t lo, sector_t hi)
 {
 	struct md_cluster_info *cinfo = mddev->cluster_info;
 	struct resync_info ri;
-	struct cluster_msg cmsg = {0};
+	struct cluster_msg cmsg = {};
 
 	/* do not send zero again, if we have sent before */
 	if (hi == 0) {
@@ -1470,7 +1470,7 @@ static int new_disk_ack(struct mddev *mddev, bool ack)
 
 static int remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 {
-	struct cluster_msg cmsg = {0};
+	struct cluster_msg cmsg = {};
 	struct md_cluster_info *cinfo = mddev->cluster_info;
 	cmsg.type = cpu_to_le32(REMOVE);
 	cmsg.raid_slot = cpu_to_le32(rdev->desc_nr);
@@ -1533,7 +1533,7 @@ static int gather_bitmaps(struct md_rdev *rdev)
 {
 	int sn, err;
 	sector_t lo, hi;
-	struct cluster_msg cmsg = {0};
+	struct cluster_msg cmsg = {};
 	struct mddev *mddev = rdev->mddev;
 	struct md_cluster_info *cinfo = mddev->cluster_info;
 
diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 258637d762d6..be8255d23dac 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -1811,7 +1811,7 @@ static void prepare_tuning_algo_parameters(struct dvb_frontend *fe)
 {
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
 	struct dvb_frontend_private *fepriv = fe->frontend_priv;
-	struct dvb_frontend_tune_settings fetunesettings = { 0 };
+	struct dvb_frontend_tune_settings fetunesettings = { };
 
 	/* get frontend-specific tuning settings */
 	if (fe->ops.get_tune_settings && (fe->ops.get_tune_settings(fe, &fetunesettings) == 0)) {
diff --git a/drivers/media/dvb-frontends/as102_fe.c b/drivers/media/dvb-frontends/as102_fe.c
index bc72d954dc1f..e365362ee56b 100644
--- a/drivers/media/dvb-frontends/as102_fe.c
+++ b/drivers/media/dvb-frontends/as102_fe.c
@@ -55,7 +55,7 @@ static int as102_fe_set_frontend(struct dvb_frontend *fe)
 {
 	struct as102_state *state = fe->demodulator_priv;
 	struct dtv_frontend_properties *c = &fe->dtv_property_cache;
-	struct as10x_tune_args tune_args = { 0 };
+	struct as10x_tune_args tune_args = { };
 
 	/* set frequency */
 	tune_args.freq = c->frequency / 1000;
@@ -186,7 +186,7 @@ static int as102_fe_get_frontend(struct dvb_frontend *fe,
 {
 	struct as102_state *state = fe->demodulator_priv;
 	int ret = 0;
-	struct as10x_tps tps = { 0 };
+	struct as10x_tps tps = { };
 
 	/* send abilis command: GET_TPS */
 	ret = state->ops->get_tps(state->priv, &tps);
@@ -302,7 +302,7 @@ static int as102_fe_read_status(struct dvb_frontend *fe, enum fe_status *status)
 {
 	int ret = 0;
 	struct as102_state *state = fe->demodulator_priv;
-	struct as10x_tune_status tstate = { 0 };
+	struct as10x_tune_status tstate = { };
 
 	/* send abilis command: GET_TUNE_STATUS */
 	ret = state->ops->get_status(state->priv, &tstate);
diff --git a/drivers/media/i2c/adv7842.c b/drivers/media/i2c/adv7842.c
index 7f8acbdf0db4..474e4851967c 100644
--- a/drivers/media/i2c/adv7842.c
+++ b/drivers/media/i2c/adv7842.c
@@ -1533,7 +1533,7 @@ static int adv7842_query_dv_timings(struct v4l2_subdev *sd,
 {
 	struct adv7842_state *state = to_state(sd);
 	struct v4l2_bt_timings *bt = &timings->bt;
-	struct stdi_readback stdi = { 0 };
+	struct stdi_readback stdi = { };
 
 	v4l2_dbg(1, debug, sd, "%s:\n", __func__);
 
diff --git a/drivers/media/i2c/ccs/ccs-data.c b/drivers/media/i2c/ccs/ccs-data.c
index 45f2b2f55ec5..c73ba08f44a7 100644
--- a/drivers/media/i2c/ccs/ccs-data.c
+++ b/drivers/media/i2c/ccs/ccs-data.c
@@ -811,7 +811,7 @@ static int __ccs_data_parse(struct bin_container *bin,
 		dev_dbg(dev, "Parsing CCS static data version %u\n", version);
 
 	if (!bin->base)
-		*ccsdata = (struct ccs_data_container){ 0 };
+		*ccsdata = (struct ccs_data_container){ };
 
 	while (block < endp) {
 		const struct __ccs_data_block *next_block;
@@ -932,7 +932,7 @@ static int __ccs_data_parse(struct bin_container *bin,
 int ccs_data_parse(struct ccs_data_container *ccsdata, const void *data,
 		   size_t len, struct device *dev, bool verbose)
 {
-	struct bin_container bin = { 0 };
+	struct bin_container bin = { };
 	int rval;
 
 	rval = __ccs_data_parse(&bin, ccsdata, data, len, dev, verbose);
diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
index bf7a6c37ca5d..0741b8a79455 100644
--- a/drivers/media/i2c/imx290.c
+++ b/drivers/media/i2c/imx290.c
@@ -648,7 +648,7 @@ static int imx290_set_fmt(struct v4l2_subdev *sd,
 static int imx290_entity_init_cfg(struct v4l2_subdev *subdev,
 				  struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	fmt.format.width = 1920;
diff --git a/drivers/media/i2c/imx334.c b/drivers/media/i2c/imx334.c
index 062125501788..1c7bc1d0db64 100644
--- a/drivers/media/i2c/imx334.c
+++ b/drivers/media/i2c/imx334.c
@@ -285,7 +285,7 @@ static inline struct imx334 *to_imx334(struct v4l2_subdev *subdev)
 static int imx334_read_reg(struct imx334 *imx334, u16 reg, u32 len, u32 *val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx334->sd);
-	struct i2c_msg msgs[2] = {0};
+	struct i2c_msg msgs[2] = {};
 	u8 addr_buf[2] = {0};
 	u8 data_buf[4] = {0};
 	int ret;
@@ -639,7 +639,7 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
 			       struct v4l2_subdev_state *sd_state)
 {
 	struct imx334 *imx334 = to_imx334(sd);
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
index 410d6b86feb5..f93387985b8d 100644
--- a/drivers/media/i2c/imx335.c
+++ b/drivers/media/i2c/imx335.c
@@ -277,7 +277,7 @@ static inline struct imx335 *to_imx335(struct v4l2_subdev *subdev)
 static int imx335_read_reg(struct imx335 *imx335, u16 reg, u32 len, u32 *val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx335->sd);
-	struct i2c_msg msgs[2] = {0};
+	struct i2c_msg msgs[2] = {};
 	u8 addr_buf[2] = {0};
 	u8 data_buf[4] = {0};
 	int ret;
@@ -630,7 +630,7 @@ static int imx335_init_pad_cfg(struct v4l2_subdev *sd,
 			       struct v4l2_subdev_state *sd_state)
 {
 	struct imx335 *imx335 = to_imx335(sd);
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	imx335_fill_pad_format(imx335, &supported_mode, &fmt);
diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index be3f6ea55559..55a60cb399ff 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -422,7 +422,7 @@ static inline struct imx412 *to_imx412(struct v4l2_subdev *subdev)
 static int imx412_read_reg(struct imx412 *imx412, u16 reg, u32 len, u32 *val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&imx412->sd);
-	struct i2c_msg msgs[2] = {0};
+	struct i2c_msg msgs[2] = {};
 	u8 addr_buf[2] = {0};
 	u8 data_buf[4] = {0};
 	int ret;
@@ -773,7 +773,7 @@ static int imx412_init_pad_cfg(struct v4l2_subdev *sd,
 			       struct v4l2_subdev_state *sd_state)
 {
 	struct imx412 *imx412 = to_imx412(sd);
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	imx412_fill_pad_format(imx412, &supported_mode, &fmt);
diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index 368fa21e675e..157d4ff43b23 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -960,7 +960,7 @@ static int ov5645_set_format(struct v4l2_subdev *sd,
 static int ov5645_entity_init_cfg(struct v4l2_subdev *subdev,
 				  struct v4l2_subdev_state *sd_state)
 {
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	fmt.format.width = 1920;
diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
index 2e0b315801e5..57a2725a78bc 100644
--- a/drivers/media/i2c/ov9282.c
+++ b/drivers/media/i2c/ov9282.c
@@ -290,7 +290,7 @@ static inline struct ov9282 *to_ov9282(struct v4l2_subdev *subdev)
 static int ov9282_read_reg(struct ov9282 *ov9282, u16 reg, u32 len, u32 *val)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(&ov9282->sd);
-	struct i2c_msg msgs[2] = {0};
+	struct i2c_msg msgs[2] = {};
 	u8 addr_buf[2] = {0};
 	u8 data_buf[4] = {0};
 	int ret;
@@ -640,7 +640,7 @@ static int ov9282_init_pad_cfg(struct v4l2_subdev *sd,
 			       struct v4l2_subdev_state *sd_state)
 {
 	struct ov9282 *ov9282 = to_ov9282(sd);
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 
 	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
 	ov9282_fill_pad_format(ov9282, &supported_mode, &fmt);
diff --git a/drivers/media/i2c/ov9640.c b/drivers/media/i2c/ov9640.c
index 0bab8c2cf160..6c7ffc59f3b2 100644
--- a/drivers/media/i2c/ov9640.c
+++ b/drivers/media/i2c/ov9640.c
@@ -504,7 +504,7 @@ static int ov9640_s_fmt(struct v4l2_subdev *sd,
 			struct v4l2_mbus_framefmt *mf)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
-	struct ov9640_reg_alt alts = {0};
+	struct ov9640_reg_alt alts = {};
 	int ret;
 
 	ov9640_alter_regs(mf->code, &alts);
diff --git a/drivers/media/pci/cobalt/cobalt-v4l2.c b/drivers/media/pci/cobalt/cobalt-v4l2.c
index 0ff37496c9ab..e54b8e725ec5 100644
--- a/drivers/media/pci/cobalt/cobalt-v4l2.c
+++ b/drivers/media/pci/cobalt/cobalt-v4l2.c
@@ -906,7 +906,7 @@ static int cobalt_s_fmt_vid_out(struct file *file, void *priv_fh,
 {
 	struct cobalt_stream *s = video_drvdata(file);
 	struct v4l2_pix_format *pix = &f->fmt.pix;
-	struct v4l2_subdev_format sd_fmt = { 0 };
+	struct v4l2_subdev_format sd_fmt = { };
 	u32 code;
 
 	if (cobalt_try_fmt_vid_out(file, priv_fh, f))
diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index a1637b78568b..699eb0c53506 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -695,7 +695,7 @@ static int csid_link_setup(struct media_entity *entity,
 		struct csid_device *csid;
 		struct csiphy_device *csiphy;
 		struct csiphy_lanes_cfg *lane_cfg;
-		struct v4l2_subdev_format format = { 0 };
+		struct v4l2_subdev_format format = { };
 
 		sd = media_entity_to_v4l2_subdev(entity);
 		csid = v4l2_get_subdevdata(sd);
diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index e0f3a36f3f3f..df0ea69600cc 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -1080,7 +1080,7 @@ static int vfe_set_format(struct v4l2_subdev *sd,
 	*format = fmt->format;
 
 	if (fmt->pad == MSM_VFE_PAD_SINK) {
-		struct v4l2_subdev_selection sel = { 0 };
+		struct v4l2_subdev_selection sel = { };
 		int ret;
 
 		/* Propagate the format from sink to source */
@@ -1121,7 +1121,7 @@ static int vfe_get_selection(struct v4l2_subdev *sd,
 			     struct v4l2_subdev_selection *sel)
 {
 	struct vfe_line *line = v4l2_get_subdevdata(sd);
-	struct v4l2_subdev_format fmt = { 0 };
+	struct v4l2_subdev_format fmt = { };
 	struct v4l2_rect *rect;
 	int ret;
 
@@ -1199,7 +1199,7 @@ static int vfe_set_selection(struct v4l2_subdev *sd,
 
 	if (sel->target == V4L2_SEL_TGT_COMPOSE &&
 		sel->pad == MSM_VFE_PAD_SINK) {
-		struct v4l2_subdev_selection crop = { 0 };
+		struct v4l2_subdev_selection crop = { };
 
 		rect = __vfe_get_compose(line, sd_state, sel->which);
 		if (rect == NULL)
@@ -1216,7 +1216,7 @@ static int vfe_set_selection(struct v4l2_subdev *sd,
 		ret = vfe_set_selection(sd, sd_state, &crop);
 	} else if (sel->target == V4L2_SEL_TGT_CROP &&
 		sel->pad == MSM_VFE_PAD_SRC) {
-		struct v4l2_subdev_format fmt = { 0 };
+		struct v4l2_subdev_format fmt = { };
 
 		rect = __vfe_get_crop(line, sd_state, sel->which);
 		if (rect == NULL)
diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 8012f5c7bf34..5197dfd89552 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -244,7 +244,7 @@ static int intbufs_set_buffer(struct venus_inst *inst, u32 type)
 
 static int intbufs_unset_buffers(struct venus_inst *inst)
 {
-	struct hfi_buffer_desc bd = {0};
+	struct hfi_buffer_desc bd = {};
 	struct intbuf *buf, *n;
 	int ret = 0;
 
@@ -1224,7 +1224,7 @@ EXPORT_SYMBOL_GPL(venus_helper_set_color_format);
 int venus_helper_set_multistream(struct venus_inst *inst, bool out_en,
 				 bool out2_en)
 {
-	struct hfi_multi_stream multi = {0};
+	struct hfi_multi_stream multi = {};
 	u32 ptype = HFI_PROPERTY_PARAM_VDEC_MULTI_STREAM;
 	int ret;
 
diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
index 9a2bdb002edc..81fdd163b0de 100644
--- a/drivers/media/platform/qcom/venus/hfi_msgs.c
+++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
@@ -23,7 +23,7 @@ static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
 			      struct hfi_msg_event_notify_pkt *pkt)
 {
 	enum hfi_version ver = core->res->hfi_version;
-	struct hfi_event_data event = {0};
+	struct hfi_event_data event = {};
 	int num_properties_changed;
 	struct hfi_framesize *frame_sz;
 	struct hfi_profile_level *profile_level;
@@ -124,7 +124,7 @@ static void event_release_buffer_ref(struct venus_core *core,
 				     struct venus_inst *inst,
 				     struct hfi_msg_event_notify_pkt *pkt)
 {
-	struct hfi_event_data event = {0};
+	struct hfi_event_data event = {};
 	struct hfi_msg_event_release_buffer_ref_pkt *data;
 
 	data = (struct hfi_msg_event_release_buffer_ref_pkt *)
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index ce98c523b3c6..a1dfddc3b1d7 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -764,7 +764,7 @@ static int venus_interface_queues_init(struct venus_hfi_device *hdev)
 	struct hfi_queue_table_header *tbl_hdr;
 	struct iface_queue *queue;
 	struct hfi_sfr *sfr;
-	struct mem_desc desc = {0};
+	struct mem_desc desc = {};
 	unsigned int offset;
 	unsigned int i;
 	int ret;
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 198e47eb63f4..018f7be66fde 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -496,7 +496,7 @@ static int
 vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_decoder_cmd *cmd)
 {
 	struct venus_inst *inst = to_inst(file);
-	struct hfi_frame_data fdata = {0};
+	struct hfi_frame_data fdata = {};
 	int ret;
 
 	ret = v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index e28eff039688..f9762fbccc14 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -494,7 +494,7 @@ static int rcsi2_calc_mbps(struct rcar_csi2 *priv, unsigned int bpp,
 static int rcsi2_get_active_lanes(struct rcar_csi2 *priv,
 				  unsigned int *lanes)
 {
-	struct v4l2_mbus_config mbus_config = { 0 };
+	struct v4l2_mbus_config mbus_config = { };
 	unsigned int num_lanes = UINT_MAX;
 	int ret;
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 07b2161392d2..a0791852d8c5 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -601,7 +601,7 @@ int sun6i_video_init(struct sun6i_video *video, struct sun6i_csi *csi,
 {
 	struct video_device *vdev = &video->vdev;
 	struct vb2_queue *vidq = &video->vb2_vidq;
-	struct v4l2_format fmt = { 0 };
+	struct v4l2_format fmt = { };
 	int ret;
 
 	video->csi = csi;
diff --git a/drivers/media/platform/vsp1/vsp1_drm.c b/drivers/media/platform/vsp1/vsp1_drm.c
index 06f74d410973..f2c17e6fcd89 100644
--- a/drivers/media/platform/vsp1/vsp1_drm.c
+++ b/drivers/media/platform/vsp1/vsp1_drm.c
@@ -477,7 +477,7 @@ static int vsp1_du_pipeline_setup_output(struct vsp1_device *vsp1,
 					 struct vsp1_pipeline *pipe)
 {
 	struct vsp1_drm_pipeline *drm_pipe = to_vsp1_drm_pipeline(pipe);
-	struct v4l2_subdev_format format = { 0, };
+	struct v4l2_subdev_format format = { };
 	int ret;
 
 	format.which = V4L2_SUBDEV_FORMAT_ACTIVE;
diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea575x.c
index c37315226c42..e5cf610f0cdc 100644
--- a/drivers/media/radio/tea575x.c
+++ b/drivers/media/radio/tea575x.c
@@ -272,7 +272,7 @@ static int vidioc_enum_freq_bands(struct file *file, void *priv,
 
 int snd_tea575x_g_tuner(struct snd_tea575x *tea, struct v4l2_tuner *v)
 {
-	struct v4l2_frequency_band band_fm = { 0, };
+	struct v4l2_frequency_band band_fm = { };
 
 	if (v->index > 0)
 		return -EINVAL;
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 6b84c3413e83..7f5c3034fc33 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -1604,7 +1604,7 @@ static int vidioc_s_std(struct file *file, void *priv, v4l2_std_id norm)
 static int vidioc_g_parm(struct file *file, void *priv,
 			 struct v4l2_streamparm *p)
 {
-	struct v4l2_subdev_frame_interval ival = { 0 };
+	struct v4l2_subdev_frame_interval ival = { };
 	struct em28xx      *dev  = video_drvdata(file);
 	struct em28xx_v4l2 *v4l2 = dev->v4l2;
 	int rc = 0;
diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9a791d8ef200..0a413efccd15 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2341,7 +2341,7 @@ static int uvc_register_chains(struct uvc_device *dev)
  * USB probe, disconnect, suspend and resume
  */
 
-static const struct uvc_device_info uvc_quirk_none = { 0 };
+static const struct uvc_device_info uvc_quirk_none = { };
 
 static int uvc_probe(struct usb_interface *intf,
 		     const struct usb_device_id *id)
diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 04af03285a20..f976370de1af 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -186,7 +186,7 @@ EXPORT_SYMBOL_GPL(__v4l2_find_nearest_size);
 int v4l2_g_parm_cap(struct video_device *vdev,
 		    struct v4l2_subdev *sd, struct v4l2_streamparm *a)
 {
-	struct v4l2_subdev_frame_interval ival = { 0 };
+	struct v4l2_subdev_frame_interval ival = { };
 	int ret;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE &&
diff --git a/drivers/memstick/core/mspro_block.c b/drivers/memstick/core/mspro_block.c
index 22778d0e24f5..e455e1f7e5ea 100644
--- a/drivers/memstick/core/mspro_block.c
+++ b/drivers/memstick/core/mspro_block.c
@@ -576,7 +576,7 @@ static int h_mspro_block_transfer_data(struct memstick_dev *card,
 {
 	struct mspro_block_data *msb = memstick_get_drvdata(card);
 	unsigned char t_val = 0;
-	struct scatterlist t_sg = { 0 };
+	struct scatterlist t_sg = { };
 	size_t t_offset;
 
 	if ((*mrq)->error)
diff --git a/drivers/mfd/rsmu_spi.c b/drivers/mfd/rsmu_spi.c
index fec2b4ec477c..5234be88efce 100644
--- a/drivers/mfd/rsmu_spi.c
+++ b/drivers/mfd/rsmu_spi.c
@@ -26,7 +26,7 @@
 static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
 {
 	struct spi_device *client = to_spi_device(rsmu->dev);
-	struct spi_transfer xfer = {0};
+	struct spi_transfer xfer = {};
 	struct spi_message msg;
 	u8 cmd[256] = {0};
 	u8 rsp[256] = {0};
@@ -64,7 +64,7 @@ static int rsmu_read_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
 static int rsmu_write_device(struct rsmu_ddata *rsmu, u8 reg, u8 *buf, u16 bytes)
 {
 	struct spi_device *client = to_spi_device(rsmu->dev);
-	struct spi_transfer xfer = {0};
+	struct spi_transfer xfer = {};
 	struct spi_message msg;
 	u8 cmd[256] = {0};
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 3dbdce96fae0..340dbe714f85 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -291,7 +291,7 @@ static long afu_ioctl_process_element(struct cxl_context *ctx,
 static long afu_ioctl_get_afu_id(struct cxl_context *ctx,
 				 struct cxl_afu_id __user *upafuid)
 {
-	struct cxl_afu_id afuid = { 0 };
+	struct cxl_afu_id afuid = { };
 
 	afuid.card_id = ctx->afu->adapter->adapter_num;
 	afuid.afu_offset = ctx->afu->slice;
diff --git a/drivers/misc/habanalabs/common/debugfs.c b/drivers/misc/habanalabs/common/debugfs.c
index 703d79fb6f3f..4d309fd477d0 100644
--- a/drivers/misc/habanalabs/common/debugfs.c
+++ b/drivers/misc/habanalabs/common/debugfs.c
@@ -326,7 +326,7 @@ static int mmu_show(struct seq_file *s, void *data)
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
 	struct hl_ctx *ctx;
-	struct hl_mmu_hop_info hops_info = {0};
+	struct hl_mmu_hop_info hops_info = {};
 	u64 virt_addr = dev_entry->mmu_addr, phys_addr;
 	int i;
 
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index f4dda7b4acdd..23b2f0af9de1 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -28,7 +28,7 @@ static u32 hl_debug_struct_size[HL_DEBUG_OP_TIMESTAMP + 1] = {
 
 static int device_status_info(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_device_status dev_stat = {0};
+	struct hl_info_device_status dev_stat = {};
 	u32 size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -43,7 +43,7 @@ static int device_status_info(struct hl_device *hdev, struct hl_info_args *args)
 
 static int hw_ip_info(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_hw_ip_info hw_ip = {0};
+	struct hl_info_hw_ip_info hw_ip = {};
 	u32 size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -116,7 +116,7 @@ static int hw_events_info(struct hl_device *hdev, bool aggregate,
 static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_info_dram_usage dram_usage = {0};
+	struct hl_info_dram_usage dram_usage = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -139,7 +139,7 @@ static int dram_usage_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 
 static int hw_idle(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_hw_idle hw_idle = {0};
+	struct hl_info_hw_idle hw_idle = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -223,7 +223,7 @@ static int debug_coresight(struct hl_device *hdev, struct hl_debug_args *args)
 
 static int device_utilization(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_device_utilization device_util = {0};
+	struct hl_info_device_utilization device_util = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	int rc;
@@ -241,7 +241,7 @@ static int device_utilization(struct hl_device *hdev, struct hl_info_args *args)
 
 static int get_clk_rate(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_clk_rate clk_rate = {0};
+	struct hl_info_clk_rate clk_rate = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	int rc;
@@ -260,7 +260,7 @@ static int get_clk_rate(struct hl_device *hdev, struct hl_info_args *args)
 
 static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_reset_count reset_count = {0};
+	struct hl_info_reset_count reset_count = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -276,7 +276,7 @@ static int get_reset_count(struct hl_device *hdev, struct hl_info_args *args)
 
 static int time_sync_info(struct hl_device *hdev, struct hl_info_args *args)
 {
-	struct hl_info_time_sync time_sync = {0};
+	struct hl_info_time_sync time_sync = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -293,7 +293,7 @@ static int time_sync_info(struct hl_device *hdev, struct hl_info_args *args)
 static int pci_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_info_pci_counters pci_counters = {0};
+	struct hl_info_pci_counters pci_counters = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	int rc;
@@ -312,7 +312,7 @@ static int pci_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_info_clk_throttle clk_throttle = {0};
+	struct hl_info_clk_throttle clk_throttle = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -328,7 +328,7 @@ static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 static int cs_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
-	struct hl_info_cs_counters cs_counters = {0};
+	struct hl_info_cs_counters cs_counters = {};
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cs_counters_atomic *cntr;
 	u32 max_size = args->return_size;
@@ -380,7 +380,7 @@ static int sync_manager_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
-	struct hl_info_sync_manager sm_info = {0};
+	struct hl_info_sync_manager sm_info = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
@@ -405,7 +405,7 @@ static int total_energy_consumption_info(struct hl_fpriv *hpriv,
 			struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
-	struct hl_info_energy total_energy = {0};
+	struct hl_info_energy total_energy = {};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	int rc;
@@ -445,7 +445,7 @@ static int power_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_power_info power_info = {0};
+	struct hl_power_info power_info = {};
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	int rc;
 
@@ -464,7 +464,7 @@ static int open_stats_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	u32 max_size = args->return_size;
-	struct hl_open_stats_info open_stats_info = {0};
+	struct hl_open_stats_info open_stats_info = {};
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 
 	if ((!max_size) || (!out))
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 4dfc246c5f95..067f750b5e00 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1874,7 +1874,7 @@ static struct msdc_delay_phase get_best_delay(struct msdc_host *host, u32 delay)
 	int start = 0, len = 0;
 	int start_final = 0, len_final = 0;
 	u8 final_phase = 0xff;
-	struct msdc_delay_phase delay_phase = { 0, };
+	struct msdc_delay_phase delay_phase = { };
 
 	if (delay == 0) {
 		dev_err(host->dev, "phase error: [map:%x]\n", delay);
@@ -1935,7 +1935,7 @@ static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 rise_delay = 0, fall_delay = 0;
-	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { };
 	struct msdc_delay_phase internal_delay_phase;
 	u8 final_delay, final_maxlen;
 	u32 internal_delay = 0;
@@ -2029,7 +2029,7 @@ static int hs400_tune_response(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 cmd_delay = 0;
-	struct msdc_delay_phase final_cmd_delay = { 0,};
+	struct msdc_delay_phase final_cmd_delay = { };
 	u8 final_delay;
 	int cmd_err;
 	int i, j;
@@ -2079,7 +2079,7 @@ static int msdc_tune_data(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 rise_delay = 0, fall_delay = 0;
-	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { };
 	u8 final_delay, final_maxlen;
 	int i, ret;
 
@@ -2134,7 +2134,7 @@ static int msdc_tune_together(struct mmc_host *mmc, u32 opcode)
 {
 	struct msdc_host *host = mmc_priv(mmc);
 	u32 rise_delay = 0, fall_delay = 0;
-	struct msdc_delay_phase final_rise_delay, final_fall_delay = { 0,};
+	struct msdc_delay_phase final_rise_delay, final_fall_delay = { };
 	u8 final_delay, final_maxlen;
 	int i, ret;
 
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 6e4e132903a6..7334ba53eec9 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -212,7 +212,7 @@ aspeed_sdhci_phases_to_taps(struct device *dev, unsigned long rate,
 static void
 aspeed_sdhci_configure_phase(struct sdhci_host *host, unsigned long rate)
 {
-	struct aspeed_sdhci_tap_param _taps = {0}, *taps = &_taps;
+	struct aspeed_sdhci_tap_param _taps = {}, *taps = &_taps;
 	struct mmc_clk_phase *params;
 	struct aspeed_sdhci *sdhci;
 	struct device *dev;
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bcc595c70a9f..d8500df1feac 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -402,7 +402,7 @@ static int sh_mmcif_dma_slave_config(struct sh_mmcif_host *host,
 				     enum dma_transfer_direction direction)
 {
 	struct resource *res;
-	struct dma_slave_config cfg = { 0, };
+	struct dma_slave_config cfg = { };
 
 	res = platform_get_resource(host->pd, IORESOURCE_MEM, 0);
 	cfg.direction = direction;
diff --git a/drivers/mtd/nand/raw/cadence-nand-controller.c b/drivers/mtd/nand/raw/cadence-nand-controller.c
index 7eec60ea9056..e23854dbc16b 100644
--- a/drivers/mtd/nand/raw/cadence-nand-controller.c
+++ b/drivers/mtd/nand/raw/cadence-nand-controller.c
@@ -1020,7 +1020,7 @@ static u32
 cadence_nand_cdma_send_and_wait(struct cdns_nand_ctrl *cdns_ctrl,
 				u8 thread)
 {
-	struct cadence_nand_irq_status irq_mask, irq_status = {0};
+	struct cadence_nand_irq_status irq_mask, irq_status = {};
 	int status;
 
 	irq_mask.trd_status = BIT(thread);
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 77dc79a7f574..d46151550d46 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5849,7 +5849,7 @@ static int bond_check_params(struct bond_params *params)
 		 * packets_per_slave is 0 or 1, just initialize it
 		 */
 		params->reciprocal_packets_per_slave =
-			(struct reciprocal_value) { 0 };
+			(struct reciprocal_value) { };
 	}
 
 	if (primary)
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index a8fde3bc458f..bcbe97409eaa 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1344,7 +1344,7 @@ static int bond_option_pps_set(struct bonding *bond,
 		 * packets_per_slave is 0 or 1, just initialize it
 		 */
 		bond->params.reciprocal_packets_per_slave =
-			(struct reciprocal_value) { 0 };
+			(struct reciprocal_value) { };
 	}
 
 	return 0;
diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
index 14e360c9f2c9..c64519c2c322 100644
--- a/drivers/net/can/usb/etas_es58x/es581_4.c
+++ b/drivers/net/can/usb/etas_es58x/es581_4.c
@@ -392,7 +392,7 @@ static int es581_4_tx_can_msg(struct es58x_priv *priv,
 
 static int es581_4_set_bittiming(struct es58x_priv *priv)
 {
-	struct es581_4_tx_conf_msg tx_conf_msg = { 0 };
+	struct es581_4_tx_conf_msg tx_conf_msg = { };
 	struct can_bittiming *bt = &priv->can.bittiming;
 
 	tx_conf_msg.bitrate = cpu_to_le32(bt->bitrate);
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index af042aa55f59..f17ebfb91ad0 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -396,7 +396,7 @@ static int es58x_fd_enable_channel(struct es58x_priv *priv)
 {
 	struct es58x_device *es58x_dev = priv->es58x_dev;
 	struct net_device *netdev = es58x_dev->netdev[priv->channel_idx];
-	struct es58x_fd_tx_conf_msg tx_conf_msg = { 0 };
+	struct es58x_fd_tx_conf_msg tx_conf_msg = { };
 	u32 ctrlmode;
 	size_t conf_len = 0;
 
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 604f54112665..140b9a902e0c 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -738,7 +738,7 @@ static bool b53_vlan_port_needs_forced_tagged(struct dsa_switch *ds, int port)
 int b53_configure_vlan(struct dsa_switch *ds)
 {
 	struct b53_device *dev = ds->priv;
-	struct b53_vlan vl = { 0 };
+	struct b53_vlan vl = { };
 	struct b53_vlan *v;
 	int i, def_vid;
 	u16 vid;
diff --git a/drivers/net/dsa/hirschmann/hellcreek.c b/drivers/net/dsa/hirschmann/hellcreek.c
index 542cfc4ccb08..2b99ee0e699e 100644
--- a/drivers/net/dsa/hirschmann/hellcreek.c
+++ b/drivers/net/dsa/hirschmann/hellcreek.c
@@ -802,7 +802,7 @@ static int hellcreek_fdb_get(struct hellcreek *hellcreek,
 	 * enter new entries anywhere.
 	 */
 	for (i = 0; i < hellcreek->fdb_entries; ++i) {
-		struct hellcreek_fdb_entry tmp = { 0 };
+		struct hellcreek_fdb_entry tmp = { };
 
 		/* Read entry */
 		hellcreek_populate_fdb_entry(hellcreek, &tmp, i);
@@ -825,7 +825,7 @@ static int hellcreek_fdb_get(struct hellcreek *hellcreek,
 static int hellcreek_fdb_add(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid)
 {
-	struct hellcreek_fdb_entry entry = { 0 };
+	struct hellcreek_fdb_entry entry = { };
 	struct hellcreek *hellcreek = ds->priv;
 	int ret;
 
@@ -870,7 +870,7 @@ static int hellcreek_fdb_add(struct dsa_switch *ds, int port,
 static int hellcreek_fdb_del(struct dsa_switch *ds, int port,
 			     const unsigned char *addr, u16 vid)
 {
-	struct hellcreek_fdb_entry entry = { 0 };
+	struct hellcreek_fdb_entry entry = { };
 	struct hellcreek *hellcreek = ds->priv;
 	int ret;
 
@@ -928,7 +928,7 @@ static int hellcreek_fdb_dump(struct dsa_switch *ds, int port,
 
 	/* Read table */
 	for (i = 0; i < hellcreek->fdb_entries; ++i) {
-		struct hellcreek_fdb_entry entry = { 0 };
+		struct hellcreek_fdb_entry entry = { };
 
 		/* Read entry */
 		hellcreek_populate_fdb_entry(hellcreek, &entry, i);
diff --git a/drivers/net/dsa/lantiq_gswip.c b/drivers/net/dsa/lantiq_gswip.c
index 64d6dfa83122..731361941e59 100644
--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -611,8 +611,8 @@ static int gswip_pce_table_entry_write(struct gswip_priv *priv,
  */
 static int gswip_add_single_port_br(struct gswip_priv *priv, int port, bool add)
 {
-	struct gswip_pce_table_entry vlan_active = {0,};
-	struct gswip_pce_table_entry vlan_mapping = {0,};
+	struct gswip_pce_table_entry vlan_active = {};
+	struct gswip_pce_table_entry vlan_mapping = {};
 	unsigned int cpu_port = priv->hw_info->cpu_port;
 	unsigned int max_ports = priv->hw_info->max_ports;
 	int err;
@@ -879,7 +879,7 @@ static int gswip_vlan_active_create(struct gswip_priv *priv,
 				    struct net_device *bridge,
 				    int fid, u16 vid)
 {
-	struct gswip_pce_table_entry vlan_active = {0,};
+	struct gswip_pce_table_entry vlan_active = {};
 	unsigned int max_ports = priv->hw_info->max_ports;
 	int idx = -1;
 	int err;
@@ -920,7 +920,7 @@ static int gswip_vlan_active_create(struct gswip_priv *priv,
 
 static int gswip_vlan_active_remove(struct gswip_priv *priv, int idx)
 {
-	struct gswip_pce_table_entry vlan_active = {0,};
+	struct gswip_pce_table_entry vlan_active = {};
 	int err;
 
 	vlan_active.index = idx;
@@ -937,7 +937,7 @@ static int gswip_vlan_active_remove(struct gswip_priv *priv, int idx)
 static int gswip_vlan_add_unaware(struct gswip_priv *priv,
 				  struct net_device *bridge, int port)
 {
-	struct gswip_pce_table_entry vlan_mapping = {0,};
+	struct gswip_pce_table_entry vlan_mapping = {};
 	unsigned int max_ports = priv->hw_info->max_ports;
 	unsigned int cpu_port = priv->hw_info->cpu_port;
 	bool active_vlan_created = false;
@@ -999,7 +999,7 @@ static int gswip_vlan_add_aware(struct gswip_priv *priv,
 				u16 vid, bool untagged,
 				bool pvid)
 {
-	struct gswip_pce_table_entry vlan_mapping = {0,};
+	struct gswip_pce_table_entry vlan_mapping = {};
 	unsigned int max_ports = priv->hw_info->max_ports;
 	unsigned int cpu_port = priv->hw_info->cpu_port;
 	bool active_vlan_created = false;
@@ -1074,7 +1074,7 @@ static int gswip_vlan_remove(struct gswip_priv *priv,
 			     struct net_device *bridge, int port,
 			     u16 vid, bool pvid, bool vlan_aware)
 {
-	struct gswip_pce_table_entry vlan_mapping = {0,};
+	struct gswip_pce_table_entry vlan_mapping = {};
 	unsigned int max_ports = priv->hw_info->max_ports;
 	unsigned int cpu_port = priv->hw_info->cpu_port;
 	int idx = -1;
@@ -1255,7 +1255,7 @@ static int gswip_port_vlan_del(struct dsa_switch *ds, int port,
 static void gswip_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct gswip_priv *priv = ds->priv;
-	struct gswip_pce_table_entry mac_bridge = {0,};
+	struct gswip_pce_table_entry mac_bridge = {};
 	int i;
 	int err;
 
@@ -1325,7 +1325,7 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
 {
 	struct gswip_priv *priv = ds->priv;
 	struct net_device *bridge = dsa_to_port(ds, port)->bridge_dev;
-	struct gswip_pce_table_entry mac_bridge = {0,};
+	struct gswip_pce_table_entry mac_bridge = {};
 	unsigned int cpu_port = priv->hw_info->cpu_port;
 	int fid = -1;
 	int i;
@@ -1379,7 +1379,7 @@ static int gswip_port_fdb_dump(struct dsa_switch *ds, int port,
 			       dsa_fdb_dump_cb_t *cb, void *data)
 {
 	struct gswip_priv *priv = ds->priv;
-	struct gswip_pce_table_entry mac_bridge = {0,};
+	struct gswip_pce_table_entry mac_bridge = {};
 	unsigned char addr[6];
 	int i;
 	int err;
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d0cba2d1cd68..9d918f1489a4 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1382,7 +1382,7 @@ mt7530_port_fdb_dump(struct dsa_switch *ds, int port,
 		     dsa_fdb_dump_cb_t *cb, void *data)
 {
 	struct mt7530_priv *priv = ds->priv;
-	struct mt7530_fdb _fdb = { 0 };
+	struct mt7530_fdb _fdb = { };
 	int cnt = MT7530_NUM_FDB_RECORDS;
 	int ret = 0;
 	u32 rsp = 0;
diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
index 40bd67a5c8e9..4afc9b271191 100644
--- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
+++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
@@ -323,7 +323,7 @@ int mv88e6xxx_g1_atu_flush(struct mv88e6xxx_chip *chip, u16 fid, bool all)
 static int mv88e6xxx_g1_atu_move(struct mv88e6xxx_chip *chip, u16 fid,
 				 int from_port, int to_port, bool all)
 {
-	struct mv88e6xxx_atu_entry entry = { 0 };
+	struct mv88e6xxx_atu_entry entry = { };
 	unsigned long mask;
 	int shift;
 
diff --git a/drivers/net/dsa/qca8k.c b/drivers/net/dsa/qca8k.c
index 1f63f50f73f1..5ce36bb1e234 100644
--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -1643,7 +1643,7 @@ qca8k_port_fdb_dump(struct dsa_switch *ds, int port,
 		    dsa_fdb_dump_cb_t *cb, void *data)
 {
 	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
-	struct qca8k_fdb _fdb = { 0 };
+	struct qca8k_fdb _fdb = { };
 	int cnt = QCA8K_NUM_FDB_RECORDS;
 	bool is_static;
 	int ret = 0;
diff --git a/drivers/net/dsa/sja1105/sja1105_clocking.c b/drivers/net/dsa/sja1105/sja1105_clocking.c
index 387a1f2f161c..15541a85485a 100644
--- a/drivers/net/dsa/sja1105/sja1105_clocking.c
+++ b/drivers/net/dsa/sja1105/sja1105_clocking.c
@@ -391,7 +391,7 @@ static int sja1105_rgmii_cfg_pad_tx_config(struct sja1105_private *priv,
 					   int port)
 {
 	const struct sja1105_regs *regs = priv->info->regs;
-	struct sja1105_cfg_pad_mii pad_mii_tx = {0};
+	struct sja1105_cfg_pad_mii pad_mii_tx = {};
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
 
 	if (regs->pad_mii_tx[port] == SJA1105_RSV_ADDR)
@@ -420,7 +420,7 @@ static int sja1105_rgmii_cfg_pad_tx_config(struct sja1105_private *priv,
 static int sja1105_cfg_pad_rx_config(struct sja1105_private *priv, int port)
 {
 	const struct sja1105_regs *regs = priv->info->regs;
-	struct sja1105_cfg_pad_mii pad_mii_rx = {0};
+	struct sja1105_cfg_pad_mii pad_mii_rx = {};
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
 
 	if (regs->pad_mii_rx[port] == SJA1105_RSV_ADDR)
@@ -520,7 +520,7 @@ int sja1105pqrs_setup_rgmii_delay(const void *ctx, int port)
 {
 	const struct sja1105_private *priv = ctx;
 	const struct sja1105_regs *regs = priv->info->regs;
-	struct sja1105_cfg_pad_mii_id pad_mii_id = {0};
+	struct sja1105_cfg_pad_mii_id pad_mii_id = {};
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
 	int rc;
 
@@ -560,7 +560,7 @@ int sja1110_setup_rgmii_delay(const void *ctx, int port)
 {
 	const struct sja1105_private *priv = ctx;
 	const struct sja1105_regs *regs = priv->info->regs;
-	struct sja1105_cfg_pad_mii_id pad_mii_id = {0};
+	struct sja1105_cfg_pad_mii_id pad_mii_id = {};
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
 
 	pad_mii_id.rxc_pd = 1;
@@ -690,7 +690,7 @@ static int sja1105_cgu_rmii_pll_config(struct sja1105_private *priv)
 {
 	const struct sja1105_regs *regs = priv->info->regs;
 	u8 packed_buf[SJA1105_SIZE_CGU_CMD] = {0};
-	struct sja1105_cgu_pll_ctrl pll = {0};
+	struct sja1105_cgu_pll_ctrl pll = {};
 	struct device *dev = priv->ds->dev;
 	int rc;
 
diff --git a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
index f2049f52833c..ebde591d9cdb 100644
--- a/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_dynamic_config.c
@@ -1193,7 +1193,7 @@ int sja1105_dynamic_config_read(struct sja1105_private *priv,
 				int index, void *entry)
 {
 	const struct sja1105_dynamic_table_ops *ops;
-	struct sja1105_dyn_cmd cmd = {0};
+	struct sja1105_dyn_cmd cmd = {};
 	/* SPI payload buffer */
 	u8 packed_buf[SJA1105_MAX_DYN_CMD_SIZE] = {0};
 	int retries = 3;
@@ -1251,7 +1251,7 @@ int sja1105_dynamic_config_read(struct sja1105_private *priv,
 		if (rc < 0)
 			return rc;
 
-		cmd = (struct sja1105_dyn_cmd) {0};
+		cmd = (struct sja1105_dyn_cmd) {};
 		ops->cmd_packing(packed_buf, &cmd, UNPACK);
 
 		if (!cmd.valident && !(ops->access & OP_VALID_ANYWAY))
@@ -1275,7 +1275,7 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 				 int index, void *entry, bool keep)
 {
 	const struct sja1105_dynamic_table_ops *ops;
-	struct sja1105_dyn_cmd cmd = {0};
+	struct sja1105_dyn_cmd cmd = {};
 	/* SPI payload buffer */
 	u8 packed_buf[SJA1105_MAX_DYN_CMD_SIZE] = {0};
 	int rc;
@@ -1321,7 +1321,7 @@ int sja1105_dynamic_config_write(struct sja1105_private *priv,
 	if (rc < 0)
 		return rc;
 
-	cmd = (struct sja1105_dyn_cmd) {0};
+	cmd = (struct sja1105_dyn_cmd) {};
 	ops->cmd_packing(packed_buf, &cmd, UNPACK);
 	if (cmd.errors)
 		return -EINVAL;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 2f8cc6686c38..3c96605e4a28 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -1475,7 +1475,7 @@ static int sja1105et_is_fdb_entry_in_bin(struct sja1105_private *priv, int bin,
 	int way;
 
 	for (way = 0; way < SJA1105ET_FDB_BIN_SIZE; way++) {
-		struct sja1105_l2_lookup_entry l2_lookup = {0};
+		struct sja1105_l2_lookup_entry l2_lookup = {};
 		int index = sja1105et_fdb_index(bin, way);
 
 		/* Skip unused entries, optionally marking them
@@ -1502,7 +1502,7 @@ static int sja1105et_is_fdb_entry_in_bin(struct sja1105_private *priv, int bin,
 int sja1105et_fdb_add(struct dsa_switch *ds, int port,
 		      const unsigned char *addr, u16 vid)
 {
-	struct sja1105_l2_lookup_entry l2_lookup = {0}, tmp;
+	struct sja1105_l2_lookup_entry l2_lookup = {}, tmp;
 	struct sja1105_private *priv = ds->priv;
 	struct device *dev = ds->dev;
 	int last_unused = -1;
@@ -1587,7 +1587,7 @@ int sja1105et_fdb_add(struct dsa_switch *ds, int port,
 int sja1105et_fdb_del(struct dsa_switch *ds, int port,
 		      const unsigned char *addr, u16 vid)
 {
-	struct sja1105_l2_lookup_entry l2_lookup = {0};
+	struct sja1105_l2_lookup_entry l2_lookup = {};
 	struct sja1105_private *priv = ds->priv;
 	int index, bin, way, rc;
 	bool keep;
@@ -1622,7 +1622,7 @@ int sja1105et_fdb_del(struct dsa_switch *ds, int port,
 int sja1105pqrs_fdb_add(struct dsa_switch *ds, int port,
 			const unsigned char *addr, u16 vid)
 {
-	struct sja1105_l2_lookup_entry l2_lookup = {0}, tmp;
+	struct sja1105_l2_lookup_entry l2_lookup = {}, tmp;
 	struct sja1105_private *priv = ds->priv;
 	int rc, i;
 
@@ -1713,7 +1713,7 @@ int sja1105pqrs_fdb_add(struct dsa_switch *ds, int port,
 int sja1105pqrs_fdb_del(struct dsa_switch *ds, int port,
 			const unsigned char *addr, u16 vid)
 {
-	struct sja1105_l2_lookup_entry l2_lookup = {0};
+	struct sja1105_l2_lookup_entry l2_lookup = {};
 	struct sja1105_private *priv = ds->priv;
 	bool keep;
 	int rc;
@@ -1771,7 +1771,7 @@ static int sja1105_fdb_dump(struct dsa_switch *ds, int port,
 	int i;
 
 	for (i = 0; i < SJA1105_MAX_L2_LOOKUP_COUNT; i++) {
-		struct sja1105_l2_lookup_entry l2_lookup = {0};
+		struct sja1105_l2_lookup_entry l2_lookup = {};
 		u8 macaddr[ETH_ALEN];
 		int rc;
 
@@ -1817,7 +1817,7 @@ static void sja1105_fast_age(struct dsa_switch *ds, int port)
 	int i;
 
 	for (i = 0; i < SJA1105_MAX_L2_LOOKUP_COUNT; i++) {
-		struct sja1105_l2_lookup_entry l2_lookup = {0};
+		struct sja1105_l2_lookup_entry l2_lookup = {};
 		u8 macaddr[ETH_ALEN];
 		int rc;
 
@@ -2548,7 +2548,7 @@ static void sja1105_port_disable(struct dsa_switch *ds, int port)
 static int sja1105_mgmt_xmit(struct dsa_switch *ds, int port, int slot,
 			     struct sk_buff *skb, bool takets)
 {
-	struct sja1105_mgmt_entry mgmt_route = {0};
+	struct sja1105_mgmt_entry mgmt_route = {};
 	struct sja1105_private *priv = ds->priv;
 	struct ethhdr *hdr;
 	int timeout = 10;
diff --git a/drivers/net/dsa/sja1105/sja1105_ptp.c b/drivers/net/dsa/sja1105/sja1105_ptp.c
index 691f6dd7e669..4149bd261028 100644
--- a/drivers/net/dsa/sja1105/sja1105_ptp.c
+++ b/drivers/net/dsa/sja1105/sja1105_ptp.c
@@ -396,7 +396,7 @@ static long sja1105_rxtstamp_work(struct ptp_clock_info *ptp)
 			continue;
 		}
 
-		*shwt = (struct skb_shared_hwtstamps) {0};
+		*shwt = (struct skb_shared_hwtstamps) {};
 
 		ts = SJA1105_SKB_CB(skb)->tstamp;
 		ts = sja1105_tstamp_reconstruct(ds, ticks, ts);
@@ -435,7 +435,7 @@ bool sja1110_rxtstamp(struct dsa_switch *ds, int port, struct sk_buff *skb)
 	struct skb_shared_hwtstamps *shwt = skb_hwtstamps(skb);
 	u64 ts = SJA1105_SKB_CB(skb)->tstamp;
 
-	*shwt = (struct skb_shared_hwtstamps) {0};
+	*shwt = (struct skb_shared_hwtstamps) {};
 
 	shwt->hwtstamp = ns_to_ktime(sja1105_ticks_to_ns(ts));
 
@@ -458,7 +458,7 @@ void sja1110_process_meta_tstamp(struct dsa_switch *ds, int port, u8 ts_id,
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
 	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
-	struct skb_shared_hwtstamps shwt = {0};
+	struct skb_shared_hwtstamps shwt = {};
 
 	/* We don't care about RX timestamps on the CPU port */
 	if (dir == SJA1110_META_TSTAMP_RX)
@@ -989,7 +989,7 @@ void sja1105_ptp_txtstamp_skb(struct dsa_switch *ds, int port,
 {
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_ptp_data *ptp_data = &priv->ptp_data;
-	struct skb_shared_hwtstamps shwt = {0};
+	struct skb_shared_hwtstamps shwt = {};
 	u64 ticks, ts;
 	int rc;
 
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index d60a530d0272..9dca1462421d 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -37,7 +37,7 @@ static int sja1105_xfer(const struct sja1105_private *priv,
 {
 	u8 hdr_buf[SJA1105_SIZE_SPI_MSG_HEADER] = {0};
 	struct spi_device *spi = priv->spidev;
-	struct spi_transfer xfers[2] = {0};
+	struct spi_transfer xfers[2] = {};
 	struct spi_transfer *chunk_xfer;
 	struct spi_transfer *hdr_xfer;
 	struct sja1105_chunk chunk;
diff --git a/drivers/net/dsa/sja1105/sja1105_static_config.c b/drivers/net/dsa/sja1105/sja1105_static_config.c
index 7a422ef4deb6..123864f4f7e1 100644
--- a/drivers/net/dsa/sja1105/sja1105_static_config.c
+++ b/drivers/net/dsa/sja1105/sja1105_static_config.c
@@ -1119,7 +1119,7 @@ sja1105_static_config_check_valid(const struct sja1105_static_config *config,
 void
 sja1105_static_config_pack(void *buf, struct sja1105_static_config *config)
 {
-	struct sja1105_table_header header = {0};
+	struct sja1105_table_header header = {};
 	enum sja1105_blk_idx i;
 	char *p = buf;
 	int j;
@@ -1889,7 +1889,7 @@ int sja1105_static_config_init(struct sja1105_static_config *config,
 {
 	enum sja1105_blk_idx i;
 
-	*config = (struct sja1105_static_config) {0};
+	*config = (struct sja1105_static_config) {};
 
 	/* Transfer static_ops array from priv into per-table ops
 	 * for handier access
diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
index e6153848a950..9d823ea0e1a2 100644
--- a/drivers/net/dsa/sja1105/sja1105_tas.c
+++ b/drivers/net/dsa/sja1105/sja1105_tas.c
@@ -582,7 +582,7 @@ static int sja1105_tas_check_running(struct sja1105_private *priv)
 {
 	struct sja1105_tas_data *tas_data = &priv->tas_data;
 	struct dsa_switch *ds = priv->ds;
-	struct sja1105_ptp_cmd cmd = {0};
+	struct sja1105_ptp_cmd cmd = {};
 	int rc;
 
 	rc = sja1105_ptp_commit(ds, &cmd, SPI_READ);
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
index 4a6dfac857ca..73d5d4dfc3d9 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
@@ -321,9 +321,9 @@ static int aq_mdo_dev_stop(struct macsec_context *ctx)
 static int aq_set_txsc(struct aq_nic_s *nic, const int txsc_idx)
 {
 	struct aq_macsec_txsc *aq_txsc = &nic->macsec_cfg->aq_txsc[txsc_idx];
-	struct aq_mss_egress_class_record tx_class_rec = { 0 };
+	struct aq_mss_egress_class_record tx_class_rec = { };
 	const struct macsec_secy *secy = aq_txsc->sw_secy;
-	struct aq_mss_egress_sc_record sc_rec = { 0 };
+	struct aq_mss_egress_sc_record sc_rec = { };
 	unsigned int sc_idx = aq_txsc->hw_sc_idx;
 	struct aq_hw_s *hw = nic->aq_hw;
 	int ret = 0;
@@ -505,8 +505,8 @@ static int aq_clear_txsc(struct aq_nic_s *nic, const int txsc_idx,
 			 enum aq_clear_type clear_type)
 {
 	struct aq_macsec_txsc *tx_sc = &nic->macsec_cfg->aq_txsc[txsc_idx];
-	struct aq_mss_egress_class_record tx_class_rec = { 0 };
-	struct aq_mss_egress_sc_record sc_rec = { 0 };
+	struct aq_mss_egress_class_record tx_class_rec = { };
+	struct aq_mss_egress_sc_record sc_rec = { };
 	struct aq_hw_s *hw = nic->aq_hw;
 	int ret = 0;
 	int sa_num;
@@ -1505,8 +1505,8 @@ void aq_macsec_free(struct aq_nic_s *nic)
 int aq_macsec_enable(struct aq_nic_s *nic)
 {
 	u32 ctl_ether_types[1] = { ETH_P_PAE };
-	struct macsec_msg_fw_response resp = { 0 };
-	struct macsec_msg_fw_request msg = { 0 };
+	struct macsec_msg_fw_response resp = { };
+	struct macsec_msg_fw_request msg = { };
 	struct aq_hw_s *hw = nic->aq_hw;
 	int num_ctl_ether_types = 0;
 	int index = 0, tbl_idx;
@@ -1518,7 +1518,7 @@ int aq_macsec_enable(struct aq_nic_s *nic)
 	rtnl_lock();
 
 	if (nic->aq_fw_ops->send_macsec_req) {
-		struct macsec_cfg_request cfg = { 0 };
+		struct macsec_cfg_request cfg = { };
 
 		cfg.enabled = 1;
 		cfg.egress_threshold = 0xffffffff;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index d8b1824c334d..b773ffdcbe0b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -507,7 +507,7 @@ static inline void bnx2x_update_rx_prod(struct bnx2x *bp,
 					u16 bd_prod, u16 rx_comp_prod,
 					u16 rx_sge_prod)
 {
-	struct ustorm_eth_rx_producers rx_prods = {0};
+	struct ustorm_eth_rx_producers rx_prods = {};
 	u32 i;
 
 	/* Update producers */
@@ -637,7 +637,7 @@ static inline void bnx2x_igu_ack_sb_gen(struct bnx2x *bp, u8 igu_sb_id,
 					u8 segment, u16 index, u8 op,
 					u8 update, u32 igu_addr)
 {
-	struct igu_regular cmd_data = {0};
+	struct igu_regular cmd_data = {};
 
 	cmd_data.sb_id_and_flags =
 			((index << IGU_REGULAR_SB_INDEX_SHIFT) |
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
index 17ae6df90723..4d327c30deb4 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_dcb.c
@@ -70,7 +70,7 @@ static void bnx2x_write_data(struct bnx2x *bp, u32 *buff,
 
 static void bnx2x_pfc_set(struct bnx2x *bp)
 {
-	struct bnx2x_nig_brb_pfc_port_params pfc_params = {0};
+	struct bnx2x_nig_brb_pfc_port_params pfc_params = {};
 	u32 pri_bit, val = 0;
 	int i;
 
@@ -115,7 +115,7 @@ static void bnx2x_pfc_set(struct bnx2x *bp)
 
 static void bnx2x_pfc_clear(struct bnx2x *bp)
 {
-	struct bnx2x_nig_brb_pfc_port_params nig_params = {0};
+	struct bnx2x_nig_brb_pfc_port_params nig_params = {};
 	nig_params.pause_enable = 1;
 	bnx2x_acquire_phy_lock(bp);
 	bp->link_params.feature_config_flags &= ~FEATURE_CONFIG_PFC_ENABLED;
@@ -567,7 +567,7 @@ static void bnx2x_dcbx_2cos_limit_update_ets_config(struct bnx2x *bp)
 static void bnx2x_dcbx_update_ets_config(struct bnx2x *bp)
 {
 	struct bnx2x_dcbx_pg_params *ets = &(bp->dcbx_port_params.ets);
-	struct bnx2x_ets_params ets_params = { 0 };
+	struct bnx2x_ets_params ets_params = { };
 	u8 i;
 
 	ets_params.num_of_cos = ets->num_of_cos;
@@ -623,7 +623,7 @@ static void bnx2x_dcbx_update_ets_params(struct bnx2x *bp)
 #ifdef BCM_DCBNL
 static int bnx2x_dcbx_read_shmem_remote_mib(struct bnx2x *bp)
 {
-	struct lldp_remote_mib remote_mib = {0};
+	struct lldp_remote_mib remote_mib = {};
 	u32 dcbx_remote_mib_offset = SHMEM2_RD(bp, dcbx_remote_mib_offset);
 	int rc;
 
@@ -652,7 +652,7 @@ static int bnx2x_dcbx_read_shmem_remote_mib(struct bnx2x *bp)
 
 static int bnx2x_dcbx_read_shmem_neg_results(struct bnx2x *bp)
 {
-	struct lldp_local_mib local_mib = {0};
+	struct lldp_local_mib local_mib = {};
 	u32 dcbx_neg_res_offset = SHMEM2_RD(bp, dcbx_neg_res_offset);
 	int rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
index 472a3a478038..49f967210b15 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c
@@ -965,7 +965,7 @@ static void bnx2x_get_regs(struct net_device *dev,
 {
 	u32 *p = _p;
 	struct bnx2x *bp = netdev_priv(dev);
-	struct dump_header dump_hdr = {0};
+	struct dump_header dump_hdr = {};
 
 	regs->version = 2;
 	memset(p, 0, regs->len);
@@ -1060,7 +1060,7 @@ static int bnx2x_get_dump_data(struct net_device *dev,
 {
 	u32 *p = buffer;
 	struct bnx2x *bp = netdev_priv(dev);
-	struct dump_header dump_hdr = {0};
+	struct dump_header dump_hdr = {};
 
 	/* Disable parity attentions as long as following dump may
 	 * cause false alarms by reading never written registers. We
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
index ae87296ae1ff..1b76af7277be 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c
@@ -3065,7 +3065,7 @@ static void storm_memset_func_cfg(struct bnx2x *bp,
 void bnx2x_func_init(struct bnx2x *bp, struct bnx2x_func_init_params *p)
 {
 	if (CHIP_IS_E1x(bp)) {
-		struct tstorm_eth_function_common_config tcfg = {0};
+		struct tstorm_eth_function_common_config tcfg = {};
 
 		storm_memset_func_cfg(bp, &tcfg, p->func_id);
 	}
@@ -3289,7 +3289,7 @@ static void bnx2x_pf_tx_q_prep(struct bnx2x *bp,
 
 static void bnx2x_pf_init(struct bnx2x *bp)
 {
-	struct bnx2x_func_init_params func_init = {0};
+	struct bnx2x_func_init_params func_init = {};
 	struct event_ring_data eq_data = { {0} };
 
 	if (!CHIP_IS_E1x(bp)) {
@@ -14578,7 +14578,7 @@ static int bnx2x_cnic_ctl_send_bh(struct bnx2x *bp, struct cnic_ctl_info *ctl)
  */
 int bnx2x_cnic_notify(struct bnx2x *bp, int cmd)
 {
-	struct cnic_ctl_info ctl = {0};
+	struct cnic_ctl_info ctl = {};
 
 	ctl.cmd = cmd;
 
@@ -14587,7 +14587,7 @@ int bnx2x_cnic_notify(struct bnx2x *bp, int cmd)
 
 static void bnx2x_cnic_cfc_comp(struct bnx2x *bp, int cid, u8 err)
 {
-	struct cnic_ctl_info ctl = {0};
+	struct cnic_ctl_info ctl = {};
 
 	/* first we tell CNIC and only then we count this as a completion */
 	ctl.cmd = CNIC_CTL_COMPLETION_CMD;
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index f255fd0b16db..166e56a3dffe 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -85,7 +85,7 @@ static void bnx2x_vf_igu_ack_sb(struct bnx2x *bp, struct bnx2x_virtf *vf,
 	u32 igu_addr_ctl = IGU_REG_COMMAND_REG_CTRL;
 	u32 func_encode = vf->abs_vfid;
 	u32 addr_encode = IGU_CMD_E2_PROD_UPD_BASE + igu_sb_id;
-	struct igu_regular cmd_data = {0};
+	struct igu_regular cmd_data = {};
 
 	cmd_data.sb_id_and_flags =
 			((index << IGU_REGULAR_SB_INDEX_SHIFT) |
@@ -2078,7 +2078,7 @@ int bnx2x_vf_acquire(struct bnx2x *bp, struct bnx2x_virtf *vf,
 
 int bnx2x_vf_init(struct bnx2x *bp, struct bnx2x_virtf *vf, dma_addr_t *sb_map)
 {
-	struct bnx2x_func_init_params func_init = {0};
+	struct bnx2x_func_init_params func_init = {};
 	int i;
 
 	/* the sb resources are initialized at this point, do the
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ea0c45d33814..6d22cb725176 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3067,7 +3067,7 @@ static void bnxt_free_rx_rings(struct bnxt *bp)
 static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
 				   struct bnxt_rx_ring_info *rxr)
 {
-	struct page_pool_params pp = { 0 };
+	struct page_pool_params pp = { };
 
 	pp.pool_size = bp->rx_ring_size;
 	pp.nid = dev_to_node(&bp->pdev->dev);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index bb7327b82d0b..ed3eed46ae27 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -422,7 +422,7 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 	enum bnxt_hwrm_chnl dst = BNXT_HWRM_CHNL_CHIMP;
 	u32 bar_offset = BNXT_GRCPF_REG_CHIMP_COMM;
 	struct bnxt_hwrm_wait_token *token = NULL;
-	struct hwrm_short_input short_input = {0};
+	struct hwrm_short_input short_input = {};
 	u16 max_req_len = BNXT_HWRM_MAX_REQ_LEN;
 	unsigned int i, timeout, tmo_count;
 	u32 *data = (u32 *)ctx->req;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 70d8ca3039dc..3a6a61b26557 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -1061,7 +1061,7 @@ static int bnxt_vf_set_link(struct bnxt *bp, struct bnxt_vf_info *vf)
 		rc = bnxt_hwrm_exec_fwd_resp(
 			bp, vf, sizeof(struct hwrm_port_phy_qcfg_input));
 	} else {
-		struct hwrm_port_phy_qcfg_output phy_qcfg_resp = {0};
+		struct hwrm_port_phy_qcfg_output phy_qcfg_resp = {};
 		struct hwrm_port_phy_qcfg_input *phy_qcfg_req;
 
 		phy_qcfg_req =
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index 46fae1acbeed..d7c67ff9bc2a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -1305,7 +1305,7 @@ static int bnxt_tc_get_decap_handle(struct bnxt *bp, struct bnxt_tc_flow *flow,
 	struct bnxt_tc_info *tc_info = bp->tc_info;
 	struct bnxt_tc_l2_key l2_info = { {0} };
 	struct bnxt_tc_tunnel_node *decap_node;
-	struct ip_tunnel_key tun_key = { 0 };
+	struct ip_tunnel_key tun_key = { };
 	struct bnxt_tc_l2_key *decap_l2_info;
 	__le32 ref_decap_handle;
 	int rc;
diff --git a/drivers/net/ethernet/broadcom/cnic.c b/drivers/net/ethernet/broadcom/cnic.c
index f7f10cfb3476..39ed7efe1d60 100644
--- a/drivers/net/ethernet/broadcom/cnic.c
+++ b/drivers/net/ethernet/broadcom/cnic.c
@@ -5178,7 +5178,7 @@ static void cnic_init_rings(struct cnic_dev *dev)
 		u32 cl_qzone_id;
 		struct client_init_ramrod_data *data;
 		union l5cm_specific_data l5_data;
-		struct ustorm_eth_rx_producers rx_prods = {0};
+		struct ustorm_eth_rx_producers rx_prods = {};
 		u32 off, i, *cid_ptr;
 
 		rx_prods.bd_prod = 0;
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
index 2b9747867d4c..ead01129d59a 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_ethtool.c
@@ -2421,7 +2421,7 @@ static int lio_set_intr_coalesce(struct net_device *netdev,
 	struct lio *lio = GET_LIO(netdev);
 	int ret;
 	struct octeon_device *oct = lio->oct_dev;
-	struct oct_intrmod_cfg intrmod = {0};
+	struct oct_intrmod_cfg intrmod = {};
 	u32 j, q_no;
 	int db_max, db_min;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
index a7f291c89702..758ac2ab4722 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.c
@@ -179,7 +179,7 @@ static const u32 t6_hma_ireg_array[][IREG_NUM_ELEM] = {
 
 u32 cudbg_get_entity_length(struct adapter *adap, u32 entity)
 {
-	struct cudbg_tcam tcam_region = { 0 };
+	struct cudbg_tcam tcam_region = { };
 	u32 value, n = 0, len = 0;
 
 	switch (entity) {
@@ -425,7 +425,7 @@ static int cudbg_do_compression(struct cudbg_init *pdbg_init,
 				struct cudbg_buffer *pin_buff,
 				struct cudbg_buffer *dbg_buff)
 {
-	struct cudbg_buffer temp_in_buff = { 0 };
+	struct cudbg_buffer temp_in_buff = { };
 	int bytes_left, bytes_read, bytes;
 	u32 offset = dbg_buff->offset;
 	int rc;
@@ -815,7 +815,7 @@ int cudbg_collect_reg_dump(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	u32 buf_size = 0;
 	int rc = 0;
 
@@ -836,7 +836,7 @@ int cudbg_collect_fw_devlog(struct cudbg_init *pdbg_init,
 			    struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct devlog_params *dparams;
 	int rc = 0;
 
@@ -874,7 +874,7 @@ int cudbg_collect_cim_la(struct cudbg_init *pdbg_init,
 			 struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int size, rc;
 	u32 cfg = 0;
 
@@ -915,7 +915,7 @@ int cudbg_collect_cim_ma_la(struct cudbg_init *pdbg_init,
 			    struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int size, rc;
 
 	size = 2 * CIM_MALA_SIZE * 5 * sizeof(u32);
@@ -935,7 +935,7 @@ int cudbg_collect_cim_qcfg(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_cim_qcfg *cim_qcfg_data;
 	int rc;
 
@@ -973,7 +973,7 @@ static int cudbg_read_cim_ibq(struct cudbg_init *pdbg_init,
 			      struct cudbg_error *cudbg_err, int qid)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int no_of_read_words, rc = 0;
 	u32 qsize;
 
@@ -1057,7 +1057,7 @@ static int cudbg_read_cim_obq(struct cudbg_init *pdbg_init,
 			      struct cudbg_error *cudbg_err, int qid)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int no_of_read_words, rc = 0;
 	u32 qsize;
 
@@ -1257,7 +1257,7 @@ static int cudbg_get_payload_range(struct adapter *padap, u8 mem_type,
 				   const char *region_name,
 				   struct cudbg_region_info *payload)
 {
-	struct cudbg_mem_desc mem_desc = { 0 };
+	struct cudbg_mem_desc mem_desc = { };
 	struct cudbg_meminfo meminfo;
 	int rc;
 
@@ -1371,7 +1371,7 @@ static int cudbg_read_fw_mem(struct cudbg_init *pdbg_init,
 						    "Rx payload:" };
 	unsigned long bytes, bytes_left, bytes_read = 0;
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_region_info payload[2];
 	u32 yield_count = 0;
 	int rc = 0;
@@ -1546,7 +1546,7 @@ int cudbg_collect_rss(struct cudbg_init *pdbg_init,
 		      struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int rc, nentries;
 
 	nentries = t4_chip_rss_size(padap);
@@ -1569,7 +1569,7 @@ int cudbg_collect_rss_vf_config(struct cudbg_init *pdbg_init,
 				struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_rss_vf_conf *vfconf;
 	int vf, rc, vf_count;
 
@@ -1592,7 +1592,7 @@ int cudbg_collect_path_mtu(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int rc;
 
 	rc = cudbg_get_buff(pdbg_init, dbg_buff, NMTUS * sizeof(u16),
@@ -1609,7 +1609,7 @@ int cudbg_collect_pm_stats(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_pm_stats *pm_stats_buff;
 	int rc;
 
@@ -1629,7 +1629,7 @@ int cudbg_collect_hw_sched(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_hw_sched *hw_sched_buff;
 	int i, rc = 0;
 
@@ -1657,7 +1657,7 @@ int cudbg_collect_tp_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct ireg_buf *ch_tp_pio;
 	int i, rc, n = 0;
 	u32 size;
@@ -1791,7 +1791,7 @@ int cudbg_collect_sge_indirect(struct cudbg_init *pdbg_init,
 			       struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct sge_qbase_reg_field *sge_qbase;
 	struct ireg_buf *ch_sge_dbg;
 	u8 padap_running = 0;
@@ -1864,7 +1864,7 @@ int cudbg_collect_ulprx_la(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_ulprx_la *ulprx_la_buff;
 	int rc;
 
@@ -1884,7 +1884,7 @@ int cudbg_collect_tp_la(struct cudbg_init *pdbg_init,
 			struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_tp_la *tp_la_buff;
 	int size, rc;
 
@@ -1904,7 +1904,7 @@ int cudbg_collect_meminfo(struct cudbg_init *pdbg_init,
 			  struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_meminfo *meminfo_buff;
 	struct cudbg_ver_hdr *ver_hdr;
 	int rc;
@@ -1939,7 +1939,7 @@ int cudbg_collect_cim_pif_la(struct cudbg_init *pdbg_init,
 {
 	struct cudbg_cim_pif_la *cim_pif_la_buff;
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	int size, rc;
 
 	size = sizeof(struct cudbg_cim_pif_la) +
@@ -1961,7 +1961,7 @@ int cudbg_collect_clk_info(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_clk_info *clk_info_buff;
 	u64 tp_tick_us;
 	int rc;
@@ -2009,7 +2009,7 @@ int cudbg_collect_pcie_indirect(struct cudbg_init *pdbg_init,
 				struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct ireg_buf *ch_pcie;
 	int i, rc, n;
 	u32 size;
@@ -2065,7 +2065,7 @@ int cudbg_collect_pm_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct ireg_buf *ch_pm;
 	int i, rc, n;
 	u32 size;
@@ -2122,7 +2122,7 @@ int cudbg_collect_tid(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_tid_info_region_rev1 *tid1;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_tid_info_region *tid;
 	u32 para[2], val[2];
 	int rc;
@@ -2213,7 +2213,7 @@ int cudbg_collect_pcie_config(struct cudbg_init *pdbg_init,
 			      struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	u32 size, *value, j;
 	int i, rc, n;
 
@@ -2394,7 +2394,7 @@ int cudbg_collect_dump_context(struct cudbg_init *pdbg_init,
 	struct adapter *padap = pdbg_init->adap;
 	u32 j, size, max_ctx_size, max_ctx_qid;
 	u8 mem_type[CTXT_INGRESS + 1] = { 0 };
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_ch_cntxt *buff;
 	u8 *ctx_buf;
 	u8 i, k;
@@ -2662,7 +2662,7 @@ int cudbg_collect_mps_tcam(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	u32 size = 0, i, n, total_size = 0;
 	struct cudbg_mps_tcam *tcam;
 	int rc;
@@ -2699,10 +2699,10 @@ int cudbg_collect_vpd_data(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	char vpd_str[CUDBG_VPD_VER_LEN + 1];
 	struct cudbg_vpd_data *vpd_data;
-	struct vpd_params vpd = { 0 };
+	struct vpd_params vpd = { };
 	u32 vpd_vers, fw_vers;
 	int rc;
 
@@ -2891,8 +2891,8 @@ int cudbg_collect_le_tcam(struct cudbg_init *pdbg_init,
 			  struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
-	struct cudbg_tcam tcam_region = { 0 };
+	struct cudbg_buffer temp_buff = { };
+	struct cudbg_tcam tcam_region = { };
 	struct cudbg_tid_data *tid_data;
 	u32 bytes = 0;
 	int rc, size;
@@ -2946,7 +2946,7 @@ int cudbg_collect_cctrl(struct cudbg_init *pdbg_init,
 			struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	u32 size;
 	int rc;
 
@@ -2964,7 +2964,7 @@ int cudbg_collect_ma_indirect(struct cudbg_init *pdbg_init,
 			      struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct ireg_buf *ma_indr;
 	int i, rc, n;
 	u32 size, j;
@@ -3018,7 +3018,7 @@ int cudbg_collect_ulptx_la(struct cudbg_init *pdbg_init,
 			   struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_ulptx_la *ulptx_la_buff;
 	struct cudbg_ver_hdr *ver_hdr;
 	u32 i, j;
@@ -3080,7 +3080,7 @@ int cudbg_collect_up_cim_indirect(struct cudbg_init *pdbg_init,
 				  struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	u32 local_offset, local_range;
 	struct ireg_buf *up_cim;
 	u32 size, j, iter;
@@ -3161,7 +3161,7 @@ int cudbg_collect_pbt_tables(struct cudbg_init *pdbg_init,
 			     struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_pbt_tables *pbt;
 	int i, rc;
 	u32 addr;
@@ -3230,7 +3230,7 @@ int cudbg_collect_mbox_log(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	struct cudbg_mbox_log *mboxlog = NULL;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct mbox_cmd_log *log = NULL;
 	struct mbox_cmd *entry;
 	unsigned int entry_idx;
@@ -3273,7 +3273,7 @@ int cudbg_collect_hma_indirect(struct cudbg_init *pdbg_init,
 			       struct cudbg_error *cudbg_err)
 {
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct ireg_buf *hma_indr;
 	int i, rc, n;
 	u32 size;
@@ -3364,7 +3364,7 @@ int cudbg_collect_qdesc(struct cudbg_init *pdbg_init,
 {
 	u32 num_queues = 0, tot_entries = 0, size = 0;
 	struct adapter *padap = pdbg_init->adap;
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct cudbg_qdesc_entry *qdesc_entry;
 	struct cudbg_qdesc_info *qdesc_info;
 	struct cudbg_ver_hdr *ver_hdr;
@@ -3567,7 +3567,7 @@ int cudbg_collect_flash(struct cudbg_init *pdbg_init,
 {
 	struct adapter *padap = pdbg_init->adap;
 	u32 count = padap->params.sf_size, n;
-	struct cudbg_buffer temp_buff = {0};
+	struct cudbg_buffer temp_buff = {};
 	u32 addr, i;
 	int rc;
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.c b/drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.c
index aad55fb3585f..c6783e21ce04 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cudbg_zlib.c
@@ -28,7 +28,7 @@ int cudbg_compress_buff(struct cudbg_init *pdbg_init,
 			struct cudbg_buffer *pin_buff,
 			struct cudbg_buffer *pout_buff)
 {
-	struct cudbg_buffer temp_buff = { 0 };
+	struct cudbg_buffer temp_buff = { };
 	struct z_stream_s compress_stream;
 	struct cudbg_compress_hdr *c_hdr;
 	int rc;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
index dd66b244466d..54c293607ce1 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_cudbg.c
@@ -106,7 +106,7 @@ static void cxgb4_cudbg_collect_entity(struct cudbg_init *pdbg_init,
 				       const struct cxgb4_collect_entity *e_arr,
 				       u32 arr_size, void *buf, u32 *tot_size)
 {
-	struct cudbg_error cudbg_err = { 0 };
+	struct cudbg_error cudbg_err = { };
 	struct cudbg_entity_hdr *entity_hdr;
 	u32 i, total_size = 0;
 	int ret;
@@ -163,7 +163,7 @@ static void cudbg_free_compress_buff(struct cudbg_init *pdbg_init)
 int cxgb4_cudbg_collect(struct adapter *adap, void *buf, u32 *buf_size,
 			u32 flag)
 {
-	struct cudbg_buffer dbg_buff = { 0 };
+	struct cudbg_buffer dbg_buff = { };
 	u32 size, min_size, total_size = 0;
 	struct cudbg_init cudbg_init;
 	struct cudbg_hdr *cudbg_hdr;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 0d9cda4ab303..cf1282d23990 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3493,8 +3493,8 @@ static int cxgb_set_tx_maxrate(struct net_device *dev, int index, u32 rate)
 {
 	struct port_info *pi = netdev_priv(dev);
 	struct adapter *adap = pi->adapter;
-	struct ch_sched_queue qe = { 0 };
-	struct ch_sched_params p = { 0 };
+	struct ch_sched_queue qe = { };
+	struct ch_sched_params p = { };
 	struct sched_class *e;
 	u32 req_rate;
 	int err = 0;
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index fa5b596ff23a..3f1d44901dd6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -907,7 +907,7 @@ void cxgb4_write_partial_sgl(const struct sk_buff *skb, struct sge_txq *q,
 			     struct ulptx_sgl *sgl, u64 *end,
 			     const dma_addr_t *addr, u32 start, u32 len)
 {
-	struct ulptx_sge_pair buf[MAX_SKB_FRAGS / 2 + 1] = {0}, *to;
+	struct ulptx_sge_pair buf[MAX_SKB_FRAGS / 2 + 1] = {}, *to;
 	u32 frag_size, skb_linear_data_len = skb_headlen(skb);
 	struct skb_shared_info *si = skb_shinfo(skb);
 	u8 i = 0, frag_idx = 0, nfrags = 0;
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
index 9098b3eed4da..c1a69d8dc034 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_main.c
@@ -467,7 +467,7 @@ static int chtls_uld_rx_handler(void *handle, const __be64 *rsp,
 static int do_chtls_getsockopt(struct sock *sk, char __user *optval,
 			       int __user *optlen)
 {
-	struct tls_crypto_info crypto_info = { 0 };
+	struct tls_crypto_info crypto_info = { };
 
 	crypto_info.version = TLS_1_2_VERSION;
 	if (copy_to_user(optval, &crypto_info, sizeof(struct tls_crypto_info)))
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 649c5c429bd7..0fd60b8c902d 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -1358,7 +1358,7 @@ int be_cmd_mccq_create(struct be_adapter *adapter,
 
 int be_cmd_txq_create(struct be_adapter *adapter, struct be_tx_obj *txo)
 {
-	struct be_mcc_wrb wrb = {0};
+	struct be_mcc_wrb wrb = {};
 	struct be_cmd_req_eth_tx_create *req;
 	struct be_queue_info *txq = &txo->q;
 	struct be_queue_info *cq = &txo->cq;
@@ -1534,7 +1534,7 @@ int be_cmd_rxq_destroy(struct be_adapter *adapter, struct be_queue_info *q)
 int be_cmd_if_create(struct be_adapter *adapter, u32 cap_flags, u32 en_flags,
 		     u32 *if_handle, u32 domain)
 {
-	struct be_mcc_wrb wrb = {0};
+	struct be_mcc_wrb wrb = {};
 	struct be_cmd_req_if_create *req;
 	int status;
 
@@ -1563,7 +1563,7 @@ int be_cmd_if_create(struct be_adapter *adapter, u32 cap_flags, u32 en_flags,
 /* Uses MCCQ if available else MBOX */
 int be_cmd_if_destroy(struct be_adapter *adapter, int interface_id, u32 domain)
 {
-	struct be_mcc_wrb wrb = {0};
+	struct be_mcc_wrb wrb = {};
 	struct be_cmd_req_if_destroy *req;
 	int status;
 
@@ -1768,7 +1768,7 @@ int be_cmd_get_die_temperature(struct be_adapter *adapter)
 /* Uses synchronous mcc */
 int be_cmd_get_fat_dump_len(struct be_adapter *adapter, u32 *dump_size)
 {
-	struct be_mcc_wrb wrb = {0};
+	struct be_mcc_wrb wrb = {};
 	struct be_cmd_req_get_fat *req;
 	int status;
 
@@ -4441,7 +4441,7 @@ int be_cmd_get_profile_config(struct be_adapter *adapter,
 	struct be_pcie_res_desc *pcie;
 	struct be_port_res_desc *port;
 	struct be_nic_res_desc *nic;
-	struct be_mcc_wrb wrb = {0};
+	struct be_mcc_wrb wrb = {};
 	struct be_dma_mem cmd;
 	u16 desc_count;
 	int status;
@@ -4529,7 +4529,7 @@ static int be_cmd_set_profile_config(struct be_adapter *adapter, void *desc,
 				     int size, int count, u8 version, u8 domain)
 {
 	struct be_cmd_req_set_profile_config *req;
-	struct be_mcc_wrb wrb = {0};
+	struct be_mcc_wrb wrb = {};
 	struct be_dma_mem cmd;
 	int status;
 
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 361c1c87c183..a58e8bf0ebf2 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1370,7 +1370,7 @@ static netdev_tx_t be_xmit(struct sk_buff *skb, struct net_device *netdev)
 	struct be_adapter *adapter = netdev_priv(netdev);
 	u16 q_idx = skb_get_queue_mapping(skb);
 	struct be_tx_obj *txo = &adapter->tx_obj[q_idx];
-	struct be_wrb_params wrb_params = { 0 };
+	struct be_wrb_params wrb_params = { };
 	bool flush = !netdev_xmit_more();
 	u16 wrb_cnt;
 
@@ -4042,7 +4042,7 @@ static void be_calculate_vf_res(struct be_adapter *adapter, u16 num_vfs,
 {
 	struct be_resources res = adapter->pool_res;
 	u32 vf_if_cap_flags = res.vf_if_cap_flags;
-	struct be_resources res_mod = {0};
+	struct be_resources res_mod = {};
 	u16 num_vf_qs = 1;
 
 	/* Distribute the queue resources among the PF and it's VFs */
@@ -4130,7 +4130,7 @@ static void be_if_destroy(struct be_adapter *adapter)
 static int be_clear(struct be_adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
-	struct  be_resources vft_res = {0};
+	struct  be_resources vft_res = {};
 
 	be_cancel_worker(adapter);
 
@@ -4165,7 +4165,7 @@ static int be_clear(struct be_adapter *adapter)
 
 static int be_vfs_if_create(struct be_adapter *adapter)
 {
-	struct be_resources res = {0};
+	struct be_resources res = {};
 	u32 cap_flags, en_flags, vf;
 	struct be_vf_cfg *vf_cfg;
 	int status;
@@ -4365,7 +4365,7 @@ static void BEx_get_resources(struct be_adapter *adapter,
 	     !(adapter->function_caps & BE_FUNCTION_CAPS_RSS))) {
 		res->max_tx_qs = 1;
 	} else if (adapter->function_caps & BE_FUNCTION_CAPS_SUPER_NIC) {
-		struct be_resources super_nic_res = {0};
+		struct be_resources super_nic_res = {};
 
 		/* On a SuperNIC profile, the driver needs to use the
 		 * GET_PROFILE_CONFIG cmd to query the per-function TXQ limits
@@ -4420,7 +4420,7 @@ static void be_setup_init(struct be_adapter *adapter)
  */
 static void be_calculate_pf_pool_rss_tables(struct be_adapter *adapter)
 {
-	struct be_port_resources port_res = {0};
+	struct be_port_resources port_res = {};
 	u8 rss_tables_on_port;
 	u16 max_vfs = be_max_vfs(adapter);
 
@@ -4438,7 +4438,7 @@ static void be_calculate_pf_pool_rss_tables(struct be_adapter *adapter)
 
 static int be_get_sriov_config(struct be_adapter *adapter)
 {
-	struct be_resources res = {0};
+	struct be_resources res = {};
 	int max_vfs, old_vfs;
 
 	be_cmd_get_profile_config(adapter, &res, NULL, ACTIVE_PROFILE_TYPE,
@@ -4478,7 +4478,7 @@ static int be_get_sriov_config(struct be_adapter *adapter)
 static void be_alloc_sriov_res(struct be_adapter *adapter)
 {
 	int old_vfs = pci_num_vf(adapter->pdev);
-	struct  be_resources vft_res = {0};
+	struct  be_resources vft_res = {};
 	int status;
 
 	be_get_sriov_config(adapter);
@@ -4504,7 +4504,7 @@ static void be_alloc_sriov_res(struct be_adapter *adapter)
 static int be_get_resources(struct be_adapter *adapter)
 {
 	struct device *dev = &adapter->pdev->dev;
-	struct be_resources res = {0};
+	struct be_resources res = {};
 	int status;
 
 	/* For Lancer, SH etc read per-function resource limits from FW.
@@ -6040,7 +6040,7 @@ static void be_eeh_resume(struct pci_dev *pdev)
 static int be_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 {
 	struct be_adapter *adapter = pci_get_drvdata(pdev);
-	struct be_resources vft_res = {0};
+	struct be_resources vft_res = {};
 	int status;
 
 	if (!num_vfs)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-dcb.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-dcb.c
index 84de0644168d..6891113fefcc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-dcb.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-dcb.c
@@ -24,7 +24,7 @@ static inline bool dpaa2_eth_is_prio_enabled(u8 pfc_en, u8 tc)
 
 static int dpaa2_eth_set_pfc_cn(struct dpaa2_eth_priv *priv, u8 pfc_en)
 {
-	struct dpni_congestion_notification_cfg cfg = {0};
+	struct dpni_congestion_notification_cfg cfg = {};
 	int i, err;
 
 	cfg.notification_mode = DPNI_CONG_OPT_FLOW_CONTROL;
@@ -62,7 +62,7 @@ static int dpaa2_eth_dcbnl_ieee_setpfc(struct net_device *net_dev,
 				       struct ieee_pfc *pfc)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
-	struct dpni_link_cfg link_cfg = {0};
+	struct dpni_link_cfg link_cfg = {};
 	bool tx_pause;
 	int err;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
index 605a39f892b9..2062cf41dc73 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
@@ -152,7 +152,7 @@ static int dpaa2_eth_dl_trap_group_action_set(struct devlink *devlink,
 	struct dpaa2_eth_priv *priv = dl_priv->dpaa2_priv;
 	struct net_device *net_dev = priv->net_dev;
 	struct device *dev = net_dev->dev.parent;
-	struct dpni_error_cfg err_cfg = {0};
+	struct dpni_error_cfg err_cfg = {};
 	int err;
 
 	if (group->id != DEVLINK_TRAP_GROUP_GENERIC_ID_PARSER_ERROR_DROPS)
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 7065c71ed7b8..81fea854f7bd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -1658,7 +1658,7 @@ static void dpaa2_eth_disable_ch_napi(struct dpaa2_eth_priv *priv)
 void dpaa2_eth_set_rx_taildrop(struct dpaa2_eth_priv *priv,
 			       bool tx_pause, bool pfc)
 {
-	struct dpni_taildrop td = {0};
+	struct dpni_taildrop td = {};
 	struct dpaa2_eth_fq *fq;
 	int i, err;
 
@@ -1720,7 +1720,7 @@ void dpaa2_eth_set_rx_taildrop(struct dpaa2_eth_priv *priv,
 
 static int dpaa2_eth_link_state_update(struct dpaa2_eth_priv *priv)
 {
-	struct dpni_link_state state = {0};
+	struct dpni_link_state state = {};
 	bool tx_pause;
 	int err;
 
@@ -2277,7 +2277,7 @@ static int dpaa2_eth_change_mtu(struct net_device *dev, int new_mtu)
 
 static int dpaa2_eth_update_rx_buffer_headroom(struct dpaa2_eth_priv *priv, bool has_xdp)
 {
-	struct dpni_buffer_layout buf_layout = {0};
+	struct dpni_buffer_layout buf_layout = {};
 	int err;
 
 	err = dpni_get_buffer_layout(priv->mc_io, 0, priv->mc_token,
@@ -2538,8 +2538,8 @@ static int dpaa2_eth_setup_tbf(struct net_device *net_dev, struct tc_tbf_qopt_of
 {
 	struct tc_tbf_qopt_offload_replace_params *cfg = &p->replace_params;
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
-	struct dpni_tx_shaping_cfg tx_cr_shaper = { 0 };
-	struct dpni_tx_shaping_cfg tx_er_shaper = { 0 };
+	struct dpni_tx_shaping_cfg tx_cr_shaper = { };
+	struct dpni_tx_shaping_cfg tx_er_shaper = { };
 	int err;
 
 	if (p->command == TC_TBF_STATS)
@@ -2992,7 +2992,7 @@ static void dpaa2_eth_free_dpbp(struct dpaa2_eth_priv *priv)
 static int dpaa2_eth_set_buffer_layout(struct dpaa2_eth_priv *priv)
 {
 	struct device *dev = priv->net_dev->dev.parent;
-	struct dpni_buffer_layout buf_layout = {0};
+	struct dpni_buffer_layout buf_layout = {};
 	u16 rx_buf_align;
 	int err;
 
@@ -3121,7 +3121,7 @@ static void dpaa2_eth_set_enqueue_mode(struct dpaa2_eth_priv *priv)
 static int dpaa2_eth_set_pause(struct dpaa2_eth_priv *priv)
 {
 	struct device *dev = priv->net_dev->dev.parent;
-	struct dpni_link_cfg link_cfg = {0};
+	struct dpni_link_cfg link_cfg = {};
 	int err;
 
 	/* Get the default link options so we don't override other flags */
@@ -3147,7 +3147,7 @@ static int dpaa2_eth_set_pause(struct dpaa2_eth_priv *priv)
 
 static void dpaa2_eth_update_tx_fqids(struct dpaa2_eth_priv *priv)
 {
-	struct dpni_queue_id qid = {0};
+	struct dpni_queue_id qid = {};
 	struct dpaa2_eth_fq *fq;
 	struct dpni_queue queue;
 	int i, j, err;
@@ -3190,8 +3190,8 @@ static void dpaa2_eth_update_tx_fqids(struct dpaa2_eth_priv *priv)
 static int dpaa2_eth_set_vlan_qos(struct dpaa2_eth_priv *priv)
 {
 	struct device *dev = priv->net_dev->dev.parent;
-	struct dpkg_profile_cfg kg_cfg = {0};
-	struct dpni_qos_tbl_cfg qos_cfg = {0};
+	struct dpkg_profile_cfg kg_cfg = {};
+	struct dpni_qos_tbl_cfg qos_cfg = {};
 	struct dpni_rule_cfg key_params;
 	void *dma_mem, *key, *mask;
 	u8 key_size = 2;	/* VLAN TCI field */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
index 2da5f881f630..a972209bea04 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ethtool.c
@@ -141,7 +141,7 @@ static int dpaa2_eth_set_pauseparam(struct net_device *net_dev,
 				    struct ethtool_pauseparam *pause)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
-	struct dpni_link_cfg cfg = {0};
+	struct dpni_link_cfg cfg = {};
 	int err;
 
 	if (!dpaa2_eth_has_pause_support(priv)) {
@@ -543,8 +543,8 @@ static int dpaa2_eth_do_cls_rule(struct net_device *net_dev,
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	struct device *dev = net_dev->dev.parent;
-	struct dpni_rule_cfg rule_cfg = { 0 };
-	struct dpni_fs_action_cfg fs_act = { 0 };
+	struct dpni_rule_cfg rule_cfg = { };
+	struct dpni_fs_action_cfg fs_act = { };
 	dma_addr_t key_iova;
 	u64 fields = 0;
 	void *key_buf;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
index 720c9230cab5..0a53432a8a61 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-ethtool.c
@@ -59,7 +59,7 @@ dpaa2_switch_get_link_ksettings(struct net_device *netdev,
 				struct ethtool_link_ksettings *link_ksettings)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-	struct dpsw_link_state state = {0};
+	struct dpsw_link_state state = {};
 	int err = 0;
 
 	if (dpaa2_switch_port_is_type_phy(port_priv))
@@ -95,7 +95,7 @@ dpaa2_switch_set_link_ksettings(struct net_device *netdev,
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct dpsw_link_cfg cfg = {0};
+	struct dpsw_link_cfg cfg = {};
 	bool if_running;
 	int err = 0, ret;
 
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 175f15c46842..58d97f1afdcc 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -192,7 +192,7 @@ static void *dpaa2_iova_to_virt(struct iommu_domain *domain,
 static int dpaa2_switch_add_vlan(struct ethsw_port_priv *port_priv, u16 vid)
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
-	struct dpsw_vlan_cfg vcfg = {0};
+	struct dpsw_vlan_cfg vcfg = {};
 	int err;
 
 	vcfg.fdb_id = dpaa2_switch_port_get_fdb_id(port_priv);
@@ -230,7 +230,7 @@ static int dpaa2_switch_port_set_pvid(struct ethsw_port_priv *port_priv, u16 pvi
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
-	struct dpsw_tci_cfg tci_cfg = { 0 };
+	struct dpsw_tci_cfg tci_cfg = { };
 	bool up;
 	int err, ret;
 
@@ -286,7 +286,7 @@ static int dpaa2_switch_port_add_vlan(struct ethsw_port_priv *port_priv,
 {
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct net_device *netdev = port_priv->netdev;
-	struct dpsw_vlan_if_cfg vcfg = {0};
+	struct dpsw_vlan_if_cfg vcfg = {};
 	int err;
 
 	if (port_priv->vlans[vid]) {
@@ -350,7 +350,7 @@ static enum dpsw_stp_state br_stp_state_to_dpsw(u8 state)
 
 static int dpaa2_switch_port_set_stp_state(struct ethsw_port_priv *port_priv, u8 state)
 {
-	struct dpsw_stp_cfg stp_cfg = {0};
+	struct dpsw_stp_cfg stp_cfg = {};
 	int err;
 	u16 vid;
 
@@ -403,7 +403,7 @@ static int dpaa2_switch_dellink(struct ethsw_core *ethsw, u16 vid)
 static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
 					const unsigned char *addr)
 {
-	struct dpsw_fdb_unicast_cfg entry = {0};
+	struct dpsw_fdb_unicast_cfg entry = {};
 	u16 fdb_id;
 	int err;
 
@@ -424,7 +424,7 @@ static int dpaa2_switch_port_fdb_add_uc(struct ethsw_port_priv *port_priv,
 static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
 					const unsigned char *addr)
 {
-	struct dpsw_fdb_unicast_cfg entry = {0};
+	struct dpsw_fdb_unicast_cfg entry = {};
 	u16 fdb_id;
 	int err;
 
@@ -446,7 +446,7 @@ static int dpaa2_switch_port_fdb_del_uc(struct ethsw_port_priv *port_priv,
 static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
 					const unsigned char *addr)
 {
-	struct dpsw_fdb_multicast_cfg entry = {0};
+	struct dpsw_fdb_multicast_cfg entry = {};
 	u16 fdb_id;
 	int err;
 
@@ -469,7 +469,7 @@ static int dpaa2_switch_port_fdb_add_mc(struct ethsw_port_priv *port_priv,
 static int dpaa2_switch_port_fdb_del_mc(struct ethsw_port_priv *port_priv,
 					const unsigned char *addr)
 {
-	struct dpsw_fdb_multicast_cfg entry = {0};
+	struct dpsw_fdb_multicast_cfg entry = {};
 	u16 fdb_id;
 	int err;
 
@@ -2618,7 +2618,7 @@ static void dpaa2_switch_drain_bp(struct ethsw_core *ethsw)
 
 static int dpaa2_switch_setup_dpbp(struct ethsw_core *ethsw)
 {
-	struct dpsw_ctrl_if_pools_cfg dpsw_ctrl_if_pools_cfg = { 0 };
+	struct dpsw_ctrl_if_pools_cfg dpsw_ctrl_if_pools_cfg = { };
 	struct device *dev = ethsw->dev;
 	struct fsl_mc_device *dpbp_dev;
 	struct dpbp_attr dpbp_attrs;
@@ -2941,8 +2941,8 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 {
 	struct device *dev = &sw_dev->dev;
 	struct ethsw_core *ethsw = dev_get_drvdata(dev);
-	struct dpsw_vlan_if_cfg vcfg = {0};
-	struct dpsw_tci_cfg tci_cfg = {0};
+	struct dpsw_vlan_if_cfg vcfg = {};
+	struct dpsw_tci_cfg tci_cfg = {};
 	struct dpsw_stp_cfg stp_cfg;
 	int err;
 	u16 i;
@@ -3077,7 +3077,7 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 static int dpaa2_switch_port_trap_mac_addr(struct ethsw_port_priv *port_priv,
 					   const char *mac)
 {
-	struct dpaa2_switch_acl_entry acl_entry = {0};
+	struct dpaa2_switch_acl_entry acl_entry = {};
 
 	/* Match on the destination MAC address */
 	ether_addr_copy(acl_entry.key.match.l2_dest_mac, mac);
@@ -3101,7 +3101,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
 	struct net_device *netdev = port_priv->netdev;
 	struct ethsw_core *ethsw = port_priv->ethsw_data;
 	struct dpaa2_switch_filter_block *filter_block;
-	struct dpsw_fdb_cfg fdb_cfg = {0};
+	struct dpsw_fdb_cfg fdb_cfg = {};
 	struct dpsw_if_attr dpsw_if_attr;
 	struct dpaa2_switch_fdb *fdb;
 	struct dpsw_acl_cfg acl_cfg;
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpmac.c b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
index d5997b654562..608330bcd94a 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpmac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpmac.c
@@ -29,7 +29,7 @@ int dpmac_open(struct fsl_mc_io *mc_io,
 	       u16 *token)
 {
 	struct dpmac_cmd_open *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -65,7 +65,7 @@ int dpmac_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_CLOSE, cmd_flags,
@@ -91,7 +91,7 @@ int dpmac_get_attributes(struct fsl_mc_io *mc_io,
 			 struct dpmac_attr *attr)
 {
 	struct dpmac_rsp_get_attributes *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -129,7 +129,7 @@ int dpmac_set_link_state(struct fsl_mc_io *mc_io,
 			 struct dpmac_link_state *link_state)
 {
 	struct dpmac_cmd_set_link_state *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_SET_LINK_STATE,
@@ -163,7 +163,7 @@ int dpmac_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 {
 	struct dpmac_cmd_get_counter *dpmac_cmd;
 	struct dpmac_rsp_get_counter *dpmac_rsp;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err = 0;
 
 	cmd.header = mc_encode_cmd_header(DPMAC_CMDID_GET_COUNTER,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpni.c b/drivers/net/ethernet/freescale/dpaa2/dpni.c
index d6afada99fb6..1a46edb92229 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpni.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpni.c
@@ -97,7 +97,7 @@ int dpni_open(struct fsl_mc_io *mc_io,
 	      int dpni_id,
 	      u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_open *cmd_params;
 
 	int err;
@@ -135,7 +135,7 @@ int dpni_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_CLOSE,
@@ -163,7 +163,7 @@ int dpni_set_pools(struct fsl_mc_io *mc_io,
 		   u16 token,
 		   const struct dpni_pools_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_pools *cmd_params;
 	int i;
 
@@ -197,7 +197,7 @@ int dpni_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ENABLE,
@@ -220,7 +220,7 @@ int dpni_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_DISABLE,
@@ -245,7 +245,7 @@ int dpni_is_enabled(struct fsl_mc_io *mc_io,
 		    u16 token,
 		    int *en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_is_enabled *rsp_params;
 	int err;
 
@@ -278,7 +278,7 @@ int dpni_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_RESET,
@@ -310,7 +310,7 @@ int dpni_set_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_irq_enable *cmd_params;
 
 	/* prepare command */
@@ -341,7 +341,7 @@ int dpni_get_irq_enable(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u8 *en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_irq_enable *cmd_params;
 	struct dpni_rsp_get_irq_enable *rsp_params;
 
@@ -388,7 +388,7 @@ int dpni_set_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 mask)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_irq_mask *cmd_params;
 
 	/* prepare command */
@@ -422,7 +422,7 @@ int dpni_get_irq_mask(struct fsl_mc_io *mc_io,
 		      u8 irq_index,
 		      u32 *mask)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_irq_mask *cmd_params;
 	struct dpni_rsp_get_irq_mask *rsp_params;
 	int err;
@@ -464,7 +464,7 @@ int dpni_get_irq_status(struct fsl_mc_io *mc_io,
 			u8 irq_index,
 			u32 *status)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_irq_status *cmd_params;
 	struct dpni_rsp_get_irq_status *rsp_params;
 	int err;
@@ -507,7 +507,7 @@ int dpni_clear_irq_status(struct fsl_mc_io *mc_io,
 			  u8 irq_index,
 			  u32 status)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_clear_irq_status *cmd_params;
 
 	/* prepare command */
@@ -536,7 +536,7 @@ int dpni_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpni_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_attr *rsp_params;
 
 	int err;
@@ -584,7 +584,7 @@ int dpni_set_errors_behavior(struct fsl_mc_io *mc_io,
 			     u16 token,
 			     struct dpni_error_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_errors_behavior *cmd_params;
 
 	/* prepare command */
@@ -616,7 +616,7 @@ int dpni_get_buffer_layout(struct fsl_mc_io *mc_io,
 			   enum dpni_queue_type qtype,
 			   struct dpni_buffer_layout *layout)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_buffer_layout *cmd_params;
 	struct dpni_rsp_get_buffer_layout *rsp_params;
 	int err;
@@ -664,7 +664,7 @@ int dpni_set_buffer_layout(struct fsl_mc_io *mc_io,
 			   enum dpni_queue_type qtype,
 			   const struct dpni_buffer_layout *layout)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_buffer_layout *cmd_params;
 
 	/* prepare command */
@@ -706,7 +706,7 @@ int dpni_set_offload(struct fsl_mc_io *mc_io,
 		     enum dpni_offload type,
 		     u32 config)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_offload *cmd_params;
 
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_OFFLOAD,
@@ -725,7 +725,7 @@ int dpni_get_offload(struct fsl_mc_io *mc_io,
 		     enum dpni_offload type,
 		     u32 *config)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_offload *cmd_params;
 	struct dpni_rsp_get_offload *rsp_params;
 	int err;
@@ -767,7 +767,7 @@ int dpni_get_qdid(struct fsl_mc_io *mc_io,
 		  enum dpni_queue_type qtype,
 		  u16 *qdid)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_qdid *cmd_params;
 	struct dpni_rsp_get_qdid *rsp_params;
 	int err;
@@ -805,7 +805,7 @@ int dpni_get_tx_data_offset(struct fsl_mc_io *mc_io,
 			    u16 token,
 			    u16 *data_offset)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_tx_data_offset *rsp_params;
 	int err;
 
@@ -840,7 +840,7 @@ int dpni_set_link_cfg(struct fsl_mc_io *mc_io,
 		      u16 token,
 		      const struct dpni_link_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_link_cfg *cmd_params;
 
 	/* prepare command */
@@ -869,7 +869,7 @@ int dpni_get_link_cfg(struct fsl_mc_io *mc_io,
 		      u16 token,
 		      struct dpni_link_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_link_cfg *rsp_params;
 	int err;
 
@@ -905,7 +905,7 @@ int dpni_get_link_state(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpni_link_state *state)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_link_state *rsp_params;
 	int err;
 
@@ -944,7 +944,7 @@ int dpni_set_max_frame_length(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      u16 max_frame_length)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_max_frame_length *cmd_params;
 
 	/* prepare command */
@@ -974,7 +974,7 @@ int dpni_get_max_frame_length(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      u16 *max_frame_length)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_max_frame_length *rsp_params;
 	int err;
 
@@ -1009,7 +1009,7 @@ int dpni_set_multicast_promisc(struct fsl_mc_io *mc_io,
 			       u16 token,
 			       int en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_multicast_promisc *cmd_params;
 
 	/* prepare command */
@@ -1037,7 +1037,7 @@ int dpni_get_multicast_promisc(struct fsl_mc_io *mc_io,
 			       u16 token,
 			       int *en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_multicast_promisc *rsp_params;
 	int err;
 
@@ -1072,7 +1072,7 @@ int dpni_set_unicast_promisc(struct fsl_mc_io *mc_io,
 			     u16 token,
 			     int en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_unicast_promisc *cmd_params;
 
 	/* prepare command */
@@ -1100,7 +1100,7 @@ int dpni_get_unicast_promisc(struct fsl_mc_io *mc_io,
 			     u16 token,
 			     int *en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_unicast_promisc *rsp_params;
 	int err;
 
@@ -1135,7 +1135,7 @@ int dpni_set_primary_mac_addr(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      const u8 mac_addr[6])
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_primary_mac_addr *cmd_params;
 	int i;
 
@@ -1165,7 +1165,7 @@ int dpni_get_primary_mac_addr(struct fsl_mc_io *mc_io,
 			      u16 token,
 			      u8 mac_addr[6])
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_primary_mac_addr *rsp_params;
 	int i, err;
 
@@ -1204,7 +1204,7 @@ int dpni_get_port_mac_addr(struct fsl_mc_io *mc_io,
 			   u16 token,
 			   u8 mac_addr[6])
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_rsp_get_port_mac_addr *rsp_params;
 	int i, err;
 
@@ -1241,7 +1241,7 @@ int dpni_enable_vlan_filter(struct fsl_mc_io *mc_io,
 			    u32 en)
 {
 	struct dpni_cmd_enable_vlan_filter *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ENABLE_VLAN_FILTER,
@@ -1277,7 +1277,7 @@ int dpni_add_vlan_id(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		     u16 vlan_id, u8 flags, u8 tc_id, u8 flow_id)
 {
 	struct dpni_cmd_vlan_id *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ADD_VLAN_ID,
@@ -1306,7 +1306,7 @@ int dpni_remove_vlan_id(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u16 vlan_id)
 {
 	struct dpni_cmd_vlan_id *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_REMOVE_VLAN_ID,
@@ -1333,7 +1333,7 @@ int dpni_add_mac_addr(struct fsl_mc_io *mc_io,
 		      u16 token,
 		      const u8 mac_addr[6])
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_add_mac_addr *cmd_params;
 	int i;
 
@@ -1363,7 +1363,7 @@ int dpni_remove_mac_addr(struct fsl_mc_io *mc_io,
 			 u16 token,
 			 const u8 mac_addr[6])
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_remove_mac_addr *cmd_params;
 	int i;
 
@@ -1397,7 +1397,7 @@ int dpni_clear_mac_filters(struct fsl_mc_io *mc_io,
 			   int unicast,
 			   int multicast)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_clear_mac_filters *cmd_params;
 
 	/* prepare command */
@@ -1431,7 +1431,7 @@ int dpni_set_rx_tc_dist(struct fsl_mc_io *mc_io,
 			u8 tc_id,
 			const struct dpni_rx_tc_dist_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_rx_tc_dist *cmd_params;
 
 	/* prepare command */
@@ -1471,7 +1471,7 @@ int dpni_set_congestion_notification(
 			const struct dpni_congestion_notification_cfg *cfg)
 {
 	struct dpni_cmd_set_congestion_notification *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header =
@@ -1521,7 +1521,7 @@ int dpni_set_queue(struct fsl_mc_io *mc_io,
 		   u8 options,
 		   const struct dpni_queue *queue)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_queue *cmd_params;
 
 	/* prepare command */
@@ -1569,7 +1569,7 @@ int dpni_get_queue(struct fsl_mc_io *mc_io,
 		   struct dpni_queue *queue,
 		   struct dpni_queue_id *qid)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_queue *cmd_params;
 	struct dpni_rsp_get_queue *rsp_params;
 	int err;
@@ -1623,7 +1623,7 @@ int dpni_get_statistics(struct fsl_mc_io *mc_io,
 			u8 page,
 			union dpni_statistics *stat)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_statistics *cmd_params;
 	struct dpni_rsp_get_statistics *rsp_params;
 	int i, err;
@@ -1672,7 +1672,7 @@ int dpni_set_taildrop(struct fsl_mc_io *mc_io,
 		      u8 index,
 		      struct dpni_taildrop *taildrop)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_set_taildrop *cmd_params;
 
 	/* prepare command */
@@ -1716,7 +1716,7 @@ int dpni_get_taildrop(struct fsl_mc_io *mc_io,
 		      u8 index,
 		      struct dpni_taildrop *taildrop)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpni_cmd_get_taildrop *cmd_params;
 	struct dpni_rsp_get_taildrop *rsp_params;
 	int err;
@@ -1760,7 +1760,7 @@ int dpni_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *minor_ver)
 {
 	struct dpni_rsp_get_api_version *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_API_VERSION,
@@ -1804,7 +1804,7 @@ int dpni_set_rx_fs_dist(struct fsl_mc_io *mc_io,
 			const struct dpni_rx_dist_cfg *cfg)
 {
 	struct dpni_cmd_set_rx_fs_dist *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_RX_FS_DIST,
@@ -1839,7 +1839,7 @@ int dpni_set_rx_hash_dist(struct fsl_mc_io *mc_io,
 			  const struct dpni_rx_dist_cfg *cfg)
 {
 	struct dpni_cmd_set_rx_hash_dist *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_RX_HASH_DIST,
@@ -1879,7 +1879,7 @@ int dpni_add_fs_entry(struct fsl_mc_io *mc_io,
 		      const struct dpni_fs_action_cfg *action)
 {
 	struct dpni_cmd_add_fs_entry *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ADD_FS_ENT,
@@ -1917,7 +1917,7 @@ int dpni_remove_fs_entry(struct fsl_mc_io *mc_io,
 			 const struct dpni_rule_cfg *cfg)
 {
 	struct dpni_cmd_remove_fs_entry *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_REMOVE_FS_ENT,
@@ -1954,7 +1954,7 @@ int dpni_set_qos_table(struct fsl_mc_io *mc_io,
 		       const struct dpni_qos_tbl_cfg *cfg)
 {
 	struct dpni_cmd_set_qos_table *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_QOS_TBL,
@@ -1991,7 +1991,7 @@ int dpni_add_qos_entry(struct fsl_mc_io *mc_io,
 		       u16 index)
 {
 	struct dpni_cmd_add_qos_entry *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ADD_QOS_ENT,
@@ -2023,7 +2023,7 @@ int dpni_remove_qos_entry(struct fsl_mc_io *mc_io,
 			  const struct dpni_rule_cfg *cfg)
 {
 	struct dpni_cmd_remove_qos_entry *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_REMOVE_QOS_ENT,
@@ -2053,7 +2053,7 @@ int dpni_clear_qos_table(struct fsl_mc_io *mc_io,
 			 u32 cmd_flags,
 			 u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_CLR_QOS_TBL,
@@ -2083,7 +2083,7 @@ int dpni_set_tx_shaping(struct fsl_mc_io *mc_io,
 			int coupled)
 {
 	struct dpni_cmd_set_tx_shaping *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_TX_SHAPING,
@@ -2117,7 +2117,7 @@ int dpni_get_single_step_cfg(struct fsl_mc_io *mc_io,
 			     struct dpni_single_step_cfg *ptp_cfg)
 {
 	struct dpni_rsp_single_step_cfg *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -2159,7 +2159,7 @@ int dpni_set_single_step_cfg(struct fsl_mc_io *mc_io,
 			     struct dpni_single_step_cfg *ptp_cfg)
 {
 	struct dpni_cmd_single_step_cfg *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	u16 flags;
 
 	/* prepare command */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dprtc.c b/drivers/net/ethernet/freescale/dpaa2/dprtc.c
index ed52a34fa6a1..58121c485a62 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dprtc.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dprtc.c
@@ -32,7 +32,7 @@ int dprtc_open(struct fsl_mc_io *mc_io,
 	       u16 *token)
 {
 	struct dprtc_cmd_open *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_OPEN,
@@ -65,7 +65,7 @@ int dprtc_close(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_CLOSE, cmd_flags,
 					  token);
@@ -95,7 +95,7 @@ int dprtc_set_irq_enable(struct fsl_mc_io *mc_io,
 			 u8 en)
 {
 	struct dprtc_cmd_set_irq_enable *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_SET_IRQ_ENABLE,
 					  cmd_flags,
@@ -125,7 +125,7 @@ int dprtc_get_irq_enable(struct fsl_mc_io *mc_io,
 {
 	struct dprtc_rsp_get_irq_enable *rsp_params;
 	struct dprtc_cmd_get_irq *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_GET_IRQ_ENABLE,
@@ -167,7 +167,7 @@ int dprtc_set_irq_mask(struct fsl_mc_io *mc_io,
 		       u32 mask)
 {
 	struct dprtc_cmd_set_irq_mask *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_SET_IRQ_MASK,
 					  cmd_flags,
@@ -200,7 +200,7 @@ int dprtc_get_irq_mask(struct fsl_mc_io *mc_io,
 {
 	struct dprtc_rsp_get_irq_mask *rsp_params;
 	struct dprtc_cmd_get_irq *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_GET_IRQ_MASK,
@@ -240,7 +240,7 @@ int dprtc_get_irq_status(struct fsl_mc_io *mc_io,
 {
 	struct dprtc_cmd_get_irq_status *cmd_params;
 	struct dprtc_rsp_get_irq_status *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_GET_IRQ_STATUS,
@@ -280,7 +280,7 @@ int dprtc_clear_irq_status(struct fsl_mc_io *mc_io,
 			   u32 status)
 {
 	struct dprtc_cmd_clear_irq_status *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPRTC_CMDID_CLEAR_IRQ_STATUS,
 					  cmd_flags,
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpsw.c b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
index ab921d75deb2..7f004fb14a20 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpsw.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpsw.c
@@ -38,7 +38,7 @@ static void build_if_id_bitmap(__le64 *bmap, const u16 *id, const u16 num_ifs)
  */
 int dpsw_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpsw_id, u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_open *cmd_params;
 	int err;
 
@@ -73,7 +73,7 @@ int dpsw_open(struct fsl_mc_io *mc_io, u32 cmd_flags, int dpsw_id, u16 *token)
  */
 int dpsw_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CLOSE,
@@ -94,7 +94,7 @@ int dpsw_close(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpsw_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ENABLE,
@@ -115,7 +115,7 @@ int dpsw_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpsw_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_DISABLE,
@@ -136,7 +136,7 @@ int dpsw_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpsw_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_RESET,
@@ -165,7 +165,7 @@ int dpsw_reset(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 int dpsw_set_irq_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 irq_index, u8 en)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_set_irq_enable *cmd_params;
 
 	/* prepare command */
@@ -199,7 +199,7 @@ int dpsw_set_irq_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_set_irq_mask(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		      u8 irq_index, u32 mask)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_set_irq_mask *cmd_params;
 
 	/* prepare command */
@@ -229,7 +229,7 @@ int dpsw_set_irq_mask(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_get_irq_status(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u8 irq_index, u32 *status)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_get_irq_status *cmd_params;
 	struct dpsw_rsp_get_irq_status *rsp_params;
 	int err;
@@ -269,7 +269,7 @@ int dpsw_get_irq_status(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_clear_irq_status(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			  u8 irq_index, u32 status)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_clear_irq_status *cmd_params;
 
 	/* prepare command */
@@ -296,7 +296,7 @@ int dpsw_clear_irq_status(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			struct dpsw_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_rsp_get_attr *rsp_params;
 	int err;
 
@@ -343,7 +343,7 @@ int dpsw_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id,
 			 struct dpsw_link_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_set_link_cfg *cmd_params;
 
 	/* prepare command */
@@ -372,7 +372,7 @@ int dpsw_if_set_link_cfg(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16
 int dpsw_if_get_link_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   u16 if_id, struct dpsw_link_state *state)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_get_link_state *cmd_params;
 	struct dpsw_rsp_if_get_link_state *rsp_params;
 	int err;
@@ -411,7 +411,7 @@ int dpsw_if_get_link_state(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_if_set_tci(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id,
 		    const struct dpsw_tci_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_set_tci *cmd_params;
 	u16 tmp_conf = 0;
 
@@ -443,7 +443,7 @@ int dpsw_if_set_tci(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id
 int dpsw_if_get_tci(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id,
 		    struct dpsw_tci_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_get_tci *cmd_params;
 	struct dpsw_rsp_if_get_tci *rsp_params;
 	int err;
@@ -485,7 +485,7 @@ int dpsw_if_get_tci(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id
 int dpsw_if_set_stp(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id,
 		    const struct dpsw_stp_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_set_stp *cmd_params;
 
 	/* prepare command */
@@ -515,7 +515,7 @@ int dpsw_if_set_stp(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id
 int dpsw_if_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u16 if_id, enum dpsw_counter type, u64 *counter)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_get_counter *cmd_params;
 	struct dpsw_rsp_if_get_counter *rsp_params;
 	int err;
@@ -551,7 +551,7 @@ int dpsw_if_get_counter(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
  */
 int dpsw_if_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if *cmd_params;
 
 	/* prepare command */
@@ -576,7 +576,7 @@ int dpsw_if_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id)
  */
 int dpsw_if_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 if_id)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if *cmd_params;
 
 	/* prepare command */
@@ -604,7 +604,7 @@ int dpsw_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   u16 if_id, struct dpsw_if_attr *attr)
 {
 	struct dpsw_rsp_if_get_attr *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if *cmd_params;
 	int err;
 
@@ -644,7 +644,7 @@ int dpsw_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_if_set_max_frame_length(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 				 u16 if_id, u16 frame_length)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if_set_max_frame_length *cmd_params;
 
 	/* prepare command */
@@ -679,7 +679,7 @@ int dpsw_if_set_max_frame_length(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 tok
 int dpsw_vlan_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		  u16 vlan_id, const struct dpsw_vlan_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_vlan_add *cmd_params;
 
 	/* prepare command */
@@ -713,7 +713,7 @@ int dpsw_vlan_add_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		     u16 vlan_id, const struct dpsw_vlan_if_cfg *cfg)
 {
 	struct dpsw_cmd_vlan_add_if *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_VLAN_ADD_IF,
@@ -749,7 +749,7 @@ int dpsw_vlan_add_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_vlan_add_if_untagged(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 vlan_id, const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -780,7 +780,7 @@ int dpsw_vlan_add_if_untagged(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_vlan_remove_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			u16 vlan_id, const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -813,7 +813,7 @@ int dpsw_vlan_remove_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_vlan_remove_if_untagged(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 				 u16 vlan_id, const struct dpsw_vlan_if_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_vlan_manage_if *cmd_params;
 
 	/* prepare command */
@@ -840,7 +840,7 @@ int dpsw_vlan_remove_if_untagged(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 tok
 int dpsw_vlan_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		     u16 vlan_id)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_vlan_remove *cmd_params;
 
 	/* prepare command */
@@ -870,7 +870,7 @@ int dpsw_fdb_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 *fdb_id,
 {
 	struct dpsw_cmd_fdb_add *cmd_params;
 	struct dpsw_rsp_fdb_add *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_ADD,
@@ -902,7 +902,7 @@ int dpsw_fdb_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 *fdb_id,
 int dpsw_fdb_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 fdb_id)
 {
 	struct dpsw_cmd_fdb_remove *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_FDB_REMOVE,
@@ -927,7 +927,7 @@ int dpsw_fdb_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 fdb_i
 int dpsw_fdb_add_unicast(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			 u16 fdb_id, const struct dpsw_fdb_unicast_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_fdb_unicast_op *cmd_params;
 	int i;
 
@@ -969,7 +969,7 @@ int dpsw_fdb_dump(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 fdb_id,
 {
 	struct dpsw_cmd_fdb_dump *cmd_params;
 	struct dpsw_rsp_fdb_dump *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -1005,7 +1005,7 @@ int dpsw_fdb_dump(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 fdb_id,
 int dpsw_fdb_remove_unicast(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			    u16 fdb_id, const struct dpsw_fdb_unicast_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_fdb_unicast_op *cmd_params;
 	int i;
 
@@ -1044,7 +1044,7 @@ int dpsw_fdb_remove_unicast(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_fdb_add_multicast(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   u16 fdb_id, const struct dpsw_fdb_multicast_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_fdb_multicast_op *cmd_params;
 	int i;
 
@@ -1083,7 +1083,7 @@ int dpsw_fdb_add_multicast(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_fdb_remove_multicast(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 fdb_id, const struct dpsw_fdb_multicast_cfg *cfg)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_fdb_multicast_op *cmd_params;
 	int i;
 
@@ -1116,7 +1116,7 @@ int dpsw_ctrl_if_get_attributes(struct fsl_mc_io *mc_io, u32 cmd_flags,
 				u16 token, struct dpsw_ctrl_if_attr *attr)
 {
 	struct dpsw_rsp_ctrl_if_get_attr *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_GET_ATTR,
@@ -1147,7 +1147,7 @@ int dpsw_ctrl_if_set_pools(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   const struct dpsw_ctrl_if_pools_cfg *cfg)
 {
 	struct dpsw_cmd_ctrl_if_set_pools *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int i;
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_SET_POOLS,
@@ -1180,7 +1180,7 @@ int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   const struct dpsw_ctrl_if_queue_cfg *cfg)
 {
 	struct dpsw_cmd_ctrl_if_set_queue *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_SET_QUEUE,
 					  cmd_flags,
@@ -1210,7 +1210,7 @@ int dpsw_ctrl_if_set_queue(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 int dpsw_get_api_version(struct fsl_mc_io *mc_io, u32 cmd_flags,
 			 u16 *major_ver, u16 *minor_ver)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_rsp_get_api_version *rsp_params;
 	int err;
 
@@ -1243,7 +1243,7 @@ int dpsw_if_get_port_mac_addr(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 if_id, u8 mac_addr[6])
 {
 	struct dpsw_rsp_if_get_mac_addr *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpsw_cmd_if *cmd_params;
 	int err, i;
 
@@ -1277,7 +1277,7 @@ int dpsw_if_get_port_mac_addr(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
  */
 int dpsw_ctrl_if_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_ENABLE, cmd_flags,
 					  token);
@@ -1295,7 +1295,7 @@ int dpsw_ctrl_if_enable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
  */
 int dpsw_ctrl_if_disable(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_CTRL_IF_DISABLE,
 					  cmd_flags,
@@ -1317,7 +1317,7 @@ int dpsw_set_egress_flood(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			  const struct dpsw_egress_flood_cfg *cfg)
 {
 	struct dpsw_cmd_set_egress_flood *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_EGRESS_FLOOD, cmd_flags, token);
 	cmd_params = (struct dpsw_cmd_set_egress_flood *)cmd.params;
@@ -1343,7 +1343,7 @@ int dpsw_if_set_learning_mode(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 if_id, enum dpsw_learning_mode mode)
 {
 	struct dpsw_cmd_if_set_learning_mode *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_SET_LEARNING_MODE,
 					  cmd_flags,
@@ -1373,7 +1373,7 @@ int dpsw_acl_add(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token, u16 *acl_id,
 {
 	struct dpsw_cmd_acl_add *cmd_params;
 	struct dpsw_rsp_acl_add *rsp_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_ADD, cmd_flags, token);
@@ -1403,7 +1403,7 @@ int dpsw_acl_remove(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		    u16 acl_id)
 {
 	struct dpsw_cmd_acl_remove *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_REMOVE, cmd_flags,
 					  token);
@@ -1427,7 +1427,7 @@ int dpsw_acl_add_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		    u16 acl_id, const struct dpsw_acl_if_cfg *cfg)
 {
 	struct dpsw_cmd_acl_if *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_ADD_IF, cmd_flags,
 					  token);
@@ -1453,7 +1453,7 @@ int dpsw_acl_remove_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       u16 acl_id, const struct dpsw_acl_if_cfg *cfg)
 {
 	struct dpsw_cmd_acl_if *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_REMOVE_IF, cmd_flags,
@@ -1529,7 +1529,7 @@ int dpsw_acl_add_entry(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 		       u16 acl_id, const struct dpsw_acl_entry_cfg *cfg)
 {
 	struct dpsw_cmd_acl_entry *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_ADD_ENTRY, cmd_flags,
 					  token);
@@ -1561,7 +1561,7 @@ int dpsw_acl_remove_entry(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			  u16 acl_id, const struct dpsw_acl_entry_cfg *cfg)
 {
 	struct dpsw_cmd_acl_entry *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_ACL_REMOVE_ENTRY,
@@ -1595,7 +1595,7 @@ int dpsw_set_reflection_if(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   u16 if_id)
 {
 	struct dpsw_cmd_set_reflection_if *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_SET_REFLECTION_IF,
 					  cmd_flags,
@@ -1620,7 +1620,7 @@ int dpsw_if_add_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			   u16 if_id, const struct dpsw_reflection_cfg *cfg)
 {
 	struct dpsw_cmd_if_reflection *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_ADD_REFLECTION,
 					  cmd_flags,
@@ -1647,7 +1647,7 @@ int dpsw_if_remove_reflection(struct fsl_mc_io *mc_io, u32 cmd_flags, u16 token,
 			      u16 if_id, const struct dpsw_reflection_cfg *cfg)
 {
 	struct dpsw_cmd_if_reflection *cmd_params;
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	cmd.header = mc_encode_cmd_header(DPSW_CMDID_IF_REMOVE_REFLECTION,
 					  cmd_flags,
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 3ca93adb9662..0ebb251dd821 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1075,7 +1075,7 @@ static int enetc_xdp_frame_to_xdp_tx_swbd(struct enetc_bdr *tx_ring,
 int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 		   struct xdp_frame **frames, u32 flags)
 {
-	struct enetc_tx_swbd xdp_redirect_arr[ENETC_MAX_SKB_FRAGS] = {0};
+	struct enetc_tx_swbd xdp_redirect_arr[ENETC_MAX_SKB_FRAGS] = {};
 	struct enetc_ndev_priv *priv = netdev_priv(ndev);
 	struct enetc_bdr *tx_ring;
 	int xdp_tx_bd_cnt, i, k;
@@ -1242,7 +1242,7 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 				   struct bpf_prog *prog)
 {
 	int xdp_tx_bd_cnt, xdp_tx_frm_cnt = 0, xdp_redirect_frm_cnt = 0;
-	struct enetc_tx_swbd xdp_tx_arr[ENETC_MAX_SKB_FRAGS] = {0};
+	struct enetc_tx_swbd xdp_tx_arr[ENETC_MAX_SKB_FRAGS] = {};
 	struct enetc_ndev_priv *priv = netdev_priv(rx_ring->ndev);
 	int rx_frm_cnt = 0, rx_byte_cnt = 0;
 	struct enetc_bdr *tx_ring;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 60d94e0a07d6..64d1e884cef2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -1133,7 +1133,7 @@ static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
  */
 static int enetc_init_port_rfs_memory(struct enetc_si *si)
 {
-	struct enetc_cmd_rfse rfse = {0};
+	struct enetc_cmd_rfse rfse = {};
 	struct enetc_hw *hw = &si->hw;
 	int num_rfs, i, err = 0;
 	u32 val;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
index 6e11ee339f12..3c3a29cb432e 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
@@ -104,7 +104,7 @@ static bool check_image_integrity(struct hinic_devlink_priv *priv,
 static int check_image_device_type(struct hinic_devlink_priv *priv,
 				   u32 image_device_type)
 {
-	struct hinic_comm_board_info board_info = {0};
+	struct hinic_comm_board_info board_info = {};
 
 	if (hinic_get_board_info(priv->hwdev, &board_info)) {
 		dev_err(&priv->hwdev->hwif->pdev->dev, "Get board info failed\n");
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
index b431c300ef1b..4e312de13837 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
@@ -258,9 +258,9 @@ static int hinic_get_link_ksettings(struct net_device *netdev,
 				    *link_ksettings)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic_link_mode_cmd link_mode = { 0 };
-	struct hinic_pause_config pause_info = { 0 };
-	struct cmd_link_settings settings = { 0 };
+	struct hinic_link_mode_cmd link_mode = { };
+	struct hinic_pause_config pause_info = { };
+	struct cmd_link_settings settings = { };
 	enum hinic_port_link_state link_state;
 	struct hinic_port_cap port_cap;
 	int err;
@@ -367,7 +367,7 @@ static bool hinic_is_support_speed(enum hinic_link_mode supported_link,
 
 static bool hinic_is_speed_legal(struct hinic_dev *nic_dev, u32 speed)
 {
-	struct hinic_link_mode_cmd link_mode = { 0 };
+	struct hinic_link_mode_cmd link_mode = { };
 	struct net_device *netdev = nic_dev->netdev;
 	enum nic_speed_level speed_level = 0;
 	int err;
@@ -394,7 +394,7 @@ static bool hinic_is_speed_legal(struct hinic_dev *nic_dev, u32 speed)
 static int get_link_settings_type(struct hinic_dev *nic_dev,
 				  u8 autoneg, u32 speed, u32 *set_settings)
 {
-	struct hinic_port_cap port_cap = { 0 };
+	struct hinic_port_cap port_cap = { };
 	int err;
 
 	err = hinic_port_get_cap(nic_dev, &port_cap);
@@ -460,7 +460,7 @@ static int set_link_settings_separate_cmd(struct hinic_dev *nic_dev,
 static int hinic_set_settings_to_hw(struct hinic_dev *nic_dev,
 				    u32 set_settings, u8 autoneg, u32 speed)
 {
-	struct hinic_link_ksettings_info settings = {0};
+	struct hinic_link_ksettings_info settings = {};
 	char set_link_str[SET_LINK_STR_MAX_LEN] = {0};
 	const char *autoneg_str;
 	struct net_device *netdev = nic_dev->netdev;
@@ -678,7 +678,7 @@ static int set_queue_coalesce(struct hinic_dev *nic_dev, u16 q_id,
 			      bool set_rx_coal)
 {
 	struct hinic_intr_coal_info *intr_coal = NULL;
-	struct hinic_msix_config interrupt_info = {0};
+	struct hinic_msix_config interrupt_info = {};
 	struct net_device *netdev = nic_dev->netdev;
 	u16 msix_idx;
 	int err;
@@ -745,8 +745,8 @@ static int __hinic_set_coalesce(struct net_device *netdev,
 				struct ethtool_coalesce *coal, u16 queue)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic_intr_coal_info rx_intr_coal = {0};
-	struct hinic_intr_coal_info tx_intr_coal = {0};
+	struct hinic_intr_coal_info rx_intr_coal = {};
+	struct hinic_intr_coal_info tx_intr_coal = {};
 	bool set_rx_coal = false;
 	bool set_tx_coal = false;
 	int err;
@@ -826,7 +826,7 @@ static void hinic_get_pauseparam(struct net_device *netdev,
 				 struct ethtool_pauseparam *pause)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic_pause_config pause_info = {0};
+	struct hinic_pause_config pause_info = {};
 	struct hinic_nic_cfg *nic_cfg;
 	int err;
 
@@ -849,8 +849,8 @@ static int hinic_set_pauseparam(struct net_device *netdev,
 				struct ethtool_pauseparam *pause)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic_pause_config pause_info = {0};
-	struct hinic_port_cap port_cap = {0};
+	struct hinic_pause_config pause_info = {};
+	struct hinic_port_cap port_cap = {};
 	int err;
 
 	err = hinic_port_get_cap(nic_dev, &port_cap);
@@ -921,7 +921,7 @@ static int hinic_set_channels(struct net_device *netdev,
 static int hinic_get_rss_hash_opts(struct hinic_dev *nic_dev,
 				   struct ethtool_rxnfc *cmd)
 {
-	struct hinic_rss_type rss_type = { 0 };
+	struct hinic_rss_type rss_type = { };
 	int err;
 
 	cmd->data = 0;
@@ -1402,7 +1402,7 @@ static void hinic_get_ethtool_stats(struct net_device *netdev,
 				    struct ethtool_stats *stats, u64 *data)
 {
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic_vport_stats vport_stats = {0};
+	struct hinic_vport_stats vport_stats = {};
 	struct hinic_phy_port_stats *port_stats;
 	u16 i = 0, j = 0;
 	char *p;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
index 307a6d4af993..03da507efe72 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
@@ -853,7 +853,7 @@ static int init_cmdqs_ctxt(struct hinic_hwdev *hwdev,
 
 static int hinic_set_cmdq_depth(struct hinic_hwdev *hwdev, u16 cmdq_depth)
 {
-	struct hinic_cmd_hw_ioctxt hw_ioctxt = { 0 };
+	struct hinic_cmd_hw_ioctxt hw_ioctxt = { };
 	struct hinic_pfhwdev *pfhwdev;
 
 	pfhwdev = container_of(hwdev, struct hinic_pfhwdev, hwdev);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
index 56b6b04e209b..e434abcea492 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_dev.c
@@ -823,7 +823,7 @@ static void free_pfhwdev(struct hinic_pfhwdev *pfhwdev)
 
 static int hinic_l2nic_reset(struct hinic_hwdev *hwdev)
 {
-	struct hinic_cmd_l2nic_reset l2nic_reset = {0};
+	struct hinic_cmd_l2nic_reset l2nic_reset = {};
 	u16 out_size = sizeof(l2nic_reset);
 	struct hinic_pfhwdev *pfhwdev;
 	int err;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
index d3fc05a07fdb..1521adee3166 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
@@ -538,7 +538,7 @@ static void set_ctrl1(struct hinic_eq *eq)
 
 static int set_ceq_ctrl_reg(struct hinic_eq *eq)
 {
-	struct hinic_ceq_ctrl_reg ceq_ctrl = {0};
+	struct hinic_ceq_ctrl_reg ceq_ctrl = {};
 	struct hinic_hwdev *hwdev = eq->hwdev;
 	u16 out_size = sizeof(ceq_ctrl);
 	u16 in_size = sizeof(ceq_ctrl);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_io.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_io.c
index a6e43d686293..d99a645b8bf9 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_io.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_io.c
@@ -492,7 +492,7 @@ void hinic_io_destroy_qps(struct hinic_func_to_io *func_to_io, int num_qps)
 int hinic_set_wq_page_size(struct hinic_hwdev *hwdev, u16 func_idx,
 			   u32 page_size)
 {
-	struct hinic_wq_page_size page_size_info = {0};
+	struct hinic_wq_page_size page_size_info = {};
 	u16 out_size = sizeof(page_size_info);
 	struct hinic_pfhwdev *pfhwdev;
 	int err;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
index 5078c0c73863..93d4e7e55189 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
@@ -519,7 +519,7 @@ static void recv_mbox_handler(struct hinic_mbox_func_to_func *func_to_func,
 static int set_vf_mbox_random_id(struct hinic_hwdev *hwdev, u16 func_id)
 {
 	struct hinic_mbox_func_to_func *func_to_func = hwdev->func_to_func;
-	struct hinic_set_random_id rand_info = {0};
+	struct hinic_set_random_id rand_info = {};
 	u16 out_size = sizeof(rand_info);
 	struct hinic_pfhwdev *pfhwdev;
 	int ret;
@@ -909,7 +909,7 @@ response_for_recv_func_mbox(struct hinic_mbox_func_to_func *func_to_func,
 			    struct hinic_recv_mbox *recv_mbox, int err,
 			    u16 out_size, u16 src_func_idx)
 {
-	struct mbox_msg_info msg_info = {0};
+	struct mbox_msg_info msg_info = {};
 
 	if (recv_mbox->ack_type == MBOX_ACK) {
 		msg_info.msg_id = recv_mbox->msg_info.msg_id;
@@ -1007,7 +1007,7 @@ int hinic_mbox_to_func(struct hinic_mbox_func_to_func *func_to_func,
 		       u16 *out_size, u32 timeout)
 {
 	struct hinic_recv_mbox *mbox_for_resp;
-	struct mbox_msg_info msg_info = {0};
+	struct mbox_msg_info msg_info = {};
 	unsigned long timeo;
 	int err;
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index ae707e305684..9ad46b2bacd1 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -961,8 +961,8 @@ static void netdev_features_init(struct net_device *netdev)
 static void hinic_refresh_nic_cfg(struct hinic_dev *nic_dev)
 {
 	struct hinic_nic_cfg *nic_cfg = &nic_dev->hwdev->func_to_io.nic_cfg;
-	struct hinic_pause_config pause_info = {0};
-	struct hinic_port_cap port_cap = {0};
+	struct hinic_pause_config pause_info = {};
+	struct hinic_port_cap port_cap = {};
 
 	if (hinic_port_get_cap(nic_dev, &port_cap))
 		return;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 28ae6f1201a8..3371101c75e9 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -380,7 +380,7 @@ int hinic_port_set_tso(struct hinic_dev *nic_dev, enum hinic_tso_state state)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
-	struct hinic_tso_config tso_cfg = {0};
+	struct hinic_tso_config tso_cfg = {};
 	struct pci_dev *pdev = hwif->pdev;
 	u16 out_size = sizeof(tso_cfg);
 	int err;
@@ -403,7 +403,7 @@ int hinic_port_set_tso(struct hinic_dev *nic_dev, enum hinic_tso_state state)
 
 int hinic_set_rx_csum_offload(struct hinic_dev *nic_dev, u32 en)
 {
-	struct hinic_checksum_offload rx_csum_cfg = {0};
+	struct hinic_checksum_offload rx_csum_cfg = {};
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	u16 out_size = sizeof(rx_csum_cfg);
 	struct hinic_hwif *hwif;
@@ -466,7 +466,7 @@ int hinic_set_max_qnum(struct hinic_dev *nic_dev, u8 num_rqs)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
-	struct hinic_rq_num rq_num = { 0 };
+	struct hinic_rq_num rq_num = { };
 	struct pci_dev *pdev = hwif->pdev;
 	u16 out_size = sizeof(rq_num);
 	int err;
@@ -492,7 +492,7 @@ static int hinic_set_rx_lro(struct hinic_dev *nic_dev, u8 ipv4_en, u8 ipv6_en,
 			    u8 max_wqe_num)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_lro_config lro_cfg = { 0 };
+	struct hinic_lro_config lro_cfg = { };
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	u16 out_size = sizeof(lro_cfg);
@@ -519,7 +519,7 @@ static int hinic_set_rx_lro(struct hinic_dev *nic_dev, u8 ipv4_en, u8 ipv6_en,
 static int hinic_set_rx_lro_timer(struct hinic_dev *nic_dev, u32 timer_value)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_lro_timer lro_timer = { 0 };
+	struct hinic_lro_timer lro_timer = { };
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	u16 out_size = sizeof(lro_timer);
@@ -653,7 +653,7 @@ int hinic_rss_set_indir_tbl(struct hinic_dev *nic_dev, u32 tmpl_idx,
 int hinic_rss_get_indir_tbl(struct hinic_dev *nic_dev, u32 tmpl_idx,
 			    u32 *indir_table)
 {
-	struct hinic_rss_indir_table rss_cfg = { 0 };
+	struct hinic_rss_indir_table rss_cfg = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct pci_dev *pdev = hwif->pdev;
@@ -743,7 +743,7 @@ int hinic_set_rss_type(struct hinic_dev *nic_dev, u32 tmpl_idx,
 int hinic_get_rss_type(struct hinic_dev *nic_dev, u32 tmpl_idx,
 		       struct hinic_rss_type *rss_type)
 {
-	struct hinic_rss_context_table ctx_tbl = { 0 };
+	struct hinic_rss_context_table ctx_tbl = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	u16 out_size = sizeof(ctx_tbl);
 	struct hinic_hwif *hwif;
@@ -786,7 +786,7 @@ int hinic_rss_set_template_tbl(struct hinic_dev *nic_dev, u32 template_id,
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
-	struct hinic_rss_key rss_key = { 0 };
+	struct hinic_rss_key rss_key = { };
 	struct pci_dev *pdev = hwif->pdev;
 	u16 out_size = sizeof(rss_key);
 	int err;
@@ -811,7 +811,7 @@ int hinic_rss_set_template_tbl(struct hinic_dev *nic_dev, u32 template_id,
 int hinic_rss_get_template_tbl(struct hinic_dev *nic_dev, u32 tmpl_idx,
 			       u8 *temp)
 {
-	struct hinic_rss_template_key temp_key = { 0 };
+	struct hinic_rss_template_key temp_key = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	u16 out_size = sizeof(temp_key);
 	struct hinic_hwif *hwif;
@@ -844,7 +844,7 @@ int hinic_rss_get_template_tbl(struct hinic_dev *nic_dev, u32 tmpl_idx,
 int hinic_rss_set_hash_engine(struct hinic_dev *nic_dev, u8 template_id,
 			      u8 type)
 {
-	struct hinic_rss_engine_type rss_engine = { 0 };
+	struct hinic_rss_engine_type rss_engine = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct pci_dev *pdev = hwif->pdev;
@@ -870,7 +870,7 @@ int hinic_rss_set_hash_engine(struct hinic_dev *nic_dev, u8 template_id,
 
 int hinic_rss_get_hash_engine(struct hinic_dev *nic_dev, u8 tmpl_idx, u8 *type)
 {
-	struct hinic_rss_engine_type hash_type = { 0 };
+	struct hinic_rss_engine_type hash_type = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	u16 out_size = sizeof(hash_type);
 	struct hinic_hwif *hwif;
@@ -902,7 +902,7 @@ int hinic_rss_get_hash_engine(struct hinic_dev *nic_dev, u8 tmpl_idx, u8 *type)
 int hinic_rss_cfg(struct hinic_dev *nic_dev, u8 rss_en, u8 template_id)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_rss_config rss_cfg = { 0 };
+	struct hinic_rss_config rss_cfg = { };
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct pci_dev *pdev = hwif->pdev;
 	u16 out_size = sizeof(rss_cfg);
@@ -928,7 +928,7 @@ int hinic_rss_cfg(struct hinic_dev *nic_dev, u8 rss_en, u8 template_id)
 
 int hinic_rss_template_alloc(struct hinic_dev *nic_dev, u8 *tmpl_idx)
 {
-	struct hinic_rss_template_mgmt template_mgmt = { 0 };
+	struct hinic_rss_template_mgmt template_mgmt = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
 	u16 out_size = sizeof(template_mgmt);
@@ -954,7 +954,7 @@ int hinic_rss_template_alloc(struct hinic_dev *nic_dev, u8 *tmpl_idx)
 
 int hinic_rss_template_free(struct hinic_dev *nic_dev, u8 tmpl_idx)
 {
-	struct hinic_rss_template_mgmt template_mgmt = { 0 };
+	struct hinic_rss_template_mgmt template_mgmt = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
 	u16 out_size = sizeof(template_mgmt);
@@ -980,8 +980,8 @@ int hinic_rss_template_free(struct hinic_dev *nic_dev, u8 tmpl_idx)
 int hinic_get_vport_stats(struct hinic_dev *nic_dev,
 			  struct hinic_vport_stats *stats)
 {
-	struct hinic_cmd_vport_stats vport_stats = { 0 };
-	struct hinic_port_stats_info stats_info = { 0 };
+	struct hinic_cmd_vport_stats vport_stats = { };
+	struct hinic_port_stats_info stats_info = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
 	u16 out_size = sizeof(vport_stats);
@@ -1009,7 +1009,7 @@ int hinic_get_vport_stats(struct hinic_dev *nic_dev,
 int hinic_get_phy_port_stats(struct hinic_dev *nic_dev,
 			     struct hinic_phy_port_stats *stats)
 {
-	struct hinic_port_stats_info stats_info = { 0 };
+	struct hinic_port_stats_info stats_info = { };
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
 	struct hinic_port_stats *port_stats;
@@ -1046,7 +1046,7 @@ int hinic_get_phy_port_stats(struct hinic_dev *nic_dev,
 int hinic_get_mgmt_version(struct hinic_dev *nic_dev, u8 *mgmt_ver)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_version_info up_ver = {0};
+	struct hinic_version_info up_ver = {};
 	u16 out_size = sizeof(up_ver);
 	struct hinic_hwif *hwif;
 	struct pci_dev *pdev;
@@ -1100,7 +1100,7 @@ int hinic_get_link_mode(struct hinic_hwdev *hwdev,
 
 int hinic_set_autoneg(struct hinic_hwdev *hwdev, bool enable)
 {
-	struct hinic_set_autoneg_cmd autoneg = {0};
+	struct hinic_set_autoneg_cmd autoneg = {};
 	u16 out_size = sizeof(autoneg);
 	int err;
 
@@ -1125,7 +1125,7 @@ int hinic_set_autoneg(struct hinic_hwdev *hwdev, bool enable)
 
 int hinic_set_speed(struct hinic_hwdev *hwdev, enum nic_speed_level speed)
 {
-	struct hinic_speed_cmd speed_info = {0};
+	struct hinic_speed_cmd speed_info = {};
 	u16 out_size = sizeof(speed_info);
 	int err;
 
@@ -1210,7 +1210,7 @@ int hinic_set_hw_pause_info(struct hinic_hwdev *hwdev,
 int hinic_dcb_set_pfc(struct hinic_hwdev *hwdev, u8 pfc_en, u8 pfc_bitmap)
 {
 	struct hinic_nic_cfg *nic_cfg = &hwdev->func_to_io.nic_cfg;
-	struct hinic_set_pfc pfc = {0};
+	struct hinic_set_pfc pfc = {};
 	u16 out_size = sizeof(pfc);
 	int err;
 
@@ -1244,7 +1244,7 @@ int hinic_dcb_set_pfc(struct hinic_hwdev *hwdev, u8 pfc_en, u8 pfc_bitmap)
 
 int hinic_set_loopback_mode(struct hinic_hwdev *hwdev, u32 mode, u32 enable)
 {
-	struct hinic_port_loopback lb = {0};
+	struct hinic_port_loopback lb = {};
 	u16 out_size = sizeof(lb);
 	int err;
 
@@ -1273,7 +1273,7 @@ static int _set_led_status(struct hinic_hwdev *hwdev, u8 port,
 			   enum hinic_led_type type,
 			   enum hinic_led_mode mode, u8 reset)
 {
-	struct hinic_led_info led_info = {0};
+	struct hinic_led_info led_info = {};
 	u16 out_size = sizeof(led_info);
 	struct hinic_pfhwdev *pfhwdev;
 	int err;
@@ -1326,7 +1326,7 @@ int hinic_reset_led_status(struct hinic_hwdev *hwdev, u8 port)
 
 static bool hinic_if_sfp_absent(struct hinic_hwdev *hwdev)
 {
-	struct hinic_cmd_get_light_module_abs sfp_abs = {0};
+	struct hinic_cmd_get_light_module_abs sfp_abs = {};
 	u16 out_size = sizeof(sfp_abs);
 	u8 port_id = hwdev->port_id;
 	int err;
@@ -1347,7 +1347,7 @@ static bool hinic_if_sfp_absent(struct hinic_hwdev *hwdev)
 
 int hinic_get_sfp_eeprom(struct hinic_hwdev *hwdev, u8 *data, u16 *len)
 {
-	struct hinic_cmd_get_std_sfp_info sfp_info = {0};
+	struct hinic_cmd_get_std_sfp_info sfp_info = {};
 	u16 out_size = sizeof(sfp_info);
 	u8 port_id;
 	int err;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index fed3b6bc0d76..380dca71e4b8 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -514,7 +514,7 @@ static irqreturn_t rx_irq(int irq, void *data)
 static int rx_request_irq(struct hinic_rxq *rxq)
 {
 	struct hinic_dev *nic_dev = netdev_priv(rxq->netdev);
-	struct hinic_msix_config interrupt_info = {0};
+	struct hinic_msix_config interrupt_info = {};
 	struct hinic_intr_coal_info *intr_coal = NULL;
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_rq *rq = rxq->rq;
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
index a78c398bf5b2..24ccabdc420b 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_sriov.c
@@ -27,7 +27,7 @@ MODULE_PARM_DESC(set_vf_link_state, "Set vf link state, 0 represents link auto,
 static int hinic_set_mac(struct hinic_hwdev *hwdev, const u8 *mac_addr,
 			 u16 vlan_id, u16 func_id)
 {
-	struct hinic_port_mac_cmd mac_info = {0};
+	struct hinic_port_mac_cmd mac_info = {};
 	u16 out_size = sizeof(mac_info);
 	int err;
 
@@ -51,7 +51,7 @@ static void hinic_notify_vf_link_status(struct hinic_hwdev *hwdev, u16 vf_id,
 					u8 link_status)
 {
 	struct vf_data_storage *vf_infos = hwdev->func_to_io.vf_infos;
-	struct hinic_port_link_status link = {0};
+	struct hinic_port_link_status link = {};
 	u16 out_size = sizeof(link);
 	int err;
 
@@ -100,7 +100,7 @@ static u16 hinic_vf_info_vlanprio(struct hinic_hwdev *hwdev, int vf_id)
 static int hinic_set_vf_vlan(struct hinic_hwdev *hwdev, bool add, u16 vid,
 			     u8 qos, int vf_id)
 {
-	struct hinic_vf_vlan_config vf_vlan = {0};
+	struct hinic_vf_vlan_config vf_vlan = {};
 	u16 out_size = sizeof(vf_vlan);
 	int err;
 	u8 cmd;
@@ -133,7 +133,7 @@ static int hinic_set_vf_tx_rate_max_min(struct hinic_hwdev *hwdev, u16 vf_id,
 					u32 max_rate, u32 min_rate)
 {
 	struct hinic_func_to_io *nic_io = &hwdev->func_to_io;
-	struct hinic_tx_rate_cfg_max_min rate_cfg = {0};
+	struct hinic_tx_rate_cfg_max_min rate_cfg = {};
 	u16 out_size = sizeof(rate_cfg);
 	int err;
 
@@ -163,7 +163,7 @@ static int hinic_set_vf_rate_limit(struct hinic_hwdev *hwdev, u16 vf_id,
 				   u32 tx_rate)
 {
 	struct hinic_func_to_io *nic_io = &hwdev->func_to_io;
-	struct hinic_tx_rate_cfg rate_cfg = {0};
+	struct hinic_tx_rate_cfg rate_cfg = {};
 	u16 out_size = sizeof(rate_cfg);
 	int err;
 
@@ -515,7 +515,7 @@ static int hinic_check_mac_info(u8 status, u16 vlan_id)
 static int hinic_update_mac(struct hinic_hwdev *hwdev, u8 *old_mac,
 			    u8 *new_mac, u16 vlan_id, u16 func_id)
 {
-	struct hinic_port_mac_update mac_info = {0};
+	struct hinic_port_mac_update mac_info = {};
 	u16 out_size = sizeof(mac_info);
 	int err;
 
@@ -841,7 +841,7 @@ int hinic_ndo_set_vf_bw(struct net_device *netdev,
 		SPEED_25000, SPEED_40000, SPEED_100000
 	};
 	struct hinic_dev *nic_dev = netdev_priv(netdev);
-	struct hinic_port_cap port_cap = { 0 };
+	struct hinic_port_cap port_cap = { };
 	enum hinic_port_link_state link_state;
 	int err;
 
@@ -902,7 +902,7 @@ int hinic_ndo_set_vf_bw(struct net_device *netdev,
 static int hinic_set_vf_spoofchk(struct hinic_hwdev *hwdev, u16 vf_id,
 				 bool spoofchk)
 {
-	struct hinic_spoofchk_set spoofchk_cfg = {0};
+	struct hinic_spoofchk_set spoofchk_cfg = {};
 	struct vf_data_storage *vf_infos = NULL;
 	u16 out_size = sizeof(spoofchk_cfg);
 	int err;
@@ -1156,7 +1156,7 @@ static int hinic_deinit_vf_hw(struct hinic_sriov_info *sriov_info,
 
 int hinic_vf_func_init(struct hinic_hwdev *hwdev)
 {
-	struct hinic_register_vf register_info = {0};
+	struct hinic_register_vf register_info = {};
 	u16 out_size = sizeof(register_info);
 	struct hinic_func_to_io *nic_io;
 	int err = 0;
@@ -1224,7 +1224,7 @@ int hinic_vf_func_init(struct hinic_hwdev *hwdev)
 
 void hinic_vf_func_free(struct hinic_hwdev *hwdev)
 {
-	struct hinic_register_vf unregister = {0};
+	struct hinic_register_vf unregister = {};
 	u16 out_size = sizeof(unregister);
 	int err;
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index c5bdb0d374ef..7498dbc7095c 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -797,7 +797,7 @@ static irqreturn_t tx_irq(int irq, void *data)
 static int tx_request_irq(struct hinic_txq *txq)
 {
 	struct hinic_dev *nic_dev = netdev_priv(txq->netdev);
-	struct hinic_msix_config interrupt_info = {0};
+	struct hinic_msix_config interrupt_info = {};
 	struct hinic_intr_coal_info *intr_coal = NULL;
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
 	struct hinic_hwif *hwif = hwdev->hwif;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
index 8c50a128df29..8176577e767e 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
@@ -327,7 +327,7 @@ int fm10k_iov_resume(struct pci_dev *pdev)
 {
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct fm10k_iov_data *iov_data = interface->iov_data;
-	struct fm10k_dglort_cfg dglort = { 0 };
+	struct fm10k_dglort_cfg dglort = { };
 	struct fm10k_hw *hw = &interface->hw;
 	int num_vfs, i;
 
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
index 2fb52bd6fc0e..0f3840603af4 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_netdev.c
@@ -1347,7 +1347,7 @@ static void *fm10k_dfwd_add_station(struct net_device *dev,
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_l2_accel *l2_accel = interface->l2_accel;
 	struct fm10k_l2_accel *old_l2_accel = NULL;
-	struct fm10k_dglort_cfg dglort = { 0 };
+	struct fm10k_dglort_cfg dglort = { };
 	struct fm10k_hw *hw = &interface->hw;
 	int size, i;
 	u16 vid, glort;
@@ -1445,7 +1445,7 @@ static void fm10k_dfwd_del_station(struct net_device *dev, void *priv)
 {
 	struct fm10k_intfc *interface = netdev_priv(dev);
 	struct fm10k_l2_accel *l2_accel = READ_ONCE(interface->l2_accel);
-	struct fm10k_dglort_cfg dglort = { 0 };
+	struct fm10k_dglort_cfg dglort = { };
 	struct fm10k_hw *hw = &interface->hw;
 	struct net_device *sdev = priv;
 	u16 vid, glort;
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index adfa2768f024..7d080418edae 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1090,7 +1090,7 @@ void fm10k_update_rx_drop_en(struct fm10k_intfc *interface)
  **/
 static void fm10k_configure_dglort(struct fm10k_intfc *interface)
 {
-	struct fm10k_dglort_cfg dglort = { 0 };
+	struct fm10k_dglort_cfg dglort = { };
 	struct fm10k_hw *hw = &interface->hw;
 	int i;
 	u32 mrqc;
@@ -1303,7 +1303,7 @@ static void fm10k_handle_fault(struct fm10k_intfc *interface, int type,
 static void fm10k_report_fault(struct fm10k_intfc *interface, u32 eicr)
 {
 	struct fm10k_hw *hw = &interface->hw;
-	struct fm10k_fault fault = { 0 };
+	struct fm10k_fault fault = { };
 	int type, err;
 
 	for (eicr &= FM10K_EICR_FAULT_MASK, type = FM10K_PCA_FAULT;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 513ba6974355..4dd8fa3852a7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -3243,7 +3243,7 @@ static int i40e_get_ethtool_fdir_entry(struct i40e_pf *pf,
 {
 	struct ethtool_rx_flow_spec *fsp =
 			(struct ethtool_rx_flow_spec *)&cmd->fs;
-	struct i40e_rx_flow_userdef userdef = {0};
+	struct i40e_rx_flow_userdef userdef = {};
 	struct i40e_fdir_filter *rule = NULL;
 	struct hlist_node *node2;
 	u64 input_set;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 2f20980dd9a5..420160d6845c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5252,8 +5252,8 @@ static u8 i40e_pf_get_tc_map(struct i40e_pf *pf)
  **/
 static int i40e_vsi_get_bw_info(struct i40e_vsi *vsi)
 {
-	struct i40e_aqc_query_vsi_ets_sla_config_resp bw_ets_config = {0};
-	struct i40e_aqc_query_vsi_bw_config_resp bw_config = {0};
+	struct i40e_aqc_query_vsi_ets_sla_config_resp bw_ets_config = {};
+	struct i40e_aqc_query_vsi_bw_config_resp bw_config = {};
 	struct i40e_pf *pf = vsi->back;
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status ret;
@@ -5460,7 +5460,7 @@ static int i40e_vsi_config_tc(struct i40e_vsi *vsi, u8 enabled_tc)
 
 	ret = i40e_vsi_configure_bw_alloc(vsi, enabled_tc, bw_share);
 	if (ret) {
-		struct i40e_aqc_query_vsi_bw_config_resp bw_config = {0};
+		struct i40e_aqc_query_vsi_bw_config_resp bw_config = {};
 
 		dev_info(&pf->pdev->dev,
 			 "Failed configuring TC map %d for VSI %d\n",
@@ -6382,7 +6382,7 @@ static int i40e_configure_queue_channels(struct i40e_vsi *vsi)
  **/
 int i40e_veb_config_tc(struct i40e_veb *veb, u8 enabled_tc)
 {
-	struct i40e_aqc_configure_switching_comp_bw_config_data bw_data = {0};
+	struct i40e_aqc_configure_switching_comp_bw_config_data bw_data = {};
 	struct i40e_pf *pf = veb->pf;
 	int ret = 0;
 	int i;
@@ -7104,7 +7104,7 @@ static void i40e_vsi_reinit_locked(struct i40e_vsi *vsi)
 static i40e_status i40e_force_link_state(struct i40e_pf *pf, bool is_up)
 {
 	struct i40e_aq_get_phy_abilities_resp abilities;
-	struct i40e_aq_set_phy_config config = {0};
+	struct i40e_aq_set_phy_config config = {};
 	bool non_zero_phy_type = is_up;
 	struct i40e_hw *hw = &pf->hw;
 	i40e_status err;
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index c36057efc7ae..3104a817cee6 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -715,7 +715,7 @@ ice_vsi_cfg_txq(struct ice_vsi *vsi, struct ice_ring *ring,
 		struct ice_aqc_add_tx_qgrp *qg_buf)
 {
 	u8 buf_len = struct_size(qg_buf, txqs, 1);
-	struct ice_tlan_ctx tlan_ctx = { 0 };
+	struct ice_tlan_ctx tlan_ctx = { };
 	struct ice_aqc_add_txqs_perq *txq;
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 2fb81e359cdf..e8e133108fa7 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -397,7 +397,7 @@ enum ice_status
 ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 		     struct ice_link_status *link, struct ice_sq_cd *cd)
 {
-	struct ice_aqc_get_link_status_data link_data = { 0 };
+	struct ice_aqc_get_link_status_data link_data = { };
 	struct ice_aqc_get_link_status *resp;
 	struct ice_link_status *li_old, *li;
 	enum ice_media_type *hw_media_type;
@@ -1330,8 +1330,8 @@ ice_sbq_send_cmd(struct ice_hw *hw, struct ice_sbq_cmd_desc *desc,
  */
 int ice_sbq_rw_reg(struct ice_hw *hw, struct ice_sbq_msg_input *in)
 {
-	struct ice_sbq_cmd_desc desc = {0};
-	struct ice_sbq_msg_req msg = {0};
+	struct ice_sbq_cmd_desc desc = {};
+	struct ice_sbq_msg_req msg = {};
 	u16 msg_len;
 	int status;
 
@@ -3069,7 +3069,7 @@ ice_cfg_phy_fc(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 enum ice_status
 ice_set_fc(struct ice_port_info *pi, u8 *aq_failures, bool ena_auto_link_update)
 {
-	struct ice_aqc_set_phy_cfg_data cfg = { 0 };
+	struct ice_aqc_set_phy_cfg_data cfg = { };
 	struct ice_aqc_get_phy_caps_data *pcaps;
 	enum ice_status status;
 	struct ice_hw *hw;
@@ -4139,7 +4139,7 @@ ice_ena_vsi_txq(struct ice_port_info *pi, u16 vsi_handle, u8 tc, u16 q_handle,
 		u8 num_qgrps, struct ice_aqc_add_tx_qgrp *buf, u16 buf_size,
 		struct ice_sq_cd *cd)
 {
-	struct ice_aqc_txsched_elem_data node = { 0 };
+	struct ice_aqc_txsched_elem_data node = { };
 	struct ice_sched_node *parent;
 	struct ice_q_ctx *q_ctx;
 	enum ice_status status;
@@ -4397,7 +4397,7 @@ int
 ice_ena_vsi_rdma_qset(struct ice_port_info *pi, u16 vsi_handle, u8 tc,
 		      u16 *rdma_qset, u16 num_qsets, u32 *qset_teid)
 {
-	struct ice_aqc_txsched_elem_data node = { 0 };
+	struct ice_aqc_txsched_elem_data node = { };
 	struct ice_aqc_add_rdma_qset_data *buf;
 	struct ice_sched_node *parent;
 	enum ice_status status;
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 926cf748c5ec..19fd6fe52158 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -271,7 +271,7 @@ int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg)
  */
 int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 {
-	struct ice_aqc_port_ets_elem buf = { 0 };
+	struct ice_aqc_port_ets_elem buf = { };
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
 	int ret = ICE_DCB_NO_HW_CHG;
@@ -445,7 +445,7 @@ ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
  */
 void ice_dcb_rebuild(struct ice_pf *pf)
 {
-	struct ice_aqc_port_ets_elem buf = { 0 };
+	struct ice_aqc_port_ets_elem buf = { };
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_dcbx_cfg *err_cfg;
 	enum ice_status ret;
@@ -546,7 +546,7 @@ static int ice_dcb_init_cfg(struct ice_pf *pf, bool locked)
  */
 static int ice_dcb_sw_dflt_cfg(struct ice_pf *pf, bool ets_willing, bool locked)
 {
-	struct ice_aqc_port_ets_elem buf = { 0 };
+	struct ice_aqc_port_ets_elem buf = { };
 	struct ice_dcbx_cfg *dcbcfg;
 	struct ice_port_info *pi;
 	struct ice_hw *hw;
@@ -845,7 +845,7 @@ void
 ice_dcb_process_lldp_set_mib_change(struct ice_pf *pf,
 				    struct ice_rq_event_info *event)
 {
-	struct ice_aqc_port_ets_elem buf = { 0 };
+	struct ice_aqc_port_ets_elem buf = { };
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_aqc_lldp_get_mib *mib;
 	struct ice_dcbx_cfg tmp_dcbx_cfg;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index c451cf401e63..b7010c5dfaa8 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -948,7 +948,7 @@ ice_set_phys_id(struct net_device *netdev, enum ethtool_phys_id_state state)
 static int ice_set_fec_cfg(struct net_device *netdev, enum ice_fec_mode req_fec)
 {
 	struct ice_netdev_priv *np = netdev_priv(netdev);
-	struct ice_aqc_set_phy_cfg_data config = { 0 };
+	struct ice_aqc_set_phy_cfg_data config = { };
 	struct ice_vsi *vsi = np->vsi;
 	struct ice_port_info *pi;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 59ef68f072c0..0b771901a58b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -667,7 +667,7 @@ void
 ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_fdir_fltr *input,
 		       struct ice_fltr_desc *fdesc, bool add)
 {
-	struct ice_fd_fltr_desc_ctx fdir_fltr_ctx = { 0 };
+	struct ice_fd_fltr_desc_ctx fdir_fltr_ctx = { };
 
 	/* set default context info */
 	ice_set_dflt_val_fd_desc(&fdir_fltr_ctx);
diff --git a/drivers/net/ethernet/intel/ice/ice_fltr.c b/drivers/net/ethernet/intel/ice/ice_fltr.c
index 2418d4fff037..66a92ff85f37 100644
--- a/drivers/net/ethernet/intel/ice/ice_fltr.c
+++ b/drivers/net/ethernet/intel/ice/ice_fltr.c
@@ -132,7 +132,7 @@ int
 ice_fltr_add_mac_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 const u8 *mac, enum ice_sw_fwd_act_type action)
 {
-	struct ice_fltr_info info = { 0 };
+	struct ice_fltr_info info = { };
 
 	info.flag = ICE_FLTR_TX;
 	info.src_id = ICE_SRC_ID_VSI;
@@ -157,7 +157,7 @@ static int
 ice_fltr_add_vlan_to_list(struct ice_vsi *vsi, struct list_head *list,
 			  u16 vlan_id, enum ice_sw_fwd_act_type action)
 {
-	struct ice_fltr_info info = { 0 };
+	struct ice_fltr_info info = { };
 
 	info.flag = ICE_FLTR_TX;
 	info.src_id = ICE_SRC_ID_VSI;
@@ -183,7 +183,7 @@ ice_fltr_add_eth_to_list(struct ice_vsi *vsi, struct list_head *list,
 			 u16 ethertype, u16 flag,
 			 enum ice_sw_fwd_act_type action)
 {
-	struct ice_fltr_info info = { 0 };
+	struct ice_fltr_info info = { };
 
 	info.flag = flag;
 	info.lkup_type = ICE_SW_LKUP_ETHERTYPE;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index 05cc5870e4ef..40e4d6982fdc 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -734,7 +734,7 @@ ice_ptp_gpio_enable_e810(struct ptp_clock_info *info,
 			 struct ptp_clock_request *rq, int on)
 {
 	struct ice_pf *pf = ptp_info_to_pf(info);
-	struct ice_perout_channel clk_cfg = {0};
+	struct ice_perout_channel clk_cfg = {};
 	unsigned int chan;
 	u32 gpio_pin;
 	int err;
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3eca0e4eab0b..1de8de341c68 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -67,7 +67,7 @@ u8 ice_get_ptp_src_clock_index(struct ice_hw *hw)
  */
 static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {};
 	int status;
 
 	msg.msg_addr_low = lower_16_bits(addr);
@@ -97,7 +97,7 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
  */
 static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 {
-	struct ice_sbq_msg_input msg = {0};
+	struct ice_sbq_msg_input msg = {};
 	int status;
 
 	msg.msg_addr_low = lower_16_bits(addr);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 6ee8e0032d52..9b40ddf2bcbf 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -2183,7 +2183,7 @@ ice_tstamp(struct ice_ring *tx_ring, struct sk_buff *skb,
 static netdev_tx_t
 ice_xmit_frame_ring(struct sk_buff *skb, struct ice_ring *tx_ring)
 {
-	struct ice_tx_offload_params offload = { 0 };
+	struct ice_tx_offload_params offload = { };
 	struct ice_vsi *vsi = tx_ring->vsi;
 	struct ice_tx_buf *first;
 	struct ethhdr *eth;
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index e93430ab37f1..bfb680e54b0e 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -414,7 +414,7 @@ static bool ice_is_vf_link_up(struct ice_vf *vf)
  */
 static void ice_vc_notify_vf_link_state(struct ice_vf *vf)
 {
-	struct virtchnl_pf_event pfe = { 0 };
+	struct virtchnl_pf_event pfe = { };
 	struct ice_hw *hw = &vf->pf->hw;
 
 	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
@@ -3107,7 +3107,7 @@ static int ice_vc_get_stats_msg(struct ice_vf *vf, u8 *msg)
 	enum virtchnl_status_code v_ret = VIRTCHNL_STATUS_SUCCESS;
 	struct virtchnl_queue_select *vqs =
 		(struct virtchnl_queue_select *)msg;
-	struct ice_eth_stats stats = { 0 };
+	struct ice_eth_stats stats = { };
 	struct ice_vsi *vsi;
 
 	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states)) {
@@ -3330,7 +3330,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
 			struct ice_ring *ring = vsi->tx_rings[vf_q_id];
-			struct ice_txq_meta txq_meta = { 0 };
+			struct ice_txq_meta txq_meta = { };
 
 			if (!ice_vc_isvalid_q_id(vf, vqs->vsi_id, vf_q_id)) {
 				v_ret = VIRTCHNL_STATUS_ERR_PARAM;
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
index 72e6ebffea33..ca97ae8ccbbd 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c
@@ -713,8 +713,8 @@ static u8 ixgbe_dcbnl_getdcbx(struct net_device *dev)
 static u8 ixgbe_dcbnl_setdcbx(struct net_device *dev, u8 mode)
 {
 	struct ixgbe_adapter *adapter = netdev_priv(dev);
-	struct ieee_ets ets = {0};
-	struct ieee_pfc pfc = {0};
+	struct ieee_ets ets = {};
+	struct ieee_pfc pfc = {};
 	int err = 0;
 
 	/* no support for LLD_MANAGED modes or CEE+IEEE */
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 24e06ba6f5e9..3f460a751195 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -8602,7 +8602,7 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
 	u32 tx_flags = 0;
 	unsigned short f;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
-	struct ixgbe_ipsec_tx_data ipsec_tx = { 0 };
+	struct ixgbe_ipsec_tx_data ipsec_tx = { };
 	__be16 protocol = skb->protocol;
 	u8 hdr_len = 0;
 
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index c714e1ecd308..5dbd314ac3a1 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -4109,7 +4109,7 @@ static int ixgbevf_xmit_frame_ring(struct sk_buff *skb,
 	int tso;
 	u32 tx_flags = 0;
 	u16 count = TXD_USE_COUNT(skb_headlen(skb));
-	struct ixgbevf_ipsec_tx_data ipsec_tx = { 0 };
+	struct ixgbevf_ipsec_tx_data ipsec_tx = { };
 #if PAGE_SIZE > IXGBE_MAX_DATA_PER_TXD
 	unsigned short f;
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 9ef4e942e31e..23806919322a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -628,7 +628,7 @@ int rvu_mbox_handler_nix_bp_enable(struct rvu *rvu,
 static void nix_setup_lso_tso_l3(struct rvu *rvu, int blkaddr,
 				 u64 format, bool v4, u64 *fidx)
 {
-	struct nix_lso_format field = {0};
+	struct nix_lso_format field = {};
 
 	/* IP's Length field */
 	field.layer = NIX_TXLAYER_OL3;
@@ -657,7 +657,7 @@ static void nix_setup_lso_tso_l3(struct rvu *rvu, int blkaddr,
 static void nix_setup_lso_tso_l4(struct rvu *rvu, int blkaddr,
 				 u64 format, u64 *fidx)
 {
-	struct nix_lso_format field = {0};
+	struct nix_lso_format field = {};
 
 	/* TCP's sequence number field */
 	field.layer = NIX_TXLAYER_OL4;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 5efb4174e82d..22db5daaa724 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -595,8 +595,8 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 				 int nixlf, u64 chan, u8 *mac_addr)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
-	struct npc_install_flow_req req = { 0 };
-	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_install_flow_req req = { };
+	struct npc_install_flow_rsp rsp = { };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct nix_rx_action action;
 	int blkaddr, index;
@@ -645,8 +645,8 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 				   int nixlf, u64 chan, u8 chan_cnt)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
-	struct npc_install_flow_req req = { 0 };
-	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_install_flow_req req = { };
+	struct npc_install_flow_rsp rsp = { };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int blkaddr, ucast_idx, index;
@@ -748,8 +748,8 @@ void rvu_npc_install_bcast_match_entry(struct rvu *rvu, u16 pcifunc,
 				       int nixlf, u64 chan)
 {
 	struct rvu_pfvf *pfvf;
-	struct npc_install_flow_req req = { 0 };
-	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_install_flow_req req = { };
+	struct npc_install_flow_rsp rsp = { };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int blkaddr, index;
@@ -819,8 +819,8 @@ void rvu_npc_enable_bcast_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 				    u64 chan)
 {
-	struct npc_install_flow_req req = { 0 };
-	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_install_flow_req req = { };
+	struct npc_install_flow_rsp rsp = { };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int blkaddr, ucast_idx, index;
@@ -1327,8 +1327,8 @@ static void npc_config_kpuaction(struct rvu *rvu, int blkaddr,
 				 const struct npc_kpu_profile_action *kpuaction,
 				 int kpu, int entry, bool pkind)
 {
-	struct npc_kpu_action0 action0 = {0};
-	struct npc_kpu_action1 action1 = {0};
+	struct npc_kpu_action0 action0 = {};
+	struct npc_kpu_action1 action1 = {};
 	u64 reg;
 
 	action1.errlev = kpuaction->errlev;
@@ -1369,8 +1369,8 @@ static void npc_config_kpucam(struct rvu *rvu, int blkaddr,
 			      const struct npc_kpu_profile_cam *kpucam,
 			      int kpu, int entry)
 {
-	struct npc_kpu_cam cam0 = {0};
-	struct npc_kpu_cam cam1 = {0};
+	struct npc_kpu_cam cam0 = {};
+	struct npc_kpu_cam cam1 = {};
 
 	cam1.state = kpucam->state & kpucam->state_mask;
 	cam1.dp0_data = kpucam->dp0 & kpucam->dp0_mask;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 51ddc7b81d0b..9df5f4bb7fe0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -893,7 +893,7 @@ static void rvu_mcam_add_rule(struct npc_mcam *mcam,
 static void rvu_mcam_remove_counter_from_rule(struct rvu *rvu, u16 pcifunc,
 					      struct rvu_npc_mcam_rule *rule)
 {
-	struct npc_mcam_oper_counter_req free_req = { 0 };
+	struct npc_mcam_oper_counter_req free_req = { };
 	struct msg_rsp free_rsp;
 
 	if (!rule->has_cntr)
@@ -910,8 +910,8 @@ static void rvu_mcam_add_counter_to_rule(struct rvu *rvu, u16 pcifunc,
 					 struct rvu_npc_mcam_rule *rule,
 					 struct npc_install_flow_rsp *rsp)
 {
-	struct npc_mcam_alloc_counter_req cntr_req = { 0 };
-	struct npc_mcam_alloc_counter_rsp cntr_rsp = { 0 };
+	struct npc_mcam_alloc_counter_req cntr_req = { };
+	struct npc_mcam_alloc_counter_rsp cntr_rsp = { };
 	int err;
 
 	cntr_req.hdr.pcifunc = pcifunc;
@@ -1016,9 +1016,9 @@ static int npc_install_flow(struct rvu *rvu, int blkaddr, u16 target,
 {
 	struct rvu_npc_mcam_rule *def_ucast_rule = pfvf->def_ucast_rule;
 	u64 features, installed_features, missing_features = 0;
-	struct npc_mcam_write_entry_req write_req = { 0 };
+	struct npc_mcam_write_entry_req write_req = { };
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	struct rvu_npc_mcam_rule dummy = { 0 };
+	struct rvu_npc_mcam_rule dummy = { };
 	struct rvu_npc_mcam_rule *rule;
 	u16 owner = req->hdr.pcifunc;
 	struct msg_rsp write_rsp;
@@ -1251,7 +1251,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
 			   u16 pcifunc)
 {
-	struct npc_mcam_ena_dis_entry_req dis_req = { 0 };
+	struct npc_mcam_ena_dis_entry_req dis_req = { };
 	struct msg_rsp dis_rsp;
 
 	if (rule->default_rule)
@@ -1316,7 +1316,7 @@ static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
 				 struct rvu_npc_mcam_rule *rule,
 				 struct rvu_pfvf *pfvf)
 {
-	struct npc_mcam_write_entry_req write_req = { 0 };
+	struct npc_mcam_write_entry_req write_req = { };
 	struct mcam_entry *entry = &write_req.entry_data;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	struct msg_rsp rsp;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index 3392487f6b47..d33611ef9952 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -11,8 +11,8 @@
 static int rvu_switch_install_rx_rule(struct rvu *rvu, u16 pcifunc,
 				      u16 chan_mask)
 {
-	struct npc_install_flow_req req = { 0 };
-	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_install_flow_req req = { };
+	struct npc_install_flow_rsp rsp = { };
 	struct rvu_pfvf *pfvf;
 
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
@@ -39,8 +39,8 @@ static int rvu_switch_install_rx_rule(struct rvu *rvu, u16 pcifunc,
 
 static int rvu_switch_install_tx_rule(struct rvu *rvu, u16 pcifunc, u16 entry)
 {
-	struct npc_install_flow_req req = { 0 };
-	struct npc_install_flow_rsp rsp = { 0 };
+	struct npc_install_flow_req req = { };
+	struct npc_install_flow_rsp rsp = { };
 	struct rvu_pfvf *pfvf;
 	u8 lbkid;
 
@@ -142,10 +142,10 @@ static int rvu_switch_install_rules(struct rvu *rvu)
 
 void rvu_switch_enable(struct rvu *rvu)
 {
-	struct npc_mcam_alloc_entry_req alloc_req = { 0 };
-	struct npc_mcam_alloc_entry_rsp alloc_rsp = { 0 };
-	struct npc_delete_flow_req uninstall_req = { 0 };
-	struct npc_mcam_free_entry_req free_req = { 0 };
+	struct npc_mcam_alloc_entry_req alloc_req = { };
+	struct npc_mcam_alloc_entry_rsp alloc_rsp = { };
+	struct npc_delete_flow_req uninstall_req = { };
+	struct npc_mcam_free_entry_req free_req = { };
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	struct msg_rsp rsp;
 	int ret;
@@ -195,8 +195,8 @@ void rvu_switch_enable(struct rvu *rvu)
 
 void rvu_switch_disable(struct rvu *rvu)
 {
-	struct npc_delete_flow_req uninstall_req = { 0 };
-	struct npc_mcam_free_entry_req free_req = { 0 };
+	struct npc_delete_flow_req uninstall_req = { };
+	struct npc_mcam_free_entry_req free_req = { };
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	struct rvu_hwinfo *hw = rvu->hw;
 	int pf, vf, numvfs;
diff --git a/drivers/net/ethernet/marvell/prestera/prestera_flower.c b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
index e571ba09ec08..96af88233bbc 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_flower.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_flower.c
@@ -49,7 +49,7 @@ static int prestera_flower_parse_meta(struct prestera_acl_rule *rule,
 				      struct prestera_flow_block *block)
 {
 	struct flow_rule *f_rule = flow_cls_offload_flow_rule(f);
-	struct prestera_acl_rule_match_entry m_entry = {0};
+	struct prestera_acl_rule_match_entry m_entry = {};
 	struct net_device *ingress_dev;
 	struct flow_match_meta match;
 	struct prestera_port *port;
diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index 8d751383530b..871e27c194ab 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -2957,7 +2957,7 @@ static bool mlx4_valid_vf_state_change(struct mlx4_dev *dev, int port,
 				       struct mlx4_vport_state *vf_admin,
 				       int vlan, int qos)
 {
-	struct mlx4_vport_state dummy_admin = {0};
+	struct mlx4_vport_state dummy_admin = {};
 
 	if (!mlx4_is_vf_vst_and_prio_qos(dev, port, vf_admin) ||
 	    !vf_admin->tx_rate)
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
index 752a72499b4f..e25c6a412dec 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c
@@ -457,8 +457,8 @@ static u8 mlx4_en_dcbnl_getdcbx(struct net_device *dev)
 static u8 mlx4_en_dcbnl_setdcbx(struct net_device *dev, u8 mode)
 {
 	struct mlx4_en_priv *priv = netdev_priv(dev);
-	struct ieee_ets ets = {0};
-	struct ieee_pfc pfc = {0};
+	struct ieee_ets ets = {};
+	struct ieee_pfc pfc = {};
 
 	if (mode == priv->dcbx_cap)
 		return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx4/fw.c b/drivers/net/ethernet/mellanox/mlx4/fw.c
index dc4ac1a2b6b6..ee2bb9b61833 100644
--- a/drivers/net/ethernet/mellanox/mlx4/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx4/fw.c
@@ -2477,7 +2477,7 @@ static const u8 config_dev_csum_flags[] = {
 int mlx4_config_dev_retrieval(struct mlx4_dev *dev,
 			      struct mlx4_config_dev_params *params)
 {
-	struct mlx4_config_dev config_dev = {0};
+	struct mlx4_config_dev config_dev = {};
 	int err;
 	u8 csum_mask;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 47efd858964d..84a3a16b7796 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -408,7 +408,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			  struct mlx5e_rq_param *rqp,
 			  int node, struct mlx5e_rq *rq)
 {
-	struct page_pool_params pp_params = { 0 };
+	struct page_pool_params pp_params = { };
 	struct mlx5_core_dev *mdev = rq->mdev;
 	void *rqc = rqp->rqc;
 	void *rqc_wq = MLX5_ADDR_OF(rqc, rqc, wq);
@@ -1273,7 +1273,7 @@ int mlx5e_create_sq_rdy(struct mlx5_core_dev *mdev,
 			u16 qos_queue_group_id,
 			u32 *sqn)
 {
-	struct mlx5e_modify_sq_param msp = {0};
+	struct mlx5e_modify_sq_param msp = {};
 	int err;
 
 	err = mlx5e_create_sq(mdev, param, csp, sqn);
@@ -1378,7 +1378,7 @@ void mlx5e_deactivate_txqsq(struct mlx5e_txqsq *sq)
 void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
 {
 	struct mlx5_core_dev *mdev = sq->mdev;
-	struct mlx5_rate_limit rl = {0};
+	struct mlx5_rate_limit rl = {};
 
 	cancel_work_sync(&sq->dim.work);
 	cancel_work_sync(&sq->recover_work);
@@ -1742,8 +1742,8 @@ static int mlx5e_set_sq_maxrate(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
-	struct mlx5e_modify_sq_param msp = {0};
-	struct mlx5_rate_limit rl = {0};
+	struct mlx5e_modify_sq_param msp = {};
+	struct mlx5_rate_limit rl = {};
 	u16 rl_index = 0;
 	int err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index ec136b499204..5dfb5fbee61f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -186,7 +186,7 @@ __esw_fdb_set_vport_rule(struct mlx5_eswitch *esw, u16 vport, bool rx_rule,
 	int match_header = (is_zero_ether_addr(mac_c) ? 0 :
 			    MLX5_MATCH_OUTER_HEADERS);
 	struct mlx5_flow_handle *flow_rule = NULL;
-	struct mlx5_flow_act flow_act = {0};
+	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_spec *spec;
 	void *mv_misc = NULL;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 0d461e38add3..794f58106360 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -928,7 +928,7 @@ mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *on_esw,
 				    struct mlx5_eswitch_rep *rep,
 				    u32 sqn)
 {
-	struct mlx5_flow_act flow_act = {0};
+	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_handle *flow_rule;
 	struct mlx5_flow_spec *spec;
@@ -999,7 +999,7 @@ static int
 mlx5_eswitch_add_send_to_vport_meta_rules(struct mlx5_eswitch *esw)
 {
 	struct mlx5_flow_destination dest = {};
-	struct mlx5_flow_act flow_act = {0};
+	struct mlx5_flow_act flow_act = {};
 	int num_vfs, rule_idx = 0, err = 0;
 	struct mlx5_flow_handle *flow_rule;
 	struct mlx5_flow_handle **flows;
@@ -1171,7 +1171,7 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 				       struct mlx5_core_dev *peer_dev)
 {
 	struct mlx5_flow_destination dest = {};
-	struct mlx5_flow_act flow_act = {0};
+	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle **flows;
 	/* total vports is the same for both e-switches */
 	int nvports = esw->total_vports;
@@ -1291,7 +1291,7 @@ static void esw_del_fdb_peer_miss_rules(struct mlx5_eswitch *esw)
 
 static int esw_add_fdb_miss_rule(struct mlx5_eswitch *esw)
 {
-	struct mlx5_flow_act flow_act = {0};
+	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_handle *flow_rule = NULL;
 	struct mlx5_flow_spec *spec;
@@ -1922,7 +1922,7 @@ struct mlx5_flow_handle *
 mlx5_eswitch_create_vport_rx_rule(struct mlx5_eswitch *esw, u16 vport,
 				  struct mlx5_flow_destination *dest)
 {
-	struct mlx5_flow_act flow_act = {0};
+	struct mlx5_flow_act flow_act = {};
 	struct mlx5_flow_handle *flow_rule;
 	struct mlx5_flow_spec *spec;
 	void *misc;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
index 8ec148010d62..d27627c2480d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -421,7 +421,7 @@ static int mlx5_fpga_ipsec_counters_read(struct mlx5_core_dev *mdev, u64 *counte
 static int mlx5_fpga_ipsec_set_caps(struct mlx5_core_dev *mdev, u32 flags)
 {
 	struct mlx5_fpga_ipsec_cmd_context *context;
-	struct mlx5_ifc_fpga_ipsec_cmd_cap cmd = {0};
+	struct mlx5_ifc_fpga_ipsec_cmd_cap cmd = {};
 	int err;
 
 	cmd.cmd = htonl(MLX5_FPGA_IPSEC_CMD_OP_SET_CAP);
@@ -1265,7 +1265,7 @@ const struct mlx5_flow_cmds *mlx5_fs_cmd_get_default_ipsec_fpga_cmds(enum fs_flo
 
 static int mlx5_fpga_ipsec_init(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_fpga_conn_attr init_attr = {0};
+	struct mlx5_fpga_conn_attr init_attr = {};
 	struct mlx5_fpga_device *fdev = mdev->fpga;
 	struct mlx5_fpga_conn *conn;
 	int err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
index 29b7339ebfa3..c95f91a0de5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/tls.c
@@ -446,7 +446,7 @@ static int mlx5_fpga_tls_get_caps(struct mlx5_fpga_device *fdev,
 int mlx5_fpga_tls_init(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_fpga_device *fdev = mdev->fpga;
-	struct mlx5_fpga_conn_attr init_attr = {0};
+	struct mlx5_fpga_conn_attr init_attr = {};
 	struct mlx5_fpga_conn *conn;
 	struct mlx5_fpga_tls *tls;
 	int err = 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 67571e5040d6..d3b455fd3987 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -110,7 +110,7 @@ void mlx5i_cleanup(struct mlx5e_priv *priv)
 
 static void mlx5i_grp_sw_update_stats(struct mlx5e_priv *priv)
 {
-	struct mlx5e_sw_stats s = { 0 };
+	struct mlx5e_sw_stats s = { };
 	int i, j;
 
 	for (i = 0; i < priv->max_nch; i++) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
index 4047629a876b..aced8990575c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c
@@ -342,7 +342,7 @@ int mlx5_hv_vhca_agent_write(struct mlx5_hv_vhca_agent *agent,
 	int err;
 
 	while (len) {
-		struct mlx5_hv_vhca_data_block data_block = {0};
+		struct mlx5_hv_vhca_data_block data_block = {};
 		int bytes;
 
 		bytes = mlx5_hv_vhca_data_block_prepare(agent, &data_block,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 1ef2b6a848c1..d2d49f240549 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -392,7 +392,7 @@ static int mlx5_query_mcia(struct mlx5_core_dev *dev,
 int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 			     u16 offset, u16 size, u8 *data)
 {
-	struct mlx5_module_eeprom_query_params query = {0};
+	struct mlx5_module_eeprom_query_params query = {};
 	u8 module_id;
 	int err;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
index 78d9c0196f2b..2f4ac59653b9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -600,7 +600,7 @@ static void mlxsw_afa_fwd_entry_destroy(struct mlxsw_afa *mlxsw_afa,
 static struct mlxsw_afa_fwd_entry *
 mlxsw_afa_fwd_entry_get(struct mlxsw_afa *mlxsw_afa, u8 local_port)
 {
-	struct mlxsw_afa_fwd_entry_ht_key ht_key = {0};
+	struct mlxsw_afa_fwd_entry_ht_key ht_key = {};
 	struct mlxsw_afa_fwd_entry *fwd_entry;
 
 	ht_key.local_port = local_port;
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 250c5a24264d..9db0bcbe24ee 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1172,7 +1172,7 @@ static int mlxsw_sp_port_hwtstamp_get(struct mlxsw_sp_port *mlxsw_sp_port,
 
 static inline void mlxsw_sp_port_ptp_clear(struct mlxsw_sp_port *mlxsw_sp_port)
 {
-	struct hwtstamp_config config = {0};
+	struct hwtstamp_config config = {};
 
 	mlxsw_sp_port->mlxsw_sp->ptp_ops->hwtstamp_set(mlxsw_sp_port, &config);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
index 1a2fef2a5379..4d9fd0bb63cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_dpipe.c
@@ -78,7 +78,7 @@ static struct devlink_dpipe_headers mlxsw_sp_dpipe_headers = {
 static int mlxsw_sp_dpipe_table_erif_actions_dump(void *priv,
 						  struct sk_buff *skb)
 {
-	struct devlink_dpipe_action action = {0};
+	struct devlink_dpipe_action action = {};
 	int err;
 
 	action.type = DEVLINK_DPIPE_ACTION_TYPE_FIELD_MODIFY;
@@ -99,7 +99,7 @@ static int mlxsw_sp_dpipe_table_erif_actions_dump(void *priv,
 static int mlxsw_sp_dpipe_table_erif_matches_dump(void *priv,
 						  struct sk_buff *skb)
 {
-	struct devlink_dpipe_match match = {0};
+	struct devlink_dpipe_match match = {};
 
 	match.type = DEVLINK_DPIPE_MATCH_TYPE_FIELD_EXACT;
 	match.header = &mlxsw_sp_dpipe_header_metadata;
@@ -193,9 +193,9 @@ mlxsw_sp_dpipe_table_erif_entries_dump(void *priv, bool counters_enabled,
 				       struct devlink_dpipe_dump_ctx *dump_ctx)
 {
 	struct devlink_dpipe_value match_value, action_value;
-	struct devlink_dpipe_action action = {0};
-	struct devlink_dpipe_match match = {0};
-	struct devlink_dpipe_entry entry = {0};
+	struct devlink_dpipe_action action = {};
+	struct devlink_dpipe_match match = {};
+	struct devlink_dpipe_entry entry = {};
 	struct mlxsw_sp *mlxsw_sp = priv;
 	unsigned int rif_count;
 	int i, j;
@@ -310,7 +310,7 @@ static void mlxsw_sp_dpipe_erif_table_fini(struct mlxsw_sp *mlxsw_sp)
 
 static int mlxsw_sp_dpipe_table_host_matches_dump(struct sk_buff *skb, int type)
 {
-	struct devlink_dpipe_match match = {0};
+	struct devlink_dpipe_match match = {};
 	int err;
 
 	match.type = DEVLINK_DPIPE_MATCH_TYPE_FIELD_EXACT;
@@ -349,7 +349,7 @@ mlxsw_sp_dpipe_table_host4_matches_dump(void *priv, struct sk_buff *skb)
 static int
 mlxsw_sp_dpipe_table_host_actions_dump(void *priv, struct sk_buff *skb)
 {
-	struct devlink_dpipe_action action = {0};
+	struct devlink_dpipe_action action = {};
 
 	action.type = DEVLINK_DPIPE_ACTION_TYPE_FIELD_MODIFY;
 	action.header = &devlink_dpipe_header_ethernet;
@@ -621,8 +621,8 @@ mlxsw_sp_dpipe_table_host_entries_dump(struct mlxsw_sp *mlxsw_sp,
 	struct devlink_dpipe_value match_values[MLXSW_SP_DPIPE_TABLE_HOST_MATCH_COUNT];
 	struct devlink_dpipe_match matches[MLXSW_SP_DPIPE_TABLE_HOST_MATCH_COUNT];
 	struct devlink_dpipe_value action_value;
-	struct devlink_dpipe_action action = {0};
-	struct devlink_dpipe_entry entry = {0};
+	struct devlink_dpipe_action action = {};
+	struct devlink_dpipe_entry entry = {};
 	int err;
 
 	memset(matches, 0, MLXSW_SP_DPIPE_TABLE_HOST_MATCH_COUNT *
@@ -859,7 +859,7 @@ static void mlxsw_sp_dpipe_host6_table_fini(struct mlxsw_sp *mlxsw_sp)
 static int mlxsw_sp_dpipe_table_adj_matches_dump(void *priv,
 						 struct sk_buff *skb)
 {
-	struct devlink_dpipe_match match = {0};
+	struct devlink_dpipe_match match = {};
 	int err;
 
 	match.type = DEVLINK_DPIPE_MATCH_TYPE_FIELD_EXACT;
@@ -888,7 +888,7 @@ static int mlxsw_sp_dpipe_table_adj_matches_dump(void *priv,
 static int mlxsw_sp_dpipe_table_adj_actions_dump(void *priv,
 						 struct sk_buff *skb)
 {
-	struct devlink_dpipe_action action = {0};
+	struct devlink_dpipe_action action = {};
 	int err;
 
 	action.type = DEVLINK_DPIPE_ACTION_TYPE_FIELD_MODIFY;
@@ -1149,7 +1149,7 @@ mlxsw_sp_dpipe_table_adj_entries_dump(void *priv, bool counters_enabled,
 	struct devlink_dpipe_value match_values[MLXSW_SP_DPIPE_TABLE_ADJ_MATCH_COUNT];
 	struct devlink_dpipe_action actions[MLXSW_SP_DPIPE_TABLE_ADJ_ACTION_COUNT];
 	struct devlink_dpipe_match matches[MLXSW_SP_DPIPE_TABLE_ADJ_MATCH_COUNT];
-	struct devlink_dpipe_entry entry = {0};
+	struct devlink_dpipe_entry entry = {};
 	struct mlxsw_sp *mlxsw_sp = priv;
 	int err;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
index 5facabd86882..16172b916def 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_ipip.c
@@ -120,7 +120,7 @@ mlxsw_sp_ipip_netdev_daddr(enum mlxsw_sp_l3proto proto,
 
 bool mlxsw_sp_l3addr_is_zero(union mlxsw_sp_l3addr addr)
 {
-	union mlxsw_sp_l3addr naddr = {0};
+	union mlxsw_sp_l3addr naddr = {};
 
 	return !memcmp(&addr, &naddr, sizeof(naddr));
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
index 9eba8fa684ae..5ab5c812114f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_nve.c
@@ -625,7 +625,7 @@ int mlxsw_sp_nve_flood_ip_add(struct mlxsw_sp *mlxsw_sp,
 			      enum mlxsw_sp_l3proto proto,
 			      union mlxsw_sp_l3addr *addr)
 {
-	struct mlxsw_sp_nve_mc_list_key key = { 0 };
+	struct mlxsw_sp_nve_mc_list_key key = { };
 	struct mlxsw_sp_nve_mc_list *mc_list;
 	int err;
 
@@ -656,7 +656,7 @@ void mlxsw_sp_nve_flood_ip_del(struct mlxsw_sp *mlxsw_sp,
 			       enum mlxsw_sp_l3proto proto,
 			       union mlxsw_sp_l3addr *addr)
 {
-	struct mlxsw_sp_nve_mc_list_key key = { 0 };
+	struct mlxsw_sp_nve_mc_list_key key = { };
 	struct mlxsw_sp_nve_mc_list *mc_list;
 
 	key.fid_index = mlxsw_sp_fid_index(fid);
@@ -693,7 +693,7 @@ static void mlxsw_sp_nve_flood_ip_flush(struct mlxsw_sp *mlxsw_sp,
 					struct mlxsw_sp_fid *fid)
 {
 	struct mlxsw_sp_nve_mc_record *mc_record, *tmp;
-	struct mlxsw_sp_nve_mc_list_key key = { 0 };
+	struct mlxsw_sp_nve_mc_list_key key = { };
 	struct mlxsw_sp_nve_mc_list *mc_list;
 
 	if (!mlxsw_sp_fid_nve_flood_index_is_set(fid))
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c581b955efb3..0cdcd5ad61ba 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -344,14 +344,14 @@ int ocelot_vlan_del(struct ocelot *ocelot, int port, u16 vid)
 
 	/* Ingress */
 	if (ocelot_port->pvid_vlan.vid == vid) {
-		struct ocelot_vlan pvid_vlan = {0};
+		struct ocelot_vlan pvid_vlan = {};
 
 		ocelot_port_set_pvid(ocelot, port, pvid_vlan);
 	}
 
 	/* Egress */
 	if (ocelot_port->native_vlan.vid == vid) {
-		struct ocelot_vlan native_vlan = {0};
+		struct ocelot_vlan native_vlan = {};
 
 		ocelot_port_set_native_vlan(ocelot, port, native_vlan);
 	}
@@ -1650,7 +1650,7 @@ void ocelot_port_bridge_leave(struct ocelot *ocelot, int port,
 			      struct net_device *bridge)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
-	struct ocelot_vlan pvid = {0}, native_vlan = {0};
+	struct ocelot_vlan pvid = {}, native_vlan = {};
 
 	ocelot_port->bridge = NULL;
 
diff --git a/drivers/net/ethernet/mscc/ocelot_net.c b/drivers/net/ethernet/mscc/ocelot_net.c
index c0c465a4a981..48f53fdfd98e 100644
--- a/drivers/net/ethernet/mscc/ocelot_net.c
+++ b/drivers/net/ethernet/mscc/ocelot_net.c
@@ -219,7 +219,7 @@ static int ocelot_setup_tc_cls_matchall(struct ocelot_port_private *priv,
 {
 	struct netlink_ext_ack *extack = f->common.extack;
 	struct ocelot *ocelot = priv->port.ocelot;
-	struct ocelot_policer pol = { 0 };
+	struct ocelot_policer pol = { };
 	struct flow_action_entry *action;
 	int port = priv->chip_port;
 	int err;
@@ -1095,7 +1095,7 @@ static int ocelot_port_obj_del(struct net_device *dev, const void *ctx,
 static void ocelot_inherit_brport_flags(struct ocelot *ocelot, int port,
 					struct net_device *brport_dev)
 {
-	struct switchdev_brport_flags flags = {0};
+	struct switchdev_brport_flags flags = {};
 	int flag;
 
 	flags.mask = BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;
diff --git a/drivers/net/ethernet/mscc/ocelot_police.c b/drivers/net/ethernet/mscc/ocelot_police.c
index 6f5068c1041a..28a0cf4b30fd 100644
--- a/drivers/net/ethernet/mscc/ocelot_police.c
+++ b/drivers/net/ethernet/mscc/ocelot_police.c
@@ -157,7 +157,7 @@ int qos_policer_conf_set(struct ocelot *ocelot, int port, u32 pol_ix,
 int ocelot_port_policer_add(struct ocelot *ocelot, int port,
 			    struct ocelot_policer *pol)
 {
-	struct qos_policer_conf pp = { 0 };
+	struct qos_policer_conf pp = { };
 	int err;
 
 	if (!pol)
@@ -187,7 +187,7 @@ EXPORT_SYMBOL(ocelot_port_policer_add);
 
 int ocelot_port_policer_del(struct ocelot *ocelot, int port)
 {
-	struct qos_policer_conf pp = { 0 };
+	struct qos_policer_conf pp = { };
 	int err;
 
 	dev_dbg(ocelot->dev, "%s: port %u\n", __func__, port);
diff --git a/drivers/net/ethernet/mscc/ocelot_vcap.c b/drivers/net/ethernet/mscc/ocelot_vcap.c
index 7945393a0655..53c18b235da9 100644
--- a/drivers/net/ethernet/mscc/ocelot_vcap.c
+++ b/drivers/net/ethernet/mscc/ocelot_vcap.c
@@ -752,7 +752,7 @@ static void is1_entry_set(struct ocelot *ocelot, int ix,
 					     dport);
 		} else {
 			/* IPv4 "other" frame */
-			struct ocelot_vcap_u16 etype = {0};
+			struct ocelot_vcap_u16 etype = {};
 
 			/* Overloaded field */
 			etype.value[0] = proto.value[0];
@@ -890,7 +890,7 @@ static void vcap_entry_set(struct ocelot *ocelot, int ix,
 static int ocelot_vcap_policer_add(struct ocelot *ocelot, u32 pol_ix,
 				   struct ocelot_policer *pol)
 {
-	struct qos_policer_conf pp = { 0 };
+	struct qos_policer_conf pp = { };
 
 	if (!pol)
 		return -EINVAL;
@@ -907,7 +907,7 @@ static void ocelot_vcap_policer_del(struct ocelot *ocelot,
 				    u32 pol_ix)
 {
 	struct ocelot_vcap_filter *filter;
-	struct qos_policer_conf pp = {0};
+	struct qos_policer_conf pp = {};
 	int index = -1;
 
 	if (pol_ix < block->pol_lpr)
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
index dc93ddea8906..a7e1becc8554 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dcbx.c
@@ -328,7 +328,7 @@ qed_dcbx_process_mib_info(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
 	struct dcbx_app_priority_feature *p_app;
 	struct dcbx_app_priority_entry *p_tbl;
-	struct qed_dcbx_results data = { 0 };
+	struct qed_dcbx_results data = { };
 	struct dcbx_ets_feature *p_ets;
 	struct qed_hw_info *p_info;
 	u32 pri_tc_tbl, flags;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 0410c3604abd..0bcacbcbf0a7 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -848,7 +848,7 @@ qed_llh_access_filter(struct qed_hwfn *p_hwfn,
 		      u8 filter_idx,
 		      struct qed_llh_filter_details *p_details)
 {
-	struct qed_dmae_params params = {0};
+	struct qed_dmae_params params = {};
 	u32 addr;
 	u8 pfid;
 	int rc;
@@ -944,7 +944,7 @@ static int
 qed_llh_remove_filter(struct qed_hwfn *p_hwfn,
 		      struct qed_ptt *p_ptt, u8 abs_ppfid, u8 filter_idx)
 {
-	struct qed_llh_filter_details filter_details = {0};
+	struct qed_llh_filter_details filter_details = {};
 
 	return qed_llh_access_filter(p_hwfn, p_ptt, abs_ppfid, filter_idx,
 				     &filter_details);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index dfaf10edfabf..cb77f1214c58 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2305,7 +2305,7 @@ static int qed_start_vport(struct qed_dev *cdev,
 	int rc, i;
 
 	for_each_hwfn(cdev, i) {
-		struct qed_sp_vport_start_params start = { 0 };
+		struct qed_sp_vport_start_params start = { };
 		struct qed_hwfn *p_hwfn = &cdev->hwfns[i];
 
 		start.tpa_mode = params->gro_enable ? QED_TPA_MODE_GRO :
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 6e5a6cc97d0e..9108983b3921 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -3911,7 +3911,7 @@ int qed_mcp_set_capabilities(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 
 int qed_mcp_get_engine_config(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	struct qed_mcp_mb_params mb_params = {0};
+	struct qed_mcp_mb_params mb_params = {};
 	struct qed_dev *cdev = p_hwfn->cdev;
 	u8 fir_valid, l2_valid;
 	int rc;
@@ -3950,7 +3950,7 @@ int qed_mcp_get_engine_config(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 
 int qed_mcp_get_ppfid_bitmap(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	struct qed_mcp_mb_params mb_params = {0};
+	struct qed_mcp_mb_params mb_params = {};
 	struct qed_dev *cdev = p_hwfn->cdev;
 	int rc;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c b/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
index f19128c8d9cc..168099d20724 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
@@ -270,7 +270,7 @@ static int qed_sp_nvmetcp_conn_offload(struct qed_hwfn *p_hwfn,
 {
 	struct nvmetcp_spe_conn_offload *p_ramrod = NULL;
 	struct tcp_offload_params_opt2 *p_tcp = NULL;
-	struct qed_sp_init_data init_data = { 0 };
+	struct qed_sp_init_data init_data = { };
 	struct qed_spq_entry *p_ent = NULL;
 	dma_addr_t r2tq_pbl_addr;
 	dma_addr_t xhq_pbl_addr;
diff --git a/drivers/net/ethernet/qlogic/qed/qed_sriov.c b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
index ed2b6fe5a78d..bac28d29c338 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -1888,7 +1888,7 @@ static void qed_iov_vf_mbx_start_vport(struct qed_hwfn *p_hwfn,
 				       struct qed_ptt *p_ptt,
 				       struct qed_vf_info *vf)
 {
-	struct qed_sp_vport_start_params params = { 0 };
+	struct qed_sp_vport_start_params params = { };
 	struct qed_iov_vf_mbx *mbx = &vf->vf_mbx;
 	struct vfpf_vport_start_tlv *start;
 	u8 status = PFVF_STATUS_SUCCESS;
diff --git a/drivers/net/ethernet/qlogic/qede/qede_fp.c b/drivers/net/ethernet/qlogic/qede/qede_fp.c
index 065e9004598e..99e8455638ed 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_fp.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_fp.c
@@ -590,7 +590,7 @@ void qede_update_rx_prod(struct qede_dev *edev, struct qede_rx_queue *rxq)
 {
 	u16 bd_prod = qed_chain_get_prod_idx(&rxq->rx_bd_ring);
 	u16 cqe_prod = qed_chain_get_prod_idx(&rxq->rx_comp_ring);
-	struct eth_rx_prod_data rx_prods = {0};
+	struct eth_rx_prod_data rx_prods = {};
 
 	/* Update producers */
 	rx_prods.bd_prod = cpu_to_le16(bd_prod);
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 9837bdb89cd4..92618b2f516e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -2144,7 +2144,7 @@ static int qede_start_queues(struct qede_dev *edev, bool clear_stats)
 	struct qed_dev_info *qed_info = &edev->dev_info.common;
 	struct qed_update_vport_params *vport_update_params;
 	struct qed_queue_start_common_params q_params;
-	struct qed_start_vport_params start = {0};
+	struct qed_start_vport_params start = {};
 	int rc, i;
 
 	if (!edev->num_queues) {
diff --git a/drivers/net/ethernet/sfc/ef100.c b/drivers/net/ethernet/sfc/ef100.c
index ffdb36715a49..65c7d67caf8b 100644
--- a/drivers/net/ethernet/sfc/ef100.c
+++ b/drivers/net/ethernet/sfc/ef100.c
@@ -450,7 +450,7 @@ static void ef100_pci_remove(struct pci_dev *pci_dev)
 static int ef100_pci_probe(struct pci_dev *pci_dev,
 			   const struct pci_device_id *entry)
 {
-	struct ef100_func_ctl_window fcw = { 0 };
+	struct ef100_func_ctl_window fcw = { };
 	struct net_device *net_dev;
 	struct efx_nic *efx;
 	int rc;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ece02b35a6ce..9e8c3740b527 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1957,7 +1957,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->rx_queue[queue];
 	struct stmmac_channel *ch = &priv->channel[queue];
 	bool xdp_prog = stmmac_xdp_is_enabled(priv);
-	struct page_pool_params pp_params = { 0 };
+	struct page_pool_params pp_params = { };
 	unsigned int num_pages;
 	unsigned int napi_id;
 	int ret;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 130346f74ee8..c295642889c0 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1554,7 +1554,7 @@ void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 static int am65_cpsw_nuss_init_tx_chns(struct am65_cpsw_common *common)
 {
 	u32  max_desc_num = ALIGN(AM65_CPSW_MAX_TX_DESC, MAX_SKB_FRAGS);
-	struct k3_udma_glue_tx_channel_cfg tx_cfg = { 0 };
+	struct k3_udma_glue_tx_channel_cfg tx_cfg = { };
 	struct device *dev = common->dev;
 	struct k3_ring_cfg ring_cfg = {
 		.elm_size = K3_RINGACC_RING_ELSIZE_8,
@@ -1644,7 +1644,7 @@ static void am65_cpsw_nuss_free_rx_chns(void *data)
 static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 {
 	struct am65_cpsw_rx_chn *rx_chn = &common->rx_chns;
-	struct k3_udma_glue_rx_channel_cfg rx_cfg = { 0 };
+	struct k3_udma_glue_rx_channel_cfg rx_cfg = { };
 	u32  max_desc_num = AM65_CPSW_MAX_RX_DESC;
 	struct device *dev = common->dev;
 	u32 hdesc_size;
@@ -2633,7 +2633,7 @@ static void am65_cpsw_nuss_apply_socinfo(struct am65_cpsw_common *common)
 
 static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 {
-	struct cpsw_ale_params ale_params = { 0 };
+	struct cpsw_ale_params ale_params = { };
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct am65_cpsw_common *common;
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 93dc48b9b4f2..9cfd74e1fa1d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3022,12 +3022,12 @@ static noinline_for_stack int
 dump_secy(struct macsec_secy *secy, struct net_device *dev,
 	  struct sk_buff *skb, struct netlink_callback *cb)
 {
-	struct macsec_tx_sc_stats tx_sc_stats = {0, };
-	struct macsec_tx_sa_stats tx_sa_stats = {0, };
-	struct macsec_rx_sc_stats rx_sc_stats = {0, };
-	struct macsec_rx_sa_stats rx_sa_stats = {0, };
+	struct macsec_tx_sc_stats tx_sc_stats = {};
+	struct macsec_tx_sa_stats tx_sa_stats = {};
+	struct macsec_rx_sc_stats rx_sc_stats = {};
+	struct macsec_rx_sa_stats rx_sa_stats = {};
 	struct macsec_dev *macsec = netdev_priv(dev);
-	struct macsec_dev_stats dev_stats = {0, };
+	struct macsec_dev_stats dev_stats = {};
 	struct macsec_tx_sc *tx_sc = &secy->tx_sc;
 	struct nlattr *txsa_list, *rxsc_list;
 	struct macsec_rx_sc *rx_sc;
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index 8e3a28ba6b28..a24372e1fc8c 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -626,7 +626,7 @@ static ssize_t tap_get_user(struct tap_queue *q, void *msg_control,
 	unsigned long total_len = iov_iter_count(from);
 	unsigned long len = total_len;
 	int err;
-	struct virtio_net_hdr vnet_hdr = { 0 };
+	struct virtio_net_hdr vnet_hdr = { };
 	int vnet_hdr_len = 0;
 	int copylen = 0;
 	int depth;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fecc9a1d293a..50e86136b790 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1653,7 +1653,7 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
 	struct sk_buff *skb;
 	size_t total_len = iov_iter_count(from);
 	size_t len = total_len, align = tun->align, linear;
-	struct virtio_net_hdr gso = { 0 };
+	struct virtio_net_hdr gso = { };
 	int good_linear;
 	int copylen;
 	bool zerocopy = false;
@@ -1950,7 +1950,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 	size_t ret;
 
 	if (tun->flags & IFF_VNET_HDR) {
-		struct virtio_net_hdr gso = { 0 };
+		struct virtio_net_hdr gso = { };
 
 		vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
 		if (unlikely(iov_iter_count(iter) < vnet_hdr_sz))
diff --git a/drivers/net/wireless/admtek/adm8211.c b/drivers/net/wireless/admtek/adm8211.c
index 2db9c948c0fc..09c403f753d4 100644
--- a/drivers/net/wireless/admtek/adm8211.c
+++ b/drivers/net/wireless/admtek/adm8211.c
@@ -431,7 +431,7 @@ static void adm8211_interrupt_rci(struct ieee80211_hw *dev)
 				     RDES1_CONTROL_RER : 0));
 
 		if (skb) {
-			struct ieee80211_rx_status rx_status = {0};
+			struct ieee80211_rx_status rx_status = {};
 
 			if (priv->pdev->revision < ADM8211_REV_CA)
 				rx_status.signal = rssi;
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index adbaeb67eedf..3721fb69583a 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -1785,7 +1785,7 @@ static bool ath10k_htt_rx_h_frag_pn_check(struct ath10k *ar,
 					  enum htt_rx_mpdu_encrypt_type enctype)
 {
 	struct ath10k_peer *peer;
-	union htt_rx_pn_t *last_pn, new_pn = {0};
+	union htt_rx_pn_t *last_pn, new_pn = {};
 	struct ieee80211_hdr *hdr;
 	u8 tid, frag_number;
 	u32 seq;
@@ -2280,7 +2280,7 @@ static bool ath10k_htt_rx_pn_check_replay_hl(struct ath10k *ar,
 	bool last_pn_valid, pn_invalid = false;
 	enum htt_txrx_sec_cast_type sec_index;
 	enum htt_security_types sec_type;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	union htt_rx_pn_t *last_pn;
 	u32 rx_desc_info, tid;
@@ -2343,7 +2343,7 @@ static bool ath10k_htt_rx_proc_rx_ind_hl(struct ath10k_htt *htt,
 	struct fw_rx_desc_hl *fw_desc;
 	enum htt_txrx_sec_cast_type sec_index;
 	enum htt_security_types sec_type;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	struct ieee80211_hdr *hdr;
 	struct ieee80211_rx_status *rx_status;
@@ -2645,7 +2645,7 @@ static bool ath10k_htt_rx_proc_rx_frag_ind_hl(struct ath10k_htt *htt,
 	struct htt_rx_indication_hl *rx_hl;
 	enum htt_security_types sec_type;
 	u32 tid, frag, seq, rx_desc_info;
-	union htt_rx_pn_t new_pn = {0};
+	union htt_rx_pn_t new_pn = {};
 	struct htt_hl_rx_desc *rx_desc;
 	u16 peer_id, sc, hdr_space;
 	union htt_rx_pn_t *last_pn;
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d6b8bdcef416..449f21033126 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -505,7 +505,7 @@ static int ath10k_htt_tx_clean_up_pending(int msdu_id, void *skb, void *ctx)
 {
 	struct ath10k *ar = ctx;
 	struct ath10k_htt *htt = &ar->htt;
-	struct htt_tx_done tx_done = {0};
+	struct htt_tx_done tx_done = {};
 
 	ath10k_dbg(ar, ATH10K_DBG_HTT, "force cleanup msdu_id %u\n", msdu_id);
 
@@ -555,7 +555,7 @@ void ath10k_htt_op_ep_tx_credits(struct ath10k *ar)
 void ath10k_htt_htc_tx_complete(struct ath10k *ar, struct sk_buff *skb)
 {
 	struct ath10k_htt *htt = &ar->htt;
-	struct htt_tx_done tx_done = {0};
+	struct htt_tx_done tx_done = {};
 	struct htt_cmd_hdr *htt_hdr;
 	struct htt_data_tx_desc *desc_hdr = NULL;
 	u16 flags1 = 0;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c272b290fa73..0169db53f09a 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3354,7 +3354,7 @@ static int ath10k_update_channel_list(struct ath10k *ar)
 	struct ieee80211_supported_band **bands;
 	enum nl80211_band band;
 	struct ieee80211_channel *channel;
-	struct wmi_scan_chan_list_arg arg = {0};
+	struct wmi_scan_chan_list_arg arg = {};
 	struct wmi_channel_arg *ch;
 	bool passive;
 	int len;
@@ -4831,7 +4831,7 @@ static int ath10k_mac_get_vht_cap_bf_sound_dim(struct ath10k *ar)
 
 static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 {
-	struct ieee80211_sta_vht_cap vht_cap = {0};
+	struct ieee80211_sta_vht_cap vht_cap = {};
 	struct ath10k_hw_params *hw = &ar->hw_params;
 	u16 mcs_map;
 	u32 val;
@@ -4889,7 +4889,7 @@ static struct ieee80211_sta_vht_cap ath10k_create_vht_cap(struct ath10k *ar)
 static struct ieee80211_sta_ht_cap ath10k_get_ht_cap(struct ath10k *ar)
 {
 	int i;
-	struct ieee80211_sta_ht_cap ht_cap = {0};
+	struct ieee80211_sta_ht_cap ht_cap = {};
 
 	if (!(ar->ht_cap_info & WMI_HT_CAP_ENABLED))
 		return ht_cap;
@@ -5120,7 +5120,7 @@ static int ath10k_start(struct ieee80211_hw *hw)
 	struct ath10k *ar = hw->priv;
 	u32 param;
 	int ret = 0;
-	struct wmi_bb_timing_cfg_arg bb_timing = {0};
+	struct wmi_bb_timing_cfg_arg bb_timing = {};
 
 	/*
 	 * This makes sense only when restarting hw. It is harmless to call
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index de8b632b058c..d4e3e7bceb52 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -534,7 +534,7 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 			       struct ath11k_ce_ring *ce_ring,
 			       int ce_id, enum hal_ring_type type)
 {
-	struct hal_srng_params params = { 0 };
+	struct hal_srng_params params = { };
 	int ret;
 
 	params.ring_base_paddr = ce_ring->base_addr_ce_space;
diff --git a/drivers/net/wireless/ath/ath11k/dbring.c b/drivers/net/wireless/ath/ath11k/dbring.c
index 5e1f5437b418..162de19b5051 100644
--- a/drivers/net/wireless/ath/ath11k/dbring.c
+++ b/drivers/net/wireless/ath/ath11k/dbring.c
@@ -115,7 +115,7 @@ int ath11k_dbring_wmi_cfg_setup(struct ath11k *ar,
 				struct ath11k_dbring *ring,
 				enum wmi_direct_buffer_module id)
 {
-	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {0};
+	struct ath11k_wmi_pdev_dma_ring_cfg_req_cmd param = {};
 	int ret;
 
 	if (id >= WMI_DIRECT_BUF_MAX)
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 554feaf1ed5c..a53589910724 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -602,7 +602,7 @@ static ssize_t ath11k_write_extd_rx_stats(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 enable, rx_filter = 0, ring_id;
 	int i;
 	int ret;
@@ -899,7 +899,7 @@ static ssize_t ath11k_write_pktlog_filter(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	u32 rx_filter = 0, ring_id, filter, mode;
 	u8 buf[128] = {0};
 	int i, ret;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
index 9e0c90da99d3..a56bb347d3d1 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_htt_stats.c
@@ -4420,7 +4420,7 @@ int ath11k_debugfs_htt_stats_req(struct ath11k *ar)
 	u8 type = stats_req->type;
 	u64 cookie = 0;
 	int ret, pdev_id = ar->pdev->pdev_id;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = { };
 
 	init_completion(&stats_req->cmpln);
 
@@ -4558,7 +4558,7 @@ static ssize_t ath11k_write_htt_stats_reset(struct file *file,
 {
 	struct ath11k *ar = file->private_data;
 	u8 type;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = { };
 	int ret;
 
 	ret = kstrtou8_from_user(user_buf, count, 0, &type);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 270c0edbb10f..1c57f50f216d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -769,7 +769,7 @@ ath11k_write_htt_peer_stats_reset(struct file *file,
 	struct ieee80211_sta *sta = file->private_data;
 	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
 	struct ath11k *ar = arsta->arvif->ar;
-	struct htt_ext_stats_cfg_params cfg_params = { 0 };
+	struct htt_ext_stats_cfg_params cfg_params = { };
 	int ret;
 	u8 type;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index b0c8f6290099..c83df437d989 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -218,7 +218,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
 			 enum hal_ring_type type, int ring_num,
 			 int mac_id, int num_entries)
 {
-	struct hal_srng_params params = { 0 };
+	struct hal_srng_params params = { };
 	int entry_sz = ath11k_hal_srng_get_entrysize(ab, type);
 	int max_entries = ath11k_hal_srng_get_max_entries(ab, type);
 	int ret;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9a224817630a..3797de18c8b5 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -695,7 +695,7 @@ static void ath11k_dp_reo_cmd_free(struct ath11k_dp *dp, void *ctx,
 static void ath11k_dp_reo_cache_flush(struct ath11k_base *ab,
 				      struct dp_rx_tid *rx_tid)
 {
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	unsigned long tot_desc_sz, desc_sz;
 	int ret;
 
@@ -785,7 +785,7 @@ static void ath11k_dp_rx_tid_del_func(struct ath11k_dp *dp, void *ctx,
 void ath11k_peer_rx_tid_delete(struct ath11k *ar,
 			       struct ath11k_peer *peer, u8 tid)
 {
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	struct dp_rx_tid *rx_tid = &peer->rx_tid[tid];
 	int ret;
 
@@ -905,7 +905,7 @@ static int ath11k_peer_rx_tid_reo_update(struct ath11k *ar,
 					 u32 ba_win_sz, u16 ssn,
 					 bool update_ssn)
 {
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	int ret;
 
 	cmd.addr_lo = lower_32_bits(rx_tid->paddr);
@@ -1129,7 +1129,7 @@ int ath11k_dp_peer_rx_pn_replay_config(struct ath11k_vif *arvif,
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_hal_reo_cmd cmd = {0};
+	struct ath11k_hal_reo_cmd cmd = {};
 	struct ath11k_peer *peer;
 	struct dp_rx_tid *rx_tid;
 	u8 tid;
@@ -2438,7 +2438,7 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 	struct ath11k_base *ab = ar->ab;
 	struct hal_rx_desc *rx_desc, *lrx_desc;
 	struct rx_attention *rx_attention;
-	struct ieee80211_rx_status rx_status = {0};
+	struct ieee80211_rx_status rx_status = {};
 	struct ieee80211_rx_status *status;
 	struct ath11k_skb_rxcb *rxcb;
 	struct ieee80211_hdr *hdr;
@@ -3940,7 +3940,7 @@ static void ath11k_dp_rx_wbm_err(struct ath11k *ar,
 				 struct sk_buff_head *msdu_list)
 {
 	struct ath11k_skb_rxcb *rxcb = ATH11K_SKB_RXCB(msdu);
-	struct ieee80211_rx_status rxs = {0};
+	struct ieee80211_rx_status rxs = {};
 	struct ieee80211_rx_status *status;
 	bool drop = true;
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8bba5234f81f..3c58949aa853 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -82,7 +82,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_dp *dp = &ab->dp;
-	struct hal_tx_info ti = {0};
+	struct hal_tx_info ti = {};
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct hal_srng *tcl_ring;
@@ -364,7 +364,7 @@ ath11k_dp_tx_process_htt_tx_complete(struct ath11k_base *ab,
 				     u32 msdu_id, struct dp_tx_ring *tx_ring)
 {
 	struct htt_tx_wbm_completion *status_desc;
-	struct ath11k_dp_htt_wbm_tx_status ts = {0};
+	struct ath11k_dp_htt_wbm_tx_status ts = {};
 	enum hal_wbm_htt_tx_comp_status wbm_status;
 
 	status_desc = desc + HTT_TX_WBM_COMP_STATUS_OFFSET;
@@ -532,7 +532,7 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
 	int hal_ring_id = dp->tx_ring[ring_id].tcl_comp_ring.ring_id;
 	struct hal_srng *status_ring = &ab->hal.srng_list[hal_ring_id];
 	struct sk_buff *msdu;
-	struct hal_tx_status ts = { 0 };
+	struct hal_tx_status ts = { };
 	struct dp_tx_ring *tx_ring = &dp->tx_ring[ring_id];
 	u32 *desc;
 	u32 msdu_id;
@@ -1023,7 +1023,7 @@ int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset)
 {
 	struct ath11k_pdev_dp *dp = &ar->dp;
 	struct ath11k_base *ab = ar->ab;
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	int ret = 0, ring_id = 0, i;
 
 	ring_id = dp->rxdma_mon_buf_ring.refill_buf_ring.ring_id;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e9b3689331ec..427691128a98 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3599,7 +3599,7 @@ static struct ieee80211_sta_ht_cap
 ath11k_create_ht_cap(struct ath11k *ar, u32 ar_ht_cap, u32 rate_cap_rx_chainmask)
 {
 	int i;
-	struct ieee80211_sta_ht_cap ht_cap = {0};
+	struct ieee80211_sta_ht_cap ht_cap = {};
 	u32 ar_vht_cap = ar->pdev->cap.vht_cap;
 
 	if (!(ar_ht_cap & WMI_HT_CAP_ENABLED))
@@ -3756,7 +3756,7 @@ static struct ieee80211_sta_vht_cap
 ath11k_create_vht_cap(struct ath11k *ar, u32 rate_cap_tx_chainmask,
 		      u32 rate_cap_rx_chainmask)
 {
-	struct ieee80211_sta_vht_cap vht_cap = {0};
+	struct ieee80211_sta_vht_cap vht_cap = {};
 	u16 txmcs_map, rxmcs_map;
 	int i;
 
@@ -4356,7 +4356,7 @@ void ath11k_mac_drain_tx(struct ath11k *ar)
 
 static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 {
-	struct htt_rx_ring_tlv_filter tlv_filter = {0};
+	struct htt_rx_ring_tlv_filter tlv_filter = {};
 	struct ath11k_base *ab = ar->ab;
 	int i, ret = 0;
 	u32 ring_id;
@@ -4663,7 +4663,7 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
-	struct vdev_create_params vdev_param = {0};
+	struct vdev_create_params vdev_param = {};
 	struct peer_create_params peer_param;
 	u32 param_id, param_value;
 	u16 nss;
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 1afe67759659..cbc5d619f392 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -203,7 +203,7 @@ static int ath11k_spectral_scan_trigger(struct ath11k *ar)
 static int ath11k_spectral_scan_config(struct ath11k *ar,
 				       enum ath11k_spectral_mode mode)
 {
-	struct ath11k_wmi_vdev_spectral_conf_param param = { 0 };
+	struct ath11k_wmi_vdev_spectral_conf_param param = { };
 	struct ath11k_vif *arvif;
 	int ret, count;
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6c253eae9d06..6bb226395be4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6081,7 +6081,7 @@ static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *sk
 
 static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct mgmt_rx_event_params rx_ev = {0};
+	struct mgmt_rx_event_params rx_ev = {};
 	struct ath11k *ar;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr;
@@ -6192,7 +6192,7 @@ static void ath11k_mgmt_rx_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 static void ath11k_mgmt_tx_compl_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_mgmt_tx_compl_event tx_compl_param = {0};
+	struct wmi_mgmt_tx_compl_event tx_compl_param = {};
 	struct ath11k *ar;
 
 	if (ath11k_pull_mgmt_tx_compl_param_tlv(ab, skb, &tx_compl_param) != 0) {
@@ -6247,7 +6247,7 @@ static struct ath11k *ath11k_get_ar_on_scan_abort(struct ath11k_base *ab,
 static void ath11k_scan_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct ath11k *ar;
-	struct wmi_scan_event scan_ev = {0};
+	struct wmi_scan_event scan_ev = {};
 
 	if (ath11k_pull_scan_ev(ab, skb, &scan_ev) != 0) {
 		ath11k_warn(ab, "failed to extract scan event");
@@ -6407,7 +6407,7 @@ static void ath11k_roam_event(struct ath11k_base *ab, struct sk_buff *skb)
 
 static void ath11k_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_chan_info_event ch_info_ev = {0};
+	struct wmi_chan_info_event ch_info_ev = {};
 	struct ath11k *ar;
 	struct survey_info *survey;
 	int idx;
@@ -6554,7 +6554,7 @@ ath11k_pdev_bss_chan_info_event(struct ath11k_base *ab, struct sk_buff *skb)
 static void ath11k_vdev_install_key_compl_event(struct ath11k_base *ab,
 						struct sk_buff *skb)
 {
-	struct wmi_vdev_install_key_complete_arg install_key_compl = {0};
+	struct wmi_vdev_install_key_complete_arg install_key_compl = {};
 	struct ath11k *ar;
 
 	if (ath11k_pull_vdev_install_key_compl_ev(ab, skb, &install_key_compl) != 0) {
@@ -6633,7 +6633,7 @@ static void ath11k_service_available_event(struct ath11k_base *ab, struct sk_buf
 
 static void ath11k_peer_assoc_conf_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
-	struct wmi_peer_assoc_conf_arg peer_assoc_conf = {0};
+	struct wmi_peer_assoc_conf_arg peer_assoc_conf = {};
 	struct ath11k *ar;
 
 	if (ath11k_pull_peer_assoc_conf_ev(ab, skb, &peer_assoc_conf) != 0) {
diff --git a/drivers/net/wireless/ath/ath9k/dfs_debug.c b/drivers/net/wireless/ath/ath9k/dfs_debug.c
index 2a79c2fa8415..6eff2ee91044 100644
--- a/drivers/net/wireless/ath/ath9k/dfs_debug.c
+++ b/drivers/net/wireless/ath/ath9k/dfs_debug.c
@@ -22,7 +22,7 @@
 #include "dfs_debug.h"
 #include "../dfs_pattern_detector.h"
 
-static struct ath_dfs_pool_stats dfs_pool_stats = { 0 };
+static struct ath_dfs_pool_stats dfs_pool_stats = { };
 
 #define ATH9K_DFS_STAT(s, p) \
 	len += scnprintf(buf + len, size - len, "%28s : %10u\n", s, \
diff --git a/drivers/net/wireless/ath/wil6210/pmc.c b/drivers/net/wireless/ath/wil6210/pmc.c
index a2f7b4c1da48..925e4f1bda5b 100644
--- a/drivers/net/wireless/ath/wil6210/pmc.c
+++ b/drivers/net/wireless/ath/wil6210/pmc.c
@@ -44,7 +44,7 @@ void wil_pmc_alloc(struct wil6210_priv *wil,
 	struct pmc_ctx *pmc = &wil->pmc;
 	struct device *dev = wil_to_dev(wil);
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
-	struct wmi_pmc_cmd pmc_cmd = {0};
+	struct wmi_pmc_cmd pmc_cmd = {};
 	int last_cmd_err = -ENOMEM;
 
 	mutex_lock(&pmc->lock);
@@ -228,7 +228,7 @@ void wil_pmc_free(struct wil6210_priv *wil, int send_pmc_cmd)
 	struct pmc_ctx *pmc = &wil->pmc;
 	struct device *dev = wil_to_dev(wil);
 	struct wil6210_vif *vif = ndev_to_vif(wil->main_ndev);
-	struct wmi_pmc_cmd pmc_cmd = {0};
+	struct wmi_pmc_cmd pmc_cmd = {};
 
 	mutex_lock(&pmc->lock);
 
diff --git a/drivers/net/wireless/atmel/at76c50x-usb.c b/drivers/net/wireless/atmel/at76c50x-usb.c
index 7582761c61e2..bdf9d6755d0b 100644
--- a/drivers/net/wireless/atmel/at76c50x-usb.c
+++ b/drivers/net/wireless/atmel/at76c50x-usb.c
@@ -1549,7 +1549,7 @@ static void at76_rx_tasklet(struct tasklet_struct *t)
 	struct at76_priv *priv = from_tasklet(priv, t, rx_tasklet);
 	struct urb *urb = priv->rx_urb;
 	struct at76_rx_buffer *buf;
-	struct ieee80211_rx_status rx_status = { 0 };
+	struct ieee80211_rx_status rx_status = { };
 
 	if (priv->device_unplugged) {
 		at76_dbg(DBG_DEVSTART, "device unplugged");
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 8effeb7a7269..6be04de0a607 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -2191,7 +2191,7 @@ brcmf_sdio_txpkt_prep(struct brcmf_sdio *bus, struct sk_buff_head *pktq,
 	struct sk_buff *pkt_next;
 	u8 txseq;
 	int ret;
-	struct brcmf_sdio_hdrinfo hd_info = {0};
+	struct brcmf_sdio_hdrinfo hd_info = {};
 
 	txseq = bus->tx_seq;
 	total_len = 0;
@@ -2397,7 +2397,7 @@ static int brcmf_sdio_tx_ctrlframe(struct brcmf_sdio *bus, u8 *frame, u16 len)
 	u8 doff;
 	u16 pad;
 	uint retries = 0;
-	struct brcmf_sdio_hdrinfo hd_info = {0};
+	struct brcmf_sdio_hdrinfo hd_info = {};
 	int ret;
 
 	brcmf_dbg(SDIO, "Enter\n");
diff --git a/drivers/net/wireless/intel/iwlegacy/4965.c b/drivers/net/wireless/intel/iwlegacy/4965.c
index 9fa556486511..ce29955935e0 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965.c
@@ -1240,7 +1240,7 @@ il4965_fill_txpower_tbl(struct il_priv *il, u8 band, u16 channel, u8 is_ht40,
 static int
 il4965_send_tx_power(struct il_priv *il)
 {
-	struct il4965_txpowertable_cmd cmd = { 0 };
+	struct il4965_txpowertable_cmd cmd = { };
 	int ret;
 	u8 band = 0;
 	bool is_ht40 = false;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6dcafd0a3d4b..11fd6b4c6a74 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2655,7 +2655,7 @@ IWL_EXPORT_SYMBOL(iwl_fw_start_dbg_conf);
  */
 static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 {
-	struct iwl_fw_dbg_params params = {0};
+	struct iwl_fw_dbg_params params = {};
 	struct iwl_fwrt_dump_data *dump_data =
 		&fwrt->dump.wks[wk_idx].dump_data;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 5dc39fbb74d6..a4b61ec3a99b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1750,7 +1750,7 @@ iwl_dbgfs_ltr_config_write(struct iwl_mvm *mvm,
 			   char *buf, size_t count, loff_t *ppos)
 {
 	int ret;
-	struct iwl_ltr_config_cmd ltr_config = {0};
+	struct iwl_ltr_config_cmd ltr_config = {};
 
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a64874c05ced..7e561091d35b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -950,7 +950,7 @@ static void iwl_mvm_unshare_queue(struct iwl_mvm *mvm, int queue)
 
 	/* If aggs should be turned back on - do it */
 	if (mvmsta->tid_data[tid].state == IWL_AGG_ON) {
-		struct iwl_mvm_add_sta_cmd cmd = {0};
+		struct iwl_mvm_add_sta_cmd cmd = {};
 
 		mvmsta->tid_disable_agg &= ~BIT(tid);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index bf04326e35ff..bc2daa2f64b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -338,7 +338,7 @@ iwl_mvm_tdls_config_channel_switch(struct iwl_mvm *mvm,
 	struct iwl_mvm_sta *mvmsta;
 	struct ieee80211_tx_info *info;
 	struct ieee80211_hdr *hdr;
-	struct iwl_tdls_channel_switch_cmd cmd = {0};
+	struct iwl_tdls_channel_switch_cmd cmd = {};
 	struct iwl_tdls_channel_switch_cmd_tail *tail =
 		iwl_mvm_chan_info_cmd_tail(mvm, &cmd.ci);
 	u16 len = sizeof(cmd) - iwl_mvm_chan_info_padding(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 398390c59344..f8d8e37ba961 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -554,7 +554,7 @@ static int compare_temps(const void *a, const void *b)
 
 int iwl_mvm_send_temp_report_ths_cmd(struct iwl_mvm *mvm)
 {
-	struct temp_report_ths_cmd cmd = {0};
+	struct temp_report_ths_cmd cmd = {};
 	int ret;
 #ifdef CONFIG_THERMAL
 	int i, j, idx = 0;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index ffa894f7312a..9ead9df2d6c6 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3808,7 +3808,7 @@ static bool hwsim_known_ciphers(const u32 *ciphers, int n_ciphers)
 
 static int hwsim_new_radio_nl(struct sk_buff *msg, struct genl_info *info)
 {
-	struct hwsim_new_radio_params param = { 0 };
+	struct hwsim_new_radio_params param = { };
 	const char *hwname = NULL;
 	int ret;
 
@@ -4497,7 +4497,7 @@ static int __init init_mac80211_hwsim(void)
 	hwsim_init_s1g_channels(hwsim_channels_s1g);
 
 	for (i = 0; i < radios; i++) {
-		struct hwsim_new_radio_params param = { 0 };
+		struct hwsim_new_radio_params param = { };
 
 		param.channels = channels;
 
diff --git a/drivers/net/wireless/quantenna/qtnfmac/event.c b/drivers/net/wireless/quantenna/qtnfmac/event.c
index 8dc80574d08d..e9b47177a66b 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/event.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/event.c
@@ -557,7 +557,7 @@ qtnf_event_handle_external_auth(struct qtnf_vif *vif,
 				const struct qlink_event_external_auth *ev,
 				u16 len)
 {
-	struct cfg80211_external_auth_params auth = {0};
+	struct cfg80211_external_auth_params auth = {};
 	struct wiphy *wiphy = priv_to_wiphy(vif->mac);
 	int ret;
 
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
index 2477e18c7cae..8915909c2667 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c
@@ -254,7 +254,7 @@ static void rtl8180_handle_rx(struct ieee80211_hw *dev)
 				      RTL818X_RX_DESC_FLAG_RX_ERR)))
 			goto done;
 		else {
-			struct ieee80211_rx_status rx_status = {0};
+			struct ieee80211_rx_status rx_status = {};
 			struct sk_buff *new_skb = dev_alloc_skb(MAX_RX_SIZE);
 
 			if (unlikely(!new_skb))
diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index eb68b2d3caa1..d6eaf9986c3c 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -328,7 +328,7 @@ static void rtl8187_rx_cb(struct urb *urb)
 	struct rtl8187_rx_info *info = (struct rtl8187_rx_info *)skb->cb;
 	struct ieee80211_hw *dev = info->dev;
 	struct rtl8187_priv *priv = dev->priv;
-	struct ieee80211_rx_status rx_status = { 0 };
+	struct ieee80211_rx_status rx_status = { };
 	int rate, signal;
 	u32 flags;
 	unsigned long f;
diff --git a/drivers/net/wireless/realtek/rtlwifi/base.c b/drivers/net/wireless/realtek/rtlwifi/base.c
index ffd150ec181f..dfded79611c7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.c
+++ b/drivers/net/wireless/realtek/rtlwifi/base.c
@@ -1343,7 +1343,7 @@ static void process_agg_start(struct ieee80211_hw *hw,
 			      struct ieee80211_hdr *hdr, u16 tid)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	struct ieee80211_rx_status rx_status = { 0 };
+	struct ieee80211_rx_status rx_status = { };
 	struct sk_buff *skb_delba = NULL;
 
 	skb_delba = rtl_make_del_ba(hw, hdr->addr2, hdr->addr3, tid);
diff --git a/drivers/net/wireless/realtek/rtlwifi/pci.c b/drivers/net/wireless/realtek/rtlwifi/pci.c
index 3776495fd9d0..d17dcea5ac34 100644
--- a/drivers/net/wireless/realtek/rtlwifi/pci.c
+++ b/drivers/net/wireless/realtek/rtlwifi/pci.c
@@ -721,7 +721,7 @@ static void _rtl_pci_rx_interrupt(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 	int rxring_idx = RTL_PCI_RX_MPDU_QUEUE;
-	struct ieee80211_rx_status rx_status = { 0 };
+	struct ieee80211_rx_status rx_status = { };
 	unsigned int count = rtlpci->rxringcount;
 	u8 own;
 	u8 tmp_one;
@@ -905,7 +905,7 @@ static irqreturn_t _rtl_pci_interrupt(int irq, void *dev_id)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	unsigned long flags;
-	struct rtl_int intvec = {0};
+	struct rtl_int intvec = {};
 
 	irqreturn_t ret = IRQ_HANDLED;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/usb.c b/drivers/net/wireless/realtek/rtlwifi/usb.c
index 86a236873254..55d3f0350966 100644
--- a/drivers/net/wireless/realtek/rtlwifi/usb.c
+++ b/drivers/net/wireless/realtek/rtlwifi/usb.c
@@ -424,7 +424,7 @@ static void _rtl_usb_rx_process_agg(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr;
 	bool unicast = false;
 	__le16 fc;
-	struct ieee80211_rx_status rx_status = {0};
+	struct ieee80211_rx_status rx_status = {};
 	struct rtl_stats stats = {
 		.signal = 0,
 		.rate = 0,
@@ -466,7 +466,7 @@ static void _rtl_usb_rx_process_noagg(struct ieee80211_hw *hw,
 	struct ieee80211_hdr *hdr;
 	bool unicast = false;
 	__le16 fc;
-	struct ieee80211_rx_status rx_status = {0};
+	struct ieee80211_rx_status rx_status = {};
 	struct rtl_stats stats = {
 		.signal = 0,
 		.rate = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 2551e228b581..5a8f66b641d2 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -629,7 +629,7 @@ static struct sk_buff *rtw_coex_info_request(struct rtw_dev *rtwdev,
 
 static bool rtw_coex_get_bt_scan_type(struct rtw_dev *rtwdev, u8 *scan_type)
 {
-	struct rtw_coex_info_req req = {0};
+	struct rtw_coex_info_req req = {};
 	struct sk_buff *skb;
 	u8 *payload;
 
@@ -647,7 +647,7 @@ static bool rtw_coex_get_bt_scan_type(struct rtw_dev *rtwdev, u8 *scan_type)
 static bool rtw_coex_set_lna_constrain_level(struct rtw_dev *rtwdev,
 					     u8 lna_constrain_level)
 {
-	struct rtw_coex_info_req req = {0};
+	struct rtw_coex_info_req req = {};
 	struct sk_buff *skb;
 
 	req.op_code = BT_MP_INFO_OP_LNA_CONSTRAINT;
@@ -3499,7 +3499,7 @@ static void rtw_coex_set_coexinfo_hw(struct rtw_dev *rtwdev, struct seq_file *m)
 static bool rtw_coex_get_bt_reg(struct rtw_dev *rtwdev,
 				u8 type, u16 addr, u16 *val)
 {
-	struct rtw_coex_info_req req = {0};
+	struct rtw_coex_info_req req = {};
 	struct sk_buff *skb;
 	__le16 le_addr;
 	u8 *payload;
@@ -3525,7 +3525,7 @@ static bool rtw_coex_get_bt_reg(struct rtw_dev *rtwdev,
 static bool rtw_coex_get_bt_patch_version(struct rtw_dev *rtwdev,
 					  u32 *patch_version)
 {
-	struct rtw_coex_info_req req = {0};
+	struct rtw_coex_info_req req = {};
 	struct sk_buff *skb;
 	u8 *payload;
 
@@ -3544,7 +3544,7 @@ static bool rtw_coex_get_bt_patch_version(struct rtw_dev *rtwdev,
 static bool rtw_coex_get_bt_supported_version(struct rtw_dev *rtwdev,
 					      u32 *supported_version)
 {
-	struct rtw_coex_info_req req = {0};
+	struct rtw_coex_info_req req = {};
 	struct sk_buff *skb;
 	u8 *payload;
 
@@ -3563,7 +3563,7 @@ static bool rtw_coex_get_bt_supported_version(struct rtw_dev *rtwdev,
 static bool rtw_coex_get_bt_supported_feature(struct rtw_dev *rtwdev,
 					      u32 *supported_feature)
 {
-	struct rtw_coex_info_req req = {0};
+	struct rtw_coex_info_req req = {};
 	struct sk_buff *skb;
 	u8 *payload;
 
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index dfd52cff5d02..74dec6d6e0b6 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -584,7 +584,7 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 path, rate;
-	struct rtw_power_params pwr_param = {0};
+	struct rtw_power_params pwr_param = {};
 	u8 bw = hal->current_band_width;
 	u8 ch = hal->current_channel;
 	u8 regd = rtwdev->regd.txpwr_regd;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index e6399519584b..a622652a6e35 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1069,7 +1069,7 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
 				    enum rtw_rsvd_packet_type type)
 {
-	struct rtw_tx_pkt_info pkt_info = {0};
+	struct rtw_tx_pkt_info pkt_info = {};
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 *pkt_desc;
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index a7a6ebfaa203..965e97fd87f1 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -896,7 +896,7 @@ static int rtw_pci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 					u32 size)
 {
 	struct sk_buff *skb;
-	struct rtw_tx_pkt_info pkt_info = {0};
+	struct rtw_tx_pkt_info pkt_info = {};
 	u8 reg_bcn_work;
 	int ret;
 
@@ -921,7 +921,7 @@ static int rtw_pci_write_data_rsvd_page(struct rtw_dev *rtwdev, u8 *buf,
 static int rtw_pci_write_data_h2c(struct rtw_dev *rtwdev, u8 *buf, u32 size)
 {
 	struct sk_buff *skb;
-	struct rtw_tx_pkt_info pkt_info = {0};
+	struct rtw_tx_pkt_info pkt_info = {};
 	int ret;
 
 	skb = rtw_tx_write_data_h2c_get(rtwdev, &pkt_info, buf, size);
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 569dd3cfde35..ad27b6baeeb6 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -981,7 +981,7 @@ void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	struct rtw_phy_cond cond = {0};
+	struct rtw_phy_cond cond = {};
 
 	cond.cut = hal->cut_version ? hal->cut_version : 15;
 	cond.pkg = pkg ? pkg : 15;
@@ -1030,7 +1030,7 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 {
 	const union phy_table_tile *p = tbl->data;
 	const union phy_table_tile *end = p + tbl->size / 2;
-	struct rtw_phy_cond pos_cond = {0};
+	struct rtw_phy_cond pos_cond = {};
 	bool is_matched = true, is_skipped = false;
 
 	BUILD_BUG_ON(sizeof(union phy_table_tile) != sizeof(struct phy_cfg_pair));
@@ -1988,7 +1988,7 @@ u8
 rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 			   enum rtw_bandwidth bandwidth, u8 channel, u8 regd)
 {
-	struct rtw_power_params pwr_param = {0};
+	struct rtw_power_params pwr_param = {};
 	u8 tx_power;
 	s8 offset;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index f3ad079967a6..8655cd3834c6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2909,7 +2909,7 @@ static void rtw8822c_do_lck(struct rtw_dev *rtwdev)
 
 static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
 {
-	struct rtw_iqk_para para = {0};
+	struct rtw_iqk_para para = {};
 	u8 iqk_chk;
 	int ret;
 
@@ -3669,7 +3669,7 @@ static u8 (*dpk_state[])(struct rtw_dev *rtwdev,
 static u8 rtw8822c_dpk_pas_agc(struct rtw_dev *rtwdev, u8 path,
 			       bool gain_only, bool loss_only)
 {
-	struct rtw8822c_dpk_data data = {0};
+	struct rtw8822c_dpk_data data = {};
 	u8 (*func)(struct rtw_dev *rtwdev, struct rtw8822c_dpk_data *data);
 	u8 state = RTW_DPK_GAIN_CHECK;
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 3a101aa139ed..8eddd32bd401 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -483,7 +483,7 @@ void rtw_tx(struct rtw_dev *rtwdev,
 	    struct ieee80211_tx_control *control,
 	    struct sk_buff *skb)
 {
-	struct rtw_tx_pkt_info pkt_info = {0};
+	struct rtw_tx_pkt_info pkt_info = {};
 	int ret;
 
 	rtw_tx_pkt_info_update(rtwdev, &pkt_info, control->sta, skb);
@@ -538,7 +538,7 @@ static int rtw_txq_push_skb(struct rtw_dev *rtwdev,
 			    struct sk_buff *skb)
 {
 	struct ieee80211_txq *txq = rtwtxq_to_txq(rtwtxq);
-	struct rtw_tx_pkt_info pkt_info = {0};
+	struct rtw_tx_pkt_info pkt_info = {};
 	int ret;
 
 	rtw_txq_check_agg(rtwdev, rtwtxq, skb);
diff --git a/drivers/net/wireless/st/cw1200/sta.c b/drivers/net/wireless/st/cw1200/sta.c
index 236022d4ae2a..42cab9860989 100644
--- a/drivers/net/wireless/st/cw1200/sta.c
+++ b/drivers/net/wireless/st/cw1200/sta.c
@@ -1809,7 +1809,7 @@ void cw1200_bss_info_changed(struct ieee80211_hw *dev,
 	/* TODO: BSS_CHANGED_TXPOWER */
 
 	if (changed & BSS_CHANGED_ARP_FILTER) {
-		struct wsm_mib_arp_ipv4_filter filter = {0};
+		struct wsm_mib_arp_ipv4_filter filter = {};
 		int i;
 
 		pr_debug("[STA] BSS_CHANGED_ARP_FILTER cnt: %d\n",
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/iosm_ipc_imem.c
index 9f00e36b7f79..5cf062569b40 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -520,7 +520,7 @@ static int ipc_imem_send_mdm_rdy_cb(struct iosm_imem *ipc_imem, int arg,
  */
 static void ipc_imem_run_state_worker(struct work_struct *instance)
 {
-	struct ipc_chnl_cfg chnl_cfg_port = { 0 };
+	struct ipc_chnl_cfg chnl_cfg_port = { };
 	struct ipc_mux_config mux_cfg;
 	struct iosm_imem *ipc_imem;
 	u8 ctrl_chl_idx = 0;
diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
index 0a472ce77370..66e03b829c32 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem_ops.c
@@ -85,7 +85,7 @@ int ipc_imem_sys_wwan_transmit(struct iosm_imem *ipc_imem,
 void ipc_imem_wwan_channel_init(struct iosm_imem *ipc_imem,
 				enum ipc_mux_protocol mux_type)
 {
-	struct ipc_chnl_cfg chnl_cfg = { 0 };
+	struct ipc_chnl_cfg chnl_cfg = { };
 
 	ipc_imem->cp_version = ipc_mmio_get_cp_version(ipc_imem->mmio);
 
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 39a01c2a3058..1f2add2d733b 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -245,7 +245,7 @@ static int xenvif_count_requests(struct xenvif_queue *queue,
 		return 0;
 
 	do {
-		struct xen_netif_tx_request dropped_tx = { 0 };
+		struct xen_netif_tx_request dropped_tx = { };
 
 		if (slots >= work_to_do) {
 			netdev_err(queue->vif->dev,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8679a108f571..bb398e0b8377 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1449,7 +1449,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
 {
-	union nvme_result res = { 0 };
+	union nvme_result res = { };
 	struct nvme_command c = { };
 	int ret;
 
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0cb98f2bbc8c..c1813a114aa7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -269,7 +269,7 @@ static u32 nvmet_format_ana_group(struct nvmet_req *req, u32 grpid,
 
 static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 {
-	struct nvme_ana_rsp_hdr hdr = { 0, };
+	struct nvme_ana_rsp_hdr hdr = { };
 	struct nvme_ana_group_desc *desc;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr); /* start beyond hdr */
 	size_t len;
diff --git a/drivers/nvmem/rave-sp-eeprom.c b/drivers/nvmem/rave-sp-eeprom.c
index 66699d44f73d..5d497fcb1c63 100644
--- a/drivers/nvmem/rave-sp-eeprom.c
+++ b/drivers/nvmem/rave-sp-eeprom.c
@@ -289,7 +289,7 @@ static int rave_sp_eeprom_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rave_sp *sp = dev_get_drvdata(dev->parent);
 	struct device_node *np = dev->of_node;
-	struct nvmem_config config = { 0 };
+	struct nvmem_config config = { };
 	struct rave_sp_eeprom *eeprom;
 	struct nvmem_device *nvmem;
 	u32 reg[2], size;
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0099a00af361..6813a3e4d0e1 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1117,7 +1117,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd)
 {
-	struct irq_affinity msi_default_affd = {0};
+	struct irq_affinity msi_default_affd = {};
 	int nvecs = -ENOSPC;
 
 	if (flags & PCI_IRQ_AFFINITY) {
diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 0b301f8be9ed..f1d7e274d468 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -603,7 +603,7 @@ static __poll_t switchtec_dev_poll(struct file *filp, poll_table *wait)
 static int ioctl_flash_info(struct switchtec_dev *stdev,
 			    struct switchtec_ioctl_flash_info __user *uinfo)
 {
-	struct switchtec_ioctl_flash_info info = {0};
+	struct switchtec_ioctl_flash_info info = {};
 	struct flash_info_regs __iomem *fi = stdev->mmio_flash_info;
 
 	if (stdev->gen == SWITCHTEC_GEN3) {
@@ -807,7 +807,7 @@ static int ioctl_flash_part_info(struct switchtec_dev *stdev,
 		struct switchtec_ioctl_flash_part_info __user *uinfo)
 {
 	int ret;
-	struct switchtec_ioctl_flash_part_info info = {0};
+	struct switchtec_ioctl_flash_part_info info = {};
 
 	if (copy_from_user(&info, uinfo, sizeof(info)))
 		return -EFAULT;
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ba042e39cfaf..86deb289dbee 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -235,7 +235,7 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 			      union phy_configure_opts *opts)
 {
-	struct cdns_dphy_cfg cfg = { 0 };
+	struct cdns_dphy_cfg cfg = { };
 
 	if (mode != PHY_MODE_MIPI_DPHY)
 		return -EINVAL;
@@ -246,7 +246,7 @@ static int cdns_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 static int cdns_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	struct cdns_dphy_cfg cfg = { 0 };
+	struct cdns_dphy_cfg cfg = { };
 	int ret;
 
 	ret = cdns_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
index a95572b397ca..7736e3b23093 100644
--- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
+++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
@@ -320,7 +320,7 @@ static int mixel_dphy_set_pll_params(struct phy *phy)
 static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct mixel_dphy_priv *priv = phy_get_drvdata(phy);
-	struct mixel_dphy_cfg cfg = { 0 };
+	struct mixel_dphy_cfg cfg = { };
 	int ret;
 
 	ret = mixel_dphy_config_from_opts(phy, &opts->mipi_dphy, &cfg);
@@ -348,7 +348,7 @@ static int mixel_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 static int mixel_dphy_validate(struct phy *phy, enum phy_mode mode, int submode,
 			       union phy_configure_opts *opts)
 {
-	struct mixel_dphy_cfg cfg = { 0 };
+	struct mixel_dphy_cfg cfg = { };
 
 	if (mode != PHY_MODE_MIPI_DPHY)
 		return -EINVAL;
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
index e1285fe2fbc0..cc993b20f92b 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
@@ -46,7 +46,7 @@ static int bcm63xx_gpio_probe(struct device *dev, struct device_node *node,
 			      const struct bcm63xx_pinctrl_soc *soc,
 			      struct bcm63xx_pinctrl *pc)
 {
-	struct gpio_regmap_config grc = {0};
+	struct gpio_regmap_config grc = {};
 
 	grc.parent = dev;
 	grc.fwnode = &node->fwnode;
diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index e14012209992..04b3054b74a8 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -484,7 +484,7 @@ static struct pinctrl_desc zynqmp_desc = {
 
 static int zynqmp_pinctrl_get_function_groups(u32 fid, u32 index, u16 *groups)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -503,7 +503,7 @@ static int zynqmp_pinctrl_get_function_groups(u32 fid, u32 index, u16 *groups)
 
 static int zynqmp_pinctrl_get_func_num_groups(u32 fid, unsigned int *ngroups)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -587,7 +587,7 @@ static int zynqmp_pinctrl_prepare_func_groups(struct device *dev, u32 fid,
 
 static void zynqmp_pinctrl_get_function_name(u32 fid, char *name)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 payload[PAYLOAD_ARG_CNT];
 
 	qdata.qid = PM_QID_PINCTRL_GET_FUNCTION_NAME;
@@ -604,7 +604,7 @@ static void zynqmp_pinctrl_get_function_name(u32 fid, char *name)
 
 static int zynqmp_pinctrl_get_num_functions(unsigned int *nfuncs)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -621,7 +621,7 @@ static int zynqmp_pinctrl_get_num_functions(unsigned int *nfuncs)
 
 static int zynqmp_pinctrl_get_pin_groups(u32 pin, u32 index, u16 *groups)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 payload[PAYLOAD_ARG_CNT];
 	int ret;
 
@@ -777,7 +777,7 @@ static int zynqmp_pinctrl_prepare_function_info(struct device *dev,
 
 static int zynqmp_pinctrl_get_num_pins(unsigned int *npins)
 {
-	struct zynqmp_pm_query_data qdata = {0};
+	struct zynqmp_pm_query_data qdata = {};
 	u32 payload[PAYLOAD_ARG_CNT];
 	int ret;
 
diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 1c7a288b59a5..0b8964da2d32 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -281,7 +281,7 @@ static bool mlxbf_bootctl_guid_match(const guid_t *guid,
 
 static int mlxbf_bootctl_probe(struct platform_device *pdev)
 {
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_res res = { };
 	guid_t guid;
 	int ret;
 
diff --git a/drivers/platform/x86/intel/int1092/intel_sar.c b/drivers/platform/x86/intel/int1092/intel_sar.c
index 379560fe5df9..8b30c7efe26b 100644
--- a/drivers/platform/x86/intel/int1092/intel_sar.c
+++ b/drivers/platform/x86/intel/int1092/intel_sar.c
@@ -89,7 +89,7 @@ static acpi_status parse_package(struct wwan_sar_context *context, union acpi_ob
 		return AE_ERROR;
 
 	for (itr = 0; itr < data->total_dev_mode; itr++) {
-		struct wwan_device_mode_info temp = { 0 };
+		struct wwan_device_mode_info temp = { };
 
 		num = &item->package.elements[itr + 1];
 		if (num->type != ACPI_TYPE_PACKAGE || num->package.count < TOTAL_DATA)
diff --git a/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
index c05b4cf502fe..2a0a374aea17 100644
--- a/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
+++ b/drivers/platform/x86/intel/int3472/intel_skl_int3472_tps68470.c
@@ -75,7 +75,7 @@ static int tps68470_chip_init(struct device *dev, struct regmap *regmap)
  */
 static int skl_int3472_tps68470_calc_type(struct acpi_device *adev)
 {
-	struct int3472_cldb cldb = { 0 };
+	struct int3472_cldb cldb = { };
 	int ret;
 
 	/*
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 659b1073033c..a8835adf57f7 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -219,7 +219,7 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 				  struct intel_pmt_namespace *ns,
 				  struct device *parent)
 {
-	struct resource res = {0};
+	struct resource res = {};
 	struct device *dev;
 	int ret;
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 50ff04c84650..4871439d8afc 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2581,7 +2581,7 @@ static void hotkey_compare_and_issue_event(struct tp_nvram_state *oldn,
  */
 static int hotkey_kthread(void *data)
 {
-	struct tp_nvram_state s[2] = { 0 };
+	struct tp_nvram_state s[2] = { };
 	u32 poll_mask, event_mask;
 	unsigned int si, so;
 	unsigned long t;
diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7e5e24b585d8..3093907a05e0 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -1757,7 +1757,7 @@ static int bq27xxx_battery_read_health(struct bq27xxx_device_info *di)
 
 void bq27xxx_battery_update(struct bq27xxx_device_info *di)
 {
-	struct bq27xxx_reg_cache cache = {0, };
+	struct bq27xxx_reg_cache cache = {};
 	bool has_ci_flag = di->opts & BQ27XXX_O_HAS_CI;
 	bool has_singe_flag = di->opts & BQ27XXX_O_ZERO;
 
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 091868e9e9e8..1000eec06ce7 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -643,7 +643,7 @@ static int cw_bat_probe(struct i2c_client *client)
 {
 	int ret;
 	struct cw_battery *cw_bat;
-	struct power_supply_config psy_cfg = { 0 };
+	struct power_supply_config psy_cfg = { };
 
 	cw_bat = devm_kzalloc(&client->dev, sizeof(*cw_bat), GFP_KERNEL);
 	if (!cw_bat)
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0c2132c7f5d4..cc452e0ac2f4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -310,7 +310,7 @@ struct psy_am_i_supplied_data {
 
 static int __power_supply_am_i_supplied(struct device *dev, void *_data)
 {
-	union power_supply_propval ret = {0,};
+	union power_supply_propval ret = {};
 	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct psy_am_i_supplied_data *data = _data;
 
@@ -343,7 +343,7 @@ EXPORT_SYMBOL_GPL(power_supply_am_i_supplied);
 
 static int __power_supply_is_system_supplied(struct device *dev, void *data)
 {
-	union power_supply_propval ret = {0,};
+	union power_supply_propval ret = {};
 	struct power_supply *psy = dev_get_drvdata(dev);
 	unsigned int *count = data;
 
@@ -378,7 +378,7 @@ EXPORT_SYMBOL_GPL(power_supply_is_system_supplied);
 static int __power_supply_get_supplier_max_current(struct device *dev,
 						   void *data)
 {
-	union power_supply_propval ret = {0,};
+	union power_supply_propval ret = {};
 	struct power_supply *epsy = dev_get_drvdata(dev);
 	struct power_supply *psy = data;
 
@@ -393,7 +393,7 @@ static int __power_supply_get_supplier_max_current(struct device *dev,
 
 int power_supply_set_input_current_limit_from_supplier(struct power_supply *psy)
 {
-	union power_supply_propval val = {0,};
+	union power_supply_propval val = {};
 	int curr;
 
 	if (!psy->desc->set_property)
diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index d60fccedb250..8d8844036cab 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1700,7 +1700,7 @@ static int get_special_regulators(struct device *dev,
 static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
-	struct regulator_config config = { 0 };
+	struct regulator_config config = { };
 	int i, j, err, omit_enable;
 	bool use_snvs;
 	struct bd718xx_regulator_data *reg_data;
diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index aa42da4d141e..44113dc2a14e 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -900,7 +900,7 @@ static int bd957x_probe(struct platform_device *pdev)
 	bool vout_mode, ddr_sel, may_have_irqs = false;
 	struct regmap *regmap;
 	struct bd957x_data *ic_data;
-	struct regulator_config config = { 0 };
+	struct regulator_config config = { };
 	/* All regulators are related to UVD and thermal IRQs... */
 	struct regulator_dev *rdevs[BD9576_NUM_REGULATORS];
 	/* ...But VoutS1 is not flagged by OVD IRQ */
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 8d1b2771c1aa..93918395e5f2 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -194,7 +194,7 @@ static long copy_from_iova(struct device *mdev,
 			   void *to, u64 iova,
 			   unsigned long n)
 {
-	struct pfn_array pa = {0};
+	struct pfn_array pa = {};
 	u64 from;
 	int i, ret;
 	unsigned long l, m;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index f433428057d9..c9e1333bcaae 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1447,7 +1447,7 @@ static int ap_get_compatible_type(ap_qid_t qid, int rawtype, unsigned int func)
 	 */
 	if (ap_qact_available()) {
 		struct ap_queue_status status;
-		union ap_qact_ap_info apinfo = {0};
+		union ap_qact_ap_info apinfo = {};
 
 		apinfo.mode = (func >> 26) & 0x07;
 		apinfo.cat = AP_DEVICE_TYPE_CEX7;
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index d70c4d3d0907..c6d28d920b8d 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -30,7 +30,7 @@ static void __ap_flush_queue(struct ap_queue *aq);
 static int ap_queue_enable_irq(struct ap_queue *aq, void *ind)
 {
 	struct ap_queue_status status;
-	struct ap_qirq_ctrl qirqctrl = { 0 };
+	struct ap_qirq_ctrl qirqctrl = { };
 
 	qirqctrl.ir = 1;
 	qirqctrl.isc = AP_ISC;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 41ca6273b750..cc8b08eb5df2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4637,7 +4637,7 @@ static int qeth_snmp_command(struct qeth_card *card, char __user *udata)
 	struct qeth_snmp_ureq __user *ureq;
 	struct qeth_cmd_buffer *iob;
 	unsigned int req_len;
-	struct qeth_arp_query_info qinfo = {0, };
+	struct qeth_arp_query_info qinfo = {};
 	int rc = 0;
 
 	QETH_CARD_TEXT(card, 3, "snmpcmd");
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 3a523e700a5a..1820aab2ea15 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1396,7 +1396,7 @@ static int qeth_l3_query_arp_cache_info(struct qeth_card *card,
 
 static int qeth_l3_arp_query(struct qeth_card *card, char __user *udata)
 {
-	struct qeth_arp_query_info qinfo = {0, };
+	struct qeth_arp_query_info qinfo = {};
 	int rc;
 
 	QETH_CARD_TEXT(card, 3, "arpquery");
diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index 6a2720105138..d16129738a94 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -441,7 +441,7 @@ int zfcp_qdio_open(struct zfcp_qdio *qdio)
 	struct qdio_buffer **input_sbals[1] = {qdio->res_q};
 	struct qdio_buffer **output_sbals[1] = {qdio->req_q};
 	struct qdio_buffer_element *sbale;
-	struct qdio_initialize init_data = {0};
+	struct qdio_initialize init_data = {};
 	struct zfcp_adapter *adapter = qdio->adapter;
 	struct ccw_device *cdev = adapter->ccw_device;
 	struct qdio_ssqd_desc ssqd;
diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
index e70f69f791db..007caf7bd8cd 100644
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -1324,7 +1324,7 @@ static void hwi_complete_cmd(struct beiscsi_conn *beiscsi_conn,
 {
 	struct iscsi_conn *conn = beiscsi_conn->conn;
 	struct iscsi_session *session = conn->session;
-	struct common_sol_cqe csol_cqe = {0};
+	struct common_sol_cqe csol_cqe = {};
 	struct hwi_wrb_context *pwrb_context;
 	struct hwi_controller *phwi_ctrlr;
 	struct wrb_handle *pwrb_handle;
diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index 440ef32be048..b984abe60259 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -492,7 +492,7 @@ void
 bfa_fcb_pbc_vport_create(struct bfad_s *bfad, struct bfi_pbc_vport_s pbc_vport)
 {
 
-	struct bfa_lport_cfg_s port_cfg = {0};
+	struct bfa_lport_cfg_s port_cfg = {};
 	struct bfad_vport_s   *vport;
 	int rc;
 
diff --git a/drivers/scsi/cxlflash/cxl_hw.c b/drivers/scsi/cxlflash/cxl_hw.c
index b814130f3f5c..a1c913281dd3 100644
--- a/drivers/scsi/cxlflash/cxl_hw.c
+++ b/drivers/scsi/cxlflash/cxl_hw.c
@@ -130,7 +130,7 @@ static void *cxlflash_fops_get_context(struct file *file)
 
 static int cxlflash_start_work(void *ctx_cookie, u64 irqs)
 {
-	struct cxl_ioctl_start_work work = { 0 };
+	struct cxl_ioctl_start_work work = { };
 
 	work.num_interrupts = irqs;
 	work.flags = CXL_START_WORK_NUM_IRQS;
diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
index b2730e859df8..8d40038a62af 100644
--- a/drivers/scsi/cxlflash/main.c
+++ b/drivers/scsi/cxlflash/main.c
@@ -2371,7 +2371,7 @@ int cxlflash_afu_sync(struct afu *afu, ctx_hndl_t ctx, res_hndl_t res, u8 mode)
 {
 	struct cxlflash_cfg *cfg = afu->parent;
 	struct device *dev = &cfg->dev->dev;
-	struct sisl_ioarcb rcb = { 0 };
+	struct sisl_ioarcb rcb = { };
 
 	dev_dbg(dev, "%s: afu=%p ctx=%u res=%u mode=%u\n",
 		__func__, afu, ctx, res, mode);
diff --git a/drivers/scsi/cxlflash/superpipe.c b/drivers/scsi/cxlflash/superpipe.c
index df0ebabbf387..0762e0d0ef1d 100644
--- a/drivers/scsi/cxlflash/superpipe.c
+++ b/drivers/scsi/cxlflash/superpipe.c
@@ -530,7 +530,7 @@ static void rht_format1(struct sisl_rht_entry *rhte, u64 lun_id, u32 perm,
 	 * LUN) using the synchronization sequence defined in the
 	 * SISLite specification.
 	 */
-	struct sisl_rht_entry_f1 dummy = { 0 };
+	struct sisl_rht_entry_f1 dummy = { };
 	struct sisl_rht_entry_f1 *rhte_f1 = (struct sisl_rht_entry_f1 *)rhte;
 
 	memset(rhte_f1, 0, sizeof(*rhte_f1));
@@ -1775,7 +1775,7 @@ static int process_sense(struct scsi_device *sdev,
 	struct llun_info *lli = sdev->hostdata;
 	struct glun_info *gli = lli->parent;
 	u64 prev_lba = gli->max_lba;
-	struct scsi_sense_hdr sshdr = { 0 };
+	struct scsi_sense_hdr sshdr = { };
 	int rc = 0;
 
 	rc = scsi_normalize_sense((const u8 *)&verify->sense_data,
diff --git a/drivers/scsi/elx/efct/efct_hw.c b/drivers/scsi/elx/efct/efct_hw.c
index ba8256b4c782..bce7038684ff 100644
--- a/drivers/scsi/elx/efct/efct_hw.c
+++ b/drivers/scsi/elx/efct/efct_hw.c
@@ -81,7 +81,7 @@ __efct_read_topology_cb(struct efct_hw *hw, int status, u8 *mqe, void *arg)
 	struct sli4_cmd_read_topology *read_topo =
 				(struct sli4_cmd_read_topology *)mqe;
 	u8 speed;
-	struct efc_domain_record drec = {0};
+	struct efc_domain_record drec = {};
 	struct efct *efct = hw->os;
 
 	if (status || le16_to_cpu(read_topo->hdr.status)) {
@@ -178,7 +178,7 @@ efct_hw_cb_link(void *ctx, void *e)
 		efct->efcport->link_status = EFC_LINK_STATUS_UP;
 
 		if (event->topology == SLI4_LINK_TOPO_NON_FC_AL) {
-			struct efc_domain_record drec = {0};
+			struct efc_domain_record drec = {};
 
 			efc_log_info(hw->os, "Link Up, NPORT, speed is %d\n",
 				     event->speed);
diff --git a/drivers/scsi/elx/libefc_sli/sli4.c b/drivers/scsi/elx/libefc_sli/sli4.c
index 6c6c04e1b74d..05d1b519031a 100644
--- a/drivers/scsi/elx/libefc_sli/sli4.c
+++ b/drivers/scsi/elx/libefc_sli/sli4.c
@@ -584,7 +584,7 @@ sli_fc_rq_set_alloc(struct sli4 *sli4, u32 num_rq_pairs,
 		    u32 payload_buffer_size)
 {
 	u32 i;
-	struct efc_dma dma = {0};
+	struct efc_dma dma = {};
 	struct sli4_rsp_cmn_create_queue_set *rsp = NULL;
 	void __iomem *db_regaddr = NULL;
 	u32 num_rqs = num_rq_pairs * 2;
@@ -918,7 +918,7 @@ sli_cq_alloc_set(struct sli4 *sli4, struct sli4_queue *qs[],
 		 u32 num_cqs, u32 n_entries, struct sli4_queue *eqs[])
 {
 	u32 i;
-	struct efc_dma dma = {0};
+	struct efc_dma dma = {};
 	struct sli4_rsp_cmn_create_queue_set *res;
 	void __iomem *db_regaddr;
 
@@ -2499,7 +2499,7 @@ int
 sli_fc_process_link_attention(struct sli4 *sli4, void *acqe)
 {
 	struct sli4_link_attention *link_attn = acqe;
-	struct sli4_link_event event = { 0 };
+	struct sli4_link_event event = { };
 
 	efc_log_info(sli4, "link=%d attn_type=%#x top=%#x speed=%#x pfault=%#x\n",
 		     link_attn->link_number, link_attn->attn_type,
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index b35bf70a8c0d..9bd16aad1c35 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -1643,7 +1643,7 @@ lpfc_issue_reset(struct device *dev, struct device_attribute *attr,
 int
 lpfc_sli4_pdev_status_reg_wait(struct lpfc_hba *phba)
 {
-	struct lpfc_register portstat_reg = {0};
+	struct lpfc_register portstat_reg = {};
 	int i;
 
 	msleep(100);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 0ec322f0e3cb..da762e162202 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -1930,7 +1930,7 @@ lpfc_handle_eratt_s4(struct lpfc_hba *phba)
 	uint32_t event_data;
 	struct Scsi_Host *shost;
 	uint32_t if_type;
-	struct lpfc_register portstat_reg = {0};
+	struct lpfc_register portstat_reg = {};
 	uint32_t reg_err1, reg_err2;
 	uint32_t uerrlo_reg, uemasklo_reg;
 	uint32_t smphr_port_status = 0, pci_rd_rc1, pci_rd_rc2;
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 07f274afd7e5..595bdfe3557c 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -817,7 +817,7 @@ static void myrs_log_event(struct myrs_hba *cs, struct myrs_event *ev)
 	unsigned char ev_type, *ev_msg;
 	struct Scsi_Host *shost = cs->host;
 	struct scsi_device *sdev;
-	struct scsi_sense_hdr sshdr = {0};
+	struct scsi_sense_hdr sshdr = {};
 	unsigned char sense_info[4];
 	unsigned char cmd_specific[4];
 
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index 3404782988d5..b1d4271149c2 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -773,7 +773,7 @@ u16 qedf_get_sqe_idx(struct qedf_rport *fcport)
 
 void qedf_ring_doorbell(struct qedf_rport *fcport)
 {
-	struct fcoe_db_data dbell = { 0 };
+	struct fcoe_db_data dbell = { };
 
 	dbell.agg_flags = 0;
 
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index ad746c62f0d4..d2c45291c321 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -716,7 +716,7 @@ qla_edif_app_authok(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 {
 	int32_t			rval = 0;
 	struct auth_complete_cmd appplogiok;
-	struct app_plogi_reply	appplogireply = {0};
+	struct app_plogi_reply	appplogireply = {};
 	struct fc_bsg_reply	*bsg_reply = bsg_job->reply;
 	fc_port_t		*fcport = NULL;
 	port_id_t		portid = {0};
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 4a96fb05731d..164b230377af 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -465,7 +465,7 @@ store_sas_phy_##field(struct device *dev, 				\
 	struct Scsi_Host *shost = dev_to_shost(phy->dev.parent);	\
 	struct sas_internal *i = to_sas_internal(shost->transportt);	\
 	u32 value;							\
-	struct sas_phy_linkrates rates = {0};				\
+	struct sas_phy_linkrates rates = {};				\
 	int error;							\
 									\
 	error = set_sas_linkspeed_names(&value, buf);			\
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index cbd9999f93a6..142f99409764 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1649,7 +1649,7 @@ static unsigned int sd_check_events(struct gendisk *disk, unsigned int clearing)
 	 * sd_revalidate() is called.
 	 */
 	if (scsi_block_when_processing_errors(sdp)) {
-		struct scsi_sense_hdr sshdr = { 0, };
+		struct scsi_sense_hdr sshdr = { };
 
 		retval = scsi_test_unit_ready(sdp, SD_TIMEOUT, sdkp->max_retries,
 					      &sshdr);
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index b9757f24b0d6..837f0c146a09 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -48,7 +48,7 @@ static int sd_zbc_parse_report(struct scsi_disk *sdkp, u8 *buf,
 			       unsigned int idx, report_zones_cb cb, void *data)
 {
 	struct scsi_device *sdp = sdkp->device;
-	struct blk_zone zone = { 0 };
+	struct blk_zone zone = { };
 	int ret;
 
 	zone.type = buf[0] & 0x0f;
diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ecb2af3f43ca..51cf5643acaf 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2727,7 +2727,7 @@ static int pqi_raid_bypass_submit_scsi_cmd(struct pqi_ctrl_info *ctrl_info,
 	u32 next_bypass_group;
 	struct pqi_encryption_info *encryption_info_ptr;
 	struct pqi_encryption_info encryption_info;
-	struct pqi_scsi_dev_raid_map_data rmd = { 0 };
+	struct pqi_scsi_dev_raid_map_data rmd = { };
 
 	rc = pqi_get_aio_lba_and_block_count(scmd, &rmd);
 	if (rc)
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 3841ab49f556..062266f8edc7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3695,7 +3695,7 @@ static void ufshcd_host_memory_configure(struct ufs_hba *hba)
  */
 static int ufshcd_dme_link_startup(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	int ret;
 
 	uic_cmd.command = UIC_CMD_DME_LINK_STARTUP;
@@ -3717,7 +3717,7 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
  */
 static int ufshcd_dme_reset(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	int ret;
 
 	uic_cmd.command = UIC_CMD_DME_RESET;
@@ -3756,7 +3756,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_configure_adapt);
  */
 static int ufshcd_dme_enable(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	int ret;
 
 	uic_cmd.command = UIC_CMD_DME_ENABLE;
@@ -3813,7 +3813,7 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
 			u8 attr_set, u32 mib_val, u8 peer)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	static const char *const action[] = {
 		"dme-set",
 		"dme-peer-set"
@@ -3857,7 +3857,7 @@ EXPORT_SYMBOL_GPL(ufshcd_dme_set_attr);
 int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
 			u32 *mib_val, u8 peer)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	static const char *const action[] = {
 		"dme-get",
 		"dme-peer-get"
@@ -4061,7 +4061,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
  */
 static int ufshcd_uic_change_pwr_mode(struct ufs_hba *hba, u8 mode)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	int ret;
 
 	if (hba->quirks & UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP) {
@@ -4119,7 +4119,7 @@ EXPORT_SYMBOL_GPL(ufshcd_link_recovery);
 static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba)
 {
 	int ret;
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	ktime_t start = ktime_get();
 
 	ufshcd_vops_hibern8_notify(hba, UIC_CMD_DME_HIBER_ENTER, PRE_CHANGE);
@@ -4141,7 +4141,7 @@ static int ufshcd_uic_hibern8_enter(struct ufs_hba *hba)
 
 int ufshcd_uic_hibern8_exit(struct ufs_hba *hba)
 {
-	struct uic_command uic_cmd = {0};
+	struct uic_command uic_cmd = {};
 	int ret;
 	ktime_t start = ktime_get();
 
@@ -4379,7 +4379,7 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
 int ufshcd_config_pwr_mode(struct ufs_hba *hba,
 		struct ufs_pa_layer_attr *desired_pwr_mode)
 {
-	struct ufs_pa_layer_attr final_params = { 0 };
+	struct ufs_pa_layer_attr final_params = { };
 	int ret;
 
 	ret = ufshcd_vops_pwr_change_notify(hba, PRE_CHANGE,
diff --git a/drivers/scsi/ufs/ufshpb.c b/drivers/scsi/ufs/ufshpb.c
index 02fb51ae8b25..0961cc838132 100644
--- a/drivers/scsi/ufs/ufshpb.c
+++ b/drivers/scsi/ufs/ufshpb.c
@@ -2756,7 +2756,7 @@ void ufshpb_init_hpb_lu(struct ufs_hba *hba, struct scsi_device *sdev)
 {
 	struct ufshpb_lu *hpb;
 	int ret;
-	struct ufshpb_lu_info hpb_lu_info = { 0 };
+	struct ufshpb_lu_info hpb_lu_info = { };
 	int lun = sdev->lun;
 
 	if (lun >= hba->dev_info.max_lu_supported)
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index ce1ba1b93629..9ce811272806 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -258,7 +258,7 @@ static void pvscsi_write_cmd_desc(const struct pvscsi_adapter *adapter,
 static void pvscsi_abort_cmd(const struct pvscsi_adapter *adapter,
 			     const struct pvscsi_ctx *ctx)
 {
-	struct PVSCSICmdDescAbortCmd cmd = { 0 };
+	struct PVSCSICmdDescAbortCmd cmd = { };
 
 	cmd.target = ctx->cmd->device->id;
 	cmd.context = pvscsi_map_context(adapter, ctx);
@@ -314,7 +314,7 @@ static void ll_bus_reset(const struct pvscsi_adapter *adapter)
 
 static void ll_device_reset(const struct pvscsi_adapter *adapter, u32 target)
 {
-	struct PVSCSICmdDescResetDevice cmd = { 0 };
+	struct PVSCSICmdDescResetDevice cmd = { };
 
 	dev_dbg(pvscsi_dev(adapter), "Resetting device: target=%u\n", target);
 
@@ -485,7 +485,7 @@ static int pvscsi_allocate_rings(struct pvscsi_adapter *adapter)
 
 static void pvscsi_setup_all_rings(const struct pvscsi_adapter *adapter)
 {
-	struct PVSCSICmdDescSetupRings cmd = { 0 };
+	struct PVSCSICmdDescSetupRings cmd = { };
 	dma_addr_t base;
 	unsigned i;
 
@@ -513,7 +513,7 @@ static void pvscsi_setup_all_rings(const struct pvscsi_adapter *adapter)
 			      &cmd, sizeof(cmd));
 
 	if (adapter->use_msg) {
-		struct PVSCSICmdDescSetupMsgRing cmd_msg = { 0 };
+		struct PVSCSICmdDescSetupMsgRing cmd_msg = { };
 
 		cmd_msg.numPages = adapter->msg_pages;
 
@@ -1160,7 +1160,7 @@ static bool pvscsi_setup_req_threshold(struct pvscsi_adapter *adapter,
 		printk(KERN_INFO "vmw_pvscsi: device does not support req_threshold\n");
 		return false;
 	} else {
-		struct PVSCSICmdDescSetupReqCall cmd_msg = { 0 };
+		struct PVSCSICmdDescSetupReqCall cmd_msg = { };
 		cmd_msg.enable = enable;
 		printk(KERN_INFO
 		       "vmw_pvscsi: %sabling reqCallThreshold\n",
diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index f04b961b96cd..8754da4f3e8b 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -397,7 +397,7 @@ static int qcom_set_laddr(struct slim_controller *sctrl,
 		u8 instance;
 		u8 laddr;
 	} __packed p;
-	struct slim_val_inf msg = {0};
+	struct slim_val_inf msg = {};
 	DEFINE_SLIM_EDEST_TXN(txn, SLIM_MSG_MC_ASSIGN_LOGICAL_ADDRESS,
 			      10, laddr, &msg);
 	int ret;
diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7040293c2ee8..8a73288554a2 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -933,10 +933,10 @@ static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
 {
 	struct slim_device *sdev = rt->dev;
 	struct slim_controller *ctrl = sdev->ctrl;
-	struct slim_val_inf msg =  {0};
+	struct slim_val_inf msg =  {};
 	u8 wbuf[SLIM_MSGQ_BUF_LEN];
 	u8 rbuf[SLIM_MSGQ_BUF_LEN];
-	struct slim_msg_txn txn = {0,};
+	struct slim_msg_txn txn = {};
 	int i, ret;
 
 	txn.mt = SLIM_MSG_MT_DEST_REFERRED_USER;
@@ -1019,7 +1019,7 @@ static int qcom_slim_ngd_enable_stream(struct slim_stream_runtime *rt)
 static int qcom_slim_ngd_get_laddr(struct slim_controller *ctrl,
 				   struct slim_eaddr *ea, u8 *laddr)
 {
-	struct slim_val_inf msg =  {0};
+	struct slim_val_inf msg =  {};
 	u8 failed_ea[6] = {0, 0, 0, 0, 0, 0};
 	struct slim_msg_txn txn;
 	u8 wbuf[10] = {0};
@@ -1171,7 +1171,7 @@ static void qcom_slim_ngd_master_worker(struct work_struct *work)
 {
 	struct qcom_slim_ngd_ctrl *ctrl;
 	struct slim_msg_txn txn;
-	struct slim_val_inf msg = {0};
+	struct slim_val_inf msg = {};
 	int retries = 0;
 	u8 wbuf[8];
 	int ret = 0;
diff --git a/drivers/soc/fsl/dpio/dpio.c b/drivers/soc/fsl/dpio/dpio.c
index af74c597a675..fef47677ee81 100644
--- a/drivers/soc/fsl/dpio/dpio.c
+++ b/drivers/soc/fsl/dpio/dpio.c
@@ -37,7 +37,7 @@ int dpio_open(struct fsl_mc_io *mc_io,
 	      int dpio_id,
 	      u16 *token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpio_cmd_open *dpio_cmd;
 	int err;
 
@@ -70,7 +70,7 @@ int dpio_close(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_CLOSE,
@@ -92,7 +92,7 @@ int dpio_enable(struct fsl_mc_io *mc_io,
 		u32 cmd_flags,
 		u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_ENABLE,
@@ -114,7 +114,7 @@ int dpio_disable(struct fsl_mc_io *mc_io,
 		 u32 cmd_flags,
 		 u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_DISABLE,
@@ -138,7 +138,7 @@ int dpio_get_attributes(struct fsl_mc_io *mc_io,
 			u16 token,
 			struct dpio_attr *attr)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpio_rsp_get_attr *dpio_rsp;
 	int err;
 
@@ -171,7 +171,7 @@ int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
 				  u16 token,
 				  u8 sdest)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	struct dpio_stashing_dest *dpio_cmd;
 
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_SET_STASHING_DEST,
@@ -196,7 +196,7 @@ int dpio_get_api_version(struct fsl_mc_io *mc_io,
 			 u16 *major_ver,
 			 u16 *minor_ver)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 	int err;
 
 	/* prepare command */
@@ -225,7 +225,7 @@ int dpio_reset(struct fsl_mc_io *mc_io,
 	       u32 cmd_flags,
 	       u16 token)
 {
-	struct fsl_mc_command cmd = { 0 };
+	struct fsl_mc_command cmd = { };
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPIO_CMDID_RESET,
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 915d5bc3d46e..b10c4ef51660 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -569,7 +569,7 @@ EXPORT_SYMBOL(pdr_add_lookup);
 int pdr_restart_pd(struct pdr_handle *pdr, struct pdr_service *pds)
 {
 	struct servreg_restart_pd_resp resp;
-	struct servreg_restart_pd_req req = { 0 };
+	struct servreg_restart_pd_req req = { };
 	struct sockaddr_qrtr addr;
 	struct pdr_service *tmp;
 	struct qmi_txn txn;
diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 312ba0f98ad7..594e261d923f 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -449,7 +449,7 @@ EXPORT_SYMBOL_GPL(k3_ringacc_request_rings_pair);
 
 static void k3_ringacc_ring_reset_sci(struct k3_ring *ring)
 {
-	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
@@ -478,7 +478,7 @@ EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset);
 static void k3_ringacc_ring_reconfig_qmode_sci(struct k3_ring *ring,
 					       enum k3_ring_mode mode)
 {
-	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
@@ -554,7 +554,7 @@ EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset_dma);
 
 static void k3_ringacc_ring_free_sci(struct k3_ring *ring)
 {
-	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
@@ -656,7 +656,7 @@ EXPORT_SYMBOL_GPL(k3_ringacc_get_ring_irq_num);
 
 static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 {
-	struct ti_sci_msg_rm_ring_cfg ring_cfg = { 0 };
+	struct ti_sci_msg_rm_ring_cfg ring_cfg = { };
 	struct k3_ringacc *ringacc = ring->parent;
 	int ret;
 
diff --git a/drivers/soundwire/generic_bandwidth_allocation.c b/drivers/soundwire/generic_bandwidth_allocation.c
index f7c66083a4dd..7e8915dbc17e 100644
--- a/drivers/soundwire/generic_bandwidth_allocation.c
+++ b/drivers/soundwire/generic_bandwidth_allocation.c
@@ -90,7 +90,7 @@ static void sdw_compute_master_ports(struct sdw_master_runtime *m_rt,
 				     struct sdw_group_params *params,
 				     int port_bo, int hstop)
 {
-	struct sdw_transport_data t_data = {0};
+	struct sdw_transport_data t_data = {};
 	struct sdw_port_runtime *p_rt;
 	struct sdw_bus *bus = m_rt->bus;
 	struct sdw_bus_params *b_params = &bus->params;
diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
index 44fc9ee13fc7..638e6fefc080 100644
--- a/drivers/spi/spi-altera-dfl.c
+++ b/drivers/spi/spi-altera-dfl.c
@@ -123,7 +123,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
 
 static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
 {
-	struct spi_board_info board_info = { 0 };
+	struct spi_board_info board_info = { };
 	struct device *dev = &dfl_dev->dev;
 	struct spi_master *master;
 	struct altera_spi *hw;
diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index a09831c62192..b7a78e57b0ad 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -73,7 +73,7 @@ static void dw_spi_dma_maxburst_init(struct dw_spi *dws)
 
 static void dw_spi_dma_sg_burst_init(struct dw_spi *dws)
 {
-	struct dma_slave_caps tx = {0}, rx = {0};
+	struct dma_slave_caps tx = {}, rx = {};
 
 	dma_get_slave_caps(dws->txchan, &tx);
 	dma_get_slave_caps(dws->rxchan, &rx);
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index e9de1d958bbd..b24cdb432278 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -539,7 +539,7 @@ static int tegra_spi_start_dma_based_transfer(
 	unsigned int len;
 	int ret = 0;
 	u8 dma_burst;
-	struct dma_slave_config dma_sconfig = {0};
+	struct dma_slave_config dma_sconfig = {};
 
 	val = SPI_DMA_BLK_SET(tspi->curr_dma_words - 1);
 	tegra_spi_writel(tspi, val, SPI_DMA_BLK);
diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 2354ca1e3858..a30461bcee44 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -563,7 +563,7 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
-	struct dma_slave_config dma_sconfig = { 0 };
+	struct dma_slave_config dma_sconfig = { };
 	unsigned int len;
 	u8 dma_burst;
 	int ret = 0;
diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/fb_ssd1351.c
index cf263a58a148..ea6c2e5596c8 100644
--- a/drivers/staging/fbtft/fb_ssd1351.c
+++ b/drivers/staging/fbtft/fb_ssd1351.c
@@ -212,7 +212,7 @@ static const struct backlight_ops bl_ops = {
 static void register_onboard_backlight(struct fbtft_par *par)
 {
 	struct backlight_device *bd;
-	struct backlight_properties bl_props = { 0, };
+	struct backlight_properties bl_props = { };
 
 	bl_props.type = BACKLIGHT_RAW;
 	bl_props.power = FB_BLANK_POWERDOWN;
diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft/fb_watterott.c
index a57e1f4feef3..af12f8dc4092 100644
--- a/drivers/staging/fbtft/fb_watterott.c
+++ b/drivers/staging/fbtft/fb_watterott.c
@@ -250,7 +250,7 @@ static const struct backlight_ops bl_ops = {
 static void register_chip_backlight(struct fbtft_par *par)
 {
 	struct backlight_device *bd;
-	struct backlight_properties bl_props = { 0, };
+	struct backlight_properties bl_props = { };
 
 	bl_props.type = BACKLIGHT_RAW;
 	bl_props.power = FB_BLANK_POWERDOWN;
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index ed992ca605eb..330557a412ed 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -170,7 +170,7 @@ static const struct backlight_ops fbtft_bl_ops = {
 void fbtft_register_backlight(struct fbtft_par *par)
 {
 	struct backlight_device *bd;
-	struct backlight_properties bl_props = { 0, };
+	struct backlight_properties bl_props = { };
 
 	if (!par->gpio.led[0]) {
 		fbtft_par_dbg(DEBUG_BACKLIGHT, par,
diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdio.c
index 37bf04c22dbc..7af748c7ce07 100644
--- a/drivers/staging/greybus/sdio.c
+++ b/drivers/staging/greybus/sdio.c
@@ -406,7 +406,7 @@ static int gb_sdio_transfer(struct gb_sdio_host *host, struct mmc_data *data)
 
 static int gb_sdio_command(struct gb_sdio_host *host, struct mmc_command *cmd)
 {
-	struct gb_sdio_command_request request = {0};
+	struct gb_sdio_command_request request = {};
 	struct gb_sdio_command_response response;
 	struct mmc_data *data = host->mrq->data;
 	unsigned int timeout_ms;
diff --git a/drivers/staging/media/atomisp/pci/atomisp_acc.c b/drivers/staging/media/atomisp/pci/atomisp_acc.c
index 9a1751895ab0..0009713bcf6c 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_acc.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_acc.c
@@ -211,7 +211,7 @@ int atomisp_acc_load_to_pipe(struct atomisp_sub_device *asd,
 int atomisp_acc_load(struct atomisp_sub_device *asd,
 		     struct atomisp_acc_fw_load *user_fw)
 {
-	struct atomisp_acc_fw_load_to_pipe ltp = {0};
+	struct atomisp_acc_fw_load_to_pipe ltp = {};
 	int r;
 
 	ltp.flags = ATOMISP_ACC_FW_LOAD_FL_ACC;
@@ -323,7 +323,7 @@ int atomisp_acc_wait(struct atomisp_sub_device *asd, unsigned int *handle)
 
 void atomisp_acc_done(struct atomisp_sub_device *asd, unsigned int handle)
 {
-	struct v4l2_event event = { 0 };
+	struct v4l2_event event = { };
 
 	event.type = V4L2_EVENT_ATOMISP_ACC_COMPLETE;
 	event.u.frame_sync.frame_sequence = atomic_read(&asd->sequence);
diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 366161cff560..ded3779e2058 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -110,7 +110,7 @@ struct atomisp_acc_pipe *atomisp_to_acc_pipe(struct video_device *dev)
 
 static unsigned short atomisp_get_sensor_fps(struct atomisp_sub_device *asd)
 {
-	struct v4l2_subdev_frame_interval fi = { 0 };
+	struct v4l2_subdev_frame_interval fi = { };
 	struct atomisp_device *isp = asd->isp;
 
 	unsigned short fps = 0;
@@ -398,7 +398,7 @@ void atomisp_msi_irq_uninit(struct atomisp_device *isp)
 
 static void atomisp_sof_event(struct atomisp_sub_device *asd)
 {
-	struct v4l2_event event = {0};
+	struct v4l2_event event = {};
 
 	event.type = V4L2_EVENT_FRAME_SYNC;
 	event.u.frame_sync.frame_sequence = atomic_read(&asd->sof_count);
@@ -408,7 +408,7 @@ static void atomisp_sof_event(struct atomisp_sub_device *asd)
 
 void atomisp_eof_event(struct atomisp_sub_device *asd, uint8_t exp_id)
 {
-	struct v4l2_event event = {0};
+	struct v4l2_event event = {};
 
 	event.type = V4L2_EVENT_FRAME_END;
 	event.u.frame_sync.frame_sequence = exp_id;
@@ -419,7 +419,7 @@ void atomisp_eof_event(struct atomisp_sub_device *asd, uint8_t exp_id)
 static void atomisp_3a_stats_ready_event(struct atomisp_sub_device *asd,
 	uint8_t exp_id)
 {
-	struct v4l2_event event = {0};
+	struct v4l2_event event = {};
 
 	event.type = V4L2_EVENT_ATOMISP_3A_STATS_READY;
 	event.u.frame_sync.frame_sequence = exp_id;
@@ -430,7 +430,7 @@ static void atomisp_3a_stats_ready_event(struct atomisp_sub_device *asd,
 static void atomisp_metadata_ready_event(struct atomisp_sub_device *asd,
 	enum atomisp_metadata_type md_type)
 {
-	struct v4l2_event event = {0};
+	struct v4l2_event event = {};
 
 	event.type = V4L2_EVENT_ATOMISP_METADATA_READY;
 	event.u.data[0] = md_type;
@@ -440,7 +440,7 @@ static void atomisp_metadata_ready_event(struct atomisp_sub_device *asd,
 
 static void atomisp_reset_event(struct atomisp_sub_device *asd)
 {
-	struct v4l2_event event = {0};
+	struct v4l2_event event = {};
 
 	event.type = V4L2_EVENT_ATOMISP_CSS_RESET;
 
@@ -1269,7 +1269,7 @@ void atomisp_delayed_init_work(struct work_struct *work)
 	 * to SOC camera, use yuvpp pipe and no support continuous mode.
 	 */
 	if (!ATOMISP_USE_YUVPP(asd)) {
-		struct v4l2_event event = {0};
+		struct v4l2_event event = {};
 		struct ia_css_stream *stream;
 
 		stream = asd->stream_env[ATOMISP_INPUT_STREAM_GENERAL].stream;
@@ -2399,7 +2399,7 @@ static void atomisp_curr_user_grid_info(struct atomisp_sub_device *asd,
 int atomisp_compare_grid(struct atomisp_sub_device *asd,
 			 struct atomisp_grid_info *atomgrid)
 {
-	struct atomisp_grid_info tmp = {0};
+	struct atomisp_grid_info tmp = {};
 
 	atomisp_curr_user_grid_info(asd, &tmp);
 	return memcmp(atomgrid, &tmp, sizeof(tmp));
@@ -2417,7 +2417,7 @@ int atomisp_gdc_cac_table(struct atomisp_sub_device *asd, int flag,
 
 	if (flag == 0) {
 		/* Get gdc table from current setup */
-		struct ia_css_morph_table tab = {0};
+		struct ia_css_morph_table tab = {};
 
 		atomisp_css_get_morph_table(asd, &tab);
 
@@ -5240,8 +5240,8 @@ static int atomisp_set_fmt_to_isp(struct video_device *vdev,
 	 */
 	if (asd->fmt_auto->val ||
 	    asd->vfpp->val != ATOMISP_VFPP_ENABLE) {
-		struct v4l2_rect vf_size = {0};
-		struct v4l2_mbus_framefmt vf_ffmt = {0};
+		struct v4l2_rect vf_size = {};
+		struct v4l2_mbus_framefmt vf_ffmt = {};
 
 		if (pix->width < 640 || pix->height < 480) {
 			vf_size.width = pix->width;
@@ -5596,7 +5596,7 @@ int atomisp_set_fmt(struct video_device *vdev, struct v4l2_format *f)
 	unsigned int padding_w = pad_w, padding_h = pad_h;
 	bool res_overflow = false, crop_needs_override = false;
 	struct v4l2_mbus_framefmt *isp_sink_fmt;
-	struct v4l2_mbus_framefmt isp_source_fmt = {0};
+	struct v4l2_mbus_framefmt isp_source_fmt = {};
 	struct v4l2_rect isp_sink_crop;
 	u16 source_pad = atomisp_subdev_source_pad(vdev);
 	struct v4l2_subdev_fh fh;
@@ -5629,7 +5629,7 @@ int atomisp_set_fmt(struct video_device *vdev, struct v4l2_format *f)
 	     && asd->run_mode->val == ATOMISP_RUN_MODE_VIDEO)) {
 		if (asd->fmt_auto->val) {
 			struct v4l2_rect *capture_comp;
-			struct v4l2_rect r = {0};
+			struct v4l2_rect r = {};
 
 			r.width = f->fmt.pix.width;
 			r.height = f->fmt.pix.height;
@@ -5914,7 +5914,7 @@ int atomisp_set_fmt(struct video_device *vdev, struct v4l2_format *f)
 					     source_pad, V4L2_SEL_TGT_COMPOSE,
 					     0, &isp_sink_crop);
 	} else if (IS_MOFD) {
-		struct v4l2_rect main_compose = {0};
+		struct v4l2_rect main_compose = {};
 
 		main_compose.width = isp_sink_crop.width;
 		main_compose.height =
@@ -5934,8 +5934,8 @@ int atomisp_set_fmt(struct video_device *vdev, struct v4l2_format *f)
 					     V4L2_SEL_TGT_COMPOSE, 0,
 					     &main_compose);
 	} else {
-		struct v4l2_rect sink_crop = {0};
-		struct v4l2_rect main_compose = {0};
+		struct v4l2_rect sink_crop = {};
+		struct v4l2_rect main_compose = {};
 
 		main_compose.width = f->fmt.pix.width;
 		main_compose.height = f->fmt.pix.height;
@@ -6029,7 +6029,7 @@ int atomisp_set_fmt_file(struct video_device *vdev, struct v4l2_format *f)
 	struct atomisp_device *isp = video_get_drvdata(vdev);
 	struct atomisp_video_pipe *pipe = atomisp_to_video_pipe(vdev);
 	struct atomisp_sub_device *asd = pipe->asd;
-	struct v4l2_mbus_framefmt ffmt = {0};
+	struct v4l2_mbus_framefmt ffmt = {};
 	const struct atomisp_format_bridge *format_bridge;
 	struct v4l2_subdev_fh fh;
 	int ret;
@@ -6287,7 +6287,7 @@ int atomisp_s_ae_window(struct atomisp_sub_device *asd,
 {
 	struct atomisp_device *isp = asd->isp;
 	/* Coverity CID 298071 - initialzize struct */
-	struct v4l2_subdev_selection sel = { 0 };
+	struct v4l2_subdev_selection sel = { };
 
 	sel.r.left = arg->x_left;
 	sel.r.top = arg->y_top;
diff --git a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
index 99a632f33d2d..ce3fb5944a99 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
@@ -1028,7 +1028,7 @@ int atomisp_q_video_buffer_to_css(struct atomisp_sub_device *asd,
 				  enum ia_css_pipe_id css_pipe_id)
 {
 	struct atomisp_stream_env *stream_env = &asd->stream_env[stream_id];
-	struct ia_css_buffer css_buf = {0};
+	struct ia_css_buffer css_buf = {};
 	int err;
 
 	css_buf.type = css_buf_type;
@@ -1048,7 +1048,7 @@ int atomisp_q_metadata_buffer_to_css(struct atomisp_sub_device *asd,
 				     enum ia_css_pipe_id css_pipe_id)
 {
 	struct atomisp_stream_env *stream_env = &asd->stream_env[stream_id];
-	struct ia_css_buffer buffer = {0};
+	struct ia_css_buffer buffer = {};
 	struct atomisp_device *isp = asd->isp;
 
 	buffer.type = IA_CSS_BUFFER_TYPE_METADATA;
@@ -1068,7 +1068,7 @@ int atomisp_q_s3a_buffer_to_css(struct atomisp_sub_device *asd,
 				enum ia_css_pipe_id css_pipe_id)
 {
 	struct atomisp_stream_env *stream_env = &asd->stream_env[stream_id];
-	struct ia_css_buffer buffer = {0};
+	struct ia_css_buffer buffer = {};
 	struct atomisp_device *isp = asd->isp;
 
 	buffer.type = IA_CSS_BUFFER_TYPE_3A_STATISTICS;
@@ -1089,7 +1089,7 @@ int atomisp_q_dis_buffer_to_css(struct atomisp_sub_device *asd,
 				enum ia_css_pipe_id css_pipe_id)
 {
 	struct atomisp_stream_env *stream_env = &asd->stream_env[stream_id];
-	struct ia_css_buffer buffer = {0};
+	struct ia_css_buffer buffer = {};
 	struct atomisp_device *isp = asd->isp;
 
 	buffer.type = IA_CSS_BUFFER_TYPE_DIS_STATISTICS;
diff --git a/drivers/staging/media/atomisp/pci/atomisp_fops.c b/drivers/staging/media/atomisp/pci/atomisp_fops.c
index f82bf082aa79..874c9f964d08 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_fops.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_fops.c
@@ -898,7 +898,7 @@ static int atomisp_release(struct file *file)
 	bool acc_node;
 	struct v4l2_requestbuffers req;
 	struct v4l2_subdev_fh fh;
-	struct v4l2_rect clear_compose = {0};
+	struct v4l2_rect clear_compose = {};
 	int ret = 0;
 
 	v4l2_fh_init(&fh.vfh, vdev);
@@ -961,7 +961,7 @@ static int atomisp_release(struct file *file)
 	 * get released.
 	 */
 	if (!isp->sw_contex.file_input && asd->fmt_auto->val) {
-		struct v4l2_mbus_framefmt isp_sink_fmt = { 0 };
+		struct v4l2_mbus_framefmt isp_sink_fmt = { };
 
 		atomisp_subdev_set_ffmt(&asd->subdev, fh.state,
 					V4L2_SUBDEV_FORMAT_ACTIVE,
@@ -973,7 +973,7 @@ static int atomisp_release(struct file *file)
 
 	/* clear the sink pad for file input */
 	if (isp->sw_contex.file_input && asd->fmt_auto->val) {
-		struct v4l2_mbus_framefmt isp_sink_fmt = { 0 };
+		struct v4l2_mbus_framefmt isp_sink_fmt = { };
 
 		atomisp_subdev_set_ffmt(&asd->subdev, fh.state,
 					V4L2_SUBDEV_FORMAT_ACTIVE,
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index c8a625667e81..14a30a28f5b7 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -761,7 +761,7 @@ static int atomisp_enum_fmt_cap(struct file *file, void *fh,
 	struct video_device *vdev = video_devdata(file);
 	struct atomisp_device *isp = video_get_drvdata(vdev);
 	struct atomisp_sub_device *asd = atomisp_to_video_pipe(vdev)->asd;
-	struct v4l2_subdev_mbus_code_enum code = { 0 };
+	struct v4l2_subdev_mbus_code_enum code = { };
 	unsigned int i, fi = 0;
 	int rval;
 
@@ -1589,7 +1589,7 @@ static void __wdt_on_master_slave_sensor_pipe(struct atomisp_video_pipe *pipe,
 
 static void atomisp_pause_buffer_event(struct atomisp_device *isp)
 {
-	struct v4l2_event event = {0};
+	struct v4l2_event event = {};
 	int i;
 
 	event.type = V4L2_EVENT_ATOMISP_PAUSE_BUFFER;
@@ -2623,7 +2623,7 @@ static int atomisp_s_parm(struct file *file, void *fh,
 	asd->high_speed_mode = false;
 	switch (parm->parm.capture.capturemode) {
 	case CI_MODE_NONE: {
-		struct v4l2_subdev_frame_interval fi = {0};
+		struct v4l2_subdev_frame_interval fi = {};
 
 		fi.interval = parm->parm.capture.timeperframe;
 
diff --git a/drivers/staging/media/atomisp/pci/atomisp_subdev.c b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
index 12f22ad007c7..4a2adb290b4f 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_subdev.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_subdev.c
@@ -318,7 +318,7 @@ static void isp_subdev_propagate(struct v4l2_subdev *sd,
 
 	switch (pad) {
 	case ATOMISP_SUBDEV_PAD_SINK: {
-		struct v4l2_rect r = {0};
+		struct v4l2_rect r = {};
 
 		/* Only crop target supported on sink pad. */
 		r.width = ffmt[pad]->width;
@@ -579,7 +579,7 @@ static int isp_subdev_set_selection(struct v4l2_subdev *sd,
 
 static int atomisp_get_sensor_bin_factor(struct atomisp_sub_device *asd)
 {
-	struct v4l2_control ctrl = {0};
+	struct v4l2_control ctrl = {};
 	struct atomisp_device *isp = asd->isp;
 	int hbin, vbin;
 	int ret;
diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
index dbd3bfe3d343..9156b9e696ea 100644
--- a/drivers/staging/media/atomisp/pci/sh_css_params.c
+++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
@@ -3663,7 +3663,7 @@ sh_css_params_write_to_ddr_internal(
 
 			/* Generate default DVS unity table on start up*/
 			if (!params->pipe_dvs_6axis_config[pipe_id]) {
-				struct ia_css_resolution dvs_offset = {0};
+				struct ia_css_resolution dvs_offset = {};
 
 				if (!IS_ISP2401) {
 					dvs_offset.width = (PIX_SHIFT_FILTER_RUN_IN_X + binary->dvs_envelope.width) / 2;
diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 9de0ebd439dc..4c71d5e59fbe 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -302,7 +302,7 @@ static void csi2ipu_gasket_init(struct csi2_dev *csi2)
 
 static int csi2_get_active_lanes(struct csi2_dev *csi2, unsigned int *lanes)
 {
-	struct v4l2_mbus_config mbus_config = { 0 };
+	struct v4l2_mbus_config mbus_config = { };
 	unsigned int num_lanes = UINT_MAX;
 	int ret;
 
diff --git a/drivers/staging/media/ipu3/ipu3-css-pool.c b/drivers/staging/media/ipu3/ipu3-css-pool.c
index fa5b7d3acef2..e3eaccf83b76 100644
--- a/drivers/staging/media/ipu3/ipu3-css-pool.c
+++ b/drivers/staging/media/ipu3/ipu3-css-pool.c
@@ -88,7 +88,7 @@ void imgu_css_pool_put(struct imgu_css_pool *pool)
 const struct imgu_css_map *
 imgu_css_pool_last(struct imgu_css_pool *pool, unsigned int n)
 {
-	static const struct imgu_css_map null_map = { 0 };
+	static const struct imgu_css_map null_map = { };
 	int i = (pool->last + IPU3_CSS_POOL_SIZE - n) % IPU3_CSS_POOL_SIZE;
 
 	WARN_ON(n >= IPU3_CSS_POOL_SIZE);
diff --git a/drivers/staging/media/ipu3/ipu3-v4l2.c b/drivers/staging/media/ipu3/ipu3-v4l2.c
index 38a240764509..1cde355eed02 100644
--- a/drivers/staging/media/ipu3/ipu3-v4l2.c
+++ b/drivers/staging/media/ipu3/ipu3-v4l2.c
@@ -1113,8 +1113,8 @@ static int imgu_v4l2_node_setup(struct imgu_device *imgu, unsigned int pipe,
 {
 	int r;
 	u32 flags;
-	struct v4l2_mbus_framefmt def_bus_fmt = { 0 };
-	struct v4l2_pix_format_mplane def_pix_fmt = { 0 };
+	struct v4l2_mbus_framefmt def_bus_fmt = { };
+	struct v4l2_pix_format_mplane def_pix_fmt = { };
 	struct device *dev = &imgu->pci_dev->dev;
 	struct imgu_media_pipe *imgu_pipe = &imgu->imgu_pipe[pipe];
 	struct v4l2_subdev *sd = &imgu_pipe->imgu_sd.subdev;
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index b9125c295d1d..783c43ea8884 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -357,7 +357,7 @@ void amvdec_dst_buf_done_offset(struct amvdec_session *sess,
 	struct device *dev = sess->core->dev_dec;
 	struct amvdec_timestamp *match = NULL;
 	struct amvdec_timestamp *tmp, *n;
-	struct v4l2_timecode timecode = { 0 };
+	struct v4l2_timecode timecode = { };
 	u64 timestamp = 0;
 	u32 vbuf_flags = 0;
 	unsigned long flags;
diff --git a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
index 0fd11aca7ac7..48ae95e3d56b 100644
--- a/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
+++ b/drivers/staging/r8188eu/hal/HalPwrSeqCmd.c
@@ -28,7 +28,7 @@ Major Change History:
 u8 HalPwrSeqCmdParsing(struct adapter *padapter, u8 cut_vers, u8 fab_vers,
 		       u8 ifacetype, struct wl_pwr_cfg pwrseqcmd[])
 {
-	struct wl_pwr_cfg pwrcfgcmd = {0};
+	struct wl_pwr_cfg pwrcfgcmd = {};
 	u8 poll_bit = false;
 	u32 aryidx = 0;
 	u8 value = 0;
diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 1b184d5c6b82..1d6dadc5a81e 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1497,7 +1497,7 @@ static int get_num_cameras(struct vchiq_mmal_instance *instance,
 {
 	int ret;
 	struct vchiq_mmal_component  *cam_info_component;
-	struct mmal_parameter_camera_info cam_info = {0};
+	struct mmal_parameter_camera_info cam_info = {};
 	u32 param_size = sizeof(cam_info);
 	int i;
 
diff --git a/drivers/staging/vt6655/dpc.c b/drivers/staging/vt6655/dpc.c
index 2d06cecc0307..54802a0092b9 100644
--- a/drivers/staging/vt6655/dpc.c
+++ b/drivers/staging/vt6655/dpc.c
@@ -25,7 +25,7 @@ static bool vnt_rx_data(struct vnt_private *priv, struct sk_buff *skb,
 {
 	struct ieee80211_hw *hw = priv->hw;
 	struct ieee80211_supported_band *sband;
-	struct ieee80211_rx_status rx_status = { 0 };
+	struct ieee80211_rx_status rx_status = { };
 	struct ieee80211_hdr *hdr;
 	__le16 fc;
 	u8 *rsr, *new_rsr, *rssi;
diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 07f36ac834c8..88607854fabd 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -166,7 +166,7 @@ static u32 put_ta_refcount(u32 ta_handle)
 
 int handle_unload_ta(u32 ta_handle)
 {
-	struct tee_cmd_unload_ta cmd = {0};
+	struct tee_cmd_unload_ta cmd = {};
 	u32 status, count;
 	int ret;
 
@@ -202,7 +202,7 @@ int handle_unload_ta(u32 ta_handle)
 
 int handle_close_session(u32 ta_handle, u32 info)
 {
-	struct tee_cmd_close_session cmd = {0};
+	struct tee_cmd_close_session cmd = {};
 	u32 status;
 	int ret;
 
@@ -224,7 +224,7 @@ int handle_close_session(u32 ta_handle, u32 info)
 
 void handle_unmap_shmem(u32 buf_id)
 {
-	struct tee_cmd_unmap_shared_mem cmd = {0};
+	struct tee_cmd_unmap_shared_mem cmd = {};
 	u32 status;
 	int ret;
 
@@ -240,7 +240,7 @@ void handle_unmap_shmem(u32 buf_id)
 int handle_invoke_cmd(struct tee_ioctl_invoke_arg *arg, u32 sinfo,
 		      struct tee_param *p)
 {
-	struct tee_cmd_invoke_cmd cmd = {0};
+	struct tee_cmd_invoke_cmd cmd = {};
 	int ret;
 
 	if (!arg || (!p && arg->num_params))
@@ -351,7 +351,7 @@ int handle_map_shmem(u32 count, struct shmem_desc *start, u32 *buf_id)
 int handle_open_session(struct tee_ioctl_open_session_arg *arg, u32 *info,
 			struct tee_param *p)
 {
-	struct tee_cmd_open_session cmd = {0};
+	struct tee_cmd_open_session cmd = {};
 	int ret;
 
 	if (!arg || !info || (!p && arg->num_params))
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 0fb5e04191e2..406f9afa3e77 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -232,7 +232,7 @@ static struct tb_cfg_result decode_error(const struct ctl_pkg *response)
 {
 	struct cfg_error_pkg *pkg = response->buffer;
 	struct tb_ctl *ctl = response->ctl;
-	struct tb_cfg_result res = { 0 };
+	struct tb_cfg_result res = { };
 	res.response_route = tb_cfg_get_route(&pkg->header);
 	res.response_port = 0;
 	res.err = check_header(response, sizeof(*pkg), TB_CFG_PKG_ERROR,
@@ -258,7 +258,7 @@ static struct tb_cfg_result parse_header(const struct ctl_pkg *pkg, u32 len,
 					 enum tb_cfg_pkg_type type, u64 route)
 {
 	struct tb_cfg_header *header = pkg->buffer;
-	struct tb_cfg_result res = { 0 };
+	struct tb_cfg_result res = { };
 
 	if (pkg->frame.eof == TB_CFG_PKG_ERROR)
 		return decode_error(pkg);
@@ -592,7 +592,7 @@ struct tb_cfg_result tb_cfg_request_sync(struct tb_ctl *ctl,
 					 int timeout_msec)
 {
 	unsigned long timeout = msecs_to_jiffies(timeout_msec);
-	struct tb_cfg_result res = { 0 };
+	struct tb_cfg_result res = { };
 	DECLARE_COMPLETION_ONSTACK(done);
 	int ret;
 
@@ -815,7 +815,7 @@ static bool tb_cfg_copy(struct tb_cfg_request *req, const struct ctl_pkg *pkg)
 struct tb_cfg_result tb_cfg_reset(struct tb_ctl *ctl, u64 route)
 {
 	struct cfg_reset_pkg request = { .header = tb_cfg_make_header(route) };
-	struct tb_cfg_result res = { 0 };
+	struct tb_cfg_result res = { };
 	struct tb_cfg_header reply;
 	struct tb_cfg_request *req;
 
@@ -858,7 +858,7 @@ struct tb_cfg_result tb_cfg_read_raw(struct tb_ctl *ctl, void *buffer,
 		u64 route, u32 port, enum tb_cfg_space space,
 		u32 offset, u32 length, int timeout_msec)
 {
-	struct tb_cfg_result res = { 0 };
+	struct tb_cfg_result res = { };
 	struct cfg_read_pkg request = {
 		.header = tb_cfg_make_header(route),
 		.addr = {
@@ -929,7 +929,7 @@ struct tb_cfg_result tb_cfg_write_raw(struct tb_ctl *ctl, const void *buffer,
 		u64 route, u32 port, enum tb_cfg_space space,
 		u32 offset, u32 length, int timeout_msec)
 {
-	struct tb_cfg_result res = { 0 };
+	struct tb_cfg_result res = { };
 	struct cfg_write_pkg request = {
 		.header = tb_cfg_make_header(route),
 		.addr = {
diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
index 564e2f42cebd..39fdcb8ebde9 100644
--- a/drivers/thunderbolt/path.c
+++ b/drivers/thunderbolt/path.c
@@ -511,7 +511,7 @@ int tb_path_activate(struct tb_path *path)
 
 	/* Activate hops. */
 	for (i = path->path_length - 1; i >= 0; i--) {
-		struct tb_regs_hop hop = { 0 };
+		struct tb_regs_hop hop = { };
 
 		/* If it is left active deactivate it first */
 		__tb_path_deactivate_hop(path->hops[i].in_port,
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e11383ae1e7e..7bbe68532147 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -471,7 +471,7 @@ static struct vio_version vcc_versions[] = {
 	{ .major = 1, .minor = 0 },
 };
 
-static struct tty_port_operations vcc_port_ops = { 0 };
+static struct tty_port_operations vcc_port_ops = { };
 
 static ssize_t domain_show(struct device *dev,
 			   struct device_attribute *attr,
diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c
index 2d4176f5788e..7ca590b8301a 100644
--- a/drivers/usb/dwc2/drd.c
+++ b/drivers/usb/dwc2/drd.c
@@ -119,7 +119,7 @@ static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
 
 int dwc2_drd_init(struct dwc2_hsotg *hsotg)
 {
-	struct usb_role_switch_desc role_sw_desc = {0};
+	struct usb_role_switch_desc role_sw_desc = {};
 	struct usb_role_switch *role_sw;
 	int ret;
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 804b50548163..4fda02b297d5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2766,7 +2766,7 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	union power_supply_propval	val = {0};
+	union power_supply_propval	val = {};
 	int				ret;
 
 	if (dwc->usb2_phy)
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 89f1f8c9f02e..1524d179c316 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -576,7 +576,7 @@ static void s3c_hsudc_process_req_status(struct s3c_hsudc *hsudc,
 static void s3c_hsudc_process_setup(struct s3c_hsudc *hsudc)
 {
 	struct s3c_hsudc_ep *hsep = &hsudc->ep[0];
-	struct usb_ctrlrequest ctrl = {0};
+	struct usb_ctrlrequest ctrl = {};
 	int ret;
 
 	s3c_hsudc_nuke_ep(hsep, -EPROTO);
diff --git a/drivers/usb/host/xhci-ext-caps.c b/drivers/usb/host/xhci-ext-caps.c
index 7a4c2c4ad50e..d47b4e9c84e9 100644
--- a/drivers/usb/host/xhci-ext-caps.c
+++ b/drivers/usb/host/xhci-ext-caps.c
@@ -31,7 +31,7 @@ static int xhci_create_intel_xhci_sw_pdev(struct xhci_hcd *xhci, u32 cap_offset)
 	struct device *dev = hcd->self.controller;
 	struct platform_device *pdev;
 	struct pci_dev *pci = to_pci_dev(dev);
-	struct resource	res = { 0, };
+	struct resource	res = { };
 	int ret;
 
 	pdev = platform_device_alloc(USB_SW_DRV_NAME, PLATFORM_DEVID_NONE);
diff --git a/drivers/usb/mtu3/mtu3_dr.c b/drivers/usb/mtu3/mtu3_dr.c
index a6b04831b20b..ef2e0e6957a7 100644
--- a/drivers/usb/mtu3/mtu3_dr.c
+++ b/drivers/usb/mtu3/mtu3_dr.c
@@ -278,7 +278,7 @@ static enum usb_role ssusb_role_sw_get(struct usb_role_switch *sw)
 
 static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
 {
-	struct usb_role_switch_desc role_sx_desc = { 0 };
+	struct usb_role_switch_desc role_sx_desc = { };
 	struct ssusb_mtk *ssusb = otg_sx_to_ssusb(otg_sx);
 	struct device *dev = ssusb->dev;
 	enum usb_dr_mode mode;
diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index 6b92d037d8fc..42e8c2499ebb 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -181,7 +181,7 @@ static enum usb_role musb_usb_role_sx_get(struct usb_role_switch *sw)
 
 static int mtk_otg_switch_init(struct mtk_glue *glue)
 {
-	struct usb_role_switch_desc role_sx_desc = { 0 };
+	struct usb_role_switch_desc role_sx_desc = { };
 
 	role_sx_desc.set = musb_usb_role_sx_set;
 	role_sx_desc.get = musb_usb_role_sx_get;
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 68198e0f2a63..fe2c7030a2e0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -928,7 +928,7 @@ long vfio_pci_core_ioctl(struct vfio_device *core_vdev, unsigned int cmd,
 
 	} else if (cmd == VFIO_DEVICE_GET_PCI_HOT_RESET_INFO) {
 		struct vfio_pci_hot_reset_info hdr;
-		struct vfio_pci_fill_info fill = { 0 };
+		struct vfio_pci_fill_info fill = { };
 		struct vfio_pci_dependent_device *devices = NULL;
 		bool slot = false;
 		int ret = 0;
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0e9217687f5c..f0f40c334972 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -2936,7 +2936,7 @@ static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
 				      unsigned long arg)
 {
 	struct vfio_iommu_type1_dma_unmap unmap;
-	struct vfio_bitmap bitmap = { 0 };
+	struct vfio_bitmap bitmap = { };
 	uint32_t mask = VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP |
 			VFIO_DMA_UNMAP_FLAG_VADDR |
 			VFIO_DMA_UNMAP_FLAG_ALL;
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 1aef3d6ebd88..d921c6c61275 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -1856,7 +1856,7 @@ static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 #if defined(DEBUG) && defined(CONFIG_FB_ATY_CT)
 	case ATYIO_CLKR:
 		if (M64_HAS(INTEGRATED)) {
-			struct atyclk clk = { 0 };
+			struct atyclk clk = { };
 			union aty_pll *pll = &par->pll;
 			u32 dsp_config = pll->ct.dsp_config;
 			u32 dsp_on_off = pll->ct.dsp_on_off;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index d43b081d592f..4c3f598055c0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -4372,7 +4372,7 @@ static void print_dispc_vm(const char *str, const struct omap_video_timings *t)
 static void print_dsi_dispc_vm(const char *str,
 		const struct omap_dss_dsi_videomode_timings *t)
 {
-	struct omap_video_timings vm = { 0 };
+	struct omap_video_timings vm = { };
 	unsigned long byteclk = t->hsclk / 4;
 	unsigned long pck;
 	u64 dsi_tput;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
index 800bd108e834..edb7a6af0897 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
@@ -147,7 +147,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	struct omap_video_timings *p;
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
 	struct hdmi_wp_data *wp = &hdmi.wp;
-	struct dss_pll_clock_info hdmi_cinfo = { 0 };
+	struct dss_pll_clock_info hdmi_cinfo = { };
 
 	r = hdmi_power_on_core(dssdev);
 	if (r)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
index e6363a420933..a0643d37dd95 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
@@ -303,7 +303,7 @@ void hdmi4_configure(struct hdmi_core_data *core,
 	struct hdmi_video_format video_format;
 	/* HDMI core */
 	struct hdmi_core_video_config v_core_cfg;
-	struct hdmi_core_packet_enable_repeat repeat_cfg = { 0 };
+	struct hdmi_core_packet_enable_repeat repeat_cfg = { };
 
 	hdmi_core_init(&v_core_cfg);
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
index 2c03608addcd..29f0e209b20e 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
@@ -163,7 +163,7 @@ static int hdmi_power_on_full(struct omap_dss_device *dssdev)
 	int r;
 	struct omap_video_timings *p;
 	struct omap_overlay_manager *mgr = hdmi.output.manager;
-	struct dss_pll_clock_info hdmi_cinfo = { 0 };
+	struct dss_pll_clock_info hdmi_cinfo = { };
 
 	r = hdmi_power_on_core(dssdev);
 	if (r)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index cb63bc0e92ca..dd2a0366e593 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -496,7 +496,7 @@ static void hdmi_core_csc_config(struct hdmi_core_data *core,
 
 static void hdmi_core_configure_range(struct hdmi_core_data *core)
 {
-	struct csc_table csc_coeff = { 0 };
+	struct csc_table csc_coeff = { };
 
 	/* support limited range with 24 bit color depth for now */
 	csc_coeff = csc_table_deepcolor[0];
diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index bfac3ee4a642..0b334a7ce334 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -612,7 +612,7 @@ static void ufx_calc_pll_values(const u32 clk_pixel_pll, struct pll_values *asic
 /* sets analog bit PLL configuration values */
 static int ufx_config_pix_clk(struct ufx_data *dev, u32 pixclock)
 {
-	struct pll_values asic_pll = {0};
+	struct pll_values asic_pll = {};
 	u32 value, clk_pixel, clk_pixel_pll;
 	int status;
 
@@ -1554,7 +1554,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
 	/* If everything else has failed, fall back to safe default mode */
 	if (default_vmode == NULL) {
 
-		struct fb_videomode fb_vmode = {0};
+		struct fb_videomode fb_vmode = {};
 
 		/* Add the standard VESA modes to our modelist
 		 * Since we don't have EDID, there may be modes that
diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
index 50111966c981..8526a48e80bb 100644
--- a/drivers/video/fbdev/tmiofb.c
+++ b/drivers/video/fbdev/tmiofb.c
@@ -506,7 +506,7 @@ static int tmiofb_ioctl(struct fb_info *fbi,
 {
 	switch (cmd) {
 	case FBIOGET_VBLANK: {
-		struct fb_vblank vblank = {0};
+		struct fb_vblank vblank = {};
 		void __user *argp = (void __user *) arg;
 
 		tmiofb_vblank(fbi, &vblank);
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index b9cdd02c1000..45803c613e42 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1371,7 +1371,7 @@ static int dlfb_setup_modes(struct dlfb_data *dlfb,
 	/* If everything else has failed, fall back to safe default mode */
 	if (default_vmode == NULL) {
 
-		struct fb_videomode fb_vmode = {0};
+		struct fb_videomode fb_vmode = {};
 
 		/*
 		 * Add the standard VESA modes to our modelist
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 72eaef2caeb1..f2c6eb9b843b 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -143,7 +143,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	struct virtqueue *vq;
 	u64 desc_addr, driver_addr, device_addr;
 	/* Assume split virtqueue, switch to packed if necessary */
-	struct vdpa_vq_state state = {0};
+	struct vdpa_vq_state state = {};
 	unsigned long flags;
 	u32 align, num;
 	int err;
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index a78704ae3618..cb90c8bbb310 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1706,7 +1706,7 @@ static void __xen_evtchn_do_upcall(void)
 {
 	struct vcpu_info *vcpu_info = __this_cpu_read(xen_vcpu);
 	int cpu = smp_processor_id();
-	struct evtchn_loop_ctrl ctrl = { 0 };
+	struct evtchn_loop_ctrl ctrl = { };
 
 	read_lock(&evtchn_rwlock);
 
diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index df7cab870be5..e1b05986a934 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -329,7 +329,7 @@ read_acpi_id(acpi_handle handle, u32 lvl, void *context, void **rv)
 	acpi_status status;
 	acpi_object_type acpi_type;
 	unsigned long long tmp;
-	union acpi_object object = { 0 };
+	union acpi_object object = { };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	acpi_io_address pblk = 0;
 
diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index c381499f5416..6d48abc81ba1 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -280,7 +280,7 @@ static int v9fs_xattr_set_acl(const struct xattr_handler *handler,
 	switch (handler->flags) {
 	case ACL_TYPE_ACCESS:
 		if (acl) {
-			struct iattr iattr = { 0 };
+			struct iattr iattr = { };
 			struct posix_acl *old_acl = acl;
 
 			retval = posix_acl_update_mode(&init_user_ns, inode,
diff --git a/fs/btrfs/check-integrity.c b/fs/btrfs/check-integrity.c
index 86816088927f..2477b711aaed 100644
--- a/fs/btrfs/check-integrity.c
+++ b/fs/btrfs/check-integrity.c
@@ -884,7 +884,7 @@ static noinline_for_stack int btrfsic_process_metablock(
 		struct btrfsic_block_data_ctx *const first_block_ctx,
 		int first_limit_nesting, int force_iodone_flag)
 {
-	struct btrfsic_stack_frame initial_stack_frame = { 0 };
+	struct btrfsic_stack_frame initial_stack_frame = { };
 	struct btrfsic_stack_frame *sf;
 	struct btrfsic_stack_frame *next_stack;
 	struct btrfs_header *const first_hdr =
@@ -2107,7 +2107,7 @@ static int btrfsic_process_written_superblock(
 		int num_copies;
 		int mirror_num;
 		const char *additional_string = NULL;
-		struct btrfs_disk_key tmp_disk_key = {0};
+		struct btrfs_disk_key tmp_disk_key = {};
 
 		btrfs_set_disk_key_objectid(&tmp_disk_key,
 					    BTRFS_ROOT_ITEM_KEY);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fc3da7585fb7..fb4b6e2bf3af 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2394,7 +2394,7 @@ static int __btrfs_mod_ref(struct btrfs_trans_handle *trans,
 	u32 nritems;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_ref generic_ref = { 0 };
+	struct btrfs_ref generic_ref = { };
 	bool for_reloc = btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC);
 	int i;
 	int action;
@@ -3283,7 +3283,7 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			   u64 parent, int last_ref)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_ref generic_ref = { 0 };
+	struct btrfs_ref generic_ref = { };
 	int ret;
 
 	btrfs_init_generic_ref(&generic_ref, BTRFS_DROP_DELAYED_REF,
@@ -4125,7 +4125,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	int ret = 0;
 	int cache_block_group_error = 0;
 	struct btrfs_block_group *block_group = NULL;
-	struct find_free_extent_ctl ffe_ctl = {0};
+	struct find_free_extent_ctl ffe_ctl = {};
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
 	bool for_treelog = (root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
@@ -4649,7 +4649,7 @@ int btrfs_alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
 				     u64 offset, u64 ram_bytes,
 				     struct btrfs_key *ins)
 {
-	struct btrfs_ref generic_ref = { 0 };
+	struct btrfs_ref generic_ref = { };
 
 	BUG_ON(root->root_key.objectid == BTRFS_TREE_LOG_OBJECTID);
 
@@ -4790,7 +4790,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
 	struct btrfs_block_rsv *block_rsv;
 	struct extent_buffer *buf;
 	struct btrfs_delayed_extent_op *extent_op;
-	struct btrfs_ref generic_ref = { 0 };
+	struct btrfs_ref generic_ref = { };
 	u64 flags = 0;
 	int ret;
 	u32 blocksize = fs_info->nodesize;
@@ -5093,7 +5093,7 @@ static noinline int do_walk_down(struct btrfs_trans_handle *trans,
 	u64 parent;
 	struct btrfs_key key;
 	struct btrfs_key first_key;
-	struct btrfs_ref ref = { 0 };
+	struct btrfs_ref ref = { };
 	struct extent_buffer *next;
 	int level = wc->level;
 	int reada = 0;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index aaddd7225348..7fb1204e7100 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2978,7 +2978,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 	struct bio_vec *bvec;
 	struct btrfs_io_bio *io_bio = btrfs_io_bio(bio);
 	struct extent_io_tree *tree, *failure_tree;
-	struct processed_extent processed = { 0 };
+	struct processed_extent processed = { };
 	/*
 	 * The offset to the beginning of a bio, since one bio can never be
 	 * larger than UINT_MAX, u32 here is enough.
@@ -5139,7 +5139,7 @@ int extent_writepages(struct address_space *mapping,
 
 void extent_readahead(struct readahead_control *rac)
 {
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = { };
 	struct page *pagepool[16];
 	struct extent_map *em_cached = NULL;
 	u64 prev_em_start = (u64)-1;
@@ -5480,7 +5480,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
 	struct extent_state *cached_state = NULL;
 	struct btrfs_path *path;
 	struct btrfs_root *root = inode->root;
-	struct fiemap_cache cache = { 0 };
+	struct fiemap_cache cache = { };
 	struct ulist *roots;
 	struct ulist *tmp_ulist;
 	int end = 0;
@@ -6453,7 +6453,7 @@ static int read_extent_buffer_subpage(struct extent_buffer *eb, int wait,
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct extent_io_tree *io_tree;
 	struct page *page = eb->pages[0];
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = { };
 	int ret = 0;
 
 	ASSERT(!test_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags));
@@ -6525,7 +6525,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	int all_uptodate = 1;
 	int num_pages;
 	unsigned long num_reads = 0;
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = { };
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
 		return 0;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7ff577005d0f..ecc50478052c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -693,7 +693,7 @@ int btrfs_drop_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *leaf;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_ref ref = { 0 };
+	struct btrfs_ref ref = { };
 	struct btrfs_key key;
 	struct btrfs_key new_key;
 	u64 ino = btrfs_ino(inode);
@@ -1084,7 +1084,7 @@ int btrfs_mark_extent_written(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_path *path;
 	struct btrfs_file_extent_item *fi;
-	struct btrfs_ref ref = { 0 };
+	struct btrfs_ref ref = { };
 	struct btrfs_key key;
 	struct btrfs_key new_key;
 	u64 bytenr;
@@ -2558,7 +2558,7 @@ static int btrfs_insert_replace_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	int slot;
-	struct btrfs_ref ref = { 0 };
+	struct btrfs_ref ref = { };
 	int ret;
 
 	if (replace_len == 0)
@@ -2645,7 +2645,7 @@ int btrfs_replace_file_extents(struct btrfs_inode *inode,
 			       struct btrfs_replace_extent_info *extent_info,
 			       struct btrfs_trans_handle **trans_out)
 {
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	u64 min_size = btrfs_calc_insert_metadata_size(fs_info, 1);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 487533c35ddb..9f56aea6f624 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -343,7 +343,7 @@ static noinline int cow_file_range_inline(struct btrfs_inode *inode, u64 start,
 					  int compress_type,
 					  struct page **compressed_pages)
 {
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
@@ -2844,7 +2844,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
 	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	u64 ram_bytes = btrfs_stack_file_extent_ram_bytes(stack_fi);
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	int ret;
 
 	path = btrfs_alloc_path();
@@ -4901,7 +4901,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 
 		if (found_extent &&
 		    root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-			struct btrfs_ref ref = { 0 };
+			struct btrfs_ref ref = { };
 
 			bytes_deleted += extent_num_bytes;
 
@@ -5136,7 +5136,7 @@ static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	int ret;
 
 	/*
@@ -8408,7 +8408,7 @@ int btrfs_readpage(struct file *file, struct page *page)
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
 	u64 start = page_offset(page);
 	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
+	struct btrfs_bio_ctrl bio_ctrl = { };
 	int ret;
 
 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 41524f9aeac3..142ef9822242 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3124,7 +3124,7 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 {
 	struct inode *inode = file_inode(file);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct btrfs_ioctl_defrag_range_args range = {0};
+	struct btrfs_ioctl_defrag_range_args range = {};
 	int ret;
 
 	ret = mnt_want_write_file(file);
@@ -4422,7 +4422,7 @@ static long btrfs_ioctl_quota_rescan(struct file *file, void __user *arg)
 static long btrfs_ioctl_quota_rescan_status(struct btrfs_fs_info *fs_info,
 						void __user *arg)
 {
-	struct btrfs_ioctl_quota_rescan_args qsa = {0};
+	struct btrfs_ioctl_quota_rescan_args qsa = {};
 	int ret = 0;
 
 	if (!capable(CAP_SYS_ADMIN))
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index 9b0814318e72..189d5e3e6a50 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -175,7 +175,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	const u64 aligned_end = ALIGN(new_key->offset + datal,
 				      fs_info->sectorsize);
 	struct btrfs_trans_handle *trans = NULL;
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	int ret;
 	struct btrfs_key key;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 914d403b4415..01bbad3cd7d4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1080,7 +1080,7 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 
 	nritems = btrfs_header_nritems(leaf);
 	for (i = 0; i < nritems; i++) {
-		struct btrfs_ref ref = { 0 };
+		struct btrfs_ref ref = { };
 
 		cond_resched();
 		btrfs_item_key_to_cpu(leaf, &key, i);
@@ -1201,7 +1201,7 @@ int replace_path(struct btrfs_trans_handle *trans, struct reloc_control *rc,
 	struct btrfs_fs_info *fs_info = dest->fs_info;
 	struct extent_buffer *eb;
 	struct extent_buffer *parent;
-	struct btrfs_ref ref = { 0 };
+	struct btrfs_ref ref = { };
 	struct btrfs_key key;
 	u64 old_bytenr;
 	u64 new_bytenr;
@@ -2375,7 +2375,7 @@ static int do_relocation(struct btrfs_trans_handle *trans,
 	path->lowest_level = node->level + 1;
 	rc->backref_cache.path[node->level] = node;
 	list_for_each_entry(edge, &node->upper, list[LOWER]) {
-		struct btrfs_ref ref = { 0 };
+		struct btrfs_ref ref = { };
 
 		cond_resched();
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 72f9b865e847..52731449a05c 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1307,7 +1307,7 @@ static int find_extent_clone(struct send_ctx *sctx,
 	u64 flags = 0;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *eb = path->nodes[0];
-	struct backref_ctx backref_ctx = {0};
+	struct backref_ctx backref_ctx = {};
 	struct clone_root *cur_clone_root;
 	struct btrfs_key found_key;
 	struct btrfs_path *tmp_path;
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 7733e8ac0a69..f70b2beb6cc8 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1086,7 +1086,7 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   int slot)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	struct btrfs_root_item ri = { 0 };
+	struct btrfs_root_item ri = { };
 	const u64 valid_root_flags = BTRFS_ROOT_SUBVOL_RDONLY |
 				     BTRFS_ROOT_SUBVOL_DEAD;
 	int ret;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f7efc26aa82a..44b88e8e94da 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -617,7 +617,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 				      struct extent_buffer *eb, int slot,
 				      struct btrfs_key *key)
 {
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int found_type;
 	u64 extent_end;
@@ -742,7 +742,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 			goto out;
 
 		if (ins.objectid > 0) {
-			struct btrfs_ref ref = { 0 };
+			struct btrfs_ref ref = { };
 			u64 csum_start;
 			u64 csum_end;
 			LIST_HEAD(ordered_sums);
@@ -2626,7 +2626,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 			 * those prealloc extents just after replaying them.
 			 */
 			if (S_ISREG(mode)) {
-				struct btrfs_drop_extents_args drop_args = { 0 };
+				struct btrfs_drop_extents_args drop_args = { };
 				struct inode *inode;
 				u64 from;
 
@@ -4326,7 +4326,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 			  struct btrfs_path *path,
 			  struct btrfs_log_ctx *ctx)
 {
-	struct btrfs_drop_extents_args drop_args = { 0 };
+	struct btrfs_drop_extents_args drop_args = { };
 	struct btrfs_root *log = root->log_root;
 	struct btrfs_file_extent_item *fi;
 	struct extent_buffer *leaf;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 0db344807ef1..f9daceb3b4a9 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3046,7 +3046,7 @@ expand_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
 		    char *ref_path)
 {
 	int rc;
-	struct dfs_info3_param referral = {0};
+	struct dfs_info3_param referral = {};
 	char *full_path = NULL, *mdata = NULL;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS)
@@ -3155,7 +3155,7 @@ static int do_dfs_failover(const char *path, const char *full_path, struct cifs_
 		goto out;
 
 	for (;;) {
-		struct dfs_info3_param ref = {0};
+		struct dfs_info3_param ref = {};
 		char *fake_devname = NULL, *mdata = NULL;
 
 		/* Get next DFS target server - if any */
@@ -3425,7 +3425,7 @@ static int is_referral_server(const char *ref_path, struct cifs_sb_info *cifs_sb
 			      struct cifs_tcon *tcon, bool *ref_server)
 {
 	int rc;
-	struct dfs_info3_param ref = {0};
+	struct dfs_info3_param ref = {};
 
 	cifs_dbg(FYI, "%s: ref_path=%s\n", __func__, ref_path);
 
@@ -3463,7 +3463,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	struct cifs_ses *ses = NULL, *root_ses = NULL;
 	struct cifs_tcon *tcon = NULL;
 	int count = 0;
-	uuid_t mount_id = {0};
+	uuid_t mount_id = {};
 	char *ref_path = NULL, *full_path = NULL;
 	char *oldmnt = NULL;
 	bool ref_server = false;
@@ -4146,7 +4146,7 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 	const char *dfs_host;
 	size_t dfs_host_len;
 	char *share = NULL, *prefix = NULL;
-	struct dfs_info3_param ref = {0};
+	struct dfs_info3_param ref = {};
 	bool isroot;
 
 	tree = kzalloc(MAX_TREE_SIZE, GFP_KERNEL);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d0216472f1c6..b261f2d842fe 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1921,7 +1921,7 @@ cifs_write(struct cifsFileInfo *open_file, __u32 pid, const char *write_data,
 	unsigned int xid;
 	struct dentry *dentry = open_file->dentry;
 	struct cifsInodeInfo *cifsi = CIFS_I(d_inode(dentry));
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 
 	cifs_dbg(FYI, "write %zd bytes to offset %lld of %pd\n",
 		 write_size, *offset, dentry);
@@ -4088,7 +4088,7 @@ cifs_read(struct file *file, char *read_data, size_t read_size, loff_t *offset)
 	unsigned int xid;
 	char *cur_offset;
 	struct cifsFileInfo *open_file;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	int buf_type = CIFS_NO_BUFFER;
 	__u32 pid;
 
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 50c01cff4c84..fc796ec2ba89 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -440,7 +440,7 @@ cifs_sfu_type(struct cifs_fattr *fattr, const char *path,
 	struct cifs_tcon *tcon;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	char buf[24];
 	unsigned int bytes_read;
 	char *pbuf;
@@ -815,7 +815,7 @@ cifs_backup_query_path_info(int xid,
 			    FILE_ALL_INFO **data)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	struct cifs_search_info info = {0};
+	struct cifs_search_info info = {};
 	u16 flags;
 	int rc;
 
@@ -921,7 +921,7 @@ cifs_get_inode_info(struct inode **inode,
 	struct tcon_link *tlink;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	bool adjust_tz = false;
-	struct cifs_fattr fattr = {0};
+	struct cifs_fattr fattr = {};
 	bool is_reparse_point = false;
 	FILE_ALL_INFO *data = in_data;
 	FILE_ALL_INFO *tmp_data = NULL;
@@ -1110,7 +1110,7 @@ smb311_posix_get_inode_info(struct inode **inode,
 	struct tcon_link *tlink;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	bool adjust_tz = false;
-	struct cifs_fattr fattr = {0};
+	struct cifs_fattr fattr = {};
 	bool symlink = false;
 	struct smb311_posix_qinfo *data = NULL;
 	int rc = 0;
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index f0a6d63bc08c..1d5d55d5188d 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -297,7 +297,7 @@ cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int oplock = 0;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	int buf_type = CIFS_NO_BUFFER;
 	FILE_ALL_INFO file_info;
 
@@ -341,7 +341,7 @@ cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int oplock = 0;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
@@ -378,7 +378,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	int buf_type = CIFS_NO_BUFFER;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
@@ -439,7 +439,7 @@ smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	struct kvec iov[2];
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 3b83839fc2c2..c31677f501de 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -920,7 +920,7 @@ cifs_unix_dfs_readlink(const unsigned int xid, struct cifs_tcon *tcon,
 {
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	int rc;
-	struct dfs_info3_param referral = {0};
+	struct dfs_info3_param referral = {};
 
 	rc = get_dfs_path(xid, tcon->ses, searchName, nls_codepage, &referral,
 			  0);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index ddc0e8f97872..1f76f6189093 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3618,7 +3618,7 @@ static int smb3_simple_fallocate_write_range(unsigned int xid,
 					     loff_t off, loff_t len,
 					     char *buf)
 {
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	int nbytes;
 	int rc = 0;
 	struct kvec iov[2];
@@ -5258,7 +5258,7 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	int rc = -EPERM;
 	FILE_ALL_INFO *buf = NULL;
-	struct cifs_io_parms io_parms = {0};
+	struct cifs_io_parms io_parms = {};
 	__u32 oplock = 0;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
index ed3d623724cd..d52ea07d0d87 100644
--- a/fs/crypto/policy.c
+++ b/fs/crypto/policy.c
@@ -723,7 +723,7 @@ EXPORT_SYMBOL_GPL(fscrypt_set_context);
 int fscrypt_set_test_dummy_encryption(struct super_block *sb, const char *arg,
 				      struct fscrypt_dummy_policy *dummy_policy)
 {
-	struct fscrypt_key_specifier key_spec = { 0 };
+	struct fscrypt_key_specifier key_spec = { };
 	int version;
 	union fscrypt_policy *policy = NULL;
 	int err;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index b2e86e739d7a..f4d70b5b88a0 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1139,8 +1139,8 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 	loff_t offset = iocb->ki_pos;
 	const loff_t end = offset + count;
 	struct dio *dio;
-	struct dio_submit sdio = { 0, };
-	struct buffer_head map_bh = { 0, };
+	struct dio_submit sdio = { };
+	struct buffer_head map_bh = { };
 	struct blk_plug plug;
 	unsigned long align = offset | iov_iter_alignment(iter);
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 606dee9e08a3..f6e4b197606f 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -626,7 +626,7 @@ static int ext4_ioc_getfsmap(struct super_block *sb,
 			     struct fsmap_head __user *arg)
 {
 	struct getfsmap_info info = { NULL };
-	struct ext4_fsmap_head xhead = {0};
+	struct ext4_fsmap_head xhead = {};
 	struct fsmap_head head;
 	bool aborted = false;
 	int error;
@@ -775,7 +775,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 {
 	struct fiemap fiemap;
 	struct fiemap __user *ufiemap = (struct fiemap __user *) arg;
-	struct fiemap_extent_info fieinfo = { 0, };
+	struct fiemap_extent_info fieinfo = { };
 	struct inode *inode = file_inode(filp);
 	int error;
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f4fd6c246c9a..f4677b914cae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1147,7 +1147,7 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 
 int f2fs_get_block(struct dnode_of_data *dn, pgoff_t index)
 {
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	struct inode *inode = dn->inode;
 
 	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
@@ -1164,7 +1164,7 @@ struct page *f2fs_get_read_data_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct dnode_of_data dn;
 	struct page *page;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	int err;
 
 	page = f2fs_grab_cache_page(mapping, index, for_write);
@@ -1462,7 +1462,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 	int err = 0, ofs = 1;
 	unsigned int ofs_in_node, last_ofs_in_node;
 	blkcnt_t prealloc;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	block_t blkaddr;
 	unsigned int start_pgofs;
 
@@ -2159,7 +2159,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	sector_t last_block_in_file;
 	const unsigned blocksize = blks_to_bytes(inode, 1);
 	struct decompress_io_ctx *dic = NULL;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	bool from_dnode = true;
 	int i;
 	int ret = 0;
@@ -2606,7 +2606,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct page *page = fio->page;
 	struct inode *inode = page->mapping->host;
 	struct dnode_of_data dn;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	struct node_info ni;
 	bool ipu_force = false;
 	int err = 0;
@@ -3281,7 +3281,7 @@ static int prepare_write_begin(struct f2fs_sb_info *sbi,
 	struct dnode_of_data dn;
 	struct page *ipage;
 	bool locked = false;
-	struct extent_info ei = {0, };
+	struct extent_info ei = {};
 	int err = 0;
 	int flag;
 
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a135d2247415..51776e0f087b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1358,7 +1358,7 @@ static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
 	struct discard_cmd *dc;
-	struct discard_info di = {0};
+	struct discard_info di = {};
 	struct rb_node **insert_p = NULL, *insert_parent = NULL;
 	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int max_discard_blocks =
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 504e69578112..c459603c5ed1 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(fiemap_prep);
 static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 {
 	struct fiemap fiemap;
-	struct fiemap_extent_info fieinfo = { 0, };
+	struct fiemap_extent_info fieinfo = { };
 	struct inode *inode = file_inode(filp);
 	int error;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d329ea49fa14..b9a5c01d2e80 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2279,7 +2279,7 @@ static int smb2_create_truncate(struct path *path)
 static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, struct path *path,
 			    struct ksmbd_file *fp)
 {
-	struct xattr_dos_attrib da = {0};
+	struct xattr_dos_attrib da = {};
 	int rc;
 
 	if (!test_share_config_flag(tcon->share_conf,
@@ -5488,7 +5488,7 @@ static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
 
 	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_STORE_DOS_ATTRS) &&
 	    (file_info->CreationTime || file_info->Attributes)) {
-		struct xattr_dos_attrib da = {0};
+		struct xattr_dos_attrib da = {};
 
 		da.version = 4;
 		da.itime = fp->itime;
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index aee28ee6b19c..3a2f059c075d 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1426,8 +1426,8 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct smb_ntsd *pntsd, int len)
 {
 	int rc;
-	struct ndr sd_ndr = {0}, acl_ndr = {0};
-	struct xattr_ntacl acl = {0};
+	struct ndr sd_ndr = {}, acl_ndr = {};
+	struct xattr_ntacl acl = {};
 	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
 	struct inode *inode = d_inode(dentry);
 
@@ -1502,7 +1502,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 	int rc;
 	struct ndr n;
 	struct inode *inode = d_inode(dentry);
-	struct ndr acl_ndr = {0};
+	struct ndr acl_ndr = {};
 	struct xattr_ntacl acl;
 	struct xattr_smb_acl *smb_acl = NULL, *def_smb_acl = NULL;
 	__u8 cmp_hash[XATTR_SD_HASH_SIZE] = {0};
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 4c48d85f6517..d95ca20a38f9 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -924,7 +924,7 @@ static __be32 process_op(int nop, struct svc_rqst *rqstp,
  */
 static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 {
-	struct cb_compound_hdr_arg hdr_arg = { 0 };
+	struct cb_compound_hdr_arg hdr_arg = { };
 	struct cb_compound_hdr_res hdr_res = { NULL };
 	struct cb_process_state cps = {
 		.drc_status = 0,
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1214bb6b7ee..e7adfec54f6d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6060,7 +6060,7 @@ static int _nfs4_do_set_security_label(struct inode *inode,
 		struct nfs4_label *olabel)
 {
 
-	struct iattr sattr = {0};
+	struct iattr sattr = {};
 	struct nfs_server *server = NFS_SERVER(inode);
 	const u32 bitmask[3] = { 0, 0, FATTR4_WORD2_SECURITY_LABEL };
 	struct nfs_setattrargs arg = {
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index f1cc8258d34a..ce0ca50d903f 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -4707,7 +4707,7 @@ int ocfs2_insert_extent(handle_t *handle,
 	int status;
 	int free_records;
 	struct buffer_head *last_eb_bh = NULL;
-	struct ocfs2_insert_type insert = {0, };
+	struct ocfs2_insert_type insert = {};
 	struct ocfs2_extent_rec rec;
 
 	trace_ocfs2_insert_extent_start(
diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
index f660c0dbdb63..301420fd3b3f 100644
--- a/fs/ocfs2/cluster/tcp.c
+++ b/fs/ocfs2/cluster/tcp.c
@@ -1548,7 +1548,7 @@ static void o2net_start_connect(struct work_struct *work)
 	struct o2net_sock_container *sc = NULL;
 	struct o2nm_node *node = NULL, *mynode = NULL;
 	struct socket *sock = NULL;
-	struct sockaddr_in myaddr = {0, }, remoteaddr = {0, };
+	struct sockaddr_in myaddr = {}, remoteaddr = {};
 	int ret = 0, stop;
 	unsigned int timeout;
 	unsigned int nofs_flag;
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 29eaa4544372..75b3fc8f49bc 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -904,7 +904,7 @@ static void do_k_mask(int i, char *unchecked_keyword, __u64 **sane_mask)
 
 int orangefs_debugfs_new_client_mask(void __user *arg)
 {
-	struct dev_mask2_info_s mask2_info = {0};
+	struct dev_mask2_info_s mask2_info = {};
 	int ret;
 
 	ret = copy_from_user(&mask2_info,
@@ -981,7 +981,7 @@ int orangefs_debugfs_new_client_string(void __user *arg)
 
 int orangefs_debugfs_new_debug(void __user *arg)
 {
-	struct dev_mask_info_s mask_info = {0};
+	struct dev_mask_info_s mask_info = {};
 	int ret;
 
 	ret = copy_from_user(&mask_info,
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index fc718f6178f2..d8c5d3821857 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -224,7 +224,7 @@ static void dump_ch(const struct ubifs_ch *ch)
 void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
 {
 	const struct ubifs_inode *ui = ubifs_inode(inode);
-	struct fscrypt_name nm = {0};
+	struct fscrypt_name nm = {};
 	union ubifs_key key;
 	struct ubifs_dent_node *dent, *pdent = NULL;
 	int count = 2;
@@ -1126,7 +1126,7 @@ int dbg_check_dir(struct ubifs_info *c, const struct inode *dir)
 	unsigned int nlink = 2;
 	union ubifs_key key;
 	struct ubifs_dent_node *dent, *pdent = NULL;
-	struct fscrypt_name nm = {0};
+	struct fscrypt_name nm = {};
 	loff_t size = UBIFS_INO_NODE_SZ;
 
 	if (!dbg_is_chk_gen(c))
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 7c61d0ec0159..6ce20e204152 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -498,7 +498,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
 {
 	int fstr_real_len = 0, err = 0;
 	struct fscrypt_name nm;
-	struct fscrypt_str fstr = {0};
+	struct fscrypt_str fstr = {};
 	union ubifs_key key;
 	struct ubifs_dent_node *dent;
 	struct inode *dir = file_inode(file);
@@ -849,7 +849,7 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
 int ubifs_check_dir_empty(struct inode *dir)
 {
 	struct ubifs_info *c = dir->i_sb->s_fs_info;
-	struct fscrypt_name nm = { 0 };
+	struct fscrypt_name nm = { };
 	struct ubifs_dent_node *dent;
 	union ubifs_key key;
 	int err;
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 8ea680dba61e..fc7f3f289f90 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -877,7 +877,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 
 	if (kill_xattrs) {
 		union ubifs_key key;
-		struct fscrypt_name nm = {0};
+		struct fscrypt_name nm = {};
 		struct inode *xino;
 		struct ubifs_dent_node *xent, *pxent = NULL;
 
diff --git a/fs/ubifs/orphan.c b/fs/ubifs/orphan.c
index 4909321d84cf..54d2c62e6748 100644
--- a/fs/ubifs/orphan.c
+++ b/fs/ubifs/orphan.c
@@ -158,7 +158,7 @@ int ubifs_add_orphan(struct ubifs_info *c, ino_t inum)
 	ino_t xattr_inum;
 	union ubifs_key key;
 	struct ubifs_dent_node *xent, *pxent = NULL;
-	struct fscrypt_name nm = {0};
+	struct fscrypt_name nm = {};
 	struct ubifs_orphan *xattr_orphan;
 	struct ubifs_orphan *orphan;
 
diff --git a/fs/ubifs/tnc.c b/fs/ubifs/tnc.c
index 488f3da7a6c6..6ba9edaf8fd8 100644
--- a/fs/ubifs/tnc.c
+++ b/fs/ubifs/tnc.c
@@ -2866,7 +2866,7 @@ int ubifs_tnc_remove_ino(struct ubifs_info *c, ino_t inum)
 {
 	union ubifs_key key1, key2;
 	struct ubifs_dent_node *xent, *pxent = NULL;
-	struct fscrypt_name nm = {0};
+	struct fscrypt_name nm = {};
 
 	dbg_tnc("ino %lu", (unsigned long)inum);
 
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index e4f193eae4b2..39ed06b2f354 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -401,7 +401,7 @@ ssize_t ubifs_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	struct ubifs_inode *host_ui = ubifs_inode(host);
 	struct ubifs_dent_node *xent, *pxent = NULL;
 	int err, len, written = 0;
-	struct fscrypt_name nm = {0};
+	struct fscrypt_name nm = {};
 
 	dbg_gen("ino %lu ('%pd'), buffer size %zd", host->i_ino,
 		dentry, size);
@@ -505,7 +505,7 @@ int ubifs_purge_xattrs(struct inode *host)
 	struct ubifs_info *c = host->i_sb->s_fs_info;
 	struct ubifs_dent_node *xent, *pxent = NULL;
 	struct inode *xino;
-	struct fscrypt_name nm = {0};
+	struct fscrypt_name nm = {};
 	int err;
 
 	if (ubifs_inode(host)->xattr_cnt <= ubifs_xattr_max_cnt(c))
diff --git a/fs/verity/enable.c b/fs/verity/enable.c
index 77e159a0346b..ed0c231b5762 100644
--- a/fs/verity/enable.c
+++ b/fs/verity/enable.c
@@ -49,7 +49,7 @@ static int build_merkle_tree_level(struct file *filp, unsigned int level,
 {
 	struct inode *inode = file_inode(filp);
 	const struct fsverity_operations *vops = inode->i_sb->s_vop;
-	struct file_ra_state ra = { 0 };
+	struct file_ra_state ra = { };
 	unsigned int pending_size = 0;
 	u64 dst_block_num;
 	u64 i;
diff --git a/fs/xfs/libxfs/xfs_da_btree.c b/fs/xfs/libxfs/xfs_da_btree.c
index c062e2c85178..6bc323f3f44b 100644
--- a/fs/xfs/libxfs/xfs_da_btree.c
+++ b/fs/xfs/libxfs/xfs_da_btree.c
@@ -427,7 +427,7 @@ xfs_da3_node_create(
 	struct xfs_da_intnode	*node;
 	struct xfs_trans	*tp = args->trans;
 	struct xfs_mount	*mp = tp->t_mountp;
-	struct xfs_da3_icnode_hdr ichdr = {0};
+	struct xfs_da3_icnode_hdr ichdr = {};
 	struct xfs_buf		*bp;
 	int			error;
 	struct xfs_inode	*dp = args->dp;
diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
index 994ad783d407..d905ec7f87ed 100644
--- a/fs/xfs/libxfs/xfs_ialloc.c
+++ b/fs/xfs/libxfs/xfs_ialloc.c
@@ -2733,7 +2733,7 @@ xfs_ialloc_count_inodes(
 	xfs_agino_t			*count,
 	xfs_agino_t			*freecount)
 {
-	struct xfs_ialloc_count_inodes	ci = {0};
+	struct xfs_ialloc_count_inodes	ci = {};
 	int				error;
 
 	ASSERT(cur->bc_btnum == XFS_BTNUM_INO);
diff --git a/fs/xfs/libxfs/xfs_log_rlimit.c b/fs/xfs/libxfs/xfs_log_rlimit.c
index 67798ff5e14e..9f0a19e22981 100644
--- a/fs/xfs/libxfs/xfs_log_rlimit.c
+++ b/fs/xfs/libxfs/xfs_log_rlimit.c
@@ -81,7 +81,7 @@ int
 xfs_log_calc_minimum_size(
 	struct xfs_mount	*mp)
 {
-	struct xfs_trans_res	tres = {0};
+	struct xfs_trans_res	tres = {};
 	int			max_logres;
 	int			min_logblks = 0;
 	int			lsunit = 0;
diff --git a/fs/xfs/libxfs/xfs_refcount.c b/fs/xfs/libxfs/xfs_refcount.c
index e5d767a7fc5d..b95c80f72ec2 100644
--- a/fs/xfs/libxfs/xfs_refcount.c
+++ b/fs/xfs/libxfs/xfs_refcount.c
@@ -799,8 +799,8 @@ xfs_refcount_merge_extents(
 	int			flags,
 	bool			*shape_changed)
 {
-	struct xfs_refcount_irec	left = {0}, cleft = {0};
-	struct xfs_refcount_irec	cright = {0}, right = {0};
+	struct xfs_refcount_irec	left = {}, cleft = {};
+	struct xfs_refcount_irec	cright = {}, right = {};
 	int				error;
 	unsigned long long		ulen;
 	bool				cequal;
diff --git a/fs/xfs/libxfs/xfs_rmap.c b/fs/xfs/libxfs/xfs_rmap.c
index f45929b1b94a..030e8238893e 100644
--- a/fs/xfs/libxfs/xfs_rmap.c
+++ b/fs/xfs/libxfs/xfs_rmap.c
@@ -2730,7 +2730,7 @@ xfs_rmap_has_other_keys(
 	const struct xfs_owner_info	*oinfo,
 	bool				*has_rmap)
 {
-	struct xfs_rmap_irec		low = {0};
+	struct xfs_rmap_irec		low = {};
 	struct xfs_rmap_irec		high;
 	struct xfs_rmap_key_state	rks;
 	int				error;
diff --git a/fs/xfs/scrub/quota.c b/fs/xfs/scrub/quota.c
index d6c1b00a4fc8..b1e2a91638da 100644
--- a/fs/xfs/scrub/quota.c
+++ b/fs/xfs/scrub/quota.c
@@ -171,7 +171,7 @@ STATIC int
 xchk_quota_data_fork(
 	struct xfs_scrub	*sc)
 {
-	struct xfs_bmbt_irec	irec = { 0 };
+	struct xfs_bmbt_irec	irec = { };
 	struct xfs_iext_cursor	icur;
 	struct xfs_quotainfo	*qi = sc->mp->m_quotainfo;
 	struct xfs_ifork	*ifp;
diff --git a/fs/xfs/scrub/repair.c b/fs/xfs/scrub/repair.c
index 8f3cba14ada3..2883a7ede6e3 100644
--- a/fs/xfs/scrub/repair.c
+++ b/fs/xfs/scrub/repair.c
@@ -292,7 +292,7 @@ xrep_alloc_ag_block(
 	xfs_fsblock_t			*fsbno,
 	enum xfs_ag_resv_type		resv)
 {
-	struct xfs_alloc_arg		args = {0};
+	struct xfs_alloc_arg		args = {};
 	xfs_agblock_t			bno;
 	int				error;
 
@@ -477,7 +477,7 @@ xrep_fix_freelist(
 	struct xfs_scrub	*sc,
 	bool			can_shrink)
 {
-	struct xfs_alloc_arg	args = {0};
+	struct xfs_alloc_arg	args = {};
 
 	args.mp = sc->mp;
 	args.tp = sc->tp;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 7aa943edfc02..d12d0f8b9bf6 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -773,7 +773,7 @@ xfs_file_buffered_write(
 		cleared_space = true;
 		goto write_retry;
 	} else if (ret == -ENOSPC && !cleared_space) {
-		struct xfs_icwalk	icw = {0};
+		struct xfs_icwalk	icw = {};
 
 		cleared_space = true;
 		xfs_flush_inodes(ip->i_mount);
diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 48287caad28b..10636c27dce5 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -519,8 +519,8 @@ xfs_getfsmap_rtdev_rtbitmap_query(
 	struct xfs_trans		*tp,
 	struct xfs_getfsmap_info	*info)
 {
-	struct xfs_rtalloc_rec		alow = { 0 };
-	struct xfs_rtalloc_rec		ahigh = { 0 };
+	struct xfs_rtalloc_rec		alow = { };
+	struct xfs_rtalloc_rec		ahigh = { };
 	struct xfs_mount		*mp = tp->t_mountp;
 	int				error;
 
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index f2210d927481..268914f1cb6d 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -1537,7 +1537,7 @@ xfs_blockgc_free_dquots(
 	struct xfs_dquot	*pdqp,
 	unsigned int		iwalk_flags)
 {
-	struct xfs_icwalk	icw = {0};
+	struct xfs_icwalk	icw = {};
 	bool			do_work = false;
 
 	if (!udqp && !gdqp && !pdqp)
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index a4f6f034fb81..f1732946638e 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2621,7 +2621,7 @@ xfs_ifree(
 {
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_perag	*pag;
-	struct xfs_icluster	xic = { 0 };
+	struct xfs_icluster	xic = { };
 	struct xfs_inode_log_item *iip = ip->i_itemp;
 	int			error;
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 0c795dc093ef..88213472413d 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1519,7 +1519,7 @@ xfs_ioc_getbmap(
 	unsigned int		cmd,
 	void			__user *arg)
 {
-	struct getbmapx		bmx = { 0 };
+	struct getbmapx		bmx = { };
 	struct kgetbmap		*buf;
 	size_t			recsize;
 	int			error, i;
@@ -1577,7 +1577,7 @@ xfs_ioc_getfsmap(
 	struct xfs_inode	*ip,
 	struct fsmap_head	__user *arg)
 {
-	struct xfs_fsmap_head	xhead = {0};
+	struct xfs_fsmap_head	xhead = {};
 	struct fsmap_head	head;
 	struct fsmap		*recs;
 	unsigned int		count;
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 67dec11e34c7..0f708d036f38 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -331,7 +331,7 @@ xfs_trans_alloc_empty(
 	struct xfs_mount		*mp,
 	struct xfs_trans		**tpp)
 {
-	struct xfs_trans_res		resv = {0};
+	struct xfs_trans_res		resv = {};
 
 	return xfs_trans_alloc(mp, &resv, 0, 0, XFS_TRANS_NO_WRITECOUNT, tpp);
 }
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 47d9abfbdb55..53ce5a8256f3 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -152,8 +152,8 @@ extern struct btf_id_set name;
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
 #define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 name[1];
-#define BTF_SET_START(name) static struct btf_id_set name = { 0 };
-#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
+#define BTF_SET_START(name) static struct btf_id_set name = { };
+#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { };
 #define BTF_SET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
index efa2f0309f00..5bf64033e7fe 100644
--- a/include/linux/dma/ti-cppi5.h
+++ b/include/linux/dma/ti-cppi5.h
@@ -519,7 +519,7 @@ cppi5_hdesc_get_next_hbdesc(struct cppi5_host_desc_t *desc)
 
 static inline void cppi5_hdesc_reset_hbdesc(struct cppi5_host_desc_t *desc)
 {
-	desc->hdr = (struct cppi5_desc_hdr_t) { 0 };
+	desc->hdr = (struct cppi5_desc_hdr_t) { };
 	desc->next_desc = 0;
 }
 
diff --git a/include/linux/icmpv6.h b/include/linux/icmpv6.h
index 9055cb380ee2..dbbfb11bffe7 100644
--- a/include/linux/icmpv6.h
+++ b/include/linux/icmpv6.h
@@ -57,7 +57,7 @@ void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info);
 #else
 static inline void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 {
-	struct inet6_skb_parm parm = { 0 };
+	struct inet6_skb_parm parm = { };
 	__icmpv6_send(skb_in, type, code, info, &parm);
 }
 #endif
diff --git a/include/net/icmp.h b/include/net/icmp.h
index caddf4a59ad1..89fed2f912f3 100644
--- a/include/net/icmp.h
+++ b/include/net/icmp.h
@@ -48,7 +48,7 @@ void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info);
 #else
 static inline void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
-	struct ip_options opts = { 0 };
+	struct ip_options opts = { };
 	__icmp_send(skb_in, type, code, info, &opts);
 }
 #endif
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c0069ac00e62..2c9ad9d28af6 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -967,7 +967,7 @@ static inline int qdisc_qstats_copy(struct gnet_dump *d, struct Qdisc *sch)
 static inline void qdisc_qstats_qlen_backlog(struct Qdisc *sch,  __u32 *qlen,
 					     __u32 *backlog)
 {
-	struct gnet_stats_queue qstats = { 0 };
+	struct gnet_stats_queue qstats = { };
 	__u32 len = qdisc_qlen_sum(sch);
 
 	__gnet_stats_copy_queue(&qstats, sch->cpu_qstats, &sch->qstats, len);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 047ac4b4703b..8020d2ccf9b1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7922,7 +7922,7 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 	struct bpf_verifier_state *vstate = env->cur_state;
 	struct bpf_func_state *state = vstate->frame[vstate->curframe];
 	struct bpf_reg_state *regs = state->regs, *dst_reg, *src_reg;
-	struct bpf_reg_state *ptr_reg = NULL, off_reg = {0};
+	struct bpf_reg_state *ptr_reg = NULL, off_reg = {};
 	u8 opcode = BPF_OP(insn->code);
 	int err;
 
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index f32320ac02fd..3efbd8d21cc6 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -276,7 +276,7 @@ __weak void arch_unregister_hw_breakpoint(struct perf_event *bp)
  */
 static int __reserve_bp_slot(struct perf_event *bp, u64 bp_type)
 {
-	struct bp_busy_slots slots = {0};
+	struct bp_busy_slots slots = {};
 	enum bp_type_idx type;
 	int weight;
 	int ret;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b348749a9fc6..2f54e8d10101 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1622,11 +1622,11 @@ void __init timekeeping_init(void)
 		persistent_clock_exists = true;
 	} else if (timespec64_to_ns(&wall_time) != 0) {
 		pr_warn("Persistent clock returned invalid value");
-		wall_time = (struct timespec64){0};
+		wall_time = (struct timespec64){};
 	}
 
 	if (timespec64_compare(&wall_time, &boot_offset) < 0)
-		boot_offset = (struct timespec64){0};
+		boot_offset = (struct timespec64){};
 
 	/*
 	 * We want set wall_to_mono, so the following is true:
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index f246b847024e..a79aba450593 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -494,14 +494,14 @@ int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
-	struct kunit_result_stats suite_stats = { 0 };
-	struct kunit_result_stats total_stats = { 0 };
+	struct kunit_result_stats suite_stats = { };
+	struct kunit_result_stats total_stats = { };
 
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
-		struct kunit_result_stats param_stats = { 0 };
+		struct kunit_result_stats param_stats = { };
 		test_case->status = KUNIT_SKIPPED;
 
 		if (test_case->generate_params) {
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index d7ad44f2c8f5..0d9dd3ebeb56 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2728,7 +2728,7 @@ int vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
 {
 	unsigned long long num;
 	char *str, *end;
-	struct printf_spec spec = {0};
+	struct printf_spec spec = {};
 
 	/* Reject out-of-range values early.  Large positive sizes are
 	   used for unknown buffer sizes. */
@@ -3029,7 +3029,7 @@ EXPORT_SYMBOL(sprintf);
  */
 int vbin_printf(u32 *bin_buf, size_t size, const char *fmt, va_list args)
 {
-	struct printf_spec spec = {0};
+	struct printf_spec spec = {};
 	char *str, *end;
 	int width;
 
@@ -3188,7 +3188,7 @@ EXPORT_SYMBOL_GPL(vbin_printf);
  */
 int bstr_printf(char *buf, size_t size, const char *fmt, const u32 *bin_buf)
 {
-	struct printf_spec spec = {0};
+	struct printf_spec spec = {};
 	char *str, *end;
 	const char *args = (const char *)bin_buf;
 
diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 1f5c13257dba..5e991d584d57 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -72,7 +72,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
-	struct damon_addr_range regions[3] = {0,};
+	struct damon_addr_range regions[3] = {};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] = {
 		(struct vm_area_struct) {.vm_start = 10, .vm_end = 20},
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58c1fb2aafa9..48b31200501b 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -128,7 +128,7 @@ static void swap_ranges(struct damon_addr_range *r1,
 static int __damon_va_three_regions(struct vm_area_struct *vma,
 				       struct damon_addr_range regions[3])
 {
-	struct damon_addr_range gap = {0}, first_gap = {0}, second_gap = {0};
+	struct damon_addr_range gap = {}, first_gap = {}, second_gap = {};
 	struct vm_area_struct *last_vma = NULL;
 	unsigned long start = 0;
 	struct rb_root rbroot;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 54879c339024..dcea354d9510 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1867,7 +1867,7 @@ EXPORT_SYMBOL_GPL(memory_failure_queue);
 static void memory_failure_work_func(struct work_struct *work)
 {
 	struct memory_failure_cpu *mf_cpu;
-	struct memory_failure_entry entry = { 0, };
+	struct memory_failure_entry entry = { };
 	unsigned long proc_flags;
 	int gotten;
 
diff --git a/net/bluetooth/ecdh_helper.c b/net/bluetooth/ecdh_helper.c
index 989401f116e9..0c437cc16931 100644
--- a/net/bluetooth/ecdh_helper.c
+++ b/net/bluetooth/ecdh_helper.c
@@ -124,7 +124,7 @@ int set_ecdh_privkey(struct crypto_kpp *tfm, const u8 private_key[32])
 	u8 *buf, *tmp = NULL;
 	unsigned int buf_len;
 	int err;
-	struct ecdh p = {0};
+	struct ecdh p = {};
 
 	if (private_key) {
 		tmp = kmalloc(32, GFP_KERNEL);
diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
index d9a89ddd0331..2b6d9f8b7081 100644
--- a/net/bridge/br_sysfs_br.c
+++ b/net/bridge/br_sysfs_br.c
@@ -34,7 +34,7 @@ static ssize_t store_bridge_parm(struct device *d,
 					    struct netlink_ext_ack *extack))
 {
 	struct net_bridge *br = to_bridge(d);
-	struct netlink_ext_ack extack = {0};
+	struct netlink_ext_ack extack = {};
 	unsigned long val;
 	char *endp;
 	int err;
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 07fa76080512..6a7f3b5bd8e2 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -59,7 +59,7 @@ static BRPORT_ATTR(_name, 0644,					\
 static int store_flag(struct net_bridge_port *p, unsigned long v,
 		      unsigned long mask)
 {
-	struct netlink_ext_ack extack = {0};
+	struct netlink_ext_ack extack = {};
 	unsigned long flags = p->flags;
 	int err;
 
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index b71b1635916e..717386600111 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -171,7 +171,7 @@ static int process_one_ticket(struct ceph_auth_client *ac,
 	struct timespec64 validity;
 	void *tp, *tpend;
 	void **ptp;
-	struct ceph_crypto_key new_session_key = { 0 };
+	struct ceph_crypto_key new_session_key = { };
 	struct ceph_buffer *new_ticket_blob;
 	time64_t new_expires, new_renew_after;
 	u64 new_secret_id;
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 49442cae6f69..f6c1fcce7cef 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -376,7 +376,7 @@ static int
 net_dm_hw_summary_report_fill(struct sk_buff *msg,
 			      const struct net_dm_hw_entries *hw_entries)
 {
-	struct net_dm_alert_msg anc_hdr = { 0 };
+	struct net_dm_alert_msg anc_hdr = { };
 	void *hdr;
 	int rc;
 
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index e491b083b348..c934ad6c32bc 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -164,7 +164,7 @@ ___gnet_stats_copy_basic(const seqcount_t *running,
 			 struct gnet_stats_basic_packed *b,
 			 int type)
 {
-	struct gnet_stats_basic_packed bstats = {0};
+	struct gnet_stats_basic_packed bstats = {};
 
 	__gnet_stats_copy_basic(running, &bstats, cpu, b);
 
@@ -337,7 +337,7 @@ gnet_stats_copy_queue(struct gnet_dump *d,
 		      struct gnet_stats_queue __percpu *cpu_q,
 		      struct gnet_stats_queue *q, __u32 qlen)
 {
-	struct gnet_stats_queue qstats = {0};
+	struct gnet_stats_queue qstats = {};
 
 	__gnet_stats_copy_queue(&qstats, cpu_q, q, qlen);
 
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 616330a16d31..bd52761d1b84 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -181,7 +181,7 @@ static int dsa_port_inherit_brport_flags(struct dsa_port *dp,
 	int flag, err;
 
 	for_each_set_bit(flag, &mask, 32) {
-		struct switchdev_brport_flags flags = {0};
+		struct switchdev_brport_flags flags = {};
 
 		flags.mask = BIT(flag);
 
@@ -204,7 +204,7 @@ static void dsa_port_clear_brport_flags(struct dsa_port *dp)
 	int flag, err;
 
 	for_each_set_bit(flag, &mask, 32) {
-		struct switchdev_brport_flags flags = {0};
+		struct switchdev_brport_flags flags = {};
 
 		flags.mask = BIT(flag);
 		flags.val = val & BIT(flag);
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 662ff531d4e2..ff8c29011f9d 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1362,7 +1362,7 @@ static int dsa_slave_vlan_rx_add_vid(struct net_device *dev, __be16 proto,
 		/* This API only allows programming tagged, non-PVID VIDs */
 		.flags = 0,
 	};
-	struct netlink_ext_ack extack = {0};
+	struct netlink_ext_ack extack = {};
 	int ret;
 
 	/* User port... */
diff --git a/net/dsa/switch.c b/net/dsa/switch.c
index 1c797ec8e2c2..04bd220f5b46 100644
--- a/net/dsa/switch.c
+++ b/net/dsa/switch.c
@@ -117,7 +117,7 @@ static int dsa_switch_bridge_leave(struct dsa_switch *ds,
 				   struct dsa_notifier_bridge_info *info)
 {
 	struct dsa_switch_tree *dst = ds->dst;
-	struct netlink_ext_ack extack = {0};
+	struct netlink_ext_ack extack = {};
 	bool change_vlan_filtering = false;
 	bool vlan_filtering;
 	int err, port;
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index c054f48541c8..ce6a9e39c1ef 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -473,7 +473,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 				   struct net_device *netdev)
 {
 	int source_port = -1, switch_id = -1;
-	struct sja1105_meta meta = {0};
+	struct sja1105_meta meta = {};
 	struct ethhdr *hdr;
 	bool is_link_local;
 	bool is_meta;
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 7e6b37a54add..7c48a9b8d997 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -55,8 +55,8 @@ static int eeprom_fallback(struct eeprom_req_info *request,
 			   struct genl_info *info)
 {
 	struct net_device *dev = reply->base.dev;
-	struct ethtool_modinfo modinfo = {0};
-	struct ethtool_eeprom eeprom = {0};
+	struct ethtool_modinfo modinfo = {};
+	struct ethtool_eeprom eeprom = {};
 	u8 *data;
 	int err;
 
@@ -107,7 +107,7 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 {
 	struct eeprom_reply_data *reply = MODULE_EEPROM_REPDATA(reply_base);
 	struct eeprom_req_info *request = MODULE_EEPROM_REQINFO(req_base);
-	struct ethtool_module_eeprom page_data = {0};
+	struct ethtool_module_eeprom page_data = {};
 	struct net_device *dev = reply_base->dev;
 	int ret;
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index f4468980b675..06cd11d230d8 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -156,7 +156,7 @@ struct net_device *__ip_dev_find(struct net *net, __be32 addr, bool devref)
 	ifa = inet_lookup_ifaddr_rcu(net, addr);
 	if (!ifa) {
 		struct flowi4 fl4 = { .daddr = addr };
-		struct fib_result res = { 0 };
+		struct fib_result res = { };
 		struct fib_table *local;
 
 		/* Fallback to FIB local table so that communication
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 8060524f4256..5997070582df 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2576,7 +2576,7 @@ static void trie_show_stats(struct seq_file *seq, struct trie_stat *stat)
 static void trie_show_usage(struct seq_file *seq,
 			    const struct trie_use_stats __percpu *stats)
 {
-	struct trie_use_stats s = { 0 };
+	struct trie_use_stats s = { };
 	int cpu;
 
 	/* loop through all of the CPUs and gather up the stats */
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 8b30cadff708..64ac3bfde55b 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -782,7 +782,7 @@ EXPORT_SYMBOL(__icmp_send);
 void icmp_ndo_send(struct sk_buff *skb_in, int type, int code, __be32 info)
 {
 	struct sk_buff *cloned_skb = NULL;
-	struct ip_options opts = { 0 };
+	struct ip_options opts = { };
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
 	__be32 orig_ip;
diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index c53f14b94356..ec2907a2f4d8 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -520,7 +520,7 @@ static int translate_table(struct net *net,
 			   void *entry0,
 			   const struct arpt_replace *repl)
 {
-	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
+	struct xt_percpu_counter_alloc_state alloc_state = { };
 	struct arpt_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -1505,7 +1505,7 @@ int arpt_register_table(struct net *net,
 	unsigned int num_ops;
 	int ret, i;
 	struct xt_table_info *newinfo;
-	struct xt_table_info bootstrap = {0};
+	struct xt_table_info bootstrap = {};
 	void *loc_cpu_entry;
 	struct xt_table *new_table;
 
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index 13acb687c19a..0bb149078d3e 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -661,7 +661,7 @@ static int
 translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
 		const struct ipt_replace *repl)
 {
-	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
+	struct xt_percpu_counter_alloc_state alloc_state = { };
 	struct ipt_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -1722,7 +1722,7 @@ int ipt_register_table(struct net *net, const struct xt_table *table,
 	unsigned int num_ops;
 	int ret, i;
 	struct xt_table_info *newinfo;
-	struct xt_table_info bootstrap = {0};
+	struct xt_table_info bootstrap = {};
 	void *loc_cpu_entry;
 	struct xt_table *new_table;
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e8b48df73c85..45f2b912a547 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1747,12 +1747,12 @@ void tcp_update_recv_tstamps(struct sk_buff *skb,
 	if (skb->tstamp)
 		tss->ts[0] = ktime_to_timespec64(skb->tstamp);
 	else
-		tss->ts[0] = (struct timespec64) {0};
+		tss->ts[0] = (struct timespec64) {};
 
 	if (skb_hwtstamps(skb)->hwtstamp)
 		tss->ts[2] = ktime_to_timespec64(skb_hwtstamps(skb)->hwtstamp);
 	else
-		tss->ts[2] = (struct timespec64) {0};
+		tss->ts[2] = (struct timespec64) {};
 }
 
 #ifdef CONFIG_MMU
@@ -2244,18 +2244,18 @@ void tcp_recv_timestamp(struct msghdr *msg, const struct sock *sk,
 		if (sk->sk_tsflags & SOF_TIMESTAMPING_SOFTWARE)
 			has_timestamping = true;
 		else
-			tss->ts[0] = (struct timespec64) {0};
+			tss->ts[0] = (struct timespec64) {};
 	}
 
 	if (tss->ts[2].tv_sec || tss->ts[2].tv_nsec) {
 		if (sk->sk_tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
 			has_timestamping = true;
 		else
-			tss->ts[2] = (struct timespec64) {0};
+			tss->ts[2] = (struct timespec64) {};
 	}
 
 	if (has_timestamping) {
-		tss->ts[1] = (struct timespec64) {0};
+		tss->ts[1] = (struct timespec64) {};
 		if (sock_flag(sk, SOCK_TSTAMP_NEW))
 			put_cmsg_scm_timestamping64(msg, tss);
 		else
diff --git a/net/ipv6/ip6_icmp.c b/net/ipv6/ip6_icmp.c
index 9e3574880cb0..eed4c844a18d 100644
--- a/net/ipv6/ip6_icmp.c
+++ b/net/ipv6/ip6_icmp.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL(__icmpv6_send);
 #include <net/netfilter/nf_conntrack.h>
 void icmpv6_ndo_send(struct sk_buff *skb_in, u8 type, u8 code, __u32 info)
 {
-	struct inet6_skb_parm parm = { 0 };
+	struct inet6_skb_parm parm = { };
 	struct sk_buff *cloned_skb = NULL;
 	enum ip_conntrack_info ctinfo;
 	struct in6_addr orig_ip;
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index de2cf3943b91..a053bb63f580 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -678,7 +678,7 @@ static int
 translate_table(struct net *net, struct xt_table_info *newinfo, void *entry0,
 		const struct ip6t_replace *repl)
 {
-	struct xt_percpu_counter_alloc_state alloc_state = { 0 };
+	struct xt_percpu_counter_alloc_state alloc_state = { };
 	struct ip6t_entry *iter;
 	unsigned int *offsets;
 	unsigned int i;
@@ -1731,7 +1731,7 @@ int ip6t_register_table(struct net *net, const struct xt_table *table,
 	unsigned int num_ops;
 	int ret, i;
 	struct xt_table_info *newinfo;
-	struct xt_table_info bootstrap = {0};
+	struct xt_table_info bootstrap = {};
 	void *loc_cpu_entry;
 	struct xt_table *new_table;
 
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 18316ee3c692..dc3eee22358c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -904,7 +904,7 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	size_t headroom = 0;
 	size_t linear;
 	struct sk_buff *skb;
-	struct iucv_message txmsg = {0};
+	struct iucv_message txmsg = {};
 	struct cmsghdr *cmsg;
 	int cmsg_done;
 	long timeo;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 53486b162f01..d48b542840ef 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1314,7 +1314,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 	case L2TP_ENCAPTYPE_IP:
 #if IS_ENABLED(CONFIG_IPV6)
 		if (cfg->local_ip6 && cfg->peer_ip6) {
-			struct sockaddr_l2tpip6 ip6_addr = {0};
+			struct sockaddr_l2tpip6 ip6_addr = {};
 
 			err = sock_create_kern(net, AF_INET6, SOCK_DGRAM,
 					       IPPROTO_L2TP, &sock);
@@ -1342,7 +1342,7 @@ static int l2tp_tunnel_sock_create(struct net *net,
 		} else
 #endif
 		{
-			struct sockaddr_l2tpip ip_addr = {0};
+			struct sockaddr_l2tpip ip_addr = {};
 
 			err = sock_create_kern(net, AF_INET, SOCK_DGRAM,
 					       IPPROTO_L2TP, &sock);
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 96eb91be9238..ca1c7575ae1a 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -188,7 +188,7 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	int proto_version;
 	int fd = -1;
 	int ret = 0;
-	struct l2tp_tunnel_cfg cfg = { 0, };
+	struct l2tp_tunnel_cfg cfg = { };
 	struct l2tp_tunnel *tunnel;
 	struct net *net = genl_info_net(info);
 	struct nlattr **attrs = info->attrs;
@@ -526,7 +526,7 @@ static int l2tp_nl_cmd_session_create(struct sk_buff *skb, struct genl_info *inf
 	int ret = 0;
 	struct l2tp_tunnel *tunnel;
 	struct l2tp_session *session;
-	struct l2tp_session_cfg cfg = { 0, };
+	struct l2tp_session_cfg cfg = { };
 	struct net *net = genl_info_net(info);
 
 	if (!info->attrs[L2TP_ATTR_CONN_ID]) {
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index bf35710127dd..9a75ca85f937 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -662,7 +662,7 @@ static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservaddr,
 	struct l2tp_connect_info info;
 	struct l2tp_tunnel *tunnel;
 	struct pppol2tp_session *ps;
-	struct l2tp_session_cfg cfg = { 0, };
+	struct l2tp_session_cfg cfg = { };
 	bool drop_refcnt = false;
 	bool drop_tunnel = false;
 	bool new_session = false;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 45fb517591ee..8bbcda9a7851 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1312,7 +1312,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	/* add one default STA interface if supported */
 	if (local->hw.wiphy->interface_modes & BIT(NL80211_IFTYPE_STATION) &&
 	    !ieee80211_hw_check(hw, NO_AUTO_VIF)) {
-		struct vif_params params = {0};
+		struct vif_params params = {};
 
 		result = ieee80211_if_add(local, "wlan%d", NET_NAME_ENUM, NULL,
 					  NL80211_IFTYPE_STATION, &params);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 49cb96d25169..88e12412c0a1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -4457,7 +4457,7 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 	struct ieee80211_chanctx *ctx;
 	u32 max_num_different_channels = 1;
 	int err;
-	struct iface_combination_params params = {0};
+	struct iface_combination_params params = {};
 
 	lockdep_assert_held(&local->chanctx_mtx);
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c4f9a5ce3815..11159da58d2e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -431,7 +431,7 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
 {
 	struct sock *sk = (struct sock *)msk, *ssk;
 	struct mptcp_subflow_context *subflow;
-	struct mptcp_addr_info remote = { 0 };
+	struct mptcp_addr_info remote = { };
 	unsigned int subflows_max;
 	int i = 0;
 
diff --git a/net/netfilter/ipset/ip_set_hash_ip.c b/net/netfilter/ipset/ip_set_hash_ip.c
index dd30c03d5a23..f8e01b0888e8 100644
--- a/net/netfilter/ipset/ip_set_hash_ip.c
+++ b/net/netfilter/ipset/ip_set_hash_ip.c
@@ -81,7 +81,7 @@ hash_ip4_kadt(struct ip_set *set, const struct sk_buff *skb,
 {
 	const struct hash_ip4 *h = set->data;
 	ipset_adtfn adtfn = set->variant->adt[adt];
-	struct hash_ip4_elem e = { 0 };
+	struct hash_ip4_elem e = { };
 	struct ip_set_ext ext = IP_SET_INIT_KEXT(skb, opt, set);
 	__be32 ip;
 
@@ -100,7 +100,7 @@ hash_ip4_uadt(struct ip_set *set, struct nlattr *tb[],
 {
 	const struct hash_ip4 *h = set->data;
 	ipset_adtfn adtfn = set->variant->adt[adt];
-	struct hash_ip4_elem e = { 0 };
+	struct hash_ip4_elem e = { };
 	struct ip_set_ext ext = IP_SET_INIT_UEXT(set);
 	u32 ip = 0, ip_to = 0, hosts;
 	int ret = 0;
diff --git a/net/netfilter/xt_l2tp.c b/net/netfilter/xt_l2tp.c
index a61eb81e9f49..97351e8add57 100644
--- a/net/netfilter/xt_l2tp.c
+++ b/net/netfilter/xt_l2tp.c
@@ -84,7 +84,7 @@ static bool l2tp_udp_mt(const struct sk_buff *skb, struct xt_action_param *par,
 	union l2tp_val *lh;
 	union l2tp_val lhbuf;
 	u16 flags;
-	struct l2tp_data data = { 0, };
+	struct l2tp_data data = { };
 
 	if (par->fragoff != 0)
 		return false;
@@ -141,7 +141,7 @@ static bool l2tp_ip_mt(const struct sk_buff *skb, struct xt_action_param *par, u
 	const struct xt_l2tp_info *info = par->matchinfo;
 	union l2tp_val *lh;
 	union l2tp_val lhbuf;
-	struct l2tp_data data = { 0, };
+	struct l2tp_data data = { };
 
 	/* For IP encap, the L2TP sid is the first 32-bits. */
 	lh = skb_header_pointer(skb, thoff, sizeof(lhbuf), &lhbuf);
diff --git a/net/netfilter/xt_rateest.c b/net/netfilter/xt_rateest.c
index 72324bd976af..7041e5e5684d 100644
--- a/net/netfilter/xt_rateest.c
+++ b/net/netfilter/xt_rateest.c
@@ -15,7 +15,7 @@ static bool
 xt_rateest_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_rateest_match_info *info = par->matchinfo;
-	struct gnet_stats_rate_est64 sample = {0};
+	struct gnet_stats_rate_est64 sample = {};
 	u_int32_t bps1, bps2, pps1, pps2;
 	bool ret = true;
 
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 076774034bb9..3adae090f506 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -828,7 +828,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 	}
 
 	if (key->eth.type == htons(ETH_P_IP)) {
-		struct rtable ovs_rt = { 0 };
+		struct rtable ovs_rt = { };
 		unsigned long orig_dst;
 
 		prepare_frag(vport, skb, orig_network_offset,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 543365f58e97..2d9152630b85 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2883,7 +2883,7 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
 	unsigned char *addr = NULL;
 	int err, reserve = 0;
 	struct sockcm_cookie sockc;
-	struct virtio_net_hdr vnet_hdr = { 0 };
+	struct virtio_net_hdr vnet_hdr = { };
 	int offset = 0;
 	struct packet_sock *po = pkt_sk(sk);
 	bool has_vnet_hdr = false;
@@ -3891,7 +3891,7 @@ packet_setsockopt(struct socket *sock, int level, int optname, sockptr_t optval,
 	}
 	case PACKET_FANOUT:
 	{
-		struct fanout_args args = { 0 };
+		struct fanout_args args = { };
 
 		if (optlen != sizeof(int) && optlen != sizeof(args))
 			return -EINVAL;
diff --git a/net/rds/ib_stats.c b/net/rds/ib_stats.c
index ac46d8961b61..dd6079e0b2eb 100644
--- a/net/rds/ib_stats.c
+++ b/net/rds/ib_stats.c
@@ -84,7 +84,7 @@ static const char *const rds_ib_stat_names[] = {
 unsigned int rds_ib_stats_info_copy(struct rds_info_iterator *iter,
 				    unsigned int avail)
 {
-	struct rds_ib_statistics stats = {0, };
+	struct rds_ib_statistics stats = {};
 	uint64_t *src;
 	uint64_t *sum;
 	size_t i;
diff --git a/net/rds/stats.c b/net/rds/stats.c
index 9e87da43c004..6decac9bcf28 100644
--- a/net/rds/stats.c
+++ b/net/rds/stats.c
@@ -112,7 +112,7 @@ static void rds_stats_info(struct socket *sock, unsigned int len,
 			   struct rds_info_iterator *iter,
 			   struct rds_info_lengths *lens)
 {
-	struct rds_statistics stats = {0, };
+	struct rds_statistics stats = {};
 	uint64_t *src;
 	uint64_t *sum;
 	size_t i;
diff --git a/net/rds/tcp_stats.c b/net/rds/tcp_stats.c
index f8a7954f1f59..ebf880234cb5 100644
--- a/net/rds/tcp_stats.c
+++ b/net/rds/tcp_stats.c
@@ -51,7 +51,7 @@ static const char * const rds_tcp_stat_names[] = {
 unsigned int rds_tcp_stats_info_copy(struct rds_info_iterator *iter,
 				     unsigned int avail)
 {
-	struct rds_tcp_statistics stats = {0, };
+	struct rds_tcp_statistics stats = {};
 	uint64_t *src;
 	uint64_t *sum;
 	size_t i;
diff --git a/net/rxrpc/input.c b/net/rxrpc/input.c
index dc201363f2c4..2116ba10c26b 100644
--- a/net/rxrpc/input.c
+++ b/net/rxrpc/input.c
@@ -302,7 +302,7 @@ static bool rxrpc_end_tx_phase(struct rxrpc_call *call, bool reply_begun,
  */
 static bool rxrpc_receiving_reply(struct rxrpc_call *call)
 {
-	struct rxrpc_ack_summary summary = { 0 };
+	struct rxrpc_ack_summary summary = { };
 	unsigned long now, timo;
 	rxrpc_seq_t top = READ_ONCE(call->tx_top);
 
@@ -841,7 +841,7 @@ static bool rxrpc_is_ack_valid(struct rxrpc_call *call,
  */
 static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
 {
-	struct rxrpc_ack_summary summary = { 0 };
+	struct rxrpc_ack_summary summary = { };
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	union {
 		struct rxrpc_ackpacket ack;
@@ -995,7 +995,7 @@ static void rxrpc_input_ack(struct rxrpc_call *call, struct sk_buff *skb)
  */
 static void rxrpc_input_ackall(struct rxrpc_call *call, struct sk_buff *skb)
 {
-	struct rxrpc_ack_summary summary = { 0 };
+	struct rxrpc_ack_summary summary = { };
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 
 	_proto("Rx ACKALL %%%u", sp->hdr.serial);
diff --git a/net/rxrpc/local_object.c b/net/rxrpc/local_object.c
index a4111408ffd0..29a765c966ba 100644
--- a/net/rxrpc/local_object.c
+++ b/net/rxrpc/local_object.c
@@ -109,7 +109,7 @@ static int rxrpc_open_socket(struct rxrpc_local *local, struct net *net)
 {
 	struct udp_tunnel_sock_cfg tuncfg = {NULL};
 	struct sockaddr_rxrpc *srx = &local->srx;
-	struct udp_port_cfg udp_conf = {0};
+	struct udp_port_cfg udp_conf = {};
 	struct sock *usk;
 	int ret;
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 2ef8f5a6205a..fcc9c5da72ff 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -1387,7 +1387,7 @@ EXPORT_SYMBOL(tcf_block_put_ext);
 
 void tcf_block_put(struct tcf_block *block)
 {
-	struct tcf_block_ext_info ei = {0, };
+	struct tcf_block_ext_info ei = {};
 
 	if (!block)
 		return;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 3c2300d14468..ae5f2bbe253d 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2987,7 +2987,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	const struct cake_flow *flow = NULL;
-	struct gnet_stats_queue qs = { 0 };
+	struct gnet_stats_queue qs = { };
 	struct nlattr *stats;
 	u32 idx = cl - 1;
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index bb0cd6d3d2c2..df9153b71a4b 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -624,7 +624,7 @@ static int fq_codel_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	u32 idx = cl - 1;
-	struct gnet_stats_queue qs = { 0 };
+	struct gnet_stats_queue qs = { };
 	struct tc_fq_codel_xstats xstats;
 
 	if (idx < q->flows_cnt) {
diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index 8c06381391d6..ab359d63287c 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -90,7 +90,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 	}
 
 	if (skb_protocol(skb, true) == htons(ETH_P_IP)) {
-		struct rtable sch_frag_rt = { 0 };
+		struct rtable sch_frag_rt = { };
 		unsigned long orig_dst;
 
 		sch_frag_prepare_frag(skb, xmit);
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 8766ab5b8788..3827d802fd56 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -385,7 +385,7 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct net_device *dev = qdisc_dev(sch);
 	struct mqprio_sched *priv = qdisc_priv(sch);
 	struct nlattr *nla = (struct nlattr *)skb_tail_pointer(skb);
-	struct tc_mqprio_qopt opt = { 0 };
+	struct tc_mqprio_qopt opt = { };
 	struct Qdisc *qdisc;
 	unsigned int ntx, tc;
 
@@ -513,8 +513,8 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	if (cl >= TC_H_MIN_PRIORITY) {
 		int i;
 		__u32 qlen = 0;
-		struct gnet_stats_queue qstats = {0};
-		struct gnet_stats_basic_packed bstats = {0};
+		struct gnet_stats_queue qstats = {};
+		struct gnet_stats_basic_packed bstats = {};
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
 
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 0c345e43a09a..61a09f342473 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -861,7 +861,7 @@ static void get_rate(struct netem_sched_data *q, const struct nlattr *attr)
 	if (q->cell_size)
 		q->cell_size_reciprocal = reciprocal_value(q->cell_size);
 	else
-		q->cell_size_reciprocal = (struct reciprocal_value) { 0 };
+		q->cell_size_reciprocal = (struct reciprocal_value) { };
 }
 
 static int get_loss_clg(struct netem_sched_data *q, const struct nlattr *attr)
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 40adf1f07a82..a7985164e00a 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -447,7 +447,7 @@ static int red_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
-	struct tc_red_xstats st = {0};
+	struct tc_red_xstats st = {};
 
 	if (sch->flags & TCQ_F_OFFLOADED) {
 		struct tc_red_qopt_offload hw_stats_request = {
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index f8e569f79f13..f7147894454e 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -864,8 +864,8 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
 	sfq_index idx = q->ht[cl - 1];
-	struct gnet_stats_queue qs = { 0 };
-	struct tc_sfq_xstats xstats = { 0 };
+	struct gnet_stats_queue qs = { };
+	struct tc_sfq_xstats xstats = { };
 
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 1ab2fc933a21..409e78080800 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1869,7 +1869,7 @@ static int taprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 	struct sched_gate_list *oper, *admin;
-	struct tc_mqprio_qopt opt = { 0 };
+	struct tc_mqprio_qopt opt = { };
 	struct nlattr *nest, *sched_nest;
 	unsigned int i;
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index ec0f52567c16..b55ce2a19db3 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -859,7 +859,7 @@ static int sctp_udp_rcv(struct sock *sk, struct sk_buff *skb)
 int sctp_udp_sock_start(struct net *net)
 {
 	struct udp_tunnel_sock_cfg tuncfg = {NULL};
-	struct udp_port_cfg udp_conf = {0};
+	struct udp_port_cfg udp_conf = {};
 	struct socket *sock;
 	int err;
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 04f1b78bcbca..496345c3b10d 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -625,7 +625,7 @@ xs_read_stream_reply(struct sock_xprt *transport, struct msghdr *msg, int flags)
 static ssize_t
 xs_read_stream(struct sock_xprt *transport, int flags)
 {
-	struct msghdr msg = { 0 };
+	struct msghdr msg = { };
 	size_t want, read = 0;
 	ssize_t ret = 0;
 
diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index a0a27d87f631..0ce1f1946ae0 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -3295,7 +3295,7 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
 static int tipc_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 {
 	struct net *net = sock_net(sock->sk);
-	struct tipc_sioc_nodeid_req nr = {0};
+	struct tipc_sioc_nodeid_req nr = {};
 	struct tipc_sioc_ln_req lnr;
 	void __user *argp = (void __user *)arg;
 
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index c2bb818704c8..8c12a22a86bb 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -330,7 +330,7 @@ static int tipc_udp_rcast_add(struct tipc_bearer *b,
 
 static int tipc_udp_rcast_disc(struct tipc_bearer *b, struct sk_buff *skb)
 {
-	struct udp_media_addr src = {0};
+	struct udp_media_addr src = {};
 	struct udp_media_addr *dst;
 
 	dst = (struct udp_media_addr *)&b->bcast_addr.value;
@@ -623,7 +623,7 @@ static int tipc_parse_udp_addr(struct nlattr *nla, struct udp_media_addr *addr,
 int tipc_udp_nl_bearer_add(struct tipc_bearer *b, struct nlattr *attr)
 {
 	int err;
-	struct udp_media_addr addr = {0};
+	struct udp_media_addr addr = {};
 	struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
 	struct udp_media_addr *dst;
 
@@ -663,9 +663,9 @@ static int tipc_udp_enable(struct net *net, struct tipc_bearer *b,
 {
 	int err = -EINVAL;
 	struct udp_bearer *ub;
-	struct udp_media_addr remote = {0};
-	struct udp_media_addr local = {0};
-	struct udp_port_cfg udp_conf = {0};
+	struct udp_media_addr remote = {};
+	struct udp_media_addr local = {};
+	struct udp_port_cfg udp_conf = {};
 	struct udp_tunnel_sock_cfg tuncfg = {NULL};
 	struct nlattr *opts[TIPC_NLA_UDP_MAX + 1];
 	u8 node_id[NODE_ID_LEN] = {0,};
diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index b2dad47a77a0..5755fa764bcf 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -47,8 +47,8 @@ void vm_exit(int sig)
 int main(int argc, char **argv)
 {
 	int vcpu_id, ret;
-	struct acrn_vm_creation create_vm = {0};
-	struct acrn_vm_memmap ram_map = {0};
+	struct acrn_vm_creation create_vm = {};
+	struct acrn_vm_memmap ram_map = {};
 	struct acrn_vcpu_regs regs;
 	struct acrn_io_request *io_req;
 	struct acrn_ioreq_notify __attribute__((aligned(8))) notify;
diff --git a/samples/binderfs/binderfs_example.c b/samples/binderfs/binderfs_example.c
index 0fd92cdda460..57c2098be04d 100644
--- a/samples/binderfs/binderfs_example.c
+++ b/samples/binderfs/binderfs_example.c
@@ -18,7 +18,7 @@
 int main(int argc, char *argv[])
 {
 	int fd, ret, saved_errno;
-	struct binderfs_device device = { 0 };
+	struct binderfs_device device = { };
 
 	ret = unshare(CLONE_NEWNS);
 	if (ret < 0) {
diff --git a/samples/bpf/cookie_uid_helper_example.c b/samples/bpf/cookie_uid_helper_example.c
index 54958802c032..fb33dcb08676 100644
--- a/samples/bpf/cookie_uid_helper_example.c
+++ b/samples/bpf/cookie_uid_helper_example.c
@@ -212,8 +212,8 @@ static void print_table(void)
 
 static void udp_client(void)
 {
-	struct sockaddr_in si_other = {0};
-	struct sockaddr_in si_me = {0};
+	struct sockaddr_in si_other = {};
+	struct sockaddr_in si_me = {};
 	struct stats dataEntry;
 	int s_rcv, s_send, i, recv_len;
 	char message = 'a';
diff --git a/samples/bpf/hbm.c b/samples/bpf/hbm.c
index b0c18efe7928..238f91ed11f8 100644
--- a/samples/bpf/hbm.c
+++ b/samples/bpf/hbm.c
@@ -153,7 +153,7 @@ static int prog_load(char *prog)
 
 static int run_bpf_prog(char *prog, int cg_id)
 {
-	struct hbm_queue_stats qstats = {0};
+	struct hbm_queue_stats qstats = {};
 	char cg_dir[100], cg_pin_path[100];
 	struct bpf_link *link = NULL;
 	int key = 0;
diff --git a/samples/bpf/xdp_rxq_info_user.c b/samples/bpf/xdp_rxq_info_user.c
index 74a2926eba08..c5bf4aaa7283 100644
--- a/samples/bpf/xdp_rxq_info_user.c
+++ b/samples/bpf/xdp_rxq_info_user.c
@@ -457,7 +457,7 @@ int main(int argc, char **argv)
 	__u32 info_len = sizeof(info);
 	int prog_fd, map_fd, opt, err;
 	bool use_separators = true;
-	struct config cfg = { 0 };
+	struct config cfg = { };
 	struct bpf_object *obj;
 	struct bpf_map *map;
 	char filename[256];
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 4e1f96b216a8..12ef446bd788 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -677,7 +677,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 	const char *tmpname, *tmpns = NULL, *name = NULL;
 	const char *info = "failed to unpack profile";
 	size_t ns_len;
-	struct rhashtable_params params = { 0 };
+	struct rhashtable_params params = { };
 	char *key = NULL;
 	struct aa_data *data;
 	int i, error = -EPROTO;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 6517f221d52c..32f789369ec5 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4648,7 +4648,7 @@ static int sock_has_perm(struct sock *sk, u32 perms)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 
 	if (sksec->sid == SECINITSID_KERNEL)
 		return 0;
@@ -4748,7 +4748,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	if (family == PF_INET || family == PF_INET6) {
 		char *addrp;
 		struct common_audit_data ad;
-		struct lsm_network_audit net = {0,};
+		struct lsm_network_audit net = {};
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
 		u16 family_sa;
@@ -4893,7 +4893,7 @@ static int selinux_socket_connect_helper(struct socket *sock,
 	    sksec->sclass == SECCLASS_DCCP_SOCKET ||
 	    sksec->sclass == SECCLASS_SCTP_SOCKET) {
 		struct common_audit_data ad;
-		struct lsm_network_audit net = {0,};
+		struct lsm_network_audit net = {};
 		struct sockaddr_in *addr4 = NULL;
 		struct sockaddr_in6 *addr6 = NULL;
 		unsigned short snum;
@@ -5053,7 +5053,7 @@ static int selinux_socket_unix_stream_connect(struct sock *sock,
 	struct sk_security_struct *sksec_other = other->sk_security;
 	struct sk_security_struct *sksec_new = newsk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	int err;
 
 	ad.type = LSM_AUDIT_DATA_NET;
@@ -5086,7 +5086,7 @@ static int selinux_socket_unix_may_send(struct socket *sock,
 	struct sk_security_struct *ssec = sock->sk->sk_security;
 	struct sk_security_struct *osec = other->sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 
 	ad.type = LSM_AUDIT_DATA_NET;
 	ad.u.net = &net;
@@ -5129,7 +5129,7 @@ static int selinux_sock_rcv_skb_compat(struct sock *sk, struct sk_buff *skb,
 	struct sk_security_struct *sksec = sk->sk_security;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	char *addrp;
 
 	ad.type = LSM_AUDIT_DATA_NET;
@@ -5163,7 +5163,7 @@ static int selinux_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	u16 family = sk->sk_family;
 	u32 sk_sid = sksec->sid;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	char *addrp;
 	u8 secmark_active;
 	u8 peerlbl_active;
@@ -5361,7 +5361,7 @@ static int selinux_sctp_assoc_request(struct sctp_endpoint *ep,
 {
 	struct sk_security_struct *sksec = ep->base.sk->sk_security;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	u8 peerlbl_active;
 	u32 peer_sid = SECINITSID_UNLABELED;
 	u32 conn_sid;
@@ -5696,7 +5696,7 @@ static unsigned int selinux_ip_forward(struct sk_buff *skb,
 	char *addrp;
 	u32 peer_sid;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	u8 secmark_active;
 	u8 netlbl_active;
 	u8 peerlbl_active;
@@ -5827,7 +5827,7 @@ static unsigned int selinux_ip_postroute_compat(struct sk_buff *skb,
 	struct sock *sk = skb_to_full_sk(skb);
 	struct sk_security_struct *sksec;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	char *addrp;
 	u8 proto;
 
@@ -5863,7 +5863,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb,
 	int ifindex = outdev->ifindex;
 	struct sock *sk;
 	struct common_audit_data ad;
-	struct lsm_network_audit net = {0,};
+	struct lsm_network_audit net = {};
 	char *addrp;
 	u8 secmark_active;
 	u8 peerlbl_active;
diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index de514ec8c83d..a81f8b70e909 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -693,7 +693,7 @@ snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
 static inline int
 snd_compr_tstamp(struct snd_compr_stream *stream, unsigned long arg)
 {
-	struct snd_compr_tstamp tstamp = {0};
+	struct snd_compr_tstamp tstamp = {};
 	int ret;
 
 	ret = snd_compr_update_tstamp(stream, &tstamp);
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 9be2260e4ca2..67e456c03e02 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -160,7 +160,7 @@ static int apply_constraint_to_size(struct snd_pcm_hw_params *params,
 	struct snd_interval *s = hw_param_interval(params, rule->var);
 	const struct snd_interval *r =
 		hw_param_interval_c(params, SNDRV_PCM_HW_PARAM_RATE);
-	struct snd_interval t = {0};
+	struct snd_interval t = {};
 	unsigned int step = 0;
 	int i;
 
@@ -1232,7 +1232,7 @@ static void process_tx_packets(struct fw_iso_context *context, u32 tstamp, size_
 	}
 
 	for (i = 0; i < packets; ++i) {
-		struct fw_iso_packet params = {0};
+		struct fw_iso_packet params = {};
 
 		if (queue_in_packet(s, &params) < 0) {
 			cancel_stream(s);
@@ -1260,7 +1260,7 @@ static void drop_tx_packets(struct fw_iso_context *context, u32 tstamp, size_t h
 	s->next_cycle = increment_ohci_cycle_count(cycle, 1);
 
 	for (i = 0; i < packets; ++i) {
-		struct fw_iso_packet params = {0};
+		struct fw_iso_packet params = {};
 
 		if (queue_in_packet(s, &params) < 0) {
 			cancel_stream(s);
diff --git a/sound/firewire/fireworks/fireworks_command.c b/sound/firewire/fireworks/fireworks_command.c
index 7e255fc2c6e4..194f08d0e12d 100644
--- a/sound/firewire/fireworks/fireworks_command.c
+++ b/sound/firewire/fireworks/fireworks_command.c
@@ -293,7 +293,7 @@ static int
 command_set_clock(struct snd_efw *efw,
 		  unsigned int source, unsigned int rate)
 {
-	struct efc_clock clock = {0};
+	struct efc_clock clock = {};
 	int err;
 
 	/* check arguments */
@@ -343,7 +343,7 @@ int snd_efw_command_get_clock_source(struct snd_efw *efw,
 				     enum snd_efw_clock_source *source)
 {
 	int err;
-	struct efc_clock clock = {0};
+	struct efc_clock clock = {};
 
 	err = command_get_clock(efw, &clock);
 	if (err >= 0)
@@ -355,7 +355,7 @@ int snd_efw_command_get_clock_source(struct snd_efw *efw,
 int snd_efw_command_get_sampling_rate(struct snd_efw *efw, unsigned int *rate)
 {
 	int err;
-	struct efc_clock clock = {0};
+	struct efc_clock clock = {};
 
 	err = command_get_clock(efw, &clock);
 	if (err >= 0)
diff --git a/sound/pci/asihpi/hpioctl.c b/sound/pci/asihpi/hpioctl.c
index bb31b7fe867d..3f5ac32a62a1 100644
--- a/sound/pci/asihpi/hpioctl.c
+++ b/sound/pci/asihpi/hpioctl.c
@@ -352,7 +352,7 @@ int asihpi_adapter_probe(struct pci_dev *pci_dev,
 	struct hpi_message hm;
 	struct hpi_response hr;
 	struct hpi_adapter adapter;
-	struct hpi_pci pci = { 0 };
+	struct hpi_pci pci = { };
 
 	memset(&adapter, 0, sizeof(adapter));
 
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index c852c6a75b91..1b24294225e8 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -657,7 +657,7 @@ static struct snd_kcontrol_new
 snd_ca0106_volume_spi_dac_ctl(const struct snd_ca0106_details *details,
 			      int channel_id)
 {
-	struct snd_kcontrol_new spi_switch = {0};
+	struct snd_kcontrol_new spi_switch = {};
 	int reg, bit;
 	int dac_id;
 
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index 78f35e88aed6..2ab2caa2026f 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -241,8 +241,8 @@ static int atc_pcm_playback_prepare(struct ct_atc *atc, struct ct_atc_pcm *apcm)
 {
 	struct src_mgr *src_mgr = atc->rsc_mgrs[SRC];
 	struct amixer_mgr *amixer_mgr = atc->rsc_mgrs[AMIXER];
-	struct src_desc desc = {0};
-	struct amixer_desc mix_dsc = {0};
+	struct src_desc desc = {};
+	struct amixer_desc mix_dsc = {};
 	struct src *src;
 	struct amixer *amixer;
 	int err;
@@ -503,12 +503,12 @@ atc_pcm_capture_get_resources(struct ct_atc *atc, struct ct_atc_pcm *apcm)
 	struct srcimp_mgr *srcimp_mgr = atc->rsc_mgrs[SRCIMP];
 	struct amixer_mgr *amixer_mgr = atc->rsc_mgrs[AMIXER];
 	struct sum_mgr *sum_mgr = atc->rsc_mgrs[SUM];
-	struct src_desc src_dsc = {0};
+	struct src_desc src_dsc = {};
 	struct src *src;
-	struct srcimp_desc srcimp_dsc = {0};
+	struct srcimp_desc srcimp_dsc = {};
 	struct srcimp *srcimp;
-	struct amixer_desc mix_dsc = {0};
-	struct sum_desc sum_dsc = {0};
+	struct amixer_desc mix_dsc = {};
+	struct sum_desc sum_dsc = {};
 	unsigned int pitch;
 	int multi, err, i;
 	int n_srcimp, n_amixer, n_srcc, n_sum;
@@ -784,8 +784,8 @@ static int spdif_passthru_playback_get_resources(struct ct_atc *atc,
 {
 	struct src_mgr *src_mgr = atc->rsc_mgrs[SRC];
 	struct amixer_mgr *amixer_mgr = atc->rsc_mgrs[AMIXER];
-	struct src_desc desc = {0};
-	struct amixer_desc mix_dsc = {0};
+	struct src_desc desc = {};
+	struct amixer_desc mix_dsc = {};
 	struct src *src;
 	int err;
 	int n_amixer = apcm->substream->runtime->channels, i;
@@ -1109,7 +1109,7 @@ static int atc_spdif_out_set_status(struct ct_atc *atc, unsigned int status)
 
 static int atc_spdif_out_passthru(struct ct_atc *atc, unsigned char state)
 {
-	struct dao_desc da_dsc = {0};
+	struct dao_desc da_dsc = {};
 	struct dao *dao;
 	int err;
 	struct ct_mixer *mixer = atc->mixer;
@@ -1326,7 +1326,7 @@ int ct_atc_create_alsa_devs(struct ct_atc *atc)
 static int atc_create_hw_devs(struct ct_atc *atc)
 {
 	struct hw *hw;
-	struct card_conf info = {0};
+	struct card_conf info = {};
 	int i, err;
 
 	err = create_hw_obj(atc->pci, atc->chip_type, atc->model, &hw);
@@ -1362,13 +1362,13 @@ static int atc_create_hw_devs(struct ct_atc *atc)
 
 static int atc_get_resources(struct ct_atc *atc)
 {
-	struct daio_desc da_desc = {0};
+	struct daio_desc da_desc = {};
 	struct daio_mgr *daio_mgr;
-	struct src_desc src_dsc = {0};
+	struct src_desc src_dsc = {};
 	struct src_mgr *src_mgr;
-	struct srcimp_desc srcimp_dsc = {0};
+	struct srcimp_desc srcimp_dsc = {};
 	struct srcimp_mgr *srcimp_mgr;
-	struct sum_desc sum_dsc = {0};
+	struct sum_desc sum_dsc = {};
 	struct sum_mgr *sum_mgr;
 	int err, i, num_srcs, num_daios;
 
@@ -1559,7 +1559,7 @@ static int atc_suspend(struct ct_atc *atc)
 static int atc_hw_resume(struct ct_atc *atc)
 {
 	struct hw *hw = atc->hw;
-	struct card_conf info = {0};
+	struct card_conf info = {};
 
 	/* Re-initialize card hardware. */
 	info.rsr = atc->rsr;
diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index f589da045342..b2cce924bcc7 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -450,7 +450,7 @@ static int dao_rsc_uninit(struct dao *dao)
 static int dao_rsc_reinit(struct dao *dao, const struct dao_desc *desc)
 {
 	struct daio_mgr *mgr = dao->mgr;
-	struct daio_desc dsc = {0};
+	struct daio_desc dsc = {};
 
 	dsc.type = dao->daio.type;
 	dsc.msr = desc->msr;
diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 0cea4982ed7d..2b1fb1acc5c6 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -1986,10 +1986,10 @@ static int hw_card_init(struct hw *hw, struct card_conf *info)
 	int err;
 	unsigned int gctl;
 	u32 data;
-	struct dac_conf dac_info = {0};
-	struct adc_conf adc_info = {0};
-	struct daio_conf daio_info = {0};
-	struct trn_conf trn_info = {0};
+	struct dac_conf dac_info = {};
+	struct adc_conf adc_info = {};
+	struct daio_conf daio_info = {};
+	struct trn_conf trn_info = {};
 
 	/* Get PCI io port base address and do Hendrix switch if needed. */
 	err = hw_card_start(hw);
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 55af8ef29838..b3cb2f98efcd 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -1603,7 +1603,7 @@ static int hw_dac_init(struct hw *hw, const struct dac_conf *info)
 	int err;
 	u32 data;
 	int i;
-	struct regs_cs4382 cs_read = {0};
+	struct regs_cs4382 cs_read = {};
 	struct regs_cs4382 cs_def = {
 		.mode_control_1 = 0x00000001, /* Mode Control 1 */
 		.mode_control_2 = 0x00000000, /* Mode Control 2 */
@@ -2114,10 +2114,10 @@ static int hw_card_init(struct hw *hw, struct card_conf *info)
 	int err;
 	unsigned int gctl;
 	u32 data = 0;
-	struct dac_conf dac_info = {0};
-	struct adc_conf adc_info = {0};
-	struct daio_conf daio_info = {0};
-	struct trn_conf trn_info = {0};
+	struct dac_conf dac_info = {};
+	struct adc_conf adc_info = {};
+	struct daio_conf daio_info = {};
+	struct trn_conf trn_info = {};
 
 	/* Get PCI io port/memory base address and
 	 * do 20kx core switch if needed. */
diff --git a/sound/pci/ctxfi/ctmixer.c b/sound/pci/ctxfi/ctmixer.c
index 6797fde3d788..d2be35e429cc 100644
--- a/sound/pci/ctxfi/ctmixer.c
+++ b/sound/pci/ctxfi/ctmixer.c
@@ -837,10 +837,10 @@ static int ct_mixer_get_resources(struct ct_mixer *mixer)
 {
 	struct sum_mgr *sum_mgr;
 	struct sum *sum;
-	struct sum_desc sum_desc = {0};
+	struct sum_desc sum_desc = {};
 	struct amixer_mgr *amixer_mgr;
 	struct amixer *amixer;
-	struct amixer_desc am_desc = {0};
+	struct amixer_desc am_desc = {};
 	int err;
 	int i;
 
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index f0f8324b08b6..0b4ad373d2ae 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -411,7 +411,7 @@ DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, 1);
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 				     const char *name)
 {
-	struct snd_ctl_elem_id sid = {0};
+	struct snd_ctl_elem_id sid = {};
 
 	strscpy(sid.name, name, sizeof(sid.name));
 	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index 0dfa093f7dca..f1e060e09e7c 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -769,7 +769,7 @@ DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, 1);
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 				     const char *name)
 {
-	struct snd_ctl_elem_id sid = {0};
+	struct snd_ctl_elem_id sid = {};
 
 	strscpy(sid.name, name, sizeof(sid.name));
 	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index 5db2f4865bbb..e507d64afae1 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -225,8 +225,8 @@ static int sst_platform_alloc_stream(struct snd_pcm_substream *substream,
 	struct sst_runtime_stream *stream =
 			substream->runtime->private_data;
 	struct snd_sst_stream_params param = {{{0,},},};
-	struct snd_sst_params str_params = {0};
-	struct snd_sst_alloc_params_ext alloc_params = {0};
+	struct snd_sst_params str_params = {};
+	struct snd_sst_alloc_params_ext alloc_params = {};
 	int ret_val = 0;
 	struct sst_data *ctx = snd_soc_dai_get_drvdata(dai);
 
diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 0af618dd8073..d7d8604a5bc0 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -242,7 +242,7 @@ static int sst_cdev_ack(struct device *dev, unsigned int str_id,
 		unsigned long bytes)
 {
 	struct stream_info *stream;
-	struct snd_sst_tstamp fw_tstamp = {0,};
+	struct snd_sst_tstamp fw_tstamp = {};
 	int offset;
 	void __iomem *addr;
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
@@ -344,7 +344,7 @@ static int sst_cdev_stream_partial_drain(struct device *dev,
 static int sst_cdev_tstamp(struct device *dev, unsigned int str_id,
 		struct snd_compr_tstamp *tstamp)
 {
-	struct snd_sst_tstamp fw_tstamp = {0,};
+	struct snd_sst_tstamp fw_tstamp = {};
 	struct stream_info *stream;
 	struct intel_sst_drv *ctx = dev_get_drvdata(dev);
 	void __iomem *addr;
diff --git a/sound/soc/intel/skylake/cnl-sst.c b/sound/soc/intel/skylake/cnl-sst.c
index 1275c149acc0..7ddf923e6c33 100644
--- a/sound/soc/intel/skylake/cnl-sst.c
+++ b/sound/soc/intel/skylake/cnl-sst.c
@@ -314,7 +314,7 @@ static irqreturn_t cnl_dsp_irq_thread_handler(int irq, void *context)
 	struct sst_dsp *dsp = context;
 	struct skl_dev *cnl = dsp->thread_context;
 	struct sst_generic_ipc *ipc = &cnl->ipc;
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	u32 hipcida, hipctdr, hipctdd;
 	int ipc_irq = 0;
 
diff --git a/sound/soc/intel/skylake/skl-messages.c b/sound/soc/intel/skylake/skl-messages.c
index eaad180af42e..fc3567032672 100644
--- a/sound/soc/intel/skylake/skl-messages.c
+++ b/sound/soc/intel/skylake/skl-messages.c
@@ -38,7 +38,7 @@ static int skl_free_dma_buf(struct device *dev, struct snd_dma_buffer *dmab)
 
 void skl_dsp_set_astate_cfg(struct skl_dev *skl, u32 cnt, void *data)
 {
-	struct skl_ipc_large_config_msg	msg = {0};
+	struct skl_ipc_large_config_msg	msg = {};
 
 	msg.large_param_id = SKL_ASTATE_PARAM_ID;
 	msg.param_data_size = (cnt * sizeof(struct skl_astate_param) +
@@ -567,8 +567,8 @@ static void skl_copy_copier_caps(struct skl_module_cfg *mconfig,
 static u32 skl_get_node_id(struct skl_dev *skl,
 			struct skl_module_cfg *mconfig)
 {
-	union skl_connector_node_id node_id = {0};
-	union skl_ssp_dma_node ssp_node  = {0};
+	union skl_connector_node_id node_id = {};
+	union skl_ssp_dma_node ssp_node  = {};
 	struct skl_pipe_params *params = mconfig->pipe->p_params;
 
 	switch (mconfig->dev_type) {
@@ -690,7 +690,7 @@ int skl_dsp_set_dma_control(struct skl_dev *skl, u32 *caps,
 				u32 caps_size, u32 node_id)
 {
 	struct skl_dma_control *dma_ctrl;
-	struct skl_ipc_large_config_msg msg = {0};
+	struct skl_ipc_large_config_msg msg = {};
 	int err = 0;
 
 
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 9ecaf6a1e847..0480975a980c 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -300,7 +300,7 @@ static int skl_pcm_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_bus *bus = dev_get_drvdata(dai->dev);
 	struct hdac_ext_stream *stream = get_hdac_ext_stream(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct skl_pipe_params p_params = {0};
+	struct skl_pipe_params p_params = {};
 	struct skl_module_cfg *m_cfg;
 	int ret, dma_id;
 
@@ -402,7 +402,7 @@ static int skl_be_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
 {
-	struct skl_pipe_params p_params = {0};
+	struct skl_pipe_params p_params = {};
 
 	p_params.s_fmt = snd_pcm_format_width(params_format(params));
 	p_params.ch = params_channels(params);
@@ -545,7 +545,7 @@ static int skl_link_hw_params(struct snd_pcm_substream *substream,
 	struct hdac_ext_stream *link_dev;
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
-	struct skl_pipe_params p_params = {0};
+	struct skl_pipe_params p_params = {};
 	struct hdac_ext_link *link;
 	int stream_tag;
 
diff --git a/sound/soc/intel/skylake/skl-sst-ipc.c b/sound/soc/intel/skylake/skl-sst-ipc.c
index 7a425271b08b..eeb9bb3c0c87 100644
--- a/sound/soc/intel/skylake/skl-sst-ipc.c
+++ b/sound/soc/intel/skylake/skl-sst-ipc.c
@@ -491,7 +491,7 @@ irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
 	struct sst_dsp *dsp = context;
 	struct skl_dev *skl = dsp->thread_context;
 	struct sst_generic_ipc *ipc = &skl->ipc;
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	u32 hipcie, hipct, hipcte;
 	int ipc_irq = 0;
 
@@ -635,8 +635,8 @@ void skl_ipc_free(struct sst_generic_ipc *ipc)
 int skl_ipc_create_pipeline(struct sst_generic_ipc *ipc,
 		u16 ppl_mem_size, u8 ppl_type, u8 instance_id, u8 lp_mode)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
@@ -662,8 +662,8 @@ EXPORT_SYMBOL_GPL(skl_ipc_create_pipeline);
 
 int skl_ipc_delete_pipeline(struct sst_generic_ipc *ipc, u8 instance_id)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
@@ -686,8 +686,8 @@ EXPORT_SYMBOL_GPL(skl_ipc_delete_pipeline);
 int skl_ipc_set_pipeline_state(struct sst_generic_ipc *ipc,
 		u8 instance_id, enum skl_ipc_pipeline_state state)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
@@ -710,8 +710,8 @@ EXPORT_SYMBOL_GPL(skl_ipc_set_pipeline_state);
 int
 skl_ipc_save_pipeline(struct sst_generic_ipc *ipc, u8 instance_id, int dma_id)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
@@ -735,8 +735,8 @@ EXPORT_SYMBOL_GPL(skl_ipc_save_pipeline);
 
 int skl_ipc_restore_pipeline(struct sst_generic_ipc *ipc, u8 instance_id)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
@@ -759,7 +759,7 @@ EXPORT_SYMBOL_GPL(skl_ipc_restore_pipeline);
 int skl_ipc_set_dx(struct sst_generic_ipc *ipc, u8 instance_id,
 		u16 module_id, struct skl_ipc_dxstate_info *dx)
 {
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	struct sst_ipc_message request;
 	int ret;
 
@@ -788,7 +788,7 @@ EXPORT_SYMBOL_GPL(skl_ipc_set_dx);
 int skl_ipc_init_instance(struct sst_generic_ipc *ipc,
 		struct skl_ipc_init_instance_msg *msg, void *param_data)
 {
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	struct sst_ipc_message request;
 	int ret;
 	u32 *buffer = (u32 *)param_data;
@@ -829,8 +829,8 @@ EXPORT_SYMBOL_GPL(skl_ipc_init_instance);
 int skl_ipc_bind_unbind(struct sst_generic_ipc *ipc,
 		struct skl_ipc_bind_unbind_msg *msg)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	u8 bind_unbind = msg->bind ? IPC_MOD_BIND : IPC_MOD_UNBIND;
 	int ret;
 
@@ -867,7 +867,7 @@ EXPORT_SYMBOL_GPL(skl_ipc_bind_unbind);
 int skl_ipc_load_modules(struct sst_generic_ipc *ipc,
 				u8 module_cnt, void *data)
 {
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	struct sst_ipc_message request;
 	int ret;
 
@@ -891,7 +891,7 @@ EXPORT_SYMBOL_GPL(skl_ipc_load_modules);
 int skl_ipc_unload_modules(struct sst_generic_ipc *ipc, u8 module_cnt,
 							void *data)
 {
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	struct sst_ipc_message request;
 	int ret;
 
@@ -915,7 +915,7 @@ EXPORT_SYMBOL_GPL(skl_ipc_unload_modules);
 int skl_ipc_set_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg, u32 *param)
 {
-	struct skl_ipc_header header = {0};
+	struct skl_ipc_header header = {};
 	struct sst_ipc_message request;
 	int ret = 0;
 	size_t sz_remaining, tx_size, data_offset;
@@ -972,8 +972,8 @@ int skl_ipc_get_large_config(struct sst_generic_ipc *ipc,
 		struct skl_ipc_large_config_msg *msg,
 		u32 **payload, size_t *bytes)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request, reply = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request, reply = {};
 	unsigned int *buf;
 	int ret;
 
@@ -1015,8 +1015,8 @@ EXPORT_SYMBOL_GPL(skl_ipc_get_large_config);
 int skl_sst_ipc_load_library(struct sst_generic_ipc *ipc,
 				u8 dma_id, u8 table_id, bool wait)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret = 0;
 
 	header.primary = IPC_MSG_TARGET(IPC_FW_GEN_MSG);
@@ -1040,8 +1040,8 @@ EXPORT_SYMBOL_GPL(skl_sst_ipc_load_library);
 
 int skl_ipc_set_d0ix(struct sst_generic_ipc *ipc, struct skl_ipc_d0ix_msg *msg)
 {
-	struct skl_ipc_header header = {0};
-	struct sst_ipc_message request = {0};
+	struct skl_ipc_header header = {};
+	struct sst_ipc_message request = {};
 	int ret;
 
 	header.primary = IPC_MSG_TARGET(IPC_MOD_MSG);
diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index b036852d6889..3399c32cd6ab 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1524,7 +1524,7 @@ static int skl_tplg_mic_control_set(struct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_dapm_widget *w = snd_soc_dapm_kcontrol_widget(kcontrol);
 	struct skl_module_cfg *mconfig = w->priv;
-	struct skl_mic_sel_config mic_cfg = {0};
+	struct skl_mic_sel_config mic_cfg = {};
 	struct soc_enum *ec = (struct soc_enum *)kcontrol->private_value;
 	u32 ch_type = *((u32 *)ec->dobj.private);
 	const int *list;
diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 625724852a7f..51fbef50e55e 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -1108,7 +1108,7 @@ int q6afe_set_lpass_clock(struct device *dev, int clk_id, int attri,
 			  int clk_root, unsigned int freq)
 {
 	struct q6afe *afe = dev_get_drvdata(dev->parent);
-	struct afe_clk_set cset = {0,};
+	struct afe_clk_set cset = {};
 
 	cset.clk_set_minor_version = AFE_API_VERSION_CLOCK_SET;
 	cset.clk_id = clk_id;
@@ -1127,9 +1127,9 @@ int q6afe_port_set_sysclk(struct q6afe_port *port, int clk_id,
 			  int clk_src, int clk_root,
 			  unsigned int freq, int dir)
 {
-	struct afe_clk_cfg ccfg = {0,};
-	struct afe_clk_set cset = {0,};
-	struct afe_digital_clk_cfg dcfg = {0,};
+	struct afe_clk_cfg ccfg = {};
+	struct afe_clk_set cset = {};
+	struct afe_digital_clk_cfg dcfg = {};
 	int ret;
 
 	switch (clk_id) {
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index c1f9f0f58464..43989ea8c3b1 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -206,7 +206,7 @@ static int hda_link_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	struct sof_intel_hda_stream *hda_stream;
-	struct hda_pipe_params p_params = {0};
+	struct hda_pipe_params p_params = {};
 	struct hdac_ext_link *link;
 	int stream_tag;
 	int ret;
diff --git a/sound/usb/mixer_s1810c.c b/sound/usb/mixer_s1810c.c
index 0255089c9efb..2b76b0168e2f 100644
--- a/sound/usb/mixer_s1810c.c
+++ b/sound/usb/mixer_s1810c.c
@@ -135,7 +135,7 @@ static int
 snd_s1810c_send_ctl_packet(struct usb_device *dev, u32 a,
 			   u32 b, u32 c, u32 d, u32 e)
 {
-	struct s1810c_ctl_packet pkt = { 0 };
+	struct s1810c_ctl_packet pkt = { };
 	int ret = 0;
 
 	pkt.fixed1 = SC1810C_CMD_F1;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9c3e343b7d87..c9fe6a78a8f8 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1175,7 +1175,7 @@ static int do_run(int argc, char **argv)
 {
 	char *data_fname_in = NULL, *data_fname_out = NULL;
 	char *ctx_fname_in = NULL, *ctx_fname_out = NULL;
-	struct bpf_prog_test_run_attr test_attr = {0};
+	struct bpf_prog_test_run_attr test_attr = {};
 	const unsigned int default_size = SZ_32K;
 	void *data_in = NULL, *data_out = NULL;
 	void *ctx_in = NULL, *ctx_out = NULL;
@@ -1375,7 +1375,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 		.relaxed_maps = relaxed_maps,
 	);
-	struct bpf_object_load_attr load_attr = { 0 };
+	struct bpf_object_load_attr load_attr = { };
 	enum bpf_attach_type expected_attach_type;
 	struct map_replace *map_replace = NULL;
 	struct bpf_program *prog = NULL, *pos;
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 57890b357f85..ecd037ccb1f5 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -148,8 +148,8 @@ extern struct btf_id_set name;
 #define BTF_ID_UNUSED
 #define BTF_ID_LIST_GLOBAL(name) u32 name[1];
 #define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
-#define BTF_SET_START(name) static struct btf_id_set name = { 0 };
-#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
+#define BTF_SET_START(name) static struct btf_id_set name = { };
+#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { };
 #define BTF_SET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 88d8825fc6f6..dbac4da11b6c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9924,7 +9924,7 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
 				     const struct perf_buffer_opts *opts)
 {
 	struct perf_buffer_params p = {};
-	struct perf_event_attr attr = { 0, };
+	struct perf_event_attr attr = { };
 
 	attr.config = PERF_COUNT_SW_BPF_OUTPUT;
 	attr.type = PERF_TYPE_SOFTWARE;
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index dc9b7dd314b0..35a9282789af 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -150,7 +150,7 @@ int orc_create(struct objtool_file *file)
 	/* Build a deduplicated list of ORC entries: */
 	INIT_LIST_HEAD(&orc_list);
 	for_each_sec(file, sec) {
-		struct orc_entry orc, prev_orc = {0};
+		struct orc_entry orc, prev_orc = {};
 		struct instruction *insn;
 		bool empty = true;
 
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 58b7069c5a5f..e56fec632417 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -313,7 +313,7 @@ static bool arm_spe__is_memory_event(enum arm_spe_sample_type type)
 
 static u64 arm_spe__synth_data_source(const struct arm_spe_record *record)
 {
-	union perf_mem_data_src	data_src = { 0 };
+	union perf_mem_data_src	data_src = { };
 
 	if (record->op == ARM_SPE_LD)
 		data_src.mem_op = PERF_MEM_OP_LOAD;
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index ba0f20853651..69393852a40b 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -295,7 +295,7 @@ struct bpf_counter_ops bpf_program_profiler_ops = {
 
 static bool bperf_attr_map_compatible(int attr_map_fd)
 {
-	struct bpf_map_info map_info = {0};
+	struct bpf_map_info map_info = {};
 	__u32 map_info_len = sizeof(map_info);
 	int err;
 
diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index bf9fd3549a1d..ca7624dadc80 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -775,7 +775,7 @@ int isst_send_mbox_command(unsigned int cpu, unsigned char command,
 {
 	const char *pathname = "/dev/isst_interface";
 	int fd, retry;
-	struct isst_if_mbox_cmds mbox_cmds = { 0 };
+	struct isst_if_mbox_cmds mbox_cmds = { };
 
 	debug_printf(
 		"mbox_send: cpu:%d command:%x sub_command:%x parameter:%x req_data:%x\n",
diff --git a/tools/testing/selftests/bpf/prog_tests/perf_branches.c b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
index 12c4f45cee1a..3e4e2671a86e 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_branches.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_branches.c
@@ -101,7 +101,7 @@ static void test_perf_branches_common(int perf_fd,
 
 static void test_perf_branches_hw(void)
 {
-	struct perf_event_attr attr = {0};
+	struct perf_event_attr attr = {};
 	int duration = 0;
 	int pfd;
 
@@ -142,7 +142,7 @@ static void test_perf_branches_hw(void)
  */
 static void test_perf_branches_no_hw(void)
 {
-	struct perf_event_attr attr = {0};
+	struct perf_event_attr attr = {};
 	int duration = 0;
 	int pfd;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index aee41547e7f4..657a05b84c7d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -146,7 +146,7 @@ static int make_socket(int sotype, const char *ip, int port,
 static int make_server(int sotype, const char *ip, int port,
 		       struct bpf_program *reuseport_prog)
 {
-	struct sockaddr_storage addr = {0};
+	struct sockaddr_storage addr = {};
 	const int one = 1;
 	int err, fd = -1;
 
@@ -222,7 +222,7 @@ static int make_server(int sotype, const char *ip, int port,
 
 static int make_client(int sotype, const char *ip, int port)
 {
-	struct sockaddr_storage addr = {0};
+	struct sockaddr_storage addr = {};
 	int err, fd;
 
 	fd = make_socket(sotype, ip, port, &addr);
@@ -357,11 +357,11 @@ static void v4_to_v6(struct sockaddr_storage *ss)
 static int udp_recv_send(int server_fd)
 {
 	char cmsg_buf[CMSG_SPACE(sizeof(struct sockaddr_storage))];
-	struct sockaddr_storage _src_addr = { 0 };
+	struct sockaddr_storage _src_addr = { };
 	struct sockaddr_storage *src_addr = &_src_addr;
 	struct sockaddr_storage *dst_addr = NULL;
-	struct msghdr msg = { 0 };
-	struct iovec iov = { 0 };
+	struct msghdr msg = { };
+	struct iovec iov = { };
 	struct cmsghdr *cm;
 	char buf[1];
 	int ret, fd;
@@ -948,7 +948,7 @@ static void test_drop_on_lookup(struct test_sk_lookup *skel)
 
 static void drop_on_reuseport(const struct test *t)
 {
-	struct sockaddr_storage dst = { 0 };
+	struct sockaddr_storage dst = { };
 	int client, server1, server2, err;
 	struct bpf_link *lookup_link;
 	ssize_t n;
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
index 7a0d64fdc192..5ee8d67edc1d 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_ktls.c
@@ -38,7 +38,7 @@ static int disconnect(int fd)
 /* Disconnect (unhash) a kTLS socket after removing it from sockmap. */
 static void test_sockmap_ktls_disconnect_after_delete(int family, int map)
 {
-	struct sockaddr_storage addr = {0};
+	struct sockaddr_storage addr = {};
 	socklen_t len = sizeof(addr);
 	int err, cli, srv, zero = 0;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
index 5c5979046523..5c61c2ffbd67 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
@@ -786,7 +786,7 @@ static void *connect_accept_thread(void *arg)
 
 static void test_syn_recv_insert_delete(int family, int sotype, int mapfd)
 {
-	struct connect_accept_ctx ctx = { 0 };
+	struct connect_accept_ctx ctx = { };
 	struct sockaddr_storage addr;
 	socklen_t len;
 	u32 zero = 0;
@@ -849,7 +849,7 @@ static void *listen_thread(void *arg)
 
 static void test_race_insert_listen(int family, int socktype, int mapfd)
 {
-	struct connect_accept_ctx ctx = { 0 };
+	struct connect_accept_ctx ctx = { };
 	const u32 zero = 0;
 	const int one = 1;
 	pthread_t t;
diff --git a/tools/testing/selftests/bpf/progs/test_sk_assign.c b/tools/testing/selftests/bpf/progs/test_sk_assign.c
index 1ecd987005d2..ac2106816abb 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_assign.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_assign.c
@@ -90,7 +90,7 @@ get_tuple(struct __sk_buff *skb, bool *ipv4, bool *tcp)
 static inline int
 handle_udp(struct __sk_buff *skb, struct bpf_sock_tuple *tuple, bool ipv4)
 {
-	struct bpf_sock_tuple ln = {0};
+	struct bpf_sock_tuple ln = {};
 	struct bpf_sock *sk;
 	const int zero = 0;
 	size_t tuple_len;
@@ -122,7 +122,7 @@ handle_udp(struct __sk_buff *skb, struct bpf_sock_tuple *tuple, bool ipv4)
 static inline int
 handle_tcp(struct __sk_buff *skb, struct bpf_sock_tuple *tuple, bool ipv4)
 {
-	struct bpf_sock_tuple ln = {0};
+	struct bpf_sock_tuple ln = {};
 	struct bpf_sock *sk;
 	const int zero = 0;
 	size_t tuple_len;
@@ -162,7 +162,7 @@ handle_tcp(struct __sk_buff *skb, struct bpf_sock_tuple *tuple, bool ipv4)
 SEC("classifier/sk_assign_test")
 int bpf_sk_assign_test(struct __sk_buff *skb)
 {
-	struct bpf_sock_tuple *tuple, ln = {0};
+	struct bpf_sock_tuple *tuple, ln = {};
 	bool ipv4 = false;
 	bool tcp = false;
 	int tuple_len;
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
index 134768f6b788..00c7501f216a 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_vlan.c
@@ -107,7 +107,7 @@ int  xdp_prognum0(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
-	struct parse_pkt pkt = { 0 };
+	struct parse_pkt pkt = { };
 
 	if (!parse_eth_frame(data, data_end, &pkt))
 		return XDP_ABORTED;
@@ -149,7 +149,7 @@ int  xdp_prognum1(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
-	struct parse_pkt pkt = { 0 };
+	struct parse_pkt pkt = { };
 
 	if (!parse_eth_frame(data, data_end, &pkt))
 		return XDP_ABORTED;
@@ -183,7 +183,7 @@ int  xdp_prognum2(struct xdp_md *ctx)
 {
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
-	struct parse_pkt pkt = { 0 };
+	struct parse_pkt pkt = { };
 	char *dest;
 
 	if (!parse_eth_frame(data, data_end, &pkt))
@@ -243,7 +243,7 @@ int  xdp_prognum3(struct xdp_md *ctx)
 	void *data_end = (void *)(long)ctx->data_end;
 	void *data     = (void *)(long)ctx->data;
 	struct ethhdr *orig_eth = data;
-	struct parse_pkt pkt = { 0 };
+	struct parse_pkt pkt = { };
 
 	if (!parse_eth_frame(orig_eth, data_end, &pkt))
 		return XDP_ABORTED;
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index eefd445b96fc..898f765ab6ad 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -552,7 +552,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		    struct msg_stats *s, bool tx,
 		    struct sockmap_options *opt)
 {
-	struct msghdr msg = {0}, msg_peek = {0};
+	struct msghdr msg = {}, msg_peek = {};
 	int err, i, flags = MSG_NOSIGNAL;
 	bool drop = opt->drop_expected;
 	bool data = opt->data_test;
@@ -714,7 +714,7 @@ static int sendmsg_test(struct sockmap_options *opt)
 {
 	float sent_Bps = 0, recvd_Bps = 0;
 	int rx_fd, txpid, rxpid, err = 0;
-	struct msg_stats s = {0};
+	struct msg_stats s = {};
 	int iov_count = opt->iov_count;
 	int iov_buf = opt->iov_length;
 	int rx_status, tx_status;
@@ -1888,7 +1888,7 @@ static int test_selftest(int cg_fd, struct sockmap_options *opt)
 int main(int argc, char **argv)
 {
 	int iov_count = 1, length = 1024, rate = 1;
-	struct sockmap_options options = {0};
+	struct sockmap_options options = {};
 	int opt, longindex, err, cg_fd = 0;
 	char *bpf_file = BPF_SOCKMAP_FILENAME;
 	int test = SELFTESTS;
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index 4a39304cc5a6..af7bbc4f6bde 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -72,7 +72,7 @@ int main(int argc, char **argv)
 	const char *file = "test_tcpnotify_kern.o";
 	struct bpf_map *perf_map, *global_map;
 	struct perf_buffer_opts pb_opts = {};
-	struct tcpnotify_globals g = {0};
+	struct tcpnotify_globals g = {};
 	struct perf_buffer *pb = NULL;
 	const char *cg_path = "/foo";
 	int prog_fd, rv, cg_fd = -1;
diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
index 842d9155d36c..4f0cd9997e1d 100644
--- a/tools/testing/selftests/bpf/xdping.c
+++ b/tools/testing/selftests/bpf/xdping.c
@@ -35,7 +35,7 @@ static void cleanup(int sig)
 
 static int get_stats(int fd, __u16 count, __u32 raddr)
 {
-	struct pinginfo pinginfo = { 0 };
+	struct pinginfo pinginfo = { };
 	char inaddrbuf[INET_ADDRSTRLEN];
 	struct in_addr inaddr;
 	__u16 i;
@@ -90,7 +90,7 @@ int main(int argc, char **argv)
 	struct addrinfo *a, hints = { .ai_family = AF_INET };
 	struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
 	__u16 count = XDPING_DEFAULT_COUNT;
-	struct pinginfo pinginfo = { 0 };
+	struct pinginfo pinginfo = { };
 	const char *optstr = "c:I:NsS";
 	struct bpf_program *main_prog;
 	int prog_fd = -1, map_fd = -1;
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index c19a97dd02d4..c5913ef31766 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -821,7 +821,7 @@ struct tcp_server_args {
 static int tcp_server(const char *cgroup, void *arg)
 {
 	struct tcp_server_args *srv_args = arg;
-	struct sockaddr_in6 saddr = { 0 };
+	struct sockaddr_in6 saddr = { };
 	socklen_t slen = sizeof(saddr);
 	int sk, client_sk, ctl_fd, yes = 1, ret = -1;
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 0315955ff0f4..961898f653e0 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -358,7 +358,7 @@ static void *binder_version_thread(void *data)
 {
 	struct __test_metadata *_metadata = _thread_metadata;
 	int fd = PTR_TO_INT(data);
-	struct binder_version version = { 0 };
+	struct binder_version version = { };
 	int ret;
 
 	ret = ioctl(fd, BINDER_VERSION, &version);
diff --git a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
index 65ede506305c..fe242cbee479 100644
--- a/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
+++ b/tools/testing/selftests/filesystems/epoll/epoll_wakeup_test.c
@@ -473,7 +473,7 @@ TEST(epoll9)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -516,7 +516,7 @@ TEST(epoll10)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -559,7 +559,7 @@ TEST(epoll11)
 {
 	pthread_t emitter;
 	struct epoll_event events[2];
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -608,7 +608,7 @@ TEST(epoll12)
 {
 	pthread_t emitter;
 	struct epoll_event events[2];
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -657,7 +657,7 @@ TEST(epoll13)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -700,7 +700,7 @@ TEST(epoll14)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -743,7 +743,7 @@ TEST(epoll15)
 {
 	pthread_t emitter;
 	struct epoll_event events[2];
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -792,7 +792,7 @@ TEST(epoll16)
 {
 	pthread_t emitter;
 	struct epoll_event events[2];
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1195,7 +1195,7 @@ TEST(epoll25)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1247,7 +1247,7 @@ TEST(epoll26)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1299,7 +1299,7 @@ TEST(epoll27)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1351,7 +1351,7 @@ TEST(epoll28)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1403,7 +1403,7 @@ TEST(epoll29)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1454,7 +1454,7 @@ TEST(epoll30)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1505,7 +1505,7 @@ TEST(epoll31)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1556,7 +1556,7 @@ TEST(epoll32)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1607,7 +1607,7 @@ TEST(epoll33)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1659,7 +1659,7 @@ TEST(epoll34)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1711,7 +1711,7 @@ TEST(epoll35)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1763,7 +1763,7 @@ TEST(epoll36)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1816,7 +1816,7 @@ TEST(epoll37)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1873,7 +1873,7 @@ TEST(epoll38)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1930,7 +1930,7 @@ TEST(epoll39)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -1987,7 +1987,7 @@ TEST(epoll40)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2043,7 +2043,7 @@ TEST(epoll41)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2095,7 +2095,7 @@ TEST(epoll42)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2147,7 +2147,7 @@ TEST(epoll43)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2199,7 +2199,7 @@ TEST(epoll44)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2252,7 +2252,7 @@ TEST(epoll45)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2308,7 +2308,7 @@ TEST(epoll46)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2361,7 +2361,7 @@ TEST(epoll47)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2417,7 +2417,7 @@ TEST(epoll48)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2701,7 +2701,7 @@ TEST(epoll53)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2766,7 +2766,7 @@ TEST(epoll54)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2831,7 +2831,7 @@ TEST(epoll55)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2896,7 +2896,7 @@ TEST(epoll56)
 {
 	pthread_t emitter;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -2962,7 +2962,7 @@ TEST(epoll57)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -3032,7 +3032,7 @@ TEST(epoll58)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
@@ -3120,7 +3120,7 @@ TEST(epoll59)
 	pthread_t emitter;
 	struct pollfd pfd;
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 	int i, ret;
 
 	signal(SIGUSR1, signal_handler);
@@ -3228,7 +3228,7 @@ static inline int count_waiters(struct epoll60_ctx *ctx)
 
 TEST(epoll60)
 {
-	struct epoll60_ctx ctx = { 0 };
+	struct epoll60_ctx ctx = { };
 	pthread_t waiters[ARRAY_SIZE(ctx.evfd)];
 	struct epoll_event e;
 	int i, n, ret;
@@ -3460,7 +3460,7 @@ TEST(epoll64)
 {
 	pthread_t waiter[2];
 	struct epoll_event e;
-	struct epoll_mtcontext ctx = { 0 };
+	struct epoll_mtcontext ctx = { };
 
 	signal(SIGUSR1, signal_handler);
 
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index e79c1b64977f..569395e601b3 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -96,7 +96,7 @@ static int handle_uffd_page_request(int uffd_mode, int uffd, uint64_t addr)
 			return r;
 		}
 	} else if (uffd_mode == UFFDIO_REGISTER_MODE_MINOR) {
-		struct uffdio_continue cont = {0};
+		struct uffdio_continue cont = {};
 
 		cont.range.start = addr;
 		cont.range.len = demand_paging_size;
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 10a8ed691c66..b7340506a9bc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -143,7 +143,7 @@ int vcpu_enable_cap(struct kvm_vm *vm, uint32_t vcpu_id,
 
 void vm_enable_dirty_ring(struct kvm_vm *vm, uint32_t ring_size)
 {
-	struct kvm_enable_cap cap = { 0 };
+	struct kvm_enable_cap cap = { };
 
 	cap.cap = KVM_CAP_DIRTY_LOG_RING;
 	cap.args[0] = ring_size;
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
index e0b2bb1339b1..3920a4aa4b53 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_clock.c
@@ -252,7 +252,7 @@ int main(void)
 
 		/* Reset kvmclock triggering TSC page update */
 		if (stage == 7 || stage == 8 || stage == 10) {
-			struct kvm_clock_data clock = {0};
+			struct kvm_clock_data clock = {};
 
 			vm_ioctl(vm, KVM_SET_CLOCK, &clock);
 		}
diff --git a/tools/testing/selftests/kvm/x86_64/hyperv_features.c b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
index 91d88aaa9899..aab4bfe275c8 100644
--- a/tools/testing/selftests/kvm/x86_64/hyperv_features.c
+++ b/tools/testing/selftests/kvm/x86_64/hyperv_features.c
@@ -180,7 +180,7 @@ static void guest_test_msrs_access(struct kvm_vm *vm, struct msr_data *msr,
 	struct kvm_cpuid_entry2 dbg = {
 		.function = HYPERV_CPUID_SYNDBG_PLATFORM_CAPABILITIES
 	};
-	struct kvm_enable_cap cap = {0};
+	struct kvm_enable_cap cap = {};
 
 	run = vcpu_state(vm, VCPU_ID);
 
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index 04ed975662c9..61e9fbdd391a 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -144,7 +144,7 @@ static void guest_main(void)
 
 static void clear_kvm_cpuid_features(struct kvm_cpuid2 *cpuid)
 {
-	struct kvm_cpuid_entry2 ent = {0};
+	struct kvm_cpuid_entry2 ent = {};
 
 	ent.function = KVM_CPUID_FEATURES;
 	TEST_ASSERT(set_cpuid(cpuid, &ent),
@@ -206,7 +206,7 @@ static void enter_guest(struct kvm_vm *vm)
 
 int main(void)
 {
-	struct kvm_enable_cap cap = {0};
+	struct kvm_enable_cap cap = {};
 	struct kvm_cpuid2 *best;
 	struct kvm_vm *vm;
 
diff --git a/tools/testing/selftests/net/ip_defrag.c b/tools/testing/selftests/net/ip_defrag.c
index f9ed749fd8c7..dd78a1105328 100644
--- a/tools/testing/selftests/net/ip_defrag.c
+++ b/tools/testing/selftests/net/ip_defrag.c
@@ -408,7 +408,7 @@ static void run_test(struct sockaddr *addr, socklen_t alen, bool ipv6)
 
 static void run_test_v4(void)
 {
-	struct sockaddr_in addr = {0};
+	struct sockaddr_in addr = {};
 
 	addr.sin_family = AF_INET;
 	addr.sin_port = htons(cfg_port);
@@ -419,7 +419,7 @@ static void run_test_v4(void)
 
 static void run_test_v6(void)
 {
-	struct sockaddr_in6 addr = {0};
+	struct sockaddr_in6 addr = {};
 
 	addr.sin6_family = AF_INET6;
 	addr.sin6_port = htons(cfg_port);
diff --git a/tools/testing/selftests/net/ipv6_flowlabel.c b/tools/testing/selftests/net/ipv6_flowlabel.c
index a7c41375374f..bf62cc6ce5c9 100644
--- a/tools/testing/selftests/net/ipv6_flowlabel.c
+++ b/tools/testing/selftests/net/ipv6_flowlabel.c
@@ -38,8 +38,8 @@ static uint32_t cfg_label	= 1;
 static void do_send(int fd, bool with_flowlabel, uint32_t flowlabel)
 {
 	char control[CMSG_SPACE(sizeof(flowlabel))] = {0};
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	int ret;
 
 	iov.iov_base = (char *)cfg_data;
@@ -75,8 +75,8 @@ static void do_recv(int fd, bool with_flowlabel, uint32_t expect)
 {
 	char control[CMSG_SPACE(sizeof(expect))];
 	char data[sizeof(cfg_data)];
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	struct cmsghdr *cm;
 	uint32_t flowlabel;
 	int ret;
diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c
index bdc03a2097e8..bdadd7562570 100644
--- a/tools/testing/selftests/net/msg_zerocopy.c
+++ b/tools/testing/selftests/net/msg_zerocopy.c
@@ -482,7 +482,7 @@ static void do_tx(int domain, int type, int protocol)
 {
 	struct iovec iov[3] = { {0} };
 	struct sockaddr_ll laddr;
-	struct msghdr msg = {0};
+	struct msghdr msg = {};
 	struct ethhdr eth;
 	union {
 		struct ipv6hdr ip6h;
diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 3653d6468c67..ad3f1153b535 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -62,7 +62,7 @@ static uint32_t cfg_max_num_members;
  * @return -1 if mode is bad, a valid socket otherwise */
 static int sock_fanout_open(uint16_t typeflags, uint16_t group_id)
 {
-	struct sockaddr_ll addr = {0};
+	struct sockaddr_ll addr = {};
 	struct fanout_args args;
 	int fd, val, err;
 
diff --git a/tools/testing/selftests/net/psock_snd.c b/tools/testing/selftests/net/psock_snd.c
index 7d15e10a9fb6..35bc9f8bdf4c 100644
--- a/tools/testing/selftests/net/psock_snd.c
+++ b/tools/testing/selftests/net/psock_snd.c
@@ -169,7 +169,7 @@ static int build_packet(int payload_len)
 
 static void do_bind(int fd)
 {
-	struct sockaddr_ll laddr = {0};
+	struct sockaddr_ll laddr = {};
 
 	laddr.sll_family = AF_PACKET;
 	laddr.sll_protocol = htons(ETH_P_IP);
@@ -197,7 +197,7 @@ static void do_send(int fd, char *buf, int len)
 	if (cfg_use_bind) {
 		ret = write(fd, buf, len);
 	} else {
-		struct sockaddr_ll laddr = {0};
+		struct sockaddr_ll laddr = {};
 
 		laddr.sll_protocol = htons(ETH_P_IP);
 		laddr.sll_ifindex = if_nametoindex(cfg_ifname);
@@ -251,7 +251,7 @@ static int do_tx(void)
 static int setup_rx(void)
 {
 	struct timeval tv = { .tv_usec = 100 * 1000 };
-	struct sockaddr_in raddr = {0};
+	struct sockaddr_in raddr = {};
 	int fd;
 
 	fd = socket(PF_INET, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/net/reuseport_addr_any.c b/tools/testing/selftests/net/reuseport_addr_any.c
index b8475cb29be7..294229df33b9 100644
--- a/tools/testing/selftests/net/reuseport_addr_any.c
+++ b/tools/testing/selftests/net/reuseport_addr_any.c
@@ -34,8 +34,8 @@ static const int PORT = 8888;
 static void build_rcv_fd(int family, int proto, int *rcv_fds, int count,
 			 const char *addr_str)
 {
-	struct sockaddr_in  addr4 = {0};
-	struct sockaddr_in6 addr6 = {0};
+	struct sockaddr_in  addr4 = {};
+	struct sockaddr_in6 addr6 = {};
 	struct sockaddr *addr;
 	int opt, i, sz;
 
@@ -100,10 +100,10 @@ static void build_rcv_fd(int family, int proto, int *rcv_fds, int count,
 
 static int connect_and_send(int family, int proto)
 {
-	struct sockaddr_in  saddr4 = {0};
-	struct sockaddr_in  daddr4 = {0};
-	struct sockaddr_in6 saddr6 = {0};
-	struct sockaddr_in6 daddr6 = {0};
+	struct sockaddr_in  saddr4 = {};
+	struct sockaddr_in  daddr4 = {};
+	struct sockaddr_in6 saddr6 = {};
+	struct sockaddr_in6 daddr6 = {};
 	struct sockaddr *saddr, *daddr;
 	int fd, sz;
 
diff --git a/tools/testing/selftests/net/so_txtime.c b/tools/testing/selftests/net/so_txtime.c
index 59067f64b775..f07e5519e95c 100644
--- a/tools/testing/selftests/net/so_txtime.c
+++ b/tools/testing/selftests/net/so_txtime.c
@@ -73,8 +73,8 @@ static uint64_t gettime_ns(clockid_t clock)
 static void do_send_one(int fdt, struct timed_send *ts)
 {
 	char control[CMSG_SPACE(sizeof(uint64_t))];
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	struct cmsghdr *cm;
 	uint64_t tdeliver;
 	int ret;
@@ -156,8 +156,8 @@ static int do_recv_errqueue_timeout(int fdt)
 		  sizeof(struct udphdr) + 1];
 	struct sock_extended_err *err;
 	int ret, num_tstamp = 0;
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	struct cmsghdr *cm;
 	int64_t tstamp = 0;
 
@@ -263,7 +263,7 @@ static void start_time_wait(void)
 static void setsockopt_txtime(int fd)
 {
 	struct sock_txtime so_txtime_val = { .clockid = cfg_clockid };
-	struct sock_txtime so_txtime_val_read = { 0 };
+	struct sock_txtime so_txtime_val_read = { };
 	socklen_t vallen = sizeof(so_txtime_val);
 
 	so_txtime_val.flags = SOF_TXTIME_REPORT_ERRORS;
diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.c b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
index 9c55ec44fc43..68f67929d46a 100644
--- a/tools/testing/selftests/net/tcp_fastopen_backup_key.c
+++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.c
@@ -90,8 +90,8 @@ static void set_keys(int fd, uint32_t *keys)
 
 static void build_rcv_fd(int family, int proto, int *rcv_fds)
 {
-	struct sockaddr_in  addr4 = {0};
-	struct sockaddr_in6 addr6 = {0};
+	struct sockaddr_in  addr4 = {};
+	struct sockaddr_in6 addr6 = {};
 	struct sockaddr *addr;
 	int opt = 1, i, sz;
 	int qlen = 100;
@@ -142,10 +142,10 @@ static void build_rcv_fd(int family, int proto, int *rcv_fds)
 
 static int connect_and_send(int family, int proto)
 {
-	struct sockaddr_in  saddr4 = {0};
-	struct sockaddr_in  daddr4 = {0};
-	struct sockaddr_in6 saddr6 = {0};
-	struct sockaddr_in6 daddr6 = {0};
+	struct sockaddr_in  saddr4 = {};
+	struct sockaddr_in  daddr4 = {};
+	struct sockaddr_in6 saddr6 = {};
+	struct sockaddr_in6 daddr6 = {};
 	struct sockaddr *saddr, *daddr;
 	int fd, sz, ret;
 	char data[1];
diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
index 710ac956bdb3..fb081ed01128 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/net/toeplitz.c
@@ -252,7 +252,7 @@ static void process_rings(void)
 
 static char *setup_ring(int fd)
 {
-	struct tpacket_req3 req3 = {0};
+	struct tpacket_req3 req3 = {};
 	void *ring;
 
 	req3.tp_retire_blk_tov = cfg_timeout_msec;
@@ -336,7 +336,7 @@ static int create_ring(char **ring)
 		.type_flags = PACKET_FANOUT_CPU,
 		.max_num_members = RSS_MAX_CPUS
 	};
-	struct sockaddr_ll ll = { 0 };
+	struct sockaddr_ll ll = { };
 	int fd, val;
 
 	fd = socket(PF_PACKET, SOCK_DGRAM, 0);
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index c66da6ffd6d8..d42ba0959d6e 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -452,8 +452,8 @@ static bool send_one(int fd, int len, int gso_len,
 		     struct sockaddr *addr, socklen_t alen)
 {
 	char control[CMSG_SPACE(sizeof(uint16_t))] = {0};
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	struct cmsghdr *cm;
 
 	iov.iov_base = buf;
@@ -618,7 +618,7 @@ static void run_test(struct sockaddr *addr, socklen_t alen)
 
 static void run_test_v4(void)
 {
-	struct sockaddr_in addr = {0};
+	struct sockaddr_in addr = {};
 
 	addr.sin_family = AF_INET;
 	addr.sin_port = htons(cfg_port);
@@ -629,7 +629,7 @@ static void run_test_v4(void)
 
 static void run_test_v6(void)
 {
-	struct sockaddr_in6 addr = {0};
+	struct sockaddr_in6 addr = {};
 
 	addr.sin6_family = AF_INET6;
 	addr.sin6_port = htons(cfg_port);
diff --git a/tools/testing/selftests/net/udpgso_bench_rx.c b/tools/testing/selftests/net/udpgso_bench_rx.c
index 76a24052f4b4..4488a576a4a3 100644
--- a/tools/testing/selftests/net/udpgso_bench_rx.c
+++ b/tools/testing/selftests/net/udpgso_bench_rx.c
@@ -215,8 +215,8 @@ static void do_verify_udp(const char *data, int len)
 static int recv_msg(int fd, char *buf, int len, int *gso_size)
 {
 	char control[CMSG_SPACE(sizeof(uint16_t))] = {0};
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	struct cmsghdr *cmsg;
 	uint16_t *gsosizeptr;
 	int ret;
diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
index 17512a43885e..151b4ebfe1d4 100644
--- a/tools/testing/selftests/net/udpgso_bench_tx.c
+++ b/tools/testing/selftests/net/udpgso_bench_tx.c
@@ -211,7 +211,7 @@ static void flush_errqueue_recv(int fd)
 	char control[CMSG_SPACE(sizeof(struct scm_timestamping)) +
 		     CMSG_SPACE(sizeof(struct sock_extended_err)) +
 		     CMSG_SPACE(sizeof(struct sockaddr_in6))] = {0};
-	struct msghdr msg = {0};
+	struct msghdr msg = {};
 	struct cmsghdr *cmsg;
 	int ret;
 
@@ -238,7 +238,7 @@ static void flush_errqueue_recv(int fd)
 static void flush_errqueue(int fd, const bool do_poll)
 {
 	if (do_poll) {
-		struct pollfd fds = {0};
+		struct pollfd fds = {};
 		int ret;
 
 		fds.fd = fd;
@@ -319,7 +319,7 @@ static int send_udp_sendmmsg(int fd, char *data)
 	memset(mmsgs, 0, sizeof(mmsgs));
 
 	if (cfg_tx_tstamp) {
-		struct msghdr msg = {0};
+		struct msghdr msg = {};
 		struct cmsghdr *cmsg;
 
 		msg.msg_control = control;
@@ -374,8 +374,8 @@ static int send_udp_segment(int fd, char *data)
 {
 	char control[CMSG_SPACE(sizeof(cfg_gso_size)) +
 		     CMSG_SPACE(sizeof(cfg_tx_ts))] = {0};
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 	size_t msg_controllen;
 	struct cmsghdr *cmsg;
 	int ret;
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 22558524f71c..b05bd3446213 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -237,7 +237,7 @@ static int child_fdinfo_nspid_test(void *args)
 static void test_pidfd_fdinfo_nspid(void)
 {
 	struct child a, b;
-	struct error err = {0, };
+	struct error err = {};
 	const char *test_name = "pidfd check for NSpid in fdinfo";
 
 	/* Create a new child in a new pid and mount namespace */
@@ -270,7 +270,7 @@ static void test_pidfd_fdinfo_nspid(void)
 static void test_pidfd_dead_fdinfo(void)
 {
 	struct child a;
-	struct error err = {0, };
+	struct error err = {};
 	const char *test_name = "pidfd check fdinfo for dead process";
 
 	/* Create a new child in a new pid and mount namespace */
diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index 5cebfb356345..8075e021c047 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -80,7 +80,7 @@ static int uevent_listener(unsigned long post_flags, bool expect_uevent,
 	socklen_t sk_addr_len;
 	int fret = -1, rcv_buf_sz = __UEVENT_BUFFER_SIZE;
 	uint64_t sync_add = 1;
-	struct sockaddr_nl sk_addr = { 0 }, rcv_addr = { 0 };
+	struct sockaddr_nl sk_addr = { }, rcv_addr = { };
 	char buf[__UEVENT_BUFFER_SIZE] = { 0 };
 	struct iovec iov = { buf, __UEVENT_BUFFER_SIZE };
 	char control[CMSG_SPACE(sizeof(struct ucred))];
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index fe043f67798b..c1e679c189c5 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -83,7 +83,7 @@ void *gup_thread(void *data)
 
 int main(int argc, char **argv)
 {
-	struct gup_test gup = { 0 };
+	struct gup_test gup = { };
 	int filed, i, opt, nr_pages = 1, thp = -1, write = 1, nthreads = 1, ret;
 	int flags = MAP_PRIVATE, touch = 0;
 	char *file = "/dev/zero";
diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 10ab56c2484a..604d58cb28db 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1092,7 +1092,7 @@ static int userfaultfd_events_test(void)
 	int err, features;
 	pid_t pid;
 	char c;
-	struct uffd_stats stats = { 0 };
+	struct uffd_stats stats = { };
 
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
@@ -1147,7 +1147,7 @@ static int userfaultfd_sig_test(void)
 	int err, features;
 	pid_t pid;
 	char c;
-	struct uffd_stats stats = { 0 };
+	struct uffd_stats stats = { };
 
 	printf("testing signal delivery: ");
 	fflush(stdout);
@@ -1208,7 +1208,7 @@ static int userfaultfd_minor_test(void)
 	uint8_t expected_byte;
 	void *expected_page;
 	char c;
-	struct uffd_stats stats = { 0 };
+	struct uffd_stats stats = { };
 	uint64_t req_features, features_out;
 
 	if (!test_uffdio_minor)
diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 67766bfe176f..ea40753dd48a 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -304,8 +304,8 @@ static void test_seqpacket_msg_bounds_server(const struct test_opts *opts)
 {
 	int fd;
 	char buf[16];
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 
 	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
 	if (fd < 0) {
@@ -354,8 +354,8 @@ static void test_seqpacket_msg_trunc_server(const struct test_opts *opts)
 {
 	int fd;
 	char buf[MESSAGE_TRUNC_SZ / 2];
-	struct msghdr msg = {0};
-	struct iovec iov = {0};
+	struct msghdr msg = {};
+	struct iovec iov = {};
 
 	fd = vsock_seqpacket_accept(VMADDR_CID_ANY, 1234, NULL);
 	if (fd < 0) {
-- 
2.30.2

