Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087F032C1B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387405AbhCCTYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350345AbhCCTFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:05:32 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2D3C061765
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 11:04:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id w1so44378805ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=emB76DYl8PmmcmITFjkIlLA/KjBQhOxxjznaA2F8hE4=;
        b=bt17grf5jTznLnyyJrRe5nSPyIJhqqI/eIkQkXHehzw1+by6/BaEkgNQZV5Wq1kReo
         yTZyzGYsWknSfPNib1svKGo6bL+jUsd+if0RrYvFKHkp5A0QOYIWx4qvvMFsz78XT8jx
         H8Zs1EyzxkLlTebyu0KkBvHHyC/zLoi/OXaWpkLUL0//E4AJOdtcEvUowmMolZhegrqt
         o2ZAduUYxBM/gFwzFDva01tjU2BHnDTcouoJfGR4JJ/Bcs5cshwl3tBK1MyIdozXAD8g
         1ERdwVMfXHlKsifQ1DcmnjHNunYIRgiPEGc9yywQkwhxEz9SUI+EXG3Q8udjPaLXg7Au
         Cppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=emB76DYl8PmmcmITFjkIlLA/KjBQhOxxjznaA2F8hE4=;
        b=O5eSutZC7iKR+E+0Q6ZA76N1i8Xj/3hoBGEJjQblXE2Pg1VSJNTv+0HS8KoDfZ613c
         Z9ThZqIrXijfP79idmHht8M75FO1w6wIvukxjokiI/8NLWeYK51/QcWMa9vcLWxjpOJ1
         vAkYMzTA1IGJmi37ZXVAc+F7fhkB/SfBAaixLVr7ST6/XGDCO3oUumDzSJfwuiyybcpP
         vNldp6mxuy5zoEe/0tR1URYSAhkG71Uewm6tvHuznKNMIZG4z/eSXJVPcOBUJYawW3Zt
         R59MwuAwQTIg89ab7m6darT3S/wB4p2jWX0OnCxs3Wk7W5c8cHarVgEnKYePPG7ruGxY
         SdcQ==
X-Gm-Message-State: AOAM532bCi2Bob1oTZXfcr4lDsO5dXsksdiYPGQWJehSD49JkYK7Iwqn
        Gjzu6a4BD4vVRB9qq/cxVqMpjrA7OjcR5Fmicz6/4g==
X-Google-Smtp-Source: ABdhPJxLmIMCD5thMPhEljfIP3oZXUuagP+sz6u1sBLxpvrEkxxiOzwKhxFS1Rlm6E3fXMFuSM+0j9eA0/LHaG2Fc+g=
X-Received: by 2002:a17:906:3603:: with SMTP id q3mr257584ejb.201.1614798284132;
 Wed, 03 Mar 2021 11:04:44 -0800 (PST)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <CADyq12ymZcrU-+ZnDZ=nieq5zgzf_j9zGT7-BPDXXnxP-rz_kw@mail.gmail.com>
In-Reply-To: <CADyq12ymZcrU-+ZnDZ=nieq5zgzf_j9zGT7-BPDXXnxP-rz_kw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 3 Mar 2021 11:04:32 -0800
Message-ID: <CA+EESO7GLWcSmzRSiTqFygqEmrKT=oVFEuMs_F0nTQf-wepJXQ@mail.gmail.com>
Subject: Re: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
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

On Wed, Mar 3, 2021 at 10:13 AM Brian Geffon <bgeffon@google.com> wrote:
>
> I apologize, this patch didn't include my signed off by, here it is:
>
> Signed-off-by: Brian Geffon <bgeffon@google.com>
>
>
> On Wed, Mar 3, 2021 at 9:53 AM Brian Geffon <bgeffon@google.com> wrote:
> >
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

Thanks for the patch, Brian. I've tested mremap(MREMAP_DONTUNMAP) on a
memfd memory range.

Tested-by: Lokesh Gidra <lokeshgidra@google.com>

> > ---
> >  mm/mremap.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index ec8f840399ed..6934d199da54 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -653,8 +653,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> > -                       vma->vm_flags & VM_SHARED))
> > +       if (flags & MREMAP_DONTUNMAP && !(vma_is_anonymous(vma) || vma_is_shmem(vma)))
> >                 return ERR_PTR(-EINVAL);
> >
> >         if (is_vm_hugetlb_page(vma))
> > --
> > 2.31.0.rc0.254.gbdcc3b1a9d-goog
> >
