Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949783922A2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhEZWWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:22:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:42385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhEZWWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:22:11 -0400
IronPort-SDR: bhRMq735Kytr34Jy0eCoynvfnz7qFlkbEBrZFVhRy9hUfTgizbwbEKqQC43553QgwqZQHjZb4t
 rvJhk/S18fGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="266486596"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="266486596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:20:36 -0700
IronPort-SDR: e70GE4DzWnsLwUwfKj1GcK0bKGGBICwOF6Z/vnRvtUQA4/5ro9a7GQQFo1Rsha7M7/Z9qBMpWs
 BN2H/6ik1/6w==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="547403537"
Received: from skgiroua-mobl2.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.251.151.24])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 15:20:35 -0700
Subject: Re: [RFC v2 28/32] x86/tdx: Make pages shared in ioremap()
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eaaa692ce1ed897f66f864bbfa2df8683768d79e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <b884067a-19d6-105f-9f8c-28feb3b43446@intel.com>
 <312879fb-d201-a16d-2568-150152044c54@linux.intel.com>
 <797c95bf-9516-8aee-59d0-f5259d77bb75@linux.intel.com>
 <5b4b4fc0-aaa8-3407-6602-537d59572bc1@intel.com>
 <YJm5QY8omAvdpBO9@google.com> <YJpP/S8MajKNhBl4@zn.tnic>
 <0e233779-9c10-11df-b527-ef61e003ea35@linux.intel.com>
 <YKfPLlulaqwypNkO@zn.tnic> <f5e64c61-7f3c-3936-1b8e-7874ec81d83e@amd.com>
 <a53cd108-8758-e153-7ae6-c508fce02003@linux.intel.com>
 <777db866-4c3d-d849-94cf-b4248c6ac2aa@amd.com>
 <de96fb04-b8a4-02b4-be51-0e1c49976f22@amd.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e9ee5e3c-b1a2-4491-52ce-f395d4c12342@linux.intel.com>
Date:   Wed, 26 May 2021 15:20:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <de96fb04-b8a4-02b4-be51-0e1c49976f22@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 3:14 PM, Tom Lendacky wrote:
> On 5/26/21 5:02 PM, Tom Lendacky wrote:
>> On 5/26/21 4:37 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>>
>>> On 5/21/21 9:19 AM, Tom Lendacky wrote:
>>>> In arch/x86/mm/mem_encrypt.c, sme_early_init() (should have renamed that
>>>> when SEV support was added), we do:
>>>>      if (sev_active())
>>>>          swiotlb_force = SWIOTLB_FORCE;
>>>>
>>>> TDX should be able to do a similar thing without having to touch
>>>> arch/x86/kernel/pci-swiotlb.c.
>>>>
>>>> That would remove any confusion over SME being part of a
>>>> protected_guest_has() call.
>>>
>>> You mean sme_active() check in arch/x86/kernel/pci-swiotlb.c is redundant?
>>
>> No, the sme_active() check is required to make sure that SWIOTLB is
>> available under SME. Encrypted DMA is supported under SME if the device
>> supports 64-bit DMA. But if the device doesn't support 64-bit DMA and the
>> IOMMU is not active, then DMA will be bounced through SWIOTLB.
>>
>> As compared to SEV, where all DMA has to be bounced through SWIOTLB or
>> unencrypted memory. For that, swiotlb_force is used.
> 
> I should probably add that SME is memory encryption support for
> host/hypervisor/bare-metal, while SEV is memory encryption support for
> virtualization.

Got it. Thanks for clarification.

> 
> Thanks,
> Tom
> 
>>
>> Thanks,
>> Tom
>>
>>>
>>>   41 int __init pci_swiotlb_detect_4gb(void)
>>>   42 {
>>>   43         /* don't initialize swiotlb if iommu=off (no_iommu=1) */
>>>   44         if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN)
>>>   45                 swiotlb = 1;
>>>   46
>>>   47         /*
>>>   48          * If SME is active then swiotlb will be set to 1 so that bounce
>>>   49          * buffers are allocated and used for devices that do not support
>>>   50          * the addressing range required for the encryption mask.
>>>   51          */
>>>   52         if (sme_active() || is_tdx_guest())
>>>   53                 swiotlb = 1;
>>>
>>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
