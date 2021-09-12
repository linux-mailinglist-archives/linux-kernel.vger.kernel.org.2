Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710544081A8
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhILUrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236334AbhILUrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w9trapGCPzLTHKk++cWbocG2cfMdgqL3mKBkfN3qm6M=;
        b=I3Wu64I9x+vmtfK8dffwOoXVDcwOyFiSNU8plkVMq1TqAIVpO5/7bt9TQ5aQ6DB3YAtsOK
        Ma9LXPSW23v6UpWLycEvdg6PhabWl89HFfAQbIvh8PIlpZbcYsm9zHFeQeuDP8BAUDVl2h
        eY5/qTjhQiYn40aJ25Sfh5C3kpCCeZw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-YNmv64VuMGySbtowV4gtJQ-1; Sun, 12 Sep 2021 16:46:37 -0400
X-MC-Unique: YNmv64VuMGySbtowV4gtJQ-1
Received: by mail-ed1-f69.google.com with SMTP id s15-20020a056402520f00b003cad788f1f6so3836663edd.22
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w9trapGCPzLTHKk++cWbocG2cfMdgqL3mKBkfN3qm6M=;
        b=JakCfarA76Kz/THR2XqBmiCvS6kF0yUwxGsp4ang/5/f2FrVc7lGRohSQmx/Ad/uGP
         7IamIN+7cByxEeNfxWgutiz5+YUigs7i2YXlexAPyMRIvFx5DYuTYGtCtt9EPAxa4DaE
         ocMU9+oITZiHa46sjtXSInhUSvWXJywjacamJONAIqVjdpUQlM6+Et/dCT1N83s37ORh
         M7ZcIAtS7NmYmWh77zWIZDhozDMP03ymEh8QHhBExJ7Zm7SW0xRd3CkHpjnhKrETy0Ve
         GulPE4ZfKWIWJVcZgFS8Big2MHgpq5wXpVeCl0cR4qY6LKfWO7uRim8IECMCDwiX68Jr
         vsBg==
X-Gm-Message-State: AOAM530VFzoJHNdigte0X+Bd/RL33lX48M1o+lBMvBeU15p5D196B/is
        xROeDQ0hIFtmZ+6xQQSBwAxlpsXh47sUvHnUPu2DiNTSfPitQzcwdR67h7GV/WqWwxK3qtEWDmO
        X4PWawfWWEKY/+si2YBJBVZQo
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr9372071ejd.241.1631479596304;
        Sun, 12 Sep 2021 13:46:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiE/BrkBwEHkrp9a9dCxLTCNaw7mGYfgbNSZjnR60diTfEEk4hPpy1B57JNKRNoTDhdDio6A==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr9372059ejd.241.1631479596093;
        Sun, 12 Sep 2021 13:46:36 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id n18sm2458684ejg.36.2021.09.12.13.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:46:35 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:46:33 +0200
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
Message-ID: <YT5nKWqAhUVFiaEn@krava>
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

could we instead have bytes_written in thread data? so we don't
need to iterate all the maps?

> +	else
> +		rec->bytes_written += size;
>  
>  	if (record__output_max_size_exceeded(rec) && !done) {
>  		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
>  				" stopping session ]\n",
> -				rec->bytes_written >> 10);
> +				record__bytes_written(rec) >> 10);

you're calling record__bytes_written twice.. could we just save the
bytes_written from the first call and use it in the printf?

>  		done = 1;
>  	}
>  
> +	if (map && map->file)
> +		return 0;

please make comment why quit in here, we don't support switch-output for
threads?

jirka

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

