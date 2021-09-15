Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC640C7BD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 16:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhIOOyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 10:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhIOOyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 10:54:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:52:47 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j1so2311017pjv.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=C2Pv2ooTfdce7tXkTH8ROpCuvqDgdiR8s/9mMjPOHH4=;
        b=dcxJIWqlAzb5DYTIYG8AwlXIJweAuseXT6s6HKLdu5Mso6GT3PxeeDVzZEBwDe3QPx
         hv5Le8wmx3cu5sEv8OmHm7HNZkoVplar0UGIB/u/munG/AYe3w/nqfzXpejeVPCswqeU
         tfcF/S7wumQ2gzp8dF4CBzqA44VbIKwQjhVACCFjyVwxiUH0B5DD2Xu4BAB05bPu9Iet
         6dlQsN9bgjJ5w3TRcqfCOwny6iODsYmDtWsf0/tUXI7t0XlzL/tPjg1lXrv8AFfyImZE
         fiA0sQdsPGJZUkZmNKeyRJIw5/lwpQ/qVBReNAij12Qcm5XngiCXJCocg5uTfOU4qION
         3ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=C2Pv2ooTfdce7tXkTH8ROpCuvqDgdiR8s/9mMjPOHH4=;
        b=yLYjC/xPOlWrzT4RCpatBX+INo0OiBzQB6M/KwUVvDbh8e+dhm38efmJN5r6+Ym2Gx
         CbX+Y3ERo43RkIN238QMt9PrpttY2k7JmdjbwPXTRT8McPf/eafJUmtjLvi3JrEKcAAZ
         VVGj4Ny5KNZpZIaHEx/SRqzHJ7hRBVGevmQzv5gZ+tEv/zhEamUb+atdKThK2OLqhbUP
         fA52IwXqhPHXkBPIkHSlUgbMNoVNgt5Navl2nsDyrwnLfwK0BIFt/Q7VqdywA+PrEfOH
         ZhKfD/PJcCiYr8jXZqJYf7FUp7+8ROoLNEkbc7XISqiivseX7Zs81e+CJIUzsqDeU+l2
         /x7Q==
X-Gm-Message-State: AOAM532yp2OWReti0P3+tnFYt+UnBdg/eiio18ZoG5W7VinHqLwpaE60
        rjvwbo0kkJH8WOT2hOMCo5MJKA==
X-Google-Smtp-Source: ABdhPJwSZ7CGy9apdu4GbVHSFYzv1SRtVFZ1FNwd4u1nYPQGpLKeKoeqfN08ZNJIqTPyJgbdGYhXsg==
X-Received: by 2002:a17:90a:428f:: with SMTP id p15mr9138753pjg.75.1631717566490;
        Wed, 15 Sep 2021 07:52:46 -0700 (PDT)
Received: from [10.254.148.129] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id b10sm198777pfl.220.2021.09.15.07.52.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 07:52:45 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <41ceeec1-52c4-4e99-201c-e1e05b2afbbc@bytedance.com>
Date:   Wed, 15 Sep 2021 22:52:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/1/21 8:32 PM, David Hildenbrand wrote:

Hi David,

>>
> 
> 
> Some high-level feedback after studying the code:
> 
> 1. Try introducing the new dummy primitives ("API") first, and then 
> convert each subsystem individually; especially, maybe convert the whole 
> pagefault handling in a single patch, because it's far from trivial. 
> This will make this series much easier to digest.

I am going to split this patch series as follows:

1. Introduce the new dummy APIs, which is an empty implementation.
    But I will explain its semantics.
2. Merge #6, #7 and #8, and call these dummy APIs in any necessary
    location, and split some special cases into single patches, such as
    pagefault and gup, etc. So that we can explain in more detail the
    concurrency in these cases. For example, we don't need to hold any
    pte_refcount in the fast path in gup on the x86_64 platform. Because
    the PTE page can't be freed after the local CPU interrupt is closed
    in the fast path in gup.
3. Introduce CONFIG_FREE_USER_PTE and implement these empty dummy APIs.
4. Add a description document.

And I try to add a function that combines pte_offset_map() and
pte_try_get(). Maybe the func name is pte_try_map() recommended by
Jason, or keep the pte_offset_map() unchanged?

> 
> Then, have a patch that adds actual logic to the dummy primitives via a 
> config option.
> 
> 2. Minimize the API.
> 
> a) pte_alloc_get{,_map,_map_lock}() is really ugly. Maybe restrict it to 
> pte_alloc_get()
I also think pte_alloc_get{,_map,_map_lock}() is ugly, but I can't
figure out a more suitable name. Maybe we can keep the
pte_alloc{,_map,_map_lock}() without any modification? But I am
worried that the caller will forget to call the paired pte_put().

> 
> b) pmd_trans_unstable_or_pte_try_get() and friends are really ugly.
> 
> Handle it independently for now, even if it implies duplicate runtime 
> checks.
> 
> if (pmd_trans_unstable() || !pte_try_get()) ...
> 
> We can always optimize later, once we can come up with something cleaner.
> 
> 3. Merge #6, and #7, after factoring out all changes to other subsystems 
> to use the API
> 
> 4. Merge #8 into #6. There is a lot of unnecessary code churn back and 
> forth, and IMHO the whole approach might not make sense without RCU due 
> to the additional locking overhead.
> 
> Or at least, try to not modify the API you introduced in patch #6 or #7 
> in #8 again. Converting all call sites back and forth just makes review 
> quite hard.
> 
> 
> I am preparing some some cleanups that will make get_locked_pte() and 
> similar a little nicer to handle. I'll send them out this or next week.
> 
Thanks,
Qi
