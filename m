Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0351B396A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 03:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhFABM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 21:12:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:47811 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232035AbhFABMZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 21:12:25 -0400
IronPort-SDR: 64CXarezPhvqoZ38I56d/gz1OGFbM88T+QLBvDma5WSt7Rl95UPnV/pXLuOfaKX2uQ10ChlpBE
 qyr6grbRnnlA==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="190807171"
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="190807171"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 18:10:44 -0700
IronPort-SDR: qxQbP9BeU7vjr9yeqoYX2lRNZxV8u9WKH5uJ/n2X1eJuol6FRE1AZMUqeGukZ/9GZOI+m4pCzf
 Me6dp4Xq8cHg==
X-IronPort-AV: E=Sophos;i="5.83,238,1616482800"; 
   d="scan'208";a="479081990"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 18:10:41 -0700
Subject: Re: [PATCH v2 6/8] perf mem: Fix wrong verbose output for recording
 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210527001610.10553-1-yao.jin@linux.intel.com>
 <20210527001610.10553-7-yao.jin@linux.intel.com> <YLVmVBDKGkSWgHwR@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3627ceef-fc72-1951-c1b6-4c59525a1afa@linux.intel.com>
Date:   Tue, 1 Jun 2021 09:10:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLVmVBDKGkSWgHwR@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 6/1/2021 6:42 AM, Jiri Olsa wrote:
> On Thu, May 27, 2021 at 08:16:08AM +0800, Jin Yao wrote:
>> Current code:
>>
>> for (j = 0; j < argc; j++, i++)
>>          rec_argv[i] = argv[j];
>>
>> if (verbose > 0) {
>>          pr_debug("calling: record ");
>>
>>          while (rec_argv[j]) {
>>                  pr_debug("%s ", rec_argv[j]);
>>                  j++;
>>          }
>>          pr_debug("\n");
>> }
>>
>> The entries of argv[] are copied to the end of rec_argv[], not
>> copied to the beginning of rec_argv[]. So the index j at
>> rec_argv[] doesn't point to the first event.
>>
>> Now we record the start index and end index for events in rec_argv[],
>> and print them if verbose is enabled.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>> v2:
>>   - New in v2.
>>
>>   tools/perf/builtin-mem.c | 8 +++++---
> 
> hi,
> do we need the same in c2c as well?
> 
> jirka
> 

perf c2c is a bit different. It sets 'j = 0;' before 'while' loop so it prints all of rec_argv[].

In test,

# perf c2c record -vvv -a -- sleep 1

calling: record -W -d --phys-data --sample-cpu -e 
{cpu_core/mem-loads-aux/,cpu_core/mem-loads,ldlat=30/}:P -e cpu_atom/mem-loads,ldlat=30/P -e 
cpu_core/mem-stores/P -e cpu_atom/mem-stores/P -a sleep 1

The verbose output looks OK.

Thanks
Jin Yao

>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
>> index 6b633df458c2..0fd2a74dbaca 100644
>> --- a/tools/perf/builtin-mem.c
>> +++ b/tools/perf/builtin-mem.c
>> @@ -65,6 +65,7 @@ static const char * const *record_mem_usage = __usage;
>>   static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   {
>>   	int rec_argc, i = 0, j, tmp_nr = 0;
>> +	int start, end;
>>   	const char **rec_argv;
>>   	char **rec_tmp;
>>   	int ret;
>> @@ -144,9 +145,11 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   	if (mem->data_page_size)
>>   		rec_argv[i++] = "--data-page-size";
>>   
>> +	start = i;
>>   	ret = perf_mem_events__record_args(rec_argv, &i, rec_tmp, &tmp_nr);
>>   	if (ret)
>>   		goto out;
>> +	end = i;
>>   
>>   	if (all_user)
>>   		rec_argv[i++] = "--all-user";
>> @@ -160,10 +163,9 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
>>   	if (verbose > 0) {
>>   		pr_debug("calling: record ");
>>   
>> -		while (rec_argv[j]) {
>> +		for (j = start; j < end; j++)
>>   			pr_debug("%s ", rec_argv[j]);
>> -			j++;
>> -		}
>> +
>>   		pr_debug("\n");
>>   	}
>>   
>> -- 
>> 2.17.1
>>
> 
