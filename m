Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA06D35D0EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 21:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbhDLTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 15:21:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245201AbhDLTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 15:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618255253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oFjHc+GCztqPmJltFlAlQEb4vymDlpph7ymGuFpnTz8=;
        b=cUU0C334tXxqNdBDs4vJ+4JayPJujnKNRSzU0gLmm2WQ0Av4ztmej+av9zVOqxir+Wyc/2
        bbuMAf8kgwvvkkxNWycVkMAMPTgbIy/VCtNV/XOkNIHn/JuwnX1HtQD57OZRe20aMEQmRq
        yXlJHspNypfE/tlJOHmZzd8dEvxGpLU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-shwCBBC4NhiTMiQ2n994tw-1; Mon, 12 Apr 2021 15:20:51 -0400
X-MC-Unique: shwCBBC4NhiTMiQ2n994tw-1
Received: by mail-qt1-f198.google.com with SMTP id 11so7396833qtz.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 12:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oFjHc+GCztqPmJltFlAlQEb4vymDlpph7ymGuFpnTz8=;
        b=JZ8kjfS6mWvqBItZAoED0VzJazyNWTMftI+G0sSOUbJSnq89p3v9pGGuU12FBr3WIU
         fOI7omP5gkoIohYysiIhCvVd/uqAO0MV7kFShuCDi6qsnh/C5VjaqUwrL1iQ7/wfKUWc
         /MbbE4Iw5PUHShcuf/dDL4mScAa8r0xARxLLucXtuf0qN/gNLV0v+KREJ3fyz19f+V31
         4MHvrl5CHjRYrkEuBgBfDWDLaq8CZoLEcBNVZSWKFH4KfsskLqWquA/doo2eGjr5hrbI
         +UmubIMbPgSHHxF8hvKx16vYphpxWealCDrMNhk3JzgZWZN8Syi7IbV7r9yl4h061JoV
         wRQA==
X-Gm-Message-State: AOAM531DtfGV89tsJzHmeI8mlCFF0N3q9gXQzSNDnLL6mIK3vyouIXhQ
        /N+wHFwZjVItmvqY4060qOlmj6KsnZ40SavtYz8oDWo2zR+e2RmIQrX+6tz5yr28hyVpJnlG0NC
        dEdIhToaACI6TL18an3RBmxdy
X-Received: by 2002:ac8:5054:: with SMTP id h20mr533142qtm.34.1618255251307;
        Mon, 12 Apr 2021 12:20:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDbd5Q9VPCdBtbn+afvB7rGxG6E+MDv4mz/Eiy7TeaQZPVd2IbxALEjPVWVlfoC0zobURBsg==
X-Received: by 2002:ac8:5054:: with SMTP id h20mr533111qtm.34.1618255251103;
        Mon, 12 Apr 2021 12:20:51 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id y29sm8531386qtm.13.2021.04.12.12.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 12:20:50 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
To:     Roman Gushchin <guro@fb.com>, Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>
References: <20210409231842.8840-1-longman@redhat.com>
 <YHEEmGSVy3nl0obM@carbon.dhcp.thefacebook.com>
 <51ea6b09-b7ee-36e9-a500-b7141bd3a42b@redhat.com>
 <YHSHqmxyu1DkAMYR@carbon.dhcp.thefacebook.com>
Message-ID: <339bd1b0-681c-61fa-210b-59f1542431e2@redhat.com>
Date:   Mon, 12 Apr 2021 15:20:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHSHqmxyu1DkAMYR@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/21 1:47 PM, Roman Gushchin wrote:
> On Mon, Apr 12, 2021 at 10:03:13AM -0400, Waiman Long wrote:
>> On 4/9/21 9:51 PM, Roman Gushchin wrote:
>>> On Fri, Apr 09, 2021 at 07:18:37PM -0400, Waiman Long wrote:
>>>> With the recent introduction of the new slab memory controller, we
>>>> eliminate the need for having separate kmemcaches for each memory
>>>> cgroup and reduce overall kernel memory usage. However, we also add
>>>> additional memory accounting overhead to each call of kmem_cache_alloc()
>>>> and kmem_cache_free().
>>>>
>>>> For workloads that require a lot of kmemcache allocations and
>>>> de-allocations, they may experience performance regression as illustrated
>>>> in [1].
>>>>
>>>> With a simple kernel module that performs repeated loop of 100,000,000
>>>> kmem_cache_alloc() and kmem_cache_free() of 64-byte object at module
>>>> init. The execution time to load the kernel module with and without
>>>> memory accounting were:
>>>>
>>>>     with accounting = 6.798s
>>>>     w/o  accounting = 1.758s
>>>>
>>>> That is an increase of 5.04s (287%). With this patchset applied, the
>>>> execution time became 4.254s. So the memory accounting overhead is now
>>>> 2.496s which is a 50% reduction.
>>> Hi Waiman!
>>>
>>> Thank you for working on it, it's indeed very useful!
>>> A couple of questions:
>>> 1) did your config included lockdep or not?
>> The test kernel is based on a production kernel config and so lockdep isn't
>> enabled.
>>> 2) do you have a (rough) estimation how much each change contributes
>>>      to the overall reduction?
>> I should have a better breakdown of the effect of individual patches. I
>> rerun the benchmarking module with turbo-boosting disabled to reduce
>> run-to-run variation. The execution times were:
>>
>> Before patch: time = 10.800s (with memory accounting), 2.848s (w/o
>> accounting), overhead = 7.952s
>> After patch 2: time = 9.140s, overhead = 6.292s
>> After patch 3: time = 7.641s, overhead = 4.793s
>> After patch 5: time = 6.801s, overhead = 3.953s
> Thank you! If there will be v2, I'd include this information into commit logs.

Yes, I am planning to send out v2 with these information in the 
cover-letter. I am just waiting a bit to see if there are more feedback.

-Longman

>
>> Patches 1 & 4 are preparatory patches that should affect performance.
>>
>> So the memory accounting overhead was reduced by about half.

BTW, the benchmark that I used is kind of the best case behavior as it 
as all updates are to the percpu stocks. Real workloads will likely to 
have a certain amount of update to the memcg charges and vmstats. So the 
performance benefit will be less.

Cheers,
Longman


