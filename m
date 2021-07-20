Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F393CF2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhGTDUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242301AbhGTDTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:19:30 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933B1C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 21:00:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d1so10834601plg.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 21:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=LsDEvt+bbqYoU5zEPmbWdAeNMHMU10ECNhR4D6yP+0g=;
        b=Y/l/MXGyUc5j65oWklB0fLPG9owxhicm0ysyUPkN5qmQnVYOq/fW6Y2A77uBB38551
         lyVBlCXnxxPttsbp5R+EBre6x55mJLBXNrCt55Pne5pU9egnwpCLcb/VobQZ2WiZ7Ieh
         SOour+SNJOzWAp2fc3HQ/oiqtyeruzsWe4L/UeLOppL/Y/FgRwe9bq5k4ZriHvoyTQqX
         AFdY9+mgIwmZjJG8RjE3YOJXk6B9VFWwjbalAzZPc2+0YNVvVqA4vAUvps+3rlbxe7bz
         Z5c4R4B/d1ifFqIARoKQZcDzwQFUIqOoZ8n3NhW3jqK4G7y7HFVqAIvR7PQHDQF6WnoK
         bu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=LsDEvt+bbqYoU5zEPmbWdAeNMHMU10ECNhR4D6yP+0g=;
        b=pnsAPuu/6ak4fQnMYB5xrz9TdqB+C77me3EgTN4LmjPsGJ4T0GteUkMkcYT2BbYVxw
         VkRtrlrg9SGigSL5qYI2Sk9ZS3TJB6Vu5bIsr5G3Q6FuS7pNwG4gWfNqNa9sVl13Jo9t
         YF8EYpKvPcYKgrom8J4oQksWIrBSIJXPkQZIQqKFHlgKGS5Wovev2gPJzM/GA/klRPHb
         WYl3r2iLhoaMabg2Ek7S0fH3ACEBUmgcBAJdwyTW9J53l4tf1yl5N5w2UVZE+owUp75X
         cY6vJNJEhroGjSj74y88GrM/D5BfdIfbcpkHgKszHDE6Ea/mP9CuT9DHOUvkOhJ+iTnB
         YYWA==
X-Gm-Message-State: AOAM53139cnpKPMdNZR2GQ30gvZYQS7BcuTmfo0FdJ+GY2ffRPpYJIKx
        62pLY2WSPPit1AwTuIEIj+puBA==
X-Google-Smtp-Source: ABdhPJw6mh9yUN8q0Jroq9MxXz0SQ3dON98jC9N/3zrg9BgpEySCUkL5IfzvS+cB6LnaaCXYRppPcA==
X-Received: by 2002:a17:902:8c83:b029:129:17e5:a1cc with SMTP id t3-20020a1709028c83b029012917e5a1ccmr22051804plo.49.1626753608080;
        Mon, 19 Jul 2021 21:00:08 -0700 (PDT)
Received: from [10.254.201.89] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id b22sm17798221pje.1.2021.07.19.21.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jul 2021 21:00:07 -0700 (PDT)
Subject: Re: [PATCH 0/7] Free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <5ce5fb25-df1d-b807-8807-595b8a7bfc63@redhat.com>
 <089e710c-fb06-e731-6d50-7858d6b9ecdf@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
Message-ID: <2c9bc121-5d4f-4503-e2bd-b5cec0088352@bytedance.com>
Date:   Tue, 20 Jul 2021 12:00:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <089e710c-fb06-e731-6d50-7858d6b9ecdf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/21 7:28 PM, David Hildenbrand wrote:
> On 19.07.21 09:34, David Hildenbrand wrote:
>> On 18.07.21 06:30, Qi Zheng wrote:
>>> Hi,
>>>
>>> This patch series aims to free user PTE page table pages when all PTE 
>>> entries
>>> are empty.
>>>
>>> The beginning of this story is that some malloc libraries(e.g. 
>>> jemalloc or
>>> tcmalloc) usually allocate the amount of VAs by mmap() and do not 
>>> unmap those VAs.
>>> They will use madvise(MADV_DONTNEED) to free physical memory if they 
>>> want.
>>> But the page tables do not be freed by madvise(), so it can produce many
>>> page tables when the process touches an enormous virtual address space.
>>
>> ... did you see that I am actually looking into this?
>>
>> https://lkml.kernel.org/r/bae8b967-c206-819d-774c-f57b94c4b362@redhat.com
>>
>> and have already spent a significant time on it as part of my research,
>> which is *really* unfortunate and makes me quite frustrated at the
>> beginning of the week alreadty ...
>>
>> Ripping out page tables is quite difficult, as we have to stop all page
>> table walkers from touching it, including the fast_gup, rmap and page
>> faults. This usually involves taking the mmap lock in write. My approach
>> does page table reclaim asynchronously from another thread and do not
>> rely on reference counts.
> 
> FWIW, I had a quick peek and I like the simplistic approach using 
> reference counting, although it seems to come with a price. By hooking 
> using pte_alloc_get_map_lock() instead of pte_alloc_map_lock, we can 
> handle quite some cases easily.
> 
> There are cases where we might immediately see a reuse after discarding 
> memory (especially, with virtio-balloon free page reporting), in which 
> case it's suboptimal to immediately discard instead of waiting a bit if 
> there is a reuse. However, the performance impact seems to be 
> comparatively small.

Good point, maybe we can wait a bit in the free_pte_table() in the added
optimiztion patch if the frequency of immediate reuse is high.

> 
> I do wonder if the 1% overhead you're seeing is actually because of 
> allcoating/freeing or because of the reference count handling on some 
> hot paths.
> 
> I'm primarily looking into asynchronous reclaim, because it somewhat 
> makes sense to only reclaim (+ pay a cost) when there is really need to 
> reclaim memory -- similar to our shrinker infrastructure.
> 
