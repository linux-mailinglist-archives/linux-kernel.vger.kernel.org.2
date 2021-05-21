Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D3038CD75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhEUSby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:31:54 -0400
Received: from mga05.intel.com ([192.55.52.43]:39036 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229762AbhEUSbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:31:53 -0400
IronPort-SDR: FDPv9F+qYq4BT20lLRpM1dXDoccaLABOvihrWYJurvzrKFeOxdQuU8wfTK6DF7E7m6GvYaEe7S
 gft5qvoMIsnw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287087255"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287087255"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:30:28 -0700
IronPort-SDR: 2/ibAWiIBOcZjx8ReYRPPf0JUqh04zOHN9CUMSnVNuzNXkKiN1uPl7pS1Sxyv3CUBlmP+Nm8E5
 RFY1LzbMhBLA==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="613342975"
Received: from pburton-mobl.amr.corp.intel.com (HELO [10.209.36.169]) ([10.209.36.169])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 11:30:27 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86/boot: Avoid #VE during boot for TDX
 platforms
To:     Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <b1aafcbb-c5db-efa5-0343-014585e73191@intel.com>
 <20210521143524.2527690-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f33c63b2-7b41-4c99-abd6-b47a8e7a4e26@intel.com>
 <YKf5hObmGXNgx0vS@google.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <9a23d1c3-a443-6142-52b4-7594123030fb@intel.com>
Date:   Fri, 21 May 2021 11:30:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YKf5hObmGXNgx0vS@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/21/21 11:18 AM, Sean Christopherson wrote:
> On Fri, May 21, 2021, Dave Hansen wrote:
>>> +	/*
>>> +	 * Preserve current value of EFER for comparison and to skip
>>> +	 * EFER writes if no change was made (for TDX guest)
>>> +	 */
>>> +	movl    %eax, %edx
>>>  	btsl	$_EFER_SCE, %eax	/* Enable System Call */
>>>  	btl	$20,%edi		/* No Execute supported? */
>>>  	jnc     1f
>>>  	btsl	$_EFER_NX, %eax
>>>  	btsq	$_PAGE_BIT_NX,early_pmd_flags(%rip)
>>> -1:	wrmsr				/* Make changes effective */
>>>  
>>> +	/* Avoid writing EFER if no change was made (for TDX guest) */
>>> +1:	cmpl	%edx, %eax
>>> +	je	1f
>>> +	xor	%edx, %edx
>>> +	wrmsr				/* Make changes effective */
>>> +1:
>>
>> Just curious, but what if this goes wrong?  Say the TDX firmware didn't
>> set up EFER correctly and this code does the WRMSR.
> 
> By firmware, do you mean TDX-module, or guest firmware?  EFER is read-only in a
> TDX guest, i.e. the guest firmware can't change it either.

I guess I was assuming that the trusted BIOS was going to do the setup
of EFER before it hands control over to the kernel.  So, I *meant* the BIOS.

But, I see from below that it's probably the TDX-module that's
responsible for this behavior.

>> What ends up happening?  Do we get anything out on the console, or is it
>> essentially undebuggable?
> 
> Assuming "firmware" means TDX-module, if TDX-Module botches EFER (and only EFER)
> then odds are very, very good that the guest will never get to the kernel as it
> will have died long before in guest BIOS.
> 
> If the bug is such that EFER is correct in hardware, but RDMSR returns the wrong
> value (due to MSR interception), IIRC this will triple fault and so nothing will
> get logged.  But, the odds of that type of bug being hit in production are
> practically zero because the EFER setup is very static, i.e. any such bug should
> be hit during qualification of the VMM+TDX-Module.
> 
> In any case, even if a bug escapes, the shutdown is relatively easy to debug even
> without logs because the failure will cleary point at the WRMSR (that info can be
> had by running a debug TD or a debug TDX-Module).  By TDX standards, debugging
> shutdowns on a specific instruction is downright trivial :-).

That sounds sane to me.  It would be nice to get this into the
changelog.  Perhaps:

	This theoretically makes guest boot more fragile.  If, for
	instance, EER was set up incorrectly and a WRMSR was performed,
	the resulting (unhandled) #VE would triple fault.  However, this
	is likely to trip up the guest BIOS long before control reaches
	the kernel.  In any case, these kinds of problems are unlikely
	to occur in production environments, and developers have good
	debug tools to fix them quickly.

That would put my mind at ease a bit.
