Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA0134120A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhCSBVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhCSBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:21:12 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C14DC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:21:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g20so1346720qkk.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 18:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=suObc3/+Vf1EytucrxjvYtf/CBrpHkGZ5JxHoK4z38E=;
        b=bhJcjepUfXuLEoJOGLGkpyQu0P6brTjnnbhvfmYXw7eHdG3fIGA3Hbh/OsxZBdzFmu
         gFVLug0cMvQ10NA++5eqgG1dgoYJKY0i/krruCcE9nM7PVn488/q6l5TwekudWhDsQr8
         qaImdyjuzs7hb2Qzru8Wp3MP1ufLaCJIzFkWA0XlMXhzidZgAbJ7n6MNkQ5VbgPyiUcx
         efNpSwQArhHoDqxp5S2D0nTNxPqbBpRx2gmtZZzO8QCxAbqpOK0XGEteJZBBp5yOCp/e
         5QsmD7NLKR1zC+4g2CFnDL/mPwurAUQHgvGmAeQmzQd7I6o2faJZC5UvLuaB+rlVYPQp
         dEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=suObc3/+Vf1EytucrxjvYtf/CBrpHkGZ5JxHoK4z38E=;
        b=L21GtGOySi042d0XOcDPHeMIdqEFmkNAZwq6tBooUF9cEUQIf518RT05w7VlEmBVOi
         3E5Kk8mZrwd4S0FyQCI6u4jezLMag00EGqd9cigFDecSfuvioxLUkKCv81wkp9f2zDNs
         bqQ36FB58SHOSRNdepCyTWffep6YAZJV4pYbUBGKCIvVglIo3B+9tWp62cOrhcjOGe8U
         eWl1i62BT+7thkktFZemX9zcDgdA8hK4E0Mf+O5nwfdnjXMF7/zFYgOwMnvBzKnD2jLk
         HHzG+0IBFoAlEOj5m5tLeAypTaw0kbSTtsK6ZuU48YQIhkN9FtSEjC4pjjGt9MHZD6aJ
         xwfg==
X-Gm-Message-State: AOAM531QfZhL/eWUBImZo4zF+LCBhvGSmXv+uFUxieOmoa9QHBIFuDEw
        jK7J+TGLvr/53uO3DIv1W7qkLQ==
X-Google-Smtp-Source: ABdhPJzxaTzfnuMMfHVnGVJvkXMVIR6OJ9/8nydBOwNcHky3r1Qs+nKNrDbEYoVcwP2Pp6h8IPKEYw==
X-Received: by 2002:a05:620a:122c:: with SMTP id v12mr7154881qkj.344.1616116871126;
        Thu, 18 Mar 2021 18:21:11 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v35sm2807770qtd.56.2021.03.18.18.21.09
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 18 Mar 2021 18:21:10 -0700 (PDT)
Date:   Thu, 18 Mar 2021 18:20:56 -0700 (PDT)
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
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v3 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP mappings
 with MREMAP_DONTUNMAP
In-Reply-To: <20210317214147.682687-1-bgeffon@google.com>
Message-ID: <alpine.LSU.2.11.2103181803280.3440@eggly.anvils>
References: <20210303175235.3308220-1-bgeffon@google.com> <20210317214147.682687-1-bgeffon@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Andrew is happy with such a long patch name, okay;
but personally I'd prefer brevity to all that detail:

mm: Extend MREMAP_DONTUNMAP to non-anonymous mappings

On Wed, 17 Mar 2021, Brian Geffon wrote:

> Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This
> change will widen the support to include any mappings which are not
> VM_DONTEXPAND or VM_PFNMAP. The primary use case is to support
> MREMAP_DONTUNMAP on mappings which may have been created from a memfd.
> 
> This change will result in mremap(MREMAP_DONTUNMAP) returning -EINVAL
> if VM_DONTEXPAND or VM_PFNMAP mappings are specified.
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

Acked-by: Hugh Dickins <hughd@google.com>

Thanks Brian, just what I wanted :)

You wondered in another mail about this returning -EINVAL whereas
the VM_DONTEXPAND size error returns -EFAULT: I've pondered, and I've
read the manpage, and I'm sure it would be wrong to change the old
-EFAULT to -EINVAL now; and I don't see good reason to change your
-EINVAL to -EFAULT either.  Let them differ, that's okay (and it's
only in special corner cases that either of these fail anyway).

> ---
>  mm/mremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ec8f840399ed..db5b8b28c2dd 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -653,8 +653,8 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
> -			vma->vm_flags & VM_SHARED))
> +	if ((flags & MREMAP_DONTUNMAP) &&
> +			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return ERR_PTR(-EINVAL);
>  
>  	if (is_vm_hugetlb_page(vma))
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
