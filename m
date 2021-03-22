Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D003440BE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCVMUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230181AbhCVMTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:19:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABA2561931;
        Mon, 22 Mar 2021 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415580;
        bh=zxvtl3PRlnpYihKBjGGbYEnphB4RPLOnR1v6ZTzVfpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VfH7sTai0KRWXoYiOFlksoJNw2XBUTqCsY5sDJ57R/rIs8d8BzPDnd1zjO+7LhXfy
         xEr4VQVWnMUbPpwjhlNewaBCrJzcJtRCjVn7QxsW8c0SHdelUCqgJaN6wcwXV42ZGm
         PE0VViNDkQIL5F+jt3Uqz+8ifWlxrGPA0BIX+wNS9P8OBZaipqo2zu+uCh1Iijbkn0
         CqYlZFhG4HVQormI3akb+jctDHE5rWt7+pQtPDj41pVNDgnZH4RqnGtljpkwFxvyU8
         6WBAKVnmHYuBAlecMcHswKfQzTCtYNTt2JuMGIFUc9orDb5ZWXOr32lj0t1HfVxf2n
         q2Obv5gOY9Gzg==
Date:   Mon, 22 Mar 2021 12:19:34 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v6 32/38] KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB
 stage 2 flag
Message-ID: <20210322121934.GE10318@willie-the-truck>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-33-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319100146.1149909-33-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 10:01:40AM +0000, Quentin Perret wrote:
> In order to further configure stage 2 page-tables, pass flags to the
> init function using a new enum.
> 
> The first of these flags allows to disable FWB even if the hardware
> supports it as we will need to do so for the host stage 2.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/include/asm/kvm_pgtable.h  | 43 +++++++++++++-------
>  arch/arm64/include/asm/pgtable-prot.h |  4 +-
>  arch/arm64/kvm/hyp/pgtable.c          | 56 +++++++++++++++------------
>  3 files changed, 62 insertions(+), 41 deletions(-)

[...]

> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index 9a65fb528110..079f4e9a3e84 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -71,10 +71,10 @@ extern bool arm64_use_ng_mappings;
>  #define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
>  #define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
>  
> -#define PAGE_S2_MEMATTR(attr)						\
> +#define PAGE_S2_MEMATTR(attr, has_fwb)					\
>  	({								\
>  		u64 __val;						\
> -		if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))		\
> +		if (has_fwb)						\
>  			__val = PTE_S2_MEMATTR(MT_S2_FWB_ ## attr);	\
>  		else							\
>  			__val = PTE_S2_MEMATTR(MT_S2_ ## attr);		\

Given that this isn't used outside of pgtable.c, I wonder if we should move
it in there, as it's a pretty low-level thing to do now that it takes the
'has_fwb' parameter.

But regardless,

Acked-by: Will Deacon <will@kernel.org>

Will
