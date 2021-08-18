Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B660E3EFF16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhHRIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238050AbhHRIYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629275050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVDVJT4CAfoChX3cfhI7dD5M9qDIXzTRCipwxamuOKs=;
        b=MxHXBAASNDAsGqkVfOWcpF1zaC0J/buAU/7roc1Xs2oyEIbJr3rbkBJ11ygXdlLz/pU9WT
        jhw4EmJMpT6PhNg3vH+6HCWIc9KN0Q7X81qkPvdaqEwt5h58JiVThoCnq/kAvlNZReXz/f
        GmrAi/9/SXy+hE7EPO/U9JnLPPqCHJg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-dWIRZbchOP-Uui2sk_oTZw-1; Wed, 18 Aug 2021 04:24:09 -0400
X-MC-Unique: dWIRZbchOP-Uui2sk_oTZw-1
Received: by mail-wm1-f71.google.com with SMTP id f19-20020a1c1f13000000b002e6bd83c344so552281wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 01:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PVDVJT4CAfoChX3cfhI7dD5M9qDIXzTRCipwxamuOKs=;
        b=RhsZKFXJ/LHap+vzCA+cxf5gt9epDIxhqBFkMLcO4Mo8Djy0RRZF0eXCN791MuF9Vh
         13WyvyeygO5vjxIjsq8bmnAobadmOpXyCOQDtQ0LUL4X4jt0crch9dbsQdYRRYcrebhh
         Dqodker0q3Q4xZDi3jReAJ5ToHuDBO++1PckoB9DVLCCFQIjt+cP9+wlk0+S5am9SDSf
         7U9aMUuVcGFM99iIetiPF9xALsWtOm7Y0HSt8VJf3nvu7hvSR0dy+YfCCzNsHoMoibf5
         MdFtKpSn4VWi7qlV1bHddGfNGC80lL45r9N2eeJ5Lu/1n+86QIhLcY8xJvCNx/90agkE
         5f5Q==
X-Gm-Message-State: AOAM530FiRisEo0qHKFMkdamjTa8QDxX/ebTF6WkZmjAgz4K2Vv1iCOp
        8FLJYV/190A/5X+u7LMrYuKwzFVW8CAy2vrI6Dma29Ph/WMebuF+xqAdT7KBpt3fprderoeTmHk
        REX5+dxCd6Mt6ih7aebIBS7PB
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr7154233wmo.75.1629275048285;
        Wed, 18 Aug 2021 01:24:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweNYxRoLeRvv1Rq6RAvHpyYTf8x276iV7h8S5Km+dqwTr0iDZLbooRSKUfGhxv5i26aG1XlA==
X-Received: by 2002:a05:600c:230c:: with SMTP id 12mr7154210wmo.75.1629275048065;
        Wed, 18 Aug 2021 01:24:08 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6417.dip0.t-ipconnect.de. [91.12.100.23])
        by smtp.gmail.com with ESMTPSA id h4sm5338985wrm.42.2021.08.18.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 01:24:07 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alistair Popple <apopple@nvidia.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        ivan.teterevkov@nutanix.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com> <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com> <YRwa6+jx5PukCn53@t490s>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <c29a9994-8fa3-d36d-d973-f99314c243cf@redhat.com>
Date:   Wed, 18 Aug 2021 10:24:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRwa6+jx5PukCn53@t490s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.08.21 22:24, Peter Xu wrote:
> On Tue, Aug 17, 2021 at 08:46:45PM +0200, David Hildenbrand wrote:
>>> Please have a look at current pagemap impl in pte_to_pagemap_entry().  It's not
>>> accurate from the 1st day, imho.  E.g., when a page is being migrated from numa
>>> node 1 to node 2, we'll mark it PM_SWAP but I think it's not the case.  We can
>>> make it more accurate, but I think it's fine, because it's a hint.
>>
>> That inconsistency doesn't really matter as you can determine if something
>> is present and worth dumping if it's either swapped or present. As long as
>> it's one of both but not simply nothing.
>>
>> I will shamelessly reference
>> tools/testing/selftests/vm/madv_populate.c:pagemap_is_populated() that
>> checks exactly for that (the test case uses only private anonymous memory).
> 
> Then I think the MADV_POPULATE_READ|WRITE test cases shouldn't depend on
> PM_SWAP for that when it goes beyond anonymous private memories - when shmem
> swapped out the pte can be none, then the test case can fail even if it
> shouldn't, imho.

Exactly, because the pagemap is fairly completely broken for shmem.

> 
> The mincore() syscall seems to be ideally the thing you may want to make it
> accurate, but again it's not a problem for current anonymous private memories.

I haven't checked the details, but I believe the mincore() syscall won't 
report swapped out pages. At least according to its documentation:

"mincore()  returns a vector that indicates whether pages of the calling 
process's virtual memory are resident in core (RAM), and so will not 
cause a disk access  (page  fault)  if  referenced."

(to protect it from swapping and relying on mincore() we would have to 
mlock that memory; we'd want MCL_ONFAULT to be able to test 
MADV_POPULATE_READ|WRITE; or we'd just want to rely on lseek)

> 
>>
>>>
>>>> Take CRIU as an example, it has to be correct even if a process would remap a
>>>> memory region, fork() and unmap in the parent as far as I understand, ...
>>>
>>> Are you talking about dirty bit or swap bit?  I'm a bit confused on why swap
>>> bit needs to be accurate.  Maybe you mean the dirty bit?
>>
>> https://criu.org/Shared_memory
>>
>> "Dumping present pages"
>>
>> "... CRIU does not dump all of the data. Instead, it determines which pages
>> contain it, and only dumps those pages. This is done similarly to how
>> regular memory dumping and restoring works, i.e. by looking for PRESENT or
>> SWAPPED bits in owners' pagemap entries."
>>
>> -> Neither PRESENT nor SWAPPED results in memory not getting dumped, which
>> makes perfect sense.
>>
>> 1) Process A sets up shared memory and writes data to it.
>> 2) System swaps out memory, hints are setup.
>> 3) Process A forks Process B, hints are not copied.
>> 4) Process A unmaps shared memory, hints are dropped.
>> 5) CRIU migrates process A and B and migrates only PRESENT or SWAPPED in
>> pagemap.
>> 6) Process B uses memory in shared memory region. Pages were not migrated.
>>
>> Just one example; feel free to correct me.
> 
> I think pte marker won't crash criu, what will happen is that it'll see more
> ptes that used to be none that become the pte markers.  This reminded me that
> maybe I should teach up mincore() syscall to also be aware of the pte marker at
> least, and all non_swap_entry() callers.
> 

I haven't checked what mincore() is doing, but from what I understand 
when reading the CRIU doc and the mincore() doc, it does the right thing 
without requiring any fiddling with pte marker hints. I assume you 
merely have a performance improvement in mind.

>>
>>
>> There is notion of the mincore() systemcall:
>>
>> "There is one particular feature of shared memory dumps worth mentioning.
>> Sometimes, a shared memory page can exist in the kernel, but it is not
>> mapped to any process. CRIU detects such pages by calling mincore() on the
>> shmem segment, which reports back the page in-memory status. The mincore
>> bitmap is when ANDed with the per-process ones. "
>>
>> Not sure if they actually mean ORed, because otherwise they'd be losing
>> pages that have been swapped out. "mincore() returns a vector that indicates
>> whether pages of the calling process's virtual memory are resident in core
>> (RAM)"
> 
> I am wildly guessing they ORed the two just because PM_SWAP is not working
> properly for shmem, so the OR happens only for shmem.  Criu may not only rely
> on mincore() because they also want the dirty bits.
> 
> Btw, I noticed in 2016 criu switched from mincore() to lseek():
> 
> https://github.com/checkpoint-restore/criu/commit/1821acedd04b602b37b587eac5a481094b6274ae

Interesting. That's certainly what we want when it comes to skipping 
holes in files. (before reading that, I wasn't even aware that mincore() 
existed)

> 
> Criu should want to know "whether this page has valid data" not "whether this
> page has swapped out", so lseek() seems to be more suitable, which I'm not
> aware of before.

Again, just as you, I learned a lot :)

> 
> I'm now wondering whether for Tiberiu's case mincore() can also be used.  It
> should just still be a bit slow because it'll look up the cache too, but it
> should work similarly like the original proposal.
> 

Very right, maybe we can just avoid tampering with pagemap on shmem 
completely (which sounds like an excellent idea to me) and document it 
as "On shared memory, we will never indicate SWAPPED if the pages have 
been swapped out. Further, PRESENT might be under-indicated: if a shared 
page is currently not mapped into the page table of a process.". I saw 
there was a related, proposed doc update, maybe we can finetune that.


-- 
Thanks,

David / dhildenb

