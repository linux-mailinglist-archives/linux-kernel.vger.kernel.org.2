Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5515534D98B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhC2V3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:29:41 -0400
Received: from mga05.intel.com ([192.55.52.43]:27861 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230100AbhC2V3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:29:18 -0400
IronPort-SDR: A+G5Vb0XQyocSCLOUv+uGhZekNw15mkQi+Z2/TILXZFU/fHUPnfTxJ2t/uJgHce6p60sLN9rvm
 GVS4j/+nL+Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="276796380"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="gz'50?scan'50,208,50";a="276796380"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 14:29:17 -0700
IronPort-SDR: BUwEXYbluwM848ON0oyU6VdSuQ14al0t3BchOvpsYRvmQx9IwFP52fMRW7s51TrcF67FYV+WIF
 ob7/L9RmMp7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="gz'50?scan'50,208,50";a="378255049"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 29 Mar 2021 14:29:14 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQzRh-0004oI-NQ; Mon, 29 Mar 2021 21:29:13 +0000
Date:   Tue, 30 Mar 2021 05:28:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Pei Huang <huangpei@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: arch/mips/loongson64/cop2-ex.c:97:29: error: 'struct thread_struct'
 has no member named 'fpu'
Message-ID: <202103300539.GrrsCbIs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Huacai,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1e43c377a79f9189fea8f2711b399d4e8b4e609b
commit: f83e4f9896eff614d0f2547a561fa5f39f9cddde MIPS: Loongson-3: Add some unaligned instructions emulation
date:   11 months ago
config: mips-randconfig-r015-20210330 (attached as .config)
compiler: mips64el-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f83e4f9896eff614d0f2547a561fa5f39f9cddde
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f83e4f9896eff614d0f2547a561fa5f39f9cddde
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/mips/loongson64/cop2-ex.c: In function 'loongson_cu2_call':
   arch/mips/loongson64/cop2-ex.c:44:15: error: implicit declaration of function '__is_fpu_owner'; did you mean 'is_fpu_owner'? [-Werror=implicit-function-declaration]
      44 |   fpu_owned = __is_fpu_owner();
         |               ^~~~~~~~~~~~~~
         |               is_fpu_owner
>> arch/mips/loongson64/cop2-ex.c:97:29: error: 'struct thread_struct' has no member named 'fpu'
      97 |    set_fpr64(current->thread.fpu.fpr,
         |                             ^
   arch/mips/loongson64/cop2-ex.c:99:29: error: 'struct thread_struct' has no member named 'fpu'
      99 |    set_fpr64(current->thread.fpu.fpr,
         |                             ^
   arch/mips/loongson64/cop2-ex.c:132:42: error: 'struct thread_struct' has no member named 'fpu'
     132 |    value_next = get_fpr64(current->thread.fpu.fpr,
         |                                          ^
   arch/mips/loongson64/cop2-ex.c:139:37: error: 'struct thread_struct' has no member named 'fpu'
     139 |    value = get_fpr64(current->thread.fpu.fpr,
         |                                     ^
   arch/mips/loongson64/cop2-ex.c:206:29: error: 'struct thread_struct' has no member named 'fpu'
     206 |    set_fpr64(current->thread.fpu.fpr,
         |                             ^
   arch/mips/loongson64/cop2-ex.c:223:29: error: 'struct thread_struct' has no member named 'fpu'
     223 |    set_fpr64(current->thread.fpu.fpr,
         |                             ^
   arch/mips/loongson64/cop2-ex.c:288:37: error: 'struct thread_struct' has no member named 'fpu'
     288 |    value = get_fpr64(current->thread.fpu.fpr,
         |                                     ^
   arch/mips/loongson64/cop2-ex.c:307:37: error: 'struct thread_struct' has no member named 'fpu'
     307 |    value = get_fpr64(current->thread.fpu.fpr,
         |                                     ^
   cc1: some warnings being treated as errors


vim +97 arch/mips/loongson64/cop2-ex.c

    26	
    27	static int loongson_cu2_call(struct notifier_block *nfb, unsigned long action,
    28		void *data)
    29	{
    30		unsigned int res, fpu_owned;
    31		unsigned long ra, value, value_next;
    32		union mips_instruction insn;
    33		int fr = !test_thread_flag(TIF_32BIT_FPREGS);
    34		struct pt_regs *regs = (struct pt_regs *)data;
    35		void __user *addr = (void __user *)regs->cp0_badvaddr;
    36		unsigned int __user *pc = (unsigned int __user *)exception_epc(regs);
    37	
    38		ra = regs->regs[31];
    39		__get_user(insn.word, pc);
    40	
    41		switch (action) {
    42		case CU2_EXCEPTION:
    43			preempt_disable();
  > 44			fpu_owned = __is_fpu_owner();
    45			if (!fr)
    46				set_c0_status(ST0_CU1 | ST0_CU2);
    47			else
    48				set_c0_status(ST0_CU1 | ST0_CU2 | ST0_FR);
    49			enable_fpu_hazard();
    50			KSTK_STATUS(current) |= (ST0_CU1 | ST0_CU2);
    51			if (fr)
    52				KSTK_STATUS(current) |= ST0_FR;
    53			else
    54				KSTK_STATUS(current) &= ~ST0_FR;
    55			/* If FPU is owned, we needn't init or restore fp */
    56			if (!fpu_owned) {
    57				set_thread_flag(TIF_USEDFPU);
    58				init_fp_ctx(current);
    59				_restore_fp(current);
    60			}
    61			preempt_enable();
    62	
    63			return NOTIFY_STOP;	/* Don't call default notifier */
    64	
    65		case CU2_LWC2_OP:
    66			if (insn.loongson3_lswc2_format.ls == 0)
    67				goto sigbus;
    68	
    69			if (insn.loongson3_lswc2_format.fr == 0) {	/* gslq */
    70				if (!access_ok(addr, 16))
    71					goto sigbus;
    72	
    73				LoadDW(addr, value, res);
    74				if (res)
    75					goto fault;
    76	
    77				LoadDW(addr + 8, value_next, res);
    78				if (res)
    79					goto fault;
    80	
    81				regs->regs[insn.loongson3_lswc2_format.rt] = value;
    82				regs->regs[insn.loongson3_lswc2_format.rq] = value_next;
    83				compute_return_epc(regs);
    84			} else {					/* gslqc1 */
    85				if (!access_ok(addr, 16))
    86					goto sigbus;
    87	
    88				lose_fpu(1);
    89				LoadDW(addr, value, res);
    90				if (res)
    91					goto fault;
    92	
    93				LoadDW(addr + 8, value_next, res);
    94				if (res)
    95					goto fault;
    96	
  > 97				set_fpr64(current->thread.fpu.fpr,
    98					insn.loongson3_lswc2_format.rt, value);
    99				set_fpr64(current->thread.fpu.fpr,
   100					insn.loongson3_lswc2_format.rq, value_next);
   101				compute_return_epc(regs);
   102				own_fpu(1);
   103			}
   104			return NOTIFY_STOP;	/* Don't call default notifier */
   105	
   106		case CU2_SWC2_OP:
   107			if (insn.loongson3_lswc2_format.ls == 0)
   108				goto sigbus;
   109	
   110			if (insn.loongson3_lswc2_format.fr == 0) {	/* gssq */
   111				if (!access_ok(addr, 16))
   112					goto sigbus;
   113	
   114				/* write upper 8 bytes first */
   115				value_next = regs->regs[insn.loongson3_lswc2_format.rq];
   116	
   117				StoreDW(addr + 8, value_next, res);
   118				if (res)
   119					goto fault;
   120				value = regs->regs[insn.loongson3_lswc2_format.rt];
   121	
   122				StoreDW(addr, value, res);
   123				if (res)
   124					goto fault;
   125	
   126				compute_return_epc(regs);
   127			} else {					/* gssqc1 */
   128				if (!access_ok(addr, 16))
   129					goto sigbus;
   130	
   131				lose_fpu(1);
   132				value_next = get_fpr64(current->thread.fpu.fpr,
   133						insn.loongson3_lswc2_format.rq);
   134	
   135				StoreDW(addr + 8, value_next, res);
   136				if (res)
   137					goto fault;
   138	
   139				value = get_fpr64(current->thread.fpu.fpr,
   140						insn.loongson3_lswc2_format.rt);
   141	
   142				StoreDW(addr, value, res);
   143				if (res)
   144					goto fault;
   145	
   146				compute_return_epc(regs);
   147				own_fpu(1);
   148			}
   149			return NOTIFY_STOP;	/* Don't call default notifier */
   150	
   151		case CU2_LDC2_OP:
   152			switch (insn.loongson3_lsdc2_format.opcode1) {
   153			/*
   154			 * Loongson-3 overridden ldc2 instructions.
   155			 * opcode1              instruction
   156			 *   0x1          gslhx: load 2 bytes to GPR
   157			 *   0x2          gslwx: load 4 bytes to GPR
   158			 *   0x3          gsldx: load 8 bytes to GPR
   159			 *   0x6	  gslwxc1: load 4 bytes to FPR
   160			 *   0x7	  gsldxc1: load 8 bytes to FPR
   161			 */
   162			case 0x1:
   163				if (!access_ok(addr, 2))
   164					goto sigbus;
   165	
   166				LoadHW(addr, value, res);
   167				if (res)
   168					goto fault;
   169	
   170				compute_return_epc(regs);
   171				regs->regs[insn.loongson3_lsdc2_format.rt] = value;
   172				break;
   173			case 0x2:
   174				if (!access_ok(addr, 4))
   175					goto sigbus;
   176	
   177				LoadW(addr, value, res);
   178				if (res)
   179					goto fault;
   180	
   181				compute_return_epc(regs);
   182				regs->regs[insn.loongson3_lsdc2_format.rt] = value;
   183				break;
   184			case 0x3:
   185				if (!access_ok(addr, 8))
   186					goto sigbus;
   187	
   188				LoadDW(addr, value, res);
   189				if (res)
   190					goto fault;
   191	
   192				compute_return_epc(regs);
   193				regs->regs[insn.loongson3_lsdc2_format.rt] = value;
   194				break;
   195			case 0x6:
   196				die_if_kernel("Unaligned FP access in kernel code", regs);
   197				BUG_ON(!used_math());
   198				if (!access_ok(addr, 4))
   199					goto sigbus;
   200	
   201				lose_fpu(1);
   202				LoadW(addr, value, res);
   203				if (res)
   204					goto fault;
   205	
   206				set_fpr64(current->thread.fpu.fpr,
   207						insn.loongson3_lsdc2_format.rt, value);
   208				compute_return_epc(regs);
   209				own_fpu(1);
   210	
   211				break;
   212			case 0x7:
   213				die_if_kernel("Unaligned FP access in kernel code", regs);
   214				BUG_ON(!used_math());
   215				if (!access_ok(addr, 8))
   216					goto sigbus;
   217	
   218				lose_fpu(1);
   219				LoadDW(addr, value, res);
   220				if (res)
   221					goto fault;
   222	
   223				set_fpr64(current->thread.fpu.fpr,
   224						insn.loongson3_lsdc2_format.rt, value);
   225				compute_return_epc(regs);
   226				own_fpu(1);
   227				break;
   228	
   229			}
   230			return NOTIFY_STOP;	/* Don't call default notifier */
   231	
   232		case CU2_SDC2_OP:
   233			switch (insn.loongson3_lsdc2_format.opcode1) {
   234			/*
   235			 * Loongson-3 overridden sdc2 instructions.
   236			 * opcode1              instruction
   237			 *   0x1          gsshx: store 2 bytes from GPR
   238			 *   0x2          gsswx: store 4 bytes from GPR
   239			 *   0x3          gssdx: store 8 bytes from GPR
   240			 *   0x6          gsswxc1: store 4 bytes from FPR
   241			 *   0x7          gssdxc1: store 8 bytes from FPR
   242			 */
   243			case 0x1:
   244				if (!access_ok(addr, 2))
   245					goto sigbus;
   246	
   247				compute_return_epc(regs);
   248				value = regs->regs[insn.loongson3_lsdc2_format.rt];
   249	
   250				StoreHW(addr, value, res);
   251				if (res)
   252					goto fault;
   253	
   254				break;
   255			case 0x2:
   256				if (!access_ok(addr, 4))
   257					goto sigbus;
   258	
   259				compute_return_epc(regs);
   260				value = regs->regs[insn.loongson3_lsdc2_format.rt];
   261	
   262				StoreW(addr, value, res);
   263				if (res)
   264					goto fault;
   265	
   266				break;
   267			case 0x3:
   268				if (!access_ok(addr, 8))
   269					goto sigbus;
   270	
   271				compute_return_epc(regs);
   272				value = regs->regs[insn.loongson3_lsdc2_format.rt];
   273	
   274				StoreDW(addr, value, res);
   275				if (res)
   276					goto fault;
   277	
   278				break;
   279	
   280			case 0x6:
   281				die_if_kernel("Unaligned FP access in kernel code", regs);
   282				BUG_ON(!used_math());
   283	
   284				if (!access_ok(addr, 4))
   285					goto sigbus;
   286	
   287				lose_fpu(1);
   288				value = get_fpr64(current->thread.fpu.fpr,
   289						insn.loongson3_lsdc2_format.rt);
   290	
   291				StoreW(addr, value, res);
   292				if (res)
   293					goto fault;
   294	
   295				compute_return_epc(regs);
   296				own_fpu(1);
   297	
   298				break;
   299			case 0x7:
   300				die_if_kernel("Unaligned FP access in kernel code", regs);
   301				BUG_ON(!used_math());
   302	
   303				if (!access_ok(addr, 8))
   304					goto sigbus;
   305	
   306				lose_fpu(1);
   307				value = get_fpr64(current->thread.fpu.fpr,
   308						insn.loongson3_lsdc2_format.rt);
   309	
   310				StoreDW(addr, value, res);
   311				if (res)
   312					goto fault;
   313	
   314				compute_return_epc(regs);
   315				own_fpu(1);
   316	
   317				break;
   318			}
   319			return NOTIFY_STOP;	/* Don't call default notifier */
   320		}
   321	
   322		return NOTIFY_OK;		/* Let default notifier send signals */
   323	
   324	fault:
   325		/* roll back jump/branch */
   326		regs->regs[31] = ra;
   327		regs->cp0_epc = (unsigned long)pc;
   328		/* Did we have an exception handler installed? */
   329		if (fixup_exception(regs))
   330			return NOTIFY_STOP;	/* Don't call default notifier */
   331	
   332		die_if_kernel("Unhandled kernel unaligned access", regs);
   333		force_sig(SIGSEGV);
   334	
   335		return NOTIFY_STOP;	/* Don't call default notifier */
   336	
   337	sigbus:
   338		die_if_kernel("Unhandled kernel unaligned access", regs);
   339		force_sig(SIGBUS);
   340	
   341		return NOTIFY_STOP;	/* Don't call default notifier */
   342	}
   343	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--M9NhX3UHpAaciwkO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Pxk9EZ5lgNazAnUp9P9cC5krDXIBAA==

--M9NhX3UHpAaciwkO--
