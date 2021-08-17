Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7ED3EF09E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhHQRJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:09:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229723AbhHQRJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629220162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sF+zTR4dttR1A/gzOM7GKm+4Dyo/HXXoPVfQl73y4Fg=;
        b=X7CV8SnBMmbEQVs4jo37sc6vDnbn/em8hH5hS/FTeDclPVF14Oo6PyY5gNyyfli0fAXpae
        4MDkWOcF0qkSGXA+b3W6K29UbTxzulgJcJugoIhis8HIDdsSQS9x6emwVrYR0wQMUAYcam
        CHuyYvhyY1f/t5+YzJ9EtKHQo1O/juA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-cbFeNbcAOi2tSjMPz13J6g-1; Tue, 17 Aug 2021 13:09:21 -0400
X-MC-Unique: cbFeNbcAOi2tSjMPz13J6g-1
Received: by mail-qt1-f198.google.com with SMTP id j1-20020ac866410000b029028bef7ed9e1so11422786qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 10:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sF+zTR4dttR1A/gzOM7GKm+4Dyo/HXXoPVfQl73y4Fg=;
        b=mXgyxWTXibx3VZMztU/BC3jChEN6rblL7kjipM161B3jz1Y5lC1yNrtcq6vRLYrXT7
         RdnQMT7ftQd4Fs5lmZa/LQNTVHBs1mB4nwl3bgycIZvQ9kQUJPuo02H+6SmCuLjACPx1
         QuABE/9OTyzuHOFPnVbaOLQB2CqilP7X8lCwf8r3DLDW8azg/ahxB6NbsYMozQESqTt2
         9XwzXBio8cQksuif/B9XQKZBD5VrSJ+kRlFxb1SGUvW7OWOZj4+z94ncbYTp5R52BN4Q
         Eoi7Ldfo29yI7/gHL14rCfFiv20tRXjL/memZONxph07Bv2WAI/Hh/l4lD2GD2E00aQH
         RGhA==
X-Gm-Message-State: AOAM532ZWI1DEOsSXdzY4OsSvLWq+i7okSDUX+R6AiYqM/d4p7CMWZ/N
        wN61emdCamM9DM9O9gccsuMQuQhOt1GEr+l0xlix1ibhADdzN9lnJUquEo4AEwBKNabebxeEgMD
        27AAWMgBeLK6WOK2CpS3aqYBM
X-Received: by 2002:ac8:5848:: with SMTP id h8mr4169357qth.254.1629220160687;
        Tue, 17 Aug 2021 10:09:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzESuW04EZR0qNwFiU4nZSawkPFByBtJsOw+SlXD9tWyXS3uBbN5rkeUoPCjw0K1QKvvjm/NA==
X-Received: by 2002:ac8:5848:: with SMTP id h8mr4169307qth.254.1629220160251;
        Tue, 17 Aug 2021 10:09:20 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::d413])
        by smtp.gmail.com with ESMTPSA id x25sm1443421qtj.77.2021.08.17.10.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 10:09:19 -0700 (PDT)
Date:   Tue, 17 Aug 2021 13:09:18 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
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
Subject: Re: [PATCH RFC 0/4] mm: Enable PM_SWAP for shmem with PTE_MARKER
Message-ID: <YRvtPrPmAorX+KY5@t490s>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:04:18AM +0200, David Hildenbrand wrote:
> Hi Peter, a couple of comments, sorry for the late reply.
> 
> > Summary
> > =======
> > 
> > [Based on v5.14-rc4]
> > 
> > This patchset enables PM_SWAP of pagemap on shmem.  IOW userspace will be able
> > to detect whether a shmem page is swapped out, just like anonymous pages.
> > 
> > This feature can be enabled with CONFIG_PTE_MARKER_PAGEOUT. When enabled, it
> > brings 0.8% overhead on swap-in performance on a shmem page, so I didn't make
> > it the default yet.  However IMHO 0.8% is still in an acceptable range that we
> > can even make it the default at last.  Comments are welcomed here.
> 
> Special config option and added complexity for handling a corner case
> feature partially more correct. Hm.
> 
> > 
> > There's one previous series that wanted to address the same issue but in
> > another way by Tiberiu A Georgescu <tiberiu.georgescu@nutanix.com>, here:
> > 
> > https://lore.kernel.org/lkml/20210730160826.63785-1-tiberiu.georgescu@nutanix.com/
> > 
> > In that series it's done by looking up page cache for all none ptes.  However I
> > raised concern on 4x performance degradation for all shmem pagemap users.
> 
> Who cares? I am asking because for me, it's hard to imagine a workload that
> actually cares about a 4x performance degradation when querying the pagemap
> in very special cases,

I won't say it's a "special case".  it affects any pagemap reading if there's
shmem, even if they're not looking for PM_SWAP it'll suffer from trying to look
up page cache if the pte is none.

Yes it needs to be a relatively large memory to show an effect, but IMHO it's
not a reason good enough that we can make it 4x slower.

> especially if it involves gigantic shmem ranges. VM
> live migration -- sync will be a bit slower? CRIU sync will be a bit slower?
> I mean, actual page dumping is a lot more expensive. Really a problem?
> 
> I read that CRIU cares about shmem via pagemap [1], at least for anonymous
> shared memory; not sure how memfd is treated, I assume in a similar way. But
> I do wonder how it even works reliably, because it relies on present/swapped
> out and sofrtdirty tracking, which are both essentially broken e.g., when
> swapping out AFAIKT. Looks like this really needs a proper fix.
> 
> [1] https://criu.org/Shared_memory

I have not enough knowledge to judge CRIU here, but I can kind of understand
Tiberiu's problem and hopefully I digested it right.  What I'm targetting with
this series is just to see whether it can fix the problem there, assuming that
could be a good summary of what it can also be used elsewhere.

We have the other solution of the page cache lookup, but I think that's slower
than this solution, so when there's the 0.8% overhead possibility I think this
one is much better.  The bad side is it's going to be added into swap-in path,
it's not ideal for fast swap devices, but I have no knowledge on that part too,
as to my understanding most swap devices should be still slow like hard disks
which can take worst case milli-seconds to read in a sector.  I think that
overhead should be mostly not measureable and lost in the white noise.

> 
> > 
> > Unlike the other approach, this series has zero overhead on pagemap read
> > because the PM_SWAP info is consolidated into the zapped PTEs directly.
> > 
> > Goals
> > =====
> > 
> > One major goal of this series is to add the PM_SWAP support, the reason is as
> > stated by Tiberiu and Ivan in the other patchset:
> > 
> > https://lore.kernel.org/lkml/CY4PR0201MB3460E372956C0E1B8D33F904E9E39@CY4PR0201MB3460.namprd02.prod.outlook.com/
> > 
> > As a summary: for some reason the userspace needs to scan the pages in the
> > background, however that scanning could misguide page reclaim on which page is
> > hot and which is cold.  With correct PM_SWAP information, the userspace can
> > correct the behavior of page reclaim by firstly fetching that info from
> > pagemap, and explicit madvise(MADV_PAGEOUT).  In this case, the pages are for
> > the guest, but it can be any shmem page.
> > 
> > Another major goal of this series is to do a proof-of-concept of the PTE marker
> > idea, and that's also the major reason why it's RFC.  So far PTE marker can
> > potentially be the solution for below three problems that I'm aware of:
> > 
> >    (a) PM_SWAP on shmem
> > 
> >    (b) Userfaultfd-wp on shmem/hugetlbfs
> > 
> >    (c) PM_SOFT_DIRTY lost for shmem over swapping
> > 
> > This series tries to resolve problem (a) which should be the simplest, ideally
> > it should solve immediate problem for the live migration issue raised by
> > Tiberiu and Ivan on proactive paging out unused guest pages.
> > 
> > Both (a) and (c) will be for performance-wise or statistic-wise.
> > 
> > Scenario (b) will require pte markers as part of the function to trap writes to
> > uffd-wp protected regions when the pages were e.g. swapped out or zapped for
> > any reason.
> > 
> > Currently, uffd-wp shmem work (still during review on the list, latest v5, [1])
> > used another solution called "special swap pte".  It works similarly like PTE
> > markers as both of the approachs are to persist information into zapped pte,
> > but people showed concern about that idea and it's suggested to use a safer
> > (swp-entry level operation, not pte level), and arch-independent approach.
> > 
> > Hopefully PTE markers satifsfy these demands.
> > 
> > Before I rework the uffd-wp series, I wanted to know whether this approach can
> > be accepted upstream.  So besides the swap part, comments on PTE markers will
> > be extremely welcomed.
> 
> For uffd-wp in its current form, it would certainly be the way to go I
> think. AFAIKT, the idea of special swap entries isn't new, just that it's
> limited to anonymous memory for now, which makes things like fork and new
> mappings a lot cheaper.

Thanks for reviewing this series separately; yes I definitely wanted to get
comments on both sides: one on the pte marker idea, the other is whether it's
applicable to this swap+shmem use case.

I don't plan to handle both fork and new mappings for swapping.

For fork(), as we've discussed, and as I've also mentioned below in Known
Issues, that we don't copy these markers in fork().  So children may lose these
hints from pte, but I think that's fine if that's hardly used.

Here I really want to make the pte marker be flexible - it can be strict when
necessary (it will be 100% strict with uffd-wp), then it can also be a hint
just like what we have with available ptes on soft-dirty, idle, accessed bits.
Here the swap bit I wanted to make it that kind, so we add zero overhead to
fork() and we still solve problems.

Same thing to "newly mapped shmem".  Do we have a use case for that?  If that's
a hint bit, can we ignore it?

> 
> > 
> > What is PTE Markers?
> > ====================
> > 
> > PTE markers are defined as some special PTEs that works like a "marker" just
> > like in normal life.  Firstly it uses a swap type, IOW it's not a valid/present
> > pte, so processor will trigger a page fault when it's accessed.  Meanwhile, the
> > format of the PTE is well-defined, so as to contain some information that we
> > would like to know before/during the page access happening.
> > 
> > In this specific case, when the shmem page is paged out, we set a marker
> > showing that this page was paged out, then when pagemap is read about this pte,
> > we know this is a swapped-out/very-cold page.
> > 
> > This use case is not an obvious one but the most simplest.  The uffd-wp use
> > case is more obvious (wr-protect is per-pte, so we can't save into page cache;
> > meanwhile we need that info to persist across zappings e.g. thp split or page
> > out of shmem pages).
> > 
> > So in the future, it can contain more information, e.g., whether this pte is
> > wr-protected by userfaultfd; whether this pte was written in this mm context
> > for soft-dirtying.  On 64 bit systems, we have a total of 58 bits (swp_offset).
> > 
> > I'm also curious whether it can be further expanded to other mm areas.  E.g.,
> > logically it can work too for non-RAM based memories outside shmem/hugetlbfs,
> > e.g. a common file system like ext4 or btrfs?  As long as there will be a need
> > to store some per-pte information across zapping of the ptes, then maybe it can
> > be considered.
> 
> As already expressed, we should try storing as little information in page
> tables as possible if we're dealing with shared memory. The features we
> design around this all seem to over-complicate the actual users,
> over-complicate fork, over-complicate handling on new mappings.

I'll skip the last two "over-complicated" items, because as we've discussed I
don't think we need to take care of them so far.  We can revisit when they
become some kind of requirement.

To me having PM_SWAP 99% right on shmem is still a progress comparing to
completely missing it, even if it's not 100% right.  It's used for performance
reasons on PAGEOUT and doing finer-grained memory control from userspace, it's
not a strict requirement.

So I still cannot strictly follow why storing information in pte is so bad for
file-backed, which I can see you really don't like it.  Could you share some
detailed example?

> 
> For uffd-wp in its current form, there seems to be no way around it, and PTE
> markers seem to be what you want -- but as I already raised, the feature
> itself on shmem is somewhat suboptimal, just like SOFTDIRTY tracking on
> shmem.

Emm I don't know whether we should call it sub-optimal. To me it's still a
clean and self-contained way to do things.  I don't know how to do that from
page cache layer, but I bet there'll be issues coming when we go that way, then
we may figure out "oh this way is 90% beautiful, but that way is 85%".  To me
it's sometimes not easy to figure out the ideal solution for all the problems.

> 
> But I guess I'm biased at this point because the main users of these
> features actually want to query/set such properties for all sharers, not
> individual processes; so the opinion of others would be appreciated.
> 
> > 
> > Known Issues/Concerns
> > =====================
> > 
> > About THP
> > ---------
> > 
> > Currently we don't need to worry about THP because paged out shmem pages will
> > be split when shrinking, IOW we only need to consider PTE, and the markers will
> > only be applied to a shmem pte not pmd or bigger.
> > 
> > About PM_SWAP Accuracy
> > ----------------------
> > 
> > This is not an "accurate" solution to provide PM_SWAP bit.  Two exmaples:
> > 
> >    - When process A & B both map shmem page P somewhere, it can happen that only
> >      one of these ptes got marked with the pte marker.  Imagine below sequence:
> > 
> >      0. Process A & B both map shmem page P somewhere
> >      1. Process A zap pte of page P for some reason (e.g. thp split)
> >      2. System decides to recycle page P
> >      3. System replace process B's pte (pointed to P) by PTE marker
> >      4. System _didn't_ replace process A's pte because it was none pte, and
> >         it'll continue to be none pte
> >      5. Only process B's relevant pte has the PTE marker after P swapped out
> > 
> >    - When fork, we don't copy shmem vma ptes, including the pte markers.  So
> >      even if page P was swapped out, only the parent process has the pte marker
> >      installed, in child it'll be none pte if fork() happened after pageout.
> > 
> > Conclusion: just like it used to be, the PM_SWAP is best-effort.  But it should
> > work in 99.99% cases and it should already start to solve problems.
> 
> At least I don't like these semantics at all. PM_SWAP is a cached value
> which might be under-represented and consequently wrong.

Please have a look at current pagemap impl in pte_to_pagemap_entry().  It's not
accurate from the 1st day, imho.  E.g., when a page is being migrated from numa
node 1 to node 2, we'll mark it PM_SWAP but I think it's not the case.  We can
make it more accurate, but I think it's fine, because it's a hint.

> Take CRIU as an example, it has to be correct even if a process would remap a
> memory region, fork() and unmap in the parent as far as I understand, ...

Are you talking about dirty bit or swap bit?  I'm a bit confused on why swap
bit needs to be accurate.  Maybe you mean the dirty bit?

> 
> If we really care about performance for users with the old semantics,
> introduce some runtime toggle that enables the new behavior (even for a
> single process?) and consequently is a bit slower in corner cases. But I
> really do wonder if we care at all about the performance degradation in
> corner cases.

Yes that's okay.  If we want to go with Tiberiu's approach, we can use an
option to avoid regress users.  However I still prefer the current approach,
and I even want to make it a default option if it can prove itself with some
more real swap workloads somewhere (maybe kernel bot has some?  I didn't check
yet).

> 
> If we really care about performance for users with new semantics, then let's
> do it properly and see how we can actually speed it up without per-process
> page table hacks.
> 
> Anyhow, just my 2 cents.

Thanks for the discussion!

-- 
Peter Xu

