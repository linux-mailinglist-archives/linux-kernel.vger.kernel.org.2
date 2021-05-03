Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E1F372129
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhECUQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 16:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhECUQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 16:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620072915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nqgS52YwzVDVjfWlq3e547UMU0Zz7FIEHtvfbJqFZ2w=;
        b=WTbIqySH2Rk2Il6xqti2JkZKxvQhSwdDKyRIYiAXLPaPRvZoFaSnYVeXFQONnw11JUs+a0
        qcr67AEUwrUwGJmcKK97woxFLJUqJaYiOJtNpLMPrPgQ7Q/djL9sWJyNxxzDX0lAFNk41E
        6ypCUlOwfNBAwsQxCxTG2UKNZDMKZMw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-2WxHX_9cM_y4sE8nSnmnew-1; Mon, 03 May 2021 16:15:14 -0400
X-MC-Unique: 2WxHX_9cM_y4sE8nSnmnew-1
Received: by mail-qv1-f72.google.com with SMTP id p20-20020a0ce1940000b02901be3272e620so5860546qvl.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 13:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=nqgS52YwzVDVjfWlq3e547UMU0Zz7FIEHtvfbJqFZ2w=;
        b=pwBSmRYJEy+gSu60WvetyUtorC1B44tWjQmNKSCiCiPIKUUb8ncAAvZhyZ5xpA6DlQ
         6wY1Z6qSYZO6WSGsGFRZQG/SQfdo+ang/7gJiEoG1PvdvghArRx1bvqSz4Q+X44ASdiz
         OnKcBKj90Ox19JvtODHgdEaFJRhau9WVNyRhbiYw7t1Sgfyeb8DfRtIKULx+ZOEtAxOh
         jbn6F2Zks6wN5L5SfSHFgtI+bpCJxGhhufFJN46XGP/Gr8Ti1GN1FqIj+R5uAL/pcOq1
         Uy48v0BMHOJGPmLkj3K56VbOV9UwEgK4JwbTW9pEDU23X6+ArlBi9Mt3kA4VoQH6uRa7
         ttPA==
X-Gm-Message-State: AOAM5321Yk6OlkpJ63ymYw9989FVNV9B0DiUiaAjJzwIZlP1oABL9Bqi
        7mmj8LkKg3fF7lWDuL4mG8BEs8EQrKE9RsW/VFFruttIhoplUr5zJvzGK8a7LKHckS4R33aw92H
        mcn9FcHYCRYHtsJWpgEOjL75z
X-Received: by 2002:a0c:fec8:: with SMTP id z8mr22048362qvs.58.1620072914063;
        Mon, 03 May 2021 13:15:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAkI+kIi2aTR1+TiicexVGxSlGuAs9crPbcBlMV9//3cmTaLpe4A/7vMgqgyaYArxfQOS0uQ==
X-Received: by 2002:a0c:fec8:: with SMTP id z8mr22048327qvs.58.1620072913834;
        Mon, 03 May 2021 13:15:13 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id g5sm1010653qtm.2.2021.05.03.13.15.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 13:15:12 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/2] mm: memcg/slab: Don't create unfreeable slab
To:     Shakeel Butt <shakeelb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Waiman Long <llong@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
References: <20210502180755.445-1-longman@redhat.com>
 <20210502180755.445-2-longman@redhat.com>
 <699e5ac8-9044-d664-f73f-778fe72fd09b@suse.cz>
 <4c90cf79-9c61-8964-a6fd-2da087893339@redhat.com>
 <d767ff72-711d-976c-d897-9cea0375c827@suse.cz>
 <CALvZod4aW0P2a5ZG4JO4YH2oQ8a1kM9_Tsjz-tAGP_-9hLyOpw@mail.gmail.com>
 <fc59cce6-71af-890e-030c-46357e0f0343@redhat.com>
Message-ID: <59afa489-3db5-3881-92a4-59b5ee82fc1b@redhat.com>
Date:   Mon, 3 May 2021 16:15:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <fc59cce6-71af-890e-030c-46357e0f0343@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 1:21 PM, Waiman Long wrote:
> On 5/3/21 12:24 PM, Shakeel Butt wrote:
>> On Mon, May 3, 2021 at 8:32 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>> On 5/3/21 4:20 PM, Waiman Long wrote:
>>>> On 5/3/21 8:22 AM, Vlastimil Babka wrote:
>>>>> On 5/2/21 8:07 PM, Waiman Long wrote:
>>>>>> The obj_cgroup array (memcg_data) embedded in the page structure is
>>>>>> allocated at the first instance an accounted memory allocation 
>>>>>> happens.
>>>>>> With the right size object, it is possible that the allocated 
>>>>>> obj_cgroup
>>>>>> array comes from the same slab that requires memory accounting. 
>>>>>> If this
>>>>>> happens, the slab will never become empty again as there is at 
>>>>>> least one
>>>>>> object left (the obj_cgroup array) in the slab.
>>>>>>
>>>>>> With instructmentation code added to detect this situation, I got 76
>>>>>> hits on the kmalloc-192 slab when booting up a test kernel on a VM.
>>>>>> So this can really happen.
>>>>>>
>>>>>> To avoid the creation of these unfreeable slabs, a check is added to
>>>>>> memcg_alloc_page_obj_cgroups() to detect that and double the size
>>>>>> of the array in case it happens to make sure that it comes from a
>>>>>> different kmemcache.
>>>>>>
>>>>>> This change, however, does not completely eliminate the presence
>>>>>> of unfreeable slabs which can still happen if a circular obj_cgroup
>>>>>> array dependency is formed.
>>>>> Hm this looks like only a half fix then.
>>>>> I'm afraid the proper fix is for kmemcg to create own set of 
>>>>> caches for the
>>>>> arrays. It would also solve the recursive kfree() issue.
>>>> Right, this is a possible solution. However, the objcg pointers 
>>>> array should
>>>> need that much memory. Creating its own set of kmemcaches may seem 
>>>> like an
>>>> overkill.
>>> Well if we go that way, there might be additional benefits:
>>>
>>> depending of gfp flags, kmalloc() would allocate from:
>>>
>>> kmalloc-* caches that never have kmemcg objects, thus can be used 
>>> for the objcg
>>> pointer arrays
>>> kmalloc-cg-* caches that have only kmemcg unreclaimable objects
>>> kmalloc-rcl-* and dma-kmalloc-* can stay with on-demand
>>> memcg_alloc_page_obj_cgroups()
>>>
>>> This way we fully solve the issues that this patchset solves. In 
>>> addition we get
>>> better separation between kmemcg and !kmemcg thus save memory - no 
>>> allocation of
>>> the array as soon as a single object appears in slab. For 
>>> "kmalloc-8" we now
>>> have 8 bytes for the useful data and 8 bytes for the obj_cgroup  
>>> pointer.
>>>
>> Yes this seems like a better approach.
>>
> OK, I will try to go this route then if there is no objection from 
> others.
>
> From slabinfo, the objs/slab numbers range from 4-512. That means we 
> need kmalloc-cg-{32,64,128,256,512,1k,2k,4k}. A init function to set 
> up the new kmemcaches and an allocation function that use the proper 
> kmemcaches to allocate from. 

I think I had misinterpreted the kmalloc-* setup. In this case, the 
kmalloc-cg-* should have the same set of sizes as kmalloc-*.

Cheers,
Longman

