Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5F33A29D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 05:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhCNEUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 23:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhCNETz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 23:19:55 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 20:19:55 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id i25-20020a4aa1190000b02901bbd9429832so2194237ool.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 20:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kixZrJkwNjUoR8zMK2p//jPoJv3zOuB8QGV2eNGzAyA=;
        b=v8QVnTHZHCVWu9EH2kSatOoL53oTW7ZGKHoZ66e5Ivw5EVDSh/cz1sn2AhTU/gUDhW
         RLNjWTnAGGDqNT+aIpfk/crGQH+y69nX1r5+EyH2fMWNvsTSrhIj52eP/3EfwxA9lGB0
         6zL9lGl6a/qCEQ2Gey41NP4+ugxL8UXWFHhVX2v2TmnXcWSD9Znhd0Q8cp3CjjWmoWla
         0kBv5dcqXlhGR9tgfg7d+u86Crv2T2c+xXV90ieVsMHJY44jtHXs5UaRCOQueJYYmqao
         nGgm1Bd83/ZasItTp62QhhY++J/Mx5AeNaQUa26Kms5rOSIg1jblEfgu/n9dUP7fG3dJ
         OIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kixZrJkwNjUoR8zMK2p//jPoJv3zOuB8QGV2eNGzAyA=;
        b=NRKKV+QB7wX6rhQMw5ZMzAOP+DO6OTE4ksXopLiih2k6a009c71AtCINsdqQ7VTUiK
         Jy7UZLQsbu8cv6xifFewJqc9S/tsC4AQ1wbIJP/7bmQphkN50BRSVx3QYozXms6IhFAX
         nBHihzPAS39rb3EZv6MhSVlB2z4jsJdld7EdD5Ei9YfauMX4YTxrSNdhWTEScgiHuxgV
         24S1iuXjM6GuPPfoxm50BRerYAQBtm1ldw7k53Rr66fmwcj0LU0D1btIXMVSLKh5nmws
         MIUY+iIJXV8zeRfwCiVkvd0zb7YYd/CCm2X137NU5PwXOVL5K1Gu1SvXYp93iw/NdrFL
         lokQ==
X-Gm-Message-State: AOAM532nEVekLDagxjA/mPgziWzXSs0zMtw4PaG4YffeJtWphdG/ji0f
        38UfS8X3+GNTsyfMyeXZCTkgAw==
X-Google-Smtp-Source: ABdhPJwcGvDEC+R1bqzuQPSx98+QkM3mYsVg4BQUjFxh2JMgLz9PzOsjvi0InQqiac1WKpfn+f8ybA==
X-Received: by 2002:a4a:45d5:: with SMTP id y204mr8994074ooa.33.1615695594687;
        Sat, 13 Mar 2021 20:19:54 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n22sm4284425oie.32.2021.03.13.20.19.52
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 13 Mar 2021 20:19:54 -0800 (PST)
Date:   Sat, 13 Mar 2021 20:19:38 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Brian Geffon <bgeffon@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
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
In-Reply-To: <20210303175235.3308220-1-bgeffon@google.com>
Message-ID: <alpine.LSU.2.11.2103131934290.18112@eggly.anvils>
References: <20210303175235.3308220-1-bgeffon@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Mar 2021, Brian Geffon wrote:

> Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This change
> will widen the support to include shmem mappings. The primary use case
> is to support MREMAP_DONTUNMAP on mappings which may have been created from
> a memfd.
> 
> Lokesh Gidra who works on the Android JVM, provided an explanation of how such
> a feature will improve Android JVM garbage collection:
> "Android is developing a new garbage collector (GC), based on userfaultfd. The
> garbage collector will use userfaultfd (uffd) on the java heap during compaction.
> On accessing any uncompacted page, the application threads will find it missing,
> at which point the thread will create the compacted page and then use UFFDIO_COPY
> ioctl to get it mapped and then resume execution. Before starting this compaction,
> in a stop-the-world pause the heap will be mremap(MREMAP_DONTUNMAP) so that the
> java heap is ready to receive UFFD_EVENT_PAGEFAULT events after resuming execution.
> 
> To speedup mremap operations, pagetable movement was optimized by moving PUD entries
> instead of PTE entries [1]. It was necessary as mremap of even modest sized memory
> ranges also took several milliseconds, and stopping the application for that long
> isn't acceptable in response-time sensitive cases. With UFFDIO_CONTINUE feature [2],
> it will be even more efficient to implement this GC, particularly the 'non-moveable'
> portions of the heap. It will also help in reducing the need to copy (UFFDIO_COPY)
> the pages. However, for this to work, the java heap has to be on a 'shared' vma.
> Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this patch will
> enable using UFFDIO_CONTINUE for the new userfaultfd-based heap compaction."
> 
> [1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
> [2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/
> ---
>  mm/mremap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ec8f840399ed..6934d199da54 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -653,8 +653,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> -			vma->vm_flags & VM_SHARED))
> +	if (flags & MREMAP_DONTUNMAP && !(vma_is_anonymous(vma) || vma_is_shmem(vma)))
>  		return ERR_PTR(-EINVAL);
>  
>  	if (is_vm_hugetlb_page(vma))
> -- 

Yet something to improve...

Thanks for extending MREMAP_DONTUNMAP to shmem, but I think this patch
goes in the wrong direction, complicating when it should be generalizing:
the mremap syscall is about rearranging the user's virtual address space,
and is not specific to the underlying anonymous or shmem or file object
(though so far you have only been interested in anonymous, and now shmem).

A better patch would say:
 
-	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
-			vma->vm_flags & VM_SHARED))
+	if ((flags & MREMAP_DONTUNMAP) &&
+	    (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return ERR_PTR(-EINVAL);

VM_DONTEXPAND is what has long been used on special mappings, to prevent
surprises from mremap changing the size of the mapping: MREMAP_DONTUNMAP
introduced a different way of expanding the mapping, so VM_DONTEXPAND
still seems a reasonable name (I've thrown in VM_PFNMAP there because
it's in the VM_DONTEXPAND test lower down: for safety I guess, and best
if both behave the same - though one says -EINVAL and the other -EFAULT).

With that VM_DONTEXPAND check in, Dmitry's commit cd544fd1dc92
("mremap: don't allow MREMAP_DONTUNMAP on special_mappings and aio")
can still be reverted (as you agreed on 28th December), even though
vma_is_anonymous() will no longer protect it.

Was there an mremap(2) man page update for MREMAP_DONTUNMAP?
Whether or not there was before, it ought to get one now.

Thanks,
Hugh
