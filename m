Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA703C6F05
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 12:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhGMK4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 06:56:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:60546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235744AbhGMK4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 06:56:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="209955740"
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="gz'50?scan'50,208,50";a="209955740"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 03:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,236,1620716400"; 
   d="gz'50?scan'50,208,50";a="630002509"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2021 03:53:47 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3G2s-000Hkm-BC; Tue, 13 Jul 2021 10:53:46 +0000
Date:   Tue, 13 Jul 2021 18:52:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: arch/arm/mach-s3c/irq-s3c24xx.c:529:31: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202107131813.ta1f2ywJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7fef2edf7cc753b51f7ccc74993971b0a9c81eca
commit: 71b9114d2c13a648fbe6523dd859e611c316ad90 ARM: s3c: move into a common directory
date:   11 months ago
config: arm-randconfig-s032-20210713 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71b9114d2c13a648fbe6523dd859e611c316ad90
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71b9114d2c13a648fbe6523dd859e611c316ad90
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/arm/mach-s3c/irq-s3c24xx.c:360:39: sparse: sparse: symbol 's3c24xx_handle_irq' was not declared. Should it be static?
>> arch/arm/mach-s3c/irq-s3c24xx.c:529:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   arch/arm/mach-s3c/irq-s3c24xx.c:529:31: sparse:     expected void [noderef] __iomem *base
   arch/arm/mach-s3c/irq-s3c24xx.c:529:31: sparse:     got void *
>> arch/arm/mach-s3c/irq-s3c24xx.c:573:22: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *base @@     got void * @@
   arch/arm/mach-s3c/irq-s3c24xx.c:573:22: sparse:     expected void [noderef] __iomem *base
   arch/arm/mach-s3c/irq-s3c24xx.c:573:22: sparse:     got void *
   arch/arm/mach-s3c/irq-s3c24xx.c:1308:12: sparse: sparse: symbol 's3c2410_init_intc_of' was not declared. Should it be static?
   arch/arm/mach-s3c/irq-s3c24xx.c:1330:12: sparse: sparse: symbol 's3c2416_init_intc_of' was not declared. Should it be static?

vim +529 arch/arm/mach-s3c/irq-s3c24xx.c

17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  359  
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07 @360  asmlinkage void __exception_irq_entry s3c24xx_handle_irq(struct pt_regs *regs)
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  361  {
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  362  	do {
658dc8fb9cbc77 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  363  		if (likely(s3c_intc[0]))
f0774d41da0e60 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  364  			if (s3c24xx_handle_intc(s3c_intc[0], regs, 0))
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  365  				continue;
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  366  
658dc8fb9cbc77 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  367  		if (s3c_intc[2])
f0774d41da0e60 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  368  			if (s3c24xx_handle_intc(s3c_intc[2], regs, 64))
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  369  				continue;
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  370  
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  371  		break;
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  372  	} while (1);
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  373  }
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  374  
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  375  #ifdef CONFIG_FIQ
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  376  /**
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  377   * s3c24xx_set_fiq - set the FIQ routing
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  378   * @irq: IRQ number to route to FIQ on processor.
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  379   * @ack_ptr: pointer to a location for storing the bit mask
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  380   * @on: Whether to route @irq to the FIQ, or to remove the FIQ routing.
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  381   *
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  382   * Change the state of the IRQ to FIQ routing depending on @irq and @on. If
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  383   * @on is true, the @irq is checked to see if it can be routed and the
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  384   * interrupt controller updated to route the IRQ. If @on is false, the FIQ
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  385   * routing is cleared, regardless of which @irq is specified.
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  386   *
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  387   * returns the mask value for the register.
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  388   */
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  389  int s3c24xx_set_fiq(unsigned int irq, u32 *ack_ptr, bool on)
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  390  {
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  391  	u32 intmod;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  392  	unsigned offs;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  393  
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  394  	if (on) {
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  395  		offs = irq - FIQ_START;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  396  		if (offs > 31)
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  397  			return 0;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  398  
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  399  		intmod = 1 << offs;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  400  	} else {
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  401  		intmod = 0;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  402  	}
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  403  
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  404  	if (ack_ptr)
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  405  		*ack_ptr = intmod;
353332855eef20 drivers/irqchip/irq-s3c24xx.c       Ben Dooks           2016-06-21  406  	writel_relaxed(intmod, S3C2410_INTMOD);
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  407  
cd4bd8f9435ddf arch/arm/mach-s3c24xx/irq-s3c24xx.c Arnd Bergmann       2020-08-06  408  	return intmod;
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  409  }
0f13c8248040d6 arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-12-07  410  
0f13c8248040d6 arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-12-07  411  EXPORT_SYMBOL_GPL(s3c24xx_set_fiq);
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  412  #endif
229fd8ffba57df arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2009-08-03  413  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  414  static int s3c24xx_irq_map(struct irq_domain *h, unsigned int virq,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  415  							irq_hw_number_t hw)
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  416  {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  417  	struct s3c_irq_intc *intc = h->host_data;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  418  	struct s3c_irq_data *irq_data = &intc->irqs[hw];
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  419  	struct s3c_irq_intc *parent_intc;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  420  	struct s3c_irq_data *parent_irq_data;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  421  	unsigned int irqno;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  422  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  423  	/* attach controller pointer to irq_data */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  424  	irq_data->intc = intc;
f5a25524508e68 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  425  	irq_data->offset = hw;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  426  
0fe3cb1ea5bf38 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  427  	parent_intc = intc->parent;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  428  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  429  	/* set handler and flags */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  430  	switch (irq_data->type) {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  431  	case S3C_IRQTYPE_NONE:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  432  		return 0;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  433  	case S3C_IRQTYPE_EINT:
1c8408e3137bcb arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-02-12  434  		/* On the S3C2412, the EINT0to3 have a parent irq
1c8408e3137bcb arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-02-12  435  		 * but need the s3c_irq_eint0t4 chip
1c8408e3137bcb arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-02-12  436  		 */
0fe3cb1ea5bf38 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  437  		if (parent_intc && (!soc_is_s3c2412() || hw >= 4))
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  438  			irq_set_chip_and_handler(virq, &s3c_irqext_chip,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  439  						 handle_edge_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  440  		else
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  441  			irq_set_chip_and_handler(virq, &s3c_irq_eint0t4,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  442  						 handle_edge_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  443  		break;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  444  	case S3C_IRQTYPE_EDGE:
0fe3cb1ea5bf38 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  445  		if (parent_intc || intc->reg_pending == S3C2416_SRCPND2)
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  446  			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  447  						 handle_edge_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  448  		else
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  449  			irq_set_chip_and_handler(virq, &s3c_irq_chip,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  450  						 handle_edge_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  451  		break;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  452  	case S3C_IRQTYPE_LEVEL:
0fe3cb1ea5bf38 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  453  		if (parent_intc)
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  454  			irq_set_chip_and_handler(virq, &s3c_irq_level_chip,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  455  						 handle_level_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  456  		else
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  457  			irq_set_chip_and_handler(virq, &s3c_irq_chip,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  458  						 handle_level_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  459  		break;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  460  	default:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  461  		pr_err("irq-s3c24xx: unsupported irqtype %d\n", irq_data->type);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  462  		return -EINVAL;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  463  	}
f5a25524508e68 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  464  
f5a25524508e68 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  465  	irq_set_chip_data(virq, irq_data);
f5a25524508e68 drivers/irqchip/irq-s3c24xx.c       Heiko Stuebner      2013-04-04  466  
0fe3cb1ea5bf38 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  467  	if (parent_intc && irq_data->type != S3C_IRQTYPE_NONE) {
502a29890cb102 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  468  		if (irq_data->parent_irq > 31) {
502a29890cb102 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  469  			pr_err("irq-s3c24xx: parent irq %lu is out of range\n",
502a29890cb102 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  470  			       irq_data->parent_irq);
d17cab4451df1f drivers/irqchip/irq-s3c24xx.c       Rob Herring         2015-08-29  471  			return -EINVAL;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  472  		}
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  473  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  474  		parent_irq_data = &parent_intc->irqs[irq_data->parent_irq];
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  475  		parent_irq_data->sub_intc = intc;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  476  		parent_irq_data->sub_bits |= (1UL << hw);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  477  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  478  		/* attach the demuxer to the parent irq */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  479  		irqno = irq_find_mapping(parent_intc->domain,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  480  					 irq_data->parent_irq);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  481  		if (!irqno) {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  482  			pr_err("irq-s3c24xx: could not find mapping for parent irq %lu\n",
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  483  			       irq_data->parent_irq);
d17cab4451df1f drivers/irqchip/irq-s3c24xx.c       Rob Herring         2015-08-29  484  			return -EINVAL;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  485  		}
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  486  		irq_set_chained_handler(irqno, s3c_irq_demux);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  487  	}
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  488  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  489  	return 0;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  490  }
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  491  
9600973656c697 drivers/irqchip/irq-s3c24xx.c       Krzysztof Kozlowski 2015-04-27  492  static const struct irq_domain_ops s3c24xx_irq_ops = {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  493  	.map = s3c24xx_irq_map,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  494  	.xlate = irq_domain_xlate_twocell,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  495  };
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  496  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  497  static void s3c24xx_clear_intc(struct s3c_irq_intc *intc)
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  498  {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  499  	void __iomem *reg_source;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  500  	unsigned long pend;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  501  	unsigned long last;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  502  	int i;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  503  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  504  	/* if intpnd is set, read the next pending irq from there */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  505  	reg_source = intc->reg_intpnd ? intc->reg_intpnd : intc->reg_pending;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  506  
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  507  	last = 0;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  508  	for (i = 0; i < 4; i++) {
353332855eef20 drivers/irqchip/irq-s3c24xx.c       Ben Dooks           2016-06-21  509  		pend = readl_relaxed(reg_source);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  510  
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  511  		if (pend == 0 || pend == last)
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  512  			break;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  513  
353332855eef20 drivers/irqchip/irq-s3c24xx.c       Ben Dooks           2016-06-21  514  		writel_relaxed(pend, intc->reg_pending);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  515  		if (intc->reg_intpnd)
353332855eef20 drivers/irqchip/irq-s3c24xx.c       Ben Dooks           2016-06-21  516  			writel_relaxed(pend, intc->reg_intpnd);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  517  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  518  		pr_info("irq: clearing pending status %08x\n", (int)pend);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  519  		last = pend;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  520  	}
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  521  }
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  522  
bc8fd900c4d460 drivers/irqchip/irq-s3c24xx.c       Arnd Bergmann       2013-04-25  523  static struct s3c_irq_intc * __init s3c24xx_init_intc(struct device_node *np,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  524  				       struct s3c_irq_data *irq_data,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  525  				       struct s3c_irq_intc *parent,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  526  				       unsigned long address)
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  527  {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  528  	struct s3c_irq_intc *intc;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29 @529  	void __iomem *base = (void *)0xf6000000; /* static mapping */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  530  	int irq_num;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  531  	int irq_start;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  532  	int ret;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  533  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  534  	intc = kzalloc(sizeof(struct s3c_irq_intc), GFP_KERNEL);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  535  	if (!intc)
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  536  		return ERR_PTR(-ENOMEM);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  537  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  538  	intc->irqs = irq_data;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  539  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  540  	if (parent)
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  541  		intc->parent = parent;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  542  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  543  	/* select the correct data for the controller.
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  544  	 * Need to hard code the irq num start and offset
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  545  	 * to preserve the static mapping for now
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  546  	 */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  547  	switch (address) {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  548  	case 0x4a000000:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  549  		pr_debug("irq: found main intc\n");
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  550  		intc->reg_pending = base;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  551  		intc->reg_mask = base + 0x08;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  552  		intc->reg_intpnd = base + 0x10;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  553  		irq_num = 32;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  554  		irq_start = S3C2410_IRQ(0);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  555  		break;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  556  	case 0x4a000018:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  557  		pr_debug("irq: found subintc\n");
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  558  		intc->reg_pending = base + 0x18;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  559  		intc->reg_mask = base + 0x1c;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  560  		irq_num = 29;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  561  		irq_start = S3C2410_IRQSUB(0);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  562  		break;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  563  	case 0x4a000040:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  564  		pr_debug("irq: found intc2\n");
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  565  		intc->reg_pending = base + 0x40;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  566  		intc->reg_mask = base + 0x48;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  567  		intc->reg_intpnd = base + 0x50;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  568  		irq_num = 8;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  569  		irq_start = S3C2416_IRQ(0);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  570  		break;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  571  	case 0x560000a4:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  572  		pr_debug("irq: found eintc\n");
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29 @573  		base = (void *)0xfd000000;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  574  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  575  		intc->reg_mask = base + 0xa4;
646dd2f0a98094 arch/arm/mach-s3c24xx/irq.c         Sylwester Nawrocki  2013-04-09  576  		intc->reg_pending = base + 0xa8;
5424f2188a76d0 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-02-12  577  		irq_num = 24;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  578  		irq_start = S3C2410_IRQ(32);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  579  		break;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  580  	default:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  581  		pr_err("irq: unsupported controller address\n");
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  582  		ret = -EINVAL;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  583  		goto err;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  584  	}
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  585  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  586  	/* now that all the data is complete, init the irq-domain */
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  587  	s3c24xx_clear_intc(intc);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  588  	intc->domain = irq_domain_add_legacy(np, irq_num, irq_start,
5424f2188a76d0 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-02-12  589  					     0, &s3c24xx_irq_ops,
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  590  					     intc);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  591  	if (!intc->domain) {
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  592  		pr_err("irq: could not create irq-domain\n");
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  593  		ret = -EINVAL;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  594  		goto err;
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  595  	}
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  596  
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  597  	set_handle_irq(s3c24xx_handle_irq);
17453dd2e7df20 arch/arm/mach-s3c24xx/irq.c         Heiko Stuebner      2013-03-07  598  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  599  	return intc;
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  600  
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  601  err:
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  602  	kfree(intc);
1f629b7a3ced8e arch/arm/plat-s3c24xx/irq.c         Heiko Stuebner      2013-01-29  603  	return ERR_PTR(ret);
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  604  }
a21765a70ec06b arch/arm/plat-s3c24xx/irq.c         Ben Dooks           2007-02-11  605  

:::::: The code at line 529 was first introduced by commit
:::::: 1f629b7a3ced8e73784a9ae3b0d9039496878f18 ARM: S3C24XX: transform irq handling into a declarative form

:::::: TO: Heiko Stuebner <heiko@sntech.de>
:::::: CC: Kukjin Kim <kgene.kim@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ikeVEW9yuYc//A+q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
74YBAA==

--ikeVEW9yuYc//A+q--
