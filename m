Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1A6346768
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhCWSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCWSRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:17:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD4EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:17:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id c6so15651677qtc.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+HwLQy3bKchx7IHXZ4Wsk4yH9UF+9lojp6Rm4JdDHaM=;
        b=d1TGdnChROJJNvmq4XZYovEvSRGEFGazEKuBKVzVpVkzpmPUdsb8eK7G3+DxcCFIdb
         TLNiqMLYx8jtUt0TIE+FyYV+Z6Im5nFfH9JlfDdZS41WGtxYHpe2J2wT0Qm8NidOR9Xv
         ePEsbu3HDRMmcfG+oInlDB0cy6xkhirkKHd2uxkor/jDk+a8OossOWtoYmmupcugzXMc
         7sPYAPRjbyCEPuM7IYMwLs5MUOmLc02RphD+5c3TyM6h/6GxfYiMWGGfwG6BpQHtkFCK
         Lly5AvvxeJ+TbckEX9UFkwQxL5tjPACJ+Ns+HQSH/GI0CpflkzOG19Qtyt10BNHz3Z0S
         KXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=+HwLQy3bKchx7IHXZ4Wsk4yH9UF+9lojp6Rm4JdDHaM=;
        b=CH5UM7E6tetyxPvz25Z0kf9v8eLfGk3X4QzbKBIy0rVyg/pGiBOVqKISeVmawpVUjZ
         u2K1c/wzTLNURxKia59yJzc5ATUR0r2uq9S1fHk6IEZ/Ba0JWhK/zwBXwpoHXT/z1T1M
         MdUMCF325xDE52xfVCPVHsPYPXq1yFMMaLgXplYkuzm7A4irMv5EgEU79vG7DfS2fpaN
         JzqCHP2b2Mc8HBiF6K6ZVzWl5siBSgXkJ2PWE+rRKjf50APKOzsAisSAToK16OPj8jR9
         RFp4taIgBbjsTDLFnEXZnVS1zHCRCgm21ZmUyshGMJ0ALjfuQnPoVcLfBc/z9u6zhiiS
         zufg==
X-Gm-Message-State: AOAM532Gc6to+ed4CSciHaeVzfW7Zz8xBZ0ZwB3to/cnYWLNp+9AmCSN
        XJ4sXxVv5x8ZceAwyV03wuGKRA==
X-Google-Smtp-Source: ABdhPJyocYjsxTU4+WHvSbrLYITW9w2wwBDGlKSn0RyTLtnIJ8dMUedSY0NPvWEC99Q6qTR00rNOKg==
X-Received: by 2002:ac8:5242:: with SMTP id y2mr5572082qtn.109.1616523423391;
        Tue, 23 Mar 2021 11:17:03 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y14sm1324924qtw.70.2021.03.23.11.17.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 23 Mar 2021 11:17:02 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:16:50 -0700 (PDT)
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
Subject: Re: [PATCH v4 2/3] Revert "mremap: don't allow MREMAP_DONTUNMAP on
 special_mappings and aio"
In-Reply-To: <20210323162611.2398613-2-bgeffon@google.com>
Message-ID: <alpine.LSU.2.11.2103231110140.4862@eggly.anvils>
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323162611.2398613-1-bgeffon@google.com> <20210323162611.2398613-2-bgeffon@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021, Brian Geffon wrote:

> This reverts commit cd544fd1dc9293c6702fab6effa63dac1cc67e99.
> 
> As discussed in [1] this commit was a no-op because the mapping type was
> checked in vma_to_resize before move_vma is ever called. This meant that
> vm_ops->mremap() would never be called on such mappings. Furthermore,
> we've since expanded support of MREMAP_DONTUNMAP to non-anonymous
> mappings, and these special mappings are still protected by the existing
> check of !VM_DONTEXPAND and !VM_PFNMAP which will result in a -EFAULT.

No, those two lines still describe an earlier version, they should say:
"mappings, and these special mappings are now protected by a check of
 !VM_DONTEXPAND and !VM_PFNMAP which will result in a -EINVAL."

> 
> 1. https://lkml.org/lkml/2020/12/28/2340
> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
>  fs/aio.c                                  | 5 +----
>  include/linux/mm.h                        | 2 +-
>  mm/mmap.c                                 | 6 +-----
>  mm/mremap.c                               | 2 +-
>  5 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index e916646adc69..0daf2f1cf7a8 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -1458,7 +1458,7 @@ static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -static int pseudo_lock_dev_mremap(struct vm_area_struct *area, unsigned long flags)
> +static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
>  {
>  	/* Not supported */
>  	return -EINVAL;
> diff --git a/fs/aio.c b/fs/aio.c
> index 1f32da13d39e..76ce0cc3ee4e 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -323,16 +323,13 @@ static void aio_free_ring(struct kioctx *ctx)
>  	}
>  }
>  
> -static int aio_ring_mremap(struct vm_area_struct *vma, unsigned long flags)
> +static int aio_ring_mremap(struct vm_area_struct *vma)
>  {
>  	struct file *file = vma->vm_file;
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct kioctx_table *table;
>  	int i, res = -EINVAL;
>  
> -	if (flags & MREMAP_DONTUNMAP)
> -		return -EINVAL;
> -
>  	spin_lock(&mm->ioctx_lock);
>  	rcu_read_lock();
>  	table = rcu_dereference(mm->ioctx_table);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 64a71bf20536..ecdc6e8dc5af 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -570,7 +570,7 @@ struct vm_operations_struct {
>  	void (*close)(struct vm_area_struct * area);
>  	/* Called any time before splitting to check if it's allowed */
>  	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
> -	int (*mremap)(struct vm_area_struct *area, unsigned long flags);
> +	int (*mremap)(struct vm_area_struct *area);
>  	/*
>  	 * Called by mprotect() to make driver-specific permission
>  	 * checks before mprotect() is finalised.   The VMA must not
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3f287599a7a3..9d7651e4e1fe 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3403,14 +3403,10 @@ static const char *special_mapping_name(struct vm_area_struct *vma)
>  	return ((struct vm_special_mapping *)vma->vm_private_data)->name;
>  }
>  
> -static int special_mapping_mremap(struct vm_area_struct *new_vma,
> -				  unsigned long flags)
> +static int special_mapping_mremap(struct vm_area_struct *new_vma)
>  {
>  	struct vm_special_mapping *sm = new_vma->vm_private_data;
>  
> -	if (flags & MREMAP_DONTUNMAP)
> -		return -EINVAL;
> -
>  	if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
>  		return -EFAULT;
>  
> diff --git a/mm/mremap.c b/mm/mremap.c
> index db5b8b28c2dd..d22629ff8f3c 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -545,7 +545,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (moved_len < old_len) {
>  		err = -ENOMEM;
>  	} else if (vma->vm_ops && vma->vm_ops->mremap) {
> -		err = vma->vm_ops->mremap(new_vma, flags);
> +		err = vma->vm_ops->mremap(new_vma);
>  	}
>  
>  	if (unlikely(err)) {
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
> 
