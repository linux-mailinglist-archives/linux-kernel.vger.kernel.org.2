Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65E3358F7E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhDHVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:53:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232704AbhDHVxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:53:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617918772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iI+fphev46QXH6YlfSl18YL/dnHeRQMS5eGheWQiTX8=;
        b=NSjPHhc4izyIY/jLm9zVQFQKtfiR70oWlEnwxOYfamy9gQDmPc7+iGFk4FF/45Vtki00vC
        a+XFutBXYjAT2f0PnIdkM2H1sm03TxDcC3zKVemUv4qqvIPEkso0hPGFbex/YnSgtjTh6g
        27lSGyvJzfBjq5ZooIoD6Z0YCg5Kmdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-UenlYvp0M2qCb8NS-cDHAQ-1; Thu, 08 Apr 2021 17:52:48 -0400
X-MC-Unique: UenlYvp0M2qCb8NS-cDHAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B8E881744F;
        Thu,  8 Apr 2021 21:52:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0A2EA101E5AF;
        Thu,  8 Apr 2021 21:52:44 +0000 (UTC)
Date:   Thu, 8 Apr 2021 23:52:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
Subject: Re: [PATCH v4 06/12] perf record: introduce data file at mmap buffer
 object
Message-ID: <YG97LMsttP4VEWPU@krava>
References: <6c15adcb-6a9d-320e-70b5-957c4c8b6ff2@linux.intel.com>
 <f52da8db-beb8-ec63-56aa-ce6def088951@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52da8db-beb8-ec63-56aa-ce6def088951@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 11:47:03AM +0300, Bayduraev, Alexey V wrote:
> 
> Introduce data file and compressor objects into mmap object so
> they could be used to process and store data stream from the
> corresponding kernel data buffer. Introduce bytes_transferred
> and bytes_compressed stats so they would capture statistics for
> the related data buffer transfers. Make use of the introduced
> per mmap file, compressor and stats when they are initialized
> and available.
> 
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++--------
>  tools/perf/util/mmap.c      |  6 ++++
>  tools/perf/util/mmap.h      |  6 ++++
>  3 files changed, 63 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 339198b2e37d..3947c60d905b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -188,11 +188,19 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  {
>  	struct perf_data_file *file = &rec->session->data->file;
>  
> +	if (map && map->file)
> +		file = map->file;
> +
>  	if (perf_data_file__write(file, bf, size) < 0) {
>  		pr_err("failed to write perf data, error: %m\n");
>  		return -1;
>  	}
>  
> +	if (map && map->file) {
> +		map->bytes_written += size;
> +		return 0;
> +	}
> +
>  	rec->bytes_written += size;

hi,
please move the compressed data stats stuff in separated patch

thanks,
jirka


>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
> @@ -210,8 +218,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  
>  static int record__aio_enabled(struct record *rec);
>  static int record__comp_enabled(struct record *rec);
> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
> -			    void *src, size_t src_size);
> +static size_t zstd_compress(struct zstd_data *data,
> +			    void *dst, size_t dst_size, void *src, size_t src_size);
>  
>  #ifdef HAVE_AIO_SUPPORT
>  static int record__aio_write(struct aiocb *cblock, int trace_fd,
> @@ -345,9 +353,13 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
>  	 */
>  
>  	if (record__comp_enabled(aio->rec)) {
> -		size = zstd_compress(aio->rec->session, aio->data + aio->size,
> -				     mmap__mmap_len(map) - aio->size,
> +		struct zstd_data *zstd_data = &aio->rec->session->zstd_data;
> +
> +		aio->rec->session->bytes_transferred += size;
> +		size = zstd_compress(zstd_data,
> +				     aio->data + aio->size, mmap__mmap_len(map) - aio->size,
>  				     buf, size);
> +		aio->rec->session->bytes_compressed += size;
>  	} else {
>  		memcpy(aio->data + aio->size, buf, size);
>  	}
> @@ -572,8 +584,22 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  	struct record *rec = to;
>  
>  	if (record__comp_enabled(rec)) {
> -		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
> +		struct zstd_data *zstd_data = &rec->session->zstd_data;
> +
> +		if (map->file) {
> +			zstd_data = &map->zstd_data;
> +			map->bytes_transferred += size;
> +		} else {
> +			rec->session->bytes_transferred += size;
> +		}
> +
> +		size = zstd_compress(zstd_data, map->data, mmap__mmap_len(map), bf, size);
>  		bf   = map->data;
> +
> +		if (map->file)
> +			map->bytes_compressed += size;
> +		else
> +			rec->session->bytes_compressed += size;
>  	}
>  
>  	thread->samples++;
> @@ -1297,18 +1323,15 @@ static size_t process_comp_header(void *record, size_t increment)
>  	return size;
>  }
>  
> -static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
> +static size_t zstd_compress(struct zstd_data *zstd_data, void *dst, size_t dst_size,
>  			    void *src, size_t src_size)
>  {
>  	size_t compressed;
>  	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
>  
> -	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
> +	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
>  						     max_record_size, process_comp_header);
>  
> -	session->bytes_transferred += src_size;
> -	session->bytes_compressed  += compressed;
> -
>  	return compressed;
>  }
>  
> @@ -1961,8 +1984,9 @@ static int record__start_threads(struct record *rec)
>  
>  static int record__stop_threads(struct record *rec, unsigned long *waking)
>  {
> -	int t;
> +	int t, tm;
>  	struct thread_data *thread_data = rec->thread_data;
> +	u64 bytes_written = 0, bytes_transferred = 0, bytes_compressed = 0;
>  
>  	for (t = 1; t < rec->nr_threads; t++)
>  		record__terminate_thread(&thread_data[t]);
> @@ -1970,9 +1994,23 @@ static int record__stop_threads(struct record *rec, unsigned long *waking)
>  	for (t = 0; t < rec->nr_threads; t++) {
>  		rec->samples += thread_data[t].samples;
>  		*waking += thread_data[t].waking;
> -		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld\n",
> +		for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
> +			if (thread_data[t].maps) {
> +				bytes_transferred += thread_data[t].maps[tm]->bytes_transferred;
> +				bytes_compressed += thread_data[t].maps[tm]->bytes_compressed;
> +				bytes_written += thread_data[t].maps[tm]->bytes_written;
> +			}
> +			if (thread_data[t].overwrite_maps) {
> +				bytes_transferred += thread_data[t].overwrite_maps[tm]->bytes_transferred;
> +				bytes_compressed += thread_data[t].overwrite_maps[tm]->bytes_compressed;
> +				bytes_written += thread_data[t].overwrite_maps[tm]->bytes_written;
> +			}
> +		}
> +		rec->session->bytes_transferred += bytes_transferred;
> +		rec->session->bytes_compressed += bytes_compressed;
> +		pr_debug("threads[%d]: samples=%lld, wakes=%ld, trasferred=%ld, compressed=%ld, written=%ld\n",
>  			 thread_data[t].tid, thread_data[t].samples, thread_data[t].waking,
> -			 rec->session->bytes_transferred, rec->session->bytes_compressed);
> +			 bytes_transferred, bytes_compressed, bytes_written);
>  	}
>  
>  	return 0;
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index ab7108d22428..a2c5e4237592 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -230,6 +230,8 @@ void mmap__munmap(struct mmap *map)
>  {
>  	bitmap_free(map->affinity_mask.bits);
>  
> +	zstd_fini(&map->zstd_data);
> +
>  	perf_mmap__aio_munmap(map);
>  	if (map->data != NULL) {
>  		munmap(map->data, mmap__mmap_len(map));
> @@ -291,6 +293,10 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu)
>  	map->core.flush = mp->flush;
>  
>  	map->comp_level = mp->comp_level;
> +	if (zstd_init(&map->zstd_data, map->comp_level)) {
> +		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
> +		return -1;
> +	}
>  
>  	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
>  		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index 9d5f589f02ae..c04ca4b5adf5 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -13,6 +13,7 @@
>  #endif
>  #include "auxtrace.h"
>  #include "event.h"
> +#include "util/compress.h"
>  
>  struct aiocb;
>  
> @@ -43,6 +44,11 @@ struct mmap {
>  	struct mmap_cpu_mask	affinity_mask;
>  	void		*data;
>  	int		comp_level;
> +	struct perf_data_file *file;
> +	struct zstd_data      zstd_data;
> +	u64		      bytes_transferred;
> +	u64		      bytes_compressed;
> +	u64		      bytes_written;
>  };
>  
>  struct mmap_params {
> -- 
> 2.19.0
> 
> 

