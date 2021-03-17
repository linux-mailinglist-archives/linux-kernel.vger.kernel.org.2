Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DC833F4A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 16:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhCQPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhCQPwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 11:52:01 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B8C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:51:39 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v11so2117826wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 07:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2QJmRsVKTO5ci+HipbAp9Ce4exjAggLbAvM7AZ2sv2M=;
        b=GQhXWmat7a3XTiXnO9GkRqto6Und9lUPumlzu/jUj0TT933/hJv0wAQBjr5KdA1yRH
         W9zqwp2AdQZVkO/IKoeGlp5fgOGbG+ZqR8pVp0hyQK3uRldI2qI/lE/DESIclnfQYNEa
         qNHr6DBBi6WT9s8ZL8ccUUnZ1dosNmMAWQZ02Vg6uyS5yndjxIZM3F+OKDNi1xXkUkiE
         JaQkqStzEtvwyuC2pQr2mCRB6yQuKFGvSeb1bGeOAOLO+rhqiYWgQlqQi0e1Zt2MhsXu
         9VSfO+dHRMSrQkM9SvMFEhwIIC1LESpUzEJgNJhe5sRTorXxYQ0f0PcHrrqVSiFXNS1E
         RkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2QJmRsVKTO5ci+HipbAp9Ce4exjAggLbAvM7AZ2sv2M=;
        b=e1WvXs7hZYtmahIWq+BJSyMp6NdCi4q4PKcaAVOLzTNTOsekg3x6mwBwbc3lQnQA0W
         yOpZS4r//tdM9g1UkxN2Jc5fmCiZFRTNOvg0XryRH01433IEQQsdZwxys4EKtfpWCdH/
         cFF0tf4o8vi3JHUeAbiCrIhQvreclmq0YJsFhBODlayESWukcyQDo/QeW34CbTIMr+iQ
         XjKxHM3ZInxtUjMoUAbP5E24mH+C9yrakUTzb0OZtTLjEHEGF9SiV8cDUyQcGKnm+Vnq
         jBljG9DcLungFM2gaQF2xw73T7NBBvAVNOuJA9IIU/WdVxDWW4UC0s3ysowE+R8kCm4W
         oxuA==
X-Gm-Message-State: AOAM5303X0zRECspYjm7A6jimxwrI0x1cDPCBZcOnpNKYvwI2MCBsoOF
        x7yLMT9Z4jiSGje+JtHfYJEzmQ==
X-Google-Smtp-Source: ABdhPJzU4mf1HgHLDhfex0ruEOsnW2Z8/qwymFAQXQiSoFpEMKwn6XWMuH5WHfLKOiAPW0wNje1c4Q==
X-Received: by 2002:adf:e582:: with SMTP id l2mr4833991wrm.207.1615992697694;
        Wed, 17 Mar 2021 07:51:37 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id a8sm2679076wmm.46.2021.03.17.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 07:51:37 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:51:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com
Subject: Re: [PATCH 1/2] KVM: arm64: Introduce KVM_PGTABLE_S2_NOFWB Stage-2
 flag
Message-ID: <YFIXdli6lZf7I9YV@google.com>
References: <20210315143536.214621-34-qperret@google.com>
 <20210317141714.383046-1-qperret@google.com>
 <20210317141714.383046-2-qperret@google.com>
 <20210317144246.GE5393@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317144246.GE5393@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 Mar 2021 at 14:42:46 (+0000), Will Deacon wrote:
> On Wed, Mar 17, 2021 at 02:17:13PM +0000, Quentin Perret wrote:
> > In order to further configure stage-2 page-tables, pass flags to the
> > init function using a new enum.
> > 
> > The first of these flags allows to disable FWB even if the hardware
> > supports it as we will need to do so for the host stage-2.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > 
> > ---
> > 
> > One question is, do we want to use stage2_has_fwb() everywhere, including
> > guest-specific paths (e.g. kvm_arch_prepare_memory_region(), ...) ?
> > 
> > That'd make this patch more intrusive, but would make the whole codebase
> > work with FWB enabled on a guest by guest basis. I don't see us use that
> > anytime soon (other than maybe debug of some sort?) but it'd be good to
> > have an agreement.
> 
> I don't see the value in spreading this everywhere for now.

Good. Sounds like we're all in agreement.

> >  arch/arm64/include/asm/kvm_pgtable.h  | 19 +++++++++--
> >  arch/arm64/include/asm/pgtable-prot.h |  4 +--
> >  arch/arm64/kvm/hyp/pgtable.c          | 49 +++++++++++++++++----------
> >  3 files changed, 50 insertions(+), 22 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
> > index b93a2a3526ab..7382bdfb6284 100644
> > --- a/arch/arm64/include/asm/kvm_pgtable.h
> > +++ b/arch/arm64/include/asm/kvm_pgtable.h
> > @@ -56,6 +56,15 @@ struct kvm_pgtable_mm_ops {
> >  	phys_addr_t	(*virt_to_phys)(void *addr);
> >  };
> >  
> > +/**
> > + * enum kvm_pgtable_stage2_flags - Stage-2 page-table flags.
> > + * @KVM_PGTABLE_S2_NOFWB:	Don't enforce Normal-WB even if the CPUs have
> > + *				ARM64_HAS_STAGE2_FWB.
> > + */
> > +enum kvm_pgtable_stage2_flags {
> > +	KVM_PGTABLE_S2_NOFWB			= BIT(0),
> > +};
> > +
> >  /**
> >   * struct kvm_pgtable - KVM page-table.
> >   * @ia_bits:		Maximum input address size, in bits.
> > @@ -72,6 +81,7 @@ struct kvm_pgtable {
> >  
> >  	/* Stage-2 only */
> >  	struct kvm_s2_mmu			*mmu;
> > +	enum kvm_pgtable_stage2_flags		flags;
> >  };
> >  
> >  /**
> > @@ -201,11 +211,16 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift);
> >   * @arch:	Arch-specific KVM structure representing the guest virtual
> >   *		machine.
> >   * @mm_ops:	Memory management callbacks.
> > + * @flags:	Stage-2 configuration flags.
> >   *
> >   * Return: 0 on success, negative error code on failure.
> >   */
> > -int kvm_pgtable_stage2_init(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > -			    struct kvm_pgtable_mm_ops *mm_ops);
> > +int kvm_pgtable_stage2_init_flags(struct kvm_pgtable *pgt, struct kvm_arch *arch,
> > +				  struct kvm_pgtable_mm_ops *mm_ops,
> > +				  enum kvm_pgtable_stage2_flags flags);
> > +
> > +#define kvm_pgtable_stage2_init(pgt, arch, mm_ops) \
> > +	kvm_pgtable_stage2_init_flags(pgt, arch, mm_ops, 0)
> 
> nit: I think some of the kerneldoc refers to "kvm_pgtable_stage_init()"
> so that needs a trivial update to e.g. "kvm_pgtable_stage_init*()".

Will do.

> > diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> > index 046be789fbb4..beeb722a82d3 100644
> > --- a/arch/arm64/include/asm/pgtable-prot.h
> > +++ b/arch/arm64/include/asm/pgtable-prot.h
> > @@ -72,10 +72,10 @@ extern bool arm64_use_ng_mappings;
> >  #define PAGE_KERNEL_EXEC	__pgprot(PROT_NORMAL & ~PTE_PXN)
> >  #define PAGE_KERNEL_EXEC_CONT	__pgprot((PROT_NORMAL & ~PTE_PXN) | PTE_CONT)
> >  
> > -#define PAGE_S2_MEMATTR(attr)						\
> > +#define PAGE_S2_MEMATTR(attr, has_fwb)					\
> >  	({								\
> >  		u64 __val;						\
> > -		if (cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))		\
> > +		if (has_fwb)						\
> >  			__val = PTE_S2_MEMATTR(MT_S2_FWB_ ## attr);	\
> >  		else							\
> >  			__val = PTE_S2_MEMATTR(MT_S2_ ## attr);		\
> 
> Can you take the pgt structure instead of a bool here, or does it end up
> being really ugly?

It means I need to expose the stage2_has_fwb() helper in pgtable.h so I
can use it here. But Marc suggested that I introduce another macro along
the lines of

#define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has_fwb(pgt))

which can be defined in pgtable.c and keep everything neatly contained
in there. So I think I'll go ahead with that unless you feel strongly
about it.

Cheers,
Quentin
