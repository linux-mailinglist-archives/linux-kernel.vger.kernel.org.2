Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB2034E071
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 06:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhC3E5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 00:57:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:49193 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhC3E4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 00:56:46 -0400
IronPort-SDR: tOxfriJYc7noS5ajTjzn0aWXb3fbmD1zpaOsEW4KLg15GAQfBTmgHEo0Fw/1bFRqeCPcYNdBdu
 SwLIGy4MAdEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="179231599"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="179231599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 21:56:46 -0700
IronPort-SDR: lsuIO7yps5TfrDZEGzRip6Lgqbfy7fftvVLDnbNXnCqD+Veh0/QF6Sy27gfIyskw0m2qoyZiE2
 sXG9UwdqgAbg==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417992474"
Received: from unknown (HELO [10.239.13.106]) ([10.239.13.106])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 21:56:43 -0700
Subject: Re: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
 <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <d78f5f76-e04f-cab1-48f5-b6c1ba6a3811@intel.com>
Date:   Tue, 30 Mar 2021 12:56:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2021 8:18 AM, Kuppuswamy Sathyanarayanan wrote:
> In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
> are not supported. So handle #VE due to these instructions as no ops.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> ---
> 
> Changes since previous series:
>   * Suppressed MWAIT feature as per Andi's comment.
>   * Added warning debug log for MWAIT #VE exception.
> 
>   arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
> index e936b2f88bf6..fb7d22b846fc 100644
> --- a/arch/x86/kernel/tdx.c
> +++ b/arch/x86/kernel/tdx.c
> @@ -308,6 +308,9 @@ void __init tdx_early_init(void)
>   
>   	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>   
> +	/* MWAIT is not supported in TDX platform, so suppress it */
> +	setup_clear_cpu_cap(X86_FEATURE_MWAIT);

In fact, MWAIT bit returned by CPUID instruction is zero for TD guest. 
This is enforced by SEAM module.

Do we still need to safeguard it by setup_clear_cpu_cap() here?

> +
>   	tdg_get_info();
>   
>   	pv_ops.irq.safe_halt = tdg_safe_halt;


