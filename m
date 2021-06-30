Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEE83B81EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbhF3MV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:21:57 -0400
Received: from mga06.intel.com ([134.134.136.31]:59496 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234414AbhF3MVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:21:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="269470509"
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="269470509"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:19:26 -0700
X-IronPort-AV: E=Sophos;i="5.83,311,1616482800"; 
   d="scan'208";a="457211794"
Received: from abaydur-mobl1.ccr.corp.intel.com (HELO [10.249.227.67]) ([10.249.227.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:19:22 -0700
Subject: Re: [PATCH v7 07/20] perf record: Introduce data transferred and
 compressed stats
To:     Riccardo Mancini <rickyman7@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>
References: <cover.1624350588.git.alexey.v.bayduraev@linux.intel.com>
 <138f94642ae93f526249f6320abdc41ab90b467b.1624350588.git.alexey.v.bayduraev@linux.intel.com>
 <565db357cfe61c4b350323968aee15bd477ef606.camel@gmail.com>
From:   "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Organization: Intel Corporation
Message-ID: <b42361e7-ebe8-5f95-3e62-a31ed6b0be04@linux.intel.com>
Date:   Wed, 30 Jun 2021 15:19:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <565db357cfe61c4b350323968aee15bd477ef606.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On 30.06.2021 11:05, Riccardo Mancini wrote:
> Hi,
> 
> On Tue, 2021-06-22 at 11:42 +0300, Alexey Bayduraev wrote:
>> Introduce bytes_transferred and bytes_compressed stats so they
>> would capture statistics for the related data buffer transfers.
>>
>> Acked-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
>> ---
>>  tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++--------
>>  tools/perf/util/mmap.h      |  3 ++
>>  2 files changed, 54 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 38bb5afbb359..c9fd31211600 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -198,6 +198,11 @@ static int record__write(struct record *rec, struct mmap
>> *map __maybe_unused,
>>                 return -1;
>>         }
>>  
>> +       if (map && map->file) {
>> +               map->bytes_written += size;
>> +               return 0;
>> +       }
>> +
>>         rec->bytes_written += size;
>>  
>>         if (record__output_max_size_exceeded(rec) && !done) {
> 
> This breaks the --max-size option in parallel trace mode.
> Maybe, we could change record__output_max_size_exceeded to check all
> thread_data->maps and sum up bytes_written. Concurrency should not be an issue
> since it's not required to stop at exactly the max-size (this is also the
> current behaviour).
> Otherwise, we could atomically increase an accumulator inside struct record
> (maybe rec->bytes_written could be reused, but I'm not sure if it's used by the
> main thread in the parallel mode), and check it for exceeded max size.

Thanks, currently threaded mode doesn't use rec->bytes_written and atomic64_t
framework is not available in kernel/tools.
I think better is to calculate sum of map->bytes_written like for threads 
statistics.

Regards,
Alexey

> 
> Thanks,
> Riccardo
> 
> 
>> @@ -215,8 +220,8 @@ static int record__write(struct record *rec, struct mmap
>> *map __maybe_unused,
>>  
>>  static int record__aio_enabled(struct record *rec);
>>  static int record__comp_enabled(struct record *rec);
>> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t
>> dst_size,
>> -                           void *src, size_t src_size);
>> +static size_t zstd_compress(struct zstd_data *data,
>> +                           void *dst, size_t dst_size, void *src, size_t
>> src_size);
>>  
>>  #ifdef HAVE_AIO_SUPPORT
>>  static int record__aio_write(struct aiocb *cblock, int trace_fd,
>> @@ -350,9 +355,13 @@ static int record__aio_pushfn(struct mmap *map, void *to,
>> void *buf, size_t size
>>          */
>>  
>>         if (record__comp_enabled(aio->rec)) {
>> -               size = zstd_compress(aio->rec->session, aio->data + aio->size,
>> -                                    mmap__mmap_len(map) - aio->size,
>> +               struct zstd_data *zstd_data = &aio->rec->session->zstd_data;
>> +
>> +               aio->rec->session->bytes_transferred += size;
>> +               size = zstd_compress(zstd_data,
>> +                                    aio->data + aio->size,
>> mmap__mmap_len(map) - aio->size,
>>                                      buf, size);
>> +               aio->rec->session->bytes_compressed += size;
>>         } else {
>>                 memcpy(aio->data + aio->size, buf, size);
>>         }
>> @@ -577,8 +586,22 @@ static int record__pushfn(struct mmap *map, void *to,
>> void *bf, size_t size)
>>         struct record *rec = to;
>>  
>>         if (record__comp_enabled(rec)) {
>> -               size = zstd_compress(rec->session, map->data,
>> mmap__mmap_len(map), bf, size);
>> +               struct zstd_data *zstd_data = &rec->session->zstd_data;
>> +
>> +               if (map->file) {
>> +                       zstd_data = &map->zstd_data;
>> +                       map->bytes_transferred += size;
>> +               } else {
>> +                       rec->session->bytes_transferred += size;
>> +               }
>> +
>> +               size = zstd_compress(zstd_data, map->data,
>> mmap__mmap_len(map), bf, size);
>>                 bf   = map->data;
>> +
>> +               if (map->file)
>> +                       map->bytes_compressed += size;
>> +               else
>> +                       rec->session->bytes_compressed += size;
>>         }
>>  
>>         thread->samples++;
>> @@ -1311,18 +1334,15 @@ static size_t process_comp_header(void *record, size_t
>> increment)
>>         return size;
>>  }
>>  
>> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t
>> dst_size,
>> +static size_t zstd_compress(struct zstd_data *zstd_data, void *dst, size_t
>> dst_size,
>>                             void *src, size_t src_size)
>>  {
>>         size_t compressed;
>>         size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct
>> perf_record_compressed) - 1;
>>  
>> -       compressed = zstd_compress_stream_to_records(&session->zstd_data, dst,
>> dst_size, src, src_size,
>> +       compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size,
>> src, src_size,
>>                                                      max_record_size,
>> process_comp_header);
>>  
>> -       session->bytes_transferred += src_size;
>> -       session->bytes_compressed  += compressed;
>> -
>>         return compressed;
>>  }
>>  
>> @@ -2006,8 +2026,10 @@ static int record__start_threads(struct record *rec)
>>  
>>  static int record__stop_threads(struct record *rec, unsigned long *waking)
>>  {
>> -       int t;
>> +       int t, tm;
>> +       struct mmap *map, *overwrite_map;
>>         struct thread_data *thread_data = rec->thread_data;
>> +       u64 bytes_written = 0, bytes_transferred = 0, bytes_compressed = 0;
>>  
>>         for (t = 1; t < rec->nr_threads; t++)
>>                 record__terminate_thread(&thread_data[t]);
>> @@ -2015,9 +2037,25 @@ static int record__stop_threads(struct record *rec,
>> unsigned long *waking)
>>         for (t = 0; t < rec->nr_threads; t++) {
>>                 rec->samples += thread_data[t].samples;
>>                 *waking += thread_data[t].waking;
>> -               pr_debug("threads[%d]: samples=%lld, wakes=%ld,
>> trasferred=%ld, compressed=%ld\n",
>> +               for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
>> +                       if (thread_data[t].maps) {
>> +                               map = thread_data[t].maps[tm];
>> +                               bytes_transferred += map->bytes_transferred;
>> +                               bytes_compressed += map->bytes_compressed;
>> +                               bytes_written += map->bytes_written;
>> +                       }
>> +                       if (thread_data[t].overwrite_maps) {
>> +                               overwrite_map =
>> thread_data[t].overwrite_maps[tm];
>> +                               bytes_transferred += overwrite_map-
>>> bytes_transferred;
>> +                               bytes_compressed += overwrite_map-
>>> bytes_compressed;
>> +                               bytes_written += overwrite_map->bytes_written;
>> +                       }
>> +               }
>> +               rec->session->bytes_transferred += bytes_transferred;
>> +               rec->session->bytes_compressed += bytes_compressed;
>> +               pr_debug("threads[%d]: samples=%lld, wakes=%ld,
>> trasferred=%ld, compressed=%ld, written=%ld\n",
>>                          thread_data[t].tid, thread_data[t].samples,
>> thread_data[t].waking,
>> -                        rec->session->bytes_transferred, rec->session-
>>> bytes_compressed);
>> +                        bytes_transferred, bytes_compressed, bytes_written);
>>         }
>>  
>>         return 0;
>> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
>> index c4aed6e89549..c04ca4b5adf5 100644
>> --- a/tools/perf/util/mmap.h
>> +++ b/tools/perf/util/mmap.h
>> @@ -46,6 +46,9 @@ struct mmap {
>>         int             comp_level;
>>         struct perf_data_file *file;
>>         struct zstd_data      zstd_data;
>> +       u64                   bytes_transferred;
>> +       u64                   bytes_compressed;
>> +       u64                   bytes_written;
>>  };
>>  
>>  struct mmap_params {
> 
> 
