Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445193C5A18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379858AbhGLJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:30:19 -0400
Received: from mga17.intel.com ([192.55.52.151]:11638 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379751AbhGLJaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 05:30:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10042"; a="190331282"
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="190331282"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 02:27:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,232,1620716400"; 
   d="scan'208";a="502066557"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 02:27:14 -0700
Date:   Mon, 12 Jul 2021 17:27:12 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/nds32/kernel/setup.c:247:26: warning: Unused variable: region
 [unusedVariable]
Message-ID: <20210712092712.GQ2022171@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   50be9417e23af5a8ac860d998e1e3f06b8fd79d7
commit: 80c4574417ae42fe2ba6978772854dc67cfc5331 h8300, nds32, openrisc: simplify detection of memory extents
date:   9 months ago
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/nds32/kernel/setup.c:247:26: warning: Unused variable: region [unusedVariable]
    struct memblock_region *region;
                            ^

vim +247 arch/nds32/kernel/setup.c

001d953ede35df Greentime Hu  2017-10-24  241  
001d953ede35df Greentime Hu  2017-10-24  242  static void __init setup_memory(void)
001d953ede35df Greentime Hu  2017-10-24  243  {
001d953ede35df Greentime Hu  2017-10-24  244  	unsigned long ram_start_pfn;
001d953ede35df Greentime Hu  2017-10-24  245  	unsigned long free_ram_start_pfn;
001d953ede35df Greentime Hu  2017-10-24  246  	phys_addr_t memory_start, memory_end;
001d953ede35df Greentime Hu  2017-10-24 @247  	struct memblock_region *region;
001d953ede35df Greentime Hu  2017-10-24  248  
001d953ede35df Greentime Hu  2017-10-24  249  	memory_end = memory_start = 0;
001d953ede35df Greentime Hu  2017-10-24  250  
001d953ede35df Greentime Hu  2017-10-24  251  	/* Find main memory where is the kernel */
80c4574417ae42 Mike Rapoport 2020-10-13  252  	memory_start = memblock_start_of_DRAM();
80c4574417ae42 Mike Rapoport 2020-10-13  253  	memory_end = memblock_end_of_DRAM();
001d953ede35df Greentime Hu  2017-10-24  254  
001d953ede35df Greentime Hu  2017-10-24  255  	if (!memory_end) {
001d953ede35df Greentime Hu  2017-10-24  256  		panic("No memory!");
001d953ede35df Greentime Hu  2017-10-24  257  	}
001d953ede35df Greentime Hu  2017-10-24  258  
001d953ede35df Greentime Hu  2017-10-24  259  	ram_start_pfn = PFN_UP(memblock_start_of_DRAM());
001d953ede35df Greentime Hu  2017-10-24  260  	/* free_ram_start_pfn is first page after kernel */
001d953ede35df Greentime Hu  2017-10-24  261  	free_ram_start_pfn = PFN_UP(__pa(&_end));
001d953ede35df Greentime Hu  2017-10-24  262  	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
001d953ede35df Greentime Hu  2017-10-24  263  	/* it could update max_pfn */
001d953ede35df Greentime Hu  2017-10-24  264  	if (max_pfn - ram_start_pfn <= MAXMEM_PFN)
001d953ede35df Greentime Hu  2017-10-24  265  		max_low_pfn = max_pfn;
001d953ede35df Greentime Hu  2017-10-24  266  	else {
001d953ede35df Greentime Hu  2017-10-24  267  		max_low_pfn = MAXMEM_PFN + ram_start_pfn;
001d953ede35df Greentime Hu  2017-10-24  268  		if (!IS_ENABLED(CONFIG_HIGHMEM))
001d953ede35df Greentime Hu  2017-10-24  269  			max_pfn = MAXMEM_PFN + ram_start_pfn;
001d953ede35df Greentime Hu  2017-10-24  270  	}
001d953ede35df Greentime Hu  2017-10-24  271  	/* high_memory is related with VMALLOC */
001d953ede35df Greentime Hu  2017-10-24  272  	high_memory = (void *)__va(max_low_pfn * PAGE_SIZE);
001d953ede35df Greentime Hu  2017-10-24  273  	min_low_pfn = free_ram_start_pfn;
001d953ede35df Greentime Hu  2017-10-24  274  
001d953ede35df Greentime Hu  2017-10-24  275  	/*
001d953ede35df Greentime Hu  2017-10-24  276  	 * initialize the boot-time allocator (with low memory only).
001d953ede35df Greentime Hu  2017-10-24  277  	 *
001d953ede35df Greentime Hu  2017-10-24  278  	 * This makes the memory from the end of the kernel to the end of
001d953ede35df Greentime Hu  2017-10-24  279  	 * RAM usable.
001d953ede35df Greentime Hu  2017-10-24  280  	 */
001d953ede35df Greentime Hu  2017-10-24  281  	memblock_set_bottom_up(true);
001d953ede35df Greentime Hu  2017-10-24  282  	memblock_reserve(PFN_PHYS(ram_start_pfn), PFN_PHYS(free_ram_start_pfn - ram_start_pfn));
001d953ede35df Greentime Hu  2017-10-24  283  
001d953ede35df Greentime Hu  2017-10-24  284  	early_init_fdt_reserve_self();
001d953ede35df Greentime Hu  2017-10-24  285  	early_init_fdt_scan_reserved_mem();
001d953ede35df Greentime Hu  2017-10-24  286  
001d953ede35df Greentime Hu  2017-10-24  287  	memblock_dump_all();
001d953ede35df Greentime Hu  2017-10-24  288  }
001d953ede35df Greentime Hu  2017-10-24  289  

:::::: The code at line 247 was first introduced by commit
:::::: 001d953ede35dfb135e636af4b41d5dd20a09471 nds32: Kernel booting and initialization

:::::: TO: Greentime Hu <greentime@andestech.com>
:::::: CC: Greentime Hu <greentime@andestech.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
