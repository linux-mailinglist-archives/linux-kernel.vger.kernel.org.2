Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA783FDF78
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 18:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245093AbhIAQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 12:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49016 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbhIAQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 12:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630512659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mT4QIhya+0xdZYe/0Zyc1Hnz1PU8Nz7fJMWnC7SmgOo=;
        b=XAUYrMBPoq5sXrerogC+k4AMJCjksictOzTaq+WokV8oaGVnZs5xRngDHee+k3H00UAJVE
        X3ohyaZAOVz8O/ZyVMaUD2rPtP8vCXVkTQRD/BbWKbFfjxSCBeG6hErro/HT0p//SsfBb7
        vpTbzPvG6ad3/x8RpqKQWw36zk3/cB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-2MQ0r732OWCoZ3xGrsTrnw-1; Wed, 01 Sep 2021 12:10:58 -0400
X-MC-Unique: 2MQ0r732OWCoZ3xGrsTrnw-1
Received: by mail-wm1-f71.google.com with SMTP id u1-20020a05600c210100b002e74fc5af71so85594wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 09:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mT4QIhya+0xdZYe/0Zyc1Hnz1PU8Nz7fJMWnC7SmgOo=;
        b=pnqFmCS8Ep5cUyZZ7PKKeSMd36pvVGF/rI/hqoN2FJk/mbpO+qb4Q1XxjBxujBmxca
         GrBIe7moLeg3IJhwtf1oRnhL89qkVTFRt+fTpjqcz2E0BNRabdpm1qC+zZtH3LWMWGjN
         C6tl7Eg5NgHnfomnMp8hng02nAp3ZBCyg4SUYEDwzBQvIFuXxXzVxODyX3GTvR/d/U3C
         KZucNH7RZtbNbT9TU4+YbdG2zRI5Hy/bFxW4gzrC7YqRmnVNLM0cXitEYKHiXjv2zX9o
         6VDqJkj/dlhqgACh0US5aPYeY6C2ecX3nxIANrkk901C38i23F3LY1QbnvAorT6yjoot
         nxUw==
X-Gm-Message-State: AOAM53311b7lEXy5hatLG5gM6U3FqyRv5NDz8V1NmPR8ObZ2QMjVxhqZ
        TPayYauQIWSevjnTzFWmP7dqc34s6UarN09Eg/QUVrr3JgW0x0Jgku4qTZB9IB3flgRz1u/zR7Y
        NSSR+WFwH3R2PC5f/GO7lO2fC
X-Received: by 2002:adf:9e08:: with SMTP id u8mr78360wre.383.1630512657483;
        Wed, 01 Sep 2021 09:10:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybwshSMTwTpFwbu/boQ/+Fuo8ShMQQyVxqlM2ZX1sFjop+HUylkUhe8YE6xALeAwPvCgllUA==
X-Received: by 2002:adf:9e08:: with SMTP id u8mr78325wre.383.1630512657206;
        Wed, 01 Sep 2021 09:10:57 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23f71.dip0.t-ipconnect.de. [79.242.63.113])
        by smtp.gmail.com with ESMTPSA id l17sm1482748wrz.35.2021.09.01.09.10.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 09:10:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] Free user PTE page table pages
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, akpm@linux-foundation.org,
        tglx@linutronix.de, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, kirill.shutemov@linux.intel.com,
        mika.penttila@nextfour.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com
References: <20210819031858.98043-1-zhengqi.arch@bytedance.com>
 <5b9348fc-95fe-5be2-e9df-7c906e0c9b81@redhat.com>
 <20210901160742.GR1200268@ziepe.ca>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <0d2cb431-bd43-7064-4311-ab541f11fbf8@redhat.com>
Date:   Wed, 1 Sep 2021 18:10:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210901160742.GR1200268@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.21 18:07, Jason Gunthorpe wrote:
> On Wed, Sep 01, 2021 at 02:32:08PM +0200, David Hildenbrand wrote:
>   
>> b) pmd_trans_unstable_or_pte_try_get() and friends are really ugly.
> 
> I suspect the good API here is really more like:

That was my exactly my first idea and I tried to rework the code for 
roughly 2 days and failed.

Especially in pagefault logic, we temporarily unmap/unlock to map/lock 
again later and don't want the page table to just vanish.

I think I met similar cases when allocating a page table and not wanting 
it to vanish and not wanting to map/lock it. But I don't recall all the 
corner cases: it didn't work for me.

> 
>    ptep = pte_try_map(pmdp, &pmd_value)
>    if (!ptep) {
>       // pmd_value is guarenteed to not be a PTE table pointer.
>       if (pmd_XXX(pmd_value))
>    }
> 
> Ie the core code will do whatever stuff, including the THP data race
> avoidance, to either return the next level page table or the value of
> a pmd that is not a enxt level page table. Callers are much clearer in
> this way.
> 
> Eg this is a fairly representative sample user:
> 
> static int smaps_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> 			   struct mm_walk *walk)
> {
> 	if (pmd_trans_unstable(pmd))
> 		goto out;
> 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> 
> And it is obviously pretty easy to integrate any refcount into
> pte_try_map and pte_unmap as in my other email.

It didn't work when I tried.

-- 
Thanks,

David / dhildenb

