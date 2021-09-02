Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831BD3FF6A6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 23:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347899AbhIBV4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 17:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347876AbhIBVzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 17:55:48 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C613FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 14:54:49 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s16so3344014ilo.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7KFt7Ikc/w0m0ZUlbubgqDtFB1Baec+oS2qYMJY2AM=;
        b=BbUBxATcW4HJyE4Tq/1ApCTB8QEm/dXc64RvmSOVjyfMHlIz2OcwoXfIcaKWpV7UuH
         mIA/krYeoCy1Taerp9mNWvCuh0sQ0SKn5N/Gj6gcxgbrLjhha7SbslhSwtIgH0ezlIsM
         nCrRQBf/KOtC2TwCkdU0y1HA0DNhJJN87wO65uNRhyRXEi7ZUMveM4+YY5P+izmJB2MX
         8o+h9KeOd5y+d0PKgKPq6M/DXidCA8fEZloNZVtay9pnGHHvjB/n2b+zdqSN90i3YQVU
         YKQGKp+4GOWCIBuaF4ix3DH+4ducJUEwQLowCPw6UEdjNmtoE7rOikV2zJpHlf4APev+
         +AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7KFt7Ikc/w0m0ZUlbubgqDtFB1Baec+oS2qYMJY2AM=;
        b=kIFli/99FwvirWdffYw/iIGPWLGXmxdulpj4Xe7mWGcGVShVVIjy5UCwlH7aUMKY4O
         afzazIEvRn3XV13r7GApHK5MJdz98c2fTvBnZ8nrIxPZTZHd05IX8sUQ7xJ/0XGVlRFj
         EgLE2C0ZFwi6oDd+BBmdqTAGK1H5Ce79HWla/J81C3Fe5Mp1KLyrYOmfbmxzKnsVzC7n
         vf46hy92ggraliIrPNugbq6vN3zykOe34NW5iITjQpCZg3KPf1T+TtHYXrnlg5KeChrs
         sE3tPi8rrUISn5sSkeTss4j58tvVvb9Q4rYeJwNpeWtxJI8lWUAPRb5CwsGs2ZwGShu3
         aHmA==
X-Gm-Message-State: AOAM531lP7bYqZg9HmAp5EPfxW3TF2oVAgu3YljEwHuN5tCecB6BWO9z
        x6aeup1GmerQqcI7Lb/h1MFCT0vLiynlHMckHFTUAg==
X-Google-Smtp-Source: ABdhPJwVA+zlFc9BfsrBvCIhhxPndKnkE4ZqvX2+vJGbRy7w5K7YJhSTjEWJf+oVnAHMOikIPxi2JOmUnRmeL/p9w4w=
X-Received: by 2002:a05:6e02:1905:: with SMTP id w5mr220889ilu.165.1630619689009;
 Thu, 02 Sep 2021 14:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210901205622.6935-1-peterx@redhat.com> <20210901205622.6935-2-peterx@redhat.com>
 <CAJHvVchpEGvgLGpH7NrSUKLbuur55x+YEm_5y_y0YT7H9yYrng@mail.gmail.com> <YTAF9VptGceZ1bVr@t490s>
In-Reply-To: <YTAF9VptGceZ1bVr@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 2 Sep 2021 14:54:12 -0700
Message-ID: <CAJHvVcgwcxDE6GLJhWZ-XHH0d9kZF+Z-YkUdC3xL8eP_Ek4=KA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/shmem: Unconditionally set pte dirty in mfill_atomic_install_pte
To:     Peter Xu <peterx@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 4:00 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Axel,
>
> On Wed, Sep 01, 2021 at 02:48:53PM -0700, Axel Rasmussen wrote:
> > On Wed, Sep 1, 2021 at 1:56 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > It was conditionally done previously, as there's one shmem special case that we
> > > use SetPageDirty() instead.  However that's not necessary and it should be
> > > easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
> > >
> > > The most recent discussion about this is here, where Hugh explained the history
> > > of SetPageDirty() and why it's possible that it's not required at all:
> > >
> > > https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
> >
> > Thanks for the cleanup Peter!
>
> No problem.  Obviously that special handling of SetPageDirty is still too
> tricky to me and I'd love to remove it.
>
> >
> > I think the discussion of whether or not the data can be marked dirty
> > below is correct, and the code change looks good as well. But, I think
> > we're missing an explanation why Hugh's concern is indeed not a
> > problem?
> >
> > Specifically, this question:
> >
> > "Haha: I think Andrea is referring to exactly the dirty_accountable
> > code in change_pte_protection() which worried me above. Now, I think
> > that will turn out okay (shmem does not have a page_mkwrite(), and
> > does not participate in dirty accounting), but you will have to do
> > some work to assure us all of that, before sending in a cleanup
> > patch."
> >
> > Do we have more evidence that this is indeed fine, vs. what we had
> > when discussing this before? If so, we should talk about it explicitly
> > in this commit message, I think.
> >
> > (Sorry if you've covered this and it's just going over my head. ;) )
>
> Thanks for looking into this.
>
> I thought Hugh's explanation should mostly have covered that.  The previous
> worry is we may have mprotect() applying write bit errornously if we have some
> read-only pte marked dirty.  But I don't think that'll happen just like Hugh
> stated in the thread I attached, as the dirty accountable flag is only set if
> vma_wants_writenotify() returns true.
>
> Take the first example within that helper:
>
>         if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
>                 return 0;
>
> So firstly it never applies to vma that doesn't have VM_WRITE|VM_SHARED. So far
> it even doesn't work for anonymous, but logically it may, like:
>
> https://github.com/aagit/aa/commit/05dc2c56ef79b3836c75fcf68c5b19b08f4e4c58
>
> Peter Collingbourne originated that patch, due to some reason it didn't land
> which I forgot, however I still think it's doable even for anonymous.
>
> Sorry to have gone off-topic; let me go back to it.
>
> It also checks for e.g. page_mkwrite() needs, soft dirty tracking and so on to
> make sure it's okay to grant write bit when possible.
>
> Hugh mentioned "do some work to assure us all of that" - I did firstly went
> throught the code carefully myself so I'm more certain it's doing the right
> thing to me, secondly I did run quite some tests on the patch (actually on the
> whole uffd-wp shmem+hugetlbfs branch).  Even if I'm going to switch the uffd-wp
> series to the pte marker format, this patch won't change.
>
> I also analysized three callers that may be affected by this change below, and
> explaining why it's okay.  I hope that can also be counted as part of the "some
> work" that Hugh asked.
>
> Besides all these, I'm pretty happy too if anyone would help me to tell
> otherwise on whether there's still things missing so we can't do this.  That's
> the "code review" part for every single patch, including this one, isn't it? :)

Makes sense. :) Allow me to think out loud for a moment; about the
three UFFD cases:

I agree case (2) mcopy_atomic_pte has !page_in_cache (by definition,
since COPY specifically means inserting a new page), and so is not
changing functionally. I'll ignore this case.



Case (1) shmem_mfill_atomic_pte is only called for shmem VMAs, with
VM_SHARED, and with mode being one of copy (NORMAL) or ZEROPAGE. This
case is interesting, because like case (2) we certainly have
!page_in_cache, so we were always doing pte_mkdirty(). The difference
here is we now no longer *also* SetPageDirty(). What does it mean for
a PTE to be dirty, but not the page (or the other way around)? I
confess I don't know.

But, at least as far as mprotect is concerned, it seems to not care
about PageDirty really. It does check it in one place, "if
(page_is_file_lru(page) && PageDirty(page))", but "page_is_file_lru"
really means "is the page *not* swap backed", so I think shmem pages
are never file lru? If true, then this check is never true for shmem
anyway, regardless of whether we SetPageDirty or not, and can be
ignored.

So, for case (1) I think there's no behavior change, at least with
regard to mprotect().



Case (3) mcontinue_atomic_pte handles CONTINUE for all shmem VMAs.
Meaning, we by definition have page_in_cache. It also seems to me we
could have any combination of VM_SHARED or not, VM_WRITE or not, PTE
writeable or not.

I have to admit, I am a little bit fuzzy on exactly what PageDirty
means for shmem (since there is no "filesystem", it's all just RAM). I
think being "dirty" in this case means, if we wanted to reclaim the
page, we would need to *swap it out*. I.e., shmem pages are always
"dirty", as long as they are in the page cache (and have been modified
at least once since being allocated? or maybe we don't bother keeping
track of zero pages).

So, this patch changes the behavior for case (3), when we end up with
!writable (i.e., !(VM_WRITE && VM_SHARED) -- note we check VM_SHARED
further down). We used to *skip* pte_mkdirty() if !writable, but now
we do it after all. But, for mprotect to do its thing, it requires
vma_wants_writenotify() -- but if we have !VM_WRITE, or !VM_SHARED, it
returns false. So in the only case where case (3) actually does
something different, mprotect *doesn't* do anything.



Okay, I've convinced myself. :) Sorry for the long e-mail. Feel free
to take (for v2 as well, this patch didn't change):

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

>
> Thanks,
>
> >
> > >
> > >
> > >
> > > Currently mfill_atomic_install_pte() has three callers:
> > >
> > >         1. shmem_mfill_atomic_pte
> > >         2. mcopy_atomic_pte
> > >         3. mcontinue_atomic_pte
> > >
> > > After the change: case (1) should have its SetPageDirty replaced by the dirty
> > > bit on pte (so we unify them together, finally), case (2) should have no
> > > functional change at all as it has page_in_cache==false, case (3) may add a
> > > dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
> > > it's merely 100% sure the page is dirty after all, so should not make a real
> > > difference either.
>
> --
> Peter Xu
>
