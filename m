Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760B234248E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 19:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCSSWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 14:22:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:44025 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230186AbhCSSWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 14:22:30 -0400
IronPort-SDR: 8bAKtSDQMGKz5EY2kQ3zPL7dDXGrHXC+ZCXPM/O1k+ehu5z6tqaPNZSbscIS1zbrjAtMfomyd+
 Eux3upZRQdvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9928"; a="275015753"
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="275015753"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:22:30 -0700
IronPort-SDR: OXb4ZlJdEYHKk0QQ+oNIDdm9cVzvDrYXRqrfD6npsWMuwEkO7NgO7LsXNCCR8H2rsU1KRq4GQM
 +USaTqo26cqw==
X-IronPort-AV: E=Sophos;i="5.81,262,1610438400"; 
   d="scan'208";a="406896980"
Received: from hyunyi-mobl1.amr.corp.intel.com (HELO [10.212.50.74]) ([10.212.50.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2021 11:22:29 -0700
Subject: Re: [PATCH v1 1/1] x86/tdx: Add tdcall() and tdvmcall() helper
 functions
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <0A886D87-1979-419C-86DE-EA2FABDFF3EB@amacapital.net>
 <20210318213053.203403-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YFTXdG+zZ32gVIPc@google.com>
 <c72d9ca6-7a5c-b614-5d20-b86d2abebdee@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <5485f0ac-da86-4f68-d277-9f0bba5c4ef5@intel.com>
Date:   Fri, 19 Mar 2021 11:22:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c72d9ca6-7a5c-b614-5d20-b86d2abebdee@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 10:42 AM, Kuppuswamy, Sathyanarayanan wrote:
>>> @@ -4,6 +4,58 @@
>>>   #include <asm/tdx.h>
>>>   #include <asm/cpufeature.h>
>>>   +void tdcall(u64 leafid, struct tdcall_regs *regs)
>>> +{
>>> +    asm volatile(
>>> +            /* RAX = leafid (TDCALL LEAF ID) */
>>> +            "  movq %0, %%rax;"
>>> +            /* Move regs->r[*] data to regs r[a-c]x,  r8-r5 */
>>> +            "  movq 8(%1), %%rcx;"
>> 
>> I am super duper opposed to using inline asm.  Large blocks are
>> hard to read,
> I think this point is arguable. Based on the review comments I
> received so far, people prefer inline assembly compared to asm sub
> functions.

It's arguable, but Sean makes a pretty compelling case.

I actually think inline assembly is a monstrosity.  It's insanely arcane
and, as I hope you have noted, does not scale nicely beyond one or two
instructions.

>> and even harder to maintain.  E.g. the %1 usage falls apart if an
>> output constraint is added; that can be avoided by defining a local
>> const/imm (I forget what they're called), but it doesn't help
>> readability.
> we can use OFFSET() calls to improve the readability and avoid this 
> issue. Also IMO, any one adding constraints should know how this
> would affect the asm code.

This is about *maintainability*.  How _easily_ can someone change this
code in the future?  Sean's arguing that it's *hard* to correctly add a
constraint.  Unfortunately, our supply of omnipotent kernel developers
is a bit short.

>>> +            "  movq 16(%1), %%rdx;"
>>> +            "  movq 24(%1), %%r8;"
>>> +            "  movq 32(%1), %%r9;"
>>> +            "  movq 40(%1), %%r10;"
>>> +            "  movq 48(%1), %%r11;"
>>> +            "  movq 56(%1), %%r12;"
>>> +            "  movq 64(%1), %%r13;"
>>> +            "  movq 72(%1), %%r14;"
>>> +            "  movq 80(%1), %%r15;"
>> 
>> This is extremely unsafe, and wasteful.  Putting the onus on the 
>> caller to zero out unused registers, with no mechanism to
>> enforce/encourage doing so,
> For encouragement, we can add a comment to this function about
> callers responsibility. makes it
>> likely that the kernel will leak information to the VMM, e.g. in
>> the form of stack data due to a partially initialized "regs".
> Unless you create sub-functions for each use cases, callers cannot
> avoid this responsibility.

I don't think we're quite at the point where we throw up our hands.

It would be pretty simple to have an initializer that zeros the
registers out, or looks at the argument mask and does it more precisely.
 Surely we can do *something*.

>>     /* Offset for fields in tdvmcall_output */
>>     OFFSET(TDVMCALL_r12, tdvmcall_output, r13);
>>     OFFSET(TDVMCALL_r13, tdvmcall_output, r13);
>>     OFFSET(TDVMCALL_r14, tdvmcall_output, r14);
>>     OFFSET(TDVMCALL_r15, tdvmcall_output, r15);
>>
>> SYM_FUNC_START(__tdvmcall)
>>     FRAME_BEGIN
>>
>>     /* Save/restore non-volatile GPRs that are exposed to the VMM. */
>>          push %r15
>>          push %r14
>>          push %r13
>>          push %r12

I might have some tweaks for the assembly once someone puts a real patch
together.  But, that looks a lot more sane than the inline assembly to me.
