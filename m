Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8092F3D2BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhGVRuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 13:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbhGVRuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 13:50:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626978643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJnRg6RexQrbbpxlDEJWagNuxouahMFP2JB9+XDpj+8=;
        b=GavrnMJ2Y16vGJWRVeqFJ1XyvALJuch6J5oqcScc/4JcSdMBY5QpmpMoILZ2IGCsjUdpo9
        jfAOX54n652RNwKPM3Wi4OdlkQgIk0MWUZZXybCx4iBk+sx7Vk1c19ujj+/07FO23YuKYt
        xomplV2sws7KNdnwmXdo903YX2Vq0tM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-WyWXDASXPg-D1PBQ3NSwTQ-1; Thu, 22 Jul 2021 14:30:42 -0400
X-MC-Unique: WyWXDASXPg-D1PBQ3NSwTQ-1
Received: by mail-qk1-f200.google.com with SMTP id k12-20020a05620a414cb02903b9ade0af31so4145062qko.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 11:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GJnRg6RexQrbbpxlDEJWagNuxouahMFP2JB9+XDpj+8=;
        b=GM7rt1hype0/g/Xz6CN05rHuMmPmNwGvt3YZQvqJoY00fH2ClPFzqGOO2bQoTJkB6y
         jMKjrBoRgs2AMppXd8jUfprZVHrqJ37Lnm6S59/6Bqc/IXjqe4eSp8Fbr2rniGUvo+aY
         EY9bPf6SN0+T8IAn2WOecrjYorLLy+Ak9VxsijzaQ5u1PKZ2LWKk/GNuZuMbO7zUg3dG
         HyBY8ots+FqcK2uchh+S+6CFm5aV/4YIvtQBvI2uzC3MOTgwfStO6a9hD6R3Zff4ZrmU
         9aMXJ4AkUpXRYJ0zA+DJQ+PMve43PZaXCVPKd+MJVb8sYpEVCk40XPN5hW0eTwDjjTQ5
         Pxlg==
X-Gm-Message-State: AOAM532F+athm/T0dFXyxBnZ97U9nfjLLwGymiWd+L1NzDzCjxypc2/j
        2qwf4I5ZpfvjOzwxxsJAzSuMaH1Qif/pY4XsbwcYeHwfU+KyS3/OTykdNkNMBd+ppIcGQt7yE8E
        AuBPaHcNmltOiVWVrCF0jo0ts
X-Received: by 2002:a05:6214:3004:: with SMTP id ke4mr1294281qvb.52.1626978641765;
        Thu, 22 Jul 2021 11:30:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxygV8ytkh+nSrGukKh74fabSktHwOrX1sxkgxPIt6G6Cegb9r0OTiPFxzZ37aDJM1h9qY0kQ==
X-Received: by 2002:a05:6214:3004:: with SMTP id ke4mr1294251qvb.52.1626978641483;
        Thu, 22 Jul 2021 11:30:41 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id u3sm10808922qtg.16.2021.07.22.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 11:30:40 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:30:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH v5 00/26] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <YPm5TyPq9CjR5lCy@t490s>
References: <20210715201422.211004-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 04:13:56PM -0400, Peter Xu wrote:
> About Swap Special PTE
> ======================

I've got some more feedback regarding this series, either within review comment
or from other threads.

Hugh shared his concern on using such type of pte level operation could make
things even worse:

https://lore.kernel.org/linux-mm/796cbb7-5a1c-1ba0-dde5-479aba8224f2@google.com/

Since most context is irrelevant, only quotting the p.s. section:

  p.s. Peter, unrelated to this particular bug, and should not divert from
  fixing it: but looking again at those swap encodings, and particularly the
  soft_dirty manipulations: they look very fragile. I think uffd_wp was wrong
  to follow that bad example, and your upcoming new encoding (that I have
  previously called elegant) takes it a worse step further.

Alistair shared his preference on keep using swp_entry to store these extra
information:

https://lore.kernel.org/linux-mm/5071185.SEdLSG93TQ@nvdebian/

So I'm trying to do some self introspection to see maybe I was just too bold to
try introducing that pte idea, either I'm not the "suitable one" to introduce
it as it's indeed challenging, or maybe it's as simple as we don't really need
to worry using up swap address space yet, at least for now (currently worst
case MAX_SWAPFILES=32-4-2-1=25).

I don't yet have plan to think about Hugh's idea on further dropping the usage
of per-arch bits in swap ptes, e.g. _PAGE_SWP_SOFT_DIRTY or _PAGE_SWP_UFFD_WP.
I need more thoughts there.  But what I can still do is think about whether we
can still go back to swap entry ptes for this series.

Originally I was afraid of wasting a whole type of swp entry just for one
single pte, so we came up with the idea (thanks again for Andrea and Hugh on
proposing and discussions around it!).  But did we just worry too much on that
while it comes from nothing?

So as time passes, there're indeed some more similar requirements coming that
has issues that look like what uffd-wp file-backed wanted to solve on pagemap,
they're:

  - PM_SWAP info missing when shmem page swapped out
  - PM_SOFT_DIRTY lost when shmem page swapped out

The 1st issue might be solved by other way and there're still discussed here:

https://lore.kernel.org/linux-mm/YPmX7ZyDFRCuLXrh@t490s/

I don't see a good way to solve the 2nd issue (if we would like to solve it
first, though; I don't know whether that's intended to not be fixed for some
reason), if without similar solution like what we will like to apply to
maintain the uffd-wp bit, because they're all potentially issues around
persisting pte information for file-backed memories.

These requirements at least show that even if we introduce a new swp type
(maybe let's just call it SWP_PTE_MARKER) then uffd-wp won't be the only user,
so there're already potential users of more bit out of the entry.

In summary, I'm considering whether I should switch the special swap pte idea
back to the swp entry idea (safer, according to Hugh, also arch-independent,
according to Alistair).  Before working on that, any early comment would be
greatly welcomed.

Thanks.

-- 
Peter Xu

