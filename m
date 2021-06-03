Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E736C39A3AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 16:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhFCOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 10:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230517AbhFCOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 10:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622731890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/JjgwFwgty+wYAd/TLY0hKsG0HookeJ8kkNgd0KRSnY=;
        b=X4mGdQIV0W1KUSf+tog5OXxvE3ma3sxLSZ/ZaRyVuYM1tr0bNilD0ZfxLU/7X9MKErQy4Y
        ogtjhNYzqR9DupIG49N2HkSmTXOPg1FKwXhYPK03bJ/zejEr8lXjTz+g7SYhCE0jbal+oq
        rhmAyG/2i73/nIYKTuz3C0m6b+IrXL0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-YOBKG7wwMkK50fb4i8l7tg-1; Thu, 03 Jun 2021 10:51:22 -0400
X-MC-Unique: YOBKG7wwMkK50fb4i8l7tg-1
Received: by mail-qt1-f197.google.com with SMTP id z9-20020a05622a0609b02901f30a4fcf9bso3219168qta.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 07:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/JjgwFwgty+wYAd/TLY0hKsG0HookeJ8kkNgd0KRSnY=;
        b=LNU5plmLtcScV8h4SspofbRudmoblyGfbz3gdU4mRxVruNZf7k9RNS+34P3q70FUzZ
         CpanbK2A+l0dZCRULtdoFg8ZAgfy4jfvBu+uoWJJat2WTnT4ZL8L07OeWaP75htY+kL9
         DR20nq7vJ9anSExrWaKo15SI0zTq77GCyfUAk1SmrbIU2k5oGLQE7ZFSVha2eAa8ev7R
         OtC/wDGXbI/EcCguqMAycNwLVDFpT4n4ldh9cbnuGGHzu9h1xHAE7Qb9+9i9OFp2nj0o
         RaWHkJGPlVmNH/2p2HRtv60LSNIjOV+uWEWpypJ+ynw/6tj4HjWoAIj7lmmt1GP2ug53
         8vvw==
X-Gm-Message-State: AOAM530467ZzGWAeYYKyHm6tSPdDNgM7zSc0N9cUJLZXyoEHs05xg0/t
        LFtT9d6byW4pE/ijvIHW4uTYti3WpXHuWchnXU6hLvcOSIYWiUWvmerkvUSz6OH3r1b7slGrD1Q
        X2Dl8uQs9C9C0VOU9jtrxRqbu
X-Received: by 2002:ac8:5315:: with SMTP id t21mr278782qtn.180.1622731882366;
        Thu, 03 Jun 2021 07:51:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZjzyXrgNjkDGMNnlrVXA18VUx+lYgw3Yq3/AzYYZJgnMoemc9xdQbWqvswJ10U6mETTLfhg==
X-Received: by 2002:ac8:5315:: with SMTP id t21mr278757qtn.180.1622731882132;
        Thu, 03 Jun 2021 07:51:22 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-61-184-147-118-108.dsl.bell.ca. [184.147.118.108])
        by smtp.gmail.com with ESMTPSA id n194sm2078914qka.66.2021.06.03.07.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 07:51:21 -0700 (PDT)
Date:   Thu, 3 Jun 2021 10:51:19 -0400
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
Message-ID: <YLjsZ4PVQcx0/vb8@t490s>
References: <20210527201927.29586-1-peterx@redhat.com>
 <4422901.rTkcW5k3cD@nvdebian>
 <YLDoYusJ9wAeahdZ@t490s>
 <4688876.HeLTNyGTSD@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4688876.HeLTNyGTSD@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 09:53:45PM +1000, Alistair Popple wrote:
> On Friday, 28 May 2021 10:56:02 PM AEST Peter Xu wrote:
> > On Fri, May 28, 2021 at 06:32:52PM +1000, Alistair Popple wrote:
> > > On Friday, 28 May 2021 6:19:04 AM AEST Peter Xu wrote:
> > > > This patch introduces a very special swap-like pte for file-backed
> > > > memories.
> > > > 
> > > > Currently it's only defined for x86_64 only, but as long as any arch
> > > > that
> > > > can properly define the UFFD_WP_SWP_PTE_SPECIAL value as requested, it
> > > > should conceptually work too.
> > > > 
> > > > We will use this special pte to arm the ptes that got either unmapped or
> > > > swapped out for a file-backed region that was previously wr-protected. 
> > > > This special pte could trigger a page fault just like swap entries, and
> > > > as long as the page fault will satisfy pte_none()==false &&
> > > > pte_present()==false.
> > > > 
> > > > Then we can revive the special pte into a normal pte backed by the page
> > > > cache.
> > > > 
> > > > This idea is greatly inspired by Hugh and Andrea in the discussion,
> > > > which is referenced in the links below.
> > > > 
> > > > The other idea (from Hugh) is that we use swp_type==1 and swp_offset=0
> > > > as
> > > > the special pte.  The current solution (as pointed out by Andrea) is
> > > > slightly preferred in that we don't even need swp_entry_t knowledge at
> > > > all
> > > > in trapping these accesses.  Meanwhile, we also reuse _PAGE_SWP_UFFD_WP
> > > > from the anonymous swp entries.
> > > 
> > > So to confirm my understanding the reason you use this special swap pte
> > > instead of a new swp_type is that you only need the fault and have no
> > > extra
> > > information that needs storing in the pte?
> > 
> > Yes.
> > 
> > > Personally I think it might be better to define a new swp_type for this
> > > rather than introducing a new arch-specific concept.
> > 
> > The concept should not be arch-specific, it's the pte that's arch-specific.
> 
> Right, agree this is a minor detail.

I can't say it's a minor detail, as that's still indeed one of the major ideas
that I'd like to get comment for within the whole series.  It's currently an
outcome from previous discussion with Andrea and Hugh, but of course if there's
better idea with reasoning I can always consider to rework the series.

>  
> > > swp_type entries are portable so wouldn't need extra arch-specific bits
> > > defined. And as I understand things not all architectures (eg. ARM) have
> > > spare bits in their swap entry encoding anyway so would have to reserve a
> > > bit specifically for this which would be less efficient than using a
> > > swp_type.
> > It looks a trade-off to me: I think it's fine to use swap type in my series,
> > as you said it's portable, but it will also waste the swap address space
> > for the arch when the arch enables it.
> > 
> > The format of the special pte to trigger the fault in this series should be
> > only a small portion of the code change.  The main logic should still be the
> > same - we just replace this pte with that one.  IMHO it also means the
> > format can be changed in the future, it's just that I don't know whether
> > it's wise to take over a new swap type from start.
> >
> > > Anyway it seems I missed the initial discussion so don't have a strong
> > > opinion here, mainly just wanted to check my understanding of what's
> > > required and how these special entries work.
> > 
> > Thanks for mentioning this and join the discussion. I don't know ARM enough
> > so good to know we may have issue on finding the bits.  Actually before
> > finding this bit for file-backed uffd-wp specifically, we need to firstly
> > find a bit in the normal pte for ARM too anyways (see _PAGE_UFFD_WP).  If
> > there's no strong reason to switch to a new swap type, I'd tend to leave
> > all these to the future when we enable them on ARM.
> 
> Yeah, makes sense to me. As you say it should be easy to change and other 
> architectures need to find another bit anyway. Not sure how useful it will be 
> but I'll try and take a look over the rest of the series as well.

I'll highly appreciate that.  Thanks Alistair!

-- 
Peter Xu

