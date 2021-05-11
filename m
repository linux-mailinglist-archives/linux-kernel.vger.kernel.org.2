Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141BF379CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhEKCS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 22:18:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:22295 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhEKCSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 22:18:55 -0400
IronPort-SDR: qIayvEk7c+FDP87tDcgGYEw/b0lweMrr6P27XIAMIKEY+XxnEb6AL89Uew3x/wIXbW+6hQFu0u
 X+lHi+RIsrOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263266245"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="263266245"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:17:50 -0700
IronPort-SDR: 74Iox4+owTMOh6QJP713UCXNVvNhqGa/MnU8MGdf2Y5uskxwdsJRBBsN9eFhAQc75gEpHgHyKE
 uFusT8xxhomQ==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="434075293"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.32.217]) ([10.209.32.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 19:17:49 -0700
Subject: Re: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
To:     Dan Williams <dan.j.williams@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <0e577692-101e-38f7-ebe2-2e7222016a9f@linux.intel.com>
Date:   Mon, 10 May 2021 19:17:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jGmhkrd+Zr4RNcZ5qfXkYO-416Bw2_idVbrgij41yvYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> To prevent TD guest from using MWAIT/MONITOR instructions,
>> support for these instructions are already disabled by TDX
>> module (SEAM). So CPUID flags for these instructions should
>> be in disabled state.
> Why does this not result in a #UD if the instruction is disabled by
> SEAM?

It's just the TDX module (SEAM is the execution mode used by the TDX module)


> How is it possible to execute a disabled instruction (one
> precluded by CPUID) to the point where it triggers #VE instead of #UD?

That's how the TDX module works. It never injects anything else other 
than #VE. You can still get other exceptions of course, but they won't 
come from the TDX module.

>> After the above mentioned preventive measures, if TD guests still
>> execute these instructions, add appropriate warning messages in #VE
>> handler. For WBIND instruction, since it's related to memory writeback
>> and cache flushes, it's mainly used in context of IO devices. Since
>> TDX 1.0 does not support non-virtual I/O devices, skipping it should
>> not cause any fatal issues.
> WBINVD is in a different class than MWAIT/MONITOR since it is not
> identified by CPUID, it can't possibly have the same #UD behaviour.
> It's not clear why WBINVD is included in the same patch as
> MWAIT/MONITOR?

Because these are all instructions we never expect to execute, so 
nothing special is needed for them. That's a unique class that logically 
fits together.


>
> I disagree with the assertion that WBINVD is mainly used in the
> context of I/O devices, it's also used for ACPI power management
> paths.

You mean S3? That's of course also not supported inside TDX.


>   WBINVD dependent functionality should be dynamically disabled
> rather than warned about.
>
> Does a TDX guest support out-of-tree modules?  The kernel is already
> tainted when out-of-tree modules are loaded. In other words in-tree
> modules preclude forbidden instructions because they can just be
> audited, and out-of-tree modules are ok to trigger abrupt failure if
> they attempt to use forbidden instructions.

We already did a lot of bi^wdiscussion on this on the last review.

Originally we had a different handling, this was the result of previous 
feedback.

It doesn't really matter because it should never happen.


>
>> But to let users know about its usage, use
>> WARN() to report about it.. For MWAIT/MONITOR instruction, since its
>> unsupported use WARN() to report unsupported usage.
> I'm not sure how useful warning is outside of a kernel developer's
> debug environment. The kernel should know what instructions are
> disabled and which are available. WBINVD in particular has potential
> data integrity implications. Code that might lead to a WBINVD usage
> should be disabled, not run all the way up to where WBINVD is
> attempted and then trigger an after-the-fact WARN_ONCE().

We don't expect the warning to ever happen. Yes all of this will be 
disabled. Nearly all are in code paths that cannot happen inside TDX 
anyways due to missing PCI-IDs or different cpuids, and S3 is explicitly 
disabled and would be impossible anyways due to lack of BIOS support.




>
> The WBINVD change deserves to be split off from MWAIT/MONITOR, and
> more thought needs to be put into where these spurious instruction
> usages are arising.

I disagree. We already spent a lot of cycles on this. WBINVD makes never 
sense in current TDX and all the code will be disabled.


-Andi

