Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2E45F324
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbhKZRq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 12:46:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:51719 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235556AbhKZRoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:44:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="233192610"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="233192610"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 09:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="498477862"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2021 09:41:09 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqfDg-0008O7-Db; Fri, 26 Nov 2021 17:41:08 +0000
Date:   Sat, 27 Nov 2021 01:41:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Ertman <david.m.ertman@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Subject: drivers/net/ethernet/intel/ice/ice_dcb_nl.c:66:6: warning: variable
 'bwcfg' set but not used
Message-ID: <202111270145.6iqJ5sdb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 2a87bd73e50d1c71392c036b0b31c9b2418981d0 ice: Add DSCP support
date:   8 weeks ago
config: i386-randconfig-a003-20211126 (https://download.01.org/0day-ci/archive/20211127/202111270145.6iqJ5sdb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2a87bd73e50d1c71392c036b0b31c9b2418981d0
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2a87bd73e50d1c71392c036b0b31c9b2418981d0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/ice/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_dcb_nl.c:66:6: warning: variable 'bwcfg' set but not used [-Wunused-but-set-variable]
           int bwcfg = 0, bwrec = 0;
               ^
   1 warning generated.


vim +/bwcfg +66 drivers/net/ethernet/intel/ice/ice_dcb_nl.c

b94b013eb626952 Dave Ertman      2019-11-06   56  
b94b013eb626952 Dave Ertman      2019-11-06   57  /**
b94b013eb626952 Dave Ertman      2019-11-06   58   * ice_dcbnl_setets - set IEEE ETS configuration
b94b013eb626952 Dave Ertman      2019-11-06   59   * @netdev: pointer to relevant netdev
b94b013eb626952 Dave Ertman      2019-11-06   60   * @ets: struct to hold ETS configuration
b94b013eb626952 Dave Ertman      2019-11-06   61   */
b94b013eb626952 Dave Ertman      2019-11-06   62  static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
b94b013eb626952 Dave Ertman      2019-11-06   63  {
b94b013eb626952 Dave Ertman      2019-11-06   64  	struct ice_pf *pf = ice_netdev_to_pf(netdev);
b94b013eb626952 Dave Ertman      2019-11-06   65  	struct ice_dcbx_cfg *new_cfg;
b94b013eb626952 Dave Ertman      2019-11-06  @66  	int bwcfg = 0, bwrec = 0;
2a87bd73e50d1c7 Dave Ertman      2021-08-06   67  	int err, i;
b94b013eb626952 Dave Ertman      2019-11-06   68  
b94b013eb626952 Dave Ertman      2019-11-06   69  	if ((pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) ||
b94b013eb626952 Dave Ertman      2019-11-06   70  	    !(pf->dcbx_cap & DCB_CAP_DCBX_VER_IEEE))
b94b013eb626952 Dave Ertman      2019-11-06   71  		return -EINVAL;
b94b013eb626952 Dave Ertman      2019-11-06   72  
fc2d1165d4a424d Chinh T Cao      2020-11-20   73  	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
b94b013eb626952 Dave Ertman      2019-11-06   74  
b94b013eb626952 Dave Ertman      2019-11-06   75  	mutex_lock(&pf->tc_mutex);
b94b013eb626952 Dave Ertman      2019-11-06   76  
b94b013eb626952 Dave Ertman      2019-11-06   77  	new_cfg->etscfg.willing = ets->willing;
b94b013eb626952 Dave Ertman      2019-11-06   78  	new_cfg->etscfg.cbs = ets->cbs;
b94b013eb626952 Dave Ertman      2019-11-06   79  	ice_for_each_traffic_class(i) {
b94b013eb626952 Dave Ertman      2019-11-06   80  		new_cfg->etscfg.tcbwtable[i] = ets->tc_tx_bw[i];
b94b013eb626952 Dave Ertman      2019-11-06   81  		bwcfg += ets->tc_tx_bw[i];
b94b013eb626952 Dave Ertman      2019-11-06   82  		new_cfg->etscfg.tsatable[i] = ets->tc_tsa[i];
2a87bd73e50d1c7 Dave Ertman      2021-08-06   83  		if (new_cfg->pfc_mode == ICE_QOS_MODE_VLAN) {
2a87bd73e50d1c7 Dave Ertman      2021-08-06   84  			/* in DSCP mode up->tc mapping cannot change */
b94b013eb626952 Dave Ertman      2019-11-06   85  			new_cfg->etscfg.prio_table[i] = ets->prio_tc[i];
2a87bd73e50d1c7 Dave Ertman      2021-08-06   86  			new_cfg->etsrec.prio_table[i] = ets->reco_prio_tc[i];
2a87bd73e50d1c7 Dave Ertman      2021-08-06   87  		}
b94b013eb626952 Dave Ertman      2019-11-06   88  		new_cfg->etsrec.tcbwtable[i] = ets->tc_reco_bw[i];
b94b013eb626952 Dave Ertman      2019-11-06   89  		bwrec += ets->tc_reco_bw[i];
b94b013eb626952 Dave Ertman      2019-11-06   90  		new_cfg->etsrec.tsatable[i] = ets->tc_reco_tsa[i];
b94b013eb626952 Dave Ertman      2019-11-06   91  	}
b94b013eb626952 Dave Ertman      2019-11-06   92  
a29a912d448dbc9 Avinash Dayanand 2020-02-13   93  	if (ice_dcb_bwchk(pf, new_cfg)) {
a29a912d448dbc9 Avinash Dayanand 2020-02-13   94  		err = -EINVAL;
a29a912d448dbc9 Avinash Dayanand 2020-02-13   95  		goto ets_out;
a29a912d448dbc9 Avinash Dayanand 2020-02-13   96  	}
a29a912d448dbc9 Avinash Dayanand 2020-02-13   97  
2a87bd73e50d1c7 Dave Ertman      2021-08-06   98  	new_cfg->etscfg.maxtcs = pf->hw.func_caps.common_cap.maxtc;
b94b013eb626952 Dave Ertman      2019-11-06   99  
b94b013eb626952 Dave Ertman      2019-11-06  100  	if (!bwrec)
b94b013eb626952 Dave Ertman      2019-11-06  101  		new_cfg->etsrec.tcbwtable[0] = 100;
b94b013eb626952 Dave Ertman      2019-11-06  102  
b94b013eb626952 Dave Ertman      2019-11-06  103  	err = ice_pf_dcb_cfg(pf, new_cfg, true);
b94b013eb626952 Dave Ertman      2019-11-06  104  	/* return of zero indicates new cfg applied */
b94b013eb626952 Dave Ertman      2019-11-06  105  	if (err == ICE_DCB_HW_CHG_RST)
b94b013eb626952 Dave Ertman      2019-11-06  106  		ice_dcbnl_devreset(netdev);
b94b013eb626952 Dave Ertman      2019-11-06  107  	if (err == ICE_DCB_NO_HW_CHG)
b94b013eb626952 Dave Ertman      2019-11-06  108  		err = ICE_DCB_HW_CHG_RST;
b94b013eb626952 Dave Ertman      2019-11-06  109  
a29a912d448dbc9 Avinash Dayanand 2020-02-13  110  ets_out:
b94b013eb626952 Dave Ertman      2019-11-06  111  	mutex_unlock(&pf->tc_mutex);
b94b013eb626952 Dave Ertman      2019-11-06  112  	return err;
b94b013eb626952 Dave Ertman      2019-11-06  113  }
b94b013eb626952 Dave Ertman      2019-11-06  114  

:::::: The code at line 66 was first introduced by commit
:::::: b94b013eb6269526eeb3768101666ba6f526313e ice: Implement DCBNL support

:::::: TO: Dave Ertman <david.m.ertman@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
