Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E63379BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 03:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhEKBHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 21:07:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:26887 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhEKBHF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 21:07:05 -0400
IronPort-SDR: nbTtxPO4RufAUq5mrGrFwKdcuQgMk5pPOhtipduQ8L4yiaTnCuynnCtUh0dCo58k6s7fADbO84
 RQST5NY9ZRKA==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260589852"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="260589852"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 18:05:59 -0700
IronPort-SDR: cn6mZp9Rq541Qwp1ArrKZ0No10NFgU3COA0DaWzvJRZdlZe4/calH5eNDb0d6rgoE+s9a7sZ4U
 M4Hd63/TVPJg==
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; 
   d="scan'208";a="436394540"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 18:05:57 -0700
Subject: Re: [PATCH v2 1/3] perf header: Support HYBRID_TOPOLOGY feature
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210507035230.3079-1-yao.jin@linux.intel.com>
 <20210507035230.3079-2-yao.jin@linux.intel.com> <YJkxF8bycH8+w+N+@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <1a6a4580-598a-6774-74c1-58c04c2d3ad2@linux.intel.com>
Date:   Tue, 11 May 2021 09:05:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJkxF8bycH8+w+N+@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/10/2021 9:11 PM, Jiri Olsa wrote:
> On Fri, May 07, 2021 at 11:52:28AM +0800, Jin Yao wrote:
>> It would be useful to let user know the hybrid topology.
>> Adding HYBRID_TOPOLOGY feature in header to indicate the
>> core cpus and the atom cpus.
>>
>> With this patch,
>>
>> For the perf.data generated on hybrid platform,
>> reports the hybrid cpu list.
>>
>>    root@otcpl-adl-s-2:~# perf report --header-only -I
>>    ...
>>    # hybrid cpu system:
>>    # cpu_core cpu list : 0-15
>>    # cpu_atom cpu list : 16-23
>>
>> For the perf.data generated on non-hybrid platform,
>> reports the message that HYBRID_TOPOLOGY is missing.
>>
>>    root@kbl-ppc:~# perf report --header-only -I
>>    ...
>>    # missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   .../Documentation/perf.data-file-format.txt   | 14 +++
>>   tools/perf/util/cputopo.c                     | 80 +++++++++++++++++
>>   tools/perf/util/cputopo.h                     | 13 +++
>>   tools/perf/util/env.c                         |  6 ++
>>   tools/perf/util/env.h                         |  7 ++
>>   tools/perf/util/header.c                      | 87 +++++++++++++++++++
>>   tools/perf/util/header.h                      |  1 +
>>   tools/perf/util/pmu-hybrid.h                  | 11 +++
>>   8 files changed, 219 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
>> index 9ee96640744e..d9d82ca8aeb7 100644
>> --- a/tools/perf/Documentation/perf.data-file-format.txt
>> +++ b/tools/perf/Documentation/perf.data-file-format.txt
>> @@ -402,6 +402,20 @@ struct {
>>   	u64 clockid_time_ns;
>>   };
>>   
>> +	HEADER_HYBRID_TOPOLOGY = 30,
>> +
>> +Indicate the hybrid CPUs. The format of data is as below.
>> +
>> +struct {
>> +	char *pmu_name;
>> +	char *cpus;
>> +};
> 
> this is missing the nr count, should be like:
> 
> struct {
> 	u32 nr;
> 	struct {
> 	     char *pmu_name;
> 	     char *cpus;
> 	} [nr]
> }
> 
> jirka
> 

Yes, we should say the format of data is:

struct {
	u32 nr;
	struct {
		char *pmu_name;
		char *cpus;
	} [nr]
}

I will update 'perf.data-file-format.txt' in v3.

Thanks
Jin Yao
