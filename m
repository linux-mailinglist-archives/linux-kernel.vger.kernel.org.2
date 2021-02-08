Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2045331407E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhBHUaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:30:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:54721 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236028AbhBHTG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 14:06:27 -0500
IronPort-SDR: FLtx/Uo0TKmgpRs8REt6uoJYD14gnkSu+DcdxGN1Bx12QD2EmiR6AWTIMhLJzk7iXibapHe0na
 SJHAAPjiJ6jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="266597679"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="266597679"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 11:04:29 -0800
IronPort-SDR: U11Fj0FVC8pr92M/O5i2/+Qyw1XG4JcwB7u6TrOG4syTpu8p4xAjMX5hLB4TZyHsQ1nVUmSLrY
 EH5kWVOby33Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="377901719"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 08 Feb 2021 11:04:28 -0800
Received: from [10.255.228.220] (kliang2-MOBL.ccr.corp.intel.com [10.255.228.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 41D475808A1;
        Mon,  8 Feb 2021 11:04:26 -0800 (PST)
Subject: Re: [PATCH 02/49] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
To:     Borislav Petkov <bp@alien8.de>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-3-git-send-email-kan.liang@linux.intel.com>
 <20210208175640.GD18227@zn.tnic>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <cddc013c-5b48-f792-058c-009e43cfe547@linux.intel.com>
Date:   Mon, 8 Feb 2021 14:04:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210208175640.GD18227@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/2021 12:56 PM, Borislav Petkov wrote:
> On Mon, Feb 08, 2021 at 07:24:59AM -0800, kan.liang@linux.intel.com wrote:
>> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
>> index c20a52b..1f25ac9 100644
>> --- a/arch/x86/include/asm/processor.h
>> +++ b/arch/x86/include/asm/processor.h
>> @@ -139,6 +139,16 @@ struct cpuinfo_x86 {
>>   	u32			microcode;
>>   	/* Address space bits used by the cache internally */
>>   	u8			x86_cache_bits;
>> +	/*
>> +	 * In hybrid processors, there is a CPU type and a native model ID. The
>> +	 * CPU type (x86_cpu_type[31:24]) describes the type of micro-
>> +	 * architecture families. The native model ID (x86_cpu_type[23:0])
>> +	 * describes a specific microarchitecture version. Combining both
>> +	 * allows to uniquely identify a CPU.
>> +	 *
>> +	 * Please note that the native model ID is not related to x86_model.
>> +	 */
>> +	u32			x86_cpu_type;
> 
> Why are you adding it here instead of simply using
> X86_FEATURE_HYBRID_CPU at the call site?
> 
> How many uses in this patchset?
> 
> /me searches...
> 
> Exactly one.
> 
> Just query X86_FEATURE_HYBRID_CPU at the call site and read what you
> need from CPUID and use it there - no need for this.
> 

I think it's good enough for perf, but I'm not sure whether other codes 
need the CPU type information.

Ricardo, do you know?

Maybe we should implement a generic function as below for this?
(Not test. Just use as an example.)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a66c1fd..679f5fe 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2056,3 +2056,11 @@ void arch_smt_update(void)
  	/* Check whether IPI broadcasting can be enabled */
  	apic_smt_update();
  }
+
+u32 x86_read_hybrid_type(void)
+{
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		return cpuid_eax(0x0000001a);
+
+	return 0;
+}


Thanks,
Kan
