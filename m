Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F7838F7F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEYCOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:14:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:64659 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhEYCOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:14:47 -0400
IronPort-SDR: GJCRIg+Hly4rUbDBwNtPoSU5qg6O7ciDXKl7nu2ku9vF6it4Cc4wCw/iQHB5aXiC0ueTUm4ioJ
 kZ2gtF8zG2EA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="201827766"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="201827766"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:13:18 -0700
IronPort-SDR: l16tqqrH6MTySpNaorQrz93PbUAvT7f0F0dPwLTSguBig3D1Jl4OEmQy+NUSFNpBDMvsoatw44
 ddng3MtoD+SA==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="546313065"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:13:17 -0700
Subject: Re: [RFC v2-fix-v2 2/2] x86/tdx: Ignore WBINVD instruction for TDX
 guest
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <37ad50ca-f568-4c62-56e2-9e9b1f34084c@linux.intel.com>
 <20210524233211.802033-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210524233211.802033-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jKY0rmewFnyL6My5-b+w8ANAwDY2tLXZk4CYKydoVbtg@mail.gmail.com>
 <b420a7af-5202-fee9-9e0b-39680d0cc9c8@linux.intel.com>
 <CAPcyv4gNz9gKsHVcindp3OsHz4hMRWPZgsNu1A5xrDQg7tYqNA@mail.gmail.com>
 <cea7c704-5f1c-3f84-e47b-c62da18e358e@linux.intel.com>
 <CAPcyv4h4=eNZFS7d13WvzpWzTkHAMF7Mxo0frqf2gdmaFN3++Q@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <125f8362-b1e3-d304-f943-3fc2f07b5d79@linux.intel.com>
Date:   Mon, 24 May 2021 19:13:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h4=eNZFS7d13WvzpWzTkHAMF7Mxo0frqf2gdmaFN3++Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/2021 6:45 PM, Dan Williams wrote:
>
>>
>>> but
>>> it does not make the description of this patch correct.
>> If KVM was broken I'm sure we would hear about it.
> KVM does not try to support the cases where wbinvd being unavailable
> would break the system. That is not the claim being made in this
> patch.

I thought we made that claim.


"We just want to be the same as KVM"

>
>> The ACPI cases are for S3, which is not supported in guests, or for the
>> old style manual IO port C6, which isn't supported either.
>> The persistent memory cases would require working DMA mappings,
> No, that analysis is wrong.The wbinvd audit would have found that
> persistent memory secure-erase and unlock, which has nothing to do
> with DMA, needs wbinvd to ensure that the CPU has not retained a copy
> of the PMEM contents from before the unlock happened and it needs to
> make sure that any data that was meant to be destroyed by an erasure
> is not retained in cache.

But that's all not supported in TDX.

And the only way it could work in KVM is when there is some DMA, likely 
at least an IOMMU, e.g. to set up the persistent memory. That's what I 
meant with working DMA mappings.

Otherwise KVM would be really broken, but I don't really believe that 
without some real evidence.


>
> It's fine to not support the above cases, I am asking for the
> explanation to demonstrate the known risks and the known mitigations.

The analysis is that all this stuff that you are worried about cannot be 
enabled in a TDX guest

(it would be a nightmare if it could, we would need to actually make it 
secure against a malicious host)

> IgnorePAT is not the mitigation, the mitigation is an audit to
> describe why the known users are unlikely to be triggered. Even better
> would be an addition patch that does something like:
>
> iff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4b80150e4afa..a6b13a1ae319 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -170,6 +170,9 @@ static int __nvdimm_security_unlock(struct nvdimm *nvdimm)
>          const void *data;
>          int rc;
>
> +       if (is_protected_guest())
> +               return -ENXIO;
> +
>          /* The bus lock should be held at the top level of the call stack */
>          lockdep_assert_held(&nvdimm_bus->reconfig_mutex);
>
> ...to explicitly error out a wbinvd use case before data is altered
> and wbinvd is needed.

I don't see any point of all of this. We really just want to be the same 
as KVM. Not get into the business of patching a bazillion sub systems 
that cannot be used in TDX anyways.

-Andi

