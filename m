Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C99326B44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 04:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhB0DIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 22:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhB0DIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 22:08:07 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC19C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:07:27 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b8so3481689plh.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=JBIul8fr3ZeQzXGpvzXjp7Ea1B9cqWbqLNAsQUjgvrw=;
        b=elNFiVlkdazF1u8TXmQ8v+imUcgYqv4KwcSMfFfeME3OjFEsxq8MFzDX8pQXcTdf/D
         n7zaMPDRm84cMQ3U99OJ7ZfhVz6VhnZBAZWvhc2b4rhOHXjqVNc2hgxkDoq1wcHPi/z6
         kIkw9ovs+djzz7fpP/IPOJvmnZ465q4pEBpqzZixaKLavlIkuk+zEZz3yDJmXRyMJu9o
         mNPZ4fD7q5Sx8OjF/DA3gSWTZNQeB/uWIIie9fgdnan1ZQyMIm26lQIhmLAKRXxZivIe
         CVMtQV0K8/kHJlkTZWDm4NKjumWLorx4gI54S8CfTt/1tqkEF6wYSO/YhplAQNuFtUZ8
         ccmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=JBIul8fr3ZeQzXGpvzXjp7Ea1B9cqWbqLNAsQUjgvrw=;
        b=Gn1DzNsfc4h8ntZoVUitYjeht/1rOWyXJn3a5osObsEqk3yRqNXVjh12B1L9gcGTy7
         cUq+5rcnaYfWqXpO45nPaRC3t6xIZxRlK+4e+LsEQ6fWzuoanfIFgwnjCWT9ihl72N2K
         w8traVfhXsnb29IG9UwEtpFhH7npWj+7adAlXhKSqMKlCI3+p/peI5Zas7tM7jg+H6eE
         SalXfNyBwx0hDbdWnmxHVOTQz6Dk8Y+i1q10sbxDCwPDFg7mwtU8vlhEPtUaonuBMeYU
         4SbCwmnU8kk5hM72zqXanzX0UXor906tWjjwdKS//xmZJ5NFhGzawKqUbUfNSsnNNCRt
         miLQ==
X-Gm-Message-State: AOAM531/M3a+Fzqn15qm3im+lyeCklVjTV9ur+UYfjComuc6ydLrmRAG
        tQBiLki3OSfDxMXEbyVpnX+tbIha+tsS5uVr
X-Google-Smtp-Source: ABdhPJy2NCmISIzqWRxPxTNogNB1OKA8LwJ9bHBHqUgIGFVilKwWdezAfYjMxNoYH7F2UwzMDxZesA==
X-Received: by 2002:a17:90a:e616:: with SMTP id j22mr6392414pjy.190.1614395246739;
        Fri, 26 Feb 2021 19:07:26 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o127sm10708708pfg.202.2021.02.26.19.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 19:07:25 -0800 (PST)
Date:   Fri, 26 Feb 2021 19:07:25 -0800 (PST)
X-Google-Original-Date: Fri, 26 Feb 2021 19:07:24 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Make NUMA depend on SMP
In-Reply-To: <e76cf929-ba52-6d53-9ac8-ef403f9b1f4f@huawei.com>
CC:     akpm@linux-foundation.org, atishp@atishpatra.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-9b0ca6d2-c491-4bd8-a9c8-0b2793694576@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021 17:03:53 PST (-0800), wangkefeng.wang@huawei.com wrote:
>
> On 2021/2/27 4:25, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmerdabbelt@google.com>
>>
>> In theory these are orthogonal, but in practice all NUMA systems are
>> SMP.  NUMA && !SMP doesn't build, everyone else is coupling them, and I
>> don't really see any value in supporting that configuration.
>>
>> Fixes: 4f0e8eef772e ("riscv: Add numa support for riscv64 platform")
>> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
>> Suggested-by: Atish Patra <atishp@atishpatra.org>
>> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
>
> Reported-and-Tested-by:  Kefeng Wang <wangkefeng.wang@huawei.com>

Ah, thanks, I forged I'd said no to this earlier ;)

>
>
>> ---
>> This is on fixes.
>> ---
>>   arch/riscv/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index a998babc1237..85d626b8ce5e 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -314,6 +314,7 @@ endchoice
>>   # Common NUMA Features
>>   config NUMA
>>   	bool "NUMA Memory Allocation and Scheduler Support"
>> +	depends on SMP
>>   	select GENERIC_ARCH_NUMA
>>   	select OF_NUMA
>>   	select ARCH_SUPPORTS_NUMA_BALANCING
