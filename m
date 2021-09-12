Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD044081A9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhILUsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236226AbhILUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hD5mu2L0rSn6NJ0lYDv6IN5TJCoxQGbrMjRvgkRfR3Q=;
        b=gEW6UVr7x7XsT2S0FBvEEBx+PhxHV2ihamCJ1OcfedpZVEiRFZqJ3bDdr0A/IGOlwmRtiO
        431ckDYBqP54KRt1uudabVfw7BBPs5VGEUYyC5ePozYrzITPT0kbzV6sKSrTMV4DyJeidP
        vl16GZ8B+FDoPV1I3AsxjOTJYrw8zCc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-N88aZidYNxirmF0qoQ0kzQ-1; Sun, 12 Sep 2021 16:46:47 -0400
X-MC-Unique: N88aZidYNxirmF0qoQ0kzQ-1
Received: by mail-ed1-f71.google.com with SMTP id bf22-20020a0564021a5600b003c86b59e291so3853370edb.18
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hD5mu2L0rSn6NJ0lYDv6IN5TJCoxQGbrMjRvgkRfR3Q=;
        b=1mTfzmiZriX+XzTDkHAmdlpOfuslrpZDHAxV5epL8OE7T1noQU0vtiN5P5891itYTf
         NBwfiKw9KUxw8Kk2aEQpFOoc3yd4ou7jC0s7FAX31hb2ltitm1Z1vuAdi8qRZ/J/CoDQ
         2Xvbvhq40oTUJ6V37uTTL3upGw26OO2z7JDZCC2FKVGzqw2/qsZzf4f9hrJSkzkPbpAM
         mq0zB7T4scBG5FFhbuZI7neyy9MJrsKQZXrF+G4sxTrmdSB6e4ns2V7u9h92nRbjWZau
         0RRLMxALp6/mKIlqlXvEXkTr8RUHLQgi/R8SMbKrOC5IDza0RAg+y4JTvo2NLY2k1RHR
         UMFw==
X-Gm-Message-State: AOAM532o6gpxqBuH0Q/QkqK73s3kQRGxWsLoNE459FpcCAjeW7wTosZo
        f78NpkeniFSqjb3c7gR6jDzJa3CYcLS9I8hKozH2f5yTZ5w+oL4yk8wWJS6kshANnxn64+/FOPp
        O+cSnEvcXJDfd1Zv/iBPXwJfT
X-Received: by 2002:a17:906:6943:: with SMTP id c3mr9063606ejs.550.1631479606136;
        Sun, 12 Sep 2021 13:46:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtzVDzCQCgmg9vruMxraTCQ4ulm/bOjc6O85vriXTkTUQVeFp3KT0GR74z+M9HlTCL0SdHtg==
X-Received: by 2002:a17:906:6943:: with SMTP id c3mr9063592ejs.550.1631479605943;
        Sun, 12 Sep 2021 13:46:45 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id z12sm2823128edi.44.2021.09.12.13.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:46:45 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:46:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
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
Subject: Re: [PATCH v11 09/24] perf record: Introduce bytes written stats to
 support --max-size option
Message-ID: <YT5nMzMPwy5/zXeh@krava>
References: <cover.1629186429.git.alexey.v.bayduraev@linux.intel.com>
 <c5c886094b1657328c7ec030da140b329282ebb7.1629186429.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c886094b1657328c7ec030da140b329282ebb7.1629186429.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 11:23:12AM +0300, Alexey Bayduraev wrote:
> Adding a function to calculate the total amount of data written
> and using it to support the --max-size option.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
> Tested-by: Riccardo Mancini <rickyman7@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 30 +++++++++++++++++++++++++++---
>  tools/perf/util/mmap.h      |  1 +
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index eff6f8db60b2..cb155f1ba979 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -186,10 +186,28 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> +static u64 record__bytes_written(struct record *rec)
> +{
> +	int t, tm;
> +	struct record_thread *thread_data = rec->thread_data;
> +	u64 bytes_written = rec->bytes_written;
> +
> +	for (t = 0; t < rec->nr_threads; t++) {
> +		for (tm = 0; tm < thread_data[t].nr_mmaps; tm++) {
> +			if (thread_data[t].maps)
> +				bytes_written += thread_data[t].maps[tm]->bytes_written;
> +			if (thread_data[t].overwrite_maps)
> +				bytes_written += thread_data[t].overwrite_maps[tm]->bytes_written;
> +		}
> +	}
> +
> +	return bytes_written;
> +}
> +
>  static bool record__output_max_size_exceeded(struct record *rec)
>  {
>  	return rec->output_max_size &&
> -	       (rec->bytes_written >= rec->output_max_size);
> +	       (record__bytes_written(rec) >= rec->output_max_size);
>  }
>  
>  static int record__write(struct record *rec, struct mmap *map __maybe_unused,
> @@ -205,15 +223,21 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
>  		return -1;
>  	}
>  
> -	rec->bytes_written += size;
> +	if (map && map->file)
> +		map->bytes_written += size;
> +	else
> +		rec->bytes_written += size;
>  
>  	if (record__output_max_size_exceeded(rec) && !done) {

also instead of slowing down each write with calling
record__output_max_size_exceeded and risking the race with done,
I think this should be called as part of trigger framework

we could call this check periodically every second or such,
we don't mind the size overhead.. IMO it's still better than
caling this each time we write to the file

jirka

>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>  				" stopping session ]\n",
> -				rec->bytes_written >> 10);
> +				record__bytes_written(rec) >> 10);
>  		done = 1;
>  	}
>  
> +	if (map && map->file)
> +		return 0;
> +
>  	if (switch_output_size(rec))
>  		trigger_hit(&switch_output_trigger);
>  
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index c4aed6e89549..67d41003d82e 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -46,6 +46,7 @@ struct mmap {
>  	int		comp_level;
>  	struct perf_data_file *file;
>  	struct zstd_data      zstd_data;
> +	u64		      bytes_written;
>  };
>  
>  struct mmap_params {
> -- 
> 2.19.0
> 

