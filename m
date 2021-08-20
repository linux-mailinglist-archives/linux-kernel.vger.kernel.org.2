Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557A93F3246
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 19:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhHTRby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 13:31:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:60664 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234711AbhHTRbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 13:31:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="196390911"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="196390911"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 10:31:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="506545031"
Received: from jmorauga-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.135.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 10:31:13 -0700
Subject: Re: [PATCH v5 06/12] x86/tdx: Get TD execution environment
 information via TDINFO
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
 <20210804181329.2899708-7-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YR/in4WqEQQ/LyPA@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <c5dc6c26-6157-c022-9d6b-f1ef10e6f736@linux.intel.com>
Date:   Fri, 20 Aug 2021 10:31:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR/in4WqEQQ/LyPA@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 10:13 AM, Borislav Petkov wrote:
> On Wed, Aug 04, 2021 at 11:13:23AM -0700, Kuppuswamy Sathyanarayanan wrote:
>> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>
>> Per Guest-Host-Communication Interface (GHCI) for Intel Trust
>> Domain Extensions (Intel TDX) specification, sec 2.4.2,
>> TDCALL[TDINFO] provides basic TD execution environment information, not
>> provided by CPUID.
>>
>> Call TDINFO during early boot to be used for following system
>> initialization.
>>
>> The call provides info on which bit in pfn is used to indicate that the
>> page is shared with the host and attributes of the TD, such as debug.
>>
>> Information about the number of CPUs need not be saved because there are
>> no users so far for it.
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>
>> Changes since v4:
>>   * None
>>
>> Changes since v3:
>>   * None
>>
>>   arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
>> index 287564990f21..3973e81751ba 100644
>> --- a/arch/x86/kernel/tdx.c
>> +++ b/arch/x86/kernel/tdx.c
>> @@ -8,6 +8,14 @@
>>   
>>   #include <asm/tdx.h>
>>   
>> +/* TDX Module call Leaf IDs */
>> +#define TDINFO				1
>> +
>> +static struct {
>> +	unsigned int gpa_width;
>> +	unsigned long attributes;
>> +} td_info __ro_after_init;
> 
> Where is that thing even used? I don't see it in the whole patchset.

It is used in different patch set. If you prefer to move it there, I can
move it to that patch set.

patch: https://lore.kernel.org/patchwork/patch/1472343/
series: https://lore.kernel.org/patchwork/project/lkml/list/?series=510836


> 
>> +
>>   /*
>>    * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
>>    * for TDCALL error.
>> @@ -54,6 +62,19 @@ bool tdx_prot_guest_has(unsigned long flag)
>>   }
>>   EXPORT_SYMBOL_GPL(tdx_prot_guest_has);
>>   
>> +static void tdg_get_info(void)
> 
> Also, what Sean said: "tdx_" please. Unless there's a real reason to
> have a different prefix - then state that reason.
> 
>> +{
>> +	u64 ret;
>> +	struct tdx_module_output out = {0};
> 
> The tip-tree preferred ordering of variable declarations at the
> beginning of a function is reverse fir tree order::
> 
> 	struct long_struct_name *descriptive_name;
> 	unsigned long foo, bar;
> 	unsigned int tmp;
> 	int ret;
> 
> The above is faster to parse than the reverse ordering::
> 
> 	int ret;
> 	unsigned int tmp;
> 	unsigned long foo, bar;
> 	struct long_struct_name *descriptive_name;
> 
> And even more so than random ordering::
> 
> 	unsigned long foo, bar;
> 	int ret;
> 	struct long_struct_name *descriptive_name;
> 	unsigned int tmp;

I will re-check the TDX patchset and fix the ordering issues.

> 
>> +
>> +	ret = __tdx_module_call(TDINFO, 0, 0, 0, 0, &out);
>> +
>> +	BUG_ON(ret);
> 
> WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
> #121: FILE: arch/x86/kernel/tdx.c:72:
> +	BUG_ON(ret);

I have already fixed reasonable check-patch issues. For this case, we
want to use BUG_ON(). Failure in tdx_module_call means buggy TDX
module. So it is safer to crash the kernel.

> 
> Have I already told you about checkpatch?
> 
> If not, here it is:
> 
> Please integrate scripts/checkpatch.pl into your patch creation
> workflow. Some of the warnings/errors *actually* make sense.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
