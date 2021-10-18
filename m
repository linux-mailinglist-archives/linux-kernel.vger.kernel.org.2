Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A519431AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 15:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhJRNZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 09:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhJRNZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 09:25:47 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65940C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 06:23:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m21so16158675pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R+1USC3iQq0ZAvIItTsw6HosKvj2fbemSqUsaeohBuw=;
        b=WlQxnaucIkZlOCh6Rz+2Xk3MFZLaB4kWG38nu1qslLpAGTqm+shHcAxExqy0tudbCH
         XT54H8Rj6osg5AZaratb4zeXr4WVwzJdzhFgjRDvCX/jo0Z9vT/DDyyQH6TyLUuK9j55
         Xgx47BCulMhBdVMJ6WPDOLh1DQIeJttnRJ3IogL7oDxTW/pLFiKqBwmdgusIn3w0rpoO
         ttXw4zm4UxMw6RrKMxSRB5iBrzZg/qFFJHKBYO2sgoEsbUHYmHV8JKrrv7fODql5dn1G
         h3Fru9DDQ05zB8xSN+dLCHrun43W7qzVQMJ+8lR7VNRovWDEkSb/Tfqq7K+CjQdHK5c4
         k4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R+1USC3iQq0ZAvIItTsw6HosKvj2fbemSqUsaeohBuw=;
        b=pwcYNjRAGEnNsNAYn785B0mapdTesNrkbT2aGwlACoGI/5LB4lWEEL7vt23Pk6xiKr
         73x2zQhKCxm0jSE3HUEyBDjKIHL/4iYsct8tBuRGSIinXpkqHhZA4lRgpwoNP9mW2ScF
         b5hKlRHRTQR/c89G3Ti6s3KhabomDP2B8XzrGD/FKdOeRyaxahLt4SNe5Bnj23KhhXKU
         S/R2lzbIZh+8NM9Y4wvYg3yDgxZk2TYG/H5E+w29hFlimXZHzifCmx+/QGmf2aGD1aDA
         AlIl5TTB0uNXO+k+HoE00cn9aluPpdsOY7n2muK4QpAGQjCapYVZri8LeNVjOECMcHh/
         KXlQ==
X-Gm-Message-State: AOAM531E5PBOulC93q4y0MjVvaC2XMy4S6rqpcs88acI6a2mqbUe1USh
        80WyWV6fyezOHrBm+qmKma7W+A==
X-Google-Smtp-Source: ABdhPJzqjcMdO2pNEtAIDRvyj1G53IS9VcEfSJ+CDLnX8masAEN/glJRmtqpGHxqxAFAiqfZYTSa2g==
X-Received: by 2002:a63:b006:: with SMTP id h6mr15994676pgf.366.1634563415818;
        Mon, 18 Oct 2021 06:23:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id y3sm13114527pge.44.2021.10.18.06.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 06:23:35 -0700 (PDT)
Date:   Mon, 18 Oct 2021 21:23:28 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
Message-ID: <20211018132328.GG130233@leoy-ThinkPad-X240s>
References: <20211004062638.GB174271@leoy-ThinkPad-X240s>
 <f877cfa6-9b25-6445-3806-ca44a4042eaf@arm.com>
 <20211006093620.GA14400@leoy-ThinkPad-X240s>
 <CAM9d7cghXgUbAqUUJjyKAea+9=jxei7RDScgV5Fd_i9bXyXkKA@mail.gmail.com>
 <be937a2e-311b-2a8b-1094-39c203c6d9f3@arm.com>
 <CAM9d7cho2hN+NDWd9-P-AQAf3D8WfPgCpEDe7cD6hk5FoA_c8Q@mail.gmail.com>
 <87dad53f-a9a5-cd36-7348-ee10f4edd8fb@arm.com>
 <20211011142940.GB37383@leoy-ThinkPad-X240s>
 <8a1eafe3-d19e-40d6-f659-de0e9daa5877@arm.com>
 <eae1a617-2624-dc1f-1ddb-ba9f5600819d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eae1a617-2624-dc1f-1ddb-ba9f5600819d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi German,

On Mon, Oct 18, 2021 at 12:01:27PM +0100, German Gomez wrote:
> Hi,
> 
> What do you thing of the patch below? PERF_RECORD_SWITCH events are also
> included for tracing forks. The patch would sit on top of Namhyung's.

Yeah, it's good to add PERF_RECORD_SWITCH.

> On 12/10/2021 12:07, German Gomez wrote:
> > Hi, Leo and Namhyung,
> >
> > I want to make sure I'm on the same page as you regarding this topic.
> >
> > [...]
> >
> > If we are not considering patching the driver at this stage, so we allow
> > hardware tracing on non-root namespaces. I think we could proceed like
> > this:
> >
> >   - For userspace, always use context-switch events as they are
> >     accurate and consistent with namespaces.

I don't think you can always use context-switch events for userspace
samples.  The underlying mechanism is when there have context-switch
event or context packet is coming, it will invoke the function
machine__set_current_tid() to set current pid/tid; afterwards, we
can retrieve the current pid/tid with the function
arm_spe_set_pid_tid_cpu().

The question is that if we want to use the tid/pid info at the same
time for both context-switch events and context packets, then it's
hard to maintain.  E.g. we need to create multiple thread context, one
is used to track pid info coming from context-switch events and
another context is to track pid info from context packet.

To simplify the code, I still think we give context packet priority and
use it if it's avalible.  And we rollback to use context-switch events
for pid/tid when context packet is not avaliable.

> >   - For kernel tracing, if context packets are enabled, use them, but
> >     warn the user that the PIDs correspond to the root namespace.
> >   - Otherwise, use context-switch events and warn the user of the time
> >     inaccuracies.
> >
> > Later, if the driver is patched to disable context packets outside the
> > root namespace, kernel tracing could fall back to using context-switch
> > events and warn the user with a single message about the time
> > inaccuracies.
> >
> > If we are aligned, we could collect your feedback and share an updated
> > patch that considers the warnings.
> >
> > Many thanks
> > Best regards
> 
> ---
>  tools/perf/util/arm-spe.c | 66 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 708323d7c93c..6a2f7a484a80 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -71,6 +71,17 @@ struct arm_spe {
>      u64                kernel_start;
>  
>      unsigned long            num_events;
> +
> +    /*
> +     * Used for PID tracing.
> +     */
> +    u8                exclude_kernel;
> +
> +    /*
> +     * Warning messages.
> +     */
> +    u8                warn_context_pkt_namesapce;
> +    u8                warn_context_switch_ev_accuracy;
>  };
>  
>  struct arm_spe_queue {
> @@ -586,11 +597,42 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
>      return timeless_decoding;
>  }
>  
> +static bool arm_spe__is_exclude_kernel(struct arm_spe *spe) {
> +    struct evsel *evsel;
> +    struct evlist *evlist = spe->session->evlist;
> +
> +    evlist__for_each_entry(evlist, evsel) {
> +    if (evsel->core.attr.type == spe->pmu_type && evsel->core.attr.exclude_kernel)
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
>                      struct auxtrace_queue *queue)
>  {
>      struct arm_spe_queue *speq = queue->priv;
> -    pid_t tid;
> +    pid_t tid = machine__get_current_tid(spe->machine, speq->cpu);
> +    u64 context_id = speq->decoder->record.context_id;
> +
> +    /*
> +    * We're tracing the kernel.
> +    */
> +    if (!spe->exclude_kernel) {

This is incorrect ... 'exclude_kernel' is a global variable and if
it's set then perf will always run below code.

I think here you want to avoid using contect packet for user space
samples, but checking 'exclude_kernel' cannot help for this purpose
since 'exclude_kernel' cannot be used to decide sample mode (kernel
mode or user mode).

Thanks,
Leo

> +        /*
> +         * Use CONTEXT packets in kernel tracing if available and warn the user of the
> +         * values correspond to the root PID namespace.
> +         *
> +         * If CONTEXT packets aren't available but context-switch events are, warn the user
> +         * of the time inaccuracies.
> +         */
> +        if (context_id != (u64) -1) {
> +            tid = speq->decoder->record.context_id;
> +            spe->warn_context_pkt_namesapce = true;
> +        } else if (tid != -1 && context_id == (u64) -1)
> +            spe->warn_context_switch_ev_accuracy = true;
> +    }
>  
>      tid = machine__get_current_tid(spe->machine, speq->cpu);
>      if (tid != -1) {
> @@ -740,7 +782,8 @@ static int arm_spe_process_event(struct perf_session *session,
>          if (err)
>              return err;
>  
> -        if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
> +        if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
> +            event->header.type == PERF_RECORD_SWITCH)
>              err = arm_spe_context_switch(spe, event, sample);
>      }
>  
> @@ -807,7 +850,20 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
>          return arm_spe_process_timeless_queues(spe, -1,
>                  MAX_TIMESTAMP - 1);
>  
> -    return arm_spe_process_queues(spe, MAX_TIMESTAMP);
> +    ret = arm_spe_process_queues(spe, MAX_TIMESTAMP);
> +
> +    if (spe->warn_context_pkt_namesapce)
> +        ui__warning(
> +            "Arm SPE CONTEXT packets used for PID/TID tracing.\n\n"
> +            "PID values correspond to the root PID namespace.\n\n");
> +
> +    if (spe->warn_context_switch_ev_accuracy)
> +        ui__warning(
> +            "No Arm SPE CONTEXT packets found within traces.\n\n"
> +            "Fallback to PERF_RECORD_SWITCH events for PID/TID tracing will have\n"
> +            "workload-dependant timing inaccuracies.\n\n");
> +
> +    return ret;
>  }
>  
>  static void arm_spe_free_queue(void *priv)
> @@ -1083,6 +1139,10 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>  
>      spe->timeless_decoding = arm_spe__is_timeless_decoding(spe);
>  
> +    spe->exclude_kernel = arm_spe__is_exclude_kernel(spe);
> +    spe->warn_context_pkt_namesapce = false;
> +    spe->warn_context_switch_ev_accuracy = false;
> +
>      /*
>       * The synthesized event PERF_RECORD_TIME_CONV has been handled ahead
>       * and the parameters for hardware clock are stored in the session
> -- 
> 2.17.1
