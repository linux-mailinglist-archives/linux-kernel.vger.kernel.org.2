Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA76387E46
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 19:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351046AbhERRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 13:17:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:47762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238824AbhERRRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 13:17:06 -0400
IronPort-SDR: JL2OkndWf9A0Q+1IkLcfFDXUsPeQEoHD5Clal5MKjZd+KvFsC6JfXHpmpmq7WtumiCznJg2etj
 PRw7zFcPUtlA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="286299835"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286299835"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:15:46 -0700
IronPort-SDR: tV68nYpT1BYbG9e3+N/FaVq8Qd7pT8bRjNyoQKZ1kCcM0kxcoQTIGizXWjESCGaHghUbdYR1+0
 s4QaIo2wSkbg==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439530784"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 10:15:45 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <YKPo2Zde5b0QxIPJ@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <d8c87904-d994-8a5a-c0e8-be861fcac6df@linux.intel.com>
Date:   Tue, 18 May 2021 10:15:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKPo2Zde5b0QxIPJ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> * If we didn't annotate we would need to add an alternative to every
>>>    MMIO access in the kernel (even though 99.9% will never be used on
>>>    TDX) which would be a complete waste and incredible binary bloat
>>>    for nothing.
>> That sounds like something objective we can measure.  Does this cost 1
>> byte of extra text per readl/writel?  10?  100?
> Agreed.  And IMO, it's worth converting the common case (macros) if the overhead
> is acceptable, while leaving the #VE handling in place for non-standard code.

We have many millions of lines of MMIO using driver code in the kernel 
99.99% of which never runs in TDX. I don't see any point in impacting 
everything for this. That would be just against all good code change 
hygiene practices, and also just be bloated.

But we also don't don't want to touch every driver, for similar reasons.

What I think would make sense is to convert something to a direct TDCALL 
if we figure out the extra #VE is a real life performance problem. AFAIK 
the only candidate that I have in mind for this is the virtio doorbell 
write (and potentially later its VMBus equivalent). But we should really 
only do that if some measurements show it's needed.



> Why does this code exist at all?  TDX and SEV-ES absolutely must share code for
> handling MMIO reflection.  It will require a fair amount of refactoring to move
> the guts of vc_handle_mmio() to common code, but there is zero reason to maintain
> two separate versions of the opcode cracking.

While that's true on the high level, all the low level details are 
different. We looked at unifying at some point, but it would have been a 
callback hell. I don't think unifying would make anything cleaner.

Besides the bulk of the decoding work is already unified in the common 
x86 instruction decoder. The actual actions are different, and the code 
fetching is also different, so on the rest there isn't that much to unify.


> The existing SEV-ES #VC handlers appear to be missing page split checks, so that
> needs to be fixed.

Only if anyone in the kernel actually relies on it?


-Andi

