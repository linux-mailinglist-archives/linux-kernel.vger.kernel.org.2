Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBAC45DCB5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355917AbhKYOwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:52:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:21950 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355933AbhKYOuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:50:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="233019067"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="233019067"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 06:45:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="607588018"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 06:45:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqG0J-0006VC-7G; Thu, 25 Nov 2021 14:45:39 +0000
Date:   Thu, 25 Nov 2021 22:44:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 93/101] drivers/soc/ti/ti_sci_inta_msi.c:116:67:
 warning: passing argument 3 of 'msi_domain_alloc_irqs_descs_locked' makes
 pointer from integer without a cast
Message-ID: <202111252218.u8k5qJA4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   1bd31f3b9bc0cc3328fe9030a6b240ac1772d60a
commit: ff97d45fcc8af0d7ca617f3dfe7f35fb7d5339dc [93/101] genirq/msi: Add range argument to msi_domain_alloc/free_descs_locked()
config: arm64-buildonly-randconfig-r003-20211125 (https://download.01.org/0day-ci/archive/20211125/202111252218.u8k5qJA4-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=ff97d45fcc8af0d7ca617f3dfe7f35fb7d5339dc
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout ff97d45fcc8af0d7ca617f3dfe7f35fb7d5339dc
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/soc/ti/ti_sci_inta_msi.c: In function 'ti_sci_inta_msi_domain_alloc_irqs':
>> drivers/soc/ti/ti_sci_inta_msi.c:116:67: warning: passing argument 3 of 'msi_domain_alloc_irqs_descs_locked' makes pointer from integer without a cast [-Wint-conversion]
     116 |         ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
         |                                                                   ^~~~
         |                                                                   |
         |                                                                   int
   In file included from drivers/soc/ti/ti_sci_inta_msi.c:11:
   include/linux/msi.h:506:106: note: expected 'struct msi_range *' but argument is of type 'int'
     506 | int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,  struct msi_range *range);
         |                                                                                        ~~~~~~~~~~~~~~~~~~^~~~~


vim +/msi_domain_alloc_irqs_descs_locked +116 drivers/soc/ti/ti_sci_inta_msi.c

49b323157bf1e70 Lokesh Vutla    2019-04-30   90  
49b323157bf1e70 Lokesh Vutla    2019-04-30   91  int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
49b323157bf1e70 Lokesh Vutla    2019-04-30   92  				      struct ti_sci_resource *res)
49b323157bf1e70 Lokesh Vutla    2019-04-30   93  {
49b323157bf1e70 Lokesh Vutla    2019-04-30   94  	struct platform_device *pdev = to_platform_device(dev);
49b323157bf1e70 Lokesh Vutla    2019-04-30   95  	struct irq_domain *msi_domain;
49b323157bf1e70 Lokesh Vutla    2019-04-30   96  	int ret, nvec;
49b323157bf1e70 Lokesh Vutla    2019-04-30   97  
49b323157bf1e70 Lokesh Vutla    2019-04-30   98  	msi_domain = dev_get_msi_domain(dev);
49b323157bf1e70 Lokesh Vutla    2019-04-30   99  	if (!msi_domain)
49b323157bf1e70 Lokesh Vutla    2019-04-30  100  		return -EINVAL;
49b323157bf1e70 Lokesh Vutla    2019-04-30  101  
49b323157bf1e70 Lokesh Vutla    2019-04-30  102  	if (pdev->id < 0)
49b323157bf1e70 Lokesh Vutla    2019-04-30  103  		return -ENODEV;
49b323157bf1e70 Lokesh Vutla    2019-04-30  104  
025c2c9e7077d3a Thomas Gleixner 2021-11-10  105  	ret = msi_setup_device_data(dev);
025c2c9e7077d3a Thomas Gleixner 2021-11-10  106  	if (ret)
025c2c9e7077d3a Thomas Gleixner 2021-11-10  107  		return ret;
025c2c9e7077d3a Thomas Gleixner 2021-11-10  108  
b9f8772d4c17ea7 Thomas Gleixner 2021-11-10  109  	msi_lock_descs(dev);
49b323157bf1e70 Lokesh Vutla    2019-04-30  110  	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
b9f8772d4c17ea7 Thomas Gleixner 2021-11-10  111  	if (nvec <= 0) {
b9f8772d4c17ea7 Thomas Gleixner 2021-11-10  112  		ret = nvec;
b9f8772d4c17ea7 Thomas Gleixner 2021-11-10  113  		goto unlock;
49b323157bf1e70 Lokesh Vutla    2019-04-30  114  	}
49b323157bf1e70 Lokesh Vutla    2019-04-30  115  
b9f8772d4c17ea7 Thomas Gleixner 2021-11-10 @116  	ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);

:::::: The code at line 116 was first introduced by commit
:::::: b9f8772d4c17ea7bb4be6bd44f44077f791e29ca soc: ti: ti_sci_inta_msi: Rework MSI descriptor allocation

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
