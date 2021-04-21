Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0580336672B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 10:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhDUIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 04:44:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232194AbhDUIoB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 04:44:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618994608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qx4dGYz57xIKRcyBm8cNLa//VH6OP4QY62G9bSPSqbY=;
        b=vR1jIb+IgHGDVvD+K8RweleyuDGzDT/mMygFYy7nkeudoMFWAJVfU/v1E09OascrON5j3j
        Q3Wb53w8sKl5yVpWbnaVJZaCpEEyA6h00hpKvfXVnYxV5a++I10QGew/VTkFK7AVpqm+L0
        357YNt97omyJtOgPqG4H7hMYOLn/zNk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE8C8B151;
        Wed, 21 Apr 2021 08:43:27 +0000 (UTC)
Date:   Wed, 21 Apr 2021 10:43:26 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [External] Re: [PATCH] mm: hugetlb: fix a race between
 memory-failure/soft_offline and gather_surplus_pages
Message-ID: <YH/lrlmkEb5b8LCo@dhcp22.suse.cz>
References: <20210421060259.67554-1-songmuchun@bytedance.com>
 <YH/cVoUCTKu/UkqB@dhcp22.suse.cz>
 <CAMZfGtWh4tRiMrOTLvv5GHM1JUCt9b+UHf_DwLev32S=+iLW8g@mail.gmail.com>
 <20210421082103.GE22456@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421082103.GE22456@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 10:21:03, Oscar Salvador wrote:
> On Wed, Apr 21, 2021 at 04:15:00PM +0800, Muchun Song wrote:
> > > The hwpoison side of this looks really suspicious to me. It shouldn't
> > > really touch the reference count of hugetlb pages without being very
> > > careful (and having hugetlb_lock held). What would happen if the
> > > reference count was increased after the page has been enqueed into the
> > > pool? This can just blow up later.
> > 
> > If the page has been enqueued into the pool, then the page can be
> > allocated to other users. The page reference count will be reset to
> > 1 in the dequeue_huge_page_node_exact(). Then memory-failure
> > will free the page because of put_page(). This is wrong. Because
> > there is another user.
> 
> Note that dequeue_huge_page_node_exact() will not hand over any pages
> which are poisoned, so in this case it will not be allocated.

I have to say I have missed the HWPoison check so the this particular
scenario is not possible indeed.

> But it is true that we might need hugetlb lock, this needs some more
> thought.

yes, nobody should be touching to the reference count of hugetlb pool
pages out of the hugetlb proper.

> I will have a look. 

Thanks!
-- 
Michal Hocko
SUSE Labs
