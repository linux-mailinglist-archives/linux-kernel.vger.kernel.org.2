Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73943402F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 11:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhCRKM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 06:12:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbhCRKMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 06:12:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616062349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jz16ifXJDJC4ftXE2JnZpLbMRVjlU9F4fxHP55xDnOU=;
        b=DkIU0uYPo/x/mCrfCR96kefe7Ss4g1mMv/uQsGM1LB4M2W0YUiIVQ6wHoxF7+C9111Tmsu
        0WftMg5JgIrS7MYTykqvqLVx6nU7gYuVFtVb+EI7HiVFM2wDDO6W8vFy2/Paesn518jiBy
        VSDgbf9FXHIj7pPhQMChX6GTe0Bodpg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CD366AD71;
        Thu, 18 Mar 2021 10:12:29 +0000 (UTC)
Date:   Thu, 18 Mar 2021 11:12:28 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YFMnjI+nihUKzAiw@dhcp22.suse.cz>
References: <20210317111251.17808-1-osalvador@suse.de>
 <20210317111251.17808-5-osalvador@suse.de>
 <YFIRqtEt4ecfu1TN@dhcp22.suse.cz>
 <YFMVKSrSQCdUQy+p@localhost.localdomain>
 <YFMdlaXBGrZFRpQQ@dhcp22.suse.cz>
 <YFMkbuUbsLti5P6a@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFMkbuUbsLti5P6a@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-03-21 10:59:10, Oscar Salvador wrote:
> On Thu, Mar 18, 2021 at 10:29:57AM +0100, Michal Hocko wrote:
> > On Thu 18-03-21 09:54:01, Oscar Salvador wrote:
> > [...]
> > > @@ -2287,10 +2288,12 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
> > >  		goto unlock;
> > >  	} else if (page_count(old_page)) {
> > >  		/*
> > > -		 * Someone has grabbed the page, fail for now.
> > > +		 * Someone has grabbed the page, try to isolate it here.
> > > +		 * Fail with -EBUSY if not possible.
> > >  		 */
> > > -		ret = -EBUSY;
> > >  		update_and_free_page(h, new_page);
> > > +		if (!isolate_huge_page(old_page, list)
> > > +			ret = -EBUSY;
> > >  		goto unlock;
> > >  	} else if (!HPageFreed(old_page)) {
> > 
> > I do not think you want to call isolate_huge_page with hugetlb_lock
> > held. You would need to drop the lock before calling isolate_huge_page.
> 
> Yeah, that was an oversight. As I said I did not compile it(let alone
> test it), otherwise the system would have screamed I guess.
> 
> I was more interested in knowing whether how did it look wrt. retry
> concerns:

Yes this looks much more to my taste. If we need to retry then it could
just goto retry there. The caller doesn't really have to care.

> @@ -2287,10 +2288,14 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page)
>  		goto unlock;
>  	} else if (page_count(old_page)) {
>  		/*
> -		 * Someone has grabbed the page, fail for now.
> +		 * Someone has grabbed the page, try to isolate it here.
> +		 * Fail with -EBUSY if not possible.
>  		 */
> -		ret = -EBUSY;
>  		update_and_free_page(h, new_page);
> +		spin_unlock(&hugetlb_lock);
> +		if (!isolate_huge_page(old_page, list)
> +			ret = -EBUSY;
> +		spin_lock(&hugetlb_lock);
>  		goto unlock;

simply return ret; here
-- 
Michal Hocko
SUSE Labs
