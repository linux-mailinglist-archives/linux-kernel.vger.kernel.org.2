Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87143A5F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhFNJdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 05:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbhFNJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 05:33:12 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BEDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 02:31:10 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:2079:619d:d324:afb5])
        by laurent.telenet-ops.be with bizsmtp
        id GxX62500Y43wVUJ01xX6n8; Mon, 14 Jun 2021 11:31:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lsivy-00H2kv-EJ
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 11:31:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lsivy-003bsH-1v
        for linux-kernel@vger.kernel.org; Mon, 14 Jun 2021 11:31:06 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.13-rc6
Date:   Mon, 14 Jun 2021 11:31:06 +0200
Message-Id: <20210614093106.860453-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.13-rc6[1] compared to v5.12[2].

Summarized:
  - build errors: +0/-6
  - build warnings: +47/-29

JFYI, when comparing v5.13-rc6[1] to v5.13-rc5[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +1/-0

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/009c9aa5be652675a06d5211e1640e02bbb1c33d/ (189 out of 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9f4ad9e425a1d3b6a34617b8ea226d56a119a717/ (all 192 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/614124bea77e452aa6df7a8714e8bc820b489922/ (191 out of 192 configs)


*** ERRORS ***

6 error improvements:
  - error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!: N/A => 
  - error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!: N/A => 
  - {standard input}: Error: inappropriate arguments for opcode 'adc': 170 => 


*** WARNINGS ***

47 warning regressions:
  + /kisskb/src/arch/s390/kernel/syscall.c: warning: '__do_syscall' uses dynamic stack allocation:  => 169:1
  + /kisskb/src/arch/s390/kernel/traps.c: warning: '__do_pgm_check' uses dynamic stack allocation:  => 359:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1112 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1227:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1120 bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 1227:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1680 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1227:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1712 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1227:1
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]:  => 3392:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c: warning: missing braces around initializer [-Wmissing-braces]: 2483:11, 2664:11 => 2625:11, 3392:8, 2810:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_crtc_timing[0]') [-Wmissing-braces]:  => 1953:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]: 1802:9 => 1953:9, 1814:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv_stat.c: warning: (near initialization for 'cmd.cmd_common') [-Wmissing-braces]:  => 61:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dmub/src/dmub_srv_stat.c: warning: missing braces around initializer [-Wmissing-braces]:  => 61:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: warning: (near initialization for 'info.head') [-Wmissing-braces]:  => 610:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: warning: missing braces around initializer [-Wmissing-braces]:  => 610:9
  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2288 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 98:1
  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2320 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 98:1
  + /kisskb/src/drivers/iio/test/iio-test-format.c: warning: the frame size of 2336 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 98:1
  + /kisskb/src/drivers/net/can/usb/etas_es58x/es58x_fd.c: warning: (near initialization for 'tx_conf_msg.nominal_bittiming') [-Wmissing-braces]:  => 400:9
  + /kisskb/src/drivers/net/can/usb/etas_es58x/es58x_fd.c: warning: missing braces around initializer [-Wmissing-braces]:  => 400:9
  + /kisskb/src/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c: warning: (near initialization for 'acl_entry.list') [-Wmissing-braces]:  => 2945:9
  + /kisskb/src/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2945:9
  + /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc.c: warning: (near initialization for 'xdp_redirect_arr[0]') [-Wmissing-braces]:  => 1078:9
  + /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc.c: warning: (near initialization for 'xdp_tx_arr[0]') [-Wmissing-braces]:  => 1245:9
  + /kisskb/src/drivers/net/ethernet/freescale/enetc/enetc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1078:9, 1245:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]: 604:9 => 654:9, 604:9, 754:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]: 605:9 => 655:9, 755:9, 605:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: missing braces around initializer [-Wmissing-braces]: 604:9, 605:9 => 654:9, 755:9, 604:9, 655:9, 605:9, 754:9
  + /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.13' uses dynamic stack allocation:  => 238:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.28' uses dynamic stack allocation:  => 3693:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.64' uses dynamic stack allocation:  => 2311:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.63' uses dynamic stack allocation:  => 2021:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.62' uses dynamic stack allocation:  => 2379:1
  + /kisskb/src/net/openvswitch/actions.c: warning: (near initialization for 'ovs_rt.dst') [-Wmissing-braces]:  => 830:10
  + /kisskb/src/net/openvswitch/actions.c: warning: missing braces around initializer [-Wmissing-braces]:  => 830:10
  + /kisskb/src/net/sched/sch_frag.c: warning: (near initialization for 'sch_frag_rt.dst') [-Wmissing-braces]:  => 93:10
  + /kisskb/src/net/sched/sch_frag.c: warning: missing braces around initializer [-Wmissing-braces]:  => 93:10
  + /kisskb/src/security/landlock/ruleset.c: warning: passing argument 2 of 'create_rule' from incompatible pointer type:  => 196:34
  + /kisskb/src/security/landlock/ruleset.c: warning: passing argument 3 of 'insert_rule' from incompatible pointer type:  => 240:38, 300:47, 330:5
  + arch/arm64/configs/defconfig: warning: override: reassigning to symbol MTK_PMIC_WRAP:  => 1018
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x13c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x154): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x16c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x184): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x19c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1b4): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1cc): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000:  => N/A
  + modpost: WARNING: modpost: lib/find_bit_benchmark.o(.text.unlikely+0x0): Section mismatch in reference from the (unknown reference) (unknown) to the variable .init.data:bitmap2:  => N/A

29 warning improvements:
  - /kisskb/src/arch/arm/mach-omap1/board-ams-delta.c: warning: 'ams_delta_camera_power' defined but not used [-Wunused-function]: 462:12 => 
  - /kisskb/src/arch/arm/mach-omap1/board-h2.c: warning: 'isp1301_gpiod_table' defined but not used [-Wunused-variable]: 347:34 => 
  - /kisskb/src/arch/m68k/include/asm/raw_io.h: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]: 20:19, 26:31, 33:35, 30:32 => 30:32, 20:19
  - /kisskb/src/arch/sh/kernel/traps.c: warning: unused variable 'cpu' [-Wunused-variable]: 183:15 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1160 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1311:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1168 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 1311:1 => 
  - /kisskb/src/block/genhd.c: warning: the frame size of 1720 bytes is larger than 1280 bytes [-Wframe-larger-than=]: 1311:1 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: warning: (near initialization for 'nv12_metrics.CurrClock') [-Wmissing-braces]: 2297:2 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../pm/swsmu/smu11/navi10_ppt.c: warning: missing braces around initializer [-Wmissing-braces]: 2297:2 => 
  - /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.10' uses dynamic stack allocation: 238:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.26' uses dynamic stack allocation: 3675:1 => 
  - /kisskb/src/kernel/static_call.c: warning: unused variable 'mod' [-Wunused-variable]: 153:18 => 
  - /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 4200 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 93:1 => 
  - /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 4224 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 93:1 => 
  - /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7424 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 93:1 => 
  - /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7432 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 93:1 => 
  - /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7440 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 93:1 => 
  - /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7456 bytes is larger than 2048 bytes [-Wframe-larger-than=]: 93:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.65' uses dynamic stack allocation: 2304:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.64' uses dynamic stack allocation: 2014:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.63' uses dynamic stack allocation: 2372:1 => 
  - modpost: WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol check will be entirely skipped.: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x134): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x14c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x164): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x17c): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x194): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1ac): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 
  - modpost: WARNING: modpost: drivers/net/ethernet/qlogic/qede/qede.o(.data+0x1c4): Section mismatch in reference from the variable qede_forced_speed_maps to the variable .init.rodata:qede_forced_speed_100000: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
