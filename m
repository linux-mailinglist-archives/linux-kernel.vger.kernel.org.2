Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011B6361251
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhDOSsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 14:48:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234505AbhDOSr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 14:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618512455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YhU7TCQFVSEb9BISH8yUV4uS7YEP0B0LlCGjPhsfIjk=;
        b=RHiDO3VVOHh2cnqVGwB19qxEhTKswqcaTc1HJSmXceVJ+18iJA+RDSoWlo58AItVpahRxH
        LHrk50W1b8Zv5NtnlYG7OumxQofHWk22/2MIfH55nRz0ImrJYs+cYCAcZgC0pbbdjazpqM
        ZjsASs5rzXqXm27NuV9yRR0d/SBsItk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-RnAw17uYPOC-A81ar37W2Q-1; Thu, 15 Apr 2021 14:47:34 -0400
X-MC-Unique: RnAw17uYPOC-A81ar37W2Q-1
Received: by mail-qt1-f197.google.com with SMTP id i9-20020ac85e490000b02901b186fa5716so4612291qtx.22
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 11:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YhU7TCQFVSEb9BISH8yUV4uS7YEP0B0LlCGjPhsfIjk=;
        b=JKR3+pGex90kx7lWrl16o1SSHCYOX2ftBTwxD3l9InbXCNc8K7ieOQwLjjBqJ7Goop
         mDRugXs9YcjTqfs6H/9BiMawZqeQ+QL5dl03RcU6bnwsc2no2LG8FbgZ81aElpXSNr6r
         IPacYtUzpFkCj5OT/9ObVlxO2/HPJ4xdpaKj7Qlc0dYWGbL6upfyRqRM+U5QJ8GfB/HV
         vYVeIjzywi20qRvrebDbZkZILjbiYuT38FaJFJxrUa3OBtm4Xvb8QeQuK9oRz3WYDIhL
         /EFJmBahj5qyB/Zh1zydtEeOl1r/ZRpvep4QXcs7bUktgGeAHqTeV2LGA0Y0iZDg86TR
         KlBw==
X-Gm-Message-State: AOAM532mMyQWzF2J9ZwHnZk9NFT/RqZojTrxgI3YGdGf3bai3/Z8Nk0K
        z43NPN1BLY/80ZCxF9BAtX0RhNpNOX/t4Al7jA6yssdq1DAHOmFXntCldQ/K9p2g7YDB2d2eW5x
        Mfdmki184nHoGAOFvbBcgeJmk
X-Received: by 2002:a37:46d5:: with SMTP id t204mr4781190qka.211.1618512453589;
        Thu, 15 Apr 2021 11:47:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUdX6JKkD3hF7Cdh86JsrrLjUwoikG2qPfbSEJduJ0S04O2Lz1qwFCwKtpktu1s8vKKzSdEQ==
X-Received: by 2002:a37:46d5:: with SMTP id t204mr4781179qka.211.1618512453403;
        Thu, 15 Apr 2021 11:47:33 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id c23sm2489546qkk.24.2021.04.15.11.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 11:47:33 -0700 (PDT)
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
Message-ID: <8a104fd5-64c7-3f41-981c-9cfa977c78a6@redhat.com>
Date:   Thu, 15 Apr 2021 14:47:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHiBlhUWoCKqQgM7@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 2:10 PM, Johannes Weiner wrote:
> On Thu, Apr 15, 2021 at 12:35:45PM -0400, Waiman Long wrote:
>> On 4/15/21 12:30 PM, Johannes Weiner wrote:
>>> On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
>>>> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
>>>> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
>>>> function call goes through a separate irq_save/irq_restore cycle. That
>>>> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
>>>> that combines them with a single irq_save/irq_restore cycle.
>>>>
>>>> @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>>>>    	refill_obj_stock(objcg, size);
>>>>    }
>>>> +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>>>> +				   struct pglist_data *pgdat, int idx)
>>> The optimization makes sense.
>>>
>>> But please don't combine independent operations like this into a
>>> single function. It makes for an unclear parameter list, it's a pain
>>> in the behind to change the constituent operations later on, and it
>>> has a habit of attracting more random bools over time. E.g. what if
>>> the caller already has irqs disabled? What if it KNOWS that irqs are
>>> enabled and it could use local_irq_disable() instead of save?
>>>
>>> Just provide an __obj_cgroup_uncharge() that assumes irqs are
>>> disabled, combine with the existing __mod_memcg_lruvec_state(), and
>>> bubble the irq handling up to those callsites which know better.
>>>
>> That will also work. However, the reason I did that was because of patch 5
>> in the series. I could put the get_obj_stock() and put_obj_stock() code in
>> slab.h and allowed them to be used directly in various places, but hiding in
>> one function is easier.
> Yeah it's more obvious after getting to patch 5.
>
> But with the irq disabling gone entirely, is there still an incentive
> to combine the atomic section at all? Disabling preemption is pretty
> cheap, so it wouldn't matter to just do it twice.
>
> I.e. couldn't the final sequence in slab code simply be
>
> 	objcg_uncharge()
> 	mod_objcg_state()
>
> again and each function disables preemption (and in the rare case
> irqs) as it sees fit?
>
> You lose the irqsoff batching in the cold path, but as you say, hit
> rates are pretty good, and it doesn't seem worth complicating the code
> for the cold path.
>
That does make sense, though a little bit of performance may be lost. I 
will try that out to see how it work out performance wise.

Cheers,
Longman

