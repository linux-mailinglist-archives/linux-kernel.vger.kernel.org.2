Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E45F432FA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhJSHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:37:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:54249 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhJSHh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:37:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="209239905"
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="209239905"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 00:35:12 -0700
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="493970184"
Received: from cqiang-mobl.ccr.corp.intel.com (HELO [10.238.2.71]) ([10.238.2.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 00:35:06 -0700
Message-ID: <e635927d-0388-af8d-04a2-24a446e166fa@intel.com>
Date:   Tue, 19 Oct 2021 15:34:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.2.0
Subject: Re: [PATCH] x86/bus_lock: Don't assume the init value of
 DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Content-Language: en-US
From:   Chenyi Qiang <chenyi.qiang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210901084004.5393-1-chenyi.qiang@intel.com>
 <cf8dec95-d85c-1074-fd65-d89230e930e1@intel.com>
In-Reply-To: <cf8dec95-d85c-1074-fd65-d89230e930e1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reminder for this minor fix.

On 9/17/2021 10:52 AM, Chenyi Qiang wrote:
> Kindly ping for this minor change.
> 
> Thanks
> Chenyi
> 
> On 9/1/2021 4:40 PM, Chenyi Qiang wrote:
>> It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
>> this kernel has been kexec'd from a kernel that enabled bus lock
>> detection.
>>
>> Disable bus lock detection explicitly if not wanted.
>>
>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> ---
>>   arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++-------------
>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
>> index 8321c43554a1..38dda04d9342 100644
>> --- a/arch/x86/kernel/cpu/intel.c
>> +++ b/arch/x86/kernel/cpu/intel.c
>> @@ -1152,22 +1152,23 @@ static void bus_lock_init(void)
>>   {
>>       u64 val;
>> -    /*
>> -     * Warn and fatal are handled by #AC for split lock if #AC for
>> -     * split lock is supported.
>> -     */
>> -    if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
>> -        (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
>> -        (sld_state == sld_warn || sld_state == sld_fatal)) ||
>> -        sld_state == sld_off)
>> +    if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
>>           return;
>> -    /*
>> -     * Enable #DB for bus lock. All bus locks are handled in #DB except
>> -     * split locks are handled in #AC in the fatal case.
>> -     */
>>       rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
>> -    val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
>> +
>> +    if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
>> +        (sld_state == sld_warn || sld_state == sld_fatal)) ||
>> +        sld_state == sld_off) {
>> +        /*
>> +         * Warn and fatal are handled by #AC for split lock if #AC for
>> +         * split lock is supported.
>> +         */
>> +        val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
>> +    } else {
>> +        val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
>> +    }
>> +
>>       wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
>>   }
>>
