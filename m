Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD34160CF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 16:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241687AbhIWOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 10:12:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:12414 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241711AbhIWOMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 10:12:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="246307410"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="246307410"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 07:10:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="551014865"
Received: from tbirrer-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.101.82])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 07:10:42 -0700
Subject: Re: [PATCH v7 05/12] x86/tdx: Add TDX guest support to
 intel_cc_platform_has()
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
 <20210916183550.15349-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YUxYuDyKBjvnfn7T@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c19ef763-68c1-8188-c4e0-040e4392ba4d@linux.intel.com>
Date:   Thu, 23 Sep 2021 07:10:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUxYuDyKBjvnfn7T@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/23/21 3:36 AM, Borislav Petkov wrote:
> On Thu, Sep 16, 2021 at 11:35:43AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
>> index 253f3ea66cd8..e38430e6e396 100644
>> --- a/include/linux/cc_platform.h
>> +++ b/include/linux/cc_platform.h
>> @@ -61,6 +61,15 @@ enum cc_attr {
>>   	 * Examples include SEV-ES.
>>   	 */
>>   	CC_ATTR_GUEST_STATE_ENCRYPT,
>> +
>> +	/**
>> +	 * @CC_ATTR_GUEST_TDX: Trusted Domain Extension Support
>> +	 *
>> +	 * The platform/OS is running as a TDX guest/virtual machine.
>> +	 *
>> +	 * Examples include SEV-ES.
> 			    ^^^^^^^
> 
> Copy/paste huh? :)

Yes. Sorry, I will fix it.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
