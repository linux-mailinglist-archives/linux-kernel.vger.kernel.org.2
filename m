Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598E531F7CB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhBSK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:59:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:51392 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhBSKzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:55:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613732100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rFG8P9Ie0qeQWrQfmu4nspdfkX+zgZBg6iq8S0zq+4o=;
        b=ghVSU2tWyDJjeKNm5dWJOkhOE1GmVzyU5Kd5XS6Z6dAMvi2zK52pQ2xaoAg4rbS+X++Krs
        OEyro5aWmQQydkGWFVzt4byaWoGkUYeNv1Bu7a3hAatcXr7cxbZbyF4WdX+9c1MM/1gisl
        LfYdpToQoAW+6AQT7JzjYgmF0G1Pvf8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A8714AC6E;
        Fri, 19 Feb 2021 10:55:00 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:55:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <YC+ZBIwXKEZCy1Bk@dhcp22.suse.cz>
References: <20210217100816.28860-1-osalvador@suse.de>
 <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
 <20210219090548.GA17266@linux>
 <YC+LWksScdiuPw7X@dhcp22.suse.cz>
 <20210219103943.GA19945@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219103943.GA19945@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-02-21 11:40:30, Oscar Salvador wrote:
> On Fri, Feb 19, 2021 at 10:56:42AM +0100, Michal Hocko wrote:
> > OK, this should work but I am really wondering whether it wouldn't be
> > just simpler to replace the old page by a new one in the free list
> > directly. Or is there any reason we have to go through the generic
> > helpers path? I mean something like this
> > 
> > 	new_page = alloc_fresh_huge_page();
> > 	if (!new_page)
> > 		goto fail;
> > 	spin_lock(hugetlb_lock);
> > 	if (!PageHuge(old_page)) {
> > 		/* freed from under us, nothing to do */ 
> > 		__update_and_free_page(new_page);
> > 		goto unlock;
> > 	}
> > 	list_del(&old_page->lru);
> > 	__update_and_free_page(old_page);
> > 	__enqueue_huge_page(new_page);
> > unlock:
> > 	spin_unlock(hugetlb_lock);
> > 
> > This will require to split update_and_free_page and enqueue_huge_page to
> > counters independent parts but that shouldn't be a big deal. But it will
> > also protect from any races. Not an act of beauty but seems less hackish
> > to me.
> 
> On a closer look, do we really need to decouple update_and_free_page and
> enqueue_huge_page? These two functions do not handle the lock, but rather
> the functions that call them (as would be in our case).
> Only update_and_free_page drops the lock during the freeing of a gigantic page
> and then it takes it again, as the caller is who took the lock.
> 
> am I missing anything obvious here?

It is not the lock that I care about but more about counters. The
intention was that there is a single place to handle both enqueing and
dequeing. As not all places require counters to be updated. E.g. the
migration which just replaces one page by another.
-- 
Michal Hocko
SUSE Labs
