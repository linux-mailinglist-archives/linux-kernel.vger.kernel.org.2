Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1B333B38
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhCJLQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:16:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhCJLQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:16:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11BAA64FCB;
        Wed, 10 Mar 2021 11:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615375014;
        bh=C1VoDQKlIyJ1+nzA/Wf/O69QQ2pK9i73dDn//SNSEaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cTAaDy2FK8y6Vilcsq2+9RlAsua1MAyRNcX7f/jInV2ZinChR7DSHtXQgPV872V1v
         AWUBPfU4l/j2B+FiX7hjHkURG0meYFKulgNNyVA7RmRcvBGDnOvuXAfwWdx04+bdic
         D3JVpdZCamSjxaWJ0FNWpy9/TeI4jVNScKhcNlKSaH2hdHlRmYwFF9f3V+bSwyS0OP
         RgnV5k9ScuJ+TPbsFHmDpZoC+G3ySHkKsbrqF6QnRPKkALurWvHnMfbuvfKEanwE+Y
         70eAU4jlhyv3dUWVewIf+0Hhmeg5vLiZZ81rY5RhnWTyVENLP/hKoDCeauHFzXfiG+
         bku0b6hYgxaDg==
Date:   Wed, 10 Mar 2021 11:16:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: mm: fix runtime fallback to 48-bt VA when 52-bit
 VA is enabled
Message-ID: <20210310111649.GA29413@willie-the-truck>
References: <20210310003216.410037-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310003216.410037-1-msalter@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 07:32:16PM -0500, Mark Salter wrote:
> I ran into an early boot soft lockup on a Qualcomm Amberwing using a v5.11
> kernel configured for 52-bit VA. This turned into a panic with a v5.12-rc2
> kernel.
> 
> The problem is that when we fall back to 48-bit VA, idmap_t0sz is not
> updated. Later, the kvm hypervisor uses idmap_t0sz to set its tcr_el2 and
> hangs (v5.11). After commit 1401bef703a4 ("arm64: mm: Always update TCR_EL1
> from __cpu_set_tcr_t0sz()"), the kernel panics when trying to use the idmap
> to call idmap_cpu_replace_ttbr1().
> 
> Oddly, other systems (thunderX2 and Ampere eMag) which don't support 52-bit
> VA seem to handle the setting of an unsupported t0sz without any apparent
> problems. Indeed, if one reads back the tcr written with t0sz==12, the
> value read has t0sz==16. Not so with Amberwing.

Nice, you have one of those elusive platforms!

> Fixes: 90ec95cda91a ("arm64: mm: Introduce VA_BITS_MIN")
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/arm64/kernel/head.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 66b0e0b66e31..2bcbbb26292e 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -291,6 +291,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	 */
>  	adrp	x0, idmap_pg_dir
>  	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
> +	mov	x4, TCR_T0SZ(VA_BITS)
>  
>  #ifdef CONFIG_ARM64_VA_BITS_52
>  	mrs_s	x6, SYS_ID_AA64MMFR2_EL1
> @@ -299,6 +300,13 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	cbnz	x6, 1f
>  #endif
>  	mov	x5, #VA_BITS_MIN
> +#ifdef CONFIG_ARM64_VA_BITS_52
> +	mov	x4, TCR_T0SZ(VA_BITS_MIN)
> +	adr_l	x6, idmap_t0sz
> +	str	x4, [x6]
> +	dmb	sy
> +	dc	ivac, x6		// Invalidate potentially stale cache line
> +#endif
>  1:
>  	adr_l	x6, vabits_actual
>  	str	x5, [x6]
> @@ -319,7 +327,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	 */
>  	adrp	x5, __idmap_text_end
>  	clz	x5, x5
> -	cmp	x5, TCR_T0SZ(VA_BITS)	// default T0SZ small enough?
> +	cmp	x5, x4			// default T0SZ small enough?
>  	b.ge	1f			// .. then skip VA range extension

Could we instead have the default value be 48-bit, and then avoid having
to update the variable in both cases? e.g. something along the lines of
the entirely untested diff below?

Cheers,

Will

--->8

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 66b0e0b66e31..fb795123896f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -319,7 +319,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
         */
        adrp    x5, __idmap_text_end
        clz     x5, x5
-       cmp     x5, TCR_T0SZ(VA_BITS)   // default T0SZ small enough?
+       cmp     x5, TCR_T0SZ(VA_BITS_MIN)       // default T0SZ small enough?
        b.ge    1f                      // .. then skip VA range extension
 
        adr_l   x6, idmap_t0sz
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 3802cfbdd20d..4c5603c41870 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -40,7 +40,7 @@
 #define NO_BLOCK_MAPPINGS      BIT(0)
 #define NO_CONT_MAPPINGS       BIT(1)
 
-u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
+u64 idmap_t0sz = TCR_T0SZ(VA_BITS_MIN);
 u64 idmap_ptrs_per_pgd = PTRS_PER_PGD;
 
 u64 __section(".mmuoff.data.write") vabits_actual;

