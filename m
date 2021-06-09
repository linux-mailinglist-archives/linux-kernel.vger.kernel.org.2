Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2C3A1BC4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFIRaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:30:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:28063 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhFIRaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:30:14 -0400
IronPort-SDR: iX8pSg86aPuGvfg89vW4U7a1r+J9G0Jym9Y6q3amMU/gVRh7h5zRQ0ghcwayPmngZWRuYScC93
 ei1qmNtBqcsA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="184812035"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="184812035"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:28:18 -0700
IronPort-SDR: u8sSWI2koZL75xdfN/Jh7FIYJLdh/eT6OLrO65DKm19TP6+x3fbu87ixuIQ7BH3g4q6ZCJtWtv
 MlKvvwo9yBRw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="402513924"
Received: from davidhok-mobl3.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.9.9])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 10:28:16 -0700
Subject: Re: [RFC v2-fix-v4 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <682f0239-8da0-3702-0f14-99b6244af499@linux.intel.com>
 <CAPcyv4jfFPGm2-cvPExeujZnaSKKky3AQRp69tzG1gcZ09dj8A@mail.gmail.com>
 <ffedf1d2-e5ec-e0e3-8e83-edd186231029@linux.intel.com>
 <CAPcyv4haWYhqk_xLD56QnB0ahK+fynOmqGdSD907UW-=7B176g@mail.gmail.com>
 <c2f4254d-3d28-544a-efd2-e65dd40d99f1@kernel.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <59484871-8ef1-b7c3-fb29-b143bd53f074@linux.intel.com>
Date:   Wed, 9 Jun 2021 10:28:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <c2f4254d-3d28-544a-efd2-e65dd40d99f1@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/21 9:12 AM, Andy Lutomirski wrote:
> On 6/9/21 8:09 AM, Dan Williams wrote:
>> On Tue, Jun 8, 2021 at 9:27 PM Andi Kleen <ak@linux.intel.com> wrote:
>>>
>>>
>>> here is no resume path.
>>>
>>>> Host is free to go into S3 independent of any guest state.
>>>
>>> Actually my understanding is that none of the systems which support TDX
>>> support S3. S3 has been deprecated for a long time.
>>
>> Ok, I wanted to imply any power state that might power-off caches.
>>
>>>
>>>
>>>>    A hostile
>>>> host is free to do just enough cache management so that it can resume
>>>> from S3 while arranging for TDX guest dirty data to be lost. Does a
>>>> TDX guest go fatal if the cache loses power?
>>>
>>> That would be a machine check, and yes it would be fatal.
>>
>> Sounds good, so incorporating this and Andy's feedback:
>>
>> "TDX guests, like other typical guests, use standard ACPI mechanisms
>> to signal sleep state entry (including reboot) to the host. The ACPI
>> specification mandates WBINVD on any sleep state entry with the
>> expectation that the platform is only responsible for maintaining the
>> state of memory over sleep states, not preserving dirty data in any
>> CPU caches. ACPI cache flushing requirements pre-date the advent of
>> virtualization. Given guest sleep state entry does not affect any host
>> power rails it is not required to flush caches. The host is
>> responsible for maintaining cache state over its own bare metal sleep
>> state transitions that power-off the cache. A TDX guest, unlike a
>> typical guest, will machine check if the CPU cache is powered off."
>>
>> Andi, is that machine check behavior relative to power states
>> mentioned in the docs?
> 
> I don't think there's anything about power states.  There is a general
> documented mechanism to integrity-check TD guest memory, but it is *not*
> replay-resistant.  So, if the guest dirties a cache line, and the cache
> line is lost, it seems entirely plausible that the guest would get
> silently corrupted.
> 
> I would argue that, if this happens, it's a host, TD module, or
> architecture bug, and it's not the guest's fault.

If you want to apply this fix for all hypervisors (using boot_cpu_has
(X86_FEATURE_HYPERVISOR) check), then we don't need any TDX specific
reference in commit log right? It can be generalized for all VM guests.

agree?

> 
> --Andy
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
