Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27A245DED4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356549AbhKYQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:58:31 -0500
Received: from mga11.intel.com ([192.55.52.93]:29885 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230456AbhKYQ4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:56:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="233033699"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="233033699"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 08:47:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="592060950"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Nov 2021 08:47:44 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqHuR-0006f6-UG; Thu, 25 Nov 2021 16:47:43 +0000
Date:   Fri, 26 Nov 2021 00:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: drivers/pci/controller/dwc/pci-keystone.c:1127:34: warning: unused
 variable 'ks_pcie_of_match'
Message-ID: <202111260033.s4hA7CmO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5f53fa508db098c9d372423a6dac31c8a5679cdf
commit: 476b70b4d1adff4465e9ff68021c52858555ac28 PCI: keystone: Enable compile-testing on !ARM
date:   1 year ago
config: x86_64-buildonly-randconfig-r004-20211118 (https://download.01.org/0day-ci/archive/20211126/202111260033.s4hA7CmO-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c46becf500df2a7fb4b4fce16178a036c344315a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=476b70b4d1adff4465e9ff68021c52858555ac28
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 476b70b4d1adff4465e9ff68021c52858555ac28
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pci-keystone.c:1127:34: warning: unused variable 'ks_pcie_of_match' [-Wunused-const-variable]
   static const struct of_device_id ks_pcie_of_match[] = {
                                    ^
   1 warning generated.


vim +/ks_pcie_of_match +1127 drivers/pci/controller/dwc/pci-keystone.c

18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1126  
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25 @1127  static const struct of_device_id ks_pcie_of_match[] = {
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1128  	{
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1129  		.type = "pci",
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1130  		.data = &ks_pcie_rc_of_data,
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1131  		.compatible = "ti,keystone-pcie",
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1132  	},
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1133  	{
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1134  		.data = &ks_pcie_am654_rc_of_data,
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1135  		.compatible = "ti,am654-pcie-rc",
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1136  	},
23284ad677a94f2 Kishon Vijay Abraham I 2019-03-25  1137  	{
23284ad677a94f2 Kishon Vijay Abraham I 2019-03-25  1138  		.data = &ks_pcie_am654_ep_of_data,
23284ad677a94f2 Kishon Vijay Abraham I 2019-03-25  1139  		.compatible = "ti,am654-pcie-ep",
23284ad677a94f2 Kishon Vijay Abraham I 2019-03-25  1140  	},
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1141  	{ },
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1142  };
18b0415bc802a8b Kishon Vijay Abraham I 2019-03-25  1143  

:::::: The code at line 1127 was first introduced by commit
:::::: 18b0415bc802a8bab5dedba5ae2757e83259e6ee PCI: keystone: Add support for PCIe RC in AM654x Platforms

:::::: TO: Kishon Vijay Abraham I <kishon@ti.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
