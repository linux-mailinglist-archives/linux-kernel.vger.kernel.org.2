Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56FBA35EC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 06:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347034AbhDNEwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 00:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54262 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230249AbhDNEwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 00:52:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 606BDB01D;
        Wed, 14 Apr 2021 04:52:22 +0000 (UTC)
Date:   Wed, 14 Apr 2021 06:52:19 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/7] mm: Make alloc_contig_range handle in-use hugetlb
 pages
Message-ID: <YHZ1A8Wi43DcEv98@localhost.localdomain>
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-7-osalvador@suse.de>
 <722f9a5e-ef0a-508a-e58a-6c3eacb5d1bd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722f9a5e-ef0a-508a-e58a-6c3eacb5d1bd@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 03:48:53PM -0700, Mike Kravetz wrote:
> The label free_new is:
> 
> free_new:
>         spin_unlock_irq(&hugetlb_lock);
>         __free_pages(new_page, huge_page_order(h));
> 
>         return ret;
> 
> So, we are locking and immediately unlocking without any code in
> between.  Usually, I don't like like multiple labels before return.
> However, perhaps we should add another to avoid this unnecessary
> cycle.  On the other hand, this is an uncommon race condition so the
> simple code may be acceptable.

I guess we could have something like:

 free_new:
         spin_unlock_irq(&hugetlb_lock);
 free_new_nolock:
         __free_pages(new_page, huge_page_order(h));
 
         return ret;

And let the retry go to there without locking. But as you said, the
racecondition is rare enough, so I am not sure if this buys us much.
But I can certainly add it if you feel strong about it.


-- 
Oscar Salvador
SUSE L3
