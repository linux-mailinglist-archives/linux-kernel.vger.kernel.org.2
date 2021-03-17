Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932B933FA17
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbhCQUpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhCQUpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:45:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73189C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:45:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ce10so474160ejb.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXDBuwtZDRVlKmXjX6RLYWp8aN0fn5ihDHSgEVvVeSI=;
        b=fCaFXuUoCSuTNHW1TUhZFbvJdVn9mau28hZtqJ3USyaTxWHCSRusVH5MDeD4JJrjFV
         8VjR9pyET6P5O5cdIHfSkMQLw5D6J0LtyOnE0RQf9Pm28gbEMnbuCJjvkLjG6wsC49+r
         WJGUv9nIFTKFstSgGl3P9zv2NyigfksGOiX5yE65u9D0I1haEGE3FI/Cqx/K39wOPmum
         nzF/3mRkpgib1vU9xEqL4qBNDbCoH1dbQrYb5l9PRwKQZco/J8ugutvdoe4VyhWrGSeZ
         yWMZBqAZOqGbWdx0JWhmb9+xtF6Drvct656lP46WS+4kvbZLOLPABFgpnp70+NS26UvB
         eP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXDBuwtZDRVlKmXjX6RLYWp8aN0fn5ihDHSgEVvVeSI=;
        b=GEhusqa7mgfCkvJ9q3i5E3oo2KTznQdiIQNTInshEtrz8Ltzn8R3iAtxpXOU1jopws
         cLof7Kz73QjZDmBaqmOM/Tl60KujSeo778Yt8Pmyca2sRFrct6G6FvG3z59KnWac9qoX
         uIGbWxU3rr1SHWBA79RjAHZdxVT9FnT7gykrcP269dmx0F2cR+1dQ2ZdoR9CyDorwns4
         LjOo0IlyTO8f5UyFR13TNYw4jDZc63EARmVtOEg7KJFDGahcf0IlsmC8L1307PWXGqM2
         T+MalIcHyvmCRn8Z5q14Zs4NARShAbqiEE17ZJgP25b+bgeUdkKkzUQ2DgEnqU9xDMrk
         qOkA==
X-Gm-Message-State: AOAM530e2hTb/arKINgWAmahrU3xR5An2i3s+LxWJKg4Di2XJkFI8OqA
        3ujIMN2/ZBTbYTlgawAw89Sa5Y3VuHqM2s+6EwAhIQ==
X-Google-Smtp-Source: ABdhPJwPKLSVtSLBjWwvmw/X3ooel+wWPEypK/xdpz3ZnNCEqaxWW6LhkTLZWYeG5ckcrR8Q/c5X0BGrAryTGMxAD/c=
X-Received: by 2002:a17:906:d157:: with SMTP id br23mr38497318ejb.192.1616013903040;
 Wed, 17 Mar 2021 13:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210317191334.564944-1-bgeffon@google.com>
 <20210317204015.GM395976@xz-x1>
In-Reply-To: <20210317204015.GM395976@xz-x1>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 17 Mar 2021 16:44:25 -0400
Message-ID: <CADyq12z6vQ0qHs14aVOFgqfn9pvFak-vwEVmLTObMQ1exsOM+g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP mappings
 with MREMAP_DONTUNMAP
To:     Peter Xu <peterx@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,
Thank you as always for taking a look. This change relies on the
existing check in vma_to_resize on line 686:
https://elixir.bootlin.com/linux/v5.12-rc3/source/mm/mremap.c#L686
which returns -EFAULT when the vma is VM_DONTEXPAND or VM_PFNMAP.

Thanks
Brian

On Wed, Mar 17, 2021 at 4:40 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Brian,
>
> On Wed, Mar 17, 2021 at 12:13:33PM -0700, Brian Geffon wrote:
> > Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This
> > change will widen the support to include any mappings which are not
> > VM_DONTEXPAND or VM_PFNMAP. The primary use case is to support
> > MREMAP_DONTUNMAP on mappings which may have been created from a memfd.
> >
> > This change which takes advantage of the existing check in vma_to_resize
> > for non-VM_DONTEXPAND and non-VM_PFNMAP mappings will cause
> > MREMAP_DONTUNMAP to return -EFAULT if such mappings are remapped. This
> > behavior is consistent with existing behavior when using mremap with
> > such mappings.
> >
> > Lokesh Gidra who works on the Android JVM, provided an explanation of how
> > such a feature will improve Android JVM garbage collection:
> > "Android is developing a new garbage collector (GC), based on userfaultfd.
> > The garbage collector will use userfaultfd (uffd) on the java heap during
> > compaction. On accessing any uncompacted page, the application threads will
> > find it missing, at which point the thread will create the compacted page
> > and then use UFFDIO_COPY ioctl to get it mapped and then resume execution.
> > Before starting this compaction, in a stop-the-world pause the heap will be
> > mremap(MREMAP_DONTUNMAP) so that the java heap is ready to receive
> > UFFD_EVENT_PAGEFAULT events after resuming execution.
> >
> > To speedup mremap operations, pagetable movement was optimized by moving
> > PUD entries instead of PTE entries [1]. It was necessary as mremap of even
> > modest sized memory ranges also took several milliseconds, and stopping the
> > application for that long isn't acceptable in response-time sensitive
> > cases.
> >
> > With UFFDIO_CONTINUE feature [2], it will be even more efficient to
> > implement this GC, particularly the 'non-moveable' portions of the heap.
> > It will also help in reducing the need to copy (UFFDIO_COPY) the pages.
> > However, for this to work, the java heap has to be on a 'shared' vma.
> > Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this
> > patch will enable using UFFDIO_CONTINUE for the new userfaultfd-based heap
> > compaction."
> >
> > [1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
> > [2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/
> >
> > Signed-off-by: Brian Geffon <bgeffon@google.com>
> > ---
> >  mm/mremap.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index ec8f840399ed..2c57dc4bc8b6 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -653,10 +653,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
> >               return ERR_PTR(-EINVAL);
> >       }
> >
> > -     if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> > -                     vma->vm_flags & VM_SHARED))
> > -             return ERR_PTR(-EINVAL);
> > -
> >       if (is_vm_hugetlb_page(vma))
> >               return ERR_PTR(-EINVAL);
>
> The code change seems to be not aligned with what the commit message said.  Did
> you perhaps forget to add the checks against VM_DONTEXPAND | VM_PFNMAP?  I'm
> guessing that (instead of commit message to be touched up) because you still
> attached the revert patch, then that check seems to be needed.  Thanks,
>
> --
> Peter Xu
>
