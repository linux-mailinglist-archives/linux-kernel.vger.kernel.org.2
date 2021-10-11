Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20233428BED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 13:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhJKL2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 07:28:31 -0400
Received: from mga14.intel.com ([192.55.52.115]:17437 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233085AbhJKL2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 07:28:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10133"; a="227140827"
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="gz'50?scan'50,208,50";a="227140827"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 04:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,364,1624345200"; 
   d="gz'50?scan'50,208,50";a="479818070"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Oct 2021 04:26:27 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mZtRq-0002F5-VJ; Mon, 11 Oct 2021 11:26:26 +0000
Date:   Mon, 11 Oct 2021 19:26:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [deller-parisc:thread-info 7/7] include/asm-generic/current.h:7:24:
 error: implicit declaration of function 'current_thread_info'
Message-ID: <202110111950.5TZCTRps-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git thread-info
head:   6e3fffa554466061367aa5d2f613b65facd67c3e
commit: 6e3fffa554466061367aa5d2f613b65facd67c3e [7/7] parisc: Move thread info into task struct (CONFIG_THREAD_INFO_IN_TASK)
config: parisc-defconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git/commit/?id=6e3fffa554466061367aa5d2f613b65facd67c3e
        git remote add deller-parisc https://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
        git fetch --no-tags deller-parisc thread-info
        git checkout 6e3fffa554466061367aa5d2f613b65facd67c3e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   include/asm-generic/preempt.h: In function 'preempt_count':
>> include/asm-generic/current.h:7:24: error: implicit declaration of function 'current_thread_info' [-Werror=implicit-function-declaration]
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:28: note: in expansion of macro '__native_word'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |                            ^~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler_types.h:302:23: note: in definition of macro '__compiletime_assert'
     302 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:322:9: note: in expansion of macro '_compiletime_assert'
     322 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:36:9: note: in expansion of macro 'compiletime_assert'
      36 |         compiletime_assert(__native_word(t) || sizeof(t) == sizeof(long long),  \
         |         ^~~~~~~~~~~~~~~~~~
   include/asm-generic/rwonce.h:49:9: note: in expansion of macro 'compiletime_assert_rwonce_type'
      49 |         compiletime_assert_rwonce_type(x);                              \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler_types.h:279:27: note: in definition of macro '__unqual_scalar_typeof'
     279 |                 _Generic((x),                                           \
         |                           ^
   include/asm-generic/rwonce.h:50:9: note: in expansion of macro '__READ_ONCE'
      50 |         __READ_ONCE(x);                                                 \
         |         ^~~~~~~~~~~
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
   In file included from ./arch/parisc/include/generated/asm/rwonce.h:1,
                    from include/linux/compiler.h:266,
                    from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/asm-generic/rwonce.h:44:73: note: in definition of macro '__READ_ONCE'
      44 | #define __READ_ONCE(x)  (*(const volatile __unqual_scalar_typeof(x) *)&(x))
         |                                                                         ^
   include/asm-generic/preempt.h:11:16: note: in expansion of macro 'READ_ONCE'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                ^~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:11:26: note: in expansion of macro 'current_thread_info'
      11 |         return READ_ONCE(current_thread_info()->preempt_count);
         |                          ^~~~~~~~~~~~~~~~~~~
   In file included from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/asm-generic/preempt.h: In function 'preempt_count_ptr':
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/preempt.h:16:17: note: in expansion of macro 'current_thread_info'
      16 |         return &current_thread_info()->preempt_count;
         |                 ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/thread_info.h:132:29: note: in expansion of macro 'current_thread_info'
     132 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:166:28: note: in expansion of macro 'test_thread_flag'
     166 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:69:43: note: in expansion of macro 'tif_need_resched'
      69 |         return !--*preempt_count_ptr() && tif_need_resched();
         |                                           ^~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/asm-generic/preempt.h: In function 'should_resched':
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/thread_info.h:132:29: note: in expansion of macro 'current_thread_info'
     132 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:166:28: note: in expansion of macro 'test_thread_flag'
     166 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:78:25: note: in expansion of macro 'tif_need_resched'
      78 |                         tif_need_resched());
         |                         ^~~~~~~~~~~~~~~~
   In file included from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/ww_mutex.h: In function 'ww_acquire_init':
>> include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/ww_mutex.h:137:21: note: in expansion of macro 'current'
     137 |         ctx->task = current;
         |                     ^~~~~~~
   include/linux/thread_info.h:24:54: note: each undeclared identifier is reported only once for each function it appears in
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/ww_mutex.h:137:21: note: in expansion of macro 'current'
     137 |         ctx->task = current;
         |                     ^~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/seccomp.h: In function 'secure_computing':
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/thread_info.h:154:29: note: in expansion of macro 'current_thread_info'
     154 |         test_ti_thread_flag(current_thread_info(), TIF_##fl)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/seccomp.h:45:22: note: in expansion of macro 'test_syscall_work'
      45 |         if (unlikely(test_syscall_work(SECCOMP)))
         |                      ^~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/sched.h: In function 'is_percpu_thread':
>> include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/sched.h:1726:17: note: in expansion of macro 'current'
    1726 |         return (current->flags & PF_NO_SETAFFINITY) &&
         |                 ^~~~~~~
   include/linux/sched.h: In function 'current_restore_flags':
>> include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/sched.h:1787:9: note: in expansion of macro 'current'
    1787 |         current->flags &= ~flags;
         |         ^~~~~~~
   In file included from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/sched.h: In function 'scheduler_ipi':
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/thread_info.h:132:29: note: in expansion of macro 'current_thread_info'
     132 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:166:28: note: in expansion of macro 'test_thread_flag'
     166 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   include/linux/preempt.h:281:13: note: in expansion of macro 'tif_need_resched'
     281 |         if (tif_need_resched()) \
         |             ^~~~~~~~~~~~~~~~
   include/linux/sched.h:1947:9: note: in expansion of macro 'preempt_fold_need_resched'
    1947 |         preempt_fold_need_resched();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/sched.h: In function 'need_resched':
>> include/asm-generic/current.h:7:45: error: invalid type argument of '->' (have 'int')
       7 | #define get_current() (current_thread_info()->task)
         |                                             ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/thread_info.h:24:54: note: in expansion of macro 'current'
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/thread_info.h:132:29: note: in expansion of macro 'current_thread_info'
     132 |         test_ti_thread_flag(current_thread_info(), flag)
         |                             ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:166:28: note: in expansion of macro 'test_thread_flag'
     166 | #define tif_need_resched() test_thread_flag(TIF_NEED_RESCHED)
         |                            ^~~~~~~~~~~~~~~~
   include/linux/sched.h:2107:25: note: in expansion of macro 'tif_need_resched'
    2107 |         return unlikely(tif_need_resched());
         |                         ^~~~~~~~~~~~~~~~
   In file included from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/uaccess.h: In function 'pagefault_disabled_inc':
>> include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/uaccess.h:219:9: note: in expansion of macro 'current'
     219 |         current->pagefault_disabled++;
         |         ^~~~~~~
   include/linux/uaccess.h: In function 'pagefault_disabled_dec':
>> include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/uaccess.h:224:9: note: in expansion of macro 'current'
     224 |         current->pagefault_disabled--;
         |         ^~~~~~~
   include/linux/uaccess.h: In function 'pagefault_disabled':
>> include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/uaccess.h:259:16: note: in expansion of macro 'current'
     259 |         return current->pagefault_disabled != 0;
         |                ^~~~~~~
   include/linux/ratelimit.h: In function 'ratelimit_state_exit':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/printk.h:418:33: note: in expansion of macro 'current'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:446:26: note: in expansion of macro 'printk_index_wrap'
     446 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
         |                          ^~~~~~~~~~~~~~~~~
   include/linux/printk.h:499:9: note: in expansion of macro 'printk'
     499 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/ratelimit.h:31:17: note: in expansion of macro 'pr_warn'
      31 |                 pr_warn("%s: %d output lines suppressed due to ratelimiting\n",
         |                 ^~~~~~~
   include/linux/sched/signal.h: In function 'kernel_dequeue_signal':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/sched/signal.h:281:36: note: in expansion of macro 'current'
     281 |         struct task_struct *task = current;
         |                                    ^~~~~~~
   include/linux/sched/signal.h: In function 'kernel_signal_stop':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/sched/signal.h:294:24: note: in expansion of macro 'current'
     294 |         spin_lock_irq(&current->sighand->siglock);
         |                        ^~~~~~~
   include/linux/sched/signal.h: In function 'restart_syscall':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/sched/signal.h:350:29: note: in expansion of macro 'current'
     350 |         set_tsk_thread_flag(current, TIF_SIGPENDING);
         |                             ^~~~~~~
   In file included from include/linux/kernel.h:11,
                    from arch/parisc/include/asm/bug.h:5,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:
   include/linux/sched/signal.h: In function 'fault_signal_pending':
   include/linux/thread_info.h:24:54: error: 'current' undeclared (first use in this function)
      24 | #define current_thread_info() ((struct thread_info *)current)
         |                                                      ^~~~~~~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/asm-generic/current.h:7:24: note: in expansion of macro 'current_thread_info'
       7 | #define get_current() (current_thread_info()->task)
         |                        ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/current.h:8:17: note: in expansion of macro 'get_current'
       8 | #define current get_current()
         |                 ^~~~~~~~~~~
   include/linux/sched/signal.h:401:47: note: in expansion of macro 'current'
     401 |                         (fatal_signal_pending(current) ||
         |                                               ^~~~~~~
   In file included from include/asm-generic/current.h:5,
                    from ./arch/parisc/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/parisc/kernel/asm-offsets.c:20:


vim +/current_thread_info +7 include/asm-generic/current.h

aafe4dbed0bf6c Arnd Bergmann 2009-05-13  6  
aafe4dbed0bf6c Arnd Bergmann 2009-05-13 @7  #define get_current() (current_thread_info()->task)
aafe4dbed0bf6c Arnd Bergmann 2009-05-13 @8  #define current get_current()
aafe4dbed0bf6c Arnd Bergmann 2009-05-13  9  

:::::: The code at line 7 was first introduced by commit
:::::: aafe4dbed0bf6cbdb2e9f03e1d42f8a540d8541d asm-generic: add generic versions of common headers

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Arnd Bergmann <arnd@klappe2.(none)>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
PNWjaHTkD5hzfDgZMQEA

--cWoXeonUoKmBZSoM--
