Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D002345FBE6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 03:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbhK0CSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 21:18:49 -0500
Received: from mga03.intel.com ([134.134.136.65]:16323 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236655AbhK0CQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 21:16:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235672463"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="235672463"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 18:13:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="498623509"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 26 Nov 2021 18:13:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqnDV-0008vc-Ht; Sat, 27 Nov 2021 02:13:29 +0000
Date:   Sat, 27 Nov 2021 10:12:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 68/69]
 drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: redefinition of
 'field_mask' as different kind of symbol
Message-ID: <202111271000.4rTe0TiV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   df6df62e60f3a32773b02a41e0d6a4e0f2b353b5
commit: 294ac78fcc3c89b63c48a5f85d4352de0a73b078 [68/69] irqchip: MStar wakeup intc
config: arm64-randconfig-r035-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271000.4rTe0TiV-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/linux-chenxing/linux/commit/294ac78fcc3c89b63c48a5f85d4352de0a73b078
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout 294ac78fcc3c89b63c48a5f85d4352de0a73b078
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: redefinition of 'field_mask' as different kind of symbol
   static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
                           ^
   include/linux/bitfield.h:122:28: note: previous definition is here
   static __always_inline u64 field_mask(u64 field)
                              ^
>> drivers/irqchip/irq-msc313-pm-wakeup.c:118:43: error: passing 'u64 (u64)' (aka 'unsigned long long (unsigned long long)') to parameter of incompatible type 'struct reg_field'
           intc->mask = regmap_field_alloc(pmsleep, field_mask);
                                                    ^~~~~~~~~~
   include/linux/regmap.h:1265:20: note: passing argument to parameter 'reg_field' here
                   struct reg_field reg_field);
                                    ^
   drivers/irqchip/irq-msc313-pm-wakeup.c:132:2: warning: ignoring return value of function declared with 'warn_unused_result' attribute [-Wunused-result]
           request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
           ^~~~~~~~~~~ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 2 errors generated.


vim +/field_mask +21 drivers/irqchip/irq-msc313-pm-wakeup.c

    20	
  > 21	static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
    22	static struct reg_field field_type = REG_FIELD(MSTAR_PMSLEEP_REG24, 0, 7);
    23	static struct reg_field field_status = REG_FIELD(MSTAR_PMSLEEP_WAKEINT_STATUS, 0, 7);
    24	
    25	struct msc313_sleep_intc {
    26		struct regmap_field *mask;
    27		struct regmap_field *type;
    28		struct regmap_field *status;
    29	};
    30	
    31	static void msc313_pm_wakeup_intc_mask_irq(struct irq_data *data)
    32	{
    33		struct msc313_sleep_intc *intc = irq_data_get_irq_chip_data(data);
    34	
    35		regmap_field_update_bits(intc->mask, 1 << data->hwirq, ~0);
    36	}
    37	
    38	static void msc313_pm_wakeup_intc_unmask_irq(struct irq_data *data)
    39	{
    40		struct msc313_sleep_intc *intc = irq_data_get_irq_chip_data(data);
    41	
    42		regmap_field_update_bits(intc->mask, 1 << data->hwirq, 0);
    43	}
    44	
    45	static void msc313_pm_wakeup_intc_irq_eoi(struct irq_data *data)
    46	{
    47	}
    48	
    49	static int msc313_pm_wakeup_intc_set_type_irq(struct irq_data *data,
    50			unsigned int flow_type)
    51	{
    52		return 0;
    53	}
    54	
    55	static struct irq_chip msc313_pm_wakeup_intc_chip = {
    56		.name		= "PM-WAKEUP",
    57		.irq_mask	= msc313_pm_wakeup_intc_mask_irq,
    58		.irq_unmask	= msc313_pm_wakeup_intc_unmask_irq,
    59		.irq_eoi	= msc313_pm_wakeup_intc_irq_eoi,
    60		.irq_set_type	= msc313_pm_wakeup_intc_set_type_irq,
    61	};
    62	
    63	static irqreturn_t msc313_pm_wakeup_intc_chainedhandler(int irq, void *data)
    64	{
    65		struct irq_domain *domain = data;
    66		struct msc313_sleep_intc *intc = domain->host_data;
    67		unsigned int hwirq, status;
    68	
    69		regmap_field_read(intc->status, &status);
    70		printk("wakeupint %x\n", status);
    71	
    72		while (status) {
    73			hwirq = __ffs(status);
    74			generic_handle_domain_irq(domain, hwirq);
    75			status &= ~BIT(hwirq);
    76		}
    77	
    78		return IRQ_HANDLED;
    79	}
    80	
    81	static int msc313_pm_wakeup_intc_domain_map(struct irq_domain *domain,
    82			unsigned int irq, irq_hw_number_t hw)
    83	{
    84		struct msc313_sleep_intc *intc = domain->host_data;
    85	
    86		irq_set_chip_and_handler(irq, &msc313_pm_wakeup_intc_chip, handle_level_irq);
    87		irq_set_chip_data(irq, intc);
    88		irq_set_probe(irq);
    89	
    90		return 0;
    91	}
    92	
    93	static const struct irq_domain_ops msc313_pm_wakeup_intc_domain_ops = {
    94		.xlate = irq_domain_xlate_twocell,
    95		.map = msc313_pm_wakeup_intc_domain_map,
    96	};
    97	
    98	static int __init msc313_pm_wakeup_intc_of_init(struct device_node *node,
    99					   struct device_node *parent)
   100	{
   101		int ret = 0, irq;
   102		struct regmap *pmsleep;
   103		struct msc313_sleep_intc *intc;
   104		struct irq_domain *domain;
   105	
   106		irq = of_irq_get(node, 0);
   107		if (irq <= 0)
   108			return irq;
   109	
   110		pmsleep = syscon_regmap_lookup_by_phandle(node, "mstar,pmsleep");
   111		if (IS_ERR(pmsleep))
   112			return PTR_ERR(pmsleep);
   113	
   114		intc = kzalloc(sizeof(*intc), GFP_KERNEL);
   115		if (!intc)
   116			return -ENOMEM;
   117	
 > 118		intc->mask = regmap_field_alloc(pmsleep, field_mask);
   119		intc->type = regmap_field_alloc(pmsleep, field_type);
   120		intc->status = regmap_field_alloc(pmsleep, field_status);
   121	
   122		/* The masks survive deep sleep so clear them. */
   123		regmap_field_write(intc->mask, ~0);
   124	
   125		domain = irq_domain_add_linear(node, NUM_IRQ,
   126				&msc313_pm_wakeup_intc_domain_ops, intc);
   127		if (!domain) {
   128			ret = -ENOMEM;
   129			goto out_free;
   130		}
   131	
   132		request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
   133					"pmsleep", domain);
   134	
   135		return 0;
   136	
   137	out_free:
   138		kfree(intc);
   139		return ret;
   140	}
   141	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
