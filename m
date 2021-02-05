Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462383107F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBEJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:34:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:60562 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhBEJbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:31:53 -0500
Received: from zn.tnic (p200300ec2f0bad000b74c3ca4e4ea61e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ad00:b74:c3ca:4e4e:a61e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 932661EC04DF;
        Fri,  5 Feb 2021 10:31:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1612517469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dYpqaAC8S7f7CDYCrc4aIJXudkETAjwiqKr9RlNwrtc=;
        b=sDiIkaCA7agPsTaK+kjcqZk811Ym6LkCJ/dwDAUaoHU7gzXWtcQoTbQomzwmHWNnYzGPXg
        h1B0+AmnUfqKrvoizOkcEcB+ZwR4KZudVaKQIcb7aj4o0x9d+ioZ5EoTkzps/TwpIcuV8z
        eR32JiN/vRXfZtygqZsdqphOFW2bBek=
Date:   Fri, 5 Feb 2021 10:31:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: Re: [RFC][PATCH 1/2] x86: remove duplicate TSC DEADLINE MSR
 definitions
Message-ID: <20210205093105.GA17488@zn.tnic>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 09:47:06AM -0800, Dave Hansen wrote:
> 
> There are two definitions for the TSC deadline MSR in msr-index.h,
> one with an underscore and one without.  Axe one of them and move
> all the references over to the other one.
> 
> Cc: x86@kernel.org
> Cc: Peter Zijlstra <peterz@infradead.org>
> 
> ---
> 
>  b/arch/x86/include/asm/msr-index.h                       |    2 --
>  b/arch/x86/kvm/x86.c                                     |    6 +++---
>  b/tools/arch/x86/include/asm/msr-index.h                 |    2 --
>  b/tools/perf/trace/beauty/tracepoints/x86_msr.sh         |    2 +-
>  b/tools/testing/selftests/kvm/include/x86_64/processor.h |    2 --

acme, ACK to take the perf bits through tip?

Leaving in the rest.

>  5 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff -puN arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE arch/x86/include/asm/msr-index.h
> --- a/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.049901042 -0800
> +++ b/arch/x86/include/asm/msr-index.h	2020-03-05 09:42:37.062901042 -0800
> @@ -576,8 +576,6 @@
>  #define MSR_IA32_APICBASE_ENABLE	(1<<11)
>  #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
>  
> -#define MSR_IA32_TSCDEADLINE		0x000006e0
> -
>  #define MSR_IA32_UCODE_WRITE		0x00000079
>  #define MSR_IA32_UCODE_REV		0x0000008b
>  
> diff -puN arch/x86/kvm/x86.c~kill-dup-MSR_IA32_TSCDEADLINE arch/x86/kvm/x86.c
> --- a/arch/x86/kvm/x86.c~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.051901042 -0800
> +++ b/arch/x86/kvm/x86.c	2020-03-05 09:42:37.065901042 -0800
> @@ -1200,7 +1200,7 @@ static const u32 emulated_msrs_all[] = {
>  	MSR_KVM_PV_EOI_EN,
>  
>  	MSR_IA32_TSC_ADJUST,
> -	MSR_IA32_TSCDEADLINE,
> +	MSR_IA32_TSC_DEADLINE,
>  	MSR_IA32_ARCH_CAPABILITIES,
>  	MSR_IA32_MISC_ENABLE,
>  	MSR_IA32_MCG_STATUS,
> @@ -2688,7 +2688,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
>  		return kvm_set_apic_base(vcpu, msr_info);
>  	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
>  		return kvm_x2apic_msr_write(vcpu, msr, data);
> -	case MSR_IA32_TSCDEADLINE:
> +	case MSR_IA32_TSC_DEADLINE:
>  		kvm_set_lapic_tscdeadline_msr(vcpu, data);
>  		break;
>  	case MSR_IA32_TSC_ADJUST:
> @@ -3009,7 +3009,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
>  	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
>  		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
>  		break;
> -	case MSR_IA32_TSCDEADLINE:
> +	case MSR_IA32_TSC_DEADLINE:
>  		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
>  		break;
>  	case MSR_IA32_TSC_ADJUST:
> diff -puN tools/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE tools/arch/x86/include/asm/msr-index.h
> --- a/tools/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.055901042 -0800
> +++ b/tools/arch/x86/include/asm/msr-index.h	2020-03-05 09:42:37.066901042 -0800
> @@ -576,8 +576,6 @@
>  #define MSR_IA32_APICBASE_ENABLE	(1<<11)
>  #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
>  
> -#define MSR_IA32_TSCDEADLINE		0x000006e0
> -
>  #define MSR_IA32_UCODE_WRITE		0x00000079
>  #define MSR_IA32_UCODE_REV		0x0000008b
>  
> diff -puN tools/perf/trace/beauty/tracepoints/x86_msr.sh~kill-dup-MSR_IA32_TSCDEADLINE tools/perf/trace/beauty/tracepoints/x86_msr.sh
> --- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.057901042 -0800
> +++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh	2020-03-05 09:42:37.066901042 -0800
> @@ -15,7 +15,7 @@ x86_msr_index=${arch_x86_header_dir}/msr
>  
>  printf "static const char *x86_MSRs[] = {\n"
>  regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
> -egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSCDEADLINE|IDT_FCR4)' | \
> +egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSC_DEADLINE|IDT_FCR4)' | \
>  	sed -r "s/$regex/\2 \1/g" | sort -n | \
>  	xargs printf "\t[%s] = \"%s\",\n"
>  printf "};\n\n"
> diff -puN tools/testing/selftests/kvm/include/x86_64/processor.h~kill-dup-MSR_IA32_TSCDEADLINE tools/testing/selftests/kvm/include/x86_64/processor.h
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.058901042 -0800
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h	2020-03-05 09:42:37.067901042 -0800
> @@ -813,8 +813,6 @@ void kvm_get_cpu_address_width(unsigned
>  #define		APIC_VECTOR_MASK	0x000FF
>  #define	APIC_ICR2	0x310
>  
> -#define MSR_IA32_TSCDEADLINE		0x000006e0
> -
>  #define MSR_IA32_UCODE_WRITE		0x00000079
>  #define MSR_IA32_UCODE_REV		0x0000008b
>  
> _

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
