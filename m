Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E105032C437
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382899AbhCDALz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391489AbhCCWhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:37:38 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9704C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 14:36:08 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d20so24871129qkc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 14:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MZiAKt0fbOuaS40adPvM88J6FSXsyizyEwSoVroQaBU=;
        b=t5BPnQ7UuLydx1JxBXBq/mCCIY0zgVkk4PwyAHHZYag5gj55OT4v6Kc+mPFeBps12T
         aF3vl75h/JOgrU8B1hTjlMtLoIfii2XKY3qTBNcSvMMuUnBccBtA3O+Fh7xFi/aKRKwl
         NKnIHRl+TRaWf2jM3Q0MgqRmkCs+kibGVUUAzWjrlRXwjXRWBbVIOspc9/3sqcRKUqxJ
         Hqo0u0R6Gu0F7ndZInDbDh3gF9Q1Rxq1JynWLKWFa1AMhkUH1nDW9unXBwq7s/7Qplr9
         KeVCdHJ23Bq00AkXOiJ8KdlJI1zDC88zQJ1F0YO25DzoxMWGDEBmS+SVaRFCse2iCU/I
         10WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MZiAKt0fbOuaS40adPvM88J6FSXsyizyEwSoVroQaBU=;
        b=MyLFFDxxsMmDtfhSODCDACQH0r9TKY3O4rYchw/akbMLFVeukl3z9eeAH5Xnka3TIQ
         c7ojfGQZHbLS/7JhgULuZpNNSE0UGcnjFW5BmEbkk3+sAgcWluZr/echqCo885EVC9pj
         oU8eY25QCrPkpbc2Ptx8yo/CncnrvMm4NLcn7QRLERdpDaKoRwF1lQDFw2pBh8nhMVeJ
         TstsuklmiccIHhWfLOtoycEZbdwkDJlFkxEUPXCjyn5YNyUprqNFieFwPxKubnNjLJj+
         shHgsirXQi/cv4TFUSBPI0rIJxcgb2mqSW7cawPotXHrXhJ6oL1T0snO5ggaYdN9fadr
         wSRA==
X-Gm-Message-State: AOAM533i65e9gHQVy4rqnDy4trxb+PXJrWs1bPKySo11EfddDHMOsGRZ
        DemG8S0kE3wbntMBxGO2AGk=
X-Google-Smtp-Source: ABdhPJzPkQh1D5inswdwGINBk4rYT8+rI0ZnrUQrzoJY5INVC3v+F7MqMa7aBGdxv0RPUWwbZPKx8A==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr1309375qkm.355.1614810967940;
        Wed, 03 Mar 2021 14:36:07 -0800 (PST)
Received: from Slackware ([156.146.55.196])
        by smtp.gmail.com with ESMTPSA id b10sm217692qtt.23.2021.03.03.14.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 14:36:06 -0800 (PST)
Date:   Thu, 4 Mar 2021 04:05:59 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
Subject: Re: Build regressions/improvements in v5.12-rc1
Message-ID: <YEAPT8eOFQIPdFD8@Slackware>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org
References: <20210301104316.2766484-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FERka9MWYhWRlr/1"
Content-Disposition: inline
In-Reply-To: <20210301104316.2766484-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FERka9MWYhWRlr/1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 11:43 Mon 01 Mar 2021, Geert Uytterhoeven wrote:

If I saw correctly , the tag clearly attached a word with it "dontuse" ...

~Bhaskar


>Below is the list of build error/warning regressions/improvements in
>v5.12-rc1[1] compared to v5.11[2].
>
>Summarized:
>  - build errors: +2/-0
>  - build warnings: +117/-8
>
>Happy fixing! ;-)
>
>Thanks to the linux-next team for providing the build service.
>
>[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8/ (all 192 configs)
>[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f40ddce88593482919761f74910f42f4b84c004b/ (all 192 configs)
>
>
>*** ERRORS ***
>
>2 error regressions:
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 674:2
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 638:2
>
>
>*** WARNINGS ***
>
>117 warning regressions:
>  + /kisskb/src/arch/m68k/include/asm/page_mm.h: warning: ordered comparison of pointer with null pointer [-Wextra]:  => 174:49
>  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation:  => 176:1
>  + /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: (near initialization for 'parent_data[0]') [-Wmissing-braces]:  => 524:9
>  + /kisskb/src/drivers/clk/xilinx/xlnx_vcu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 524:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: (near initialization for 'clock_table.DcfClocks') [-Wmissing-braces]:  => 880:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 880:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 198:8
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: warning: missing braces around initializer [-Wmissing-braces]:  => 198:8
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]:  => 704:15
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]:  => 129:10, 116:11
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 704:15, 116:11, 129:10
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1802:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1802:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 1273:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1273:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: (near initialization for 'hw_locks.bits') [-Wmissing-braces]:  => 1223:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1223:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]:  => 451:15
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 451:15
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 258:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 258:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: (near initialization for 'warmup_params.start_address') [-Wmissing-braces]:  => 264:9
>  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: warning: missing braces around initializer [-Wmissing-braces]:  => 264:9
>  + /kisskb/src/drivers/media/i2c/imx334.c: warning: (near initialization for 'msgs[0]') [-Wmissing-braces]:  => 288:9
>  + /kisskb/src/drivers/media/i2c/imx334.c: warning: missing braces around initializer [-Wmissing-braces]:  => 288:9
>  + /kisskb/src/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation:  => 444:1
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'req.hdr') [-Wmissing-braces]:  => 604:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: (near initialization for 'rsp.hdr') [-Wmissing-braces]:  => 605:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 604:9, 605:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_req.hdr') [-Wmissing-braces]:  => 878:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'cntr_rsp.hdr') [-Wmissing-braces]:  => 879:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dis_req.hdr') [-Wmissing-braces]:  => 1198:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'dummy.packet') [-Wmissing-braces]:  => 974:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'free_req.hdr') [-Wmissing-braces]:  => 861:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: (near initialization for 'write_req.hdr') [-Wmissing-braces]:  => 1263:9, 972:9
>  + /kisskb/src/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1263:9, 972:9, 878:9, 879:9, 1198:9, 861:9, 974:9
>  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation:  => 1092:1
>  + /kisskb/src/drivers/net/phy/phy_device.c: warning: 'mdio_bus_phy_resume' defined but not used [-Wunused-function]:  => 293:12
>  + /kisskb/src/drivers/net/phy/phy_device.c: warning: 'mdio_bus_phy_suspend' defined but not used [-Wunused-function]:  => 273:12
>  + /kisskb/src/drivers/net/wireless/ath/ath11k/qmi.c: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t {aka unsigned int}' [-Wformat=]:  => 1690:8
>  + /kisskb/src/drivers/net/wireless/ath/ath11k/qmi.c: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]:  => 1689:4
>  + /kisskb/src/drivers/net/wireless/ath/ath11k/qmi.c: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]:  => 1690:8
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation:  => 317:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation:  => 331:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation:  => 590:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation:  => 216:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation:  => 282:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation:  => 359:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation:  => 303:1
>  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation:  => 85:1
>  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.40' uses dynamic stack allocation:  => 481:1
>  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation:  => 2886:1
>  + /kisskb/src/fs/btrfs/ref-verify.c: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]:  => 225:1, 221:1
>  + /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation:  => 723:1
>  + /kisskb/src/fs/ntfs/aops.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 1311:1
>  + /kisskb/src/kernel/bpf/cpumap.c: warning: 'cpu_map_bpf_prog_run_xdp.isra.10' uses dynamic stack allocation:  => 238:1
>  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.26' uses dynamic stack allocation:  => 3670:1
>  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation:  => 1784:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation:  => 1439:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation:  => 1549:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation:  => 1580:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation:  => 1498:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation:  => 1517:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation:  => 1290:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation:  => 1480:1
>  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation:  => 1378:1
>  + /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation:  => 9235:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation:  => 8422:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation:  => 8719:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation:  => 7972:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation:  => 7750:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation:  => 8630:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation:  => 8128:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation:  => 7849:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation:  => 7369:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation:  => 8514:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation:  => 7656:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_text_poke_output' uses dynamic stack allocation:  => 8837:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation:  => 8910:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation:  => 8455:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation:  => 8585:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation:  => 10394:1
>  + /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation:  => 9549:1
>  + /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation:  => 281:1
>  + /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation:  => 300:1
>  + /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation:  => 521:1
>  + /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation:  => 331:1
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation:  => 255:15
>  + /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation:  => 2768:1
>  + /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation:  => 3092:1
>  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.64' uses dynamic stack allocation:  => 2304:1
>  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.65' uses dynamic stack allocation:  => 2304:1
>  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.63' uses dynamic stack allocation:  => 2014:1
>  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.64' uses dynamic stack allocation:  => 2014:1
>  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.62' uses dynamic stack allocation:  => 2372:1
>  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.63' uses dynamic stack allocation:  => 2372:1
>  + /kisskb/src/mm/z3fold.c: warning: 'z3fold_reclaim_page.constprop' uses dynamic stack allocation:  => 1471:1
>  + /kisskb/src/net/bridge/br_netlink.c: warning: 'br_fill_linkxstats' uses dynamic stack allocation:  => 1753:1
>  + /kisskb/src/net/bridge/br_vlan.c: warning: 'br_vlan_fill_vids' uses dynamic stack allocation:  => 1672:1
>  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation:  => 1767:1
>  + arch/sparc/configs/sparc64_defconfig: warning: override: reassigning to symbol ATA:  => 237
>  + arch/sparc/configs/sparc64_defconfig: warning: override: reassigning to symbol HAPPYMEAL:  => 239
>
>8 warning improvements:
>  - /kisskb/src/arch/sparc/include/asm/cmpxchg_32.h: warning: value computed is not used [-Wunused-value]: 28:22 =>
>  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: (near initialization for 'cmd.lock_hw') [-Wmissing-braces]: 36:8 =>
>  - /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_hw_lock_mgr.c: warning: missing braces around initializer [-Wmissing-braces]: 36:8 =>
>  - /kisskb/src/drivers/net/ethernet/aurora/nb8800.h: warning: "TCR_DIE" redefined: 92 =>
>  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'pdata' [-Wunused-variable]: 1667:28 =>
>  - /kisskb/src/drivers/net/ethernet/freescale/fec_main.c: warning: unused variable 'val' [-Wunused-variable]: 948:6 =>
>  - /kisskb/src/drivers/rtc/rtc-rx6110.c: warning: 'rx6110_probe' defined but not used [-Wunused-function]: 314:12 =>
>  - warning: unmet direct dependencies detected for COMPAT_BINFMT_ELF: N/A =>
>
>Gr{oetje,eeting}s,
>
>						Geert
>
>--
>Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
>In personal conversations with technical people, I call myself a hacker. But
>when I'm talking to journalists I just say "programmer" or something like that.
>							    -- Linus Torvalds

--FERka9MWYhWRlr/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBAD0gACgkQsjqdtxFL
KRXrFwgAvuQlbt6WV5hRQ/Z/UMyDvQQAaAyU5UW9TjKYOg965m57QWij38GlO2sp
rXFsKUk8ExCuur0c5sgko77LDCocES7mcpBP0wvbDhk9KdDkKDEPk16Zv6jp3OZH
OmMWCJD0PHafT7t1IWCs8Gq6CL83n6BeSo0u3HYgv4SnvaTQbPPTNF48j9jSDg14
TYh3B+hhyMBVB3R5JErtIxFRhkVKb9lYnpq5gB2juOOSLt3Y5KgUrv9tnh42kpC0
cbIjYyCfEaNjWJiHUJN3Vd2pF4oWhjCzy0sU7TePOvkl9vco4r/h3xQl5IjyO1UI
diQtvvEPAYl5fFzOpzujYmJWNS5IFw==
=OcJU
-----END PGP SIGNATURE-----

--FERka9MWYhWRlr/1--
