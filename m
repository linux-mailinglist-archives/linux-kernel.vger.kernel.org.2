Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99029305E01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhA0OPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:15:33 -0500
Received: from foss.arm.com ([217.140.110.172]:48390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232605AbhA0ONN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:13:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BA471FB;
        Wed, 27 Jan 2021 06:12:23 -0800 (PST)
Received: from [10.57.40.145] (unknown [10.57.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8C853F68F;
        Wed, 27 Jan 2021 06:12:21 -0800 (PST)
Subject: Re: [PATCH V3 14/14] coresight: etm-perf: Add support for trace
 buffer format
To:     Peter Zijlstra <peterz@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        lcherian@marvell.com, linux-kernel@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-15-git-send-email-anshuman.khandual@arm.com>
 <YBFiecTmjA30qRaW@hirez.programming.kicks-ass.net>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <fdde5dab-e76a-efec-2124-ef42f8ffa818@arm.com>
Date:   Wed, 27 Jan 2021 14:12:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBFiecTmjA30qRaW@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter

On 1/27/21 12:54 PM, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 02:25:38PM +0530, Anshuman Khandual wrote:
> 
>> It is possible to have a
>> perf session where some events end up collecting the trace
>> in TMC-ETR while the others in TRBE. Thus we need a way
>> to identify the type of the trace for each AUX record.
> 
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index 9a5ca45..169e6b3 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -1111,6 +1111,10 @@ enum perf_callchain_context {
>>   #define PERF_AUX_FLAG_COLLISION			0x08	/* sample collided with another */
>>   #define PERF_AUX_FLAG_PMU_FORMAT_TYPE_MASK	0xff00	/* PMU specific trace format type */
>>   
>> +/* CoreSight PMU AUX buffer formats */
>> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT	0x0000 /* Default for backward compatibility */
>> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW		0x0100 /* Raw format of the source */
> 
> Would CORESIGHT_FORMAT_ETR / CORESIGHT_FORMAT_TRBE be better names?
> 

Not really. The format used by the ETR is CORESIGHT frame formatting. And
there are other sinks that uses the formatting. e.g, TMC-ETB (a sink with
internal memory), TMC-ETF (trace fifo with internal memory). So it is really
not tied to ETR.

As for TRBE, it simply pumps the data thrown at it to the memory. As such
calling it TRBE format would be confusing as the format of the buffer is
really Raw trace thrown at it. This can be inferred from the ETM/ETE
looking at the ID registers, which the userspace perf already captures
in the perf.data. So the decoder perf can look at the perf.data and the
AUX records to interpret the buffer correctly.

Suzuki
