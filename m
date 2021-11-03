Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02C444637
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhKCQtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:49:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:49840 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232860AbhKCQtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:49:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="211597011"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="gz'50?scan'50,208,50";a="211597011"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 09:46:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="gz'50?scan'50,208,50";a="599963577"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Nov 2021 09:46:25 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miJP6-0005i1-GA; Wed, 03 Nov 2021 16:46:24 +0000
Date:   Thu, 4 Nov 2021 00:46:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dinguyen:nios2_for_v5.16 1/1] arch/nios2/kernel/irq.c:33:21: error:
 'CTL_IENABLE' undeclared; did you mean 'PTR_IENABLE'?
Message-ID: <202111040000.Ep1D268V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git nios2_for_v5.16
head:   97497b288e3c5e80d7de693e535484382629fbb3
commit: 97497b288e3c5e80d7de693e535484382629fbb3 [1/1] nios2: Add NIOS2_ to distinquish defines
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git/commit/?id=97497b288e3c5e80d7de693e535484382629fbb3
        git remote add dinguyen https://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git
        git fetch --no-tags dinguyen nios2_for_v5.16
        git checkout 97497b288e3c5e80d7de693e535484382629fbb3
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/nios2/kernel/irq.c:19:17: warning: no previous prototype for 'do_IRQ' [-Wmissing-prototypes]
      19 | asmlinkage void do_IRQ(int hwirq, struct pt_regs *regs)
         |                 ^~~~~~
   In file included from arch/nios2/include/asm/irqflags.h:8,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/interrupt.h:6,
                    from arch/nios2/kernel/irq.c:13:
   arch/nios2/kernel/irq.c: In function 'chip_unmask':
>> arch/nios2/kernel/irq.c:33:21: error: 'CTL_IENABLE' undeclared (first use in this function); did you mean 'PTR_IENABLE'?
      33 |         NIOS2_WRCTL(CTL_IENABLE, ienable);
         |                     ^~~~~~~~~~~
   arch/nios2/kernel/irq.c:33:9: note: in expansion of macro 'NIOS2_WRCTL'
      33 |         NIOS2_WRCTL(CTL_IENABLE, ienable);
         |         ^~~~~~~~~~~
   arch/nios2/kernel/irq.c:33:21: note: each undeclared identifier is reported only once for each function it appears in
      33 |         NIOS2_WRCTL(CTL_IENABLE, ienable);
         |                     ^~~~~~~~~~~
   arch/nios2/kernel/irq.c:33:9: note: in expansion of macro 'NIOS2_WRCTL'
      33 |         NIOS2_WRCTL(CTL_IENABLE, ienable);
         |         ^~~~~~~~~~~
   arch/nios2/kernel/irq.c: In function 'chip_mask':
   arch/nios2/kernel/irq.c:39:21: error: 'CTL_IENABLE' undeclared (first use in this function); did you mean 'PTR_IENABLE'?
      39 |         NIOS2_WRCTL(CTL_IENABLE, ienable);
         |                     ^~~~~~~~~~~
   arch/nios2/include/asm/registers.h:33:49: note: in definition of macro 'NIOS2_WRCTL'
      33 | #define NIOS2_WRCTL(r, v)       __builtin_wrctl(r, v)
         |                                                 ^
   arch/nios2/kernel/irq.c: At top level:
   arch/nios2/kernel/irq.c:61:13: warning: no previous prototype for 'init_IRQ' [-Wmissing-prototypes]
      61 | void __init init_IRQ(void)
         |             ^~~~~~~~
   In file included from arch/nios2/include/asm/irqflags.h:8,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/interrupt.h:6,
                    from arch/nios2/kernel/irq.c:13:
   arch/nios2/kernel/irq.c: In function 'init_IRQ':
   arch/nios2/kernel/irq.c:78:31: error: 'CTL_IENABLE' undeclared (first use in this function); did you mean 'PTR_IENABLE'?
      78 |         ienable = NIOS2_RDCTL(CTL_IENABLE);
         |                               ^~~~~~~~~~~
   arch/nios2/include/asm/registers.h:32:41: note: in definition of macro 'NIOS2_RDCTL'
      32 | #define NIOS2_RDCTL(r)  __builtin_rdctl(r)
         |                                         ^
--
   arch/nios2/kernel/traps.c:32:6: warning: no previous prototype for 'die' [-Wmissing-prototypes]
      32 | void die(const char *str, struct pt_regs *regs, long err)
         |      ^~~
   arch/nios2/kernel/traps.c:109:17: warning: no previous prototype for 'breakpoint_c' [-Wmissing-prototypes]
     109 | asmlinkage void breakpoint_c(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~
   arch/nios2/kernel/traps.c:147:17: warning: no previous prototype for 'handle_illegal_c' [-Wmissing-prototypes]
     147 | asmlinkage void handle_illegal_c(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~~~~~
   arch/nios2/kernel/traps.c:154:17: warning: no previous prototype for 'handle_supervisor_instr' [-Wmissing-prototypes]
     154 | asmlinkage void handle_supervisor_instr(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   arch/nios2/kernel/traps.c:161:17: warning: no previous prototype for 'handle_diverror_c' [-Wmissing-prototypes]
     161 | asmlinkage void handle_diverror_c(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~~~~~~
   arch/nios2/kernel/traps.c:168:17: warning: no previous prototype for 'unhandled_exception' [-Wmissing-prototypes]
     168 | asmlinkage void unhandled_exception(struct pt_regs *regs, int cause)
         |                 ^~~~~~~~~~~~~~~~~~~
   In file included from arch/nios2/include/asm/irqflags.h:8,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/nios2/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/current.h:5,
                    from ./arch/nios2/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from arch/nios2/kernel/traps.c:13:
   arch/nios2/kernel/traps.c: In function 'unhandled_exception':
>> arch/nios2/kernel/traps.c:170:42: error: 'CTL_BADADDR' undeclared (first use in this function); did you mean 'PTR_BADADDR'?
     170 |         unsigned long addr = NIOS2_RDCTL(CTL_BADADDR);
         |                                          ^~~~~~~~~~~
   arch/nios2/include/asm/registers.h:32:41: note: in definition of macro 'NIOS2_RDCTL'
      32 | #define NIOS2_RDCTL(r)  __builtin_rdctl(r)
         |                                         ^
   arch/nios2/kernel/traps.c:170:42: note: each undeclared identifier is reported only once for each function it appears in
     170 |         unsigned long addr = NIOS2_RDCTL(CTL_BADADDR);
         |                                          ^~~~~~~~~~~
   arch/nios2/include/asm/registers.h:32:41: note: in definition of macro 'NIOS2_RDCTL'
      32 | #define NIOS2_RDCTL(r)  __builtin_rdctl(r)
         |                                         ^
   arch/nios2/kernel/traps.c: At top level:
   arch/nios2/kernel/traps.c:183:17: warning: no previous prototype for 'handle_trap_1_c' [-Wmissing-prototypes]
     183 | asmlinkage void handle_trap_1_c(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~~~~
   arch/nios2/kernel/traps.c:188:17: warning: no previous prototype for 'handle_trap_2_c' [-Wmissing-prototypes]
     188 | asmlinkage void handle_trap_2_c(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~~~~
   arch/nios2/kernel/traps.c:193:17: warning: no previous prototype for 'handle_trap_3_c' [-Wmissing-prototypes]
     193 | asmlinkage void handle_trap_3_c(struct pt_regs *fp)
         |                 ^~~~~~~~~~~~~~~
--
   arch/nios2/kernel/misaligned.c:66:17: warning: no previous prototype for 'handle_unaligned_c' [-Wmissing-prototypes]
      66 | asmlinkage void handle_unaligned_c(struct pt_regs *fp, int cause)
         |                 ^~~~~~~~~~~~~~~~~~
   In file included from arch/nios2/include/asm/irqflags.h:8,
                    from include/linux/irqflags.h:16,
                    from include/asm-generic/bitops.h:14,
                    from ./arch/nios2/include/generated/asm/bitops.h:1,
                    from include/linux/bitops.h:33,
                    from include/linux/kernel.h:12,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from include/linux/proc_fs.h:10,
                    from arch/nios2/kernel/misaligned.c:19:
   arch/nios2/kernel/misaligned.c: In function 'handle_unaligned_c':
>> arch/nios2/kernel/misaligned.c:150:28: error: 'CTL_BADADDR' undeclared (first use in this function); did you mean 'PTR_BADADDR'?
     150 |         addr = NIOS2_RDCTL(CTL_BADADDR);
         |                            ^~~~~~~~~~~
   arch/nios2/include/asm/registers.h:32:41: note: in definition of macro 'NIOS2_RDCTL'
      32 | #define NIOS2_RDCTL(r)  __builtin_rdctl(r)
         |                                         ^
   arch/nios2/kernel/misaligned.c:150:28: note: each undeclared identifier is reported only once for each function it appears in
     150 |         addr = NIOS2_RDCTL(CTL_BADADDR);
         |                            ^~~~~~~~~~~
   arch/nios2/include/asm/registers.h:32:41: note: in definition of macro 'NIOS2_RDCTL'
      32 | #define NIOS2_RDCTL(r)  __builtin_rdctl(r)
         |                                         ^


vim +33 arch/nios2/kernel/irq.c

    29	
    30	static void chip_unmask(struct irq_data *d)
    31	{
    32		ienable |= (1 << d->hwirq);
  > 33		NIOS2_WRCTL(CTL_IENABLE, ienable);
    34	}
    35	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2oS5YaxWCcQjTEyO--
