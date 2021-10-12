Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530E442AC52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbhJLStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbhJLStG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:49:06 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02207C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:47:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so2622634pjw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DfbFY8+dvVdayrpl/HC8aWmEL5nQTdONvOQ8G8k3sdI=;
        b=btrJZ/IPtSJJEbgCzV6kLMKqVSQRPFad9W9idPv/BiZkJlo6bd8G81Kds8V+qlts68
         3bQnjkeOOxKIBW56arcH1rokJD7Au9TeVsJ8TJ+Z5zeMOmbsetfD1dwwfcHcz6Ypn0kq
         hM+nYHme6i+QiLuXnZc+fGlxFT9/zcx8u8iqhQ/6sSEjE12Dj53FwHia2CePuYV1/jkO
         faSxpMuKmvLzs/e1NY8UN9zkG/5P75+JRJbV8MPR8oi6a1W0SYyP6vgly4sUvh4UQEoP
         yGCsAs4zCy+iTJ0jhrZEFAcP5DBJ4XPOou6hakCEZOKj2fxsyuBfwVLPCkTnrkbgSqTq
         H41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DfbFY8+dvVdayrpl/HC8aWmEL5nQTdONvOQ8G8k3sdI=;
        b=TQiyfEJWRf+ywjGHfN0TCfLQvdDOXbOZYJfEdDRQfp3zsbt3A5j8MxICQjN1O2unfY
         ziCgQewjaKcaiYLYCwCujdVLf8pjY6VXI2QbvciRhmLDn+8pe/YbMZGxkyVgrxq/z1Me
         eWTJAKxIksx3XdrJd8yA9Mp28yX0OOd0uVTSSjgyvnA6M1wzsKCOLg6J0Oo3HEc8eZqg
         vYNrWqBFpsvwYoxKVD/PJjSqZ3QBNRkplvg2kAi3xUxiuyecY1alyHL73fiGKrLAxc9h
         Aw+kNJVjspXRq9qBGgcLs2/ku7yuOsMGMTFVvehfSukE01YCWroYPrpjTwf66UyCzBDo
         +L0g==
X-Gm-Message-State: AOAM532ycNwc83ngtxgHEWzvqTo4fK97u72Ss7icR5wfL5SD1aVrdsLS
        EmPxln1fWHZsobnba9/UIusulQ==
X-Google-Smtp-Source: ABdhPJw+X5MZoBakEaHZNsLbsAa4QxFgESLNxqGtJNcguDnKmi32hzC66ItirwvCxHpvHxMp0faMyQ==
X-Received: by 2002:a17:902:a710:b029:12b:9b9f:c461 with SMTP id w16-20020a170902a710b029012b9b9fc461mr31769695plq.59.1634064422208;
        Tue, 12 Oct 2021 11:47:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id w2sm11975808pfq.207.2021.10.12.11.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:47:01 -0700 (PDT)
Date:   Tue, 12 Oct 2021 18:46:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 26/45] KVM: SVM: Mark the private vma unmerable
 for SEV-SNP guests
Message-ID: <YWXYIWuK2T8Kejng@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-27-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820155918.7518-27-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021, Brijesh Singh wrote:
> When SEV-SNP is enabled, the guest private pages are added in the RMP
> table; while adding the pages, the rmp_make_private() unmaps the pages
> from the direct map. If KSM attempts to access those unmapped pages then
> it will trigger #PF (page-not-present).
> 
> Encrypted guest pages cannot be shared between the process, so an
> userspace should not mark the region mergeable but to be safe, mark the
> process vma unmerable before adding the pages in the RMP table.

To be safe from what?  Does the !PRESENT #PF crash the kernel?

> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kvm/svm/sev.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 4b126598b7aa..dcef0ae5f8e4 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -18,11 +18,13 @@
>  #include <linux/processor.h>
>  #include <linux/trace_events.h>
>  #include <linux/sev.h>
> +#include <linux/ksm.h>
>  #include <asm/fpu/internal.h>
>  
>  #include <asm/pkru.h>
>  #include <asm/trapnr.h>
>  #include <asm/sev.h>
> +#include <asm/mman.h>
>  
>  #include "x86.h"
>  #include "svm.h"
> @@ -1683,6 +1685,30 @@ static bool is_hva_registered(struct kvm *kvm, hva_t hva, size_t len)
>  	return false;
>  }
>  
> +static int snp_mark_unmergable(struct kvm *kvm, u64 start, u64 size)
> +{
> +	struct vm_area_struct *vma;
> +	u64 end = start + size;
> +	int ret;
> +
> +	do {
> +		vma = find_vma_intersection(kvm->mm, start, end);
> +		if (!vma) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> +				  MADV_UNMERGEABLE, &vma->vm_flags);
> +		if (ret)
> +			break;
> +
> +		start = vma->vm_end;
> +	} while (end > vma->vm_end);
> +
> +	return ret;
> +}
> +
>  static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  {
>  	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
> @@ -1707,6 +1733,12 @@ static int snp_launch_update(struct kvm *kvm, struct kvm_sev_cmd *argp)
>  	if (!is_hva_registered(kvm, params.uaddr, params.len))
>  		return -EINVAL;
>  
> +	mmap_write_lock(kvm->mm);
> +	ret = snp_mark_unmergable(kvm, params.uaddr, params.len);
> +	mmap_write_unlock(kvm->mm);

This does not, and practically speaking cannot, work.  There are multiple TOCTOU
bugs, here and in __snp_handle_page_state_change().  Userspace can madvise() the
range at any later point, munmap()/mmap() the entire range, mess with the memslots
in the PSC case, and so on and so forth.  Relying on MADV_UNMERGEABLE for functional
correctness simply cannot work in KVM, barring mmu_notifier and a big pile of code.

> +	if (ret)
> +		return -EFAULT;
> +
>  	/*
>  	 * The userspace memory is already locked so technically we don't
>  	 * need to lock it again. Later part of the function needs to know
> -- 
> 2.17.1
> 
