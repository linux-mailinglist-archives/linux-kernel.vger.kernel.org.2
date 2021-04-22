Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB33677D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbhDVDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:21:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:30679 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDVDVK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:21:10 -0400
IronPort-SDR: A5j7p4fHeEHSRVj16REpRZrI72gTkhctAcOsCqkILLjBCc/rZqUiz5P+fxUkRwZmQnK4JwvKhW
 /WK84pkjRU5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="195374634"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="195374634"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:20:36 -0700
IronPort-SDR: yVVoCITEhMtrYlRnDNznNapeCo1lLh06PpoVBcjBbMQs4Jez762KE/0UyjN5HYz4ehnNevA+2Z
 bhv09PTIbzkw==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427757313"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:20:34 -0700
Subject: Re: [PATCH v4 22/25] perf tests: Support 'Parse and process metrics'
 test for hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-23-yao.jin@linux.intel.com> <YIBvD16uYZspDVDa@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <bb83ada4-a669-7ae1-1472-5c8d97a3f177@linux.intel.com>
Date:   Thu, 22 Apr 2021 11:20:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBvD16uYZspDVDa@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:14PM +0800, Jin Yao wrote:
>> Some events are not supported. Only pick up some cases for hybrid.
>>
>>    # ./perf test 67
>>    67: Parse and process metrics                                       : Ok
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/tests/parse-metric.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
>> index 4968c4106254..24e5ddff515e 100644
>> --- a/tools/perf/tests/parse-metric.c
>> +++ b/tools/perf/tests/parse-metric.c
>> @@ -11,6 +11,7 @@
>>   #include "debug.h"
>>   #include "expr.h"
>>   #include "stat.h"
>> +#include "pmu.h"
>>   
>>   static struct pmu_event pme_test[] = {
>>   {
>> @@ -370,12 +371,17 @@ static int test_metric_group(void)
>>   
>>   int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>>   {
>> +	perf_pmu__scan(NULL);
> 
> perf_pmu__has_hybrid calls perf_pmu__scan no?
> 
> jirka
> 

Sorry, I don't need to call perf_pmu_scan here.

+bool perf_pmu__has_hybrid(void)
+{
+       if (!hybrid_scanned) {
+               hybrid_scanned = true;
+               perf_pmu__scan(NULL);
+       }
+
+       return !list_empty(&perf_pmu__hybrid_pmus);
+}

perf_pmu__has_hybrid calls perf_pmu__scan if it's not scanned yet.

Thanks
Jin Yao

>> +
>>   	TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>>   	TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
>> -	TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>>   	TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>>   	TEST_ASSERT_VAL("recursion fail failed", test_recursion_fail() == 0);
>> -	TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
>>   	TEST_ASSERT_VAL("Memory bandwidth", test_memory_bandwidth() == 0);
>> +
>> +	if (!perf_pmu__has_hybrid()) {
>> +		TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
>> +		TEST_ASSERT_VAL("test metric group", test_metric_group() == 0);
>> +	}
>>   	return 0;
>>   }
>> -- 
>> 2.17.1
>>
> 
