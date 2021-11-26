Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7345E3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbhKZAYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:24:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:6781 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhKZAWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:22:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235823509"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="235823509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 16:16:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="498218836"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 16:16:57 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqOvA-000783-Eb; Fri, 26 Nov 2021 00:16:56 +0000
Date:   Fri, 26 Nov 2021 08:16:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Taylor <Ryan.Taylor@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c:399:5: warning: no previous
 prototype for function 'amdgpu_vkms_output_init'
Message-ID: <202111260806.ISy82sTq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: 733ee71ae0d03a8b03711dca8bc94c8ac05a6bc3 drm/amdgpu: replace dce_virtual with amdgpu_vkms (v3)
date:   4 months ago
config: i386-randconfig-a015-20210927 (https://download.01.org/0day-ci/archive/20211126/202111260806.ISy82sTq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project dc6e8dfdfe7efecfda318d43a06fae18b40eb498)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=733ee71ae0d03a8b03711dca8bc94c8ac05a6bc3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 733ee71ae0d03a8b03711dca8bc94c8ac05a6bc3
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c:399:5: warning: no previous prototype for function 'amdgpu_vkms_output_init' [-Wmissing-prototypes]
   int amdgpu_vkms_output_init(struct drm_device *dev,
       ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c:399:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int amdgpu_vkms_output_init(struct drm_device *dev,
   ^
   static 
   1 warning generated.


vim +/amdgpu_vkms_output_init +399 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c

84ec374bd58036 Ryan Taylor 2021-06-07  398  
84ec374bd58036 Ryan Taylor 2021-06-07 @399  int amdgpu_vkms_output_init(struct drm_device *dev,
84ec374bd58036 Ryan Taylor 2021-06-07  400  			    struct amdgpu_vkms_output *output, int index)
84ec374bd58036 Ryan Taylor 2021-06-07  401  {
84ec374bd58036 Ryan Taylor 2021-06-07  402  	struct drm_connector *connector = &output->connector;
84ec374bd58036 Ryan Taylor 2021-06-07  403  	struct drm_encoder *encoder = &output->encoder;
84ec374bd58036 Ryan Taylor 2021-06-07  404  	struct drm_crtc *crtc = &output->crtc;
84ec374bd58036 Ryan Taylor 2021-06-07  405  	struct drm_plane *primary, *cursor = NULL;
84ec374bd58036 Ryan Taylor 2021-06-07  406  	int ret;
84ec374bd58036 Ryan Taylor 2021-06-07  407  
84ec374bd58036 Ryan Taylor 2021-06-07  408  	primary = amdgpu_vkms_plane_init(dev, DRM_PLANE_TYPE_PRIMARY, index);
84ec374bd58036 Ryan Taylor 2021-06-07  409  	if (IS_ERR(primary))
84ec374bd58036 Ryan Taylor 2021-06-07  410  		return PTR_ERR(primary);
84ec374bd58036 Ryan Taylor 2021-06-07  411  
84ec374bd58036 Ryan Taylor 2021-06-07  412  	ret = amdgpu_vkms_crtc_init(dev, crtc, primary, cursor);
84ec374bd58036 Ryan Taylor 2021-06-07  413  	if (ret)
84ec374bd58036 Ryan Taylor 2021-06-07  414  		goto err_crtc;
84ec374bd58036 Ryan Taylor 2021-06-07  415  
84ec374bd58036 Ryan Taylor 2021-06-07  416  	ret = drm_connector_init(dev, connector, &amdgpu_vkms_connector_funcs,
84ec374bd58036 Ryan Taylor 2021-06-07  417  				 DRM_MODE_CONNECTOR_VIRTUAL);
84ec374bd58036 Ryan Taylor 2021-06-07  418  	if (ret) {
84ec374bd58036 Ryan Taylor 2021-06-07  419  		DRM_ERROR("Failed to init connector\n");
84ec374bd58036 Ryan Taylor 2021-06-07  420  		goto err_connector;
84ec374bd58036 Ryan Taylor 2021-06-07  421  	}
84ec374bd58036 Ryan Taylor 2021-06-07  422  
84ec374bd58036 Ryan Taylor 2021-06-07  423  	drm_connector_helper_add(connector, &amdgpu_vkms_conn_helper_funcs);
84ec374bd58036 Ryan Taylor 2021-06-07  424  
84ec374bd58036 Ryan Taylor 2021-06-07  425  	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
84ec374bd58036 Ryan Taylor 2021-06-07  426  	if (ret) {
84ec374bd58036 Ryan Taylor 2021-06-07  427  		DRM_ERROR("Failed to init encoder\n");
84ec374bd58036 Ryan Taylor 2021-06-07  428  		goto err_encoder;
84ec374bd58036 Ryan Taylor 2021-06-07  429  	}
84ec374bd58036 Ryan Taylor 2021-06-07  430  	encoder->possible_crtcs = 1 << index;
84ec374bd58036 Ryan Taylor 2021-06-07  431  
84ec374bd58036 Ryan Taylor 2021-06-07  432  	ret = drm_connector_attach_encoder(connector, encoder);
84ec374bd58036 Ryan Taylor 2021-06-07  433  	if (ret) {
84ec374bd58036 Ryan Taylor 2021-06-07  434  		DRM_ERROR("Failed to attach connector to encoder\n");
84ec374bd58036 Ryan Taylor 2021-06-07  435  		goto err_attach;
84ec374bd58036 Ryan Taylor 2021-06-07  436  	}
84ec374bd58036 Ryan Taylor 2021-06-07  437  
84ec374bd58036 Ryan Taylor 2021-06-07  438  	drm_mode_config_reset(dev);
84ec374bd58036 Ryan Taylor 2021-06-07  439  
84ec374bd58036 Ryan Taylor 2021-06-07  440  	return 0;
84ec374bd58036 Ryan Taylor 2021-06-07  441  
84ec374bd58036 Ryan Taylor 2021-06-07  442  err_attach:
84ec374bd58036 Ryan Taylor 2021-06-07  443  	drm_encoder_cleanup(encoder);
84ec374bd58036 Ryan Taylor 2021-06-07  444  
84ec374bd58036 Ryan Taylor 2021-06-07  445  err_encoder:
84ec374bd58036 Ryan Taylor 2021-06-07  446  	drm_connector_cleanup(connector);
84ec374bd58036 Ryan Taylor 2021-06-07  447  
84ec374bd58036 Ryan Taylor 2021-06-07  448  err_connector:
84ec374bd58036 Ryan Taylor 2021-06-07  449  	drm_crtc_cleanup(crtc);
84ec374bd58036 Ryan Taylor 2021-06-07  450  
84ec374bd58036 Ryan Taylor 2021-06-07  451  err_crtc:
84ec374bd58036 Ryan Taylor 2021-06-07  452  	drm_plane_cleanup(primary);
84ec374bd58036 Ryan Taylor 2021-06-07  453  
84ec374bd58036 Ryan Taylor 2021-06-07  454  	return ret;
84ec374bd58036 Ryan Taylor 2021-06-07  455  }
733ee71ae0d03a Ryan Taylor 2021-06-18  456  

:::::: The code at line 399 was first introduced by commit
:::::: 84ec374bd580364a32818c9fc269c19d6e931cab drm/amdgpu: create amdgpu_vkms (v4)

:::::: TO: Ryan Taylor <Ryan.Taylor@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
