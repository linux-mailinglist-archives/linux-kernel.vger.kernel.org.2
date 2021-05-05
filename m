Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A9D374802
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 20:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbhEEScc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 14:32:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42056 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229810AbhEESca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 14:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620239493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iZZoApOePTacyMEHxFVuuuLNE5NT9++VAw5gEmX09no=;
        b=CHvk6OMMeCiGGV6zEBcTnDHqCTHFXjaNR6yTZcgs5KXUzfvN0PDIO2SjUytxS49sV7mOIg
        9X+BaD84d/0tWEwkObDCWJ8WsRQmgR/+U4FEz1R+PfgO0LkoJ2DZEcy6JkY5RQOZ4xol7b
        d7YkCyeafoe9wTUTwFdmsKDMeYxMW1U=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-ZBqTGe9ePu-zyD10Gis9Pw-1; Wed, 05 May 2021 14:31:31 -0400
X-MC-Unique: ZBqTGe9ePu-zyD10Gis9Pw-1
Received: by mail-qk1-f198.google.com with SMTP id d15-20020a05620a136fb02902e9e93c69c8so1754163qkl.23
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 11:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iZZoApOePTacyMEHxFVuuuLNE5NT9++VAw5gEmX09no=;
        b=K8STJLoiGW+s6bwi9MribVQH3xkJxjLDcq8foOlqqtfi/hHFMgaqRA6RzHZGvKY3GN
         Nv78qA1eui7+VccAy0xKP8wVgotQrYUC9bFIG4esSqRYYRXgsbeLg+rLy7xdL3RqsquM
         qLguzw/YTu+FMnxXq2jMCScjCvhMsKMRXM7VKtycGeqMbxxAV7HNArtQ+o9lXvoZE6Jm
         JvJ/muSF10BbSZXse5shcoiZ+Uy+yuJtA7wkKx/HzCRa86Ft/GGeEAHEwJtWcGvyzPaV
         jQ9rLsaOcv+nltMr6qajqjMA9xAakHNx7sDwGFyHmXD4NocGupLaFSTqMc7OX98FDzLH
         yQNg==
X-Gm-Message-State: AOAM532bjl80Jl/gwJVxopShdBc8li3jGY44uYCAFlXd7RFjLVOd+W+7
        t5thsTbU2HbLPT47JzeC3j4B3d7G5gFWMb1IxrV1l1MVeZSo/oeLlu9OzD8sHLGcojAcT+IN/v7
        oJmZKTSlBBd0skREZgsFOMr0y
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr25472615qtu.354.1620239491473;
        Wed, 05 May 2021 11:31:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3Vgrw+Obvg37H8gXeV4VtntcL6XTn6AldJFseCTJC3EWm+0xAcC/5uqwBEOES5ueZAeNNDQ==
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr25472588qtu.354.1620239491305;
        Wed, 05 May 2021 11:31:31 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id h7sm25955qtr.50.2021.05.05.11.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 11:31:30 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20210505154613.17214-1-longman@redhat.com>
 <20210505154613.17214-3-longman@redhat.com>
 <YJLWN6bNBYyKRPEN@carbon.DHCP.thefacebook.com>
 <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
Message-ID: <4e4b6903-2444-f4ed-f589-26d5beae3120@redhat.com>
Date:   Wed, 5 May 2021 14:31:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <235f45b4-2d99-f32d-ac2b-18b59fea5a25@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 2:02 PM, Vlastimil Babka wrote:
> On 5/5/21 7:30 PM, Roman Gushchin wrote:
>> On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
>>> With this change, all the objcg pointer array objects will come from
>>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>>> both the recursive kfree() problem and non-freeable slab problem are
>>> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>>> have mixed accounted and unaccounted objects, this will slightly reduce
>>> the number of objcg pointer arrays that need to be allocated and save
>>> a bit of memory.
>> Unfortunately the positive effect of this change will be likely
>> reversed by a lower utilization due to a larger number of caches.
>>
>> Btw, I wonder if we also need a change in the slab caches merging procedure?
>> KMALLOC_NORMAL caches should not be merged with caches which can potentially
>> include accounted objects.
> Good point. But looks like kmalloc* caches are extempt from all merging in
> create_boot_cache() via
>
> 	s->refcount = -1;       /* Exempt from merging for now */
>
> It wouldn't hurt though to create the kmalloc-cg-* caches with SLAB_ACCOUNT flag
> to prevent accidental merging in case the above is ever removed. It would also
> better reflect reality, and ensure that the array is allocated immediately with
> the page, AFAICS.
>
I am not sure if this is really true.

struct kmem_cache *__init create_kmalloc_cache(const char *name,
                 unsigned int size, slab_flags_t flags,
                 unsigned int useroffset, unsigned int usersize)
{
         struct kmem_cache *s = kmem_cache_zalloc(kmem_cache, GFP_NOWAIT);

         if (!s)
                 panic("Out of memory when creating slab %s\n", name);

         create_boot_cache(s, name, size, flags, useroffset, usersize);
         kasan_cache_create_kmalloc(s);
         list_add(&s->list, &slab_caches);
         s->refcount = 1;
         return s;
}

Even though refcount is set to -1 initially, it is set back to 1 
afterward. So merging can still happen AFAICS.

Cheers,
Longman

