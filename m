Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615793F903D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbhHZVn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 17:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40225 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232675AbhHZVn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 17:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630014157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2FmJSXlEr2qCecPowyaOlZhRz8GpI4FUiMuAU7OKCg=;
        b=Y/63FrcMG1QuuX/52F569B75PDtrTEn+pL2lwxFURSNISjv/34ZBrHTDG8irD60os6G3va
        T/QQh508iNtIxFOGq8t9SCo9vfQ9DaEpflihYw4kjJ35CFSk3OxTR9Jn0KUOjguH/uCWTe
        JYkP2fj2fqQBfsArjhdJ78Vojbh713U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-D4emmOqQPYOG8fVTrNUBBg-1; Thu, 26 Aug 2021 17:42:23 -0400
X-MC-Unique: D4emmOqQPYOG8fVTrNUBBg-1
Received: by mail-wm1-f72.google.com with SMTP id r4-20020a1c4404000000b002e728beb9fbso4872582wma.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 14:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m2FmJSXlEr2qCecPowyaOlZhRz8GpI4FUiMuAU7OKCg=;
        b=L0RAMx/2BUwky1guX9u0Tvd/eh0QPUaI+Jb51XUDaW2jAxuPoWFmyBu9ukQAHq2PXx
         EAOdIcorrqBFzYAwAE9COCmbcQtiyeFAA3mp47bUusCRS6vk0OFSrCIZweMLxbk0O6AV
         kMznwBbofJRjTiZWAG/gO/zdIAyjHH2PoGcsZL6rfKgjeuaifGk4iKKoZJDwQPUiRun9
         aIpVZDjdybHRHO8CL1F1ANnP5Iik4bGh+tE2zmKRrg6qSPd+pI8hS95zkmojYvo5iP2b
         HOSu/2gV4OZg/TGl/+XmdAcT9pfPVtnWu62eXvzS9gvpdyAFwgQKDk5TRDtED4CvisIb
         1DWw==
X-Gm-Message-State: AOAM533dxCx2/M7ZQqo/Z7Rg8W3zxBa4IXuWAITwKmhVecBuL++u/WRA
        Yh8KXNsIF+1lhq58Jrk5X5YTE1vlQTyguZfKRfi9RBaZirr7Bet6BwO6FxDmR03OCdpdFI9jcoV
        l0TqT8YLP3lxXGs3Cik+DT4w43+6Zoy/7TpWOk1CuyCBiGSzDRLCdSATQ+iCLH6MEPdC92DKC
X-Received: by 2002:adf:9783:: with SMTP id s3mr6606223wrb.349.1630014142807;
        Thu, 26 Aug 2021 14:42:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCkhqn+UwHShsb4JKtbEqOs0TLDQOFLz7yJC8vYxiDcumhU3BYy/FLLwouM+xIIp2eUTNUgA==
X-Received: by 2002:adf:9783:: with SMTP id s3mr6606161wrb.349.1630014142475;
        Thu, 26 Aug 2021 14:42:22 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23dec.dip0.t-ipconnect.de. [79.242.61.236])
        by smtp.gmail.com with ESMTPSA id i21sm4261721wrb.62.2021.08.26.14.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 14:42:21 -0700 (PDT)
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     akpm@linux-foundation.org, markubo@amazon.com,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, joe@perches.com, mgorman@suse.de,
        mheyne@amazon.de, minchan@kernel.org, mingo@redhat.com,
        namhyung@kernel.org, peterz@infradead.org, riel@surriel.com,
        rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org,
        shakeelb@google.com, shuah@kernel.org, sieberf@amazon.com,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210826172920.4877-1-sjpark@amazon.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v34 05/13] mm/damon: Implement primitives for the virtual
 memory address spaces
Message-ID: <3b094493-9c1e-6024-bfd5-7eca66399b7e@redhat.com>
Date:   Thu, 26 Aug 2021 23:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210826172920.4877-1-sjpark@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.21 19:29, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Hello David,
> 
> 
> On Thu, 26 Aug 2021 16:09:23 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>> +static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
>>> +{
>>> +	pte_t *pte = NULL;
>>> +	pmd_t *pmd = NULL;
>>> +	spinlock_t *ptl;
>>> +
>>
>> I just stumbled over this, sorry for the dumb questions:
> 
> Appreciate for the great questions!
> 
>>
>>
>> a) What do we know about that region we are messing with?
>>
>> AFAIU, just like follow_pte() and follow_pfn(), follow_invalidate_pte()
>> should only be called on VM_IO and raw VM_PFNMAP mappings in general
>> (see the doc of follow_pte()). Do you even know that it's within a
>> single VMA and that there are no concurrent modifications?
> 
> We have no idea about the region at this moment.  However, if we successfully
> get the pte or pmd under the protection of the page table lock, we ensure the
> page for the pte or pmd is a online LRU-page with damon_get_page(), before
> updating the pte or pmd's PAGE_ACCESSED bit.  We release the page table lock
> only after the update.
> 
> And concurrent VMA change doesn't matter here because we read and write only
> the page table.  If the address is not mapped or not backed by LRU pages, we
> simply treat it as not accessed.

reading/writing page tables is the real problem.

> 
>>
>> b) Which locks are we holding?
>>
>> I hope we're holding the mmap lock in read mode at least. Or how are you
>> making sure there are no concurrent modifications to page tables / VMA
>> layout ... ?
>>
>>> +	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
> 
> All the operations are protected by the page table lock of the pte or pmd, so
> no concurrent page table modification would happen.  As previously mentioned,
> because we read and update only page table, we don't care about VMAs and
> therefore we don't need to hold mmap lock here.

See below, that's unfortunately not sufficient.

> 
> Outside of this function, DAMON reads the VMAs to know which address ranges are
> not mapped, and avoid inefficiently checking access to the area with the
> information.  Nevertheless, it happens only occasionally (once per 60 seconds
> by default), and it holds the mmap read lock in the case.
> 
> Nonetheless, I agree the usage of follow_invalidate_pte() here could make
> readers very confusing.  It would be better to implement and use DAMON's own
> page table walk logic.  Of course, I might missing something important.  If you
> think so, please don't hesitate at yelling to me.


I'm certainly not going to yell :) But unfortunately I'll have to tell 
you that what you are doing is in my understanding fundamentally broken.

See, page tables might get removed any time
a) By munmap() code even while holding the mmap semaphore in read (!)
b) By khugepaged holding the mmap lock in write mode

The rules are (ignoring the rmap side of things)

a) You can walk page tables inside a known VMA with the mmap semaphore 
held in read mode. If you drop the mmap sem, you have to re-validate the 
VMA! Anything could have changed in the meantime. This is essentially 
what mm/pagewalk.c does.

b) You can walk page tables ignoring VMAs with the mmap semaphore held 
in write mode.

c) You can walk page tables lockless if the architecture supports it and 
you have interrupts disabled the hole time. But you are not allowed to 
write.

With what you're doing, you might end up reading random garbage as page 
table pointers, or writing random garbage to pages that are no longer 
used as page tables.

Take a look at mm/gup.c:lockless_pages_from_mm() to see how difficult it 
is to walk page tables lockless. And it only works because page table 
freeing code synchronizes either via IPI or fake-rcu before actually 
freeing a page table.

follow_invalidate_pte() is, in general, the wrong thing to use. It's 
specialized to VM_IO and VM_PFNMAP. take a look at the difference in 
complexity between follow_invalidate_pte() and mm/pagewalk.c!

I'm really sorry, but as far as I can tell, this is locking-wise broken 
and follow_invalidate_pte() is the wrong interface to use here.

Someone can most certainly correct me if I'm wrong, or if I'm missing 
something regarding your implementation, but if you take a look around, 
you won't find any code walking page tables without at least holding the 
mmap sem in read mode -- for a good reason.

-- 
Thanks,

David / dhildenb

