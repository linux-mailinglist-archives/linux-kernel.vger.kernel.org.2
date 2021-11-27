Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2906445FC44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 04:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351295AbhK0DJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 22:09:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:11299 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234464AbhK0DHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 22:07:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="222607251"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="222607251"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 19:04:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="608035875"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Nov 2021 19:04:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqo0s-0008yx-UR; Sat, 27 Nov 2021 03:04:30 +0000
Date:   Sat, 27 Nov 2021 11:03:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [tip:core/entry 9/11] arch/powerpc/kernel/interrupt.c:151:64: error:
 passing argument 2 of 'set_bits' makes pointer from integer without a cast
Message-ID: <202111271105.v7pE3REd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
head:   5796ee48d26a18930a8b86fb865ba195282889d0
commit: 51ed65dcfd9c61a15920a40178d471d236a7514c [9/11] powerpc: Avoid discarding flags in system_call_exception()
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20211127/202111271105.v7pE3REd-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=51ed65dcfd9c61a15920a40178d471d236a7514c
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip core/entry
        git checkout 51ed65dcfd9c61a15920a40178d471d236a7514c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/kernel/interrupt.c: In function 'system_call_exception':
>> arch/powerpc/kernel/interrupt.c:151:64: error: passing argument 2 of 'set_bits' makes pointer from integer without a cast [-Werror=int-conversion]
     151 |                 set_bits(_TIF_RESTOREALL, current_thread_info()->flags);
   In file included from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/powerpc/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from arch/powerpc/include/asm/ptrace.h:323,
                    from arch/powerpc/include/asm/hw_irq.h:12,
                    from arch/powerpc/include/asm/irqflags.h:12,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/powerpc/include/asm/cmpxchg.h:526,
                    from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/context_tracking.h:5,
                    from arch/powerpc/kernel/interrupt.c:3:
   arch/powerpc/include/asm/bitops.h:67:41: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
      67 |                 volatile unsigned long *_p)     \
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~
   arch/powerpc/include/asm/bitops.h:82:1: note: in expansion of macro 'DEFINE_BITOP'
      82 | DEFINE_BITOP(set_bits, or, "")
         | ^~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/set_bits +151 arch/powerpc/kernel/interrupt.c

    76	
    77	/* Has to run notrace because it is entered not completely "reconciled" */
    78	notrace long system_call_exception(long r3, long r4, long r5,
    79					   long r6, long r7, long r8,
    80					   unsigned long r0, struct pt_regs *regs)
    81	{
    82		syscall_fn f;
    83	
    84		kuep_lock();
    85	
    86		regs->orig_gpr3 = r3;
    87	
    88		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
    89			BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
    90	
    91		trace_hardirqs_off(); /* finish reconciling */
    92	
    93		CT_WARN_ON(ct_state() == CONTEXT_KERNEL);
    94		user_exit_irqoff();
    95	
    96		BUG_ON(regs_is_unrecoverable(regs));
    97		BUG_ON(!(regs->msr & MSR_PR));
    98		BUG_ON(arch_irq_disabled_regs(regs));
    99	
   100	#ifdef CONFIG_PPC_PKEY
   101		if (mmu_has_feature(MMU_FTR_PKEY)) {
   102			unsigned long amr, iamr;
   103			bool flush_needed = false;
   104			/*
   105			 * When entering from userspace we mostly have the AMR/IAMR
   106			 * different from kernel default values. Hence don't compare.
   107			 */
   108			amr = mfspr(SPRN_AMR);
   109			iamr = mfspr(SPRN_IAMR);
   110			regs->amr  = amr;
   111			regs->iamr = iamr;
   112			if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
   113				mtspr(SPRN_AMR, AMR_KUAP_BLOCKED);
   114				flush_needed = true;
   115			}
   116			if (mmu_has_feature(MMU_FTR_BOOK3S_KUEP)) {
   117				mtspr(SPRN_IAMR, AMR_KUEP_BLOCKED);
   118				flush_needed = true;
   119			}
   120			if (flush_needed)
   121				isync();
   122		} else
   123	#endif
   124			kuap_assert_locked();
   125	
   126		booke_restore_dbcr0();
   127	
   128		account_cpu_user_entry();
   129	
   130		account_stolen_time();
   131	
   132		/*
   133		 * This is not required for the syscall exit path, but makes the
   134		 * stack frame look nicer. If this was initialised in the first stack
   135		 * frame, or if the unwinder was taught the first stack frame always
   136		 * returns to user with IRQS_ENABLED, this store could be avoided!
   137		 */
   138		irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
   139	
   140		/*
   141		 * If system call is called with TM active, set _TIF_RESTOREALL to
   142		 * prevent RFSCV being used to return to userspace, because POWER9
   143		 * TM implementation has problems with this instruction returning to
   144		 * transactional state. Final register values are not relevant because
   145		 * the transaction will be aborted upon return anyway. Or in the case
   146		 * of unsupported_scv SIGILL fault, the return state does not much
   147		 * matter because it's an edge case.
   148		 */
   149		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
   150				unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
 > 151			set_bits(_TIF_RESTOREALL, current_thread_info()->flags);
   152	
   153		/*
   154		 * If the system call was made with a transaction active, doom it and
   155		 * return without performing the system call. Unless it was an
   156		 * unsupported scv vector, in which case it's treated like an illegal
   157		 * instruction.
   158		 */
   159	#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
   160		if (unlikely(MSR_TM_TRANSACTIONAL(regs->msr)) &&
   161		    !trap_is_unsupported_scv(regs)) {
   162			/* Enable TM in the kernel, and disable EE (for scv) */
   163			hard_irq_disable();
   164			mtmsr(mfmsr() | MSR_TM);
   165	
   166			/* tabort, this dooms the transaction, nothing else */
   167			asm volatile(".long 0x7c00071d | ((%0) << 16)"
   168					:: "r"(TM_CAUSE_SYSCALL|TM_CAUSE_PERSISTENT));
   169	
   170			/*
   171			 * Userspace will never see the return value. Execution will
   172			 * resume after the tbegin. of the aborted transaction with the
   173			 * checkpointed register state. A context switch could occur
   174			 * or signal delivered to the process before resuming the
   175			 * doomed transaction context, but that should all be handled
   176			 * as expected.
   177			 */
   178			return -ENOSYS;
   179		}
   180	#endif // CONFIG_PPC_TRANSACTIONAL_MEM
   181	
   182		local_irq_enable();
   183	
   184		if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
   185			if (unlikely(trap_is_unsupported_scv(regs))) {
   186				/* Unsupported scv vector */
   187				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
   188				return regs->gpr[3];
   189			}
   190			/*
   191			 * We use the return value of do_syscall_trace_enter() as the
   192			 * syscall number. If the syscall was rejected for any reason
   193			 * do_syscall_trace_enter() returns an invalid syscall number
   194			 * and the test against NR_syscalls will fail and the return
   195			 * value to be used is in regs->gpr[3].
   196			 */
   197			r0 = do_syscall_trace_enter(regs);
   198			if (unlikely(r0 >= NR_syscalls))
   199				return regs->gpr[3];
   200			r3 = regs->gpr[3];
   201			r4 = regs->gpr[4];
   202			r5 = regs->gpr[5];
   203			r6 = regs->gpr[6];
   204			r7 = regs->gpr[7];
   205			r8 = regs->gpr[8];
   206	
   207		} else if (unlikely(r0 >= NR_syscalls)) {
   208			if (unlikely(trap_is_unsupported_scv(regs))) {
   209				/* Unsupported scv vector */
   210				_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
   211				return regs->gpr[3];
   212			}
   213			return -ENOSYS;
   214		}
   215	
   216		/* May be faster to do array_index_nospec? */
   217		barrier_nospec();
   218	
   219		if (unlikely(is_compat_task())) {
   220			f = (void *)compat_sys_call_table[r0];
   221	
   222			r3 &= 0x00000000ffffffffULL;
   223			r4 &= 0x00000000ffffffffULL;
   224			r5 &= 0x00000000ffffffffULL;
   225			r6 &= 0x00000000ffffffffULL;
   226			r7 &= 0x00000000ffffffffULL;
   227			r8 &= 0x00000000ffffffffULL;
   228	
   229		} else {
   230			f = (void *)sys_call_table[r0];
   231		}
   232	
   233		return f(r3, r4, r5, r6, r7, r8);
   234	}
   235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
