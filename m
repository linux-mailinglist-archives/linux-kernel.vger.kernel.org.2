Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D37103D4453
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 04:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhGXBdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 21:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhGXBdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 21:33:18 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FEBC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 19:13:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso3869872otb.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 19:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3CjAkz2rbpfDTDykSfg6TYvqG+xZm+08z3kG9+FzpqQ=;
        b=PumW6vTF3OQbz4r0hupGJyZ2Ymio43RPxINIzs94H/MUmq1PRZItJYHpYjIJufqzO0
         ZUE4RnZ1+xxOMLXNrOefcBGA8YwMIT5aYzcGEv1tkoK4kpogcsRBVOpJWPFb3nJV+I/q
         4tZeRXVga5OHfgfsCMTGsEHGpWTUa50aV/7g4HRJeFYbx+LPiRgekbghJNALAACfDfM9
         6rDGAqiDLmItY+oMvQz8YhefuFfplrRB1eHYsSAJ6JFMoGgGKGi/7R0wpXtF9isMlkV7
         hc/G5Jx3ymX3Z1UUU+DF+M8qwgTvue0u8uH09M9AdhwublBCrFzNAj2pq7ZxoWPe3Xrn
         abMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3CjAkz2rbpfDTDykSfg6TYvqG+xZm+08z3kG9+FzpqQ=;
        b=qv0lELmHv4JNNq+7CNodZQWrcLlAJq+yeftqBSoMGBqw+BNeZ1p38NKi2EGk6UrlQV
         Xo6YLptKKs/6cIhuCVNN7o9WMxgyLkAWuKkIXwX39EfD9xMItHMakmgCAOJuCmLwA9/G
         8+xLNiRG3miHRpG8n4q0DOlmjgj/vFa1yZ6R8C/WpE6Y52cBiDelvGfMkpgwmIHpzku9
         fj/UmjoGXZCDFR0VK7zTBN/ox8njuByQI3ssOhs7ZLmI6kJuzhIBpI+19SgheMgxMrIr
         GrvJ7pf45VI6C3ZUQp1w4Vp/nskk6tFcgUqfUNMfO7eIm4/W0We1EMR5pHG242tFzlzt
         3IMw==
X-Gm-Message-State: AOAM533h57neS5J3/D4rOehiE0tCX/F7tMnknXwIiEfM9/mXHSfKeQaY
        WgBtBVNP/XsPPJPNjehteYg=
X-Google-Smtp-Source: ABdhPJwELDcuejERxKfOH2VhD4WeSAsv6zdHykutuSV2cLOte104DCXdH0dRCWL8+vW6fnGWy9dsAA==
X-Received: by 2002:a05:6830:16cb:: with SMTP id l11mr4912645otr.209.1627092829813;
        Fri, 23 Jul 2021 19:13:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u126sm1211034ooa.23.2021.07.23.19.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jul 2021 19:13:49 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com
References: <mhng-1b892781-2ee8-476b-90b8-44b5cca45cf9@palmerdabbelt-glaptop>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] riscv: Disable STACKPROTECTOR_PER_TASK if
 GCC_PLUGIN_RANDSTRUCT is enabled
Message-ID: <9b3a28fe-9f05-580d-0266-22ff9856096c@roeck-us.net>
Date:   Fri, 23 Jul 2021 19:13:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <mhng-1b892781-2ee8-476b-90b8-44b5cca45cf9@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/21 5:58 PM, Palmer Dabbelt wrote:
> On Tue, 06 Jul 2021 09:26:21 PDT (-0700), linux@roeck-us.net wrote:
>> riscv uses the value of TSK_STACK_CANARY to set
>> stack-protector-guard-offset. With GCC_PLUGIN_RANDSTRUCT enabled, that
>> value is non-deterministic, and with riscv:allmodconfig often results
>> in build errors such as
>>
>> cc1: error: '8120' is not a valid offset in '-mstack-protector-guard-offset='
>>
>> Enable STACKPROTECTOR_PER_TASK only if GCC_PLUGIN_RANDSTRUCT is disabled
>> to fix the problem.
>>
>> Fixes: fea2fed201ee5 ("riscv: Enable per-task stack canaries")
>> Cc: Guo Ren <guoren@linux.alibaba.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>  arch/riscv/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 469a70bd8da6..3afb84fa2190 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -486,6 +486,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
>>
>>  config STACKPROTECTOR_PER_TASK
>>      def_bool y
>> +    depends on !GCC_PLUGIN_RANDSTRUCT
>>      depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
>>
>>  config PHYS_RAM_BASE_FIXED
> 
> Thanks, this is on fixes.  I do an allmodconfig build and haven't seen these failures, is there something special I need to do to get this working?  I know nothing about GCC plugins...

The problem is seen only randomly. It depends on the value
of TSK_STACK_CANARY in include/generated/asm-offsets.h.
That in turn depends on the location of stack_canary
in struct task_struct. You may have to try several times
from a clean tree to see the problem.

Guenter
