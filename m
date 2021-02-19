Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D9131F812
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBSLR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 06:17:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:36512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhBSLRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 06:17:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7CDC7AC6E;
        Fri, 19 Feb 2021 11:17:13 +0000 (UTC)
Date:   Fri, 19 Feb 2021 12:17:11 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Make alloc_contig_range handle free hugetlb pages
Message-ID: <20210219111703.GA20286@linux>
References: <20210217100816.28860-2-osalvador@suse.de>
 <YC0ve4PP+VTrEEtw@dhcp22.suse.cz>
 <20210218100917.GA4842@localhost.localdomain>
 <YC5jFrwegRVkMkBQ@dhcp22.suse.cz>
 <20210218133250.GA7983@localhost.localdomain>
 <YC5yzNB9xT76fkod@dhcp22.suse.cz>
 <20210219090548.GA17266@linux>
 <YC+LWksScdiuPw7X@dhcp22.suse.cz>
 <20210219103943.GA19945@linux>
 <YC+ZBIwXKEZCy1Bk@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YC+ZBIwXKEZCy1Bk@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 11:55:00AM +0100, Michal Hocko wrote:
> It is not the lock that I care about but more about counters. The
> intention was that there is a single place to handle both enqueing and
> dequeing. As not all places require counters to be updated. E.g. the
> migration which just replaces one page by another.

I see.
alloc_fresh_huge_page->prep_new_huge_page increments h->nr_huge_pages{_node}
counters.
Which means:

>       new_page = alloc_fresh_huge_page();
>       if (!new_page)
>               goto fail;
>       spin_lock(hugetlb_lock);
>       if (!PageHuge(old_page)) {
>               /* freed from under us, nothing to do */ 
>               __update_and_free_page(new_page);

Here we need update_and_free_page, otherwise we would be leaving a stale value
in h->nr_huge_pages{_node}. 

>               goto unlock;
>       }
>       list_del(&old_page->lru);
>       __update_and_free_page(old_page);

Same here.

>       __enqueue_huge_page(new_page);

This is ok since h->free_huge_pages{_node} do not need to be updated.

-- 
Oscar Salvador
SUSE L3
