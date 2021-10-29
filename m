Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7841E43F9B5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhJ2JXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 05:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230010AbhJ2JXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 05:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635499253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aELSxeLzsNPY5cODBpGLa8izmuFLeHd4iMVoueHjp5Q=;
        b=ZNPT+g5qDlnx4AMr99wv1B1HMC2xB1SYfx98Y91Qk6E4xvLyeWnhi+pj2Axrg2S1NkTQm8
        SD6lvrAg9B9um1HpaBjp4RjDH3ih7cpwXqmk9afYreZ9kAWRrVoXyNa4ymtiZmPGBOrxd5
        4H+FpLzE47cB0RpWn5vIMsGLkQtzkxg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-JENp3RekPVuCEPZTdTrBgQ-1; Fri, 29 Oct 2021 05:20:52 -0400
X-MC-Unique: JENp3RekPVuCEPZTdTrBgQ-1
Received: by mail-wr1-f71.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so3202610wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 02:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aELSxeLzsNPY5cODBpGLa8izmuFLeHd4iMVoueHjp5Q=;
        b=wiiafR5+ecP5UQKEiLc1ksbZmqoL4LfePj/M62ZXx27pqXRE3UcYC48pcGBDYSpIW3
         p8TL8vndXJmv9Jp0BSvqWjQHQNket7BZCe6B8n2+kD6DCNhEIVGlxjvf8nnnQxs1uhkb
         nRq9ZzwQWbRbNrlvX/dAJdtOq/w2qCWMoGW0BP7FGvVC6L3DsB+z2glDatMoR9ArBY6R
         HHmp4LlDa1Wg6/YuRdcYP+fravGht3Tj2Q4U+GBD7DQoLqWIeCTINDDdJP/8KNxIdQ9u
         Rka1YzpB5en6vxjjAL5PGggAQz/IRYUMkgupYyDFCRRALBLGby2OKdXqZFPVUP2L2Vho
         VNgg==
X-Gm-Message-State: AOAM5332tXBHF9bd30kMqLWBIynf63/lpyF8InUpo4X7fLaga3GZJZkQ
        S2ToX5I6iestj9c6fDrXbTcoZyeZrPLqpLFdmX0TeuTsF0DSF+Y+/vLpovY1y91c+W/tHAEgc6q
        sxhnnogvbZBpa+69n4REC8B71
X-Received: by 2002:a7b:c005:: with SMTP id c5mr17972902wmb.155.1635499250913;
        Fri, 29 Oct 2021 02:20:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznSH35qVd188usAUAoH6JOF+N1v9Ugri5msPsP13G8NH9h/V93eqzYP38SWoF/niJrNC18Dg==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr17972880wmb.155.1635499250730;
        Fri, 29 Oct 2021 02:20:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id h1sm4540944wmb.7.2021.10.29.02.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 02:20:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH 2/2] x86/hyperv: Move required MSRs check to initial
 platform probing
In-Reply-To: <20211028222148.2924457-3-seanjc@google.com>
References: <20211028222148.2924457-1-seanjc@google.com>
 <20211028222148.2924457-3-seanjc@google.com>
Date:   Fri, 29 Oct 2021 11:20:49 +0200
Message-ID: <87r1c4rxu6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> Explicitly check for MSR_HYPERCALL and MSR_VP_INDEX support when probing
> for running as a Hyper-V guest instead of waiting until hyperv_init() to
> detect the bogus configuration.  Add messages to give the admin a heads
> up that they are likely running on a broken virtual machine setup.
>
> At best, silently disabling Hyper-V is confusing and difficult to debug,
> e.g. the kernel _says_ it's using all these fancy Hyper-V features, but
> always falls back to the native versions.  At worst, the half baked setup
> will crash/hang the kernel.
>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/hyperv/hv_init.c      |  9 +--------
>  arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
>  2 files changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 6cc845c026d4..abfb09610e22 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -347,20 +347,13 @@ static void __init hv_get_partition_id(void)
>   */
>  void __init hyperv_init(void)
>  {
> -	u64 guest_id, required_msrs;
> +	u64 guest_id;
>  	union hv_x64_msr_hypercall_contents hypercall_msr;
>  	int cpuhp;
>  
>  	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
>  		return;
>  
> -	/* Absolutely required MSRs */
> -	required_msrs = HV_MSR_HYPERCALL_AVAILABLE |
> -		HV_MSR_VP_INDEX_AVAILABLE;
> -
> -	if ((ms_hyperv.features & required_msrs) != required_msrs)
> -		return;
> -
>  	if (hv_common_init())
>  		return;
>  
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index e095c28d27ae..ef6316fef99f 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -163,12 +163,22 @@ static uint32_t  __init ms_hyperv_platform(void)
>  	cpuid(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS,
>  	      &eax, &hyp_signature[0], &hyp_signature[1], &hyp_signature[2]);
>  
> -	if (eax >= HYPERV_CPUID_MIN &&
> -	    eax <= HYPERV_CPUID_MAX &&
> -	    !memcmp("Microsoft Hv", hyp_signature, 12))
> -		return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
> +	if (eax < HYPERV_CPUID_MIN || eax > HYPERV_CPUID_MAX ||
> +	    memcmp("Microsoft Hv", hyp_signature, 12))
> +		return 0;
>  
> -	return 0;
> +	/* HYPERCALL and VP_INDEX MSRs are mandatory for all features. */
> +	eax = cpuid_eax(HYPERV_CPUID_FEATURES);
> +	if (!(eax & HV_MSR_HYPERCALL_AVAILABLE)) {
> +		pr_warn("x86/hyperv: HYPERCALL MSR not available.\n");
> +		return 0;
> +	}
> +	if (!(eax & HV_MSR_VP_INDEX_AVAILABLE)) {
> +		pr_warn("x86/hyperv: VP_INDEX MSR not available.\n");
> +		return 0;
> +	}
> +
> +	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
>  }
>  
>  static unsigned char hv_get_nmi_reason(void)

In theory, we can get away without VP_INDEX MSR as e.g. PV spinlocks
don't need it but it will require us to add the check to all other
features which actually need it and disable them so it's probably not
worth the effort (and unless we're running on KVM/QEMU which actually
*can* create such configuration, it's likely impossible to meet such
setup in real life).

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

