Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536433FF020
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345735AbhIBP0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 11:26:07 -0400
Received: from mga04.intel.com ([192.55.52.120]:46851 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhIBP0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="217290489"
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="217290489"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 08:25:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,262,1624345200"; 
   d="scan'208";a="533335602"
Received: from yzhai-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.161.204])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 08:25:04 -0700
Subject: Re: [PATCH v5 07/12] x86/traps: Add #VE support for TDX guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-8-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSTHMAUA1LjjOQPe@zn.tnic>
 <99c5f6e9-a747-1a4a-d0f4-95b8b28e0d02@linux.intel.com>
 <YSUwi2HraMFVanTP@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <42201ef7-6552-3fbc-23ef-013cb3e93649@linux.intel.com>
Date:   Thu, 2 Sep 2021 08:24:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSUwi2HraMFVanTP@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 10:46 AM, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 10:32:13AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> Mainly chose it avoid future name conflicts with KVM (tdx) calls. But
> 
> What name conflicts with KVM calls? Please explain.

Currently there are no name conflicts. But in our initial submissions (RFC v?)
we had some conflicts in functions like (tdx_get_tdreport() and
tdx_get_quote()).

Since it is no longer true and "tdg" is not a favorite prefix, I will
rename tdg -> tdx in next submission.

> 
>> It is required to handle #VE exceptions raised by unhandled MSR
>> read/writes.
> 
> Example? Please elaborate.

If MSR read/write failed in tdx_handle_virtualization_exception(), it will
return non zero return value which in turn will trigger ve_raise_fault().

If we don't call fixup_exception() for such case, it will trigger oops
and eventually panic in TDX. For MSR read/write failures we don't want
to panic.

#VE MSR read/write
  -> exc_virtualization_exception()
     -> tdx_handle_virtualization_exception()
        ->tdx_write_msr_safe()
     -> ve_raise_fault
        -> fixup_exception()

> 
>> Ok. I can check it. But there is only one statement after this call.
>> So it may not be very helpful.
> 
> Looking at die_addr(), that calls the die notifier too. So do you
> even *have* to call it here with VEFSTR? As yo say, there's only one
> statement after that call and box is dead in the water after that so why
> even bother...

Reason for calling die_addr() is to trigger oops for failed #VE handling, which
is desirable for TDX. Also sending die notification may be useful for debuggers.

This sequence of calls are similar to exc_general_protection().

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
