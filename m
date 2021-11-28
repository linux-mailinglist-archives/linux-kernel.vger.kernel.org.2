Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF6460417
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 05:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356655AbhK1Exe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 23:53:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:7272 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353780AbhK1Evc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 23:51:32 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="234537273"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="234537273"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 20:48:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="742804866"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Nov 2021 20:48:15 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrC6o-000ALE-4L; Sun, 28 Nov 2021 04:48:14 +0000
Date:   Sun, 28 Nov 2021 12:48:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/mips/mm/tlbex.c:2599 check_pabits() warn: always true condition
 '(fillbits >= ((__builtin_constant_p(0)) ?(((0) < 2) ?0:63 -
 __builtin_clzll(0)):((4 <= 4)) ?__ilog2_u32(0):__ilog2_u64(0))) => (0-u32max
 >= 0)'
Message-ID: <202111281203.l0V4WbS0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3498e7f2bb415e447354a3debef6738d9655768c
commit: 2f78788b55baa3410b1ec91a576286abe1ad4d6a ilog2: improve ilog2 for constant arguments
date:   12 months ago
config: mips-randconfig-m031-20211123 (https://download.01.org/0day-ci/archive/20211128/202111281203.l0V4WbS0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
arch/mips/mm/tlbex.c:2599 check_pabits() warn: always true condition '(fillbits >= ((__builtin_constant_p(0)) ?(((0) < 2) ?0:63 - __builtin_clzll(0)):((4 <= 4)) ?__ilog2_u32(0):__ilog2_u64(0))) => (0-u32max >= 0)'

Old smatch warnings:
arch/mips/mm/tlbex.c:1681 iPTE_LW() warn: curly braces intended?
arch/mips/mm/tlbex.c:1713 iPTE_SW() warn: inconsistent indenting

vim +2599 arch/mips/mm/tlbex.c

c5b367835cfc7a Steven J. Hill 2015-02-26  2569  
00bf1c691d082c Paul Burton    2015-09-22  2570  static void check_pabits(void)
00bf1c691d082c Paul Burton    2015-09-22  2571  {
00bf1c691d082c Paul Burton    2015-09-22  2572  	unsigned long entry;
00bf1c691d082c Paul Burton    2015-09-22  2573  	unsigned pabits, fillbits;
00bf1c691d082c Paul Burton    2015-09-22  2574  
00bf1c691d082c Paul Burton    2015-09-22  2575  	if (!cpu_has_rixi || !_PAGE_NO_EXEC) {
00bf1c691d082c Paul Burton    2015-09-22  2576  		/*
00bf1c691d082c Paul Burton    2015-09-22  2577  		 * We'll only be making use of the fact that we can rotate bits
00bf1c691d082c Paul Burton    2015-09-22  2578  		 * into the fill if the CPU supports RIXI, so don't bother
00bf1c691d082c Paul Burton    2015-09-22  2579  		 * probing this for CPUs which don't.
00bf1c691d082c Paul Burton    2015-09-22  2580  		 */
00bf1c691d082c Paul Burton    2015-09-22  2581  		return;
00bf1c691d082c Paul Burton    2015-09-22  2582  	}
00bf1c691d082c Paul Burton    2015-09-22  2583  
00bf1c691d082c Paul Burton    2015-09-22  2584  	write_c0_entrylo0(~0ul);
00bf1c691d082c Paul Burton    2015-09-22  2585  	back_to_back_c0_hazard();
00bf1c691d082c Paul Burton    2015-09-22  2586  	entry = read_c0_entrylo0();
00bf1c691d082c Paul Burton    2015-09-22  2587  
00bf1c691d082c Paul Burton    2015-09-22  2588  	/* clear all non-PFN bits */
00bf1c691d082c Paul Burton    2015-09-22  2589  	entry &= ~((1 << MIPS_ENTRYLO_PFN_SHIFT) - 1);
00bf1c691d082c Paul Burton    2015-09-22  2590  	entry &= ~(MIPS_ENTRYLO_RI | MIPS_ENTRYLO_XI);
00bf1c691d082c Paul Burton    2015-09-22  2591  
00bf1c691d082c Paul Burton    2015-09-22  2592  	/* find a lower bound on PABITS, and upper bound on fill bits */
00bf1c691d082c Paul Burton    2015-09-22  2593  	pabits = fls_long(entry) + 6;
00bf1c691d082c Paul Burton    2015-09-22  2594  	fillbits = max_t(int, (int)BITS_PER_LONG - pabits, 0);
00bf1c691d082c Paul Burton    2015-09-22  2595  
00bf1c691d082c Paul Burton    2015-09-22  2596  	/* minus the RI & XI bits */
00bf1c691d082c Paul Burton    2015-09-22  2597  	fillbits -= min_t(unsigned, fillbits, 2);
00bf1c691d082c Paul Burton    2015-09-22  2598  
00bf1c691d082c Paul Burton    2015-09-22 @2599  	if (fillbits >= ilog2(_PAGE_NO_EXEC))
00bf1c691d082c Paul Burton    2015-09-22  2600  		fill_includes_sw_bits = true;
00bf1c691d082c Paul Burton    2015-09-22  2601  
00bf1c691d082c Paul Burton    2015-09-22  2602  	pr_debug("Entry* registers contain %u fill bits\n", fillbits);
00bf1c691d082c Paul Burton    2015-09-22  2603  }
00bf1c691d082c Paul Burton    2015-09-22  2604  

:::::: The code at line 2599 was first introduced by commit
:::::: 00bf1c691d082c1945fdba032c03a9a82e9e7e61 MIPS: tlbex: Avoid placing software PTE bits in Entry* PFN fields

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
