Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFF4430C08
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 22:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbhJQUhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 16:37:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:11991 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242454AbhJQUhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 16:37:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="215068719"
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="215068719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 13:35:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,380,1624345200"; 
   d="scan'208";a="565425995"
Received: from ericalo-mobl.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.45.96])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2021 13:35:24 -0700
Subject: Re: [PATCH v7 05/10] x86/tdx: Handle port I/O
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, thomas.lendacky@amd.com
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <87v91v2zkk.ffs@tglx>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <eadc3025-a32d-3641-de83-e5f05728a755@linux.intel.com>
Date:   Sun, 17 Oct 2021 13:35:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87v91v2zkk.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/17/21 12:58 PM, Thomas Gleixner wrote:
> On Tue, Oct 05 2021 at 13:41, Kuppuswamy Sathyanarayanan wrote:
>>   									\
>>   static inline void outs##bwl(int port, const void *addr, unsigned long count) \
>>   {									\
>> -	if (sev_key_active()) {						\
>> +	if (sev_key_active() ||						\
>> +	    cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
> Instead of adding an extra check, can you please replace that
> sev_key_active() with cc_platform_has() completely?

Yes. sev_key_active() can be removed and replaced with
cc_platform_has().

Thomas Lendacky also proposed to introduce as common
static key which can be set by both AMD SEV and TDX code.

@Thomas Lendacky, any comments?

>
>> +/*
>> + * tdx_handle_early_io() cannot be re-used in #VE handler for handling
>> + * I/O because the way of handling string I/O is different between
>> + * normal and early I/O case. Also, once trace support is enabled,
>> + * tdx_handle_io() will be extended to use trace calls which is also
>> + * not valid for early I/O cases.
>> + */
>> +static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
>> +{
>> +	struct tdx_hypercall_output outh;
>> +	int out, size, port, ret;
>> +	bool string;
>> +	u64 mask;
>> +
>> +	string = VE_IS_IO_STRING(exit_qual);
>> +
>> +	/* I/O strings ops are unrolled at build time. */
> Fancy. The compiler can evaluate sev_key_active() and
> cc_platform_has() at build time?

It is incorrect. I will fix this in next version. How about following
change?

I/O strings are replaced with in/out instructions. If string is reported,
report it with BUG.

>
> Thanks,
>
>          tglx

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

