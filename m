Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CCC34EB81
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbhC3PFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232359AbhC3PFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617116713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5L4DA/Q6l8UcF5qSBBQB3UwbGkT6Q9l2lLSd3emRQhI=;
        b=CEpLNLccrhlCZCLB0Du5FFYIJ+SvCwTfKUlULF89pXNowyXz9hj4hx9gE+qM2Uc2PWC7hX
        RJv4uqqdnsd7blEkGpaSolbQWsXpEScGQnmTQcRAw5LLr39EKxMfQqzv55ECgqEzEMqdYY
        nkDQXb0x+D41wzrAvmadec+q/n98BAI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-bgTqe6B9OWGX8Tue3LOleg-1; Tue, 30 Mar 2021 11:05:09 -0400
X-MC-Unique: bgTqe6B9OWGX8Tue3LOleg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EEEE107ACCD;
        Tue, 30 Mar 2021 15:05:08 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6C3B5D730;
        Tue, 30 Mar 2021 15:05:06 +0000 (UTC)
Subject: Re: [PATCH] mm: change size_t to unsigned int for cma_alloc
To:     Minchan Kim <minchan@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210329182553.3129234-1-minchan@kernel.org>
 <20210329184431.GJ351017@casper.infradead.org> <YGI0sThJjsshpPIR@google.com>
 <6d305211-c956-ad80-5908-703d07fca441@redhat.com>
 <YGM8/V7iv3j6JWyx@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d22b04d6-85d6-9b3c-d218-d16f797dd30f@redhat.com>
Date:   Tue, 30 Mar 2021 17:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YGM8/V7iv3j6JWyx@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.21 17:00, Minchan Kim wrote:
> On Tue, Mar 30, 2021 at 09:58:37AM +0200, David Hildenbrand wrote:
>> On 29.03.21 22:12, Minchan Kim wrote:
>>> On Mon, Mar 29, 2021 at 07:44:31PM +0100, Matthew Wilcox wrote:
>>>> On Mon, Mar 29, 2021 at 11:25:53AM -0700, Minchan Kim wrote:
>>>>> size_t in cma_alloc is confusing since it makes people think
>>>>> it's byte count, not pages. Fix it.
>>>>
>>>> i think it has to be unsigned long.
>>>>
>>>> 67a2e213e7e937c41c52ab5bc46bf3f4de469f6e
>>
>> Right.
>>
>> Fortunately, we don't have such large allocations yet via
>> CMA/alloc_contig_range
>>
>>>
>>> Thanks for the pinter. I wanted to have the smallest change.
>>> The commit leads me to change cma_release, trace_cma_alloc,
>>> cma_clear_bitmap and front_contig_range as well.(Not sure
>>> we have more. Will check).
>>>
>>> Ccing david@redhat.com for upcoming changing free_contig_range.
>>
>> While at it, we might want to convert free_contig_range() to eat
>> "unsigned long start, unsigned long end" like alloc_contig_range(), instead
>> of "unsigned long pfn, unsigned int nr_pages" like alloc_contig_pages() ...
> 
> Well, I personllay tempted to change alloc_contig_range, not
> free_contig_range because base_pfn with nr_pages was more
> straightforward than base_pfn and end_pfn in that we don't
> need to tell whether end_pfn is inclusive or exclusive.
> 

That's right.

> When I look at callers of [alloc|free]_contig_range, many of them
> already have used nr_pages based approach rather than start_pfn,
> end_pfn. If your suggestion come from that "it's *range* API",

Right you are, teaching alloc_contig_range() to eat "nr_pages" might 
actually be even better and more consistent.

> I'd like to rename it with "alloc_contig_pages|free_contig_pages".

alloc_contig_pages is just a wrapper for alloc_contig_range(), so 
free_contig_range() is a better fit; OTOH, having both would also 
somehow make sense.

> 
> Since it's beyond the goal of this patch and might be controversial,
> I will not deal with it in this patch.

Sure, but feel free to send a patch to make that consistent. It's been 
bugging me already (having to always remember if to pass in nr_pages or 
end).

-- 
Thanks,

David / dhildenb

