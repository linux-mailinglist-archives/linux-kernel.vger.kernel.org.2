Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3144169FC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 04:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243911AbhIXCZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 22:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243850AbhIXCZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 22:25:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126B1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:24:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c1so7495594pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DBLPQkg/kO5ASFtfk+t/XeZTp3dTZPnTRFF3O4rADL4=;
        b=OeuIzFZdiPEedGDiO7PxecdOHaoDHoTfxluMloCmEd90h+Z9DyM5f2FZgVh5QNeyCe
         0qcVxQtpMNz4GE7zwUPnwtd0fITYQXT8qttxxDOu3ZZxSb7OETT0cm/EvrJ2M8oB5X/b
         8sojVxAqPBXbkki2p7e82AZx0EFik2lyIXgG4QqdI0puJIXfUCw5BQ0XIhO7r80bKLwX
         hqRqwnh24DK7qT5QOJCTX7i1nGo8KrRZ+W4luPiB4YxvJTWZVchK6ufD2jiwCwIlzDVq
         nk3E4JcR7Mem3HQOr+wHqlvGVlnViAaLOr0hWGRYMtNqTh35huChocYJQ37R8GDFYlvd
         ru9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DBLPQkg/kO5ASFtfk+t/XeZTp3dTZPnTRFF3O4rADL4=;
        b=faYl1MCZwjKETza9pUo/0rGz+7R5cyGG2zVVx0yn/s+UUB4NjmTPSvy0YcjlKRUVkP
         s9wuFFXExOiSWTe7rbnK7lOGYalOLhZGnHu8c6Q4YtjNLmExJdpp1sDZvg9WELSefIM7
         sldFZAG5RGlEqWcPyy3JyAH9bZLWWwJgYc1LVyfSvZxL5NVK+ukfyQ/WMbI8BoWCCKJq
         WPbmDM5lGeVEiJO/C4P1RB9T8YHcl2doXSwThtERfaYIpRKqx1Ei1pPMnfiO2Sz/Jdv4
         8roRF2e2v1i0opUGFvhXgsKq1Nf9Hf6RmLtA3Lbkl1/iq4uyt1yycEplqdHAk6HZZFGl
         Wz3w==
X-Gm-Message-State: AOAM533XC68oYAlRgNM4LCVqdHfW5iyJXG8P/ZniN08suteawNGZ6Plg
        GXphYUeKW4Gv0mkcsiIRSyvfvQ==
X-Google-Smtp-Source: ABdhPJwrZpmVouPmoXMnwC2oolb/vsvPAPc9nLZvI0gmbK4/alFFziPzIc437ps2DG64MtjpEKOW1w==
X-Received: by 2002:a63:ed17:: with SMTP id d23mr1703047pgi.29.1632450250572;
        Thu, 23 Sep 2021 19:24:10 -0700 (PDT)
Received: from [10.255.74.217] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id q2sm10249656pjo.27.2021.09.23.19.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 19:24:10 -0700 (PDT)
Subject: Re: [PATCH] mm/memory_failure: Fix the missing pte_unmap() call
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
References: <20210923122642.4999-1-zhengqi.arch@bytedance.com>
 <20210923161738.990b61933c96df78bc1bf96d@linux-foundation.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <2eca94ce-4e26-aff6-240d-39baf1a9cc36@bytedance.com>
Date:   Fri, 24 Sep 2021 10:24:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923161738.990b61933c96df78bc1bf96d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/21 7:17 AM, Andrew Morton wrote:
> On Thu, 23 Sep 2021 20:26:42 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>> The paired pte_unmap() call is missing before the
>> dev_pagemap_mapping_shift() returns. So fix it.
>>
>> ...
>>
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -306,6 +306,7 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>>   		struct vm_area_struct *vma)
>>   {
>>   	unsigned long address = vma_address(page, vma);
>> +	unsigned long ret = 0;
>>   	pgd_t *pgd;
>>   	p4d_t *p4d;
>>   	pud_t *pud;
>> @@ -330,10 +331,12 @@ static unsigned long dev_pagemap_mapping_shift(struct page *page,
>>   		return PMD_SHIFT;
>>   	pte = pte_offset_map(pmd, address);
>>   	if (!pte_present(*pte))
>> -		return 0;
>> +		goto unmap;
>>   	if (pte_devmap(*pte))
>> -		return PAGE_SHIFT;
>> -	return 0;
>> +		ret = PAGE_SHIFT;
>> +unmap:
>> +	pte_unmap(pte);
>> +	return ret;
>>   }
>>   
> 
> This is neater?

Yes, and I see this neater version has merged into your mm tree,
thanks. :)

> 
> +++ a/mm/memory-failure.c
> @@ -330,11 +330,8 @@ static unsigned long dev_pagemap_mapping
>   	if (pmd_devmap(*pmd))
>   		return PMD_SHIFT;
>   	pte = pte_offset_map(pmd, address);
> -	if (!pte_present(*pte))
> -		goto unmap;
> -	if (pte_devmap(*pte))
> +	if (pte_present(*pte) && pte_devmap(*pte))
>   		ret = PAGE_SHIFT;
> -unmap:
>   	pte_unmap(pte);
>   	return ret;
>   }
> _
> 
