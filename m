Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE4A3CFE43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhGTPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240046AbhGTPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 11:05:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33705C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:45:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2046317pjx.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NpNq7JDQIJsNXoJR8EGd3wRq6OdERgGrM4wiXizuMoU=;
        b=RAuytij50B1HtqFlhb1ThqAgMNg6BilfhB9jx0mtyAl5MTDm6gG16mEu5rVsJzWSrQ
         XPoh8svdvJkX3t4NrtKUmhgV0MZ5qwtj/qGZd9qJCLJS/A03WCGsFN+NY21PQBE3ecW2
         xg3j6RUl5iRt1x2c20NK09b3Ji9uwdQSc0kLt9A4YONoQMVLsLD8ushCp4gwdY7nUX8G
         ARHH5DPWnC//phZHPZm088DpkQE2+MI/mMMM2yCLzZylzalGflVUdYMyquY2cHRq/s54
         3XTSHK6ECup1XMgZJAfcjSCj71kDYPo2r5c7OJR5EMduG1Ai6ab7kHC/hYaz0aOl8v0d
         0GMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NpNq7JDQIJsNXoJR8EGd3wRq6OdERgGrM4wiXizuMoU=;
        b=f/Ez7djrDVSIXgYYDZl9yun7WLUOYrsFAQAx6Q7ETIJyiIvbD+ETUl+QX0fItWjXXE
         LlSk0ex9y4LUo/s0Dl07pL4lZQdOHQHjUvlGCUsvsx0s0SvmHdNXgUDSJlgaxS4rwBkz
         jJkCHLIerrYdASt3aLaYiDZRvTqhrwTdh3urhuYkyuoun1Pq0eTi+j84/CFnLzobTJFq
         HEJt7gxMRszwIFXiHw6A1ItdNibHoXoQ5QPffdcrtwzTaOiaj89zMENBB624b9yg7zZV
         F3t8420ET4aVNZ7nVFlrcy5s7BtsQcpoSM9zfpmIfBFViwbRH5w8w47HPhivjMJvKpMX
         ZwOQ==
X-Gm-Message-State: AOAM533m+25pZW77Tsj7wSP0lT4N6O6seI9HKvyfhG5eHNfDEhZeIo2V
        n9OnWyc0QhQzApbSTsM/GXovfw==
X-Google-Smtp-Source: ABdhPJytdcE+2qJMEZYiBxTfYvfrc6yNOaa3KyauvEf3q3eOuA1CJjXhvaLgmV4o2xw5yf21dCnZyw==
X-Received: by 2002:a17:902:c204:b029:12b:25f7:9d51 with SMTP id 4-20020a170902c204b029012b25f79d51mr23880464pll.77.1626795942702;
        Tue, 20 Jul 2021 08:45:42 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id m16sm24152897pfo.152.2021.07.20.08.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:45:42 -0700 (PDT)
Date:   Tue, 20 Jul 2021 09:45:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] perf cs-etm: Pass unformatted flag to decoder
Message-ID: <20210720154539.GC2296792@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-7-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:08PM +0100, James Clark wrote:
> The TRBE (Trace Buffer Extension) feature allows a separate trace buffer
> for each trace source, therefore the trace wouldn't need to be
> formatted. The driver was introduced in commit 3fbf7f011f24
> ("coresight: sink: Add TRBE driver").
> 
> The formatted/unformatted mode is encoded in one of the flags of the
> AUX record. The first AUX record encountered for each event is used to
> determine the mode, and this will persist for the remaining trace that
> is either decoded or dumped.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 42 +++++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 760050ea936d..62769a84a53f 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -461,13 +461,14 @@ static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
>  }
>  
>  static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
> -				     struct cs_etm_auxtrace *etm)
> +				     struct cs_etm_auxtrace *etm,
> +				     int decoders_per_cpu)
>  {
>  	int i;
>  	u32 etmidr;
>  	u64 architecture;
>  
> -	for (i = 0; i < etm->num_cpu; i++) {
> +	for (i = 0; i < decoders_per_cpu; i++) {
>  		architecture = etm->metadata[i][CS_ETM_MAGIC];
>  
>  		switch (architecture) {
> @@ -488,7 +489,8 @@ static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
>  
>  static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>  				       struct cs_etm_queue *etmq,
> -				       enum cs_etm_decoder_operation mode)
> +				       enum cs_etm_decoder_operation mode,
> +				       bool formatted)
>  {
>  	int ret = -EINVAL;
>  
> @@ -498,7 +500,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
>  	d_params->packet_printer = cs_etm__packet_dump;
>  	d_params->operation = mode;
>  	d_params->data = etmq;
> -	d_params->formatted = true;
> +	d_params->formatted = formatted;
>  	d_params->fsyncs = false;
>  	d_params->hsyncs = false;
>  	d_params->frame_aligned = true;
> @@ -720,11 +722,13 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  	return len;
>  }
>  
> -static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
> +static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
> +						bool formatted)
>  {
>  	struct cs_etm_decoder_params d_params;
>  	struct cs_etm_trace_params  *t_params = NULL;
>  	struct cs_etm_queue *etmq;
> +	int decoders_per_cpu = formatted ? etm->num_cpu : 1;

I really tripped on the name "decoders_per_cpu", to a point where I had to
review the current code before looking at this patch.  I find the "_per_cpu"
part especially puzzling.  In the end the variable determines the amount of
decoders to instantiate for a specific queue...  

Couldn't it be just "decoders"?  Or maybe it just needs a little comment to
disambiguate things?

Thanks,
Mathieu

>  
>  	etmq = zalloc(sizeof(*etmq));
>  	if (!etmq)
> @@ -735,21 +739,23 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  		goto out_free;
>  
>  	/* Use metadata to fill in trace parameters for trace decoder */
> -	t_params = zalloc(sizeof(*t_params) * etm->num_cpu);
> +	t_params = zalloc(sizeof(*t_params) * decoders_per_cpu);
>  
>  	if (!t_params)
>  		goto out_free;
>  
> -	if (cs_etm__init_trace_params(t_params, etm))
> +	if (cs_etm__init_trace_params(t_params, etm, decoders_per_cpu))
>  		goto out_free;
>  
>  	/* Set decoder parameters to decode trace packets */
>  	if (cs_etm__init_decoder_params(&d_params, etmq,
>  					dump_trace ? CS_ETM_OPERATION_PRINT :
> -						     CS_ETM_OPERATION_DECODE))
> +						     CS_ETM_OPERATION_DECODE,
> +					formatted))
>  		goto out_free;
>  
> -	etmq->decoder = cs_etm_decoder__new(etm->num_cpu, &d_params, t_params);
> +	etmq->decoder = cs_etm_decoder__new(decoders_per_cpu, &d_params,
> +					    t_params);
>  
>  	if (!etmq->decoder)
>  		goto out_free;
> @@ -777,14 +783,15 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  
>  static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  			       struct auxtrace_queue *queue,
> -			       unsigned int queue_nr)
> +			       unsigned int queue_nr,
> +			       bool formatted)
>  {
>  	struct cs_etm_queue *etmq = queue->priv;
>  
>  	if (list_empty(&queue->head) || etmq)
>  		return 0;
>  
> -	etmq = cs_etm__alloc_queue(etm);
> +	etmq = cs_etm__alloc_queue(etm, formatted);
>  
>  	if (!etmq)
>  		return -ENOMEM;
> @@ -2430,8 +2437,14 @@ static int cs_etm__process_auxtrace_event(struct perf_session *session,
>  		if (err)
>  			return err;
>  
> +		/*
> +		 * Knowing if the trace is formatted or not requires a lookup of
> +		 * the aux record so only works in non-piped mode where data is
> +		 * queued in cs_etm__queue_aux_records(). Always assume
> +		 * formatted in piped mode (true).
> +		 */
>  		err = cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> -					  idx);
> +					  idx, true);
>  		if (err)
>  			return err;
>  
> @@ -2678,6 +2691,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  	union perf_event auxtrace_fragment;
>  	__u64 aux_offset, aux_size;
>  	__u32 idx;
> +	bool formatted;
>  
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
> @@ -2745,7 +2759,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>  			return err;
>  
>  		idx = auxtrace_event->idx;
> -		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx], idx);
> +		formatted = !(aux_event->flags & PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW);
> +		return cs_etm__setup_queue(etm, &etm->queues.queue_array[idx],
> +					   idx, formatted);
>  	}
>  
>  	/* Wasn't inside this buffer, but there were no parse errors. 1 == 'not found' */
> -- 
> 2.28.0
> 
