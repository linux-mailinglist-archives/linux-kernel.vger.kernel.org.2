Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABA430DEBE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhBCPx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:53:29 -0500
Received: from foss.arm.com ([217.140.110.172]:42452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234666AbhBCPwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:52:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2D7311FB;
        Wed,  3 Feb 2021 07:51:23 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B4913F719;
        Wed,  3 Feb 2021 07:51:22 -0800 (PST)
Subject: Re: [PATCH V3 04/14] coresight: ete: Add support for ETE sysreg
 access
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-5-git-send-email-anshuman.khandual@arm.com>
 <20210202175241.GC1536093@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c5e68822-2407-e72e-d31e-620ffc08294c@arm.com>
Date:   Wed, 3 Feb 2021 15:51:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210202175241.GC1536093@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 5:52 PM, Mathieu Poirier wrote:
> On Wed, Jan 27, 2021 at 02:25:28PM +0530, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Add support for handling the system registers for Embedded Trace
>> Extensions (ETE). ETE shares most of the registers with ETMv4 except
>> for some and also adds some new registers. Re-arrange the ETMv4x list
>> to share the common definitions and add the ETE sysreg support.
>>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 32 +++++++++++++
>>   drivers/hwtracing/coresight/coresight-etm4x.h      | 52 ++++++++++++++++++----
>>   2 files changed, 75 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> index 9edf8be..9e92d2a 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
>> @@ -114,6 +114,38 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>>   	}
>>   }
>>   
>> +u64 ete_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
>> +{
>> +	u64 res = 0;
>> +
>> +	switch (offset) {
>> +	ETE_READ_CASES(res)
>> +	default :
>> +		WARN_ONCE(1, "ete: trying to read unsupported register @%x\n",
>> +			 offset);
> 
> Alignment
> 
>> +	}
>> +
>> +	if (!_relaxed)
>> +		__iormb(res);	/* Imitate the !relaxed I/O helpers */
>> +
>> +	return res;
>> +}
>> +
>> +void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>> +{
>> +	if (!_relaxed)
>> +		__iowmb();	/* Imitate the !relaxed I/O helpers */
>> +	if (!_64bit)
>> +		val &= GENMASK(31, 0);
>> +
>> +	switch (offset) {
>> +	ETE_WRITE_CASES(val)
>> +	default :
>> +		WARN_ONCE(1, "ete: trying to write to unsupported register @%x\n",
>> +			offset);
> 
> Alignment
> 
>> +	}
>> +}
> 
> The etm4x_sysreg_xyz() equivalent of these use a pr_warn_ratelimited() rather
> than a WARN_ONE().
> 
> With that:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Converted to pr_warn_ratelimited() to both instances and fixed Alignment

Cheers
Suzuki

