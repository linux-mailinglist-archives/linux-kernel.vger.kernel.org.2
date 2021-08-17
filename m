Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AD03EE918
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 11:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbhHQJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 05:04:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235220AbhHQJEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 05:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629191062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+IpbFjalCEJL70F6BNCn2FQl0douXGw12dWrMR8Sr9Y=;
        b=M/upx8zIKN5dwFksfmhQPGhf9l1nEQ3qgMzsc8FzLiIOQRF62kDreM7s+EYb41TLld+Wbm
        YJLdfXxCF6lq+i6HSfPr+GjGX0mTMxPZWE7i3I9S+QXukG024FPz2lfyHExnWA9pZBHAnh
        CJBrUYNm4C9N1+1PjjON3KVCqTkJi2Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-1O4TTMFFOuO7deMk4iaoLA-1; Tue, 17 Aug 2021 05:04:21 -0400
X-MC-Unique: 1O4TTMFFOuO7deMk4iaoLA-1
Received: by mail-wr1-f71.google.com with SMTP id v18-20020adfe2920000b029013bbfb19640so6317331wri.17
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 02:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+IpbFjalCEJL70F6BNCn2FQl0douXGw12dWrMR8Sr9Y=;
        b=W0mHoYcqpCImOeboca0eZp4Zu090iNVpACLEiKWUTKFvVUccX5MxSS8WwqtjFTtIGs
         WoLQRfMLmMZv09Q6RLhsFPPSaunIZ0fNr3FTZDRe+qoqQcFdx9O/cm3hyTgH6DR6u158
         Jwt08O+nIDNCkugsMSXxa+g7A29N8YFaNgSn4nXWeFainrcixg3Ngsuh2JmnbxjAoTVe
         gPOVVLklDXCVzojHct1kWw0ybY7RxVdNr/iVR2b3PQ7Qb7vtraEcHJKu5VHKd0a6egaj
         6YW3A3veGwwH8aZ1GhPclzWyKeNeWuZ6hruHQX1oRVj0zWSUqom0HwwTefSEY7WpEuif
         ABwA==
X-Gm-Message-State: AOAM531ZC+rqZOzthB5mzPBwJScW4Yz90EGGbqKK8vuUe2/qWOqgeAzf
        PbsnKnCoQhD4tfenL1cPBe8YFEjFCTaeqIEpxopCA+UrDcDoNXratud4uxuLZW/tss95YFIwwqR
        7h0QJ+iXHEmt73aKls2KvoysD
X-Received: by 2002:adf:d194:: with SMTP id v20mr2709284wrc.126.1629191059624;
        Tue, 17 Aug 2021 02:04:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJye/5DW7piAT297rJq2MdvHuKv29UYJI0Ej0h/pY6QDpxSYNcpguZleFjWb4vEry66PwyDTTw==
X-Received: by 2002:adf:d194:: with SMTP id v20mr2709255wrc.126.1629191059320;
        Tue, 17 Aug 2021 02:04:19 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c65c6.dip0.t-ipconnect.de. [91.12.101.198])
        by smtp.gmail.com with ESMTPSA id z13sm1653015wrs.71.2021.08.17.02.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Aug 2021 02:04:18 -0700 (PDT)
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alistair Popple <apopple@nvidia.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com>
Date:   Tue, 17 Aug 2021 11:04:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210807032521.7591-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, a couple of comments, sorry for the late reply.

> Summary
> =======
> 
> [Based on v5.14-rc4]
> 
> This patchset enables PM_SWAP of pagemap on shmem.  IOW userspace will be able
> to detect whether a shmem page is swapped out, just like anonymous pages.
> 
> This feature can be enabled with CONFIG_PTE_MARKER_PAGEOUT. When enabled, it
> brings 0.8% overhead on swap-in performance on a shmem page, so I didn't make
> it the default yet.  However IMHO 0.8% is still in an acceptable range that we
> can even make it the default at last.  Comments are welcomed here.

Special config option and added complexity for handling a corner case 
feature partially more correct. Hm.

> 
> There's one previous series that wanted to address the same issue but in
> another way by Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>, here:
> 
> https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/
> 
> In that series it's done by looking up page cache for all none ptes.  However I
> raised concern on 4x performance degradation for all shmem pagemap users.

Who cares? I am asking because for me, it's hard to imagine a workload 
that actually cares about a 4x performance degradation when querying the 
pagemap in very special cases, especially if it involves gigantic shmem 
ranges. VM live migration -- sync will be a bit slower? CRIU sync will 
be a bit slower? I mean, actual page dumping is a lot more expensive. 
Really a problem?

I read that CRIU cares about shmem via pagemap [1], at least for 
anonymous shared memory; not sure how memfd is treated, I assume in a 
similar way. But I do wonder how it even works reliably, because it 
relies on present/swapped out and sofrtdirty tracking, which are both 
essentially broken e.g., when swapping out AFAIKT. Looks like this 
really needs a proper fix.

[1] https://criu.org/Shared_memory

> 
> Unlike the other approach, this series has zero overhead on pagemap read
> because the PM_SWAP info is consolidated into the zapped PTEs directly.
> 
> Goals
> =====
> 
> One major goal of this series is to add the PM_SWAP support, the reason is as
> stated by Tiberiu and Ivan in the other patchset:
> 
> https://lore.kernel.org/lkml/CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com/
> 
> As a summary: for some reason the userspace needs to scan the pages in the
> background, however that scanning could misguide page reclaim on which page is
> hot and which is cold.  With correct PM_SWAP information, the userspace can
> correct the behavior of page reclaim by firstly fetching that info from
> pagemap, and explicit madvise(MADV_PAGEOUT).  In this case, the pages are for
> the guest, but it can be any shmem page.
> 
> Another major goal of this series is to do a proof-of-concept of the PTE marker
> idea, and that's also the major reason why it's RFC.  So far PTE marker can
> potentially be the solution for below three problems that I'm aware of:
> 
>    (a) PM_SWAP on shmem
> 
>    (b) Userfaultfd-wp on shmem/hugetlbfs
> 
>    (c) PM_SOFT_DIRTY lost for shmem over swapping
> 
> This series tries to resolve problem (a) which should be the simplest, ideally
> it should solve immediate problem for the live migration issue raised by
> Tiberiu and Ivan on proactive paging out unused guest pages.
> 
> Both (a) and (c) will be for performance-wise or statistic-wise.
> 
> Scenario (b) will require pte markers as part of the function to trap writes to
> uffd-wp protected regions when the pages were e.g. swapped out or zapped for
> any reason.
> 
> Currently, uffd-wp shmem work (still during review on the list, latest v5, [1])
> used another solution called "special swap pte".  It works similarly like PTE
> markers as both of the approachs are to persist information into zapped pte,
> but people showed concern about that idea and it's suggested to use a safer
> (swp-entry level operation, not pte level), and arch-independent approach.
> 
> Hopefully PTE markers satifsfy these demands.
> 
> Before I rework the uffd-wp series, I wanted to know whether this approach can
> be accepted upstream.  So besides the swap part, comments on PTE markers will
> be extremely welcomed.

For uffd-wp in its current form, it would certainly be the way to go I 
think. AFAIKT, the idea of special swap entries isn't new, just that 
it's limited to anonymous memory for now, which makes things like fork 
and new mappings a lot cheaper.

> 
> What is PTE Markers?
> ====================
> 
> PTE markers are defined as some special PTEs that works like a "marker" just
> like in normal life.  Firstly it uses a swap type, IOW it's not a valid/present
> pte, so processor will trigger a page fault when it's accessed.  Meanwhile, the
> format of the PTE is well-defined, so as to contain some information that we
> would like to know before/during the page access happening.
> 
> In this specific case, when the shmem page is paged out, we set a marker
> showing that this page was paged out, then when pagemap is read about this pte,
> we know this is a swapped-out/very-cold page.
> 
> This use case is not an obvious one but the most simplest.  The uffd-wp use
> case is more obvious (wr-protect is per-pte, so we can't save into page cache;
> meanwhile we need that info to persist across zappings e.g. thp split or page
> out of shmem pages).
> 
> So in the future, it can contain more information, e.g., whether this pte is
> wr-protected by userfaultfd; whether this pte was written in this mm context
> for soft-dirtying.  On 64 bit systems, we have a total of 58 bits (swp_offset).
> 
> I'm also curious whether it can be further expanded to other mm areas.  E.g.,
> logically it can work too for non-RAM based memories outside shmem/hugetlbfs,
> e.g. a common file system like ext4 or btrfs?  As long as there will be a need
> to store some per-pte information across zapping of the ptes, then maybe it can
> be considered.

As already expressed, we should try storing as little information in 
page tables as possible if we're dealing with shared memory. The 
features we design around this all seem to over-complicate the actual 
users, over-complicate fork, over-complicate handling on new mappings.

For uffd-wp in its current form, there seems to be no way around it, and 
PTE markers seem to be what you want -- but as I already raised, the 
feature itself on shmem is somewhat suboptimal, just like SOFTDIRTY 
tracking on shmem.

But I guess I'm biased at this point because the main users of these 
features actually want to query/set such properties for all sharers, not 
individual processes; so the opinion of others would be appreciated.

> 
> Known Issues/Concerns
> =====================
> 
> About THP
> ---------
> 
> Currently we don't need to worry about THP because paged out shmem pages will
> be split when shrinking, IOW we only need to consider PTE, and the markers will
> only be applied to a shmem pte not pmd or bigger.
> 
> About PM_SWAP Accuracy
> ----------------------
> 
> This is not an "accurate" solution to provide PM_SWAP bit.  Two exmaples:
> 
>    - When process A & B both map shmem page P somewhere, it can happen that only
>      one of these ptes got marked with the pte marker.  Imagine below sequence:
> 
>      0. Process A & B both map shmem page P somewhere
>      1. Process A zap pte of page P for some reason (e.g. thp split)
>      2. System decides to recycle page P
>      3. System replace process B's pte (pointed to P) by PTE marker
>      4. System _didn't_ replace process A's pte because it was none pte, and
>         it'll continue to be none pte
>      5. Only process B's relevant pte has the PTE marker after P swapped out
> 
>    - When fork, we don't copy shmem vma ptes, including the pte markers.  So
>      even if page P was swapped out, only the parent process has the pte marker
>      installed, in child it'll be none pte if fork() happened after pageout.
> 
> Conclusion: just like it used to be, the PM_SWAP is best-effort.  But it should
> work in 99.99% cases and it should already start to solve problems.

At least I don't like these semantics at all. PM_SWAP is a cached value 
which might be under-represented and consequently wrong. Take CRIU as an 
example, it has to be correct even if a process would remap a memory 
region, fork() and unmap in the parent as far as I understand, ...

If we really care about performance for users with the old semantics, 
introduce some runtime toggle that enables the new behavior (even for a 
single process?) and consequently is a bit slower in corner cases. But I 
really do wonder if we care at all about the performance degradation in 
corner cases.

If we really care about performance for users with new semantics, then 
let's do it properly and see how we can actually speed it up without 
per-process page table hacks.

Anyhow, just my 2 cents.

-- 
Thanks,

David / dhildenb

