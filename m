Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAFE389325
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355059AbhESQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:00:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:12728 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355046AbhESQA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:00:27 -0400
IronPort-SDR: tPMrkotKm0z4TRyFCowZd5jXu9Nlb9LZ7sAGEhWg/qLbYzOMyGDxrLyAPIbsW/I7G2J4doXZff
 WEPaIIBJ2u1w==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="181287198"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181287198"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:59:07 -0700
IronPort-SDR: KX8HN55gRTtx1o223ApTBGDmY2sO0VGE12XpbWwCDLvJo67fCrndXXVSCfEWxzBSlIKQApyUK7
 M+JT5Sqj8Q4A==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="474683001"
Received: from mconrado-mobl1.amr.corp.intel.com (HELO [10.209.83.57]) ([10.209.83.57])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:59:06 -0700
Subject: Re: [RFC v2 29/32] x86/tdx: Add helper to do MapGPA TDVMALL
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
 <7d43f57c3b178a905ef2505cef5313844c497984.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <d139d180-9be7-3f7e-22db-d39fd09dfcb5@intel.com>
Date:   Wed, 19 May 2021 08:59:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7d43f57c3b178a905ef2505cef5313844c497984.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> MapGPA TDVMCALL requests the host VMM to map a GPA range as private or
> shared memory mappings. Shared GPA mappings can be used for
> communication beteen TD guest and host VMM, for example for
> paravirtualized IO.

As usual, I hate the changelog.  This appears to just be regurgitating
the spec.

Is this just for part of converting an existing mapping between private
and shared?  If so, please say that.

> The new helper tdx_map_gpa() provides access to the operation.

<sigh>  You got your own name wrong. It's tdg_map_gpa() in the patch.

BTW, I agree with Sean on this one: "tdg" is a horrible prefix.  You
just proved Sean's point by mistyping it.  *EVERYONE* is going to rpeat
that mistake: tdg -> tdx.

> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index dc80cf7f7d08..4789798d7737 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -7,6 +7,11 @@
>  
>  #ifndef __ASSEMBLY__
>  
> +enum tdx_map_type {
> +	TDX_MAP_PRIVATE,
> +	TDX_MAP_SHARED,
> +};

I like the enum, but please call out that this is a software construct,
not a part of any hardware or VMM ABI.

>  #ifdef CONFIG_INTEL_TDX_GUEST
>  
>  #include <asm/cpufeature.h>
> @@ -112,6 +117,8 @@ unsigned short tdg_inw(unsigned short port);
>  unsigned int tdg_inl(unsigned short port);
>  
>  extern phys_addr_t tdg_shared_mask(void);
> +extern int tdg_map_gpa(phys_addr_t gpa, int numpages,
> +		       enum tdx_map_type map_type);
>  
>  #else // !CONFIG_INTEL_TDX_GUEST
>  
> @@ -155,6 +162,12 @@ static inline phys_addr_t tdg_shared_mask(void)
>  {
>  	return 0;
>  }
> +
> +static inline int tdg_map_gpa(phys_addr_t gpa, int numpages,
> +			      enum tdx_map_type map_type)
> +{
> +	return -ENODEV;
> +}

FWIW, you could probably get away with just inlining tdg_map_gpa():

static inline int tdg_map_gpa(phys_addr_t gpa, int numpages, ...
{
	u64 ret;

	if (!IS_ENABLED(CONFIG_INTEL_TDX_GUEST))
		return -ENODEV;

	if (map_type == TDX_MAP_SHARED)
		gpa |= tdg_shared_mask();

	ret = tdvmcall(TDVMCALL_MAP_GPA, gpa, ...

	return ret ? -EIO : 0;
}

Then you don't have three copies of the function signature that can get
out of sync.

>  #endif /* CONFIG_INTEL_TDX_GUEST */
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_X86_TDX_H */
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index 7e391cd7aa2b..074136473011 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -15,6 +15,8 @@
>  #include "tdx-kvm.c"
>  #endif
>  
> +#define TDVMCALL_MAP_GPA	0x10001
> +
>  static struct {
>  	unsigned int gpa_width;
>  	unsigned long attributes;
> @@ -98,6 +100,17 @@ static void tdg_get_info(void)
>  	physical_mask &= ~tdg_shared_mask();
>  }
>  
> +int tdg_map_gpa(phys_addr_t gpa, int numpages, enum tdx_map_type map_type)
> +{
> +	u64 ret;
> +
> +	if (map_type == TDX_MAP_SHARED)
> +		gpa |= tdg_shared_mask();
> +
> +	ret = tdvmcall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0);
> +	return ret ? -EIO : 0;
> +}

The naming Intel chose here is nasty.  This doesn't "map" anything.  It
modifies an existing mapping from what I can tell.  We could name it
much better than the spec, perhaps:

	tdx_hcall_gpa_intent()

BTW, all of these hypercalls need a consistent prefix.

It also needs a comment:

	/*
	 * Inform the VMM of the guest's intent for this physical page:
	 * shared with the VMM or private to the guest.  The VMM is
	 * expected to change its mapping of the page in response.
	 *
	 * Note: shared->private conversions require further guest
	 * action to accept the page.
	 */

The intent here is important.  It makes it clear that this function
really only plays a role in the conversion process.
