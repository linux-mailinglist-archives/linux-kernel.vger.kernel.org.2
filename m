Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE5245E66A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 04:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbhKZDGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 22:06:36 -0500
Received: from mga04.intel.com ([192.55.52.120]:23539 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344001AbhKZDEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 22:04:35 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="234329218"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="234329218"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 19:01:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675416755"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 19:01:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqRTy-0007NH-Hv; Fri, 26 Nov 2021 03:01:02 +0000
Date:   Fri, 26 Nov 2021 11:00:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jude Shih <shenshih@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:632:6:
 warning: no previous prototype for 'dmub_aux_setconfig_callback'
Message-ID: <202111261000.OurVD8yZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ced7ca3570333998ad2088d5a6275701970e28e
commit: e27c41d5b0681c597ac1894f4e02cf626e062250 drm/amd/display: Support for DMUB HPD interrupt handling
date:   3 months ago
config: powerpc64-buildonly-randconfig-r004-20211026 (https://download.01.org/0day-ci/archive/20211126/202111261000.OurVD8yZ-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e27c41d5b0681c597ac1894f4e02cf626e062250
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e27c41d5b0681c597ac1894f4e02cf626e062250
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:632:6: warning: no previous prototype for 'dmub_aux_setconfig_callback' [-Wmissing-prototypes]
     632 | void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:648:6: warning: no previous prototype for 'dmub_hpd_callback' [-Wmissing-prototypes]
     648 | void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
         |      ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:702:6: warning: no previous prototype for 'register_dmub_notify_callback' [-Wmissing-prototypes]
     702 | bool register_dmub_notify_callback(struct amdgpu_device *adev, enum dmub_notification_type type,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/dmub_aux_setconfig_callback +632 drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c

   622	
   623	/**
   624	 * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
   625	 * @adev: amdgpu_device pointer
   626	 * @notify: dmub notification structure
   627	 *
   628	 * Dmub AUX or SET_CONFIG command completion processing callback
   629	 * Copies dmub notification to DM which is to be read by AUX command.
   630	 * issuing thread and also signals the event to wake up the thread.
   631	 */
 > 632	void dmub_aux_setconfig_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
   633	{
   634		if (adev->dm.dmub_notify)
   635			memcpy(adev->dm.dmub_notify, notify, sizeof(struct dmub_notification));
   636		if (notify->type == DMUB_NOTIFICATION_AUX_REPLY)
   637			complete(&adev->dm.dmub_aux_transfer_done);
   638	}
   639	
   640	/**
   641	 * dmub_hpd_callback - DMUB HPD interrupt processing callback.
   642	 * @adev: amdgpu_device pointer
   643	 * @notify: dmub notification structure
   644	 *
   645	 * Dmub Hpd interrupt processing callback. Gets displayindex through the
   646	 * ink index and calls helper to do the processing.
   647	 */
 > 648	void dmub_hpd_callback(struct amdgpu_device *adev, struct dmub_notification *notify)
   649	{
   650		struct amdgpu_dm_connector *aconnector;
   651		struct drm_connector *connector;
   652		struct drm_connector_list_iter iter;
   653		struct dc_link *link;
   654		uint8_t link_index = 0;
   655		struct drm_device *dev = adev->dm.ddev;
   656	
   657		if (adev == NULL)
   658			return;
   659	
   660		if (notify == NULL) {
   661			DRM_ERROR("DMUB HPD callback notification was NULL");
   662			return;
   663		}
   664	
   665		if (notify->link_index > adev->dm.dc->link_count) {
   666			DRM_ERROR("DMUB HPD index (%u)is abnormal", notify->link_index);
   667			return;
   668		}
   669	
   670		drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
   671	
   672		link_index = notify->link_index;
   673	
   674		link = adev->dm.dc->links[link_index];
   675	
   676		drm_connector_list_iter_begin(dev, &iter);
   677		drm_for_each_connector_iter(connector, &iter) {
   678			aconnector = to_amdgpu_dm_connector(connector);
   679			if (link && aconnector->dc_link == link) {
   680				DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
   681				handle_hpd_irq_helper(aconnector);
   682				break;
   683			}
   684		}
   685		drm_connector_list_iter_end(&iter);
   686		drm_modeset_unlock(&dev->mode_config.connection_mutex);
   687	
   688	}
   689	
   690	/**
   691	 * register_dmub_notify_callback - Sets callback for DMUB notify
   692	 * @adev: amdgpu_device pointer
   693	 * @type: Type of dmub notification
   694	 * @callback: Dmub interrupt callback function
   695	 * @dmub_int_thread_offload: offload indicator
   696	 *
   697	 * API to register a dmub callback handler for a dmub notification
   698	 * Also sets indicator whether callback processing to be offloaded.
   699	 * to dmub interrupt handling thread
   700	 * Return: true if successfully registered, false if there is existing registration
   701	 */
 > 702	bool register_dmub_notify_callback(struct amdgpu_device *adev, enum dmub_notification_type type,
   703	dmub_notify_interrupt_callback_t callback, bool dmub_int_thread_offload)
   704	{
   705		if (callback != NULL && type < ARRAY_SIZE(adev->dm.dmub_thread_offload)) {
   706			adev->dm.dmub_callback[type] = callback;
   707			adev->dm.dmub_thread_offload[type] = dmub_int_thread_offload;
   708		} else
   709			return false;
   710	
   711		return true;
   712	}
   713	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
