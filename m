Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1661632D4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhCDOHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:07:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239549AbhCDOGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:06:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E38AB64EEC;
        Thu,  4 Mar 2021 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614866768;
        bh=1dXhPHcdLiOgxzEHJx0A7ZK7YsqkFUlqYImM4D6WVdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlGpZRnGSxPTSr+AY8pgAiSms8x+YYKquffA2x0ApYgl6yRgalGYhrmrc37OzlIzp
         VZ2GtuxlvDh6p9HWHthhiPHMU0iIZ3SvZdMa3NP70IeJpkoKEPAdVh9+ZSR/eK9UV1
         iv5u1/Lh692rC4Lb0j4PJvNC0anvYYeEXaTlFNkM7m8fbX1lWrYBQX/gfqqvrXOBfv
         9BB0kxeL3AfbJ1jApFr0Q8sUP0dwn7Tyl2stprU0dST8dGjtdlLlo4Eh3++eXZ2MB6
         872gei5nFmauoLJYvc1deoe8SvrJMPjWQrpfBRVajyPmOU6MFyMJAJzaMobejqYHuk
         RRRgyPIJzCFTw==
Date:   Thu, 4 Mar 2021 14:06:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 06/32] KVM: arm64: Factor memory allocation out of
 pgtable.c
Message-ID: <20210304140602.GC21229@willie-the-truck>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-7-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302150002.3685113-7-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 02:59:36PM +0000, Quentin Perret wrote:
> In preparation for enabling the creation of page-tables at EL2, factor
> all memory allocation out of the page-table code, hence making it
> re-usable with any compatible memory allocator.
> 
> No functional changes intended.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h | 41 +++++++++++-
>  arch/arm64/kvm/hyp/pgtable.c         | 98 +++++++++++++++++-----------
>  arch/arm64/kvm/mmu.c                 | 66 ++++++++++++++++++-
>  3 files changed, 163 insertions(+), 42 deletions(-)

Just a few nits:

> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> index 8886d43cfb11..3c306f90f7da 100644
> --- a/arch/arm64/include/asm/kvm_pgtable.h
> +++ b/arch/arm64/include/asm/kvm_pgtable.h
> @@ -13,17 +13,50 @@
>  
>  typedef u64 kvm_pte_t;
>  
> +/**
> + * struct kvm_pgtable_mm_ops - Memory management callbacks.
> + * @zalloc_page:	Allocate a single zeroed memory page. The @arg parameter
> + *			can be used by the walker to pass a memcache. The
> + *			initial refcount of the page is 1.
> + * @zalloc_pages_exact:	Allocate an exact number of zeroed memory pages. The
> + *			@size parameter is in bytes, it is automatically rounded
> + *			to PAGE_SIZE and the resulting allocation is physically
> + *			contiguous.

It's not clear to me whether "it is automatically rounded to PAGE_SIZE"
means that the caller or the callee does the rounding. If it's the caller,
maybe it would be better to pass the number of pages as an 'npages' argument
instead of the size in bytes?

> + * @free_pages_exact:	Free an exact number of memory pages, to free memory
> + *			allocated with zalloc_pages_exact.

"Free an exact number of memory pages previously allocated by
 zalloc_pages_exact()"


> + * @get_page:		Increment the refcount on a page.
> + * @put_page:		Decrement the refcount on a page. When the refcount
> + *			reaches 0 the page is automatically freed.
> + * @page_count:		Return the refcount of a page.
> + * @phys_to_virt:	Convert a physical address into a virtual address as
> + *			accessible in the current context.

s/as accessible/mapped/

With those changes:

Acked-by: Will Deacon <will@kernel.org>

Will
