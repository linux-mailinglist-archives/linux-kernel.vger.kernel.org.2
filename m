Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283FD31536D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 17:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhBIQI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 11:08:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:39320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232608AbhBIQIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:08:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF459AB71;
        Tue,  9 Feb 2021 16:08:11 +0000 (UTC)
To:     David Rientjes <rientjes@google.com>,
        Charan Teja Kalla <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1612187338-19100-1-git-send-email-charante@codeaurora.org>
 <d9d1dd7b-1fe7-67b6-6ba4-fb1a6faa8fae@google.com>
 <160ba3b5-2cd4-5ff0-1348-fb477cefd33d@codeaurora.org>
 <1213f4c6-7557-268d-253e-23f8fea55b19@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: page_alloc: update the COMPACT[STALL|FAIL] events
 properly
Message-ID: <77fd72eb-0bb5-af33-0727-90a69ef7733a@suse.cz>
Date:   Tue, 9 Feb 2021 17:08:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1213f4c6-7557-268d-253e-23f8fea55b19@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 11:28 PM, David Rientjes wrote:
> On Tue, 2 Feb 2021, Charan Teja Kalla wrote:
> 
>> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> >> index 519a60d..531f244 100644
>> >> --- a/mm/page_alloc.c
>> >> +++ b/mm/page_alloc.c
>> >> @@ -4152,6 +4152,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
>> >>  	memalloc_noreclaim_restore(noreclaim_flag);
>> >>  	psi_memstall_leave(&pflags);
>> >>  
>> >> +	if (*compact_result == COMPACT_SKIPPED)
>> >> +		return NULL;
>> >>  	/*
>> >>  	 * At least in one zone compaction wasn't deferred or skipped, so let's
>> >>  	 * count a compaction stall
>> > 
>> > This makes sense, I wonder if it would also be useful to check that 
>> > page == NULL, either in try_to_compact_pages() or here for 
>> > COMPACT_SKIPPED?
>> 
>> In the code, when COMPACT_SKIPPED is being returned, the page will
>> always be NULL. So, I'm not sure how much useful it is for the page ==
>> NULL check here. Or I failed to understand your point here?
>> 
> 
> Your code is short-circuiting the rest of  __alloc_pages_direct_compact() 
> where the return value is dictated by whether page is NULL or non-NULL.  
> We can't leak a captured page if we are testing for it being NULL or 
> non-NULL, which is what the rest of __alloc_pages_direct_compact() does 
> *before* your change.  So the idea was to add a check the page is actually 
> NULL here since you are now relying on the return value of 
> compact_zone_order() to be COMPACT_SKIPPED to infer page == NULL.
> 
> I agree that's currently true in the code, I was trying to catch any 
> errors where current->capture_control.page was non-NULL but 
> try_to_compact_pages() returns COMPACT_SKIPPED.  There's some complexity 
> here.
> 
> So my idea was the expand this out to:
> 
> 	if (*compact_result == COMPACT_SKIPPED) {
> 		VM_BUG_ON(page);
> 		return NULL;
> 	}

Note that this may indeed actually trigger due to free page capture, when an IRQ
handler frees the page. See commit b9e20f0da1f5 ("mm, compaction: make capture
control handling safe wrt interrupts") describing how this was happening for
Hugh. So, this VM_BUG_ON() would sooner or later trigger.

It's because while compact_zone() does detect a successful capture and return
COMPACT_SUCCESS, the IRQ-capture can also happen later without being detected -
at any moment until compact_zone_order() resets the current->capture_control to
NULL. And at that point it may be already poised to return COMPACT_SKIPPED.

It might be cleanest to check *capture at the end of compact_zone_order() and
return COMPACT_SUCCESS when non-NULL. Technically it might be not true that
compaction was successful (we were just lucky that IRQ came and freed the page),
but not much harm in that. Better than e.g. the danger of leaking the captured
page which the proposed patch would do due to the shortcut.
The minor downside is that you would count a stall that wasn't really a stall in
case we skipped compaction, but captured a page by luck, but it would be very rare.

