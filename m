Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58570320460
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 09:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhBTIMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 03:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 03:11:59 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCDCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 00:11:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id 201so304078pfw.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V+9eRXBXr3a/Jjk1oqfCZbLnBKfF/Q5hWwSEoBYXKsI=;
        b=W1YC8dkBKHnTBnbSX8mBp/ciNjiZtm+Dw6hISPi85dC+wnfU6e6Sh+pIKSxyuzznPQ
         BiC864ubG6IUeo6w2TWSojojwi4XP9f/QmVMcUNY3EXk+v/yzwooaToRSKjss8jFTT7Q
         WYpj1uqT08VjdJ9EaS0PvSJTB42mHDHuWQS+zwEg6hNm+janpTgA5YgIegenh7zvyLyg
         WEEQIUhmxGKgcIVAB2G2fNZnCb7/YPB07+xlp4ojjmg0XWsKGevAbAVIRE82ncBub6Hh
         glaXoNwACmC3CXAPcOoHpOxdscZ9Z40MPOvVfPeH372MvES+X2TMQRnfDI4Tp9/YqC+F
         dCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V+9eRXBXr3a/Jjk1oqfCZbLnBKfF/Q5hWwSEoBYXKsI=;
        b=m4lB0fIb+7R4ScBinJBndp3a/gqEFeKYqB5BZBMWRDmUNRtrflcj1jGAcvXoC790My
         JDYx+BsXpypJj77AY/dCWtrnMPqKlhVlLM6u3HG5IAcpFINyGOEySmYlpyiY7/G9pu4i
         Txj1xG2l4W6HxSycmV6vY1HH9IqUiJt6GRX2uDH5EM54XCcP19agz3Qv8zsDuwGz0N4L
         6TZEtit3HCPXy64daLClF8lZtxudKDJArZT1kI4CDmSmQUOp5BXBgjusfug40u+r7qYl
         Y6oS5Fp56boO2wb7/cxJBmi5BfNEGEAbl9LjI+JLidjXc6MtdQndHb8O9hgJ3hXyldtB
         IkgQ==
X-Gm-Message-State: AOAM533QqzYTknCV3mPftCi7yI5SJeoxyHfrgHZg8aKCFRYAf0ZaY8qh
        PkxqDl8IhuigMarRl675nHJ4MA==
X-Google-Smtp-Source: ABdhPJydj1PELrX33LMT6/dBfXUKNCO9kgla7zUsILNl2j83CZTMGIm/PTA6YBveusVU2TYeRrwRXQ==
X-Received: by 2002:a63:b66:: with SMTP id a38mr11615309pgl.116.1613808678557;
        Sat, 20 Feb 2021 00:11:18 -0800 (PST)
Received: from leoy-ThinkPad-X240s (96.45.177.130.16clouds.com. [96.45.177.130])
        by smtp.gmail.com with ESMTPSA id ke13sm10791624pjb.44.2021.02.20.00.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 00:11:18 -0800 (PST)
Date:   Sat, 20 Feb 2021 16:11:10 +0800
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
Subject: Re: [PATCH 1/7] perf cs-etm: Split up etm queue setup function
Message-ID: <20210220081110.GA3824@leoy-ThinkPad-X240s>
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210212144513.31765-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212144513.31765-2-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Feb 12, 2021 at 04:45:07PM +0200, James Clark wrote:
> Refactor the function into separate allocation and
> timestamp search parts. Later the timestamp search
> will be done multiple times.

The new introduced function cs_etm__search_first_timestamp() is to
search timestamp; if it cannot find any valid timestamp, it will
drop all packets for every queue with the logic:

  cs_etm__search_first_timestamp()
  {
     timestamp = cs_etm__etmq_get_timestamp();

     if (timestamp)
       return auxtrace_heap__add();  -> heapify timestamp

     cs_etm__clear_all_packet_queues();  -> clear all packets
     return 0;
  }

If the function cs_etm__search_first_timestamp() is invoked for multiple
times, is it possible to clear all packets in the middle of decoding?

From my understanding, it makes sense to drop the trace data at the
very early decoding so that can get the timestamp for packets,
afterwards the packets should always have valid timestamp?  If so, I
don't think it's necessary to contain the function
cs_etm__clear_all_packet_queues() in cs_etm__search_first_timestamp().

I will go back to check this conclusion is correct or not after I
have better understanding for the whole patch set.  Just note here.

Thanks,
Leo

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 60 +++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index a2a369e2fbb6..27894facae5e 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -765,33 +765,12 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm)
>  	return NULL;
>  }
>  
> -static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> -			       struct auxtrace_queue *queue,
> -			       unsigned int queue_nr)
> +static int cs_etm__search_first_timestamp(struct cs_etm_queue *etmq)
>  {
>  	int ret = 0;
> +	u64 timestamp;
>  	unsigned int cs_queue_nr;
>  	u8 trace_chan_id;
> -	u64 timestamp;
> -	struct cs_etm_queue *etmq = queue->priv;
> -
> -	if (list_empty(&queue->head) || etmq)
> -		goto out;
> -
> -	etmq = cs_etm__alloc_queue(etm);
> -
> -	if (!etmq) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> -
> -	queue->priv = etmq;
> -	etmq->etm = etm;
> -	etmq->queue_nr = queue_nr;
> -	etmq->offset = 0;
> -
> -	if (etm->timeless_decoding)
> -		goto out;
>  
>  	/*
>  	 * We are under a CPU-wide trace scenario.  As such we need to know
> @@ -808,7 +787,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  		 */
>  		ret = cs_etm__get_data_block(etmq);
>  		if (ret <= 0)
> -			goto out;
> +			return ret;
>  
>  		/*
>  		 * Run decoder on the trace block.  The decoder will stop when
> @@ -817,7 +796,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  		 */
>  		ret = cs_etm__decode_data_block(etmq);
>  		if (ret)
> -			goto out;
> +			return ret;
>  
>  		/*
>  		 * Function cs_etm_decoder__do_{hard|soft}_timestamp() does all
> @@ -849,10 +828,33 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  	 * Note that packets decoded above are still in the traceID's packet
>  	 * queue and will be processed in cs_etm__process_queues().
>  	 */
> -	cs_queue_nr = TO_CS_QUEUE_NR(queue_nr, trace_chan_id);
> -	ret = auxtrace_heap__add(&etm->heap, cs_queue_nr, timestamp);
> -out:
> -	return ret;
> +	cs_queue_nr = TO_CS_QUEUE_NR(etmq->queue_nr, trace_chan_id);
> +	return auxtrace_heap__add(&etmq->etm->heap, cs_queue_nr, timestamp);
> +}
> +
> +static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
> +			       struct auxtrace_queue *queue,
> +			       unsigned int queue_nr)
> +{
> +	struct cs_etm_queue *etmq = queue->priv;
> +
> +	if (list_empty(&queue->head) || etmq)
> +		return 0;
> +
> +	etmq = cs_etm__alloc_queue(etm);
> +
> +	if (!etmq)
> +		return -ENOMEM;
> +
> +	queue->priv = etmq;
> +	etmq->etm = etm;
> +	etmq->queue_nr = queue_nr;
> +	etmq->offset = 0;
> +
> +	if (etm->timeless_decoding)
> +		return 0;
> +	else
> +		return cs_etm__search_first_timestamp(etmq);
>  }
>  
>  static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
> -- 
> 2.28.0
> 
