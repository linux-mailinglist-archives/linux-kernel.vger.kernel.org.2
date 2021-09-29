Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70CA41CD32
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346625AbhI2UJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:09:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45192 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346400AbhI2UIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:08:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632946025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlsVknWTVdSlZTHHBhOHbdQ8+OQgty9cJuZLKmK8P4Q=;
        b=gvDSGy6EoQ/SGIQIZFDmJHsfEB7eJkkPqMOISO+qHnFj07TZ3W58Un23BsrO2SJOP5oI/M
        aJO6guQUBAH8/Bk3qH6nN/ewix1KG2QJPceX0aA6/YB23G/6szPYeahrHYodGiUTa4sJw3
        /FZWsXw6mEh7VhBM6VWjUtpfmJ1MyBQ8gH/Kr4jh+xX9i1jTFxiEtMvT5ITfqV2Zdl2iut
        hDO+T4lF0i5fNNlgiuPwCsI0IT4sX4rI8ZFOy5cT5/HIqRV+vFvuNtSUEuzm/YJTXjGs+b
        b7pZjQr/eDgA9a/2lygRLPEDQUzWaXs9+DASg2sA1gUEIKFp2AwCtM3qayMPgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632946025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tlsVknWTVdSlZTHHBhOHbdQ8+OQgty9cJuZLKmK8P4Q=;
        b=icQDdrktOulCIkwKp/cwu1bpceb+vYu4ltjmHgN1zZFbMrIXdWbqAISaG/oKDVP8Nru7Uq
        HTEWYV63v6AU54Cg==
To:     "Luck, Tony" <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/8] x86/mmu: Add mm-based PASID refcounting
In-Reply-To: <YVSw/6BAFvh9C+ct@agluck-desk2.amr.corp.intel.com>
References: <87o88jfajo.ffs@tglx> <87k0j6dsdn.ffs@tglx>
 <YU3414QT0J7EN4w9@agluck-desk2.amr.corp.intel.com>
 <a77ee33c-6fa7-468c-8fc0-a0a2ce725e75@www.fastmail.com>
 <YVQ3wc/XjeOHpGCX@hirez.programming.kicks-ass.net> <87r1d78t2e.ffs@tglx>
 <75e95acc-6730-ddcf-d722-66e575076256@kernel.org> <877dez8fqu.ffs@tglx>
 <YVSlVv/j+WKftUU5@agluck-desk2.amr.corp.intel.com>
 <YVSrWouhMo2JxRCC@otcwcpicx3.sc.intel.com>
 <YVSw/6BAFvh9C+ct@agluck-desk2.amr.corp.intel.com>
Date:   Wed, 29 Sep 2021 22:07:04 +0200
Message-ID: <874ka387tj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29 2021 at 11:31, Tony Luck wrote:
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index a58800973aed..5a3c87fd65de 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -528,6 +528,32 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  
>  #define GPFSTR "general protection fault"
>  
> +/*
> + * When a user executes the ENQCMD instruction it will #GP
> + * fault if the IA32_PASID MSR has not been set up with a
> + * valid PASID.
> + * So if the process has been allocated a PASID (mm->pasid)
> + * AND the IA32_PASID MSR has not been initialized, try to
> + * fix this #GP by initializing the IA32_PASID MSR.
> + * If the #GP was for some other reason, it will trigger
> + * again, but this routine will return false and the #GP
> + * will be processed.
> + */
> +static void try_fixup_pasid(void)
> +{
> +	if (!cpu_feature_enabled(X86_FEATURE_ENQCMD))
> +		return false;
> +
> +#ifdef CONFIG_IOMMU_SUPPORT
> +	if (current->mm->pasid && !current->pasid_activated) {
> +		current->pasid_activated = 1;
> +		wrmsrl(MSR_IA32_PASID, current->mm->pasid);
> +		return true;
> +	}
> +#endif
> +	return false;
> +}
> +
>  DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
> @@ -536,6 +562,9 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	unsigned long gp_addr;
>  	int ret;
>  
> +	if (user_mode(regs) && try_fixup_pasid())
> +		return;
> +
>  	cond_local_irq_enable(regs);
>  
>  	if (static_cpu_has(X86_FEATURE_UMIP)) {

Amen.
