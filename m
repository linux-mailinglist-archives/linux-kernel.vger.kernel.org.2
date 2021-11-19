Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4344F4572E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbhKSQbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhKSQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:31:24 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96088C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:28:22 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so11368382pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ybj8leGqi8HAKT+pZnPyX6b+iagwbpbkNfSOtTdmlOk=;
        b=J3KzIZ9Bz7ZsQjbZNp2SLJAH7S0PF0ybPyaDvwLXqTkv3XKz8jVAjfzuxKtwJooWFX
         +Jv5JjK8VF8WfZvtfaAJfqw3iYK1phZs78z/4ivAS7EnhQNJZsOtd9nRKOBNIVTqIjCn
         3sSmRjFCPhh/D3BE+cneGg5PPH3gypU+auoNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ybj8leGqi8HAKT+pZnPyX6b+iagwbpbkNfSOtTdmlOk=;
        b=dW16M0DlNnJ55sSCXOyc+x57iiTKL5uO/y7HMZ0IVVG5SXhUuRL1WdQ4Fsdxeemb2b
         ayCJNfJM62W77anMR/XlLpx8ZLkYhkrzrASJTOHXU/UBv+UcH5kWSGirwPCpKIQLn04V
         jcUFsU/RWjOsm/cI5VDPJP5rgVdLNu4O+hYGj9vMOj+MffgTLlu+6tqTEm1ppynwJvfe
         auYzdsH26YhC/2iPM6ol/q2cY/ir1j8vs4HNEfR9Ug+49hpTCe1NEB3IibTw2atgovD4
         poBS+0gHtlgjtgo+sm7K7C3UwLqG8av4BjSPICCBQfRMSK8OkFUQbb3/hXM1cw9wcice
         K48w==
X-Gm-Message-State: AOAM533J0cT1q+oAJth1AOOEhLN+2V1Ns8aa7z4vMvgZsJ/DfvY/tK1o
        Hm3V9wL/pxBgW2S/h+WK5vNGpw==
X-Google-Smtp-Source: ABdhPJxRffQGESQhnw0mmGeDMIRmUJZyEDMjlQcKSSft47HbFV/oRz9Z37VmdGYBtBFL6i0yNPTRfg==
X-Received: by 2002:a17:90a:f002:: with SMTP id bt2mr956004pjb.221.1637339302086;
        Fri, 19 Nov 2021 08:28:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i13sm190799pgr.22.2021.11.19.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:28:21 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:28:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     LEROY Christophe <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        kernel test robot <lkp@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] powerpc/signal32: Use struct_group() to zero spe regs
Message-ID: <202111190824.AEBBE1328@keescook>
References: <20211118203604.1288379-1-keescook@chromium.org>
 <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e312cbd-cd52-ddce-f839-db765173c526@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2021 at 08:46:27AM +0000, LEROY Christophe wrote:
> 
> 
> Le 18/11/2021 à 21:36, Kees Cook a écrit :
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Add a struct_group() for the spe registers so that memset() can correctly reason
> > about the size:
> > 
> >     In function 'fortify_memset_chk',
> >         inlined from 'restore_user_regs.part.0' at arch/powerpc/kernel/signal_32.c:539:3:
> >     >> include/linux/fortify-string.h:195:4: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
> >       195 |    __write_overflow_field();
> >           |    ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> However, is it really worth adding that grouping ? Wouldn't it be 
> cleaner to handle evr[] and acc separately ? Now that we are using 
> unsafe variants of get/put user performance wouldn't be impacted.

I'm fine with whatever is desired here. I reworked an earlier version of
this patch based on mpe's feedback, so I can certain rework it again. :)

> 
> I have some doubts about things like:
> 
> 	unsafe_copy_to_user(&frame->mc_vregs, current->thread.evr,
> 				    ELF_NEVRREG * sizeof(u32), failed);
> 
> Because as far as I can see, ELF_NEVRREG is 34 but mc_vregs is a table 
> of 33 u32 and is at the end of the structure:
> 
> 	struct mcontext {
> 		elf_gregset_t	mc_gregs;
> 		elf_fpregset_t	mc_fregs;
> 		unsigned long	mc_pad[2];
> 		elf_vrregset_t	mc_vregs __attribute__((__aligned__(16)));
> 	};
> 
> 	typedef elf_vrreg_t elf_vrregset_t[ELF_NVRREG];
> 
> 	# define ELF_NEVRREG	34	/* includes acc (as 2) */
> 	# define ELF_NVRREG	33	/* includes vscr */

I don't know these internals very well -- do you want me to change this
specifically somehow? With the BUILD_BUG_ON()s added, there's no binary
change here -- I wanted to make sure nothing was different in the
output.

-Kees

> 
> 
> 
> > ---
> >   arch/powerpc/include/asm/processor.h |  6 ++++--
> >   arch/powerpc/kernel/signal_32.c      | 14 +++++++++-----
> >   2 files changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> > index e39bd0ff69f3..978a80308466 100644
> > --- a/arch/powerpc/include/asm/processor.h
> > +++ b/arch/powerpc/include/asm/processor.h
> > @@ -191,8 +191,10 @@ struct thread_struct {
> >   	int		used_vsr;	/* set if process has used VSX */
> >   #endif /* CONFIG_VSX */
> >   #ifdef CONFIG_SPE
> > -	unsigned long	evr[32];	/* upper 32-bits of SPE regs */
> > -	u64		acc;		/* Accumulator */
> > +	struct_group(spe,
> > +		unsigned long	evr[32];	/* upper 32-bits of SPE regs */
> > +		u64		acc;		/* Accumulator */
> > +	);
> >   	unsigned long	spefscr;	/* SPE & eFP status */
> >   	unsigned long	spefscr_last;	/* SPEFSCR value on last prctl
> >   					   call or trap return */
> > diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> > index 00a9c9cd6d42..5e1664b501e4 100644
> > --- a/arch/powerpc/kernel/signal_32.c
> > +++ b/arch/powerpc/kernel/signal_32.c
> > @@ -527,16 +527,20 @@ static long restore_user_regs(struct pt_regs *regs,
> >   	regs_set_return_msr(regs, regs->msr & ~(MSR_FP | MSR_FE0 | MSR_FE1));
> >   
> >   #ifdef CONFIG_SPE
> > -	/* force the process to reload the spe registers from
> > -	   current->thread when it next does spe instructions */
> > +	/*
> > +	 * Force the process to reload the spe registers from
> > +	 * current->thread when it next does spe instructions.
> > +	 * Since this is user ABI, we must enforce the sizing.
> > +	 */
> > +	BUILD_BUG_ON(sizeof(current->thread.spe) != ELF_NEVRREG * sizeof(u32));
> >   	regs_set_return_msr(regs, regs->msr & ~MSR_SPE);
> >   	if (msr & MSR_SPE) {
> >   		/* restore spe registers from the stack */
> > -		unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
> > -				      ELF_NEVRREG * sizeof(u32), failed);
> > +		unsafe_copy_from_user(&current->thread.spe, &sr->mc_vregs,
> > +				      sizeof(current->thread.spe), failed);
> >   		current->thread.used_spe = true;
> >   	} else if (current->thread.used_spe)
> > -		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
> > +		memset(&current->thread.spe, 0, sizeof(current->thread.spe));
> >   
> >   	/* Always get SPEFSCR back */
> >   	unsafe_get_user(current->thread.spefscr, (u32 __user *)&sr->mc_vregs + ELF_NEVRREG, failed);
> > 

-- 
Kees Cook
