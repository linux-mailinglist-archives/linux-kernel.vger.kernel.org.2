Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A21D039AA11
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhFCSfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:35:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:51916 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229881AbhFCSfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:35:45 -0400
IronPort-SDR: nTWbcctoTbJQyziP4SOl4Aw4YamsZXANl7YmbQXQmyxP4VBcJT/qtWd2C8sLCgPuNg9zkgFrVS
 x0F0NzH3wkqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204101412"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="204101412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:33:56 -0700
IronPort-SDR: S2Mvcw5l149MaBFfOIgSvmArchHKNEO57xPABoVdEmi5dPSPT35e1bFw+5CXUsHZCuGFa77oJw
 0nuntYJEijDQ==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="480333355"
Received: from jacobmon-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.36.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 11:33:55 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86: Introduce generic protected guest
 abstraction
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210527042356.3983284-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210601211417.2177598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YLkcIuL2qvo0hviU@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d062aedf-29d9-a83f-a727-109aaf766bf9@linux.intel.com>
Date:   Thu, 3 Jun 2021 11:33:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLkcIuL2qvo0hviU@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/21 11:14 AM, Borislav Petkov wrote:
> On Tue, Jun 01, 2021 at 02:14:17PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
>> new file mode 100644
>> index 000000000000..303dfba81d52
>> --- /dev/null
>> +++ b/include/linux/protected_guest.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef _LINUX_PROTECTED_GUEST_H
>> +#define _LINUX_PROTECTED_GUEST_H 1
>> +
>> +#include <linux/mem_encrypt.h>
>> +
>> +/* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
>> +
>> +/* Support for guest encryption */
>> +#define VM_MEM_ENCRYPT			0x100
>> +/* Encryption support is active */
>> +#define VM_MEM_ENCRYPT_ACTIVE		0x101
>> +/* Support for unrolled string IO */
>> +#define VM_UNROLL_STRING_IO		0x102
>> +/* Support for host memory encryption */
>> +#define VM_HOST_MEM_ENCRYPT		0x103
>> +/* Support for shared mapping initialization (after early init) */
>> +#define VM_SHARED_MAPPING_INIT		0x104
> 
> Ok, a couple of things:
> 
> first of all, those flags with that VM_ prefix make me think of
> "virtual memory" instead of "virtual machine". So they should be
> something else, like, say
> 
> PR_G_... for Protected Guest or so. Or PR_GUEST or ...

I would prefer PR_GUEST over PR_G_

> 
> (yeah, good namespaces are all taken. )
> 
> Then, about the function name length, I'm fine if we did:
> 
> 	prot_guest_has()
> 
> or something even shorter, if you folks have a good suggestion.
> 
> Anyway, below is a diff ontop of your tree with what I think the
> barebones of this should be.
> 
> As a reply to this message I went and converted sme_active() to use
> protected_guest_has() too.
> 
> Comments, complaints?
> 
> Thx.
> 
> ---
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index 1492b0eb29d0..9c80c68d75b5 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -56,8 +56,6 @@ bool sev_es_active(void);
>   
>   #define __bss_decrypted __section(".bss..decrypted")
>   
> -bool amd_protected_guest_has(unsigned long flag);
> -
>   #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>   
>   #define sme_me_mask	0ULL
> @@ -88,8 +86,6 @@ early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0;
>   
>   static inline void mem_encrypt_free_decrypted_mem(void) { }
>   
> -static inline bool amd_protected_guest_has(unsigned long flag) { return false; }
> -
>   #define __bss_decrypted
>   
>   #endif	/* CONFIG_AMD_MEM_ENCRYPT */
> diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
> index fa5cd05d3b5b..f09996c6a272 100644
> --- a/arch/x86/include/asm/sev.h
> +++ b/arch/x86/include/asm/sev.h
> @@ -11,6 +11,7 @@
>   #include <linux/types.h>
>   #include <asm/insn.h>
>   #include <asm/sev-common.h>
> +#include <asm/pgtable_types.h>
>   
>   #define GHCB_PROTO_OUR		0x0001UL
>   #define GHCB_PROTOCOL_MAX	1ULL
> @@ -81,12 +82,15 @@ static __always_inline void sev_es_nmi_complete(void)
>   		__sev_es_nmi_complete();
>   }
>   extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
> +bool sev_protected_guest_has(unsigned long flag);
> +
>   #else
>   static inline void sev_es_ist_enter(struct pt_regs *regs) { }
>   static inline void sev_es_ist_exit(void) { }
>   static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
>   static inline void sev_es_nmi_complete(void) { }
>   static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
> +static inline bool sev_protected_guest_has(unsigned long flag) { return false; }
>   #endif
>   
> -#endif
> +#endif /* __ASM_ENCRYPTED_STATE_H */
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index f7a743d122eb..01a224fdb897 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -1402,3 +1402,14 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>   	while (true)
>   		halt();
>   }
> +
> +bool sev_protected_guest_has(unsigned long flag)
> +{
> +	switch (flag) {
> +	case VM_MEM_ENCRYPT:
> +	case VM_MEM_ENCRYPT_ACTIVE:
> +		return true;
> +	}
> +
> +	return false;
> +}

I assume this file will get compiled for both SEV and SME cases.

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index ced658e79753..49d11bb6e02a 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -391,18 +391,6 @@ bool noinstr sev_es_active(void)
>   	return sev_status & MSR_AMD64_SEV_ES_ENABLED;
>   }
>   
> -bool amd_protected_guest_has(unsigned long flag)
> -{
> -	switch (flag) {
> -	case VM_MEM_ENCRYPT:
> -	case VM_MEM_ENCRYPT_ACTIVE:
> -		return true;
> -	}
> -
> -	return false;
> -}
> -EXPORT_SYMBOL_GPL(amd_protected_guest_has);
> -
>   /* Override for DMA direct allocation check - AMD specific initialization */
>   bool amd_force_dma_unencrypted(struct device *dev)
>   {
> diff --git a/include/linux/protected_guest.h b/include/linux/protected_guest.h
> index 6855d5b3e244..bb4b1a06b21f 100644
> --- a/include/linux/protected_guest.h
> +++ b/include/linux/protected_guest.h
> @@ -2,7 +2,9 @@
>   #ifndef _LINUX_PROTECTED_GUEST_H
>   #define _LINUX_PROTECTED_GUEST_H 1
>   
> -#include <linux/mem_encrypt.h>
> +#include <asm/processor.h>
> +#include <asm/tdx.h>
> +#include <asm/sev.h>
>   
>   /* Protected Guest Feature Flags (leave 0-0xff for arch specific flags) */
>   
> @@ -20,23 +22,18 @@
>   #define VM_DISABLE_UNCORE_SUPPORT	0x105
>   
>   #if defined(CONFIG_INTEL_TDX_GUEST) || defined(CONFIG_AMD_MEM_ENCRYPT)
> -
> -#include <asm/tdx.h>
> -
>   static inline bool protected_guest_has(unsigned long flag)
>   {
>   	if (is_tdx_guest())
>   		return tdx_protected_guest_has(flag);
> -	else if (mem_encrypt_active())
> -		return amd_protected_guest_has(flag);
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return sev_protected_guest_has(flag);

Since you are checking for AMD vendor ID, why not use amd_protected_guest_has()?

>   
>   	return false;
>   }
>   
>   #else
> -
>   static inline bool protected_guest_has(unsigned long flag) { return false; }
> -
>   #endif
>   
> -#endif
> +#endif /* _LINUX_PROTECTED_GUEST_H */
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
