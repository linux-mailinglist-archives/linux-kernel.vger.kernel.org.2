Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B20C30E5CD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhBCWKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233112AbhBCWJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612390087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hG2EjjDlxu+mTK6oPbxOTgSnmmgeufvKa274DeuP6Hk=;
        b=JpI7tHI6pHt5GPJRDsnMQZA0nLy9CA8u8EphQ0IMNr/x6gTZFjUQ6FaWacYsKuIzw+ZV2T
        4jp/NyJYVG1r/MF4yim1cFZ403l9LkIn+wvNnKVzx2yZMQSlOivobTis/X7BZH69Qr3AbA
        DnA0nI4GG54Qv3QJKLCE9NAB1iCmxJw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-RBOzOuhtM1uLbJ3d4kmPaA-1; Wed, 03 Feb 2021 17:08:06 -0500
X-MC-Unique: RBOzOuhtM1uLbJ3d4kmPaA-1
Received: by mail-qk1-f199.google.com with SMTP id s66so808909qkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 14:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hG2EjjDlxu+mTK6oPbxOTgSnmmgeufvKa274DeuP6Hk=;
        b=W3gT3JiRoOGlN9JQRvcfvENUKhlcns8kzNHCCzotqJs/bmoTvcTxfaFIG93c/xP+Wz
         dRFY16lnAaiTX+xzNDFQGYXzZzuuKYUgtPRWhIRaweXOSJev2Oxn1RjD+bxGUq3LIUVZ
         Q/IufJQJ2F1mS5VWvnNV8URkOBLoMBQQZZLqm8il0c0jAuRHWmuTxTj8+Kh7ndXWb5js
         8UWV8DZXEaOcHMN6MoTLPfD7d3/IdeZdxm/lO5WC3cC6rrJC8TG/CmKwt9Lqw80xRygD
         Mb2mksZczyTPHWC1AHa2Q532DqmbDYgZfSM850NDgTKJFXtek10Et8Zi1N0haHUSZyyY
         Ho2g==
X-Gm-Message-State: AOAM531urLAVy2fdKrtuv1bvBjtOG8bfkTxGbGX+BUOF+Z1RN3JPnoCn
        1lJ4dbdBo3Qw8DewgReL1vGIUVetnIbWRDvlYwsa8+ZokSRWI8gBxlpm3kHaZe4nVJOdj9nncU5
        ilWTvLwSjmpIXvRFSEiaRvIVF
X-Received: by 2002:a05:622a:44b:: with SMTP id o11mr4401694qtx.229.1612390085164;
        Wed, 03 Feb 2021 14:08:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxbCthm7uB1Int/mO1oiVdZ8U1Sguv/fGeWNI5tA5hIlAChAcVxFUEccPG6U3m7FNFy5cgUjw==
X-Received: by 2002:a05:622a:44b:: with SMTP id o11mr4401660qtx.229.1612390084879;
        Wed, 03 Feb 2021 14:08:04 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id p12sm2702851qtw.27.2021.02.03.14.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 14:08:04 -0800 (PST)
Date:   Wed, 3 Feb 2021 17:08:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [PATCH 4/4] hugetlb: Do early cow when page pinned on src mm
Message-ID: <20210203220802.GJ6468@xz-x1>
References: <20210203210832.113685-1-peterx@redhat.com>
 <20210203210832.113685-5-peterx@redhat.com>
 <CAHk-=whGvKx2aDhrW4K-PZix+Yt2L=dcv1meQWBiDFrW7ZJ63A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whGvKx2aDhrW4K-PZix+Yt2L=dcv1meQWBiDFrW7ZJ63A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 01:15:03PM -0800, Linus Torvalds wrote:
> On Wed, Feb 3, 2021 at 1:08 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This is the last missing piece of the COW-during-fork effort when there're
> > pinned pages found.  One can reference 70e806e4e645 ("mm: Do early cow for
> > pinned pages during fork() for ptes", 2020-09-27) for more information, since
> > we do similar things here rather than pte this time, but just for hugetlb.
> 
> No issues with the code itself, but..
> 
> Comments are good, but the comments inside this block of code actually
> makes the code *much* harder to read, because now the actual logic is
> much more spread out and you can't see what it does so well.
> 
> > +                       if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
> > +                               /* This is very possibly a pinned huge page */
> > +                               if (!prealloc) {
> > +                                       /*
> > +                                        * Preallocate the huge page without
> > +                                        * tons of locks since we could sleep.
> > +                                        * Note: we can't use any reservation
> > +                                        * because the page will be exclusively
> > +                                        * owned by the child later.
> > +                                        */
> > +                                       put_page(ptepage);
> > +                                       spin_unlock(src_ptl);
> > +                                       spin_unlock(dst_ptl);
> > +                                       prealloc = alloc_huge_page(vma, addr, 0);
> > +                                       if (!prealloc) {
> > +                                               /*
> > +                                                * hugetlb_cow() seems to be
> > +                                                * more careful here than us.
> > +                                                * However for fork() we could
> > +                                                * be strict not only because
> > +                                                * no one should be referencing
> > +                                                * the child mm yet, but also
> > +                                                * if resources are rare we'd
> > +                                                * better simply fail the
> > +                                                * fork() even earlier.
> > +                                                */
> > +                                               ret = -ENOMEM;
> > +                                               break;
> > +                                       }
> > +                                       goto again;
> > +                               }
> > +                               /*
> > +                                * We have page preallocated so that we can do
> > +                                * the copy right now.
> > +                                */
> > +                               hugetlb_copy_page(vma, dst_pte, addr, ptepage,
> > +                                                 prealloc);
> > +                               put_page(ptepage);
> > +                               spin_unlock(src_ptl);
> > +                               spin_unlock(dst_ptl);
> > +                               prealloc = NULL;
> > +                               continue;
> > +                       }
> 
> Can you move the comment above the code?

Sure.

> And I _think_ the prealloc conditional could be split up to a helper function
> (which would help more), but maybe there are too many variables for that to
> be practical.

It's just that comparing to pte case where we introduced page_copy_prealloc(),
we've already got a very nice helper alloc_huge_page() for that for e.g. cgroup
charging and so on, so it seems already clean enough to use it.

The only difference comparing to the pte case is I moved the reset of
"prealloc" to be out of the copy function since we never fail after all, to
avoid passing a struct page** double pointer.

Would below look better (only comment change)?

---------------8<------------------
@@ -3816,6 +3832,39 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
                        }
                        set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
                } else {
+                       entry = huge_ptep_get(src_pte);
+                       ptepage = pte_page(entry);
+                       get_page(ptepage);
+
+                       /*
+                        * This is a rare case where we see pinned hugetlb
+                        * pages while they're prone to COW.  We need to do the
+                        * COW earlier during fork.
+                        *
+                        * When pre-allocating the page we need to be without
+                        * all the locks since we could sleep when allocate.
+                        */
+                       if (unlikely(page_needs_cow_for_dma(vma, ptepage))) {
+                               if (!prealloc) {
+                                       put_page(ptepage);
+                                       spin_unlock(src_ptl);
+                                       spin_unlock(dst_ptl);
+                                       prealloc = alloc_huge_page(vma, addr, 0);
+                                       if (!prealloc) {
+                                               ret = -ENOMEM;
+                                               break;
+                                       }
+                                       goto again;
+                               }
+                               hugetlb_copy_page(vma, dst_pte, addr, ptepage,
+                                                 prealloc);
+                               put_page(ptepage);
+                               spin_unlock(src_ptl);
+                               spin_unlock(dst_ptl);
+                               prealloc = NULL;
+                               continue;
+                       }
+
---------------8<------------------

Thanks,

-- 
Peter Xu

