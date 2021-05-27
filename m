Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025163936B2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235319AbhE0Tzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47710 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234586AbhE0Tzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:55:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622145251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mxtUZSqaXY8XU4F0jZiCtJarRMKlJKSJank0/DGF1qE=;
        b=jft1LIQuYeIRXNbtKljIzon9kwDrYp1ebHG3kXcY+2m7xpCf6aRtAHUwiCw32S+CvyHC70
        SvzxAV5T1N7AsYidRphEY7x3Wd5UV2ksctBRPd5QQG2jRJUp/PteNDjrUifMgFwJyM3+Ye
        HUUc++LUS0/nTDYdQhYMJPIHm0fJFsg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F02F2AE99;
        Thu, 27 May 2021 19:54:10 +0000 (UTC)
Date:   Thu, 27 May 2021 21:54:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
Message-ID: <YK/44mOnwZgUOdYA@dhcp22.suse.cz>
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
 <2097f731-0b72-a5bc-1011-09447089a81b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2097f731-0b72-a5bc-1011-09447089a81b@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-05-21 09:28:51, Mike Kravetz wrote:
> On 5/26/21 4:52 PM, Naoya Horiguchi wrote:
> > From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > 
> > When memory_failure() or soft_offline_page() is called on a tail page of
> > some hugetlb page, "BUG: unable to handle page fault" error can be
> > triggered.
> > 
> > remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> > page points to a head page, but one of the caller,
> > dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> > which could be a tail page.  So pass 'head' to it, instead.
> > 
> > Fixes: 6eb4e88a6d27 ("hugetlb: create remove_hugetlb_page() to separate functionality")
> > Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> > ---
> >  mm/hugetlb.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git v5.13-rc3/mm/hugetlb.c v5.13-rc3_patched/mm/hugetlb.c
> > index 95918f410c0f..470f7b5b437e 100644
> > --- v5.13-rc3/mm/hugetlb.c
> > +++ v5.13-rc3_patched/mm/hugetlb.c
> > @@ -1793,7 +1793,7 @@ int dissolve_free_huge_page(struct page *page)
> >  			SetPageHWPoison(page);
> >  			ClearPageHWPoison(head);
> >  		}
> > -		remove_hugetlb_page(h, page, false);
> > +		remove_hugetlb_page(h, head, false);
> >  		h->max_huge_pages--;
> >  		spin_unlock_irq(&hugetlb_lock);
> >  		update_and_free_page(h, head);
> > 
> 
> I believe we have the same problem later in the routine when calling
> add_hugetlb_page()?

Can we ever get a tail page there?

> If so, should we combine the changes?  Or, do we need two patches as
> the bugs were introduced with different commits?

If there is an issue then I would go with a separate patch.

Thanks!
-- 
Michal Hocko
SUSE Labs
