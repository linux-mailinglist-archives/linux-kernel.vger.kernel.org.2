Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AEA41DD81
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbhI3PdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344086AbhI3PdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:33:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55665C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S0BblVsdckwghc4txw7r+dPMT0D1gW3oVbzrVCA8EGA=; b=KnFOj0lp75XlU4ooc12G0EXxE9
        gWRX4QNFmmTtdsLG1Y4GQeG7R3u/wggaZoaQ5CVmtm4dY8DjHuLVe8FDwDjPdFkWRw7oSp+84lUG3
        TnekohIjzeda3UF0SKrqSV8u22ROkZNhO4NNIWNjU88fWGCY3tZ8CoPdTqpWEK+fqsyjNeWBizz7R
        UyJH7191eFnQiynjWLm5QTzeR2loZ0y2Q85ob+iTIXoBE3IvQ9SxxbZ/aVtBJtBq1IOib1/1G+ane
        SJMCFvNjCbW2S97rXyGbMLf4kV/QUarT1mnNnPUDNwxG5in5YgShOI5cPytdohEBl3F3YNGXy9yoc
        bld4yTRA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVxzH-00D08C-Iu; Thu, 30 Sep 2021 15:29:15 +0000
Date:   Thu, 30 Sep 2021 16:28:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVXXq0ssvW6P525J@casper.infradead.org>
References: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
 <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
 <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 10:24:44PM -0700, Hugh Dickins wrote:
> On Wed, 29 Sep 2021, Song Liu wrote:
> > On Wed, Sep 29, 2021 at 6:54 PM Rongwei Wang
> > <rongwei.wang@linux.alibaba.com> wrote:
> > > On 9/30/21 7:41 AM, Song Liu wrote:
> > > > On Wed, Sep 29, 2021 at 10:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >>
> > > > [...]
> > > >>> Now, I am able to crash the system on
> > > >>>      find_lock_entries () {
> > > >>>       ...
> > > >>>         VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
> > > >>>      }
> > > >>> I guess it is related. I will test more.
> > > >>
> > > >> That's a bogus VM_BUG_ON.  I have a patch in my tree to delete it.
> > > >> Andrew has it too, but for some reason, he hasn't sent it on to Linus.
> 
> I think Andrew has held back from sending it on to Linus because I pointed
> out that the example Matthew cited (shmem and swap cache) was wrong, and
> could not explain it: we wanted to understand what syzbot had actually
> hit before sending on.
> 
> Would this bug be a good explanation for it?

I don't think so?  Even if that specific example is not what's happening,
the general principle is that you can't verify page->index until you're
holding the page lock.  So the VM_BUG_ON is definitely in the wrong place.

> In the meantime, independently, I was looking at fuse_try_move_page(),
> which appears to do the old splice thievery that got disabled from splice
> itself, stealing a page from one mapping to put into another.  I suspect
> that could result in a page->index != xas.xa_index too (outside page lock).

I think there are other examples too where page->index gets changed ...
they're not springing to mind right now, but I have some other intricate
details occupying that bit of my brain at the moment.

> > > I think the second possibility mentioned above will been found if you
> > > enable CONFIG_DEBUG_VM:
> > >
> > > 1) multiple writers truncate the same page cache concurrently;
> > > 2) collapse_file rolls back when writer truncates the page cache;
> > >
> > > The following log will be print after enable CONFIG_DEBUG_VM:
> > >
> > > [22216.789904]  do_idle+0xb4/0x104
> > > [22216.789906]  cpu_startup_entry+0x34/0x9c
> > > [22216.790144] Hardware name: Alibaba Cloud Alibaba Cloud ECS, BIOS
> > > 0.0.0 02/06/2015
> > > [22216.790553]  secondary_start_kernel+0x104/0x180
> > > [22216.790778] Call trace:
> > > [22216.791300] Code: d4210000 b0006161 910d4021 94013b45 (d4210000)
> > > [22216.791662]  dump_backtrace+0x0/0x1ec
> > > [22216.791664]  show_stack+0x24/0x30
> > > [22216.791956] ---[ end trace dc769a61c1af087b ]---
> > > [22216.792295]  dump_stack+0xd0/0x128
> > > [22216.792299]  bad_page+0xe4/0x110
> > > [22216.792579] Kernel panic - not syncing: Oops - BUG: Fatal exception
> > > in interrupt
> > > [22216.792937]  check_free_page_bad+0x84/0x90
> > > [22216.792940]  free_pcp_prepare+0x1fc/0x21c
> > > [22216.793253] SMP: stopping secondary CPUs
> > > [22216.793525]  free_unref_page+0x2c/0xec
> > > [22216.805537]  __put_page+0x60/0x70
> > > [22216.805931]  collapse_file+0xdc8/0x12f0
> > > [22216.806385]  khugepaged_scan_file+0x2dc/0x37c
> > > [22216.806900]  khugepaged_scan_mm_slot+0x2e0/0x380
> > > [22216.807450]  khugepaged_do_scan+0x2dc/0x2fc
> > > [22216.807946]  khugepaged+0x38/0x100
> > > [22216.808342]  kthread+0x11c/0x120
> > > [22216.808735] Kernel Offset: disabled
> > > [22216.809153] CPU features: 0x0040002,62208238
> > > [22216.809681] Memory Limit: none
> > > [22216.813477] Starting crashdump kernel...
> > >
> > > So I think the race also exists between collapse_file and
> > > truncate_pagecache.
> > 
> > I do have CONFIG_DEBUG_VM, but I haven't hit this issue yet.
> 
> Sorry, it's taken me a long time to get into this bug(s).
> 
> I haven't tried to reproduce it, but I do think that Rongwei will
> be proved right.
> 
> In doing a lockless lookup of the page cache, we tend to imagine
> that the THP head page will be encountered first, and the special
> treatment for the head will do the right thing to skip the tails.
> 
> But when racing against collapse_file()'s rewind, I agree with
> Rongwei that it is possible for truncation (or page cache cleanup
> in this instance) to collect a pagevec which starts with a PageTail
> some way into the compound page.
> 
> shmem_undo_range() (which shmem uses rather than truncate_pagecache())
> would not call truncate_inode_page() on a THP tail: if it encounters a
> tail, it will try to split the THP, and not call truncate_inode_page()
> if it cannot.  Unless I'm inventing the memory, I now think that I did
> encounter this race between truncate and collapse on huge shmem, and
> had to re-craft my shmem_punch_compound() to handle it correctly.
> 
> If it is just a matter of collapse_file() rewind, I suppose we could
> reverse the direction in which that proceeds; but I'm not convinced
> that would be enough, and don't think we need such a "big" change.
> 
> Aside from the above page->index mischeck in find_lock_entries(),
> I now think this bug needs nothing more than simply removing the
> VM_BUG_ON_PAGE(PageTail(page), page) from truncate_inode_page().

I don't think that's right.  This bug was also observed when calling
truncate(), so there's clearly a situation where two concurrent calls
to truncate_pagecache() leaves a THP in the cache.

Unless there's a case where mapping->nr_thps gets corrupted, so the
open() thinks there's no THPs in the page cache, when there's actually
one or more?  That might be a problem that we're solving by locking
around the truncate_pagecache() call?

> (You could say move its page->mapping check before its PageTail
> check; but the PageTail check would then never catch anything.)
> 
> Rongwei's patch went in the right direction, but why add N lines
> if deleting one is good?  And for a while I thought that idea of
> using filemap_invalidate_lock() was very good; but now think
> the page lock we already have is better, and solve both races.
> 
> Hugh
