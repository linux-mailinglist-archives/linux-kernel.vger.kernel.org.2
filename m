Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4697B342FA8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 22:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhCTVZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 17:25:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 17:25:03 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616275502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ESK4gLVBul9JIjak2zSrxPBLjFzPx32Uar+EjOsP6VI=;
        b=FhwuICPUBJnNlxuRNedlBch4bDSNV3AVBXNvCUZftJbw4B5I1wd6AYLhGorYHlJgs0JHtF
        wBQo9b5xPp33Sm5qg4HfD2v0B5sJJPtKHqAP9/CEgMleePyP9rSxPeR/LcHT+of7iW9mu3
        FSZLp30rP0O1LppqhJOZ+XUb+RqAdMFbx0s2UBGI1TiLO1GsTNRvawROyAXyIzPbeR+kOI
        +xaYWnV+Jrp3EeApNPAcXUg+h7AfrGtOTh3P2+jCfpD0CoYOLm4/14BS3KG9+Z3ByiTMME
        vkoq633NGjAtbdSs8voAH0tO2FYZAw1rcIf6JOvU/FqF290hfyy7lDSeDbLjBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616275502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ESK4gLVBul9JIjak2zSrxPBLjFzPx32Uar+EjOsP6VI=;
        b=rzfdm2b4k0+/cTlwsDrgEV3dDGPsdahwPrjnQd2CcQQ3N/Twu37M3lMEy2uxj4NPm3F43M
        i53lgJ+vw300jYAw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v4 16/22] x86/fpu/xstate: Extend the table to map state components with features
In-Reply-To: <20210221185637.19281-17-chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com> <20210221185637.19281-17-chang.seok.bae@intel.com>
Date:   Sat, 20 Mar 2021 22:25:01 +0100
Message-ID: <87y2eha576.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 21 2021 at 10:56, Chang S. Bae wrote:
> +struct xfeature_capflag_info {
> +	int xfeature_idx;
> +	short cpu_cap;

First of all please format the struct members tabular as x86 does all
over the place.

What's the purpose of 'int' 'short' here? This data is unsinged. We have
no negative feature bits and no negative xfeatures.

Also if your intention is to save space, then you might want to look at
the compiler output. It's not saving anything, it's still 8 byte because
the compiler pads the struct.

> +};
> +
> +static struct xfeature_capflag_info xfeature_capflags[] __initdata = {
> +	{ XFEATURE_FP,				X86_FEATURE_FPU },
> +	{ XFEATURE_SSE,				X86_FEATURE_XMM },
> +	{ XFEATURE_YMM,				X86_FEATURE_AVX },
> +	{ XFEATURE_BNDREGS,			X86_FEATURE_MPX },
> +	{ XFEATURE_BNDCSR,			X86_FEATURE_MPX },
> +	{ XFEATURE_OPMASK,			X86_FEATURE_AVX512F },
> +	{ XFEATURE_ZMM_Hi256,			X86_FEATURE_AVX512F },
> +	{ XFEATURE_Hi16_ZMM,			X86_FEATURE_AVX512F },
> +	{ XFEATURE_PT_UNIMPLEMENTED_SO_FAR,	X86_FEATURE_INTEL_PT },
> +	{ XFEATURE_PKRU,			X86_FEATURE_PKU },
> +	{ XFEATURE_PASID,			X86_FEATURE_ENQCMD },
>  };

And you could have changed the existing table just so:

static unsigned short xsave_cpuid_features[] __initdata = {
	[XFEATURE_FP]                          = X86_FEATURE_FPU,
	[XFEATURE_SSE]                         = X86_FEATURE_XMM,
	[XFEATURE_YMM]                         = X86_FEATURE_AVX,
	[XFEATURE_BNDREGS]                     = X86_FEATURE_MPX,
	[XFEATURE_BNDCSR]                      = X86_FEATURE_MPX,
	[XFEATURE_OPMASK]                      = X86_FEATURE_AVX512F,
	[XFEATURE_ZMM_Hi256]                   = X86_FEATURE_AVX512F,
	[XFEATURE_Hi16_ZMM]                    = X86_FEATURE_AVX512F,
	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]     = X86_FEATURE_INTEL_PT,
	[XFEATURE_PKRU]                        = X86_FEATURE_PKU,
	[XFEATURE_PASID]                       = X86_FEATURE_ENQCMD,
};

and the implementation to:            

        for (i = 0; i < ARRAY_SIZE(xsave_cpuid_features); i++) {
-		if (xsave_cpuid_features[i] || !boot_cpu_has(xsave_cpuid_features[i]))
+		if (xsave_cpuid_features[i] || !boot_cpu_has(xsave_cpuid_features[i]))
                	xfeatures_mask_all &= ~BIT_ULL(i);

Even with the gaps for XTILE the table is smaller, the code is simpler...

> +	for (i = 0; i < ARRAY_SIZE(xfeature_capflags); i++) {
> +		short cpu_cap = xfeature_capflags[i].cpu_cap;
> +		int idx = xfeature_capflags[i].xfeature_idx;
> +
> +		if (!boot_cpu_has(cpu_cap))
> +			xfeatures_mask_all &= ~BIT_ULL(idx);
>  	}
>  
>  	xfeatures_mask_all &= fpu__get_supported_xfeatures_mask();

Thanks,

        tglx
