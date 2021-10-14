Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C1F42D939
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJNMZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 08:25:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:44126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhJNMZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 08:25:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="227948171"
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="gz'50?scan'50,208,50";a="227948171"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 05:23:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,372,1624345200"; 
   d="gz'50?scan'50,208,50";a="481241676"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 14 Oct 2021 05:23:25 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mazld-00063L-9Y; Thu, 14 Oct 2021 12:23:25 +0000
Date:   Thu, 14 Oct 2021 20:22:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Cc:     kbuild-all@lists.01.org, guptap@codeaurora.org,
        Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: Re: [PATCH v3] mm: page_alloc: Add debug log in free_reserved_area
 for static memory
Message-ID: <202110142052.L5jD9owk-lkp@intel.com>
References: <1634195564-14048-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <1634195564-14048-1-git-send-email-faiyazm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Faiyaz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.15-rc5]
[cannot apply to hnaz-mm/master next-20211013]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Faiyaz-Mohammed/mm-page_alloc-Add-debug-log-in-free_reserved_area-for-static-memory/20211014-151427
base:    64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc
config: nios2-defconfig (attached as .config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/009729e4f858e64537a4a144369b155f8d69d62f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Faiyaz-Mohammed/mm-page_alloc-Add-debug-log-in-free_reserved_area-for-static-memory/20211014-151427
        git checkout 009729e4f858e64537a4a144369b155f8d69d62f
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/page_alloc.c:3810:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
    3810 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
         |               ^~~~~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/mm.h:9,
                    from mm/page_alloc.c:19:
   mm/page_alloc.c: In function 'free_reserved_area':
>> mm/page_alloc.c:8134:33: error: '__RET_IP_' undeclared (first use in this function)
    8134 |                         (void *)__RET_IP_);
         |                                 ^~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   mm/page_alloc.c:8133:17: note: in expansion of macro 'pr_debug'
    8133 |                 pr_debug("[%pa-%pa] %pS\n", &pstart, &pend,
         |                 ^~~~~~~~
   mm/page_alloc.c:8134:33: note: each undeclared identifier is reported only once for each function it appears in
    8134 |                         (void *)__RET_IP_);
         |                                 ^~~~~~~~~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:576:9: note: in expansion of macro 'no_printk'
     576 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   mm/page_alloc.c:8133:17: note: in expansion of macro 'pr_debug'
    8133 |                 pr_debug("[%pa-%pa] %pS\n", &pstart, &pend,
         |                 ^~~~~~~~


vim +/__RET_IP_ +8134 mm/page_alloc.c

  8097	
  8098	unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
  8099	{
  8100		const phys_addr_t pstart = __pa(start);
  8101		const phys_addr_t pend = __pa(end);
  8102		void *pos;
  8103		unsigned long pages = 0;
  8104	
  8105		start = (void *)PAGE_ALIGN((unsigned long)start);
  8106		end = (void *)((unsigned long)end & PAGE_MASK);
  8107		for (pos = start; pos < end; pos += PAGE_SIZE, pages++) {
  8108			struct page *page = virt_to_page(pos);
  8109			void *direct_map_addr;
  8110	
  8111			/*
  8112			 * 'direct_map_addr' might be different from 'pos'
  8113			 * because some architectures' virt_to_page()
  8114			 * work with aliases.  Getting the direct map
  8115			 * address ensures that we get a _writeable_
  8116			 * alias for the memset().
  8117			 */
  8118			direct_map_addr = page_address(page);
  8119			/*
  8120			 * Perform a kasan-unchecked memset() since this memory
  8121			 * has not been initialized.
  8122			 */
  8123			direct_map_addr = kasan_reset_tag(direct_map_addr);
  8124			if ((unsigned int)poison <= 0xFF)
  8125				memset(direct_map_addr, poison, PAGE_SIZE);
  8126	
  8127			free_reserved_page(page);
  8128		}
  8129	
  8130		if (pages && s) {
  8131			pr_info("Freeing %s memory: %ldK\n",
  8132				s, pages << (PAGE_SHIFT - 10));
  8133			pr_debug("[%pa-%pa] %pS\n", &pstart, &pend,
> 8134				(void *)__RET_IP_);
  8135		}
  8136	
  8137		return pages;
  8138	}
  8139	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3MwIy2ne0vdjdPXF
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--3MwIy2ne0vdjdPXF--
