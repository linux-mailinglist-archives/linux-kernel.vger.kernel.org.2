Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CC343C725
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhJ0KCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 06:02:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36602 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241319AbhJ0KBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 06:01:16 -0400
Received: from zn.tnic (p200300ec2f1615002935f4cf24b5c3ba.dip0.t-ipconnect.de [IPv6:2003:ec:2f16:1500:2935:f4cf:24b5:c3ba])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0AEA21EC0622;
        Wed, 27 Oct 2021 11:58:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1635328730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2wrxbVGiHtT+851EEfdKGyPl86mZcd8DuPl474V4X3A=;
        b=V7pD81yavCzYcUTcnGLcrh8YBeGocCi04kKDc2MI44q3reuowzVOlm0LQLnXf6oDlZPooE
        sKvm1UlJ8e3qSoJXI15IRq406831yaL71wCPZEgWiAN/2qbSE+jT158c7wGpxWQ1HtgLI9
        ZsnYQENEpleqVCsR4q2lEro/W2ullSg=
Date:   Wed, 27 Oct 2021 11:58:45 +0200
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
Subject: Re: [PATCH v3 3/4] x86/mm: Flush global TLB when switching to
 trampoline page-table
Message-ID: <YXki1Zx4jCmikBuf@zn.tnic>
References: <20211001154817.29225-1-joro@8bytes.org>
 <20211001154817.29225-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211001154817.29225-4-joro@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01, 2021 at 05:48:16PM +0200, Joerg Roedel wrote:
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index 31b5856010cb..b9802b18f504 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -17,6 +17,29 @@ u32 *trampoline_cr4_features;
>  /* Hold the pgd entry used on booting additional CPUs */
>  pgd_t trampoline_pgd_entry;
>  
> +void load_trampoline_pgtable(void)
> +{
> +#ifdef CONFIG_X86_32
> +	load_cr3(initial_page_table);
> +#else
> +	/* Exiting long mode will fail if CR4.PCIDE is set. */

So this comment is not valid anymore if this is a separate function - it
is valid only when that function is called in reboot.c so I guess you
should leave that comment there.

> +	if (boot_cpu_has(X86_FEATURE_PCID))
> +		cr4_clear_bits(X86_CR4_PCIDE);
> +
> +	write_cr3(real_mode_header->trampoline_pgd);

Is there any significance to the reordering of those calls here? The
commit message doesn't say...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
