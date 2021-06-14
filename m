Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF7A3A7176
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhFNVjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 17:39:44 -0400
Received: from mga03.intel.com ([134.134.136.65]:27355 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232594AbhFNVjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:39:42 -0400
IronPort-SDR: xNAy/e81YPOv5q2pRvUeDxLnViQFJMJSdqoI6AeBxMOL85C8THaQFnsmhaLN8+Pk/0MKFmiRHc
 pTt6/gI/yx2g==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="205915643"
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="205915643"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:37:36 -0700
IronPort-SDR: I7Mm/rg0UCZZSwPpyzexFGL4qtaF+Ik80rtJg56L1lyH6oB6n5oaE4My+rXSyFLwbyQoddeNAk
 vfOPvuVvRedQ==
X-IronPort-AV: E=Sophos;i="5.83,273,1616482800"; 
   d="scan'208";a="621154130"
Received: from unknown (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.156.97])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2021 14:37:35 -0700
Subject: Re: [PATCH v1 05/11] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210602022136.2186759-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YMcXvzD2o7rWsl0W@zn.tnic>
 <b0dff409-d084-bfc1-c260-e1732b5e8ee5@linux.intel.com>
 <YMe34ptb8CCV7Vg9@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ba91c178-406f-834c-e49c-06fa1d953971@linux.intel.com>
Date:   Mon, 14 Jun 2021 14:37:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMe34ptb8CCV7Vg9@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/14/21 1:11 PM, Borislav Petkov wrote:
> On Mon, Jun 14, 2021 at 12:45:45PM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> May be I should define a macro for it and use Mov to keep it uniform
>> with other register updates.
> 
> Macro?
> 
> There's the, well, *MOV* instruction, if you insist on keeping it
> uniform. But this is not about keeping it uniform - it is about having
> the code as clear as understandable as possible:
> 
> 
> 	/* Set RAX to TDCALL leaf function 0 */
> 	xor %eax, %eax
> 
> Plain and simple and clear why the XORing is done.

Ok. I will fix the comment.


>> With the trace support, they should be able to see the flow before making
>> the tdx_*_call(). That should be enough clue for debug right?
> 
> Are you expecting all those cloud users to trace their guests just to
> figure that out? I'm sceptical they will...
> 
> Rather, I'd try to allocate a special error value that
> do_tdx_hypercall() returns in %eax and then have the wrapper which will
> puts %r10 on the stack, check that error value and panic with a nice
> error message.
> 

I will add r10 to struct tdx_hypercall_output and return it to callers to
check it.


> 
> Btw, where is that function used? Gurgling, it shows it in some MMIO
> patch, I'm guessing that's still coming.
> 
> As to how to do it properly, you pass in
> 
> 	struct tdx_hypercall_output *out
> 
> as a function parameter and caller can pick out whatever it wants from
> that struct.

It looks like it is used only in MMIO use case now. I think we don't need
it anymore. I will remove it.

> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
