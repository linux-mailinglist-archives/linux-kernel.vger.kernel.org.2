Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B037FB67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbhEMQXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235104AbhEMQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620922948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIx7hWghyOcKHsxnhk7V96UW46vI1Sqd/jZUYBrxrFs=;
        b=hKlULPkoulYlZIy5SXjnctz4Sn/fCBGk+wDptP8HVw3G1CLr4vTlrSoWCNbO+MokCiYnfW
        t6b/MX4M2yrnH99zV3UbhNu6svZPrZfrPh+V25oApTFyYDTDYVp3rQ8uj2+5y7lZdXv/vU
        qQIOphsNd2h7DrjYR7QvJ/aiwHcR0Rk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-4_FY14s6PHSyM52XJW3YDw-1; Thu, 13 May 2021 12:22:24 -0400
X-MC-Unique: 4_FY14s6PHSyM52XJW3YDw-1
Received: by mail-qv1-f72.google.com with SMTP id a6-20020a0ce3460000b02901c4f39aa36aso21663955qvm.21
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EIx7hWghyOcKHsxnhk7V96UW46vI1Sqd/jZUYBrxrFs=;
        b=JTLT4oNlf3ay8l3cQwfORHuNmvZ08ht5fy1VxiFVFm9rSzujN1M1LowruDDzPrpyJl
         YQ0rslKUMnCeDmSWOCMEAoh/4hmWIG9A4no2EnQjt5hF2/zv2I35hW4Hr2bb6s1Ex0/4
         qoe7zTR0CvhaTzatf6KjOTrC5GyW9NCf3DrQqv/qrmjeaw0i3vL6jN1i6zJpE88lffyL
         aPuC7mvr20Tzt+zTDr7jaHm/nXlr/b4FBJrw9AiRswC2NGdi2/DKaWLkNTJVZkOuAIwl
         KfNDTyRH8iRv9gfY5xqluel3rCGVpL1Uii5jcXjrKx0F1EQvDXiGUIvpx+z25y0TFmbX
         hoxQ==
X-Gm-Message-State: AOAM533gg9ma7LrnrzwAbLTFnIPTIGQsOGzy79A+jVXZdJzBWkggMWix
        +0RNXd1Waz1rRJ8yv9yhoD8CosNHCpPPRqJvZHoXSfjyOJW/wXaVatW745hpohGvtfIXrkMEp6A
        BJcNmeK8woOM+GNGQZQzvxmSx
X-Received: by 2002:ae9:c010:: with SMTP id u16mr36002735qkk.133.1620922944362;
        Thu, 13 May 2021 09:22:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypW52z4koXjDm+vseDa/OGAuJKFw35V6mcwKGIJDY6x7ocwRRUfji64raykrWzMhJogEoz0Q==
X-Received: by 2002:ae9:c010:: with SMTP id u16mr36002717qkk.133.1620922944166;
        Thu, 13 May 2021 09:22:24 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c20sm2816714qtm.52.2021.05.13.09.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 May 2021 09:22:23 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210512145107.6208-1-longman@redhat.com>
 <0919aaab-cc08-f86d-1f9a-8ddfeed7bb31@redhat.com>
 <20210512173212.738f592c36bf0e4c205f628e@linux-foundation.org>
Message-ID: <5b853795-6583-8527-93d2-68ff0b9b5457@redhat.com>
Date:   Thu, 13 May 2021 12:22:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210512173212.738f592c36bf0e4c205f628e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/21 8:32 PM, Andrew Morton wrote:
> On Wed, 12 May 2021 10:54:19 -0400 Waiman Long <llong@redhat.com> wrote:
>
>>>    include/linux/slab.h | 42 +++++++++++++++++++++++++++++++++---------
>>>    mm/slab_common.c     | 25 +++++++++++++++++--------
>>>    2 files changed, 50 insertions(+), 17 deletions(-)
>> The following are the diff's from previous version. It turns out that
>> the previous patch doesn't work if CONFIG_ZONE_DMA isn't defined.
>>
>> diff --git a/include/linux/slab.h b/include/linux/slab.h
>> index a51cad5f561c..aa7f6c222a60 100644
>> --- a/include/linux/slab.h
>> +++ b/include/linux/slab.h
>> @@ -312,16 +312,17 @@ static inline void __check_heap_object(const void
>> *ptr, un
>> signed long n,
>>     */
>>    enum kmalloc_cache_type {
>>        KMALLOC_NORMAL = 0,
>> -#ifdef CONFIG_MEMCG_KMEM
>> -    KMALLOC_CGROUP,
>> -#else
>> +#ifndef CONFIG_ZONE_DMA
>> +    KMALLOC_DMA = KMALLOC_NORMAL,
>> +#endif
>> +#ifndef CONFIG_MEMCG_KMEM
>>        KMALLOC_CGROUP = KMALLOC_NORMAL,
>> +#else
>> +    KMALLOC_CGROUP,
>>    #endif
>>        KMALLOC_RECLAIM,
>>    #ifdef CONFIG_ZONE_DMA
>>        KMALLOC_DMA,
>> -#else
>> -    KMALLOC_DMA = KMALLOC_NORMAL,
>>    #endif
>>        NR_KMALLOC_TYPES
>>    };
> I assume this fixes
> https://lkml.kernel.org/r/20210512152806.2492ca42@canb.auug.org.au?
>
Yes.

Cheers,
Longman

