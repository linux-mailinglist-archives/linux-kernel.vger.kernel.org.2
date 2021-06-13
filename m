Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9A833A5A64
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhFMUlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:41:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:61692 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhFMUlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:41:19 -0400
IronPort-SDR: 4iRh1wKvwu1bCYPS42o1iQ/k6I4DR41YzTfALcV6AAZELe1RDBQv76AT1GggMmpnYpt2NVmdsl
 2uBqnVHlQbSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="205766054"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="205766054"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 13:39:17 -0700
IronPort-SDR: b3u2JvTBXzF72YrPB+d/qxP1sFvjVukEtcaswYKGgvqd1RN5hmMcXPCSyKC1SazszCdYCFdBOB
 nsn+Tniv+DDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="449690218"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2021 13:39:16 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsWt3-0001Uy-5a; Sun, 13 Jun 2021 20:39:17 +0000
Date:   Mon, 14 Jun 2021 04:38:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 336/364] arch/x86/include/asm/page_32_types.h:22:
 warning: "THREAD_SIZE_ORDER" redefined
Message-ID: <202106140413.HF1PpaD5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: 8ba52e725f44d3c1da94670a29614b683e286c5a [336/364] sched/headers, mm: Simplify <linux/slab.h>'s header file dependencies
config: um-i386_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=8ba52e725f44d3c1da94670a29614b683e286c5a
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout 8ba52e725f44d3c1da94670a29614b683e286c5a
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/um/user-offsets.c:18:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      18 | void foo(void)
         |      ^~~
   In file included from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/page_types.h:11: warning: "PAGE_SIZE" redefined
      11 | #define PAGE_SIZE  (_AC(1,UL) << PAGE_SHIFT)
         | 
   In file included from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/page.h:14: note: this is the location of the previous definition
      14 | #define PAGE_SIZE (_AC(1, UL) << PAGE_SHIFT)
         | 
   In file included from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/page_types.h:36: warning: "PAGE_OFFSET" redefined
      36 | #define PAGE_OFFSET  ((unsigned long)__PAGE_OFFSET)
         | 
   In file included from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/page.h:93: note: this is the location of the previous definition
      93 | #define PAGE_OFFSET (uml_physmem)
         | 
   In file included from arch/x86/include/asm/page_types.h:49,
                    from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
>> arch/x86/include/asm/page_32_types.h:22: warning: "THREAD_SIZE_ORDER" redefined
      22 | #define THREAD_SIZE_ORDER 1
         | 
   In file included from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/thread_info.h:9: note: this is the location of the previous definition
       9 | #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER
         | 
   In file included from arch/x86/include/asm/page_types.h:49,
                    from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
>> arch/x86/include/asm/page_32_types.h:23: warning: "THREAD_SIZE" redefined
      23 | #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
         | 
   In file included from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/thread_info.h:10: note: this is the location of the previous definition
      10 | #define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
         | 
   In file included from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:53,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:21,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:93,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:21,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/processor-generic.h: At top level:
   arch/um/include/asm/processor-generic.h:71: warning: "TASK_SIZE" redefined
      71 | #define TASK_SIZE (task_size)
         | 
   In file included from arch/x86/include/asm/page_types.h:49,
                    from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/page_32_types.h:48: note: this is the location of the previous definition
      48 | #define TASK_SIZE  __PAGE_OFFSET
         | 
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:6,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/shared/common-offsets.h: In function 'foo':
   arch/um/include/shared/common-offsets.h:26:15: error: 'HZ' undeclared (first use in this function)
      26 | DEFINE(UM_HZ, HZ);
         |               ^~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   arch/um/include/shared/common-offsets.h:26:15: note: each undeclared identifier is reported only once for each function it appears in
      26 | DEFINE(UM_HZ, HZ);
         |               ^~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'modules_prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'modules_prepare' not remade because of errors.
--
   arch/x86/um/user-offsets.c:18:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      18 | void foo(void)
         |      ^~~
   In file included from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/page_types.h:11: warning: "PAGE_SIZE" redefined
      11 | #define PAGE_SIZE  (_AC(1,UL) << PAGE_SHIFT)
         | 
   In file included from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/page.h:14: note: this is the location of the previous definition
      14 | #define PAGE_SIZE (_AC(1, UL) << PAGE_SHIFT)
         | 
   In file included from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/page_types.h:36: warning: "PAGE_OFFSET" redefined
      36 | #define PAGE_OFFSET  ((unsigned long)__PAGE_OFFSET)
         | 
   In file included from arch/um/include/asm/thread_info.h:15,
                    from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/page.h:93: note: this is the location of the previous definition
      93 | #define PAGE_OFFSET (uml_physmem)
         | 
   In file included from arch/x86/include/asm/page_types.h:49,
                    from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
>> arch/x86/include/asm/page_32_types.h:22: warning: "THREAD_SIZE_ORDER" redefined
      22 | #define THREAD_SIZE_ORDER 1
         | 
   In file included from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/thread_info.h:9: note: this is the location of the previous definition
       9 | #define THREAD_SIZE_ORDER CONFIG_KERNEL_STACK_ORDER
         | 
   In file included from arch/x86/include/asm/page_types.h:49,
                    from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
>> arch/x86/include/asm/page_32_types.h:23: warning: "THREAD_SIZE" redefined
      23 | #define THREAD_SIZE  (PAGE_SIZE << THREAD_SIZE_ORDER)
         | 
   In file included from include/linux/thread_info.h:52,
                    from include/asm-generic/current.h:5,
                    from ./arch/um/include/generated/asm/current.h:1,
                    from include/linux/sched.h:18,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:3,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/thread_info.h:10: note: this is the location of the previous definition
      10 | #define THREAD_SIZE ((1 << CONFIG_KERNEL_STACK_ORDER) * PAGE_SIZE)
         | 
   In file included from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:53,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:21,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/spinlock_up.h:8,
                    from include/linux/spinlock.h:93,
                    from include/linux/swait.h:7,
                    from include/linux/completion.h:12,
                    from include/linux/crypto.h:21,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/asm/processor-generic.h: At top level:
   arch/um/include/asm/processor-generic.h:71: warning: "TASK_SIZE" redefined
      71 | #define TASK_SIZE (task_size)
         | 
   In file included from arch/x86/include/asm/page_types.h:49,
                    from include/linux/slab.h:20,
                    from include/linux/crypto.h:20,
                    from arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/x86/include/asm/page_32_types.h:48: note: this is the location of the previous definition
      48 | #define TASK_SIZE  __PAGE_OFFSET
         | 
   In file included from arch/um/kernel/asm-offsets.c:1:
   arch/x86/um/shared/sysdep/kernel-offsets.h:9:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
       9 | void foo(void)
         |      ^~~
   In file included from arch/x86/um/shared/sysdep/kernel-offsets.h:6,
                    from arch/um/kernel/asm-offsets.c:1:
   arch/um/include/shared/common-offsets.h: In function 'foo':
   arch/um/include/shared/common-offsets.h:26:15: error: 'HZ' undeclared (first use in this function)
      26 | DEFINE(UM_HZ, HZ);
         |               ^~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   arch/um/include/shared/common-offsets.h:26:15: note: each undeclared identifier is reported only once for each function it appears in
      26 | DEFINE(UM_HZ, HZ);
         |               ^~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/um/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/THREAD_SIZE_ORDER +22 arch/x86/include/asm/page_32_types.h

a02150610776f6 Kees Cook           2013-07-08  21  
38e7c572ce7310 Thomas Gleixner     2012-05-05 @22  #define THREAD_SIZE_ORDER	1
38e7c572ce7310 Thomas Gleixner     2012-05-05 @23  #define THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)
51c78eb3f0eb03 Jeremy Fitzhardinge 2009-02-08  24  

:::::: The code at line 22 was first introduced by commit
:::::: 38e7c572ce7310def003d8bb7c34260f5d8118cb x86: Use common threadinfo allocator

:::::: TO: Thomas Gleixner <tglx@linutronix.de>
:::::: CC: Thomas Gleixner <tglx@linutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OgqxwSJOaUobr8KG
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
MBKaiAAA

--OgqxwSJOaUobr8KG--
