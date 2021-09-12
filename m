Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8844081A5
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhILUrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33787 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236292AbhILUrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PjvlGSdnGG5wtWxkF3EyFLoH5h3Fuzy88PPCh+MZH4E=;
        b=VilmpcwAY6CUb+UvkTALaoR0nb6/t+keXds9Ey5OVfC2VbtHUnREagVxZmkVHFkxUyHuT6
        HwAA20n2+rd9RdRr19KzFQHxxAGn7FjIBhCQThaIPNRZpHCbxizl7yqDWQk7hoziCCLvON
        N+O7zC4u3p9Z/3mfLX0d1nVAtHfzQaA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-LcPkuSeWP5iwO2sIv1pg-Q-1; Sun, 12 Sep 2021 16:45:55 -0400
X-MC-Unique: LcPkuSeWP5iwO2sIv1pg-Q-1
Received: by mail-ed1-f71.google.com with SMTP id g11-20020a056402090b00b003d114f9cb8aso1420286edz.20
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PjvlGSdnGG5wtWxkF3EyFLoH5h3Fuzy88PPCh+MZH4E=;
        b=FGOJsh8xt7ywSNTuK3XxLEKA0A5FG9EHsqDI/zPa30oOpjmV2Yi0Ri2Jk9SSZM5++v
         95+xxEyW68CL5LqAdTX/+N22RvYaZPWJv5gz89xdgYMyr1Gxkvlt4nfD6+ugtOtfzoMi
         6LbBnppDc5+E9bZOgcKhFvNGRZxHqmG3iqYFKk/tWWUnXbMo6LHm2SR1XCE3aO11HE/R
         cc9psVAbujaYQLqNDQli0iXHXjNi8/nHUhExNhOo5TZCZwB9gL6Di7jenHhi4rZcoUnz
         +mQVx7/GeDkBzQyuzsFgtrkkpavSTbMS+S/UoUNsE09iFVGbUaX731+uKTSu6+VYzAL1
         3MIg==
X-Gm-Message-State: AOAM531ReilCZFFv9k+UKMKjiVl0D7O2RY5U2WsChIHZ/NxoS4VVUgdj
        r0bPDx6aayGov7M5aM6mbJOkKwrUVSAT6gblHz16HrF2QwsslV5XeWGZncCbNWyoeKBl2HlrV7i
        RW+jvK7oiTn3o/qSghyiQp2As
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr9060897ejt.98.1631479554365;
        Sun, 12 Sep 2021 13:45:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRkUhpfKHz7TL/XSnUkITtIh/OCvP4A+TUfnTz/AWpklfvoaee7/qbuAZOIsZJxhPF+hC9Sw==
X-Received: by 2002:a17:906:5d6:: with SMTP id t22mr9060882ejt.98.1631479554232;
        Sun, 12 Sep 2021 13:45:54 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id r16sm2841070edt.15.2021.09.12.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:45:53 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:45:52 +0200
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
Subject: Re: [PATCH v10 05/24] perf record: Introduce thread local variable
Message-ID: <YT5nAMJ9BuKZHb+2@krava>
References: <cover.1626072008.git.alexey.v.bayduraev@linux.intel.com>
 <afa31d66f692558e0c9c06ea2f83a62ac394097f.1626072009.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afa31d66f692558e0c9c06ea2f83a62ac394097f.1626072009.git.alexey.v.bayduraev@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 09:46:05AM +0300, Alexey Bayduraev wrote:
> Introduce thread local variable and use it for threaded trace streaming.
> Use thread affinity mask instead or record affinity mask in affinity
> modes.
> 
> Acked-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 139 ++++++++++++++++++++++++------------
>  1 file changed, 93 insertions(+), 46 deletions(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a25b23affc43..dfc5db24e037 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -110,6 +110,8 @@ struct record_thread {
>  	unsigned long		waking;
>  };
>  
> +static __thread struct record_thread *thread;
> +
>  struct record {
>  	struct perf_tool	tool;
>  	struct record_opts	opts;
> @@ -132,7 +134,6 @@ struct record {
>  	bool			timestamp_boundary;
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
> -	struct mmap_cpu_mask	affinity_mask;
>  	unsigned long		output_max_size;	/* = 0: unlimited */
>  	int			nr_threads;
>  	struct thread_mask	*thread_masks;
> @@ -574,7 +575,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  		bf   = map->data;
>  	}
>  
> -	rec->samples++;
> +	thread->samples++;
>  	return record__write(rec, map, bf, size);
>  }
>  
> @@ -1317,19 +1318,29 @@ static struct perf_event_header finished_round_event = {
>  	.type = PERF_RECORD_FINISHED_ROUND,
>  };
>  
> -static void record__adjust_affinity(struct record *rec, struct mmap *map)
> +static int record__adjust_affinity(struct record *rec, struct mmap *map)

hm, why changing the return value if the caller does not check it?

jirka

>  {
> +	int ret = 0;
> +
>  	if (rec->opts.affinity != PERF_AFFINITY_SYS &&
> -	    !bitmap_equal(rec->affinity_mask.bits, map->affinity_mask.bits,
> -			  rec->affinity_mask.nbits)) {
> -		bitmap_zero(rec->affinity_mask.bits, rec->affinity_mask.nbits);
> -		bitmap_or(rec->affinity_mask.bits, rec->affinity_mask.bits,
> -			  map->affinity_mask.bits, rec->affinity_mask.nbits);
> -		sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&rec->affinity_mask),
> -				  (cpu_set_t *)rec->affinity_mask.bits);
> -		if (verbose == 2)
> -			mmap_cpu_mask__scnprintf(&rec->affinity_mask, "thread");
> +	    !bitmap_equal(thread->mask->affinity.bits, map->affinity_mask.bits,
> +			  thread->mask->affinity.nbits)) {
> +		bitmap_zero(thread->mask->affinity.bits, thread->mask->affinity.nbits);
> +		bitmap_or(thread->mask->affinity.bits, thread->mask->affinity.bits,
> +			  map->affinity_mask.bits, thread->mask->affinity.nbits);
> +		ret = sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread->mask->affinity),
> +					(cpu_set_t *)thread->mask->affinity.bits);
> +		if (ret)
> +			pr_err("threads[%d]: sched_setaffinity() call failed: %s\n",
> +			       thread->tid, strerror(errno));
> +		if (verbose == 2) {
> +			pr_debug("threads[%d]: addr=", thread->tid);
> +			mmap_cpu_mask__scnprintf(&thread->mask->affinity, "thread");
> +			pr_debug("threads[%d]: on cpu=%d\n", thread->tid, sched_getcpu());
> +		}
>  	}
> +
> +	return ret;
>  }

SNIP

