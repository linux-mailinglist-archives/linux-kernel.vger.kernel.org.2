Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B453C37ED86
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384333AbhELUiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:38:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1383472AbhELUPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 16:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620850485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3wuTWQtuAdZWIF9OysD2QPM7zsLn8CRp+0adiSduMjY=;
        b=SZ0kSaJcuz8dG0U0sHqMcSyhpgb4voCez+FrEIFPblu6kMaw2H5vGFBSRQBgLlrXMNSsQf
        PzaMle1/mSdu8B3oP6IaHt+6EJIUE25dQeX+5ExOIlvtPuu0+Pvyu2zpVyHQUfbM3fna8F
        wk9yTC7IhfQNT+K+FomsGKiCVWx+2A4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-4h4DCB0tOoizu1V88jgoMg-1; Wed, 12 May 2021 16:14:43 -0400
X-MC-Unique: 4h4DCB0tOoizu1V88jgoMg-1
Received: by mail-qv1-f69.google.com with SMTP id b24-20020a0cb3d80000b02901e78b82d74aso9763735qvf.20
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 13:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3wuTWQtuAdZWIF9OysD2QPM7zsLn8CRp+0adiSduMjY=;
        b=VBndn8d2H3NCRNHahfwYbXWXcODlA/xij73Kv6lbwGJpKnlxQJ7d+RSrRPZ4ze1hIC
         xHn/GNEW9RWOUd9qO+dQspgnyydW8jM92TMv9WcN2HS9LE8yyaI1QWGs698vfuMGQyIg
         ZiQMTeCtenO9EC8Upuuz/lcjODYGWR8wsnvJkQDYvHxnbCOUqK2lPLOkDhYtNciVFW/C
         I+uhtXdkTrLfY68yoLobuHNq6CVm5XVeW3uBKhX5hlRFH8+sNowFKobUIUg/ZBQqS2PC
         +HKWEqZNkpjtfRxKLw0qUV+Pkxb/sUWFSHSjk0m+TMR4tSF0HhtPdN3IInwS1Br2AIRK
         1LJw==
X-Gm-Message-State: AOAM530qlQFCTqC0/EXHwjWNQGf0Y1VgOBcewhhQtc5N9jSR2KOEDght
        GRKvMViMIe/fx8yENN/QjAK6lHPTmHvZdZ3GZ3lzQZUgzFZ0k/j2KGY+au8ePUld8aFXMDJOiDo
        xTI4CifgjnmFPf+T1YGajLcJ/
X-Received: by 2002:ac8:754a:: with SMTP id b10mr35375896qtr.83.1620850483239;
        Wed, 12 May 2021 13:14:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFVH3v9wK01tFnKp9M4XThk+XsejO1huyQYVMBeEOp+qXQ8jQRLoYuAI5nciOv1HySxPSwOA==
X-Received: by 2002:ac8:754a:: with SMTP id b10mr35375872qtr.83.1620850482957;
        Wed, 12 May 2021 13:14:42 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id h10sm884015qka.26.2021.05.12.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 13:14:42 -0700 (PDT)
Date:   Wed, 12 May 2021 16:14:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm, hugetlb: fix resv_huge_pages underflow on UFFDIO_COPY
Message-ID: <YJw3MH2kTftwvlGa@t490s>
References: <e134d74d-c218-a01d-a315-82b909c84051@oracle.com>
 <20210512065813.89270-1-almasrymina@google.com>
 <CAJHvVch0ZMapPVEc0Ge5V4KDgNDNhECbqwDi0y9XxsxFXQZ-gg@mail.gmail.com>
 <c455d241-11f6-95a6-eb29-0ddd94eedbd7@oracle.com>
 <CAHS8izM8G948ziJToaNKgqaMQ9_CB+anksGQQHSbTY1a+yGSjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHS8izM8G948ziJToaNKgqaMQ9_CB+anksGQQHSbTY1a+yGSjg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mina,

On Wed, May 12, 2021 at 12:42:32PM -0700, Mina Almasry wrote:
> > >> @@ -4868,30 +4869,39 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
> > >>                             struct page **pagep)
> > >>  {
> > >>         bool is_continue = (mode == MCOPY_ATOMIC_CONTINUE);
> > >> -       struct address_space *mapping;
> > >> -       pgoff_t idx;
> > >> +       struct hstate *h = hstate_vma(dst_vma);
> > >> +       struct address_space *mapping = dst_vma->vm_file->f_mapping;
> > >> +       pgoff_t idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> > >>         unsigned long size;
> > >>         int vm_shared = dst_vma->vm_flags & VM_SHARED;
> > >> -       struct hstate *h = hstate_vma(dst_vma);
> > >>         pte_t _dst_pte;
> > >>         spinlock_t *ptl;
> > >> -       int ret;
> > >> +       int ret = -ENOMEM;
> > >>         struct page *page;
> > >>         int writable;
> > >>
> > >> -       mapping = dst_vma->vm_file->f_mapping;
> > >> -       idx = vma_hugecache_offset(h, dst_vma, dst_addr);
> > >> +       /* Out parameter. */
> > >> +       WARN_ON(*pagep);
> > >
> > > I don't think this warning works, because we do set *pagep, in the
> > > copy_huge_page_from_user failure case. In that case, the following
> > > happens:
> > >
> > > 1. We set *pagep, and return immediately.
> > > 2. Our caller notices this particular error, drops mmap_lock, and then
> > > calls us again with *pagep set.
> > >
> > > In this path, we're supposed to just re-use this existing *pagep
> > > instead of allocating a second new page.
> > >
> > > I think this also means we need to keep the "else" case where *pagep
> > > is set below.
> > >
> >
> > +1 to Peter's comment.
> >
> 
> Gah, sorry about that. I'll fix in v2.

I have a question regarding v1: how do you guarantee huge_add_to_page_cache()
won't fail again even if checked before page alloc?  Say, what if the page
cache got inserted after hugetlbfs_pagecache_present() (which is newly added in
your v1) but before huge_add_to_page_cache()?

I also have a feeling that we've been trying to work around something else, but
I can't tell yet as I'll probably need to read a bit more/better on how hugetlb
does the accounting and also on reservations.

Thanks,

-- 
Peter Xu

