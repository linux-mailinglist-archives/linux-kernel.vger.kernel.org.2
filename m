Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7121F3385F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhCLGeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhCLGeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:34:14 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE85DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:34:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso15101542wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 22:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1/tfClp+7Xwws1Pzo0a1sfKu9YRenK6a+xVG2qklwd4=;
        b=HbVmTtEiViLLTmj5PsNXwihfohAn4IXar+c8rDArckbzttahoELkcZBLU3H5B53M/B
         yl8Qsl8vmYcFYPbNLm+E/5rs/XVU4JRHK+xzL83AabloXrgBHN7x2JmIjv8WIJWn5Lsq
         lsaS7UHui+qNtWlL1ZsDZ7/bXi/Qs0gL76SLst2hQL5e+3lvM+AatMVQRAgQeijKee10
         K2n1ny8KYwAdg60MLTf6jwBKv2SPzfS8if6SfxlCzOHublVVFvtMyjLX9iAXb0XND6Bf
         IT6GVVHlt4CWPXSvvX0XBMG3ls9F43VdruAt03ENP6+32alyb6S1sqAgZn9Q7yvRByZj
         QVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1/tfClp+7Xwws1Pzo0a1sfKu9YRenK6a+xVG2qklwd4=;
        b=YBDL0QCm0/pLFbEjE0ZsmK2iE/bgq+nlSLE9UHeTccPNlmz/aPULDIiCA1harm1Y2z
         9RTr1YmLHDe2kfb7j5TaIyQraNs/py2lG/TTQGHzXdOb1rvOK6VASUr06xbPFQCqf9ji
         ezRJpOrkiKy5x81Pca2vHOcBGIeRZwxV0z5qsQvpWJnf+b6SgvlC9845JAQIO7N+9LhO
         yJH8unzwyiJ1976OHJ3MVwPIkeyd0z8h/FC5rD+Vfo4IUmVkH95bduGR+BAQYdxU7Bts
         ZyGwJczmEEi0naDk6hyaP9/eij5SzH8KHyCQcleZ07ivES+I0GrAFNCEtVTc93vZu1vu
         R0Qw==
X-Gm-Message-State: AOAM532VvCjE8xMFtHS0T4ViChJ1hQWIjzaH7QTd2W9pmj5y+iZxeh4R
        6Nb3YfXSBoqg+CYewjERLEvqEw==
X-Google-Smtp-Source: ABdhPJzA/b526bFotN9qw9enozEUd7huuW/LQlBGtEU+Rk9os7n745FhiM+n3ml6/wx92ZKbGriN1g==
X-Received: by 2002:a05:600c:35c1:: with SMTP id r1mr11379120wmq.60.1615530852267;
        Thu, 11 Mar 2021 22:34:12 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id s18sm7409255wrr.27.2021.03.11.22.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 22:34:12 -0800 (PST)
Date:   Fri, 12 Mar 2021 06:34:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 13/34] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <YEsLYX2CjNMXF9TN@google.com>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-14-qperret@google.com>
 <20210311193638.GE31586@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311193638.GE31586@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 Mar 2021 at 19:36:39 (+0000), Will Deacon wrote:
> On Wed, Mar 10, 2021 at 05:57:30PM +0000, Quentin Perret wrote:
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 066030717a4c..f2d8b479ff74 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1154,6 +1154,18 @@ u64 read_sanitised_ftr_reg(u32 id)
> >  }
> >  EXPORT_SYMBOL_GPL(read_sanitised_ftr_reg);
> >  
> > +int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
> > +{
> > +	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
> > +
> > +	if (!regp)
> > +		return -EINVAL;
> > +
> > +	memcpy(dst, regp, sizeof(*regp));
> 
> Can you not just use struct assignment here?

Sure.

> > diff --git a/arch/arm64/kvm/hyp/nvhe/cache.S b/arch/arm64/kvm/hyp/nvhe/cache.S
> > new file mode 100644
> > index 000000000000..36cef6915428
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/nvhe/cache.S
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Code copied from arch/arm64/mm/cache.S.
> > + */
> > +
> > +#include <linux/linkage.h>
> > +#include <asm/assembler.h>
> > +#include <asm/alternative.h>
> > +
> > +SYM_FUNC_START_PI(__flush_dcache_area)
> > +	dcache_by_line_op civac, sy, x0, x1, x2, x3
> > +	ret
> > +SYM_FUNC_END_PI(__flush_dcache_area)
> 
> Separate patch for this? (or fold it into that one really near the start
> that introduces some other PI helpers).

Right, I guess that'll make reverts and such easier so why not.

> > diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> > index 4f2f1e3145de..84be93df52fa 100644
> > --- a/arch/arm64/kvm/sys_regs.c
> > +++ b/arch/arm64/kvm/sys_regs.c
> > @@ -21,6 +21,7 @@
> >  #include <asm/debug-monitors.h>
> >  #include <asm/esr.h>
> >  #include <asm/kvm_arm.h>
> > +#include <asm/kvm_cpufeature.h>
> >  #include <asm/kvm_emulate.h>
> >  #include <asm/kvm_hyp.h>
> >  #include <asm/kvm_mmu.h>
> > @@ -2775,3 +2776,23 @@ void kvm_sys_reg_table_init(void)
> >  	/* Clear all higher bits. */
> >  	cache_levels &= (1 << (i*3))-1;
> >  }
> > +
> > +#undef KVM_HYP_CPU_FTR_REG
> > +#define KVM_HYP_CPU_FTR_REG(id, name) \
> > +	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) },
> > +struct __ftr_reg_copy_entry {
> > +	u32			sys_id;
> > +	struct arm64_ftr_reg	*dst;
> > +} hyp_ftr_regs[] __initdata = {
> > +	#include <asm/kvm_cpufeature.h>
> > +};
> 
> This looks a bit elaborate to me. Why can't you just spell things out here
> like:
> 
> #define KVM_HYP_CPU_FTR_REG(id, name) \
> 	{ .sys_id = id, .dst = (struct arm64_ftr_reg *)&kvm_nvhe_sym(name) }
> 
> struct __ftr_reg_copy_entry {
> 	u32			sys_id;
> 	struct arm64_ftr_reg	*dst;
> } hyp_ftr_regs[] __initdata = {
> 	KVM_HYP_CPU_FTR_REG(SYS_CTR_EL0, arm64_ftr_reg_ctrel0),
> 	...
> };
> 
> and then have the header file be a normal, guarded header which just
> declares these things? The id parameter to the macro isn't used there.

I just tried to reduce the boilerplate as much as possible -- in the
current form you only need to add additional features to the header
it'll 'just work'.

Thanks,
Quentin
