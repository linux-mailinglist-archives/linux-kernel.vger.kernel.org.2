Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFC8388163
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbhERU33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:29:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:39384 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241944AbhERU3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:29:25 -0400
IronPort-SDR: 2B8EfOEbOEi9x5W4OBhG6i3OoC2odTbLqa1uKdjOms0oZaPLS1iEHhrTYzt7Yh6KHntHRxW7RJ
 +UbfkjOKC4BA==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="221872848"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="221872848"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:28:05 -0700
IronPort-SDR: GEYpBpjKL4O7gln/JhicziBFxTX5Un5g6AQOwLhN1OXdnYNmdvsHu5XhRsj3dozAOWpBNzhf3y
 vsYq0fQR84Lw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439620689"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.65.183]) ([10.209.65.183])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:28:05 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
To:     Sean Christopherson <seanjc@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
 <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <36cd2665-6d8b-9c0b-eec1-25152dcca2a3@intel.com>
 <43e583a3-ee2b-52d8-5275-e26a6609c126@linux.intel.com>
 <YKP1Xty7EEzHkZ6Y@google.com>
 <8fb0e52c-ed0a-2185-585a-27007c27ed56@linux.intel.com>
 <YKQF08wqTsCQ3qHL@google.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3a037a43-435b-fc28-63d0-48e543cddfdd@linux.intel.com>
Date:   Tue, 18 May 2021 13:28:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YKQF08wqTsCQ3qHL@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/18/2021 11:22 AM, Sean Christopherson wrote:
> On Tue, May 18, 2021, Andi Kleen wrote:
>>> The extra bytes for .altinstructions is very different than the extra bytes for
>>> the code itself.  The .altinstructions section is freed after init, so yes it
>>> bloats the kernel size a bit, but the runtime footprint is unaffected by the
>>> patching metadata.
>>>
>>> IIRC, patching read/write{b,w,l,q}() can be done with 3 bytes of .text overhead.
>>>
>>> The other option to explore is to hook/patch IO_COND(), which can be done with
>>> neglible overhead because the helpers that use IO_COND() are not inlined.  In a
>>> TDX guest, redirecting IO_COND() to a paravirt helper would likely cover the
>>> majority of IO/MMIO since virtio-pci exclusively uses the IO_COND() wrappers.
>>> And if there are TDX VMMs that want to deploy virtio-mmio, hooking
>>> drivers/virtio/virtio_mmio.c directly would be a viable option.
>> Yes but what's the point of all that?
> Patching IO_COND() is relatively low effort.  With some clever refactoring, I
> suspect the net lines of code added would be less than 10.  That seems like a
> worthwhile effort to avoid millions of faults over the lifetime of the guest.

AFAIK IO_COND is only for iomap users. But most drivers don't even use 
iomap. virtio doesn't for example, and that's really the only case we 
currently care about.

Also millions of faults is nothing for a CPU.

The only case I can see it making sense is the virtio (and vmbus) door 
bells. Everything else should be slow path anyways.

But doing that now would be premature optimization and that's usually a 
bad idea. If it's a problem we can fix it later.


>
>> Even if it's only 3 bytes we still have a lot of MMIO all over the kernel
>> which never needs it.
>>
>> And I don't even see what TDX (or SEV which already does the decoding and
>> has been merged) would get out of it. We handle all the #VEs just fine. And
>> the instruction handling code is fairly straight forward too.
>>
>> Besides instruction decoding works fine for all the existing hypervisors.
>> All we really want to do is to do the same thing as KVM would do.
> Heh, trust me, you don't want to do the same thing KVM does :-)

We want the same behavior.

Yes probably not the same code.


-Andi


