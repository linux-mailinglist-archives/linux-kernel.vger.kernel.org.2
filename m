Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD6B3654BC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 11:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhDTJEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 05:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231234AbhDTJET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 05:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618909428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOmqfkZfJ81cGODs96B5RU3aGjEyMHtTRJDCqNpS4YI=;
        b=FN0Ja/cvm7Bl/F4MSgWPK/+OOr3vGCYjjGJ1+pQLsoN93f2H8R+EVcVMMXmLYxthwxA52W
        Zbvk0nmxpsLS8Y9zf2KKt7IgWvRaxqEGIQBwwyTho+xU9x8TwwQNgkkup8nRYouKE3cdcp
        nbKG5/5Nf2VFyc6XfLEWCkEEMJKUkpg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-Av7uYwEIMy6a9nkCJKq9Yg-1; Tue, 20 Apr 2021 05:03:46 -0400
X-MC-Unique: Av7uYwEIMy6a9nkCJKq9Yg-1
Received: by mail-ej1-f69.google.com with SMTP id i10-20020a1709067a4ab029037c5dba8400so4557920ejo.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 02:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zOmqfkZfJ81cGODs96B5RU3aGjEyMHtTRJDCqNpS4YI=;
        b=uCNB4zbdfh5mecQDtU+30bFgtWrl25TrJ8WD2X/riEE1f0/AM029QAgVhIbBxfdqG/
         UOT+/ZmNKsKzZuS//JsapU39/vmrPZelwQl50Ty944StZHHuBdRnwSIy+iaRvJkoqFJ1
         vTmsnxR150GihLD7vlLjRdZJ8vWd/X9eVVm7HfeVftmfYaNqYFbnffqewWG+6SuVrjdC
         38ZH7ryugXl7EajgwAJXIPAVvfrC/kI6BGyVoRmy2io1MxyATI1BbxSXzjs2rLMXLVSz
         YKTsxSb3tng9pE/p7dmqQwBW6dojB7gA4JRDQyvnH615LzFx5kzfnP9AVWEIM94C2YRV
         sixg==
X-Gm-Message-State: AOAM533QaLSTUaSxOSbnfsglYU43MKR8uiHm6DOb5wmObxRuMs0c1wEj
        THqjco3+pLw70KOCf3azt4BenYKZkfUC15ShJTzZkJXIJu+BV0LuBw110D7mJFnCWxAhsfdqVZe
        nua39/P3piAq2LjLR1iB4PS1q
X-Received: by 2002:aa7:cd6e:: with SMTP id ca14mr14442998edb.111.1618909425290;
        Tue, 20 Apr 2021 02:03:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ3pRylkvogdCY5d+NpiLzbIuTxXYQR0frVwMnQm2/ZbN0JlGpq74b49bjg7gPVq+dRBi8IA==
X-Received: by 2002:aa7:cd6e:: with SMTP id ca14mr14442958edb.111.1618909425009;
        Tue, 20 Apr 2021 02:03:45 -0700 (PDT)
Received: from [192.168.3.132] (p4ff2390a.dip0.t-ipconnect.de. [79.242.57.10])
        by smtp.gmail.com with ESMTPSA id gu14sm10625639ejb.114.2021.04.20.02.03.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 02:03:44 -0700 (PDT)
To:     Christoph Lameter <cl@gentwo.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "linuxppc-dev @ lists . ozlabs . org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <1618199302-29335-1-git-send-email-anshuman.khandual@arm.com>
 <09284b9a-cfe1-fc49-e1f6-3cf0c1b74c76@arm.com>
 <162877dd-e6ba-d465-d301-2956bb034429@redhat.com>
 <ce4f9838-da4b-1423-4123-23c0941a2198@arm.com>
 <alpine.DEB.2.22.394.2104191236500.777076@gentwo.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH V2] mm/page_alloc: Ensure that HUGETLB_PAGE_ORDER is less
 than MAX_ORDER
Message-ID: <01bdeedc-f77d-ebd0-9d42-62f09b0a2d1a@redhat.com>
Date:   Tue, 20 Apr 2021 11:03:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2104191236500.777076@gentwo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

thanks for your insight.

> You can have larger blocks but you would need to allocate multiple
> contigous max order blocks or do it at boot time before the buddy
> allocator is active.
> 
> What IA64 did was to do this at boot time thereby avoiding the buddy
> lists. And it had a separate virtual address range and page table for the
> huge pages.
> 
> Looks like the current code does these allocations via CMA which should
> also bypass the buddy allocator.

Using CMA doesn't really care about the pageblock size when it comes to 
fragmentation avoidance a.k.a. somewhat reliable allocation of memory 
chunks with an order > MAX_ORDER - 1.

IOW, when using CMA for hugetlb, we don't need pageblock_order > 
MAX_ORDER - 1.

> 
> 
>>>      }
>>>
>>>
>>> But it's kind of weird, isn't it? Let's assume we have MAX_ORDER - 1 correspond to 4 MiB and pageblock_order correspond to 8 MiB.
>>>
>>> Sure, we'd be grouping pages in 8 MiB chunks, however, we cannot even
>>> allocate 8 MiB chunks via the buddy. So only alloc_contig_range()
>>> could really grab them (IOW: gigantic pages).
>>
>> Right.
> 
> But then you can avoid the buddy allocator.
> 
>>> Further, we have code like deferred_free_range(), where we end up
>>> calling __free_pages_core()->...->__free_one_page() with
>>> pageblock_order. Wouldn't we end up setting the buddy order to
>>> something > MAX_ORDER -1 on that path?
>>
>> Agreed.
> 
> We would need to return the supersized block to the huge page pool and not
> to the buddy allocator. There is a special callback in the compound page
> sos that you can call an alternate free function that is not the buddy
> allocator.

Sorry, but that doesn't make any sense. We are talking about bringup 
code, where we transition from memblock to the buddy and fill the free 
page lists. Looking at the code, deferred initialization of the memmap 
is broken on these setups -- so I deferred memmap init is never enabled.

> 
>>
>>>
>>> Having pageblock_order > MAX_ORDER feels wrong and looks shaky.
>>>
>> Agreed, definitely does not look right. Lets see what other folks
>> might have to say on this.
>>
>> + Christoph Lameter <cl@linux.com>
>>
> 
> It was done for a long time successfully and is running in numerous
> configurations.

Enforcing pageblock_order < MAX_ORDER would mean that runtime allocation 
of gigantic (here:huge) pages (HUGETLB_PAGE_ORDER >= MAX_ORDER) via 
alloc_contig_pages() becomes less reliable. To compensate, relevant 
archs could switch to "hugetlb_cma=", to improve the reliability of 
runtime allocation.

I wonder which configurations we are talking about:

a) ia64

At least I couldn't care less; it's a dead architecture -- not
sure how much people care about "more reliable runtime
allocation of gigantic (here: huge) pages". Also, not sure about which 
exact configurations.

b) ppc64

We have variable hpage size only with CONFIG_PPC_BOOK3S_64. We 
initialize the hugepage either to 1M, 2M or 16M. 16M seems to be the 
primary choice.

ppc64 has CONFIG_FORCE_MAX_ZONEORDER

default "9" if PPC64 && PPC_64K_PAGES
-> 16M effective buddy maximum size
default "13" if PPC64 && !PPC_64K_PAGES
-> 16M effective buddy maximum size

So I fail to see in which scenario we even could end up with 
pageblock_order < MAX_ORDER. I did not check ppc32.

-- 
Thanks,

David / dhildenb

