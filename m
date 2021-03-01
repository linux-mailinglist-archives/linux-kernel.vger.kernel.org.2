Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DC327C7B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbhCAKoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbhCAKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:44:10 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10187C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:43:18 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:d15e:6060:f6a9:3ce5])
        by baptiste.telenet-ops.be with bizsmtp
        id ayjH2400B0v3pQi01yjHjZ; Mon, 01 Mar 2021 11:43:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lGg1E-002wqB-Rl
        for linux-kernel@vger.kernel.org; Mon, 01 Mar 2021 11:43:16 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lGg1E-00BbhT-7S
        for linux-kernel@vger.kernel.org; Mon, 01 Mar 2021 11:43:16 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.12-rc1
Date:   Mon,  1 Mar 2021 11:43:16 +0100
Message-Id: <20210301104316.2766484-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.12-rc1[1] compared to v5.11[2].

Summarized:
  - build errors: +2/-0
  - build warnings: +117/-8

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)


*** ERRORS ***

2 error regressions:
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2


*** WARNINGS ***

117 warning regressions:
  + /kisskb/src/arch/m68k/include/asm/page_mm.h: warning: ordered comparison of pointer with null pointer [-Wextra]:  => 174:49
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation:  => 176:1
  + /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: (near initialization for 'parent_data[0]') [-Wmissing-braces]:  => 524:9
  + /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 524:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: (near initialization for 'clock_table.DcfClocks') [-Wmissing-braces]:  => 880:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 880:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 198:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 198:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]:  => 704:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 129:10, 116:11
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 704:15, 116:11, 129:10
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1802:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1802:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 1273:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1273:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1223:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1223:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]:  => 451:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 451:15
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 258:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 258:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: (near initialization for 'warmup_params.start_address') [-Wmissing-braces]:  => 264:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 264:9
  + /kisskb/src/drivers/media/i2c/imx334.c: warning: (near initialization for 'msgs[0]') [-Wmissing-braces]:  => 288:9
  + /kisskb/src/drivers/media/i2c/imx334.c: warning: missing braces around initializer [-Wmissing-braces]:  => 288:9
  + /kisskb/src/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation:  => 444:1
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]:  => 604:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]:  => 605:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 604:9, 605:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_req.hdr') [-Wmissing-braces]:  => 878:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_rsp.hdr') [-Wmissing-braces]:  => 879:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dis_req.hdr') [-Wmissing-braces]:  => 1198:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dummy.packet') [-Wmissing-braces]:  => 974:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'free_req.hdr') [-Wmissing-braces]:  => 861:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'write_req.hdr') [-Wmissing-braces]:  => 1263:9, 972:9
  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1263:9, 972:9, 878:9, 879:9, 1198:9, 861:9, 974:9
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation:  => 1092:1
  + /kisskb/src/drivers/net/phy/phy_device.c: warning: 'mdio_bus_phy_resume' defined but not used [-Wunused-function]:  => 293:12
  + /kisskb/src/drivers/net/phy/phy_device.c: warning: 'mdio_bus_phy_suspend' defined but not used [-Wunused-function]:  => 273:12
  + /kisskb/src/drivers/net/wireless/ath/ath11k/qmi.c: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]:  => 1690:8
  + /kisskb/src/drivers/net/wireless/ath/ath11k/qmi.c: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]:  => 1689:4
  + /kisskb/src/drivers/net/wireless/ath/ath11k/qmi.c: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]:  => 1690:8
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation:  => 317:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation:  => 331:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation:  => 590:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation:  => 216:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation:  => 282:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation:  => 359:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation:  => 303:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation:  => 85:1
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.40' uses dynamic stack allocation:  => 481:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation:  => 2886:1
  + /kisskb/src/fs/btrfs/ref-verify.c: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]:  => 225:1, 221:1
  + /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation:  => 723:1
  + /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 1311:1
  + /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.10' uses dynamic stack allocation:  => 238:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.26' uses dynamic stack allocation:  => 3670:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation:  => 1784:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation:  => 1439:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation:  => 1549:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation:  => 1580:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation:  => 1498:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation:  => 1517:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation:  => 1290:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation:  => 1480:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation:  => 1378:1
  + /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation:  => 9235:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation:  => 8422:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation:  => 8719:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation:  => 7972:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation:  => 7750:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation:  => 8630:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation:  => 8128:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation:  => 7849:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation:  => 7369:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation:  => 8514:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation:  => 7656:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_text_poke_output' uses dynamic stack allocation:  => 8837:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation:  => 8910:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation:  => 8455:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation:  => 8585:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation:  => 10394:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation:  => 9549:1
  + /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation:  => 281:1
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation:  => 300:1
  + /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation:  => 521:1
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
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.64' uses dynamic stack allocation:  => 2304:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.65' uses dynamic stack allocation:  => 2304:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.63' uses dynamic stack allocation:  => 2014:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.64' uses dynamic stack allocation:  => 2014:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.62' uses dynamic stack allocation:  => 2372:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.63' uses dynamic stack allocation:  => 2372:1
  + /kisskb/src/mm/z3fold.c: warning: 'z3fold_reclaim_page.constprop' uses dynamic stack allocation:  => 1471:1
  + /kisskb/src/net/bridge/br_netlink.c: warning: 'br_fill_linkxstats' uses dynamic stack allocation:  => 1753:1
  + /kisskb/src/net/bridge/br_vlan.c: warning: 'br_vlan_fill_vids' uses dynamic stack allocation:  => 1672:1
  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation:  => 1767:1
  + arch/sparc/configs/sparc64_defconfig: warning: override: reassigning to symbol ATA:  => 237
  + arch/sparc/configs/sparc64_defconfig: warning: override: reassigning to symbol HAPPYMEAL:  => 239

8 warning improvements:
  - /kisskb/src/arch/sparc/include/asm/cmpxchg_32.h: warning: value computed is not used [-Wunused-value]: 28:22 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]: 36:8 => 
  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 36:8 => 
  - /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'pdata' [-Wunused-variable]: 1667:28 => 
  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'val' [-Wunused-variable]: 948:6 => 
  - /kisskb/src/drivers/rtc/rtc-rx6110.c: warning: 'rx6110_probe' defined but not used [-Wunused-function]: 314:12 => 
  - warning: unmet direct dependencies detected for COMPAT_BINFMT_ELF: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
