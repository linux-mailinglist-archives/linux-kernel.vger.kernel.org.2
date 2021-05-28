Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A339430A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhE1M5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 08:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229552AbhE1M5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 08:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622206567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfNmkt8/NcUZNR0qW24m0wKOWRCBjF/g8IalMns/rZM=;
        b=A/QDGOlXKG5tnbxUvvpIxh51PcZhKerQ7LKp33bZAsaU74amslMSoPk5WIAUAvXc+oZD/P
        uzPVJ+ys1GLkpxCHxTWEWwJWOURrxsPCg/frrrV+LwDaG/BjUw5hO+Pvbv7O4JXso7dIdq
        7OVSShAhtw8ud1bLWhpyMhQwdzr46pY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-RKq2dtD6MYmfVO9oGxxHeQ-1; Fri, 28 May 2021 08:56:05 -0400
X-MC-Unique: RKq2dtD6MYmfVO9oGxxHeQ-1
Received: by mail-qv1-f69.google.com with SMTP id k12-20020a0cfd6c0000b029020df9543019so2572890qvs.14
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 05:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfNmkt8/NcUZNR0qW24m0wKOWRCBjF/g8IalMns/rZM=;
        b=fx6tH6P4UxQkt/qZ0I6wZ5de8oHQ+wAIKu6q076Enxllat1Cj/+ZQ6YgwmK5dVXycq
         kmxDKBdrHy9fQt0dy0vaNqPILZOJqKf+s1qmmxqrbSftffYtH8IneqR06Zqnsq4i8z+T
         aJofieOmh/LoMbiHHfGh7or1+uKh/PpONaPNykZPBXM3chehUpYm6iCIGmu8WUKm6922
         v40rbOS231x7yRof/yr5BE1yXfs3y011d/9bRSYrzwuXr1aaRrCVFWQGamKLZs+1azLz
         weMjPCD8Xg4OnXlHOk5t2O2yhVahuO91sePUqe2jm/UiLV7tBeAN9ByE/gixDev7+X1f
         rQOA==
X-Gm-Message-State: AOAM530XE9t0Q/jZQRdsQ3b4Znsd+qsw9vngMDdGTeJ4XwDlj4bF5NWY
        ZisnPkWt4s3mZuG07g+oqW8maeXYYhcJNf1uJUgCMyVxUZQ+TY/IY+UE5fbIt4aZWUtogrMIlpR
        MIzvKN9OBSFKDPUwGFeja4Gvx
X-Received: by 2002:a37:ef06:: with SMTP id j6mr3853652qkk.25.1622206564981;
        Fri, 28 May 2021 05:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1VUv+BI1TcALoEnUxRq6kApiF70FXFYkLNF2YXAc4YQvBKvV7VbhNBzthoBGO153G8YXZMg==
X-Received: by 2002:a37:ef06:: with SMTP id j6mr3853622qkk.25.1622206564661;
        Fri, 28 May 2021 05:56:04 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id x9sm3311843qtf.76.2021.05.28.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:56:03 -0700 (PDT)
Date:   Fri, 28 May 2021 08:56:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3 04/27] mm/userfaultfd: Introduce special pte for
 unmapped file-backed mem
Message-ID: <YLDoYusJ9wAeahdZ@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <20210527201927.29586-5-peterx@redhat.com>
 <4422901.rTkcW5k3cD@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4422901.rTkcW5k3cD@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 06:32:52PM +1000, Alistair Popple wrote:
> On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:
> > This patch introduces a very special swap-like pte for file-backed memories.
> > 
> > Currently it's only defined for x86_64 only, but as long as any arch that
> > can properly define the UFFD_WP_SWP_PTE_SPECIAL value as requested, it
> > should conceptually work too.
> > 
> > We will use this special pte to arm the ptes that got either unmapped or
> > swapped out for a file-backed region that was previously wr-protected.  This
> > special pte could trigger a page fault just like swap entries, and as long
> > as the page fault will satisfy pte_none()==false && pte_present()==false.
> > 
> > Then we can revive the special pte into a normal pte backed by the page
> > cache.
> > 
> > This idea is greatly inspired by Hugh and Andrea in the discussion, which is
> > referenced in the links below.
> > 
> > The other idea (from Hugh) is that we use swp_type==1 and swp_offset=0 as
> > the special pte.  The current solution (as pointed out by Andrea) is
> > slightly preferred in that we don't even need swp_entry_t knowledge at all
> > in trapping these accesses.  Meanwhile, we also reuse _PAGE_SWP_UFFD_WP
> > from the anonymous swp entries.
> 
> So to confirm my understanding the reason you use this special swap pte 
> instead of a new swp_type is that you only need the fault and have no extra 
> information that needs storing in the pte?

Yes.

> 
> Personally I think it might be better to define a new swp_type for this rather 
> than introducing a new arch-specific concept.

The concept should not be arch-specific, it's the pte that's arch-specific.

> swp_type entries are portable so wouldn't need extra arch-specific bits
> defined. And as I understand things not all architectures (eg. ARM) have
> spare bits in their swap entry encoding anyway so would have to reserve a bit
> specifically for this which would be less efficient than using a swp_type.

It looks a trade-off to me: I think it's fine to use swap type in my series, as
you said it's portable, but it will also waste the swap address space for the
arch when the arch enables it.

The format of the special pte to trigger the fault in this series should be
only a small portion of the code change.  The main logic should still be the
same - we just replace this pte with that one.  IMHO it also means the format
can be changed in the future, it's just that I don't know whether it's wise to
take over a new swap type from start.

> 
> Anyway it seems I missed the initial discussion so don't have a strong opinion 
> here, mainly just wanted to check my understanding of what's required and how 
> these special entries work.

Thanks for mentioning this and join the discussion. I don't know ARM enough so
good to know we may have issue on finding the bits.  Actually before finding
this bit for file-backed uffd-wp specifically, we need to firstly find a bit in
the normal pte for ARM too anyways (see _PAGE_UFFD_WP).  If there's no strong
reason to switch to a new swap type, I'd tend to leave all these to the future
when we enable them on ARM.

-- 
Peter Xu

