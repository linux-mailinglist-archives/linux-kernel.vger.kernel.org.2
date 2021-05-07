Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909313767BD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhEGPOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhEGPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:14:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8BCC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 08:13:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620400413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLZLSWlcOKN7FzT4MMQSgEtnpKbrHYc0tKz+8iP5Taw=;
        b=QIzM1sz3UM6oWI5XhrR+vR7pvVI23nABQn/2cspSbKghmEe4Ss6cc6nNwShvsw/MCbhwSj
        OB2qD7Ge+fuySto663rHhQ1/PVIXaifkFSOG4gbMBKAVow8g6tsVK67mTGgvGn/+7SzJrC
        dIhyTyWJ9vmVG/FUZJSkneZxsGnmKgpRo0VOu6ynJUHxlFRxuAr70g5K4BhDtKLHEW2JUY
        7tRvOKBr1ynE2JoLw989uHMpbuFIdOtzuqHfawezSFs73PlUj0Zlw8VBm2VzT28qjqVo6p
        B/lm+vj5it6337WmMWdir7A9IohcRksiUvUfYVL39Q+qqc/hXdUMfYdCPaUorQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620400413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLZLSWlcOKN7FzT4MMQSgEtnpKbrHYc0tKz+8iP5Taw=;
        b=rxz4a7WkZvo8qQ0exe2xV4aVB30RepQyqcZJW6V1kgg7l4st1i7AB9SIumvSEFRs3pex8y
        Kj7hpmcUGEBjA6Bg==
To:     Ramakrishna Saripalli <rsaripal@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, Jonathan Corbet <corbet@lwn.net>,
        bsd@redhat.com, rsaripal@amd.com,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/1] x86/cpufeatures: Implement Predictive Store Forwarding control.
In-Reply-To: <20210505190923.276051-2-rsaripal@amd.com>
References: <20210505190923.276051-1-rsaripal@amd.com> <20210505190923.276051-2-rsaripal@amd.com>
Date:   Fri, 07 May 2021 17:13:33 +0200
Message-ID: <87wnsamvaa.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05 2021 at 14:09, Ramakrishna Saripalli wrote:
> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>
> Certain AMD processors feature a new technology called Predictive Store
> Forwarding (PSF).
>
> PSF is a micro-architectural optimization designed to improve the
> performance of code execution by predicting dependencies between
> loads and stores.
>
> Incorrect PSF predictions can occur due to two reasons.
>
> - It is possible that the load/store pair may have had dependency for
>   a while but the dependency has stopped because the address in the
>   load/store pair has changed.
>
> - Second source of incorrect PSF prediction can occur because of an alias
>   in the PSF predictor structure stored in the microarchitectural state.
>   PSF predictor tracks load/store pair based on portions of instruction
>   pointer. It is possible that a load/store pair which does have a
>   dependency may be aliased by another load/store pair which does not have
>   the same dependency. This can result in incorrect speculation.
>
>   Software may be able to detect this aliasing and perform side-channel
>   attacks.

So this is the new post spectre/meltdown/.../ world order.

What would have been considered a potential speculative side channel bug
two years ago is now sold a feature which is by default enabled.

Just to be clear. From a security POV this is just yet another
default enabled speculative vulnerability. The difference to the others
is that this is communicated upfront and comes with a knob to turn it
off right away.

There is also interaction with SSB and the SSB mitigation which is
described in the cover letter, but not in the changelog and is not
detectable from user space.

I know that you had it implemented that way in your first attempt, but I
was busy with other things and missed the discussion which resulted in
this being treated as a feature.

TBH, I'm not really happy about this because that's inconsistent with
how we treat the other speculation related issues and there is no way
for user space to actually check this like the other one via /sys/....

> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1170,3 +1170,22 @@ void set_dr_addr_mask(unsigned long mask, int dr)
>  		break;
>  	}
>  }
> +
> +static int __init psf_cmdline(char *str)
> +{
> +	if (!boot_cpu_has(X86_FEATURE_PSFD))
> +		return 0;
> +
> +	if (!str)
> +		return -EINVAL;
> +
> +	if (!strcmp(str, "off")) {
> +		set_cpu_cap(&boot_cpu_data, X86_FEATURE_MSR_SPEC_CTRL);

What? Why is this setting this feature here and why is this not done in
init_speculation_control() as for all the other speculation misfeatures?

> +		x86_spec_ctrl_base |= SPEC_CTRL_PSFD;

What? See below.

> +		msr_set_bit(MSR_IA32_SPEC_CTRL, SPEC_CTRL_PSFD_SHIFT);
> +	}
> +
> +	return 0;

So any parameter is treated as valid here. That's interesting at best.

> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -78,6 +78,8 @@ EXPORT_SYMBOL_GPL(mds_idle_clear);
>  
>  void __init check_bugs(void)
>  {
> +	u64 tmp = 0;
> +
>  	identify_boot_cpu();
>  
>  	/*
> @@ -97,7 +99,9 @@ void __init check_bugs(void)
>  	 * init code as it is not enumerated and depends on the family.
>  	 */
>  	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> -		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> +		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);
> +
> +	x86_spec_ctrl_base |= tmp;

How is anyone supposed to understand that logic?

Just because x86_spec_ctrl_base is a global variable does not justify
this hackery at all. It's just a matter of time that someone reads this:

u64 x86_spec_ctrl_base;

void __init check_bugs(void)
{
	u64 tmp = 0;

        ...

  	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
		rdmsrl(MSR_IA32_SPEC_CTRL, tmp);

	x86_spec_ctrl_base |= tmp;

and figures that this is a pointless exercise and reverts that hunk.

What's wrong with just treating this in the same way in which we treat
all other speculative vulnerabilities and provide a consistent picture
to the user?

Something like the below. You get the idea.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -111,6 +111,7 @@ void __init check_bugs(void)
 	mds_select_mitigation();
 	taa_select_mitigation();
 	srbds_select_mitigation();
+	psf_select_mitigation();
 
 	/*
 	 * As MDS and TAA mitigations are inter-related, print MDS
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -891,6 +891,9 @@ static void init_speculation_control(str
 		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 		clear_cpu_cap(c, X86_FEATURE_VIRT_SSBD);
 	}
+
+	if (!boot_cpu_has(X86_FEATURE_PSFD))
+		set_cpu_cap(c, X86_FEATURE_MSR_SPEC_CTRL);
 }
 
 void get_cpu_cap(struct cpuinfo_x86 *c)
