Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB543E4119
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbhHIHuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbhHIHuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:50:40 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691CEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 00:50:19 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:85c3:1250:92e5:c526])
        by xavier.telenet-ops.be with bizsmtp
        id fKqH2500S4aJ70U01KqHqx; Mon, 09 Aug 2021 09:50:17 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mD037-000uIi-Fk
        for linux-kernel@vger.kernel.org; Mon, 09 Aug 2021 09:50:17 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mD036-001jmj-Ve
        for linux-kernel@vger.kernel.org; Mon, 09 Aug 2021 09:50:17 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.14-rc5
Date:   Mon,  9 Aug 2021 09:50:16 +0200
Message-Id: <20210809075016.414276-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.14-rc5[1] compared to v5.13+[2].

Summarized:
  - build errors: +13/-0
  - build warnings: +101/-45

JFYI, when comparing v5.14-rc5[1] to v5.14-rc4[3], the summaries are:
  - build errors: +4/-9
  - build warnings: +43/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/36a21d51725af2ce0700c6ebcb6b9594aac658a6/ (182 out of 189 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/66d9282523b3228183b14d9f812872dd2620704d/ (all 189 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c500bee1c5b2f1d59b1081ac879d73268ab0ff17/ (182 out of 189 configs)


*** ERRORS ***

13 error regressions:
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'boot_cpu_has' [-Werror=implicit-function-declaration]:  => 74:6
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_eax' [-Werror=implicit-function-declaration]:  => 64:18
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_ebx' [-Werror=implicit-function-declaration]:  => 17:31
  + /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_HIGH' undeclared (first use in this function):  => 150:20
  + /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_LOW' undeclared (first use in this function):  => 151:35
  + /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'base_address':  => 151:19
  + /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'destid_0_7':  => 152:19
  + /kisskb/src/drivers/pci/controller/vmd.c: error: control reaches end of non-void function [-Werror=return-type]:  => 127:1
  + /kisskb/src/drivers/pci/controller/vmd.c: error: dereferencing pointer to incomplete type 'struct pci_sysdata':  => 700:4
  + /kisskb/src/drivers/pci/controller/vmd.c: error: field 'sysdata' has incomplete type:  => 116:21
  + /kisskb/src/include/linux/compiler_attributes.h: error: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Werror=undef]:  => 29:29
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1857' declared with attribute error: FIELD_PREP: value too large for the field:  => 328:38
  + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1864' declared with attribute error: FIELD_PREP: value too large for the field:  => 328:38


*** WARNINGS ***

101 warning regressions:
  + .config: warning: override: reassigning to symbol GCC_PLUGIN_RANDSTRUCT:  => 11823, 11598
  + .config: warning: override: reassigning to symbol GCC_PLUGIN_SANCOV:  => 11820, 11595
  + /kisskb/src/arch/parisc/math-emu/fpudispatch.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 1042:8, 749:18, 637:5, 498:5, 314:18, 483:5, 875:5, 343:18, 625:5, 830:5, 744:5, 817:5, 408:3, 320:5, 1075:5, 766:5, 410:5, 860:5, 352:5, 661:5, 755:5, 649:5, 728:3, 368:5, 1030:5, 329:18, 423:5, 361:18, 312:18, 468:5, 574:5, 521:7, 760:18, 327:18, 733:5, 336:5, 771:18, 845:5, 938:7, 305:5, 1021:5, 738:18, 300:3, 905:5, 345:18, 890:5, 438:5, 777:5, 815:3, 453:5, 359:18
  + /kisskb/src/arch/s390/kernel/perf_cpum_cf.c: warning: 'cfdiag_push_sample' uses dynamic stack allocation:  => 651:1
  + /kisskb/src/drivers/cxl/core.c: warning: (near initialization for '(anonymous).hdm_decoder') [-Wmissing-braces]:  => 567:17
  + /kisskb/src/drivers/cxl/core.c: warning: (near initialization for '(anonymous).status') [-Wmissing-braces]:  => 831:17
  + /kisskb/src/drivers/cxl/core.c: warning: missing braces around initializer [-Wmissing-braces]:  => 831:17, 567:17
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c: warning: (near initialization for 'params.triggers') [-Wmissing-braces]:  => 104:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 104:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]:  => 402:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 179:10, 157:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 157:11, 179:10, 402:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_smu.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 240:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_smu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 240:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'data.inbox0_cmd_common') [-Wmissing-braces]:  => 58:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 58:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'ddc_init_data.id') [-Wmissing-braces]:  => 3725:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]: 451:15 => 3725:9, 451:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c: warning: (near initialization for 'ddc_init_data.id') [-Wmissing-braces]:  => 2542:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2542:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn31.c: warning: (near initialization for 'boot_options.bits') [-Wmissing-braces]:  => 320:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn31.c: warning: missing braces around initializer [-Wmissing-braces]:  => 320:8
  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2128 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 98:1
  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 98:1
  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2152 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 98:1
  + /kisskb/src/drivers/net/dsa/sja1105/sja1105_spi.c: warning: (near initialization for 'xfers[0]') [-Wmissing-braces]:  => 40:9
  + /kisskb/src/drivers/net/dsa/sja1105/sja1105_spi.c: warning: missing braces around initializer [-Wmissing-braces]:  => 40:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]: 754:9, 654:9, 604:9 => 774:9, 681:9, 845:9, 631:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]: 755:9, 605:9, 655:9 => 682:9, 632:9, 775:9, 846:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: missing braces around initializer [-Wmissing-braces]: 754:9, 755:9, 654:9, 604:9, 655:9, 605:9 => 846:9, 681:9, 682:9, 774:9, 775:9, 632:9, 631:9, 845:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'alloc_req.hdr') [-Wmissing-braces]:  => 144:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'alloc_rsp.hdr') [-Wmissing-braces]:  => 145:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'free_req.hdr') [-Wmissing-braces]:  => 147:9, 198:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]:  => 13:9, 41:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]:  => 42:9, 14:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'uninstall_req.hdr') [-Wmissing-braces]:  => 197:9, 146:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: missing braces around initializer [-Wmissing-braces]:  => 14:9, 145:9, 42:9, 197:9, 13:9, 144:9, 41:9, 147:9, 146:9, 198:9
  + /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: warning: (near initialization for 'm_entry.list') [-Wmissing-braces]:  => 52:9
  + /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: warning: missing braces around initializer [-Wmissing-braces]:  => 52:9
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.39' uses dynamic stack allocation:  => 481:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 2207:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 3168 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 2207:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 3176 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 2207:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 7192 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 2367:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 7208 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 2367:1
  + /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 7264 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 2367:1
  + /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]:  => 1439:10, 1414:10
  + /kisskb/src/drivers/video/fbdev/riva/fbdev.c: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]:  => 2059:11, 2092:11
  + /kisskb/src/drivers/virtio/virtio_vdpa.c: warning: (near initialization for 'state.<anonymous>') [-Wmissing-braces]:  => 146:9
  + /kisskb/src/drivers/virtio/virtio_vdpa.c: warning: missing braces around initializer [-Wmissing-braces]:  => 146:9
  + /kisskb/src/fs/cifs/connect.c: warning: (near initialization for 'mount_id.b') [-Wmissing-braces]:  => 3466:2
  + /kisskb/src/fs/cifs/connect.c: warning: missing braces around initializer [-Wmissing-braces]:  => 3466:2
  + /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2208 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 1311:1
  + /kisskb/src/include/linux/compiler_attributes.h: warning: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Wundef]:  => 29:29
  + /kisskb/src/kernel/trace/trace_osnoise.c: warning: 'main' is usually a function [-Wmain]:  => 1461:8
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2128 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 437:1, 530:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 530:1, 437:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2464 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 437:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2472 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 437:1, 530:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2480 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 530:1, 437:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2488 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 437:1, 530:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2512 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 437:1, 530:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2616 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2952 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 2992 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/test_scanf.c: warning: the frame size of 3008 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 488:1
  + /kisskb/src/lib/xxhash.c: warning: the frame size of 1656 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 236:1
  + /kisskb/src/lib/xxhash.c: warning: the frame size of 1672 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 236:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1393:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1384 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2051:1
  + /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1432 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 2262:1
  + arch/powerpc/configs/mpc885_ads_defconfig: warning: override: reassigning to symbol IPV6:  => 79
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "clear_page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "copy_page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version ...:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x140): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x158): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x170): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x188): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1a0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1b8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1d0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + warning: LSE atomics not supported by binutils:  => N/A
  + warning: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum:  => N/A

45 warning improvements:
  - .config: warning: override: reassigning to symbol GCC_PLUGIN_CYC_COMPLEXITY: 4582, 4553 => 
  - .config: warning: override: reassigning to symbol GCC_PLUGIN_LATENT_ENTROPY: 4584, 4555 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation: 503:1 => 
  - /kisskb/src/arch/s390/kernel/traps.c: warning: '__do_pgm_check' uses dynamic stack allocation: 359:1 => 
  - /kisskb/src/arch/xtensa/include/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]: 173:3 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'params.triggers') [-Wmissing-braces]: 10583:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]: 10583:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: warning: (near initialization for 'info.head') [-Wmissing-braces]: 610:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: warning: missing braces around initializer [-Wmissing-braces]: 610:9 => 
  - /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2288 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 98:1 => 
  - /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2320 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 98:1 => 
  - /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2336 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 98:1 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.40' uses dynamic stack allocation: 481:1 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 542:37, 563:8, 596:5, 580:8, 566:8 => 
  - /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 1311:1 => 
  - /kisskb/src/lib/xxhash.c: warning: the frame size of 1616 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 236:1 => 
  - /kisskb/src/lib/xxhash.c: warning: the frame size of 1624 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 236:1 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1348 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2262:1 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1584 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1393:1 => 
  - arch/arm64/configs/defconfig: warning: override: reassigning to symbol MTK_PMIC_WRAP: 1018 => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x13c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x154): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x16c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x184): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x19c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1b4): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1cc): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - warning: 4 bad relocations: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
