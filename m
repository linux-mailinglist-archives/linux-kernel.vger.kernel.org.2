Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F753A5AB0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 23:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbhFMVuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 17:50:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:16677 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232020AbhFMVuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 17:50:07 -0400
IronPort-SDR: PVc2GMCsxHWqO7b6QSxgnm62/M/SxS1sMOueQ09nRnHNGOUpzLytj88mZkysCSB2Of1cbKqVwB
 YkmvPOR2zNpw==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="266888894"
X-IronPort-AV: E=Sophos;i="5.83,272,1616482800"; 
   d="gz'50?scan'50,208,50";a="266888894"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 14:48:04 -0700
IronPort-SDR: R2ouuXAENz1cWhXGqTQeFxsr9PiOHUfkaIDi4FByqgaTv4wIH+7SVtOwnglf7wzxDm7cvpaVwO
 ss9ExTszvtSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,272,1616482800"; 
   d="gz'50?scan'50,208,50";a="553930872"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2021 14:48:02 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsXxb-0001Wi-Ar; Sun, 13 Jun 2021 21:48:03 +0000
Date:   Mon, 14 Jun 2021 05:47:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 351/364] include/linux/seqlock.h:239:76: error:
 implicit declaration of function 'mutex_unlock'; did you mean
Message-ID: <202106140542.rljPsQVi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: 6c13131b6a385211160e6bd8a211e5ed72e780a8 [351/364] sched/headers, locking/seqlocks: Optimize <linux/seqlock.h>
config: sparc64-randconfig-r015-20210613 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=6c13131b6a385211160e6bd8a211e5ed72e780a8
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout 6c13131b6a385211160e6bd8a211e5ed72e780a8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/sparc/kernel/asm-offsets.c:14:
   include/linux/sched.h:475:20: error: array type has incomplete element type 'struct held_lock'
     475 |  struct held_lock  held_locks[MAX_LOCK_DEPTH];
         |                    ^~~~~~~~~~
   In file included from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:53,
                    from include/linux/mm_types.h:9,
                    from arch/sparc/kernel/asm-offsets.c:15:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_types.h:17,
                    from arch/sparc/kernel/asm-offsets.c:15:
   include/linux/seqlock.h: In function '__seqprop_mutex_sequence':
   include/linux/seqlock.h:239:86: error: implicit declaration of function 'mutex_lock' [-Werror=implicit-function-declaration]
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                                      ^~~~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:239:76: error: implicit declaration of function 'mutex_unlock'; did you mean 'write_unlock'? [-Werror=implicit-function-declaration]
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                            ^~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_mutex_assert':
   include/linux/lockdep.h:286:52: error: dereferencing pointer to incomplete type 'struct mutex'
     286 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
         |                                                    ^~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/lockdep.h:310:3: note: in expansion of macro 'WARN_ON'
     310 |   WARN_ON(debug_locks &&     \
         |   ^~~~~~~
   include/linux/lockdep.h:311:4: note: in expansion of macro 'lockdep_is_held'
     311 |    lockdep_is_held(l) == LOCK_STATE_NOT_HELD); \
         |    ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:231:13: note: in expansion of macro 'lockdep_assert_held'
     231 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_sequence':
>> include/linux/seqlock.h:240:86: error: implicit declaration of function 'ww_mutex_lock'; did you mean 'write_lock'? [-Werror=implicit-function-declaration]
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         |                                                                                      ^~~~~~~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:240:76: error: implicit declaration of function 'ww_mutex_unlock'; did you mean 'write_unlock'? [-Werror=implicit-function-declaration]
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         |                                                                            ^~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_assert':
   include/linux/seqlock.h:240:68: error: dereferencing pointer to incomplete type 'struct ww_mutex'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         |                                                                    ^~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/lockdep.h:310:3: note: in expansion of macro 'WARN_ON'
     310 |   WARN_ON(debug_locks &&     \
         |   ^~~~~~~
   include/linux/lockdep.h:311:4: note: in expansion of macro 'lockdep_is_held'
     311 |    lockdep_is_held(l) == LOCK_STATE_NOT_HELD); \
         |    ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:231:13: note: in expansion of macro 'lockdep_assert_held'
     231 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c: At top level:
   arch/sparc/kernel/asm-offsets.c:29:5: warning: no previous prototype for 'sparc64_foo' [-Wmissing-prototypes]
      29 | int sparc64_foo(void)
         |     ^~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:48:5: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      48 | int foo(void)
         |     ^~~
   In file included from arch/sparc/kernel/asm-offsets.c:17:
   arch/sparc/kernel/asm-offsets.c: In function 'foo':
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:51:27: note: in expansion of macro 'offsetof'
      51 |  DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
         |                           ^~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/sparc/kernel/asm-offsets.c:14:
   include/linux/sched.h:475:20: error: array type has incomplete element type 'struct held_lock'
     475 |  struct held_lock  held_locks[MAX_LOCK_DEPTH];
         |                    ^~~~~~~~~~
   In file included from ./arch/sparc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:53,
                    from include/linux/mm_types.h:9,
                    from arch/sparc/kernel/asm-offsets.c:15:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_types.h:17,
                    from arch/sparc/kernel/asm-offsets.c:15:
   include/linux/seqlock.h: In function '__seqprop_mutex_sequence':
   include/linux/seqlock.h:239:86: error: implicit declaration of function 'mutex_lock' [-Werror=implicit-function-declaration]
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                                      ^~~~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:239:76: error: implicit declaration of function 'mutex_unlock'; did you mean 'write_unlock'? [-Werror=implicit-function-declaration]
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         |                                                                            ^~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_mutex_assert':
   include/linux/lockdep.h:286:52: error: dereferencing pointer to incomplete type 'struct mutex'
     286 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
         |                                                    ^~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/lockdep.h:310:3: note: in expansion of macro 'WARN_ON'
     310 |   WARN_ON(debug_locks &&     \
         |   ^~~~~~~
   include/linux/lockdep.h:311:4: note: in expansion of macro 'lockdep_is_held'
     311 |    lockdep_is_held(l) == LOCK_STATE_NOT_HELD); \
         |    ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:231:13: note: in expansion of macro 'lockdep_assert_held'
     231 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     239 | SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_sequence':
>> include/linux/seqlock.h:240:86: error: implicit declaration of function 'ww_mutex_lock'; did you mean 'write_lock'? [-Werror=implicit-function-declaration]
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         |                                                                                      ^~~~~~~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:240:76: error: implicit declaration of function 'ww_mutex_unlock'; did you mean 'write_unlock'? [-Werror=implicit-function-declaration]
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         |                                                                            ^~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_assert':
   include/linux/seqlock.h:240:68: error: dereferencing pointer to incomplete type 'struct ww_mutex'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         |                                                                    ^~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
     136 | #define __SEQ_LOCK(expr) expr
         |                          ^~~~
   include/linux/lockdep.h:310:3: note: in expansion of macro 'WARN_ON'
     310 |   WARN_ON(debug_locks &&     \
         |   ^~~~~~~
   include/linux/lockdep.h:311:4: note: in expansion of macro 'lockdep_is_held'
     311 |    lockdep_is_held(l) == LOCK_STATE_NOT_HELD); \
         |    ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:231:13: note: in expansion of macro 'lockdep_assert_held'
     231 |  __SEQ_LOCK(lockdep_assert_held(lockmember));   \
         |             ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
     240 | SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
         | ^~~~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c: At top level:
   arch/sparc/kernel/asm-offsets.c:29:5: warning: no previous prototype for 'sparc64_foo' [-Wmissing-prototypes]
      29 | int sparc64_foo(void)
         |     ^~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:48:5: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      48 | int foo(void)
         |     ^~~
   In file included from arch/sparc/kernel/asm-offsets.c:17:
   arch/sparc/kernel/asm-offsets.c: In function 'foo':
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:51:27: note: in expansion of macro 'offsetof'
      51 |  DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
         |                           ^~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/sparc/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by
   - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   In file included from arch/sparc/kernel/asm-offsets.c:14:
   include/linux/sched.h:475:20: error: array type has incomplete element type 'struct held_lock'
   475 | struct held_lock
   | ^~~~~~~~~~
   In file included from ./arch/sparc/include/generated/asm/preempt.h:1,
   from include/linux/preempt.h:80,
   from include/linux/spinlock.h:53,
   from include/linux/mm_types.h:9,
   from arch/sparc/kernel/asm-offsets.c:15:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched'
   69 | return && tif_need_resched();
   | ^~~~~~~~~~~~~~~~
   In file included from include/linux/mm_types.h:17,
   from arch/sparc/kernel/asm-offsets.c:15:
   include/linux/seqlock.h: In function '__seqprop_mutex_sequence':
   include/linux/seqlock.h:239:86: error: implicit declaration of function 'mutex_lock'
   239 | SEQCOUNT_LOCKNAME(mutex, struct mutex, true, s->lock, mutex, mutex_lock(s->lock))
   | ^~~~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
   136 | #define __SEQ_LOCK(expr) expr
   | ^~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
   239 | SEQCOUNT_LOCKNAME(mutex, struct mutex, true, s->lock, mutex, mutex_lock(s->lock))
   | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:239:76: error: implicit declaration of function 'mutex_unlock'; did you mean
   239 | SEQCOUNT_LOCKNAME(mutex, struct mutex, true, s->lock, mutex, mutex_lock(s->lock))
   | ^~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
   136 | #define __SEQ_LOCK(expr) expr
   | ^~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
   239 | SEQCOUNT_LOCKNAME(mutex, struct mutex, true, s->lock, mutex, mutex_lock(s->lock))
   | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_mutex_assert':
   include/linux/lockdep.h:286:52: error: dereferencing pointer to incomplete type 'struct mutex'
   286 | #define lockdep_is_held(lock) lock_is_held(&(lock)->dep_map)
   | ^~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
   136 | #define __SEQ_LOCK(expr) expr
   | ^~~~
   include/linux/lockdep.h:310:3: note: in expansion of macro 'WARN_ON'
   310 | WARN_ON(debug_locks && | ^~~~~~~
   include/linux/lockdep.h:311:4: note: in expansion of macro 'lockdep_is_held'
   311 | lockdep_is_held(l) == LOCK_STATE_NOT_HELD); | ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:231:13: note: in expansion of macro 'lockdep_assert_held'
   231 | __SEQ_LOCK(lockdep_assert_held(lockmember)); | ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:239:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
   239 | SEQCOUNT_LOCKNAME(mutex, struct mutex, true, s->lock, mutex, mutex_lock(s->lock))
   | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_sequence':
>> include/linux/seqlock.h:240:86: error: implicit declaration of function 'ww_mutex_lock'; did you mean
   240 | SEQCOUNT_LOCKNAME(ww_mutex, struct ww_mutex, true, &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   | ^~~~~~~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
   136 | #define __SEQ_LOCK(expr) expr
   | ^~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
   240 | SEQCOUNT_LOCKNAME(ww_mutex, struct ww_mutex, true, &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   | ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:240:76: error: implicit declaration of function 'ww_mutex_unlock'; did you mean
   240 | SEQCOUNT_LOCKNAME(ww_mutex, struct ww_mutex, true, &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   | ^~~~~~~~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
   136 | #define __SEQ_LOCK(expr) expr
   | ^~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
   240 | SEQCOUNT_LOCKNAME(ww_mutex, struct ww_mutex, true, &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   | ^~~~~~~~~~~~~~~~~
   include/linux/seqlock.h: In function '__seqprop_ww_mutex_assert':
   include/linux/seqlock.h:240:68: error: dereferencing pointer to incomplete type 'struct ww_mutex'
   240 | SEQCOUNT_LOCKNAME(ww_mutex, struct ww_mutex, true, &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   | ^~
   include/linux/seqlock.h:136:26: note: in definition of macro '__SEQ_LOCK'
   136 | #define __SEQ_LOCK(expr) expr
   | ^~~~
   include/linux/lockdep.h:310:3: note: in expansion of macro 'WARN_ON'
   310 | WARN_ON(debug_locks && | ^~~~~~~
   include/linux/lockdep.h:311:4: note: in expansion of macro 'lockdep_is_held'
   311 | lockdep_is_held(l) == LOCK_STATE_NOT_HELD); | ^~~~~~~~~~~~~~~
   include/linux/seqlock.h:231:13: note: in expansion of macro 'lockdep_assert_held'
   231 | __SEQ_LOCK(lockdep_assert_held(lockmember)); | ^~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:240:1: note: in expansion of macro 'SEQCOUNT_LOCKNAME'
   240 | SEQCOUNT_LOCKNAME(ww_mutex, struct ww_mutex, true, &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
   | ^~~~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c: At top level:
   arch/sparc/kernel/asm-offsets.c:29:5: warning: no previous prototype for 'sparc64_foo'
   29 | int sparc64_foo(void)
   | ^~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:48:5: warning: no previous prototype for 'foo'
   48 | int foo(void)
   | ^~~
   In file included from arch/sparc/kernel/asm-offsets.c:17:
   arch/sparc/kernel/asm-offsets.c: In function 'foo':
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
   140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
   | ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
   6 | asm volatile("n.ascii "->" #sym " %0 " #val """ : : "i" (val))
   | ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
   17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
   | ^~~~~~~~~~~~~~~~~~~
   arch/sparc/kernel/asm-offsets.c:51:27: note: in expansion of macro 'offsetof'
   51 | DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
   | ^~~~~~~~
   cc1: some warnings being treated as errors
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt [scripts/Makefile.build:117: arch/sparc/kernel/asm-offsets.s] Error 1
   Target '__build' not remade because of errors.
   Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt [Makefile:1232: prepare0] Error 2
   Target 'prepare' not remade because of errors.
   make: Makefile arch block certs crypto drivers fs include init ipc kernel lib mm net scripts security sound source usr virt [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by
   - LOCK_STAT && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT


vim +/mutex_unlock +239 include/linux/seqlock.h

267580db047ef42 peterz@infradead.org 2020-09-15  172  
55f3560df975f55 Ahmed S. Darwish     2020-07-20  173  /*
6dd699b13d53f26 Ahmed S. Darwish     2020-09-04  174   * SEQCOUNT_LOCKNAME()	- Instantiate seqcount_LOCKNAME_t and helpers
5cdd25572a29e46 Ahmed S. Darwish     2020-09-04  175   * seqprop_LOCKNAME_*()	- Property accessors for seqcount_LOCKNAME_t
5cdd25572a29e46 Ahmed S. Darwish     2020-09-04  176   *
6dd699b13d53f26 Ahmed S. Darwish     2020-09-04  177   * @lockname:		"LOCKNAME" part of seqcount_LOCKNAME_t
6dd699b13d53f26 Ahmed S. Darwish     2020-09-04  178   * @locktype:		LOCKNAME canonical C data type
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  179   * @preemptible:	preemptibility of above locktype
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  180   * @lockmember:		argument for lockdep_assert_held()
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  181   * @lockbase:		associated lock release function (prefix only)
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  182   * @lock_acquire:	associated lock acquisition function (full call)
55f3560df975f55 Ahmed S. Darwish     2020-07-20  183   */
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  184  #define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockmember, lockbase, lock_acquire) \
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  185  typedef struct seqcount_##lockname {					\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  186  	seqcount_t		seqcount;				\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  187  	__SEQ_LOCK(locktype	*lock);					\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  188  } seqcount_##lockname##_t;						\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  189  									\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  190  static __always_inline seqcount_t *					\
5cdd25572a29e46 Ahmed S. Darwish     2020-09-04  191  __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  192  {									\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  193  	return &s->seqcount;						\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  194  }									\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  195  									\
52ac39e5db5148f Ahmed S. Darwish     2020-09-04  196  static __always_inline unsigned						\
52ac39e5db5148f Ahmed S. Darwish     2020-09-04  197  __seqprop_##lockname##_sequence(const seqcount_##lockname##_t *s)	\
52ac39e5db5148f Ahmed S. Darwish     2020-09-04  198  {									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  199  	unsigned seq = READ_ONCE(s->seqcount.sequence);			\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  200  									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  201  	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  202  		return seq;						\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  203  									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  204  	if (preemptible && unlikely(seq & 1)) {				\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  205  		__SEQ_LOCK(lock_acquire);				\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  206  		__SEQ_LOCK(lockbase##_unlock(s->lock));			\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  207  									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  208  		/*							\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  209  		 * Re-read the sequence counter since the (possibly	\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  210  		 * preempted) writer made progress.			\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  211  		 */							\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  212  		seq = READ_ONCE(s->seqcount.sequence);			\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  213  	}								\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  214  									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  215  	return seq;							\
52ac39e5db5148f Ahmed S. Darwish     2020-09-04  216  }									\
52ac39e5db5148f Ahmed S. Darwish     2020-09-04  217  									\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  218  static __always_inline bool						\
5cdd25572a29e46 Ahmed S. Darwish     2020-09-04  219  __seqprop_##lockname##_preemptible(const seqcount_##lockname##_t *s)	\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  220  {									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  221  	if (!IS_ENABLED(CONFIG_PREEMPT_RT))				\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  222  		return preemptible;					\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  223  									\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  224  	/* PREEMPT_RT relies on the above LOCK+UNLOCK */		\
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  225  	return false;							\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  226  }									\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  227  									\
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  228  static __always_inline void						\
5cdd25572a29e46 Ahmed S. Darwish     2020-09-04  229  __seqprop_##lockname##_assert(const seqcount_##lockname##_t *s)		\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  230  {									\
e55687fe5c1e484 Peter Zijlstra       2020-07-23 @231  	__SEQ_LOCK(lockdep_assert_held(lockmember));			\
55f3560df975f55 Ahmed S. Darwish     2020-07-20  232  }
55f3560df975f55 Ahmed S. Darwish     2020-07-20  233  
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  234  #define __SEQ_RT	IS_ENABLED(CONFIG_PREEMPT_RT)
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  235  
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  236  SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    s->lock,        raw_spin, raw_spin_lock(s->lock))
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  237  SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, s->lock,        spin,     spin_lock(s->lock))
8117ab508f9c476 Ahmed S. Darwish     2020-09-04  238  SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, s->lock,        read,     read_lock(s->lock))
8117ab508f9c476 Ahmed S. Darwish     2020-09-04 @239  SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     s->lock,        mutex,    mutex_lock(s->lock))
8117ab508f9c476 Ahmed S. Darwish     2020-09-04 @240  SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mutex, ww_mutex_lock(s->lock, NULL))
a8772dccb2ec7b1 Peter Zijlstra       2020-07-23  241  

:::::: The code at line 239 was first introduced by commit
:::::: 8117ab508f9c476e0a10b9db7f4818f784cf3176 seqlock: seqcount_LOCKNAME_t: Introduce PREEMPT_RT support

:::::: TO: Ahmed S. Darwish <a.darwish@linutronix.de>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--17pEHd4RhPHOinZp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--17pEHd4RhPHOinZp--
