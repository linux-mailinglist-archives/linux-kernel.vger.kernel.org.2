Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BCA31F504
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 07:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBSGJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 01:09:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:45620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhBSGIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 01:08:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87039AC69;
        Fri, 19 Feb 2021 06:08:07 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 19 Feb 2021 07:08:06 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: Make alloc_contig_range handle free hugetlb
 pages
In-Reply-To: <9a902aae-7478-4287-ad5c-f6b0b7fdf2ad@oracle.com>
References: <20210218120028.6499-1-osalvador@suse.de>
 <20210218120028.6499-2-osalvador@suse.de>
 <9a902aae-7478-4287-ad5c-f6b0b7fdf2ad@oracle.com>
User-Agent: Roundcube Webmail
Message-ID: <73df96ab131fb1587c3527a5ca151c08@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-19 03:10, Mike Kravetz wrote:
> Those counts will be wrong as there are no huge pages on the node.
> 
> I'll think about this more tomorrow.
> Pretty sure this is an issue, but I could be wrong.  Just wanted to 
> give
> a heads up.

Yes, this is a problem, although the fixup would be to check whether we 
have any hugepages.

Nevertheless, I think we should not be touching surplus at all but 
rather make the page temporary.
I am exploring making migrate_pages() handle free hugepages as Michal 
suggested, so the approach is cleaner and we do not need extra 
functions. I yet have to see if that is feasible, as some issues come to 
my mind like the page needs to be in a list to go to migrate_pages, but 
if it is in that list, it is not in hugepages_freelist, and that could 
disrupt userspace as it could not dequeue hugepages if it demands it.
I have to check. Shoult not be possible, we can always make the page 
temporary here.

> --
> Mike Kravetz
> 
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +bool isolate_or_dissolve_huge_page(struct page *page)
>> +{
>> +	struct hstate *h = NULL;
>> +	struct page *head;
>> +	bool ret = false;
>> +
>> +	spin_lock(&hugetlb_lock);
>> +	if (PageHuge(page)) {
>> +		head = compound_head(page);
>> +		h = page_hstate(head);
>> +	}
>> +	spin_unlock(&hugetlb_lock);
>> +
>> +	/*
>> +	 * The page might have been dissolved from under our feet.
>> +	 * If that is the case, return success as if we dissolved it 
>> ourselves.
>> +	 */
>> +	if (!h)
>> +		return true;
>> +
>> +	/*
>> +	 * Fence off gigantic pages as there is a cyclic dependency
>> +	 * between alloc_contig_range and them.
>> +	 */
>> +	if (hstate_is_gigantic(h))
>> +		return ret;
>> +
>> +	if(!page_count(head) && alloc_and_dissolve_huge_page(h, head))
>> +		ret = true;
>> +
>> +	return ret;
>> +}
>> +
>>  struct page *alloc_huge_page(struct vm_area_struct *vma,
>>  				    unsigned long addr, int avoid_reserve)
>>  {
>> 

-- 
Oscar Salvador
SUSE L3
