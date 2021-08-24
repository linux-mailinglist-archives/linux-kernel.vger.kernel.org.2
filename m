Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74123F6998
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbhHXTMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:12:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:11632 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234266AbhHXTMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:12:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="239546962"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="239546962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 12:11:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; 
   d="scan'208";a="597687106"
Received: from ydevadig-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.137.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 12:11:03 -0700
Subject: Re: [PATCH v5 09/12] x86/tdx: Wire up KVM hypercalls
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
 <20210804181329.2899708-10-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YSUfpQPvL6wsk6Ou@zn.tnic>
 <8ccbf970-fd4f-b1ea-ac85-98acfe296b00@linux.intel.com>
 <YSU6eixLyNdESBe9@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <b4742f7b-b1d8-8431-407f-f15a78a0d3f0@linux.intel.com>
Date:   Tue, 24 Aug 2021 12:11:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YSU6eixLyNdESBe9@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/21 11:29 AM, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 11:11:43AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> Since TDX code can be used by other hypervisor (non KVM case) we
>> want to have a config to differentiate the KVM related calls.
> 
> You need to start explaining yourself better. WTH does "to differentiate
> the KVM related calls" even mean? Differentiate for what?!

tdx_kvm_hypercall() function and its usage in arch/x86/include/asm/kvm_para.h
is only required for KVM hypervisor.

  static inline long kvm_hypercall0(unsigned int nr)
  {
         long ret;
+
+       if (prot_guest_has(PATTR_GUEST_TDX))
+               return tdx_kvm_hypercall(nr, 0, 0, 0, 0);

If the TDX code is complied for another hypervior, we need some config to
disable above the above code. CONFIG_INTEL_TDX_GUEST_KVM is added
for this purpose. If you think there is no sufficient reason, I can
use defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST) to protect
the implementation of tdx_kvm_hypercall()


> 
> Our CONFIG space is a huuge mess. Adding another option better be
> properly justified.
> 
>> Compiler raised version generation issue for __tdx_hypercall
> 
> -ENOTENOUGHINFO.

Following is the error info.

WARNING: modpost: EXPORT symbol "__tdx_hypercall" [vmlinux] version generation failed, symbol will 
not be versioned.

So to fix the above issue, added tdx.h in arch/x86/include/asm/asm-prototypes.h

> 
> Try again.
> 
>> Yes. I will fix this in next version.
> 
> And here audit all your patchsets. All exports better be _GPL.

Ok. I will check it before my next submission.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
