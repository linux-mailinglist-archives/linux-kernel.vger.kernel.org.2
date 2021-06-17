Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8513AB520
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhFQNtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231886AbhFQNtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623937633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wd1jgvwSy93wjHiyys1SAuQrEvjJBrCsIo1P11oaA30=;
        b=JSYTXQLqrjqLSz89Fj8PgVaVmJZzHAVTjnM0NSu7ymel1GiuuXZ37sSW9De9+s99vNWguO
        tMmq0FT63yj1VYZ2p47lJIvHSMEw0QICWokwC6HEWKFVrg5q3dhPYnqqcxRxMxB8MJ9tNB
        Tu2VALLAcMZv2qCkCwizJScNADy/xuo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-QZrCWGMYPu-9pwJoHbE4Ww-1; Thu, 17 Jun 2021 09:47:12 -0400
X-MC-Unique: QZrCWGMYPu-9pwJoHbE4Ww-1
Received: by mail-wm1-f71.google.com with SMTP id w186-20020a1cdfc30000b02901ced88b501dso2160728wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wd1jgvwSy93wjHiyys1SAuQrEvjJBrCsIo1P11oaA30=;
        b=Gw3x3ji40g67Qa2r+C3WE3Z8HAnl6WHzYhjBL9j8f2ycwJUjpA9i4uf886wEXZThjl
         mwOo+COoZSoS72+IymBYYHKFCt0eaJJBilG/mLuOo2SWVwG5yWat7ocG4fSjVswCGmlh
         Krxf8MjCUZ63db8W8CPfzPYVXnw99xmTV8RFMgyhjUNwGgAhA3UOXUXIwjgjUXLGVEmZ
         eIllf5s7DXejiE8Cp5y6xr0cSnhqmYgf4g2t+ZLWcIbaBG8AqZCh4jYJTJILlgaZI2W9
         hWqT82FWc6jgfHh0nGEn7Vhux2ztBkCsRrTtaEBgf/bzalAeiG8FahQk0g4H3tEFRo+n
         TKXw==
X-Gm-Message-State: AOAM531Fi/krk8S40ot7UioFXI8CkcN1wSNeOILy3Dpq+ZPZ866CY2uz
        z4v+5E+CJtJ3urL5ExSFf9bm+qOZlFZU7s79dgWqVWWBNlrUk0GHc3iQtyVNs+eBC7gqQOzpqkj
        AN50T0znZSkRZDMtEUHJ2ej6h
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr5263415wmi.174.1623937631057;
        Thu, 17 Jun 2021 06:47:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUyVfNf4oswCXiVl+tihhzfOLhyAxMHHePLdWtquIMEW6+6AMiTxB2pqsusdTOV3Wd3VJFxQ==
X-Received: by 2002:a05:600c:20d:: with SMTP id 13mr5263382wmi.174.1623937630796;
        Thu, 17 Jun 2021 06:47:10 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6170.dip0.t-ipconnect.de. [91.12.97.112])
        by smtp.gmail.com with ESMTPSA id c7sm5595252wrs.23.2021.06.17.06.47.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:47:10 -0700 (PDT)
To:     Michel Lespinasse <michel@lespinasse.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Andy Lutomirski <luto@kernel.org>
References: <20210430195232.30491-1-michel@lespinasse.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 00/29] Speculative page faults (anon vmas only)
Message-ID: <3047d699-2793-e051-e1eb-deef7c5764a8@redhat.com>
Date:   Thu, 17 Jun 2021 15:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210430195232.30491-1-michel@lespinasse.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.04.21 21:52, Michel Lespinasse wrote:
> This patchset is my take on speculative page faults (spf).
> It builds on ideas that have been previously proposed by Laurent Dufour,
> Peter Zijlstra and others before. While Laurent's previous proposal
> was rejected around the time of LSF/MM 2019, I am hoping we can revisit
> this now based on what I think is a simpler and more bisectable approach,
> much improved scaling numbers in the anonymous vma case, and the Android
> use case that has since emerged. I will expand on these points towards
> the end of this message.
> 
> The patch series applies on top of linux v5.12;
> a git tree is also available:
> git fetch https://github.com/lespinasse/linux.git v5.12-spf-anon
> 
> I believe these patches should be considered for merging.
> My github also has a v5.12-spf branch which extends this mechanism
> for handling file mapped vmas too; however I believe these are less
> mature and I am not submitting them for inclusion at this point.
> 
> 
> Compared to the previous (RFC) proposal, I have split out / left out
> the file VMA handling parts, fixed some config specific build issues,
> added a few more comments and modified the speculative fault handling
> to use rcu_read_lock() rather than local_irq_disable() in the
> MMU_GATHER_RCU_TABLE_FREE case.
> 
> 
> Classical page fault processing takes the mmap read lock in order to
> prevent races with mmap writers. In contrast, speculative fault
> processing does not take the mmap read lock, and instead verifies,
> when the results of the page fault are about to get committed and
> become visible to other threads, that no mmap writers have been
> running concurrently with the page fault. If the check fails,
> speculative updates do not get committed and the fault is retried
> in the usual, non-speculative way (with the mmap read lock held).
> 
> The concurrency check is implemented using a per-mm mmap sequence count.
> The counter is incremented at the beginning and end of each mmap write
> operation. If the counter is initially observed to have an even value,
> and has the same value later on, the observer can deduce that no mmap
> writers have been running concurrently with it between those two times.
> This is similar to a seqlock, except that readers never spin on the
> counter value (they would instead revert to taking the mmap read lock),
> and writers are allowed to sleep. One benefit of this approach is that
> it requires no writer side changes, just some hooks in the mmap write
> lock APIs that writers already use.
> 
> The first step of a speculative page fault is to look up the vma and
> read its contents (currently by making a copy of the vma, though in
> principle it would be sufficient to only read the vma attributes that
> are used in page faults). The mmap sequence count is used to verify
> that there were no mmap writers concurrent to the lookup and copy steps.
> Note that walking rbtrees while there may potentially be concurrent
> writers is not an entirely new idea in linux, as latched rbtrees
> are already doing this. This is safe as long as the lookup is
> followed by a sequence check to verify that concurrency did not
> actually occur (and abort the speculative fault if it did).
> 
> The next step is to walk down the existing page table tree to find the
> current pte entry. This is done with interrupts disabled to avoid
> races with munmap(). Again, not an entirely new idea, as this repeats
> a pattern already present in fast GUP. Similar precautions are also
> taken when taking the page table lock.

Hi Michel,

I just started working on a project to reclaim page tables inside 
running processes that are no longer needed (for example, empty after 
madvise(DISCARD)). Long story short, there are scenarios where we want 
to scan for such page tables asynchronously to free up memory (which can 
be quite significant in some use cases).

Now that I (mostly) understood the complex locking, I'm looking for 
other mm features that might be "problematic" in that regard and require 
properly planning to get right (or let them run mutually exclusive).

As I essentially rip out page tables from the page table hierarchy to 
free them (in the simplest case within a VMA to get started), I 
certainly need the mmap lock in read right now to scan the page table 
hierarchy, and the mmap lock in write when actually removing a page 
table. This is similar handling as khugepagd when collapsing a THP and 
removing a page table. Of course, we could use any kind of 
synchronization mechanism (-> rcu) to make sure nobody is using a page 
table anymore before actually freeing it.

1. I now wonder how your code actually protects against e.g., khugepaged 
and how it could protect against page table reclaim. Will we be using 
RCU while walking the page tables? That would make life easier.

2. You mention "interrupts disabled to avoid races with munmap()". Can 
you elaborate how that is supposed to work? Shouldn't we rather be using 
RCU than manually disabling interrupts? What is the rationale?


Thanks a lot in advance!

-- 
Thanks,

David / dhildenb

