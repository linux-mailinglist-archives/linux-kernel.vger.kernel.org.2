Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5053314CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhCHR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhCHRZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:25:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7851C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:25:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n22so6534487wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSrMcCtXO2Gc8fgmK3B2dNriKujoktzoBllraRSPmQY=;
        b=nshsOx2uZLOhCV8Lo5za223+uFo7Gifmw83chiXJAmDVVLcPGOAF41z6xJN7k6YncG
         Koslsi74Th7uVrO+ZZi6gpYDuYlhMtMgzqwwN6VfnEjzHzzzTBIR936EPX2F/dPO/urh
         xqAuOsIqMsCspn2g4y/6ZErN9zzmSR3SVH9U9h65HEAC3HTxI5j4c5HtAE/+l3KSSf6D
         xXQGph/wZGLtBmh2ZxLoUYkj348QSWbIserm4BROKLPC3+k88HjvoxDoljOWBWeDe4qp
         YWPN+rOTlNNW2/1WPH7TPe08Iwae2KOGxhCRM3obmnBrLf8U227E98srobjmLXnfZ0oc
         0nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSrMcCtXO2Gc8fgmK3B2dNriKujoktzoBllraRSPmQY=;
        b=iKQ41gnJ52XIMmbGiJx/0nHSCZs0GeeBtSlbNozDhvq9MZQ1D2kqc2ePsPO9VbH3po
         rEpmfB7wx1fYG2Wup+YcJ2rpy5muQBQ+qXhXUugp4sw8MzAP86Xo6xvi5vFvv/wyMw6F
         cl6ZwNjFplxAhd6MWAEY71AnyCV1N2mAxJ77m1HikAlSCk8Fj0oOhYfOtS6XWZ/y/P2F
         5g07nbwAwjsuSGog9Kzysfit5+ZZG4HYrh44li++QU/vB6baEBwX2mWET1TtrU4nIKQD
         G/Qo3lqDrAj1g1W0OFfzRbiNn5dnUKnuzsRzX8YFrJuB/T/baWgFzfcUBkS85uGGiEW4
         ltqg==
X-Gm-Message-State: AOAM531VOKP+TTdc0Gh7d+oIo1L3fbkZHXpXxlFc9lpFhe8DUCx4WzvU
        DgCK4Ua8nksa+NH4r6Eth81TklMnLfr/kHFd8iZxfA==
X-Google-Smtp-Source: ABdhPJwxjqQlUdmg7+NPnawLjH6Z6Xwc2jhunIaRvI1cFKbiCVP7KzGL04YGOjb5S2teif4SBJ4TFklwH/Ws+H1QUTg=
X-Received: by 2002:a1c:9d51:: with SMTP id g78mr23957208wme.5.1615224356651;
 Mon, 08 Mar 2021 09:25:56 -0800 (PST)
MIME-Version: 1.0
References: <20210225193543.2920532-1-suzuki.poulose@arm.com> <20210225193543.2920532-11-suzuki.poulose@arm.com>
In-Reply-To: <20210225193543.2920532-11-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 8 Mar 2021 17:25:46 +0000
Message-ID: <CAJ9a7VghourELWQokjDgydwsBObKCg_Puh8zD2L=QiX=RUb=0g@mail.gmail.com>
Subject: Re: [PATCH v4 10/19] coresight: etm-perf: Allow an event to use
 different sinks
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 at 19:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> When a sink is not specified by the user, the etm perf driver
> finds a suitable sink automatically, based on the first ETM
> where this event could be scheduled. Then we allocate the
> sink buffer based on the selected sink. This is fine for a
> CPU bound event as the "sink" is always guaranteed to be
> reachable from the ETM (as this is the only ETM where the
> event is going to be scheduled). However, if we have a thread
> bound event, the event could be scheduled on any of the ETMs
> on the system. In this case, currently we automatically select
> a sink and exclude any ETMs that cannot reach the selected
> sink. This is problematic especially for 1x1 configurations.
> We end up in tracing the event only on the "first" ETM,
> as the default sink is local to the first ETM and unreachable
> from the rest. However, we could allow the other ETMs to
> trace if they all have a sink that is compatible with the
> "selected" sink and can use the sink buffer. This can be
> easily done by verifying that they are all driven by the
> same driver and matches the same subtype. Please note
> that at anytime there can be only one ETM tracing the event.
>
> Adding support for different types of sinks for a single
> event is complex and is not something that we expect
> on a sane configuration.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Tested-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes:
> - Rename sinks_match => sinks_compatible
> - Tighten the check by matching the sink subtype
> - Use user_sink instead of "sink_forced" and clean up the code (Mathieu)
> - More comments, better commit description
> ---
>  .../hwtracing/coresight/coresight-etm-perf.c  | 60 ++++++++++++++++---
>  1 file changed, 52 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 0f603b4094f2..aa0974bd265b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -232,6 +232,25 @@ static void etm_free_aux(void *data)
>         schedule_work(&event_data->work);
>  }
>
> +/*
> + * Check if two given sinks are compatible with each other,
> + * so that they can use the same sink buffers, when an event
> + * moves around.
> + */
> +static bool sinks_compatible(struct coresight_device *a,
> +                            struct coresight_device *b)
> +{
> +       if (!a || !b)
> +               return false;
> +       /*
> +        * If the sinks are of the same subtype and driven
> +        * by the same driver, we can use the same buffer
> +        * on these sinks.
> +        */
> +       return (a->subtype.sink_subtype == b->subtype.sink_subtype) &&
> +              (sink_ops(a) == sink_ops(b));
> +}
> +
>  static void *etm_setup_aux(struct perf_event *event, void **pages,
>                            int nr_pages, bool overwrite)
>  {
> @@ -239,6 +258,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>         int cpu = event->cpu;
>         cpumask_t *mask;
>         struct coresight_device *sink = NULL;
> +       struct coresight_device *user_sink = NULL, *last_sink = NULL;
>         struct etm_event_data *event_data = NULL;
>
>         event_data = alloc_event_data(cpu);
> @@ -249,7 +269,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>         /* First get the selected sink from user space. */
>         if (event->attr.config2) {
>                 id = (u32)event->attr.config2;
> -               sink = coresight_get_sink_by_id(id);
> +               sink = user_sink = coresight_get_sink_by_id(id);
>         }
>
>         mask = &event_data->mask;
> @@ -277,14 +297,33 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>                 }
>
>                 /*
> -                * No sink provided - look for a default sink for one of the
> -                * devices. At present we only support topology where all CPUs
> -                * use the same sink [N:1], so only need to find one sink. The
> -                * coresight_build_path later will remove any CPU that does not
> -                * attach to the sink, or if we have not found a sink.
> +                * No sink provided - look for a default sink for all the ETMs,
> +                * where this event can be scheduled.
> +                * We allocate the sink specific buffers only once for this
> +                * event. If the ETMs have different default sink devices, we
> +                * can only use a single "type" of sink as the event can carry
> +                * only one sink specific buffer. Thus we have to make sure
> +                * that the sinks are of the same type and driven by the same
> +                * driver, as the one we allocate the buffer for. As such
> +                * we choose the first sink and check if the remaining ETMs
> +                * have a compatible default sink. We don't trace on a CPU
> +                * if the sink is not compatible.
>                  */
> -               if (!sink)
> +               if (!user_sink) {
> +                       /* Find the default sink for this ETM */
>                         sink = coresight_find_default_sink(csdev);
> +                       if (!sink) {
> +                               cpumask_clear_cpu(cpu, mask);
> +                               continue;
> +                       }
> +
> +                       /* Check if this sink compatible with the last sink */
> +                       if (last_sink && !sinks_compatible(last_sink, sink)) {
> +                               cpumask_clear_cpu(cpu, mask);
> +                               continue;
> +                       }
> +                       last_sink = sink;
> +               }
>
>                 /*
>                  * Building a path doesn't enable it, it simply builds a
> @@ -312,7 +351,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
>         if (!sink_ops(sink)->alloc_buffer || !sink_ops(sink)->free_buffer)
>                 goto err;
>
> -       /* Allocate the sink buffer for this session */
> +       /*
> +        * Allocate the sink buffer for this session. All the sinks
> +        * where this event can be scheduled are ensured to be of the
> +        * same type. Thus the same sink configuration is used by the
> +        * sinks.
> +        */
>         event_data->snk_config =
>                         sink_ops(sink)->alloc_buffer(sink, event, pages,
>                                                      nr_pages, overwrite);
> --
> 2.24.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
