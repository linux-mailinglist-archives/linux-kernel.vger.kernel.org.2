Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9B7363E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 11:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238523AbhDSJQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 05:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbhDSJQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 05:16:22 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D69CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 02:15:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:5116:5b49:cd89:9620])
        by xavier.telenet-ops.be with bizsmtp
        id uZFo2400c33aHnP01ZFoff; Mon, 19 Apr 2021 11:15:49 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lYQ0S-00GDft-KB
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 11:15:48 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lYQ0S-009eWL-41
        for linux-kernel@vger.kernel.org; Mon, 19 Apr 2021 11:15:48 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.12-rc8
Date:   Mon, 19 Apr 2021 11:15:48 +0200
Message-Id: <20210419091548.2300577-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.12-rc8[1] compared to v5.11[2].

Summarized:
  - build errors: +5/-0
  - build warnings: +110/-10

JFYI, when comparing v5.12-rc8[1] to v5.12-rc7[3], the summaries are:
  - build errors: +0/-0
  - build warnings: +0/-2

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bf05bf16c76bb44ab5156223e1e58e26dfe30a88/ (191 out of 193 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 193 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d434405aaab7d0ebc516b68a8fc4100922d7f5ef/ (191 out of 193 configs)


*** ERRORS ***

5 error regressions:
  + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A


*** WARNINGS ***

110 warning regressions:
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation:  => 176:1
  + /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: (near initialization for 'parent_data[0]') [-Wmissing-braces]:  => 524:9
  + /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 524:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: (near initialization for 'clock_table.DcfClocks') [-Wmissing-braces]:  => 880:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 880:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 198:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 198:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]:  => 704:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 116:11, 129:10
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 116:11, 704:15, 129:10
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1802:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1802:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 1273:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1273:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1229:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1229:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]:  => 451:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 451:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 258:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 258:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: (near initialization for 'warmup_params.start_address') [-Wmissing-braces]:  => 264:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 264:9
  + /kisskb/src/drivers/media/i2c/imx334.c: warning: (near initialization for 'msgs[0]') [-Wmissing-braces]:  => 288:9
  + /kisskb/src/drivers/media/i2c/imx334.c: warning: missing braces around initializer [-Wmissing-braces]:  => 288:9
  + /kisskb/src/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation:  => 444:1
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709551584' to '-32' [-Woverflow]:  => 844:2
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in implicit constant conversion [-Woverflow]:  => 844:2
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]:  => 604:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]:  => 605:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 605:9, 604:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_req.hdr') [-Wmissing-braces]:  => 878:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_rsp.hdr') [-Wmissing-braces]:  => 879:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dis_req.hdr') [-Wmissing-braces]:  => 1198:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dummy.packet') [-Wmissing-braces]:  => 974:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'free_req.hdr') [-Wmissing-braces]:  => 861:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'write_req.hdr') [-Wmissing-braces]:  => 1263:9, 972:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: missing braces around initializer [-Wmissing-braces]:  => 878:9, 1198:9, 972:9, 974:9, 1263:9, 879:9, 861:9
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation:  => 1092:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation:  => 317:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation:  => 331:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation:  => 590:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation:  => 216:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation:  => 282:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation:  => 359:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation:  => 303:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation:  => 85:1
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.40' uses dynamic stack allocation:  => 481:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation:  => 2885:1
  + /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation:  => 723:1
  + /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 1311:1
  + /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.10' uses dynamic stack allocation:  => 238:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.26' uses dynamic stack allocation:  => 3675:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation:  => 1789:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation:  => 1439:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation:  => 1549:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation:  => 1580:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation:  => 1498:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation:  => 1517:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation:  => 1290:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation:  => 1480:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation:  => 1378:1
  + /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation:  => 9268:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation:  => 8455:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation:  => 8752:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation:  => 8005:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation:  => 7783:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation:  => 8663:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation:  => 8161:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation:  => 7882:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation:  => 7402:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation:  => 8547:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation:  => 7689:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_text_poke_output' uses dynamic stack allocation:  => 8870:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation:  => 8943:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation:  => 8488:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation:  => 8618:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation:  => 10427:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation:  => 9582:1
  + /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation:  => 281:1
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation:  => 300:1
  + /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation:  => 521:1
  + /kisskb/src/kernel/static_call.c: warning: unused variable 'mod' [-Wunused-variable]:  => 153:18
  + /kisskb/src/lib/bitfield_kunit.c: warning: the frame size of 7424 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 93:1
  + /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation:  => 331:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation:  => 255:15
  + /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation:  => 2768:1
  + /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation:  => 3092:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.65' uses dynamic stack allocation:  => 2304:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.64' uses dynamic stack allocation:  => 2014:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.63' uses dynamic stack allocation:  => 2372:1
  + /kisskb/src/mm/z3fold.c: warning: 'z3fold_reclaim_page.constprop' uses dynamic stack allocation:  => 1485:1
  + /kisskb/src/net/bridge/br_netlink.c: warning: 'br_fill_linkxstats' uses dynamic stack allocation:  => 1753:1
  + /kisskb/src/net/bridge/br_vlan.c: warning: 'br_vlan_fill_vids' uses dynamic stack allocation:  => 1672:1
  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation:  => 1791:1
  + modpost: WARNING: modpost: Symbol info of vmlinux is missing. Unresolved symbol check will be entirely skipped.:  => N/A

10 warning improvements:
  - /kisskb/src/arch/sparc/include/asm/cmpxchg_32.h: warning: value computed is not used [-Wunused-value]: 28:22 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]: 36:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 36:8 => 
  - /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'pdata' [-Wunused-variable]: 1667:28 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'val' [-Wunused-variable]: 948:6 => 
  - /kisskb/src/drivers/rtc/rtc-rx6110.c: warning: 'rx6110_probe' defined but not used [-Wunused-function]: 314:12 => 
  - arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA: 58 => 
  - arch/ia64/configs/generic_defconfig: warning: override: reassigning to symbol ATA_PIIX: 59 => 
  - warning: unmet direct dependencies detected for COMPAT_BINFMT_ELF: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
