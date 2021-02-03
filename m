Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAE30E4CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhBCVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhBCVQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:16:04 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6436AC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 13:15:24 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id m22so779187ljj.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+u6BTILoUVaAAqMvPP05q1+sYeBPgAq4q8dfomuEGM=;
        b=WEU9PqqZm2T0n4ETvzj8mQa1byAVBWQqIYe3UmQcn18OJkbNKbZTIyyJA1vcHeB9Qh
         exvPK/JEtrSWN7eF8haKy1SWYJ64eE/yz8Kr6mQ/5HqBIf2LUWRyeyuaTGlpm3LtIdfi
         QdkMo2BqRJIdo5qA25F+mrnvHdLId1tZ6k2cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+u6BTILoUVaAAqMvPP05q1+sYeBPgAq4q8dfomuEGM=;
        b=dx5LbTpkMWxic6dMgNGqOytyT2ZcOMAZpGu+DzZGTLE+IEz6iYmDQuauXai/84+ePW
         bdbzJMVpDvMQRTs7BS39wpY8mCxbY/VejuaS4MCYdKKHVb9SgfnY9wbuG60feoSWxAKP
         AVV2XFcTKMitKsfYKb3RGlJL4N2twvuiH/1lLtBSQHBcGPJ9Ai5QrYyVZ0Ikj5qr7e0l
         UVt009GeaypOrKWcxhMlnWdIGqcEKqMgLom88HfWow5EVKXInLCND6tCpnsYOucHQZXy
         3ELhtVV6w4cT/c8EOqkV+EptzMvCk0wQV7y8l1bGe5PKp6wyBF+08k/sVkBOpRuoOsLG
         PJIg==
X-Gm-Message-State: AOAM5314ST/tSdmesYu6I77zDpaMV5w8dbjWl3gwQIAzt8kwL4Vi3m+2
        2uwbqUtyCxErKnzebpRzYjMiDWexptPg5g==
X-Google-Smtp-Source: ABdhPJwpOJFkwhST65mb+4Tpvjom9Fpdsu2zLFKCBHvpjXMB4jWjA9EJkoqfz2fb8S6Y6BCwcPfPMg==
X-Received: by 2002:a2e:54d:: with SMTP id 74mr2726052ljf.44.1612386922526;
        Wed, 03 Feb 2021 13:15:22 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q1sm349988lfu.48.2021.02.03.13.15.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 13:15:20 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id v24so1260062lfr.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 13:15:20 -0800 (PST)
X-Received: by 2002:ac2:5502:: with SMTP id j2mr2651150lfk.421.1612386919848;
 Wed, 03 Feb 2021 13:15:19 -0800 (PST)
MIME-Version: 1.0
References: <20210203210832.113685-1-peterx@redhat.com> <20210203210832.113685-5-peterx@redhat.com>
In-Reply-To: <20210203210832.113685-5-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Feb 2021 13:15:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=whGvKx2aDhrW4K-PZix+Yt2L=dcv1meQWBiDFrW7ZJ63A@mail.gmail.com>
Message-ID: <CAHk-=whGvKx2aDhrW4K-PZix+Yt2L=dcv1meQWBiDFrW7ZJ63A@mail.gmail.com>
Subject: Re: [PATCH 4/4] hugetlb: Do early cow when page pinned on src mm
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Wei Zhang <wzam@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Gal Pressman <galpress@amazon.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 1:08 PM Peter Xu <peterx@redhat.com> wrote:
>
> This is the last missing piece of the COW-during-fork effort when there're
> pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> pinned pages during fork() for ptes", 2020-09-27) for more information, since
> we do similar things here rather than pte this time, but just for hugetlb.

No issues with the code itself, but..

Comments are good, but the comments inside this block of code actually
makes the code *much* harder to read, because now the actual logic is
much more spread out and you can't see what it does so well.

> +                       if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
> +                               /* This is very possibly a pinned huge page */
> +                               if (!prealloc) {
> +                                       /*
> +                                        * Preallocate the huge page without
> +                                        * tons of locks since we could sleep.
> +                                        * Note: we can't use any reservation
> +                                        * because the page will be exclusively
> +                                        * owned by the child later.
> +                                        */
> +                                       put_page(ptepage);
> +                                       spin_unlock(src_ptl);
> +                                       spin_unlock(dst_ptl);
> +                                       prealloc = alloc_huge_page(vma, addr, 0);
> +                                       if (!prealloc) {
> +                                               /*
> +                                                * hugetlb_cow() seems to be
> +                                                * more careful here than us.
> +                                                * However for fork() we could
> +                                                * be strict not only because
> +                                                * no one should be referencing
> +                                                * the child mm yet, but also
> +                                                * if resources are rare we'd
> +                                                * better simply fail the
> +                                                * fork() even earlier.
> +                                                */
> +                                               ret = -ENOMEM;
> +                                               break;
> +                                       }
> +                                       goto again;
> +                               }
> +                               /*
> +                                * We have page preallocated so that we can do
> +                                * the copy right now.
> +                                */
> +                               hugetlb_copy_page(vma, dst_pte, addr, ptepage,
> +                                                 prealloc);
> +                               put_page(ptepage);
> +                               spin_unlock(src_ptl);
> +                               spin_unlock(dst_ptl);
> +                               prealloc = NULL;
> +                               continue;
> +                       }

Can you move the comment above the code? And I _think_ the prealloc
conditional could be split up to a helper function (which would help
more), but maybe there are too many variables for that to be
practical.

           Linus
