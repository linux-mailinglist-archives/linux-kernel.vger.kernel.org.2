Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F3545E3AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351860AbhKZAcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:32:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:47660 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237355AbhKZAaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:30:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="215608214"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="215608214"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 16:26:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="498220062"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 16:26:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqP4q-00078k-L4; Fri, 26 Nov 2021 00:26:56 +0000
Date:   Fri, 26 Nov 2021 08:26:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2678:21: warning:
 variable 'main_plane' is uninitialized when used here
Message-ID: <202111260815.v5s0FohX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20211117-234622/Sascha-Hauer/drm-rockchip-RK356x-VOP2-support/20211117-223601
head:   bb17f3afe532266901ec476abd66abd2178e5cfb
commit: bb17f3afe532266901ec476abd66abd2178e5cfb drm: rockchip: Add VOP2 driver
date:   8 days ago
config: hexagon-randconfig-r002-20211118 (https://download.01.org/0day-ci/archive/20211126/202111260815.v5s0FohX-lkp@intel.com/config)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bb17f3afe532266901ec476abd66abd2178e5cfb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20211117-234622/Sascha-Hauer/drm-rockchip-RK356x-VOP2-support/20211117-223601
        git checkout bb17f3afe532266901ec476abd66abd2178e5cfb
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2678:21: warning: variable 'main_plane' is uninitialized when used here [-Wuninitialized]
                           top_win_pstate = main_plane->state;
                                            ^~~~~~~~~~
   drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2661:30: note: initialize the variable 'main_plane' to silence this warning
           struct drm_plane *main_plane;
                                       ^
                                        = NULL
>> drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:2943:20: warning: variable 'plane' set but not used [-Wunused-but-set-variable]
           struct drm_plane *plane;
                             ^
   2 warnings generated.
--
>> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:521:35: warning: unused variable 'rk3568_area1_scl' [-Wunused-const-variable]
   static const struct vop2_scl_regs rk3568_area1_scl = {
                                     ^
>> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:541:35: warning: unused variable 'rk3568_area2_scl' [-Wunused-const-variable]
   static const struct vop2_scl_regs rk3568_area2_scl = {
                                     ^
>> drivers/gpu/drm/rockchip/rockchip_vop2_reg.c:561:35: warning: unused variable 'rk3568_area3_scl' [-Wunused-const-variable]
   static const struct vop2_scl_regs rk3568_area3_scl = {
                                     ^
   3 warnings generated.


vim +/main_plane +2678 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

  2644	
  2645	/*
  2646	 * src: top layer
  2647	 * dst: bottom layer.
  2648	 * Cluster mixer default use win1 as top layer
  2649	 */
  2650	static void vop2_setup_cluster_alpha(struct vop2 *vop2, struct vop2_cluster *cluster)
  2651	{
  2652		uint32_t src_color_ctrl_offset = vop2->data->ctrl->cluster0_src_color_ctrl.offset;
  2653		uint32_t dst_color_ctrl_offset = vop2->data->ctrl->cluster0_dst_color_ctrl.offset;
  2654		uint32_t src_alpha_ctrl_offset = vop2->data->ctrl->cluster0_src_alpha_ctrl.offset;
  2655		uint32_t dst_alpha_ctrl_offset = vop2->data->ctrl->cluster0_dst_alpha_ctrl.offset;
  2656		uint32_t offset = (cluster->main->data->phys_id * 0x10);
  2657		struct vop2_alpha_config alpha_config;
  2658		struct vop2_alpha alpha;
  2659		struct vop2_win *main_win = cluster->main;
  2660		struct vop2_win *sub_win = cluster->sub;
  2661		struct drm_plane *main_plane;
  2662		struct drm_plane_state *top_win_pstate;
  2663		struct drm_plane_state *bottom_win_pstate;
  2664		bool src_pixel_alpha_en = false;
  2665		uint16_t src_glb_alpha_val, dst_glb_alpha_val;
  2666		bool premulti_en = false;
  2667		bool swap = false;
  2668	
  2669		if (!sub_win) {
  2670			/* At one win mode, win0 is dst/bottom win, and win1 is a all zero src/top win */
  2671			top_win_pstate = NULL;
  2672			bottom_win_pstate = main_win->base.state;
  2673			src_glb_alpha_val = 0;
  2674			dst_glb_alpha_val = main_win->base.state->alpha;
  2675		} else {
  2676			if (main_win->base.state->zpos > sub_win->base.state->zpos) {
  2677				swap = 1;
> 2678				top_win_pstate = main_plane->state;
  2679				bottom_win_pstate = sub_win->base.state;
  2680				src_glb_alpha_val = main_win->base.state->alpha;
  2681				dst_glb_alpha_val = sub_win->base.state->alpha;
  2682			} else {
  2683				swap = 0;
  2684				top_win_pstate = sub_win->base.state;
  2685				bottom_win_pstate = main_plane->state;
  2686				src_glb_alpha_val = sub_win->base.state->alpha;
  2687				dst_glb_alpha_val = main_win->base.state->alpha;
  2688			}
  2689	
  2690			if (!top_win_pstate->fb)
  2691				return;
  2692	
  2693			if (top_win_pstate->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI)
  2694				premulti_en = true;
  2695			else
  2696				premulti_en = false;
  2697	
  2698			src_pixel_alpha_en = is_alpha_support(top_win_pstate->fb->format->format);
  2699		}
  2700	
  2701		if (!bottom_win_pstate->fb)
  2702			return;
  2703	
  2704		alpha_config.src_premulti_en = premulti_en;
  2705		alpha_config.dst_premulti_en = false;
  2706		alpha_config.src_pixel_alpha_en = src_pixel_alpha_en;
  2707		alpha_config.dst_pixel_alpha_en = true; /* alpha value need transfer to next mix */
  2708		alpha_config.src_glb_alpha_value = src_glb_alpha_val;
  2709		alpha_config.dst_glb_alpha_value = dst_glb_alpha_val;
  2710		vop2_parse_alpha(&alpha_config, &alpha);
  2711	
  2712		alpha.src_color_ctrl.bits.src_dst_swap = swap;
  2713		vop2_writel(vop2, src_color_ctrl_offset + offset, alpha.src_color_ctrl.val);
  2714		vop2_writel(vop2, dst_color_ctrl_offset + offset, alpha.dst_color_ctrl.val);
  2715		vop2_writel(vop2, src_alpha_ctrl_offset + offset, alpha.src_alpha_ctrl.val);
  2716		vop2_writel(vop2, dst_alpha_ctrl_offset + offset, alpha.dst_alpha_ctrl.val);
  2717	}
  2718	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
