Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0130535C81C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242068AbhDLODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238998AbhDLODi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618236200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUFKvDRszZ9E49AwoslD+yXNYOfmw6oJnUv4+bKBZOM=;
        b=W45c4zAXXx1GatkmynpAcbZadOeg6cHV6Hlkm54yZzNJYupu2J/pCb+hF/B0JOK13f9FlN
        3bBpQwJ2JOP/TXWHLCAwRldft+tERJqT9kLi91BRkXOaBddi+gws/OuF7VFwq5gCN5bL9t
        4b+oqWspzUd+RNf0oJJ42+GVCMMOIaQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-7IHnsiRNNeiONHb6sBOs8g-1; Mon, 12 Apr 2021 10:03:18 -0400
X-MC-Unique: 7IHnsiRNNeiONHb6sBOs8g-1
Received: by mail-qk1-f199.google.com with SMTP id u5so8790976qkj.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 07:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SUFKvDRszZ9E49AwoslD+yXNYOfmw6oJnUv4+bKBZOM=;
        b=KJbEwPMxTHnIHuGgJQJaHqMdxMvlkOfi4/cenhRebSgRxLrmzaamyy2bAWShBZRkrT
         TdpVjdLuJywhFSVaqr5qMDCEYqeMrrIUPc7xdi87cLkEUkedAaTo66Zh5nlRez8l7/hp
         NgeH5cuqvALVpoxlH21Rfy7FlB0410BJajFSIq+wKh8l+GncdHPgsXxgrQfKdrG9yzby
         wVM+nQG4t/52I7bsNSOUpEETrJjn5nEG7QiuAQRqQz/DqC+Kk02rKpvpw0kLOvUBOGXu
         s8XlaL+IrAgu2beUz5VKTEdRV8Y+R2UWajGuR5Ho5AYAYDTMvyXH9LWvnvYqdy7ZX+S6
         Qc7A==
X-Gm-Message-State: AOAM533ZHO9Oi5lqGSP69KbFmnvKSyhMOsJ8D2104QyGh7PhPxbp/GoV
        jLCwKzR4CnwJEM4ELFu5SfF+wJDEC1Wm4fE1OpW4BMN7qu4qlyvmYe31M6cnIVGSMZCEHWRtTND
        g07el6aG63AYtmQOioL6jj1Y6
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr26976851qki.27.1618236198078;
        Mon, 12 Apr 2021 07:03:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/m+RE4YGY3sRkMrggCvOCM/P16DqLnvzQHNIcSVq31/bvEQGmYIuoSTu7OcWz0fSglKSnDA==
X-Received: by 2002:a05:620a:22ea:: with SMTP id p10mr26976813qki.27.1618236197806;
        Mon, 12 Apr 2021 07:03:17 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id i12sm7764843qkl.49.2021.04.12.07.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 07:03:14 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 0/5] mm/memcg: Reduce kmemcache memory accounting overhead
To:     Roman Gushchin <guro@fb.com>
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
Message-ID: <51ea6b09-b7ee-36e9-a500-b7141bd3a42b@redhat.com>
Date:   Mon, 12 Apr 2021 10:03:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YHEEmGSVy3nl0obM@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/21 9:51 PM, Roman Gushchin wrote:
> On Fri, Apr 09, 2021 at 07:18:37PM -0400, Waiman Long wrote:
>> With the recent introduction of the new slab memory controller, we
>> eliminate the need for having separate kmemcaches for each memory
>> cgroup and reduce overall kernel memory usage. However, we also add
>> additional memory accounting overhead to each call of kmem_cache_alloc()
>> and kmem_cache_free().
>>
>> For workloads that require a lot of kmemcache allocations and
>> de-allocations, they may experience performance regression as illustrated
>> in [1].
>>
>> With a simple kernel module that performs repeated loop of 100,000,000
>> kmem_cache_alloc() and kmem_cache_free() of 64-byte object at module
>> init. The execution time to load the kernel module with and without
>> memory accounting were:
>>
>>    with accounting = 6.798s
>>    w/o  accounting = 1.758s
>>
>> That is an increase of 5.04s (287%). With this patchset applied, the
>> execution time became 4.254s. So the memory accounting overhead is now
>> 2.496s which is a 50% reduction.
> Hi Waiman!
>
> Thank you for working on it, it's indeed very useful!
> A couple of questions:
> 1) did your config included lockdep or not?
The test kernel is based on a production kernel config and so lockdep 
isn't enabled.
> 2) do you have a (rough) estimation how much each change contributes
>     to the overall reduction?

I should have a better breakdown of the effect of individual patches. I 
rerun the benchmarking module with turbo-boosting disabled to reduce 
run-to-run variation. The execution times were:

Before patch: time = 10.800s (with memory accounting), 2.848s (w/o 
accounting), overhead = 7.952s
After patch 2: time = 9.140s, overhead = 6.292s
After patch 3: time = 7.641s, overhead = 4.793s
After patch 5: time = 6.801s, overhead = 3.953s

Patches 1 & 4 are preparatory patches that should affect performance.

So the memory accounting overhead was reduced by about half.

Cheers,
Longman

