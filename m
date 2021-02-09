Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4614B315076
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 14:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhBINjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 08:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhBINiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 08:38:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F13BC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 05:37:44 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id d20so19400494oiw.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N841iQ9kWSoyGbDxnyS2lfPbTFn9GbQBCWGWYptwBjo=;
        b=dZnwC0EP2oRvQWDzVYjaBz0mpRcOi213Sz/23TmswG07qWiPNm18GTaVBf5tLMQHnN
         npPa0SIiwwz5hq4z6EPRBu6MenNeP46VigR7K9W+N0XELD7lgOgModNvxP1ianmO1OUC
         WgV8qTbjUWfRbzNtOTCmMhaBEd+myqyLjIfv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N841iQ9kWSoyGbDxnyS2lfPbTFn9GbQBCWGWYptwBjo=;
        b=E0xxDJtQXYQiN79Dy1WN48EP1dk+NGQ7Fw5ANiG/6G/thojza2/60j7bARrHOaAC1n
         62b5JnaWj8pWq4qbWcmmpgfAoReVLOBNXpY8IR19AHrrVugqtMW/a0fGnJKQ2aafmc8O
         R0SRs/VnV/IuQLRmtSuAAnRSVojx/E4xtXcytxRQcilpObdtpmISvQDk2+UhZkN5mj7v
         1dTDIaA2YfUOgu2M8rvw68IgmukpizXrGXqNAKentsC1Qa9QtUPQB/0Q7m8I1EZfqWDo
         NvZh7LeKMPukcwAOWuD2WJfaKw9nhIRMd5aolKW3cFqJQC5WvWkGkQ/yaunIAP4Jb5QP
         OGuQ==
X-Gm-Message-State: AOAM533EPY+iYIcK08G7gzxfmpf09Ps8GPbWj6DG6Sm1xDEKmaJ5d1XO
        Cvz62wMRvOE9VOofABuq1o+PqavbYcgYhP608lNX+A==
X-Google-Smtp-Source: ABdhPJyy5MepLQLdvLY0EPRLtIDNjgs2IIyBoFeuNQNErnK1iydPhtA2Lf5mM4hgfdSRq9s19tLXbQJR2E7el+1dVPg=
X-Received: by 2002:aca:df42:: with SMTP id w63mr2479956oig.128.1612877863700;
 Tue, 09 Feb 2021 05:37:43 -0800 (PST)
MIME-Version: 1.0
References: <20210209010722.13839-1-apopple@nvidia.com> <CAKMK7uGwg2-DTU7Zrco=TSkcR4yTqN1AF0hvVYEAbuj4BUYi5Q@mail.gmail.com>
 <3426910.QXTomnrpqD@nvdebian>
In-Reply-To: <3426910.QXTomnrpqD@nvdebian>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 9 Feb 2021 14:37:32 +0100
Message-ID: <CAKMK7uHp+BzHF1=JhKjv5HYm_j0SVqsGdRqjUxVFYx4GSEPucg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Add support for SVM atomics in Nouveau
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Nouveau Dev <nouveau@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm-ppc@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 1:57 PM Alistair Popple <apopple@nvidia.com> wrote:
>
> On Tuesday, 9 February 2021 9:27:05 PM AEDT Daniel Vetter wrote:
> > >
> > > Recent changes to pin_user_pages() prevent the creation of pinned pages in
> > > ZONE_MOVABLE. This series allows pinned pages to be created in
> ZONE_MOVABLE
> > > as attempts to migrate may fail which would be fatal to userspace.
> > >
> > > In this case migration of the pinned page is unnecessary as the page can
> be
> > > unpinned at anytime by having the driver revoke atomic permission as it
> > > does for the migrate_to_ram() callback. However a method of calling this
> > > when memory needs to be moved has yet to be resolved so any discussion is
> > > welcome.
> >
> > Why do we need to pin for gpu atomics? You still have the callback for
> > cpu faults, so you
> > can move the page as needed, and hence a long-term pin sounds like the
> > wrong approach.
>
> Technically a real long term unmoveable pin isn't required, because as you say
> the page can be moved as needed at any time. However I needed some way of
> stopping the CPU page from being freed once the userspace mappings for it had
> been removed. Obviously I could have just used get_page() but from the
> perspective of page migration the result is much the same as a pin - a page
> which can't be moved because of the extra refcount.

long term pin vs short term page reference aren't fully fleshed out.
But the rule more or less is:
- short term page reference: _must_ get released in finite time for
migration and other things, either because you have a callback, or
because it's just for direct I/O, which will complete. This means
short term pins will delay migration, but not foul it complete

- long term pin: the page cannot be moved, all migration must fail.
Also this will have an impact on COW behaviour for fork (but not sure
where those patches are, John Hubbard will know).

So I think for your use case here you want a) short term page
reference to make sure it doesn't disappear plus b) callback to make
sure migrate isn't blocked.

Breaking ZONE_MOVEABLE with either allowing long term pins or failing
migrations because you don't release your short term page reference
isn't good.

> The normal solution of registering an MMU notifier to unpin the page when it
> needs to be moved also doesn't work as the CPU page tables now point to the
> device-private page and hence the migration code won't call any invalidate
> notifiers for the CPU page.

Yeah you need some other callback for migration on the page directly.
it's a bit awkward since there is one already for struct
address_space, but that's own by the address_space/page cache, not
HMM. So I think we need something else, maybe something for each
ZONE_DEVICE?

> > That would avoid all the hacking around long term pin constraints, because
> > for real unmoveable long term pinned memory we really want to have all
> > these checks. So I think we might be missing some other callbacks to be
> > able to move these pages, instead of abusing longterm pins for lack of
> > better tools.
>
> Yes, I would like to avoid the long term pin constraints as well if possible I
> just haven't found a solution yet. Are you suggesting it might be possible to
> add a callback in the page migration logic to specially deal with moving these
> pages?

s/possible/need to type some code to address it/ I think.

But also I'm not much of an expert on this, I've only just started
learning how this all fits together coming from the gpu side. There's
a _lot_ of finesse involved.

Cheers, Daniel

>
> Thanks, Alistair
>
> > Cheers, Daniel
> >
> >
> >
> > >
> > > Alistair Popple (9):
> > >   mm/migrate.c: Always allow device private pages to migrate
> > >   mm/migrate.c: Allow pfn flags to be passed to migrate_vma_setup()
> > >   mm/migrate: Add a unmap and pin migration mode
> > >   Documentation: Add unmap and pin to HMM
> > >   hmm-tests: Add test for unmap and pin
> > >   nouveau/dmem: Only map migrating pages
> > >   nouveau/svm: Refactor nouveau_range_fault
> > >   nouveau/dmem: Add support for multiple page types
> > >   nouveau/svm: Implement atomic SVM access
> > >
> > >  Documentation/vm/hmm.rst                      |  22 +-
> > >  arch/powerpc/kvm/book3s_hv_uvmem.c            |   4 +-
> > >  drivers/gpu/drm/nouveau/include/nvif/if000c.h |   1 +
> > >  drivers/gpu/drm/nouveau/nouveau_dmem.c        | 190 +++++++++++++++---
> > >  drivers/gpu/drm/nouveau/nouveau_dmem.h        |   9 +
> > >  drivers/gpu/drm/nouveau/nouveau_svm.c         | 148 +++++++++++---
> > >  drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.h |   1 +
> > >  .../drm/nouveau/nvkm/subdev/mmu/vmmgp100.c    |   6 +
> > >  include/linux/migrate.h                       |   2 +
> > >  include/linux/migrate_mode.h                  |   1 +
> > >  lib/test_hmm.c                                | 109 ++++++++--
> > >  lib/test_hmm_uapi.h                           |   1 +
> > >  mm/migrate.c                                  |  82 +++++---
> > >  tools/testing/selftests/vm/hmm-tests.c        |  49 +++++
> > >  14 files changed, 524 insertions(+), 101 deletions(-)
> > >
> > > --
> > > 2.20.1
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
>
>
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
