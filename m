Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9933FE5EB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbhIAXBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 19:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54408 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344583AbhIAXBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 19:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630537210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=560IcZXSiBf9qDG9Tl/mVQRipFa5V94OKcciALLHTxI=;
        b=dRdKgF0PXr2n9Yo+wUzC5EZzHndWxZ24tnom2u1oZLGHSrr4AiAphQfOqIHrEuKUmFvva6
        Yg7GWzORTP4D5Vzj8zG07sL5xWohXI4+oZCve0puAUyFmT6w3SVylGrxXL/xer0F1dEFVG
        /vIX+OvMlcx5jh36egVoDJxn3YNyE6k=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-OJPd9Zv5M-anyc8r0mPoBA-1; Wed, 01 Sep 2021 19:00:09 -0400
X-MC-Unique: OJPd9Zv5M-anyc8r0mPoBA-1
Received: by mail-qk1-f199.google.com with SMTP id 62-20020a3706410000b02903d2cdd9acf0so7054qkg.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 16:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=560IcZXSiBf9qDG9Tl/mVQRipFa5V94OKcciALLHTxI=;
        b=KsgbRUSaSbX8RXXqFf98Hk4kNvIyCxMQMeO7T+cF8nuVnFw1pspJt5MXDFCDwGRshh
         /omGX0quP4Rc3y152iX6fM/JQGo9vNXuAJWswqJTzaF43t+rAbwQoXt8LV1Y32wbVkib
         CAcNN2wHzcsyI4PYxekV7mcSp7r2XrW/k0ZyMX6ooMtd04t09m0oKDqGHGCe0cWEM+Xf
         Oexd4uw1cna/GUU1CMuub0cnAruYFbxJxiNsDKXQU+qknSSsRIoC2Kr/GboZgMfvFKMJ
         5Qwb4d/sTGfB66/mLJHTP/xefb32dFv1IDw5TUVfe2XgGx+36RKnuCk1huzX0IGFomsV
         HH1A==
X-Gm-Message-State: AOAM531T8j1kaD+RN883mCDqA0aowrLOJQopUah7cdmG4Yhn9NzB/A7t
        QuopYI9d4KKRUC7Gxw81V+eQQvyqNQ+8bi+hkzAKSVIh8kpPpRO0cBjGfYW7VzscMPzlAkb1DDQ
        2u5t2JvSTDe2mKq6NHLxdoacE
X-Received: by 2002:ac8:6ec9:: with SMTP id f9mr202357qtv.2.1630537208441;
        Wed, 01 Sep 2021 16:00:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbz8PSQQW0BjBZE+Ytxvd/XDrQximTXqbhGRrX8eSbVjhoHPq5Tgw6KPxDY7cuY+yd6RRDSA==
X-Received: by 2002:ac8:6ec9:: with SMTP id f9mr202327qtv.2.1630537208115;
        Wed, 01 Sep 2021 16:00:08 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id g8sm74883qkm.25.2021.09.01.16.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 16:00:07 -0700 (PDT)
Date:   Wed, 1 Sep 2021 19:00:05 -0400
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
Message-ID: <YTAF9VptGceZ1bVr@t490s>
References: <20210901205622.6935-1-peterx@redhat.com>
 <20210901205622.6935-2-peterx@redhat.com>
 <CAJHvVchpEGvgLGpH7NrSUKLbuur55x+YEm_5y_y0YT7H9yYrng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVchpEGvgLGpH7NrSUKLbuur55x+YEm_5y_y0YT7H9yYrng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Axel,

On Wed, Sep 01, 2021 at 02:48:53PM -0700, Axel Rasmussen wrote:
> On Wed, Sep 1, 2021 at 1:56 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > It was conditionally done previously, as there's one shmem special case that we
> > use SetPageDirty() instead.  However that's not necessary and it should be
> > easier and cleaner to do it unconditionally in mfill_atomic_install_pte().
> >
> > The most recent discussion about this is here, where Hugh explained the history
> > of SetPageDirty() and why it's possible that it's not required at all:
> >
> > https://lore.kernel.org/lkml/alpine.LSU.2.11.2104121657050.1097@eggly.anvils/
> 
> Thanks for the cleanup Peter!

No problem.  Obviously that special handling of SetPageDirty is still too
tricky to me and I'd love to remove it.

> 
> I think the discussion of whether or not the data can be marked dirty
> below is correct, and the code change looks good as well. But, I think
> we're missing an explanation why Hugh's concern is indeed not a
> problem?
> 
> Specifically, this question:
> 
> "Haha: I think Andrea is referring to exactly the dirty_accountable
> code in change_pte_protection() which worried me above. Now, I think
> that will turn out okay (shmem does not have a page_mkwrite(), and
> does not participate in dirty accounting), but you will have to do
> some work to assure us all of that, before sending in a cleanup
> patch."
> 
> Do we have more evidence that this is indeed fine, vs. what we had
> when discussing this before? If so, we should talk about it explicitly
> in this commit message, I think.
> 
> (Sorry if you've covered this and it's just going over my head. ;) )

Thanks for looking into this.

I thought Hugh's explanation should mostly have covered that.  The previous
worry is we may have mprotect() applying write bit errornously if we have some
read-only pte marked dirty.  But I don't think that'll happen just like Hugh
stated in the thread I attached, as the dirty accountable flag is only set if
vma_wants_writenotify() returns true.

Take the first example within that helper:

	if ((vm_flags & (VM_WRITE|VM_SHARED)) != ((VM_WRITE|VM_SHARED)))
		return 0;

So firstly it never applies to vma that doesn't have VM_WRITE|VM_SHARED. So far
it even doesn't work for anonymous, but logically it may, like:

https://github.com/aagit/aa/commit/05dc2c56ef79b3836c75fcf68c5b19b08f4e4c58

Peter Collingbourne originated that patch, due to some reason it didn't land
which I forgot, however I still think it's doable even for anonymous.

Sorry to have gone off-topic; let me go back to it.

It also checks for e.g. page_mkwrite() needs, soft dirty tracking and so on to
make sure it's okay to grant write bit when possible.

Hugh mentioned "do some work to assure us all of that" - I did firstly went
throught the code carefully myself so I'm more certain it's doing the right
thing to me, secondly I did run quite some tests on the patch (actually on the
whole uffd-wp shmem+hugetlbfs branch).  Even if I'm going to switch the uffd-wp
series to the pte marker format, this patch won't change.

I also analysized three callers that may be affected by this change below, and
explaining why it's okay.  I hope that can also be counted as part of the "some
work" that Hugh asked.

Besides all these, I'm pretty happy too if anyone would help me to tell
otherwise on whether there's still things missing so we can't do this.  That's
the "code review" part for every single patch, including this one, isn't it? :)

Thanks,

> 
> >
> >
> >
> > Currently mfill_atomic_install_pte() has three callers:
> >
> >         1. shmem_mfill_atomic_pte
> >         2. mcopy_atomic_pte
> >         3. mcontinue_atomic_pte
> >
> > After the change: case (1) should have its SetPageDirty replaced by the dirty
> > bit on pte (so we unify them together, finally), case (2) should have no
> > functional change at all as it has page_in_cache==false, case (3) may add a
> > dirty bit to the pte.  However since case (3) is UFFDIO_CONTINUE for shmem,
> > it's merely 100% sure the page is dirty after all, so should not make a real
> > difference either.

-- 
Peter Xu

