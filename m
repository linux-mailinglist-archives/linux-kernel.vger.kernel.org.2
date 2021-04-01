Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39AA3522EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhDAWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:53:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:37867 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234043AbhDAWxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:53:50 -0400
IronPort-SDR: mEOxo2h4HMC1u3S68MrjGN1zb3ymIKnb8xO+30El/8uWSC226Ro6iC4LiAPVfocWhydlFDN8ZV
 NBcsOZM4VoJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="189091647"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="189091647"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:53:50 -0700
IronPort-SDR: RruNdSep7MegQ0genuhfAWsQc8dXz8NA043ile2il05ZBIOVSQUTaV2RhK9qSFWcL9RUx4wrH3
 0kfPQQ3UjjZg==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="611091079"
Received: from pzlai-mobl.amr.corp.intel.com (HELO [10.213.169.242]) ([10.213.169.242])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:53:50 -0700
Subject: Re: [RFC v1 12/26] x86/tdx: Handle in-kernel MMIO
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <94a9847072098e554146ca4fa3c6f28fc1ac5b22.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <3e43ff6b-2f19-69f1-3017-d8d67abcfd9f@intel.com>
 <YGZIks0DsfPS2IMk@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <3b0cb3fc-87bc-ae18-1a26-f6ad45a56fb5@intel.com>
Date:   Thu, 1 Apr 2021 15:53:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGZIks0DsfPS2IMk@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 3:26 PM, Sean Christopherson wrote:
> On Thu, Apr 01, 2021, Dave Hansen wrote:
>> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> Handle #VE due to MMIO operations. MMIO triggers #VE with EPT_VIOLATION
>>> exit reason.
>>>
>>> For now we only handle subset of instruction that kernel uses for MMIO
>>> oerations. User-space access triggers SIGBUS.
>> ..
>>> +	case EXIT_REASON_EPT_VIOLATION:
>>> +		ve->instr_len = tdx_handle_mmio(regs, ve);
>>> +		break;
>>
>> Is MMIO literally the only thing that can cause an EPT violation for TDX
>> guests?
> 
> Any EPT Violation, or specifically EPT Violation #VE?  Any memory access can
> cause an EPT violation, but the VMM will get the ones that lead to VM-Exit.  The
> guest will only get the ones that cause #VE.

I'll rephrase: Is MMIO literally the only thing that can cause us to get
into the EXIT_REASON_EPT_VIOLATION case of the switch() here?

> Assuming you're asking about #VE... No, any shared memory access can take a #VE
> since the VMM controls the shared EPT tables and can clear the SUPPRESS_VE bit 
> at any time.  But, if the VMM is friendly, #VE should be limited to MMIO.

OK, but what are we doing in the case of unfriendly VMMs?  What does
*this* code do as-is, and where do we want to take it?

From the _looks_ of this patch, tdx_handle_mmio() is the be all end all
solution to all EXIT_REASON_EPT_VIOLATION events.

>> But for an OS where we have source for the *ENTIRE* thing, and where we
>> have a chokepoint for MMIO accesses (arch/x86/include/asm/io.h), it
>> seems like an *AWFUL* idea to:
>> 1. Have the kernel set up special mappings for I/O memory
>> 2. Kernel generates special instructions to access that memory
>> 3. Kernel faults on that memory
>> 4. Kernel cracks its own special instructions to see what they were
>>    doing
>> 5. Kernel calls up to host to do the MMIO
>>
>> Instead of doing 2/3/4, why not just have #2 call up to the host
>> directly?  This patch seems a very slow, roundabout way to do
>> paravirtualized MMIO.
>>
>> BTW, there's already some SEV special-casing in io.h.
> 
> I implemented #2 a while back for build_mmio_{read,write}(), I'm guessing the
> code is floating around somewhere.  The gotcha is that there are nasty little
> pieces of the kernel that don't use the helpers provided by io.h, e.g. the I/O
> APIC code likes to access MMIO via a struct overlay, so the compiler is free to
> use any instruction that satisfies the constraint.

So, there aren't an infinite number of these.  It's also 100% possible
to add some tooling to the kernel today to help you find these.  You
could also have added tooling to KVM hosts to help find these.

Folks are *also* saying that we'll need a driver audit just to trust
that drivers aren't vulnerable to attacks from devices or from the host.
 This can quite easily be a part of that effort.

> The I/O APIC can and should be forced off, but dollars to donuts says there are
> more special snowflakes lying in wait.  If the kernel uses an allowlist for
> drivers, then in theory it should be possible to hunt down all offenders.  But
> I think we'll want fallback logic to handle kernel MMIO #VEs, especially if the
> kernel needs ISA cracking logic for userspace.  Without fallback logic, any MMIO
> #VE from the kernel would be fatal, which is too harsh IMO since the behavior
> isn't so obviously wrong, e.g. versus the split lock #AC purge where there's no
> legitimate reason for the kernel to generate a split lock.

I'll buy that this patch is convenient for *debugging*.  It helped folks
bootstrap the TDX support and get it going.

IMNHO, if a driver causes a #VE, it's a bug.  Just like if it goes off
the rails and touches bad memory and #GP's or #PF's.

Are there any printk's in the #VE handler?  Guess what those do.  Print
to the console.  Guess what consoles do.  MMIO.  You can't get away from
doing audits of the console drivers.  Sure, you can go make #VE special,
like NMIs, but that's not going to be fun.  At least the guest doesn't
have to deal with the fatality of a nested #VE, but it's still fatal.

I just don't like us pretending that we're Windows and have no control
over the code we run and throwing up our hands.
