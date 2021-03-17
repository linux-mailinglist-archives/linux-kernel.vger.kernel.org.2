Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619FD33FA0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 21:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhCQUku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 16:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231920AbhCQUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 16:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616013623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y409+hbMmdUUFTiOqanFc/IWp7lWurY/OstZudlxMGI=;
        b=WDQC3d6NqBDluSuMQBJdQiDqieir/Gb4KnF05fyop1gp46dYnThHmGYko5efYRj0TWOq/6
        SnuURKjL/+/2WfJgLWlfNWmJxNt+ppxuqBK3pCbTdbbSEdQ4yWXorVZ+A11ZMxRLQ1SO7g
        62/RTFSY9q0bITQhATOUQ+9m5Zid/CA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-priFkR8cNKOKWybEoEZzbg-1; Wed, 17 Mar 2021 16:40:20 -0400
X-MC-Unique: priFkR8cNKOKWybEoEZzbg-1
Received: by mail-qk1-f197.google.com with SMTP id b78so30197211qkg.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 13:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y409+hbMmdUUFTiOqanFc/IWp7lWurY/OstZudlxMGI=;
        b=gF7a+g9+Ckn30dRnXTGgjft9SKK47ANxPBK1j9z57XolCboYdCHg9JSoXaH0UJKmNI
         UEGX96kKK9xrVnhqC28Vmg+61Cc5+G195Vf8If38YgAymIKyA1kcpnrt8j2hKfj8a5vF
         6yb+Ve8ntEyo1hrrwDOPDZE0XwlxIVcLp+L5iOjT0l5jV8pQ5Wd4gHm7qd/KMKi+MW9W
         1jPhak91b4UiyIovioh2dBtWqn+92n/6+F9Ol4HZvF4vFm7u3O6z4YvgYOHNhA9jd/DB
         lM/f06YHx2P8aSx6OT+wt+KAdQ1AELIoUBTpaywPLymPK86KKdrRlVN7zCVe7BDiTnux
         bw/w==
X-Gm-Message-State: AOAM533dNRWeJulYOPzrjCc2oo/Fr7ggbkaDc14yDZYfxF9q6hgmjkBW
        2THYEtk62DzrDJy6EPqJ6z28/qcAQiOjUwrnEYC130U+rTe47d74rzD82RY9gl+h3F9xTEzodmw
        ZekQ9XpT6DxyEZHzEM/vmZpwR
X-Received: by 2002:a37:7006:: with SMTP id l6mr1112499qkc.137.1616013619518;
        Wed, 17 Mar 2021 13:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAO2RnKvysnz5AJ2MhEmACHRCP/slH3sKue7aceM79G8SFp4fSuy7PZcfMdyA5pFmgw02GQQ==
X-Received: by 2002:a37:7006:: with SMTP id l6mr1112476qkc.137.1616013619214;
        Wed, 17 Mar 2021 13:40:19 -0700 (PDT)
Received: from xz-x1 ([142.126.89.138])
        by smtp.gmail.com with ESMTPSA id j6sm14931770qtx.14.2021.03.17.13.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:40:18 -0700 (PDT)
Date:   Wed, 17 Mar 2021 16:40:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP
 mappings with MREMAP_DONTUNMAP
Message-ID: <20210317204015.GM395976@xz-x1>
References: <20210303175235.3308220-1-bgeffon@google.com>
 <20210317191334.564944-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317191334.564944-1-bgeffon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Brian,

On Wed, Mar 17, 2021 at 12:13:33PM -0700, Brian Geffon wrote:
> Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This
> change will widen the support to include any mappings which are not
> VM_DONTEXPAND or VM_PFNMAP. The primary use case is to support
> MREMAP_DONTUNMAP on mappings which may have been created from a memfd.
> 
> This change which takes advantage of the existing check in vma_to_resize
> for non-VM_DONTEXPAND and non-VM_PFNMAP mappings will cause
> MREMAP_DONTUNMAP to return -EFAULT if such mappings are remapped. This
> behavior is consistent with existing behavior when using mremap with
> such mappings.
> 
> Lokesh Gidra who works on the Android JVM, provided an explanation of how
> such a feature will improve Android JVM garbage collection:
> "Android is developing a new garbage collector (GC), based on userfaultfd.
> The garbage collector will use userfaultfd (uffd) on the java heap during
> compaction. On accessing any uncompacted page, the application threads will
> find it missing, at which point the thread will create the compacted page
> and then use UFFDIO_COPY ioctl to get it mapped and then resume execution.
> Before starting this compaction, in a stop-the-world pause the heap will be
> mremap(MREMAP_DONTUNMAP) so that the java heap is ready to receive
> UFFD_EVENT_PAGEFAULT events after resuming execution.
> 
> To speedup mremap operations, pagetable movement was optimized by moving
> PUD entries instead of PTE entries [1]. It was necessary as mremap of even
> modest sized memory ranges also took several milliseconds, and stopping the
> application for that long isn't acceptable in response-time sensitive
> cases.
> 
> With UFFDIO_CONTINUE feature [2], it will be even more efficient to
> implement this GC, particularly the 'non-moveable' portions of the heap.
> It will also help in reducing the need to copy (UFFDIO_COPY) the pages.
> However, for this to work, the java heap has to be on a 'shared' vma.
> Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this
> patch will enable using UFFDIO_CONTINUE for the new userfaultfd-based heap
> compaction."
> 
> [1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
> [2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  mm/mremap.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ec8f840399ed..2c57dc4bc8b6 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -653,10 +653,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> -			vma->vm_flags & VM_SHARED))
> -		return ERR_PTR(-EINVAL);
> -
>  	if (is_vm_hugetlb_page(vma))
>  		return ERR_PTR(-EINVAL);

The code change seems to be not aligned with what the commit message said.  Did
you perhaps forget to add the checks against VM_DONTEXPAND | VM_PFNMAP?  I'm
guessing that (instead of commit message to be touched up) because you still
attached the revert patch, then that check seems to be needed.  Thanks,

-- 
Peter Xu

