Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376C13290B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 21:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242988AbhCAUNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 15:13:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:6616 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235899AbhCARDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 12:03:50 -0500
IronPort-SDR: yPKU7TSqjEerrwT5C3zpICWzgw9NLZQiCi1hoG+KprQVDb+ZktPNebw9zvzer+v6wZFkRybzEN
 FC0T8+GdM/tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="165766143"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="165766143"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 09:02:42 -0800
IronPort-SDR: KBXsf6wW2q1PykwlqySVb7L/LRvhRWUnnEeS+co9JHXlrTdT46/wlEEpfuorJsvRMV7E6a3imG
 sBkzuxd0AyFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="505334816"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2021 09:02:40 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGlwO-0004eX-1Z; Mon, 01 Mar 2021 17:02:40 +0000
Date:   Tue, 2 Mar 2021 01:02:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/ath11k/mac.c:1892:7: warning: Uninitialized
 variable: ret
Message-ID: <202103020120.4uzsVzW3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
commit: 047679e366b9842a9da3ab82dca26fcaad8020eb ath11k: FILS discovery and unsolicited broadcast probe response support
date:   4 months ago
compiler: or1k-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> drivers/net/wireless/ath/ath11k/mac.c:1892:7: warning: Uninitialized variable: ret [uninitvar]
    if (!ret)
         ^

vim +1892 drivers/net/wireless/ath/ath11k/mac.c

  1852	
  1853	static int ath11k_mac_fils_discovery(struct ath11k_vif *arvif,
  1854					     struct ieee80211_bss_conf *info)
  1855	{
  1856		struct ath11k *ar = arvif->ar;
  1857		struct sk_buff *tmpl;
  1858		int ret;
  1859		u32 interval;
  1860		bool unsol_bcast_probe_resp_enabled = false;
  1861	
  1862		if (info->fils_discovery.max_interval) {
  1863			interval = info->fils_discovery.max_interval;
  1864	
  1865			tmpl = ieee80211_get_fils_discovery_tmpl(ar->hw, arvif->vif);
  1866			if (tmpl)
  1867				ret = ath11k_wmi_fils_discovery_tmpl(ar, arvif->vdev_id,
  1868								     tmpl);
  1869		} else if (info->unsol_bcast_probe_resp_interval) {
  1870			unsol_bcast_probe_resp_enabled = 1;
  1871			interval = info->unsol_bcast_probe_resp_interval;
  1872	
  1873			tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(ar->hw,
  1874									 arvif->vif);
  1875			if (tmpl)
  1876				ret = ath11k_wmi_probe_resp_tmpl(ar, arvif->vdev_id,
  1877								 tmpl);
  1878		} else { /* Disable */
  1879			return ath11k_wmi_fils_discovery(ar, arvif->vdev_id, 0, false);
  1880		}
  1881	
  1882		if (!tmpl) {
  1883			ath11k_warn(ar->ab,
  1884				    "mac vdev %i failed to retrieve %s template\n",
  1885				    arvif->vdev_id, (unsol_bcast_probe_resp_enabled ?
  1886				    "unsolicited broadcast probe response" :
  1887				    "FILS discovery"));
  1888			return -EPERM;
  1889		}
  1890		kfree_skb(tmpl);
  1891	
> 1892		if (!ret)
  1893			ret = ath11k_wmi_fils_discovery(ar, arvif->vdev_id, interval,
  1894							unsol_bcast_probe_resp_enabled);
  1895	
  1896		return ret;
  1897	}
  1898	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
