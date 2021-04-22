Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FD43677CE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhDVDPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:15:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:54538 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDVDPa (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:15:30 -0400
IronPort-SDR: zxNHQBXmcrHT7F84/VJgNaRSE2Q9o9n/gyuLIpzXaB82mOqhHl/YbY6IEfvVDEAM/KXlYurM6d
 tqyz3Sho5d1g==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175304633"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="175304633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:14:56 -0700
IronPort-SDR: bDOvQcQ80TiwH++t2tfBI9FIOnRx5Zy68NDD/duyIyZ6IqKnrEMEtUgdKAG0WGL4sjKRLpNi9B
 S0eriEEYyIog==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427756217"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:14:53 -0700
Subject: Re: [PATCH v4 21/25] perf tests: Support 'Track with sched_switch'
 test for hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-22-yao.jin@linux.intel.com> <YIBu52/0p8r+JZO0@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <42749f8d-50ed-aa91-2dc0-31cb0cc146ee@linux.intel.com>
Date:   Thu, 22 Apr 2021 11:14:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBu52/0p8r+JZO0@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:28 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:13PM +0800, Jin Yao wrote:
>> Since for "cycles:u' on hybrid platform, it creates two "cycles".
>> So the number of events in evlist is not expected in next test
>> steps. Now we just use one event "cpu_core/cycles:u/" for hybrid.
>>
>>    # ./perf test 35
>>    35: Track with sched_switch                                         : Ok
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/tests/switch-tracking.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
>> index 3ebaa758df77..3a12176f8c46 100644
>> --- a/tools/perf/tests/switch-tracking.c
>> +++ b/tools/perf/tests/switch-tracking.c
>> @@ -18,6 +18,7 @@
>>   #include "record.h"
>>   #include "tests.h"
>>   #include "util/mmap.h"
>> +#include "pmu.h"
>>   
>>   static int spin_sleep(void)
>>   {
>> @@ -340,6 +341,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>>   	struct evsel *switch_evsel, *tracking_evsel;
>>   	const char *comm;
>>   	int err = -1;
>> +	bool hybrid = false;
>> +
>> +	if (perf_pmu__has_hybrid())
>> +		hybrid = true;
>>   
>>   	threads = thread_map__new(-1, getpid(), UINT_MAX);
>>   	if (!threads) {
>> @@ -371,7 +376,10 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
>>   	cpu_clocks_evsel = evlist__last(evlist);
>>   
>>   	/* Second event */
>> -	err = parse_events(evlist, "cycles:u", NULL);
>> +	if (!hybrid)
> 
> why the variable? some leftover? could be directly
> 'if (perf_pmu__has_hybrid())' no?
> 

Yes, using 'if (perf_pmu__has_hybrid())' is the better style.

Thanks
Jin Yao

> thanks,
> jirka
>
>> +		err = parse_events(evlist, "cycles:u", NULL);
>> +	else
>> +		err = parse_events(evlist, "cpu_core/cycles/u", NULL);
>>   	if (err) {
>>   		pr_debug("Failed to parse event cycles:u\n");
>>   		goto out_err;
>> -- 
>> 2.17.1
>>
> 
