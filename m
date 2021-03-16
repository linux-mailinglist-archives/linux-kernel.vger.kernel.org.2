Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154C33D8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbhCPQFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:05:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:16815 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238389AbhCPQEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:04:38 -0400
IronPort-SDR: LLhykzwTz+TWnnS6tXjAt04xQgyeSaBW6qZ4K77IXAmuwXZebVqZed6ELBSH/7FXqm0wNcZ9Z2
 PT+keXnXKZMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="253301540"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="gz'50?scan'50,208,50";a="253301540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 09:04:26 -0700
IronPort-SDR: FGnrQMqZu8ByNpFC15e+t0fWxIaHC9qsywbg8Km9vIW/KlqPDwJajxbYxbi0GnFQD46qIt5no8
 fGL0idlZ5kgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="gz'50?scan'50,208,50";a="511422898"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Mar 2021 09:04:23 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMCBC-0000CZ-Cp; Tue, 16 Mar 2021 16:04:22 +0000
Date:   Wed, 17 Mar 2021 00:03:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Move page_mapping_file to pagemap.h
Message-ID: <202103162330.mQEYO3rW-lkp@intel.com>
References: <20210316141040.37576-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20210316141040.37576-1-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi "Matthew,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-linux-mm/master]

url:    https://github.com/0day-ci/linux/commits/Matthew-Wilcox-Oracle/mm-Move-page_mapping_file-to-pagemap-h/20210316-221138
base:   https://github.com/hnaz/linux-mm master
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5f7b112de945843f38fbf9f602dd547010e8b8d0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Wilcox-Oracle/mm-Move-page_mapping_file-to-pagemap-h/20210316-221138
        git checkout 5f7b112de945843f38fbf9f602dd547010e8b8d0
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   arch/nios2/mm/cacheflush.c:160:6: warning: no previous prototype for '__flush_dcache_page' [-Wmissing-prototypes]
     160 | void __flush_dcache_page(struct address_space *mapping, struct page *page)
         |      ^~~~~~~~~~~~~~~~~~~
   arch/nios2/mm/cacheflush.c: In function 'flush_dcache_page':
>> arch/nios2/mm/cacheflush.c:183:12: error: implicit declaration of function 'page_mapping_file'; did you mean 'page_mapping'? [-Werror=implicit-function-declaration]
     183 |  mapping = page_mapping_file(page);
         |            ^~~~~~~~~~~~~~~~~
         |            page_mapping
>> arch/nios2/mm/cacheflush.c:183:10: warning: assignment to 'struct address_space *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     183 |  mapping = page_mapping_file(page);
         |          ^
   arch/nios2/mm/cacheflush.c: In function 'update_mmu_cache':
   arch/nios2/mm/cacheflush.c:221:10: warning: assignment to 'struct address_space *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     221 |  mapping = page_mapping_file(page);
         |          ^
   cc1: some warnings being treated as errors


vim +183 arch/nios2/mm/cacheflush.c

93c91cb228e76b Ley Foon Tan 2014-11-06  159  
1a70db49a73535 Ley Foon Tan 2015-04-24 @160  void __flush_dcache_page(struct address_space *mapping, struct page *page)
1a70db49a73535 Ley Foon Tan 2015-04-24  161  {
1a70db49a73535 Ley Foon Tan 2015-04-24  162  	/*
1a70db49a73535 Ley Foon Tan 2015-04-24  163  	 * Writeback any data associated with the kernel mapping of this
1a70db49a73535 Ley Foon Tan 2015-04-24  164  	 * page.  This ensures that data in the physical page is mutually
1a70db49a73535 Ley Foon Tan 2015-04-24  165  	 * coherent with the kernels mapping.
1a70db49a73535 Ley Foon Tan 2015-04-24  166  	 */
1a70db49a73535 Ley Foon Tan 2015-04-24  167  	unsigned long start = (unsigned long)page_address(page);
1a70db49a73535 Ley Foon Tan 2015-04-24  168  
8e3d7c834ba0f7 Ley Foon Tan 2015-11-26  169  	__flush_dcache(start, start + PAGE_SIZE);
1a70db49a73535 Ley Foon Tan 2015-04-24  170  }
1a70db49a73535 Ley Foon Tan 2015-04-24  171  
93c91cb228e76b Ley Foon Tan 2014-11-06  172  void flush_dcache_page(struct page *page)
93c91cb228e76b Ley Foon Tan 2014-11-06  173  {
93c91cb228e76b Ley Foon Tan 2014-11-06  174  	struct address_space *mapping;
93c91cb228e76b Ley Foon Tan 2014-11-06  175  
93c91cb228e76b Ley Foon Tan 2014-11-06  176  	/*
93c91cb228e76b Ley Foon Tan 2014-11-06  177  	 * The zero page is never written to, so never has any dirty
93c91cb228e76b Ley Foon Tan 2014-11-06  178  	 * cache lines, and therefore never needs to be flushed.
93c91cb228e76b Ley Foon Tan 2014-11-06  179  	 */
93c91cb228e76b Ley Foon Tan 2014-11-06  180  	if (page == ZERO_PAGE(0))
93c91cb228e76b Ley Foon Tan 2014-11-06  181  		return;
93c91cb228e76b Ley Foon Tan 2014-11-06  182  
cb9f753a3731f7 Huang Ying   2018-04-05 @183  	mapping = page_mapping_file(page);
93c91cb228e76b Ley Foon Tan 2014-11-06  184  
93c91cb228e76b Ley Foon Tan 2014-11-06  185  	/* Flush this page if there are aliases. */
93c91cb228e76b Ley Foon Tan 2014-11-06  186  	if (mapping && !mapping_mapped(mapping)) {
93c91cb228e76b Ley Foon Tan 2014-11-06  187  		clear_bit(PG_dcache_clean, &page->flags);
93c91cb228e76b Ley Foon Tan 2014-11-06  188  	} else {
1a70db49a73535 Ley Foon Tan 2015-04-24  189  		__flush_dcache_page(mapping, page);
1a70db49a73535 Ley Foon Tan 2015-04-24  190  		if (mapping) {
93c91cb228e76b Ley Foon Tan 2014-11-06  191  			unsigned long start = (unsigned long)page_address(page);
93c91cb228e76b Ley Foon Tan 2014-11-06  192  			flush_aliases(mapping,  page);
1a70db49a73535 Ley Foon Tan 2015-04-24  193  			flush_icache_range(start, start + PAGE_SIZE);
1a70db49a73535 Ley Foon Tan 2015-04-24  194  		}
93c91cb228e76b Ley Foon Tan 2014-11-06  195  		set_bit(PG_dcache_clean, &page->flags);
93c91cb228e76b Ley Foon Tan 2014-11-06  196  	}
93c91cb228e76b Ley Foon Tan 2014-11-06  197  }
93c91cb228e76b Ley Foon Tan 2014-11-06  198  EXPORT_SYMBOL(flush_dcache_page);
93c91cb228e76b Ley Foon Tan 2014-11-06  199  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sdtB3X0nJg68CQEu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Rk4hPjht0E60/wFaa6fW85cAAA==

--sdtB3X0nJg68CQEu--
