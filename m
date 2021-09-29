Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A1041CB64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbhI2R7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbhI2R7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:59:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3CAC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=PBrItrWYc4exfbDaKqyby4f2f1oZNsNLet5vMQY77Po=; b=SsDrPhn3Ek/0gG58GnPT0RGdtb
        t2lZlMA1e2ZxEjK7xX0YIK/91Rld17n3pmw8hNS9Tr7I0MnZHbFad9H8GDwGo4wO64u3E17G1EQ4d
        CSHh1GIcZ6MM2+tcvF3q+ol1dCOVzzBX2LwJNnzy21boWeloHpn6EVvHE3QLJ9J8A9rzgwuc1LmKr
        FbhtBAqttUz0CdWiGIR3Xu4MtrDGwaGeVmu0JYazQd/aMez5nJ+4fbF6kndcQhp2a2b8L4QglGJbQ
        +F3jp6w6B6oq1F1jmk8RTxc5XW/8zgudI7ZT8wduRCiGQvwA4Kxf3s158kVziu+vcRpQsMFZk0Je9
        fMAjc/oA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVdo7-00C5Pm-EU; Wed, 29 Sep 2021 17:56:06 +0000
Date:   Wed, 29 Sep 2021 18:55:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <song@kernel.org>
Cc:     Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVSopxYWegtQJ3iD@casper.infradead.org>
References: <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
 <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
 <CAPhsuW4x2UzMLwZyioWH4dXqrYwNT-XKgzvrm+6YeWk9EgQmCQ@mail.gmail.com>
 <dde441c4-febe-cfa1-7729-b405fa331a4e@linux.alibaba.com>
 <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5FONP=1rPh0oPLHsehjfGSDQWn8hKH4v=azdd=+WK2sA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:59:38AM -0700, Song Liu wrote:
> On Wed, Sep 29, 2021 at 12:50 AM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
> >
> >
> >
> > On 9/29/21 3:14 PM, Song Liu wrote:
> > > On Tue, Sep 28, 2021 at 9:20 AM Rongwei Wang
> > > <rongwei.wang@linux.alibaba.com> wrote:
> > >>
> > >>
> > >>
> > >> On 9/28/21 6:24 AM, Song Liu wrote:
> > >>> On Fri, Sep 24, 2021 at 12:12 AM Rongwei Wang
> > >>> <rongwei.wang@linux.alibaba.com> wrote:
> > >>>>
> > >>>>
> > >>>>
> > >>>> On 9/24/21 10:43 AM, Andrew Morton wrote:
> > >>>>> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
> > >>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wrote:
> > >>>>>>>
> > >>>>>>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
> > >>>>>>>> Transparent huge page has supported read-only non-shmem files. The file-
> > >>>>>>>> backed THP is collapsed by khugepaged and truncated when written (for
> > >>>>>>>> shared libraries).
> > >>>>>>>>
> > >>>>>>>> However, there is race in two possible places.
> > >>>>>>>>
> > >>>>>>>> 1) multiple writers truncate the same page cache concurrently;
> > >>>>>>>> 2) collapse_file rolls back when writer truncates the page cache;
> > >>>>>>>
> > >>>>>>> As I've said before, the bug here is that somehow there is a writable fd
> > >>>>>>> to a file with THPs.  That's what we need to track down and fix.
> > >>>>>> Hi, Matthew
> > >>>>>> I am not sure get your means. We know “mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs"
> > >>>>>> Introduced file-backed THPs for DSO. It is possible {very rarely} for DSO to be opened in writeable way.
> > >>>>>>
> > >>>>>> ...
> > >>>>>>
> > >>>>>>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/
> > >>>>>> All in all, what you mean is that we should solve this race at the source?
> > >>>>>
> > >>>>> Matthew is being pretty clear here: we shouldn't be permitting
> > >>>>> userspace to get a writeable fd for a thp-backed file.
> > >>>>>
> > >>>>> Why are we permitting the DSO to be opened writeably?  If there's a
> > >>>>> legitimate case for doing this then presumably "mm, thp: relax the
> > >>>> There is a use case to stress file-backed THP within attachment.
> > >>>> I test this case in a system which has enabled CONFIG_READ_ONLY_THP_FOR_FS:
> > >>>>
> > >>>> $ gcc -Wall -g -o stress_madvise_dso stress_madvise_dso.c
> > >>>> $ ulimit -s unlimited
> > >>>> $ ./stress_madvise_dso 10000 <libtest.so>
> > >>>>
> > >>>> the meaning of above parameters:
> > >>>> 10000: the max test time;
> > >>>> <libtest.so>: the DSO that will been mapped into file-backed THP by
> > >>>> madvise. It recommended that the text segment of DSO to be tested is
> > >>>> greater than 2M.
> > >>>>
> > >>>> The crash will been triggered at once in the latest kernel. And this
> > >>>> case also can used to trigger the bug that mentioned in our another patch.
> > >>>
> > >>> Hmm.. I am not able to use the repro program to crash the system. Not
> > >>> sure what I did wrong.
> > >>>
> > >> Hi
> > >> I have tried to check my test case again. Can you make sure the DSO that
> > >> you test have THP mapping?
> > >>
> > >> If you are willing to try again, I can send my libtest.c which is used
> > >> to test by myself (actually, it shouldn't be target DSO problem).
> > >>
> > >> Thanks very much!
> > >>> OTOH, does it make sense to block writes within khugepaged, like:
> > >>>
> > >>> diff --git i/mm/khugepaged.c w/mm/khugepaged.c
> > >>> index 045cc579f724e..ad7c41ec15027 100644
> > >>> --- i/mm/khugepaged.c
> > >>> +++ w/mm/khugepaged.c
> > >>> @@ -51,6 +51,7 @@ enum scan_result {
> > >>>           SCAN_CGROUP_CHARGE_FAIL,
> > >>>           SCAN_TRUNCATED,
> > >>>           SCAN_PAGE_HAS_PRIVATE,
> > >>> +       SCAN_BUSY_WRITE,
> > >>>    };
> > >>>
> > >>>    #define CREATE_TRACE_POINTS
> > >>> @@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm,
> > >>>           /* Only allocate from the target node */
> > >>>           gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> > >>>
> > >>> +       if (deny_write_access(file)) {
> > >>> +               result = SCAN_BUSY_WRITE;
> > >>> +               return;
> > >>> +       }
> > >>> +
> > >> This can indeed avoid some possible races from source.
> > >>
> > >> But, I am thinking about whether this will lead to DDoS attack?
> > >> I remember the reason of DSO has ignored MAP_DENYWRITE in kernel
> > >> is that DDoS attack. In addition, 'deny_write_access' will change
> > >> the behavior, such as user will get 'Text file busy' during
> > >> collapse_file. I am not sure whether the behavior changing is acceptable
> > >> in user space.
> > >>
> > >> If it is acceptable, I am very willing to fix the races like your way.
> > >
> > > I guess we should not let the write get ETXTBUSY for khugepaged work.
> > >
> > > I am getting some segfault on stress_madvise_dso. And it doesn't really
> > > generate the bug stack in my vm (qemu-system-x86_64). Is there an newer
> > Hi, I can sure I am not update the stress_madvise_dso.c.
> >
> > My test environment is vm (qemu-system-aarch64, 32 cores). And I can
> > think of the following possibilities:
> >
> > (1) in thread_read()
> >
> > printf("read %s\n", dso_path);
> > d = open(dso_path, O_RDONLY);
> > /* The start addr must be alignment with 2M */
> > void *p = mmap((void *)0x40000dc00000UL, 0x800000, PROT_READ |
> > PROT_EXEC,MAP_PRIVATE, fd, 0);
> > if (p == MAP_FAILED) {
> >         perror("mmap");
> >         goto out;
> > }
> >
> > 0x40000dc00000 is random setting by myself. I am not sure this address
> > is available in your vm.
> >
> > (2) in thread_write()
> > int fd = open(dso_path, O_RDWR);
> > p = mmap(NULL, 0x800000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> > if (p == MAP_FAILED) {
> >         perror("mmap");
> >          goto out; /* fail */
> > }
> >
> > because of I am sure the DSO is bigger than 0x800000, so directly map
> > the DSO using 0x800000. Maybe I had use '-z max-page-size=0x200000' to
> > compile the DSO? likes:
> > $ gcc -z max-page-size=0x200000 -o libtest.so -shared libtest.o
> >
> > If you don't mind, you can send the segment fault log to me. And I will
> > find x86 environment to test.
> 
> I fixed the segfault with
> 1. malloc buf (as it is too big for stack) in thread_read
> 2. reduce memcpy() size in thread_read.
> 
> Now, I am able to crash the system on
>     find_lock_entries () {
>      ...
>        VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
>     }
> I guess it is related. I will test more.

That's a bogus VM_BUG_ON.  I have a patch in my tree to delete it.
Andrew has it too, but for some reason, he hasn't sent it on to Linus.

+++ b/mm/filemap.c
@@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
                if (!xa_is_value(page)) {
                        if (page->index < start)
                                goto put;
-                       VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
                        if (page->index + thp_nr_pages(page) - 1 > end)
                                goto put;
                        if (!trylock_page(page))


