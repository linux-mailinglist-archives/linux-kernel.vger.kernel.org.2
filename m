Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A7944D08E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 04:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhKKEBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 23:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhKKEBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 23:01:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C070C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 19:58:21 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v20so4712295plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 19:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=JTeJVgs4uMWJJ4SvicTT4FHnOZ8dZrGiRRxYTiZUitI=;
        b=FQUaTfep7fnRf+51gBDqNzWsdCT6wVcyS5Uw3FhD6a5+/UZMukwYBPcn9K43Y5WSBS
         fNuNJkcVYfcBvZRpEXhJc3bwpySwSysc7PuIFVZ1tsaCOGC89+KUHxqVo0ono1Gv7uJc
         O1xuixykVvH4tZSf9zj0bnSR5uJ6iyIQ0t/cjqQKkaQfYx7VMWMfj6mPU0/BV5NfFvcJ
         DwKk2AL/hls8o6k++lPWCylONcD1pDxPUY9g3XVU0WOpk/4VNw4V3HZTaKsLryW8QMZG
         XIsZe0j73m1asOF7+7e+vn1qUPQC65n5QRd/avEhtXtn1PpWq6nEeIR3ExpuyOpCZ75z
         Eu1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JTeJVgs4uMWJJ4SvicTT4FHnOZ8dZrGiRRxYTiZUitI=;
        b=rs/1+1lI28fAUxz4Ikb4xv6nLgUhtB0eiEK4hBocQWiR+egbByrjaeINkmSrmyU+PQ
         bEDYi11rKrF2IcfLiZ954sGmq1DuAi66XuRixNIQ83JHiK3UToQm+MwPcyc4C26Y0zBb
         it1W6jjlp68Y+TcMUqfyUbDNW5bH+4TdRus76C8xddwtEUtVfG8EVi6vhadYpWwTzeWc
         PXujGDXDNIMnZgRPPslsUQNxCstuZln8D1Q5MEwziRW9cETVNsLWPUbVqfDdaWolnLuL
         4vfzlp3yW+fQvmJFdielcMQXLcR6udfzZqgb6zOF1CZoS2cFnNyMtc6LRnB0DoUfHX11
         qLCQ==
X-Gm-Message-State: AOAM531uarnNzzR+ztWbyAqjZ+z+h4V3hTmH40RXi3H8JWUy/BCw2Igl
        ADLWs44QUyS95GorrFO5eXsc4w==
X-Google-Smtp-Source: ABdhPJzMgcHiWH3WYBvm9aLEEMeTSsBXC34tf2Q+a9uHZZ2XEf5hWlILaMRH/S45qcUd0EOYmUvyMA==
X-Received: by 2002:a17:902:bd98:b0:13f:9ae7:54d1 with SMTP id q24-20020a170902bd9800b0013f9ae754d1mr4846798pls.15.1636603100724;
        Wed, 10 Nov 2021 19:58:20 -0800 (PST)
Received: from [10.254.173.217] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id n1sm843342pgb.54.2021.11.10.19.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 19:58:20 -0800 (PST)
Message-ID: <60515562-5f93-11cd-6c6a-c7cc92ff3bf8@bytedance.com>
Date:   Thu, 11 Nov 2021 11:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH v3 00/15] Free user PTE page table pages
To:     David Hildenbrand <david@redhat.com>,
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
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <7c97d86f-57f4-f764-3e92-1660690a0f24@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/21 1:37 AM, David Hildenbrand wrote:
>>> It would still be a fairly coarse-grained locking, I am not sure if that
>>> is a step into the right direction. If you want to modify *some* page
>>> table in your process you have exclude each and every page table walker.
>>> Or did I mis-interpret what you were saying?
>>
>> That is one possible design, it favours fast walking and penalizes
>> mutation. We could also stick a lock in the PMD (instead of a
>> refcount) and still logically be using a lock instead of a refcount
>> scheme. Remember modify here is "want to change a table pointer into a
>> leaf pointer" so it isn't an every day activity..
> 
> It will be if we somewhat frequent when reclaim an empty PTE page table
> as soon as it turns empty. This not only happens when zapping, but also
> during writeback/swapping. So while writing back / swapping you might be
> left with empty page tables to reclaim.
> 
> Of course, this is the current approach. Another approach that doesn't
> require additional refcounts is scanning page tables for empty ones and
> reclaiming them. This scanning can either be triggered manually from
> user space or automatically from the kernel.

Whether it is introducing a special rwsem or scanning an empty page
table, there are two problems as follows:

	#1. When to trigger the scanning or releasing?
	#2. Every time to release a 4K page table page, 512 page table
	    entries need to be scanned.

For #1, if the scanning is triggered manually from user space, the
kernel is relatively passive, and the user does not fully know the best
timing to scan. If the scanning is triggered automatically from the
kernel, that is great. But the timing is not easy to confirm, is it
scanned and reclaimed every time zap or try_to_unmap?

For #2, refcount has advantages.

> 
>>
>> There is some advantage with this thinking because it harmonizes well
>> with the other stuff that wants to convert tables into leafs, but has
>> to deal with complicated locking.
>>
>> On the other hand, refcounts are a degenerate kind of rwsem and only
>> help with freeing pages. It also puts more atomics in normal fast
>> paths since we are refcounting each PTE, not read locking the PMD.
>>
>> Perhaps the ideal thing would be to stick a rwsem in the PMD. read
>> means a table cannot be come a leaf. I don't know if there is space
>> for another atomic in the PMD level, and we'd have to use a hitching
>> post/hashed waitq scheme too since there surely isn't room for a waitq
>> too..
>>
>> I wouldn't be so quick to say one is better than the other, but at
>> least let's have thought about a locking solution before merging
>> refcounts :)
> 
> Yes, absolutely. I can see the beauty in the current approach, because
> it just reclaims "automatically" once possible -- page table empty and
> nobody is walking it. The downside is that it doesn't always make sense
> to reclaim an empty page table immediately once it turns empty.
> 
> Also, it adds complexity for something that is only a problem in some
> corner cases -- sparse memory mappings, especially relevant for some
> memory allocators after freeing a lot of memory or running VMs with
> memory ballooning after inflating the balloon. Some of these use cases
> might be good with just triggering page table reclaim manually from user
> space.
> 

Yes, this is indeed a problem. Perhaps some flags can be introduced so
that the release of page table pages can be delayed in some cases.
Similar to the lazyfree mechanism in MADV_FREE?

Thanks,
Qi
