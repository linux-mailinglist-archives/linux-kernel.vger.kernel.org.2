Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C79B4226A6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 14:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234744AbhJEMby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 08:31:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:34488 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234825AbhJEMbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 08:31:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="226037352"
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="226037352"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:29:50 -0700
X-IronPort-AV: E=Sophos;i="5.85,348,1624345200"; 
   d="scan'208";a="559304412"
Received: from slwegrzy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.129.144])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 05:29:48 -0700
Subject: Re: [PATCH v8 04/11] x86/tdx: Add Intel ARCH support to
 cc_platform_has()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <50eaabfc-50b2-7617-ed9f-61f61b619cd8@infradead.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <0350a300-dced-c10e-a4ce-53fb50a7a11a@linux.intel.com>
Date:   Tue, 5 Oct 2021 05:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <50eaabfc-50b2-7617-ed9f-61f61b619cd8@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/21 9:47 PM, Randy Dunlap wrote:
> On 10/4/21 7:51 PM, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index c42dd8a2d1f4..abb249dc829d 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -871,6 +871,7 @@ config INTEL_TDX_GUEST
>>       depends on SECURITY
>>       select X86_X2APIC
>>       select SECURITY_LOCKDOWN_LSM
>> +    select ARCH_HAS_CC_PLATFORM
> 
> Where is ARCH_HAS_CC_PLATFORM defined, please?
> I can't seem to find it.

It is merged to tip tree.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=46b49b12f3fc5e1347dba37d4639e2165f447871

> 
>>       help
>>         Provide support for running in a trusted domain on Intel processors
>>         equipped with Trusted Domain eXtensions. TDX is a Intel technology
> 
> 
> thanks.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
