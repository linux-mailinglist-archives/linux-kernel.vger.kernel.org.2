Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1D93894D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhESR6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 13:58:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38503 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhESR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 13:58:40 -0400
Received: from mail-qv1-f72.google.com ([209.85.219.72])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1ljQRb-0004r5-00
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 17:57:19 +0000
Received: by mail-qv1-f72.google.com with SMTP id z93-20020a0ca5e60000b02901ec19d8ff47so11055692qvz.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcZ/T9imHACo8Z4kSI40UuANWMVe6/Ole5+QagzVCe8=;
        b=DQICcAbuOWoYYcF+UBaZAVnRZPhtcJ96JSWdrO6qly6NzAM4EykxLWKFchrQN04Iwa
         cfo56zJEHqJY7RasvnQ/D2RwkwD2zNWBVUJqCIUJisxEcM9Z+tSMKHZ9uB81HlEgRKOL
         RCK8+w6Fx6seDksbojBKSTDJv4CbTbl2bHCqcjHM2aC9L+3SnUt62taPjsDBzwr32Fad
         9Crf2qhizeoxo1KKu5BsQUAMuMVgs76pYziK+P3I/z1ZNzZtukpz4Ws0mjv+SewabWxu
         41lsULIw57ltr4JblSRIthTvk1dZItraFTDJ5JCRucvY3TxllJTSEpdUQ8zTllOrYXOd
         61ag==
X-Gm-Message-State: AOAM532TsWfeJFlngHZGBJl9Nfph1M6HHdfhvoX/2tMeWqSUcozhUbcx
        OA8oNrvcw3UfnVAlpb5uQMqQkh5AM+jlkLDbYt1IhSvV94AZEi9yUbI9CVGaj+DApHRj0eZ8drJ
        chkbgJ1VqHR9j6relGeRwK+aIB88oHHu6Y5zfozzBcw==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr743234qtm.207.1621447038143;
        Wed, 19 May 2021 10:57:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKraDoCFPHZbxvHQR9nlAIXYbb9X3n0gzCd66TMrZlnS/PJn2nu80hkAHPonSh3n4gmge3UA==
X-Received: by 2002:ac8:4256:: with SMTP id r22mr743216qtm.207.1621447037980;
        Wed, 19 May 2021 10:57:17 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.1])
        by smtp.gmail.com with ESMTPSA id x13sm117197qtj.12.2021.05.19.10.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 10:57:17 -0700 (PDT)
Subject: Re: [PATCH] mm, page_alloc: really disable DEBUG_PAGEALLOC with
 hibernation
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Guilherme Piccoli <gpiccoli@canonical.com>
References: <20210519152804.27063-1-krzysztof.kozlowski@canonical.com>
 <b0cf875b-6ff5-2b5c-8b3d-6dc6c75b8be8@redhat.com>
 <515ca9c5-ba60-5b90-0941-2b3dfe1d61f3@suse.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e7b05af7-c0c8-c1ac-a81b-7026d151726a@canonical.com>
Date:   Wed, 19 May 2021 13:57:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <515ca9c5-ba60-5b90-0941-2b3dfe1d61f3@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2021 11:48, Vlastimil Babka wrote:
> On 5/19/21 5:30 PM, David Hildenbrand wrote:
>> On 19.05.21 17:28, Krzysztof Kozlowski wrote:
>>> The documentation of DEBUG_PAGEALLOC states that it cannot be used with
>>> hibernation, however the Kconfig entry would allow it if
>>> ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC.
>>>
>>> Fixes: ee3b4290aec0 ("generic debug pagealloc: build fix")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> ---
>>>   mm/Kconfig.debug | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
>>> index 1e73717802f8..0ace5b2a9d04 100644
>>> --- a/mm/Kconfig.debug
>>> +++ b/mm/Kconfig.debug
>>> @@ -11,7 +11,7 @@ config PAGE_EXTENSION
>>>   config DEBUG_PAGEALLOC
>>>       bool "Debug page memory allocations"
>>>       depends on DEBUG_KERNEL
>>> -    depends on !HIBERNATION || ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
>>> +    depends on !HIBERNATION && ARCH_SUPPORTS_DEBUG_PAGEALLOC && !PPC && !SPARC
>>>       select PAGE_POISONING if !ARCH_SUPPORTS_DEBUG_PAGEALLOC
>>>       help
>>>         Unmap pages from the kernel linear mapping after free_pages().
>>>
>>
>> I remember this should be working now, as we temporarily map the pages in the
>> direct map when hibernating?
> 
> Yeah, and if the problem was the page poisoning based implementation/fallback,
> that was also fixed.
> 
> The current dependencies come from the unification by ee3b4290aec03
> 
> The question is if PPC and SPARC still really need to disable hibernation.

I tested slightly older kernel (v5.8 with few backports for poison
support with hibernation) and it worked fine on x86_64. For the PPC and
SPARC I don't know.

I can update the Kconfig option description to mention x86_64.


Best regards,
Krzysztof
