Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D9D316681
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhBJMVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:21:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54224 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231481AbhBJMSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:18:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E7F4EAC97;
        Wed, 10 Feb 2021 12:17:33 +0000 (UTC)
Subject: Re: [PATCH] mm: remove lru_add_drain_all in alloc_contig_range
To:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
References: <20210209175048.361638-1-minchan@kernel.org>
 <accc057c-e639-7510-f722-4a4d166c80b6@redhat.com>
 <20210209190332.GA3363@localhost.localdomain>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <49491777-6d61-db4d-5e90-7a8b9045faca@suse.cz>
Date:   Wed, 10 Feb 2021 13:17:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209190332.GA3363@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 8:03 PM, Oscar Salvador wrote:
> On Tue, Feb 09, 2021 at 07:17:59PM +0100, David Hildenbrand wrote:
>> I was expecting some magical reason why this is still required but I am not
>> able to find a compelling one. Maybe this is really some historical
>> artifact.
>> 
>> Let's see if other people know why this call here still exists.
> 
> I also stumbled upon this while working on adding hugetlb support for
> alloc_acontig_range [1].
> I have to confess I puzzled me a bit.
> 
> I saw it going back to when the function was first introduced by 
> 
> commit 041d3a8cdc18dc375a128d90bbb753949a81b1fb
> Author: Michal Nazarewicz <mina86@mina86.com>
> Date:   Thu Dec 29 13:09:50 2011 +0100
> 
>     mm: page_alloc: introduce alloc_contig_range()
> 
> 
> It does not make much sense to me. At this point our pages are free, so
> we do not care about LRU handling here.
> But I might be missing something.

AFAICS, at the time page migration used putback_lru_page() to release the
migration source page. This would put the page on lru pvec even if it was in
fact not mapped anywhere anymore, and only the drain would actually free it.
Seems Minchan optimized this in 2016 by c6c919eb90e0 ("mm: use put_page() to
free page instead of putback_lru_page()")

> [1] https://lore.kernel.org/linux-mm/20210208103935.GA32103@linux/T/#md651fc6e73c656105179382f92f8b2d6073051d1
> 
> 

