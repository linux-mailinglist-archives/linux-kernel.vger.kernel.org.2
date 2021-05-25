Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C44390D07
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 01:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEYXrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 19:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbhEYXrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 19:47:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD41C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:45:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id q3so18543070lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 16:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bWAgXGiiTzRVKYdfnPTxYrHckcttw3uRegUUnWbckY=;
        b=hhrAWAHsfs4V6Q1rRk+5RzotFe5WWhSfBpNqaVfrq48cm1yZ4mCi/3DHK5lHSGhFsd
         SmJ1xpnVoC7GwKmpH3GoRruIKeU8Ih6iy6Ws79VyE23+Fo9+g4JbUuKztOnJQ/A75X32
         F6tDH6wZDjxQVpUNs2UF0fySZ6sghA7NntIauYgD3MF2VdG4v6OLxVduYDUv5zVgV76d
         JmwjeX0l2NgUtx/F5ZxGtsUf5xupPKtD5PS/OAlZL4HfxZcTuGUESs0ONaygDVe19cwv
         FQzPzjRzsZB6Fnrt5Ecm93WJVhOzxD/x/n3M9I7hGisNhSKHzTk/Tm0AJmUjDadrhVhA
         Z3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bWAgXGiiTzRVKYdfnPTxYrHckcttw3uRegUUnWbckY=;
        b=Kth1GcSqyNTOgAO3sbgph0vUJ8h/WLi6a0gWyVlwU62FLXdI+BfscQ4kFYkgIlU/ch
         6k7ooQzr2clgB1OZ3hyM+XavQPS5g+t8vdMV0BSCAmzh6dyEyW4yk79fSyd1b/CheR8j
         1ihrDV1vIdOf76LrymyHjsZ5+tmDgHrWBty5QgH0h/RaqeD/mt/5pCXG8taFa692sQ9x
         vibB1PmTKysptrnyEyPZp0pOB7Qq8CFCFAC8ohkEKuSCTrVDpibGyUHWcl7IJ/UqaPo2
         MIN9j4G7iu9Ydcp9knAvGWO+8A3PXv6cTpvytsSfp6B1R4WfhwlC3Ua8pjcmpywHLArs
         riWg==
X-Gm-Message-State: AOAM531WmswJnp16mXrVLSqIDmrNTgOuGpMf76KeajqCmk0bL8v1XA/E
        8cUIU8sl1jJaVUPbg9PFl1wC6hLzej9ELxVRzcth8A==
X-Google-Smtp-Source: ABdhPJy9hB4q6/cvtU+d+uGxv+1Wbe3+B9NkI4vv8arO0VwtZXiweVdebha1FQ1CcW8CnxfqxV9Z3KwiBdSb7es7wjA=
X-Received: by 2002:a05:6512:3da3:: with SMTP id k35mr69007lfv.347.1621986339891;
 Tue, 25 May 2021 16:45:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210524132725.12697-1-apopple@nvidia.com> <20210524132725.12697-4-apopple@nvidia.com>
 <20210525183710.fa2m2sbfixnhz7g5@revolver>
In-Reply-To: <20210525183710.fa2m2sbfixnhz7g5@revolver>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 May 2021 16:45:28 -0700
Message-ID: <CALvZod5T1yjOk48Q_efppvP6iQWnSUwdOQL=G9TadrB6nS-s4Q@mail.gmail.com>
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

On Tue, May 25, 2021 at 11:40 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
[...]
> >
> > +/*
> > + * Walks the vma's mapping a page and mlocks the page if any locked vma's are
> > + * found. Once one is found the page is locked and the scan can be terminated.
> > + */
>
> Can you please add that this requires the mmap_sem() lock to the
> comments?
>

Why does this require mmap_sem() lock? Also mmap_sem() lock of which mm_struct?

> > +static bool page_mlock_one(struct page *page, struct vm_area_struct *vma,
> > +                              unsigned long address, void *unused)
> > +{
> > +     struct page_vma_mapped_walk pvmw = {
> > +             .page = page,
> > +             .vma = vma,
> > +             .address = address,
> > +     };
> > +
> > +     /* An un-locked vma doesn't have any pages to lock, continue the scan */
> > +     if (!(vma->vm_flags & VM_LOCKED))
> > +             return true;
> > +
> > +     while (page_vma_mapped_walk(&pvmw)) {
> > +             /* PTE-mapped THP are never mlocked */
> > +             if (!PageTransCompound(page))
> > +                     mlock_vma_page(page);
> > +             page_vma_mapped_walk_done(&pvmw);
> > +
> > +             /*
> > +              * no need to continue scanning other vma's if the page has
> > +              * been locked.
> > +              */
> > +             return false;
> > +     }
> > +
> > +     return true;
> > +}
