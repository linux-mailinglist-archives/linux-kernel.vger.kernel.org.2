Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E44B41D2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348080AbhI3F0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347973AbhI3F0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:26:41 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAD8C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:24:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id e16so4562184qte.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8kt8QKH2fdL9UWT5D63SxiPEKf5eylzKJX/9hWp15xY=;
        b=Z4BS+g4qY6uWPmXhWeMzLSgZYqPCBF0YZzGvA0SaPuuQwvEJ/WjlKt7BlSi1BI3kfX
         u0pJk3ZSH0hqFfofkD9WLOohm8I+yvAk9maw0Sd+/22u1KFYa+G2bG94I8R13fWCTwVk
         1mshe3rKG/cL1TktzGK9A4OOfcwzU/uVCL7KCrFsc621lPjau//cDeAE4xjmSBxYTg22
         w7aVhLawmQDlhWmIkx/psDDxgfy8kMpIexn+VqWmsS8F3qcvP5IgB6FEX3JoC8IHQ6ca
         XbXhCSnkdreEzJFeaC4RKKOgwWY/2yd4+Rsc6XnuUGpLJJqrzhgwFtoMgXI+OCs2W4yH
         VjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8kt8QKH2fdL9UWT5D63SxiPEKf5eylzKJX/9hWp15xY=;
        b=eF1v6URmlif5uMEmFf4Dxwi0ikssMVXTiE85rOOWY0FWEDzioF6/P1tebF3H/ICWjA
         8pe0mJuceBU+5nd2f++0YNYB8us8Av+M+ySBUoUhu7aYRQHvGfFg23NFRpEVZgCBKa5J
         rQgBtqYjo+T718AENJaGEIZ5kB4tf8YcYBCFxpalWHd/xKh7KNMrecVl2kllMvTEGjwh
         F9s363YViv2FXU9HC082QySUp9CMsk2/p03xAeOCq05y+0VZp44cre5INSV6bywOMuiW
         e9zr5G+r4Pyk8eYaBJZHFYT+MrXl0sWaNtrBoN2NLnbjb4/8MJkvx/eM40y5hDA2IOlf
         e+fg==
X-Gm-Message-State: AOAM532CCqbx/BcPcfbwby5jkvrfpXH+gPHUFO/eSsHaYvSdeybX9vwq
        nKzkVEcdNVUGU/0ZSideRLDo1A==
X-Google-Smtp-Source: ABdhPJycxWBtFT4SvTFWZh7qcgEbvNUEZdUAK5A7SRzqBCwpTKtt/kFiLF70bEmQOqIJTFROuI2ikA==
X-Received: by 2002:ac8:4312:: with SMTP id z18mr4241769qtm.208.1632979498167;
        Wed, 29 Sep 2021 22:24:58 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z19sm1064608qts.96.2021.09.29.22.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 22:24:57 -0700 (PDT)
Date:   Wed, 29 Sep 2021 22:24:44 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Song Liu <song@kernel.org>
cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
In-Reply-To: <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
Message-ID: <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com>
References: <20210922070645.47345-2-rongwei.wang@linux.alibaba.com> <YUsVcEDcQ2vEzjGg@casper.infradead.org> <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com> <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org> <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com> <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com> <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com> <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com> <YVSopxYWegtQJ3iD@casper.infradead.org> <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com> <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
 <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021, Song Liu wrote:
> On Wed, Sep 29, 2021 at 6:54 PM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
> > On 9/30/21 7:41 AM, Song Liu wrote:
> > > On Wed, Sep 29, 2021 at 10:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >>
> > > [...]
> > >>> Now, I am able to crash the system on
> > >>>      find_lock_entries () {
> > >>>       ...
> > >>>         VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> > >>>      }
> > >>> I guess it is related. I will test more.
> > >>
> > >> That's a bogus VM_BUG_ON.  I have a patch in my tree to delete it.
> > >> Andrew has it too, but for some reason, he hasn't sent it on to Linus.

I think Andrew has held back from sending it on to Linus because I pointed
out that the example Matthew cited (shmem and swap cache) was wrong, and
could not explain it: we wanted to understand what syzbot had actually
hit before sending on.

Would this bug be a good explanation for it?

In the meantime, independently, I was looking at fuse_try_move_page(),
which appears to do the old splice thievery that got disabled from splice
itself, stealing a page from one mapping to put into another.  I suspect
that could result in a page->index != xas.xa_index too (outside page lock).

> > >>
> > >> +++ b/mm/filemap.c
> > >> @@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
> > >>                  if (!xa_is_value(page)) {
> > >>                          if (page->index < start)
> > >>                                  goto put;
> > >> -                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> > >>                          if (page->index + thp_nr_pages(page) - 1 > end)
> > >>                                  goto put;
> > >>                          if (!trylock_page(page))
> > >
> > > Yes, after removing this line, I am able to see the same bug.
> > >
> > > Here is my finding so far:
> > >
> > > The issue is NOT caused by concurrent khugepaged:collapse_file() and
> > > truncate_pagecache(inode, 0). With some printks, we can see a clear
> > > time gap (>2 second )  between collapse_file() finishes, and
> > > truncate_pagecache() (which crashes soon). Therefore, my earlier
> > > suggestion that adds deny_write_access() to collapse_file() does NOT
> > > work.
> > >
> > > The crash is actually caused by concurrent truncate_pagecache(inode, 0).
> > > If I change the number of write thread in stress_madvise_dso.c to one,
> > > (IOW, one thread_read and one thread_write), I cannot reproduce the
> > > crash anymore.
> > Whether CONFIG_DEBUG_VM is enabled in your vm?
> >
> > I think the second possibility mentioned above will been found if you
> > enable CONFIG_DEBUG_VM:
> >
> > 1) multiple writers truncate the same page cache concurrently;
> > 2) collapse_file rolls back when writer truncates the page cache;
> >
> > The following log will be print after enable CONFIG_DEBUG_VM:
> >
> > [22216.789904]  do_idle+0xb4/0x104
> > [22216.789906]  cpu_startup_entry+0x34/0x9c
> > [22216.790144] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS
> > 0.0.0 02/06/2015
> > [22216.790553]  secondary_start_kernel+0x104/0x180
> > [22216.790778] Call trace:
> > [22216.791300] Code: d4210000 b0006161 910d4021 94013b45 (d4210000)
> > [22216.791662]  dump_backtrace+0x0/0x1ec
> > [22216.791664]  show_stack+0x24/0x30
> > [22216.791956] ---[ end trace dc769a61c1af087b ]---
> > [22216.792295]  dump_stack+0xd0/0x128
> > [22216.792299]  bad_page+0xe4/0x110
> > [22216.792579] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > in interrupt
> > [22216.792937]  check_free_page_bad+0x84/0x90
> > [22216.792940]  free_pcp_prepare+0x1fc/0x21c
> > [22216.793253] SMP: stopping secondary CPUs
> > [22216.793525]  free_unref_page+0x2c/0xec
> > [22216.805537]  __put_page+0x60/0x70
> > [22216.805931]  collapse_file+0xdc8/0x12f0
> > [22216.806385]  khugepaged_scan_file+0x2dc/0x37c
> > [22216.806900]  khugepaged_scan_mm_slot+0x2e0/0x380
> > [22216.807450]  khugepaged_do_scan+0x2dc/0x2fc
> > [22216.807946]  khugepaged+0x38/0x100
> > [22216.808342]  kthread+0x11c/0x120
> > [22216.808735] Kernel Offset: disabled
> > [22216.809153] CPU features: 0x0040002,62208238
> > [22216.809681] Memory Limit: none
> > [22216.813477] Starting crashdump kernel...
> >
> > So I think the race also exists between collapse_file and
> > truncate_pagecache.
> 
> I do have CONFIG_DEBUG_VM, but I haven't hit this issue yet.

Sorry, it's taken me a long time to get into this bug(s).

I haven't tried to reproduce it, but I do think that Rongwei will
be proved right.

In doing a lockless lookup of the page cache, we tend to imagine
that the THP head page will be encountered first, and the special
treatment for the head will do the right thing to skip the tails.

But when racing against collapse_file()'s rewind, I agree with
Rongwei that it is possible for truncation (or page cache cleanup
in this instance) to collect a pagevec which starts with a PageTail
some way into the compound page.

shmem_undo_range() (which shmem uses rather than truncate_pagecache())
would not call truncate_inode_page() on a THP tail: if it encounters a
tail, it will try to split the THP, and not call truncate_inode_page()
if it cannot.  Unless I'm inventing the memory, I now think that I did
encounter this race between truncate and collapse on huge shmem, and
had to re-craft my shmem_punch_compound() to handle it correctly.

If it is just a matter of collapse_file() rewind, I suppose we could
reverse the direction in which that proceeds; but I'm not convinced
that would be enough, and don't think we need such a "big" change.

Aside from the above page->index mischeck in find_lock_entries(),
I now think this bug needs nothing more than simply removing the
VM_BUG_ON_PAGE(PageTail(page), page) from truncate_inode_page().

(You could say move its page->mapping check before its PageTail
check; but the PageTail check would then never catch anything.)

Rongwei's patch went in the right direction, but why add N lines
if deleting one is good?  And for a while I thought that idea of
using filemap_invalidate_lock() was very good; but now think
the page lock we already have is better, and solve both races.

Hugh
