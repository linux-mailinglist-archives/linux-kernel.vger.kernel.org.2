Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869D645D27A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbhKYBmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:42:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:46094 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347659AbhKYBki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:40:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235358202"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="235358202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 17:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="571650841"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Nov 2021 17:35:12 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq3fL-0005Zj-TB; Thu, 25 Nov 2021 01:35:11 +0000
Date:   Thu, 25 Nov 2021 09:34:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [ardb:for-kernelci 25/25] arch/arm/kernel/traps.c:865:17: warning:
 no previous prototype for function 'handle_bad_stack'
Message-ID: <202111250918.ErFZktQF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git for-kernelci
head:   5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
commit: 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1 [25/25] ARM: implement THREAD_INFO_IN_TASK for uniprocessor systems
config: arm-randconfig-r024-20211124 (https://download.01.org/0day-ci/archive/20211125/202111250918.ErFZktQF-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/commit/?id=5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
        git remote add ardb git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
        git fetch --no-tags ardb for-kernelci
        git checkout 5da04a8b7050432b72f6551b6c95e4b5b5fd68d1
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/arm/kernel/traps.c:95:6: warning: no previous prototype for function 'dump_backtrace_stm' [-Wmissing-prototypes]
   void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
        ^
   arch/arm/kernel/traps.c:95:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
   ^
   static 
   arch/arm/kernel/traps.c:446:17: warning: no previous prototype for function 'do_undefinstr' [-Wmissing-prototypes]
   asmlinkage void do_undefinstr(struct pt_regs *regs)
                   ^
   arch/arm/kernel/traps.c:446:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void do_undefinstr(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/traps.c:511:39: warning: no previous prototype for function 'handle_fiq_as_nmi' [-Wmissing-prototypes]
   asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
                                         ^
   arch/arm/kernel/traps.c:511:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __exception_irq_entry handle_fiq_as_nmi(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/traps.c:530:17: warning: no previous prototype for function 'bad_mode' [-Wmissing-prototypes]
   asmlinkage void bad_mode(struct pt_regs *regs, int reason)
                   ^
   arch/arm/kernel/traps.c:530:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void bad_mode(struct pt_regs *regs, int reason)
              ^
              static 
   arch/arm/kernel/traps.c:603:16: warning: no previous prototype for function 'arm_syscall' [-Wmissing-prototypes]
   asmlinkage int arm_syscall(int no, struct pt_regs *regs)
                  ^
   arch/arm/kernel/traps.c:603:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage int arm_syscall(int no, struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/traps.c:729:1: warning: no previous prototype for function 'baddataabort' [-Wmissing-prototypes]
   baddataabort(int code, unsigned long instr, struct pt_regs *regs)
   ^
   arch/arm/kernel/traps.c:728:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void
              ^
              static 
   arch/arm/kernel/traps.c:769:17: warning: no previous prototype for function '__div0' [-Wmissing-prototypes]
   asmlinkage void __div0(void)
                   ^
   arch/arm/kernel/traps.c:769:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void __div0(void)
              ^
              static 
>> arch/arm/kernel/traps.c:865:17: warning: no previous prototype for function 'handle_bad_stack' [-Wmissing-prototypes]
   asmlinkage void handle_bad_stack(struct pt_regs *regs)
                   ^
   arch/arm/kernel/traps.c:865:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void handle_bad_stack(struct pt_regs *regs)
              ^
              static 
   8 warnings generated.


vim +/handle_bad_stack +865 arch/arm/kernel/traps.c

adc7d753de62f2 Ard Biesheuvel 2021-09-23  864  
adc7d753de62f2 Ard Biesheuvel 2021-09-23 @865  asmlinkage void handle_bad_stack(struct pt_regs *regs)
adc7d753de62f2 Ard Biesheuvel 2021-09-23  866  {
adc7d753de62f2 Ard Biesheuvel 2021-09-23  867  	unsigned long tsk_stk = (unsigned long)current->stack;
5da04a8b705043 Ard Biesheuvel 2021-11-24  868  #ifdef CONFIG_IRQSTACKS
adc7d753de62f2 Ard Biesheuvel 2021-09-23  869  	unsigned long irq_stk = (unsigned long)this_cpu_read(irq_stack_ptr);
5da04a8b705043 Ard Biesheuvel 2021-11-24  870  #endif
adc7d753de62f2 Ard Biesheuvel 2021-09-23  871  	unsigned long ovf_stk = (unsigned long)this_cpu_read(overflow_stack_ptr);
adc7d753de62f2 Ard Biesheuvel 2021-09-23  872  
adc7d753de62f2 Ard Biesheuvel 2021-09-23  873  	console_verbose();
adc7d753de62f2 Ard Biesheuvel 2021-09-23  874  	pr_emerg("Insufficient stack space to handle exception!");
adc7d753de62f2 Ard Biesheuvel 2021-09-23  875  
adc7d753de62f2 Ard Biesheuvel 2021-09-23  876  	pr_emerg("Task stack:     [0x%08lx..0x%08lx]\n",
adc7d753de62f2 Ard Biesheuvel 2021-09-23  877  		 tsk_stk, tsk_stk + THREAD_SIZE);
5da04a8b705043 Ard Biesheuvel 2021-11-24  878  #ifdef CONFIG_IRQSTACKS
adc7d753de62f2 Ard Biesheuvel 2021-09-23  879  	pr_emerg("IRQ stack:      [0x%08lx..0x%08lx]\n",
adc7d753de62f2 Ard Biesheuvel 2021-09-23  880  		 irq_stk - THREAD_SIZE, irq_stk);
5da04a8b705043 Ard Biesheuvel 2021-11-24  881  #endif
adc7d753de62f2 Ard Biesheuvel 2021-09-23  882  	pr_emerg("Overflow stack: [0x%08lx..0x%08lx]\n",
adc7d753de62f2 Ard Biesheuvel 2021-09-23  883  		 ovf_stk - OVERFLOW_STACK_SIZE, ovf_stk);
adc7d753de62f2 Ard Biesheuvel 2021-09-23  884  
adc7d753de62f2 Ard Biesheuvel 2021-09-23  885  	die("kernel stack overflow", regs, 0);
adc7d753de62f2 Ard Biesheuvel 2021-09-23  886  }
adc7d753de62f2 Ard Biesheuvel 2021-09-23  887  

:::::: The code at line 865 was first introduced by commit
:::::: adc7d753de62f220505f528106a6d618104302c5 ARM: implement support for vmap'ed stacks

:::::: TO: Ard Biesheuvel <ardb@kernel.org>
:::::: CC: Ard Biesheuvel <ardb@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
