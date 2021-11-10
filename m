Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E229E44C60B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 18:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhKJRkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 12:40:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230230AbhKJRkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 12:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636565873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V72fuJ24xTgOW+zYH7y5UyBi5jfxtvQ+nMh5kovHOGg=;
        b=RJvFoxuiVHWZlB7co6QQ9ynIf6ObFU1ljcv03rr+pjGNpYcED3LaFz4Yc/vp/dosONp51X
        lMhapWuwZMv0uAO3GM9G1kQCX7nGI6r5ZMa+VeenOC7+KS51aopxlVS4CqK3eeETs0Zn3S
        +On8sMZQtuV91TJCjZnKsrs3uFR+j8k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-Nn26CleZP_qvRgU7ABO7jA-1; Wed, 10 Nov 2021 12:37:52 -0500
X-MC-Unique: Nn26CleZP_qvRgU7ABO7jA-1
Received: by mail-wm1-f72.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1487325wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 09:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=V72fuJ24xTgOW+zYH7y5UyBi5jfxtvQ+nMh5kovHOGg=;
        b=QF1lUYSYzdoJ+KmI5fMhHb6xGfKpts2VuBDmJWWvRkr7ok6oigXzgxCzaf8/wrPTwS
         ad0T3KQvBCf0XzAV34bytYWdzae5eO2vb6GA3q5HxC30MCCgnODW2nW3TjAKJ1M2zERm
         694ueswlSW0E8rMAMfnianlhLVylX1cwj15P/kVGiuD1pyHdqio1m5M0RBYbpaLqjtQZ
         GbGt29//NMSGD4acHw0ueylBJHa/Hql7oFoFIRo0D+CNeaTqrwTUOyouMFK0B+45lvFO
         vPh6MkqCYODytbIiJZ1xH6MeFiCN9q55ee5ZlRMSvE1BmYFpW0gMniCFCW7hZHhWAP1Z
         p2Yg==
X-Gm-Message-State: AOAM5321jEZblcOLvsZQaF3X0CTRcSbv6esoSrIw4RX40w9REcDqYDvV
        WDTmM4K5Mc+3PnIwKFkXd3CuaEGpfmZBLvbnYxmiwKnXaWntcVcrPs0pvUgBViA8YreQJZRKx6r
        jyu6q8KZXv+6ACj91wgwIaD+Y
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr902241wrn.218.1636565870781;
        Wed, 10 Nov 2021 09:37:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxo6eV2FpNqCC7ApgXEc820M/YWOnI7TToNOh2YVDJTJPljm10278YLll4KDJ6oYmc3tgd92w==
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr902207wrn.218.1636565870524;
        Wed, 10 Nov 2021 09:37:50 -0800 (PST)
Received: from [192.168.3.132] (p5b0c604f.dip0.t-ipconnect.de. [91.12.96.79])
        by smtp.gmail.com with ESMTPSA id h3sm463426wrv.69.2021.11.10.09.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 09:37:47 -0800 (PST)
Message-ID: <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
Date:   Wed, 10 Nov 2021 18:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
 <20211110125601.GQ1740502@nvidia.com>
 <8d0bc258-58ba-52c5-2e0d-a588489f2572@redhat.com>
 <20211110143859.GS1740502@nvidia.com>
 <6ac9cc0d-7dea-0e19-51b3-625ec6561ac7@redhat.com>
 <20211110163925.GX1740502@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
In-Reply-To: <20211110163925.GX1740502@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> It would still be a fairly coarse-grained locking, I am not sure if that
>> is a step into the right direction. If you want to modify *some* page
>> table in your process you have exclude each and every page table walker.
>> Or did I mis-interpret what you were saying?
> 
> That is one possible design, it favours fast walking and penalizes
> mutation. We could also stick a lock in the PMD (instead of a
> refcount) and still logically be using a lock instead of a refcount
> scheme. Remember modify here is "want to change a table pointer into a
> leaf pointer" so it isn't an every day activity..

It will be if we somewhat frequent when reclaim an empty PTE page table
as soon as it turns empty. This not only happens when zapping, but also
during writeback/swapping. So while writing back / swapping you might be
left with empty page tables to reclaim.

Of course, this is the current approach. Another approach that doesn't
require additional refcounts is scanning page tables for empty ones and
reclaiming them. This scanning can either be triggered manually from
user space or automatically from the kernel.

> 
> There is some advantage with this thinking because it harmonizes well
> with the other stuff that wants to convert tables into leafs, but has
> to deal with complicated locking.
> 
> On the other hand, refcounts are a degenerate kind of rwsem and only
> help with freeing pages. It also puts more atomics in normal fast
> paths since we are refcounting each PTE, not read locking the PMD.
> 
> Perhaps the ideal thing would be to stick a rwsem in the PMD. read
> means a table cannot be come a leaf. I don't know if there is space
> for another atomic in the PMD level, and we'd have to use a hitching
> post/hashed waitq scheme too since there surely isn't room for a waitq
> too..
> 
> I wouldn't be so quick to say one is better than the other, but at
> least let's have thought about a locking solution before merging
> refcounts :)

Yes, absolutely. I can see the beauty in the current approach, because
it just reclaims "automatically" once possible -- page table empty and
nobody is walking it. The downside is that it doesn't always make sense
to reclaim an empty page table immediately once it turns empty.

Also, it adds complexity for something that is only a problem in some
corner cases -- sparse memory mappings, especially relevant for some
memory allocators after freeing a lot of memory or running VMs with
memory ballooning after inflating the balloon. Some of these use cases
might be good with just triggering page table reclaim manually from user
space.

-- 
Thanks,

David / dhildenb

