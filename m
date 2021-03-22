Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C604344EB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhCVSl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhCVSle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:41:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E787C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:41:33 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id v70so11656558qkb.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U+OzOX7tjLVvQcXW/2k7+q38diVUE6BWa8EhfFT5RJs=;
        b=YMHAh/gWzPuf0VEggYbTbG614hsxqgo9KW9qdxoVQ0IHK9QvIl1jxuoR2I0L9X2SPM
         S26vCNZTKgq9BQimp5DcVUue0t37Ur0KYMgkfIWiRlt5CX/RCw2V4KE4v6ejymz5c5yr
         mNFCCC/0QSTGL16LrfLYAOZ0holnZ8mrMiDsCidmOrvjQ1ZKQtgkhkdGXIP0afqv3/nz
         iZpNwFOC1kWhts70rcU4hdw9IbFItB4UwRtaOF5QN0bST33E7q2iWWbM104USFsWliMu
         IxFAHj95OXKQkaOKhlsePt98AKWw5VMpLF9D5YamjZC8myreYa+n1/cdqAEY4bkrpezf
         FBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=U+OzOX7tjLVvQcXW/2k7+q38diVUE6BWa8EhfFT5RJs=;
        b=NjOD1LIJuYY/TjG3pSWc1Emocwc150YYj/FtkmgMAj4d1cfWEkJ/XZ9SXmLrpkmu+q
         CXydrMZWdxKR2RHY0PY5VgHIRgA6hdlCtix6Tu9wnKEIqgxIx5zvfuW9lKpgi/5zdUEX
         iEn0PFEJ6R7Rz61lF9xd+aFfwoY0ccWQ1w/rYTNkxgqSZTLIPbV9K4MBpB1tY8iH/YoR
         FH7Uo3TiLIMUHCYo/Y6GrqE4l73OYdk1FTrItZIRXi83t+hWU05Q04+PJGDtFhEUAiXV
         FIbN7MaHFGd3SpWFXThR1TVC/P7QIHZFnHE6J+N+JOVFRnGQAwJmMjGBEWgFyld9/x2r
         kG/A==
X-Gm-Message-State: AOAM530sGNOfpR2fCC0OkAZSeHRR6aBtUtbzURkEuI7R5+TKaceVkQgI
        8etsZNSkTWnnjEfIGmE/VAqGcA==
X-Google-Smtp-Source: ABdhPJzsLeBXiIg9Lg7vbIZbsh/HMI1xuQ4IrY/9LZR3BY4WQHFiqaJFUjqBWIijlOm1qhZ7u7lqxg==
X-Received: by 2002:a05:620a:630:: with SMTP id 16mr1564969qkv.304.1616438492694;
        Mon, 22 Mar 2021 11:41:32 -0700 (PDT)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id b22sm11718512qkk.45.2021.03.22.11.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 11:41:32 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] arm64: mm: reserve CMA and crashkernel in
 ZONE_DMA32
From:   Jon Masters <jcm@jonmasters.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20191107095611.18429-1-nsaenzjulienne@suse.de>
 <20191107095611.18429-3-nsaenzjulienne@suse.de>
 <4f094513-507d-566d-a0e2-a30ea36f64c9@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <d2cde732-a6d5-65d3-843a-e2f3fe498fde@jonmasters.org>
Date:   Mon, 22 Mar 2021 14:40:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4f094513-507d-566d-a0e2-a30ea36f64c9@jonmasters.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 2:34 PM, Jon Masters wrote:
> Hi Nicolas,
> 
> On 11/7/19 4:56 AM, Nicolas Saenz Julienne wrote:
>> With the introduction of ZONE_DMA in arm64 we moved the default CMA and
>> crashkernel reservation into that area. This caused a regression on big
>> machines that need big CMA and crashkernel reservations. Note that
>> ZONE_DMA is only 1GB big.
>>
>> Restore the previous behavior as the wide majority of devices are OK
>> with reserving these in ZONE_DMA32. The ones that need them in ZONE_DMA
>> will configure it explicitly.
>>
>> Reported-by: Qian Cai <cai@lca.pw>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> ---
>>   arch/arm64/mm/init.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 580d1052ac34..8385d3c0733f 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -88,7 +88,7 @@ static void __init reserve_crashkernel(void)
>>       if (crash_base == 0) {
>>           /* Current arm64 boot protocol requires 2MB alignment */
>> -        crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
>> +        crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
>>                   crash_size, SZ_2M);
>>           if (crash_base == 0) {
>>               pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>> @@ -454,7 +454,7 @@ void __init arm64_memblock_init(void)
>>       high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
>> -    dma_contiguous_reserve(arm64_dma_phys_limit ? : 
>> arm64_dma32_phys_limit);
>> +    dma_contiguous_reserve(arm64_dma32_phys_limit);
>>   }
>>   void __init bootmem_init(void)
> 
> Can we get a bit more of a backstory about what the regression was on 
> larger machines? If the 32-bit DMA region is too small, but the machine 
> otherwise has plenty of memory, the crashkernel reservation will fail. 
> Most e.g. enterprise users aren't going to respond to that situation by 
> determining the placement manually, they'll just not have a crashkernel.

Nevermind, looks like Catalin already changed this logic in Jan 2021 by 
removing arm64_dma32_phys_limit and I'm out of date.

Jon.

-- 
Computer Architect
