Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE493A5A51
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhFMUUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:20:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:59385 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhFMUUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:20:07 -0400
IronPort-SDR: ybTAo/EU0W9WCcp1XmXskrQ8XCJz1z1CxuRbhnJjhulyfE6b6IESMdqBABnA36dkM3GRtwZ3ie
 l1AIL32WohFw==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="266885899"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="266885899"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 13:18:04 -0700
IronPort-SDR: qGFDp6/JCwwfJVFYdB93tKE7wKthX74qsnbxoLgG/JbqhH2olh2dkFpZ1UC2pwIoMHEi9JEGcl
 uB56IyUXRUQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="553918432"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 13 Jun 2021 13:18:00 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsWYU-0001Ug-5u; Sun, 13 Jun 2021 20:18:02 +0000
Date:   Mon, 14 Jun 2021 04:17:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 16/364] include/linux/compiler_types.h:140:35: error:
 'struct task_struct' has no member named 'thread_info'
Message-ID: <202106140452.nsaAOzTj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: afd3aae51f9e55c5e72f86f9344a7e73aa1039f1 [16/364] sched/headers: Move task->thread_info to per_task()
config: riscv-nommu_k210_defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=afd3aae51f9e55c5e72f86f9344a7e73aa1039f1
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout afd3aae51f9e55c5e72f86f9344a7e73aa1039f1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:18,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/asm-generic/preempt.h: In function 'preempt_count_ptr':
   include/asm-generic/preempt.h:16:31: error: invalid type argument of '->' (have 'int')
      16 |  return &current_thread_info()->preempt_count;
         |                               ^~
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:85,
                    from <command-line>:
   include/asm-generic/mmiowb.h: In function 'mmiowb_set_pending':
   arch/riscv/include/asm/smp.h:61:54: error: invalid type argument of '->' (have 'int')
      61 | #define raw_smp_processor_id() (current_thread_info()->cpu)
         |                                                      ^~
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
      35 |  (typeof(ptr)) (__ptr + (off));     \
         |                          ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |  arch_raw_cpu_ptr(ptr);      \
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:26: note: in expansion of macro 'raw_cpu_ptr'
      30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
         |                          ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:37:28: note: in expansion of macro '__mmiowb_state'
      37 |  struct mmiowb_state *ms = __mmiowb_state();
         |                            ^~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h: In function 'mmiowb_spin_lock':
   arch/riscv/include/asm/smp.h:61:54: error: invalid type argument of '->' (have 'int')
      61 | #define raw_smp_processor_id() (current_thread_info()->cpu)
         |                                                      ^~
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
      35 |  (typeof(ptr)) (__ptr + (off));     \
         |                          ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |  arch_raw_cpu_ptr(ptr);      \
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:26: note: in expansion of macro 'raw_cpu_ptr'
      30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
         |                          ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:45:28: note: in expansion of macro '__mmiowb_state'
      45 |  struct mmiowb_state *ms = __mmiowb_state();
         |                            ^~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h: In function 'mmiowb_spin_unlock':
   arch/riscv/include/asm/smp.h:61:54: error: invalid type argument of '->' (have 'int')
      61 | #define raw_smp_processor_id() (current_thread_info()->cpu)
         |                                                      ^~
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
      35 |  (typeof(ptr)) (__ptr + (off));     \
         |                          ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |  arch_raw_cpu_ptr(ptr);      \
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:26: note: in expansion of macro 'raw_cpu_ptr'
      30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
         |                          ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:51:28: note: in expansion of macro '__mmiowb_state'
      51 |  struct mmiowb_state *ms = __mmiowb_state();
         |                            ^~~~~~~~~~~~~~
   In file included from arch/riscv/kernel/asm-offsets.c:9:
   arch/riscv/kernel/asm-offsets.c: In function 'asm_offsets':
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:32:2: note: in expansion of macro 'OFFSET'
      32 |  OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:33:2: note: in expansion of macro 'OFFSET'
      33 |  OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:34:2: note: in expansion of macro 'OFFSET'
      34 |  OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:35:2: note: in expansion of macro 'OFFSET'
      35 |  OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:36:2: note: in expansion of macro 'OFFSET'
      36 |  OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
         |  ^~~~~~
   cc1: some warnings being treated as errors
--
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:18,
                    from arch/riscv/kernel/asm-offsets.c:10:
   include/asm-generic/preempt.h: In function 'preempt_count_ptr':
   include/asm-generic/preempt.h:16:31: error: invalid type argument of '->' (have 'int')
      16 |  return &current_thread_info()->preempt_count;
         |                               ^~
   include/asm-generic/preempt.h: In function '__preempt_count_dec_and_test':
   include/asm-generic/preempt.h:69:36: error: implicit declaration of function 'tif_need_resched' [-Werror=implicit-function-declaration]
      69 |  return !--*preempt_count_ptr() && tif_need_resched();
         |                                    ^~~~~~~~~~~~~~~~
   In file included from include/linux/compiler_types.h:85,
                    from <command-line>:
   include/asm-generic/mmiowb.h: In function 'mmiowb_set_pending':
   arch/riscv/include/asm/smp.h:61:54: error: invalid type argument of '->' (have 'int')
      61 | #define raw_smp_processor_id() (current_thread_info()->cpu)
         |                                                      ^~
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
      35 |  (typeof(ptr)) (__ptr + (off));     \
         |                          ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |  arch_raw_cpu_ptr(ptr);      \
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:26: note: in expansion of macro 'raw_cpu_ptr'
      30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
         |                          ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:37:28: note: in expansion of macro '__mmiowb_state'
      37 |  struct mmiowb_state *ms = __mmiowb_state();
         |                            ^~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h: In function 'mmiowb_spin_lock':
   arch/riscv/include/asm/smp.h:61:54: error: invalid type argument of '->' (have 'int')
      61 | #define raw_smp_processor_id() (current_thread_info()->cpu)
         |                                                      ^~
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
      35 |  (typeof(ptr)) (__ptr + (off));     \
         |                          ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |  arch_raw_cpu_ptr(ptr);      \
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:26: note: in expansion of macro 'raw_cpu_ptr'
      30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
         |                          ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:45:28: note: in expansion of macro '__mmiowb_state'
      45 |  struct mmiowb_state *ms = __mmiowb_state();
         |                            ^~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h: In function 'mmiowb_spin_unlock':
   arch/riscv/include/asm/smp.h:61:54: error: invalid type argument of '->' (have 'int')
      61 | #define raw_smp_processor_id() (current_thread_info()->cpu)
         |                                                      ^~
   include/linux/compiler-gcc.h:35:26: note: in definition of macro 'RELOC_HIDE'
      35 |  (typeof(ptr)) (__ptr + (off));     \
         |                          ^~~
   include/asm-generic/percpu.h:44:31: note: in expansion of macro 'SHIFT_PERCPU_PTR'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                               ^~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:25: note: in expansion of macro 'per_cpu_offset'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                         ^~~~~~~~~~~~~~
   include/asm-generic/percpu.h:31:40: note: in expansion of macro 'raw_smp_processor_id'
      31 | #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
         |                                        ^~~~~~~~~~~~~~~~~~~~
   include/asm-generic/percpu.h:44:53: note: in expansion of macro '__my_cpu_offset'
      44 | #define arch_raw_cpu_ptr(ptr) SHIFT_PERCPU_PTR(ptr, __my_cpu_offset)
         |                                                     ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:242:2: note: in expansion of macro 'arch_raw_cpu_ptr'
     242 |  arch_raw_cpu_ptr(ptr);      \
         |  ^~~~~~~~~~~~~~~~
   include/asm-generic/mmiowb.h:30:26: note: in expansion of macro 'raw_cpu_ptr'
      30 | #define __mmiowb_state() raw_cpu_ptr(&__mmiowb_state)
         |                          ^~~~~~~~~~~
   include/asm-generic/mmiowb.h:51:28: note: in expansion of macro '__mmiowb_state'
      51 |  struct mmiowb_state *ms = __mmiowb_state();
         |                            ^~~~~~~~~~~~~~
   In file included from arch/riscv/kernel/asm-offsets.c:9:
   arch/riscv/kernel/asm-offsets.c: In function 'asm_offsets':
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:32:2: note: in expansion of macro 'OFFSET'
      32 |  OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:33:2: note: in expansion of macro 'OFFSET'
      33 |  OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:34:2: note: in expansion of macro 'OFFSET'
      34 |  OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:35:2: note: in expansion of macro 'OFFSET'
      35 |  OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
         |  ^~~~~~
>> include/linux/compiler_types.h:140:35: error: 'struct task_struct' has no member named 'thread_info'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                   ^~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:6:62: note: in definition of macro 'DEFINE'
       6 |  asm volatile("\n.ascii \"->" #sym " %0 " #val "\"" : : "i" (val))
         |                                                              ^~~
   include/linux/stddef.h:17:32: note: in expansion of macro '__compiler_offsetof'
      17 | #define offsetof(TYPE, MEMBER) __compiler_offsetof(TYPE, MEMBER)
         |                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kbuild.h:11:14: note: in expansion of macro 'offsetof'
      11 |  DEFINE(sym, offsetof(struct str, mem))
         |              ^~~~~~~~
   arch/riscv/kernel/asm-offsets.c:36:2: note: in expansion of macro 'OFFSET'
      36 |  OFFSET(TASK_TI_CPU, task_struct, thread_info.cpu);
         |  ^~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:117: arch/riscv/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1232: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +140 include/linux/compiler_types.h

71391bdd2e9aab Xiaozhou Liu 2018-12-14  139  
71391bdd2e9aab Xiaozhou Liu 2018-12-14 @140  #define __compiler_offsetof(a, b)	__builtin_offsetof(a, b)
71391bdd2e9aab Xiaozhou Liu 2018-12-14  141  

:::::: The code at line 140 was first introduced by commit
:::::: 71391bdd2e9aab188f86bf1ecd9b232531ec7eea include/linux/compiler_types.h: don't pollute userspace with macro definitions

:::::: TO: Xiaozhou Liu <liuxiaozhou@bytedance.com>
:::::: CC: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--
