Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF57236E44C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 06:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbhD2EoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 00:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhD2EoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 00:44:06 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D96C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:43:20 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so10308161pjv.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 21:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sE2savxAfPxu0P92GN6OpAhX0O3eNjGvHwyPPUWKYXM=;
        b=BbKFsrcgMKJaZOVLDg+9Z0CXvzo42Bs4YtCgco8RWK06gIpsXcpSRcHtnm21RXdPag
         4AOSJCwn0TOJbK0rk5+7Leh4jED6MQpJRhgh4FX/gc286imJNECfydO1JA6qe5bWYh2C
         wIvXkDFCJg+QlmNxoYUmO7+0+Wv/38VQ7r8ofok18unzJkIODkz0IL3shy8pg2vHamPY
         dEqTLKKs7LELc70nV46Ds+h1PFT2uHN0+KSRkUHZ0NYtgBAkGFikYjAOJW1JmMD6DhdW
         YYqrJg5FH5yXQEpg+PDLKPHfD0KH9qOUP1/w7tli4LY1LN9mVWjGPsdjpsmJIS+MwAAj
         g5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sE2savxAfPxu0P92GN6OpAhX0O3eNjGvHwyPPUWKYXM=;
        b=tGz6agppf5Y81dGvQweOOW6Iyi4oY0KPbNEXBRVrlYJQEwTB8FKVLKqu/+HWv+LOgv
         enRndl312HQOtBVCUt1ONr6z0BiYF4htGe1sPgVwMrqma/adjBRw/HgdV2nXMfqGyujV
         xBHGZDe9PUWvYX8OVyvQDkq43DkYsSrEaa82ff18c3w7wu8D5NQjdnBdQn5TzJnY5wXD
         jGltx0DeSAJzYnfkMVtVNMwximIex3UIwOMC1lP9b7ovxihKfm8FODNkaJ1UxuwMNCbN
         TCU10kNfoUL6KnLCeXekklMiL4RuGsJkqAw+TH9lI4rAUk+UHOUvWbTfPVySofI0S3bU
         0RSg==
X-Gm-Message-State: AOAM531rbChORvIgECKv+kXZYSoTCtBqORlNAJhqPITcd9zXjuTfouqG
        DXb0U5Dfl1KovDKKZhh1bd5zTWq5HxUXMQ==
X-Google-Smtp-Source: ABdhPJzIZ4MO/M2q7pEFyxcjdg+AMdv6kInIrBs1Dge1k1V8H0zvz80UNnzL5Hf6btnS/YDAvJKmjg==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr7555235pjb.194.1619671400173;
        Wed, 28 Apr 2021 21:43:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a16sm1134447pgl.12.2021.04.28.21.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 21:43:19 -0700 (PDT)
Date:   Wed, 28 Apr 2021 21:43:19 -0700 (PDT)
X-Google-Original-Date: Wed, 28 Apr 2021 21:43:11 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Always define XIP_FIXUP
In-Reply-To: <b674bc91-8228-9236-f3ec-8f65bb5620c8@ghiti.fr>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        rppt@kernel.org, vitaly.wool@konsulko.com, greentime.hu@sifive.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        linux@roeck-us.net
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-2e1a7543-84bc-4954-843a-b577fc132157@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2021 01:25:55 PDT (-0700), alex@ghiti.fr wrote:
> Le 4/27/21 à 11:34 PM, Palmer Dabbelt a écrit :
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> XIP depends on MMU, but XIP_FIXUP is defined throughout the kernel in
>> order to avoid excessive ifdefs.  This just makes sure to always define
>> XIP_FIXIP, which will fix MMU=n builds.
>
> A small typo here.

Actually two: "defined" should have been "used".  Both are fixed.

>
>>
>> Fixes: 44c922572952 ("RISC-V: enable XIP")
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>> ---
>>   arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 2f1384e14e31..fd749351f432 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -73,18 +73,6 @@
>>   #endif
>>   #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>>
>> -#ifdef CONFIG_XIP_KERNEL
>> -#define XIP_OFFSET		SZ_8M
>> -#define XIP_FIXUP(addr) ({							\
>> -	uintptr_t __a = (uintptr_t)(addr);					\
>> -	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
>> -		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
>> -		__a;								\
>> -	})
>> -#else
>> -#define XIP_FIXUP(addr)		(addr)
>> -#endif /* CONFIG_XIP_KERNEL */
>> -
>>   #endif
>>
>>   #ifndef __ASSEMBLY__
>> @@ -101,6 +89,18 @@
>>   #include <asm/pgtable-32.h>
>>   #endif /* CONFIG_64BIT */
>>
>> +#ifdef CONFIG_XIP_KERNEL
>> +#define XIP_OFFSET		SZ_8M
>
>
> XIP_OFFSET is used in head.S and then this breaks XIP_KERNEL. XIP_OFFSET
> must live outside the ifndef __ASSEMBLY__.

Thanks, I hadn't even seen XIP_OFFSET.  This is fixed in the v2.

Do you have an XIP config that will run on QEMU, and a way to run it?  
If so, can you post a defconfig and some instructions?  That'll make it 
easier to test on my end.

>> +#define XIP_FIXUP(addr) ({							\
>> +	uintptr_t __a = (uintptr_t)(addr);					\
>> +	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
>> +		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
>> +		__a;								\
>> +	})
>> +#else
>> +#define XIP_FIXUP(addr)		(addr)
>> +#endif /* CONFIG_XIP_KERNEL */
>> +
>>   #ifdef CONFIG_MMU
>>   /* Number of entries in the page global directory */
>>   #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
>>
>
> Thank you for doing that!
>
> Alex
