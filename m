Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8FD3FF7DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbhIBXbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45912 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233191AbhIBXbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630625423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gZI3Tf9nXIz6lTaw6ipHmwA5l0ZDecuTzDK6PB7wDHo=;
        b=cPFcPlQBEq+m6lDu7Y97GQDPByTHEjmx0EopIMrJeduizYxJYjqnygCF1jyQQJ1FB8dtZd
        GcGUIct4vl2Jyvk9VMS+c+CamL21AMFN6lI1PuH6PletgtP8TKy3upLTsSmPqRFZG0W0pU
        K0Jnbjr3KjCFXi0KpWYJydgfuoTtOz0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-a6V2N7p0P9-TDvdpDiPXDQ-1; Thu, 02 Sep 2021 19:30:22 -0400
X-MC-Unique: a6V2N7p0P9-TDvdpDiPXDQ-1
Received: by mail-qk1-f197.google.com with SMTP id t18-20020a05620a0b1200b003f8729fdd04so4624635qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZI3Tf9nXIz6lTaw6ipHmwA5l0ZDecuTzDK6PB7wDHo=;
        b=Apz+NVqR1Rxu3GOWM/1myZqNhG8c3czY2aG+QbImJQT+qkdZaxCWzetSgzwIxtV7Yw
         bvhZVxZHAwx9rgcEqf465os+9kJzr1ZaUz10sD4lQmqZLbcMt6M3hu798QVAswzgH+Fi
         yBSdVtgC+tnN1oTQxL+Bf0HWSZSuJkdaM1PpKa5RoN0H+88g0w+xTBhD206jrDEvnDe7
         nt5+Yx8NgPHFBTJkXjgs4VYadKjagjE9s5Hbi593Cax7mGqe3y8uRdEotLmbTywP4Ob2
         X+geTt8Wy7HgJGkoUm+L0ZvHhwvmLxrwE5s0n6Rzo/KoGQHTkFAYTPgDpKb4BB52N+VB
         gcCg==
X-Gm-Message-State: AOAM533Iw90GAiYj4Y0kZRN0pGxz/3BJDE9sLAsSi6sUk0F/JX0mq49W
        9E2UBEWWmuLKZtmlvW+4ku/qRXhk0dt1NsKsUz74XMNZ1g/iQpbDs2LAOnMEIvwLvYyzI7SJUqM
        wYUGrq0RfYNn71mwNlkrrYixh
X-Received: by 2002:a05:620a:ce6:: with SMTP id c6mr654740qkj.384.1630625422217;
        Thu, 02 Sep 2021 16:30:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy22bml7DNmDIh/39nUKnHqVRrSt1LhTO9Qy+cDfvp9ycn6Y4sA0BR9dt3M4TiXNlfh5LJFQA==
X-Received: by 2002:a05:620a:ce6:: with SMTP id c6mr654715qkj.384.1630625421902;
        Thu, 02 Sep 2021 16:30:21 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id v23sm1985841qto.55.2021.09.02.16.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 16:30:21 -0700 (PDT)
Date:   Thu, 2 Sep 2021 19:30:19 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
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
Subject: Re: [PATCH 1/5] mm/shmem: Unconditionally set pte dirty in
 mfill_atomic_install_pte
Message-ID: <YTFei9pzT8hsdMFe@t490s>
References: <20210901205622.6935-1-peterx@redhat.com>
 <20210901205622.6935-2-peterx@redhat.com>
 <CAJHvVchpEGvgLGpH7NrSUKLbuur55x+YEm_5y_y0YT7H9yYrng@mail.gmail.com>
 <YTAF9VptGceZ1bVr@t490s>
 <CAJHvVcgwcxDE6GLJhWZ-XHH0d9kZF+Z-YkUdC3xL8eP_Ek4=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgwcxDE6GLJhWZ-XHH0d9kZF+Z-YkUdC3xL8eP_Ek4=KA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:54:12PM -0700, Axel Rasmussen wrote:
> On Wed, Sep 1, 2021 at 4:00 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Axel,
> >
> > On Wed, Sep 01, 2021 at 02:48:53PM -0700, Axel Rasmussen wrote:
> > > On Wed, Sep 1, 2021 at 1:56 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > It was conditionally done previously, as there's one shmem special case that we
> > > > use SetPageDirty() instead.  However that's not necessary and it should be
> > > > easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
> > > >
> > > > The most recent discussion about this is here, where Hugh explained the history
> > > > of SetPageDirty() and why it's possible that it's not required at all:
> > > >
> > > > https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
> > >
> > > Thanks for the cleanup Peter!
> >
> > No problem.  Obviously that special handling of SetPageDirty is still too
> > tricky to me and I'd love to remove it.
> >
> > >
> > > I think the discussion of whether or not the data can be marked dirty
> > > below is correct, and the code change looks good as well. But, I think
> > > we're missing an explanation why Hugh's concern is indeed not a
> > > problem?
> > >
> > > Specifically, this question:
> > >
> > > "Haha: I think Andrea is referring to exactly the dirty_accountable
> > > code in change_pte_protection() which worried me above. Now, I think
> > > that will turn out okay (shmem does not have a page_mkwrite(), and
> > > does not participate in dirty accounting), but you will have to do
> > > some work to assure us all of that, before sending in a cleanup
> > > patch."
> > >
> > > Do we have more evidence that this is indeed fine, vs. what we had
> > > when discussing this before? If so, we should talk about it explicitly
> > > in this commit message, I think.
> > >
> > > (Sorry if you've covered this and it's just going over my head. ;) )
> >
> > Thanks for looking into this.
> >
> > I thought Hugh's explanation should mostly have covered that.  The previous
> > worry is we may have mprotect() applying write bit errornously if we have some
> > read-only pte marked dirty.  But I don't think that'll happen just like Hugh
> > stated in the thread I attached, as the dirty accountable flag is only set if
> > vma_wants_writenotify() returns true.
> >
> > Take the first example within that helper:
> >
> >         if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
> >                 return 0;
> >
> > So firstly it never applies to vma that doesn't have VM_WRITE|VM_SHARED. So far
> > it even doesn't work for anonymous, but logically it may, like:
> >
> > https://github.com/aagit/aa/commit/05dc2c56ef79b3836c75fcf68c5b19b08f4e4c58
> >
> > Peter Collingbourne originated that patch, due to some reason it didn't land
> > which I forgot, however I still think it's doable even for anonymous.
> >
> > Sorry to have gone off-topic; let me go back to it.
> >
> > It also checks for e.g. page_mkwrite() needs, soft dirty tracking and so on to
> > make sure it's okay to grant write bit when possible.
> >
> > Hugh mentioned "do some work to assure us all of that" - I did firstly went
> > throught the code carefully myself so I'm more certain it's doing the right
> > thing to me, secondly I did run quite some tests on the patch (actually on the
> > whole uffd-wp shmem+hugetlbfs branch).  Even if I'm going to switch the uffd-wp
> > series to the pte marker format, this patch won't change.
> >
> > I also analysized three callers that may be affected by this change below, and
> > explaining why it's okay.  I hope that can also be counted as part of the "some
> > work" that Hugh asked.
> >
> > Besides all these, I'm pretty happy too if anyone would help me to tell
> > otherwise on whether there's still things missing so we can't do this.  That's
> > the "code review" part for every single patch, including this one, isn't it? :)
> 
> Makes sense. :) Allow me to think out loud for a moment; about the
> three UFFD cases:
> 
> I agree case (2) mcopy_atomic_pte has !page_in_cache (by definition,
> since COPY specifically means inserting a new page), and so is not
> changing functionally. I'll ignore this case.
> 
> 
> 
> Case (1) shmem_mfill_atomic_pte is only called for shmem VMAs, with
> VM_SHARED, and with mode being one of copy (NORMAL) or ZEROPAGE. This
> case is interesting, because like case (2) we certainly have
> !page_in_cache, so we were always doing pte_mkdirty(). The difference
> here is we now no longer *also* SetPageDirty(). What does it mean for
> a PTE to be dirty, but not the page (or the other way around)? I
> confess I don't know.

The PTE being dirty should be fine to cover the PageDirty case.

When the PTE is zapped, we'll need to move that pte dirty bit to PageDirty no
matter when we zap that PTE.  E.g. see zap_pte_range(), here is:

        if (!PageAnon(page)) {
                if (pte_dirty(ptent)) {
                        force_flush = 1;
                        set_page_dirty(page);
                }
                ...
        }

So IMHO you can see it as a delayed (but unified) version of setting page
PG_dirty.

> 
> But, at least as far as mprotect is concerned, it seems to not care
> about PageDirty really. It does check it in one place, "if
> (page_is_file_lru(page) && PageDirty(page))", but "page_is_file_lru"
> really means "is the page *not* swap backed", so I think shmem pages
> are never file lru? If true, then this check is never true for shmem
> anyway, regardless of whether we SetPageDirty or not, and can be
> ignored.
> 
> So, for case (1) I think there's no behavior change, at least with
> regard to mprotect().

The behavior change is that the pte does not have the dirty bit set before this
patch for this case, now it will have.

I think that's also why Hugh explained why it's okay, and what's the source of
the discussion that we used to think it might have an impact - that originates
from Andrea's patch on the 1st usage of SetPageDirty within UFFDIO_COPY shmem
path.

> 
> 
> 
> Case (3) mcontinue_atomic_pte handles CONTINUE for all shmem VMAs.
> Meaning, we by definition have page_in_cache. It also seems to me we
> could have any combination of VM_SHARED or not, VM_WRITE or not, PTE
> writeable or not.
> 
> I have to admit, I am a little bit fuzzy on exactly what PageDirty
> means for shmem (since there is no "filesystem", it's all just RAM). I
> think being "dirty" in this case means, if we wanted to reclaim the
> page, we would need to *swap it out*.

Yes, at least that's how I understand it too.

If the page doesn't have dirty bit set, it means it can be thrown away at any
time.  See pageout() calling clear_page_dirty_for_io(), and its own stack when
doing page reclaim.

> I.e., shmem pages are always
> "dirty", as long as they are in the page cache (and have been modified
> at least once since being allocated? or maybe we don't bother keeping
> track of zero pages).
> 
> So, this patch changes the behavior for case (3), when we end up with
> !writable (i.e., !(VM_WRITE && VM_SHARED) -- note we check VM_SHARED
> further down). We used to *skip* pte_mkdirty() if !writable, but now
> we do it after all. But, for mprotect to do its thing, it requires
> vma_wants_writenotify() -- but if we have !VM_WRITE, or !VM_SHARED, it
> returns false. So in the only case where case (3) actually does
> something different, mprotect *doesn't* do anything.

Yes, I think that could be a slight difference for !write case but IMHO it's
fine too, it's the case when process A maps the shmem with RO but process B
maps with RW: process B should be the one that updates page and sends
UFFDIO_CONTINUE; and process B mustn't map it RO because otherwise why bother
if it can't do anything!  It means page cache must be dirty anyway irrelevant
of dirty bit in process A.  So I think that's not a general use case for minor
fault either as I should have expressed in the commit message.

Keeping that "optimization on conditionally set dirty bit" is okay but it just
makes things complicated and it'll grow more complex when uffd-wp shmem comes.
That is not worth it.  I figured it's easier to set dirty always - no reason to
fight data loss again.

> 
> 
> 
> Okay, I've convinced myself. :) Sorry for the long e-mail. Feel free
> to take (for v2 as well, this patch didn't change):
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

Thank you, Axel.  I'll collect that in v3.

-- 
Peter Xu

