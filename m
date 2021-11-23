Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4082A459CCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 08:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhKWHht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 02:37:49 -0500
Received: from mga01.intel.com ([192.55.52.88]:37701 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhKWHhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 02:37:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="258818224"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="258818224"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 23:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="456606013"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2021 23:34:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpQJy-0001at-2l; Tue, 23 Nov 2021 07:34:30 +0000
Date:   Tue, 23 Nov 2021 15:34:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime@cerno.tech>
Subject: [sunxi:sunxi/clk-for-5.17 4/10]
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:532:46: error: 'pdev' undeclared
Message-ID: <202111231442.Mg1z9HFF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/clk-for-5.17
head:   c81821db64a8957e8ff4ebd4cdda60243ab5c949
commit: 72928074833fef3290e89f00dc471c037bcebc0c [4/10] clk: sunxi-ng: Allow the CCU core to be built as a module
config: parisc-buildonly-randconfig-r005-20211123 (https://download.01.org/0day-ci/archive/20211123/202111231442.Mg1z9HFF-lkp@intel.com/config.gz)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/commit/?id=72928074833fef3290e89f00dc471c037bcebc0c
        git remote add sunxi https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
        git fetch --no-tags sunxi sunxi/clk-for-5.17
        git checkout 72928074833fef3290e89f00dc471c037bcebc0c
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash drivers/clk/sunxi-ng/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c: In function 'suniv_f1c100s_ccu_setup':
>> drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:532:46: error: 'pdev' undeclared (first use in this function)
     532 |         reg = devm_platform_ioremap_resource(pdev, 0);
         |                                              ^~~~
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:532:46: note: each undeclared identifier is reported only once for each function it appears in
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:534:24: error: 'return' with a value, in function returning void [-Werror=return-type]
     534 |                 return PTR_ERR(reg);
         |                        ^~~~~~~~~~~~
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:526:20: note: declared here
     526 | static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:543:24: error: 'return' with a value, in function returning void [-Werror=return-type]
     543 |                 return ret;
         |                        ^~~
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:526:20: note: declared here
     526 | static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:552:16: error: 'return' with a value, in function returning void [-Werror=return-type]
     552 |         return 0;
         |                ^
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:526:20: note: declared here
     526 | static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c: At top level:
>> drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:561:19: error: 'suniv_f1c100s_ccu_probe' undeclared here (not in a function); did you mean 'suniv_f1c100s_ccu_driver'?
     561 |         .probe  = suniv_f1c100s_ccu_probe,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
         |                   suniv_f1c100s_ccu_driver
   drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c:526:20: warning: 'suniv_f1c100s_ccu_setup' defined but not used [-Wunused-function]
     526 | static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/pdev +532 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c

0380126eb9afc4 Mesih Kilinc   2018-12-02  525  
0380126eb9afc4 Mesih Kilinc   2018-12-02  526  static void __init suniv_f1c100s_ccu_setup(struct device_node *node)
0380126eb9afc4 Mesih Kilinc   2018-12-02  527  {
0380126eb9afc4 Mesih Kilinc   2018-12-02  528  	void __iomem *reg;
72dc8e122383fc Samuel Holland 2021-11-18  529  	int ret;
0380126eb9afc4 Mesih Kilinc   2018-12-02  530  	u32 val;
0380126eb9afc4 Mesih Kilinc   2018-12-02  531  
72dc8e122383fc Samuel Holland 2021-11-18 @532  	reg = devm_platform_ioremap_resource(pdev, 0);
72dc8e122383fc Samuel Holland 2021-11-18  533  	if (IS_ERR(reg))
72dc8e122383fc Samuel Holland 2021-11-18  534  		return PTR_ERR(reg);
0380126eb9afc4 Mesih Kilinc   2018-12-02  535  
0380126eb9afc4 Mesih Kilinc   2018-12-02  536  	/* Force the PLL-Audio-1x divider to 4 */
0380126eb9afc4 Mesih Kilinc   2018-12-02  537  	val = readl(reg + SUNIV_PLL_AUDIO_REG);
0380126eb9afc4 Mesih Kilinc   2018-12-02  538  	val &= ~GENMASK(19, 16);
0380126eb9afc4 Mesih Kilinc   2018-12-02  539  	writel(val | (3 << 16), reg + SUNIV_PLL_AUDIO_REG);
0380126eb9afc4 Mesih Kilinc   2018-12-02  540  
72dc8e122383fc Samuel Holland 2021-11-18  541  	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &suniv_ccu_desc);
72dc8e122383fc Samuel Holland 2021-11-18  542  	if (ret)
72dc8e122383fc Samuel Holland 2021-11-18  543  		return ret;
0380126eb9afc4 Mesih Kilinc   2018-12-02  544  
0380126eb9afc4 Mesih Kilinc   2018-12-02  545  	/* Gate then ungate PLL CPU after any rate changes */
0380126eb9afc4 Mesih Kilinc   2018-12-02  546  	ccu_pll_notifier_register(&suniv_pll_cpu_nb);
0380126eb9afc4 Mesih Kilinc   2018-12-02  547  
0380126eb9afc4 Mesih Kilinc   2018-12-02  548  	/* Reparent CPU during PLL CPU rate changes */
0380126eb9afc4 Mesih Kilinc   2018-12-02  549  	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
0380126eb9afc4 Mesih Kilinc   2018-12-02  550  				  &suniv_cpu_nb);
72dc8e122383fc Samuel Holland 2021-11-18  551  
72dc8e122383fc Samuel Holland 2021-11-18 @552  	return 0;
0380126eb9afc4 Mesih Kilinc   2018-12-02  553  }
72dc8e122383fc Samuel Holland 2021-11-18  554  
72dc8e122383fc Samuel Holland 2021-11-18  555  static const struct of_device_id suniv_f1c100s_ccu_ids[] = {
72dc8e122383fc Samuel Holland 2021-11-18  556  	{ .compatible = "allwinner,suniv-f1c100s-ccu" },
72dc8e122383fc Samuel Holland 2021-11-18  557  	{ }
72dc8e122383fc Samuel Holland 2021-11-18  558  };
72dc8e122383fc Samuel Holland 2021-11-18  559  
72dc8e122383fc Samuel Holland 2021-11-18  560  static struct platform_driver suniv_f1c100s_ccu_driver = {
72dc8e122383fc Samuel Holland 2021-11-18 @561  	.probe	= suniv_f1c100s_ccu_probe,
72dc8e122383fc Samuel Holland 2021-11-18  562  	.driver	= {
72dc8e122383fc Samuel Holland 2021-11-18  563  		.name			= "suniv-f1c100s-ccu",
72dc8e122383fc Samuel Holland 2021-11-18  564  		.suppress_bind_attrs	= true,
72dc8e122383fc Samuel Holland 2021-11-18  565  		.of_match_table		= suniv_f1c100s_ccu_ids,
72dc8e122383fc Samuel Holland 2021-11-18  566  	},
72dc8e122383fc Samuel Holland 2021-11-18  567  };
72dc8e122383fc Samuel Holland 2021-11-18  568  module_platform_driver(suniv_f1c100s_ccu_driver);
72dc8e122383fc Samuel Holland 2021-11-18  569  

:::::: The code at line 532 was first introduced by commit
:::::: 72dc8e122383fcce2ef6d32e351ec0609bd7ca49 clk: sunxi-ng: Convert early providers to platform drivers

:::::: TO: Samuel Holland <samuel@sholland.org>
:::::: CC: Maxime Ripard <maxime@cerno.tech>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
