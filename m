Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E939856F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 11:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhFBJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 05:45:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:47989 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232109AbhFBJpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 05:45:39 -0400
IronPort-SDR: VhiqguSAYIb6XgpStXEW643D4SGj059Lvgt6uuLRurQLF3N3lr/aZ4Tewr9aVAoIe8V3YrVE9N
 vFkBeyGuc86Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="200738708"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="200738708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 02:43:57 -0700
IronPort-SDR: ahrV80wV3JIVDV6C7MMJ8QF4KbLE3B01TgQ5aWe0bFAfQ+IgPJDFRUSHqml+6wEH7Tfi6wPKRl
 VdECDRDXkyyw==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="479641147"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2021 02:43:55 -0700
Date:   Wed, 2 Jun 2021 17:43:41 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: arch/h8300/kernel/setup.c:72:26: warning: Unused variable: region
 [unusedVariable]
Message-ID: <20210602094340.GI1271937@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c2131f7e73c9e9365613e323d65c7b9e5b910f56
commit: 80c4574417ae42fe2ba6978772854dc67cfc5331 h8300, nds32, openrisc: simplify detection of memory extents
date:   8 months ago
compiler: h8300-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> arch/h8300/kernel/setup.c:72:26: warning: Unused variable: region [unusedVariable]
    struct memblock_region *region;
                            ^

vim +72 arch/h8300/kernel/setup.c

d8b0bdb444ed0e Yoshinori Sato 2015-05-11  69  
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  70  static void __init bootmem_init(void)
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  71  {
d8b0bdb444ed0e Yoshinori Sato 2015-05-11 @72  	struct memblock_region *region;
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  73  
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  74  	memory_end = memory_start = 0;
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  75  
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  76  	/* Find main memory where is the kernel */
80c4574417ae42 Mike Rapoport  2020-10-13  77  	memory_start = memblock_start_of_DRAM();
80c4574417ae42 Mike Rapoport  2020-10-13  78  	memory_end = memblock_end_of_DRAM();
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  79  
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  80  	if (!memory_end)
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  81  		panic("No memory!");
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  82  
c489dfefe739d3 Rob Herring    2018-03-16  83  	/* setup bootmem globals (we use no_bootmem, but mm still depends on this) */
c489dfefe739d3 Rob Herring    2018-03-16  84  	min_low_pfn = PFN_UP(memory_start);
80c4574417ae42 Mike Rapoport  2020-10-13  85  	max_low_pfn = PFN_DOWN(memory_end);
c489dfefe739d3 Rob Herring    2018-03-16  86  	max_pfn = max_low_pfn;
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  87  
c489dfefe739d3 Rob Herring    2018-03-16  88  	memblock_reserve(__pa(_stext), _end - _stext);
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  89  
c489dfefe739d3 Rob Herring    2018-03-16  90  	early_init_fdt_reserve_self();
c489dfefe739d3 Rob Herring    2018-03-16  91  	early_init_fdt_scan_reserved_mem();
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  92  
c489dfefe739d3 Rob Herring    2018-03-16  93  	memblock_dump_all();
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  94  }
d8b0bdb444ed0e Yoshinori Sato 2015-05-11  95  

:::::: The code at line 72 was first introduced by commit
:::::: d8b0bdb444ed0e2bd5f9d3ea7412cb90bdec58cf h8300: kernel startup

:::::: TO: Yoshinori Sato <ysato@users.sourceforge.jp>
:::::: CC: Yoshinori Sato <ysato@users.sourceforge.jp>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
