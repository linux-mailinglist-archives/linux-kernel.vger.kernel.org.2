Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AD3355951
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346494AbhDFQix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:38:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:26090 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346415AbhDFQiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:38:51 -0400
IronPort-SDR: sDW/IuPCXVeGxepljo3+dFOa+YXeCRKn5z8aJn5S1BzK/mYmtgg9lnHUKEb7BKkjqBSQJv9xLu
 b1D90ExeAjbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="173187019"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="173187019"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 09:38:43 -0700
IronPort-SDR: b7tcnY7BderJ4QK20eQOeLBL3v5QD7U2wMjolWHVlrsGq39waug5enz5f/u7g3fVhWrQrrAm6C
 mLPsJAkTa5NQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="447907689"
Received: from hlalithk-mobl1.amr.corp.intel.com (HELO [10.209.146.228]) ([10.209.146.228])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 09:38:42 -0700
Subject: Re: [RFC v1 25/26] x86/tdx: Make DMA pages shared
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0bc9209a36760ee7c8591322327ddbfe87351b09.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <cc8e2e73-9d08-894c-47f9-ec82b0642789@intel.com>
 <20210406163150.cbmcybnu6hu5alk7@box>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <6065a93b-6bcd-2038-e994-6ec7b7b4c891@intel.com>
Date:   Tue, 6 Apr 2021 09:38:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406163150.cbmcybnu6hu5alk7@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 9:31 AM, Kirill A. Shutemov wrote:
> On Thu, Apr 01, 2021 at 02:01:15PM -0700, Dave Hansen wrote:
>>> @@ -1977,8 +1978,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>>>  	struct cpa_data cpa;
>>>  	int ret;
>>>  
>>> -	/* Nothing to do if memory encryption is not active */
>>> -	if (!mem_encrypt_active())
>>> +	/* Nothing to do if memory encryption and TDX are not active */
>>> +	if (!mem_encrypt_active() && !is_tdx_guest())
>>>  		return 0;
>>
>> So, this is starting to look like the "enc" naming is wrong, or at least
>> a little misleading.   Should we be talking about "protection" or
>> "guards" or something?
> 
> Are you talking about the function argument or function name too?

Yes, __set_memory_enc_dec() isn't really just doing "enc"ryption any more.

>>>  	/* Should not be working on unaligned addresses */
>>> @@ -1988,8 +1989,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>>>  	memset(&cpa, 0, sizeof(cpa));
>>>  	cpa.vaddr = &addr;
>>>  	cpa.numpages = numpages;
>>> -	cpa.mask_set = enc ? __pgprot(_PAGE_ENC) : __pgprot(0);
>>> -	cpa.mask_clr = enc ? __pgprot(0) : __pgprot(_PAGE_ENC);
>>> +	if (is_tdx_guest()) {
>>> +		cpa.mask_set = __pgprot(enc ? 0 : tdx_shared_mask());
>>> +		cpa.mask_clr = __pgprot(enc ? tdx_shared_mask() : 0);
>>> +	} else {
>>> +		cpa.mask_set = __pgprot(enc ? _PAGE_ENC : 0);
>>> +		cpa.mask_clr = __pgprot(enc ? 0 : _PAGE_ENC);
>>> +	}
>>
>> OK, this is too hideous to live.  It sucks that the TDX and SEV/SME bits
>> are opposite polarity, but oh well.
>>
>> To me, this gets a lot clearer, and opens up room for commenting if you
>> do something like:
>>
>> 	if (is_tdx_guest()) {
>> 		mem_enc_bits   = 0;
>> 		mem_plain_bits = tdx_shared_mask();
>> 	} else {
>> 		mem_enc_bits   = _PAGE_ENC;
>> 		mem_plain_bits = 0
>> 	}
>>
>> 	if (enc) {
>> 		cpa.mask_set = mem_enc_bits;
>> 		cpa.mask_clr = mem_plain_bits;  // clear "plain" bits
>> 	} else {
>> 		
>> 		cpa.mask_set = mem_plain_bits;
>> 		cpa.mask_clr = mem_enc_bits;	// clear encryption bits
>> 	}
> 
> I'm not convinced that your approach it clearer. If you add the missing
> __pgprot() it going to as ugly as the original.
> 
> But if a maintainer wants... :)

Yes, please.  I think my version (with the added __pgprot() conversions)
clearly separates out the two thing that are going on.

>>>  	cpa.pgd = init_mm.pgd;
>>>  
>>>  	/* Must avoid aliasing mappings in the highmem code */
>>> @@ -1999,7 +2006,8 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
>>>  	/*
>>>  	 * Before changing the encryption attribute, we need to flush caches.
>>>  	 */
>>> -	cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>>> +	if (!enc || !is_tdx_guest())
>>> +		cpa_flush(&cpa, !this_cpu_has(X86_FEATURE_SME_COHERENT));
>>
>> That "!enc" looks wrong to me.  Caches would need to be flushed whenever
>> encryption attributes *change*, not just when they are set.
>>
>> Also, cpa_flush() flushes caches *AND* the TLB.  How does TDX manage to
>> not need TLB flushes?
> 
> I will double-check everthing, but I think we can skip *both* cpa_flush()
> for private->shared conversion. VMM and TDX module will take care about
> TLB and cache flush in response to MapGPA TDVMCALL.

Oh, interesting.  You might also want to double check if there are any
more places where X86_FEATURE_SME_COHERENT and TDX have similar properties.
