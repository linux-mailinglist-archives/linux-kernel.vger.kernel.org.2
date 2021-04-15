Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6576B3610A3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 18:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhDORAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 13:00:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233407AbhDORAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 13:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618505979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=elHrGsyviNRX+T8DndgeK2yskuXfifgVcBuAA2Ta4Ok=;
        b=ewyXg4zk7G8LPtm97g8uMyScjtrJePy7OCx2SFjFsyU0Z85qgGi7wh+cEV9rB9wSh7TcPW
        c89zEp/NM3T70m2NioU9smDZgnTGxrZxG6DyNYlbgDMFVdJbz0+APdu34658zc6Fu2kea5
        /D3XGef37+yY+RPxaTRzDF0PuIHttas=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-zAQRut4iO_-wEVLxExOtyQ-1; Thu, 15 Apr 2021 12:59:36 -0400
X-MC-Unique: zAQRut4iO_-wEVLxExOtyQ-1
Received: by mail-qt1-f197.google.com with SMTP id s4-20020ac85cc40000b02901b59d9c0986so1698001qta.19
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 09:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=elHrGsyviNRX+T8DndgeK2yskuXfifgVcBuAA2Ta4Ok=;
        b=a+qeJKRAJx/5muq2VTTBmpzq4tgQQ/hp8ZI99/mihIgpwQz7CaH2s8WDda9DwNMzsq
         3CtIBoBu7HyckdaeWySewHy8y+SBbPhwHeVAPFGHbuZvulKZVexbNRCyEBook/aYoNS0
         pSEQ29z6aDY13Xg1USI4+6iWLvH5K9jDcEAGpbkCeO0tXSJ4wNcz6LkArgpD3kSn0Rfd
         sPqmCClRjSNtwlyqit5H+GDgLJmbYquJQeEOVbgvFTvBLp3GYjhhz/HVbenyrFVxYYQU
         54p0JyE6A058jb9eqVDcjaDsN6UDiHmgi6u9eVr4fUbMzSWFQlmzarcp76IuWwO//7co
         dIDQ==
X-Gm-Message-State: AOAM532Dq1CCyhgrxCOeG7owo3COgW5ES42hjH1yV+8c5SMCBykUt7tt
        4Ch+aFE0FxKVG/MIYR4ZlkAuQGR9CWaxRMPWSY0LIklo4v4AHo5ph75/j02XdIb4orV7xMxsl/l
        yG4kjX5BKOJrGFekJFlY2/RTw
X-Received: by 2002:a37:905:: with SMTP id 5mr4486247qkj.242.1618505974699;
        Thu, 15 Apr 2021 09:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvAPNkVJI8wUxitPnbMVkF+NPMJpjx0i3yeexynXZiZOvFXpqTEJad03ray4v6M3SeArr5Zw==
X-Received: by 2002:a05:620a:13a6:: with SMTP id m6mr4535437qki.64.1618505963716;
        Thu, 15 Apr 2021 09:59:23 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h65sm2349848qkc.128.2021.04.15.09.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 09:59:23 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
To:     Johannes Weiner <hannes@cmpxchg.org>
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
 <20210414012027.5352-2-longman@redhat.com> <YHhsapGx3vTlyZvF@cmpxchg.org>
Message-ID: <59a85df9-3e77-1d43-8673-2ff50a741130@redhat.com>
Date:   Thu, 15 Apr 2021 12:59:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHhsapGx3vTlyZvF@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/21 12:40 PM, Johannes Weiner wrote:
> On Tue, Apr 13, 2021 at 09:20:23PM -0400, Waiman Long wrote:
>> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
>> available. So both of them are now passed to mod_memcg_lruvec_state()
>> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
>> updated to allow either of the two parameters to be set to null. This
>> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
>> is null.
>>
>> The new __mod_memcg_lruvec_state() function will be used in the next
>> patch as a replacement of mod_memcg_state() in mm/percpu.c for the
>> consolidation of the memory uncharge and vmstat update functions in
>> the kmem_cache_free() path.
> This requires users who want both to pass a pgdat that can be derived
> from the lruvec. This is error prone, and we just acked a patch that
> removes this very thing from mem_cgroup_page_lruvec().
>
> With the suggestion for patch 2, this shouldn't be necessary anymore,
> though. And sort of underlines my point around that combined function
> creating akwward code above and below it.
>
The reason of passing in the pgdat is because of the caching of vmstat 
data. lruvec may be gone if the corresponding memory cgroup is removed, 
but pgdat should stay put. That is why I put pgdat in the obj_stock for 
caching. I could also put the node id instead of pgdat.

Cheers,
Longman

