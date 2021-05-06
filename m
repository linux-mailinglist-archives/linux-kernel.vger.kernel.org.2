Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394CB3753FE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 14:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhEFMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 08:45:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:39337 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhEFMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 08:45:00 -0400
IronPort-SDR: wX5Gd5BEVO4AIV9P9LiMP6pWXn32Q/FOTQFW8Eg2mvqWlUZmqE17YDP/1zaGi9y0Lc5Gl4aQk0
 sk/KGlFdv69w==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="198102181"
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="198102181"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 05:44:01 -0700
IronPort-SDR: OLM6QTvlzuf1+BZDVUO5NgH1Qd5eC2S+EMEpFLH+JX6zstRllxDgrra673sZvqgE7hc5GaiG02
 2qe8c57/35mQ==
X-IronPort-AV: E=Sophos;i="5.82,277,1613462400"; 
   d="scan'208";a="469436772"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.229.1]) ([10.249.229.1])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 05:43:57 -0700
Subject: Re: [PATCH v5 00/20] Introduce threaded trace streaming for basic
 perf record operation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
References: <cover.1619781188.git.alexey.v.bayduraev@linux.intel.com>
 <CAM9d7citW_NGb0vjMM2ytp=Mbq5YNe4GEaWspEkMGf=KAm+ugw@mail.gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <9f178dde-751f-9ac9-f5a0-fd1bfba3ca32@linux.intel.com>
Date:   Thu, 6 May 2021 15:43:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7citW_NGb0vjMM2ytp=Mbq5YNe4GEaWspEkMGf=KAm+ugw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06.05.2021 9:20, Namhyung Kim wrote:
> Hello,
> 
> On Tue, May 4, 2021 at 12:05 AM Alexey Bayduraev
> <alexey.v.bayduraev@linux.intel.com> wrote:
>>
<SNIP>>>
>> Basic analysis of data directories is provided in perf report mode.
>> Raw dump and aggregated reports are available for data directories,
>> still with no memory consumption optimizations.
> 
> Do you have an idea how to improve it?
> 
> I have to say again that I don't like merely adding more threads to
> record.  Yeah, parallelizing the perf record is good, but we have to
> think about the perf report (and others) too.

There is your idea about separating tracking records and process them 
first, but these changes can be much larger than my patch and I think 
they looks like independent patch and could be introduced as extension 
of parallel data loading.

I also thought and experimented with the intermediate flushing of 
the ordered queue. This is simple for per-cpu data files (sorted 
by time), but not clear for arbitrary CPU masks.

I think my patch can be the first step to introduce parallel mode 
to the perf tool. It just extends perf-record (already used in our 
vtune tool) and allows to load parallel data in experimental mode. 
Next patches could optimize and extend parallel data loading.

Regards,
Alexey

> 
> Thanks,
> Namhyung
> 
> 
>>
>> Tested:
>>
>> tools/perf/perf record -o prof.data --threads -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads= -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads=cpu -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads=core -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads=socket -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads=numa -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data -C 2,5 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data -C 3,4 --threads=0-3/3:4-7/4 -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=core -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data -C 0,4,2,6 --threads=numa -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads -g --call-graph dwarf,4096 --compression-level=3 -- matrix.gcc.g.O3
>> tools/perf/perf record -o prof.data --threads -a
>> tools/perf/perf record -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
>> tools/perf/perf record --threads -D -1 -e cpu-cycles -a --control fd:10,11 -- sleep 30
>>
>> tools/perf/perf report -i prof.data
>> tools/perf/perf report -i prof.data --call-graph=callee
>> tools/perf/perf report -i prof.data --stdio --header
>> tools/perf/perf report -i prof.data -D --header
>>
>> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
>> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
>>
>> ---
>>
>> Alexey Bayduraev (20):
>>   perf record: introduce thread affinity and mmap masks
>>   perf record: introduce thread specific data array
>>   perf record: introduce thread local variable
>>   perf record: stop threads in the end of trace streaming
>>   perf record: start threads in the beginning of trace streaming
>>   perf record: introduce data file at mmap buffer object
>>   perf record: introduce data transferred and compressed stats
>>   perf record: init data file at mmap buffer object
>>   tools lib: introduce bitmap_intersects() operation
>>   perf record: introduce --threads=<spec> command line option
>>   perf record: document parallel data streaming mode
>>   perf report: output data file name in raw trace dump
>>   perf session: move reader structure to the top
>>   perf session: introduce reader_state in reader object
>>   perf session: introduce reader objects in session object
>>   perf session: introduce decompressor into trace reader object
>>   perf session: move init into reader__init function
>>   perf session: move map/unmap into reader__mmap function
>>   perf session: load single file for analysis
>>   perf session: load data directory files for analysis
>>
>>  tools/include/linux/bitmap.h             |   11 +
>>  tools/lib/api/fd/array.c                 |   17 +
>>  tools/lib/api/fd/array.h                 |    1 +
>>  tools/lib/bitmap.c                       |   14 +
>>  tools/perf/Documentation/perf-record.txt |   30 +
>>  tools/perf/builtin-inject.c              |    3 +-
>>  tools/perf/builtin-record.c              | 1066 ++++++++++++++++++++--
>>  tools/perf/util/evlist.c                 |   16 +
>>  tools/perf/util/evlist.h                 |    1 +
>>  tools/perf/util/mmap.c                   |    6 +
>>  tools/perf/util/mmap.h                   |    6 +
>>  tools/perf/util/ordered-events.h         |    1 +
>>  tools/perf/util/record.h                 |    2 +
>>  tools/perf/util/session.c                |  491 +++++++---
>>  tools/perf/util/session.h                |    5 +
>>  tools/perf/util/tool.h                   |    3 +-
>>  16 files changed, 1474 insertions(+), 199 deletions(-)
>>
>> --
>> 2.19.0
>>
