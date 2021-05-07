Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE6375FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbhEGFrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:47:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:49645 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhEGFrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:47:19 -0400
IronPort-SDR: Bb/hl8O4o1ebGvCtEloCYBPBy4AAo7gCBuBg+lIwB53DhafPug38AKwkpYMy9QMDIpNLvtkJ75
 nZaM687xP9Vw==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="196638077"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="196638077"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:46:20 -0700
IronPort-SDR: lHiIJCgrqwPR810HPe1w+euFdu9WS0nJfECSjwAmqaDK9WINevExTmie8G5b9xSl5uxIdDIDdd
 UVyDiUveHbvQ==
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="431143435"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 22:46:18 -0700
Date:   Fri, 7 May 2021 13:45:12 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/openrisc/mm/init.c:125:10: warning: Uninitialized variable:
 region [uninitvar]
Message-ID: <20210507054512.GA2687475@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9f67672a817ec046f7554a885f0fe0d60e1bf99f
commit: b10d6bca87204cdafd0cd7aaa837ad30b4eb8c20 arch, drivers: replace for_each_membock() with for_each_mem_range()
compiler: or1k-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/openrisc/mm/init.c:125:10: warning: Uninitialized variable: region [uninitvar]
            region->base, region->base + region->size);
            ^

vim +125 arch/openrisc/mm/init.c

61e85e367535a7 Jonas Bonn          2011-06-04   58  
61e85e367535a7 Jonas Bonn          2011-06-04   59  /*
61e85e367535a7 Jonas Bonn          2011-06-04   60   * Map all physical memory into kernel's address space.
61e85e367535a7 Jonas Bonn          2011-06-04   61   *
61e85e367535a7 Jonas Bonn          2011-06-04   62   * This is explicitly coded for two-level page tables, so if you need
61e85e367535a7 Jonas Bonn          2011-06-04   63   * something else then this needs to change.
61e85e367535a7 Jonas Bonn          2011-06-04   64   */
61e85e367535a7 Jonas Bonn          2011-06-04   65  static void __init map_ram(void)
61e85e367535a7 Jonas Bonn          2011-06-04   66  {
b10d6bca87204c Mike Rapoport       2020-10-13   67  	phys_addr_t start, end;
61e85e367535a7 Jonas Bonn          2011-06-04   68  	unsigned long v, p, e;
61e85e367535a7 Jonas Bonn          2011-06-04   69  	pgprot_t prot;
61e85e367535a7 Jonas Bonn          2011-06-04   70  	pgd_t *pge;
b187fb7fca9cc4 Mike Rapoport       2020-06-04   71  	p4d_t *p4e;
61e85e367535a7 Jonas Bonn          2011-06-04   72  	pud_t *pue;
61e85e367535a7 Jonas Bonn          2011-06-04   73  	pmd_t *pme;
61e85e367535a7 Jonas Bonn          2011-06-04   74  	pte_t *pte;
b10d6bca87204c Mike Rapoport       2020-10-13   75  	u64 i;
61e85e367535a7 Jonas Bonn          2011-06-04   76  	/* These mark extents of read-only kernel pages...
61e85e367535a7 Jonas Bonn          2011-06-04   77  	 * ...from vmlinux.lds.S
61e85e367535a7 Jonas Bonn          2011-06-04   78  	 */
61e85e367535a7 Jonas Bonn          2011-06-04   79  	struct memblock_region *region;
61e85e367535a7 Jonas Bonn          2011-06-04   80  
61e85e367535a7 Jonas Bonn          2011-06-04   81  	v = PAGE_OFFSET;
61e85e367535a7 Jonas Bonn          2011-06-04   82  
b10d6bca87204c Mike Rapoport       2020-10-13   83  	for_each_mem_range(i, &start, &end) {
b10d6bca87204c Mike Rapoport       2020-10-13   84  		p = (u32) start & PAGE_MASK;
b10d6bca87204c Mike Rapoport       2020-10-13   85  		e = (u32) end;
61e85e367535a7 Jonas Bonn          2011-06-04   86  
61e85e367535a7 Jonas Bonn          2011-06-04   87  		v = (u32) __va(p);
61e85e367535a7 Jonas Bonn          2011-06-04   88  		pge = pgd_offset_k(v);
61e85e367535a7 Jonas Bonn          2011-06-04   89  
61e85e367535a7 Jonas Bonn          2011-06-04   90  		while (p < e) {
61e85e367535a7 Jonas Bonn          2011-06-04   91  			int j;
b187fb7fca9cc4 Mike Rapoport       2020-06-04   92  			p4e = p4d_offset(pge, v);
b187fb7fca9cc4 Mike Rapoport       2020-06-04   93  			pue = pud_offset(p4e, v);
61e85e367535a7 Jonas Bonn          2011-06-04   94  			pme = pmd_offset(pue, v);
61e85e367535a7 Jonas Bonn          2011-06-04   95  
61e85e367535a7 Jonas Bonn          2011-06-04   96  			if ((u32) pue != (u32) pge || (u32) pme != (u32) pge) {
61e85e367535a7 Jonas Bonn          2011-06-04   97  				panic("%s: OR1K kernel hardcoded for "
61e85e367535a7 Jonas Bonn          2011-06-04   98  				      "two-level page tables",
61e85e367535a7 Jonas Bonn          2011-06-04   99  				     __func__);
61e85e367535a7 Jonas Bonn          2011-06-04  100  			}
61e85e367535a7 Jonas Bonn          2011-06-04  101  
61e85e367535a7 Jonas Bonn          2011-06-04  102  			/* Alloc one page for holding PTE's... */
fb054d0d91dbe3 Mike Rapoport       2019-03-11  103  			pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
fb054d0d91dbe3 Mike Rapoport       2019-03-11  104  			if (!pte)
fb054d0d91dbe3 Mike Rapoport       2019-03-11  105  				panic("%s: Failed to allocate page for PTEs\n",
fb054d0d91dbe3 Mike Rapoport       2019-03-11  106  				      __func__);
61e85e367535a7 Jonas Bonn          2011-06-04  107  			set_pmd(pme, __pmd(_KERNPG_TABLE + __pa(pte)));
61e85e367535a7 Jonas Bonn          2011-06-04  108  
61e85e367535a7 Jonas Bonn          2011-06-04  109  			/* Fill the newly allocated page with PTE'S */
f47706099bdb8c Stefan Kristiansson 2014-01-11  110  			for (j = 0; p < e && j < PTRS_PER_PTE;
61e85e367535a7 Jonas Bonn          2011-06-04  111  			     v += PAGE_SIZE, p += PAGE_SIZE, j++, pte++) {
61e85e367535a7 Jonas Bonn          2011-06-04  112  				if (v >= (u32) _e_kernel_ro ||
61e85e367535a7 Jonas Bonn          2011-06-04  113  				    v < (u32) _s_kernel_ro)
61e85e367535a7 Jonas Bonn          2011-06-04  114  					prot = PAGE_KERNEL;
61e85e367535a7 Jonas Bonn          2011-06-04  115  				else
61e85e367535a7 Jonas Bonn          2011-06-04  116  					prot = PAGE_KERNEL_RO;
61e85e367535a7 Jonas Bonn          2011-06-04  117  
61e85e367535a7 Jonas Bonn          2011-06-04  118  				set_pte(pte, mk_pte_phys(p, prot));
61e85e367535a7 Jonas Bonn          2011-06-04  119  			}
61e85e367535a7 Jonas Bonn          2011-06-04  120  
61e85e367535a7 Jonas Bonn          2011-06-04  121  			pge++;
61e85e367535a7 Jonas Bonn          2011-06-04  122  		}
61e85e367535a7 Jonas Bonn          2011-06-04  123  
61e85e367535a7 Jonas Bonn          2011-06-04  124  		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
61e85e367535a7 Jonas Bonn          2011-06-04 @125  		       region->base, region->base + region->size);
61e85e367535a7 Jonas Bonn          2011-06-04  126  	}
61e85e367535a7 Jonas Bonn          2011-06-04  127  }
61e85e367535a7 Jonas Bonn          2011-06-04  128  

:::::: The code at line 125 was first introduced by commit
:::::: 61e85e367535a7b6385b404bef93928768140f96 OpenRISC: Memory management

:::::: TO: Jonas Bonn <jonas@southpole.se>
:::::: CC: Jonas Bonn <jonas@southpole.se>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
