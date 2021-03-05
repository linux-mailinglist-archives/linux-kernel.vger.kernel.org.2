Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC61E32E47D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCEJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhCEJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:14:49 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:14:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id w203-20020a1c49d40000b029010c706d0642so5682688wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NiGdJYWOwk1ggBwvtk4IUuiZlQG7Jo/ZpYTDhsXbulA=;
        b=oygQwv/uuVsd5nAZHELl0vYZAwL1bEnGaj9F3FXEjO1aDtyUsCLlSZH4VFoz/BZ23Z
         7JIaatV3Cn/gtHUE7gdSWrBwMvwL/NvBQK1PMENx0Wir+Tc6ixUoZc4M5AY2FQw9GKY4
         W8HXdZ8mlFrB0aEfVyFtMhMjYrgcDEXeh9i4/7fOtRGgGfEEK5hhkjJCRtSKHd7Swo47
         z8/GZ+YMn11E+eKb7xKCqzlCyzhXX3fVVGmHj3/EGo42mar1WRyA3AstJ3TTywM7X1ZK
         87XFFzISGMbXifIvG3xDD9g9dMcbvJlF67H3BiIcQHg6xDxPNr6QrjHzDHGWfdaeeJEa
         eR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NiGdJYWOwk1ggBwvtk4IUuiZlQG7Jo/ZpYTDhsXbulA=;
        b=RP8YW94YkI6rlDuvMJdxYWhhWeJWSJvKYzExe6et0LdzjUX1fPWL9t6Q2fEBY2aKOL
         HHlMu+2x1B+OFrkIJF26j+Ycj7mdsJPOO3ggmh3JPgbxNQM+jVq4cdnMBiTEyTZTgubl
         XodTDB2hymzfxSU8wtXaDFrKt6+ECh1v8MKqJ4g7masbaqi4klxVbp3LayEdKWCX8ln/
         AFBEEkOW9d+va+41aJdDGjYqlvFhW1zZY1kuaysAGIeZQv+DH3JJEG6KiALdg9HMNgoK
         TIc8Ui/IIE9qOLV3GleRACfa1II6qRxF3yy+KLw+zKmQaVbh+gq3zTfpd6YW8NhNKgov
         rRlw==
X-Gm-Message-State: AOAM532zCcxRQJfTwEN2AjwsCjidKcXoK5gjLGEBAhEhb6db1untUgyn
        ekosF/6bpFCfgrO3sz98FNFtew==
X-Google-Smtp-Source: ABdhPJyhmE/fuJuG/SeC3BKpW8cT6v1DcHKNo/NjdhJ2SUdl9YVtwJAipHAm0jYNcM/x6WsfP8i8wQ==
X-Received: by 2002:a1c:17:: with SMTP id 23mr7928664wma.6.1614935687986;
        Fri, 05 Mar 2021 01:14:47 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id m3sm3355609wmc.48.2021.03.05.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:14:47 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:14:45 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 16/32] KVM: arm64: Elevate hypervisor mappings
 creation at EL2
Message-ID: <YEH2hf4MWiMkHnwN@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-17-qperret@google.com>
 <20210304192540.GE21795@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304192540.GE21795@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2021 at 19:25:41 (+0000), Will Deacon wrote:
> > +static int do_pkvm_init(u32 hyp_va_bits)
> > +{
> > +	void *per_cpu_base = kvm_ksym_ref(kvm_arm_hyp_percpu_base);
> > +	int ret;
> > +
> > +	preempt_disable();
> > +	hyp_install_host_vector();
> 
> It's a shame we need this both here _and_ on the reinit path, but it looks
> like it's necessary.

Right and I want this before the KVM vectors are installed on secondary
CPUs, to make sure they get the new pgtable from the start. Otherwise
I'd need to do the same dance on all of them to go a switch TTBR0_EL2
and such.

> > +	ret = kvm_call_hyp_nvhe(__pkvm_init, hyp_mem_base, hyp_mem_size,
> > +				num_possible_cpus(), kern_hyp_va(per_cpu_base),
> > +				hyp_va_bits);
> > +	preempt_enable();
> > +
> > +	return ret;
> > +}
> 
> [...]
> 
> >  /**
> >   * Inits Hyp-mode on all online CPUs
> >   */
> >  static int init_hyp_mode(void)
> >  {
> > +	u32 hyp_va_bits;
> >  	int cpu;
> > -	int err = 0;
> > +	int err = -ENOMEM;
> > +
> > +	/*
> > +	 * The protected Hyp-mode cannot be initialized if the memory pool
> > +	 * allocation has failed.
> > +	 */
> > +	if (is_protected_kvm_enabled() && !hyp_mem_base)
> > +		return err;
> 
> This skips the error message you get on the out_err path.

Ack, I'll fix.

> > diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> > index 4d41d7838d53..9d331bf262d2 100644
> > --- a/arch/arm64/kvm/mmu.c
> > +++ b/arch/arm64/kvm/mmu.c
> > @@ -221,15 +221,39 @@ void free_hyp_pgds(void)
> >  	if (hyp_pgtable) {
> >  		kvm_pgtable_hyp_destroy(hyp_pgtable);
> >  		kfree(hyp_pgtable);
> > +		hyp_pgtable = NULL;
> >  	}
> >  	mutex_unlock(&kvm_hyp_pgd_mutex);
> >  }
> >  
> > +static bool kvm_host_owns_hyp_mappings(void)
> > +{
> > +	if (static_branch_likely(&kvm_protected_mode_initialized))
> > +		return false;
> > +
> > +	/*
> > +	 * This can happen at boot time when __create_hyp_mappings() is called
> > +	 * after the hyp protection has been enabled, but the static key has
> > +	 * not been flipped yet.
> > +	 */
> > +	if (!hyp_pgtable && is_protected_kvm_enabled())
> > +		return false;
> > +
> > +	WARN_ON(!hyp_pgtable);
> > +
> > +	return true;
> 
> 	return !(WARN_ON(!hyp_pgtable) && is_protected_kvm_enabled());

Wouldn't this WARN when I have !hyp_pgtable && is_protected_kvm_enabled()
but the static key is still off (which can happen, sadly, as per the
comment above)?

Thanks,
Quentin
