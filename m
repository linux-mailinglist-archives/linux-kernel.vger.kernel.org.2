Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A18309BBA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 12:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhAaLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhAaKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:08:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56998C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:07:50 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e15so10630092wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tometzki.de; s=google;
        h=date:from:to:cc:subject:message-id:reply-to:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent
         :organization;
        bh=2LFKUqYoQeBEjNkEcCQG0oHH48uHjpfxQcW7ayh7/GQ=;
        b=PltLWdFheUeiORSOxC3ejb22zuPuGsJiGLKcOkCol2qFgss376hxtbHzA8YIF7kmIW
         jP4Ua36xAb0/yWgwRxCxDoBOgEWTqOcAHBKqfxEFGWPPujjXD4CXoxbtHat0MbH97p4C
         vAGd9JpFAEcoiI+z81UnqYxGYc3E6jZ+8J/CIVnoFeVT4bBD2m5wmDf47vUYO3rNfFww
         7lTSQboBqJfhAYyuacvXNkhrtgar2XWQrFt1gIhEvspLJPDtWe6iBE2G7/sgd6toVynA
         u4blZF0SA1UeTph7Y6NTcpUvaGoM5Vff36WitFErX+DBDyJ7EGMO3NKFfEAeHpNm5Q6A
         P0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent:organization;
        bh=2LFKUqYoQeBEjNkEcCQG0oHH48uHjpfxQcW7ayh7/GQ=;
        b=pWv0z4vAPJDB5ETJDLOySf6uJ9U/rb+nl3whLgN0YtyPXD+8XI2OjIZq9bevaY6PCM
         K0x2ueMR1nso8E5S8FNFQrcIko6aoSv5zePhvDGwQRFzQxANP0awKuRhxAb/AMRu00Bn
         kYtqNXO6/S3Jpgd4C0SzV3Eu1SMX0SarDj8W+xx4hpd+m4fOzkBQfhlv3Dcou8aRCrjX
         yxTyVdJLlE7UWisHQSSFuuxdLrsCYavSFdL8VXIDAGv7E1iyiyhndnrL1vVxe3awlpHn
         UJ6gSzI8ZYdGxI31zPgjX7vFS7hFvMBmGW4nlcOElWfAMj0YjkOQHJHwQ8G0RM9vSDCe
         iDvQ==
X-Gm-Message-State: AOAM531Ne171n8rgXhbzPLSiOVC1jkYbilB1RLEqPyNIiC6DHCw0OfQp
        euczJuwVIlwMhy2AFg2WHJ/HIQ==
X-Google-Smtp-Source: ABdhPJyiy0JHQujZ5y9LwkAfFjgYkFfQklFyyByGHQM7q87nwYQvG/tREHsScACJM78oAq+PYYOM5Q==
X-Received: by 2002:a05:600c:d1:: with SMTP id u17mr10494846wmm.20.1612087668915;
        Sun, 31 Jan 2021 02:07:48 -0800 (PST)
Received: from fedora.tometzki.de (p200300e68f334e009f56fbcb8d40a599.dip0.t-ipconnect.de. [2003:e6:8f33:4e00:9f56:fbcb:8d40:a599])
        by smtp.gmail.com with ESMTPSA id n5sm15814533wmq.7.2021.01.31.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 02:07:47 -0800 (PST)
Date:   Sun, 31 Jan 2021 11:07:45 +0100
From:   Damian Tometzki <linux@tometzki.de>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [RFC 13/20] mm/tlb: introduce tlb_start_ptes() and tlb_end_ptes()
Message-ID: <YBaBcc2jEGaxuxH0@fedora.tometzki.de>
Reply-To: Damian Tometzki <damian@tometzki.de>
Mail-Followup-To: Nadav Amit <nadav.amit@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Yu Zhao <yuzhao@google.com>, Nick Piggin <npiggin@gmail.com>,
        x86@kernel.org
References: <20210131001132.3368247-1-namit@vmware.com>
 <20210131001132.3368247-14-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210131001132.3368247-14-namit@vmware.com>
User-Agent: Mutt
Organization: Familie Tometzki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30. Jan 16:11, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Introduce tlb_start_ptes() and tlb_end_ptes() which would be called
> before and after PTEs are updated and TLB flushes are deferred. This
> will be later be used for fine granualrity deferred TLB flushing
> detection.
> 
> In the meanwhile, move flush_tlb_batched_pending() into
> tlb_start_ptes(). It was not called from mapping_dirty_helpers by
> wp_pte() and clean_record_pte(), which might be a bug.
> 
> No additional functional change is intended.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> ---
>  fs/proc/task_mmu.c         |  2 ++
>  include/asm-generic/tlb.h  | 18 ++++++++++++++++++
>  mm/madvise.c               |  6 ++++--
>  mm/mapping_dirty_helpers.c | 15 +++++++++++++--
>  mm/memory.c                |  2 ++
>  mm/mprotect.c              |  3 ++-
>  6 files changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 4cd048ffa0f6..d0cce961fa5c 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1168,6 +1168,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>  		return 0;
>  
>  	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> +	tlb_start_ptes(&cp->tlb);
>  	for (; addr != end; pte++, addr += PAGE_SIZE) {
>  		ptent = *pte;
>  
> @@ -1190,6 +1191,7 @@ static int clear_refs_pte_range(pmd_t *pmd, unsigned long addr,
>  		tlb_flush_pte_range(&cp->tlb, addr, PAGE_SIZE);
>  		ClearPageReferenced(page);
>  	}
> +	tlb_end_ptes(&cp->tlb);
>  	pte_unmap_unlock(pte - 1, ptl);
>  	cond_resched();
>  	return 0;
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 041be2ef4426..10690763090a 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -58,6 +58,11 @@
>   *    Defaults to flushing at tlb_end_vma() to reset the range; helps when
>   *    there's large holes between the VMAs.
>   *
> + *  - tlb_start_ptes() / tlb_end_ptes; makr the start / end of PTEs change.

Hello Nadav,

short nid makr/mark

Damian

> + *
> + *    Does internal accounting to allow fine(r) granularity checks for
> + *    pte_accessible() on certain configuration.
> + *
>   *  - tlb_remove_table()
>   *
>   *    tlb_remove_table() is the basic primitive to free page-table directories
> @@ -373,6 +378,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>  		flush_tlb_range(tlb->vma, tlb->start, tlb->end);
>  	}
>  }
> +#endif
> +
> +#if __is_defined(tlb_flush) ||						\
> +	IS_ENABLED(CONFIG_ARCH_WANT_AGGRESSIVE_TLB_FLUSH_BATCHING)
>  
>  static inline void
>  tlb_update_vma(struct mmu_gather *tlb, struct vm_area_struct *vma)
> @@ -523,6 +532,15 @@ static inline void mark_mm_tlb_gen_done(struct mm_struct *mm, u64 gen)
>  
>  #endif /* CONFIG_ARCH_HAS_TLB_GENERATIONS */
>  
> +#define tlb_start_ptes(tlb)						\
> +	do {								\
> +		struct mmu_gather *_tlb = (tlb);			\
> +									\
> +		flush_tlb_batched_pending(_tlb->mm);			\
> +	} while (0)
> +
> +static inline void tlb_end_ptes(struct mmu_gather *tlb) { }
> +
>  /*
>   * tlb_flush_{pte|pmd|pud|p4d}_range() adjust the tlb->start and tlb->end,
>   * and set corresponding cleared_*.
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 0938fd3ad228..932c1c2eb9a3 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -392,7 +392,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  #endif
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	orig_pte = pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
> -	flush_tlb_batched_pending(mm);
> +	tlb_start_ptes(tlb);
>  	arch_enter_lazy_mmu_mode();
>  	for (; addr < end; pte++, addr += PAGE_SIZE) {
>  		ptent = *pte;
> @@ -468,6 +468,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  	}
>  
>  	arch_leave_lazy_mmu_mode();
> +	tlb_end_ptes(tlb);
>  	pte_unmap_unlock(orig_pte, ptl);
>  	if (pageout)
>  		reclaim_pages(&page_list);
> @@ -588,7 +589,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  
>  	tlb_change_page_size(tlb, PAGE_SIZE);
>  	orig_pte = pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
> -	flush_tlb_batched_pending(mm);
> +	tlb_start_ptes(tlb);
>  	arch_enter_lazy_mmu_mode();
>  	for (; addr != end; pte++, addr += PAGE_SIZE) {
>  		ptent = *pte;
> @@ -692,6 +693,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>  		add_mm_counter(mm, MM_SWAPENTS, nr_swap);
>  	}
>  	arch_leave_lazy_mmu_mode();
> +	tlb_end_ptes(tlb);
>  	pte_unmap_unlock(orig_pte, ptl);
>  	cond_resched();
>  next:
> diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
> index 2ce6cf431026..063419ade304 100644
> --- a/mm/mapping_dirty_helpers.c
> +++ b/mm/mapping_dirty_helpers.c
> @@ -6,6 +6,8 @@
>  #include <asm/cacheflush.h>
>  #include <asm/tlb.h>
>  
> +#include "internal.h"
> +
>  /**
>   * struct wp_walk - Private struct for pagetable walk callbacks
>   * @range: Range for mmu notifiers
> @@ -36,7 +38,10 @@ static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
>  	pte_t ptent = *pte;
>  
>  	if (pte_write(ptent)) {
> -		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
> +		pte_t old_pte;
> +
> +		tlb_start_ptes(&wpwalk->tlb);
> +		old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
>  
>  		ptent = pte_wrprotect(old_pte);
>  		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
> @@ -44,6 +49,7 @@ static int wp_pte(pte_t *pte, unsigned long addr, unsigned long end,
>  
>  		if (pte_may_need_flush(old_pte, ptent))
>  			tlb_flush_pte_range(&wpwalk->tlb, addr, PAGE_SIZE);
> +		tlb_end_ptes(&wpwalk->tlb);
>  	}
>  
>  	return 0;
> @@ -94,13 +100,18 @@ static int clean_record_pte(pte_t *pte, unsigned long addr,
>  	if (pte_dirty(ptent)) {
>  		pgoff_t pgoff = ((addr - walk->vma->vm_start) >> PAGE_SHIFT) +
>  			walk->vma->vm_pgoff - cwalk->bitmap_pgoff;
> -		pte_t old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
> +		pte_t old_pte;
> +
> +		tlb_start_ptes(&wpwalk->tlb);
> +
> +		old_pte = ptep_modify_prot_start(walk->vma, addr, pte);
>  
>  		ptent = pte_mkclean(old_pte);
>  		ptep_modify_prot_commit(walk->vma, addr, pte, old_pte, ptent);
>  
>  		wpwalk->total++;
>  		tlb_flush_pte_range(&wpwalk->tlb, addr, PAGE_SIZE);
> +		tlb_end_ptes(&wpwalk->tlb);
>  
>  		__set_bit(pgoff, cwalk->bitmap);
>  		cwalk->start = min(cwalk->start, pgoff);
> diff --git a/mm/memory.c b/mm/memory.c
> index 9e8576a83147..929a93c50d9a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1221,6 +1221,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	init_rss_vec(rss);
>  	start_pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
>  	pte = start_pte;
> +	tlb_start_ptes(tlb);
>  	flush_tlb_batched_pending(mm);
>  	arch_enter_lazy_mmu_mode();
>  	do {
> @@ -1314,6 +1315,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  	add_mm_rss_vec(mm, rss);
>  	arch_leave_lazy_mmu_mode();
>  
> +	tlb_end_ptes(tlb);
>  	/* Do the actual TLB flush before dropping ptl */
>  	if (force_flush)
>  		tlb_flush_mmu_tlbonly(tlb);
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index b7473d2c9a1f..1258bbe42ee1 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -70,7 +70,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  	    atomic_read(&vma->vm_mm->mm_users) == 1)
>  		target_node = numa_node_id();
>  
> -	flush_tlb_batched_pending(vma->vm_mm);
> +	tlb_start_ptes(tlb);
>  	arch_enter_lazy_mmu_mode();
>  	do {
>  		oldpte = *pte;
> @@ -182,6 +182,7 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
>  		}
>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>  	arch_leave_lazy_mmu_mode();
> +	tlb_end_ptes(tlb);
>  	pte_unmap_unlock(pte - 1, ptl);
>  
>  	return pages;
> -- 
> 2.25.1
> 
> 
