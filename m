Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CD9379D20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhEKCpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:45:43 -0400
Received: from mga14.intel.com ([192.55.52.115]:39611 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhEKCpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:45:25 -0400
IronPort-SDR: aGfO+/81u1FmYvxH8txcdnSht81fN4H+99fGYVE/BIbdiatiZ6zviconv67Tfdfa44aIK2K5oa
 yqe+zprFcKqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="199015690"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="199015690"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:44:19 -0700
IronPort-SDR: ccLpTow3uD/S2YlR38pTizc386Ox0kDEBSAnlJaDbtI5EF+RzP7ZpXmQ2dWCcEN91Pvt/rkHa3
 eaf3FqUNRMOQ==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="609324386"
Received: from kcmorris-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.165.53])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:44:18 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
 <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <04c3922a-36e2-bf07-e5fd-0d2eebda250b@linux.intel.com>
Date:   Mon, 10 May 2021 19:44:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/21 7:17 PM, Andi Kleen wrote:
>>> To prevent TD guest from using MWAIT/MONITOR instructions,
>>> support for these instructions are already disabled by TDX
>>> module (SEAM). So CPUID flags for these instructions should
>>> be in disabled state.
>> Why does this not result in a #UD if the instruction is disabled by
>> SEAM?
> 
> It's just the TDX module (SEAM is the execution mode used by the TDX module)

If it is disabled by the TDX Module, we should never execute it. But for some
reason, if we still come across this instruction (buggy TDX module?), we add
appropriate warning in  #VE handler.

> 
> 
>> How is it possible to execute a disabled instruction (one
>> precluded by CPUID) to the point where it triggers #VE instead of #UD?
> 
> That's how the TDX module works. It never injects anything else other than #VE. You can still get 
> other exceptions of course, but they won't come from the TDX module.
> 
>>> After the above mentioned preventive measures, if TD guests still
>>> execute these instructions, add appropriate warning messages in #VE
>>> handler. For WBIND instruction, since it's related to memory writeback
>>> and cache flushes, it's mainly used in context of IO devices. Since
>>> TDX 1.0 does not support non-virtual I/O devices, skipping it should
>>> not cause any fatal issues.
>> WBINVD is in a different class than MWAIT/MONITOR since it is not
>> identified by CPUID, it can't possibly have the same #UD behaviour.
>> It's not clear why WBINVD is included in the same patch as
>> MWAIT/MONITOR?
> 
> Because these are all instructions we never expect to execute, so nothing special is needed for 
> them. That's a unique class that logically fits together.

Yes, for all these three instruction we don't need any special
handling code. So they are grouped together.

> 
> 
>>
>> I disagree with the assertion that WBINVD is mainly used in the
>> context of I/O devices, it's also used for ACPI power management
>> paths.
> 
> You mean S3? That's of course also not supported inside TDX.
> 
> 
>>   WBINVD dependent functionality should be dynamically disabled
>> rather than warned about.
>>
>> Does a TDX guest support out-of-tree modules?  The kernel is already
>> tainted when out-of-tree modules are loaded. In other words in-tree
>> modules preclude forbidden instructions because they can just be
>> audited, and out-of-tree modules are ok to trigger abrupt failure if
>> they attempt to use forbidden instructions.
> 
> We already did a lot of bi^wdiscussion on this on the last review.
> 
> Originally we had a different handling, this was the result of previous feedback.
> 
> It doesn't really matter because it should never happen.
> 
> 
>>
>>> But to let users know about its usage, use
>>> WARN() to report about it.. For MWAIT/MONITOR instruction, since its
>>> unsupported use WARN() to report unsupported usage.
>> I'm not sure how useful warning is outside of a kernel developer's
>> debug environment. The kernel should know what instructions are
>> disabled and which are available. WBINVD in particular has potential
>> data integrity implications. Code that might lead to a WBINVD usage
>> should be disabled, not run all the way up to where WBINVD is
>> attempted and then trigger an after-the-fact WARN_ONCE().
> 
> We don't expect the warning to ever happen. Yes all of this will be disabled. Nearly all are in code 
> paths that cannot happen inside TDX anyways due to missing PCI-IDs or different cpuids, and S3 is 
> explicitly disabled and would be impossible anyways due to lack of BIOS support.

We have added WARN to let user know about its usage and fix it. By default we should
never hit this path.

> 
> 
> 
> 
>>
>> The WBINVD change deserves to be split off from MWAIT/MONITOR, and
>> more thought needs to be put into where these spurious instruction
>> usages are arising.
> 
> I disagree. We already spent a lot of cycles on this. WBINVD makes never sense in current TDX and 
> all the code will be disabled.

> 
> 
> -Andi
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
