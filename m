Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5891309C46
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhAaM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 07:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhAaML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 07:11:58 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77BAC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 04:02:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id s24so8653811pjp.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 04:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Wc3uUA2H/tMIs/qQu4DYWaAR4LcSw0G3CtOHfYluew=;
        b=CaYRIrc7WPEtJLOwA1ONCd1HJshob9QVVFGSgoCjOqAPLkRsQbCfu4EBXUb6WnvdU3
         fwOeEZ4UoMhhJ4uwOrVMmw+/6k0tbsUq9IHkR+sekNpS1X6Xar8H43BukpcfsDjZ4GB5
         qNHtfDuT7CRjC87c/8CdmtgNuqrIdb/vc8JFNcupC/NINGDdPYxkxXomMED9KhRdOjSQ
         qxocrv9B+Dd7Pm4rUgC92SKxSubmta8pah2SxfoxQ98avK3vTVlRwUmRWmIhjEIRRPFd
         QfOu+3xuUUTmQlo4H4J4GcgU+zmhXAiph2eIyUEo7AdwHCXmdfdn5TOduRD8UMwOW6BH
         XfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Wc3uUA2H/tMIs/qQu4DYWaAR4LcSw0G3CtOHfYluew=;
        b=QwgOEK3eUqrn3U7Cly+ua1vWZ9V7TPnjyhOz7gAeaIYHepdDYcAbiI2aVqFMW/C8ht
         nvioivBbjM6Mb0BByd53VgFlXnM09KsAJUZ4PBiz7aFLpv+ueFzuo/MkN4giuJBQ7RsD
         MIMFG1o6znP7ZFAOHgN/NcoXgQJkKntCCU/huRIWyaVo3jmCubniaVzfqKqSboQNqOWh
         viJP2zRxOVuXMTtv3tLuf9Hzhp2Je4UbDCrHcIBZBBatKUCFSB1WSpIkFd5FGka+tDpF
         6/pW3eLIcH4Xt1HxOdN4WhDgkuVHfbuVe4f7U/3aIwwAgOiYd6gVZLhxetqsojthOVsh
         LQ5g==
X-Gm-Message-State: AOAM532CXZlh+wjJNkLt+U82kF14/FXi18Ve7n9EpDSJGlzs7cOEg+nB
        26Bw0fDAtVoawxCf26jRPNRxbg==
X-Google-Smtp-Source: ABdhPJyuTvqCqtlLQPK0HydVLrqI8Tkrcq+tOmmIlEvLwu0L1r44gBuvrIaKe8wUdkpjxwUf22w54A==
X-Received: by 2002:a17:90a:1082:: with SMTP id c2mr12644697pja.183.1612094525297;
        Sun, 31 Jan 2021 04:02:05 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.180.10])
        by smtp.gmail.com with ESMTPSA id ne6sm12217059pjb.44.2021.01.31.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jan 2021 04:02:04 -0800 (PST)
Date:   Sun, 31 Jan 2021 20:01:56 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 8/8] perf arm-spe: Set thread TID
Message-ID: <20210131120156.GB230721@leoy-ThinkPad-X240s>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210119144658.793-8-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119144658.793-8-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Tue, Jan 19, 2021 at 04:46:58PM +0200, James Clark wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> Set thread TID for SPE samples. Now that the context ID is saved
> in each record it can be used to set the TID for a sample.
> 
> The context ID is only present in SPE data if the kernel is
> compiled with CONFIG_PID_IN_CONTEXTIDR and perf record is
> run as root. Otherwise the PID of the first process is assigned
> to each SPE sample.

I tested this patch series on Hisilicon D06, it outputs the result as
expected.  I am comfortable for the testing result based our two sides
on two different platforms.

Based on the discussion in the thread [1], IIUC, there have concern for
using CONTEXTIDR for non-root namespace.  Thus the patch 08/08 is
limited to support PID tracing in the root namespace, so we have two
options:

Option 1: by merging patches 07/08 and 08/08, we can firstly support PID
tracing for root namespace, and later we can extend to support PID
tracing in container (and in VMs).

Option 2: we can use the software method to establish PID for SPE
trace, which can base on kernel's events PERF_RECORD_SWITCH /
PERF_RECORD_SWITCH_CPU_WIDE and check context switch ip.

To be honest, I am a bit concern for option 1 for later might
introduce regression when later support PID for containers (and VMs).
If you have a plan for option 1, I think it's good to record current
limitation and the plan for next step in the commit log, so we can merge
this patch at this time and later extend for containers.

Otherwise, we need to consider how to implement the PID tracing with
option 2.  If it is the case, we should firstly only merge patches
01 ~ 06 for data source enabling.  How about you think for this?

> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Besides for techinical question, you could add your "Co-developed-by"
tags for patches 06, 07, 08/08, which you have took time to refin them.

Thanks you for kindly efforts.

[1] https://lore.kernel.org/patchwork/patch/1353286/

> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Wei Li <liwei391@huawei.com>
> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/arm-spe.c | 75 ++++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 27a0b9dfe22d..9828fad7e516 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -223,6 +223,46 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
>  		PERF_RECORD_MISC_USER;
>  }
>  
> +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> +				    struct auxtrace_queue *queue)
> +{
> +	struct arm_spe_queue *speq = queue->priv;
> +	pid_t tid;
> +
> +	tid = machine__get_current_tid(spe->machine, speq->cpu);
> +	if (tid != -1) {
> +		speq->tid = tid;
> +		thread__zput(speq->thread);
> +	} else
> +		speq->tid = queue->tid;
> +
> +	if ((!speq->thread) && (speq->tid != -1)) {
> +		speq->thread = machine__find_thread(spe->machine, -1,
> +						    speq->tid);
> +	}
> +
> +	if (speq->thread) {
> +		speq->pid = speq->thread->pid_;
> +		if (queue->cpu == -1)
> +			speq->cpu = speq->thread->cpu;
> +	}
> +}
> +
> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
> +{
> +	int err;
> +	struct arm_spe *spe = speq->spe;
> +	struct auxtrace_queue *queue;
> +
> +	err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
> +	if (err)
> +		return err;
> +
> +	queue = &speq->spe->queues.queue_array[speq->queue_nr];
> +	arm_spe_set_pid_tid_cpu(speq->spe, queue);
> +	return 0;
> +}
> +
>  static void arm_spe_prep_sample(struct arm_spe *spe,
>  				struct arm_spe_queue *speq,
>  				union perf_event *event,
> @@ -431,6 +471,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>  static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>  {
>  	struct arm_spe *spe = speq->spe;
> +	const struct arm_spe_record *record;
>  	int ret;
>  
>  	if (!spe->kernel_start)
> @@ -450,6 +491,11 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>  		if (ret < 0)
>  			continue;
>  
> +		record = &speq->decoder->record;
> +		ret = arm_spe_set_tid(speq, record->context_id);
> +		if (ret)
> +			return ret;
> +
>  		ret = arm_spe_sample(speq);
>  		if (ret)
>  			return ret;
> @@ -500,6 +546,10 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
>  
>  		record = &speq->decoder->record;
>  
> +		ret = arm_spe_set_tid(speq, record->context_id);
> +		if (ret)
> +			return ret;
> +
>  		speq->timestamp = record->timestamp;
>  		ret = auxtrace_heap__add(&spe->heap, queue_nr, speq->timestamp);
>  		if (ret)
> @@ -552,31 +602,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
>  	return timeless_decoding;
>  }
>  
> -static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
> -				    struct auxtrace_queue *queue)
> -{
> -	struct arm_spe_queue *speq = queue->priv;
> -	pid_t tid;
> -
> -	tid = machine__get_current_tid(spe->machine, speq->cpu);
> -	if (tid != -1) {
> -		speq->tid = tid;
> -		thread__zput(speq->thread);
> -	} else
> -		speq->tid = queue->tid;
> -
> -	if ((!speq->thread) && (speq->tid != -1)) {
> -		speq->thread = machine__find_thread(spe->machine, -1,
> -						    speq->tid);
> -	}
> -
> -	if (speq->thread) {
> -		speq->pid = speq->thread->pid_;
> -		if (queue->cpu == -1)
> -			speq->cpu = speq->thread->cpu;
> -	}
> -}
> -
>  static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
>  {
>  	unsigned int queue_nr;
> -- 
> 2.28.0
> 
