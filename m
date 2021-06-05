Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6B239C497
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 02:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFEAoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 20:44:17 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:33777 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbhFEAoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 20:44:16 -0400
Received: by mail-lj1-f181.google.com with SMTP id o8so13826700ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 17:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S0RNl1ValKKRLQbUx9zapSSxQl8HE3O+Grx55QC8BB8=;
        b=ojqlPcYN//lzjPCK23tdLtRIIYrgW9m/5kJ/xOjRInCF4R7iFC1/I0ZkVLmxGV8DXR
         MQWb07lHHZMwwI3mGCRqMAesfKm1mWvsT1fKDr2EyaZCEGoXBk5MRscqdZbVrfjd6byB
         UC2OAmXNTjZ1XXqU2QIkZUr+320CRdtEbj7InexW97stnDZxR/A2mRYURCjA4zPGoT8h
         zZKD7TJ6uy/9jzID2bu4rxwrKqn/bYNh5LMyz+lefblMFpIWrDYNy/UqqVnv9iY+GCYm
         zCIocFSTC5JEnil58sWiJDJ+0EtmDGYceal8ew26Jn/vZJQwmrzF2MxxEU2hsojtFjNK
         mK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0RNl1ValKKRLQbUx9zapSSxQl8HE3O+Grx55QC8BB8=;
        b=f4767xQtN0Z1qY+IJ40DiwY3nZMrylHHcIrynuS15mJKJAkQMW6J6Jum04KW99+n1U
         TPmrQ16Qb47Qk69M7T0tvw0BpdVVehGy/HBWm9AW6tvUIlWrJsPU3WT/a9M7WJ+jvkw8
         dM66gCf4F6+u7Fv25aju6T/smlpgEV51PSo9KPxd4/uAP7ODeHsx7SX14b7u1obAQjYg
         Tz2r6LNvS3VQTxgQbQHT66uTMhee9YFltP6OJhVzhdAseiweVcz8qQpEWP6jbf8dJaqG
         yrg+4NoA247ODIi/xeISC3X0eMfFFEezYCbn4AkWYgjKejUgMfLAe7J6j/xp1hnMaUaV
         ZzvA==
X-Gm-Message-State: AOAM530wHJj5JM7hkQgVGe2Hc8IVMgNuQMahsruGGDVSPt7PIWa2yKio
        n0SE2UhZ8p744In0xT0WEhcppStTttra03tKzgnc2w==
X-Google-Smtp-Source: ABdhPJz1RZbFciQV1FijFF60AoPQ2WRU7bGHglkLlwJI2jhHqLCKOZ4khT7GPCOGC1aZRVomGnuidnciWbK1dWihUSA=
X-Received: by 2002:a05:651c:292:: with SMTP id b18mr5197181ljo.456.1622853674402;
 Fri, 04 Jun 2021 17:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210524132725.12697-1-apopple@nvidia.com> <20210524132725.12697-4-apopple@nvidia.com>
 <20210525183710.fa2m2sbfixnhz7g5@revolver> <CALvZod5T1yjOk48Q_efppvP6iQWnSUwdOQL=G9TadrB6nS-s4Q@mail.gmail.com>
 <20210604204934.sbspsmwdqdtmz73d@revolver>
In-Reply-To: <20210604204934.sbspsmwdqdtmz73d@revolver>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 4 Jun 2021 17:41:03 -0700
Message-ID: <CALvZod6myLUu0j13=nn2vCbH7kQJ4yXs06=0+pZYie2ZN13Mxw@mail.gmail.com>
Subject: Re: [PATCH v9 03/10] mm/rmap: Split try_to_munlock from try_to_unmap
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "bskeggs@redhat.com" <bskeggs@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "jhubbard@nvidia.com" <jhubbard@nvidia.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "hughd@google.com" <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 1:49 PM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> * Shakeel Butt <shakeelb@google.com> [210525 19:45]:
> > On Tue, May 25, 2021 at 11:40 AM Liam Howlett <liam.howlett@oracle.com> wrote:
> > >
> > [...]
> > > >
> > > > +/*
> > > > + * Walks the vma's mapping a page and mlocks the page if any locked vma's are
> > > > + * found. Once one is found the page is locked and the scan can be terminated.
> > > > + */
> > >
> > > Can you please add that this requires the mmap_sem() lock to the
> > > comments?
> > >
> >
> > Why does this require mmap_sem() lock? Also mmap_sem() lock of which mm_struct?
>
>
> Doesn't the mlock_vma_page() require the mmap_sem() for reading?  The
> mm_struct in vma->vm_mm;
>

We are traversing all the vmas where this page is mapped of possibly
different mm_structs. I don't think we want to take mmap_sem() of all
those mm_structs. The commit b87537d9e2fe ("mm: rmap use pte lock not
mmap_sem to set PageMlocked") removed exactly that.

>
> From what I can see, at least the following paths have mmap_lock held
> for writing:
>
> munlock_vma_pages_range() from __do_munmap()
> munlokc_vma_pages_range() from remap_file_pages()
>

The following path does not hold mmap_sem:

exit_mmap() -> munlock_vma_pages_all() -> munlock_vma_pages_range().

I would really suggest all to carefully read the commit message of
b87537d9e2fe ("mm: rmap use pte lock not mmap_sem to set
PageMlocked").

Particularly the following paragraph:
...
    Vlastimil Babka points out another race which this patch protects against.
     try_to_unmap_one() might reach its mlock_vma_page() TestSetPageMlocked a
    moment after munlock_vma_pages_all() did its Phase 1 TestClearPageMlocked:
    leaving PageMlocked and unevictable when it should be evictable.  mmap_sem
    is ineffective because exit_mmap() does not hold it; page lock ineffective
    because __munlock_pagevec() only takes it afterwards, in Phase 2; pte lock
    is effective because __munlock_pagevec_fill() takes it to get the page,
    after VM_LOCKED was cleared from vm_flags, so visible to try_to_unmap_one.
...

Alistair, please bring back the VM_LOCKED check with pte lock held and
the comment "Holding pte lock, we do *not* need mmap_lock here".

One positive outcome of this cleanup patch is the removal of
unnecessary invalidation (unmapping for kvm case) of secondary mmus.
