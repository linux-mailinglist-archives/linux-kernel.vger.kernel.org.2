Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3581B35B6F2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhDKVBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhDKVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:01:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C13C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Kff/vuXZY4KcqPcN4appKlL5R1PwDKRuBaOkmR4fHU0=; b=YGirTqNowq6qHGEuh1isXqZdlS
        tvCjV55D4ztYhNYIixFK0K/2PmuQFHVizS9E6uZar2k/g5NYqtB7ifFFLnRN8IB2vF9tRSroSRGy/
        wloNMJfpjU7TlhtXH8+ge0PDZtwmCADNNRHtx/ny5GfIFL5fz7LEUC++5H6VtpiMDHfZVcMFHYtJg
        azB4tukOqf/98hbSsFSGe9EAWGtTJhR1j5Va/5N+affZXEPQycqyN21MGDIQ5Fv3gZjUfdWr350Y7
        U98z4ZRJPydXc90iLgI7s0wJocLeYxNFzG9l7dqAB1U7RO5fQx5YeT6+U9jyMAX1uD/HHmFdiW7Mu
        RieCOJVg==;
Received: from [2601:1c0:6280:3f0::e0e1]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVhCm-003PqL-SV; Sun, 11 Apr 2021 21:01:17 +0000
Subject: Re: [PATCH] mm: eliminate "expecting prototype" kernel-doc warnings
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <20210411174321.7013-1-rdunlap@infradead.org>
 <20210411183545.GD2531743@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8a65e36-74dd-9b86-55dd-b422f5a6655f@infradead.org>
Date:   Sun, 11 Apr 2021 14:01:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210411183545.GD2531743@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/21 11:35 AM, Matthew Wilcox wrote:
> On Sun, Apr 11, 2021 at 10:43:21AM -0700, Randy Dunlap wrote:
>> +++ linux-next-20210409/mm/mmu_gather.c
>> @@ -250,7 +250,7 @@ void tlb_flush_mmu(struct mmu_gather *tl
>>  }
>>  
>>  /**
>> - * tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
>> + * __tlb_gather_mmu - initialize an mmu_gather structure for page-table tear-down
>>   * @tlb: the mmu_gather structure to initialize
>>   * @mm: the mm_struct of the target address space
>>   * @fullmm: @mm is without users and we're going to destroy the full address
> 
> I think this is the wrong fix.  __tlb_gather_mmu is static, so documenting
> it isn't going to do much good.  Instead, this doc should be moved
> down to tlb_gather_mmu().  For bonus points, add documentation for
> tlb_gather_mmu_fullmm().

I'll certainly add the doc for tlb_gather_mmu_fullmm()  -- don't want to
lose that @fullmm: comment.

> 
>> --- linux-next-20210409.orig/mm/oom_kill.c
>> +++ linux-next-20210409/mm/oom_kill.c
>> @@ -171,10 +171,11 @@ static bool oom_unkillable_task(struct t
>>  }
>>  
>>  /**
>> - * Check whether unreclaimable slab amount is greater than
>> - * all user memory(LRU pages).
>> + * should_dump_unreclaim_slab - Check whether unreclaimable slab amount
>> + * is greater than all user memory (LRU pages).
>> + *
>>   * dump_unreclaimable_slab() could help in the case that
>> - * oom due to too much unreclaimable slab used by kernel.
>> + * oom is due to too much unreclaimable slab used by kernel.
>>  */
>>  static bool should_dump_unreclaim_slab(void)
> 
> This is static.  I'd just remove the second '*' and turn it into a
> non-kernel-doc comment.

Done.

>>  {
>> --- linux-next-20210409.orig/mm/shuffle.c
>> +++ linux-next-20210409/mm/shuffle.c
>> @@ -148,7 +148,7 @@ void __meminit __shuffle_zone(struct zon
>>  }
>>  
>>  /**
>> - * shuffle_free_memory - reduce the predictability of the page allocator
>> + * __shuffle_free_memory - reduce the predictability of the page allocator
>>   * @pgdat: node page data
>>   */
>>  void __meminit __shuffle_free_memory(pg_data_t *pgdat)
> 
> Nobody calls __shuffle_free_memory() directly.  If anything, the doc
> should be moved to shuffle_free_memory().  But since it has precisely
> one caller, and it's within mm/, I'm more inclined to leave this comment
> where it is and turn it into a non-kernel-doc comment.  Thoughts?
> 

Sounds good. Thanks. v2 coming soon.

-- 
~Randy

