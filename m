Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1E360A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbhDONSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232253AbhDONSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618492662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ekDAkkr77eB7AxytMHc6R8nrzotwIpYRJxiGpMYfIQ=;
        b=Uodcfmich+hUu73FW+LcOlBja1FCvDUuXc6PZIxoTKwKY8wz/0vxmVlSoTtLrbTs8tZbDQ
        /eC31E+HrGkb4Pg8T2uCUnLshzWrTZ23G95We/HPi8Lk3ab4qn7xKlA2pDGV9k0bnEzxVF
        FcyO60eD28Ig+kUaum1j6rwvKC5cHQU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-HRA3KqH7NlK2HhDJFGDh_A-1; Thu, 15 Apr 2021 09:17:41 -0400
X-MC-Unique: HRA3KqH7NlK2HhDJFGDh_A-1
Received: by mail-qv1-f72.google.com with SMTP id m19-20020a0cdb930000b029019a25080c40so1736101qvk.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6ekDAkkr77eB7AxytMHc6R8nrzotwIpYRJxiGpMYfIQ=;
        b=fNgIzJEgh0na49LhWTu7jnr+vARwaY36XMYnONN7xq/c2Ldox4E0FKzN7UTI6XGBA0
         8Y1MBP9p4bVKGKufFasF20x6CETSrxrJXpHwciQO/U+DiIdTlaA7LE/6Lm6vN9OUth6T
         ZbehE0oPCLcAZ9O1FITOuxBg8Qjf01rYpxDrTtwHmeph0iyz//gx+9HGU2934LxtHyuY
         9sVCjFowBShKMLI9zThOo5cmUguTH3sWP3LOtI5A5HVCsmzkaWJ5HSU26CZqju5iLr9y
         kUhOmiZzNlR1sHw36yyS/R6e9gx/pM90fL5ahs1/P5jJvYC/VL1KKChn8RtB62eMgyg1
         Ma3g==
X-Gm-Message-State: AOAM5330NYrCkBH1wrpyQu0dIbAC4d7QJqqTZ4hLJHHbGN8cHKYySmmw
        MwUSIwygMvOgHvU8qyOerGAWa8pKXXPQkKrYJHwZrFCKr1NvnBWcRU7kSiENECoiZlPF8dgxn8s
        leQkj0mvWbnM8Xm+AKZbUX1NI
X-Received: by 2002:aed:2042:: with SMTP id 60mr2968649qta.340.1618492660576;
        Thu, 15 Apr 2021 06:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD+jDw+3d0Vt7K0lMNcqpB1cyAf1PizDO/B0uJhdje9Ty4/DaY0Axl2ZceZ8eUq0lZta2ATw==
X-Received: by 2002:aed:2042:: with SMTP id 60mr2968619qta.340.1618492660352;
        Thu, 15 Apr 2021 06:17:40 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h82sm1946504qke.30.2021.04.15.06.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 06:17:39 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 0/5] mm/memcg: Reduce kmemcache memory accounting
 overhead
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210415032642.gfaevezaxoj4od3d@gabell>
Message-ID: <12cba05a-e268-3a5d-69d7-feb00e36ef40@redhat.com>
Date:   Thu, 15 Apr 2021 09:17:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210415032642.gfaevezaxoj4od3d@gabell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 11:26 PM, Masayoshi Mizuma wrote:
>
> Hi Longman,
>
> Thank you for your patches.
> I rerun the benchmark with your patches, it seems that the reduction
> is small... The total duration of sendto() and recvfrom() system call
> during the benchmark are as follows.
>
> - sendto
>    - v5.8 vanilla:                      2576.056 msec (100%)
>    - v5.12-rc7 vanilla:                 2988.911 msec (116%)
>    - v5.12-rc7 with your patches (1-5): 2984.307 msec (115%)
>
> - recvfrom
>    - v5.8 vanilla:                      2113.156 msec (100%)
>    - v5.12-rc7 vanilla:                 2305.810 msec (109%)
>    - v5.12-rc7 with your patches (1-5): 2287.351 msec (108%)
>
> kmem_cache_alloc()/kmem_cache_free() are called around 1,400,000 times during
> the benchmark. I ran a loop in a kernel module as following. The duration
> is reduced by your patches actually.
>
>    ---
>    dummy_cache = KMEM_CACHE(dummy, SLAB_ACCOUNT);
>    for (i = 0; i < 1400000; i++) {
> 	p = kmem_cache_alloc(dummy_cache, GFP_KERNEL);
> 	kmem_cache_free(dummy_cache, p);
>    }
>    ---
>
> - v5.12-rc7 vanilla:                 110 msec (100%)
> - v5.12-rc7 with your patches (1-5):  85 msec (77%)
>
> It seems that the reduction is small for the benchmark though...
> Anyway, I can see your patches reduce the overhead.
> Please feel free to add:
>
> 	Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> Thanks!
> Masa
>
Thanks for the testing.

I was focusing on your kernel module benchmark in testing my patch. I 
will try out your pgbench benchmark to see if there can be other tuning 
that can be done.

BTW, how many numa nodes does your test machine? I did my testing with a 
2-socket system. The vmstat caching part may be less effective on 
systems with more numa nodes. I will try to find a larger 4-socket 
systems for testing.

Cheers,
Longman

