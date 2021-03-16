Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7984C33DE83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCPUSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229764AbhCPURi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615925858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rAH+Y0PqchePCmc63qPqb547JnFTHPCLfyKXcC3d+MU=;
        b=QEXTS8xwQjYR49TzGa9ihGPvbR45txmXqgQTzd0es+fRmhNzlVyhyaRQJnxvJUBauEyQAu
        BNekiVkzf/1XRHhDfPjGyiJ+AOpCeFYExxHECpjoFSAGNPRVPCeDv/ZER+qMeSR7NG8ME7
        JRk7Fz6Kt4JzID6UtERDgHcPlKLnzBw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-vKPUfW4YNve60ByQ4lZjvA-1; Tue, 16 Mar 2021 16:17:36 -0400
X-MC-Unique: vKPUfW4YNve60ByQ4lZjvA-1
Received: by mail-qv1-f69.google.com with SMTP id d15so26029262qvn.16
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:17:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rAH+Y0PqchePCmc63qPqb547JnFTHPCLfyKXcC3d+MU=;
        b=ePcYE6MEs8Se2MgUEKCvZ5F5V8l3yi0D5LhEtqVYyBaByZ0J8HvXZ7Lc7xXXPV671v
         Ac+ysnebjXF/OtSR+cvMdBPVmyuT8TSCMVJR55aPyauYQCnj0prvm+vJbS9RRYumADFG
         GzMv24wjW6lDGGTV31WcGxSwS4HMhNF+wpdJ71zBipf2kcuzHn13z+NpSNCICd+MJheF
         ees2rK3fFrCghtFYL4eNNiOyKklljkPWIlLs5hALa/uAYl8tmoKKpHUvo6gUftFI3qe6
         VMVkZt4Lr77dsEYzBCtsNAsduZ/KIFLb2gMZ77PchXcK6UtXEpyEzrsIzqpryyI7VHof
         4ddA==
X-Gm-Message-State: AOAM533H0nfJ0BWBCDpCOtkwizKWBD3rlTuKtVTmLeq1/Oy8qzBBfejT
        6o6mm2zI9fy6m1C6H3/XRObWTf7mraC+GsjKXDsnrkjiEw9locIHdcsHQEbooHqpCO3PZdXoC42
        P1TuqYzr8BE9pK6ZGV9JlJQqU
X-Received: by 2002:a05:620a:78b:: with SMTP id 11mr925517qka.0.1615925855682;
        Tue, 16 Mar 2021 13:17:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxg/+/oLCGxaXXk4ILJXSHUGW/63RO3FZxkH6WXEukwCWHHZ1LfWTUVa14nD3PSw3iQ+bTtRw==
X-Received: by 2002:a05:620a:78b:: with SMTP id 11mr925478qka.0.1615925855357;
        Tue, 16 Mar 2021 13:17:35 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id k4sm16119463qke.13.2021.03.16.13.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:17:34 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:17:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Brian Geffon <bgeffon@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Subject: Re: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
Message-ID: <20210316201732.GD395976@xz-x1>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <alpine.LSU.2.11.2103131934290.18112@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2103131934290.18112@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 08:19:38PM -0800, Hugh Dickins wrote:
> On Wed, 3 Mar 2021, Brian Geffon wrote:
> 
> > Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This change
> > will widen the support to include shmem mappings. The primary use case
> > is to support MREMAP_DONTUNMAP on mappings which may have been created from
> > a memfd.
> > 
> > Lokesh Gidra who works on the Android JVM, provided an explanation of how such
> > a feature will improve Android JVM garbage collection:
> > "Android is developing a new garbage collector (GC), based on userfaultfd. The
> > garbage collector will use userfaultfd (uffd) on the java heap during compaction.
> > On accessing any uncompacted page, the application threads will find it missing,
> > at which point the thread will create the compacted page and then use UFFDIO_COPY
> > ioctl to get it mapped and then resume execution. Before starting this compaction,
> > in a stop-the-world pause the heap will be mremap(MREMAP_DONTUNMAP) so that the
> > java heap is ready to receive UFFD_EVENT_PAGEFAULT events after resuming execution.
> > 
> > To speedup mremap operations, pagetable movement was optimized by moving PUD entries
> > instead of PTE entries [1]. It was necessary as mremap of even modest sized memory
> > ranges also took several milliseconds, and stopping the application for that long
> > isn't acceptable in response-time sensitive cases. With UFFDIO_CONTINUE feature [2],
> > it will be even more efficient to implement this GC, particularly the 'non-moveable'
> > portions of the heap. It will also help in reducing the need to copy (UFFDIO_COPY)
> > the pages. However, for this to work, the java heap has to be on a 'shared' vma.
> > Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this patch will
> > enable using UFFDIO_CONTINUE for the new userfaultfd-based heap compaction."
> > 
> > [1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
> > [2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/
> > ---
> >  mm/mremap.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index ec8f840399ed..6934d199da54 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -653,8 +653,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> >  		return ERR_PTR(-EINVAL);
> >  	}
> >  
> > -	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> > -			vma->vm_flags & VM_SHARED))
> > +	if (flags & MREMAP_DONTUNMAP && !(vma_is_anonymous(vma) || vma_is_shmem(vma)))
> >  		return ERR_PTR(-EINVAL);
> >  
> >  	if (is_vm_hugetlb_page(vma))
> > -- 
> 
> Yet something to improve...
> 
> Thanks for extending MREMAP_DONTUNMAP to shmem, but I think this patch
> goes in the wrong direction, complicating when it should be generalizing:
> the mremap syscall is about rearranging the user's virtual address space,
> and is not specific to the underlying anonymous or shmem or file object
> (though so far you have only been interested in anonymous, and now shmem).
> 
> A better patch would say:
>  
> -	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> -			vma->vm_flags & VM_SHARED))
> +	if ((flags & MREMAP_DONTUNMAP) &&
> +	    (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return ERR_PTR(-EINVAL);
> 
> VM_DONTEXPAND is what has long been used on special mappings, to prevent
> surprises from mremap changing the size of the mapping: MREMAP_DONTUNMAP
> introduced a different way of expanding the mapping, so VM_DONTEXPAND
> still seems a reasonable name (I've thrown in VM_PFNMAP there because
> it's in the VM_DONTEXPAND test lower down: for safety I guess, and best
> if both behave the same - though one says -EINVAL and the other -EFAULT).
> 
> With that VM_DONTEXPAND check in, Dmitry's commit cd544fd1dc92
> ("mremap: don't allow MREMAP_DONTUNMAP on special_mappings and aio")
> can still be reverted (as you agreed on 28th December), even though
> vma_is_anonymous() will no longer protect it.
> 
> Was there an mremap(2) man page update for MREMAP_DONTUNMAP?
> Whether or not there was before, it ought to get one now.

I'm curious whether it's okay to expand MREMAP_DONTUNMAP to PFNMAP too..
E.g. vfio maps device MMIO regions with both VM_DONTEXPAND|VM_PFNMAP, to me it
makes sense to allow the userspace to get such MMIO region remapped/duplicated
somewhere else as long as the size won't change.  With the strict check as
above we kill all those possibilities.

Though in that case we'll still need commits like cd544fd1dc92 to protect any
customized ->mremap() when they're not supported.

Thanks,

-- 
Peter Xu

