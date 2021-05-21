Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4361B38CD79
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhEUSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:32:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:18032 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232583AbhEUSc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:32:57 -0400
IronPort-SDR: Jg2CGNSkzbgLpsmSvm8N6RuwKadZmOvyPr7hkg7dzTrguqps+bsrwltcPz6YwLMUIM5xuzoP29
 8TDLijtxm/RQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="265454097"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265454097"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:31:32 -0700
IronPort-SDR: eyYK8ErqfcJQIa0PIa3TYUy9WIkLtNYJjtNwF9kW98MxelC0La13YapBBYsH02BPqVzMRk3ctc
 KCKmFV1gZNiQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441193658"
Received: from orxpovpvmu02.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.181.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:31:32 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86/boot: Avoid #VE during boot for TDX
 platforms
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <b1aafcbb-c5db-efa5-0343-014585e73191@intel.com>
 <20210521143524.2527690-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f33c63b2-7b41-4c99-abd6-b47a8e7a4e26@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f1d61f01-3b50-9a75-bd83-5b8d385b8459@linux.intel.com>
Date:   Fri, 21 May 2021 11:31:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f33c63b2-7b41-4c99-abd6-b47a8e7a4e26@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 9:11 AM, Dave Hansen wrote:
>> Avoid operations which will inject #VE during boot process.
>> They're easy to avoid and it is less complex than handling
>> the exceptions.
> 
> This puts the solution before the problem.  I'd also make sure to
> clearly connect this solution to the problem.  For instance, if you
> refer to register "modification", ensure that you reflect that language
> here.  Don't call them "modifications" in one part of the changelog and
> "operations" here.  I'd also qualify them as "superfluous".
> 
> Please reorder this in the following form:
> 
> 1. Background
> 2. Problem
> 3. Solution
> 
> Please do this for all of your patches.
> 
>> There are a few MSRs and control register bits which the
>> kernel normally needs to modify during boot.  But, TDX
>> disallows modification of these registers to help provide
>> consistent security guarantees ( and avoid generating #VE
>> when updating them).
> 
> No, the TDX architecture does not avoid generating #VE.  The *kernel*
> does that.  This sentence conflates those two things.
> 
>> Fortunately, TDX ensures that these are
>> all in the correct state before the kernel loads, which means
>> the kernel has no need to modify them.
>>
>> The conditions we need to avoid are:
>>
>>    * Any writes to the EFER MSR
>>    * Clearing CR0.NE
>>    * Clearing CR3.MCE
> 
> Sathya, there have been repeated issues in your changelogs with "we's".
>   Remember, speak in imperative voice.  Please fix this in your tooling
> to find these so that reviewers don't have to.

How about the following commit log?

In TDX guests, Virtualization Exceptions (#VE) are delivered
to TDX guests due to specific guest actions like MSR writes,
CPUID leaf accesses or I/O access. But in early boot code, #VE
cannot be allowed because the required exception handler setup
support code is missing. If #VE is triggered without proper
handler support, it would lead to triple fault or kernel hang.
So, avoid operations which will inject #VE during boot process.
They're easy to avoid and it is less complex than handling the
exceptions.

There are a few MSRs and control register bits which the kernel
normally needs to modify during boot. But, TDX disallows
modification of these registers to help provide consistent
security guarantees. Fortunately, TDX ensures that these are all
in the correct state before the kernel loads, which means the
kernel has no need to modify them.

The conditions to avoid are:

   * Any writes to the EFER MSR
   * Clearing CR0.NE
   * Clearing CR3.MCE

If above conditions are not avoided, it would lead to triple
fault or kernel hang.

> 
>> +	/*
>> +	 * Preserve current value of EFER for comparison and to skip
>> +	 * EFER writes if no change was made (for TDX guest)
>> +	 */
>> +	movl    %eax, %edx
>>   	btsl	$_EFER_SCE, %eax	/* Enable System Call */
>>   	btl	$20,%edi		/* No Execute supported? */
>>   	jnc     1f
>>   	btsl	$_EFER_NX, %eax
>>   	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
>> -1:	wrmsr				/* Make changes effective */
>>   
>> +	/* Avoid writing EFER if no change was made (for TDX guest) */
>> +1:	cmpl	%edx, %eax
>> +	je	1f
>> +	xor	%edx, %edx
>> +	wrmsr				/* Make changes effective */
>> +1:
> 
> Just curious, but what if this goes wrong?  Say the TDX firmware didn't
> set up EFER correctly and this code does the WRMSR.  What ends up
> happening? 

It would lead to triple fault.

  Do we get anything out on the console, or is it essentially
> undebuggable?
> 

We can still get logs with debug TDX module. So it is still debugable.

>>
>> +	/*
>> +	 * Skip writing to EFER if the register already has desiered
>> +	 * value (to avoid #VE for TDX guest).
>> +	 */
> 
> 
> 							spelling ^
> 
> There are lots of editors that can do spell checking, even in C
> comments.  You might want to look into that for your editor.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
