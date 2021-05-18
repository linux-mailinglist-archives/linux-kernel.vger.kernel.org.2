Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3C838829F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 00:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbhERWNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 18:13:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:45780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236372AbhERWNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 18:13:24 -0400
IronPort-SDR: jZXOvV14y5wJrfUbzpGTtKe+JdA64aMGp0hO3kDaQuXZLwtmfQ97lq9/6sfceIv8pADBk09j9L
 w+7Mis1si66Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="198881829"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="198881829"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 15:12:05 -0700
IronPort-SDR: ltagyiBDDPPrVx/YvHQ/sjP4prabpfqgXYNMwxc2wzB7sAAcDvw+nmGYHTGLD0oAmzItlpXlri
 gbOZjOwjRAaQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439660110"
Received: from dwchow-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.41.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 15:12:04 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Make DMA pages shared
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <1ccf5e60d2d79308d50f93c8c3b32b1394bc7baf.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210518011912.259112-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YKQbu3bITMjUMf75@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <ec7718a5-09d9-4c2e-c48e-034c249b3573@linux.intel.com>
Date:   Tue, 18 May 2021 15:12:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YKQbu3bITMjUMf75@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/21 12:55 PM, Sean Christopherson wrote:
> On Mon, May 17, 2021, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> Intel TDX doesn't allow VMM to access guest memory. Any memory
>                                               ^
>                                               |- private
> 
> And to be pedantic, the VMM can _access_ guest private memory all it wants, it
> just can't decrypt guest private memory.

Ok. I will use "guest private memory".

> 
>> that is required for communication with VMM must be shared
>> explicitly by setting the bit in page table entry. And, after
>> setting the shared bit, the conversion must be completed with
>> MapGPA TDVMALL. The call informs VMM about the conversion and
>> makes it remove the GPA from the S-EPT mapping.
> 
> The VMM is _not_ required to remove the GPA from the S-EPT.  E.g. if the VMM
> wants to, it can leave a 2mb private page intact and create a 4kb shared page
> translation within the same range (ignoring the shared bit).

So does removing "makes it remove the GPA from the S-EPT mapping"
be sufficient? Or you want to add more detail?


> 
>> The shared memory is similar to unencrypted memory in AMD SME/SEV
>> terminology but the underlying process of sharing/un-sharing the memory is
>> different for Intel TDX guest platform.
>>
>> SEV assumes that I/O devices can only do DMA to "decrypted"
>> physical addresses without the C-bit set.  In order for the CPU
>> to interact with this memory, the CPU needs a decrypted mapping.
>> To add this support, AMD SME code forces force_dma_unencrypted()
>> to return true for platforms that support AMD SEV feature. It will
>> be used for DMA memory allocation API to trigger
>> set_memory_decrypted() for platforms that support AMD SEV feature.
>>
>> TDX is similar.  TDX architecturally prevents access to private
> 
> TDX doesn't prevent accesses.  If hardware _prevented_ accesses then we wouldn't
> have to deal with the #MC mess.
How about following change?

"TDX is similar. TDX architecturally prevents access to private guest memory by
  anything other than the guest itself.This means that any DMA buffers must be
  shared."

modified to =>

"TDX is similar. In TDX architecture, the private guest memory is encrypted, which
prevents anything other than guest from accessing/modifying it. So to communicate
with I/O devices, we need to create decrypted mapping and make the pages shared."

> 
>> guest memory by anything other than the guest itself. This means
>> that any DMA buffers must be shared.
>>
>> So create a new file mem_encrypt_tdx.c to hold TDX specific memory
>> initialization code, and re-define force_dma_unencrypted() for
>> TDX guest and make it return true to get DMA pages mapped as shared.
>>
>> __set_memory_enc_dec() is now aware about TDX and sets Shared bit
>> accordingly following with relevant TDVMCALL.
>>
>> Also, Do TDACCEPTPAGE on every 4k page after mapping the GPA range when
> 
> This should call out that the current TDX spec only supports 4kb AUG/ACCEPT.

Ok. I will add this spec detail.

> 
> On that topic... are there plans to support 2mb and/or 1gb TDH.MEM.PAGE.AUG?  If
> so, will TDG.MEM.PAGE.ACCEPT also support 2mb/1gb granularity?
> 
>> converting memory to private.  If the VMM uses a common pool for private
>> and shared memory, it will likely do TDAUGPAGE in response to MAP_GPA
>> (or on the first access to the private GPA),
> 
> What the VMM does or does not do is irrelevant.  What matters is what the VMM is
> _allowed_ to do without violating the GHCI.  Specifically, the VMM is allowed to
> unmap a private page in response to MAP_GPA to convert to a shared page.
> 
>    If the GPA (range) was already mapped as an active, private page, the host
>    VMM may remove the private page from the TD by following the “Removing TD
>    Private Pages” sequence in the Intel TDX-module specification [3] to safely
>    block the mapping(s), flush the TLB and cache, and remove the mapping(s).
> 
> That would also provide a nice segue into the "already accepted" error below.

Ok. I will add the above detail.

> 
>> in which case TDX-Module will hold the page in a non-present "pending" state
>> until it is explicitly accepted.
>>
>> BUG() if TDACCEPTPAGE fails (except the above case)
> 
> What above case?  The code handles the case where the page was already accepted,
> but the changelog doesn't talk about that at all.

I think it meant about "already accepted" page case. With your above suggestion,
we can ignore this error. Or I can change it to,

BUG() if TDACCEPTPAGE fails (except "previously accepted page" case)

> 
>> as the guest is completely hosed if it can't access memory.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
