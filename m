Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D503A0BB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 06:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhFIE40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 00:56:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:55376 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhFIE4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 00:56:24 -0400
IronPort-SDR: gBMjJfB3w7HqRntFRuekXA9EAYm8c3CXr9Z4EqcqqOAhtBg8PsdwbeR+d+XYACEkCht+H42/3P
 luT0FBjSYjVA==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="268858160"
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="268858160"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:54:30 -0700
IronPort-SDR: yp6UxF6aTXDSGVA4DPfi/owkf5vf9OHVqY0BKZnY7xrkn53TRi3Z4NH2wuigV9P47xY6yJ4s8J
 f5maYtJ7LDxA==
X-IronPort-AV: E=Sophos;i="5.83,260,1616482800"; 
   d="scan'208";a="402317455"
Received: from dabarred-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.185.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 21:54:29 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAPcyv4iAgXnMmg+Z1cqrgeQUcuQgXZ1WCtAaNmeHuLT_5QArUw@mail.gmail.com>
 <20210609011030.751451-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4gLeKPfYOx1kmg-mO1_mNd+XGqVO-CbqX+2d52GZ+DSFw@mail.gmail.com>
 <23418f34-7c03-7477-6fbf-1b36b4718cb9@kernel.org>
 <4e5ac34f-28cb-def6-0b87-e560fa42e5e5@linux.intel.com>
 <e9b2aab2-4a6f-4739-a939-c448414e6af2@www.fastmail.com>
 <390d6712-35b5-e52a-fb32-205844bad4ef@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b1eb467e-1cb4-0e5e-c3e0-d99044f83ab6@linux.intel.com>
Date:   Tue, 8 Jun 2021 21:54:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <390d6712-35b5-e52a-fb32-205844bad4ef@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 9:40 PM, Andi Kleen wrote:
> 
>>> KVM only turns it into a noop if there is no VT-d, because with VT-d you
>>> might need it to turn mappings into uncached and vice versa.
>> Wow, I found the kvm_arch_register_noncoherent_dma() stuff.  That's horrifying.  What's it for?  e
> 
> e.g. if you want to run a GPU it really needs some uncached memory. Same is true for other more 
> complex devices.
> 
> Now modern Linux of course will be preferring CLFLUSH instead for the conversion, but there are old 
> versions that preferred WBINVD.
> 
> I don't think it's a DoS, as long as you're not too picky about latencies on the host.
> 
> -Andi
> 

Currently we use prot_guest_has(PR_GUEST_DISABLE_WBINVD)) check for disabling the wbinvd()
usage (which can be selectively enabled for tested guests).

Is it alright to generalize it with boot_cpu_has(X86_FEATURE_HYPERVISOR) without
verify it?

> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
