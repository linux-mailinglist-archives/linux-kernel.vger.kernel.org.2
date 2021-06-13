Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 230C53A5A65
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhFMUnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:43:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:40041 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhFMUnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:43:22 -0400
IronPort-SDR: ghNAtPkfRfhwj0nlO+lv6tgSjd7XDumdy7BFIxOs+z5v528nakFLTFTegS7Q2cHMDg9diZleKa
 mZajmYQNlHtA==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="205556456"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="205556456"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 13:41:18 -0700
IronPort-SDR: hlMRSI5suBi0ZFmt6axnfn/OyFvpxsffYk//NeloiQmr+HkLN2/Na3wyoKjXjAiz9rh0JNrgYT
 1VgM0uKVxEQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="449690507"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2021 13:41:16 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsWuz-0001V4-6i; Sun, 13 Jun 2021 20:41:17 +0000
Date:   Mon, 14 Jun 2021 04:40:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 176/364] arch/arm/include/asm/ucontext.h:25:32: error:
 'sigset_t' undeclared here (not in a function); did you mean 'size_t'?
Message-ID: <202106140420.xc4h3qoq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: be65473fb5b77d57d8955beffd5aa370cfdae467 [176/364] sched/headers, rcu: Remove <linux/sched/signal.h> dependency from <linux/rcuwait.h>
config: arm-spear13xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=be65473fb5b77d57d8955beffd5aa370cfdae467
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout be65473fb5b77d57d8955beffd5aa370cfdae467
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:279:13: note: in definition of macro '__unqual_scalar_typeof'
     279 |   _Generic((x),      \
         |             ^
   include/asm-generic/rwonce.h:50:2: note: in expansion of macro '__READ_ONCE'
      50 |  __READ_ONCE(x);       \
         |  ^~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from arch/arm/kernel/asm-offsets.c:10:
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/asm-generic/rwonce.h:44:72: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x) (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                        ^
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/signal.h:1,
                    from arch/arm/kernel/asm-offsets.c:28:
   arch/arm/include/asm/ucontext.h: At top level:
>> arch/arm/include/asm/ucontext.h:21:2: error: unknown type name 'stack_t'
      21 |  stack_t    uc_stack;
         |  ^~~~~~~
>> arch/arm/include/asm/ucontext.h:22:20: error: field 'uc_mcontext' has incomplete type
      22 |  struct sigcontext uc_mcontext;
         |                    ^~~~~~~~~~~
>> arch/arm/include/asm/ucontext.h:23:2: error: unknown type name 'sigset_t'
      23 |  sigset_t   uc_sigmask;
         |  ^~~~~~~~
>> arch/arm/include/asm/ucontext.h:25:32: error: 'sigset_t' undeclared here (not in a function); did you mean 'size_t'?
      25 |  int    __unused[32 - (sizeof (sigset_t) / sizeof (int))];
         |                                ^~~~~~~~
         |                                size_t
   In file included from arch/arm/kernel/asm-offsets.c:28:
>> arch/arm/kernel/signal.h:9:17: error: field 'info' has incomplete type
       9 |  struct siginfo info;
         |                 ^~~~
   In file included from arch/arm/kernel/asm-offsets.c:26:
   arch/arm/kernel/asm-offsets.c: In function 'main':
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'stack_canary'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/asm-offsets.c:41:28: note: in expansion of macro 'offsetof'
      41 |   DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
         |                            ^~~~~~~~
   cc1: some warnings being treated as errors
--
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:279:13: note: in definition of macro '__unqual_scalar_typeof'
     279 |   _Generic((x),      \
         |             ^
   include/asm-generic/rwonce.h:50:2: note: in expansion of macro '__READ_ONCE'
      50 |  __READ_ONCE(x);       \
         |  ^~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from arch/arm/kernel/asm-offsets.c:10:
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/asm-generic/rwonce.h:44:72: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x) (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                        ^
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/signal.h:1,
                    from arch/arm/kernel/asm-offsets.c:28:
   arch/arm/include/asm/ucontext.h: At top level:
>> arch/arm/include/asm/ucontext.h:21:2: error: unknown type name 'stack_t'
      21 |  stack_t    uc_stack;
         |  ^~~~~~~
>> arch/arm/include/asm/ucontext.h:22:20: error: field 'uc_mcontext' has incomplete type
      22 |  struct sigcontext uc_mcontext;
         |                    ^~~~~~~~~~~
>> arch/arm/include/asm/ucontext.h:23:2: error: unknown type name 'sigset_t'
      23 |  sigset_t   uc_sigmask;
         |  ^~~~~~~~
>> arch/arm/include/asm/ucontext.h:25:32: error: 'sigset_t' undeclared here (not in a function); did you mean 'size_t'?
      25 |  int    __unused[32 - (sizeof (sigset_t) / sizeof (int))];
         |                                ^~~~~~~~
         |                                size_t
   In file included from arch/arm/kernel/asm-offsets.c:28:
>> arch/arm/kernel/signal.h:9:17: error: field 'info' has incomplete type
       9 |  struct siginfo info;
         |                 ^~~~
   In file included from arch/arm/kernel/asm-offsets.c:26:
   arch/arm/kernel/asm-offsets.c: In function 'main':
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'stack_canary'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/asm-offsets.c:41:28: note: in expansion of macro 'offsetof'
      41 |   DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
         |                            ^~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:21: note: in expansion of macro '__native_word'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |                     ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:308:9: note: in definition of macro '__compiletime_assert'
     308 |   if (!(condition))     \
         |         ^~~~~~~~~
   include/linux/compiler_types.h:328:2: note: in expansion of macro '_compiletime_assert'
     328 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:2: note: in expansion of macro 'compiletime_assert'
      36 |  compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long), \
         |  ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:2: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |  compiletime_assert_rwonce_type(x);    \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/linux/compiler_types.h:279:13: note: in definition of macro '__unqual_scalar_typeof'
     279 |   _Generic((x),      \
         |             ^
   include/asm-generic/rwonce.h:50:2: note: in expansion of macro '__READ_ONCE'
      50 |  __READ_ONCE(x);       \
         |  ^~~~~~~~~~~
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:248,
                    from arch/arm/kernel/asm-offsets.c:10:
   include/linux/sched/thread_info_api.h:38:62: error: 'const struct task_struct' has no member named 'stack'
      38 | # define task_thread_info(task) ((struct thread_info *)(task)->stack)
         |                                                              ^~
   include/asm-generic/rwonce.h:44:72: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x) (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                        ^
   include/linux/sched/thread_info_api.h:194:9: note: in expansion of macro 'READ_ONCE'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |         ^~~~~~~~~
   include/linux/sched/thread_info_api.h:194:19: note: in expansion of macro 'task_thread_info'
     194 |  return READ_ONCE(task_thread_info(p)->cpu);
         |                   ^~~~~~~~~~~~~~~~
   In file included from arch/arm/kernel/signal.h:1,
                    from arch/arm/kernel/asm-offsets.c:28:
   arch/arm/include/asm/ucontext.h: At top level:
>> arch/arm/include/asm/ucontext.h:21:2: error: unknown type name 'stack_t'
      21 |  stack_t    uc_stack;
         |  ^~~~~~~
>> arch/arm/include/asm/ucontext.h:22:20: error: field 'uc_mcontext' has incomplete type
      22 |  struct sigcontext uc_mcontext;
         |                    ^~~~~~~~~~~
>> arch/arm/include/asm/ucontext.h:23:2: error: unknown type name 'sigset_t'
      23 |  sigset_t   uc_sigmask;
         |  ^~~~~~~~
>> arch/arm/include/asm/ucontext.h:25:32: error: 'sigset_t' undeclared here (not in a function); did you mean 'size_t'?
      25 |  int    __unused[32 - (sizeof (sigset_t) / sizeof (int))];
         |                                ^~~~~~~~
         |                                size_t
   In file included from arch/arm/kernel/asm-offsets.c:28:
>> arch/arm/kernel/signal.h:9:17: error: field 'info' has incomplete type
       9 |  struct siginfo info;
         |                 ^~~~
   In file included from arch/arm/kernel/asm-offsets.c:26:
   arch/arm/kernel/asm-offsets.c: In function 'main':
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'stack_canary'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/asm-offsets.c:41:28: note: in expansion of macro 'offsetof'
      41 |   DEFINE(TSK_STACK_CANARY, offsetof(struct task_struct, stack_canary));
         |                            ^~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/arm/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +25 arch/arm/include/asm/ucontext.h

85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24   7  
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24   8  /*
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24   9   * struct sigcontext only has room for the basic registers, but struct
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  10   * ucontext now has room for all registers which need to be saved and
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  11   * restored.  Coprocessor registers are stored in uc_regspace.  Each
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  12   * coprocessor's saved state should start with a documented 32-bit magic
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  13   * number, followed by a 32-bit word giving the coproccesor's saved size.
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  14   * uc_regspace may be expanded if necessary, although this takes some
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  15   * coordination with glibc.
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  16   */
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  17  
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16  18  struct ucontext {
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16  19  	unsigned long	  uc_flags;
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16  20  	struct ucontext  *uc_link;
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16 @21  	stack_t		  uc_stack;
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16 @22  	struct sigcontext uc_mcontext;
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24 @23  	sigset_t	  uc_sigmask;
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  24  	/* Allow for uc_sigmask growth.  Glibc uses a 1024-bit sigset_t.  */
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24 @25  	int		  __unused[32 - (sizeof (sigset_t) / sizeof (int))];
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  26  	/* Last for extensibility.  Eight byte aligned because some
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  27  	   coprocessors require eight byte alignment.  */
85fe068123aa11 include/asm-arm/ucontext.h Daniel Jacobowitz 2006-06-24  28   	unsigned long	  uc_regspace[128] __attribute__((__aligned__(8)));
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16  29  };
^1da177e4c3f41 include/asm-arm/ucontext.h Linus Torvalds    2005-04-16  30  

:::::: The code at line 25 was first introduced by commit
:::::: 85fe068123aa11d3477ce88c7d365e233b1f2e10 [ARM] 3648/1: Update struct ucontext layout for coprocessor registers

:::::: TO: Daniel Jacobowitz <drow@false.org>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HlL+5n6rz5pIUxbD--
