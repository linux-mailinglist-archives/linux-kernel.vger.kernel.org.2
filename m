Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C9734B414
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 04:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0Dls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 23:41:48 -0400
Received: from mga18.intel.com ([134.134.136.126]:42639 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230392AbhC0DlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 23:41:07 -0400
IronPort-SDR: quPF0SaxjwyO9mAF3VMgGh0RlGGiZqwGU7bmdJWo6GEO98MyiAdBOE5DLaA8bUsfmXB3KRem5U
 2qCHrtLW7Onw==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="178806175"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="178806175"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 20:40:53 -0700
IronPort-SDR: 4pslsytrB72nCk3HjK6crr7LbMlyk+4nbAY3z2AHqzMm7e2JUsqfYSTeLTKCQ0rNLWcUHDw1Tp
 vCltLOZWmD2g==
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="526259126"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.231.203])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 20:40:52 -0700
Subject: Re: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <89236DB3-7B03-4B11-9F5B-5D820289C544@amacapital.net>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <dc970f33-bb1e-7300-3298-6241dec8d445@linux.intel.com>
Date:   Fri, 26 Mar 2021 20:40:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <89236DB3-7B03-4B11-9F5B-5D820289C544@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/21 7:40 PM, Andy Lutomirski wrote:
> 
> 
>> On Mar 26, 2021, at 5:18 PM, Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>>
>> ﻿In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
>> are not supported. So handle #VE due to these instructions as no ops.
> 
> These should at least be WARN.
I will change it to WARN.
> 
> Does TDX send #UD if these instructions have the wrong CPL?  
No, TDX does not trigger #UD for these instructions.
If the #VE came from user mode, we should send an appropriate signal instead.
It will be mapped into #GP(0) fault. This should be enough notification right?
> 
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>
>> Changes since previous series:
>> * Suppressed MWAIT feature as per Andi's comment.
>> * Added warning debug log for MWAIT #VE exception.
>>
>> arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
>> 1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index e936b2f88bf6..fb7d22b846fc 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -308,6 +308,9 @@ void __init tdx_early_init(void)
>>
>>     setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
>>
>> +    /* MWAIT is not supported in TDX platform, so suppress it */
>> +    setup_clear_cpu_cap(X86_FEATURE_MWAIT);
>> +
>>     tdg_get_info();
>>
>>     pv_ops.irq.safe_halt = tdg_safe_halt;
>> @@ -362,6 +365,26 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
>>     case EXIT_REASON_EPT_VIOLATION:
>>         ve->instr_len = tdg_handle_mmio(regs, ve);
>>         break;
>> +    /*
>> +     * Per Guest-Host-Communication Interface (GHCI) for Intel Trust
>> +     * Domain Extensions (Intel TDX) specification, sec 2.4,
>> +     * some instructions that unconditionally cause #VE (such as WBINVD,
>> +     * MONITOR, MWAIT) do not have corresponding TDCALL
>> +     * [TDG.VP.VMCALL <Instruction>] leaves, since the TD has been designed
>> +     * with no deterministic way to confirm the result of those operations
>> +     * performed by the host VMM.  In those cases, the goal is for the TD
>> +     * #VE handler to increment the RIP appropriately based on the VE
>> +     * information provided via TDCALL.
>> +     */
>> +    case EXIT_REASON_WBINVD:
>> +        pr_warn_once("WBINVD #VE Exception\n");
>> +    case EXIT_REASON_MONITOR_INSTRUCTION:
>> +        /* Handle as nops. */
>> +        break;
>> +    case EXIT_REASON_MWAIT_INSTRUCTION:
>> +        /* MWAIT is supressed, not supposed to reach here. */
>> +        pr_warn("MWAIT unexpected #VE Exception\n");
>> +        return -EFAULT;
>>     default:
>>         pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
>>         return -EFAULT;
>> -- 
>> 2.25.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
