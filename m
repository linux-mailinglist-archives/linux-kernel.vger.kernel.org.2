Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2148352D72
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhDBP1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:27:42 -0400
Received: from mga09.intel.com ([134.134.136.24]:21577 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236421AbhDBP1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:27:36 -0400
IronPort-SDR: mY0QcfNJJUBsTYxnuDE8e0fD50cIQcUH+XX9nviRpqB6G1a+68bsuuDap+POMD3fHu8njXnEjk
 rXaHkgQ4za5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9942"; a="192589183"
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="192589183"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 08:27:18 -0700
IronPort-SDR: k+Nv7Te4Mnz2pyI3wiaM6EnmatjwAdgiZYSNXGvEdWULkMTnLjmIKCnNZnbskPFP9cirW94dsY
 vPTBIQL1Hf6Q==
X-IronPort-AV: E=Sophos;i="5.81,300,1610438400"; 
   d="scan'208";a="456464618"
Received: from danagy-mobl.amr.corp.intel.com (HELO [10.209.45.147]) ([10.209.45.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 08:27:18 -0700
Subject: Re: [RFC v1 00/26] Add TDX Guest Support
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <95e97456-478b-c6a2-f851-3b19ce794262@intel.com>
 <20210402024852.GK1285835@tassilo.jf.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <9bfa74a5-6a56-a2e0-7432-d35766099d54@intel.com>
Date:   Fri, 2 Apr 2021 08:27:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210402024852.GK1285835@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/21 7:48 PM, Andi Kleen wrote:
>> I've heard things like "we need to harden the drivers" or "we need to do
>> audits" and that drivers might be "whitelisted".
> 
> The basic driver allow listing patches are already in the repository,
> but not currently posted or complete:
> 
> https://github.com/intel/tdx/commits/guest

That lists exactly 8 ids:

> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1000 }, /* Virtio NET */
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1001 }, /* Virtio block */
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1003 }, /* Virtio console */
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1009 }, /* Virtio FS */
> 
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1041 }, /* Virtio 1.0 NET */
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1042 }, /* Virtio 1.0 block */
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1043 }, /* Virtio 1.0 console */
> 	{ PCI_VENDOR_ID_REDHAT_QUMRANET, 0x1049 }, /* Virtio 1.0 FS */

How many places do those 8 drivers touch MMIO?

>> Are there any "real" hardware drivers
>> involved like how QEMU emulates an e1000 or rtl8139 device?  
> 
> Not currently (but some later hypervisor might rely on one of those)
> 
>> What about
>> the APIC or HPET?
> 
> No IO-APIC, but the local APIC. No HPET.

Sean seemed worried about other x86-specific oddities.  Are there any
more, or is the local APIC the only non-driver MMIO?

>> Without something concrete, it's really hard to figure out if we should
>> go full-blown paravirtualized MMIO, or do something like the #VE
>> trapping that's in this series currently.
> 
> As Sean says the concern about MMIO is less drivers (which should
> be generally ok if they work on other architectures which require MMIO
> magic), but other odd code that only ran on x86 before.
> 
> I really don't understand your crusade against #VE. It really
> isn't that bad if we can avoid the few corner cases.

The problem isn't with #VE per se.  It's with posting a series that
masquerades as a full solution while *NOT* covering or even enumerating
the corner cases.  That's exactly what happened with #VE to start with:
it was implemented in a way that exposed the kernel to #VE during the
syscall gap (and the SWAPGS gap for that matter).

So, I'm pushing for a design that won't have corner cases.  If MMIO
itself is disallowed, then we can scream about *any* detected MMIO.
Then, there's no worry about #VE nesting.  No #VE, no #VE nesting.  We
don't even have to consider if #VE needs NMI-like semantics.

> For me it would seem wrong to force all MMIO for all drivers to some
> complicated paravirt construct, blowing up code side everywhere
> and adding complicated self modifying code, when it's only needed for very
> few drivers. But we also don't want to patch every MMIO to be special cased
> even those few drivers.
> 
> #VE based MMIO avoids all that cleanly while being nicely non intrusive.

But, we're not selling used cars here.  Using #VE is has downsides.
Let's not pretend that it doesn't.

If we go this route, what are the rules and restrictions?  Do we have to
say "no MMIO in #VE"?

I'm really the most worried about the console.  Consoles and NMIs have
been a nightmare, IIRC.  Doesn't this just make it *WORSE* because now
the deepest reaches of the console driver are guaranteed to #VE?

Which brings up another related point: How do you debug TD guests?  Does
earlyprintk work?
