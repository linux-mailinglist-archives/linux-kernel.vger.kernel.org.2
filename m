Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437F13F6855
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhHXRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:43:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:5257 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242659AbhHXRlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:41:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="214240954"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="214240954"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:32:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="597658567"
Received: from ydevadig-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.137.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 10:32:18 -0700
Subject: Re: [PATCH v5 07/12] x86/traps: Add #VE support for TDX guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSTHMAUA1LjjOQPe@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <99c5f6e9-a747-1a4a-d0f4-95b8b28e0d02@linux.intel.com>
Date:   Tue, 24 Aug 2021 10:32:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSTHMAUA1LjjOQPe@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 3:17 AM, Borislav Petkov wrote:
> On Wed, Aug 04, 2021 at 11:13:24AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> If a guest kernel action which would normally cause a #VE occurs in the
>> interrupt-disabled region before TDGETVEINFO, a #DF is delivered to the
>> guest which will result in an oops (and should eventually be a panic, as
>> we would like to set panic_on_oops to 1 for TDX guests).
> 
> Who's "we"?
> 
> Please use passive voice in your commit message and comments: no "we"
> or "I", etc. Personal pronouns are ambiguous in text, especially with
> so many parties/companies/etc developing the kernel so let's avoid them.
> 
> Audit all your patchsets pls.

Sorry. I will fix this in next version.

> 
>> Add basic infrastructure to handle any #VE which occurs in the kernel or
>> userspace.  Later patches will add handling for specific #VE scenarios.
>>
>> Convert unhandled #VE's (everything, until later in this series) so that
>> they appear just like a #GP by calling ve_raise_fault() directly.
>> ve_raise_fault() is similar to #GP handler and is responsible for
>> sending SIGSEGV to userspace and cpu die and notifying debuggers and
> 
> In all your text:
> 
> s/cpu/CPU/g
> 
> Audit all your patchsets pls.

Yes. I will fix this in next version.

> 
>> @@ -53,6 +67,11 @@ u64 __tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>>   u64 __tdx_hypercall(u64 type, u64 fn, u64 r12, u64 r13, u64 r14,
>>   		    u64 r15, struct tdx_hypercall_output *out);
>>   
>> +unsigned long tdg_get_ve_info(struct ve_info *ve);
>> +
>> +int tdg_handle_virtualization_exception(struct pt_regs *regs,
> 
> There's that "tdg" prefix again. Please fix all your patchsets.

Mainly chose it avoid future name conflicts with KVM (tdx) calls. But
if you don't like "tdg", I can change it back to "tdx" and resolve the
naming issues when it occurs.


>>   static struct {
>>   	unsigned int gpa_width;
>> @@ -75,6 +76,41 @@ static void tdg_get_info(void)
>>   	td_info.attributes = out.rdx;
>>   }
>>   
>> +unsigned long tdg_get_ve_info(struct ve_info *ve)
>> +{
>> +	u64 ret;
>> +	struct tdx_module_output out = {0};
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;

Yes. I will fix this in next version.


>> +int tdg_handle_virtualization_exception(struct pt_regs *regs,
>> +					struct ve_info *ve)
>> +{
>> +	/*
>> +	 * TODO: Add handler support for various #VE exit
>> +	 * reasons. It will be added by other patches in
>> +	 * the series.
>> +	 */
> 
> That comment needs to go.

Ok. I will remove it.

>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +#define VEFSTR "VE fault"
>> +static void ve_raise_fault(struct pt_regs *regs, long error_code)
>> +{
>> +	struct task_struct *tsk = current;
>> +
>> +	if (user_mode(regs)) {
>> +		tsk->thread.error_code = error_code;
>> +		tsk->thread.trap_nr = X86_TRAP_VE;
>> +
>> +		/*
>> +		 * Not fixing up VDSO exceptions similar to #GP handler
>> +		 * because we don't expect the VDSO to trigger #VE.
>> +		 */
>> +		show_signal(tsk, SIGSEGV, "", VEFSTR, regs, error_code);
>> +		force_sig(SIGSEGV);
>> +		return;
>> +	}
>> +
>> +	if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
> 
> There are exception table entries which can trigger a #VE?

It is required to handle #VE exceptions raised by unhandled MSR
read/writes.

> 
>> +		return;
>> +
>> +	tsk->thread.error_code = error_code;
>> +	tsk->thread.trap_nr = X86_TRAP_VE;
>> +
>> +	/*
>> +	 * To be potentially processing a kprobe fault and to trust the result
>> +	 * from kprobe_running(), we have to be non-preemptible.
>> +	 */
>> +	if (!preemptible() &&
>> +	    kprobe_running() &&
>> +	    kprobe_fault_handler(regs, X86_TRAP_VE))
>> +		return;
>> +
>> +	notify_die(DIE_GPF, VEFSTR, regs, error_code, X86_TRAP_VE, SIGSEGV);
> 
> Other handlers check that retval.

Ok. I can check it. But there is only one statement after this call. So it
may not be very helpful.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
