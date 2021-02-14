Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D69331B2E5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 22:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhBNVvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 16:51:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:54905 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229916AbhBNVv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 16:51:29 -0500
IronPort-SDR: wCKqMFTlo715DKyhWZyy9r0DY0kciBjKWdlWTwtXMEsDmtZ5UD0qcl6aFY5onbrPDsCC1lIyHz
 L8sWSb8teCUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9895"; a="182675331"
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="gz'50?scan'50,208,50";a="182675331"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2021 13:50:44 -0800
IronPort-SDR: WFw/oy/DBV5FQseKSMmtJFJ+7WSfTjzPx4kSg4bECQK9vtMb8EuLxvdOYfPSu4EoUkewLegqTK
 bOPzOaaz+jnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,179,1610438400"; 
   d="gz'50?scan'50,208,50";a="492257121"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2021 13:50:42 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lBPHt-0006xN-CU; Sun, 14 Feb 2021 21:50:41 +0000
Date:   Mon, 15 Feb 2021 05:50:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:122:11:
 warning: missing braces around initializer
Message-ID: <202102150503.jJOTKxh6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   358feceebbf68f33c44c6650d14455389e65282d
commit: 20f2ffe504728612d7b0c34e4f8280e34251e704 drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v3)
date:   3 months ago
config: i386-randconfig-a014-20200624 (attached as .config)
compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20f2ffe504728612d7b0c34e4f8280e34251e704
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 20f2ffe504728612d7b0c34e4f8280e34251e704
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:96:6: warning: no previous prototype for 'vg_update_clocks' [-Wmissing-prototypes]
    void vg_update_clocks(struct clk_mgr *clk_mgr_base,
         ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: In function 'vg_update_clocks':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:122:11: warning: missing braces around initializer [-Wmissing-braces]
        union display_idle_optimization_u idle_info = { 0 };
              ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:122:11: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:135:10: warning: missing braces around initializer [-Wmissing-braces]
       union display_idle_optimization_u idle_info = { 0 };
             ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:135:10: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c: At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:375:6: warning: no previous prototype for 'vg_get_clk_states' [-Wmissing-prototypes]
    void vg_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
         ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:393:6: warning: no previous prototype for 'vg_init_clocks' [-Wmissing-prototypes]
    void vg_init_clocks(struct clk_mgr *clk_mgr)
         ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:710:15: warning: missing braces around initializer [-Wmissing-braces]
    static struct watermarks dummy_wms = { 0 };
                  ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:710:15: warning: (near initialization for 'dummy_wms.WatermarkRow') [-Wmissing-braces]
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:91:5: warning: no previous prototype for 'dcn301_smu_send_msg_with_param' [-Wmissing-prototypes]
    int dcn301_smu_send_msg_with_param(
        ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c: In function 'dcn301_smu_enable_phy_refclk_pwrdwn':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:198:8: warning: missing braces around initializer [-Wmissing-braces]
     union display_idle_optimization_u idle_info = { 0 };
           ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:198:8: warning: (near initialization for 'idle_info.idle_info') [-Wmissing-braces]
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_mmhubbub_warmup':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:264:9: warning: missing braces around initializer [-Wmissing-braces]
     struct mcif_warmup_params warmup_params = {0};
            ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:264:9: warning: (near initialization for 'warmup_params.start_address') [-Wmissing-braces]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_enable_writeback':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:322:27: warning: variable 'optc' set but not used [-Wunused-but-set-variable]
     struct timing_generator *optc;
                              ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c: In function 'dcn30_update_info_frame':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_hwseq.c:654:7: warning: variable 'is_dp' set but not used [-Wunused-but-set-variable]
     bool is_dp;
          ^
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:447:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(0),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:447:2: warning: (near initialization for 'stream_enc_regs[0].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:447:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:447:2: warning: (near initialization for 'stream_enc_regs[0].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:447:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:447:2: warning: (near initialization for 'stream_enc_regs[0].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:448:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(1),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:448:2: warning: (near initialization for 'stream_enc_regs[1].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:448:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:448:2: warning: (near initialization for 'stream_enc_regs[1].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:448:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:448:2: warning: (near initialization for 'stream_enc_regs[1].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:449:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(2),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:449:2: warning: (near initialization for 'stream_enc_regs[2].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:449:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:449:2: warning: (near initialization for 'stream_enc_regs[2].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:449:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:449:2: warning: (near initialization for 'stream_enc_regs[2].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:450:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(3),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:450:2: warning: (near initialization for 'stream_enc_regs[3].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:450:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:450:2: warning: (near initialization for 'stream_enc_regs[3].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:450:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:450:2: warning: (near initialization for 'stream_enc_regs[3].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:451:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(4),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:451:2: warning: (near initialization for 'stream_enc_regs[4].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:451:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:451:2: warning: (near initialization for 'stream_enc_regs[4].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:451:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:451:2: warning: (near initialization for 'stream_enc_regs[4].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:452:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(5)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:452:2: warning: (near initialization for 'stream_enc_regs[5].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:452:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:452:2: warning: (near initialization for 'stream_enc_regs[5].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:452:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:452:2: warning: (near initialization for 'stream_enc_regs[5].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:501:2: warning: initialized field overwritten [-Woverride-init]
     DCN_AUX_MASK_SH_LIST(__SHIFT)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:501:2: warning: (near initialization for 'aux_shift.AUX_SW_AUTOINCREMENT_DISABLE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:505:2: warning: initialized field overwritten [-Woverride-init]
     DCN_AUX_MASK_SH_LIST(_MASK)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:505:2: warning: (near initialization for 'aux_mask.AUX_SW_AUTOINCREMENT_DISABLE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:509:2: warning: initialized field overwritten [-Woverride-init]
     link_regs(0, A),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:509:2: warning: (near initialization for 'link_enc_regs[0].TMDS_CTL_BITS') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:510:2: warning: initialized field overwritten [-Woverride-init]
     link_regs(1, B),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:510:2: warning: (near initialization for 'link_enc_regs[1].TMDS_CTL_BITS') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:511:2: warning: initialized field overwritten [-Woverride-init]
     link_regs(2, C),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:511:2: warning: (near initialization for 'link_enc_regs[2].TMDS_CTL_BITS') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:512:2: warning: initialized field overwritten [-Woverride-init]
     link_regs(3, D),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:512:2: warning: (near initialization for 'link_enc_regs[3].TMDS_CTL_BITS') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:513:2: warning: initialized field overwritten [-Woverride-init]
     link_regs(4, E),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:513:2: warning: (near initialization for 'link_enc_regs[4].TMDS_CTL_BITS') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:514:2: warning: initialized field overwritten [-Woverride-init]
     link_regs(5, F)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:514:2: warning: (near initialization for 'link_enc_regs[5].TMDS_CTL_BITS') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:518:2: warning: initialized field overwritten [-Woverride-init]
     LINK_ENCODER_MASK_SH_LIST_DCN30(__SHIFT),\
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:518:2: warning: (near initialization for 'le_shift.TMDS_CTL0') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:523:2: warning: initialized field overwritten [-Woverride-init]
     LINK_ENCODER_MASK_SH_LIST_DCN30(_MASK),\
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:523:2: warning: (near initialization for 'le_mask.TMDS_CTL0') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:546:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(0),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:546:2: warning: (near initialization for 'dpp_regs[0].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:546:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:546:2: warning: (near initialization for 'dpp_regs[0].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:546:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:546:2: warning: (near initialization for 'dpp_regs[0].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:547:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(1),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:547:2: warning: (near initialization for 'dpp_regs[1].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:547:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:547:2: warning: (near initialization for 'dpp_regs[1].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:547:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:547:2: warning: (near initialization for 'dpp_regs[1].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn30/dcn30_resource.c:548:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(2),
     ^
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:447:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(0),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:447:2: warning: (near initialization for 'stream_enc_regs[0].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:447:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:447:2: warning: (near initialization for 'stream_enc_regs[0].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:447:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:447:2: warning: (near initialization for 'stream_enc_regs[0].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:448:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(1),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:448:2: warning: (near initialization for 'stream_enc_regs[1].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:448:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:448:2: warning: (near initialization for 'stream_enc_regs[1].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:448:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:448:2: warning: (near initialization for 'stream_enc_regs[1].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:449:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(2),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:449:2: warning: (near initialization for 'stream_enc_regs[2].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:449:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:449:2: warning: (near initialization for 'stream_enc_regs[2].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:449:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:449:2: warning: (near initialization for 'stream_enc_regs[2].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:450:2: warning: initialized field overwritten [-Woverride-init]
     stream_enc_regs(3),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:450:2: warning: (near initialization for 'stream_enc_regs[3].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:450:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:450:2: warning: (near initialization for 'stream_enc_regs[3].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:450:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:450:2: warning: (near initialization for 'stream_enc_regs[3].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:493:2: warning: initialized field overwritten [-Woverride-init]
     DCN_AUX_MASK_SH_LIST(__SHIFT)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:493:2: warning: (near initialization for 'aux_shift.AUX_SW_AUTOINCREMENT_DISABLE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:497:2: warning: initialized field overwritten [-Woverride-init]
     DCN_AUX_MASK_SH_LIST(_MASK)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:497:2: warning: (near initialization for 'aux_mask.AUX_SW_AUTOINCREMENT_DISABLE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:508:2: warning: initialized field overwritten [-Woverride-init]
     LINK_ENCODER_MASK_SH_LIST_DCN301(__SHIFT)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:508:2: warning: (near initialization for 'le_shift.TMDS_CTL0') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:512:2: warning: initialized field overwritten [-Woverride-init]
     LINK_ENCODER_MASK_SH_LIST_DCN301(_MASK)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:512:2: warning: (near initialization for 'le_mask.TMDS_CTL0') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:539:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(0),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:539:2: warning: (near initialization for 'dpp_regs[0].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:539:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:539:2: warning: (near initialization for 'dpp_regs[0].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:539:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:539:2: warning: (near initialization for 'dpp_regs[0].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:540:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(1),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:540:2: warning: (near initialization for 'dpp_regs[1].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:540:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:540:2: warning: (near initialization for 'dpp_regs[1].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:540:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:540:2: warning: (near initialization for 'dpp_regs[1].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:541:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(2),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:541:2: warning: (near initialization for 'dpp_regs[2].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:541:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:541:2: warning: (near initialization for 'dpp_regs[2].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:541:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:541:2: warning: (near initialization for 'dpp_regs[2].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:542:2: warning: initialized field overwritten [-Woverride-init]
     dpp_regs(3),
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:542:2: warning: (near initialization for 'dpp_regs[3].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:542:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:542:2: warning: (near initialization for 'dpp_regs[3].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:542:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:542:2: warning: (near initialization for 'dpp_regs[3].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:546:3: warning: initialized field overwritten [-Woverride-init]
      DPP_REG_LIST_SH_MASK_DCN30(__SHIFT)
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:546:3: warning: (near initialization for 'tf_shift.CM_3DLUT_MODE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:550:3: warning: initialized field overwritten [-Woverride-init]
      DPP_REG_LIST_SH_MASK_DCN30(_MASK)
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:550:3: warning: (near initialization for 'tf_mask.CM_3DLUT_MODE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:634:2: warning: initialized field overwritten [-Woverride-init]
     DSC_REG_LIST_SH_MASK_DCN20(__SHIFT)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:634:2: warning: (near initialization for 'dsc_shift.PIC_WIDTH') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:634:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:634:2: warning: (near initialization for 'dsc_shift.PIC_HEIGHT') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:638:2: warning: initialized field overwritten [-Woverride-init]
     DSC_REG_LIST_SH_MASK_DCN20(_MASK)
     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:638:2: warning: (near initialization for 'dsc_mask.PIC_WIDTH') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:638:2: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:638:2: warning: (near initialization for 'dsc_mask.PIC_HEIGHT') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:647:3: warning: initialized field overwritten [-Woverride-init]
      MPC_OUT_MUX_REG_LIST_DCN3_0(1),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:647:3: warning: (near initialization for 'mpc_regs.MPC_OUT_CSC_COEF_FORMAT') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn301/dcn301_resource.c:648:3: warning: initialized field overwritten [-Woverride-init]
      MPC_OUT_MUX_REG_LIST_DCN3_0(2),
      ^
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:505:3: warning: initialized field overwritten [-Woverride-init]
      stream_enc_regs(0),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:505:3: warning: (near initialization for 'stream_enc_regs[0].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:505:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:505:3: warning: (near initialization for 'stream_enc_regs[0].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:505:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:505:3: warning: (near initialization for 'stream_enc_regs[0].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:506:3: warning: initialized field overwritten [-Woverride-init]
      stream_enc_regs(1),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:506:3: warning: (near initialization for 'stream_enc_regs[1].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:506:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:506:3: warning: (near initialization for 'stream_enc_regs[1].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:506:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:506:3: warning: (near initialization for 'stream_enc_regs[1].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:507:3: warning: initialized field overwritten [-Woverride-init]
      stream_enc_regs(2),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:507:3: warning: (near initialization for 'stream_enc_regs[2].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:507:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:507:3: warning: (near initialization for 'stream_enc_regs[2].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:507:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:507:3: warning: (near initialization for 'stream_enc_regs[2].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:508:3: warning: initialized field overwritten [-Woverride-init]
      stream_enc_regs(3),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:508:3: warning: (near initialization for 'stream_enc_regs[3].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:508:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:508:3: warning: (near initialization for 'stream_enc_regs[3].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:508:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:508:3: warning: (near initialization for 'stream_enc_regs[3].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:509:3: warning: initialized field overwritten [-Woverride-init]
      stream_enc_regs(4)
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:509:3: warning: (near initialization for 'stream_enc_regs[4].DP_SEC_METADATA_TRANSMISSION') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:509:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:509:3: warning: (near initialization for 'stream_enc_regs[4].HDMI_METADATA_PACKET_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:509:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:509:3: warning: (near initialization for 'stream_enc_regs[4].DIG_FE_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:585:3: warning: initialized field overwritten [-Woverride-init]
      HWSEQ_DCN302_REG_LIST()
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:585:3: warning: (near initialization for 'hwseq_reg.DCFCLK_CNTL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: initialized field overwritten [-Woverride-init]
      HUBP_MASK_SH_LIST_DCN30(__SHIFT)
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: (near initialization for 'hubp_shift.REFCYC_PER_REQ_DELIVERY') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: (near initialization for 'hubp_shift.QoS_LEVEL_FIXED') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: (near initialization for 'hubp_shift.QoS_RAMP_DISABLE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:621:3: warning: (near initialization for 'hubp_shift.REFCYC_PER_REQ_DELIVERY_PRE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: initialized field overwritten [-Woverride-init]
      HUBP_MASK_SH_LIST_DCN30(_MASK)
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: (near initialization for 'hubp_mask.REFCYC_PER_REQ_DELIVERY') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: (near initialization for 'hubp_mask.QoS_LEVEL_FIXED') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: (near initialization for 'hubp_mask.QoS_RAMP_DISABLE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:625:3: warning: (near initialization for 'hubp_mask.REFCYC_PER_REQ_DELIVERY_PRE') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:647:3: warning: initialized field overwritten [-Woverride-init]
      dpp_regs(0),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:647:3: warning: (near initialization for 'dpp_regs[0].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:647:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:647:3: warning: (near initialization for 'dpp_regs[0].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:647:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:647:3: warning: (near initialization for 'dpp_regs[0].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:648:3: warning: initialized field overwritten [-Woverride-init]
      dpp_regs(1),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:648:3: warning: (near initialization for 'dpp_regs[1].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:648:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:648:3: warning: (near initialization for 'dpp_regs[1].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:648:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:648:3: warning: (near initialization for 'dpp_regs[1].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:649:3: warning: initialized field overwritten [-Woverride-init]
      dpp_regs(2),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:649:3: warning: (near initialization for 'dpp_regs[2].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:649:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:649:3: warning: (near initialization for 'dpp_regs[2].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:649:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:649:3: warning: (near initialization for 'dpp_regs[2].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:650:3: warning: initialized field overwritten [-Woverride-init]
      dpp_regs(3),
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:650:3: warning: (near initialization for 'dpp_regs[3].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:650:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:650:3: warning: (near initialization for 'dpp_regs[3].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:650:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:650:3: warning: (near initialization for 'dpp_regs[3].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:651:3: warning: initialized field overwritten [-Woverride-init]
      dpp_regs(4)
      ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:651:3: warning: (near initialization for 'dpp_regs[4].CM_GAMCOR_LUT_INDEX') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:651:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:651:3: warning: (near initialization for 'dpp_regs[4].CURSOR_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:651:3: warning: initialized field overwritten [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:651:3: warning: (near initialization for 'dpp_regs[4].CM_BLNDGAM_CONTROL') [-Woverride-init]
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn302/dcn302_resource.c:655:3: warning: initialized field overwritten [-Woverride-init]
      DPP_REG_LIST_SH_MASK_DCN30(__SHIFT)
      ^


vim +122 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c

3a83e4e64bb152 Roman Li 2020-09-29   95  
3a83e4e64bb152 Roman Li 2020-09-29   96  void vg_update_clocks(struct clk_mgr *clk_mgr_base,
3a83e4e64bb152 Roman Li 2020-09-29   97  			struct dc_state *context,
3a83e4e64bb152 Roman Li 2020-09-29   98  			bool safe_to_lower)
3a83e4e64bb152 Roman Li 2020-09-29   99  {
3a83e4e64bb152 Roman Li 2020-09-29  100  	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
3a83e4e64bb152 Roman Li 2020-09-29  101  	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
3a83e4e64bb152 Roman Li 2020-09-29  102  	struct dc *dc = clk_mgr_base->ctx->dc;
3a83e4e64bb152 Roman Li 2020-09-29  103  	int display_count;
3a83e4e64bb152 Roman Li 2020-09-29  104  	bool update_dppclk = false;
3a83e4e64bb152 Roman Li 2020-09-29  105  	bool update_dispclk = false;
3a83e4e64bb152 Roman Li 2020-09-29  106  	bool dpp_clock_lowered = false;
3a83e4e64bb152 Roman Li 2020-09-29  107  
3a83e4e64bb152 Roman Li 2020-09-29  108  	if (dc->work_arounds.skip_clock_update)
3a83e4e64bb152 Roman Li 2020-09-29  109  		return;
3a83e4e64bb152 Roman Li 2020-09-29  110  
3a83e4e64bb152 Roman Li 2020-09-29  111  	/*
3a83e4e64bb152 Roman Li 2020-09-29  112  	 * if it is safe to lower, but we are already in the lower state, we don't have to do anything
3a83e4e64bb152 Roman Li 2020-09-29  113  	 * also if safe to lower is false, we just go in the higher state
3a83e4e64bb152 Roman Li 2020-09-29  114  	 */
3a83e4e64bb152 Roman Li 2020-09-29  115  	if (safe_to_lower) {
3a83e4e64bb152 Roman Li 2020-09-29  116  		/* check that we're not already in lower */
3a83e4e64bb152 Roman Li 2020-09-29  117  		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
3a83e4e64bb152 Roman Li 2020-09-29  118  
3a83e4e64bb152 Roman Li 2020-09-29  119  			display_count = vg_get_active_display_cnt_wa(dc, context);
3a83e4e64bb152 Roman Li 2020-09-29  120  			/* if we can go lower, go lower */
3a83e4e64bb152 Roman Li 2020-09-29  121  			if (display_count == 0) {
3a83e4e64bb152 Roman Li 2020-09-29 @122  				union display_idle_optimization_u idle_info = { 0 };
3a83e4e64bb152 Roman Li 2020-09-29  123  
3a83e4e64bb152 Roman Li 2020-09-29  124  				idle_info.idle_info.df_request_disabled = 1;
3a83e4e64bb152 Roman Li 2020-09-29  125  				idle_info.idle_info.phy_ref_clk_off = 1;
3a83e4e64bb152 Roman Li 2020-09-29  126  
3a83e4e64bb152 Roman Li 2020-09-29  127  				dcn301_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
3a83e4e64bb152 Roman Li 2020-09-29  128  				/* update power state */
3a83e4e64bb152 Roman Li 2020-09-29  129  				clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_LOW_POWER;
3a83e4e64bb152 Roman Li 2020-09-29  130  			}
3a83e4e64bb152 Roman Li 2020-09-29  131  		}
3a83e4e64bb152 Roman Li 2020-09-29  132  	} else {
3a83e4e64bb152 Roman Li 2020-09-29  133  		/* check that we're not already in D0 */
3a83e4e64bb152 Roman Li 2020-09-29  134  		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
3a83e4e64bb152 Roman Li 2020-09-29  135  			union display_idle_optimization_u idle_info = { 0 };
3a83e4e64bb152 Roman Li 2020-09-29  136  
3a83e4e64bb152 Roman Li 2020-09-29  137  			dcn301_smu_set_display_idle_optimization(clk_mgr, idle_info.data);
3a83e4e64bb152 Roman Li 2020-09-29  138  			/* update power state */
3a83e4e64bb152 Roman Li 2020-09-29  139  			clk_mgr_base->clks.pwr_state = DCN_PWR_STATE_MISSION_MODE;
3a83e4e64bb152 Roman Li 2020-09-29  140  		}
3a83e4e64bb152 Roman Li 2020-09-29  141  	}
3a83e4e64bb152 Roman Li 2020-09-29  142  
3a83e4e64bb152 Roman Li 2020-09-29  143  	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
3a83e4e64bb152 Roman Li 2020-09-29  144  		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
3a83e4e64bb152 Roman Li 2020-09-29  145  		dcn301_smu_set_hard_min_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_khz);
3a83e4e64bb152 Roman Li 2020-09-29  146  	}
3a83e4e64bb152 Roman Li 2020-09-29  147  
3a83e4e64bb152 Roman Li 2020-09-29  148  	if (should_set_clock(safe_to_lower,
3a83e4e64bb152 Roman Li 2020-09-29  149  			new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
3a83e4e64bb152 Roman Li 2020-09-29  150  		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
3a83e4e64bb152 Roman Li 2020-09-29  151  		dcn301_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
3a83e4e64bb152 Roman Li 2020-09-29  152  	}
3a83e4e64bb152 Roman Li 2020-09-29  153  
3a83e4e64bb152 Roman Li 2020-09-29  154  	// workaround: Limit dppclk to 100Mhz to avoid lower eDP panel switch to plus 4K monitor underflow.
3a83e4e64bb152 Roman Li 2020-09-29  155  	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
3a83e4e64bb152 Roman Li 2020-09-29  156  		if (new_clocks->dppclk_khz < 100000)
3a83e4e64bb152 Roman Li 2020-09-29  157  			new_clocks->dppclk_khz = 100000;
3a83e4e64bb152 Roman Li 2020-09-29  158  	}
3a83e4e64bb152 Roman Li 2020-09-29  159  
3a83e4e64bb152 Roman Li 2020-09-29  160  	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->base.clks.dppclk_khz)) {
3a83e4e64bb152 Roman Li 2020-09-29  161  		if (clk_mgr->base.clks.dppclk_khz > new_clocks->dppclk_khz)
3a83e4e64bb152 Roman Li 2020-09-29  162  			dpp_clock_lowered = true;
3a83e4e64bb152 Roman Li 2020-09-29  163  		clk_mgr_base->clks.dppclk_khz = new_clocks->dppclk_khz;
3a83e4e64bb152 Roman Li 2020-09-29  164  		update_dppclk = true;
3a83e4e64bb152 Roman Li 2020-09-29  165  	}
3a83e4e64bb152 Roman Li 2020-09-29  166  
3a83e4e64bb152 Roman Li 2020-09-29  167  	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
3a83e4e64bb152 Roman Li 2020-09-29  168  		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
3a83e4e64bb152 Roman Li 2020-09-29  169  		dcn301_smu_set_dispclk(clk_mgr, clk_mgr_base->clks.dispclk_khz);
3a83e4e64bb152 Roman Li 2020-09-29  170  
3a83e4e64bb152 Roman Li 2020-09-29  171  		update_dispclk = true;
3a83e4e64bb152 Roman Li 2020-09-29  172  	}
3a83e4e64bb152 Roman Li 2020-09-29  173  
3a83e4e64bb152 Roman Li 2020-09-29  174  	if (dpp_clock_lowered) {
3a83e4e64bb152 Roman Li 2020-09-29  175  		// increase per DPP DTO before lowering global dppclk
3a83e4e64bb152 Roman Li 2020-09-29  176  		dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
3a83e4e64bb152 Roman Li 2020-09-29  177  		dcn301_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
3a83e4e64bb152 Roman Li 2020-09-29  178  	} else {
3a83e4e64bb152 Roman Li 2020-09-29  179  		// increase global DPPCLK before lowering per DPP DTO
3a83e4e64bb152 Roman Li 2020-09-29  180  		if (update_dppclk || update_dispclk)
3a83e4e64bb152 Roman Li 2020-09-29  181  			dcn301_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
3a83e4e64bb152 Roman Li 2020-09-29  182  		// always update dtos unless clock is lowered and not safe to lower
3a83e4e64bb152 Roman Li 2020-09-29  183  		if (new_clocks->dppclk_khz >= dc->current_state->bw_ctx.bw.dcn.clk.dppclk_khz)
3a83e4e64bb152 Roman Li 2020-09-29  184  			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
3a83e4e64bb152 Roman Li 2020-09-29  185  	}
3a83e4e64bb152 Roman Li 2020-09-29  186  }
3a83e4e64bb152 Roman Li 2020-09-29  187  

:::::: The code at line 122 was first introduced by commit
:::::: 3a83e4e64bb1522ddac67ffc787d1c38291e1a65 drm/amd/display: Add dcn3.01 support to DC (v2)

:::::: TO: Roman Li <Roman.Li@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--pf9I7BMVVzbSWLtt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
DTJQcDJmB8VSMOq/HD4sWl3OvYRRSTK8xQfZsPhoAg72AAX0xUNg/i4jLw70r/N8J+MQIg6X
Ergqnw7/+3p4uPu+er67/Rp4RO6EhQ65OXOV2GIWNAYX9AJ5zEcLnHZDxkO5lGNjOVxKODbk
5UD8PyrhGioQir9fBVW0yZv5+1VEU1AYWNorStYA2pBpvE2mmafqmFBAp1m9sNJLSSIBT2o9
UozjKix05qbsH4ho3//eDOOZjRL5OZbI1aen+//YG3O/S7tOKW9riu+1Tv+HXlWeuwYWajsL
E4p/TIF/s+jk4TI34rrfXC4R/jnZvYgQwZiQ+iGshvEHe5Zoo8Dl2TK9DzmqnQGEPFS2xmVp
AXADsLHxOMkasbAKEyPznzuEJMXjMV/YKwfsORiRW7XG3MefhbVq0VSya8IaWLiGcxDPgE7y
LGda7fmP26fDJw8gJ4dtH2wkSebiGRM+STu6o37icUJnjsLLPn09hBo0xBiuxIh/TYogvyAg
ctp0CyRNRXzQR5q7TUraTktyN0/xtOzYR9/kh66HmXT2+uwKVr8AvFgdXu7e/eofVcQclcCA
wEJCFZI5t59HWAomaTKL0pJF3QYIxZaSJoUikGab87wgKEu1kTfZ2Qks7seOyU1yeJgakXUp
DDEkTWBI1ouhKC94p3J0bMP7TixZS2vCE43Gg8TvfidO30PV9HUNuNCpm9qG6vfvT049oARK
pYmPxV6VQSL3woZbYbh/uH36vqLfXr/eRqdv8KSHML5ra8Yf4jkAjJh6IjhpnYUo75++/RcO
+KqYGwVapJzfkkluICWn3Dbk7VyuANpnZUqsyus+L4f0w2lN/FIXB5ioIIZVTccuZwS8/zKh
dxsp8bZ9YMDMbDCgwuNNbunAvm1TM+5oiTbKVy1jUZjuhKUul8OtsD58ebpdfXbrbI2vobj3
LGkGR57tULCnm20Q18Ub6g7k82b2NsPJJHhB2937U89cYCrJmpz2DYvLzt5fxqW6JZ1J9Qie
qN4+3f1x/3K4w1DL20+HP2HoqOJmNsM5QPZyxq39kMaExtO7ORQ2bY1OJsyVDIl3Juu1rf1M
ULMkY8VZU+jHzKH8xmbkJOXiXx0H20ayZAjF9DbFYLrGxNYwHztHZ3UeGTVvacGp7zN8gBkN
m4F8Yv5YIslqE+cM2VLMo0kRRJsuH5oBzDlL2jP0smtsph6VEr351BPELQ2dwekFpmlxLcQm
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

--pf9I7BMVVzbSWLtt--
