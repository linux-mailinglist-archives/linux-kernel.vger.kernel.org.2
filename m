Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF6390DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 03:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhEZBK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 21:10:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:56085 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232667AbhEZBKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 21:10:54 -0400
IronPort-SDR: gjszMN445M2fAcN47O93NWpSBB24MKOjn3higP87zRWGUWt9zNE6kXhVV++3HRD7O5maBoc+kp
 eCfiF9ZFWWXQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9995"; a="266244528"
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="266244528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 18:09:23 -0700
IronPort-SDR: oPNdmylFX/LiEGmJITXHiwohwZQ7lw+a0k7+iy+RhafimeY4OU3ka/Iufjc0FtKcG5T9aVPiCC
 UYhXJAuTF1Bg==
X-IronPort-AV: E=Sophos;i="5.82,330,1613462400"; 
   d="scan'208";a="546919036"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.20.22]) ([10.209.20.22])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 18:09:22 -0700
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
 <6f44fbeb-a8be-d2e4-5161-d46ddf09482e@linux.intel.com>
 <CAPcyv4iLNkWpopY6gN9bXtTxnM3qm0YatwV4jc-zVn-VEYpprw@mail.gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <fe11bf3c-c0f8-7c25-8fc0-99bee9c1d164@linux.intel.com>
Date:   Tue, 25 May 2021 18:09:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iLNkWpopY6gN9bXtTxnM3qm0YatwV4jc-zVn-VEYpprw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/24/2021 8:40 PM, Dan Williams wrote:
> On Mon, May 24, 2021 at 8:27 PM Andi Kleen <ak@linux.intel.com> wrote:
>>
>> On 5/24/2021 7:49 PM, Dan Williams wrote:
>>> On Mon, May 24, 2021 at 7:13 PM Andi Kleen <ak@linux.intel.com> wrote:
>>> [..]
>>>>> ...to explicitly error out a wbinvd use case before data is altered
>>>>> and wbinvd is needed.
>>>> I don't see any point of all of this. We really just want to be the same
>>>> as KVM. Not get into the business of patching a bazillion sub systems
>>>> that cannot be used in TDX anyways.
>>> Please let's not start this patch off with dubious claims of safety
>>> afforded by IgnorePAT. Instead make the true argument that wbinvd is
>>> known to be problematic in guests
>> That's just another reason to not support WBINVD, but I don't think it's
>> the main reason. The main reason is that it is simply not needed, unless
>> you do DMA in some form.
>>
>> (and yes I consider direct mapping of persistent memory with a complex
>> setup procedure a form of DMA -- my guess is that the reason that it
>> works in KVM is that it somehow activates the DMA code paths in KVM)
> No, it doesn't. Simply no one has tried to pass through the security
> interface of bare metal nvdimm to a guest, or enabled the security
> commands in a virtualized nvdimm.

Maybe a better term would be "external side effects". If you have 
something in IO domain which can notice a difference.

> If a guest supports a memory map it supports PMEM I struggle to see DMA anywhere in that equation.

Okay if that's happen to a TDX guest we have to start emulate WBINVD. 
But right now we don't need it.

I guess we can add a comment that says

"if someone wants to implement NVDIMM secure delete they would also need 
to implement this new hypercall"

>
>> IMNSHO that's the true reason.
> I do see why it would be attractive if IgnorePAT was a solid signal to
> ditch wbinvd support. However, it simply isn't, and to date nothing
> has cared trip over that gap.


I think we're getting into angels on a pinhead here.

The key point is that current TDX does not need WBINVD. I believe we 
agree on that.


-Andi


