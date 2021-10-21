Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0BC4366BA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhJUPtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhJUPts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:49:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95CBC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:47:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so883520pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LjkqvoWTymfCy+YcaZh0ZqmF+EOwMe7EIAue/ES2zZI=;
        b=CKOZQwON6vxm5fh94b90jypEEwVdTo/XS3/hpKg8aWp4Q3bRT2RoOivhdvZiLyvWSj
         VwB2cy4/Zon7lOfSIpRV0SCkDz6vRE5NSNBnXBJaSvYyzQ0wRePr5maWpgkVcyz54dzs
         yan3eA4lYTfpE1UJs594hRujOZzkgWhWDs0ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LjkqvoWTymfCy+YcaZh0ZqmF+EOwMe7EIAue/ES2zZI=;
        b=lSl+37kFiMF3Kt4+STUMaHWtNOZI5/Ilks8n9YERvyYB28Bc0L9HHPRbT1uGj6C7Jt
         PkhhRUAmBBXOwDcr04KRiNatmEkx23dnr6/AlOkp9opblhiJYwN4buKlsNgu29JxZhhd
         C0ggcrh+R0itPuAbcc/wYJ9/+y1wJn8DiOEW+cFhO3oT8Z+H7MfIvpbII3CNsOK8OjLN
         KhHWHG8q0Lo2V7Idhlmfyx9rgKQMZptQ2NKp2rK31qn4TcnjKZk8kMYnxZnnYEvlNyyG
         ccvHqctGBAICL/QMF323JylOjY/cb8CrRMVVehAeN+yORzfgBu1hd+1EdQZG+2bA07Ko
         4N/A==
X-Gm-Message-State: AOAM530w/6K9WS94yTV0YKoE78e61F5ShIaEBCbAZHOkmt3NjqHZEDV0
        kL8XDPV/iLEJG23vjJx1MuZ8BHf5JBU=
X-Google-Smtp-Source: ABdhPJzWRRaUhrJPndRABVKVdgJ1OpmaLHbcaLDagTz8RC8SHv0taaYpAJEqvR/gJDrn5/MKGviahw==
X-Received: by 2002:a17:90b:3ec6:: with SMTP id rm6mr7568949pjb.27.1634831251225;
        Thu, 21 Oct 2021 08:47:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n22sm6640941pfo.15.2021.10.21.08.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:47:30 -0700 (PDT)
Date:   Thu, 21 Oct 2021 08:47:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     James Clark <james.clark@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 1/4] arm64: Use static key for tracing PID in CONTEXTIDR
Message-ID: <202110210846.8A7B9F684@keescook>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-2-leo.yan@linaro.org>
 <53962765-53b9-dfdc-a5b2-a3133a924c12@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53962765-53b9-dfdc-a5b2-a3133a924c12@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 03:33:01PM +0100, James Clark wrote:
> 
> 
> On 21/10/2021 14:45, Leo Yan wrote:
> > The kernel provides CONFIG_PID_IN_CONTEXTIDR for tracing PID into system
> > register CONTEXTIDR; we need to statically enable this configuration
> > when build kernel image to use this feature.
> > 
> > On the other hand, hardware tracing modules (e.g. Arm CoreSight, SPE,
> > etc) rely on this feature to provide context info in their tracing data.
> > If kernel has not enabled configuration CONFIG_PID_IN_CONTEXTIDR, then
> > tracing modules have no chance to capture PID related info.
> > 
> > This patch introduces static key for tracing PID in CONTEXTIDR, it
> > provides a possibility for device driver to dynamically enable and
> > disable tracing PID into CONTEXTIDR as needed.
> > 
> > As the first step, the kernel increases the static key if
> > CONFIG_PID_IN_CONTEXTIDR is enabled when booting kernel, in this case
> > kernel will always trace PID into CONTEXTIDR at the runtime.  This means
> > before and after applying this patch, the semantics for
> > CONFIG_PID_IN_CONTEXTIDR are consistent.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  arch/arm64/include/asm/mmu_context.h |  4 +++-
> >  arch/arm64/kernel/process.c          | 11 +++++++++++
> >  2 files changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
> > index f4ba93d4ffeb..e1f33616f83a 100644
> > --- a/arch/arm64/include/asm/mmu_context.h
> > +++ b/arch/arm64/include/asm/mmu_context.h
> > @@ -26,9 +26,11 @@
> >  
> >  extern bool rodata_full;
> >  
> > +DECLARE_STATIC_KEY_FALSE(contextidr_in_use);
> > +
> >  static inline void contextidr_thread_switch(struct task_struct *next)
> >  {
> > -	if (!IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> > +	if (!static_branch_unlikely(&contextidr_in_use))
> >  		return;
> >  
> >  	write_sysreg(task_pid_nr(next), contextidr_el1);
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 40adb8cdbf5a..d744c0c7e4c4 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -61,6 +61,9 @@ unsigned long __stack_chk_guard __ro_after_init;
> >  EXPORT_SYMBOL(__stack_chk_guard);
> >  #endif
> >  
> > +DEFINE_STATIC_KEY_FALSE(contextidr_in_use);
> > +EXPORT_SYMBOL_GPL(contextidr_in_use);
> > +
> >  /*
> >   * Function pointers to optional machine specific functions
> >   */
> > @@ -721,3 +724,11 @@ int arch_elf_adjust_prot(int prot, const struct arch_elf_state *state,
> >  	return prot;
> >  }
> >  #endif
> > +
> > +static int __init contextidr_init(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> > +		static_branch_inc(&contextidr_in_use);
> > +	return 0;
> > +}
> > +early_initcall(contextidr_init);
> 
> Hi Leo,
> 
> Can you skip this early_initcall() part if you do something like this:
> 
>     DECLARE_STATIC_KEY_MAYBE(CONFIG_PID_IN_CONTEXTIDR, contextidr_in_use)
> 
> It seems like there is a way to conditionally initialise it to true.

I was going to suggest the same thing. :) With this change, it looks
good:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
