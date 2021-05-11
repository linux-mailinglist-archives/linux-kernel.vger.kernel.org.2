Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F937AACA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhEKPiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 11:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbhEKPiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 11:38:05 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07F5C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:36:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so1586822pjv.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bm0ThZyWWvkLjCoo9Dq8b/C4KxZriqHuAbFylLklyVo=;
        b=cTKHHWvxMiXPT8Tyx7AbSF90K0KSV4Z47No9imd9DRlMSzJieMPawBapmD0XMRcNBx
         D1AJUatmcsJ7mZKpE/I/bp9xqxacr/uwBf4mMiom1JlG7NNieUx7n+RTaQN2H6vQjigo
         6nrAWxQ3VTiBE4rPxdkpBUFHS91PLBnjigq5i4U83m3vvdelKFDKDS8noeUty6LfR8Ge
         nHvyJIv5aFF5mg7ZhCxC5mnJXlCOeKNjnXu+iCQTns0PFzg7uj86l4PW9nHyIlY4TzK5
         ntfqSczQCVtW8YSScbkHnKGb1tZzPuyMCNENjDOkDT2i6IpFbbp2VB6B9XL7GgYRVQ3w
         tbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bm0ThZyWWvkLjCoo9Dq8b/C4KxZriqHuAbFylLklyVo=;
        b=Z0FjZZUi+W5p9d2PaJ7xN0U17DNTDXxOiV4mBqRIwCRa80WirsutmBLTC70+lZcxFb
         m10Gl3hEPcbDrslHu9jo4kYpi45kjdyMGM0d34oKwzB1xj2DDss1t3U7DigRs0fRKsOe
         z2gv2d81lWDabT6isTTTEvzyxpxq6ItfYz8vd6g5k+VvBA3oi257G47OQsuNdtJqy2ES
         GC0ht8jcM0QcWJJKaLH3bB4luIKuZLvdx2FLjbUDsivDbYgqlvEpGYG/d8vJrGRkGz77
         0rX6nbz2Hk6V58/WhjAP30VKwy6ZcFoEf2qzvLnoMGSxV9YSMqM61lIGbZOqmXoxLwED
         O9pQ==
X-Gm-Message-State: AOAM532cPHXRTai2GPGPnGSCOBGgV/ynpIrgEJtkh+yyHLmbQD2SXrlz
        6H0/gBAYvGmCVAXLHFE5TTnzrw==
X-Google-Smtp-Source: ABdhPJzFfB2V30iJqIdnh2v586Mpk6Cvns42itzjXc3zLDJrp2d9noAu0jWOQWcL8XV9voaDxO/tdg==
X-Received: by 2002:a17:90a:5d14:: with SMTP id s20mr33564115pji.185.1620747418098;
        Tue, 11 May 2021 08:36:58 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l62sm14023723pfl.88.2021.05.11.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 08:36:56 -0700 (PDT)
Date:   Tue, 11 May 2021 09:36:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] perf cs-etm: Refactor timestamp variable names
Message-ID: <20210511153654.GA124805@xps15>
References: <20210510143248.27423-1-james.clark@arm.com>
 <20210510143248.27423-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510143248.27423-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 05:32:47PM +0300, James Clark wrote:
> Remove ambiguity in variable names relating to timestamps.
> A later commit will save the sample kernel timestamp in one
> of the etm structs, so name all elements appropriately to
> avoid confusion.
> 
> This is also removes some ambiguity arising from the fact
> that the --timestamp argument to perf record refers to
> sample kernel timestamps, and the /timestamp/ event modifier
> refers to CS timestamps, so the term is overloaded.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 ++++----
>  tools/perf/util/cs-etm.c                      | 42 +++++++++----------
>  tools/perf/util/cs-etm.h                      |  4 +-
>  3 files changed, 31 insertions(+), 33 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 059bcec3f651..b01d363b9301 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -276,13 +276,13 @@ cs_etm_decoder__do_soft_timestamp(struct cs_etm_queue *etmq,
>  				  const uint8_t trace_chan_id)
>  {
>  	/* No timestamp packet has been received, nothing to do */
> -	if (!packet_queue->timestamp)
> +	if (!packet_queue->cs_timestamp)
>  		return OCSD_RESP_CONT;
>  
> -	packet_queue->timestamp = packet_queue->next_timestamp;
> +	packet_queue->cs_timestamp = packet_queue->next_cs_timestamp;
>  
>  	/* Estimate the timestamp for the next range packet */
> -	packet_queue->next_timestamp += packet_queue->instr_count;
> +	packet_queue->next_cs_timestamp += packet_queue->instr_count;
>  	packet_queue->instr_count = 0;
>  
>  	/* Tell the front end which traceid_queue needs attention */
> @@ -308,8 +308,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  	 * Function do_soft_timestamp() will report the value to the front end,
>  	 * hence asking the decoder to keep decoding rather than stopping.
>  	 */
> -	if (packet_queue->timestamp) {
> -		packet_queue->next_timestamp = elem->timestamp;
> +	if (packet_queue->cs_timestamp) {
> +		packet_queue->next_cs_timestamp = elem->timestamp;
>  		return OCSD_RESP_CONT;
>  	}
>  
> @@ -320,8 +320,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  	 * which instructions started by subtracting the number of instructions
>  	 * executed to the timestamp.
>  	 */
> -	packet_queue->timestamp = elem->timestamp - packet_queue->instr_count;
> -	packet_queue->next_timestamp = elem->timestamp;
> +	packet_queue->cs_timestamp = elem->timestamp - packet_queue->instr_count;
> +	packet_queue->next_cs_timestamp = elem->timestamp;
>  	packet_queue->instr_count = 0;
>  
>  	/* Tell the front end which traceid_queue needs attention */
> @@ -334,8 +334,8 @@ cs_etm_decoder__do_hard_timestamp(struct cs_etm_queue *etmq,
>  static void
>  cs_etm_decoder__reset_timestamp(struct cs_etm_packet_queue *packet_queue)
>  {
> -	packet_queue->timestamp = 0;
> -	packet_queue->next_timestamp = 0;
> +	packet_queue->cs_timestamp = 0;
> +	packet_queue->next_cs_timestamp = 0;
>  	packet_queue->instr_count = 0;
>  }
>  
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 7e63e7dedc33..533f6f2f0685 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -38,8 +38,6 @@
>  #include <tools/libc_compat.h>
>  #include "util/synthetic-events.h"
>  
> -#define MAX_TIMESTAMP (~0ULL)
> -
>  struct cs_etm_auxtrace {
>  	struct auxtrace auxtrace;
>  	struct auxtrace_queues queues;
> @@ -86,7 +84,7 @@ struct cs_etm_queue {
>  	struct cs_etm_decoder *decoder;
>  	struct auxtrace_buffer *buffer;
>  	unsigned int queue_nr;
> -	u8 pending_timestamp;
> +	u8 pending_timestamp_chan_id;
>  	u64 offset;
>  	const unsigned char *buf;
>  	size_t buf_len, buf_used;
> @@ -208,7 +206,7 @@ void cs_etm__etmq_set_traceid_queue_timestamp(struct cs_etm_queue *etmq,
>  	 * be more than one channel per cs_etm_queue, we need to specify
>  	 * what traceID queue needs servicing.
>  	 */
> -	etmq->pending_timestamp = trace_chan_id;
> +	etmq->pending_timestamp_chan_id = trace_chan_id;
>  }
>  
>  static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
> @@ -216,22 +214,22 @@ static u64 cs_etm__etmq_get_timestamp(struct cs_etm_queue *etmq,
>  {
>  	struct cs_etm_packet_queue *packet_queue;
>  
> -	if (!etmq->pending_timestamp)
> +	if (!etmq->pending_timestamp_chan_id)
>  		return 0;
>  
>  	if (trace_chan_id)
> -		*trace_chan_id = etmq->pending_timestamp;
> +		*trace_chan_id = etmq->pending_timestamp_chan_id;
>  
>  	packet_queue = cs_etm__etmq_get_packet_queue(etmq,
> -						     etmq->pending_timestamp);
> +						     etmq->pending_timestamp_chan_id);
>  	if (!packet_queue)
>  		return 0;
>  
>  	/* Acknowledge pending status */
> -	etmq->pending_timestamp = 0;
> +	etmq->pending_timestamp_chan_id = 0;
>  
>  	/* See function cs_etm_decoder__do_{hard|soft}_timestamp() */
> -	return packet_queue->timestamp;
> +	return packet_queue->cs_timestamp;
>  }
>  
>  static void cs_etm__clear_packet_queue(struct cs_etm_packet_queue *queue)
> @@ -814,7 +812,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  	int ret = 0;
>  	unsigned int cs_queue_nr;
>  	u8 trace_chan_id;
> -	u64 timestamp;
> +	u64 cs_timestamp;
>  	struct cs_etm_queue *etmq = queue->priv;
>  
>  	if (list_empty(&queue->head) || etmq)
> @@ -854,7 +852,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  
>  		/*
>  		 * Run decoder on the trace block.  The decoder will stop when
> -		 * encountering a timestamp, a full packet queue or the end of
> +		 * encountering a CS timestamp, a full packet queue or the end of
>  		 * trace for that block.
>  		 */
>  		ret = cs_etm__decode_data_block(etmq);
> @@ -865,10 +863,10 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
>  		 * the timestamp calculation for us.
>  		 */
> -		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> +		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>  
>  		/* We found a timestamp, no need to continue. */
> -		if (timestamp)
> +		if (cs_timestamp)
>  			break;
>  
>  		/*
> @@ -892,7 +890,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  	 * queue and will be processed in cs_etm__process_queues().
>  	 */
>  	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> -	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
> +	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
>  out:
>  	return ret;
>  }
> @@ -2221,7 +2219,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  	int ret = 0;
>  	unsigned int cs_queue_nr, queue_nr;
>  	u8 trace_chan_id;
> -	u64 timestamp;
> +	u64 cs_timestamp;
>  	struct auxtrace_queue *queue;
>  	struct cs_etm_queue *etmq;
>  	struct cs_etm_traceid_queue *tidq;
> @@ -2283,9 +2281,9 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  		if (ret)
>  			goto out;
>  
> -		timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
> +		cs_timestamp = cs_etm__etmq_get_timestamp(etmq, &trace_chan_id);
>  
> -		if (!timestamp) {
> +		if (!cs_timestamp) {
>  			/*
>  			 * Function cs_etm__decode_data_block() returns when
>  			 * there is no more traces to decode in the current
> @@ -2308,7 +2306,7 @@ static int cs_etm__process_queues(struct cs_etm_auxtrace *etm)
>  		 * this queue/traceID.
>  		 */
>  		cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> -		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
> +		ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, cs_timestamp);
>  	}
>  
>  out:
> @@ -2380,7 +2378,7 @@ static int cs_etm__process_event(struct perf_session *session,
>  				 struct perf_tool *tool)
>  {
>  	int err = 0;
> -	u64 timestamp;
> +	u64 sample_kernel_timestamp;
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> @@ -2394,11 +2392,11 @@ static int cs_etm__process_event(struct perf_session *session,
>  	}
>  
>  	if (sample->time && (sample->time != (u64) -1))
> -		timestamp = sample->time;
> +		sample_kernel_timestamp = sample->time;
>  	else
> -		timestamp = 0;
> +		sample_kernel_timestamp = 0;
>  
> -	if (timestamp || etm->timeless_decoding) {
> +	if (sample_kernel_timestamp || etm->timeless_decoding) {
>  		err = cs_etm__update_queues(etm);
>  		if (err)
>  			return err;
> diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> index 36428918411e..d65c7b19407d 100644
> --- a/tools/perf/util/cs-etm.h
> +++ b/tools/perf/util/cs-etm.h
> @@ -171,8 +171,8 @@ struct cs_etm_packet_queue {
>  	u32 head;
>  	u32 tail;
>  	u32 instr_count;
> -	u64 timestamp;
> -	u64 next_timestamp;
> +	u64 cs_timestamp;
> +	u64 next_cs_timestamp;
>  	struct cs_etm_packet packet_buffer[CS_ETM_PACKET_MAX_BUFFER];
>  };
>  
> -- 
> 2.28.0
> 
