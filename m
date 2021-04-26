Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE036BB1A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 23:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235327AbhDZVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 17:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234123AbhDZVRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 17:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619471818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEQLnehRjN8mwQ4ES7/Y9NAfh0YJFRvcwj6u1Q6K0CE=;
        b=VZxxt210nkllU7NTi1FMEfN3bnpjKp6GhgM7NbG85sbtYKmoEKYs/4Wt45S7kPnXo0sU09
        rkXxPN88u/QCIZMVTc+C49XGPJief8HR18MKtbs0dlLyh+HIl4QDxQ0Fa2Si5zxQhL9iW3
        nR59JapSq5URL9fhPL8j6SxT8EaqsGg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-p0Ntp5INP0WRD-qV_fxFXQ-1; Mon, 26 Apr 2021 17:16:56 -0400
X-MC-Unique: p0Ntp5INP0WRD-qV_fxFXQ-1
Received: by mail-qv1-f71.google.com with SMTP id l61-20020a0c84430000b02901a9a7e363edso16108122qva.16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 14:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEQLnehRjN8mwQ4ES7/Y9NAfh0YJFRvcwj6u1Q6K0CE=;
        b=jNbouv1WlEtC6tqSzZFhh50yudu3h0Tryvh5m3UfUtwBfe3xr7yXIvwvlEiJvo16bt
         pY8Y/3gLrbS1HURe2Nn6AKj0g1q6DVjbfc1YQUrfJQf/kpbbYPXHYpq9SB1LoG1R0XwC
         3s9u3HWd9PYSSVmqF3s/hnileZSYke3Bk9ugCefHxzKF2PdhxhyvoasBI9jE6ZM07m/z
         bN1ZtlM0+N6wqTc4fh6nq1mw5LBVYX7VN1o1C8JFIlnlJSZ9PhlhS42DL/cSgV5R2K5Z
         nYPCWLtNbKmfEubsp2e5yIU9MeGVPn8Z502I8X4NQxShnLA+HlV7mogOHTTOKev03d+9
         /rAQ==
X-Gm-Message-State: AOAM532rRBZ0TVb8ocOj+vteNklE7gqN7+hU9pwDC12Wwfq4oFubpz6T
        e3LPruA/XvCNxghWiNcq1g6BXp9LjXqmuv+Zj6haGGh0qCyY9yW+xZFvtVV+9Bj18S38P+pnXj6
        5km7IIXiatigHS1zJoZMooXuM
X-Received: by 2002:a37:bc43:: with SMTP id m64mr19667066qkf.186.1619471816219;
        Mon, 26 Apr 2021 14:16:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzaehxDdHdCrW+x0DBANxZND88U+9w+Ju2P10+GFOeHdhA/f1R9jfiU1eywFPsLMLlcX5nAA==
X-Received: by 2002:a37:bc43:: with SMTP id m64mr19667036qkf.186.1619471815840;
        Mon, 26 Apr 2021 14:16:55 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id f7sm12666659qtv.53.2021.04.26.14.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 14:16:54 -0700 (PDT)
Date:   Mon, 26 Apr 2021 17:16:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 21/23] hugetlb/userfaultfd: Only drop uffd-wp special pte
 if required
Message-ID: <20210426211653.GH85002@xz-x1>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005054.35973-1-peterx@redhat.com>
 <02712955-0552-f82a-0ab8-460d63af3519@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02712955-0552-f82a-0ab8-460d63af3519@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:33:08PM -0700, Mike Kravetz wrote:
> On 3/22/21 5:50 PM, Peter Xu wrote:
> > Just like what we've done with shmem uffd-wp special ptes, we shouldn't drop
> > uffd-wp special swap pte for hugetlb too, only if we're going to unmap the
> > whole vma, or we're punching a hole with safe locks held.
> > 
> > For example, remove_inode_hugepages() is safe to drop uffd-wp ptes, because it
> > has taken hugetlb fault mutex so that no concurrent page fault would trigger.
> > While the call to hugetlb_vmdelete_list() in hugetlbfs_punch_hole() is not
> > safe.  That's why the previous call will be with ZAP_FLAG_DROP_FILE_UFFD_WP,
> > while the latter one won't be able to.
> 
> This commit message is a bit confusing, but the hugetlb hole punch code
> path is a bit confusing. :)   How about something like this?
> 
> As with  shmem uffd-wp special ptes, only drop the uffd-wp special swap
> pte if unmapping an entire vma or synchronized such that faults can not
> race with the unmap operation.  This requires passing zap_flags all the
> way to the lowest level hugetlb unmap routine: __unmap_hugepage_range.
> 
> In general, unmap calls originated in hugetlbfs code will pass the
> ZAP_FLAG_DROP_FILE_UFFD_WP flag as synchronization is in place to prevent
> faults.  The exception is hole punch which will first unmap without any
> synchronization.  Later when hole punch actually removes the page from
> the file, it will check to see if there was a subsequent fault and if
> so take the hugetlb fault mutex while unmapping again.  This second
> unmap will pass in ZAP_FLAG_DROP_FILE_UFFD_WP.

Sure, I can replace mine.

Maybe it's because I didn't explain enough on the reasoning so it's confusing.
The core justification of "whether to apply ZAP_FLAG_DROP_FILE_UFFD_WP flag
when unmap a hugetlb range" is (IMHO): we should never reach a state when a
page fault could errornously fault in a page-cache page that was wr-protected
to be writable, even in an extremely short period.  That could happen if
e.g. we pass ZAP_FLAG_DROP_FILE_UFFD_WP in hugetlbfs_punch_hole() when calling
hugetlb_vmdelete_list(), because if a page fault triggers after that call and
before the remove_inode_hugepages() right after it, the page cache can be
mapped writable again in the small window, which can cause data corruption.

> 
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  fs/hugetlbfs/inode.c    | 15 +++++++++------
> >  include/linux/hugetlb.h | 13 ++++++++-----
> >  mm/hugetlb.c            | 27 +++++++++++++++++++++------
> >  mm/memory.c             |  5 ++++-
> >  4 files changed, 42 insertions(+), 18 deletions(-)
> > 
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index d81f52b87bd7..5fe19e801a2b 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -399,7 +399,8 @@ static void remove_huge_page(struct page *page)
> >  }
> >  
> >  static void
> > -hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
> > +hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end,
> > +		      unsigned long zap_flags)
> >  {
> >  	struct vm_area_struct *vma;
> >  
> > @@ -432,7 +433,7 @@ hugetlb_vmdelete_list(struct rb_root_cached *root, pgoff_t start, pgoff_t end)
> >  		}
> >  
> >  		unmap_hugepage_range(vma, vma->vm_start + v_offset, v_end,
> > -									NULL);
> > +				     NULL, zap_flags);
> >  	}
> >  }
> >  
> > @@ -513,7 +514,8 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
> >  				mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >  				hugetlb_vmdelete_list(&mapping->i_mmap,
> >  					index * pages_per_huge_page(h),
> > -					(index + 1) * pages_per_huge_page(h));
> > +					(index + 1) * pages_per_huge_page(h),
> > +					ZAP_FLAG_DROP_FILE_UFFD_WP);
> >  				i_mmap_unlock_write(mapping);
> >  			}
> >  
> > @@ -579,7 +581,8 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
> >  	i_mmap_lock_write(mapping);
> >  	i_size_write(inode, offset);
> >  	if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
> > -		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0);
> > +		hugetlb_vmdelete_list(&mapping->i_mmap, pgoff, 0,
> > +				      ZAP_FLAG_DROP_FILE_UFFD_WP);
> >  	i_mmap_unlock_write(mapping);
> >  	remove_inode_hugepages(inode, offset, LLONG_MAX);
> >  }
> > @@ -612,8 +615,8 @@ static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
> >  		i_mmap_lock_write(mapping);
> >  		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
> >  			hugetlb_vmdelete_list(&mapping->i_mmap,
> > -						hole_start >> PAGE_SHIFT,
> > -						hole_end  >> PAGE_SHIFT);
> > +					      hole_start >> PAGE_SHIFT,
> > +					      hole_end >> PAGE_SHIFT, 0);
> >  		i_mmap_unlock_write(mapping);
> >  		remove_inode_hugepages(inode, hole_start, hole_end);
> >  		inode_unlock(inode);
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index 92710600596e..4047fa042782 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -121,14 +121,15 @@ long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
> >  			 unsigned long *, unsigned long *, long, unsigned int,
> >  			 int *);
> >  void unmap_hugepage_range(struct vm_area_struct *,
> > -			  unsigned long, unsigned long, struct page *);
> > +			  unsigned long, unsigned long, struct page *,
> > +			  unsigned long);
> >  void __unmap_hugepage_range_final(struct mmu_gather *tlb,
> >  			  struct vm_area_struct *vma,
> >  			  unsigned long start, unsigned long end,
> > -			  struct page *ref_page);
> > +			  struct page *ref_page, unsigned long zap_flags);
> >  void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> >  				unsigned long start, unsigned long end,
> > -				struct page *ref_page);
> > +				struct page *ref_page, unsigned long zap_flags);
> 
> Nothing introduced with your patch, but it seems __unmap_hugepage_range_final
> does not need to be in the header and can be static in hugetlb.c.

It seems to be used in unmap_single_vma() of mm/memory.c?

> 
> Everything else looks good,
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Please let me know whether you want my extra paragraph in the commit message,
then I'll coordinate accordingly with the R-b.  Thanks!

-- 
Peter Xu

