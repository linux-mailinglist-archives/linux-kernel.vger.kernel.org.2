Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E23F7129
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbhHYIjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:39:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbhHYIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629880706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WbFTSPWjWmdzFcIoM8QePiF1gcVWuKexFnmCVr4uGQE=;
        b=bIzSmrx2FO6UQ0vXhZyInZgIdhg5SP2ww6ThG7BgoFHhQm7Mu31yUsbxbiXgtWB/nroet8
        y1R/6n8luPHWpCnrCQAWJhwfbC1YqvBmzqPWdgiqV81W+d0CoYRxOGAdciBVuZg2f24KW6
        3N7n2j7XThu1dSqMVERChKosx/a+Y64=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-kznWAHT6NoGumWaUBFadqg-1; Wed, 25 Aug 2021 04:38:25 -0400
X-MC-Unique: kznWAHT6NoGumWaUBFadqg-1
Received: by mail-wm1-f71.google.com with SMTP id j33-20020a05600c48a100b002e879427915so1534183wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 01:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=WbFTSPWjWmdzFcIoM8QePiF1gcVWuKexFnmCVr4uGQE=;
        b=TETjqT0MJ6BXV7kCChMPGscG4bcSXTQxvby2bMMh1rzOVs6gJ7JqGp/hDXST/HF2sv
         +02xhg/yWc8fVvqVFYpZ2RnhLaBnzCdZpZAmwylBI19WXxYY4BcjIoqMwJdEK6xdrzNc
         JGv+gN1z4pTFbN8ahaUtz+ePxH8u4xd2U1QksZ8eOxYwb6B63WYK7jj/d2rNyb5ALyCE
         zWlm7qY8trUMGcu0i9ht+ubIw+OQuFwQez6pqRipQ+HAZc8kxjRjITrSGqAfs+osYw/2
         z7CR9wUh6R2aUJ44rjBS5mvUKmv6I1eDxvMJl2P5HPV0DG8LMVGFelCsPYd9GSaMNCMw
         hozQ==
X-Gm-Message-State: AOAM533X7Uxrw7QULmQP2FuyvUIRltE+XK/lFfuYK2e9sOqRIT6Hr45A
        ALLYxqU3bMJymtXFS3IkCl6Hdf79yvjR1Kb4dlARaMtwA+Qa0td1d+SIrQ3l/P5j3SZG0Gj6We1
        yPK9ZqNixHvidtWodi3c3HleHVI1TvfXEfUJAIAL1DndUFwGiyS53Hw18ObAQyg/SyJiICk9f
X-Received: by 2002:a5d:638d:: with SMTP id p13mr18169077wru.223.1629880704201;
        Wed, 25 Aug 2021 01:38:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcxTSu+f6NvOxxXz2pL83gdFnm8n+Qoid7x4qixIQ0UMcFDx3pvvfVfrHZGLq8X6L0hbzG7Q==
X-Received: by 2002:a5d:638d:: with SMTP id p13mr18169059wru.223.1629880704006;
        Wed, 25 Aug 2021 01:38:24 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23d6b.dip0.t-ipconnect.de. [79.242.61.107])
        by smtp.gmail.com with ESMTPSA id 17sm4555894wmj.20.2021.08.25.01.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 01:38:23 -0700 (PDT)
To:     Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20210823132513.15836-1-rppt@kernel.org>
 <20210823132513.15836-5-rppt@kernel.org>
 <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 4/4] x86/mm: write protect (most) page tables
Message-ID: <1ec0d015-90fa-e2f4-c9ef-e63ec43a46b3@redhat.com>
Date:   Wed, 25 Aug 2021 10:38:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1cccc2b6-8b5b-4aee-483d-f10e64a248a5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.08.21 01:50, Dave Hansen wrote:
> On 8/23/21 6:25 AM, Mike Rapoport wrote:
>>   void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>>   {
>> +	enable_pgtable_write(page_address(pte));
>>   	pgtable_pte_page_dtor(pte);
>>   	paravirt_release_pte(page_to_pfn(pte));
>>   	paravirt_tlb_remove_table(tlb, pte);
>> @@ -69,6 +73,7 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>>   #ifdef CONFIG_X86_PAE
>>   	tlb->need_flush_all = 1;
>>   #endif
>> +	enable_pgtable_write(pmd);
>>   	pgtable_pmd_page_dtor(page);
>>   	paravirt_tlb_remove_table(tlb, page);
>>   }
> 
> I would expected this to have leveraged the pte_offset_map/unmap() code
> to enable/disable write access.  Granted, it would enable write access
> even when only a read is needed, but that could be trivially fixed with
> having a variant like:

For write access you actually want pte_offset_map_locked(), but it's 
also used for stable read access sometimes (exclude any writers).

> 
> 	pte_offset_map_write()
> 	pte_offset_unmap_write()
> 
> in addition to the existing (presumably read-only) versions:
> 
> 	pte_offset_map()
> 	pte_offset_unmap()

These should mostly only be read access, you'd need other ways of making 
sure nobody else messes with that entry. I think it even holds for 
khugepaged collapsing code.


I find these hidden PMD entry modifications (e.g., without holding the 
PMD lock) deep down in arch code quite concerning. Read: horribly ugly 
and a nightmare to debug.

-- 
Thanks,

David / dhildenb

