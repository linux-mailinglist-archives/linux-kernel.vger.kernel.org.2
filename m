Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8F315BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhBJAu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233202AbhBIWGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612908277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYA2lzjucFPzbA9Ee90dKrm+lNMdDDs9+GspopiTkfM=;
        b=RY93SW9P4v0+54k0e8TbeLOf5LKGs++Zn1HENzhILP9uUum8sOsoCmxl0Iy3TEWa8HByLf
        ea6t/tvMzgFqrv4qRnnjhSoK2bcL0lMqr/A86G2cCzln5AztzrkD58spto5LdN//0p5iN2
        w9jieO7aiPVXnU34+RGbz7wNmv1QiPc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-Ow09sEroPOGO3vnadh1p4g-1; Tue, 09 Feb 2021 17:01:00 -0500
X-MC-Unique: Ow09sEroPOGO3vnadh1p4g-1
Received: by mail-qk1-f197.google.com with SMTP id t184so9822617qkc.19
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 14:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYA2lzjucFPzbA9Ee90dKrm+lNMdDDs9+GspopiTkfM=;
        b=GfspBoxZPfTSEu2KTR5ApKyflDoj2YU6275ZJLKrTOz+E1B7rs/g5OBf5r8/PZUcrG
         dDN/YRcUxwI1AyhpwTj3bBk3zu62MNKcx0ihJ+rOnQVjgGDnUXNkqp5YbZl8ZrgfGG1h
         WGfSUAarn/yaK9O05gFjakQTa1wwrkUACDFEjrVXxmUeM3+zj9Rwfs9xHNf2wm4RlHdi
         9W8L7FJmVRydQ3F7vNTYzED6OtkCrW6FvrVEq5HtJSokc2X4EkZRMLcy4HF38rdGTKsO
         yE0oD3B0eHIkwOSVt5xYaaADzwxJRY+XOAsiGt82/YGOD5KQZC77eWrvyeIscwtvx8sr
         tHUQ==
X-Gm-Message-State: AOAM530UTuiG1JRDkHmZ6j+nJHMyYSBQCVGnJxGsLRKdCKXlec1YkNEp
        jjZuX7IdRlg81C0jqGRjwuCefiFUiinoGNocUmX/vw2LUOo+4ECrjfn2S/RWQBUGsCsx1x/r4OV
        EJe9sT4RH4uRwWxPDanQ5DAHO
X-Received: by 2002:a0c:fd64:: with SMTP id k4mr23199138qvs.3.1612908059082;
        Tue, 09 Feb 2021 14:00:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyODVUhkZ0D/FcCVYPrcdLpBq1QCMhWW6Jh+y/z7047FCb4TOzpP+ovlH411+WardRc056V1Q==
X-Received: by 2002:a0c:fd64:: with SMTP id k4mr23199101qvs.3.1612908058747;
        Tue, 09 Feb 2021 14:00:58 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id v145sm45655qka.27.2021.02.09.14.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 14:00:58 -0800 (PST)
Date:   Tue, 9 Feb 2021 17:00:56 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH RFC 00/30] userfaultfd-wp: Support shmem and hugetlbfs
Message-ID: <20210209220056.GD103365@xz-x1>
References: <20210115170907.24498-1-peterx@redhat.com>
 <20210129224938.GC260413@xz-x1>
 <339d27e8-9f34-3e80-2910-46f46d58e9a6@oracle.com>
 <20210206023627.GD3195@xz-x1>
 <201f2636-1193-2cc1-ccee-a91243f14666@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201f2636-1193-2cc1-ccee-a91243f14666@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:29:56AM -0800, Mike Kravetz wrote:
> On 2/5/21 6:36 PM, Peter Xu wrote:
> > On Fri, Feb 05, 2021 at 01:53:34PM -0800, Mike Kravetz wrote:
> >> On 1/29/21 2:49 PM, Peter Xu wrote:
> >>> On Fri, Jan 15, 2021 at 12:08:37PM -0500, Peter Xu wrote:
> >>>> This is a RFC series to support userfaultfd upon shmem and hugetlbfs.
> >> ...
> >>> Huge & Mike,
> >>>
> >>> Would any of you have comment/concerns on the high-level design of this series?
> >>>
> >>> It would be great to know it, especially major objection, before move on to an
> >>> non-rfc version.
> >>
> >> My apologies for not looking at this sooner.  Even now, I have only taken
> >> a very brief look at the hugetlbfs patches.
> >>
> >> Coincidentally, I am working on the 'BUG' that soft dirty does not work for
> >> hugetlbfs.  As you can imagine, there is some overlap in handling of wp ptes
> >> set for soft dirty.  In addition, pmd sharing must be disabled for soft dirty
> >> as here and in Axel's uffd minor fault code.
> > 
> > Interesting to know that we'll reach and need something common from different
> > directions, especially when they all mostly happen at the same time. :)
> > 
> > Is there a real "BUG" that you mentioned?  I'd be glad to read about it if
> > there is a link or something.
> > 
> 
> Sorry, I was referring to a bugzilla bug not a BUG().  Bottom line is that
> hugetlb was mostly overlooked when soft dirty support was added.  A thread
> mostly from me is at:
> lore.kernel.org/r/999775bf-4204-2bec-7c3d-72d81b4fce30@oracle.com
> I am close to sending out a RFC, but keep getting distracted.

Thanks.  Indeed I see no reason to not have hugetlb supported for soft dirty.
Tracking 1G huge pages could be too coarse and heavy, but 2M at least still
seems reasonable.

> 
> >> No objections to the overall approach based on my quick look.
> > 
> > Thanks for having a look.
> > 
> > So for hugetlb one major thing is indeed about the pmd sharing part, which
> > seems that we've got very good consensus on.
> 
> Yes
> 
> > The other thing that I'd love to get some comment would be a shared topic with
> > shmem in that: for a file-backed memory type, uffd-wp needs a consolidated way
> > to record wr-protect information even if the pgtable entries were flushed.
> > That comes from a fundamental difference between anonymous and file-backed
> > memory in that anonymous pages keep all info in the pgtable entry, but
> > file-backed memory is not, e.g., pgtable entries can be dropped at any time as
> > long as page cache is there.
> 
> Sorry, but I can not recall this difference for hugetlb pages.  What operations
> lead to flushing of pagetable entries?  It would need to be something other
> than unmap as it seems we want to lose the information in unmap IIUC.

For hugetlbfs I know two cases.

One is exactly huge pmd sharing as mentioned above, where we'll drop the
pgtable entries for a specific process but the page cache will still exist.

The other one is hugetlbfs_punch_hole(), where hugetlb_vmdelete_list() called
before remove_inode_hugepages().  For uffd-wp, there will be a very small
window that a wr-protected huge page can be written before the page is finally
dropped in remove_inode_hugepages() but after pgtable entry flushed.  In some
apps that could cause data loss.

> 
> > I goes to look at soft-dirty then regarding this issue, and there's actually a
> > paragraph about it:
> > 
> >         While in most cases tracking memory changes by #PF-s is more than enough
> >         there is still a scenario when we can lose soft dirty bits -- a task
> >         unmaps a previously mapped memory region and then maps a new one at
> >         exactly the same place. When unmap is called, the kernel internally
> >         clears PTE values including soft dirty bits. To notify user space
> >         application about such memory region renewal the kernel always marks
> >         new memory regions (and expanded regions) as soft dirty.
> > 
> > I feel like it just means soft-dirty currently allows false positives: we could
> > have set the soft dirty bit even if the page is clean.  And that's what this
> > series wanted to avoid: it used the new concept called "swap special pte" to
> > persistent that information even for file-backed memory.  That all goes for
> > avoiding those false positives.
> 
> Yes, I have seen this with soft dirty.  It really does not seem right.  When
> you first create a mapping, even before faulting in anything the vma is marked
> VM_SOFTDIRTY and from the user's perspective all addresses/pages appear dirty.

Right that seems not optimal.  It is understandable since dirty info is indeed
tolerant to false positives, so soft-dirty avoided this issue as uffd-wp wanted
to solve in this series.  It would be great to know if current approach in this
series would work for us to remove those false positives.

> 
> To be honest, I am not sure you want to try and carry per-process/per-mapping
> wp information in the file.

What this series does is trying to persist that information in pgtable entries,
rather than in the file (or page cache).  Frankly I can't say whether that's
optimal either, so I'm always open to any comment.  So far I think it's a valid
solution, but it could always be possible that I missed something important.

> In the comment about soft dirty above, it seems
> reasonable that unmapping would clear all soft dirty information.  Also,
> unmapping would clear any uffd state/information.

Right, unmap should always means "dropping all information in the ptes".  It's
in below patch that we tried to treat it differently:

https://github.com/xzpeter/linux/commit/e958e9ee8d33e9a6602f93cdbe24a0c3614ab5e2

A quick summary of above patch: only if we unmap or truncate the hugetlbfs
file, would we call hugetlb_vmdelete_list() with ZAP_FLAG_DROP_FILE_UFFD_WP
(which means we'll drop all the information, including uffd-wp bit).

Thanks,

-- 
Peter Xu

