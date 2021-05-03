Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E157237226E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 23:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhECVcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 17:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23924 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhECVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 17:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620077481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n64fW+FUSe4kv3w/HKCwW5Xq4SBkoiGn+eJ75KrpHrE=;
        b=MYw06eI1Rs/s8+BEyd3OluGoOt46AtbmgkOrgrolDsuY3xKyMlDEpFNqSusdz8WTcYvpg/
        /EB11HrNiUD5VIdvpf57l0AvYAeOWqYSYnh8O5Wz2s+Hwxew4pPljATBVFHTF1DfAppPUv
        +QWfgkNCdjIIK3ug29ZCiHVY8sBwQ5Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-A1utHnqgMlG-cV5B9_K53g-1; Mon, 03 May 2021 17:31:18 -0400
X-MC-Unique: A1utHnqgMlG-cV5B9_K53g-1
Received: by mail-qk1-f197.google.com with SMTP id s143-20020a3745950000b029028274263008so6172482qka.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 14:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n64fW+FUSe4kv3w/HKCwW5Xq4SBkoiGn+eJ75KrpHrE=;
        b=KiHBDJdYO/YzYYLx+DLBsVKrMO5yBKeXl3Ewt5bm/bB1d1cWtnAYtXlccRfyV7g+9c
         8Y3BpMdCAP5a+FX+W4DtLWGlgLiGvnO7Oa0ibUPSgi/HM7eDxqMEouWhP5K4ImkaGRsx
         7p5RpLTrEA6lzDAk5wgXyXJiIXhn3zeoLZiYeYnMdpBkgeoVZVj2q++BaKhtuo8Kh9Yr
         qkXJJC/GoI6Rp5uZJfqMONo0UddAUdSw5vJd1iwC95NTur2V6rh7g2DhxPpHwBtc5unV
         NcDyZi2VIzExBLHBZ+MmfSOm9OHoAY3HXuQbqNGD0dMSEIqAGAu5enN0aumGEXodU+hQ
         Uv9w==
X-Gm-Message-State: AOAM531Zw0D6M4A1CaQI2NAbsvkL2r3HkVPQAQI8pIbzDTAd4Fzgkpvm
        JaZI8HrsL6tJoUswQDTSlnWPunhY1iAl9oJZBLGiTZnV7zPdmqF6U60QPleR8ZxmF/w5yNwNtyC
        P1pfWl3jdfpN3ygSgWPLYuPAL
X-Received: by 2002:a0c:8d07:: with SMTP id r7mr21631131qvb.7.1620077477914;
        Mon, 03 May 2021 14:31:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWDipoQVNtGoxUfUyAs44TTWIpMdLrqMTRQZA0DfItr0izkIIJM7y3hOgX0d5FrSQC7vBSeA==
X-Received: by 2002:a0c:8d07:: with SMTP id r7mr21631106qvb.7.1620077477587;
        Mon, 03 May 2021 14:31:17 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id b15sm9388146qkj.95.2021.05.03.14.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 14:31:16 -0700 (PDT)
Date:   Mon, 3 May 2021 17:31:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mjk.linux@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH 1/2] mm/hugetlb: Fix F_SEAL_FUTURE_WRITE
Message-ID: <YJBro5N+1SHkx8D3@t490s>
References: <20210501144110.8784-1-peterx@redhat.com>
 <20210501144110.8784-2-peterx@redhat.com>
 <be33c24e-cf2d-3894-a450-7432fd976802@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be33c24e-cf2d-3894-a450-7432fd976802@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike,

On Mon, May 03, 2021 at 11:55:41AM -0700, Mike Kravetz wrote:
> On 5/1/21 7:41 AM, Peter Xu wrote:
> > F_SEAL_FUTURE_WRITE is missing for hugetlb starting from the first day.
> > There is a test program for that and it fails constantly.
> > 
> > $ ./memfd_test hugetlbfs
> > memfd-hugetlb: CREATE
> > memfd-hugetlb: BASIC
> > memfd-hugetlb: SEAL-WRITE
> > memfd-hugetlb: SEAL-FUTURE-WRITE
> > mmap() didn't fail as expected
> > Aborted (core dumped)
> > 
> > I think it's probably because no one is really running the hugetlbfs test.
> > 
> > Fix it by checking FUTURE_WRITE also in hugetlbfs_file_mmap() as what we do in
> > shmem_mmap().  Generalize a helper for that.
> > 
> > Reported-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/hugetlbfs/inode.c |  5 +++++
> >  include/linux/mm.h   | 32 ++++++++++++++++++++++++++++++++
> >  mm/shmem.c           | 22 ++++------------------
> >  3 files changed, 41 insertions(+), 18 deletions(-)
> 
> Thanks Peter and Hugh!
> 
> One question below,
> 
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index a2a42335e8fd2..39922c0f2fc8c 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -131,10 +131,15 @@ static void huge_pagevec_release(struct pagevec *pvec)
> >  static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> >  	struct inode *inode = file_inode(file);
> > +	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
> >  	loff_t len, vma_len;
> >  	int ret;
> >  	struct hstate *h = hstate_file(file);
> >  
> > +	ret = seal_check_future_write(info->seals, vma);
> > +	if (ret)
> > +		return ret;
> > +
> >  	/*
> >  	 * vma address alignment (but not the pgoff alignment) has
> >  	 * already been checked by prepare_hugepage_range.  If you add
> 
> The full comment below the code you added is:
> 
> 	/*
> 	 * vma address alignment (but not the pgoff alignment) has
> 	 * already been checked by prepare_hugepage_range.  If you add
> 	 * any error returns here, do so after setting VM_HUGETLB, so
> 	 * is_vm_hugetlb_page tests below unmap_region go the right
> 	 * way when do_mmap unwinds (may be important on powerpc
> 	 * and ia64).
> 	 */
> 
> This comment was added in commit 68589bc35303 by Hugh, although it
> appears David Gibson added the reason for the comment in the commit
> message:
> 
> "If hugetlbfs_file_mmap() returns a failure to do_mmap_pgoff() - for example,
> because the given file offset is not hugepage aligned - then do_mmap_pgoff
> will go to the unmap_and_free_vma backout path.
> 
> But at this stage the vma hasn't been marked as hugepage, and the backout path
> will call unmap_region() on it.  That will eventually call down to the
> non-hugepage version of unmap_page_range().  On ppc64, at least, that will
> cause serious problems if there are any existing hugepage pagetable entries in
> the vicinity - for example if there are any other hugepage mappings under the
> same PUD.  unmap_page_range() will trigger a bad_pud() on the hugepage pud
> entries.  I suspect this will also cause bad problems on ia64, though I don't
> have a machine to test it on."
> 
> There are still comments in the unmap code about special handling of
> ppc64 PUDs.  So, this may still be an issue.
> 
> I am trying to dig into the code to determine if this is still and
> issue.  Just curious if you looked into this?  Might be simpler and
> safer to just put the seal check after setting the VM_HUGETLB flag?

Good catch!  I overlooked on that, and I definitely didn't look into it yet.
For now I'd better move that check to be after the flag settings in all cases.

I'll also add:

Fixes: ab3948f58ff84 ("mm/memfd: add an F_SEAL_FUTURE_WRITE seal to memfd")

Thanks,

-- 
Peter Xu

