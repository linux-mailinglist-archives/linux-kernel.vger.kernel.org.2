Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD5044D3FA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhKKJZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKKJZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636622544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pTcXn8lDBNl5Oxwvz/+9oyCccLflTYi8TLSgnD01o+8=;
        b=Y87LSoTX75W63o7nU3bel3b4one5jFhATleJNZNl/6Fe87jM0fF/jxnFfwUifJaAQeedfY
        nRUcMIG+NQ06MWP7R89gfgjS2WoglU9Fb3Kk2ZWTULjCcnsuL2m3AbsOCR+5uX1NiTwZbS
        AuJqU2ZUrWorX43ySLqf78k8WWHB6PE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-gi4JTIoWNtyqaoWsZ4gMMQ-1; Thu, 11 Nov 2021 04:22:23 -0500
X-MC-Unique: gi4JTIoWNtyqaoWsZ4gMMQ-1
Received: by mail-wm1-f70.google.com with SMTP id z126-20020a1c7e84000000b003335e5dc26bso1165032wmc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 01:22:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=pTcXn8lDBNl5Oxwvz/+9oyCccLflTYi8TLSgnD01o+8=;
        b=ot+O5YByWGD4criaTwg4pTaokiKxFuC3oiN2baW6da/8GpGi6IRSUOw/NxzYQWSFhl
         26qmqB2GLCT8aRxYyfjSmo41en4SW8MfWeCo9BwJoBlpawibHYqXoTsnJK82jDXJZ8cq
         BG2g/HatjYzfU9pgUUDLqFTgVbJ7tsHi2ssa1NTZODmevr+XR76CV38FyjcaBMFLI+k0
         uZnOB4DawB98ibFHhdPtyZMfCAPTjnqhkziZYniKm3sPyrZcAJsiAnmjAycV71s8gEyr
         sVFBDzmn5liyhyIkRo/mIqDt+YHQFeXrWtPvVrOQrLFeVtZhGuNMKEK6Rmtv5WF4F6Uk
         Z0cQ==
X-Gm-Message-State: AOAM5323YxamLPch5bLStYyef6nMPlb6lM5G+vqS6COgxr87IeiyuOB4
        7MGmYWHQILifMNF7PkO61xfw9QPK+WP+rKba4pwQV8d8KI/ObrYhZX65LvEOFM4djvad7E/irVA
        e1TwlZvFim7o4vbkvuO5AQdHR
X-Received: by 2002:a05:600c:1f0c:: with SMTP id bd12mr3732519wmb.56.1636622541772;
        Thu, 11 Nov 2021 01:22:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQNZccMd7oGqdNLArZFxY0ib2Rnyco5IqL58899+5VQyJOnRQz6tqnPpf7oggrF3pQz+ZNdg==
X-Received: by 2002:a05:600c:1f0c:: with SMTP id bd12mr3732483wmb.56.1636622541513;
        Thu, 11 Nov 2021 01:22:21 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id f133sm2279291wmf.31.2021.11.11.01.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 01:22:20 -0800 (PST)
Message-ID: <a052e0ba-a22c-5df1-80b8-d847efacd66e@redhat.com>
Date:   Thu, 11 Nov 2021 10:22:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
 <20211110163925.GX1740502@nvidia.com>
 <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
 <60515562-5f93-11cd-6c6a-c7cc92ff3bf8@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
In-Reply-To: <60515562-5f93-11cd-6c6a-c7cc92ff3bf8@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.11.21 04:58, Qi Zheng wrote:
> 
> 
> On 11/11/21 1:37 AM, David Hildenbrand wrote:
>>>> It would still be a fairly coarse-grained locking, I am not sure if that
>>>> is a step into the right direction. If you want to modify *some* page
>>>> table in your process you have exclude each and every page table walker.
>>>> Or did I mis-interpret what you were saying?
>>>
>>> That is one possible design, it favours fast walking and penalizes
>>> mutation. We could also stick a lock in the PMD (instead of a
>>> refcount) and still logically be using a lock instead of a refcount
>>> scheme. Remember modify here is "want to change a table pointer into a
>>> leaf pointer" so it isn't an every day activity..
>>
>> It will be if we somewhat frequent when reclaim an empty PTE page table
>> as soon as it turns empty. This not only happens when zapping, but also
>> during writeback/swapping. So while writing back / swapping you might be
>> left with empty page tables to reclaim.
>>
>> Of course, this is the current approach. Another approach that doesn't
>> require additional refcounts is scanning page tables for empty ones and
>> reclaiming them. This scanning can either be triggered manually from
>> user space or automatically from the kernel.
> 
> Whether it is introducing a special rwsem or scanning an empty page
> table, there are two problems as follows:
> 
> 	#1. When to trigger the scanning or releasing?

For example when reclaiming memory, when scanning page tables in
khugepaged, or triggered by user space (note that this is the approach I
originally looked into). But it certainly requires more locking thought
to avoid stopping essentially any page table walker.

> 	#2. Every time to release a 4K page table page, 512 page table
> 	    entries need to be scanned.

It would happen only when actually trigger reclaim of page tables
(again, someone has to trigger it), so it's barely an issue.

For example, khugepaged already scans the page tables either way.

> 
> For #1, if the scanning is triggered manually from user space, the
> kernel is relatively passive, and the user does not fully know the best
> timing to scan. If the scanning is triggered automatically from the
> kernel, that is great. But the timing is not easy to confirm, is it
> scanned and reclaimed every time zap or try_to_unmap?
> 
> For #2, refcount has advantages.
> 
>>
>>>
>>> There is some advantage with this thinking because it harmonizes well
>>> with the other stuff that wants to convert tables into leafs, but has
>>> to deal with complicated locking.
>>>
>>> On the other hand, refcounts are a degenerate kind of rwsem and only
>>> help with freeing pages. It also puts more atomics in normal fast
>>> paths since we are refcounting each PTE, not read locking the PMD.
>>>
>>> Perhaps the ideal thing would be to stick a rwsem in the PMD. read
>>> means a table cannot be come a leaf. I don't know if there is space
>>> for another atomic in the PMD level, and we'd have to use a hitching
>>> post/hashed waitq scheme too since there surely isn't room for a waitq
>>> too..
>>>
>>> I wouldn't be so quick to say one is better than the other, but at
>>> least let's have thought about a locking solution before merging
>>> refcounts :)
>>
>> Yes, absolutely. I can see the beauty in the current approach, because
>> it just reclaims "automatically" once possible -- page table empty and
>> nobody is walking it. The downside is that it doesn't always make sense
>> to reclaim an empty page table immediately once it turns empty.
>>
>> Also, it adds complexity for something that is only a problem in some
>> corner cases -- sparse memory mappings, especially relevant for some
>> memory allocators after freeing a lot of memory or running VMs with
>> memory ballooning after inflating the balloon. Some of these use cases
>> might be good with just triggering page table reclaim manually from user
>> space.
>>
> 
> Yes, this is indeed a problem. Perhaps some flags can be introduced so
> that the release of page table pages can be delayed in some cases.
> Similar to the lazyfree mechanism in MADV_FREE?

The issue AFAIU is that once your refcount hits 0 (no more references,
no more entries), the longer you wait with reclaim, the longer others
have to wait for populating a fresh page table because the "page table
to be reclaimed" is still stuck around. You'd have to keep the refcount
increased for a while, and only drop it after a while. But when? And
how? IMHO it's not trivial, but maybe there is an easy way to achieve it.


-- 
Thanks,

David / dhildenb

