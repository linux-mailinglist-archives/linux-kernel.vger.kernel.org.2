Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04363C6D79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 11:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhGMJdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 05:33:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbhGMJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 05:32:57 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C7CCC2007E;
        Tue, 13 Jul 2021 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626168606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JcCPjDcrvfzpmzaVzS7nNSr2ItgjCbZj3DsU2BMBR/E=;
        b=a3jdJE7sy8Ewp0X+SdC/k03tAwBJsCPyelubwU2+vA+YxTWuDWROkohFZ3JvBVivUgabr5
        l+BPrZglKPsK3AH3rzuKqbjCE/oQz0vEjyQMKA1IGluU9QimBfpWCAB60WyT2zB7mJbZtB
        MCAGswAVEraxGxhOcFa6mIHyBfmrP94=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 305EEA3B8C;
        Tue, 13 Jul 2021 09:30:03 +0000 (UTC)
Date:   Tue, 13 Jul 2021 11:30:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        axboe@kernel.dk, iamjoonsoo.kim@lge.com, alexs@kernel.org,
        apopple@nvidia.com, willy@infradead.org, minchan@kernel.org,
        david@redhat.com, shli@fb.com, hillf.zj@alibaba-inc.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
Message-ID: <YO1dGvcTLaRJplRQ@dhcp22.suse.cz>
References: <20210710100329.49174-1-linmiaohe@huawei.com>
 <20210710100329.49174-2-linmiaohe@huawei.com>
 <YOvtmy9ggJA4KUIQ@dhcp22.suse.cz>
 <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9409189e-44f7-2608-68af-851629b6d453@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 12-07-21 19:03:39, Miaohe Lin wrote:
> On 2021/7/12 15:22, Michal Hocko wrote:
> > On Sat 10-07-21 18:03:25, Miaohe Lin wrote:
> >> If the MADV_FREE pages are redirtied before they could be reclaimed, put
> >> the pages back to anonymous LRU list by setting SwapBacked flag and the
> >> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
> >> won't be reclaimed as expected.
> > 
> > Could you describe problem which you are trying to address? What does it
> > mean that pages won't be reclaimed as expected?
> > 
> 
> In fact, this is not a bug and harmless.

Fixes tag is then misleading and the changelog should be more clear
about this as well.

> But it looks buggy as it didn't perform
> the expected ops from code view. Lazyfree (MADV_FREE) pages are clean anonymous
> pages. They have SwapBacked flag cleared to distinguish normal anonymous pages.

yes.

> When the MADV_FREE pages are redirtied before they could be reclaimed, the pages
> should be put back to anonymous LRU list by setting SwapBacked flag, thus the
> pages will be reclaimed in normal swapout way.

Agreed. But the question is why this needs an explicit handling here
when we already do handle this case when trying to unmap the page.
Please make sure to document the behavior you are observing, why it is
not desirable.

> Many thanks for review and reply.
> 
> > Also why is SetPageSwapBacked in shrink_page_list insufficient?

Sorry I meant to say try_to_unmap path here

> >> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/vmscan.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index a7602f71ec04..6483fe0e2065 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1628,6 +1628,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> >>  			if (!page_ref_freeze(page, 1))
> >>  				goto keep_locked;
> >>  			if (PageDirty(page)) {
> >> +				SetPageSwapBacked(page);
> >>  				page_ref_unfreeze(page, 1);
> >>  				goto keep_locked;
> >>  			}
> >> -- 
> >> 2.23.0
> > 

-- 
Michal Hocko
SUSE Labs
