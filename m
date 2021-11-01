Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788EB44142D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhKAHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhKAHa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:30:56 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C057CC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 00:28:22 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id y128so23733168oie.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 00:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=RqW8CwN/3q/RALu15iJaJH7Zr+D0ZVGcpdYZqRlJVMw=;
        b=lW5k9kzlcOkGK7tJxfQULZe0wiPyT9adRYYK3WkK6qLsoj8iTOXgEiPxcoXaJIqq2v
         3++kx/xE3FZa/SqwzEWOBK/euOLsMbrogZS4cW00dAB3HRJKD17SQMV9+kyXdS1eGdmS
         jUuCLp0g4qk9876DnNLLMrss3QPq+2RcJAUfDKM6a9uNJjm/577OE26cxZBB4z8wcff9
         em89wgMLo182njbaYS10QEcvMqg+GaQLGCx6GrS4GSoKdFOhiouuU0IlBACsekBVtmC0
         79HHt1nRvT6mK4AvCFUrqn4Rk1rrMFSFJZbmKdSwYdQWwhw1WeBB2ZXHHPwczxZ8QI0i
         fxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=RqW8CwN/3q/RALu15iJaJH7Zr+D0ZVGcpdYZqRlJVMw=;
        b=nKh64qWgYaxzAkRsLy6M+3Ek5oqSEx1bOhBaROzZqSIo7FZAaq4R9DNpoyKSiTPvh0
         4QIphn0Z8ecJoT1SEobjQxuHoWIpPGeeTAYpSssTFt8nz64x0bD7/noMP5ejvjkLEUBQ
         jhaGcqW96hrq8DDXkZGRAmh14ATjoFxTEZdITv+5p+LqsUgh4WgNCntOuYwOvnnJ/bvW
         HJHCo8dlLe6LV4bnlwhMn5zcZV9dEMqd962f/FnDeLptYYfmij0GCQHK2x8FW9W3KFDt
         s+o0Q1xrDsWR4tGFgS1pUE91j+S/vADQj88noqBe+RAhCGQWZZCPn4+cW4MoYxANB3Mk
         uImA==
X-Gm-Message-State: AOAM53144oCXM71ZjqaMNikDdKv8EIGeTX7Pxat36Msa04tx0jcR6Lf1
        FH2bdpl+NF9M7UOdZsL7Efj8vOgR+t8zlg==
X-Google-Smtp-Source: ABdhPJyt+tBZx8cu4zcyrRQwwQRI3i2jTEQ/9gTdRpP/7DwpTz9aSswMcGqwN04otMfTmAMuGDoknA==
X-Received: by 2002:a05:6808:13ca:: with SMTP id d10mr1417922oiw.154.1635751701966;
        Mon, 01 Nov 2021 00:28:21 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y4sm4147170ots.73.2021.11.01.00.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 00:28:21 -0700 (PDT)
Date:   Mon, 1 Nov 2021 00:28:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Nadav Amit <nadav.amit@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>, x86@kernel.org
Subject: Re: [PATCH] mm: use correct VMA flags when freeing page-tables
In-Reply-To: <20211021122322.592822-1-namit@vmware.com>
Message-ID: <80283a1e-dfab-c02b-7a6a-424e2f7fda4@google.com>
References: <20211021122322.592822-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Oct 2021, Nadav Amit wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> Consistent use of the mmu_gather interface requires a call to
> tlb_start_vma() and tlb_end_vma() for each VMA. free_pgtables() does not
> follow this pattern.
> 
> Certain architectures need tlb_start_vma() to be called in order for
> tlb_update_vma_flags() to update the VMA flags (tlb->vma_exec and
> tlb->vma_huge), which are later used for the proper TLB flush to be
> issued. Since tlb_start_vma() is not called, this can lead to the wrong
> VMA flags being used when the flush is performed.
> 
> Specifically, the munmap syscall would call unmap_region(), which unmaps
> the VMAs and then frees the page-tables. A flush is needed after
> the page-tables are removed to prevent page-walk caches from holding
> stale entries, but this flush would use the flags of the VMA flags of
> the last VMA that was flushed. This does not appear to be right.
> 
> Use tlb_start_vma() and tlb_end_vma() to prevent this from happening.
> This might lead to unnecessary calls to flush_cache_range() on certain
> arch's. If needed, a new flag can be added to mmu_gather to indicate
> that the flush is not needed.
> 
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: x86@kernel.org
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  mm/memory.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 12a7b2094434..056fbfdd3c1f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -412,6 +412,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		unlink_anon_vmas(vma);
>  		unlink_file_vma(vma);
>  
> +		tlb_start_vma(tlb, vma);
> +
>  		if (is_vm_hugetlb_page(vma)) {
>  			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next ? next->vm_start : ceiling);
> @@ -429,6 +431,8 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next ? next->vm_start : ceiling);
>  		}
> +
> +		tlb_end_vma(tlb, vma);
>  		vma = next;
>  	}
>  }
> -- 
> 2.25.1

No.

This is an experiment to see whether reviewers look at a wider context
than is seen in the patch itself?  Let's take a look:

		tlb_start_vma(tlb, vma);

		if (is_vm_hugetlb_page(vma)) {
			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
				floor, next ? next->vm_start : ceiling);
		} else {
			/*
			 * Optimization: gather nearby vmas into one call down
			 */
			while (next && next->vm_start <= vma->vm_end + PMD_SIZE
			       && !is_vm_hugetlb_page(next)) {
				vma = next;
				next = vma->vm_next;
				unlink_anon_vmas(vma);
				unlink_file_vma(vma);
			}
			free_pgd_range(tlb, addr, vma->vm_end,
				floor, next ? next->vm_start : ceiling);
		}

		tlb_end_vma(tlb, vma);
		vma = next;

So, the vma may well have changed in between the new tlb_start_vma()
and tlb_end_vma(): which defeats the intent of the patch.

And I doubt that optimization should be dropped to suit the patch:
you admit to limited understanding of those architectures which need
tlb_start_vma(), me too; but they seem to have survived many years
without it there in free_pgtables(), and I think that tlb_start_vma()
is for when freeing pages, not for when freeing page tables.  Surely
all architectures have to accommodate the fact that a single page
table can be occupied by many different kinds of vma.

(Sorry, I'm being totally unresponsive at present, needing to focus
on something else; but thought I'd better get these comments in before
mmotm's mm-use-correct-vma-flags-when-freeing-page-tables.patch goes to 5.16.)

Hugh
