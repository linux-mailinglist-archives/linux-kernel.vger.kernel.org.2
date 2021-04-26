Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D405536BBAF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbhDZWcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:32:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:57982 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhDZWcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:32:51 -0400
IronPort-SDR: 4e0lipseylVvNoRRTxkYaOG+ephhRE0fvvgcbdo7LZBJ4EeJWKiFPmiudZqe392Cxq8WrRAIdp
 35waHAYtysFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="193227683"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="193227683"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:32:09 -0700
IronPort-SDR: KUuXlNxe3y0xU+C+8+tj7NB5PWyN+o1NpVSHnCnqYFlmRTdBgo30/zbTitFOa+vVdw6LPIbzlI
 S4eVDWimm0yA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="465272238"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 15:32:08 -0700
Subject: Re: [RFC v2 02/32] x86/tdx: Introduce INTEL_TDX_GUEST config option
To:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <32870c547c6e143a8f42667c6087ee61dc07e90b.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <a4faf7f0-27ab-9d39-a183-a9a696aae061@infradead.org>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e4fdc23e-71ef-db02-b05e-5ae55c1fadb2@linux.intel.com>
Date:   Mon, 26 Apr 2021 15:32:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a4faf7f0-27ab-9d39-a183-a9a696aae061@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/21 2:09 PM, Randy Dunlap wrote:
> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
>> Add INTEL_TDX_GUEST config option to selectively compile
>> TDX guest support.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   arch/x86/Kconfig | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 6b4b682af468..932e6d759ba7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -875,6 +875,21 @@ config ACRN_GUEST
>>   	  IOT with small footprint and real-time features. More details can be
>>   	  found in https://projectacrn.org/.
>>   
>> +config INTEL_TDX_GUEST
>> +	bool "Intel Trusted Domain eXtensions Guest Support"
>> +	depends on X86_64 && CPU_SUP_INTEL && PARAVIRT
>> +	depends on SECURITY
>> +	select PARAVIRT_XL
>> +	select X86_X2APIC
>> +	select SECURITY_LOCKDOWN_LSM
>> +	help
>> +	  Provide support for running in a trusted domain on Intel processors
>> +	  equipped with Trusted Domain eXtenstions. TDX is an new Intel
> 
> 	                                                   a new Intel
> 

Good catch. I will fix it in next version.

>> +	  technology that extends VMX and Memory Encryption with a new kind of
>> +	  virtual machine guest called Trust Domain (TD). A TD is designed to
>> +	  run in a CPU mode that protects the confidentiality of TD memory
>> +	  contents and the TD’s CPU state from other software, including VMM.
>> +
>>   endif #HYPERVISOR_GUEST
>>   
>>   source "arch/x86/Kconfig.cpu"
>>
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
