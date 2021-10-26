Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0167343AF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 11:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhJZJ6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 05:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhJZJ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 05:58:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBB8C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 02:55:49 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131c00c83ef6486df21458.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1c00:c83e:f648:6df2:1458])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A09811EC05C4;
        Tue, 26 Oct 2021 11:55:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635242147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/nGiaXUNK1wAqib06XNY7mg/5wjjoqOtEItIBicF8Vo=;
        b=K7aIzw5TiHL42ToOC/uvdU+O5/xQYJLI9zsODuQFRTPeEIgjGAZ7IQP0kpWcggngcDgtEK
        ZyVA4ojdNeP9qu/xP1S8mIIt+T9hmYXUjhZ24r9Q2uTn1O3qKmZgZvOClthnZrLNdjMbB7
        5SQzvV6scy4CA0/TuTjgmQVeqnJRhzY=
Date:   Tue, 26 Oct 2021 11:55:44 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] x86/mm/64: Flush global TLB on boot and AP bringup
Message-ID: <YXfQoO0McyPiOFwz@zn.tnic>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-3-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211001154817.29225-3-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:48:15PM +0200, Joerg Roedel wrote:
> +/*
> + * The __flush_tlb_all() function uses all kinds of state which is not
> + * initialized that early and can not be used here. So the helper below is used
> + * to flush global TLB entries.
> + */
> +static void __init early_flush_tlb_global(void)
> +{
> +	unsigned long cr4 = native_read_cr4();
> +
> +	native_write_cr4(cr4 ^ X86_CR4_PGE);
> +	native_write_cr4(cr4);
> +}

Please make sure now and in the future to avoid such duplication - diff
ontop, for a possible way to do this, at the end.

>  asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  {
>  	/*
> @@ -478,6 +491,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>  	/* Kill off the identity-map trampoline */
>  	reset_early_page_tables();
>  
> +	early_flush_tlb_global();
> +
>  	clear_bss();
>  
>  	clear_page(init_top_pgt);
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index d8b3ebd2bb85..bd4b6ebafdc3 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -166,9 +166,26 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
>  	call	sev_verify_cbit
>  	popq	%rsi
>  
> -	/* Switch to new page-table */
> +	/*
> +	 * Switch to new page-table
> +	 *
> +	 * For the boot CPU this switches to early_top_pgt which still has the
> +	 * indentity mappings present. The secondary CPUs will switch to the
> +	 * init_top_pgt here, away from the trampoline_pgd and unmapping the

"... unmap the... "

> +	 * indentity mapped ranges.
> +	 *
> +	 * Do a global TLB flush after the CR3 switch to make sure the TLB
> +	 * entries from the identity mapping are flushed.

Put this comment...

> +	 */
>  	movq	%rax, %cr3
>  
> +	/* Flush global TLB entries - only needed for secondary CPUs */

... here instead of this one.

> +	movq	%cr4, %rcx
> +	movq	%rcx, %rax
> +	xorq	$X86_CR4_PGE, %rcx
> +	movq	%rcx, %cr4
> +	movq	%rax, %cr4
> +
>  	/* Ensure I am executing from virtual addresses */
>  	movq	$1f, %rax
>  	ANNOTATE_RETPOLINE_SAFE
> -- 

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index b587a9ee9cb2..98fa0a114074 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -261,4 +261,9 @@ extern void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
 #endif /* !MODULE */
 
+static inline void __native_tlb_flush_global(unsigned long cr4)
+{
+	native_write_cr4(cr4 ^ X86_CR4_PGE);
+	native_write_cr4(cr4);
+}
 #endif /* _ASM_X86_TLBFLUSH_H */
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 0a93b24d7604..75acb6027a87 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -462,19 +462,6 @@ static void __init copy_bootdata(char *real_mode_data)
 	sme_unmap_bootdata(real_mode_data);
 }
 
-/*
- * The __flush_tlb_all() function uses all kinds of state which is not
- * initialized that early and can not be used here. So the helper below is used
- * to flush global TLB entries.
- */
-static void __init early_flush_tlb_global(void)
-{
-	unsigned long cr4 = native_read_cr4();
-
-	native_write_cr4(cr4 ^ X86_CR4_PGE);
-	native_write_cr4(cr4);
-}
-
 asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 {
 	/*
@@ -496,7 +483,7 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
 	/* Kill off the identity-map trampoline */
 	reset_early_page_tables();
 
-	early_flush_tlb_global();
+	__native_tlb_flush_global(native_read_cr4());
 
 	clear_bss();
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 59ba2968af1b..1e6513f95133 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1148,7 +1148,7 @@ void flush_tlb_one_user(unsigned long addr)
  */
 STATIC_NOPV void native_flush_tlb_global(void)
 {
-	unsigned long cr4, flags;
+	unsigned long flags;
 
 	if (static_cpu_has(X86_FEATURE_INVPCID)) {
 		/*
@@ -1168,11 +1168,7 @@ STATIC_NOPV void native_flush_tlb_global(void)
 	 */
 	raw_local_irq_save(flags);
 
-	cr4 = this_cpu_read(cpu_tlbstate.cr4);
-	/* toggle PGE */
-	native_write_cr4(cr4 ^ X86_CR4_PGE);
-	/* write old PGE again and flush TLBs */
-	native_write_cr4(cr4);
+	__native_tlb_flush_global(this_cpu_read(cpu_tlbstate.cr4));
 
 	raw_local_irq_restore(flags);
 }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
