Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDAD37975E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhEJTFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbhEJTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:05:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1472BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:04:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id x188so14278546pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WQ3UlPMi8iO1JweMxxShHAfYCCuhz0sN8zAS6TXgeZ8=;
        b=vd4BMadKXX2VYgCwHP2rz/WhOyv8UV+3Nk1yGWi1MWwBuhF4Mb4GRq5sxXn4AEuYdL
         dLlUqxkd1lWXDByZ2We6cegOkUUHrhOH5WFhT/RnRyS9O9Ma2v674hwJ2hbrWTiO0Mjw
         ny/SeUMfYOLdb3OSL9sDDLLyfsgNEU2inDnK2LmM6HmtSLKhrxmST9EVM8PtIP57ze7e
         0gFip1GIGoXL9gpDsnDbeyh7x8uqVeW4m8YXy3Pjh79KTVGWJRDitG6EjQXkm0j3vOGN
         UUGKo2g7dnwrzaPC8gzO4YFIBXKvsREJrkxf0gSESM3qCHywcPiSFYG34qYlPYQbZ+T3
         Gb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WQ3UlPMi8iO1JweMxxShHAfYCCuhz0sN8zAS6TXgeZ8=;
        b=H/BPlkC6aJZNbKVejr2+36SdeHGBTrJ6DUD638EohH3Tp6Xk4P8FlTD3hEG2rAJKaH
         6K3Z1cBJ1BwFzHGpXugWc4m4lMUEJo5zqJB0HTPhgb/5qmdwyctd+rVhHiJEDUB16qp1
         ZHquj7F51bTsYADR4NPcDJfxwqnfTE4dtKVCwIpRH07ShOviZu174xpsWlRrT9O/NWin
         1MlDESlR4i+22x7yjTtnx7bVFq7Bx9I/gRUnJEwka0xc8TacFyj30+OVM+yzCKYxT6Uo
         JMDjqqfXuWKUqHY3tN9CFuzo3RE6iaBoY2RZCe5ZC0iUEHmTyHsiJRZjWIvLdRx8HRvw
         kJCA==
X-Gm-Message-State: AOAM531Yo44oOYNB3QjEUdgWvElrlmlnqFY7T/2Gxx2d+V1htzcUtxOI
        MUI5abCbbjDMKfIlMbeIjY0=
X-Google-Smtp-Source: ABdhPJyfcWJULySA3pD+719piBeBcWvrLBFc8WnyM7QHhcOIc5yXuHy57rzrSbcSkDQFpBH4yBwBvw==
X-Received: by 2002:a63:e30d:: with SMTP id f13mr22059947pgh.201.1620673443541;
        Mon, 10 May 2021 12:04:03 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p19sm11552318pff.206.2021.05.10.12.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 May 2021 12:04:03 -0700 (PDT)
Subject: Re: Regression when booting 5.15 as dom0 on arm64 (WAS: Re:
 [linux-linus test] 161829: regressions - FAIL)
To:     Julien Grall <julien@xen.org>, Christoph Hellwig <hch@lst.de>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org,
        osstest service owner <osstest-admin@xenproject.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        iommu@lists.linux-foundation.org
References: <osstest-161829-mainreport@xen.org>
 <4ea1e89f-a7a0-7664-470c-b3cf773a1031@xen.org> <20210510084057.GA933@lst.de>
 <8b851596-acf7-9d3b-b08a-848cae5adada@xen.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <2c19af0b-e4c1-4f57-19cd-a86b4dc18c35@gmail.com>
Date:   Mon, 10 May 2021 12:04:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <8b851596-acf7-9d3b-b08a-848cae5adada@xen.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2021 11:15 AM, Julien Grall wrote:
> Hi Christoph,
> 
> On 10/05/2021 09:40, Christoph Hellwig wrote:
>> On Sat, May 08, 2021 at 12:32:37AM +0100, Julien Grall wrote:
>>> The pointer dereferenced seems to suggest that the swiotlb hasn't been
>>> allocated. From what I can tell, this may be because swiotlb_force is
>>> set
>>> to SWIOTLB_NO_FORCE, we will still enable the swiotlb when running on
>>> top
>>> of Xen.
>>>
>>> I am not entirely sure what would be the correct fix. Any opinions?
>>
>> Can you try something like the patch below (not even compile tested, but
>> the intent should be obvious?
>>
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 16a2b2b1c54d..7671bc153fb1 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -44,6 +44,8 @@
>>   #include <asm/tlb.h>
>>   #include <asm/alternative.h>
>>   +#include <xen/arm/swiotlb-xen.h>
>> +
>>   /*
>>    * We need to be able to catch inadvertent references to memstart_addr
>>    * that occur (potentially in generic code) before
>> arm64_memblock_init()
>> @@ -482,7 +484,7 @@ void __init mem_init(void)
>>       if (swiotlb_force == SWIOTLB_FORCE ||
>>           max_pfn > PFN_DOWN(arm64_dma_phys_limit))
>>           swiotlb_init(1);
>> -    else
>> +    else if (!IS_ENABLED(CONFIG_XEN) || !xen_swiotlb_detect())
>>           swiotlb_force = SWIOTLB_NO_FORCE;
>>         set_max_mapnr(max_pfn - PHYS_PFN_OFFSET);
> 
> I have applied the patch on top of 5.13-rc1 and can confirm I am able to
> boot dom0. Are you going to submit the patch?

Sorry about that Julien and thanks Christoph!
-- 
Florian
