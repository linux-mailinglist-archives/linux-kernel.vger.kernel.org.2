Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5344E393287
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbhE0Pjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbhE0Pjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:39:40 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5695C061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:38:06 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id j30so639670ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2crjK0WkoLk1yIKgn4T+sf7fuQ4+lslYOkCkxigqz6k=;
        b=HZqATLPbPzHq6IDZSeyW6yH3VLhnhrOp5bu1V+jQffAojleUQIGYzRCLBTyyAF7nTw
         QZdn6q3lNQvvH94cVuMX6+YSeETwJjiUqVI3hHgZEWGje65RasGlKI9IU2/Qb6W5IpLp
         6aUq14d4eX44abInTxfQRMnCoTlWzntjphX6fjdlh9f5UrKWtoqdgrFS6068t/uofmQE
         C+Had2Qt+I5/EBQaI2YQq1uvB7x5OhaH1Ts6Q1Yg9zqyx1Dj6uD8LBdBx7+tmCU2Kqik
         QBO9GxjTTyNCd7BpIvdFDrbKyasY2MWTur57x6ZjClfx+FC85KZkhYHcxjjx58ISBnfL
         m8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2crjK0WkoLk1yIKgn4T+sf7fuQ4+lslYOkCkxigqz6k=;
        b=DnKPBNurpSmEcuHrrWu9nFIodQ7oCx3/LN5ybjA7iRFuG4QDEJcuvYC8mX/WdAUnlV
         VJgrlRMvi+Ra4V24MnRSAeiok+KTiOBqTSsqiggih/yypwVoqTFc9wO8XzSEKx/rs/J4
         AgTLkG4xyuU4M8N/Oj8KSFJp1mSMrupSiAL/cwXJYPUalrCC3r9tw70wNBYbdDIMWzw6
         MmLwbN80Q7l9AIjBm5w9JGBnEhQ0uKxEL+nfC0HWLgz75HCwp4m9rB/p+FmkFSjzumim
         z3PFFgKCENHJat0n7RhlTVw2VTNXvomOoQ3Z4Sa2sGfhhr+2szlvwUX1e60YmQ8IcyUC
         8uyw==
X-Gm-Message-State: AOAM5338X+m+Ef6PH+tK8GjzGbtI5m+3Jh0imbLjyd2q0sl5MJfsGr71
        /U8BhKjm7jiCeJcNB85NfDeOqNLDMPZkuo6CbFpRMw==
X-Google-Smtp-Source: ABdhPJwEeY2zSrutI4aF0G0bm/TwO5xOgq5IIyL9IMRKy/P97LQ/FPMd1WBfxtwT4wPgD2diYeMeoKv6gQKs6NAZbeM=
X-Received: by 2002:a92:c54a:: with SMTP id a10mr3421574ilj.140.1622129885983;
 Thu, 27 May 2021 08:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210527104234.24313-1-james.clark@arm.com> <11822824-7486-2333-f039-bfd801b86922@arm.com>
In-Reply-To: <11822824-7486-2333-f039-bfd801b86922@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 27 May 2021 09:37:54 -0600
Message-ID: <CANLsYkynQbGRhOmyramX+nSHvVnH_nSJb=t03Dp-2WeXP3ZYAw@mail.gmail.com>
Subject: Re: [RFC PATCH v3] perf cs-etm: Split Coresight decode by aux records
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Al Grant <al.grant@arm.com>,
        branislav.rankov@arm.com, Denis Nikitin <denik@chromium.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 at 07:46, James Clark <james.clark@arm.com> wrote:
>
>
>
> On 27/05/2021 13:42, James Clark wrote:
> > Populate the auxtrace queues using AUX records rather than whole
> > auxtrace buffers.
> >
> ...
> > Snapshot mode still needs to be tested.
> >
>
> Snapshot mode is also working, but needs the following patch applied to reverse aux_offset
> from the end of the buffer to the beginning:

It might be better to send another revision with this patch included
in to make sure everyone is looking at (and testing) the same thing.

>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 5d6c03488187..9db556e14dfa 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2700,6 +2700,7 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session,
>         struct perf_record_auxtrace *auxtrace_event;
>         union perf_event auxtrace_fragment;
>         bool matchesCpuPid;
> +       __u64 aux_offset;
>         struct cs_etm_auxtrace *etm = container_of(session->auxtrace,
>                                                    struct cs_etm_auxtrace,
>                                                    auxtrace);
> @@ -2730,19 +2731,26 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session,
>         else
>                 matchesCpuPid = auxtrace_event->cpu == sample->cpu;
>
> +       /*
> +        * In snapshot/overwrite mode, the head points to the end of the buffer so aux_offset needs
> +        * to have the size subtracted so it points to the beginning as in normal mode.
> +        */
> +       if (aux_event->flags && PERF_AUX_FLAG_OVERWRITE)
> +               aux_offset = aux_event->aux_offset - aux_event->aux_size;
> +       else
> +               aux_offset = aux_event->aux_offset;
> +
>         if (matchesCpuPid &&
> -           aux_event->aux_offset >= auxtrace_event->offset &&
> -           aux_event->aux_offset + aux_event->aux_size <=
> -                       auxtrace_event->offset + auxtrace_event->size) {
> +           aux_offset >= auxtrace_event->offset &&
> +           aux_offset + aux_event->aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>                 /*
>                  * If this AUX event was inside this buffer somewhere, create a new auxtrace event
>                  * based on the sizes of the aux event, and queue that fragment.
>                  */
>                 auxtrace_fragment.auxtrace = *auxtrace_event;
>                 auxtrace_fragment.auxtrace.size = aux_event->aux_size;
> -               auxtrace_fragment.auxtrace.offset = aux_event->aux_offset;
> -               file_offset += aux_event->aux_offset - auxtrace_event->offset +
> -                               auxtrace_event->header.size;
> +               auxtrace_fragment.auxtrace.offset = aux_offset;
> +               file_offset += aux_offset - auxtrace_event->offset + auxtrace_event->header.size;
>                 return auxtrace_queues__add_event(&etm->queues,
>                                                session,
>                                                &auxtrace_fragment,
>
>
