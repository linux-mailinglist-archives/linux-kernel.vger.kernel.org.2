Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4322735217E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 23:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbhDAVR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 17:17:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:50949 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234065AbhDAVRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 17:17:55 -0400
IronPort-SDR: Da++G4s+zh3TrMtqRIl095h7QtpYUG9tYhrMjsZg/H83hesq6iOKrT9t0MHVxjgl2akU6RwDq0
 yh9UzvkQk02g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179465019"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179465019"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:17:55 -0700
IronPort-SDR: LfyvV3st3bZJke4KhgrQEGLoszJGEW97KoyhSeg8gM49SE9s4cjNBfldaAZVdL6NswhmRa8pKO
 1x2f3HhYUKDQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="611065152"
Received: from pzlai-mobl.amr.corp.intel.com (HELO [10.213.169.242]) ([10.213.169.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 14:17:54 -0700
Subject: Re: [RFC v1 26/26] x86/kvm: Use bounce buffers for TD guest
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <72ebe1575ff79bce7be38b8093aeb41032562a22.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <1741d632-0ed0-6a5b-efae-4fdb2689e20f@intel.com>
Date:   Thu, 1 Apr 2021 14:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72ebe1575ff79bce7be38b8093aeb41032562a22.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> TDX doesn't allow to perform DMA access to guest private memory.
> In order for DMA to work properly in TD guest, user SWIOTLB bounce
> buffers.
> 
> Move AMD SEV initialization into common code and adopt for TDX.

This would be best if it can draw a parallel between TDX and SEV.

>  arch/x86/kernel/pci-swiotlb.c    |  2 +-
>  arch/x86/kernel/tdx.c            |  3 +++
>  arch/x86/mm/mem_encrypt.c        | 44 -------------------------------
>  arch/x86/mm/mem_encrypt_common.c | 45 ++++++++++++++++++++++++++++++++
>  4 files changed, 49 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index c2cfa5e7c152..020e13749758 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -49,7 +49,7 @@ int __init pci_swiotlb_detect_4gb(void)
>  	 * buffers are allocated and used for devices that do not support
>  	 * the addressing range required for the encryption mask.
>  	 */
> -	if (sme_active())
> +	if (sme_active() || is_tdx_guest())
>  		swiotlb = 1;
>  
>  	return swiotlb;
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index f51a19168adc..ccb9401bd706 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -9,6 +9,7 @@
>  #include <asm/vmx.h>
>  #include <asm/insn.h>
>  #include <linux/sched/signal.h> /* force_sig_fault() */
> +#include <linux/swiotlb.h>
>  
>  #ifdef CONFIG_KVM_GUEST
>  #include "tdx-kvm.c"
> @@ -472,6 +473,8 @@ void __init tdx_early_init(void)
>  
>  	legacy_pic = &null_legacy_pic;
>  
> +	swiotlb_force = SWIOTLB_FORCE;

Dumb question time.  But, what is the difference between

	swiotlb = 1;

and

	swiotlb_force = SWIOTLB_FORCE;

It would be nice of the patch to enable me to be a lazy reviewer.

>  	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "tdx:cpu_hotplug",
>  			  NULL, tdx_cpu_offline_prepare);
>  
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 11a6a7b3af7e..7fbbb2f3d426 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c

Should we be renaming this to amd_mem_encrypt.c or something?

...
> -	 */
> -	if (sev_active())
> -		static_branch_enable(&sev_enable_key);
> -
> -	print_mem_encrypt_feature_info();
> -}
> -
> diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
> index b6d93b0c5dcf..6f3d90d4d68e 100644
> --- a/arch/x86/mm/mem_encrypt_common.c
> +++ b/arch/x86/mm/mem_encrypt_common.c
> @@ -10,6 +10,7 @@
>  #include <linux/mm.h>
>  #include <linux/mem_encrypt.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/swiotlb.h>
>  
>  /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
>  bool force_dma_unencrypted(struct device *dev)
> @@ -36,3 +37,47 @@ bool force_dma_unencrypted(struct device *dev)
>  
>  	return false;
>  }
> +
> +static void print_mem_encrypt_feature_info(void)
> +{

This function is now named wrong IMNHO.  If it's about AMD only, it
needs AMD in the name.

> +	pr_info("AMD Memory Encryption Features active:");
> +
> +	/* Secure Memory Encryption */
> +	if (sme_active()) {
> +		/*
> +		 * SME is mutually exclusive with any of the SEV
> +		 * features below.
> +		 */
> +		pr_cont(" SME\n");
> +		return;
> +	}
> +
> +	/* Secure Encrypted Virtualization */
> +	if (sev_active())
> +		pr_cont(" SEV");
> +
> +	/* Encrypted Register State */
> +	if (sev_es_active())
> +		pr_cont(" SEV-ES");
> +
> +	pr_cont("\n");
> +}

I'm really tempted to say this needs to be off in arch/x86/kernel/cpu/amd.c

> +/* Architecture __weak replacement functions */
> +void __init mem_encrypt_init(void)
> +{
> +	if (!sme_me_mask && !is_tdx_guest())
> +		return;

The direct check of sme_me_mask looks odd now.  What does this *MEAN*?
Are we looking to jump out of here if no memory encryption is enabled?

I'd much rather this look more like:

	if (!x86_memory_encryption())
		return;

> +	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
> +	swiotlb_update_mem_attributes();
> +	/*
> +	 * With SEV, we need to unroll the rep string I/O instructions.
> +	 */
> +	if (sev_active())
> +		static_branch_enable(&sev_enable_key);
> +
> +	if (!is_tdx_guest())
> +		print_mem_encrypt_feature_info();
> +}

