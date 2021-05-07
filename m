Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED2376BE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhEGVrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:47:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:12356 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGVrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:47:45 -0400
IronPort-SDR: TirPp7fMImxyVBNQPLySX7/S1p4Gs4weWVEpxdk+rdJiVwxakLuR2ktZVAljTvJwQP7FiqV5AU
 KUBZLPHM0MOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="178382805"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="178382805"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:46:44 -0700
IronPort-SDR: TsPHdmpeaje8A1mMeStcCLoEz/3fxdWh4p7Ouw62oeA3rCUFn7fhEWLH6qBCaFvaGcyx4h60FF
 wLTQ8pUkLGeQ==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431677987"
Received: from msandrid-mobl.amr.corp.intel.com (HELO [10.212.134.124]) ([10.212.134.124])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:46:43 -0700
Subject: Re: [RFC v2 10/32] x86/tdx: Wire up KVM hypercalls
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <04de6cd6549eee0b77fe3b0937c4b4b7f0e3ff2e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <bc2e6da5-f35d-6574-52d0-82d996e56920@intel.com>
Date:   Fri, 7 May 2021 14:46:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <04de6cd6549eee0b77fe3b0937c4b4b7f0e3ff2e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> KVM hypercalls have to be wrapped into vendor-specific TDVMCALLs.

How about:

KVM hypercalls use the "vmcall" or "vmmcall" instructions.  Although the
ABI is similar, those instructions no longer function for TDX guests.
Make TDVMCALLs instead of VMCALL/VMCALL.

> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 338119852512..2fa85481520b 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -6,6 +6,7 @@
>  #include <asm/alternative.h>
>  #include <linux/interrupt.h>
>  #include <uapi/asm/kvm_para.h>
> +#include <asm/tdx.h>
>  
>  extern void kvmclock_init(void);
>  
> @@ -34,6 +35,10 @@ static inline bool kvm_check_and_clear_guest_paused(void)
>  static inline long kvm_hypercall0(unsigned int nr)
>  {
>  	long ret;
> +
> +	if (is_tdx_guest())
> +		return tdx_kvm_hypercall0(nr);

... all of these look OK.

>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/tdcall.S b/arch/x86/kernel/tdcall.S
> index 81af70c2acbd..964bfd7fc682 100644
> --- a/arch/x86/kernel/tdcall.S
> +++ b/arch/x86/kernel/tdcall.S
> @@ -11,6 +11,7 @@
>   * refer to TDX GHCI specification).
>   */
>  #define TDVMCALL_EXPOSE_REGS_MASK	0xfc00
> +#define TDVMCALL_VENDOR_KVM		0x4d564b2e584454 /* "TDX.KVM" */
>  
>  /*
>   * TDX guests use the TDCALL instruction to make
> @@ -198,3 +199,9 @@ SYM_FUNC_START(__tdvmcall)
>  	call do_tdvmcall
>  	retq
>  SYM_FUNC_END(__tdvmcall)
> +
> +SYM_FUNC_START(__tdvmcall_vendor_kvm)
> +	movq $TDVMCALL_VENDOR_KVM, %r10
> +	call do_tdvmcall
> +	retq
> +SYM_FUNC_END(__tdvmcall_vendor_kvm)

Granted, this is not a ton of assembly.  But, it does look a bit weird.
 It needs a comment and/or a mention in the changelog.

R10 is not part of the function call ABI, but it is a part of the
TDVMCALL ABI.  This little assembly wrapper lets us reuse do_tdvmcall()
for both KVM-specific hypercalls TDVMCALL_VENDOR_KVM and the more
generic __tdvmcalls.

> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -8,6 +8,10 @@
>  
>  #include <linux/cpu.h>
>  
> +#ifdef CONFIG_KVM_GUEST
> +#include "tdx-kvm.c"
> +#endif
> +
>  static struct {
>  	unsigned int gpa_width;
>  	unsigned long attributes;

I know KVM does weird stuff.  But, this is *really* weird.  Why are we
#including a .c file into another .c file?
