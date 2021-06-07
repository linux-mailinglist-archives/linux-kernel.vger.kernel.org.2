Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E54539E617
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFGSDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:03:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:34078 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231364AbhFGSDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:03:01 -0400
IronPort-SDR: 7GH5SV6zW5V5y+58tutXH+1O1jBBG20lG6J4ZM49+a7s2INM079kTgH7cWZfLyJQkD1pP4cc3w
 zfXRxIAkpvYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="226012434"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="226012434"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 11:01:08 -0700
IronPort-SDR: AtVubwasQhCX8WWv5y9frrS1uEfpxMIAR80njkx6cCJKXRR5xBPpc4AGN2jAvcqZIb/Aefhm9S
 XleIjLuz73Wg==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="619026583"
Received: from ssanje1x-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.153.170])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 11:01:07 -0700
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
Message-ID: <82f9e5a9-682a-70be-e5ea-938bb742265f@linux.intel.com>
Date:   Mon, 7 Jun 2021 11:01:05 -0700
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

snip

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

Why move this header outside CONFIG_INTEL_TDX_GUEST or CONFIG_AMD_MEM_ENCRYPT ifdef?

This header only exists in x86 arch code. So it is better to protect it with x86
specific header file.

>   static inline bool protected_guest_has(unsigned long flag)
>   {
>   	if (is_tdx_guest())
>   		return tdx_protected_guest_has(flag);
> -	else if (mem_encrypt_active())
> -		return amd_protected_guest_has(flag);
> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return sev_protected_guest_has(flag);
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
