Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8339741AF7C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbhI1M5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:57:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:34584 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240848AbhI1M5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:57:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="222796674"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="222796674"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 05:56:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; 
   d="scan'208";a="553982639"
Received: from oogunmoy-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.221.219])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2021 05:56:03 -0700
Subject: Re: [PATCH v6 04/11] x86/tdx: Add protected guest support for TDX
 guest
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210903172812.1097643-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YVMAgFpGvKgBfx0P@8bytes.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <20fc6806-0c46-15d6-930b-6b4e90dfee6d@linux.intel.com>
Date:   Tue, 28 Sep 2021 05:56:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVMAgFpGvKgBfx0P@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/21 4:46 AM, Joerg Roedel wrote:
> On Fri, Sep 03, 2021 at 10:28:05AM -0700, Kuppuswamy Sathyanarayanan wrote:
>>   static inline bool prot_guest_has(unsigned int attr)
>>   {
>>   	if (sme_me_mask)
>>   		return amd_prot_guest_has(attr);
>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
>> +		return intel_prot_guest_has(attr);
> 
> This causes a function call on every Intel machine this code runs. is
> there an easier to check whether TDX is enabled, like the sme_me_mask
> check on AMD?

This will only be called when CONFIG_ARCH_HAS_CC_PLATFORM is set by a platform.
So it won't be called for all platforms.

Also, intel_prot_guest_has() is a generic Intel platform branch call (so we can't
directly check for TDX here).

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
