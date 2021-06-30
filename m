Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7803B87A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhF3RZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:25:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhF3RZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:25:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0821361483;
        Wed, 30 Jun 2021 17:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625073786;
        bh=GJUUx2Bds7F2Rna+cCsiZupJRnm2r6WUgsOR4AAFoGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cR+aJA/O6ngH1r8l5t0HOjaU1s0GU0NUDYefG8N+qcwbEZNj7KwVw0N047fjFXTQM
         H2Gyi+6efNgI3HtBPxKecE9QWpLpJtPDt30oI+zroyUmoMzQ7qxjuhzhzIHV1ZM0sq
         TrwtYw0I0a3p9PsPYN7LoIwG4f+DgKLe4zfA14JxYRhsAkqzGk/5j7UAtPivTHI6Dw
         m+eb5RIAwua+R3Mb1qj/HmrlWYv1/kslQNISmKo/WeoSgDIZeaRjPObhDLDhgr/hzH
         +Rj3wZ4QpTecbe4yOT42iBTKJJeRw0C/Rin7gEGkVfrLU9wI6SFV2V4r6FBntIFckN
         5K/mbyi3iiVIA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9D58F40B1A; Wed, 30 Jun 2021 14:23:03 -0300 (-03)
Date:   Wed, 30 Jun 2021 14:23:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
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
Subject: Re: [PATCH v8 06/22] perf record: Introduce data file at mmap buffer
 object
Message-ID: <YNyodxMjNEHjAaFW@kernel.org>
References: <cover.1625065643.git.alexey.v.bayduraev@linux.intel.com>
 <ace86f5d00ddb901a79196bb1863ed1395c408fd.1625065643.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ace86f5d00ddb901a79196bb1863ed1395c408fd.1625065643.git.alexey.v.bayduraev@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 30, 2021 at 06:54:45PM +0300, Alexey Bayduraev escreveu:
> Introduce data file and compressor objects into mmap object so
> they could be used to process and store data stream from the
> corresponding kernel data buffer. Make use of the introduced
> per mmap file and compressor when they are initialized and
> available.

So you're introducing even compressed storage in this patchset? To make
it smaller I thought this could be in a followup cset.

- Arnaldo
 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 3 +++
>  tools/perf/util/mmap.c      | 6 ++++++
>  tools/perf/util/mmap.h      | 3 +++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index cead2b3c56d7..9b7e7a5dc116 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -190,6 +190,9 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  {
>  	struct perf_data_file *file = &rec->session->data->file;
>  
> +	if (map && map->file)
> +		file = map->file;
> +
>  	if (perf_data_file__write(file, bf, size) < 0) {
>  		pr_err("failed to write perf data, error: %m\n");
>  		return -1;
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
> index 9d5f589f02ae..c4aed6e89549 100644
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
> @@ -43,6 +44,8 @@ struct mmap {
>  	struct mmap_cpu_mask	affinity_mask;
>  	void		*data;
>  	int		comp_level;
> +	struct perf_data_file *file;
> +	struct zstd_data      zstd_data;
>  };
>  
>  struct mmap_params {
> -- 
> 2.19.0
> 

-- 

- Arnaldo
