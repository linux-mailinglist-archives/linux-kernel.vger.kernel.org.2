Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B753379A7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbhEJXJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:09:53 -0400
Received: from mga07.intel.com ([134.134.136.100]:17989 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229502AbhEJXJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:09:51 -0400
IronPort-SDR: X8HV9nn+rTJFTWoweLiAj+4HhXDeX6lsAMAqirBUuou4Y8cYj8jd+Zs5KtNvgjBLv+DoJy7eUf
 EsLSqaTQHK/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263239092"
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="263239092"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 16:08:43 -0700
IronPort-SDR: E2KqVgeupgma0ACp6LRa582YaTCbDKsP6QiK26M+uvBvb2xS26/sA0EHioJUlpAoRNjaix0I3H
 tJMkXThKZ1dQ==
X-IronPort-AV: E=Sophos;i="5.82,288,1613462400"; 
   d="scan'208";a="434020287"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.217]) ([10.209.32.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 16:08:42 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
Date:   Mon, 10 May 2021 16:08:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/10/2021 2:57 PM, Dan Williams wrote:
>
> There is a mix of direct-TDVMCALL usage and handling #VE when and why
> is either approached used?

For the really early code in the decompressor or the main kernel we 
can't use #VE because the IDT needed for handling the exception is not 
set up, and some other infrastructure needed by the handler is missing. 
The early code needs to do port IO to be able to write the early serial 
console. To keep it all common it ended up that all port IO is paravirt. 
Actually for most the main kernel port IO calls we could just use #VE 
and it would result in smaller binaries, but then we would need to 
annotate all early portio with some special name. That's why port IO is 
all TDCALL.

For some others the only thing that really has to be #VE is MMIO because 
we don't want to annotate every MMIO read*/write* with an alternative 
(which would result in incredible binary bloat) For the others they have 
mostly become now direct calls.


>
>> Decompression code uses port IO for earlyprintk. We must use
>> paravirt calls there too if we want to allow earlyprintk.
> What is the tradeoff between teaching the decompression code to handle
> #VE (the implied assumption) vs teaching it to avoid #VE with direct
> TDVMCALLs (the chosen direction)?

The decompression code only really needs it to output something. But you 
couldn't debug anything until #VE is set up. Also the decompression code 
has a very basic environment that doesn't supply most kernel services, 
and the #VE handler is relatively complicated. It would probably need to 
be duplicated and the instruction decoder be ported to work in this 
environment. It would be all a lot of work, just to make the debug 
output work.

>
>> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> ---
>>   arch/x86/boot/compressed/Makefile |   1 +
>>   arch/x86/boot/compressed/tdcall.S |   9 ++
>>   arch/x86/include/asm/io.h         |   5 +-
>>   arch/x86/include/asm/tdx.h        |  46 ++++++++-
>>   arch/x86/kernel/tdcall.S          | 154 ++++++++++++++++++++++++++++++
> Why is this named "tdcall" when it is implementing tdvmcalls? I must
> say those names don't really help me understand what they do. Can we
> have Linux names that don't mandate keeping the spec terminology in my
> brain's translation cache?

The instruction is called TDCALL. It's always the same instruction

TDVMCALL is the variant when the host processes it (as opposed to the 
TDX module), but it's just a different name space in the call number.


             \

> Is there a unified Linux name these can be given to stop the
> proliferation of poor vendor names for similar concepts?

We could use protected_guest()


>
> Does it also not know how to handle #VE to keep it aligned with the
> runtime code?


Not sure I understand the question, but the decompression code supports 
neither alternatives nor #VE. It's a very limited environment.

>
> Outside the boot decompression code isn't this branch of the "ifdef
> BOOT_COMPRESSED_MISC_H"  handled by #VE? I also don't see any usage of
> __{in,out}() in this patch.

I thought it was all alternative after decompression, so the #VE code 
shouldn't be called. We still have it for some reason though.


>
> Perhaps "PAYLOAD_SIZE" since it is used for both input and output?
>
> If the ABI does not include the size of the payload then how would
> code detect if even 80 bytes was violated in the future?


The payload in memory is just a Linux concept. At the TDCALL level it's 
only registers.


>
> 5
> Surely there's an existing macro for this pattern? Would
> PUSH_AND_CLEAR_REGS + POP_REGS be suitable? Besides code sharing it
> would eliminate clearing of %r8.


There used to be SAVE_ALL/SAVE_REGS, but they have been all removed in 
some past refactorings.


-Andi

