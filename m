Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E728645FE32
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 11:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhK0K7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 05:59:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:55937 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhK0K5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 05:57:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235690871"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="235690871"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 02:53:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="675769121"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2021 02:53:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqvL0-0009OG-PL; Sat, 27 Nov 2021 10:53:46 +0000
Date:   Sat, 27 Nov 2021 18:53:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-devel:msi 93/101] drivers/soc/ti/ti_sci_inta_msi.c:116:60:
 warning: incompatible integer to pointer conversion passing 'int' to
 parameter of type 'struct msi_range *'
Message-ID: <202111271856.wXc90TMb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi
head:   900894c6ddc1b5b5a8f0c99ca573619d996468b8
commit: 46c1ea0c989ee963922a41cb88027994da48786c [93/101] genirq/msi: Add range argument to msi_domain_alloc/free_descs_locked()
config: arm64-randconfig-r006-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271856.wXc90TMb-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=46c1ea0c989ee963922a41cb88027994da48786c
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel msi
        git checkout 46c1ea0c989ee963922a41cb88027994da48786c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/soc/ti/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/soc/ti/ti_sci_inta_msi.c:116:60: warning: incompatible integer to pointer conversion passing 'int' to parameter of type 'struct msi_range *' [-Wint-conversion]
           ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
                                                                     ^~~~
   include/linux/msi.h:506:106: note: passing argument to parameter 'range' here
   int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,  struct msi_range *range);
                                                                                                            ^
   1 warning generated.


vim +116 drivers/soc/ti/ti_sci_inta_msi.c

49b323157bf1e7 Lokesh Vutla    2019-04-30   90  
49b323157bf1e7 Lokesh Vutla    2019-04-30   91  int ti_sci_inta_msi_domain_alloc_irqs(struct device *dev,
49b323157bf1e7 Lokesh Vutla    2019-04-30   92  				      struct ti_sci_resource *res)
49b323157bf1e7 Lokesh Vutla    2019-04-30   93  {
49b323157bf1e7 Lokesh Vutla    2019-04-30   94  	struct platform_device *pdev = to_platform_device(dev);
49b323157bf1e7 Lokesh Vutla    2019-04-30   95  	struct irq_domain *msi_domain;
49b323157bf1e7 Lokesh Vutla    2019-04-30   96  	int ret, nvec;
49b323157bf1e7 Lokesh Vutla    2019-04-30   97  
49b323157bf1e7 Lokesh Vutla    2019-04-30   98  	msi_domain = dev_get_msi_domain(dev);
49b323157bf1e7 Lokesh Vutla    2019-04-30   99  	if (!msi_domain)
49b323157bf1e7 Lokesh Vutla    2019-04-30  100  		return -EINVAL;
49b323157bf1e7 Lokesh Vutla    2019-04-30  101  
49b323157bf1e7 Lokesh Vutla    2019-04-30  102  	if (pdev->id < 0)
49b323157bf1e7 Lokesh Vutla    2019-04-30  103  		return -ENODEV;
49b323157bf1e7 Lokesh Vutla    2019-04-30  104  
43736dc111781c Thomas Gleixner 2021-11-10  105  	ret = msi_setup_device_data(dev);
43736dc111781c Thomas Gleixner 2021-11-10  106  	if (ret)
43736dc111781c Thomas Gleixner 2021-11-10  107  		return ret;
43736dc111781c Thomas Gleixner 2021-11-10  108  
32e74ad753f574 Thomas Gleixner 2021-11-10  109  	msi_lock_descs(dev);
49b323157bf1e7 Lokesh Vutla    2019-04-30  110  	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
32e74ad753f574 Thomas Gleixner 2021-11-10  111  	if (nvec <= 0) {
32e74ad753f574 Thomas Gleixner 2021-11-10  112  		ret = nvec;
32e74ad753f574 Thomas Gleixner 2021-11-10  113  		goto unlock;
49b323157bf1e7 Lokesh Vutla    2019-04-30  114  	}
49b323157bf1e7 Lokesh Vutla    2019-04-30  115  
32e74ad753f574 Thomas Gleixner 2021-11-10 @116  	ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);

:::::: The code at line 116 was first introduced by commit
:::::: 32e74ad753f5747e1f201dc462a05ad80e9389ce soc: ti: ti_sci_inta_msi: Rework MSI descriptor allocation

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
