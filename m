Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BB13E9DE8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 07:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhHLFXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 01:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhHLFXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:23:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F109BC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:23:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a20so5831582plm.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 22:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bQrl411Cthqt6pIHr/hant9kt/vOifGny5MEgIFUvls=;
        b=T84Kc/z9q+vHcpHvLIkoCJUyMDs96A0EO2OHme82NSs3xI2gKCVBV7ic09BrGiaqfV
         owlWmGhzA877enYL54ze9LYMseOpAmKkSjq4XSaPVjkeYnDkpVcEXyzJQSgFCSmRG0QB
         rFbT5eYN2MY7iAJhl8WIfabRth4JLCwQP/isGczfWhSbeotdeO/NbZMrGXK4tLKA1WYf
         1impM3Ypm18+EYY4p68OCq0GX17xBxmWHs7w1YVn8tzNKf72DygeCQX76T+9cckyjlGA
         1yCIRLncfqyG6noT6hP4AOnIlN5O/2lhVJm6zGF1ij5VfMXV2pZcKqSSTxgj6jINhMoW
         r+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bQrl411Cthqt6pIHr/hant9kt/vOifGny5MEgIFUvls=;
        b=K/notOGCypn6DrVovj4PNowX9Z9i41nc2TUNE+dCEU2AWkur1xllPFV3FJcIOQHfUt
         Ys+5fw0q1IsBr9WEgm0ketfo24vbDdZu/4vZzaKaAAkBkIXbgq66onaSLnbqDvzHstIN
         KobMFE8dZv2BY3cSpRqWr35QjUZlrq5gJSgcXg9kfo/d/7E/8OITPVJqhwHOHTbiFPnq
         ldfM4Kp2g6amWu1EyGPQWnNMNkCfl1bYM+SbBvX+wgjYzP4/kZ2OloGXg5YDmRXGrdKp
         bsNA+riZLm8+Fl2mbugJ49YfnGH7T45E34lpf5sv3ckZ+xzl7J6VnT/uFATEQq5I44Kl
         fhMw==
X-Gm-Message-State: AOAM533UVMsys8Kco3IosM/UlLAczAZovSBjq46pvlvTZAnDHjUYWzlM
        sq/ZbnxpMa7pDwvoY4pKBbEV8A==
X-Google-Smtp-Source: ABdhPJx3HD960snankcmEtYZ/kpTb1TVul2ICB91HEVhe10nex0sfnUsxnhn3Cd2ImnxMgbSUIzsGA==
X-Received: by 2002:a17:902:e8c4:b029:12d:1c9c:2e77 with SMTP id v4-20020a170902e8c4b029012d1c9c2e77mr2218679plg.48.1628745805478;
        Wed, 11 Aug 2021 22:23:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b9sm663873pfo.175.2021.08.11.22.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 22:23:24 -0700 (PDT)
Date:   Wed, 11 Aug 2021 22:23:24 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Aug 2021 21:47:49 PDT (-0700)
Subject:     Re: [PATCH -fixes 3/3] riscv: Optimize kernel virtual address conversion macro
In-Reply-To: <39a1fa85-1885-effe-1670-ec9cf34099f5@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-48d9e47f-a43b-4dac-808c-61078c2b77d9@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Aug 2021 12:31:24 PDT (-0700), alex@ghiti.fr wrote:
> Le 7/08/2021 à 18:36, Palmer Dabbelt a écrit :
>> On Wed, 21 Jul 2021 00:59:37 PDT (-0700), alex@ghiti.fr wrote:
>>> The current test in kernel_mapping_va_to_pa only applies when
>>> CONFIG_XIP_KERNEL is set, so use IS_ENABLED to optimize this macro at
>>> compile-time in standard kernels that do not require this test.
>>>
>>> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
>>> ---
>>>  arch/riscv/include/asm/page.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/include/asm/page.h
>>> b/arch/riscv/include/asm/page.h
>>> index b0ca5058e7ae..10dc063868f6 100644
>>> --- a/arch/riscv/include/asm/page.h
>>> +++ b/arch/riscv/include/asm/page.h
>>> @@ -123,7 +123,7 @@ extern phys_addr_t phys_ram_base;
>>>  #define linear_mapping_va_to_pa(x)    ((unsigned long)(x) -
>>> kernel_map.va_pa_offset)
>>>  #define kernel_mapping_va_to_pa(y) ({                        \
>>>      unsigned long _y = y;                            \
>>> -    (_y < kernel_map.virt_addr + XIP_OFFSET) ?                    \
>>> +    (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr +
>>> XIP_OFFSET) ?    \
>>>          ((unsigned long)(_y) - kernel_map.va_kernel_xip_pa_offset)
>>> :        \
>>>          ((unsigned long)(_y) - kernel_map.va_kernel_pa_offset -
>>> XIP_OFFSET);    \
>>>      })
>>
>> IIUC this isn't actually a fix?  The other two are, though, so they're
>> on fixes.
>
> Indeed this is not a fix, this is symmetrical to what I have done in
> patch 1 so that seemed natural to land in the same patchset. Let me know
> if you want me to resend it on its own.

That's fine, it was just explicitly called out as a fix in the subject 
line so I wanted to make sure I wasn't missing something.  This is on 
for-next.

Thanks!
