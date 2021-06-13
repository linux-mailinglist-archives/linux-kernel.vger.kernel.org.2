Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F563A5A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhFMUcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:32:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:12504 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231883AbhFMUcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:32:14 -0400
IronPort-SDR: 85ZCgQe072mT17P7tR6zSZ2nboTLTKNWRu/46/pmiAF3FMzQFsgn68lUFRtFgKtL6URiv3r65b
 R0DJqI6IDaQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="186111620"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="186111620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 13:30:12 -0700
IronPort-SDR: ckYGqqtTDuhYTpC2ZW6b7h5fGI/P1AeQcO37fISMnrAC0nri0Y55O028fGOTUgiVRmf+6ZwY7i
 z/VCS0H4J5qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="553919729"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2021 13:30:11 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsWkG-0001Up-4w; Sun, 13 Jun 2021 20:30:12 +0000
Date:   Mon, 14 Jun 2021 04:29:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 253/364] arch/riscv/kernel/asm-offsets.c:313:27:
 error: implicit declaration of function 'ALIGN'
Message-ID: <202106140411.easp8sck-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ingo,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: d9c2c90ff3d122ee8c4bf9129c91eb741b5c6463 [253/364] sched/headers: Simplify <linux/kernel.h>
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=d9c2c90ff3d122ee8c4bf9129c91eb741b5c6463
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout d9c2c90ff3d122ee8c4bf9129c91eb741b5c6463
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:290:5: note: in expansion of macro 'offsetof'
     290 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:293:5: note: in expansion of macro 'offsetof'
     293 |     offsetof(struct task_struct, thread.fstate.f[29])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:294:5: note: in expansion of macro 'offsetof'
     294 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:297:5: note: in expansion of macro 'offsetof'
     297 |     offsetof(struct task_struct, thread.fstate.f[30])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:298:5: note: in expansion of macro 'offsetof'
     298 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:301:5: note: in expansion of macro 'offsetof'
     301 |     offsetof(struct task_struct, thread.fstate.f[31])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:302:5: note: in expansion of macro 'offsetof'
     302 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:305:5: note: in expansion of macro 'offsetof'
     305 |     offsetof(struct task_struct, thread.fstate.fcsr)
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:306:5: note: in expansion of macro 'offsetof'
     306 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
>> arch/riscv/kernel/asm-offsets.c:313:27: error: implicit declaration of function 'ALIGN' [-Werror=implicit-function-declaration]
     313 |  DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
         |                           ^~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   cc1: some warnings being treated as errors
--
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:290:5: note: in expansion of macro 'offsetof'
     290 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:293:5: note: in expansion of macro 'offsetof'
     293 |     offsetof(struct task_struct, thread.fstate.f[29])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:294:5: note: in expansion of macro 'offsetof'
     294 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:297:5: note: in expansion of macro 'offsetof'
     297 |     offsetof(struct task_struct, thread.fstate.f[30])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:298:5: note: in expansion of macro 'offsetof'
     298 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:301:5: note: in expansion of macro 'offsetof'
     301 |     offsetof(struct task_struct, thread.fstate.f[31])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:302:5: note: in expansion of macro 'offsetof'
     302 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:305:5: note: in expansion of macro 'offsetof'
     305 |     offsetof(struct task_struct, thread.fstate.fcsr)
         |     ^~~~~~~~
   include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/asm-offsets.c:306:5: note: in expansion of macro 'offsetof'
     306 |   - offsetof(struct task_struct, thread.fstate.f[0])
         |     ^~~~~~~~
>> arch/riscv/kernel/asm-offsets.c:313:27: error: implicit declaration of function 'ALIGN' [-Werror=implicit-function-declaration]
     313 |  DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));
         |                           ^~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/ALIGN +313 arch/riscv/kernel/asm-offsets.c

7db91e57a0acde Palmer Dabbelt    2017-07-10   74  
7db91e57a0acde Palmer Dabbelt    2017-07-10   75  	DEFINE(PT_SIZE, sizeof(struct pt_regs));
a4c3733d32a72f Christoph Hellwig 2019-10-28   76  	OFFSET(PT_EPC, pt_regs, epc);
7db91e57a0acde Palmer Dabbelt    2017-07-10   77  	OFFSET(PT_RA, pt_regs, ra);
7db91e57a0acde Palmer Dabbelt    2017-07-10   78  	OFFSET(PT_FP, pt_regs, s0);
7db91e57a0acde Palmer Dabbelt    2017-07-10   79  	OFFSET(PT_S0, pt_regs, s0);
7db91e57a0acde Palmer Dabbelt    2017-07-10   80  	OFFSET(PT_S1, pt_regs, s1);
7db91e57a0acde Palmer Dabbelt    2017-07-10   81  	OFFSET(PT_S2, pt_regs, s2);
7db91e57a0acde Palmer Dabbelt    2017-07-10   82  	OFFSET(PT_S3, pt_regs, s3);
7db91e57a0acde Palmer Dabbelt    2017-07-10   83  	OFFSET(PT_S4, pt_regs, s4);
7db91e57a0acde Palmer Dabbelt    2017-07-10   84  	OFFSET(PT_S5, pt_regs, s5);
7db91e57a0acde Palmer Dabbelt    2017-07-10   85  	OFFSET(PT_S6, pt_regs, s6);
7db91e57a0acde Palmer Dabbelt    2017-07-10   86  	OFFSET(PT_S7, pt_regs, s7);
7db91e57a0acde Palmer Dabbelt    2017-07-10   87  	OFFSET(PT_S8, pt_regs, s8);
7db91e57a0acde Palmer Dabbelt    2017-07-10   88  	OFFSET(PT_S9, pt_regs, s9);
7db91e57a0acde Palmer Dabbelt    2017-07-10   89  	OFFSET(PT_S10, pt_regs, s10);
7db91e57a0acde Palmer Dabbelt    2017-07-10   90  	OFFSET(PT_S11, pt_regs, s11);
7db91e57a0acde Palmer Dabbelt    2017-07-10   91  	OFFSET(PT_SP, pt_regs, sp);
7db91e57a0acde Palmer Dabbelt    2017-07-10   92  	OFFSET(PT_TP, pt_regs, tp);
7db91e57a0acde Palmer Dabbelt    2017-07-10   93  	OFFSET(PT_A0, pt_regs, a0);
7db91e57a0acde Palmer Dabbelt    2017-07-10   94  	OFFSET(PT_A1, pt_regs, a1);
7db91e57a0acde Palmer Dabbelt    2017-07-10   95  	OFFSET(PT_A2, pt_regs, a2);
7db91e57a0acde Palmer Dabbelt    2017-07-10   96  	OFFSET(PT_A3, pt_regs, a3);
7db91e57a0acde Palmer Dabbelt    2017-07-10   97  	OFFSET(PT_A4, pt_regs, a4);
7db91e57a0acde Palmer Dabbelt    2017-07-10   98  	OFFSET(PT_A5, pt_regs, a5);
7db91e57a0acde Palmer Dabbelt    2017-07-10   99  	OFFSET(PT_A6, pt_regs, a6);
7db91e57a0acde Palmer Dabbelt    2017-07-10  100  	OFFSET(PT_A7, pt_regs, a7);
7db91e57a0acde Palmer Dabbelt    2017-07-10  101  	OFFSET(PT_T0, pt_regs, t0);
7db91e57a0acde Palmer Dabbelt    2017-07-10  102  	OFFSET(PT_T1, pt_regs, t1);
7db91e57a0acde Palmer Dabbelt    2017-07-10  103  	OFFSET(PT_T2, pt_regs, t2);
7db91e57a0acde Palmer Dabbelt    2017-07-10  104  	OFFSET(PT_T3, pt_regs, t3);
7db91e57a0acde Palmer Dabbelt    2017-07-10  105  	OFFSET(PT_T4, pt_regs, t4);
7db91e57a0acde Palmer Dabbelt    2017-07-10  106  	OFFSET(PT_T5, pt_regs, t5);
7db91e57a0acde Palmer Dabbelt    2017-07-10  107  	OFFSET(PT_T6, pt_regs, t6);
7db91e57a0acde Palmer Dabbelt    2017-07-10  108  	OFFSET(PT_GP, pt_regs, gp);
7db91e57a0acde Palmer Dabbelt    2017-07-10  109  	OFFSET(PT_ORIG_A0, pt_regs, orig_a0);
a4c3733d32a72f Christoph Hellwig 2019-10-28  110  	OFFSET(PT_STATUS, pt_regs, status);
a4c3733d32a72f Christoph Hellwig 2019-10-28  111  	OFFSET(PT_BADADDR, pt_regs, badaddr);
a4c3733d32a72f Christoph Hellwig 2019-10-28  112  	OFFSET(PT_CAUSE, pt_regs, cause);
7db91e57a0acde Palmer Dabbelt    2017-07-10  113  
7db91e57a0acde Palmer Dabbelt    2017-07-10  114  	/*
7db91e57a0acde Palmer Dabbelt    2017-07-10  115  	 * THREAD_{F,X}* might be larger than a S-type offset can handle, but
7db91e57a0acde Palmer Dabbelt    2017-07-10  116  	 * these are used in performance-sensitive assembly so we can't resort
7db91e57a0acde Palmer Dabbelt    2017-07-10  117  	 * to loading the long immediate every time.
7db91e57a0acde Palmer Dabbelt    2017-07-10  118  	 */
7db91e57a0acde Palmer Dabbelt    2017-07-10  119  	DEFINE(TASK_THREAD_RA_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  120  		  offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  121  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  122  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  123  	DEFINE(TASK_THREAD_SP_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  124  		  offsetof(struct task_struct, thread.sp)
7db91e57a0acde Palmer Dabbelt    2017-07-10  125  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  126  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  127  	DEFINE(TASK_THREAD_S0_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  128  		  offsetof(struct task_struct, thread.s[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  129  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  130  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  131  	DEFINE(TASK_THREAD_S1_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  132  		  offsetof(struct task_struct, thread.s[1])
7db91e57a0acde Palmer Dabbelt    2017-07-10  133  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  134  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  135  	DEFINE(TASK_THREAD_S2_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  136  		  offsetof(struct task_struct, thread.s[2])
7db91e57a0acde Palmer Dabbelt    2017-07-10  137  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  138  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  139  	DEFINE(TASK_THREAD_S3_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  140  		  offsetof(struct task_struct, thread.s[3])
7db91e57a0acde Palmer Dabbelt    2017-07-10  141  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  142  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  143  	DEFINE(TASK_THREAD_S4_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  144  		  offsetof(struct task_struct, thread.s[4])
7db91e57a0acde Palmer Dabbelt    2017-07-10  145  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  146  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  147  	DEFINE(TASK_THREAD_S5_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  148  		  offsetof(struct task_struct, thread.s[5])
7db91e57a0acde Palmer Dabbelt    2017-07-10  149  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  150  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  151  	DEFINE(TASK_THREAD_S6_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  152  		  offsetof(struct task_struct, thread.s[6])
7db91e57a0acde Palmer Dabbelt    2017-07-10  153  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  154  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  155  	DEFINE(TASK_THREAD_S7_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  156  		  offsetof(struct task_struct, thread.s[7])
7db91e57a0acde Palmer Dabbelt    2017-07-10  157  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  158  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  159  	DEFINE(TASK_THREAD_S8_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  160  		  offsetof(struct task_struct, thread.s[8])
7db91e57a0acde Palmer Dabbelt    2017-07-10  161  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  162  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  163  	DEFINE(TASK_THREAD_S9_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  164  		  offsetof(struct task_struct, thread.s[9])
7db91e57a0acde Palmer Dabbelt    2017-07-10  165  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  166  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  167  	DEFINE(TASK_THREAD_S10_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  168  		  offsetof(struct task_struct, thread.s[10])
7db91e57a0acde Palmer Dabbelt    2017-07-10  169  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  170  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  171  	DEFINE(TASK_THREAD_S11_RA,
7db91e57a0acde Palmer Dabbelt    2017-07-10  172  		  offsetof(struct task_struct, thread.s[11])
7db91e57a0acde Palmer Dabbelt    2017-07-10  173  		- offsetof(struct task_struct, thread.ra)
7db91e57a0acde Palmer Dabbelt    2017-07-10  174  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  175  
7db91e57a0acde Palmer Dabbelt    2017-07-10  176  	DEFINE(TASK_THREAD_F0_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  177  		  offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  178  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  179  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  180  	DEFINE(TASK_THREAD_F1_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  181  		  offsetof(struct task_struct, thread.fstate.f[1])
7db91e57a0acde Palmer Dabbelt    2017-07-10  182  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  183  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  184  	DEFINE(TASK_THREAD_F2_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  185  		  offsetof(struct task_struct, thread.fstate.f[2])
7db91e57a0acde Palmer Dabbelt    2017-07-10  186  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  187  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  188  	DEFINE(TASK_THREAD_F3_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  189  		  offsetof(struct task_struct, thread.fstate.f[3])
7db91e57a0acde Palmer Dabbelt    2017-07-10  190  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  191  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  192  	DEFINE(TASK_THREAD_F4_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  193  		  offsetof(struct task_struct, thread.fstate.f[4])
7db91e57a0acde Palmer Dabbelt    2017-07-10  194  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  195  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  196  	DEFINE(TASK_THREAD_F5_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  197  		  offsetof(struct task_struct, thread.fstate.f[5])
7db91e57a0acde Palmer Dabbelt    2017-07-10  198  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  199  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  200  	DEFINE(TASK_THREAD_F6_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  201  		  offsetof(struct task_struct, thread.fstate.f[6])
7db91e57a0acde Palmer Dabbelt    2017-07-10  202  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  203  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  204  	DEFINE(TASK_THREAD_F7_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  205  		  offsetof(struct task_struct, thread.fstate.f[7])
7db91e57a0acde Palmer Dabbelt    2017-07-10  206  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  207  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  208  	DEFINE(TASK_THREAD_F8_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  209  		  offsetof(struct task_struct, thread.fstate.f[8])
7db91e57a0acde Palmer Dabbelt    2017-07-10  210  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  211  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  212  	DEFINE(TASK_THREAD_F9_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  213  		  offsetof(struct task_struct, thread.fstate.f[9])
7db91e57a0acde Palmer Dabbelt    2017-07-10  214  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  215  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  216  	DEFINE(TASK_THREAD_F10_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  217  		  offsetof(struct task_struct, thread.fstate.f[10])
7db91e57a0acde Palmer Dabbelt    2017-07-10  218  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  219  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  220  	DEFINE(TASK_THREAD_F11_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  221  		  offsetof(struct task_struct, thread.fstate.f[11])
7db91e57a0acde Palmer Dabbelt    2017-07-10  222  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  223  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  224  	DEFINE(TASK_THREAD_F12_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  225  		  offsetof(struct task_struct, thread.fstate.f[12])
7db91e57a0acde Palmer Dabbelt    2017-07-10  226  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  227  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  228  	DEFINE(TASK_THREAD_F13_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  229  		  offsetof(struct task_struct, thread.fstate.f[13])
7db91e57a0acde Palmer Dabbelt    2017-07-10  230  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  231  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  232  	DEFINE(TASK_THREAD_F14_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  233  		  offsetof(struct task_struct, thread.fstate.f[14])
7db91e57a0acde Palmer Dabbelt    2017-07-10  234  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  235  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  236  	DEFINE(TASK_THREAD_F15_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  237  		  offsetof(struct task_struct, thread.fstate.f[15])
7db91e57a0acde Palmer Dabbelt    2017-07-10  238  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  239  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  240  	DEFINE(TASK_THREAD_F16_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  241  		  offsetof(struct task_struct, thread.fstate.f[16])
7db91e57a0acde Palmer Dabbelt    2017-07-10  242  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  243  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  244  	DEFINE(TASK_THREAD_F17_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  245  		  offsetof(struct task_struct, thread.fstate.f[17])
7db91e57a0acde Palmer Dabbelt    2017-07-10  246  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  247  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  248  	DEFINE(TASK_THREAD_F18_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  249  		  offsetof(struct task_struct, thread.fstate.f[18])
7db91e57a0acde Palmer Dabbelt    2017-07-10  250  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  251  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  252  	DEFINE(TASK_THREAD_F19_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  253  		  offsetof(struct task_struct, thread.fstate.f[19])
7db91e57a0acde Palmer Dabbelt    2017-07-10  254  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  255  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  256  	DEFINE(TASK_THREAD_F20_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  257  		  offsetof(struct task_struct, thread.fstate.f[20])
7db91e57a0acde Palmer Dabbelt    2017-07-10  258  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  259  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  260  	DEFINE(TASK_THREAD_F21_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  261  		  offsetof(struct task_struct, thread.fstate.f[21])
7db91e57a0acde Palmer Dabbelt    2017-07-10  262  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  263  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  264  	DEFINE(TASK_THREAD_F22_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  265  		  offsetof(struct task_struct, thread.fstate.f[22])
7db91e57a0acde Palmer Dabbelt    2017-07-10  266  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  267  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  268  	DEFINE(TASK_THREAD_F23_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  269  		  offsetof(struct task_struct, thread.fstate.f[23])
7db91e57a0acde Palmer Dabbelt    2017-07-10  270  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  271  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  272  	DEFINE(TASK_THREAD_F24_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  273  		  offsetof(struct task_struct, thread.fstate.f[24])
7db91e57a0acde Palmer Dabbelt    2017-07-10  274  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  275  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  276  	DEFINE(TASK_THREAD_F25_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  277  		  offsetof(struct task_struct, thread.fstate.f[25])
7db91e57a0acde Palmer Dabbelt    2017-07-10  278  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  279  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  280  	DEFINE(TASK_THREAD_F26_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  281  		  offsetof(struct task_struct, thread.fstate.f[26])
7db91e57a0acde Palmer Dabbelt    2017-07-10  282  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  283  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  284  	DEFINE(TASK_THREAD_F27_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  285  		  offsetof(struct task_struct, thread.fstate.f[27])
7db91e57a0acde Palmer Dabbelt    2017-07-10  286  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  287  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  288  	DEFINE(TASK_THREAD_F28_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  289  		  offsetof(struct task_struct, thread.fstate.f[28])
7db91e57a0acde Palmer Dabbelt    2017-07-10  290  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  291  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  292  	DEFINE(TASK_THREAD_F29_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  293  		  offsetof(struct task_struct, thread.fstate.f[29])
7db91e57a0acde Palmer Dabbelt    2017-07-10  294  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  295  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  296  	DEFINE(TASK_THREAD_F30_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  297  		  offsetof(struct task_struct, thread.fstate.f[30])
7db91e57a0acde Palmer Dabbelt    2017-07-10  298  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  299  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  300  	DEFINE(TASK_THREAD_F31_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  301  		  offsetof(struct task_struct, thread.fstate.f[31])
7db91e57a0acde Palmer Dabbelt    2017-07-10  302  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  303  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  304  	DEFINE(TASK_THREAD_FCSR_F0,
7db91e57a0acde Palmer Dabbelt    2017-07-10  305  		  offsetof(struct task_struct, thread.fstate.fcsr)
7db91e57a0acde Palmer Dabbelt    2017-07-10  306  		- offsetof(struct task_struct, thread.fstate.f[0])
7db91e57a0acde Palmer Dabbelt    2017-07-10  307  	);
7db91e57a0acde Palmer Dabbelt    2017-07-10  308  
7db91e57a0acde Palmer Dabbelt    2017-07-10  309  	/*
7db91e57a0acde Palmer Dabbelt    2017-07-10  310  	 * We allocate a pt_regs on the stack when entering the kernel.  This
7db91e57a0acde Palmer Dabbelt    2017-07-10  311  	 * ensures the alignment is sane.
7db91e57a0acde Palmer Dabbelt    2017-07-10  312  	 */
7db91e57a0acde Palmer Dabbelt    2017-07-10 @313  	DEFINE(PT_SIZE_ON_STACK, ALIGN(sizeof(struct pt_regs), STACK_ALIGN));

:::::: The code at line 313 was first introduced by commit
:::::: 7db91e57a0acde126a162ababfb1e0ab190130cb RISC-V: Task implementation

:::::: TO: Palmer Dabbelt <palmer@dabbelt.com>
:::::: CC: Palmer Dabbelt <palmer@dabbelt.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--3V7upXqbjpZ4EhLz--
