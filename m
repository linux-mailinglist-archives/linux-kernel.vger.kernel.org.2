Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C633E9D80
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhHLE2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:28:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:44281 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhHLE2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:28:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202462612"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="202462612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:28:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="527594245"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:28:14 -0700
Date:   Wed, 11 Aug 2021 21:28:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mm,hwpoison: fix race with hugetlb page allocation
Message-ID: <20210812042813.GA1576603@agluck-desk2.amr.corp.intel.com>
References: <20210603233632.2964832-1-nao.horiguchi@gmail.com>
 <20210603233632.2964832-2-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603233632.2964832-2-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 08:36:31AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When hugetlb page fault (under overcommitting situation) and
> memory_failure() race, VM_BUG_ON_PAGE() is triggered by the following race:
> 
>     CPU0:                           CPU1:
> 
>                                     gather_surplus_pages()
>                                       page = alloc_surplus_huge_page()
>     memory_failure_hugetlb()
>       get_hwpoison_page(page)
>         __get_hwpoison_page(page)
>           get_page_unless_zero(page)
>                                       zero = put_page_testzero(page)
>                                       VM_BUG_ON_PAGE(!zero, page)
>                                       enqueue_huge_page(h, page)
>       put_page(page)
> 
> __get_hwpoison_page() only checks the page refcount before taking an
> additional one for memory error handling, which is not enough because
> there's a time window where compound pages have non-zero refcount during
> hugetlb page initialization.
> 
> So make __get_hwpoison_page() check page status a bit more for hugetlb
> pages with get_hwpoison_huge_page(). Checking hugetlb-specific flags
> under hugetlb_lock makes sure that the hugetlb page is not transitive.
> It's notable that another new function, HWPoisonHandlable(), is helpful
> to prevent a race against other transitive page states (like a generic
> compound page just before PageHuge becomes true).

I'm seeing some strange results when doing a simple injection/recovery.

Current upstream often fails to offline the page with messages like:

	"high-order kernel page"
or
	"unknown page"

Things were working in v5.12. Broken in v5.13.

Bisect says that:

25182f05ffed ("mm,hwpoison: fix race with hugetlb page allocation")

is the culprit (though it is possible that there is more than one
issue ... failure symptoms changed a bit during the bisection).

This commit doesn't revert automatically from upstream. But it
does revert from v5.13. Running with this reverted from v5.13
gives kernel that recovers normally[1] from hundreds of consecutive
error injections.

-Tony

[1] Almost normally. My test catches SIGBUS and prints the virtual
address from the siginfo_t structure. Sometimes the address is correct
other times it is NULL.
