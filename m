Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF4B39CF7B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 16:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFFOWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 10:22:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:14430 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230011AbhFFOWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 10:22:08 -0400
IronPort-SDR: jCMSKTgcmhVf6kogJCiUfbTRNSZl93ulM3AwzjuuKXBTHYqIOvVM5fqUvoU2WUqQ11Pv/pgby1
 BVL2KMbKemSA==
X-IronPort-AV: E=McAfee;i="6200,9189,10007"; a="204324486"
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="gz'50?scan'50,208,50";a="204324486"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2021 07:20:18 -0700
IronPort-SDR: 9YjrH4Z12d21G/hmpG2HtaEYQ6rvCorfmiXYZMY6HDwl6v4S7owcg2dUK4uJoPleId/fpZ6cv9
 aMrBkaXkh0Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,253,1616482800"; 
   d="gz'50?scan'50,208,50";a="401446988"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 06 Jun 2021 07:20:16 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lptdQ-0007xE-0l; Sun, 06 Jun 2021 14:20:16 +0000
Date:   Sun, 6 Jun 2021 22:19:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     irqchip-bot for Marc Zyngier <tip-bot2@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
Subject: Re: [irqchip: irq/irqchip-next] genirq: Use irq_resolve_mapping() to
 implement __handle_domain_irq() and co
Message-ID: <202106062255.MSPpLhpo-lkp@intel.com>
References: <162298342683.29796.7142738277768084602.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <162298342683.29796.7142738277768084602.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi irqchip-bot,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on tip/irq/core linus/master v5.13-rc4 next-20210604]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/irqchip-bot-for-Marc-Zyngier/genirq-Use-irq_resolve_mapping-to-implement-__handle_domain_irq-and-co/20210606-204819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git dd860052c99b1e088352bdd4fb7aef46f8d2ef47
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e684b127b014b361df0088dca184273cdd73d79e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review irqchip-bot-for-Marc-Zyngier/genirq-Use-irq_resolve_mapping-to-implement-__handle_domain_irq-and-co/20210606-204819
        git checkout e684b127b014b361df0088dca184273cdd73d79e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/irq/irqdesc.c: In function '__handle_domain_irq':
   kernel/irq/irqdesc.c:683:10: error: implicit declaration of function 'irq_resolve_mapping'; did you mean 'irq_create_mapping'? [-Werror=implicit-function-declaration]
     683 |   desc = irq_resolve_mapping(domain, hwirq);
         |          ^~~~~~~~~~~~~~~~~~~
         |          irq_create_mapping
>> kernel/irq/irqdesc.c:683:8: warning: assignment to 'struct irq_desc *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     683 |   desc = irq_resolve_mapping(domain, hwirq);
         |        ^
   kernel/irq/irqdesc.c: In function 'handle_domain_nmi':
   kernel/irq/irqdesc.c:730:7: warning: assignment to 'struct irq_desc *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     730 |  desc = irq_resolve_mapping(domain, hwirq);
         |       ^
   cc1: some warnings being treated as errors


vim +683 kernel/irq/irqdesc.c

   661	
   662	#ifdef CONFIG_HANDLE_DOMAIN_IRQ
   663	/**
   664	 * __handle_domain_irq - Invoke the handler for a HW irq belonging to a domain
   665	 * @domain:	The domain where to perform the lookup
   666	 * @hwirq:	The HW irq number to convert to a logical one
   667	 * @lookup:	Whether to perform the domain lookup or not
   668	 * @regs:	Register file coming from the low-level handling code
   669	 *
   670	 * Returns:	0 on success, or -EINVAL if conversion has failed
   671	 */
   672	int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
   673				bool lookup, struct pt_regs *regs)
   674	{
   675		struct pt_regs *old_regs = set_irq_regs(regs);
   676		struct irq_desc *desc;
   677		int ret = 0;
   678	
   679		irq_enter();
   680	
   681		if (likely(IS_ENABLED(CONFIG_IRQ_DOMAIN) && lookup)) {
   682			/* The irqdomain code provides boundary checks */
 > 683			desc = irq_resolve_mapping(domain, hwirq);
   684		} else {
   685			/*
   686			 * Some hardware gives randomly wrong interrupts.  Rather
   687			 * than crashing, do something sensible.
   688			 */
   689			if (unlikely(!hwirq || hwirq >= nr_irqs)) {
   690				ack_bad_irq(hwirq);
   691				desc = NULL;
   692			} else {
   693				desc = irq_to_desc(hwirq);
   694			}
   695		}
   696	
   697		if (likely(desc))
   698			handle_irq_desc(desc);
   699		else
   700			ret = -EINVAL;
   701	
   702		irq_exit();
   703		set_irq_regs(old_regs);
   704		return ret;
   705	}
   706	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
qCQ4HWE425F2tmOUHoqW9xSdF/8HrAYdgM9/AAA=

--rwEMma7ioTxnRzrJ--
