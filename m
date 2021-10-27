Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA9843BFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbhJ0CcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhJ0CcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:32:18 -0400
Received: from out10.migadu.com (out10.migadu.com [IPv6:2001:41d0:2:e8e3::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD57C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:29:53 -0700 (PDT)
Date:   Wed, 27 Oct 2021 11:29:37 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1635301789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQGDOP/LiQ5qzBi3yIx/uAb2j3FzvKGJHPlYNIgLsaI=;
        b=iArym7oen0t74ifKxfuMX6gQLNj3u84i6EINnK5MlGKMIWEoRAAeLUYUlWA2Hm2YSR4QI+
        uSaQf4JgCWzDAe3VSuqff8w9xmpP+xgQh+p8pGjEbtcNEIPZfudnANO58dJKEK2WLrvuXo
        i59u53fcevjv2Rva6VXt1I2SOjRhwwA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Ding Hui <dinghui@sangfor.com.cn>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Tony Luck <tony.luck@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 4/4] mm/hwpoison: fix unpoison_memory()
Message-ID: <20211027022937.GB2707645@u2004>
References: <20211025232634.GA2651726@u2004>
 <0d83410a-4377-35ee-66ec-0dbeb5e8801f@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d83410a-4377-35ee-66ec-0dbeb5e8801f@sangfor.com.cn>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 09:26:08AM +0800, Ding Hui wrote:
> On 2021/10/26 7:27, Naoya Horiguchi wrote:
> > (Please ignore previous patch 4/4 which leaves the replied message at
> > the end of body, this was due to my wrong manual edit, sorry about noise.
> > I resend 4/4.)
> > 
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > After recent soft-offline rework, error pages can be taken off from
> > buddy allocator, but the existing unpoison_memory() does not properly
> > undo the operation.  Moreover, due to the recent change on
> > __get_hwpoison_page(), get_page_unless_zero() is hardly called for
> > hwpoisoned pages.  So __get_hwpoison_page() highly likely returns zero
> 
> Sorry, can you explain that __get_hwpoison_page() likely go which branch to
> return zero for hwpoisoned pages ?
> 
> not returns -EBUSY because HWPoisonHandlable() is false ?

Sorry, you're right, the return value mentioned here was changed since v1,
so I should have updated the description.

...
> > @@ -1958,9 +2023,7 @@ int unpoison_memory(unsigned long pfn)
> >   {
> >   	struct page *page;
> >   	struct page *p;
> > -	int freeit = 0;
> > -	int ret = 0;
> > -	unsigned long flags = 0;
> > +	int ret = -EBUSY;
> >   	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
> >   					DEFAULT_RATELIMIT_BURST);
> > @@ -1996,24 +2059,27 @@ int unpoison_memory(unsigned long pfn)
> >   		goto unlock_mutex;
> >   	}
> > -	if (!get_hwpoison_page(p, flags)) {
> > -		if (TestClearPageHWPoison(p))
> > -			num_poisoned_pages_dec();
> > -		unpoison_pr_info("Unpoison: Software-unpoisoned free page %#lx\n",
> > -				 pfn, &unpoison_rs);
> > +	if (PageSlab(page))
> 
> As I reported before [1], get refcount to a PageTable(page) is not safe,
> maybe let huge_pmd_unshare() go to wrong branch, so can you also avoid
> PageTable(page) here ?
> 
> [1]: https://lore.kernel.org/linux-mm/271d0f41-0599-9d5d-0555-47189f476243@sangfor.com.cn/

Sure, I'll add it.

> 
> >   		goto unlock_mutex;
> > -	}
> > -	if (TestClearPageHWPoison(page)) {
> > -		unpoison_pr_info("Unpoison: Software-unpoisoned page %#lx\n",
> > -				 pfn, &unpoison_rs);
> > -		num_poisoned_pages_dec();
> > -		freeit = 1;
> > -	}
> > +	ret = get_hwpoison_page(p, MF_UNPOISON);
> > +	if (!ret) {
> > +		ret = clear_page_hwpoison(&unpoison_rs, p);
> 
> in this case, the page p has zero refcount, with HWPoison flag, but without
> MAGIC_HWPOISON, where it come from ? race condition or normal case ? Is
> there any examples please ?

memory_failure() could set HWPoison flag at any time, so if a memory error happens
on a page which a just being freed, that could be linked to buddy freelist with
HWPoison flag.

Another example is hugetlb's case, if memory_failrue() is called for a free hugetlb
page and somehow dissolve_free_huge_page() fails in handling path, the hugepage
remains with HWPoison flag set and refcount 0.
BTW, considering this case, I found that clear_page_hwpoison() should be called
for "page" instead of "p", which will be fixed in the next version.

Thanks,
Naoya Horiguchi
