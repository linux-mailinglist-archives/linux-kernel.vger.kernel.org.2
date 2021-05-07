Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02EC376B98
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 23:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhEGVVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 17:21:47 -0400
Received: from mga07.intel.com ([134.134.136.100]:58220 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhEGVVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 17:21:46 -0400
IronPort-SDR: fkbIOEb2OhoJ6Lclxu+t96mYhxp+M4o+n7Kku9fuP5xXwULKLekFOOgnk+kLSvj6tXEJtul0ae
 /u3o+eKIVujg==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="262752569"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="262752569"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:20:45 -0700
IronPort-SDR: iVNVaUP5F6JNGhWABOyW+MSGqmKeqnHBcwUpxM2/UrmayEpYFEFAJYdY+AWzPPa7yykDGNgzJS
 sPIY2DBPTh3w==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="431671829"
Received: from msandrid-mobl.amr.corp.intel.com (HELO [10.212.134.124]) ([10.212.134.124])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 14:20:44 -0700
Subject: =?UTF-8?Q?Re=3a_=5bRFC_v2_07/32=5d_x86/traps=3a_Add=c2=a0do=5fgener?=
 =?UTF-8?Q?al=5fprotection=28=29_helper_function?=
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
 <00eeea950502dbaa5f6d48509307c806e08c6e4d.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <92b85694-8250-dccd-71df-193e647fcd78@intel.com>
Date:   Fri, 7 May 2021 14:20:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <00eeea950502dbaa5f6d48509307c806e08c6e4d.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> TDX guest #VE exception handler treats unsupported exceptions

 ^ The

> as #GP. So to handle the #GP, move the protection fault handler

s/So to/To/

Also, it does not "treat them as #GP".  It handles them in the same way
that a #GP is handled.  There's a difference between literally making
them a #GP and having a similar end result.  This description conflates
them.

> code to out of exc_general_protection() and create new helper
> function for it.

I wouldn't name the functions.  Just say that you want the #GP behavior
from #VE so you need a common helper.

> Also since exception handler is responsible to decide when to

	    ^ an

> turn on/off IRQ, move cond_local_irq_{enable/disable)() calls
> out of do_general_protection().

This paragraph doesn't really say anything meaningful.  Yes, exception
handlers reenable interrupts.  Try to *SAY* something about why they do
this and why you have to move the code around.  Or, just axe it.

> This is a preparatory patch for adding #VE exception handler
> support for TDX guests.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  arch/x86/kernel/traps.c | 51 ++++++++++++++++++++++-------------------
>  1 file changed, 27 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 651e3e508959..213d4aa8e337 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -527,44 +527,28 @@ static enum kernel_gp_hint get_kernel_gp_address(struct pt_regs *regs,
>  
>  #define GPFSTR "general protection fault"
>  
> -DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> +static void do_general_protection(struct pt_regs *regs, long error_code)
>  {
>  	char desc[sizeof(GPFSTR) + 50 + 2*sizeof(unsigned long) + 1] = GPFSTR;
>  	enum kernel_gp_hint hint = GP_NO_HINT;
> -	struct task_struct *tsk;
> +	struct task_struct *tsk = current;
>  	unsigned long gp_addr;
>  	int ret;
>  
> -	cond_local_irq_enable(regs);
> -
> -	if (static_cpu_has(X86_FEATURE_UMIP)) {
> -		if (user_mode(regs) && fixup_umip_exception(regs))
> -			goto exit;
> -	}
> -
> -	if (v8086_mode(regs)) {
> -		local_irq_enable();
> -		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
> -		local_irq_disable();
> -		return;
> -	}
> -
> -	tsk = current;
> -
>  	if (user_mode(regs)) {
>  		tsk->thread.error_code = error_code;
>  		tsk->thread.trap_nr = X86_TRAP_GP;
>  
>  		if (fixup_vdso_exception(regs, X86_TRAP_GP, error_code, 0))
> -			goto exit;
> +			return;
>  
>  		show_signal(tsk, SIGSEGV, "", desc, regs, error_code);
>  		force_sig(SIGSEGV);
> -		goto exit;
> +		return;
>  	}
>  
>  	if (fixup_exception(regs, X86_TRAP_GP, error_code, 0))
> -		goto exit;
> +		return;
>  
>  	tsk->thread.error_code = error_code;
>  	tsk->thread.trap_nr = X86_TRAP_GP;
> @@ -576,11 +560,11 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  	if (!preemptible() &&
>  	    kprobe_running() &&
>  	    kprobe_fault_handler(regs, X86_TRAP_GP))
> -		goto exit;
> +		return;
>  
>  	ret = notify_die(DIE_GPF, desc, regs, error_code, X86_TRAP_GP, SIGSEGV);

So... We're going to send signals based on #VE which use this bit in the
ABI which is documented as:

#define X86_TRAP_GP             13      /* General Protection Fault */

Considering that there is also a:

#define X86_TRAP_VE             20      /* Virtualization Exception */

this seems like a stretch.

Also, isnt there a lot of truly #GP-specific code in there, like
fixup_exception()?  Why do you need to call that for #VE?  How did you
decide what remains in the handler versus what gets separated out?

>  	if (ret == NOTIFY_STOP)
> -		goto exit;
> +		return;
>  
>  	if (error_code)
>  		snprintf(desc, sizeof(desc), "segment-related " GPFSTR);
> @@ -601,8 +585,27 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
>  		gp_addr = 0;
>  
>  	die_addr(desc, regs, error_code, gp_addr);
> +}
>  
> -exit:
> +DEFINE_IDTENTRY_ERRORCODE(exc_general_protection)
> +{
> +	cond_local_irq_enable(regs);
> +
> +	if (static_cpu_has(X86_FEATURE_UMIP)) {
> +		if (user_mode(regs) && fixup_umip_exception(regs)) {
> +			cond_local_irq_disable(regs);
> +			return;
> +		}
> +	}
> +
> +	if (v8086_mode(regs)) {
> +		local_irq_enable();
> +		handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
> +		local_irq_disable();
> +		return;
> +	}
> +
> +	do_general_protection(regs, error_code);
>  	cond_local_irq_disable(regs);
>  }

