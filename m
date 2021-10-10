Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D81427F3E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 07:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbhJJFbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 01:31:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhJJFbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 01:31:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B969608FE;
        Sun, 10 Oct 2021 05:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633843794;
        bh=eHFnTDoBrLpZXdBQbujr2Cswj6WvddXJYT4qVIu7jts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=my+A/rdRN93FNGZhI3TpZWC6QVYpIPlOqBaadqubmF4PfP1rMeyf/Xl46E9v4UJeb
         1d7fpHsWJ9Ymq6Qh1awQZUgK0IwJ1mUxVDmTxnkcE+c2i7Qk3gt2s6qPHv+D8og8rU
         75pTIgEA7Ye4VXySMtCwt4uuzQXwotJ0xlVKOvNPfF8aTXaTyr1vkn788BkaWDzsyJ
         S2kD9rk3cJwAGTEazlUYBtfxUDcDdJlKTyV534v400GTDiEZVHh7WGhlcdvU/Y4l+8
         5H42kzADfWKXAbPiRZJcYj1CeHkdbpyWKty93CEo1NNMeOt3z2w2PXh2axwVKEhaos
         naNlvC7lBiOOA==
Date:   Sun, 10 Oct 2021 08:29:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Stephen <stephenackerman16@gmail.com>
Subject: Re: [PATCH] mm: Fix NULL page->mapping dereference in
 page_is_secretmem()
Message-ID: <YWJ6TH2KZ4K1U80g@kernel.org>
References: <20211007231502.3552715-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007231502.3552715-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 04:15:02PM -0700, Sean Christopherson wrote:
> Check for a NULL page->mapping before dereferencing the mapping in
> page_is_secretmem(), as the page's mapping can be nullified while gup()
> is running, e.g. by reclaim or truncation.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000068
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 0 P4D 0
>   Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 6 PID: 4173897 Comm: CPU 3/KVM Tainted: G        W
>   RIP: 0010:internal_get_user_pages_fast+0x621/0x9d0
>   Code: <48> 81 7a 68 80 08 04 bc 0f 85 21 ff ff 8 89 c7 be
>   RSP: 0018:ffffaa90087679b0 EFLAGS: 00010046
>   RAX: ffffe3f37905b900 RBX: 00007f2dd561e000 RCX: ffffe3f37905b934
>   RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffe3f37905b900
>   ...
>   CR2: 0000000000000068 CR3: 00000004c5898003 CR4: 00000000001726e0
>   Call Trace:
>    get_user_pages_fast_only+0x13/0x20
>    hva_to_pfn+0xa9/0x3e0
>    try_async_pf+0xa1/0x270
>    direct_page_fault+0x113/0xad0
>    kvm_mmu_page_fault+0x69/0x680
>    vmx_handle_exit+0xe1/0x5d0
>    kvm_arch_vcpu_ioctl_run+0xd81/0x1c70
>    kvm_vcpu_ioctl+0x267/0x670
>    __x64_sys_ioctl+0x83/0xa0
>    do_syscall_64+0x56/0x80
>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-mm@kvack.org
> Reported-by: Darrick J. Wong <djwong@kernel.org>
> Reported-by: Stephen <stephenackerman16@gmail.com>
> Tested-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/secretmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/secretmem.h b/include/linux/secretmem.h
> index 21c3771e6a56..988528b5da43 100644
> --- a/include/linux/secretmem.h
> +++ b/include/linux/secretmem.h
> @@ -23,7 +23,7 @@ static inline bool page_is_secretmem(struct page *page)
>  	mapping = (struct address_space *)
>  		((unsigned long)page->mapping & ~PAGE_MAPPING_FLAGS);
>  
> -	if (mapping != page->mapping)
> +	if (!mapping || mapping != page->mapping)
>  		return false;
>  
>  	return mapping->a_ops == &secretmem_aops;
> -- 
> 2.33.0.882.g93a45727a2-goog
> 

-- 
Sincerely yours,
Mike.
