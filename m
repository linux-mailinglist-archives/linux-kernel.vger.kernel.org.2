Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28CA374BB3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhEEXH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 19:07:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229748AbhEEXH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 19:07:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620255988;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y2UtSfp8BrCUffF0CdlLACo8aqMI+/YAkO0AYQU2b30=;
        b=NA4FDRR7YR9+lvxBSwDmvobyBDqmrOSoy6dhUCKj4Qh/H5bskuWuNoekxIHut3zN29+mqK
        4sKvARzHc75hFmpFZwZ6T77jt7o29cMNEMNUTPs3rmTy5odpXRkJrtpiTNv/pFwu1br5Ed
        Wd0iGvk/WEb5DDsC+DyVopEBd7WMTSI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-5c8d6gCoOwWN7JvuKY01aw-1; Wed, 05 May 2021 19:06:27 -0400
X-MC-Unique: 5c8d6gCoOwWN7JvuKY01aw-1
Received: by mail-qk1-f197.google.com with SMTP id s143-20020a3745950000b029028274263008so2235442qka.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 16:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Y2UtSfp8BrCUffF0CdlLACo8aqMI+/YAkO0AYQU2b30=;
        b=Vo94sj8oL5dqLzfzUtZIohTDcKdlBRKHYOan8SAniguS3It5RsXQfSwtCDgAqat40z
         CmYtBm1VQxtEzBDsD2ODBwV4Maq/b22tHoBwMX+aCH6NAkLXOYFhg+zUYi7/G88fyD41
         3hoqMdVo8+cF0ac2BDnOt+jsStj12YlZCRaWfUEmQe6ZbU6qGcE+9T9dTDxgjQ9mEoLx
         y1jFH/uWgLZkU2qa+AylnHO0dnaXHCIY+HNq4gfibm8qwz6VV8WGd98StOPOzCP/Tadg
         BwW6MIf3loX4nCxtLP2ipUlyRT2qcNGdPAodNXu2j9Cck652Fj9V9kPdQCGiYkJoS72m
         IYuA==
X-Gm-Message-State: AOAM530mFje++PXbrR6WmepNicUULQrJdIcNO1ICjABKouWPSuSo5QiJ
        f4bYDiIlhPvDirjEhk1CF9i8pTwPJYgDrwa+kx59xyFbXG6bOieqWWE9fC4/Kvz5qiCiDihXTSl
        RS/U9cqFwGyZylbbMAuykd7pz
X-Received: by 2002:a05:6214:f6e:: with SMTP id iy14mr1253373qvb.53.1620255986850;
        Wed, 05 May 2021 16:06:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3hH/gk/oToXyZz2B9Atla//dvgE163CPVjfB/H70FKKvN99+oSJaI0N0HRHRQQFmidgkzUw==
X-Received: by 2002:a05:6214:f6e:: with SMTP id iy14mr1253349qvb.53.1620255986621;
        Wed, 05 May 2021 16:06:26 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id j196sm726721qke.25.2021.05.05.16.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 16:06:26 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v3 2/2] mm: memcg/slab: Create a new set of kmalloc-cg-<n>
 caches
To:     Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>
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
 <YJLk1tmDeGed58yr@carbon.dhcp.thefacebook.com>
 <f73cc1c6-2950-c56d-6a57-8cebb23db65b@suse.cz>
 <YJMZ+542NVnbWgat@carbon.dhcp.thefacebook.com>
Message-ID: <95ab4bdf-f373-f71d-cdf5-05ad6edbb772@redhat.com>
Date:   Wed, 5 May 2021 19:06:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YJMZ+542NVnbWgat@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 6:19 PM, Roman Gushchin wrote:
> On Wed, May 05, 2021 at 11:29:54PM +0200, Vlastimil Babka wrote:
>> On 5/5/21 8:32 PM, Roman Gushchin wrote:
>>> On Wed, May 05, 2021 at 08:02:06PM +0200, Vlastimil Babka wrote:
>>>> On 5/5/21 7:30 PM, Roman Gushchin wrote:
>>>>> On Wed, May 05, 2021 at 11:46:13AM -0400, Waiman Long wrote:
>>>>>> With this change, all the objcg pointer array objects will come from
>>>>>> KMALLOC_NORMAL caches which won't have their objcg pointer arrays. So
>>>>>> both the recursive kfree() problem and non-freeable slab problem are
>>>>>> gone. Since both the KMALLOC_NORMAL and KMALLOC_CGROUP caches no longer
>>>>>> have mixed accounted and unaccounted objects, this will slightly reduce
>>>>>> the number of objcg pointer arrays that need to be allocated and save
>>>>>> a bit of memory.
>>>>> Unfortunately the positive effect of this change will be likely
>>>>> reversed by a lower utilization due to a larger number of caches.
>>>>>
>>>>> Btw, I wonder if we also need a change in the slab caches merging procedure?
>>>>> KMALLOC_NORMAL caches should not be merged with caches which can potentially
>>>>> include accounted objects.
>>>> Good point. But looks like kmalloc* caches are extempt from all merging in
>>>> create_boot_cache() via
>>>>
>>>> 	s->refcount = -1;       /* Exempt from merging for now */
>>> Wait, s->refcount is adjusted to 1 in create_kmalloc_cache() after calling
>>> into create_boot_cache?
>> Hmm I missed that
>>
>> Now I wonder why all kmalloc caches on my system have 0 aliases :)
>> cat /sys/kernel/slab/kmalloc-*/aliases
> Yeah, I noticed it too, it's a good question. And I remember a case from
> the past when it wasn't true (kmalloc-32 was shared with something else).
>
The criteria for cache merging require close to exact match in all 
attributes with a size difference of no more than sizeof(void *). So it 
is not easy to find a close match.

Cheers,
Longman

