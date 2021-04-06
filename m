Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2DF3558E8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbhDFQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 12:11:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:46694 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232512AbhDFQLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 12:11:38 -0400
IronPort-SDR: JKJnwMJ7Cyp1jLQlUTBf78yjiBK+6Nz6Aq881wAnIBHZCDNFZzUE9KPmHNRkFKjwtNPzUimong
 Bb3VVRpUQMNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="180233170"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180233170"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 09:11:27 -0700
IronPort-SDR: 1YWU5SzxmksaCSX/9/l0K8abvfTRRJ1UslXS5shBUg+QhYkUD/PDWgoNWyYG+06LWUhZgiqALW
 X0cggfqkkfBQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="447898408"
Received: from hlalithk-mobl1.amr.corp.intel.com (HELO [10.209.146.228]) ([10.209.146.228])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 09:11:26 -0700
Subject: Re: [RFC v1 21/26] x86/mm: Move force_dma_unencrypted() to common
 code
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
        linux-kernel@vger.kernel.org
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <444fe9c7c035417f6abc3e0be2a4861cb573ab28.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d4eb7452-f6dd-2e0e-a790-76abdbbbfee9@intel.com>
 <20210406153755.evphkyms3bwo7scc@box>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <8d551c07-1361-b431-6195-d81a08e9e83a@intel.com>
Date:   Tue, 6 Apr 2021 09:11:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406153755.evphkyms3bwo7scc@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/21 8:37 AM, Kirill A. Shutemov wrote:
> On Thu, Apr 01, 2021 at 01:06:29PM -0700, Dave Hansen wrote:
>> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
>>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>>
>>> Intel TDX doesn't allow VMM to access guest memory. Any memory that is
>>> required for communication with VMM suppose to be shared explicitly by
>>
>> s/suppose to/must/
> 
> Right.
> 
>>> setting the bit in page table entry. The shared memory is similar to
>>> unencrypted memory in AMD SME/SEV terminology.
>>
>> In addition to setting the page table bit, there's also a dance to go
>> through to convert the memory.  Please mention the procedure here at
>> least.  It's very different from SME.
> 
> "
>   After setting the shared bit, the conversion must be completed with
>   MapGPA TDVMALL. The call informs VMM about the conversion and makes it
>   remove the GPA from the S-EPT mapping.
> "

Where does the TDX module fit in here?

>>> force_dma_unencrypted() has to return true for TDX guest. Move it out of
>>> AMD SME code.
>>
>> You lost me here.  What does force_dma_unencrypted() have to do with
>> host/guest shared memory?
> 
> "
>   AMD SEV makes force_dma_unencrypted() return true which triggers
>   set_memory_decrypted() calls on all DMA allocations. TDX will use the
>   same code path to make DMA allocations shared.
> "

SEV assumes that I/O devices can only do DMA to "decrypted" physical
addresses without the C-bit set.  In order for the CPU to interact with
this memory, the CPU needs a decrypted mapping.

TDX is similar.  TDX architecturally prevents access to private guest
memory by anything other than the guest itself.  This means that any DMA
buffers must be shared.

Right?

>>> Introduce new config option X86_MEM_ENCRYPT_COMMON that has to be
>>> selected by all x86 memory encryption features.
>>
>> Please also mention what will set it.  I assume TDX guest support will
>> set this option.  It's probably also worth a sentence to say that
>> force_dma_unencrypted() will have TDX-specific code added to it.  (It
>> will, right??)
> 
> "
>   Only AMD_MEM_ENCRYPT uses the option now. TDX will be the second one.
> "
> 
>>> This is preparation for TDX changes in DMA code.
>>
>> Probably best to also mention that this effectively just moves code
>> around.  This patch should have no functional changes at runtime.
> 
> Isn't it what the subject says? :P

Yes, but please mention it explicitly.
