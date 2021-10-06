Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8490D4245D5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 20:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJFSRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 14:17:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:26211 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhJFSRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 14:17:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="249353787"
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="249353787"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 11:14:34 -0700
X-IronPort-AV: E=Sophos;i="5.85,352,1624345200"; 
   d="scan'208";a="589855256"
Received: from ptcotton-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.211.164])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2021 11:14:33 -0700
Subject: Re: [PATCH v8 04/11] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
To:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
 <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005211611.ys42txybaed4ffpz@treble> <YV3kmuIksOXMl11G@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5fa4df70-fab6-fd7a-06cf-cb71e77ac4d5@linux.intel.com>
Date:   Wed, 6 Oct 2021 11:14:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YV3kmuIksOXMl11G@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/6/21 11:02 AM, Borislav Petkov wrote:
> On Tue, Oct 05, 2021 at 02:16:11PM -0700, Josh Poimboeuf wrote:
>> I assume this needs a rebase on -tip since cc_platform.c already has an
>> empty version of this function (and it's static so it doesn't need to be
>> declared in a header).
> 
> Yes:
> 
> arch/x86/kernel/cc_platform.c:16:28: error: static declaration of ‘intel_cc_platform_has’ follows non-static declaration
>     16 | static bool __maybe_unused intel_cc_platform_has(enum cc_attr attr)
>        |                            ^~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/mem_encrypt.h:17,
>                   from arch/x86/kernel/cc_platform.c:12:
> ./arch/x86/include/asm/mem_encrypt.h:105:6: note: previous declaration of ‘intel_cc_platform_has’ was here
>    105 | bool intel_cc_platform_has(enum cc_attr attr);
>        |      ^~~~~~~~~~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:277: arch/x86/kernel/cc_platform.o] Error 1
> make[1]: *** [scripts/Makefile.build:540: arch/x86/kernel] Error 2
> make: *** [Makefile:1868: arch/x86] Error 2
> make: *** Waiting for unfinished jobs....
> 
> I had already started that function there - please add all TDX logic in
> cc_platform.c.
> 
> When you do your next set, you can use tip/master as a base. This should
> be used for all x86 patchsets anyway.

Yes. I have already rebased my patches on top of tip branch. Next version
will not have this issue.


> 
>>> +	/**
>>> +	 * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
>>> +	 *
>>> +	 * The platform/OS is running as a TDX guest/virtual machine.
>>> +	 *
>>> +	 * Examples include Intel TDX.
>>> +	 */
>>> +	CC_ATTR_GUEST_TDX,
>>
>> Examples of TDX include TDX? :-)
> 
> Yeah, so whether we should be naming the actual conf. computing
> implementation came up during the cc_platform_has() review and looking
> forward in this patchset:
> 
> +       if (cc_platform_has(CC_ATTR_GUEST_TDX))
> +               return tdx_kvm_hypercall(nr, 0, 0, 0, 0);
> 
> you really need to test for TDX because you're doing a TDX-specific
> hypercall.
> 
> Which brings me back to the fastpath use of is_idx_guest(): this
> looks to me like a fastpath use - dunno how often one needs to do TDX
> hypercalls so I can imagine that for this, the is_tdx_guest() check
> should use a static branch.
> 
> But only with numbers to show the need for it.

Compared to TDX hypercall, additional function call should not take much
time. IMO, we don't need fast path for hypercalls.

Sean/Andi - Any comments?

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
