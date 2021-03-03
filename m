Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442C832C10E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837858AbhCCS7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386327AbhCCSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:14:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1434C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 10:13:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id mj10so23959923ejb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 10:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpD0RaMDqf7Z66lLx19Nw3YO9e/Zfu9hvTlC9c/TTdQ=;
        b=iL/okFPl96aw14inj9n1SVBd7xMdas0YydLx5oBkq3SQKnafTNRLs5xgjyYRvmHWuS
         Uo64beUXwbhGRdY76A0YHsK0DDES4iiLcIhL5xqZy3JVw8ZljklTwXvGbDEItX6EfQVF
         J2HVuG/FKL8dIYGziZAHf2UOJP6kKUzlR3MIdJHEsm+vx8FGfWOKYEaUyyBZDpMfMGs7
         Od+lPlfJofzeWRckzCJefpNs+vOfxkpeohcJTbBYUH9brN9e9u/1fNW0pXG7DdDE0+WG
         QV1vSl8eO7fdIXND4WH+p4J1OhG9F0463vIGuVKsjua57VdrI35eyHMnEXZj2AjzFHW3
         Q3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpD0RaMDqf7Z66lLx19Nw3YO9e/Zfu9hvTlC9c/TTdQ=;
        b=Y20kgv/vTJ1OQsNcqJVBzMXKmH1KNe1fEVdOFl+oIUvH6Tdbd5GitNFKEKZcFT+aGM
         iIrl6ObhZHH54zdEOZjO+bd9+LEHYkklTKRHlJ9Eu1UY4YPvGcpCso+CsPoWTLbigJDR
         OSKD3GK3mUKDgHTm+bxA1VxOFPSLi3xQgO6OoM4zbB/uPYst96FmYXLEhR4cIgTYObBu
         VXGeITNo6hcgAvamX162yE+iVKNHttgQ69jzfUW0BdlCadkKHEPDlZeHLvqWIShkmzJX
         wNvhCREGK4cP1/NPXmXhjBwXMgGu6p7hufxLvKYIbbtncU2KF2ScceHAsGEyCmMR2Q5W
         m1cA==
X-Gm-Message-State: AOAM532ab+NPM01x94pl4FVUFXolpk5SiddSdju+Ra48DOCGJDCMWv0n
        dquriaa1zhkwQ3bO07yF0FVyXWueGqPoNHQXu9oWqw==
X-Google-Smtp-Source: ABdhPJw5AZ/c6u1egiHd+y/UURI+Oe7j8650RVp7gMoL2chG4BFCZHQYsBIZBv9fGIJcq9rTN/PyNaGgWQeQZ2foMJA=
X-Received: by 2002:a17:906:2312:: with SMTP id l18mr95958eja.468.1614795234368;
 Wed, 03 Mar 2021 10:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com>
In-Reply-To: <20210303175235.3308220-1-bgeffon@google.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 3 Mar 2021 10:13:18 -0800
Message-ID: <CADyq12ymZcrU-+ZnDZ=nieq5zgzf_j9zGT7-BPDXXnxP-rz_kw@mail.gmail.com>
Subject: Re: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize, this patch didn't include my signed off by, here it is:

Signed-off-by: Brian Geffon <bgeffon@google.com>


On Wed, Mar 3, 2021 at 9:53 AM Brian Geffon <bgeffon@google.com> wrote:
>
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
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> -                       vma->vm_flags & VM_SHARED))
> +       if (flags & MREMAP_DONTUNMAP && !(vma_is_anonymous(vma) || vma_is_shmem(vma)))
>                 return ERR_PTR(-EINVAL);
>
>         if (is_vm_hugetlb_page(vma))
> --
> 2.31.0.rc0.254.gbdcc3b1a9d-goog
>
