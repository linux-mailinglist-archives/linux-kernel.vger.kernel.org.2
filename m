Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0B460AEB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 23:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347913AbhK1W7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 17:59:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:41105 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234914AbhK1W47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 17:56:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="234592183"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="234592183"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 14:53:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="458900534"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2021 14:53:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrT3E-000BDp-Ry; Sun, 28 Nov 2021 22:53:40 +0000
Date:   Mon, 29 Nov 2021 06:52:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 20/27] arch/arm/common/bL_switcher.c:211:58:
 error: passing argument 2 of 'cpu_suspend' from incompatible pointer type
Message-ID: <202111290656.AUyxGhf2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   4dc44f9fca72ac68efe2713290fadc972ead1141
commit: b3d05657e7030270a97b7b13447abe74f7fb9b4a [20/27] ARM: bL_switcher: drop unnecessary stack handling magic
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20211129/202111290656.AUyxGhf2-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=b3d05657e7030270a97b7b13447abe74f7fb9b4a
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout b3d05657e7030270a97b7b13447abe74f7fb9b4a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/common/bL_switcher.c: In function 'bL_switch_to':
>> arch/arm/common/bL_switcher.c:211:58: error: passing argument 2 of 'cpu_suspend' from incompatible pointer type [-Werror=incompatible-pointer-types]
     211 |         ret = cpu_suspend((unsigned long)&handshake_ptr, bL_do_switch);
         |                                                          ^~~~~~~~~~~~
         |                                                          |
         |                                                          void (*)(void *)
   In file included from arch/arm/common/bL_switcher.c:37:
   arch/arm/include/asm/suspend.h:15:39: note: expected 'int (*)(long unsigned int)' but argument is of type 'void (*)(void *)'
      15 | extern int cpu_suspend(unsigned long, int (*)(unsigned long));
         |                                       ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/cpu_suspend +211 arch/arm/common/bL_switcher.c

   119	
   120	/*
   121	 * bL_switch_to - Switch to a specific cluster for the current CPU
   122	 * @new_cluster_id: the ID of the cluster to switch to.
   123	 *
   124	 * This function must be called on the CPU to be switched.
   125	 * Returns 0 on success, else a negative status code.
   126	 */
   127	static int bL_switch_to(unsigned int new_cluster_id)
   128	{
   129		unsigned int mpidr, this_cpu, that_cpu;
   130		unsigned int ob_mpidr, ob_cpu, ob_cluster, ib_mpidr, ib_cpu, ib_cluster;
   131		struct completion inbound_alive;
   132		long volatile *handshake_ptr;
   133		int ipi_nr, ret;
   134	
   135		this_cpu = smp_processor_id();
   136		ob_mpidr = read_mpidr();
   137		ob_cpu = MPIDR_AFFINITY_LEVEL(ob_mpidr, 0);
   138		ob_cluster = MPIDR_AFFINITY_LEVEL(ob_mpidr, 1);
   139		BUG_ON(cpu_logical_map(this_cpu) != ob_mpidr);
   140	
   141		if (new_cluster_id == ob_cluster)
   142			return 0;
   143	
   144		that_cpu = bL_switcher_cpu_pairing[this_cpu];
   145		ib_mpidr = cpu_logical_map(that_cpu);
   146		ib_cpu = MPIDR_AFFINITY_LEVEL(ib_mpidr, 0);
   147		ib_cluster = MPIDR_AFFINITY_LEVEL(ib_mpidr, 1);
   148	
   149		pr_debug("before switch: CPU %d MPIDR %#x -> %#x\n",
   150			 this_cpu, ob_mpidr, ib_mpidr);
   151	
   152		this_cpu = smp_processor_id();
   153	
   154		/* Close the gate for our entry vectors */
   155		mcpm_set_entry_vector(ob_cpu, ob_cluster, NULL);
   156		mcpm_set_entry_vector(ib_cpu, ib_cluster, NULL);
   157	
   158		/* Install our "inbound alive" notifier. */
   159		init_completion(&inbound_alive);
   160		ipi_nr = register_ipi_completion(&inbound_alive, this_cpu);
   161		ipi_nr |= ((1 << 16) << bL_gic_id[ob_cpu][ob_cluster]);
   162		mcpm_set_early_poke(ib_cpu, ib_cluster, gic_get_sgir_physaddr(), ipi_nr);
   163	
   164		/*
   165		 * Let's wake up the inbound CPU now in case it requires some delay
   166		 * to come online, but leave it gated in our entry vector code.
   167		 */
   168		ret = mcpm_cpu_power_up(ib_cpu, ib_cluster);
   169		if (ret) {
   170			pr_err("%s: mcpm_cpu_power_up() returned %d\n", __func__, ret);
   171			return ret;
   172		}
   173	
   174		/*
   175		 * Raise a SGI on the inbound CPU to make sure it doesn't stall
   176		 * in a possible WFI, such as in bL_power_down().
   177		 */
   178		gic_send_sgi(bL_gic_id[ib_cpu][ib_cluster], 0);
   179	
   180		/*
   181		 * Wait for the inbound to come up.  This allows for other
   182		 * tasks to be scheduled in the mean time.
   183		 */
   184		wait_for_completion(&inbound_alive);
   185		mcpm_set_early_poke(ib_cpu, ib_cluster, 0, 0);
   186	
   187		/*
   188		 * From this point we are entering the switch critical zone
   189		 * and can't take any interrupts anymore.
   190		 */
   191		local_irq_disable();
   192		local_fiq_disable();
   193		trace_cpu_migrate_begin(ktime_get_real_ns(), ob_mpidr);
   194	
   195		/* redirect GIC's SGIs to our counterpart */
   196		gic_migrate_target(bL_gic_id[ib_cpu][ib_cluster]);
   197	
   198		tick_suspend_local();
   199	
   200		ret = cpu_pm_enter();
   201	
   202		/* we can not tolerate errors at this point */
   203		if (ret)
   204			panic("%s: cpu_pm_enter() returned %d\n", __func__, ret);
   205	
   206		/* Swap the physical CPUs in the logical map for this logical CPU. */
   207		cpu_logical_map(this_cpu) = ib_mpidr;
   208		cpu_logical_map(that_cpu) = ob_mpidr;
   209	
   210		/* Let's do the actual CPU switch. */
 > 211		ret = cpu_suspend((unsigned long)&handshake_ptr, bL_do_switch);
   212		if (ret > 0)
   213			panic("%s: cpu_suspend() returned %d\n", __func__, ret);
   214	
   215		/* We are executing on the inbound CPU at this point */
   216		mpidr = read_mpidr();
   217		pr_debug("after switch: CPU %d MPIDR %#x\n", this_cpu, mpidr);
   218		BUG_ON(mpidr != ib_mpidr);
   219	
   220		mcpm_cpu_powered_up();
   221	
   222		ret = cpu_pm_exit();
   223	
   224		tick_resume_local();
   225	
   226		trace_cpu_migrate_finish(ktime_get_real_ns(), ib_mpidr);
   227		local_fiq_enable();
   228		local_irq_enable();
   229	
   230		*handshake_ptr = 1;
   231		dsb_sev();
   232	
   233		if (ret)
   234			pr_err("%s exiting with error %d\n", __func__, ret);
   235		return ret;
   236	}
   237	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
