Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05D33BC44C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 02:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGFAI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 20:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhGFAIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 20:08:24 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305ADC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 17:05:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id a2so19757317pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 17:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=f7ZB2u7cN1xFre4uiL7GzLzkfmTR/fW1AGUvpXkWqYQ=;
        b=hBdjwIEdLWSbkaE0dToSCvL7WVoHK+VOzyfByguxTb/zgIN1/XRbvNbL9ePushfI0g
         fV7TnLTtBNTOg+vRygVQXJ4w1mMTyjLR3fSuzeLHNCJW4ENh8/XR/5X742M6seefXTKp
         BrtaMCYD7dxR7HCkgUidWhYMJJ/og0irx42RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f7ZB2u7cN1xFre4uiL7GzLzkfmTR/fW1AGUvpXkWqYQ=;
        b=jENcDpHCgD+S3+oBfGZjyRh9pGNpdFG/ciBvSSgfahyiND7+CYViw0PAy9UtweL4hE
         Ve/dFy/83ypjZfw40IoP/fQtPmOrDOk+1LcRKXNKaQywrnTZC4NxDBf0szoSjewtc3V7
         nO/QmDSY7YA/BHELk5eUlAM1aHjtXMA31TCVOT4RsskYR54IMp8OiPwrlix5ItpbS0Sz
         dIE0FE5IkJpoBblDDqScj0Y/wDlxJnFRvB0QrXKJyFlwV2XLuTged8bfQH5sipPUTa76
         JihtoskCaIQ2AzVSyEtRii2dUuKYI8k6Bmjawy7Gdlez93ncX7Epaem3LPFb+TBkoRKl
         noAw==
X-Gm-Message-State: AOAM533iauGMvz+SOy0eBgh5hRzi9tQI1P6JA9/U6hEkBnUaHCgGX70m
        yCO2mxqdr+pPwBKLkCjQYPaVFg==
X-Google-Smtp-Source: ABdhPJyscNgeBpcNyDzkDp0rCnRIjnVB2rLGbQzAnBGt9PE0WskVAsgBL1REwpJL1OsDyscNUh/oqw==
X-Received: by 2002:a05:6a00:5e:b029:30f:d0d3:214e with SMTP id i30-20020a056a00005eb029030fd0d3214emr17518723pfk.29.1625529945768;
        Mon, 05 Jul 2021 17:05:45 -0700 (PDT)
Received: from localhost ([203.206.29.204])
        by smtp.gmail.com with ESMTPSA id d23sm12060542pjd.25.2021.07.05.17.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 17:05:45 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: Re: [PATCH -next 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
In-Reply-To: <87bl7gxq7k.fsf@dja-thinkpad.axtens.net>
References: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
 <20210705111453.164230-4-wangkefeng.wang@huawei.com>
 <YOMfcE7V7lSE3N/z@elver.google.com>
 <87bl7gxq7k.fsf@dja-thinkpad.axtens.net>
Date:   Tue, 06 Jul 2021 10:05:41 +1000
Message-ID: <878s2kxq5m.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> If so, should we put the call inside of vm_area_register_early?
Ah, we already do this. Sorry. My other questions remain.

Kind regards,
Daniel

>
> Kind regards,
> Daniel
>
>>
>>>  void __init kasan_init(void)
>>>  {
>>>  	kasan_init_shadow();
>>> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
>>> index 5310e217bd74..79d3895b0240 100644
>>> --- a/include/linux/kasan.h
>>> +++ b/include/linux/kasan.h
>>> @@ -49,6 +49,8 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>>>  int kasan_populate_early_shadow(const void *shadow_start,
>>>  				const void *shadow_end);
>>>  
>>> +void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>>> +
>>>  static inline void *kasan_mem_to_shadow(const void *addr)
>>>  {
>>>  	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
>>> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
>>> index cc64ed6858c6..d39577d088a1 100644
>>> --- a/mm/kasan/init.c
>>> +++ b/mm/kasan/init.c
>>> @@ -279,6 +279,11 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>>>  	return 0;
>>>  }
>>>  
>>> +void __init __weak kasan_populate_early_vm_area_shadow(void *start,
>>> +						       unsigned long size)
>>> +{
>>> +}
>>
>> I'm just wondering if this could be a generic function, perhaps with an
>> appropriate IS_ENABLED() check of a generic Kconfig option
>> (CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK ?) to short-circuit it, if it's
>> not only an arm64 problem.
>>
>> But I haven't looked much further, so would appeal to you to either
>> confirm or reject this idea.
>>
>> Thanks,
>> -- Marco
