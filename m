Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777203D0699
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 04:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhGUBZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 21:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhGUBYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 21:24:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC5FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:05:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k20so470401pgg.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 19:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CR6e7L39bvv4cVAWl7nDFXsCXi3qZFbBtgP7R4qlUk0=;
        b=maWcJ6MiehasEtax7J2WPwxAf1jcx6tDiC9mcb+3UkkzVfpnyHX+jcScZ1uf3UxHGB
         5ad3yQsGe0bJofiSL14RjdXNqbI2E1moZPkK/7jhipD3d6YeIsEM4O9sRGk5K1SCqLJS
         mJTypDdRoR7uQpXEfhTjX8Ob2dxqbfdgbRHqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CR6e7L39bvv4cVAWl7nDFXsCXi3qZFbBtgP7R4qlUk0=;
        b=Xw6J++OMLrXSaaD1nKDLQUI351m7BONm5My2rBfqzJy8YxSe4urGK5DM8YZ/SIm8Cn
         3BrdEeQ11NLeMgpYVf1r75sL/P9MfJsdi86yyrapKMmmx1CtNT9yC7N/NrtCQA4d8n1/
         9hJhi0r76mEPUK4mTiFpvmFTJQroHzRawfXImRBGumALOsCbf9ZGCSz75iU87rN8Ary5
         57D38aU5UHz1KLfawAlhGgJ9clcCyTHM/r0+Qr6f14lcHRKZc9JTUgpF/wr9elvw6STo
         HXqNwv6AX0jRin2T2Eh/pxrDpszbEl8TzINgXc+/MGyN6EJffU9AGbG65wakRfPU/T1N
         Orhw==
X-Gm-Message-State: AOAM531uEVEtXUARD5o/7tlxi3c5yMDtuGAj7x81gl9GxDoT8+w34bYv
        69XflLNJ3Vyy8eSdzqlabBOq4g==
X-Google-Smtp-Source: ABdhPJxpeEKw7sLSFfF2jFlD87jS6c3Cv7f9kkLu2mZtm2AkTa4BArHc2e4Css5Mt5sAAvOPk9e0Tg==
X-Received: by 2002:aa7:86d9:0:b029:32b:5ec8:c87b with SMTP id h25-20020aa786d90000b029032b5ec8c87bmr34511465pfo.1.1626833131504;
        Tue, 20 Jul 2021 19:05:31 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:808c:1a13:1159:8184])
        by smtp.gmail.com with ESMTPSA id m21sm20972208pjz.36.2021.07.20.19.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 19:05:30 -0700 (PDT)
Date:   Wed, 21 Jul 2021 11:05:25 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Will Deacon <will@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCHv2 2/4] arm64: add guest pvstate support
Message-ID: <YPeA5ReGSwBvWGSa@google.com>
References: <20210709043713.887098-1-senozhatsky@chromium.org>
 <20210709043713.887098-3-senozhatsky@chromium.org>
 <877dhv35ea.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dhv35ea.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/07/12 16:42), Marc Zyngier wrote:
> > 
> > PV-vcpu-state is a per-CPU struct, which, for the time being,
> > holds boolean `preempted' vCPU state. During the startup,
> > given that host supports PV-state, each guest vCPU sends
> > a pointer to its per-CPU variable to the host as a payload
> 
> What is the expected memory type for this memory region? What is its
> life cycle? Where is it allocated from?

Guest per-CPU area, which physical addresses is shared with the host.

> > with the SMCCC HV call, so that host can update vCPU state
> > when it puts or loads vCPU.
> > 
> > This has impact on the guest's scheduler:
> > 
> > [..]
> >   wake_up_process()
> >    try_to_wake_up()
> >     select_task_rq_fair()
> >      available_idle_cpu()
> >       vcpu_is_preempted()
> > 
> > Some sched benchmarks data is available on the github page [0].
> > 
> > [0] https://github.com/sergey-senozhatsky/arm64-vcpu_is_preempted
> 
> Please include these results in the cover letter. I tend to reply to
> email while offline, and I can't comment on GH.

ACK.

> > +struct vcpu_state {
> 
> If this is KVM specific (which it most likely is), please name-space
> it correctly, and move it to a KVM-specific location.

ACK.

> > +	bool	preempted;
> > +	u8	reserved[63];
> 
> Why 63? Do you attach any particular meaning to a 64byte structure
> (and before you say "cache line size", please look at some of the
> cache line sizes we have to deal with...).

We do have some future plans to share some bits of the guest's context
with the host.

> This should also be versioned from day-1, one way or another.

Makes sense.

> > +};
> > +
> >  #ifdef CONFIG_PARAVIRT
> >  #include <linux/static_call_types.h>
> >  
> > @@ -20,8 +25,22 @@ static inline u64 paravirt_steal_clock(int cpu)
> >  
> >  int __init pv_time_init(void);
> >  
> > +bool dummy_vcpu_is_preempted(unsigned int cpu);
> > +
> > +extern struct static_key pv_vcpu_is_preempted_enabled;
> > +DECLARE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> > +
> > +static inline bool paravirt_vcpu_is_preempted(unsigned int cpu)
> > +{
> > +	return static_call(pv_vcpu_is_preempted)(cpu);
> > +}
> > +
> > +int __init pv_vcpu_state_init(void);
> > +
> >  #else
> >  
> > +#define pv_vcpu_state_init() do {} while (0)
> > +
> >  #define pv_time_init() do {} while (0)
> >  
> >  #endif // CONFIG_PARAVIRT
> > diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> > index 75fed4460407..d8fc46795d94 100644
> > --- a/arch/arm64/kernel/paravirt.c
> > +++ b/arch/arm64/kernel/paravirt.c
> > @@ -40,6 +40,11 @@ struct pv_time_stolen_time_region {
> >  
> >  static DEFINE_PER_CPU(struct pv_time_stolen_time_region, stolen_time_region);
> >  
> > +static DEFINE_PER_CPU(struct vcpu_state, vcpus_states);
> 
> nit: there is only one 'state' structure per CPU, so I'd prefer the
> singular form.

ACK.

> > +struct static_key pv_vcpu_is_preempted_enabled;
> > +
> > +DEFINE_STATIC_CALL(pv_vcpu_is_preempted, dummy_vcpu_is_preempted);
> > +
> >  static bool steal_acc = true;
> >  static int __init parse_no_stealacc(char *arg)
> >  {
> > @@ -165,3 +170,92 @@ int __init pv_time_init(void)
> >  
> >  	return 0;
> >  }
> > +
> > +bool dummy_vcpu_is_preempted(unsigned int cpu)
> 
> Why does this have to be global?

I think this can be moved away from the header, so then we don't need
to DECLARE_STATIC_CALL() with a dummy function.

> > +static bool has_pv_vcpu_state(void)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	/* To detect the presence of PV time support we require SMCCC 1.1+ */
> > +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
> > +		return false;
> > +
> > +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> > +			     ARM_SMCCC_HV_PV_VCPU_STATE_FEATURES,
> > +			     &res);
> > +
> > +	if (res.a0 != SMCCC_RET_SUCCESS)
> > +		return false;
> > +	return true;
> 
> Please move all this over the the KVM-specific discovery mechanism.

Will take a look.

> > +static int __pv_vcpu_state_hook(unsigned int cpu, int event)
> > +{
> > +	struct arm_smccc_res res;
> > +	struct vcpu_state *st;
> > +
> > +	st = &per_cpu(vcpus_states, cpu);
> > +	arm_smccc_1_1_invoke(event, virt_to_phys(st), &res);
> > +	if (res.a0 != SMCCC_RET_SUCCESS)
> > +		return -EINVAL;
> > +	return 0;
> > +}
> > +
> > +static int vcpu_state_init(unsigned int cpu)
> > +{
> > +	int ret = __pv_vcpu_state_hook(cpu, ARM_SMCCC_HV_PV_VCPU_STATE_INIT);
> > +
> > +	if (ret)
> > +		pr_warn("Unable to ARM_SMCCC_HV_PV_STATE_INIT\n");
> 
> pr_warn_once(), please.

ACK.
