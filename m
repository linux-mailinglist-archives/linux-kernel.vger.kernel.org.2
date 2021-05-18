Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC9387CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbhERP6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:58:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:59187 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350480AbhERP6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:58:51 -0400
IronPort-SDR: GvKliayCrsKSygqPg55lDbUbeUxabKMuz5/1EiA75JS+Azcr7I2ebYihEyrKdztxva1nYcVJ89
 gAMLtYx+VBDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180349931"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180349931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:56:35 -0700
IronPort-SDR: z0g/9luv2LW0Bv8ya4CBBWhVf/O0tqqr6okTgFhwzmWzVguUBYB2Ep7t7ZLaMTP1i933egEkiU
 Q4Px3ZljA5Xw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439500398"
Received: from msaber-mobl.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:56:34 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
Date:   Tue, 18 May 2021 08:56:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2021 8:00 AM, Dave Hansen wrote:
> On 5/17/21 5:48 PM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> In traditional VMs, MMIO tends to be implemented by giving a
>> guest access to a mapping which will cause a VMEXIT on access.
>> That's not possible in TDX guest.
> Why is it not possible?

For once the TDX module doesn't support uncached mappings (IgnorePAT is 
always 1)




>
>> For now we only handle a subset of instructions that the kernel
>> uses for MMIO operations. User-space access triggers SIGBUS.
> How do you know which instructions the kernel uses?

They're all in MMIO macros.


>   How do you know
> that the compiler won't change them?

The macros try hard to prevent that because it would likely break real 
MMIO too.

Besides it works for others, like AMD-SEV today and of course all the 
hypervisors that do the same.




> That sounds like something objective we can measure.  Does this cost 1
> byte of extra text per readl/writel?  10?  100?

Alternatives are at least a pointer, but also the extra alternative 
code. It's definitely more than 10, I would guess 40+



>
> I thought there were more than a few ways that userspace could get
> access to MMIO mappings.

Yes and they will all fault in TDX guests.


>> +	if (user_mode(regs)) {
>> +		pr_err("Unexpected user-mode MMIO access.\n");
>> +		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) ve->gla);
> 						       extra space ^
>
> Is a non-ratelimited pr_err() appropriate here?  I guess there shouldn't
> be any MMIO passthrough to userspace on these systems.
Yes rate limiting makes sense.

