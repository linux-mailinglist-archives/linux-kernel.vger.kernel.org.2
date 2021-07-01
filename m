Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F573B94C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGAQn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 12:43:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:10380 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhGAQnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 12:43:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="195858618"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="195858618"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 09:41:24 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="457729529"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.231.202]) ([10.249.231.202])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 09:41:20 -0700
Subject: Re: [PATCH v8 06/22] perf record: Introduce data file at mmap buffer
 object
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <ace86f5d00ddb901a79196bb1863ed1395c408fd.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <YNyodxMjNEHjAaFW@kernel.org>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <2240e335-9991-8792-7437-c3ec88f6a7a2@linux.intel.com>
Date:   Thu, 1 Jul 2021 19:41:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNyodxMjNEHjAaFW@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30.06.2021 20:23, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 30, 2021 at 06:54:45PM +0300, Alexey Bayduraev escreveu:
>> Introduce data file and compressor objects into mmap object so
>> they could be used to process and store data stream from the
>> corresponding kernel data buffer. Make use of the introduced
>> per mmap file and compressor when they are initialized and
>> available.
> 
> So you're introducing even compressed storage in this patchset? To make
> it smaller I thought this could be in a followup cset.

These patches were slit by request from Jiri:

Changes in v5:
- split patch 06/12 to 06/20 and 07/20

request:
https://lore.kernel.org/lkml/YG97LMsttP4VEWPU@krava/

And I'm a bit confused :)

Regards,
Alexey

> 
> - Arnaldo
>  
>> Acked-by: Andi Kleen <ak@linux.intel.com>
>> Acked-by: Namhyung Kim <namhyung@gmail.com>
>> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 3 +++
>>  tools/perf/util/mmap.c      | 6 ++++++
>>  tools/perf/util/mmap.h      | 3 +++
>>  3 files changed, 12 insertions(+)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index cead2b3c56d7..9b7e7a5dc116 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -190,6 +190,9 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>>  {
>>  	struct perf_data_file *file = &rec->session->data->file;
>>  
>> +	if (map && map->file)
>> +		file = map->file;
>> +
>>  	if (perf_data_file__write(file, bf, size) < 0) {
>>  		pr_err("failed to write perf data, error: %m\n");
>>  		return -1;
>> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
>> index ab7108d22428..a2c5e4237592 100644
>> --- a/tools/perf/util/mmap.c
>> +++ b/tools/perf/util/mmap.c
>> @@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
>>  {
>>  	bitmap_free(map->affinity_mask.bits);
>>  
>> +	zstd_fini(&map->zstd_data);
>> +
>>  	perf_mmap__aio_munmap(map);
>>  	if (map->data != NULL) {
>>  		munmap(map->data, mmap__mmap_len(map));
>> @@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>>  	map->core.flush = mp->flush;
>>  
>>  	map->comp_level = mp->comp_level;
>> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
>> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
>> +		return -1;
>> +	}
>>  
>>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index 9d5f589f02ae..c4aed6e89549 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -13,6 +13,7 @@
>>  #endif
>>  #include "auxtrace.h"
>>  #include "event.h"
>> +#include "util/compress.h"
>>  
>>  struct aiocb;
>>  
>> @@ -43,6 +44,8 @@ struct mmap {
>>  	struct mmap_cpu_mask	affinity_mask;
>>  	void		*data;
>>  	int		comp_level;
>> +	struct perf_data_file *file;
>> +	struct zstd_data      zstd_data;
>>  };
>>  
>>  struct mmap_params {
>> -- 
>> 2.19.0
>>
> 
