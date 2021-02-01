Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217A330B36B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 00:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBAXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 18:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhBAXX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 18:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612221723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JXealjKRFD0r2pq7PhUr7p4RbntHdqXsJgCcMNzSn98=;
        b=W+QnMGnUV5PvvC6swOo7K7BCSyHy84IsAYAkK+abb9Czv0aJFDb1CL7p48RuhojvaqvuiP
        zxw6HMYZ1zDSdKn6AsaQ+qTk3IeD1WOo38XVp5amK0qG+Ruph/0CESCUxZwlp7bm+mFHhq
        9x+LL+LxdAeF1/gICQgif8vGBoRVJz0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-CejP8yOePtScV-qSU-q7hA-1; Mon, 01 Feb 2021 18:22:00 -0500
X-MC-Unique: CejP8yOePtScV-qSU-q7hA-1
Received: by mail-qt1-f198.google.com with SMTP id v13so1813051qtq.18
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 15:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JXealjKRFD0r2pq7PhUr7p4RbntHdqXsJgCcMNzSn98=;
        b=gk34ZDdJ4JyWKAXNH7WNvu+KPxVrax3Dvk8I2FpvGTKY3Ucu/RCDPsLLjHuphqfusn
         O66AOuVkwqztItEOXSJ6ysb5+/ExU+g9pLZs1Pjdo8B5NzmYDZKmQcMGik+V57xMB42Q
         THdh4DBps2b4djt0k5a+zlv/2D07StPepd2GmPJqBShVB9ZTDZNgG5j7B+3+EcqOespd
         axePfBBAcw34BUAgdeI3iQT4lBIOp/YuhHEbC8pb5RG1QZ2OjhpeZ88WHhQQiRp7QzAq
         yKAiSyLJnRk6vG84jlORXNRmVyEDpwTE8bOI2Rpasaz7DeVHM7Mr2UdGOJW+Sv0PVTDJ
         M0jg==
X-Gm-Message-State: AOAM533VVpfwIwTpjZKcqDP784OoCXjYV2tReEorHH51oE05xpu9EUrd
        B/IxEYfwM9lcnb7rhBW+pLXnw8Lt8mRN3Df5vhzTouTlm1YPKUkyHFm8D3GXxlmTiP5VRxR7TVa
        kLXdEiuAl9uIwymlXY2OlmBxi
X-Received: by 2002:a37:a955:: with SMTP id s82mr18552949qke.121.1612221719636;
        Mon, 01 Feb 2021 15:21:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS+3wDmDxJ77Mv8mHl7zqigCXAmGJWxZRWwAqLuTopvy7+5ZDn3Q72W9Q6xnbA4goZHL5uNQ==
X-Received: by 2002:a37:a955:: with SMTP id s82mr18552913qke.121.1612221719336;
        Mon, 01 Feb 2021 15:21:59 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id n24sm14841134qtv.26.2021.02.01.15.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:21:58 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:21:55 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v3 4/9] hugetlb/userfaultfd: Unshare all pmds for
 hugetlbfs when register wp
Message-ID: <20210201232155.GL260413@xz-x1>
References: <20210128224819.2651899-1-axelrasmussen@google.com>
 <20210128224819.2651899-5-axelrasmussen@google.com>
 <bdac0f96-1d6a-6450-c58a-6902d985e3e0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bdac0f96-1d6a-6450-c58a-6902d985e3e0@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 02:33:20PM -0800, Mike Kravetz wrote:
> On 1/28/21 2:48 PM, Axel Rasmussen wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > Huge pmd sharing for hugetlbfs is racy with userfaultfd-wp because
> > userfaultfd-wp is always based on pgtable entries, so they cannot be shared.
> > 
> > Walk the hugetlb range and unshare all such mappings if there is, right before
> > UFFDIO_REGISTER will succeed and return to userspace.
> > 
> > This will pair with want_pmd_share() in hugetlb code so that huge pmd sharing
> > is completely disabled for userfaultfd-wp registered range.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c             | 45 ++++++++++++++++++++++++++++++++++++
> >  include/linux/mmu_notifier.h |  1 +
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 894cc28142e7..2c6706ac2504 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/sched/signal.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/mm.h>
> > +#include <linux/mmu_notifier.h>
> >  #include <linux/poll.h>
> >  #include <linux/slab.h>
> >  #include <linux/seq_file.h>
> > @@ -1190,6 +1191,47 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
> >  	}
> >  }
> >  
> > +/*
> > + * This function will unconditionally remove all the shared pmd pgtable entries
> > + * within the specific vma for a hugetlbfs memory range.
> > + */
> > +static void hugetlb_unshare_all_pmds(struct vm_area_struct *vma)
> > +{
> > +#ifdef CONFIG_HUGETLB_PAGE
> > +	struct hstate *h = hstate_vma(vma);
> > +	unsigned long sz = huge_page_size(h);
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	struct mmu_notifier_range range;
> > +	unsigned long address;
> > +	spinlock_t *ptl;
> > +	pte_t *ptep;
> > +
> 
> Perhaps we should add a quick to see if vma is sharable.  Might be as
> simple as !(vma->vm_flags & VM_MAYSHARE).  I see a comment/question in
> a later patch about only doing minor fault processing on shared mappings.

Yes, that comment was majorly about shmem though - I believe shared case should
still be the major one, especially for hugetlbfs.

So what I was thinking is something like: one non-uffd process use shared
mapping of the file, meanwhile the other uffd process used private mapping on
the same file.  When the uffd process access page it could fault in the page
cache and continued by UFFDIO_CONTINUE, however when it writes it'll COW into
private pages.  Something like that.  Not sure whether it's useful, but I just
don't see why we should block that case.

> 
> Code below looks fine, but it would be a wast to do all that for a vma
> that could not be shared.

Right, still better to check it.

Mike, I agree with all your comments on the initial 4 patches, thanks for the
input!  To make Axel's life easier, I've modified them locally and pushed since
after all I'll do it in my series too (I also picked Mike's r-b on patch 3):

https://github.com/xzpeter/linux/commits/uffd-wp-shmem-hugetlbfs

Axel, feel free to fetch from it directly.

Thanks,

-- 
Peter Xu

