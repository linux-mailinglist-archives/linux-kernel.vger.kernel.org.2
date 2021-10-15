Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327B442E628
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 03:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhJOBcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 21:32:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:47617 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232443AbhJOBcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 21:32:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="226601384"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="226601384"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:30:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="492269607"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123]) ([10.239.13.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 18:30:08 -0700
Subject: Re: [PATCH v7 6/6] x86/split_lock: Fix the split lock #AC handling
 when running as guest
To:     Sean Christopherson <seanjc@google.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuwamy@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005230550.1819406-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005230550.1819406-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWdB+rGPWDIVzuBY@google.com>
 <38a70cf2-1849-97fd-82a2-10ce64c6be8c@linux.intel.com>
 <71884ac9-6da3-e75d-af1e-f8f24a7562cb@intel.com>
 <YWhG+UcaRyNptzw9@google.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <1d3c97cd-d243-6a2c-9964-4d1d22691db0@intel.com>
Date:   Fri, 15 Oct 2021 09:30:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YWhG+UcaRyNptzw9@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2021 11:04 PM, Sean Christopherson wrote:
> On Thu, Oct 14, 2021, Xiaoyao Li wrote:
>> On 10/14/2021 5:32 AM, Sathyanarayanan Kuppuswamy wrote:
>>> + Xiaoyao
>>>
>>> On 10/13/21 1:30 PM, Sean Christopherson wrote:
>>>> On Tue, Oct 05, 2021, Kuppuswamy Sathyanarayanan wrote:
>>>>> From: Xiaoyao Li <xiaoyao.li@intel.com>
>>>>>
>>>>> If running as guest and hypervisor enables
>>>>> MSR_TEST_CTRL.SPLIT_LOCK_DETECT during its running, it can get split
>>>>> lock #AC even though sld_state is sld_off.
>>>> That's a hypervisor bug, no?  The hypervisor should never inject a fault
>>>> that the guest cannot reasonably expect.
>>
>> What if hypervisor doesn't intercept #AC and host enables SPLIT_LOCK_DETECT
>> during guest running? That's exactly the case TDX is facing.
> 
> That's a hypervisor bug.  Since it sounds like the TDX Module buries its head in
> the sand for split-lock #AC, KVM should refuse to run TDX guests if split-lock #AC
> is enabled.  Ideally the TDX Module would provide support for conditionally
> intercepting #AC, e.g. intercept and re-inject "normal" #AC, and exit to the VMM
> for split-lock #AC.  That would give VMMs the option of enabling split-lock
> detection in fatal mode for guests.
> 

We have bus lock VM exit for it.
