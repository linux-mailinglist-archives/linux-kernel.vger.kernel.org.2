Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415F745EE43
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 13:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377708AbhKZMqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 07:46:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:54187 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377237AbhKZMoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:44:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235898752"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="235898752"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 04:40:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="457650719"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Nov 2021 04:39:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqaWE-00086k-4x; Fri, 26 Nov 2021 12:39:58 +0000
Date:   Fri, 26 Nov 2021 20:39:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/khugepaged.c:2181:13: warning: stack frame size (3808) exceeds
 limit (2048) in 'khugepaged_do_scan'
Message-ID: <202111262010.UBcefCrE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 2b5067a8143e34aa3fa57a20fb8a3c40d905f942 mm: mmap_lock: add tracepoints around lock acquisition
date:   12 months ago
config: mips-randconfig-r013-20211124 (https://download.01.org/0day-ci/archive/20211126/202111262010.UBcefCrE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b5067a8143e34aa3fa57a20fb8a3c40d905f942
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2b5067a8143e34aa3fa57a20fb8a3c40d905f942
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/khugepaged.c:2181:13: warning: stack frame size (3808) exceeds limit (2048) in 'khugepaged_do_scan' [-Wframe-larger-than]
   static void khugepaged_do_scan(void)
               ^
   1 warning generated.
   Assembler messages:
   Warning: a different -march was already specified, is now octeon


vim +/khugepaged_do_scan +2181 mm/khugepaged.c

b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2180  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26 @2181  static void khugepaged_do_scan(void)
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2182  {
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2183  	struct page *hpage = NULL;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2184  	unsigned int progress = 0, pass_through_head = 0;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2185  	unsigned int pages = khugepaged_pages_to_scan;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2186  	bool wait = true;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2187  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2188  	barrier(); /* write khugepaged_pages_to_scan to local stack */
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2189  
a980df33e9351e Kirill A. Shutemov 2020-06-03  2190  	lru_add_drain_all();
a980df33e9351e Kirill A. Shutemov 2020-06-03  2191  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2192  	while (progress < pages) {
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2193  		if (!khugepaged_prealloc_page(&hpage, &wait))
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2194  			break;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2195  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2196  		cond_resched();
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2197  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2198  		if (unlikely(kthread_should_stop() || try_to_freeze()))
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2199  			break;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2200  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2201  		spin_lock(&khugepaged_mm_lock);
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2202  		if (!khugepaged_scan.mm_slot)
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2203  			pass_through_head++;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2204  		if (khugepaged_has_work() &&
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2205  		    pass_through_head < 2)
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2206  			progress += khugepaged_scan_mm_slot(pages - progress,
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2207  							    &hpage);
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2208  		else
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2209  			progress = pages;
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2210  		spin_unlock(&khugepaged_mm_lock);
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2211  	}
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2212  
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2213  	if (!IS_ERR_OR_NULL(hpage))
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2214  		put_page(hpage);
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2215  }
b46e756f5e4703 Kirill A. Shutemov 2016-07-26  2216  

:::::: The code at line 2181 was first introduced by commit
:::::: b46e756f5e47031c67658ff036e5ffe27062fa43 thp: extract khugepaged from mm/huge_memory.c

:::::: TO: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
