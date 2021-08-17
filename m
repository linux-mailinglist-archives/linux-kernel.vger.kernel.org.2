Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A09A3EF3FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhHQUZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42856 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237212AbhHQUYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629231855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QOMKNDJNdfhb8sOCj0R2Nfirh2qK76ofz1GMvuJS7sg=;
        b=awEHJX5PrHJebXRYgjcTayEnsa1yz16yoBFlG/rp8YxOAXm8mxnJZDTqeWLxHlJe2KO3pV
        OIfuWJieQ1qYk5B647lDXSS/P32X+kySsvZgaMfqOYMaZiy0M0CKueb6fZqTaPqwduoWFm
        Fjwk/tU4tSKmHtQXQ5XuU/sCG7TiwBU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-546-2wdw16v1PgGeaqAiuVUCTg-1; Tue, 17 Aug 2021 16:24:14 -0400
X-MC-Unique: 2wdw16v1PgGeaqAiuVUCTg-1
Received: by mail-qv1-f69.google.com with SMTP id iw1-20020a0562140f2100b0035f58985cecso424278qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 13:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QOMKNDJNdfhb8sOCj0R2Nfirh2qK76ofz1GMvuJS7sg=;
        b=ID9k05fodTWlkOxWOnmjKhHUDIOZfzDsgn17GLBqOvNhL/2oEy7Z3QDBw7GmoJRqDl
         3HHaX9Z8/FmTtzRFD59GCvyPqLOC3u0PzEzyossiXqI2wrhKl4oFuGE62MhwnK9Vk17l
         h/GDkdDED4DjtX2g+AZGssonsHF5ggrrUjiMCdglk/5qCvw8oUUZ/Z+UdTm1f2QJq83L
         BNgxH41we+WQpvCglWnKFmnHDQ/i7US8mnew/TOBwRRSyxArBCLbgtbZqn0it4dqNj1Y
         qWyqUwD1tX44GAF+hqWaN6ODXmWgg55XTgMWlInus+lGs7o2YKLxhQfShtxpOGnrZ7SK
         PgLw==
X-Gm-Message-State: AOAM533LgKVWY/1ZawW79R0dcgUdvtxHERaucUJzDrJfFpwAPcX6FC2c
        3ahcJmoDSyUqgPqE5+QIq9Qx1P4m9oggQL/yNXNWecm5AS47SjGMRNGVCIbfxTITtkrgIQbQQsf
        Gyv+v1Fbb/uNyqBweu3a+0OWx
X-Received: by 2002:a05:6214:301d:: with SMTP id ke29mr5207723qvb.45.1629231854337;
        Tue, 17 Aug 2021 13:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXvyf/6/dfFegAkX3W2Ty9u08DfDF5DEr+ehsrmgmaz5RK9iEID+tFYDGRq6AwlqpNJJomYA==
X-Received: by 2002:a05:6214:301d:: with SMTP id ke29mr5207705qvb.45.1629231854064;
        Tue, 17 Aug 2021 13:24:14 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::d413])
        by smtp.gmail.com with ESMTPSA id p123sm2184065qke.94.2021.08.17.13.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:24:13 -0700 (PDT)
Date:   Tue, 17 Aug 2021 16:24:11 -0400
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
Message-ID: <YRwa6+jx5PukCn53@t490s>
References: <20210807032521.7591-1-peterx@redhat.com>
 <16a765e7-c2a3-982a-e585-c04067766e3f@redhat.com>
 <YRvtPrPmAorX+KY5@t490s>
 <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c4adbba1-2299-f87c-1893-e83af9beadbc@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 08:46:45PM +0200, David Hildenbrand wrote:
> > Please have a look at current pagemap impl in pte_to_pagemap_entry().  It's not
> > accurate from the 1st day, imho.  E.g., when a page is being migrated from numa
> > node 1 to node 2, we'll mark it PM_SWAP but I think it's not the case.  We can
> > make it more accurate, but I think it's fine, because it's a hint.
> 
> That inconsistency doesn't really matter as you can determine if something
> is present and worth dumping if it's either swapped or present. As long as
> it's one of both but not simply nothing.
> 
> I will shamelessly reference
> tools/testing/selftests/vm/madv_populate.c:pagemap_is_populated() that
> checks exactly for that (the test case uses only private anonymous memory).

Then I think the MADV_POPULATE_READ|WRITE test cases shouldn't depend on
PM_SWAP for that when it goes beyond anonymous private memories - when shmem
swapped out the pte can be none, then the test case can fail even if it
shouldn't, imho.

The mincore() syscall seems to be ideally the thing you may want to make it
accurate, but again it's not a problem for current anonymous private memories.

> 
> > 
> > > Take CRIU as an example, it has to be correct even if a process would remap a
> > > memory region, fork() and unmap in the parent as far as I understand, ...
> > 
> > Are you talking about dirty bit or swap bit?  I'm a bit confused on why swap
> > bit needs to be accurate.  Maybe you mean the dirty bit?
> 
> https://criu.org/Shared_memory
> 
> "Dumping present pages"
> 
> "... CRIU does not dump all of the data. Instead, it determines which pages
> contain it, and only dumps those pages. This is done similarly to how
> regular memory dumping and restoring works, i.e. by looking for PRESENT or
> SWAPPED bits in owners' pagemap entries."
> 
> -> Neither PRESENT nor SWAPPED results in memory not getting dumped, which
> makes perfect sense.
> 
> 1) Process A sets up shared memory and writes data to it.
> 2) System swaps out memory, hints are setup.
> 3) Process A forks Process B, hints are not copied.
> 4) Process A unmaps shared memory, hints are dropped.
> 5) CRIU migrates process A and B and migrates only PRESENT or SWAPPED in
> pagemap.
> 6) Process B uses memory in shared memory region. Pages were not migrated.
> 
> Just one example; feel free to correct me.

I think pte marker won't crash criu, what will happen is that it'll see more
ptes that used to be none that become the pte markers.  This reminded me that
maybe I should teach up mincore() syscall to also be aware of the pte marker at
least, and all non_swap_entry() callers.

> 
> 
> There is notion of the mincore() systemcall:
> 
> "There is one particular feature of shared memory dumps worth mentioning.
> Sometimes, a shared memory page can exist in the kernel, but it is not
> mapped to any process. CRIU detects such pages by calling mincore() on the
> shmem segment, which reports back the page in-memory status. The mincore
> bitmap is when ANDed with the per-process ones. "
> 
> Not sure if they actually mean ORed, because otherwise they'd be losing
> pages that have been swapped out. "mincore() returns a vector that indicates
> whether pages of the calling process's virtual memory are resident in core
> (RAM)"

I am wildly guessing they ORed the two just because PM_SWAP is not working
properly for shmem, so the OR happens only for shmem.  Criu may not only rely
on mincore() because they also want the dirty bits.

Btw, I noticed in 2016 criu switched from mincore() to lseek():

https://github.com/checkpoint-restore/criu/commit/1821acedd04b602b37b587eac5a481094b6274ae

Criu should want to know "whether this page has valid data" not "whether this
page has swapped out", so lseek() seems to be more suitable, which I'm not
aware of before.

I'm now wondering whether for Tiberiu's case mincore() can also be used.  It
should just still be a bit slow because it'll look up the cache too, but it
should work similarly like the original proposal.

Thanks,

-- 
Peter Xu

