Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B17838F8C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 05:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbhEYD2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 23:28:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:38160 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhEYD2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 23:28:37 -0400
IronPort-SDR: 1bIe6Ap6B8NHIRkgg5Gfq4X4+4lg+tuu3bfBduDkS8MQC2A/4O4Mg3A0oCqltAUOKf+Sb7BWvz
 negNEd71rq/A==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181729283"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="181729283"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 20:27:07 -0700
IronPort-SDR: bDO7nvJWaEgi8pYE1m5vIndBvhH6MzW+uxUJdfWYznKKDGjNtd8GoHgoctlM048DHrleVCOXeI
 yaJoHL+Ys7OA==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="546330008"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.195.214]) ([10.212.195.214])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 20:27:06 -0700
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
 <125f8362-b1e3-d304-f943-3fc2f07b5d79@linux.intel.com>
 <CAPcyv4gRDnm0y4=RWhvTSoY2sk=BOyeDDNcCifZD=opyJf05LQ@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <6f44fbeb-a8be-d2e4-5161-d46ddf09482e@linux.intel.com>
Date:   Mon, 24 May 2021 20:27:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gRDnm0y4=RWhvTSoY2sk=BOyeDDNcCifZD=opyJf05LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/2021 7:49 PM, Dan Williams wrote:
> On Mon, May 24, 2021 at 7:13 PM Andi Kleen <ak@linux.intel.com> wrote:
> [..]
>>> ...to explicitly error out a wbinvd use case before data is altered
>>> and wbinvd is needed.
>> I don't see any point of all of this. We really just want to be the same
>> as KVM. Not get into the business of patching a bazillion sub systems
>> that cannot be used in TDX anyways.
> Please let's not start this patch off with dubious claims of safety
> afforded by IgnorePAT. Instead make the true argument that wbinvd is
> known to be problematic in guests

That's just another reason to not support WBINVD, but I don't think it's 
the main reason. The main reason is that it is simply not needed, unless 
you do DMA in some form.

(and yes I consider direct mapping of persistent memory with a complex 
setup procedure a form of DMA -- my guess is that the reason that it 
works in KVM is that it somehow activates the DMA code paths in KVM)

IMNSHO that's the true reason.

> and for that reason many bare metal
> use cases that require wbinvd have not been ported to guests (like
> PMEM unlock), and others that only use wbinvd to opportunistically
> enforce a cache state (like ACPI sleep states)

ACPI sleep states are not supported or needed in virtualization. They 
are mostly obsolete on real hardware too.


> do not see ill effects
> from missing wbinvd. Given KVM ships with a policy to elide wbinvd in
> many scenarios adopt the same policy for TDX guests.
