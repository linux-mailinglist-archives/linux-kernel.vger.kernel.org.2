Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D385457B42
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhKTEss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:48:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:61376 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhKTEss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:48:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="258329750"
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="gz'50?scan'50,208,50";a="258329750"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 20:45:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="gz'50?scan'50,208,50";a="605771606"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 19 Nov 2021 20:45:42 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1moIFx-0005MR-Ok; Sat, 20 Nov 2021 04:45:41 +0000
Date:   Sat, 20 Nov 2021 12:45:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/mips/kernel/syscall.c:173:31: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202111201220.iqKWiDfb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a90af8f15bdc9449ee2d24e1d73fa3f7e8633f81
commit: ddb002d6d6af12c45dd9d565cadf0f40b36b7c25 MIPS: uaccess: Reduce number of nested macros
date:   7 months ago
config: mips-randconfig-s032-20211116 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ddb002d6d6af12c45dd9d565cadf0f40b36b7c25
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/kernel/syscall.c:173:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int * @@
   arch/mips/kernel/syscall.c:173:31: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   arch/mips/kernel/syscall.c:173:31: sparse:     got unsigned int *
>> arch/mips/kernel/syscall.c:174:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_ptr @@     got unsigned int * @@
   arch/mips/kernel/syscall.c:174:32: sparse:     expected unsigned int [noderef] __user *__pu_ptr
   arch/mips/kernel/syscall.c:174:32: sparse:     got unsigned int *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/kernel/ptrace.c: note: in included file:
>> arch/mips/include/asm/syscall.h:70:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   arch/mips/include/asm/syscall.h:70:17: sparse:     expected int const [noderef] __user *__p
   arch/mips/include/asm/syscall.h:70:17: sparse:     got int *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/kernel/signal.c:280:13: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:280:13: sparse: sparse: cast removes address space '__user' of expression
>> arch/mips/kernel/signal.c:280:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   arch/mips/kernel/signal.c:280:13: sparse:     expected unsigned int [noderef] __user *__pu_ptr
   arch/mips/kernel/signal.c:280:13: sparse:     got unsigned int [usertype] *
   arch/mips/kernel/signal.c:280:13: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:293:23: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:293:23: sparse: sparse: cast removes address space '__user' of expression
>> arch/mips/kernel/signal.c:293:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int * @@
   arch/mips/kernel/signal.c:293:23: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   arch/mips/kernel/signal.c:293:23: sparse:     got unsigned int *
   arch/mips/kernel/signal.c:300:23: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:300:23: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:300:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const [noderef] __user *__gu_ptr @@     got unsigned int * @@
   arch/mips/kernel/signal.c:300:23: sparse:     expected unsigned int const [noderef] __user *__gu_ptr
   arch/mips/kernel/signal.c:300:23: sparse:     got unsigned int *
   arch/mips/kernel/signal.c:630:17: sparse: sparse: symbol 'sys_sigreturn' was not declared. Should it be static?
   arch/mips/kernel/signal.c:667:17: sparse: sparse: symbol 'sys_rt_sigreturn' was not declared. Should it be static?
   arch/mips/kernel/signal.c:157:14: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:157:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ucontext [noderef] __user *uc @@     got struct ucontext * @@
   arch/mips/kernel/signal.c:157:12: sparse:     expected struct ucontext [noderef] __user *uc
   arch/mips/kernel/signal.c:157:12: sparse:     got struct ucontext *
   arch/mips/kernel/signal.c:157:14: sparse: sparse: cast removes address space '__user' of expression
   arch/mips/kernel/signal.c:157:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ucontext [noderef] __user *uc @@     got struct ucontext * @@
   arch/mips/kernel/signal.c:157:12: sparse:     expected struct ucontext [noderef] __user *uc
   arch/mips/kernel/signal.c:157:12: sparse:     got struct ucontext *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __user *p @@     got char *buf @@
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     expected void const [noderef] __user *p
   arch/mips/sibyte/common/sb_tbprof.c:449:14: sparse:     got char *buf
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got char *dest @@
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     expected void [noderef] __user *to
   arch/mips/sibyte/common/sb_tbprof.c:464:38: sparse:     got char *dest
>> arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__p @@     got int * @@
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     expected int [noderef] __user *__p
   arch/mips/sibyte/common/sb_tbprof.c:515:23: sparse:     got int *
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *read )( ... ) @@     got int ( * )( ... ) @@
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     expected int ( *read )( ... )
   arch/mips/sibyte/common/sb_tbprof.c:531:27: sparse:     got int ( * )( ... )
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   kernel/ptrace.c:53:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:53:22: sparse:    struct task_struct *
   kernel/ptrace.c:53:22: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:72:23: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct task_struct [noderef] __rcu *parent @@     got struct task_struct *new_parent @@
   kernel/ptrace.c:72:23: sparse:     expected struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:72:23: sparse:     got struct task_struct *new_parent
   kernel/ptrace.c:73:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const [noderef] __rcu *ptracer_cred @@     got struct cred const * @@
   kernel/ptrace.c:73:29: sparse:     expected struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:73:29: sparse:     got struct cred const *
   kernel/ptrace.c:127:18: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct cred const *old_cred @@     got struct cred const [noderef] __rcu *ptracer_cred @@
   kernel/ptrace.c:127:18: sparse:     expected struct cred const *old_cred
   kernel/ptrace.c:127:18: sparse:     got struct cred const [noderef] __rcu *ptracer_cred
   kernel/ptrace.c:131:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:131:25: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:131:25: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:169:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:169:27: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:169:27: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:181:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:181:28: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:181:28: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:186:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:186:30: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:186:30: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:196:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:196:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:196:9: sparse:    struct task_struct *
   kernel/ptrace.c:241:44: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/ptrace.c:241:44: sparse:    struct task_struct [noderef] __rcu *
   kernel/ptrace.c:241:44: sparse:    struct task_struct *
   kernel/ptrace.c:415:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:415:24: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:415:24: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:438:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:438:26: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:438:26: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:474:54: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *parent @@     got struct task_struct [noderef] __rcu *parent @@
   kernel/ptrace.c:474:54: sparse:     expected struct task_struct *parent
   kernel/ptrace.c:474:54: sparse:     got struct task_struct [noderef] __rcu *parent
   kernel/ptrace.c:482:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct task_struct *new_parent @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:482:53: sparse:     expected struct task_struct *new_parent
   kernel/ptrace.c:482:53: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:530:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *p1 @@     got struct task_struct [noderef] __rcu *real_parent @@
   kernel/ptrace.c:530:41: sparse:     expected struct task_struct *p1
   kernel/ptrace.c:530:41: sparse:     got struct task_struct [noderef] __rcu *real_parent
   kernel/ptrace.c:532:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sighand_struct *sigh @@     got struct sighand_struct [noderef] __rcu *sighand @@
   kernel/ptrace.c:532:50: sparse:     expected struct sighand_struct *sigh
   kernel/ptrace.c:532:50: sparse:     got struct sighand_struct [noderef] __rcu *sighand
   kernel/ptrace.c:734:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:734:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:734:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:742:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:742:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:742:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:847:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:847:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:847:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:851:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:851:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:851:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1081:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1081:37: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1081:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1083:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/ptrace.c:1083:39: sparse:     expected struct spinlock [usertype] *lock
   kernel/ptrace.c:1083:39: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:480:38: sparse: sparse: dereference of noderef expression
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:708:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:708:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:708:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:681:9: sparse: sparse: context imbalance in 'ptrace_getsiginfo' - different lock contexts for basic block
   include/linux/sched/signal.h:708:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:708:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:708:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:697:9: sparse: sparse: context imbalance in 'ptrace_setsiginfo' - different lock contexts for basic block
   kernel/ptrace.c:853:9: sparse: sparse: context imbalance in 'ptrace_resume' - different lock contexts for basic block
   kernel/ptrace.c: note: in included file:
>> arch/mips/include/asm/syscall.h:70:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   arch/mips/include/asm/syscall.h:70:17: sparse:     expected int const [noderef] __user *__p
   arch/mips/include/asm/syscall.h:70:17: sparse:     got int *
   kernel/ptrace.c: note: in included file (through include/linux/rcuwait.h, include/linux/percpu-rwsem.h, include/linux/fs.h, ...):
   include/linux/sched/signal.h:708:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:708:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:708:37: sparse:     got struct spinlock [noderef] __rcu *
   include/linux/sched/signal.h:708:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   include/linux/sched/signal.h:708:37: sparse:     expected struct spinlock [usertype] *lock
   include/linux/sched/signal.h:708:37: sparse:     got struct spinlock [noderef] __rcu *
   kernel/ptrace.c:1229:9: sparse: sparse: context imbalance in 'ptrace_request' - different lock contexts for basic block
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   kernel/seccomp.c:1333:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1333:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1333:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1345:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1345:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1345:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1831:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1831:31: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1831:31: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c:1849:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/seccomp.c:1849:33: sparse:     expected struct spinlock [usertype] *lock
   kernel/seccomp.c:1849:33: sparse:     got struct spinlock [noderef] __rcu *
   kernel/seccomp.c: note: in included file:
>> arch/mips/include/asm/syscall.h:70:17: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__p @@     got int * @@
   arch/mips/include/asm/syscall.h:70:17: sparse:     expected int const [noderef] __user *__p
   arch/mips/include/asm/syscall.h:70:17: sparse:     got int *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char [noderef] __user *__p @@     got char *buf @@
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected char [noderef] __user *__p
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__p @@     got char const *buf @@
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected char const [noderef] __user *__p
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf

vim +173 arch/mips/kernel/syscall.c

3c37026d43c47b Ralf Baechle        2005-04-13   96  
12890d0f61fc4e Ralf Baechle        2012-12-27   97  static inline int mips_atomic_set(unsigned long addr, unsigned long new)
^1da177e4c3f41 Linus Torvalds      2005-04-16   98  {
f1e39a4a616cd9 Ralf Baechle        2009-09-17   99  	unsigned long old, tmp;
12890d0f61fc4e Ralf Baechle        2012-12-27  100  	struct pt_regs *regs;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  101  	unsigned int err;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  102  
f1e39a4a616cd9 Ralf Baechle        2009-09-17  103  	if (unlikely(addr & 3))
f1e39a4a616cd9 Ralf Baechle        2009-09-17  104  		return -EINVAL;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  105  
96d4f267e40f95 Linus Torvalds      2019-01-03  106  	if (unlikely(!access_ok((const void __user *)addr, 4)))
f1e39a4a616cd9 Ralf Baechle        2009-09-17  107  		return -EINVAL;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  108  
256ec489f1c772 Thomas Bogendoerfer 2020-08-24  109  	if (cpu_has_llsc && IS_ENABLED(CONFIG_WAR_R10000_LLSC)) {
f1e39a4a616cd9 Ralf Baechle        2009-09-17  110  		__asm__ __volatile__ (
378ed6f0e3c525 Paul Burton         2018-11-08  111  		"	.set	push					\n"
a809d46066d517 Ralf Baechle        2014-03-30  112  		"	.set	arch=r4000				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  113  		"	li	%[err], 0				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  114  		"1:	ll	%[old], (%[addr])			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  115  		"	move	%[tmp], %[new]				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  116  		"2:	sc	%[tmp], (%[addr])			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  117  		"	beqzl	%[tmp], 1b				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  118  		"3:							\n"
0e525e48f73cc8 Maciej W. Rozycki   2014-11-15  119  		"	.insn						\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  120  		"	.section .fixup,\"ax\"				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  121  		"4:	li	%[err], %[efault]			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  122  		"	j	3b					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  123  		"	.previous					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  124  		"	.section __ex_table,\"a\"			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  125  		"	"STR(PTR)"	1b, 4b				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  126  		"	"STR(PTR)"	2b, 4b				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  127  		"	.previous					\n"
378ed6f0e3c525 Paul Burton         2018-11-08  128  		"	.set	pop					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  129  		: [old] "=&r" (old),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  130  		  [err] "=&r" (err),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  131  		  [tmp] "=&r" (tmp)
f1e39a4a616cd9 Ralf Baechle        2009-09-17  132  		: [addr] "r" (addr),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  133  		  [new] "r" (new),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  134  		  [efault] "i" (-EFAULT)
f1e39a4a616cd9 Ralf Baechle        2009-09-17  135  		: "memory");
f1e39a4a616cd9 Ralf Baechle        2009-09-17  136  	} else if (cpu_has_llsc) {
f1e39a4a616cd9 Ralf Baechle        2009-09-17  137  		__asm__ __volatile__ (
378ed6f0e3c525 Paul Burton         2018-11-08  138  		"	.set	push					\n"
fee313d4b880d4 Markos Chandras     2015-01-15  139  		"	.set	"MIPS_ISA_ARCH_LEVEL"			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  140  		"	li	%[err], 0				\n"
4915e1b043d628 James Hogan         2017-05-31  141  		"1:							\n"
e84957e6ae043b Paul Burton         2019-10-01  142  		"	" __SYNC(full, loongson3_war) "			\n"
4915e1b043d628 James Hogan         2017-05-31  143  		user_ll("%[old]", "(%[addr])")
f1e39a4a616cd9 Ralf Baechle        2009-09-17  144  		"	move	%[tmp], %[new]				\n"
4915e1b043d628 James Hogan         2017-05-31  145  		"2:							\n"
4915e1b043d628 James Hogan         2017-05-31  146  		user_sc("%[tmp]", "(%[addr])")
203e090ade7357 James Hogan         2017-05-31  147  		"	beqz	%[tmp], 1b				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  148  		"3:							\n"
0e525e48f73cc8 Maciej W. Rozycki   2014-11-15  149  		"	.insn						\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  150  		"	.section .fixup,\"ax\"				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  151  		"5:	li	%[err], %[efault]			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  152  		"	j	3b					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  153  		"	.previous					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  154  		"	.section __ex_table,\"a\"			\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  155  		"	"STR(PTR)"	1b, 5b				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  156  		"	"STR(PTR)"	2b, 5b				\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  157  		"	.previous					\n"
378ed6f0e3c525 Paul Burton         2018-11-08  158  		"	.set	pop					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  159  		: [old] "=&r" (old),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  160  		  [err] "=&r" (err),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  161  		  [tmp] "=&r" (tmp)
f1e39a4a616cd9 Ralf Baechle        2009-09-17  162  		: [addr] "r" (addr),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  163  		  [new] "r" (new),
f1e39a4a616cd9 Ralf Baechle        2009-09-17  164  		  [efault] "i" (-EFAULT)
f1e39a4a616cd9 Ralf Baechle        2009-09-17  165  		: "memory");
f1e39a4a616cd9 Ralf Baechle        2009-09-17  166  	} else {
f1e39a4a616cd9 Ralf Baechle        2009-09-17  167  		do {
f1e39a4a616cd9 Ralf Baechle        2009-09-17  168  			preempt_disable();
f1e39a4a616cd9 Ralf Baechle        2009-09-17  169  			ll_bit = 1;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  170  			ll_task = current;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  171  			preempt_enable();
f1e39a4a616cd9 Ralf Baechle        2009-09-17  172  
f1e39a4a616cd9 Ralf Baechle        2009-09-17 @173  			err = __get_user(old, (unsigned int *) addr);
f1e39a4a616cd9 Ralf Baechle        2009-09-17 @174  			err |= __put_user(new, (unsigned int *) addr);
f1e39a4a616cd9 Ralf Baechle        2009-09-17  175  			if (err)
f1e39a4a616cd9 Ralf Baechle        2009-09-17  176  				break;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  177  			rmb();
f1e39a4a616cd9 Ralf Baechle        2009-09-17  178  		} while (!ll_bit);
f1e39a4a616cd9 Ralf Baechle        2009-09-17  179  	}
f1e39a4a616cd9 Ralf Baechle        2009-09-17  180  
f1e39a4a616cd9 Ralf Baechle        2009-09-17  181  	if (unlikely(err))
f1e39a4a616cd9 Ralf Baechle        2009-09-17  182  		return err;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  183  
12890d0f61fc4e Ralf Baechle        2012-12-27  184  	regs = current_pt_regs();
f1e39a4a616cd9 Ralf Baechle        2009-09-17  185  	regs->regs[2] = old;
f1e39a4a616cd9 Ralf Baechle        2009-09-17  186  	regs->regs[7] = 0;	/* No error */
f1e39a4a616cd9 Ralf Baechle        2009-09-17  187  
f1e39a4a616cd9 Ralf Baechle        2009-09-17  188  	/*
f1e39a4a616cd9 Ralf Baechle        2009-09-17  189  	 * Don't let your children do this ...
f1e39a4a616cd9 Ralf Baechle        2009-09-17  190  	 */
f1e39a4a616cd9 Ralf Baechle        2009-09-17  191  	__asm__ __volatile__(
f1e39a4a616cd9 Ralf Baechle        2009-09-17  192  	"	move	$29, %0						\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  193  	"	j	syscall_exit					\n"
f1e39a4a616cd9 Ralf Baechle        2009-09-17  194  	: /* no outputs */
f1e39a4a616cd9 Ralf Baechle        2009-09-17  195  	: "r" (regs));
f1e39a4a616cd9 Ralf Baechle        2009-09-17  196  
f1e39a4a616cd9 Ralf Baechle        2009-09-17  197  	/* unreached.  Honestly.  */
f2ace93136cade Ralf Baechle        2012-12-27  198  	unreachable();
f1e39a4a616cd9 Ralf Baechle        2009-09-17  199  }
f1e39a4a616cd9 Ralf Baechle        2009-09-17  200  

:::::: The code at line 173 was first introduced by commit
:::::: f1e39a4a616cd9981a9decfd5332fd07a01abb8b MIPS: Rewrite sysmips(MIPS_ATOMIC_SET, ...) in C with inline assembler

:::::: TO: Ralf Baechle <ralf@linux-mips.org>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--sm4nu43k4a2Rpi4c--
