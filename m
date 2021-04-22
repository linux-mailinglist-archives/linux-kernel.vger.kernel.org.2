Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821FC3677C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbhDVDMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:12:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:63752 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDVDMg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:12:36 -0400
IronPort-SDR: ieKKV2TRJqlfNpDl2RBDPWx6YEsYoFTXf0NOHKHrNM5EL/ARxRuBiRBlTh1tVK50uaG4wRT6Um
 vfhu6ubmFDXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="216476611"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="216476611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:12:02 -0700
IronPort-SDR: 71YyLgHbqlr+0jz6BnI6UTrKpbTh0fa4doueZ8Z1OX4zdJ3BYDBK427VmIIpz7GX5z7X569Rd2
 V4xP8QdH8Bbg==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427755581"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:11:59 -0700
Subject: Re: [PATCH v4 20/25] perf tests: Skip 'Setup struct perf_event_attr'
 test for hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-21-yao.jin@linux.intel.com> <YIBu9czPTYWePyak@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <4e6b9806-3906-f0f1-b847-8c1c2b5cdce9@linux.intel.com>
Date:   Thu, 22 Apr 2021 11:11:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBu9czPTYWePyak@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:12PM +0800, Jin Yao wrote:
>> For hybrid, the attr.type consists of pmu type id + original type.
>> There will be much changes for this test. Now we temporarily
>> skip this test case and TODO in future.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/tests/attr.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
>> index dd39ce9b0277..b37c35fb5a46 100644
>> --- a/tools/perf/tests/attr.c
>> +++ b/tools/perf/tests/attr.c
>> @@ -34,6 +34,7 @@
>>   #include "event.h"
>>   #include "util.h"
>>   #include "tests.h"
>> +#include "pmu.h"
>>   
>>   #define ENV "PERF_TEST_ATTR"
>>   
>> @@ -184,6 +185,9 @@ int test__attr(struct test *test __maybe_unused, int subtest __maybe_unused)
>>   	char path_dir[PATH_MAX];
>>   	char *exec_path;
>>   
>> +	if (perf_pmu__has_hybrid())
>> +		return 0;
> 
> should return TEST_SKIP
> 

Got it, thanks Jiri!

> jirka
>

Thanks
Jin Yao

>> +
>>   	/* First try development tree tests. */
>>   	if (!lstat("./tests", &st))
>>   		return run_dir("./tests", "./perf");
>> -- 
>> 2.17.1
>>
> 
