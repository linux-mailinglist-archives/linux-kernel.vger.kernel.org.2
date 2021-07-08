Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219103BF3A7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 03:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhGHBvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 21:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhGHBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 21:51:18 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC4AC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 18:48:36 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id x3so2102738pll.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 18:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AeCyKvKQjgmbacxYTAcqC8M+hyMuT56UzWGesj9goYg=;
        b=siCDe7rwb2ksD6+7NOE34Ocen/HSi/o1yJ7IAZzHsyweZpBFrCGImKGVxejhS1n8MI
         kqwQhzBo9C7tcww+xSojdDNMcmC0k1socuPX8ytj+nAIQAPg52mv6Mw+IFQL0/D6BAky
         MzhNJwvP8j+nyJafuNSYnXxp3ti9QEpf0twpgad9tQpn8qgi8SXslClYCl++qLV/DUlV
         G/ps+yrBzYxqWs1TVSpMZ/zMlei4q4otMoHT9eww9n3Qo4viqWa3kkOrCrocEaalwZ3v
         dcIJtp3uPJuq8APM3qJ6+tQ+RT2lheabEfMUaMPxWONa7ZAJBCe9zARYTCWaYdvWBxO/
         3SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AeCyKvKQjgmbacxYTAcqC8M+hyMuT56UzWGesj9goYg=;
        b=UkPYmzu7RDza1+3fndI25HCcQkrDuzyW6s8Q1kjViXEYZHwVz6uZBOLtCK2/d+IxUi
         XFBrSy4/TabxNjJ8EoAO7RcLSdkYeIPTBMU+t3vGr2NwelvN5WOXSTCi91SOV9wpxgwy
         qdLYeDAn3lQWaq9PNTZ0cQ4o6mP1Itz7ogcSD7+mkAFoezavLLBAriU8mi+Lhi7WdwWo
         Iel2D5I8aJ+vSBhO1it3bKzbR22PByCeQ1qTXg3PPsSogDjHBOm67NfWnxbHIH6mJYuM
         XA+TYX1KufKbRadDCW8vLkE44yDmLA8T7QrMjvFcPmoY9yz/S7kwzppEFfJBJRElW3Bv
         +VRA==
X-Gm-Message-State: AOAM532EAIZN/++69HFLESn2tQT2UdWQaPeHUDyLsLgeNoEVntZd7K3G
        loBSxeUhp9sNx14zHP63eEA=
X-Google-Smtp-Source: ABdhPJzI5BPhJfGVIvS5ui2RLQoxj/N7aDPdHcN6muKl2SFYbNtxFaz9hUUf4LC/1my2BpehQLQUXA==
X-Received: by 2002:a17:902:b7c5:b029:128:e537:52f7 with SMTP id v5-20020a170902b7c5b0290128e53752f7mr23815836plz.59.1625708915349;
        Wed, 07 Jul 2021 18:48:35 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id y1sm498995pfe.72.2021.07.07.18.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 18:48:34 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: avoid deadlocks for &pagesets.lock
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org, Zqiang <qiang.zhang@windriver.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
References: <20210707111245.625374-1-desmondcheongzx@gmail.com>
 <20210707122530.GU3840@techsingularity.net>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <b97a32b7-8b63-9f34-395c-bf902aa8a6d2@gmail.com>
Date:   Thu, 8 Jul 2021 09:48:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707122530.GU3840@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/21 8:25 pm, Mel Gorman wrote:
> On Wed, Jul 07, 2021 at 07:12:45PM +0800, Desmond Cheong Zhi Xi wrote:
>> Syzbot reports a number of potential deadlocks for &pagesets.lock. It
>> seems that this new lock is being used as both an inner and outer
>> lock, which makes it prone to creating circular dependencies.
>>
>> For example, one such call trace goes as follows:
>>    __alloc_pages_bulk()
>>      local_lock_irqsave(&pagesets.lock, flags) <---- outer lock here
>>      prep_new_page():
>>        post_alloc_hook():
>>          set_page_owner():
>>            __set_page_owner():
>>              save_stack():
>>                stack_depot_save():
>>                  alloc_pages():
>>                    alloc_page_interleave():
>>                      __alloc_pages():
>>                        get_page_from_freelist():
>>                          rm_queue():
>>                            rm_queue_pcplist():
>>                              local_lock_irqsave(&pagesets.lock, flags);
>>                              *** DEADLOCK ***
>>
>> The common culprit for the lockdep splats seems to be the call to
>> local_lock_irqsave(&pagesets.lock, flags) inside
>> __alloc_pages_bulk(). &pagesets.lock becomes an outer lock if it's
>> held during the call to prep_new_page().
>>
>> As the local lock is used to protect the PCP structure, we adjust the
>> locking in __alloc_pages_bulk so that only the necessary structures
>> are protected.
>>
>> Fixes: dbbee9d5cd83 ("mm/page_alloc: convert per-cpu list protection to local_lock")
>> Reported-and-tested-by: syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> 
> Hi Desmond,
> 
> Thanks for the report. Unfortunately, this patch incurs a performance
> penalty for the bulk allocator even if PAGE_OWNER is disabled. Can you
> try the following as an alternative please? It passed a build and boot
> test but I didn't try triggering the actual bug.
> 

Hi Mel,

Thanks for the feedback, I hadn't thought of the performance penalty. I 
think you're right that if the recursive call to __set_page_owner is 
avoided, then that also avoids creating the circular lock hierarchy.

Your proposed patch passed the Syzbot repro test:

Reported-and-tested-by: 
syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com

Best wishes,
Desmond

> --8<--
> mm/page_alloc: Avoid page allocator recursion with pagesets.lock held
> 
> Syzbot is reporting potential deadlocks due to pagesets.lock when
> PAGE_OWNER is enabled. One example from Desmond Cheong Zhi Xi is
> as follows
> 
>    __alloc_pages_bulk()
>      local_lock_irqsave(&pagesets.lock, flags) <---- outer lock here
>      prep_new_page():
>        post_alloc_hook():
>          set_page_owner():
>            __set_page_owner():
>              save_stack():
>                stack_depot_save():
>                  alloc_pages():
>                    alloc_page_interleave():
>                      __alloc_pages():
>                        get_page_from_freelist():
>                          rm_queue():
>                            rm_queue_pcplist():
>                              local_lock_irqsave(&pagesets.lock, flags);
>                              *** DEADLOCK ***
> 
> Zhang, Qiang also reported
> 
>    BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
>    in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
>    .....
>    __dump_stack lib/dump_stack.c:79 [inline]
>    dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
>    ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
>    prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
>    __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
>    alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
>    alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
>    stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
>    save_stack+0x15e/0x1e0 mm/page_owner.c:120
>    __set_page_owner+0x50/0x290 mm/page_owner.c:181
>    prep_new_page mm/page_alloc.c:2445 [inline]
>    __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
>    alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
>    vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
>    __vmalloc_area_node mm/vmalloc.c:2845 [inline]
>    __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
>    __vmalloc_node mm/vmalloc.c:2996 [inline]
>    vzalloc+0x67/0x80 mm/vmalloc.c:3066
> 
> There are a number of ways it could be fixed. The page owner code could
> be audited to strip GFP flags that allow sleeping but it'll impair the
> functionality of PAGE_OWNER if allocations fail. The bulk allocator
> could add a special case to release/reacquire the lock for prep_new_page
> and lookup PCP after the lock is reacquired at the cost of performance.
> Both options are relatively complex and the second one still incurs a
> performance penalty when PAGE_OWNER is active so this patch takes the
> simple approach -- disable bulk allocation of PAGE_OWNER is active. The
> caller will be forced to allocate one page at a time incurring a
> performance penalty but PAGE_OWNER is already a performance penalty.
> 
> Fixes: dbbee9d5cd83 ("mm/page_alloc: convert per-cpu list protection to local_lock")
> Reported-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> Reported-by: "Zhang, Qiang" <Qiang.Zhang@windriver.com>
> Reported-by: syzbot+127fd7828d6eeb611703@syzkaller.appspotmail.com
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>   mm/page_alloc.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b97e17806be..6ef86f338151 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5239,6 +5239,18 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
>   	if (nr_pages - nr_populated == 1)
>   		goto failed;
>   
> +#ifdef CONFIG_PAGE_OWNER
> +	/*
> +	 * PAGE_OWNER may recurse into the allocator to allocate space to
> +	 * save the stack with pagesets.lock held. Releasing/reacquiring
> +	 * removes much of the performance benefit of bulk allocation so
> +	 * force the caller to allocate one page at a time as it'll have
> +	 * similar performance to added complexity to the bulk allocator.
> +	 */
> +	if (static_branch_unlikely(&page_owner_inited))
> +		goto failed;
> +#endif
> +
>   	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
>   	gfp &= gfp_allowed_mask;
>   	alloc_gfp = gfp;
> 

