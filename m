Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26A371E7B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhECRWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232445AbhECRWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620062483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZDSpOdU8hPfHGPNyL2Z2ZCh2W/0XFNgs6Mty9l/A+c=;
        b=OuysUCLJWTKBAuryv+zkbTO8VG98FKxASjrlGQPERNUdADSKUSQ0U6t4iwtdXePllsLm3b
        jREYgtErgm80jm237D4hrlDFEbpZoSfAgjFuJZsK0FmRz7jgh93dYhvee7yNetLQ4dpC/G
        BWOqmEJgiR/Z3p8IC7MpQqwr3DnAMRw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-7F2zffU0Mm-fJFgKkrSEWw-1; Mon, 03 May 2021 13:21:22 -0400
X-MC-Unique: 7F2zffU0Mm-fJFgKkrSEWw-1
Received: by mail-qt1-f197.google.com with SMTP id b5-20020ac867850000b02901be2b671973so1855180qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 10:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YZDSpOdU8hPfHGPNyL2Z2ZCh2W/0XFNgs6Mty9l/A+c=;
        b=lH2K5QSbLNhN7SIXHxtEjSghn9wm5B0d9YJUrA7J6ocUGhhYiX4N/oVDpvsnm2BN3u
         evy89O3AWVAhQ3M/8XjrXS6Ihbt4WrGx/zaAKghQUxGeypvAPogHTqPGWA/IAVW9ou0t
         Pnmn6FdjMk2jhn20IEFCzesWOcNj905lWS4ITKDpZsvMznLF67rLlggMA3fPDsRVIrvX
         pGkrVqpBCHAYBQnVLWLwXGpQq7VJ6+TPTz4do57C8Hl7ao7mmdlwzvD1wmIU16Q0OC7S
         3Txisd2JwWvKYLirlx2sdPgYH0akE7Id/T4WkIwa+ozuPbc2bgFNkhPUiyhmRCM/FeeV
         Bp2A==
X-Gm-Message-State: AOAM533yYphw73A2s4E91MYgDYyXv0SrQNFHFa1R3svTzbMDJDYWGFQF
        ReBWFpiR8GEE6CRuNLz/2H2HnNEszysGR14chr10mTfjU32tzg2SRRLSVCxScGcGIPw96ynKp1F
        9pfhUR/mqAxQuNQaKDgqJ2LxK
X-Received: by 2002:a37:63d2:: with SMTP id x201mr7074649qkb.202.1620062481536;
        Mon, 03 May 2021 10:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmunf7UZomjEHDhfWMtb2NRGFIT1wgqlRurUitZcql23n+8CfCkV+WD6dRYv77MurlRjHEbw==
X-Received: by 2002:a37:63d2:: with SMTP id x201mr7074617qkb.202.1620062481295;
        Mon, 03 May 2021 10:21:21 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id t3sm9023329qke.72.2021.05.03.10.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 10:21:20 -0700 (PDT)
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
Message-ID: <fc59cce6-71af-890e-030c-46357e0f0343@redhat.com>
Date:   Mon, 3 May 2021 13:21:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4aW0P2a5ZG4JO4YH2oQ8a1kM9_Tsjz-tAGP_-9hLyOpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/21 12:24 PM, Shakeel Butt wrote:
> On Mon, May 3, 2021 at 8:32 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> On 5/3/21 4:20 PM, Waiman Long wrote:
>>> On 5/3/21 8:22 AM, Vlastimil Babka wrote:
>>>> On 5/2/21 8:07 PM, Waiman Long wrote:
>>>>> The obj_cgroup array (memcg_data) embedded in the page structure is
>>>>> allocated at the first instance an accounted memory allocation happens.
>>>>> With the right size object, it is possible that the allocated obj_cgroup
>>>>> array comes from the same slab that requires memory accounting. If this
>>>>> happens, the slab will never become empty again as there is at least one
>>>>> object left (the obj_cgroup array) in the slab.
>>>>>
>>>>> With instructmentation code added to detect this situation, I got 76
>>>>> hits on the kmalloc-192 slab when booting up a test kernel on a VM.
>>>>> So this can really happen.
>>>>>
>>>>> To avoid the creation of these unfreeable slabs, a check is added to
>>>>> memcg_alloc_page_obj_cgroups() to detect that and double the size
>>>>> of the array in case it happens to make sure that it comes from a
>>>>> different kmemcache.
>>>>>
>>>>> This change, however, does not completely eliminate the presence
>>>>> of unfreeable slabs which can still happen if a circular obj_cgroup
>>>>> array dependency is formed.
>>>> Hm this looks like only a half fix then.
>>>> I'm afraid the proper fix is for kmemcg to create own set of caches for the
>>>> arrays. It would also solve the recursive kfree() issue.
>>> Right, this is a possible solution. However, the objcg pointers array should
>>> need that much memory. Creating its own set of kmemcaches may seem like an
>>> overkill.
>> Well if we go that way, there might be additional benefits:
>>
>> depending of gfp flags, kmalloc() would allocate from:
>>
>> kmalloc-* caches that never have kmemcg objects, thus can be used for the objcg
>> pointer arrays
>> kmalloc-cg-* caches that have only kmemcg unreclaimable objects
>> kmalloc-rcl-* and dma-kmalloc-* can stay with on-demand
>> memcg_alloc_page_obj_cgroups()
>>
>> This way we fully solve the issues that this patchset solves. In addition we get
>> better separation between kmemcg and !kmemcg thus save memory - no allocation of
>> the array as soon as a single object appears in slab. For "kmalloc-8" we now
>> have 8 bytes for the useful data and 8 bytes for the obj_cgroup  pointer.
>>
> Yes this seems like a better approach.
>
OK, I will try to go this route then if there is no objection from others.

 From slabinfo, the objs/slab numbers range from 4-512. That means we 
need kmalloc-cg-{32,64,128,256,512,1k,2k,4k}. A init function to set up 
the new kmemcaches and an allocation function that use the proper 
kmemcaches to allocate from.

Cheers,
Longman

