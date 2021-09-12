Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC574081A4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 22:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbhILUrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 16:47:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20884 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236292AbhILUq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 16:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631479544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzcy6zz34pSgX/5uARJvw2PlkJ2zdCgMxguaWEDx/h0=;
        b=b8vTTWfsoWW4YtXFhqLftaPesLkNZFWU0PhyP2wRrTbEJ3bmGOdM7wKCDoKftOPgC63LV5
        d2KLtm/ie51rwB21bT83v9f4gOl/rv9OKz/oA6MReAslJtdJ3SPokehmHGAmzxQw2uxsEv
        N2GzgzEs+eJvv+QiGf1VrV7emH2+dK0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-W2-aQSzyM7yezL54gohL8Q-1; Sun, 12 Sep 2021 16:45:43 -0400
X-MC-Unique: W2-aQSzyM7yezL54gohL8Q-1
Received: by mail-ej1-f72.google.com with SMTP id g4-20020a170906520400b005e7d062772dso2808077ejm.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 13:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pzcy6zz34pSgX/5uARJvw2PlkJ2zdCgMxguaWEDx/h0=;
        b=nEHfBK1gT01EDgyNJIRCrC6ZzQE3UXZph24Q8cHnengmU2i3JWY4mDzkmKLAk06Rpy
         mWp7TMl/LK6J2gAtpi3MOwRFcnQOKuZfcytlC0CZNNW3KSGW/tikRdHqF1BebgGERNi+
         2dXBfrX3nFe1+kCRbbYs1G3rjnHLuNqqk2VFpEGhDuy5PoHTbnWt7lrVVy9ZHkKykAcm
         a5Ikpqy6rdqRi2yA54O58NbMoffO7PmmWJWAjoYVksnJx57iA0bFCEUhzuEQ08FfSZRj
         VjYcdqYW78BYKG5T4aTIMgBMarko33gGjMSAF21S7AJyos+iJ69nbjTaspQ15PrnXfsw
         hMFQ==
X-Gm-Message-State: AOAM5317JmW+ccfcXdZ6Uit7ZRxIk+WDlOYBODFv5zdS9r48OQlqYSj0
        l5+wwIO+PhHUpe26OfSeci88s3P/Nsm03GxlyJeuEAXZhKFvv3By3GtQVs9htaNjtrNCedwh609
        Bkv1sIsq2cOf4yZ8m/Wiws1j3
X-Received: by 2002:a17:906:1e0c:: with SMTP id g12mr9257689ejj.155.1631479542339;
        Sun, 12 Sep 2021 13:45:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwE2fjSQx7SmsCpq+n9i0NxXiTcXYfdNl37j5IKUaT08JTo/NzvTJS2aA+R2SWHsOx1UKwMQ==
X-Received: by 2002:a17:906:1e0c:: with SMTP id g12mr9257678ejj.155.1631479542181;
        Sun, 12 Sep 2021 13:45:42 -0700 (PDT)
Received: from krava ([83.240.60.52])
        by smtp.gmail.com with ESMTPSA id c10sm2464549eje.37.2021.09.12.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:45:41 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:45:40 +0200
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
Message-ID: <YT5m9LqWWpD5mPZe@krava>
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

please split this change from the rest

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

same here, it's not just 'rec' to 'thread' change in here

thanks,
jirka

