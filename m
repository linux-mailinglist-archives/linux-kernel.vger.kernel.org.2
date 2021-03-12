Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF833889F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhCLJ0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:26:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232932AbhCLJ0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:26:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B85FE64ED7;
        Fri, 12 Mar 2021 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615541162;
        bh=lt1IwrNUaz19OAxDfxgi2aiw3GOvHySCHyMhts/ttlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fj6Lfc2WDvpu5FN2uF4nmKoY/pKj+yD6c1fxrHH/2C9G+WxYhA5XcICxqbDZryfHb
         UILcjc19PqDMIxnxPslMIKU2n5/nLiV1Ky0Z9E//xMmLGgTQbxgeTfZU2kAWYZBxoK
         Rw0RHvov/Ewu9lspDaalDVnJc6UQlHkTT0o+ubMrV+1eER3D8uUTJ/+L6pVBO3wu1g
         kIfJ2rWYtUX9JtkeoRaoE/+5gOfR4fv6xG95DkxlY7BkzgE1Yyi8ZdhqCgebkwanaU
         mLNNKPkrM9JHPA5MDb6489q/r3qq5RVsRy0VwZST8KtNuShKhUgPjyWON19f6p7gH9
         G9dOWm5SsN/+g==
Date:   Fri, 12 Mar 2021 09:25:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 13/34] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <20210312092556.GA32016@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-14-qperret@google.com>
 <20210311193638.GE31586@willie-the-truck>
 <YEsLYX2CjNMXF9TN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEsLYX2CjNMXF9TN@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:34:09AM +0000, Quentin Perret wrote:
> On Thursday 11 Mar 2021 at 19:36:39 (+0000), Will Deacon wrote:
> > On Wed, Mar 10, 2021 at 05:57:30PM +0000, Quentin Perret wrote:
> > > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > > index 4f2f1e3145de..84be93df52fa 100644
> > > --- a/arch/arm64/kvm/sys_regs.c
> > > +++ b/arch/arm64/kvm/sys_regs.c
> > > @@ -21,6 +21,7 @@
> > >  #include <asm/debug-monitors.h>
> > >  #include <asm/esr.h>
> > >  #include <asm/kvm_arm.h>
> > > +#include <asm/kvm_cpufeature.h>
> > >  #include <asm/kvm_emulate.h>
> > >  #include <asm/kvm_hyp.h>
> > >  #include <asm/kvm_mmu.h>
> > > @@ -2775,3 +2776,23 @@ void kvm_sys_reg_table_init(void)
> > >  	/* Clear all higher bits. */
> > >  	cache_levels &= (1 << (i*3))-1;
> > >  }
> > > +
> > > +#undef KVM_HYP_CPU_FTR_REG
> > > +#define KVM_HYP_CPU_FTR_REG(id, name) \
> > > +	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
> > > +struct __ftr_reg_copy_entry {
> > > +	u32			sys_id;
> > > +	struct arm64_ftr_reg	*dst;
> > > +} hyp_ftr_regs[] __initdata = {
> > > +	#include <asm/kvm_cpufeature.h>
> > > +};
> > 
> > This looks a bit elaborate to me. Why can't you just spell things out here
> > like:
> > 
> > #define KVM_HYP_CPU_FTR_REG(id, name) \
> > 	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) }
> > 
> > struct __ftr_reg_copy_entry {
> > 	u32			sys_id;
> > 	struct arm64_ftr_reg	*dst;
> > } hyp_ftr_regs[] __initdata = {
> > 	KVM_HYP_CPU_FTR_REG(SYS_CTR_EL0, arm64_ftr_reg_ctrel0),
> > 	...
> > };
> > 
> > and then have the header file be a normal, guarded header which just
> > declares these things? The id parameter to the macro isn't used there.
> 
> I just tried to reduce the boilerplate as much as possible -- in the
> current form you only need to add additional features to the header
> it'll 'just work'.

I don't really think it's worth it -- people are used to having to add
declarations for things, so keeping it simple should be fine.

Will
