Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A883FAEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhH2W3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:29:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:46088 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235556AbhH2W3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:29:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="281899321"
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="281899321"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 15:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,362,1620716400"; 
   d="gz'50?scan'50,208,50";a="458911794"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2021 15:28:06 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKTHa-0004cS-1m; Sun, 29 Aug 2021 22:28:06 +0000
Date:   Mon, 30 Aug 2021 06:27:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Megha Dey <megha.dey@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [meghadey-crypto:d_msix 1/1] kernel/irq/msi.c:730: error: expected
 '(' at end of input
Message-ID: <202108300640.U9xSk7Lo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/meghadey/crypto d_msix
head:   37b5937a105abc8efe975c67fe4444e47da17c60
commit: 37b5937a105abc8efe975c67fe4444e47da17c60 [1/1] PCI/MSI: Dynamic allocation of MSI-X vectors
config: sparc64-randconfig-r002-20210829 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/meghadey/crypto/commit/37b5937a105abc8efe975c67fe4444e47da17c60
        git remote add meghadey-crypto https://github.com/meghadey/crypto
        git fetch --no-tags meghadey-crypto d_msix
        git checkout 37b5937a105abc8efe975c67fe4444e47da17c60
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   kernel/irq/msi.c: In function '__msi_domain_alloc_irqs':
>> include/linux/compiler_types.h:328:68: error: unterminated argument list invoking macro "if"
     328 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                                                    ^~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:119:18: note: in expansion of macro 'READ_ONCE'
     119 |         ___ret = READ_ONCE(*raw_cpu_ptr(&(pcp)));                       \
         |                  ^~~~~~~~~
   include/asm-generic/percpu.h:138:25: note: in expansion of macro '__this_cpu_generic_read_nopreempt'
     138 |                 __ret = __this_cpu_generic_read_nopreempt(pcp);         \
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:329:41: note: in expansion of macro 'this_cpu_generic_read'
     329 | #define this_cpu_read_8(pcp)            this_cpu_generic_read(pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:324:30: note: in expansion of macro 'this_cpu_read_8'
     324 |         case 8: pscr_ret__ = stem##8(variable); break;                  \
         |                              ^~~~
   include/linux/percpu-defs.h:507:41: note: in expansion of macro '__pcpu_size_call_return'
     507 | #define this_cpu_read(pcp)              __pcpu_size_call_return(this_cpu_read_, pcp)
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/interrupt.h:561:16: note: in expansion of macro 'this_cpu_read'
     561 |         return this_cpu_read(ksoftirqd);
         |                ^~~~~~~~~~~~~
>> kernel/irq/msi.c:730: error: expected '(' at end of input
   kernel/irq/msi.c:576:9: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
     576 |         if (ret
         |         ^~
   kernel/irq/msi.c:576:9: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
>> kernel/irq/msi.c:576:9: error: expected declaration or statement at end of input
   kernel/irq/msi.c:573:14: warning: unused variable 'can_reserve' [-Wunused-variable]
     573 |         bool can_reserve;
         |              ^~~~~~~~~~~
   kernel/irq/msi.c:572:21: warning: unused variable 'virq' [-Wunused-variable]
     572 |         int i, ret, virq;
         |                     ^~~~
   kernel/irq/msi.c:572:16: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     572 |         int i, ret, virq;
         |                ^~~
   kernel/irq/msi.c:572:13: warning: unused variable 'i' [-Wunused-variable]
     572 |         int i, ret, virq;
         |             ^
   kernel/irq/msi.c:570:26: warning: unused variable 'desc' [-Wunused-variable]
     570 |         struct msi_desc *desc;
         |                          ^~~~
   kernel/irq/msi.c:569:26: warning: unused variable 'irq_data' [-Wunused-variable]
     569 |         struct irq_data *irq_data;
         |                          ^~~~~~~~
   kernel/irq/msi.c:568:32: warning: unused variable 'ops' [-Wunused-variable]
     568 |         struct msi_domain_ops *ops = info->ops;
         |                                ^~~
   kernel/irq/msi.c:730: error: control reaches end of non-void function [-Werror=return-type]
   At top level:
   kernel/irq/msi.c:536:13: warning: 'msi_check_reservation_mode' defined but not used [-Wunused-function]
     536 | static bool msi_check_reservation_mode(struct irq_domain *domain,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +730 kernel/irq/msi.c

da5dd9e854d2ed Thomas Gleixner 2017-12-29  563  
43e9e705dd57c4 Thomas Gleixner 2020-08-26  564  int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
d9109698be6e74 Jiang Liu       2014-11-15  565  			    int nvec)
d9109698be6e74 Jiang Liu       2014-11-15  566  {
d9109698be6e74 Jiang Liu       2014-11-15  567  	struct msi_domain_info *info = domain->host_data;
d9109698be6e74 Jiang Liu       2014-11-15  568  	struct msi_domain_ops *ops = info->ops;
da5dd9e854d2ed Thomas Gleixner 2017-12-29  569  	struct irq_data *irq_data;
d9109698be6e74 Jiang Liu       2014-11-15  570  	struct msi_desc *desc;
06fde695ee7642 Zenghui Yu      2020-12-18  571  	msi_alloc_info_t arg = { };
b6140914fd079e Thomas Gleixner 2016-07-04  572  	int i, ret, virq;
da5dd9e854d2ed Thomas Gleixner 2017-12-29  573  	bool can_reserve;
d9109698be6e74 Jiang Liu       2014-11-15  574  
b2eba39bcab9d6 Marc Zyngier    2015-11-23  575  	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
37b5937a105abc Megha Dey       2021-08-26 @576  	if (ret
d9109698be6e74 Jiang Liu       2014-11-15  577  		return ret;
d9109698be6e74 Jiang Liu       2014-11-15  578  
37b5937a105abc Megha Dey       2021-08-26  579  	for_each_msi_entry_from(desc, dev) {
d9109698be6e74 Jiang Liu       2014-11-15  580  		ops->set_desc(&arg, desc);
d9109698be6e74 Jiang Liu       2014-11-15  581  
b6140914fd079e Thomas Gleixner 2016-07-04  582  		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
06ee6d571f0e35 Thomas Gleixner 2016-07-04  583  					       dev_to_node(dev), &arg, false,
0972fa57f53525 Thomas Gleixner 2016-07-04  584  					       desc->affinity);
d9109698be6e74 Jiang Liu       2014-11-15  585  		if (virq < 0) {
d9109698be6e74 Jiang Liu       2014-11-15  586  			ret = -ENOSPC;
d9109698be6e74 Jiang Liu       2014-11-15  587  			if (ops->handle_error)
d9109698be6e74 Jiang Liu       2014-11-15  588  				ret = ops->handle_error(domain, desc, ret);
d9109698be6e74 Jiang Liu       2014-11-15  589  			if (ops->msi_finish)
d9109698be6e74 Jiang Liu       2014-11-15  590  				ops->msi_finish(&arg, ret);
d9109698be6e74 Jiang Liu       2014-11-15  591  			return ret;
d9109698be6e74 Jiang Liu       2014-11-15  592  		}
d9109698be6e74 Jiang Liu       2014-11-15  593  
07557ccb8c83f3 Thomas Gleixner 2017-09-13  594  		for (i = 0; i < desc->nvec_used; i++) {
d9109698be6e74 Jiang Liu       2014-11-15  595  			irq_set_msi_desc_off(virq, i, desc);
07557ccb8c83f3 Thomas Gleixner 2017-09-13  596  			irq_debugfs_copy_devname(virq + i, dev);
07557ccb8c83f3 Thomas Gleixner 2017-09-13  597  		}
d9109698be6e74 Jiang Liu       2014-11-15  598  	}
d9109698be6e74 Jiang Liu       2014-11-15  599  
d9109698be6e74 Jiang Liu       2014-11-15  600  	if (ops->msi_finish)
d9109698be6e74 Jiang Liu       2014-11-15  601  		ops->msi_finish(&arg, 0);
d9109698be6e74 Jiang Liu       2014-11-15  602  
bc976233a872c0 Thomas Gleixner 2017-12-29  603  	can_reserve = msi_check_reservation_mode(domain, info, dev);
da5dd9e854d2ed Thomas Gleixner 2017-12-29  604  
f3b0946d629c8b Marc Zyngier    2016-07-13  605  	/*
f3b0946d629c8b Marc Zyngier    2016-07-13  606  	 * This flag is set by the PCI layer as we need to activate
f3b0946d629c8b Marc Zyngier    2016-07-13  607  	 * the MSI entries before the PCI layer enables MSI in the
f3b0946d629c8b Marc Zyngier    2016-07-13  608  	 * card. Otherwise the card latches a random msi message.
f3b0946d629c8b Marc Zyngier    2016-07-13  609  	 */
da5dd9e854d2ed Thomas Gleixner 2017-12-29  610  	if (!(info->flags & MSI_FLAG_ACTIVATE_EARLY))
4c457e8cb75eda Marc Zyngier    2021-01-23  611  		goto skip_activate;
f3b0946d629c8b Marc Zyngier    2016-07-13  612  
37b5937a105abc Megha Dey       2021-08-26  613  	for_each_msi_vector_from(desc, i, dev) {
4c457e8cb75eda Marc Zyngier    2021-01-23  614  		if (desc->irq == i) {
4c457e8cb75eda Marc Zyngier    2021-01-23  615  			virq = desc->irq;
4c457e8cb75eda Marc Zyngier    2021-01-23  616  			dev_dbg(dev, "irq [%d-%d] for MSI\n",
4c457e8cb75eda Marc Zyngier    2021-01-23  617  				virq, virq + desc->nvec_used - 1);
4c457e8cb75eda Marc Zyngier    2021-01-23  618  		}
4c457e8cb75eda Marc Zyngier    2021-01-23  619  		irq_data = irq_domain_get_irq_data(domain, i);
6f1a4891a5928a Thomas Gleixner 2020-01-31  620  		if (!can_reserve) {
bc976233a872c0 Thomas Gleixner 2017-12-29  621  			irqd_clr_can_reserve(irq_data);
6f1a4891a5928a Thomas Gleixner 2020-01-31  622  			if (domain->flags & IRQ_DOMAIN_MSI_NOMASK_QUIRK)
6f1a4891a5928a Thomas Gleixner 2020-01-31  623  				irqd_set_msi_nomask_quirk(irq_data);
6f1a4891a5928a Thomas Gleixner 2020-01-31  624  		}
bc976233a872c0 Thomas Gleixner 2017-12-29  625  		ret = irq_domain_activate_irq(irq_data, can_reserve);
bb9b428a5c832d Thomas Gleixner 2017-09-13  626  		if (ret)
bb9b428a5c832d Thomas Gleixner 2017-09-13  627  			goto cleanup;
da5dd9e854d2ed Thomas Gleixner 2017-12-29  628  	}
da5dd9e854d2ed Thomas Gleixner 2017-12-29  629  
4c457e8cb75eda Marc Zyngier    2021-01-23  630  skip_activate:
da5dd9e854d2ed Thomas Gleixner 2017-12-29  631  	/*
da5dd9e854d2ed Thomas Gleixner 2017-12-29  632  	 * If these interrupts use reservation mode, clear the activated bit
da5dd9e854d2ed Thomas Gleixner 2017-12-29  633  	 * so request_irq() will assign the final vector.
da5dd9e854d2ed Thomas Gleixner 2017-12-29  634  	 */
da5dd9e854d2ed Thomas Gleixner 2017-12-29  635  	if (can_reserve) {
37b5937a105abc Megha Dey       2021-08-26  636  		for_each_msi_vector_from(desc, i, dev) {
4c457e8cb75eda Marc Zyngier    2021-01-23  637  			irq_data = irq_domain_get_irq_data(domain, i);
22d0b12f3560d3 Thomas Gleixner 2017-09-13  638  			irqd_clr_activated(irq_data);
f3b0946d629c8b Marc Zyngier    2016-07-13  639  		}
d9109698be6e74 Jiang Liu       2014-11-15  640  	}
d9109698be6e74 Jiang Liu       2014-11-15  641  	return 0;
bb9b428a5c832d Thomas Gleixner 2017-09-13  642  
bb9b428a5c832d Thomas Gleixner 2017-09-13  643  cleanup:
bb9b428a5c832d Thomas Gleixner 2017-09-13  644  	msi_domain_free_irqs(domain, dev);
bb9b428a5c832d Thomas Gleixner 2017-09-13  645  	return ret;
d9109698be6e74 Jiang Liu       2014-11-15  646  }
d9109698be6e74 Jiang Liu       2014-11-15  647  
d9109698be6e74 Jiang Liu       2014-11-15  648  /**
43e9e705dd57c4 Thomas Gleixner 2020-08-26  649   * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
43e9e705dd57c4 Thomas Gleixner 2020-08-26  650   * @domain:	The domain to allocate from
d9109698be6e74 Jiang Liu       2014-11-15  651   * @dev:	Pointer to device struct of the device for which the interrupts
43e9e705dd57c4 Thomas Gleixner 2020-08-26  652   *		are allocated
43e9e705dd57c4 Thomas Gleixner 2020-08-26  653   * @nvec:	The number of interrupts to allocate
43e9e705dd57c4 Thomas Gleixner 2020-08-26  654   *
3b35e7e6daef5a Randy Dunlap    2021-08-10  655   * Return: %0 on success or an error code.
d9109698be6e74 Jiang Liu       2014-11-15  656   */
43e9e705dd57c4 Thomas Gleixner 2020-08-26  657  int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
43e9e705dd57c4 Thomas Gleixner 2020-08-26  658  			  int nvec)
43e9e705dd57c4 Thomas Gleixner 2020-08-26  659  {
43e9e705dd57c4 Thomas Gleixner 2020-08-26  660  	struct msi_domain_info *info = domain->host_data;
43e9e705dd57c4 Thomas Gleixner 2020-08-26  661  	struct msi_domain_ops *ops = info->ops;
43e9e705dd57c4 Thomas Gleixner 2020-08-26  662  
43e9e705dd57c4 Thomas Gleixner 2020-08-26  663  	return ops->domain_alloc_irqs(domain, dev, nvec);
43e9e705dd57c4 Thomas Gleixner 2020-08-26  664  }
43e9e705dd57c4 Thomas Gleixner 2020-08-26  665  
43e9e705dd57c4 Thomas Gleixner 2020-08-26  666  void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
d9109698be6e74 Jiang Liu       2014-11-15  667  {
dbbc93576e03fb Bixuan Cui      2021-05-18  668  	struct irq_data *irq_data;
d9109698be6e74 Jiang Liu       2014-11-15  669  	struct msi_desc *desc;
dbbc93576e03fb Bixuan Cui      2021-05-18  670  	int i;
dbbc93576e03fb Bixuan Cui      2021-05-18  671  
dbbc93576e03fb Bixuan Cui      2021-05-18  672  	for_each_msi_vector(desc, i, dev) {
dbbc93576e03fb Bixuan Cui      2021-05-18  673  		irq_data = irq_domain_get_irq_data(domain, i);
dbbc93576e03fb Bixuan Cui      2021-05-18  674  		if (irqd_is_activated(irq_data))
dbbc93576e03fb Bixuan Cui      2021-05-18  675  			irq_domain_deactivate_irq(irq_data);
dbbc93576e03fb Bixuan Cui      2021-05-18  676  	}
d9109698be6e74 Jiang Liu       2014-11-15  677  
d9109698be6e74 Jiang Liu       2014-11-15  678  	for_each_msi_entry(desc, dev) {
fe0c52fc003bc0 Marc Zyngier    2015-01-26  679  		/*
fe0c52fc003bc0 Marc Zyngier    2015-01-26  680  		 * We might have failed to allocate an MSI early
fe0c52fc003bc0 Marc Zyngier    2015-01-26  681  		 * enough that there is no IRQ associated to this
fe0c52fc003bc0 Marc Zyngier    2015-01-26  682  		 * entry. If that's the case, don't do anything.
fe0c52fc003bc0 Marc Zyngier    2015-01-26  683  		 */
fe0c52fc003bc0 Marc Zyngier    2015-01-26  684  		if (desc->irq) {
d9109698be6e74 Jiang Liu       2014-11-15  685  			irq_domain_free_irqs(desc->irq, desc->nvec_used);
d9109698be6e74 Jiang Liu       2014-11-15  686  			desc->irq = 0;
d9109698be6e74 Jiang Liu       2014-11-15  687  		}
d9109698be6e74 Jiang Liu       2014-11-15  688  	}
fe0c52fc003bc0 Marc Zyngier    2015-01-26  689  }
d9109698be6e74 Jiang Liu       2014-11-15  690  
43e9e705dd57c4 Thomas Gleixner 2020-08-26  691  /**
3b35e7e6daef5a Randy Dunlap    2021-08-10  692   * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated to @dev
43e9e705dd57c4 Thomas Gleixner 2020-08-26  693   * @domain:	The domain to managing the interrupts
43e9e705dd57c4 Thomas Gleixner 2020-08-26  694   * @dev:	Pointer to device struct of the device for which the interrupts
43e9e705dd57c4 Thomas Gleixner 2020-08-26  695   *		are free
43e9e705dd57c4 Thomas Gleixner 2020-08-26  696   */
43e9e705dd57c4 Thomas Gleixner 2020-08-26  697  void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
43e9e705dd57c4 Thomas Gleixner 2020-08-26  698  {
43e9e705dd57c4 Thomas Gleixner 2020-08-26  699  	struct msi_domain_info *info = domain->host_data;
43e9e705dd57c4 Thomas Gleixner 2020-08-26  700  	struct msi_domain_ops *ops = info->ops;
43e9e705dd57c4 Thomas Gleixner 2020-08-26  701  
43e9e705dd57c4 Thomas Gleixner 2020-08-26  702  	return ops->domain_free_irqs(domain, dev);
43e9e705dd57c4 Thomas Gleixner 2020-08-26  703  }
43e9e705dd57c4 Thomas Gleixner 2020-08-26  704  
37b5937a105abc Megha Dey       2021-08-26  705  void msi_domain_free_irq(struct irq_domain *domain, struct device *dev, unsigned int irq)
37b5937a105abc Megha Dey       2021-08-26  706  {
37b5937a105abc Megha Dey       2021-08-26  707  	struct msi_desc *desc = irq_get_msi_desc(irq);
37b5937a105abc Megha Dey       2021-08-26  708  	struct irq_data *irq_data;
37b5937a105abc Megha Dey       2021-08-26  709  
37b5937a105abc Megha Dey       2021-08-26  710  	irq_data = irq_domain_get_irq_data(domain, irq);
37b5937a105abc Megha Dey       2021-08-26  711  	if (irqd_is_activated(irq_data))
37b5937a105abc Megha Dey       2021-08-26  712  		irq_domain_deactivate_irq(irq_data);
37b5937a105abc Megha Dey       2021-08-26  713  
37b5937a105abc Megha Dey       2021-08-26  714  	irq_domain_free_irqs(desc->irq, 1);
37b5937a105abc Megha Dey       2021-08-26  715  	desc->irq = 0;
37b5937a105abc Megha Dey       2021-08-26  716  }
37b5937a105abc Megha Dey       2021-08-26  717  
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  718  /**
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  719   * msi_get_domain_info - Get the MSI interrupt domain info for @domain
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  720   * @domain:	The interrupt domain to retrieve data from
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  721   *
3b35e7e6daef5a Randy Dunlap    2021-08-10  722   * Return: the pointer to the msi_domain_info stored in @domain->host_data.
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  723   */
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  724  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain)
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  725  {
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  726  	return (struct msi_domain_info *)domain->host_data;
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  727  }
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  728  
f3cf8bb0d6c3c1 Jiang Liu       2014-11-12  729  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LZvS9be/3tNcYl/X--
