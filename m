Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B477537A9B1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhEKOlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 10:41:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:64173 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231781AbhEKOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 10:41:00 -0400
IronPort-SDR: XAkxS6d8g+sflp8cTidaO5uAhX5/9ZA4VCt8nT63Ej/yHJ3sZJWEPtBaZh1Uc8BCcJwp0mRfug
 2w8dkvToRTHw==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199510634"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="199510634"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:39:36 -0700
IronPort-SDR: lrKdDO3hBV/t0wpH4Cl75xqd+QCi/dUBsTHwNXHDa18qTx3XbeIbZkQtmKQ6oBaZ7IHt2f54Mn
 neE33GRv1bMw==
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="537054480"
Received: from unknown (HELO [10.251.0.45]) ([10.251.0.45])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 07:39:36 -0700
Subject: Re: [RFC v2 14/32] x86/tdx: Handle port I/O
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0e7e94d1ee4bae49dfd0dd441dc4f2ab6df76668.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jPLGs6p0PNZQB6yKB3QDtEcGb234zcgCbJutXxZZEGnA@mail.gmail.com>
 <e8ac31bc-e307-f277-f928-24ebba4cbca7@linux.intel.com>
 <CAPcyv4iuRdXooQvCzEWd9babzPij4nXpM-z5fai9+SGaeFYswQ@mail.gmail.com>
 <9f89a317-11fa-d784-87a8-37124891900c@linux.intel.com>
 <CAPcyv4hymb73WZ7QqNsDyKiPzsFdPJF63+MLnOTfJMsQBFvSDg@mail.gmail.com>
 <3059c7d3-8646-2e1a-3c9f-1de67f7ed382@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <609b1182-5629-0727-d174-849c113a3960@intel.com>
Date:   Tue, 11 May 2021 07:39:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3059c7d3-8646-2e1a-3c9f-1de67f7ed382@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/21 7:29 PM, Kuppuswamy, Sathyanarayanan wrote:
> On 5/10/21 6:07 PM, Dan Williams wrote:
>> On Mon, May 10, 2021 at 5:30 PM Kuppuswamy, Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> [..]
>>> It is mainly used by functions like
>>> __tdx_hypercall(),__tdx_hypercall_vendor_kvm()
>>> and tdx_in{b,w,l}.
>>>
>>> u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
>>>                       struct tdx_hypercall_output *out);
>>> u64 __tdx_hypercall_vendor_kvm(u64 fn, u64 r12, u64 r13, u64 r14,
>>>                                  u64 r15, struct tdx_hypercall_output
>>> *out);
>>>
>>> struct tdx_hypercall_output {
>>>           u64 r11;
>>>           u64 r12;
>>>           u64 r13;
>>>           u64 r14;
>>>           u64 r15;
>>> };
>>
>> Why is this by register name and not something like:
>>
>> struct tdx_hypercall_payload {
>>    u64 data[5];
>> };
>>
>> ...because the code in this patch is reading the payload out of a
>> stack relative offset, not r11.
> 
> Since this patch allocates this memory in ASM code, we read it via
> offset. If you see other use cases in tdx.c, you will notice the use
> of register names.

To what you do you refer by "this patch allocates this memory in ASM
code"?  Could you point to the specific ASM code that "allocates memory"?

Dan I'll try to answer your question.  TDX has both a "hypercall"
interface for guests to call into hosts and a "seamcall" interface where
guests or hosts can talk to the TDX/SEAM module.

Both of these represent an ABI which _resembles_ a system call ABI.
Values are placed in registers, including a "function" register which is
very similar to a the system call number we place in RAX.

*But* those ABIs was actually designed to (IIRC) resemble the
Windows/Microsoft ABI, not the Linux ABI.  So the register conventions
are unfamiliar.  There is assembly code to convert between the ELF
function call ABI and the TDX ABIs.

For instance, if you are in C code and you call:

	__tdx_hypercall_vendor_kvm(u64 fn, u64 r12, ...

The value for "fn" will be placed in RAX and "r12" will be placed in RDI
for the function call itself.  The assembly code will, for instance,
take the "r12" *VARIABLE* and ensure it gets into the R12 *REGISTER* for
the hypercall.

The same thing happens on the output side.  The TDX ABIs specify
"return" values in certain registers (r11-r15).  However, those
registers are not preserved in our function return ABI.  So, they must
be stashed off in memory into a place where the caller can retrieve them.

Rather than being unstructured "data[]", the value in
tdx_hypercall_output->r11 was actually in register R11 at some point.
If you look at the spec, you can see the functions that use R11.

Let's say there's a hypercall to check for whether puppies are cute.
Here's the kernel side:

bool tdx_hypercall_puppies_are_cute()
{
	struct tdx_hypercall_output out;
	u64 ret;

	ret = __tdx_hypercall_vendor_kvm(HOST_LIKES_PUPPIES, ..., &out);

	/* Did the hypercall even succeed? */
	if (ret != SUCCESS)
		return -EINVAL;

	if (out->r11 == TDX_WHATEVER_CUTE_BIT)
		return true;

	// Nope, I guess puppies are not cute
	return false;
}

The spec would actually say, "Blah blah, puppies are cute if
TDX_WHATEVER_CUTE_BIT is set in r11".  So, this whole setup actually
results in really nice C code that you can sit side-by-side with the
spec and see if they agree.
