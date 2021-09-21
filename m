Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA426413940
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhIURyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhIURyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:54:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF10C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:53:11 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id me1so142781pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g3Ie4lAZHJkjTqSCJA2msx6oJOosrwYmylIab5VDUbQ=;
        b=s7B3qh1A0Uy+Ta2/mNnDyDzsCwhMkYxPlleUMXsJONjNJISZpfNJ6Z7msPIYVDagbb
         xefBxySQRsjdJRuaIvZvjJdVDrKSEfpnQiOeXXmt4q5G6Y12bDfP/QmQmUIuWmvXNe7i
         wsU7OTuo/cJI/qe/1KsDqepG6VgKMdQyqFGRk9gEl2D0uvmBaHVtjSqRO/YUVScl5GgU
         SIGAfg966uKy2+kXknDY83z4YwBUchdG7iPwlC5kq4QyJQkVRH/9HR1U4yfpZXat6Rnz
         GFwoXZH5StgHI+6fXrFcCbL5xQKb3TVxZMxpR//Ry2QBRC/77aqROTL4QdcIhvtFvdRw
         6Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3Ie4lAZHJkjTqSCJA2msx6oJOosrwYmylIab5VDUbQ=;
        b=mCWLYpLpcoFU8UF51karH7E5avjYrLZOPTVEn9qa5MxKYtG7P5vbKCi2sFT1LGAXT/
         uf2CRVoByqyAtPzMu1Aj+kX79+2N1KtRPp2yVAHRnb/cszxzRLyC3KYXmY1JNzTm+Ub4
         ATm//xeCpK+pDgjiLzxdz3aU0htxLHrLsS6iKbyoH7oRx71skSs8S7OwlmlzyJxwxskV
         RpTeRwezqnmDkN9ghKVpyAo1iMRE1CSSia+O0Kl/6Z65SiaKvtitId2FX/BQAqCehZJN
         q7ZFve5PxtHCEglSplxst0sIy4/5rZ63VE9wP/RooMzItDlofHvpntyRd40h6t0LMbVQ
         +1ww==
X-Gm-Message-State: AOAM5303zhbUd3eP9S8y945AamniE0unriVS140tOHdJy8No3ZhN9dSf
        /bMAwu5wZp33c3M5GqNZhE0cbQ==
X-Google-Smtp-Source: ABdhPJyGskc7dwQIIgpQA/e6j4h/k14mRv90byezKQlM6w0LRJtz6XCXtFKZo3PfvoMAY1nUXDSucA==
X-Received: by 2002:a17:902:ce83:b0:13b:67d5:2c4e with SMTP id f3-20020a170902ce8300b0013b67d52c4emr28886949plg.45.1632246791266;
        Tue, 21 Sep 2021 10:53:11 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g141sm18118677pfb.128.2021.09.21.10.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:53:10 -0700 (PDT)
Date:   Tue, 21 Sep 2021 11:53:08 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: Don't immediately close events that are run
 on invalid CPU/sink combos
Message-ID: <20210921175308.GF2059841@p14s>
References: <20210921130231.386095-1-james.clark@arm.com>
 <20210921151721.GA2059841@p14s>
 <2d1326ea-a60c-8723-28a4-891a5478846f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d1326ea-a60c-8723-28a4-891a5478846f@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 05:22:23PM +0100, Suzuki K Poulose wrote:
> On 21/09/2021 16:17, Mathieu Poirier wrote:
> > On Tue, Sep 21, 2021 at 02:02:31PM +0100, James Clark wrote:
> > > When a traced process runs on a CPU that can't reach the selected sink,
> > > the event will be stopped with PERF_HES_STOPPED. This means that even if
> > > the process migrates to a valid CPU, tracing will not resume.
> > > 
> > > This can be reproduced (on N1SDP) by using taskset to start the process
> > > on CPU 0, and then switching it to CPU 2 (ETF 1 is only reachable from
> > > CPU 2):
> > > 
> > >    taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- taskset --cpu-list 2 ls
> > > 
> > > This produces a single 0 length AUX record, and then no more trace:
> > > 
> > >    0x3c8 [0x30]: PERF_RECORD_AUX offset: 0 size: 0 flags: 0x1 [T]
> > > 
> > > After the fix, the same command produces normal AUX records. The perf
> > > self test "89: Check Arm CoreSight trace data recording and synthesized
> > > samples" no longer fails intermittently. This was because the taskset in
> > > the test is after the fork, so there is a period where the task is
> > > scheduled on a random CPU rather than forced to a valid one.
> > > 
> > > Specifically selecting an invalid CPU will still result in a failure to
> > > open the event because it will never produce trace:
> > > 
> > >    ./perf record -C 2 -e cs_etm/@tmc_etf0/
> > >    failed to mmap with 12 (Cannot allocate memory)
> > > 
> > > The only scenario that has changed is if the CPU mask has a valid CPU
> > > sink combo in it.
> > > 
> > > Testing
> > > =======
> > > 
> > > * Coresight self test passes consistently:
> > >    ./perf test Coresight
> > > 
> > > * CPU wide mode still produces trace:
> > >    ./perf record -e cs_etm// -a
> > > 
> > > * Invalid -C options still fail to open:
> > >    ./perf record -C 2,3 -e cs_etm/@tmc_etf0/
> > >    failed to mmap with 12 (Cannot allocate memory)
> > > 
> > > * Migrating a task to a valid sink/CPU now produces trace:
> > >    taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- taskset --cpu-list 2 ls
> > > 
> > > * If the task remains on an invalid CPU, no trace is emitted:
> > >    taskset --cpu-list 0 ./perf record -e cs_etm/@tmc_etf1/ --per-thread -- ls
> > > 
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >   .../hwtracing/coresight/coresight-etm-perf.c  | 27 +++++++++++++++----
> > >   1 file changed, 22 insertions(+), 5 deletions(-)
> > 
> > Very interesting corner case - and I like your solution.  Arnaldo, please
> > consider.
> > 
> > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > 
> 
> PS: This is for coresight driver, I can pick this up. Otherwise,
> 

As yes, silly me... Sure, please add it to the tree.

> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> 
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > index 8ebd728d3a80..79346f0f0e0b 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > > @@ -452,9 +452,14 @@ static void etm_event_start(struct perf_event *event, int flags)
> > >   	 * sink from this ETM. We can't do much in this case if
> > >   	 * the sink was specified or hinted to the driver. For
> > >   	 * now, simply don't record anything on this ETM.
> > > +	 *
> > > +	 * As such we pretend that everything is fine, and let
> > > +	 * it continue without actually tracing. The event could
> > > +	 * continue tracing when it moves to a CPU where it is
> > > +	 * reachable to a sink.
> > >   	 */
> > >   	if (!cpumask_test_cpu(cpu, &event_data->mask))
> > > -		goto fail_end_stop;
> > > +		goto out;
> > >   	path = etm_event_cpu_path(event_data, cpu);
> > >   	/* We need a sink, no need to continue without one */
> > > @@ -466,16 +471,15 @@ static void etm_event_start(struct perf_event *event, int flags)
> > >   	if (coresight_enable_path(path, CS_MODE_PERF, handle))
> > >   		goto fail_end_stop;
> > > -	/* Tell the perf core the event is alive */
> > > -	event->hw.state = 0;
> > > -
> > >   	/* Finally enable the tracer */
> > >   	if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> > >   		goto fail_disable_path;
> > > +out:
> > > +	/* Tell the perf core the event is alive */
> > > +	event->hw.state = 0;
> > >   	/* Save the event_data for this ETM */
> > >   	ctxt->event_data = event_data;
> > > -out:
> > >   	return;
> > >   fail_disable_path:
> > > @@ -517,6 +521,19 @@ static void etm_event_stop(struct perf_event *event, int mode)
> > >   	if (WARN_ON(!event_data))
> > >   		return;
> > > +	/*
> > > +	 * Check if this ETM was allowed to trace, as decided at
> > > +	 * etm_setup_aux(). If it wasn't allowed to trace, then
> > > +	 * nothing needs to be torn down other than outputting a
> > > +	 * zero sized record.
> > > +	 */
> > > +	if (handle->event && (mode & PERF_EF_UPDATE) &&
> > > +	    !cpumask_test_cpu(cpu, &event_data->mask)) {
> > > +		event->hw.state = PERF_HES_STOPPED;
> > > +		perf_aux_output_end(handle, 0);
> > > +		return;
> > > +	}
> > > +
> > >   	if (!csdev)
> > >   		return;
> > > -- 
> > > 2.28.0
> > > 
> 
