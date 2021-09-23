Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848834160C6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241603AbhIWOLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:11:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:23604 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241556AbhIWOLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:11:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="309407829"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="309407829"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 07:10:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="551013747"
Received: from tbirrer-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.101.82])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 07:10:04 -0700
Subject: Re: [PATCH v7 04/12] x86/cpufeatures: Add TDX Guest CPU feature
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
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
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210916183550.15349-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YUxQzRdoH3dLJjL2@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5a04034b-e692-6b45-bdde-f1a0fff96f7b@linux.intel.com>
Date:   Thu, 23 Sep 2021 07:10:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUxQzRdoH3dLJjL2@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 3:02 AM, Borislav Petkov wrote:
> On Thu, Sep 16, 2021 at 11:35:42AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> @@ -495,6 +496,8 @@ asmlinkage __visible void __init x86_64_start_kernel(char * real_mode_data)
>>   
>>   	copy_bootdata(__va(real_mode_data));
>>   
>> +	tdx_early_init();
>> +
> 
> | Changes since v4:
> |  * Moved tdx_early_init() below copy_bootdata() because of
> |    cmdline and IDT dependencies.
> 
> 
> What "cmdline and IDT dependencies"?
> 
> Without a comment explaining why that thing must be there in the boot
> order, you're adding more to the already fragile house of cards.
> 
> Explain please.

Initially, tdx_early_init() was added between kasan_early_init() and
idt_setup_early_handler() in x86_64_start_kernel(). But I found that
we have requirement to parse command line params in future
changes to tdx_early_init() (not from the patches in this series). Since
command line pointer is getting initialized in copy_bootdata(), I want
move the tdx_early_init() call below it. Instead of moving the initialization
order in future, I thought to move it appropriate place in the initial
patch. Regarding IDT dependency, #VE handling will have a dependency on
it (so it is better to initialize it before tdx_early_init()).

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
