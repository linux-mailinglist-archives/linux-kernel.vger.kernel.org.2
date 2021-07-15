Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF963CAB63
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245612AbhGOTT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:19:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:8035 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242599AbhGOTFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:05:13 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="210659126"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="gz'50?scan'50,208,50";a="210659126"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 11:59:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="gz'50?scan'50,208,50";a="655965091"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2021 11:59:04 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m46Zc-000JvW-8o; Thu, 15 Jul 2021 18:59:04 +0000
Date:   Fri, 16 Jul 2021 02:58:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@suse.de>
Subject: [mel:sched-notarget-v1r15 7/8] kernel/sched/fair.c:7053:12: sparse:
 sparse: incorrect type in assignment (different address spaces)
Message-ID: <202107160205.oTD13Avo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git sched-notarget-v1r15
head:   a9ca7602387d3ed6aa80ccd5cc7e491709dbebae
commit: 20791824e212ce10d7abfa7a6bcdad80f05ab376 [7/8] sched/fair: select idle cpu from idle cpumask for task wakeup
config: ia64-randconfig-s031-20210715 (attached as .config)
compiler: ia64-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/commit/?id=20791824e212ce10d7abfa7a6bcdad80f05ab376
        git remote add mel https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git
        git fetch --no-tags mel sched-notarget-v1r15
        git checkout 20791824e212ce10d7abfa7a6bcdad80f05ab376
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:830:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:830:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:830:34: sparse:     got struct sched_entity [noderef] __rcu *
   kernel/sched/fair.c:10816:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10816:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10816:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:4961:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:4961:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:4961:22: sparse:    struct task_struct *
   kernel/sched/fair.c:6783:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6783:20: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:6783:20: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:6917:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] tmp @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:6917:9: sparse:     expected struct sched_domain *[assigned] tmp
   kernel/sched/fair.c:6917:9: sparse:     got struct sched_domain [noderef] __rcu *parent
>> kernel/sched/fair.c:7053:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *sd @@     got struct sched_domain [noderef] __rcu * @@
   kernel/sched/fair.c:7053:12: sparse:     expected struct sched_domain *sd
   kernel/sched/fair.c:7053:12: sparse:     got struct sched_domain [noderef] __rcu *
   kernel/sched/fair.c:7150:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7150:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7150:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7434:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7434:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7434:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:8419:40: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *child @@     got struct sched_domain [noderef] __rcu *child @@
   kernel/sched/fair.c:8419:40: sparse:     expected struct sched_domain *child
   kernel/sched/fair.c:8419:40: sparse:     got struct sched_domain [noderef] __rcu *child
   kernel/sched/fair.c:8867:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/fair.c:8867:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/fair.c:8867:22: sparse:    struct task_struct *
   kernel/sched/fair.c:10130:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10130:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10130:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:9790:44: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct sched_domain *sd_parent @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:9790:44: sparse:     expected struct sched_domain *sd_parent
   kernel/sched/fair.c:9790:44: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:10202:9: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct sched_domain *[assigned] sd @@     got struct sched_domain [noderef] __rcu *parent @@
   kernel/sched/fair.c:10202:9: sparse:     expected struct sched_domain *[assigned] sd
   kernel/sched/fair.c:10202:9: sparse:     got struct sched_domain [noderef] __rcu *parent
   kernel/sched/fair.c:4626:31: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2185:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2185:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2185:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2027:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2027:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2027:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2027:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2027:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2027:25: sparse:    struct task_struct *

vim +7053 kernel/sched/fair.c

  7026	
  7027	/*
  7028	 * Update cpu idle state and record this information
  7029	 * in sd_llc_shared->idle_cpus_span.
  7030	 *
  7031	 * This function is called with interrupts disabled.
  7032	 */
  7033	void update_idle_cpumask(int cpu, bool idle)
  7034	{
  7035		struct sched_domain *sd;
  7036		struct rq *rq = cpu_rq(cpu);
  7037		int idle_state;
  7038	
  7039		/*
  7040		 * Also set SCHED_IDLE cpu in idle cpumask to
  7041		 * allow SCHED_IDLE cpu as a wakeup target.
  7042		 */
  7043		idle_state = idle || sched_idle_cpu(cpu);
  7044		/*
  7045		 * No need to update idle cpumask if the state
  7046		 * does not change.
  7047		 */
  7048		if (rq->last_idle_state == idle_state)
  7049			return;
  7050		/*
  7051		 * Called with irq disabled, rcu protection is not needed.
  7052		 */
> 7053		sd = per_cpu(sd_llc, cpu);
  7054		if (unlikely(!sd))
  7055			return;
  7056	
  7057		if (idle_state)
  7058			cpumask_set_cpu(cpu, sds_idle_cpus(sd->shared));
  7059		else
  7060			cpumask_clear_cpu(cpu, sds_idle_cpus(sd->shared));
  7061	
  7062		rq->last_idle_state = idle_state;
  7063	}
  7064	#endif /* CONFIG_SMP */
  7065	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--
