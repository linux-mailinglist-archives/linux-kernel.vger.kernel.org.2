Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8933116C7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhBEXNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:13:00 -0500
Received: from foss.arm.com ([217.140.110.172]:35406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232507AbhBEO2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:28:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BA67106F;
        Fri,  5 Feb 2021 07:41:40 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4765D3F719;
        Fri,  5 Feb 2021 07:41:38 -0800 (PST)
Subject: Re: [PATCH v11 4/5] arm64: mte: Enable async tag check fault
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
 <20210130165225.54047-5-vincenzo.frascino@arm.com>
 <20210205153918.GA12697@gaia>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <1254c150-599c-d39d-3b83-8af4f3c403ee@arm.com>
Date:   Fri, 5 Feb 2021 15:45:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205153918.GA12697@gaia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/5/21 3:39 PM, Catalin Marinas wrote:
> On Sat, Jan 30, 2021 at 04:52:24PM +0000, Vincenzo Frascino wrote:
>> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
>> index 92078e1eb627..7763ac1f2917 100644
>> --- a/arch/arm64/kernel/mte.c
>> +++ b/arch/arm64/kernel/mte.c
>> @@ -182,6 +182,37 @@ bool mte_report_once(void)
>>  	return READ_ONCE(report_fault_once);
>>  }
>>  
>> +#ifdef CONFIG_KASAN_HW_TAGS
>> +void mte_check_tfsr_el1(void)
>> +{
>> +	u64 tfsr_el1;
>> +
>> +	if (!system_supports_mte())
>> +		return;
>> +
>> +	tfsr_el1 = read_sysreg_s(SYS_TFSR_EL1);
>> +
>> +	/*
>> +	 * The kernel should never trigger an asynchronous fault on a
>> +	 * TTBR0 address, so we should never see TF0 set.
>> +	 * For futexes we disable checks via PSTATE.TCO.
>> +	 */
>> +	WARN_ONCE(tfsr_el1 & SYS_TFSR_EL1_TF0,
>> +		  "Kernel async tag fault on TTBR0 address");
> 
> Sorry, I got confused when I suggested this warning. If the user is
> running in async mode, the TFSR_EL1.TF0 bit may be set by
> copy_mount_options(), strncpy_from_user() which rely on an actual fault
> happening (not the case with asynchronous where only a bit is set). With
> the user MTE support, we never report asynchronous faults caused by the
> kernel on user addresses as we can't easily track them. So this warning
> may be triggered on correctly functioning kernel/user.
> 

No issue, I will re-post removing the WARN_ONCE().

>> +
>> +	if (unlikely(tfsr_el1 & SYS_TFSR_EL1_TF1)) {
>> +		/*
>> +		 * Note: isb() is not required after this direct write
>> +		 * because there is no indirect read subsequent to it
>> +		 * (per ARM DDI 0487F.c table D13-1).
>> +		 */
>> +		write_sysreg_s(0, SYS_TFSR_EL1);
> 
> Zeroing the whole register is still fine, we don't care about the TF0
> bit anyway.
> 
>> +
>> +		kasan_report_async();
>> +	}
>> +}
>> +#endif
> 

-- 
Regards,
Vincenzo
