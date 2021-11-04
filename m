Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BDC444D20
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhKDB4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:56:13 -0400
Received: from mga01.intel.com ([192.55.52.88]:27247 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230198AbhKDB4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:56:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="255270369"
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="gz'50?scan'50,208,50";a="255270369"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 18:53:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,207,1631602800"; 
   d="gz'50?scan'50,208,50";a="489782153"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Nov 2021 18:53:32 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1miRwZ-0005zX-Uy; Thu, 04 Nov 2021 01:53:31 +0000
Date:   Thu, 4 Nov 2021 09:52:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [rppt:pks/v0.0 25/27] mm/page_alloc.c:5532:9: error: implicit
 declaration of function 'set_memory_4k'; did you mean 'set_memory_nx'?
Message-ID: <202111040923.oCmHUsBv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git pks/v0.0
head:   b1ddb6750818e99c719da2f60b21e5752f43f0e7
commit: c215b60b24418f8dff21de57333f066ebfb30b93 [25/27] mm/page_alloc: add MIGRATE_PTE_MAPPED and __GFP_PTE_MAPPED_2
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=c215b60b24418f8dff21de57333f066ebfb30b93
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt pks/v0.0
        git checkout c215b60b24418f8dff21de57333f066ebfb30b93
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/page_alloc.c:3934:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
    3934 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
         |               ^~~~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c: In function '__alloc_pages':
>> mm/page_alloc.c:5532:9: error: implicit declaration of function 'set_memory_4k'; did you mean 'set_memory_nx'? [-Werror=implicit-function-declaration]
    5532 |   err = set_memory_4k(addr, nr_pages);
         |         ^~~~~~~~~~~~~
         |         set_memory_nx
   cc1: some warnings being treated as errors


vim +5532 mm/page_alloc.c

  5457	
  5458	/*
  5459	 * This is the 'heart' of the zoned buddy allocator.
  5460	 */
  5461	struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
  5462								nodemask_t *nodemask)
  5463	{
  5464		struct page *page;
  5465		unsigned int alloc_flags = ALLOC_WMARK_LOW;
  5466		gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
  5467		struct alloc_context ac = { };
  5468	
  5469		/*
  5470		 * There are several places where we assume that the order value is sane
  5471		 * so bail out early if the request is out of bound.
  5472		 */
  5473		if (unlikely(order >= MAX_ORDER)) {
  5474			WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
  5475			return NULL;
  5476		}
  5477	
  5478		gfp &= gfp_allowed_mask;
  5479		/*
  5480		 * Apply scoped allocation constraints. This is mainly about GFP_NOFS
  5481		 * resp. GFP_NOIO which has to be inherited for all allocation requests
  5482		 * from a particular context which has been marked by
  5483		 * memalloc_no{fs,io}_{save,restore}. And PF_MEMALLOC_PIN which ensures
  5484		 * movable zones are not used during allocation.
  5485		 */
  5486		gfp = current_gfp_context(gfp);
  5487		alloc_gfp = gfp;
  5488		if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
  5489				&alloc_gfp, &alloc_flags))
  5490			return NULL;
  5491	
  5492		if ((alloc_gfp & __GFP_PTE_MAPPED) && order == 0) {
  5493			page = alloc_page_pte_mapped(alloc_gfp);
  5494			if (page)
  5495				goto out;
  5496		}
  5497	
  5498		/*
  5499		 * Forbid the first pass from falling back to types that fragment
  5500		 * memory until all local zones are considered.
  5501		 */
  5502		alloc_flags |= alloc_flags_nofragment(ac.preferred_zoneref->zone, gfp);
  5503	
  5504		/* First allocation attempt */
  5505		page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
  5506		if (likely(page))
  5507			goto out;
  5508	
  5509		alloc_gfp = gfp;
  5510		ac.spread_dirty_pages = false;
  5511	
  5512		/*
  5513		 * Restore the original nodemask if it was potentially replaced with
  5514		 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
  5515		 */
  5516		ac.nodemask = nodemask;
  5517	
  5518		page = __alloc_pages_slowpath(alloc_gfp, order, &ac);
  5519	
  5520	out:
  5521		if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT) && page &&
  5522		    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
  5523			__free_pages(page, order);
  5524			page = NULL;
  5525		}
  5526	
  5527		if (gfp & __GFP_PTE_MAPPED_2) {
  5528			unsigned long addr = (unsigned long)page_address(page);
  5529			unsigned long nr_pages = (1 << order);
  5530			int err;
  5531	
> 5532			err = set_memory_4k(addr, nr_pages);
  5533			if (err) {
  5534				/* FIXME: reset pageblock migratetype */
  5535				/* set_pageblock_migratetype(old_mt) */
  5536				__free_pages(page, order);
  5537				page = NULL;
  5538			}
  5539	
  5540			/* FIXME: should we flush TLB here or later? */
  5541			/* flush_tlb_kernel_range(addr, addr + PAGE_SIZE * nr_pages); */
  5542		}
  5543	
  5544		trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
  5545	
  5546		return page;
  5547	}
  5548	EXPORT_SYMBOL(__alloc_pages);
  5549	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--n8g4imXOkfNTN/H1--
