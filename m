Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554BE41150C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhITM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:56:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:9505 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238815AbhITM4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:56:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="284136030"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="284136030"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 05:54:39 -0700
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="548698090"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.227.77]) ([10.249.227.77])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 05:54:36 -0700
Subject: Re: [PATCH v11 09/24] perf record: Introduce bytes written stats to
 support --max-size option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <c5c886094b1657328c7ec030da140b329282ebb7.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <YT5nKWqAhUVFiaEn@krava>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <88975265-4e15-3a49-547b-c2f7dd067ac2@linux.intel.com>
Date:   Mon, 20 Sep 2021 15:54:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YT5nKWqAhUVFiaEn@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.09.2021 23:46, Jiri Olsa wrote:
> On Tue, Aug 17, 2021 at 11:23:12AM +0300, Alexey Bayduraev wrote:

<SNIP>

>>  static bool record__output_max_size_exceeded(struct record *rec)
>>  {
>>  	return rec->output_max_size &&
>> -	       (rec->bytes_written >= rec->output_max_size);
>> +	       (record__bytes_written(rec) >= rec->output_max_size);
>>  }
>>  
>>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>> @@ -205,15 +223,21 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>>  		return -1;
>>  	}
>>  
>> -	rec->bytes_written += size;
>> +	if (map && map->file)
>> +		map->bytes_written += size;
> 
> could we instead have bytes_written in thread data? so we don't
> need to iterate all the maps?

Hi,

As I remember the main issue is that bytes_written should be atomic64_t.
Unfortunately we don't have atomic64 framework in tools/lib (even 
atomic32_add is missing). Thus I decided to calculate total size on each 
iteration. But I think your suggestion to move record__output_max_size_exceeded 
to trigger framework is better.

> 
>> +	else
>> +		rec->bytes_written += size;
>>  
>>  	if (record__output_max_size_exceeded(rec) && !done) {
>>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>>  				" stopping session ]\n",
>> -				rec->bytes_written >> 10);
>> +				record__bytes_written(rec) >> 10);
> 
> you're calling record__bytes_written twice.. could we just save the
> bytes_written from the first call and use it in the printf?
> 
>>  		done = 1;
>>  	}
>>  
>> +	if (map && map->file)
>> +		return 0;
> 
> please make comment why quit in here, we don't support switch-output for
> threads?

Yes, parallel streaming mode doesn't support switch-output and there is 
a special warning in [PATCH v11 14/24]

Thanks,
Alexey


> 
> jirka
> 
>> +
>>  	if (switch_output_size(rec))
>>  		trigger_hit(&switch_output_trigger);
>>  
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index c4aed6e89549..67d41003d82e 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -46,6 +46,7 @@ struct mmap {
>>  	int		comp_level;
>>  	struct perf_data_file *file;
>>  	struct zstd_data      zstd_data;
>> +	u64		      bytes_written;
>>  };
>>  
>>  struct mmap_params {
>> -- 
>> 2.19.0
>>
> 
