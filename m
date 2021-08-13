Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6673EADD5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 02:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhHMAVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 20:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhHMAVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:21:32 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97A4C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 17:21:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d17so9586774plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 17:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jPOasYiBAcjG9pv11zmhOsUezGxQh8Ee+W8L/ZGWhXE=;
        b=Ucsw6v7F1/7OrQNGaQv6pTULwv5MHBtWCvb27jnzWJtP2n85q1GxWLopCu354aJfLM
         MR/o+T1kNXS3HBXN6/BXF2t5qtOsc7kaHFIgH2OUXrm2MTHoGQgcDfYhuPlfUHp9NvlQ
         TuS+xd4bdJbA4Tse+EZr7HouuH634AaflULJR+4AuaJLK1EXeq9RyquIdWVw1MZIH/tZ
         WO+3+y8M0asx6RjlDnpiEdeJ171TN8Ib10X08Z6ism/3AUZgng6P8Ha/Nueokg90u1DL
         kfdPt9MDV1aTQb0mWjr22j/HM8O1T7XkxDtxLkPOeGwG/MAiVLIwzIPPZ2QTRLlhqdqD
         AzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPOasYiBAcjG9pv11zmhOsUezGxQh8Ee+W8L/ZGWhXE=;
        b=ZJgtKWk0zjZx1UBAhu2om8jPT7BrJVrr9JxrvH/TEjx1aM4aejmxyGN23QCg7rJq+k
         JHIvJ5ihHgW6Cm7sNtcXbq9dCpTJDsS/luGOJaMukLFY6JxlNOcGCuRav+126LGjD+kR
         y4uwP5ldrs6092HUn/OHmyF4E497d1JPld04TbpAFpss/0rR4puAcNfnvrMTJpEnx3tK
         6c27gOEepzktuZlQaRsDv2nsNU6sW72enjKUHhdqfjjowbDYuqcpRarVRztQmLX/9cHr
         HBbLTbI5Smq1+CwmP60jHwYCK5qCHdpENsid2+s8c4684yymIqrnnKaWCQpmUTbNP7Gd
         JkAw==
X-Gm-Message-State: AOAM532Zm2ooVOK5g0ihN3knioV+h3PaaBGHT3a/CbF25PwJukCvvqHg
        /g1pFEskWcfN1OA2ElFtLNlljS5ucy0=
X-Google-Smtp-Source: ABdhPJxeJzQTTki0QzVX/bcIs+hRPolDk7b10eftkkr7ujda30hSu8XaKsdtDBfvSl21VRgIAKMYaQ==
X-Received: by 2002:a63:4e11:: with SMTP id c17mr6120172pgb.54.1628814066103;
        Thu, 12 Aug 2021 17:21:06 -0700 (PDT)
Received: from [10.69.57.159] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n23sm4846116pgv.76.2021.08.12.17.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 17:21:05 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: don't corrupt pcppage_migratetype
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210811182917.2607994-1-opendmb@gmail.com>
 <e9393682-5429-448a-d151-a3ee05216499@suse.cz>
From:   Doug Berger <opendmb@gmail.com>
Message-ID: <b5020966-c7dd-54b2-9e6a-e1d21a23d267@gmail.com>
Date:   Thu, 12 Aug 2021 17:21:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e9393682-5429-448a-d151-a3ee05216499@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/2021 1:17 AM, Vlastimil Babka wrote:
> On 8/11/21 8:29 PM, Doug Berger wrote:
>> When placing pages on a pcp list, migratetype values over
>> MIGRATE_PCPTYPES get added to the MIGRATE_MOVABLE pcp list.
>>
>> However, the actual migratetype is preserved in the page and
>> should not be changed to MIGRATE_MOVABLE or the page may end
>> up on the wrong free_list.
> 
> Nice, how did you find out? Were there any user-visible effects? (Hint: which?
> the changelog should say that so that the severity of the bug can be judged).
> Otherwise I agree the bug is there and patch is fixing it. Thanks.

I did not observe the bug "in the wild", but rather noticed it while
reviewing the current CMA implementation. I would imagine in the worst
case that CMA memory could leak onto MIGRATE_MOVABLE free_lists and get
"stolen" through fallback for MIGRATE_UNMOVABLE allocations effectively
breaking CMA.

For full disclosure I should take this opportunity to say that I am
investigating ways to improve the CMA/Movable memory implementations
somewhat in line with what Joonsoo Kim has been trying, which is why I
observed this bug.

However, I largely agree with the proposal Mel Gorman made in his
comments on:
https://lkml.org/lkml/2016/4/28/244

I can appreciate that zones may provide a convenient way of grouping
memory with common attributes, but it is a bastardization of the
original intention of zones. I would prefer a mechanism for designating
blocks of memory as "sticky" movable such that they can only be used to
satisfy movable memory requests and not be converted to other
migratetypes. I've wrestled with the terminology and currently favor
Designated Movable Blocks (as opposed to "sticky") because these are
blocks of memory that have the movable attribute by designation rather
than by default or accident.

While CMA blocks should be a subset of Designated Movable Blocks since
they have the same migration properties, it may be desirable/necessary
to maintain a distinction to accommodate competing allocation
objectives. Specifically, Designated Movable Blocks used by CMA to
satisfy the needs of drivers will likely want the page allocator to be
less aggressive than users of Memory Hot-plug or kernelcore= Designated
Movable Blocks. Perhaps a round-robin scheme with MIGRATE_MOVABLE can
satisfy all users, but I'm not too optimistic.

I don't know if Mel has changed his opinions on this matter, but any
suggestions and encouragement are appreciated.

Thanks,
    Doug

> 
>> Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
>> Signed-off-by: Doug Berger <opendmb@gmail.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
>> ---
>>  mm/page_alloc.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 73704e836649..8addb4919f75 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3436,19 +3436,10 @@ void free_unref_page_list(struct list_head *list)
>>  		 * comment in free_unref_page.
>>  		 */
>>  		migratetype = get_pcppage_migratetype(page);
>> -		if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
>> -			if (unlikely(is_migrate_isolate(migratetype))) {
>> -				list_del(&page->lru);
>> -				free_one_page(page_zone(page), page, pfn, 0,
>> -							migratetype, FPI_NONE);
>> -				continue;
>> -			}
>> -
>> -			/*
>> -			 * Non-isolated types over MIGRATE_PCPTYPES get added
>> -			 * to the MIGRATE_MOVABLE pcp list.
>> -			 */
>> -			set_pcppage_migratetype(page, MIGRATE_MOVABLE);
>> +		if (unlikely(is_migrate_isolate(migratetype))) {
>> +			list_del(&page->lru);
>> +			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
>> +			continue;
>>  		}
>>  
>>  		set_page_private(page, pfn);
>> @@ -3458,7 +3449,15 @@ void free_unref_page_list(struct list_head *list)
>>  	list_for_each_entry_safe(page, next, list, lru) {
>>  		pfn = page_private(page);
>>  		set_page_private(page, 0);
>> +
>> +		/*
>> +		 * Non-isolated types over MIGRATE_PCPTYPES get added
>> +		 * to the MIGRATE_MOVABLE pcp list.
>> +		 */
>>  		migratetype = get_pcppage_migratetype(page);
>> +		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
>> +			migratetype = MIGRATE_MOVABLE;
>> +
>>  		trace_mm_page_free_batched(page);
>>  		free_unref_page_commit(page, pfn, migratetype, 0);
>>  
>>
> 

