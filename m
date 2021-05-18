Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD04388122
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhERUNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:13:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:15947 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231580AbhERUNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:13:38 -0400
IronPort-SDR: lW+E/tN/Vo5eHLG8t+wWMBOtbZF8j8aDRVqUYVDeqeyTvMm7FThuAEc0eS6PzdvkMAui6wHcyX
 6JiJRMZJvJvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="180412480"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="180412480"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:12:19 -0700
IronPort-SDR: 7GyFl8XF4rtUcZ0YJIFXpM9+DMHHP8/7cRhj8uZOsIGSElbYivynm+SCWpFS/qZIMRRZh0X1oJ
 71Og0/s8YcqQ==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="439611380"
Received: from dwchow-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.41.14])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 13:12:18 -0700
Subject: Re: [RFC v2-fix 1/1] x86/tdx: Wire up KVM hypercalls
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <2a4e9702-5407-aa95-be9b-864775bbaabd@intel.com>
 <20210518001551.258126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <f9bbc6b2-c7ac-3f36-08e3-9c4da68a6a9d@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d669889f-23e0-5f21-60ab-b550d5934364@linux.intel.com>
Date:   Tue, 18 May 2021 13:12:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <f9bbc6b2-c7ac-3f36-08e3-9c4da68a6a9d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/21 8:51 AM, Dave Hansen wrote:
> Question for KVM folks: Should all of these guest patches say:
> "x86/tdx/guest:" or something?  It seems like that would put us all in
> the right frame of mind as we review these.  It's kinda easy (for me at
> least) to get lost about which side I'm looking at sometimes.
> 
> On 5/17/21 5:15 PM, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> KVM hypercalls use the "vmcall" or "vmmcall" instructions.
>> Although the ABI is similar, those instructions no longer
>> function for TDX guests. Make vendor specififc TDVMCALLs
> 
> 				"vendor-specific"
> 
> 		    Hyphen and spelling ^

I will fix it next version.

> 
>> instead of VMCALL.
> 
> This would also be a great place to say:
> 
> This enables TDX guests to run with KVM acting as the hypervisor.  TDX
> guests running under other hypervisors will continue to use those
> hypervisors hypercalls.

I will include it.

> 
>> [Isaku: proposed KVM VENDOR string]
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> This SoB chain is odd.  Kirill wrote this, sent it to Isaku, who sent it
> to Sathya?

Initially we have used "0" as vendor ID for KVM. But Isaku proposed a new
value for it and sent a patch to fix it. But, I did not want to carry it as
separate patch (for one line change). So I have merged his change with
this patch, and added his signed-off with comment ([Isaku: proposed KVM VENDOR string])

+#define TDVMCALL_VENDOR_KVM            0x4d564b2e584454 /* "TDX.KVM" */


> 
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 9e0e0ff76bab..768df1b98487 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -886,6 +886,12 @@ config INTEL_TDX_GUEST
>>   	  run in a CPU mode that protects the confidentiality of TD memory
>>   	  contents and the TD’s CPU state from other software, including VMM.
>>   
>> +config INTEL_TDX_GUEST_KVM
>> +	def_bool y
>> +	depends on KVM_GUEST && INTEL_TDX_GUEST
>> +	help
>> +	 This option enables KVM specific hypercalls in TDX guest.
> 
> For something that's not user-visible, I'd probably just add a Kconfig
> comment rather than help text.

If it is the preferred approach, I can remove it.

> 
> ...
>> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
>> index 7966c10ea8d1..a90fec004844 100644
>> --- a/arch/x86/kernel/Makefile
>> +++ b/arch/x86/kernel/Makefile
>> @@ -128,6 +128,7 @@ obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
>>   
>>   obj-$(CONFIG_JAILHOUSE_GUEST)	+= jailhouse.o
>>   obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdcall.o tdx.o
>> +obj-$(CONFIG_INTEL_TDX_GUEST_KVM) += tdx-kvm.o
> 
> Is the indentation consistent with the other items near "tdx-kvm.o" in
> the Makefile?

Yes. For longer config names, common indentation is not maintained. Please
check the PMEM example.

126 obj-$(CONFIG_PARAVIRT_CLOCK)    += pvclock.o
127 obj-$(CONFIG_X86_PMEM_LEGACY_DEVICE) += pmem.o
128
129 obj-$(CONFIG_JAILHOUSE_GUEST)   += jailhouse.o
130 obj-$(CONFIG_INTEL_TDX_GUEST)   += tdcall.o tdx.o
131 obj-$(CONFIG_INTEL_TDX_GUEST_KVM) += tdx-kvm.o


> 
> ...
>> +/* Used by kvm_hypercall4() to trigger hypercall in TDX guest */
>> +long tdx_kvm_hypercall4(unsigned int nr, unsigned long p1, unsigned long p2,
>> +		unsigned long p3, unsigned long p4)
>> +{
>> +	return tdx_kvm_hypercall(nr, p1, p2, p3, p4);
>> +}
>> +EXPORT_SYMBOL_GPL(tdx_kvm_hypercall4);
> 
> I always forget that KVM code is goofy and needs to have things in C
> files so you can export the symbols.  Could you add a sentence to the
> changelog to this effect?
> 
> Code-wise, this is fine.  Just a few tweaks and I'll be happy to ack
> this one.

Will add it.

     Since KVM hypercall functions can be included and called
     from kernel modules, export tdx_kvm_hypercall*() functions
     to avoid symbol errors


> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
