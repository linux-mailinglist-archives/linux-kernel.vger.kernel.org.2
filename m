Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96145FFFE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 16:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355419AbhK0P4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 10:56:20 -0500
Received: from mga12.intel.com ([192.55.52.136]:33987 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351049AbhK0PyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 10:54:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="215790667"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="215790667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 07:51:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="675815184"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Nov 2021 07:50:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqzyc-0009iV-QQ; Sat, 27 Nov 2021 15:50:58 +0000
Date:   Sat, 27 Nov 2021 23:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Wang <rocking@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/idle: support busy loop polling on idle SMT cpus
Message-ID: <202111272343.0rQFsj1v-lkp@intel.com>
References: <487180cde91b5de55f013c0294743908fd46e358.1637062971.git.rocking@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <487180cde91b5de55f013c0294743908fd46e358.1637062971.git.rocking@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master linux/master linus/master v5.16-rc2 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Peng-Wang/sched-idle-support-busy-loop-polling-on-idle-SMT-cpus/20211116-195600
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 8ea9183db4ad8afbcb7089a77c23eaf965b0cacd
config: sparc64-randconfig-r035-20211116 (https://download.01.org/0day-ci/archive/20211127/202111272343.0rQFsj1v-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/11c6a63e5c0f496b43058351f1e2a488ee27a5ec
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peng-Wang/sched-idle-support-busy-loop-polling-on-idle-SMT-cpus/20211116-195600
        git checkout 11c6a63e5c0f496b43058351f1e2a488ee27a5ec
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/list.h:9,
                    from include/linux/rculist.h:10,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel/sched/sched.h:5,
                    from kernel/sched/idle.c:9:
   kernel/sched/idle.c: In function 'smt_idle_poll_switch':
>> kernel/sched/idle.c:73:51: error: 'cpu_cgrp_id' undeclared (first use in this function); did you mean 'io_cgrp_id'?
      73 |         tg = container_of(task_css_check(current, cpu_cgrp_id, true),
         |                                                   ^~~~~~~~~~~
   include/linux/kernel.h:494:33: note: in definition of macro 'container_of'
     494 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   kernel/sched/idle.c:73:27: note: in expansion of macro 'task_css_check'
      73 |         tg = container_of(task_css_check(current, cpu_cgrp_id, true),
         |                           ^~~~~~~~~~~~~~
   kernel/sched/idle.c:73:51: note: each undeclared identifier is reported only once for each function it appears in
      73 |         tg = container_of(task_css_check(current, cpu_cgrp_id, true),
         |                                                   ^~~~~~~~~~~
   include/linux/kernel.h:494:33: note: in definition of macro 'container_of'
     494 |         void *__mptr = (void *)(ptr);                                   \
         |                                 ^~~
   kernel/sched/idle.c:73:27: note: in expansion of macro 'task_css_check'
      73 |         tg = container_of(task_css_check(current, cpu_cgrp_id, true),
         |                           ^~~~~~~~~~~~~~
   In file included from <command-line>:
   include/linux/kernel.h:495:58: error: invalid use of undefined type 'struct task_group'
     495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
         |                                                          ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:495:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
     495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
         |         ^~~~~~~~~~~~~~~~
   include/linux/kernel.h:495:27: note: in expansion of macro '__same_type'
     495 |         BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&   \
         |                           ^~~~~~~~~~~
   kernel/sched/idle.c:73:14: note: in expansion of macro 'container_of'
      73 |         tg = container_of(task_css_check(current, cpu_cgrp_id, true),
         |              ^~~~~~~~~~~~
>> include/linux/compiler_types.h:140:41: error: invalid use of undefined type 'struct task_group'
     140 | #define __compiler_offsetof(a, b)       __builtin_offsetof(a, b)
         |                                         ^~~~~~~~~~~~~~~~~~
   include/linux/stddef.h:17:33: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER)  __compiler_offsetof(TYPE, MEMBER)
         |                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:498:28: note: in expansion of macro 'offsetof'
     498 |         ((type *)(__mptr - offsetof(type, member))); })
         |                            ^~~~~~~~
   kernel/sched/idle.c:73:14: note: in expansion of macro 'container_of'
      73 |         tg = container_of(task_css_check(current, cpu_cgrp_id, true),
         |              ^~~~~~~~~~~~
>> kernel/sched/idle.c:75:36: error: invalid use of undefined type 'struct task_group'
      75 |         rq->need_smt_idle_poll = tg->need_smt_idle_poll;
         |                                    ^~


vim +73 kernel/sched/idle.c

    57	
    58	void smt_idle_poll_switch(struct rq *rq)
    59	{
    60		struct rq *smt_rq;
    61		struct task_group *tg;
    62		int smt, cpu;
    63	
    64		if (!static_branch_unlikely(&__smt_idle_poll_enabled))
    65			return;
    66	
    67		if (rq->idle == current) {
    68			rq->need_smt_idle_poll = false;
    69			return;
    70		}
    71	
    72		rcu_read_lock();
  > 73		tg = container_of(task_css_check(current, cpu_cgrp_id, true),
    74			struct task_group, css);
  > 75		rq->need_smt_idle_poll = tg->need_smt_idle_poll;
    76		rcu_read_unlock();
    77	
    78		if (!rq->need_smt_idle_poll)
    79			return;
    80	
    81		cpu = rq->cpu;
    82		for_each_cpu(smt, cpu_smt_mask(cpu)) {
    83			if (cpu == smt || !cpu_online(smt))
    84				continue;
    85			smt_rq = cpu_rq(smt);
    86			if (smt_rq->idle == smt_rq->curr && !smt_rq->in_smt_idle_poll)
    87				smp_send_reschedule(smt);
    88		}
    89	}
    90	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
