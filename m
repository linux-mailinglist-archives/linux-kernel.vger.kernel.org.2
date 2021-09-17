Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC940EFD2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 04:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhIQCxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 22:53:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:46717 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241787AbhIQCxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 22:53:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209940383"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="209940383"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 19:52:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="546106710"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.2.89]) ([10.238.2.89])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 19:52:17 -0700
Subject: Re: [PATCH] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210901084004.5393-1-chenyi.qiang@intel.com>
From:   Chenyi Qiang <chenyi.qiang@intel.com>
Message-ID: <cf8dec95-d85c-1074-fd65-d89230e930e1@intel.com>
Date:   Fri, 17 Sep 2021 10:52:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210901084004.5393-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kindly ping for this minor change.

Thanks
Chenyi

On 9/1/2021 4:40 PM, Chenyi Qiang wrote:
> It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
> this kernel has been kexec'd from a kernel that enabled bus lock
> detection.
> 
> Disable bus lock detection explicitly if not wanted.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>   arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++-------------
>   1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 8321c43554a1..38dda04d9342 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -1152,22 +1152,23 @@ static void bus_lock_init(void)
>   {
>   	u64 val;
>   
> -	/*
> -	 * Warn and fatal are handled by #AC for split lock if #AC for
> -	 * split lock is supported.
> -	 */
> -	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
> -	    (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
> -	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
> -	    sld_state == sld_off)
> +	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
>   		return;
>   
> -	/*
> -	 * Enable #DB for bus lock. All bus locks are handled in #DB except
> -	 * split locks are handled in #AC in the fatal case.
> -	 */
>   	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
> -	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> +
> +	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
> +	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
> +	    sld_state == sld_off) {
> +		/*
> +		 * Warn and fatal are handled by #AC for split lock if #AC for
> +		 * split lock is supported.
> +		 */
> +		val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
> +	} else {
> +		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
> +	}
> +
>   	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
>   }
>   
> 
