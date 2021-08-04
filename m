Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061C03E07C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238728AbhHDSlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 14:41:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:20333 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232690AbhHDSlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 14:41:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="275038588"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="gz'50?scan'50,208,50";a="275038588"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 11:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="gz'50?scan'50,208,50";a="522078140"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2021 11:40:54 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mBLoy-000F7i-HN; Wed, 04 Aug 2021 18:40:52 +0000
Date:   Thu, 5 Aug 2021 02:40:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [tglx-devel:rtmutex 3/65] include/linux/sched.h:211:3: error:
 implicit declaration of function 'debug_special_state_change'
Message-ID: <202108050222.PXHAVYhX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git rtmutex
head:   91fb95023a1645acf99daa67e51cc1f5e2bc8b8e
commit: c4c28f993851857356b76b7471f74cd154d58b84 [3/65] sched: Reorganize current::__state helpers
config: nios2-randconfig-r032-20210804 (attached as .config)
compiler: nios2-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=c4c28f993851857356b76b7471f74cd154d58b84
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel rtmutex
        git checkout c4c28f993851857356b76b7471f74cd154d58b84
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/nios2/kernel/asm-offsets.c:7:
   include/linux/sched.h:147:3: error: invalid preprocessing directive #debug_normal_state_change
     147 | # debug_normal_state_change(cond) do { } while (0)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched.h:148:3: error: invalid preprocessing directive #debug_special_state_change
     148 | # debug_special_state_change(cond) do { } while (0)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/nios2/kernel/asm-offsets.c:7:
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
>> include/linux/sched.h:211:3: error: implicit declaration of function 'debug_special_state_change' [-Werror=implicit-function-declaration]
     211 |   debug_special_state_change((state_value));  \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:296:3: note: in expansion of macro 'set_special_state'
     296 |   set_special_state(TASK_STOPPED);
         |   ^~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h: In function 'finish_rcuwait':
>> include/linux/sched.h:190:3: error: implicit declaration of function 'debug_normal_state_change' [-Werror=implicit-function-declaration]
     190 |   debug_normal_state_change((state_value));  \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h:53:2: note: in expansion of macro '__set_current_state'
      53 |  __set_current_state(TASK_RUNNING);
         |  ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/nios2/kernel/asm-offsets.c:7:
   include/linux/sched.h:147:3: error: invalid preprocessing directive #debug_normal_state_change
     147 | # debug_normal_state_change(cond) do { } while (0)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched.h:148:3: error: invalid preprocessing directive #debug_special_state_change
     148 | # debug_special_state_change(cond) do { } while (0)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/nios2/kernel/asm-offsets.c:7:
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
>> include/linux/sched.h:211:3: error: implicit declaration of function 'debug_special_state_change' [-Werror=implicit-function-declaration]
     211 |   debug_special_state_change((state_value));  \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/signal.h:296:3: note: in expansion of macro 'set_special_state'
     296 |   set_special_state(TASK_STOPPED);
         |   ^~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h: In function 'finish_rcuwait':
>> include/linux/sched.h:190:3: error: implicit declaration of function 'debug_normal_state_change' [-Werror=implicit-function-declaration]
     190 |   debug_normal_state_change((state_value));  \
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcuwait.h:53:2: note: in expansion of macro '__set_current_state'
      53 |  __set_current_state(TASK_RUNNING);
         |  ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/nios2/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1213: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:220: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/debug_special_state_change +211 include/linux/sched.h

   150	
   151	/*
   152	 * set_current_state() includes a barrier so that the write of current->state
   153	 * is correctly serialised wrt the caller's subsequent test of whether to
   154	 * actually sleep:
   155	 *
   156	 *   for (;;) {
   157	 *	set_current_state(TASK_UNINTERRUPTIBLE);
   158	 *	if (CONDITION)
   159	 *	   break;
   160	 *
   161	 *	schedule();
   162	 *   }
   163	 *   __set_current_state(TASK_RUNNING);
   164	 *
   165	 * If the caller does not need such serialisation (because, for instance, the
   166	 * CONDITION test and condition change and wakeup are under the same lock) then
   167	 * use __set_current_state().
   168	 *
   169	 * The above is typically ordered against the wakeup, which does:
   170	 *
   171	 *   CONDITION = 1;
   172	 *   wake_up_state(p, TASK_UNINTERRUPTIBLE);
   173	 *
   174	 * where wake_up_state()/try_to_wake_up() executes a full memory barrier before
   175	 * accessing p->state.
   176	 *
   177	 * Wakeup will do: if (@state & p->state) p->state = TASK_RUNNING, that is,
   178	 * once it observes the TASK_UNINTERRUPTIBLE store the waking CPU can issue a
   179	 * TASK_RUNNING store which can collide with __set_current_state(TASK_RUNNING).
   180	 *
   181	 * However, with slightly different timing the wakeup TASK_RUNNING store can
   182	 * also collide with the TASK_UNINTERRUPTIBLE store. Losing that store is not
   183	 * a problem either because that will result in one extra go around the loop
   184	 * and our @cond test will save the day.
   185	 *
   186	 * Also see the comments of try_to_wake_up().
   187	 */
   188	#define __set_current_state(state_value)				\
   189		do {								\
 > 190			debug_normal_state_change((state_value));		\
   191			WRITE_ONCE(current->__state, (state_value));		\
   192		} while (0)
   193	
   194	#define set_current_state(state_value)					\
   195		do {								\
   196			debug_normal_state_change((state_value));		\
   197			smp_store_mb(current->__state, (state_value));		\
   198		} while (0)
   199	
   200	/*
   201	 * set_special_state() should be used for those states when the blocking task
   202	 * can not use the regular condition based wait-loop. In that case we must
   203	 * serialize against wakeups such that any possible in-flight TASK_RUNNING
   204	 * stores will not collide with our state change.
   205	 */
   206	#define set_special_state(state_value)					\
   207		do {								\
   208			unsigned long flags; /* may shadow */			\
   209										\
   210			raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 > 211			debug_special_state_change((state_value));		\
   212			WRITE_ONCE(current->__state, (state_value));		\
   213			raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
   214		} while (0)
   215	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--RnlQjJ0d97Da+TV1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--RnlQjJ0d97Da+TV1--
