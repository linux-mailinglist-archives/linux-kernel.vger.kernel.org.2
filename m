Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26D933C2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbhCOQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhCOQ41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:56:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E96CC061764
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:26 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g20so8541079wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y+xprG6vtxLrLveW5ZtmXkAhTW+9ve7ImVtbj1EZZHk=;
        b=mrnugUQmzKMeO4p3w/jnYU3L1WrHmqn69Ewz5QiylBU/GCQ7x2L5iCA/2VLhI22o1f
         W7jrrGpK5WWx3YVj7oM5uobQdYkmkHBrkxM8eBM/wtyNCQ4B3xtYrO0pRfS2MHwwMm/i
         r/yLef5VBQeLl5z7LufUnSYeT6PSQvb4YAx4eHzXliCNP0KVZVVrmT2OE9ql2ZoUCj4h
         6qLCrwsSJSS8Y7DinACPvae2jg3sDwxPbWHNSNB+c75KtEIH5lOiOTB+Tpk/HrTM4ABe
         gEjS0u885Zc+dHqAvZDyTfOraMGPj1KodeE4dzb6MOdSO+ppf8lS43Ce2F1tOKysy4CZ
         VMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y+xprG6vtxLrLveW5ZtmXkAhTW+9ve7ImVtbj1EZZHk=;
        b=I5cklJLXKibJyHXWl21SHgHGNZbwsC6FELlfyeyymB8aWKAZCrUUfTN6iazCmstudG
         1ntGKQLt+D/Zi67a2cGZU/gYiNmn8S1xXgEGe5U7D3IYM3raPJ1+B4hjPZ0Xpx4n7EsL
         vrVSdhUpZeWl2ponxJZSUwFQh58pekOphEQi8xLVzr/95O0VRibtjUQ0STZPfqS1LVCh
         OEW9lK4O2pyKhrfT5mc9GSxHJ+8PKnB7V42TrCBbZOKGKxDWC0biUwv3x0lEpYODwcl5
         VO8ageKZadJImasjR5Gpk9h/JjypNuiPVhFZSqduzRGEfLmjEhkZTZjV9JWECO7XuuRA
         8YuA==
X-Gm-Message-State: AOAM530fHeyapMCfHTpVMC4g6H5J+pcLJp8QMFMtpuTRUdy6WxiVNjIk
        f9kjRbHOYKUg/xomp75/1xINng==
X-Google-Smtp-Source: ABdhPJxvHGew9n7ZzD/LWAiEsnPZPO/Aweogz7praM5dvQpdXhh8dOt7XfTLD17acpcb9/3p3JioXA==
X-Received: by 2002:a1c:c206:: with SMTP id s6mr563841wmf.77.1615827384635;
        Mon, 15 Mar 2021 09:56:24 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id s18sm22046028wrr.27.2021.03.15.09.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:56:24 -0700 (PDT)
Date:   Mon, 15 Mar 2021 16:56:21 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v5 14/36] KVM: arm64: Provide __flush_dcache_area at EL2
Message-ID: <YE+RtegUL4ki2qa/@google.com>
References: <20210315143536.214621-1-qperret@google.com>
 <20210315143536.214621-15-qperret@google.com>
 <20210315163322.GE3430@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315163322.GE3430@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 Mar 2021 at 16:33:23 (+0000), Will Deacon wrote:
> On Mon, Mar 15, 2021 at 02:35:14PM +0000, Quentin Perret wrote:
> > We will need to do cache maintenance at EL2 soon, so compile a copy of
> > __flush_dcache_area at EL2, and provide a copy of arm64_ftr_reg_ctrel0
> > as it is needed by the read_ctr macro.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_cpufeature.h |  2 ++
> >  arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
> >  arch/arm64/kvm/hyp/nvhe/cache.S         | 13 +++++++++++++
> >  arch/arm64/kvm/sys_regs.c               |  1 +
> >  4 files changed, 18 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
> > 
> > diff --git a/arch/arm64/include/asm/kvm_cpufeature.h b/arch/arm64/include/asm/kvm_cpufeature.h
> > index 3fd9f60d2180..efba1b89b8a4 100644
> > --- a/arch/arm64/include/asm/kvm_cpufeature.h
> > +++ b/arch/arm64/include/asm/kvm_cpufeature.h
> > @@ -13,3 +13,5 @@
> >  #define KVM_HYP_CPU_FTR_REG(name) extern struct arm64_ftr_reg kvm_nvhe_sym(name)
> >  #endif
> >  #endif
> > +
> > +KVM_HYP_CPU_FTR_REG(arm64_ftr_reg_ctrel0);
> 
> I still think this is a bit weird. If you really want to macro-ise stuff,
> then why not follow the sort of thing we do for e.g. per-cpu variables and
> have separate DECLARE_HYP_CPU_FTR_REG and DEFINE_HYP_CPU_FTR_REG macros.
> 
> That way kvm_cpufeature.h can have header guards like a normal header and
> we can drop the '#ifndef KVM_HYP_CPU_FTR_REG' altogether. I don't think
> the duplication of the symbol name really matters -- it should fail at
> build time if something is missing.

I just tend to hate unnecessary boilerplate, but if you feel strongly
about it, happy to change :)

Cheers,
Quentin
