Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E384A45D3B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 04:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbhKYDpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 22:45:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:45293 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239927AbhKYDna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 22:43:30 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="234163484"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="234163484"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 19:40:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="675082505"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 19:40:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq5cO-0005iU-K5; Thu, 25 Nov 2021 03:40:16 +0000
Date:   Thu, 25 Nov 2021 11:39:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, rth@twiddle.net
Cc:     kbuild-all@lists.01.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] mm: Fix warning comparing pointer to 0
Message-ID: <202111251151.p23HabxR-lkp@intel.com>
References: <1637748818-21730-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637748818-21730-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Jiapeng-Chong/mm-Fix-warning-comparing-pointer-to-0/20211124-181519
base:   https://github.com/hnaz/linux-mm master
config: alpha-randconfig-r021-20211124 (https://download.01.org/0day-ci/archive/20211125/202111251151.p23HabxR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/60f2c3a3b475b791c9d450b7bf64016757bf6959
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jiapeng-Chong/mm-Fix-warning-comparing-pointer-to-0/20211124-181519
        git checkout 60f2c3a3b475b791c9d450b7bf64016757bf6959
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/alpha/mm/fault.c:85:1: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
      85 | do_page_fault(unsigned long address, unsigned long mmcsr,
         | ^~~~~~~~~~~~~
   arch/alpha/mm/fault.c: In function 'do_page_fault':
>> arch/alpha/mm/fault.c:195:57: error: expected ')' before '{' token
     195 |         if (!(fixup = search_exception_tables(regs->pc)) {
         |            ~                                            ^~
         |                                                         )
>> arch/alpha/mm/fault.c:250:1: error: expected expression before '}' token
     250 | }
         | ^
>> arch/alpha/mm/fault.c:191:17: error: label 'do_sigsegv' used but not defined
     191 |                 goto do_sigsegv;
         |                 ^~~~
>> arch/alpha/mm/fault.c:164:25: error: label 'do_sigbus' used but not defined
     164 |                         goto do_sigbus;
         |                         ^~~~
>> arch/alpha/mm/fault.c:160:25: error: label 'out_of_memory' used but not defined
     160 |                         goto out_of_memory;
         |                         ^~~~
>> arch/alpha/mm/fault.c:91:13: error: variable 'si_code' set but not used [-Werror=unused-but-set-variable]
      91 |         int si_code = SEGV_MAPERR;
         |             ^~~~~~~
   cc1: all warnings being treated as errors


vim +195 arch/alpha/mm/fault.c

    56	
    57	
    58	/*
    59	 * This routine handles page faults.  It determines the address,
    60	 * and the problem, and then passes it off to handle_mm_fault().
    61	 *
    62	 * mmcsr:
    63	 *	0 = translation not valid
    64	 *	1 = access violation
    65	 *	2 = fault-on-read
    66	 *	3 = fault-on-execute
    67	 *	4 = fault-on-write
    68	 *
    69	 * cause:
    70	 *	-1 = instruction fetch
    71	 *	0 = load
    72	 *	1 = store
    73	 *
    74	 * Registers $9 through $15 are saved in a block just prior to `regs' and
    75	 * are saved and restored around the call to allow exception code to
    76	 * modify them.
    77	 */
    78	
    79	/* Macro for exception fixup code to access integer registers.  */
    80	#define dpf_reg(r)							\
    81		(((unsigned long *)regs)[(r) <= 8 ? (r) : (r) <= 15 ? (r)-16 :	\
    82					 (r) <= 18 ? (r)+10 : (r)-10])
    83	
    84	asmlinkage void
    85	do_page_fault(unsigned long address, unsigned long mmcsr,
    86		      long cause, struct pt_regs *regs)
    87	{
    88		struct vm_area_struct * vma;
    89		struct mm_struct *mm = current->mm;
    90		const struct exception_table_entry *fixup;
  > 91		int si_code = SEGV_MAPERR;
    92		vm_fault_t fault;
    93		unsigned int flags = FAULT_FLAG_DEFAULT;
    94	
    95		/* As of EV6, a load into $31/$f31 is a prefetch, and never faults
    96		   (or is suppressed by the PALcode).  Support that for older CPUs
    97		   by ignoring such an instruction.  */
    98		if (cause == 0) {
    99			unsigned int insn;
   100			__get_user(insn, (unsigned int __user *)regs->pc);
   101			if ((insn >> 21 & 0x1f) == 0x1f &&
   102			    /* ldq ldl ldt lds ldg ldf ldwu ldbu */
   103			    (1ul << (insn >> 26) & 0x30f00001400ul)) {
   104				regs->pc += 4;
   105				return;
   106			}
   107		}
   108	
   109		/* If we're in an interrupt context, or have no user context,
   110		   we must not take the fault.  */
   111		if (!mm || faulthandler_disabled())
   112			goto no_context;
   113	
   114	#ifdef CONFIG_ALPHA_LARGE_VMALLOC
   115		if (address >= TASK_SIZE)
   116			goto vmalloc_fault;
   117	#endif
   118		if (user_mode(regs))
   119			flags |= FAULT_FLAG_USER;
   120		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
   121	retry:
   122		mmap_read_lock(mm);
   123		vma = find_vma(mm, address);
   124		if (!vma)
   125			goto bad_area;
   126		if (vma->vm_start <= address)
   127			goto good_area;
   128		if (!(vma->vm_flags & VM_GROWSDOWN))
   129			goto bad_area;
   130		if (expand_stack(vma, address))
   131			goto bad_area;
   132	
   133		/* Ok, we have a good vm_area for this memory access, so
   134		   we can handle it.  */
   135	 good_area:
   136		si_code = SEGV_ACCERR;
   137		if (cause < 0) {
   138			if (!(vma->vm_flags & VM_EXEC))
   139				goto bad_area;
   140		} else if (!cause) {
   141			/* Allow reads even for write-only mappings */
   142			if (!(vma->vm_flags & (VM_READ | VM_WRITE)))
   143				goto bad_area;
   144		} else {
   145			if (!(vma->vm_flags & VM_WRITE))
   146				goto bad_area;
   147			flags |= FAULT_FLAG_WRITE;
   148		}
   149	
   150		/* If for any reason at all we couldn't handle the fault,
   151		   make sure we exit gracefully rather than endlessly redo
   152		   the fault.  */
   153		fault = handle_mm_fault(vma, address, flags, regs);
   154	
   155		if (fault_signal_pending(fault, regs))
   156			return;
   157	
   158		if (unlikely(fault & VM_FAULT_ERROR)) {
   159			if (fault & VM_FAULT_OOM)
 > 160				goto out_of_memory;
   161			else if (fault & VM_FAULT_SIGSEGV)
   162				goto bad_area;
   163			else if (fault & VM_FAULT_SIGBUS)
 > 164				goto do_sigbus;
   165			BUG();
   166		}
   167	
   168		if (flags & FAULT_FLAG_ALLOW_RETRY) {
   169			if (fault & VM_FAULT_RETRY) {
   170				flags |= FAULT_FLAG_TRIED;
   171	
   172				 /* No need to mmap_read_unlock(mm) as we would
   173				 * have already released it in __lock_page_or_retry
   174				 * in mm/filemap.c.
   175				 */
   176	
   177				goto retry;
   178			}
   179		}
   180	
   181		mmap_read_unlock(mm);
   182	
   183		return;
   184	
   185		/* Something tried to access memory that isn't in our memory map.
   186		   Fix it, but check if it's kernel or user first.  */
   187	 bad_area:
   188		mmap_read_unlock(mm);
   189	
   190		if (user_mode(regs))
 > 191			goto do_sigsegv;
   192	
   193	 no_context:
   194		/* Are we prepared to handle this fault as an exception?  */
 > 195		if (!(fixup = search_exception_tables(regs->pc)) {
   196			unsigned long newpc;
   197			newpc = fixup_exception(dpf_reg, fixup, regs->pc);
   198			regs->pc = newpc;
   199			return;
   200		}
   201	
   202		/* Oops. The kernel tried to access some bad page. We'll have to
   203		   terminate things with extreme prejudice.  */
   204		printk(KERN_ALERT "Unable to handle kernel paging request at "
   205		       "virtual address %016lx\n", address);
   206		die_if_kernel("Oops", regs, cause, (unsigned long*)regs - 16);
   207		do_exit(SIGKILL);
   208	
   209		/* We ran out of memory, or some other thing happened to us that
   210		   made us unable to handle the page fault gracefully.  */
   211	 out_of_memory:
   212		mmap_read_unlock(mm);
   213		if (!user_mode(regs))
   214			goto no_context;
   215		pagefault_out_of_memory();
   216		return;
   217	
   218	 do_sigbus:
   219		mmap_read_unlock(mm);
   220		/* Send a sigbus, regardless of whether we were in kernel
   221		   or user mode.  */
   222		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) address);
   223		if (!user_mode(regs))
   224			goto no_context;
   225		return;
   226	
   227	 do_sigsegv:
   228		force_sig_fault(SIGSEGV, si_code, (void __user *) address);
   229		return;
   230	
   231	#ifdef CONFIG_ALPHA_LARGE_VMALLOC
   232	 vmalloc_fault:
   233		if (user_mode(regs))
   234			goto do_sigsegv;
   235		else {
   236			/* Synchronize this task's top level page-table
   237			   with the "reference" page table from init.  */
   238			long index = pgd_index(address);
   239			pgd_t *pgd, *pgd_k;
   240	
   241			pgd = current->active_mm->pgd + index;
   242			pgd_k = swapper_pg_dir + index;
   243			if (!pgd_present(*pgd) && pgd_present(*pgd_k)) {
   244				pgd_val(*pgd) = pgd_val(*pgd_k);
   245				return;
   246			}
   247			goto no_context;
   248		}
   249	#endif
 > 250	}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
