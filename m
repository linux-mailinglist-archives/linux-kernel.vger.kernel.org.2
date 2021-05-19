Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD5B38937A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355138AbhESQTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:19:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:43531 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240297AbhESQTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:19:11 -0400
IronPort-SDR: k/kZNvgjmnp35G4krEGi3hi7Zkhgqwzr5aSVMWAOTNVoeLnuT4ewJ8YCJZmRp75L4DWZP3IhoW
 tnGBjwmXvYfA==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="200707631"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="200707631"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 09:14:05 -0700
IronPort-SDR: kdy48xDvviEBq3GPD0EL3d+dehKgv0oH7MjYRqNJLL/xskwkofRc7Kk26R+QmueHp2Jsndai3K
 00FKgZlpmi+g==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474690753"
Received: from mconrado-mobl1.amr.corp.intel.com (HELO [10.209.83.57]) ([10.209.83.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 09:14:03 -0700
Subject: Re: [RFC v2 27/32] x86/tdx: Exclude Shared bit from __PHYSICAL_MASK
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
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <3ae38a0b-0676-1543-7015-39a589b2807a@intel.com>
Date:   Wed, 19 May 2021 09:14:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87b31425b79df3cc44d2bdc6a79d6aa36c42d116.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> tdx_shared_mask() returns the mask that has to be set in a page
> table entry to make page shared with VMM.

Here's a rewrite:

Just like MKTME, TDX reassigns bits of the physical address for
metadata.  MKTME used several bits for an encryption KeyID.  TDX uses a
single bit in guests to communicate whether a physical page should be
protected by TDX as private memory (bit set to 0) or unprotected and
shared with the VMM (bit set to 1).

Add a helper, tdg_shared_mask() (bad name please fix it) to generate the
mask.  The processor enumerates its physical address width to include
the shared bit, which means it gets included in __PHYSICAL_MASK by default.

Remove the shared mask from 'physical_mask' since any bits in
tdg_shared_mask() are not used for physical addresses in page table entries.

--

BTW, do you find it confusing that the subject says: '__PHYSICAL_MASK'
and yet the code only modifies 'physical_mask'?

> Also, note that we cannot club shared mapping configuration between
> AMD SME and Intel TDX Guest platforms in common function. SME has
> to do it very early in __startup_64() as it sets the bit on all
> memory, except what is used for communication. TDX can postpone as
> we don't need any shared mapping in very early boot.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/Kconfig           | 1 +
>  arch/x86/include/asm/tdx.h | 6 ++++++
>  arch/x86/kernel/tdx.c      | 9 +++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 67f99bf27729..5f92e8205de2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -882,6 +882,7 @@ config INTEL_TDX_GUEST
>  	select PARAVIRT_XL
>  	select X86_X2APIC
>  	select SECURITY_LOCKDOWN_LSM
> +	select X86_MEM_ENCRYPT_COMMON
>  	help
>  	  Provide support for running in a trusted domain on Intel processors
>  	  equipped with Trusted Domain eXtenstions. TDX is an new Intel
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index b972c6531a53..dc80cf7f7d08 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -111,6 +111,8 @@ unsigned char tdg_inb(unsigned short port);
>  unsigned short tdg_inw(unsigned short port);
>  unsigned int tdg_inl(unsigned short port);
>  
> +extern phys_addr_t tdg_shared_mask(void);
> +
>  #else // !CONFIG_INTEL_TDX_GUEST
>  
>  static inline bool is_tdx_guest(void)
> @@ -149,6 +151,10 @@ static inline long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1,
>  	return -ENODEV;
>  }
>  
> +static inline phys_addr_t tdg_shared_mask(void)
> +{
> +	return 0;
> +}
>  #endif /* CONFIG_INTEL_TDX_GUEST */
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 1f1bb98e1d38..7e391cd7aa2b 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -76,6 +76,12 @@ bool is_tdx_guest(void)
>  }
>  EXPORT_SYMBOL_GPL(is_tdx_guest);
>  
> +/* The highest bit of a guest physical address is the "sharing" bit */
> +phys_addr_t tdg_shared_mask(void)
> +{
> +	return 1ULL << (td_info.gpa_width - 1);
> +}

Why not just inline this thing?  Functions don't get any smaller than
that.  Or does it not get used anywhere else?  Or are you concerned
about exporting td_info?

>  static void tdg_get_info(void)
>  {
>  	u64 ret;
> @@ -87,6 +93,9 @@ static void tdg_get_info(void)
>  
>  	td_info.gpa_width = out.rcx & GENMASK(5, 0);
>  	td_info.attributes = out.rdx;
> +
> +	/* Exclude Shared bit from the __PHYSICAL_MASK */
> +	physical_mask &= ~tdg_shared_mask();
>  }
>  
>  static __cpuidle void tdg_halt(void)
> 

