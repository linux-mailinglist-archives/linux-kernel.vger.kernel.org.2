Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D1B374BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEEXU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 19:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37855 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhEEXUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 19:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620256768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=42NhY9pIv+uXlb41VZhPnr08pYEJ08Pi29tdv81LhX8=;
        b=Mp5X4gw9sAQN1MsvWogvUs6YaqvOl8JIcDFVZmwOEmDSRj6/uot3a43y2L1cgNl2qKrPl3
        ah30XGb9kbHYVXwZeV3eW+oTSzD9K3Zbc/3OCZLd4F//eufbbgtr+VwgSXzfnBqIbkvHPw
        Uw3EbOkobrfBkUF/6DOGwzv+PCwV0A0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-S35fr5sOMJWMNHExRCMq6Q-1; Wed, 05 May 2021 19:19:26 -0400
X-MC-Unique: S35fr5sOMJWMNHExRCMq6Q-1
Received: by mail-qk1-f200.google.com with SMTP id p17-20020a05620a1131b02902e45c6e4d33so2283018qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 16:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=42NhY9pIv+uXlb41VZhPnr08pYEJ08Pi29tdv81LhX8=;
        b=K6C2NUPLwIC+2tQRiubKL8m8nwnSBoBMwXfRfzjPNCpL360Z9ngXAG4/WArTXCFRtL
         s/y4aJTFSqeKW+mMuHs8H/OaRtDOiJfFvPFurphwoakY5c9zbAsKUYGdqvfHSrZfotrZ
         MO7R2voh4947PRS4bC24KVGJFmvRXGj1oP1NUZi6L5vfJRVf6sxYjE5wi8kqfLanlwFT
         Op/El4GKga/ClbqD5MNzwny33YJJCBQcNr6uyY1pxCa/GchdXxGLQa9zdr/ypZqiXORC
         cNjX7kTZ7PEaSDtcjT52NgG8SI3dPXOjb32EqB9UaGhBtOiwtkvLTo1cn4a5rgL6aapf
         UFAw==
X-Gm-Message-State: AOAM533mRo/okDx8m2faDJDnx8bPmeloYg2Q6hH2I1BhCrYNcoLYMTJo
        5VIecbT2LjRk3bsAZYX1j0zj4UaAy8SF5+SVnmIREEWkZyMZl/fpnI2MI36dK/LzFmlPqcMSoFt
        EzyDHcNMtoqJCI24jmRVTsV2V
X-Received: by 2002:a05:6214:e82:: with SMTP id hf2mr1260034qvb.22.1620256766428;
        Wed, 05 May 2021 16:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrf6/P25SquN9SJbJPN+P3WLa7pQBOu70auUucnAsduD5gcjZBVPI39mewNtJuN0YMSZCgHQ==
X-Received: by 2002:a05:6214:e82:: with SMTP id hf2mr1260019qvb.22.1620256766268;
        Wed, 05 May 2021 16:19:26 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id i129sm621947qke.103.2021.05.05.16.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 16:19:25 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/3] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505200610.13943-1-longman@redhat.com>
 <20210505200610.13943-3-longman@redhat.com>
 <935031de-f177-b49f-2a1d-2af2b519a270@suse.cz>
Message-ID: <e27561f4-75ac-77ae-de09-6c7d1cd96967@redhat.com>
Date:   Wed, 5 May 2021 19:19:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <935031de-f177-b49f-2a1d-2af2b519a270@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 5:41 PM, Vlastimil Babka wrote:
> On 5/5/21 10:06 PM, Waiman Long wrote:
>> There are currently two problems in the way the objcg pointer array
>> (memcg_data) in the page structure is being allocated and freed.
>>
>> On its allocation, it is possible that the allocated objcg pointer
>> array comes from the same slab that requires memory accounting. If this
>> happens, the slab will never become empty again as there is at least
>> one object left (the obj_cgroup array) in the slab.
>>
>> When it is freed, the objcg pointer array object may be the last one
>> in its slab and hence causes kfree() to be called again. With the
>> right workload, the slab cache may be set up in a way that allows the
>> recursive kfree() calling loop to nest deep enough to cause a kernel
>> stack overflow and panic the system.
>>
>> One way to solve this problem is to split the kmalloc-<n> caches
>> (KMALLOC_NORMAL) into two separate sets - a new set of kmalloc-<n>
>> (KMALLOC_NORMAL) caches for unaccounted objects only and a new set of
>> kmalloc-cg-<n> (KMALLOC_CGROUP) caches for accounted objects only. All
>> the other caches can still allow a mix of accounted and unaccounted
>> objects.
>>
>> With this change, all the objcg pointer array objects will come from
>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>> both the recursive kfree() problem and non-freeable slab problem are
>> gone.
>>
>> Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer have
>> mixed accounted and unaccounted objects, this will slightly reduce the
>> number of objcg pointer arrays that need to be allocated and save a bit
>> of memory. On the other hand, creating a new set of kmalloc caches does
>> have the effect of reducing cache utilization. So it is properly a wash.
>>
>> The new KMALLOC_CGROUP is added between KMALLOC_NORMAL and
>> KMALLOC_RECLAIM so that the first for loop in create_kmalloc_caches()
>> will include the newly added caches without change.
>>
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> A last nitpick: the new caches -cg should perhaps not be created when
> cgroup_memory_nokmem == true because kmemcg was disabled by the respective boot
> param.
>
It is a nice to have feature. However, the nokmem kernel parameter isn't 
used that often. The cgroup_memory_nokmem variable is private to 
memcontrol.c and is not directly accessible. I will take a look on that, 
but it will be a follow-on patch. I am not planning to change the 
current patchset unless there are other issues coming up.

Cheers,
Longman

