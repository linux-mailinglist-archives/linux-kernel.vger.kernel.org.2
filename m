Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D92C531A6FB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBLViW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:38:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231720AbhBLViS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:38:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1698464E36;
        Fri, 12 Feb 2021 21:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613165857;
        bh=VhO4KwYQfjLMcVQl/d62MwxLvX+UyY8Vsf6ti99Gh0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D03pNCag8MIEkTNe9nm+P56wVIyrC7gkNpk/Jr0u9Zq1eZRD/MeoFZFieuKYvJ0bT
         0fx2BXsthw851ouokiWtDlz8KK28SzDpa+Rw1MmLWK2pV9UG6c+SEXG0STwnIG9pC6
         LS6me3SNKegXz/E94gGkRy5g5ghhuTv2DgmV9Xnd3FFO1GIoQ2DCVKftrgDz0SbXJL
         waLki8/aJGt70OUjLa2sH1/UofT7D1m4GAa495PFMnNfZzGRulSwqjmLxBcClsmucc
         ZwnEbDXEc2igJJz4fL9tKU+FO0qjNofNFCXsm2MgUZuFwQ/OzIWUPYRN5lPDZQfeNF
         WT+B5oPOfu1ww==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F31EA40513; Fri, 12 Feb 2021 18:37:34 -0300 (-03)
Date:   Fri, 12 Feb 2021 18:37:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org
Subject: Re: [RFC][PATCH 1/2] x86: remove duplicate TSC DEADLINE MSR
 definitions
Message-ID: <20210212213734.GN1398414@kernel.org>
References: <20200305174706.0D6B8EE4@viggo.jf.intel.com>
 <20210205093105.GA17488@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205093105.GA17488@zn.tnic>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 05, 2021 at 10:31:05AM +0100, Borislav Petkov escreveu:
> On Thu, Mar 05, 2020 at 09:47:06AM -0800, Dave Hansen wrote:
> > 
> > There are two definitions for the TSC deadline MSR in msr-index.h,
> > one with an underscore and one without.  Axe one of them and move
> > all the references over to the other one.
> > 
> > Cc: x86@kernel.org
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > 
> > ---
> > 
> >  b/arch/x86/include/asm/msr-index.h                       |    2 --
> >  b/arch/x86/kvm/x86.c                                     |    6 +++---
> >  b/tools/arch/x86/include/asm/msr-index.h                 |    2 --
> >  b/tools/perf/trace/beauty/tracepoints/x86_msr.sh         |    2 +-
> >  b/tools/testing/selftests/kvm/include/x86_64/processor.h |    2 --
> 
> acme, ACK to take the perf bits through tip?

Sure
 
> Leaving in the rest.
> 
> >  5 files changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff -puN arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE arch/x86/include/asm/msr-index.h
> > --- a/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.049901042 -0800
> > +++ b/arch/x86/include/asm/msr-index.h	2020-03-05 09:42:37.062901042 -0800
> > @@ -576,8 +576,6 @@
> >  #define MSR_IA32_APICBASE_ENABLE	(1<<11)
> >  #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
> >  
> > -#define MSR_IA32_TSCDEADLINE		0x000006e0
> > -
> >  #define MSR_IA32_UCODE_WRITE		0x00000079
> >  #define MSR_IA32_UCODE_REV		0x0000008b
> >  
> > diff -puN arch/x86/kvm/x86.c~kill-dup-MSR_IA32_TSCDEADLINE arch/x86/kvm/x86.c
> > --- a/arch/x86/kvm/x86.c~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.051901042 -0800
> > +++ b/arch/x86/kvm/x86.c	2020-03-05 09:42:37.065901042 -0800
> > @@ -1200,7 +1200,7 @@ static const u32 emulated_msrs_all[] = {
> >  	MSR_KVM_PV_EOI_EN,
> >  
> >  	MSR_IA32_TSC_ADJUST,
> > -	MSR_IA32_TSCDEADLINE,
> > +	MSR_IA32_TSC_DEADLINE,
> >  	MSR_IA32_ARCH_CAPABILITIES,
> >  	MSR_IA32_MISC_ENABLE,
> >  	MSR_IA32_MCG_STATUS,
> > @@ -2688,7 +2688,7 @@ int kvm_set_msr_common(struct kvm_vcpu *
> >  		return kvm_set_apic_base(vcpu, msr_info);
> >  	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
> >  		return kvm_x2apic_msr_write(vcpu, msr, data);
> > -	case MSR_IA32_TSCDEADLINE:
> > +	case MSR_IA32_TSC_DEADLINE:
> >  		kvm_set_lapic_tscdeadline_msr(vcpu, data);
> >  		break;
> >  	case MSR_IA32_TSC_ADJUST:
> > @@ -3009,7 +3009,7 @@ int kvm_get_msr_common(struct kvm_vcpu *
> >  	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
> >  		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
> >  		break;
> > -	case MSR_IA32_TSCDEADLINE:
> > +	case MSR_IA32_TSC_DEADLINE:
> >  		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
> >  		break;
> >  	case MSR_IA32_TSC_ADJUST:
> > diff -puN tools/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE tools/arch/x86/include/asm/msr-index.h
> > --- a/tools/arch/x86/include/asm/msr-index.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.055901042 -0800
> > +++ b/tools/arch/x86/include/asm/msr-index.h	2020-03-05 09:42:37.066901042 -0800
> > @@ -576,8 +576,6 @@
> >  #define MSR_IA32_APICBASE_ENABLE	(1<<11)
> >  #define MSR_IA32_APICBASE_BASE		(0xfffff<<12)
> >  
> > -#define MSR_IA32_TSCDEADLINE		0x000006e0
> > -
> >  #define MSR_IA32_UCODE_WRITE		0x00000079
> >  #define MSR_IA32_UCODE_REV		0x0000008b
> >  
> > diff -puN tools/perf/trace/beauty/tracepoints/x86_msr.sh~kill-dup-MSR_IA32_TSCDEADLINE tools/perf/trace/beauty/tracepoints/x86_msr.sh
> > --- a/tools/perf/trace/beauty/tracepoints/x86_msr.sh~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.057901042 -0800
> > +++ b/tools/perf/trace/beauty/tracepoints/x86_msr.sh	2020-03-05 09:42:37.066901042 -0800
> > @@ -15,7 +15,7 @@ x86_msr_index=${arch_x86_header_dir}/msr
> >  
> >  printf "static const char *x86_MSRs[] = {\n"
> >  regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MSR_([[:alnum:]][[:alnum:]_]+)[[:space:]]+(0x00000[[:xdigit:]]+)[[:space:]]*.*'
> > -egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSCDEADLINE|IDT_FCR4)' | \
> > +egrep $regex ${x86_msr_index} | egrep -v 'MSR_(ATOM|P[46]|AMD64|IA32_TSC_DEADLINE|IDT_FCR4)' | \
> >  	sed -r "s/$regex/\2 \1/g" | sort -n | \
> >  	xargs printf "\t[%s] = \"%s\",\n"
> >  printf "};\n\n"
> > diff -puN tools/testing/selftests/kvm/include/x86_64/processor.h~kill-dup-MSR_IA32_TSCDEADLINE tools/testing/selftests/kvm/include/x86_64/processor.h
> > --- a/tools/testing/selftests/kvm/include/x86_64/processor.h~kill-dup-MSR_IA32_TSCDEADLINE	2020-03-05 09:42:37.058901042 -0800
> > +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h	2020-03-05 09:42:37.067901042 -0800
> > @@ -813,8 +813,6 @@ void kvm_get_cpu_address_width(unsigned
> >  #define		APIC_VECTOR_MASK	0x000FF
> >  #define	APIC_ICR2	0x310
> >  
> > -#define MSR_IA32_TSCDEADLINE		0x000006e0
> > -
> >  #define MSR_IA32_UCODE_WRITE		0x00000079
> >  #define MSR_IA32_UCODE_REV		0x0000008b
> >  
> > _
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 

- Arnaldo
