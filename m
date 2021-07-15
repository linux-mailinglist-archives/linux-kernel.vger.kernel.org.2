Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF93C98BB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 08:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbhGOGXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 02:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhGOGXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 02:23:01 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E62AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:20:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n10so2664918plk.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KEYRV18inQTvxQEnqR/XVe6/C5rX+tc+VWpSwxHYPA=;
        b=VKLtGA+Eu/71OhbovI75hGlNKv6anN9s84itIzsfFEminUCEj7EMW+9LuLjH4s8qyl
         qbPz62Qkv/52TuLe0OxHtGpTeN5XCIlLBF5ZfnVzAyox8b8uvekArNjyzf4CFoYoVL16
         VwtxPXcMa4pUGx5cjrofYbSvsc/QYbYXFUnZne9Q3kA5dPWAXC+UodCttN/Dl6KFh3yx
         xy8kJMhdRkAZobISbgNz3c9Vl3M5ujsTlDb0s11C3mfnI90HlRcU4y67bTr4hvgUJaLB
         3aIgzEjl/18UtraL0xRGv98D2/fDEpVb+yo817YdKlcnQjqCwjr+vhIwtsE25BM085mL
         LONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KEYRV18inQTvxQEnqR/XVe6/C5rX+tc+VWpSwxHYPA=;
        b=BYmmYdNZnltqROFYn69q3eKlYrSacReAqdMXJ0Gk6712+1pUn9OXipDZjvKElyMzKy
         XIBRQ9IDw4vMvktt5oQsTM1vLL1wTXcMwopMoaBUAgm4MuM2GC/LQ84bCPREQwQm/meK
         ODZ30j7szCDjY4k5Q0+89j4VxNpwekHc+MKcx2RHebf79JhSi7i6Voq695K47/1/FI2X
         j0oUBftBCh9UCR3A34zeHfGvjXgzibcU6asL41Yr2W6Tb+DsytTM+uXStCUw30mKKnZ2
         MtFUU7TelsZttvj4KTOFweqgMVfH1L4bnTa/T7xBWeACNjs1XuwNKWf0nb+KGPGYDEMJ
         UX1A==
X-Gm-Message-State: AOAM532KwW5x8VbHnCNFBgoPINXichGE0HRPpXYYGvQPXES4hesmfnvO
        GuKvZXQnzNOmnejmqE1mJ3zdaqGgeAc=
X-Google-Smtp-Source: ABdhPJyqZ7oJFlKXoHbeQ6MasTn8ZV58Ycg6hIwJbWFpqbmbcmtq3SDYKcAMtWPnMxOr005WRz7Lzg==
X-Received: by 2002:a17:90a:3e0f:: with SMTP id j15mr2678681pjc.178.1626330006434;
        Wed, 14 Jul 2021 23:20:06 -0700 (PDT)
Received: from [192.168.1.123] (M106072041033.v4.enabler.ne.jp. [106.72.41.33])
        by smtp.gmail.com with ESMTPSA id u21sm4937658pfh.163.2021.07.14.23.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 23:20:05 -0700 (PDT)
Cc:     akira.tsukamoto@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] riscv: __asm_copy_to-from_user: Optimize unaligned
 memory access and pipeline stall
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <3e1dbea4-3b0f-de32-5447-2e23c6d4652a@gmail.com>
 <60c1f087-1e8b-8f22-7d25-86f5f3dcee3f@gmail.com>
 <20210710014915.GA149706@roeck-us.net>
 <CAMuHMdWrrP37Kfp4yC8G5f6SvMtD6u_=JkqX-Nd97FS_mayYWQ@mail.gmail.com>
From:   Akira Tsukamoto <akira.tsukamoto@gmail.com>
Message-ID: <f0d06d39-3dc8-fb10-4d37-a75ef866cdc8@gmail.com>
Date:   Thu, 15 Jul 2021 15:20:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWrrP37Kfp4yC8G5f6SvMtD6u_=JkqX-Nd97FS_mayYWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/14/2021 3:10 AM, Geert Uytterhoeven wrote:
> Hi Günter, Tsukamoto-san,
> 
> On Sat, Jul 10, 2021 at 3:50 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Wed, Jun 23, 2021 at 09:40:39PM +0900, Akira Tsukamoto wrote:
>>> This patch will reduce cpu usage dramatically in kernel space especially
>>> for application which use sys-call with large buffer size, such as network
>>> applications. The main reason behind this is that every unaligned memory
>>> access will raise exceptions and switch between s-mode and m-mode causing
>>> large overhead.
>>>
>>> First copy in bytes until reaches the first word aligned boundary in
>>> destination memory address. This is the preparation before the bulk
>>> aligned word copy.
>>>
>>> The destination address is aligned now, but oftentimes the source address
>>> is not in an aligned boundary. To reduce the unaligned memory access, it
>>> reads the data from source in aligned boundaries, which will cause the
>>> data to have an offset, and then combines the data in the next iteration
>>> by fixing offset with shifting before writing to destination. The majority
>>> of the improving copy speed comes from this shift copy.
>>>
>>> In the lucky situation that the both source and destination address are on
>>> the aligned boundary, perform load and store with register size to copy the
>>> data. Without the unrolling, it will reduce the speed since the next store
>>> instruction for the same register using from the load will stall the
>>> pipeline.
>>>
>>> At last, copying the remainder in one byte at a time.
>>>
>>> Signed-off-by: Akira Tsukamoto <akira.tsukamoto@gmail.com>
>>
>> This patch causes all riscv32 qemu emulations to stall during boot.
>> The log suggests that something in kernel/user communication may be wrong.
>>
>> Bad case:
>>
>> Starting syslogd: OK
>> Starting klogd: OK
>> /etc/init.d/S02sysctl: line 68: syntax error: EOF in backquote substitution
>> /etc/init.d/S20urandom: line 1: syntax error: unterminated quoted string
>> Starting network: /bin/sh: syntax error: unterminated quoted string
> 
>> # first bad commit: [ca6eaaa210deec0e41cbfc380bf89cf079203569] riscv: __asm_copy_to-from_user: Optimize unaligned memory access and pipeline stall
> 
> Same here on vexriscv. Bisected to the same commit.
> 
> The actual scripts look fine when using "cat", but contain some garbage
> when executing them using "sh -v".
> 
> Tsukamoto-san: glancing at the patch:
> 
> +       addi    a0, a0, 8*SZREG
> +       addi    a1, a1, 8*SZREG
> 
> I think you forgot about rv32, where registers cover only 4
> bytes each?

Thanks Günter and Geert for the pointing out the errors.
I will send the fixes, probably this weekend.

Akira
