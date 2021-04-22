Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441203677D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhDVDQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:16:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:32523 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDVDQ2 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:16:28 -0400
IronPort-SDR: zO0X58vMnOVFyyTzBIFrhmrAwEAqF+fkAxJzevMkWvcwOaxLSVNoEr50MXrNyM2H8eft3eJMP9
 uyHOEAqbaOJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="259771689"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="259771689"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:15:54 -0700
IronPort-SDR: NygI/7rm9wa3PRWPXAjbCwvzi+zpkbKu21d2Vb4wIMwrEe7nt2JKC4O8WV9gP37j3VbRZO+101
 8pxOqjxZNFsA==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="427756521"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 20:15:51 -0700
Subject: Re: [PATCH v4 23/25] perf tests: Support 'Session topology' test for
 hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-24-yao.jin@linux.intel.com> <YIBu7gUSTqremQ2K@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <fb105c0c-1a4f-de24-093e-02cf1211bd93@linux.intel.com>
Date:   Thu, 22 Apr 2021 11:15:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBu7gUSTqremQ2K@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:15PM +0800, Jin Yao wrote:
>> Force to create one event "cpu_core/cycles/" by default,
>> otherwise in evlist__valid_sample_type, the checking of
>> 'if (evlist->core.nr_entries == 1)' would be failed.
>>
>>    # ./perf test 41
>>    41: Session topology                                                : Ok
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/tests/topology.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
>> index 050489807a47..30b4acb08d35 100644
>> --- a/tools/perf/tests/topology.c
>> +++ b/tools/perf/tests/topology.c
>> @@ -8,6 +8,7 @@
>>   #include "session.h"
>>   #include "evlist.h"
>>   #include "debug.h"
>> +#include "pmu.h"
>>   #include <linux/err.h>
>>   
>>   #define TEMPL "/tmp/perf-test-XXXXXX"
>> @@ -40,7 +41,14 @@ static int session_write_header(char *path)
>>   	session = perf_session__new(&data, false, NULL);
>>   	TEST_ASSERT_VAL("can't get session", !IS_ERR(session));
>>   
>> -	session->evlist = evlist__new_default();
>> +	if (!perf_pmu__has_hybrid()) {
>> +		session->evlist = evlist__new_default();
>> +	} else {
>> +		struct parse_events_error err;
>> +
>> +		session->evlist = evlist__new();
> 
> you should ASSERT session->evlist in here
> 
> jirka
> 

OK, will add "ASSERT session->evlist" in next version.

Thanks
Jin Yao

>> +		parse_events(session->evlist, "cpu_core/cycles/", &err);
>> +	}
>>   	TEST_ASSERT_VAL("can't get evlist", session->evlist);
>>   
>>   	perf_header__set_feat(&session->header, HEADER_CPU_TOPOLOGY);
>> -- 
>> 2.17.1
>>
> 
