Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C4834D9C9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhC2Vzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:55:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:63104 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231157AbhC2Vzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:55:43 -0400
IronPort-SDR: GzHe1G+RKjvQ9jQZ06eX2tZTGWx9z4z3j+5jhSSYOhxHaXMull+gE5ASuuVnEOXlFxX2Nt4z/b
 tO5PQidR60IA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="189386033"
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="189386033"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 14:55:42 -0700
IronPort-SDR: tyfksML8sMt5NYtPnaB6DDs9Y1INUILOk/ndGw4WUx902aUprMH9PYCFc37IAcPbP4KiTxPqPp
 0C5uwoa/fapg==
X-IronPort-AV: E=Sophos;i="5.81,288,1610438400"; 
   d="scan'208";a="444792948"
Received: from ajzangar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.145.70])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 14:55:41 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <91C0F6F1-B8C3-4130-B903-C63CD4B87F3F@amacapital.net>
 <ed7e96ba7a271e36bdfe61ee34c6d61eb78000c5.1616885306.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <498f078c-5196-a608-7f1a-8425ff056135@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8e02ce39-f672-e652-b314-418b7ec5f52a@linux.intel.com>
Date:   Mon, 29 Mar 2021 14:55:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <498f078c-5196-a608-7f1a-8425ff056135@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/21 10:14 AM, Dave Hansen wrote:
> On 3/27/21 3:54 PM, Kuppuswamy Sathyanarayanan wrote:
>> +	/*
>> +	 * Per Guest-Host-Communication Interface (GHCI) for Intel Trust
>> +	 * Domain Extensions (Intel TDX) specification, sec 2.4,
>> +	 * some instructions that unconditionally cause #VE (such as WBINVD,
>> +	 * MONITOR, MWAIT) do not have corresponding TDCALL
>> +	 * [TDG.VP.VMCALL <Instruction>] leaves, since the TD has been designed
>> +	 * with no deterministic way to confirm the result of those operations
>> +	 * performed by the host VMM.  In those cases, the goal is for the TD
>> +	 * #VE handler to increment the RIP appropriately based on the VE
>> +	 * information provided via TDCALL.
>> +	 */

> 
> That's an awfully big comment.  Could you pare it down, please?  Maybe
> focus on the fact that we should never get here and why, rather than
> talking about some silly spec?
I will remove this and add individual one line comment for WBINVD and MONITOR
instructions. Some thing like "Privileged instruction, can only be executed
in ring 0. So raise a BUG.
> 
>> +	case EXIT_REASON_WBINVD:
>> +		pr_warn_once("WBINVD #VE Exception\n");
> 
> I actually think WBINVD in here should oops.  We use it for some really
> important things.  If it can't be executed, and we're depending on it,
> the kernel is in deep, deep trouble.
Agree. I will call BUG().
> 
> I think a noop here is dangerous.
> 
>> +	case EXIT_REASON_MONITOR_INSTRUCTION:
>> +		/* Handle as nops. */
>> +		break;
> 
> MONITOR is a privileged instruction, right?  So we can only end up in
> here if the kernel screws up and isn't reading CPUID correctly, right?
> 
> That dosen't seem to me like something we want to suppress.  This needs
> a warning, at least.  I assume that having a MONITOR instruction
> immediately return doesn't do any harm.
Agree. Since we are not supposed to come here, I will use BUG.
> 
>> +	case EXIT_REASON_MWAIT_INSTRUCTION:
>> +		/* MWAIT is supressed, not supposed to reach here. */
>> +		WARN(1, "MWAIT unexpected #VE Exception\n");
>> +		return -EFAULT;
> 
> How is MWAIT "supppressed"?
I am clearing the MWAIT feature flag in early init code. We should also disable
this feature in firmware.
setup_clear_cpu_cap(X86_FEATURE_MWAIT);
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
