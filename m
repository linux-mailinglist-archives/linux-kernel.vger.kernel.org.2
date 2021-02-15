Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBC31C098
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhBOR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbhBOQ2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:28:25 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14078C0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:27:44 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id n6so9605144wrv.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rXB1Evv0m8kwqlTKU02VIKHeXR8nzMaC4DQc01Q54IM=;
        b=jpSEHilwhMfZXhuzQavrU9xggKGtA1Do9+v2S4SbsBJsYvMUHLVn/Zn3gaoN7rzI+n
         6Ukc3xZsQoYdcdrdKMPkAb1BxsgvArb57fJsVwVxpHFmpMcZbSFzxp2zl7zqdCC4y6VW
         Z/yCaATPDub6lzldZrWM7DpxDRTkJ33TndR0HHDEojEOOmPepsIn8Q+KRZ3DYCfNKeLF
         AhNdsR6/Ga1CEWLZbcO12xBTtGx3pqTVdWha+qbSgL3cmsCQWJ+gmz9jp2NVpMihUqtW
         p1KBrYKBrNKqsiTJwbcaYw0a9jplCYC33IyRoF4KvZqQcMnaXO/6ZveKoQxoch2vHBxS
         RjYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rXB1Evv0m8kwqlTKU02VIKHeXR8nzMaC4DQc01Q54IM=;
        b=Yx6GlwSiOA2YxHz9r5NTDp+nG5V88bbtCLmaeUfds/Qr0ZGLaYj86aGhkft7GlZUBv
         6s1eabfJ+8QcbjdZnDklPrYqCw4EKLOT79FMV40tl2IqzEGQ2gY69IjN0VKVqoVrlPFP
         GT+gR6thPmtV4kM7R98XLyRhTgoKS/EwUx92/GbNlgLJ4AqLszmr3wl3Gv41z9pKY3fV
         XeVQF6et0m+wPFUUYtDq27blXinstwUaScH/W+Swm+GuFPpJP2HFcCemCKsTq2+vFzNt
         /75bW0w3yi5KPqgeyvEelAP3gHYqoR5xs3EJFsryhwybUBvf7tevh+kkMJ05LPP6Apfz
         7Iww==
X-Gm-Message-State: AOAM530+Tbll535FotjqunItDKhNPd6TjPcC3EJ5OKpyXTiyGd+l9N4Y
        bzTKU0Dy6bYY9Rw2U+KS71u9tv022SsFy+llUggqSw==
X-Google-Smtp-Source: ABdhPJyDpc7MynAhXyFRIg/WKYAL04+utCgB69x2/Yf0/Nl1c8E6Xn2JStfvEXn4jsZQnJVgpBAvRZ+UHZvPnw3/NGk=
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr19244591wrv.182.1613406462803;
 Mon, 15 Feb 2021 08:27:42 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com> <1611737738-1493-8-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-8-git-send-email-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Feb 2021 16:27:32 +0000
Message-ID: <CAJ9a7VgFstzt7_nqJzDfRk4vi+Y_Er5vb=uR4U2SbeBkjxs-UQ@mail.gmail.com>
Subject: Re: [PATCH V3 07/14] coresight: etm-perf: Handle stale output handles
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> The context associated with an ETM for a given perf event
> includes :
>   - handle -> the perf output handle for the AUX buffer.
>   - the path for the trace components
>   - the buffer config for the sink.
>
> The path and the buffer config are part of the "aux_priv" data
> (etm_event_data) setup by the setup_aux() callback, and made available
> via perf_get_aux(handle).
>
> Now with a sink supporting IRQ, the sink could "end" an output
> handle when the buffer reaches the programmed limit and would try
> to restart a handle. This could fail if there is not enough
> space left the AUX buffer (e.g, the userspace has not consumed
> the data). This leaves the "handle" disconnected from the "event"
> and also the "perf_get_aux()" cleared. This all happens within
> the sink driver, without the etm_perf driver being aware.
> Now when the event is actually stopped, etm_event_stop()
> will need to access the "event_data". But since the handle
> is not valid anymore, we loose the information to stop the
> "trace" path. So, we need a reliable way to access the etm_event_data
> even when the handle may not be active.
>
> This patch replaces the per_cpu handle array with a per_cpu context
> for the ETM, which tracks the "handle" as well as the "etm_event_data".
> The context notes the etm_event_data at etm_event_start() and clears
> it at etm_event_stop(). This makes sure that we don't access a
> stale "etm_event_data" as we are guaranteed that it is not
> freed by free_aux() as long as the event is active and tracing,
> also provides us with access to the critical information
> needed to wind up a session even in the absence of an active
> output_handle.
>
> This is not an issue for the legacy sinks as none of them supports
> an IRQ and is centrally handled by the etm-perf.
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 45 +++++++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index eb9e7e9..a3977b0 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -24,7 +24,26 @@
>  static struct pmu etm_pmu;
>  static bool etm_perf_up;
>
> -static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
> +/*
> + * An ETM context for a running event includes the perf aux handle
> + * and aux_data. For ETM, the aux_data (etm_event_data), consists of
> + * the trace path and the sink configuration. The event data is accessible
> + * via perf_get_aux(handle). However, a sink could "end" a perf output
> + * handle via the IRQ handler. And if the "sink" encounters a failure
> + * to "begin" another session (e.g due to lack of space in the buffer),
> + * the handle will be cleared. Thus, the event_data may not be accessible
> + * from the handle when we get to the etm_event_stop(), which is required
> + * for stopping the trace path. The event_data is guaranteed to stay alive
> + * until "free_aux()", which cannot happen as long as the event is active on
> + * the ETM. Thus the event_data for the session must be part of the ETM context
> + * to make sure we can disable the trace path.
> + */
> +struct etm_ctxt {
> +       struct perf_output_handle handle;
> +       struct etm_event_data *event_data;
> +};
> +
> +static DEFINE_PER_CPU(struct etm_ctxt, etm_ctxt);
>  static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
>
>  /* ETMv3.5/PTM's ETMCR is 'config' */
> @@ -332,7 +351,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>  {
>         int cpu = smp_processor_id();
>         struct etm_event_data *event_data;
> -       struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
> +       struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
> +       struct perf_output_handle *handle = &ctxt->handle;
>         struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
>         struct list_head *path;
>
> @@ -374,6 +394,8 @@ static void etm_event_start(struct perf_event *event, int flags)
>         if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
>                 goto fail_disable_path;
>
> +       /* Save the event_data for this ETM */
> +       ctxt->event_data = event_data;
>  out:
>         return;
>
> @@ -392,13 +414,20 @@ static void etm_event_stop(struct perf_event *event, int mode)
>         int cpu = smp_processor_id();
>         unsigned long size;
>         struct coresight_device *sink, *csdev = per_cpu(csdev_src, cpu);
> -       struct perf_output_handle *handle = this_cpu_ptr(&ctx_handle);
> -       struct etm_event_data *event_data = perf_get_aux(handle);
> +       struct etm_ctxt *ctxt = this_cpu_ptr(&etm_ctxt);
> +       struct perf_output_handle *handle = &ctxt->handle;
> +       struct etm_event_data *event_data = ctxt->event_data;
>         struct list_head *path;
>
> +       /* Clear the event_data as this ETM is stopping the trace. */
> +       ctxt->event_data = NULL;
>         if (event->hw.state == PERF_HES_STOPPED)
>                 return;
>
> +       /* We must have a valid event_data for a running event */
> +       if (WARN_ON(!event_data))
> +               return;
> +
>         if (!csdev)
>                 return;
>
> @@ -416,7 +445,13 @@ static void etm_event_stop(struct perf_event *event, int mode)
>         /* tell the core */
>         event->hw.state = PERF_HES_STOPPED;
>
> -       if (mode & PERF_EF_UPDATE) {
> +       /*
> +        * If the handle is not bound to an event anymore
> +        * (e.g, the sink driver was unable to restart the
> +        * handle due to lack of buffer space), we don't
> +        * have to do anything here.
> +        */
> +       if (handle->event && (mode & PERF_EF_UPDATE)) {
>                 if (WARN_ON_ONCE(handle->event != event))
>                         return;
>
> --
> 2.7.4
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
