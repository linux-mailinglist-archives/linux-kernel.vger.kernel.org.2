Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879A73C9E0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhGOL7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 07:59:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:25240 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGOL7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 07:59:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="190903231"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="190903231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 04:56:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="495403405"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.30.133]) ([10.255.30.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 04:56:34 -0700
Subject: Re: [PATCH v3 03/11] x86/cpufeatures: Add TDX Guest CPU feature
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <64bf7394-ff82-86f7-7a52-ed12508276ac@intel.com>
Date:   Thu, 15 Jul 2021 19:56:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618225755.662725-4-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/2021 6:57 AM, Kuppuswamy Sathyanarayanan wrote:
> Add CPU feature detection for Trusted Domain Extensions support. TDX
> feature adds capabilities to keep guest register state and memory
> isolated from hypervisor.
> 
> For TDX guest platforms, executing CPUID(eax=0x21, ecx=0) will return
> following values in EAX, EBX, ECX and EDX.
> 
> EAX:  Maximum sub-leaf number:  0
> EBX/EDX/ECX:  Vendor string:
> 
> EBX =  "Inte"
> EDX =  "lTDX"
> ECX =  "    "
> 
> So when above condition is true, set X86_FEATURE_TDX_GUEST feature cap
> bit.
> 

...

> +static inline bool cpuid_has_tdx_guest(void)
> +{
> +	u32 eax, sig[3];
> +
> +	if (cpuid_eax(0) < TDX_CPUID_LEAF_ID)
> +		return false;
> +
> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[1], &sig[2]);

As change log describes, EBX + EDX + ECX is "IntelTDX    ", not EBX + 
ECX + EDX. So it should be

	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2], &sig[1]);

Please also correct early_cpuid_has_tdx_guest()

> +
> +	return !memcmp("IntelTDX    ", sig, 12);
> +}
> +
> +void __init tdx_early_init(void)
> +{
> +	if (!cpuid_has_tdx_guest())
> +		return;
> +
> +	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
> +
> +	pr_info("Guest initialized\n");
> +}
> 

