Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F953677D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhDVDRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:17:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:13574 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230319AbhDVDRw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:17:52 -0400
IronPort-SDR: Nxk6rqJcb7PUioFo0/usAp2hnew/lxj9/Ruoej77wLXehvbvUpZZlZTIKzALUJUCWq2AEfObPh
 ozVhBx9LAWDA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="183304368"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="183304368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:16:58 -0700
IronPort-SDR: fUPT+MPQOVG0IKK0A+jG6q2HwBfctbodIzmZWE9HHhnq1ufrWWa7KvfFpuFyHrUbARVZtaC4OZ
 jVcwM3XKa3lA==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427756783"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:16:55 -0700
Subject: Re: [PATCH v4 24/25] perf tests: Support 'Convert perf time to TSC'
 test for hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-25-yao.jin@linux.intel.com> <YIBu/DyPmMf1Mta4@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fd34b4fb-817b-0cf5-f8ce-7d860748e9a6@linux.intel.com>
Date:   Thu, 22 Apr 2021 11:16:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBu/DyPmMf1Mta4@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:16PM +0800, Jin Yao wrote:
>> Since for "cycles:u' on hybrid platform, it creates two "cycles".
>> So the second evsel in evlist also needs initialization.
>>
>> With this patch,
>>
>>    # ./perf test 71
>>    71: Convert perf time to TSC                                        : Ok
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/tests/perf-time-to-tsc.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/tools/perf/tests/perf-time-to-tsc.c b/tools/perf/tests/perf-time-to-tsc.c
>> index 680c3cffb128..72f268c6cc5d 100644
>> --- a/tools/perf/tests/perf-time-to-tsc.c
>> +++ b/tools/perf/tests/perf-time-to-tsc.c
>> @@ -20,6 +20,7 @@
>>   #include "tsc.h"
>>   #include "mmap.h"
>>   #include "tests.h"
>> +#include "pmu.h"
>>   
>>   #define CHECK__(x) {				\
>>   	while ((x) < 0) {			\
>> @@ -66,6 +67,10 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>>   	u64 test_tsc, comm1_tsc, comm2_tsc;
>>   	u64 test_time, comm1_time = 0, comm2_time = 0;
>>   	struct mmap *md;
>> +	bool hybrid = false;
>> +
>> +	if (perf_pmu__has_hybrid())
>> +		hybrid = true;
>>   
>>   	threads = thread_map__new(-1, getpid(), UINT_MAX);
>>   	CHECK_NOT_NULL__(threads);
>> @@ -88,6 +93,17 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
>>   	evsel->core.attr.disabled = 1;
>>   	evsel->core.attr.enable_on_exec = 0;
>>   
>> +	/*
>> +	 * For hybrid "cycles:u", it creates two events.
>> +	 * Init the second evsel here.
>> +	 */
>> +	if (hybrid) {
> 
> same, don't see the reason for 'hybrid' variable
> 

OK, will use 'if (perf_pmu__has_hybrid())' instead.

Thanks
Jin Yao

> jirka
> 
>> +		evsel = evsel__next(evsel);
>> +		evsel->core.attr.comm = 1;
>> +		evsel->core.attr.disabled = 1;
>> +		evsel->core.attr.enable_on_exec = 0;
>> +	}
>> +
>>   	CHECK__(evlist__open(evlist));
>>   
>>   	CHECK__(evlist__mmap(evlist, UINT_MAX));
>> -- 
>> 2.17.1
>>
> 
