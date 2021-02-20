Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D1632051E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 12:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhBTLvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 06:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBTLvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 06:51:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9121C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 03:50:28 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 201so515631pfw.5
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 03:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kg4ioz6bfAx/Lh/IDD2LjV5Zlw8cQV4X2x+CpujDirY=;
        b=W5jp7kOiLw8h3tIpkTtMIPz2rBIxw6YC4wN5n81mLHuRu/jVLT8Jmxa7PFdmvRYjPJ
         04hR8gAgoojdVy/LtQ72AgVa4EDrvn3hIbafj16CXLvryYEZXT4wqc7MaDKrZg+vABK3
         /oyMKPc23Mi6qOKly0BpZT7c5KKhdqhBo40Z7o4nB0eiNNDtaSfEW5IYvaFFuf8ebQdX
         m2VaUHU2iB2i74wcOoIMFhmqgyy5LKwBICUW+83N/CewApx78Hn6VZIWz/42FE6dxWdi
         YZw0uH0AS0i2Vsv/AuLiF2YMEUndF9c3QMBeWcDNYjXt6h1foCu+TczsSMJBu/mtKchN
         AyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kg4ioz6bfAx/Lh/IDD2LjV5Zlw8cQV4X2x+CpujDirY=;
        b=qI1mV4zz5kOu19Rq29Z/k9UdxxDIfAjq5sVet1QBcuqsrwbwt9gRukgRdBqJ/Q7QtV
         xMD4ZVK8mHKYsS38PkYWBnNQutvBM1oCIP6t+pHV6ueQov36GXVPCoCT3ouGGV42W2Py
         DY/40sCHlGjtKNu/Qm6fIwdoXGrHQ3GmMmrnBhkYcmN0MdIMEIV2zec5golA1am8+wVd
         SyyxDmpz2N9aJ/F2lLaTVt9toLYMxePWlQSlN/oLtsitxiGHzLv/iretNBWQu2wv4s7V
         JMlbFnpWniNs05aklkE5PySZbxhXxRpOZLvu0a06VzNAAFO9bXUfKv2aoFdfq5Uik7gl
         8qDg==
X-Gm-Message-State: AOAM531/6GUo1LjhYznP+AiJO8YNnkoeu8yPudqIKmeoeOOEC3q2wj01
        DU/oFTT1u/OLF8KQZJOAhDnHUg==
X-Google-Smtp-Source: ABdhPJwy4qQMK/7UAde33BeHLG8SssWXwY3J3+Riai/cUIJefm7KNlCt9zg6kKem4V8euFbj3rR0BQ==
X-Received: by 2002:a05:6a00:138f:b029:1b8:b9d5:3a2c with SMTP id t15-20020a056a00138fb02901b8b9d53a2cmr13919424pfg.10.1613821828235;
        Sat, 20 Feb 2021 03:50:28 -0800 (PST)
Received: from leoy-ThinkPad-X240s (96.45.177.130.16clouds.com. [96.45.177.130])
        by smtp.gmail.com with ESMTPSA id j4sm12309877pfa.131.2021.02.20.03.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 03:50:27 -0800 (PST)
Date:   Sat, 20 Feb 2021 19:50:19 +0800
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
Subject: Re: [PATCH 2/7] perf cs-etm: Only search timestamp in current
 sample's queue.
Message-ID: <20210220115019.GB3824@leoy-ThinkPad-X240s>
References: <20210212144513.31765-1-james.clark@arm.com>
 <20210212144513.31765-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212144513.31765-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 04:45:08PM +0200, James Clark wrote:
> Change initial timestamp search to only operate on the queue
> related to the current event. In a later change the bounds
> of the aux record will also be used to reset the decoder and
> the record is only relevant to a single queue.

I roughly understand this patch tries to establish the mechanism for
timstamp search per CPU, but I am struggling to understand what's issue
you try to address.

So could you give more description for "what's current issue?" and
"why need to use this way to fix the issue?".  This would be very
appreciated.

> This change makes some files that had coresight data
> but didn't syntesise any events start working and generating
> events. I'm not sure of the reason for that. I'd expect this
> change to only affect the ordering of events.

This seems to me that this patch introduces regression.

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 27894facae5e..8f8b448632fb 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -97,7 +97,7 @@ struct cs_etm_queue {
>  /* RB tree for quick conversion between traceID and metadata pointers */
>  static struct intlist *traceid_list;
>  
> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu);
>  static int cs_etm__process_queues(struct cs_etm_auxtrace *etm);
>  static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
>  					   pid_t tid);
> @@ -524,7 +524,6 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
>  static int cs_etm__flush_events(struct perf_session *session,
>  				struct perf_tool *tool)
>  {
> -	int ret;
>  	struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>  						   struct cs_etm_auxtrace,
>  						   auxtrace);
> @@ -534,11 +533,6 @@ static int cs_etm__flush_events(struct perf_session *session,
>  	if (!tool->ordered_events)
>  		return -EINVAL;
>  
> -	ret = cs_etm__update_queues(etm);
> -
> -	if (ret < 0)
> -		return ret;
> -

When flush events, it means the trace data is discontinuous or at the
end of trace data.  If the trace data is discontinuous, we need to use
cs_etm__update_queues() to create new queues.  So if we remove the
calling cs_etm__update_queues(), I suspect it cannot handle the
discontinuous trace data anymore.

>  	if (etm->timeless_decoding)
>  		return cs_etm__process_timeless_queues(etm, -1);
>  
> @@ -851,10 +845,7 @@ static int cs_etm__setup_queue(struct cs_etm_auxtrace *etm,
>  	etmq->queue_nr = queue_nr;
>  	etmq->offset = 0;
>  
> -	if (etm->timeless_decoding)
> -		return 0;
> -	else
> -		return cs_etm__search_first_timestamp(etmq);
> +	return 0;
>  }
>  
>  static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
> @@ -874,14 +865,20 @@ static int cs_etm__setup_queues(struct cs_etm_auxtrace *etm)
>  	return 0;
>  }
>  
> -static int cs_etm__update_queues(struct cs_etm_auxtrace *etm)
> +static int cs_etm__update_queues(struct cs_etm_auxtrace *etm, int cpu)
>  {
> +	int ret;
>  	if (etm->queues.new_data) {
>  		etm->queues.new_data = false;
> -		return cs_etm__setup_queues(etm);
> +		ret = cs_etm__setup_queues(etm);

Just remind, the new parameter "cpu" is introduced in this function,
in theory, cs_etm__update_queues() should work for the specified CPU.
But it always setup queues for all CPUs with calling
cs_etm__setup_queues().

> +		if (ret)
> +			return ret;
>  	}
>  
> -	return 0;
> +	if (!etm->timeless_decoding)
> +		return cs_etm__search_first_timestamp(etm->queues.queue_array[cpu].priv);
> +	else
> +		return 0;

In the original code of cs_etm__update_queues(), if there have no any
new data (or has already setup queues), then it does nothing and
directly bails out.

After applied the up change, it will always search the first timestamp
for the "cpu".

>  }
>  
>  static inline
> @@ -2358,8 +2355,9 @@ static int cs_etm__process_event(struct perf_session *session,
>  	else
>  		timestamp = 0;
>  
> -	if (timestamp || etm->timeless_decoding) {
> -		err = cs_etm__update_queues(etm);
> +	if ((timestamp || etm->timeless_decoding)
> +			&& event->header.type == PERF_RECORD_AUX) {
> +		err = cs_etm__update_queues(etm, sample->cpu);

Here might cause potential issue.  Let's see an example:

If CoreSight uses N:1 model for tracers and sink (just like multiple
ETMs output trace to the same ETR), when "sample->cpu" is 0, it will
only initialize the timestamp for CPU 0.  In the same AUX trace data,
it can contains trace for CPU 1, 2, etc; for this case, the flow
doesn't prepare the timestamp for CPU1/2, so it will fail to generate
samples for CPU 1/2, right?

Thanks,
Leo

>  		if (err)
>  			return err;
>  	}
> -- 
> 2.28.0
> 
