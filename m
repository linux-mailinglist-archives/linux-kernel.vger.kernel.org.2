Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19017326C17
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 08:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhB0HUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 02:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhB0HUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 02:20:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F61C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 23:11:02 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id u11so6481348plg.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 23:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yao3DKiDUVXPocg3HZu3CrfMuuVcOFmhFEPj7H1Bbw8=;
        b=JdOofawLly857oBjaPmoYppod2v41v2JW2vM8XlV0oH12qJSzyQGY97LEdlw9+kjRs
         i2kPwMRp9XE2jcpYDmK+P7pLVB/DBGTfygwIWIAaJx/hQxgw7YYX0g8YXGfYwpGtZjlz
         3bJd99NJxGXqj9M4YFEN2/LjaGA4YoJ4AvQIULe6H0yAQ5YYuSADW5W7KGijPvc5JejZ
         U4sCST/UDmBi5oDOdr2rkStT+UkJ6az241G5DE1Fb1NAFgNGrtUCVNV0m0RCHT72xn8Z
         QCvHUaV7mdl62lXEV8msDPl6p3xZ3XZb4pTG59D58RR0BEITYlWnKfbCBBm7n6RGkJhE
         0mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yao3DKiDUVXPocg3HZu3CrfMuuVcOFmhFEPj7H1Bbw8=;
        b=W33q8/CjEr9ZYsY3U0gAWFLh+lsUhGj0EhP05AkmbajAHPuV18AaM3UcqIeFs7iKIR
         8E8naS2hVGFj8dOUD4mXtsD8lQ4YLmlSejl3hnAsrCmg+2waARcL9Asyc4Dbj30crlir
         my2QYb7uW2qnY7gw5q5Xih6D9fKB+yBUCqyqCfOtsd/XLwKTxy7quAp83ED1p9RCpEq4
         0LIDPpwgqXY/IkGKVLYRcL4XUui7XCLD/hrvQGxDHU6rlrzqd4YCTxQikfjBMF3DAzLN
         OA5u/fUnfd8p0LaHfIVXXKVCZMlOa29i0RIfVEORTujB0rIPNQECLfLGwrSlZJDkPmI0
         eiHg==
X-Gm-Message-State: AOAM5316IVaXTqD9MNE+8M46PDOmN5eUX2eDE0lz4UakplNriaNwRSc3
        oWGTAVe+X3Zp4bNT18UKb3F1Pw==
X-Google-Smtp-Source: ABdhPJw3iXjS9OpmouIDqNBfQQ+aGegQs6fCKMRNIgcVH2OptBhhf6Ug0IaWy1z/qwt8iphCZjWgmA==
X-Received: by 2002:a17:902:690b:b029:e3:688d:5ab9 with SMTP id j11-20020a170902690bb02900e3688d5ab9mr6534606plk.55.1614409862107;
        Fri, 26 Feb 2021 23:11:02 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([218.190.226.35])
        by smtp.gmail.com with ESMTPSA id q4sm11422703pfs.134.2021.02.26.23.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 23:11:01 -0800 (PST)
Date:   Sat, 27 Feb 2021 15:10:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] perf cs-etm: Save aux records in each etm queue
Message-ID: <20210227071056.GA3317@leoy-ThinkPad-X240s>
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210212144513.31765-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212144513.31765-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:45:09PM +0200, James Clark wrote:
> The aux records will be used set the bounds of decoding in a
> later commit. In the future we may also want to use the flags
> of each record to control decoding.
> 
> Do these need to be saved in their entirety, or can pointers
> to each record safely be saved instead for later access?

Rather than introudcing the perf record list, I just wander if we can
use easier method to fix this problem.  So below is the rough idea
(though I don't really verify it):

The essential information we need is what's the valid buffer length can
be used for decoding.  Though cs_etm_queue::buf_len tracks the buffer
length, but it's the buffer length is for the whole AUX buffer, and
which belongs to multiple "PERF_RECORD_AUX" events.  So we cannot decode
at once for the whole trace data in the AUX trace buffer, on the other
hand, the incoming "PERF_RECORD_AUX" event can guide the CoreSight
decoder it should decode how much buffer size.  At the end, the trace
data can be decoded step by step based on the incoming "PERF_RECORD_AUX"
events.

I'd like to propose to add a new field "cs_etm_queue::buf_rec_len", it
stands for the record length based on the RECORD_AUX event.  In
theory, this value should be always less than "cs_etm_queue::buf_len".

When every time the "PERF_RECORD_AUX" event is coming, we find out the
corresponding queue (so this can be applied for "1:1" or "N:1" models
for source and sink), and accumulate "perf_record_aux::aux_size" into
"cs_etm_queue::buf_rec_len".

At the decoder side, it decreases "etmq->buf_rec_len" until to zero for
the current round of decoding (see cs_etm__decode_data_block()).  Since
all the "PERF_RECORD_AUX" event will be processed before
"PERF_RECORD_EXIT" event, so we don't worry the tail trace data will be
ignored.

The main reason for this suggestion is it don't need to change the
significant logic in current code.  I will try to do experiment for this
idea and share back.

James, if you think I miss anything, please correct me as needed.
Thanks!

Leo

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 8f8b448632fb..88b541b2a804 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -92,12 +92,16 @@ struct cs_etm_queue {
>  	/* Conversion between traceID and index in traceid_queues array */
>  	struct intlist *traceid_queues_list;
>  	struct cs_etm_traceid_queue **traceid_queues;
> +	int aux_record_list_len;
> +	int aux_record_list_idx;
> +	struct perf_record_aux *aux_record_list;
>  };
>  
>  /* RB tree for quick conversion between traceID and metadata pointers */
>  static struct intlist *traceid_list;
>  
> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu,
> +				 struct perf_record_aux *aux_record);
>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>  					   pid_t tid);
> @@ -585,6 +589,7 @@ static void cs_etm__free_queue(void *priv)
>  
>  	cs_etm_decoder__free(etmq->decoder);
>  	cs_etm__free_traceid_queues(etmq);
> +	free(etmq->aux_record_list);
>  	free(etmq);
>  }
>  
> @@ -759,6 +764,19 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  	return NULL;
>  }
>  
> +static int cs_etm__save_aux_record(struct cs_etm_queue *etmq,
> +				   struct perf_record_aux *aux_record)
> +{
> +	etmq->aux_record_list = reallocarray(etmq->aux_record_list,
> +					      etmq->aux_record_list_len+1,
> +					      sizeof(*etmq->aux_record_list));
> +	if (!etmq->aux_record_list)
> +		return -ENOMEM;
> +
> +	etmq->aux_record_list[etmq->aux_record_list_len++] = *aux_record;
> +	return 0;
> +}
> +
>  static int cs_etm__search_first_timestamp(struct cs_etm_queue *etmq)
>  {
>  	int ret = 0;
> @@ -865,7 +883,7 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>  	return 0;
>  }
>  
> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu, struct perf_record_aux *aux)
>  {
>  	int ret;
>  	if (etm->queues.new_data) {
> @@ -875,6 +893,14 @@ static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
>  			return ret;
>  	}
>  
> +	/* In timeless mode, cpu is set to -1, and a single aux buffer is filled */
> +	if (cpu < 0)
> +		cpu = 0;
> +
> +	ret = cs_etm__save_aux_record(etm->queues.queue_array[cpu].priv, aux);
> +	if (ret)
> +		return ret;
> +
>  	if (!etm->timeless_decoding)
>  		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
>  	else
> @@ -2357,7 +2383,7 @@ static int cs_etm__process_event(struct perf_session *session,
>  
>  	if ((timestamp || etm->timeless_decoding)
>  			&& event->header.type == PERF_RECORD_AUX) {
> -		err = cs_etm__update_queues(etm, sample->cpu);
> +		err = cs_etm__update_queues(etm, sample->cpu, &event->aux);
>  		if (err)
>  			return err;
>  	}
> -- 
> 2.28.0
> 
