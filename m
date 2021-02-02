Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF230CD96
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhBBVEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbhBBVEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:04:25 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DFFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:03:45 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id h14so21283503otr.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZsKito0PPC3VESrZMizMHi4i2e28LHAJItDb4eofiAk=;
        b=sEAVITEt74b7QqIvte43l5CEvMAF+x6tSbFyFV50suk0ZhA+IEhPQy1Tw8QKilsnmU
         2C2KMTwEGB25YMrnrQ9hSKnEEc0iEwMBckvAZ5171uIU57PGjkKa5zN1o2xaBlUMVH7f
         By4ciUSd5J+f59n9Bdw/TYdOOx7l3G2HJSkwE3U7sm8LI4+xpzx6T9G2Sqw4Ug5N37Zj
         MUOraGZXOkPb6HNpIbI21257dbzdyFw3Ir3eQpi8t5qQQ5RzMtW6eE+7dJO/FS2MKQ7q
         YaRQQ/nNBesqSM6n+f/wsq/uF+Uhii4FX70RJYF7usJO3kFK6H1vfvRlaO3TxZ8Ssq3p
         lQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZsKito0PPC3VESrZMizMHi4i2e28LHAJItDb4eofiAk=;
        b=auoK0UNe9DMypQ2m7xFVlanQ17MLa/OjElrOPxO1jpM7F7tTudtpFUiDolnHrwUkon
         ALSr/lTGHiq/fK3VYRSgTBxTiSGBgatDCt8u1S48EI+EjxhDxlnVwRb4mCe+uT8gliWo
         PgMVGWTAo9gWKnYtucTMvi1v0RCTUx+0H0EL7KaQnK8fC5cOGPdWD7GDL2h0yzBcoYBa
         bGBqI8/lejuokeTx95ZrH5IRprkLfUAEk9iZeC/1s4OS+vnoujMpDK208wM/iJk2Xiyb
         iIlmrF9pT2zINcoQp6RP7mQtTho86F/MjPrkxrh4S+sYSFpnO7qHu89BoeyY0q3z+cwV
         mHzQ==
X-Gm-Message-State: AOAM533pnxfeiQ+vXCYCMWiJ9DdWJ5Z6Rmfs9va9Y6VIAf9qBYu4cuxp
        0T3cxaJcYgF9KPoav2vT5/CbEDd16lrUHw==
X-Google-Smtp-Source: ABdhPJwMlUnj4fH+ki4NPgTAsKN3RYV0SL53cm6thygtY83oEPOWIUOK1QSTyB0WML9AXqvSdSkx+g==
X-Received: by 2002:a9d:4c83:: with SMTP id m3mr17446829otf.353.1612299824553;
        Tue, 02 Feb 2021 13:03:44 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u81sm14056oia.49.2021.02.02.13.03.43
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 02 Feb 2021 13:03:43 -0800 (PST)
Date:   Tue, 2 Feb 2021 13:03:32 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
In-Reply-To: <20210202203127.3596707-1-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2102021248250.2436@eggly.anvils>
References: <20210202203127.3596707-1-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021, Axel Rasmussen wrote:

> For background, mm/userfaultfd.c provides a general mcopy_atomic
> implementation. But some types of memory (e.g., hugetlb and shmem) need
> a slightly different implementation, so they provide their own helpers
> for this. In other words, userfaultfd is the only caller of this
> function.
> 
> This patch achieves two things:
> 
> 1. Don't spend time compiling code which will end up never being
> referenced anyway (a small build time optimization).
> 
> 2. In future patches (e.g. [1]), we plan to extend the signature of
> these helpers with UFFD-specific state (e.g., enums or structs defined
> conditionally in userfaultfd_k.h). Once this happens, this patch will be
> needed to avoid build errors (or, we'd need to define more UFFD-only
> stuff unconditionally, which seems messier to me).
> 
> Peter Xu suggested this be sent as a standalone patch, in the mailing
> list discussion for [1].
> 
> [1] https://patchwork.kernel.org/project/linux-mm/list/?series=424091
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/hugetlb.h | 4 ++++
>  mm/hugetlb.c            | 2 ++
>  2 files changed, 6 insertions(+)

Hi Axel, please also do the same to mm/shmem.c (perhaps you missed
it because I did that long ago to our internal copy of mm/shmem.c).
But please also comment the endifs
#endif /* CONFIG_USERFAULTFD */
to help find one's way around them.

I see you've done include/linux/hugetlb.h: okay, that's not necessary,
but a matter of taste; up to you whether to do include/linux/shmem_fs.h.

Thanks,
Hugh

> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebca2ef02212..749701b5c153 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -134,11 +134,13 @@ void hugetlb_show_meminfo(void);
>  unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
> +#ifdef CONFIG_USERFAULTFD
>  int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
>  				struct vm_area_struct *dst_vma,
>  				unsigned long dst_addr,
>  				unsigned long src_addr,
>  				struct page **pagep);
> +#endif
>  int hugetlb_reserve_pages(struct inode *inode, long from, long to,
>  						struct vm_area_struct *vma,
>  						vm_flags_t vm_flags);
> @@ -308,6 +310,7 @@ static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
>  	BUG();
>  }
>  
> +#ifdef CONFIG_USERFAULTFD
>  static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  						pte_t *dst_pte,
>  						struct vm_area_struct *dst_vma,
> @@ -318,6 +321,7 @@ static inline int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	BUG();
>  	return 0;
>  }
> +#endif
>  
>  static inline pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr,
>  					unsigned long sz)
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 18f6ee317900..821bfa9c0c80 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4615,6 +4615,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	return ret;
>  }
>  
> +#ifdef CONFIG_USERFAULTFD
>  /*
>   * Used by userfaultfd UFFDIO_COPY.  Based on mcopy_atomic_pte with
>   * modifications for huge pages.
> @@ -4745,6 +4746,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	put_page(page);
>  	goto out;
>  }
> +#endif
>  
>  long follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
>  			 struct page **pages, struct vm_area_struct **vmas,
> -- 
> 2.30.0.365.g02bc693789-goog
