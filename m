Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A8D36530F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhDTHTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:19:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:14427 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230172AbhDTHSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:18:53 -0400
IronPort-SDR: dKTQQA1jvAY3dQuV81LWpmPIFyZGomktSw4LJ8vV4LQI9mnLyZQQc4JAEbI8RXn/oYRjq7WLcP
 BDz/4NaJwwpw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195572386"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="gz'50?scan'50,208,50";a="195572386"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 00:18:21 -0700
IronPort-SDR: Lb2wZjzQvXmMDbXlIs0xtt5cK6svisHCmekD7Wee5ymP2FarJFIaR4lnJVSDFwFx2WQiDZFkwQ
 nVTD1PSYHCBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="gz'50?scan'50,208,50";a="426815000"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2021 00:18:19 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYkeI-0002Dp-HL; Tue, 20 Apr 2021 07:18:18 +0000
Date:   Tue, 20 Apr 2021 15:17:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: cc1: error: arch/sh/include/mach-hp6xx: No such file or directory
Message-ID: <202104201524.2g2YoQhV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7af08140979a6e7e12b78c93b8625c8d25b084e2
commit: 4c8dd95a723d9cccf8810be54aa62be82885c9d8 kbuild: add some extra warning flags unconditionally
date:   1 year, 11 months ago
config: sh-hp6xx_defconfig (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4c8dd95a723d9cccf8810be54aa62be82885c9d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 4c8dd95a723d9cccf8810be54aa62be82885c9d8
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/idle.c:32:6: error: no previous prototype for 'arch_cpu_idle_dead' [-Werror=missing-prototypes]
      32 | void arch_cpu_idle_dead(void)
         |      ^~~~~~~~~~~~~~~~~~
   arch/sh/kernel/idle.c:37:6: error: no previous prototype for 'arch_cpu_idle' [-Werror=missing-prototypes]
      37 | void arch_cpu_idle(void)
         |      ^~~~~~~~~~~~~
   arch/sh/kernel/idle.c:42:13: error: no previous prototype for 'select_idle_routine' [-Werror=missing-prototypes]
      42 | void __init select_idle_routine(void)
         |             ^~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/machvec.c: In function 'early_parse_mv':
   arch/sh/kernel/machvec.c:43:8: error: variable 'mv_comma' set but not used [-Werror=unused-but-set-variable]
      43 |  char *mv_comma;
         |        ^~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/ptrace_32.c: In function 'arch_ptrace':
   arch/sh/kernel/ptrace_32.c:380:26: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
     380 |   if ((addr & 3) || addr < 0 ||
         |                          ^
   arch/sh/kernel/ptrace_32.c:420:26: error: comparison of unsigned expression < 0 is always false [-Werror=type-limits]
     420 |   if ((addr & 3) || addr < 0 ||
         |                          ^
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/return_address.c:49:7: error: no previous prototype for 'return_address' [-Werror=missing-prototypes]
      49 | void *return_address(unsigned int depth)
         |       ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/sys_sh.c:58:16: error: no previous prototype for 'sys_cacheflush' [-Werror=missing-prototypes]
      58 | asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len, int op)
         |                ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/traps_32.c:731:6: error: no previous prototype for 'per_cpu_trap_init' [-Werror=missing-prototypes]
     731 | void per_cpu_trap_init(void)
         |      ^~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/kernel/hw_breakpoint.c:135:5: error: no previous prototype for 'arch_bp_generic_fields' [-Werror=missing-prototypes]
     135 | int arch_bp_generic_fields(int sh_len, int sh_type,
         |     ^~~~~~~~~~~~~~~~~~~~~~
   arch/sh/kernel/hw_breakpoint.c: In function 'arch_bp_generic_fields':
   arch/sh/kernel/hw_breakpoint.c:159:13: error: this statement may fall through [-Werror=implicit-fallthrough=]
     159 |   *gen_type = HW_BREAKPOINT_R;
         |   ~~~~~~~~~~^~~~~~~~~~~~~~~~~
   arch/sh/kernel/hw_breakpoint.c:160:2: note: here
     160 |  case SH_BREAKPOINT_WRITE:
         |  ^~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/mm/cache-sh3.c:93:13: error: no previous prototype for 'sh3_cache_init' [-Werror=missing-prototypes]
      93 | void __init sh3_cache_init(void)
         |             ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/mm/fault.c:391:27: error: no previous prototype for 'do_page_fault' [-Werror=missing-prototypes]
     391 | asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
         |                           ^~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
>> cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
   arch/sh/mm/pgtable.c:12:6: error: no previous prototype for 'pgd_ctor' [-Werror=missing-prototypes]
      12 | void pgd_ctor(void *x)
         |      ^~~~~~~~
   arch/sh/mm/pgtable.c:33:8: error: no previous prototype for 'pgd_alloc' [-Werror=missing-prototypes]
      33 | pgd_t *pgd_alloc(struct mm_struct *mm)
         |        ^~~~~~~~~
   arch/sh/mm/pgtable.c:38:6: error: no previous prototype for 'pgd_free' [-Werror=missing-prototypes]
      38 | void pgd_free(struct mm_struct *mm, pgd_t *pgd)
         |      ^~~~~~~~
   cc1: all warnings being treated as errors
..

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9hbp/8s0Z9pfiQAA

--+HP7ph2BbKc20aGI--
