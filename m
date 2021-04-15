Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7AD361309
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 21:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhDOTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 15:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234803AbhDOTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 15:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618515901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MzuzLCNcYk+OU/vK/NWC4xqjTEKnID3tXG3/okG0iZw=;
        b=h0y7NPKb7TCnnHoWRh5AFM0oTI++aw3kojoUAGyb95eriU6kYXNSj7kVdZJ3gP5GH/JKm9
        3s2+05qvfojiG08tfBebSjPUZcLiqP4+y0QnfDPbrOPDKyEmSJ4upVgTr3fuN39cYXI36x
        T0aqZc7nf3KjKpM5N03l2vhZGidVVUE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-Egc2-pScPheyRmq6rJLgTQ-1; Thu, 15 Apr 2021 15:44:59 -0400
X-MC-Unique: Egc2-pScPheyRmq6rJLgTQ-1
Received: by mail-qv1-f70.google.com with SMTP id 13-20020a056214202db0290187c75d98a1so2522306qvf.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 12:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MzuzLCNcYk+OU/vK/NWC4xqjTEKnID3tXG3/okG0iZw=;
        b=l9cgTsssxfVmdnMQJY6LK+qa/F+4qGDZ3Y0wo/6MgNc1jIZWKMiu1W60wGmyEhoKVP
         ODYPDCF+zMqEuBoQ7I+zuVsdzR7mG8Xh9ITl1m4GI/WFgaihc8yfd5Ho9Tov2+SRaWsp
         WkvCVAUuLqKH+R+Yt7oUMYyy7CVajT9grQuI2yrasY1PO5MLnhKL4JScFAs3D1+A4OQj
         xAEmRuVJ7Cacq3f5JU52VYfIOy9fnhUH3Ft+sSOnpJHL8V9nBD6nMhKaJdMWGFgtzZni
         mcC65024tZSnrD0B1TiLnpaqv3QUzjoXk2PYVw7RV+ZiHMREjvp/ckh58eXwMSbwx5kT
         iiUQ==
X-Gm-Message-State: AOAM533dzFLz3B/9SSnfnSHZACMI5jmDDt7S3TZ4N+a9ntxkEWOezulV
        KT1KtcCeRLjUHWuXpG28bBwGNhbGVmGfStlTFAeTPTIbThQjgQm4ZNcyP9vEY5GcGO5XVKVLqmI
        PyHiWJsUwnHnuCrOVhu77UaRS
X-Received: by 2002:a05:620a:4093:: with SMTP id f19mr1176802qko.136.1618515899002;
        Thu, 15 Apr 2021 12:44:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+EBr54ugjJ7Z8pc6qrdlkkGfICL7wFBIgBC32OsPmXGrZ6ZuIucba5mmAo/PQQafgfBHuwg==
X-Received: by 2002:a05:620a:4093:: with SMTP id f19mr1176786qko.136.1618515898806;
        Thu, 15 Apr 2021 12:44:58 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id b3sm547487qkd.29.2021.04.15.12.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 12:44:58 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/5] mm/memcg: Introduce
 obj_cgroup_uncharge_mod_state()
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <llong@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-3-longman@redhat.com> <YHhqPYcajI9JgXk/@cmpxchg.org>
 <1c85e8f6-e8b9-33e1-e29b-81fbadff959f@redhat.com>
 <YHiBlhUWoCKqQgM7@cmpxchg.org>
 <8a104fd5-64c7-3f41-981c-9cfa977c78a6@redhat.com>
 <YHiWmsQVQPGSm2El@cmpxchg.org>
Message-ID: <cba964b6-d2b6-9a74-f556-e2733b65dd81@redhat.com>
Date:   Thu, 15 Apr 2021 15:44:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHiWmsQVQPGSm2El@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 3:40 PM, Johannes Weiner wrote:
> On Thu, Apr 15, 2021 at 02:47:31PM -0400, Waiman Long wrote:
>> On 4/15/21 2:10 PM, Johannes Weiner wrote:
>>> On Thu, Apr 15, 2021 at 12:35:45PM -0400, Waiman Long wrote:
>>>> On 4/15/21 12:30 PM, Johannes Weiner wrote:
>>>>> On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
>>>>>> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
>>>>>> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
>>>>>> function call goes through a separate irq_save/irq_restore cycle. That
>>>>>> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
>>>>>> that combines them with a single irq_save/irq_restore cycle.
>>>>>>
>>>>>> @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>>>>>>     	refill_obj_stock(objcg, size);
>>>>>>     }
>>>>>> +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>>>>>> +				   struct pglist_data *pgdat, int idx)
>>>>> The optimization makes sense.
>>>>>
>>>>> But please don't combine independent operations like this into a
>>>>> single function. It makes for an unclear parameter list, it's a pain
>>>>> in the behind to change the constituent operations later on, and it
>>>>> has a habit of attracting more random bools over time. E.g. what if
>>>>> the caller already has irqs disabled? What if it KNOWS that irqs are
>>>>> enabled and it could use local_irq_disable() instead of save?
>>>>>
>>>>> Just provide an __obj_cgroup_uncharge() that assumes irqs are
>>>>> disabled, combine with the existing __mod_memcg_lruvec_state(), and
>>>>> bubble the irq handling up to those callsites which know better.
>>>>>
>>>> That will also work. However, the reason I did that was because of patch 5
>>>> in the series. I could put the get_obj_stock() and put_obj_stock() code in
>>>> slab.h and allowed them to be used directly in various places, but hiding in
>>>> one function is easier.
>>> Yeah it's more obvious after getting to patch 5.
>>>
>>> But with the irq disabling gone entirely, is there still an incentive
>>> to combine the atomic section at all? Disabling preemption is pretty
>>> cheap, so it wouldn't matter to just do it twice.
>>>
>>> I.e. couldn't the final sequence in slab code simply be
>>>
>>> 	objcg_uncharge()
>>> 	mod_objcg_state()
>>>
>>> again and each function disables preemption (and in the rare case
>>> irqs) as it sees fit?
>>>
>>> You lose the irqsoff batching in the cold path, but as you say, hit
>>> rates are pretty good, and it doesn't seem worth complicating the code
>>> for the cold path.
>>>
>> That does make sense, though a little bit of performance may be lost. I will
>> try that out to see how it work out performance wise.
> Thanks.
>
> Even if we still end up doing it, it's great to have that cost
> isolated, so we know how much extra code complexity corresponds to how
> much performance gain. It seems the task/irq split could otherwise be
> a pretty localized change with no API implications.
>
I still want to move mod_objcg_state() function to memcontrol.c though 
as I don't want to put any obj_stock stuff in mm/slab.h.

Cheers,
Longman

