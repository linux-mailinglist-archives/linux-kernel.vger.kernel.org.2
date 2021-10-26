Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481E743AC76
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbhJZGyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbhJZGyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:54:03 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FD7C061243
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 23:51:39 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:3ceb:3f52:2846:9a21])
        by baptiste.telenet-ops.be with bizsmtp
        id AWrc2600M4Ahxzd01WrcZc; Tue, 26 Oct 2021 08:51:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfGJ6-007wut-8w
        for linux-kernel@vger.kernel.org; Tue, 26 Oct 2021 08:51:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfGJ5-009p8B-56
        for linux-kernel@vger.kernel.org; Tue, 26 Oct 2021 08:51:35 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.15-rc7
Date:   Tue, 26 Oct 2021 08:51:35 +0200
Message-Id: <20211026065135.2341456-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.15-rc7[1] compared to v5.14[2].

Summarized:
  - build errors: +7/-12
  - build warnings: +16/-288

JFYI, when comparing v5.15-rc7[1] to v5.15-rc6[3], the summaries are:
  - build errors: +0/-2
  - build warnings: +0/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/3906fe9bb7f1a2c8667ae54e967dc8690824f4ea/ (90 out of 182 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7d2a07b769330c34b4deabeed939325c77a7ec2f/ (all 182 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/519d81956ee277b4419c723adfb154603c2565ba/ (90 out of 182 configs)


*** ERRORS ***

7 error regressions:
  + /kisskb/src/drivers/tty/serial/cpm_uart/cpm_uart_core.c: error: 'udbg_cpm_getc' defined but not used [-Werror=unused-function]:  => 1109:12
  + /kisskb/src/drivers/tty/serial/cpm_uart/cpm_uart_core.c: error: 'udbg_cpm_putc' defined but not used [-Werror=unused-function]:  => 1095:13
  + /kisskb/src/drivers/tty/serial/sunzilog.c: error: 'sunzilog_putchar' defined but not used [-Werror=unused-function]:  => 1128:13
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]:  => 970:13, 842:13, 1496:33, 842:41, 970:41, 1496:12
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]:  => 1497:48, 1497:27, 971:28, 843:28, 971:56, 843:56
  + /kisskb/src/drivers/video/fbdev/riva/fbdev.c: error: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Werror=discarded-qualifiers]:  => 2062:11, 2095:11
  + /kisskb/src/lib/xxhash.c: error: the frame size of 1624 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]:  => 236:1

12 error improvements:
  - /kisskb/src/drivers/dma/idxd/init.c: error: implicit declaration of function 'cpu_feature_enabled' [-Werror=implicit-function-declaration]: 815:7 => 
  - /kisskb/src/drivers/dma/idxd/perfmon.h: error: 'struct perf_event' has no member named 'pmu': 35:13, 24:13 => 
  - /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'boot_cpu_has' [-Werror=implicit-function-declaration]: 74:6 => 
  - /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_eax' [-Werror=implicit-function-declaration]: 64:18 => 
  - /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_ebx' [-Werror=implicit-function-declaration]: 17:31 => 
  - /kisskb/src/include/linux/compiler_attributes.h: error: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Werror=undef]: 29:29 => 
  - /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1854' declared with attribute error: FIELD_PREP: value too large for the field: 328:38 => 
  - /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1861' declared with attribute error: FIELD_PREP: value too large for the field: 328:38 => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5100), (.head.text+0x5040) => 
  - error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) => 
  - error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0xc), (.fixup+0x4) => 
  - error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text': (.fixup+0x10), (.fixup+0x28), (.fixup+0x1c), (.fixup+0x34), (.fixup+0x4) => 


*** WARNINGS ***

16 warning regressions:
  + /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' reading 6 bytes from a region of size 0 [-Wstringop-overread]:  => 72:25
  + /kisskb/src/block/genhd.c: warning: the frame size of 1640 bytes is larger than 1536 bytes [-Wframe-larger-than=]:  => 1192:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1672 bytes is larger than 1536 bytes [-Wframe-larger-than=]:  => 1192:1
  + /kisskb/src/lib/xxhash.c: warning: the frame size of 1616 bytes is larger than 1536 bytes [-Wframe-larger-than=]:  => 236:1
  + /opt/cross/kisskb/korg/gcc-5.5.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/5.5.0/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 170:24, 102:21
  + /opt/cross/kisskb/korg/gcc-5.5.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/5.5.0/plugin/include/config/rs6000/option-defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 42:20
  + /opt/cross/kisskb/korg/gcc-5.5.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/5.5.0/plugin/include/config/rs6000/sysv4.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 411:24
  + /opt/cross/kisskb/korg/gcc-5.5.0-nolibc/powerpc64-linux/bin/../lib/gcc/powerpc64-linux/5.5.0/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]:  => 126:24
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x108): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x120): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x138): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x150): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x168): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x180): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x198): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:test_print:  => N/A

288 warning improvements:
  - .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT: 13081, 13076, 13094 => 13223, 13236
  - .config: warning: override: reassigning to symbol PPC_64K_PAGES: 13449 => 
  - .config: warning: override: reassigning to symbol SMP: 4189 => 
  - .config: warning: override: reassigning to symbol VIRTUALIZATION: 4189 => 
  - /kisskb/src/arch/arm/crypto/ghash-ce-glue.c: warning: passing argument 4 of 'pmull_ghash_update_p64' from incompatible pointer type: 67:44 => 
  - /kisskb/src/arch/arm/crypto/ghash-ce-glue.c: warning: passing argument 4 of 'pmull_ghash_update_p8' from incompatible pointer type: 69:43 => 
  - /kisskb/src/arch/m68k/include/asm/raw_io.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 30:32, 20:19 => 
  - /kisskb/src/arch/m68k/mvme147/config.c: warning: #warning check me! [-Wcpp]: 174:2 => 
  - /kisskb/src/arch/m68k/mvme16x/config.c: warning: #warning check me! [-Wcpp]: 439:2 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_CLEAR" redefined: 261, 261:0 => 
  - /kisskb/src/arch/mips/include/asm/sibyte/bcm1480_scd.h: warning: "M_SPC_CFG_ENABLE" redefined: 262:0, 262 => 
  - /kisskb/src/arch/nds32/kernel/setup.c: warning: unused variable 'region' [-Wunused-variable]: 247:26 => 
  - /kisskb/src/arch/parisc/math-emu/fpudispatch.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 815:3, 728:3, 408:3, 410:5, 890:5, 637:5, 368:5, 453:5, 755:5, 1021:5, 483:5, 817:5, 329:18, 300:3, 860:5, 305:5, 438:5, 312:18, 314:18, 345:18, 336:5, 938:7, 1042:8, 875:5, 574:5, 468:5, 905:5, 830:5, 766:5, 661:5, 361:18, 744:5, 521:7, 359:18, 771:18, 1030:5, 733:5, 625:5, 760:18, 777:5, 749:18, 738:18, 498:5, 423:5, 845:5, 320:5, 343:18, 327:18, 649:5, 1075:5, 352:5 => 
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation: 189:1 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_cf.c: warning: 'cfdiag_push_sample' uses dynamic stack allocation: 651:1 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation: 1145:1 => 
  - /kisskb/src/arch/s390/kernel/syscall.c: warning: '__do_syscall' uses dynamic stack allocation: 168:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1181:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1181:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1680 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 1181:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1712 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 1181:1 => 
  - /kisskb/src/block/mq-deadline.c: warning: 'dd_queued' defined but not used [-Wunused-function]: 274:12 => 
  - /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: (near initialization for 'parent_data[0]') [-Wmissing-braces]: 524:9 => 
  - /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: missing braces around initializer [-Wmissing-braces]: 524:9 => 
  - /kisskb/src/drivers/crypto/sa2ul.c: warning: (near initialization for 'ad.enc_eng') [-Wmissing-braces]: 1899:9, 1886:9, 969:9, 1644:9, 1001:9, 1628:9, 1660:9, 949:9, 987:9 => 
  - /kisskb/src/drivers/crypto/sa2ul.c: warning: missing braces around initializer [-Wmissing-braces]: 1660:9, 1628:9, 987:9, 949:9, 1886:9, 1644:9, 969:9, 1001:9, 1899:9 => 
  - /kisskb/src/drivers/cxl/core.c: warning: (near initialization for '(anonymous).hdm_decoder') [-Wmissing-braces]: 567:17 => 
  - /kisskb/src/drivers/cxl/core.c: warning: (near initialization for '(anonymous).status') [-Wmissing-braces]: 831:17 => 
  - /kisskb/src/drivers/cxl/core.c: warning: missing braces around initializer [-Wmissing-braces]: 831:17, 567:17 => 
  - /kisskb/src/drivers/firmware/qcom_scm-legacy.c: warning: (near initialization for 'smc.args') [-Wmissing-braces]: 139:9 => 
  - /kisskb/src/drivers/firmware/qcom_scm-legacy.c: warning: missing braces around initializer [-Wmissing-braces]: 139:9 => 
  - /kisskb/src/drivers/firmware/qcom_scm-smc.c: warning: (near initialization for 'smc.args') [-Wmissing-braces]: 95:9 => 
  - /kisskb/src/drivers/firmware/qcom_scm-smc.c: warning: missing braces around initializer [-Wmissing-braces]: 95:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c: warning: (near initialization for 'params.triggers') [-Wmissing-braces]: 104:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_psr.c: warning: missing braces around initializer [-Wmissing-braces]: 104:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c: warning: (near initialization for 'dummy_record.record_header') [-Wmissing-braces]: 297:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c: warning: missing braces around initializer [-Wmissing-braces]: 297:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: (near initialization for 'clock_table.DcfClocks') [-Wmissing-braces]: 934:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 934:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]: 213:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: missing braces around initializer [-Wmissing-braces]: 213:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]: 707:15 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]: 131:10, 118:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 118:11, 707:15, 131:10 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]: 402:15 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]: 179:10, 157:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 402:15, 179:10, 157:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_smu.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]: 240:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn31/dcn31_smu.c: warning: missing braces around initializer [-Wmissing-braces]: 240:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]: 3433:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]: 2688:11, 2874:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: missing braces around initializer [-Wmissing-braces]: 3433:8, 2688:11, 2874:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'dpcd_pattern_period[0]') [-Wmissing-braces]: 3086:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'dpcd_test_mode.bits') [-Wmissing-braces]: 3084:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]: 4464:11, 4508:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: missing braces around initializer [-Wmissing-braces]: 4508:11, 3086:8, 3084:8, 4464:11 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'data.inbox0_cmd_common') [-Wmissing-braces]: 58:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 58:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_crtc_timing[0]') [-Wmissing-braces]: 1992:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]: 1853:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]: 1853:9, 1992:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]: 1278:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: missing braces around initializer [-Wmissing-braces]: 1278:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]: 1230:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]: 1230:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]: 451:15 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'ddc_init_data.id') [-Wmissing-braces]: 3725:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]: 451:15, 3725:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]: 258:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]: 258:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: (near initialization for 'warmup_params.start_address') [-Wmissing-braces]: 266:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]: 266:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c: warning: (near initialization for 'ddc_init_data.id') [-Wmissing-braces]: 2541:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c: warning: missing braces around initializer [-Wmissing-braces]: 2541:9 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn20.c: warning: (near initialization for 'boot_options.bits') [-Wmissing-braces]: 393:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn20.c: warning: missing braces around initializer [-Wmissing-braces]: 393:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn31.c: warning: (near initialization for 'boot_options.bits') [-Wmissing-braces]: 320:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_dcn31.c: warning: missing braces around initializer [-Wmissing-braces]: 320:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv_stat.c: warning: (near initialization for 'cmd.cmd_common') [-Wmissing-braces]: 54:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv_stat.c: warning: missing braces around initializer [-Wmissing-braces]: 54:8 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c: warning: overflow in conversion from 'int' to '__s8' {aka 'signed char'} changes value from '-251' to '5' [-Woverflow]: 60:21 => 
  - /kisskb/src/drivers/gpu/drm/rockchip/cdn-dp-core.c: warning: 'cdn_dp_resume' defined but not used [-Wunused-function]: 1126:12 => 
  - /kisskb/src/drivers/gpu/drm/xlnx/zynqmp_dp.c: warning: (near initialization for 'opts.mipi_dphy') [-Wmissing-braces]: 667:9 => 
  - /kisskb/src/drivers/gpu/drm/xlnx/zynqmp_dp.c: warning: missing braces around initializer [-Wmissing-braces]: 667:9 => 
  - /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2128 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 98:1 => 
  - /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 98:1 => 
  - /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2152 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 98:1 => 
  - /kisskb/src/drivers/input/joystick/analog.c: warning: #warning Precise timer not defined for this architecture. [-Wcpp]: 160:2 => 
  - /kisskb/src/drivers/media/i2c/imx334.c: warning: (near initialization for 'msgs[0]') [-Wmissing-braces]: 288:9 => 
  - /kisskb/src/drivers/media/i2c/imx334.c: warning: missing braces around initializer [-Wmissing-braces]: 288:9 => 
  - /kisskb/src/drivers/mtd/nand/raw/mpc5121_nfc.c: warning: unused variable 'mtd' [-Wunused-variable]: 294:19 => 
  - /kisskb/src/drivers/net/can/usb/etas_es58x/es58x_fd.c: warning: (near initialization for 'tx_conf_msg.nominal_bittiming') [-Wmissing-braces]: 400:9 => 
  - /kisskb/src/drivers/net/can/usb/etas_es58x/es58x_fd.c: warning: missing braces around initializer [-Wmissing-braces]: 400:9 => 
  - /kisskb/src/drivers/net/dsa/sja1105/sja1105_spi.c: warning: (near initialization for 'xfers[0]') [-Wmissing-braces]: 40:9 => 
  - /kisskb/src/drivers/net/dsa/sja1105/sja1105_spi.c: warning: missing braces around initializer [-Wmissing-braces]: 40:9 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '____alloc_ei_netdev' defined but not used [-Wunused-function]: 995:27 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_close' defined but not used [-Wunused-function]: 233:12 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_get_stats' defined but not used [-Wunused-function]: 857:33 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_open' defined but not used [-Wunused-function]: 204:12 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_poll' defined but not used [-Wunused-function]: 512:13 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_set_multicast_list' defined but not used [-Wunused-function]: 957:13 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_start_xmit' defined but not used [-Wunused-function]: 303:20 => 
  - /kisskb/src/drivers/net/ethernet/8390/lib8390.c: warning: '__ei_tx_timeout' defined but not used [-Wunused-function]: 257:13 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq" redefined: 2133 => 
  - /kisskb/src/drivers/net/ethernet/broadcom/bnxt/bnxt.h: warning: "writeq_relaxed" redefined: 2141 => 
  - /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/sge.c: warning: (near initialization for 'buf[0]') [-Wmissing-braces]: 910:9 => 
  - /kisskb/src/drivers/net/ethernet/chelsio/cxgb4/sge.c: warning: missing braces around initializer [-Wmissing-braces]: 910:9 => 
  - /kisskb/src/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation: 444:1 => 
  - /kisskb/src/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c: warning: (near initialization for 'acl_entry.list') [-Wmissing-braces]: 2945:9 => 
  - /kisskb/src/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c: warning: missing braces around initializer [-Wmissing-braces]: 2945:9 => 
  - /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc.c: warning: (near initialization for 'xdp_redirect_arr[0]') [-Wmissing-braces]: 1078:9 => 
  - /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc.c: warning: (near initialization for 'xdp_tx_arr[0]') [-Wmissing-braces]: 1245:9 => 
  - /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc.c: warning: missing braces around initializer [-Wmissing-braces]: 1078:9, 1245:9 => 
  - /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc_pf.c: warning: (near initialization for 'rfse.smac_h') [-Wmissing-braces]: 1136:9 => 
  - /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc_pf.c: warning: missing braces around initializer [-Wmissing-braces]: 1136:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]: 845:9, 774:9, 631:9, 681:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]: 775:9, 846:9, 682:9, 632:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: missing braces around initializer [-Wmissing-braces]: 774:9, 631:9, 682:9, 775:9, 845:9, 846:9, 632:9, 681:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_req.hdr') [-Wmissing-braces]: 888:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_rsp.hdr') [-Wmissing-braces]: 889:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dis_req.hdr') [-Wmissing-braces]: 1238:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dummy.packet') [-Wmissing-braces]: 996:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'free_req.hdr') [-Wmissing-braces]: 871:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'write_req.hdr') [-Wmissing-braces]: 994:9, 1303:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: missing braces around initializer [-Wmissing-braces]: 888:9, 996:9, 871:9, 889:9, 1303:9, 1238:9, 994:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'alloc_req.hdr') [-Wmissing-braces]: 144:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'alloc_rsp.hdr') [-Wmissing-braces]: 145:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'free_req.hdr') [-Wmissing-braces]: 198:9, 147:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]: 13:9, 41:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]: 42:9, 14:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: (near initialization for 'uninstall_req.hdr') [-Wmissing-braces]: 197:9, 146:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c: warning: missing braces around initializer [-Wmissing-braces]: 42:9, 13:9, 145:9, 146:9, 197:9, 14:9, 198:9, 144:9, 147:9, 41:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: warning: (near initialization for 'm_entry.list') [-Wmissing-braces]: 52:9 => 
  - /kisskb/src/drivers/net/ethernet/marvell/prestera/prestera_flower.c: warning: missing braces around initializer [-Wmissing-braces]: 52:9 => 
  - /kisskb/src/drivers/net/ethernet/mscc/ocelot_vcap.c: warning: (near initialization for 'etype.value') [-Wmissing-braces]: 755:11 => 
  - /kisskb/src/drivers/net/ethernet/mscc/ocelot_vcap.c: warning: missing braces around initializer [-Wmissing-braces]: 755:11 => 
  - /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation: 1092:1 => 
  - /kisskb/src/drivers/net/phy/dp83640_reg.h: warning: "PAGE0" redefined: 8 => 
  - /kisskb/src/drivers/parisc/dino.c: warning: 'pci_dev_is_behind_card_dino' defined but not used [-Wunused-function]: 160:12 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation: 317:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation: 331:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation: 590:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation: 216:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation: 282:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation: 359:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation: 303:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation: 85:1 => 
  - /kisskb/src/drivers/soc/qcom/pdr_interface.c: warning: (near initialization for 'req.service_path') [-Wmissing-braces]: 572:9 => 
  - /kisskb/src/drivers/soc/qcom/pdr_interface.c: warning: missing braces around initializer [-Wmissing-braces]: 572:9 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.39' uses dynamic stack allocation: 481:1 => 
  - /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation: 2887:1 => 
  - /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 3136 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 2207:1 => 
  - /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 3168 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 2207:1 => 
  - /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 3176 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 2207:1 => 
  - /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 7192 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 2367:1 => 
  - /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 7208 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 2367:1 => 
  - /kisskb/src/drivers/thunderbolt/test.c: warning: the frame size of 7264 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 2367:1 => 
  - /kisskb/src/drivers/tty/serial/sunzilog.c: warning: 'sunzilog_putchar' defined but not used [-Wunused-function]: 1128:13 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]: 1496:12, 842:13, 970:13 => 
  - /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 843:28, 1497:27, 971:28 => 
  - /kisskb/src/drivers/video/fbdev/nvidia/nvidia.c: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]: 1414:10, 1439:10 => 
  - /kisskb/src/drivers/video/fbdev/riva/fbdev.c: warning: passing argument 1 of 'iounmap' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]: 2059:11, 2092:11 => 
  - /kisskb/src/drivers/virtio/virtio_vdpa.c: warning: (near initialization for 'state.<anonymous>') [-Wmissing-braces]: 146:9 => 
  - /kisskb/src/drivers/virtio/virtio_vdpa.c: warning: missing braces around initializer [-Wmissing-braces]: 146:9 => 
  - /kisskb/src/fs/btrfs/tree-checker.c: warning: (near initialization for 'ri.inode') [-Wmissing-braces]: 1071:9 => 
  - /kisskb/src/fs/btrfs/tree-checker.c: warning: missing braces around initializer [-Wmissing-braces]: 1071:9 => 
  - /kisskb/src/fs/cifs/connect.c: warning: (near initialization for 'mount_id.b') [-Wmissing-braces]: 3466:2 => 
  - /kisskb/src/fs/cifs/connect.c: warning: missing braces around initializer [-Wmissing-braces]: 3466:2 => 
  - /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation: 719:1 => 
  - /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2208 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 1311:1 => 
  - /kisskb/src/include/linux/compiler_attributes.h: warning: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Wundef]: 29:29 => 
  - /kisskb/src/include/linux/err.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 22:49 => 
  - /kisskb/src/include/linux/minmax.h: warning: comparison of distinct pointer types lacks a cast: 20:28 => 
  - /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.13' uses dynamic stack allocation: 238:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.28' uses dynamic stack allocation: 3750:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation: 1833:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation: 1437:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation: 1547:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation: 1578:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation: 1496:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation: 1515:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation: 1288:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation: 1478:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation: 1376:1 => 
  - /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation: 9389:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation: 8576:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation: 8872:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation: 8128:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation: 7906:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation: 8783:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation: 8284:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation: 8005:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation: 7525:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation: 8668:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation: 7812:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_text_poke_output' uses dynamic stack allocation: 8990:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation: 9063:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation: 8609:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation: 8738:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation: 10548:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation: 9703:1 => 
  - /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation: 295:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation: 313:1 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation: 763:1 => 
  - /kisskb/src/kernel/trace/trace_osnoise.c: warning: 'main' is usually a function [-Wmain]: 1515:8 => 
  - /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation: 331:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2128 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 437:1, 530:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2144 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 530:1, 437:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2464 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 437:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2472 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 437:1, 530:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2480 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 530:1, 437:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2488 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 437:1, 530:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2512 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 530:1, 437:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2616 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2640 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2952 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2960 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2976 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 2992 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_scanf.c: warning: the frame size of 3008 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 488:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation: 255:15 => 
  - /kisskb/src/lib/xxhash.c: warning: the frame size of 1656 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 236:1 => 
  - /kisskb/src/lib/xxhash.c: warning: the frame size of 1672 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 236:1 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1192 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1393:1 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1384 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2051:1 => 
  - /kisskb/src/lib/zstd/compress.c: warning: the frame size of 1432 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 2262:1 => 
  - /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation: 2821:1 => 
  - /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation: 3144:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.64' uses dynamic stack allocation: 2357:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.63' uses dynamic stack allocation: 2067:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.62' uses dynamic stack allocation: 2425:1 => 
  - /kisskb/src/mm/z3fold.c: warning: 'z3fold_reclaim_page.constprop' uses dynamic stack allocation: 1475:1 => 
  - /kisskb/src/net/bridge/br_netlink.c: warning: 'br_fill_linkxstats' uses dynamic stack allocation: 1755:1 => 
  - /kisskb/src/net/bridge/br_vlan.c: warning: 'br_vlan_fill_vids' uses dynamic stack allocation: 1725:1 => 
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation: 1821:1 => 
  - /kisskb/src/net/openvswitch/actions.c: warning: (near initialization for 'ovs_rt.dst') [-Wmissing-braces]: 831:10 => 
  - /kisskb/src/net/openvswitch/actions.c: warning: missing braces around initializer [-Wmissing-braces]: 831:10 => 
  - /kisskb/src/net/sched/sch_frag.c: warning: (near initialization for 'sch_frag_rt.dst') [-Wmissing-braces]: 93:10 => 
  - /kisskb/src/net/sched/sch_frag.c: warning: missing braces around initializer [-Wmissing-braces]: 93:10 => 
  - /kisskb/src/security/landlock/ruleset.c: warning: passing argument 2 of 'create_rule' from incompatible pointer type: 196:34 => 
  - /kisskb/src/security/landlock/ruleset.c: warning: passing argument 3 of 'insert_rule' from incompatible pointer type: 300:47, 330:5, 240:38 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.4/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 102:21, 170:24 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/4.9.4/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 126:24 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/mips-linux/bin/../lib/gcc/mips-linux/4.9.4/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 102:21, 170:24 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/mips-linux/bin/../lib/gcc/mips-linux/4.9.4/plugin/include/config/mips/mips.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 2791:20 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/mips-linux/bin/../lib/gcc/mips-linux/4.9.4/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 126:24 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/s390-linux/bin/../lib/gcc/s390-linux/4.9.4/plugin/include/config/elfos.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 102:21, 170:24 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/s390-linux/bin/../lib/gcc/s390-linux/4.9.4/plugin/include/config/s390/s390.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 836:20 => 
  - /opt/cross/kisskb/korg/gcc-4.9.4-nolibc/s390-linux/bin/../lib/gcc/s390-linux/4.9.4/plugin/include/defaults.h: warning: invalid suffix on literal; C++11 requires a space between literal and string macro [-Wliteral-suffix]: 126:24 => 
  - arch/powerpc/configs/mpc885_ads_defconfig: warning: override: reassigning to symbol IPV6: 79 => 
  - modpost: WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version ...: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x140): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x158): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x170): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x188): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1a0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1b8): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1d0): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
