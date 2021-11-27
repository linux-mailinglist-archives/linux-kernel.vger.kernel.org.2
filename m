Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEB7E45FF0D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 15:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355235AbhK0OOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 09:14:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:24987 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235734AbhK0OMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 09:12:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235581715"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="235581715"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 06:08:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="675800733"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2021 06:08:53 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqyNo-0009c3-Nu; Sat, 27 Nov 2021 14:08:52 +0000
Date:   Sat, 27 Nov 2021 22:08:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-20211125 9/11] drivers/irqchip/irq-gic.c:433:46:
 warning: comparison of constant '1' with boolean expression is always false
Message-ID: <202111272225.wq15DtQK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-20211125
head:   e3a9cfe4830141c88aa5d8a93eae3512b2ae2882
commit: 9a237acabf8c32b395723ad4a1642201573e6ed1 [9/11] lib/cpumask: introduce num_possible_cpus_{eq,gt,le}
config: arm-defconfig (https://download.01.org/0day-ci/archive/20211127/202111272225.wq15DtQK-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/9a237acabf8c32b395723ad4a1642201573e6ed1
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-20211125
        git checkout 9a237acabf8c32b395723ad4a1642201573e6ed1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-gic.c: In function 'gic_get_cpumask':
>> drivers/irqchip/irq-gic.c:433:46: warning: comparison of constant '1' with boolean expression is always false [-Wbool-compare]
     433 |         if (!mask && num_possible_cpus_gt(1) > 1)
         |                                              ^


vim +/1 +433 drivers/irqchip/irq-gic.c

   419	
   420	static u8 gic_get_cpumask(struct gic_chip_data *gic)
   421	{
   422		void __iomem *base = gic_data_dist_base(gic);
   423		u32 mask, i;
   424	
   425		for (i = mask = 0; i < 32; i += 4) {
   426			mask = readl_relaxed(base + GIC_DIST_TARGET + i);
   427			mask |= mask >> 16;
   428			mask |= mask >> 8;
   429			if (mask)
   430				break;
   431		}
   432	
 > 433		if (!mask && num_possible_cpus_gt(1) > 1)
   434			pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
   435	
   436		return mask;
   437	}
   438	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
