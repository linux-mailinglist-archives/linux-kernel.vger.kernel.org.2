Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29B3732608A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 10:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbhBZJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 04:52:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:49476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhBZJwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 04:52:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614333085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8ELmdVBlgSFEM0c+8AL7CXModPBPz81obvz/7XnzWnc=;
        b=CPKMJQj54h34+7/Xoeo8J4aZTqTa6EYLB3mHPan+F006P17R7stKKFzXzupg5uR4LM//Zd
        240pjifIk35pgZJTw0ntGpLRtWtr8zsNmnBdK7KpT5cKEvv5wte7OcPTVKRJCWM6/zRqvt
        AzQ6yA5kxKv1joQZk6eJ3WlyGNIe/l0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3C875AAAE;
        Fri, 26 Feb 2021 09:51:25 +0000 (UTC)
Date:   Fri, 26 Feb 2021 10:51:24 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
Message-ID: <YDjEnKex9bBmQv7C@dhcp22.suse.cz>
References: <20210222135137.25717-1-osalvador@suse.de>
 <20210222135137.25717-2-osalvador@suse.de>
 <YDiyvQ2SCXxCjPJ2@dhcp22.suse.cz>
 <20210226094507.GA3240@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226094507.GA3240@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-02-21 10:45:14, Oscar Salvador wrote:
> On Fri, Feb 26, 2021 at 09:35:09AM +0100, Michal Hocko wrote:
> > I think it would be helpful to call out that specific case explicitly
> > here. I can see only one scenario (are there more?)
> > __free_huge_page()		isolate_or_dissolve_huge_page
> > 				  PageHuge() == T
> > 				  alloc_and_dissolve_huge_page
> > 				    alloc_fresh_huge_page()
> > 				    spin_lock(hugetlb_lock)
> > 				    // PageHuge() && !PageHugeFreed &&
> > 				    // !PageCount()
> > 				    spin_unlock(hugetlb_lock)
> >   spin_lock(hugetlb_lock)
> >   1) update_and_free_page
> >        PageHuge() == F
> >        __free_pages()
> >   2) enqueue_huge_page
> >        SetPageHugeFreed()
> >   spin_unlock(&hugetlb_lock)
> 
> I do not think there are more scenarios. The thing is to find a !page_count &&
> !PageHugeFreed.
> AFAICS, this can only happen after:
> put_page->put_page_test_zero->..->_free_huge_page gets called but __free_huge_page
> has not reached enqueue_huge_page yet (as you just described above)
> 
> By calling out this case, you meant to describe it in the changelog?

Yes.
[...]
> > 	struct hstate *h;
> > 
> > 	/*
> > 	 * The page might have been dissloved from under our feet
> > 	 * so make sure to carefully check the state under the lock.
> > 	 * Return success on when racing as if we dissloved the page
> > 	 * ourselves.
> > 	 */
> > 	spin_lock(&hugetlb_lock);
> > 	if (PageHuge(page)) {
> > 		head = compound_head(page);
> > 		h = page_hstate(head);
> > 	} else {
> > 		spin_unlock(&hugetlb_lock);
> > 		return true;
> > 	}
> > 	spin_unlock(&hugetlb_lock);
> 
> Yes, I find this less eyesore.
> 
> I will fix it up in v4.

Thanks!
-- 
Michal Hocko
SUSE Labs
