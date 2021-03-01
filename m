Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7C7327CF1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhCALR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 06:17:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:25326 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232033AbhCALR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 06:17:56 -0500
IronPort-SDR: zZIFKygTmlWuI2h6OpIkQSAKH4SzqQkKNGe+pOscLGWnPZ4npVQFjMo1TnTVgDV+amPYjrRZVX
 NId7IOu18uTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="206035612"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="206035612"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 03:16:10 -0800
IronPort-SDR: 8kpapafSxW/FY0BkiQkWd6121dmlKLANMD+R/FV1oDkMtDB5q0QXboLWM8G24sUUOuZJTb930R
 llG83deb8Eaw==
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="406180903"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.226.70]) ([10.249.226.70])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 03:16:07 -0800
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [PATCH v3 07/12] perf record: init data file at mmap buffer
 object
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
 <ad205903-41a6-5041-f4f3-6f57d83cbd3a@linux.intel.com>
 <20201120104942.GF94830@google.com>
Organization: Intel Corporation
To:     Namhyung Kim <namhyung@kernel.org>,
        Alexei Budankov <abudankov@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Message-ID: <64b0859f-aad3-43fa-4e4c-81614d0c75e4@linux.intel.com>
Date:   Mon, 1 Mar 2021 14:16:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20201120104942.GF94830@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20.11.2020 13:49, Namhyung Kim wrote:
> On Mon, Nov 16, 2020 at 03:19:41PM +0300, Alexey Budankov wrote:

<SNIP>

>>  
>> @@ -1400,8 +1417,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>>  	/*
>>  	 * Mark the round finished in case we wrote
>>  	 * at least one event.
>> +	 *
>> +	 * No need for round events in directory mode,
>> +	 * because per-cpu maps and files have data
>> +	 * sorted by kernel.
> 
> But it's not just for single cpu since task can migrate so we need to
> look at other cpu's data too.  Thus we use the ordered events queue
> and round events help to determine when to flush the data.  Without
> the round events, it'd consume huge amount of memory during report.
> 
> If we separate tracking records and process them first, we should be
> able to process samples immediately without sorting them in the
> ordered event queue.  This will save both cpu cycles and memory
> footprint significantly IMHO.
> 
> Thanks,
> Namhyung
> 

As far as I understand, to split tracing records (FORK/MMAP/COMM) into
a separate file, we need to implement a runtime trace decoder on the
perf-record side to recognize such tracing records coming from the kernel.
Is that what you mean?

IMHO this can be tricky to implement and adds some overhead that can lead
to possible data loss. Do you have any other ideas how to optimize memory
consumption on perf-report side without a runtime trace decoder?
Maybe "round events" would somehow help in directory mode?

BTW In our tool we use another approach: two-pass trace file loading. 
The first loads tracing records, the second loads samples. 

Thanks,
Alexey

> 
>>  	 */
>> -	if (bytes_written != rec->bytes_written)
>> +	if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
>>  		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
>>  
>>  	if (overwrite)
>> @@ -1514,7 +1535,9 @@ static void record__init_features(struct record *rec)
>>  	if (!rec->opts.use_clockid)
>>  		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
>>  
>> -	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
>> +	if (!record__threads_enabled(rec))
>> +		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
>> +
>>  	if (!record__comp_enabled(rec))
>>  		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
>>  
>> @@ -1525,15 +1548,21 @@ static void
>>  record__finish_output(struct record *rec)
>>  {
>>  	struct perf_data *data = &rec->data;
>> -	int fd = perf_data__fd(data);
>> +	int i, fd = perf_data__fd(data);
>>  
>>  	if (data->is_pipe)
>>  		return;
>>  
>>  	rec->session->header.data_size += rec->bytes_written;
>>  	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
>> +	if (record__threads_enabled(rec)) {
>> +		for (i = 0; i < data->dir.nr; i++)
>> +			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
>> +	}
>>  
>>  	if (!rec->no_buildid) {
>> +		/* this will be recalculated during process_buildids() */
>> +		rec->samples = 0;
>>  		process_buildids(rec);
>>  
>>  		if (rec->buildid_all)
>> @@ -2438,8 +2467,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>>  		status = err;
>>  
>>  	record__synthesize(rec, true);
>> -	/* this will be recalculated during process_buildids() */
>> -	rec->samples = 0;
>>  
>>  	if (!err) {
>>  		if (!rec->timestamp_filename) {
>> @@ -3179,7 +3206,7 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	}
>>  
>> -	if (rec->opts.kcore)
>> +	if (rec->opts.kcore || record__threads_enabled(rec))
>>  		rec->data.is_dir = true;
>>  
>>  	if (rec->opts.comp_level != 0) {
>> diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
>> index 266760ac9143..9c13a39cc58f 100644
>> --- a/tools/perf/util/record.h
>> +++ b/tools/perf/util/record.h
>> @@ -74,6 +74,7 @@ struct record_opts {
>>  	int	      ctl_fd;
>>  	int	      ctl_fd_ack;
>>  	bool	      ctl_fd_close;
>> +	int	      threads_spec;
>>  };
>>  
>>  extern const char * const *record_usage;
>> -- 
>> 2.24.1
>>
