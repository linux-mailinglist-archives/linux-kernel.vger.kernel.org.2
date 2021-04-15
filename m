Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747B5360C64
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhDOOuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:50:44 -0400
Received: from foss.arm.com ([217.140.110.172]:48066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233865AbhDOOuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:50:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FFBF106F;
        Thu, 15 Apr 2021 07:49:49 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F147F3F73B;
        Thu, 15 Apr 2021 07:49:46 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] perf arm-spe: Remove unused enum value
 ARM_SPE_PER_CPU_MMAPS
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-2-leo.yan@linaro.org>
 <882e13d1-c793-88c6-0b1e-629462fb99ac@arm.com>
 <20210415144158.GD1011890@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <a3a516c5-fc13-50d6-d80f-66f68d1c89c1@arm.com>
Date:   Thu, 15 Apr 2021 17:49:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415144158.GD1011890@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/04/2021 17:41, Leo Yan wrote:
> Hi James,
> 
> On Thu, Apr 15, 2021 at 05:13:36PM +0300, James Clark wrote:
>> On 12/04/2021 12:10, Leo Yan wrote:
>>> The enum value 'ARM_SPE_PER_CPU_MMAPS' is never used so remove it.
>>
>> Hi Leo,
>>
>> I think this causes an error when attempting to open a newly recorded file
>> with an old version of perf. The value ARM_SPE_AUXTRACE_PRIV_MAX is used here:
>>
>> 	size_t min_sz = sizeof(u64) * ARM_SPE_AUXTRACE_PRIV_MAX;
>> 	struct perf_record_time_conv *tc = &session->time_conv;
>> 	struct arm_spe *spe;
>> 	int err;
>>
>> 	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
>> 					min_sz)
>> 		return -EINVAL;
>>
>> And removing ARM_SPE_PER_CPU_MMAPS changes the value of ARM_SPE_AUXTRACE_PRIV_MAX.
>>
>> At least I think that's what's causing the problem. I get this error:
>>
>> 	./perf report -i per-thread-spe-time.data
>> 	0x1c0 [0x18]: failed to process type: 70 [Invalid argument]
>> 	Error:
>> 	failed to process sample
>> 	# To display the perf.data header info, please use --header/--header-only options.
>> 	#
> 
> Yes, when working on this patch I had concern as well.
> 
> I carefully thought that the perf tool should be backwards-compatible,
> but there have no requirement for forwards-compatibility.  This is the
> main reason why I kept this patch.
> 
> If you or anyone could confirm the forwards-compatibility is required,
> it's quite fine for me to drop this patch.
> 

Personally, I can easily imagine sending a file to someone to open with an older version and it causing
friction where it could be easily avoided. And it even made testing a bit more difficult because
I wanted to compare opening the same file with the patched and un-patched version. But if there
is no hard requirement I can't really put too much pressure to not remove it.

> Thanks a lot for the reviewing and testing!
> Leo
> 
