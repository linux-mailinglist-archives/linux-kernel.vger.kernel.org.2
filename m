Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892FE416210
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbhIWPbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbhIWPbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:31:37 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF51C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:30:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r2so6696538pgl.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZUy1p6PSvt5yN2wZ9JfbzOdoAH6IHdQaxa/WlcclC5A=;
        b=vBJT9bZ8UIrkJtobhhnlh/mB+9KIPZv0ORskTyPFxmF+FPTxARiT5mBkoOp4F9mJks
         oV6BXGQb/eIRLo7yw1UkrIb4oA8h6QSYDosiir5tiSGZwJ+1XGFfReDn0ZXK8DbWv0vG
         uXpJw66fJjk1G80xiF43wKowpDLn/Dnw+1zbv7nSJQaMK6KiO2dFFkW/lAJIkffK5qTN
         NNdqalKGAv57XsF3w27sPN4uY7kOE3bDk+4bdgW192dqqnKkvA3aTuh8rBj50AFs73i6
         5V03TECnDljVWWcxfxdIQCL64+pM8IfCp114L/JzIkqAhlj+9SMt3/kadYYWaQOMqGef
         6unQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZUy1p6PSvt5yN2wZ9JfbzOdoAH6IHdQaxa/WlcclC5A=;
        b=RPg/kJN3KHvVWlVDrPErlhV6M7QAl9j4fgcmcExNoridjr5WAbSYvj6a+Dy5qAZBl2
         56Sy1nmlTKJR9ELSMHwdt+EpmrvFTm3OowcCtaYJrinR6xv2blFxppX1jR3oJCtYLwem
         wG2RgYSjo+9c3nW1FlDk6gXEoCVTp7h2Dfje6Ozp1lyCdd1izEBEoFBygPgUviEWb0WP
         c78Z0V0kzxV3PvkQuSGPcvryQid8WwERliuFBspKOsqWDch+F0Gl+EoJca/k3SlRP93+
         dEZZFn9zrLkJOzs1S2KWcbdlWSwriCVq6DdBUwnWQ1e1+vguK+n/KoH0eynULJjewiSq
         g5Uw==
X-Gm-Message-State: AOAM532xwgGmScCF2Z1ocQu00aeGg9WPUve5HMZhwQ+lClIDjnUB2CB5
        w2zDAKY6H8ymGDjlmQjHZ1BOMlCfp6xckw==
X-Google-Smtp-Source: ABdhPJzlRgeEr2IwjeVRqkMvNkcTvR86bvibTMPjWX++/ibNnSHZgn4GAdjqkrTH9WD3WFAmx9RjCg==
X-Received: by 2002:a65:6107:: with SMTP id z7mr4762144pgu.43.1632411005784;
        Thu, 23 Sep 2021 08:30:05 -0700 (PDT)
Received: from [10.255.74.217] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id h10sm9044360pjs.51.2021.09.23.08.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:30:05 -0700 (PDT)
Subject: Re: [PATCH] mm/memory_failure: Fix the missing pte_unmap() call
To:     David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
References: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
 <7330e2e0-9dc4-e412-a821-ed62a469371d@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <7a93c298-fd78-1963-a9f6-b4a7191bf747@bytedance.com>
Date:   Thu, 23 Sep 2021 23:30:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7330e2e0-9dc4-e412-a821-ed62a469371d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 11:19 PM, David Hildenbrand wrote:
> On 23.09.21 14:26, Qi Zheng wrote:
>> The paired pte_unmap() call is missing before the
>> dev_pagemap_mapping_shift() returns. So fix it.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memory-failure.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index e2984c123e7e..4e5419f16fd4 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -306,6 +306,7 @@ static unsigned long 
>> dev_pagemap_mapping_shift(struct page *page,
>>           struct vm_area_struct *vma)
>>   {
>>       unsigned long address = vma_address(page, vma);
>> +    unsigned long ret = 0;
>>       pgd_t *pgd;
>>       p4d_t *p4d;
>>       pud_t *pud;
>> @@ -330,10 +331,12 @@ static unsigned long 
>> dev_pagemap_mapping_shift(struct page *page,
>>           return PMD_SHIFT;
>>       pte = pte_offset_map(pmd, address);
>>       if (!pte_present(*pte))
>> -        return 0;
>> +        goto unmap;
>>       if (pte_devmap(*pte))
>> -        return PAGE_SHIFT;
>> -    return 0;
>> +        ret = PAGE_SHIFT;
>> +unmap:
>> +    pte_unmap(pte);
>> +    return ret;
>>   }
>>   /*
>>
> 
> I guess this code never runs on 32bit / highmem, that's why we didn't 
> notice so far.

I guess so too.

> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 

Thanks,
Qi

