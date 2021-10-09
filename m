Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5852B427D75
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhJIU6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 16:58:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:9691 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230003AbhJIU6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 16:58:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="287568430"
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="287568430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 13:56:15 -0700
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="440285384"
Received: from lmtorre1-mobl-2020.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.84.14])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 13:56:14 -0700
Subject: Re: [PATCH v10 00/11] Add TDX Guest Support (Initial support)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211009053747.1694419-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YWFG7+QqVGZ5ZdG9@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6584b4d5-b7a1-2dbb-1a27-10f9c7949be9@linux.intel.com>
Date:   Sat, 9 Oct 2021 13:56:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWFG7+QqVGZ5ZdG9@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/21 12:38 AM, Borislav Petkov wrote:
> On Fri, Oct 08, 2021 at 10:37:36PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> Hi All,
> 
> Now let's see: you sent this particular patchset on Monday, 4th. The
> usual process is that you wait at least a week for review comments,
> incorporate them into your next revision and then you send it. We were
> still reviewing v8...

Sorry for the quick re-submissions. But the main reason for sending v9
within a week is,

1. Following compilation error found in v8.

This fails to build:

arch/x86/kernel/tdx.c: In function ‘tdx_write_msr_safe’:
arch/x86/kernel/tdx.c:135:22: error: implicit declaration of function ‘tdx_is_context_switched_msr’ 
[-Werror=implicit-function-declaration]
135 | WARN_ON_ONCE(tdx_is_context_switched_msr(msr));
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/asm-generic/bug.h:104:32: note: in definition of macro ‘WARN_ON_ONCE’
104 | int __ret_warn_on = !!(condition);


2. I had to rebase my patches on your tip tree again to adapt to the latest
version of CC patches.
3. Also to address your comment about using is_tdx_guest() in
cc_platform_has()

I thought the above issues warranted a re-submission. I know that it is a mistake
from my end. But I did not want you to review code changes that might go away
due to rebase.


> 
> But I see already a v9 in my mbox from yesterday and *also* a v10. v9
> you probably didn't build-test enough so you had to hastily do a v10. 4
> days later!

I have sent v10 within few hours of v9 submission to fix a static inline issue.

I did not catch it my compilation test because, it happens only with a
TDX disabled config.

Sorry for the trouble again. Please ignore the v9 version. I will try not to repeat
this  in future.

> 
> And because that's not enough, there are a bunch of other TDX patchsets
> from you flying in constantly.
> 
> Now, please explain to me how you imagine this whole review thing is
> supposed to work?
> 
> You hammer people with patchsets until they go in? Forget proper review?
> 
> Or people should drop the other things they have to do for their jobs
> and deal only with your patchsets?
> 
> How about we trade places: you review and try to get sh*t to work and I
> hammer you with patchsets every 3-4 days?
> 
> For chrissakes, please calm down with that constant hammering and try to
> put yourself in the maintainer's shoes for once. Also, try to realize
> that hammering people with patchsets will get you the *opposite* of what
> you're trying to achieve - you will get ignored.
> 
> Geez.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
