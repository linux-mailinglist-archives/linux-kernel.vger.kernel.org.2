Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B814E426271
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 04:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbhJHC1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 22:27:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:19306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhJHC1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 22:27:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="225194662"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="225194662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 19:25:48 -0700
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="624554949"
Received: from mlazarux-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.19.27])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 19:25:47 -0700
Subject: Re: [PATCH v8 11/11] x86/tdx: Handle CPUID via #VE
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211006202630.chblrhdqepsbtdaa@treble>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <02e4f583-39dd-cac9-5b51-5fa9ba81b996@linux.intel.com>
Date:   Thu, 7 Oct 2021 19:25:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211006202630.chblrhdqepsbtdaa@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 1:26 PM, Josh Poimboeuf wrote:
> On Mon, Oct 04, 2021 at 07:52:05PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +static u64 tdx_handle_cpuid(struct pt_regs *regs)
>> +{
>> +	struct tdx_hypercall_output out = {0};
>> +	u64 ret;
>> +
>> +	/*
>> +	 * Emulate CPUID instruction via hypercall. More info about
>> +	 * ABI can be found in TDX Guest-Host-Communication Interface
>> +	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
>> +	 */
>> +	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
>> +
>> +	/*
>> +	 * As per TDX GHCI CPUID ABI, r12-r15 registers contains contents of
>> +	 * EAX, EBX, ECX, EDX registers after CPUID instruction execution.
>> +	 * So copy the register contents back to pt_regs.
>> +	 */
>> +	regs->ax = out.r12;
>> +	regs->bx = out.r13;
>> +	regs->cx = out.r14;
>> +	regs->dx = out.r15;
> 
> Does it still make sense to save the regs if _tdx_hypercall() returns an
> error?

We don't need to save it in failure case. I will add check for error
case in next version.

> 
>> +
>> +	return ret;
> 
> Also I'm wondering about error handling for all these _tdx_hypercall()
> wrapper functions which are called by the #VE handler. >
> First, there are some inconsistencies in whether and how they return the
> r10 error.

Since we have only cared about zero/non-zero return value, we did not
check for consistency. May be I can convert all handler return values
to bool.

> 
> - _tdx_halt() warns and doesn't return anything.

Since tdx_halt handler is shared with pv_ops, we can't return anything
back (so we use WARN_ON to report the error).

> 
> - tdx_read_msr_safe() and tdx_write_msr_safe() convert all errors to -EIO.

Return value does not matter. we only check for zero/non-zero value in
tdx_handle_virtualization_exception(). we have used -EIO to convey that it is
an IO error.

> 
> - tdx_handle_cpuid() returns the raw vmcall error.
> 
> Second, as far as I can tell, the #VE handler doesn't check the actual
> return code value, other than checking for non-zero.  Should it at least
> be printed in a warning?

I don't think this is required. We can use trace to check the error code
or argument details in failure case. Since we don't really use the error
value, I am planning to change the #VE handler return type to bool.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
