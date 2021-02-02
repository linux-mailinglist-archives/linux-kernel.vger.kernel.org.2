Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1A30C621
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbhBBQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236672AbhBBQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:37:32 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BED6C06121C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 08:33:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so18432879wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBPcsTSXaGQFq/lqdl8P8bMbniUqcnGA9csSSsJg7Y4=;
        b=wvy7yIWHmRtkYR+ScdfIvZuXn0jMRW/3JHoFOnleyEMVnm8VohAjE19XZaPNN637nD
         1/dY5yqC5+nC/MzvgY15r3FVwqPhdKI5lmlgyc/DF0ctDkjzGNQw2L6FuOi6JY9nKliC
         qOHIalLw/zVDC9ZtTKOKXG2yJ3p0/4JMAHugTRlvO5SmuClfFNymiQILFrjK8Pp0URm2
         uWUQGJDr0Nvwaa57Xvqk/liykI19wFZBaV5VbqwGvrEhNodDnP7RN/liVH8nGS1htrFW
         1ODoQSdB8//4XVUt+mLSeDhvUKIYDOL23mZVpXD6ByaoZvomI6SUWJT83pLnylZAie/H
         2G7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBPcsTSXaGQFq/lqdl8P8bMbniUqcnGA9csSSsJg7Y4=;
        b=WDK6ThbtHovUBoWviNjsMFTCINEgJ22bOBt7cVJZZVsYe2ufiyajpRmqTbza68Xrlw
         7KOKhgJgE+6vSa58gPSQUr3fEHQ871K2xH95sUsErOv9buXDl6dRCaHNY9SxBY5+pEUy
         o5QCDMm8cBXzIo9PDkG1aiZW/acz4Mb6LMWEo75DHXbFqso4Dj7D2JYJAZK74GuqXnUZ
         mFxTiyzbGyOAU48K0mDiobjS3nCdx10WBAeqlUJr0GWnYmW5Luj40da7/2LluxUjNyrt
         kTL0odLUlvRxCpgs6sHX/DvaVCQT89gN0QvHD3Ly5TcBtRBUvANIKCSiU7QKFF5YxDgT
         DACQ==
X-Gm-Message-State: AOAM531cieV2ADn0mtGc7uIkhO7K3zyqwCGRn8Zyohzxc2xs48Ex5s5Y
        KDRyDle8qBzyNyrXNhXuL6ckuCKsIUSjmgWzwSunBg==
X-Google-Smtp-Source: ABdhPJwVaVyb93Uy8okKB4jbDvBJ9mDCeNk0wxkyR6YMKHAt5vA9AUDbSMdGqh8F8MTQpXMHwHGRTveIHo/EMIlzV+k=
X-Received: by 2002:a5d:6685:: with SMTP id l5mr24105377wru.176.1612283592212;
 Tue, 02 Feb 2021 08:33:12 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-2-git-send-email-anshuman.khandual@arm.com>
 <20210201231720.GB1475392@xps15> <2438dab1-2d28-74f9-92b5-34d9aa09acda@arm.com>
In-Reply-To: <2438dab1-2d28-74f9-92b5-34d9aa09acda@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 2 Feb 2021 16:33:00 +0000
Message-ID: <CAJ9a7Vi1LXGL+Fjuv04KTQJ9N232MybTJWq6Yo=1vCk_3WYpRA@mail.gmail.com>
Subject: Re: [PATCH V3 01/14] coresight: etm-perf: Allow an event to use
 different sinks
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2 Feb 2021 at 09:42, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 2/1/21 11:17 PM, Mathieu Poirier wrote:
> > Hi Anshuman,
> >
> > I have started reviewing this set.  As it is quite voluminous comments will
> > come over serveral days.  I will let you know when I am done.
> >
> > On Wed, Jan 27, 2021 at 02:25:25PM +0530, Anshuman Khandual wrote:
> >> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>
> >> When there are multiple sinks on the system, in the absence
> >> of a specified sink, it is quite possible that a default sink
> >> for an ETM could be different from that of another ETM. However
> >> we do not support having multiple sinks for an event yet. This
> >> patch allows the event to use the default sinks on the ETMs
> >> where they are scheduled as long as the sinks are of the same
> >> type.
> >>
> >> e.g, if we have 1x1 topology with per-CPU ETRs, the event can
> >> use the per-CPU ETR for the session. However, if the sinks
> >> are of different type, e.g TMC-ETR on one and a custom sink
> >> on another, the event will only trace on the first detected
> >> sink.
> >>
> >
> > I found the above changelog very confusing - I read it several times and still
> > couldn't get all of it.  In the end this patch prevents sinks of different types
> > from being used for session, and this is what the text should reflect.
>
> Sorry about that. Your inference is correct, but it is only a side effect
> of the primary motive. How about the following :
>
> "When a sink is not specified by the user, the etm perf driver
> finds a suitable sink automatically based on the first ETM, where
> this event could be scheduled. Then we allocate the sink buffer based
> on the selected sink. This is fine for a CPU bound event as the "sink"
> is always guaranteed to be reachable from the ETM (as this is the only
> ETM where the event is going to be scheduled). However, if we have a task
> bound event, the event could be scheduled on any of the ETMs on the
> system. In this case, currently we automatically select a sink and exclude
> any ETMs that are not reachable from the selected sink. This is
> problematic for 1x1 configurations as we end up in tracing the event
> only on the "first" ETM, as the default sink is local to the first
> ETM and unreachable from the rest.
> However, we could allow the other ETMs to trace if they all have a
> sink that is compatible with the "selected" sink and can use the
> sink buffer. This can be easily done by verifying that they are
> all driven by the same driver and matches the same subtype."
>


Not sure that the logic here makes total sense - I can't see _why_
multiple sinks need to be of the same type.

1) This patch is designed to allow multiple sinks to be used in a 1:1
topology system - but there is no specific restriction here - and N:M
should work on the same basis
2) This implies that multiple sinks will work within the coresight
infrastucture.
3)  The sink interface -> struct coresight_ops_sink allows sinks to be
abstracted - therefore whichever sink is chosen the coresight
infrastructure calls the operations for the given sink.
4) Each individual sink, will have its own hardware buffer - copied
into the perf buffers at some appropriate point.

Thus if the users specifies a selected sink - we need to eliminate any
source that cannot reach it.
If not we need to find the relevant default sink for the source, which
might be a shared ETR, or per CPU TRBE / ETR, and the abstraction
logic ought to handle getting the captured data to the correct place.
If it doesn't then we are on shaky ground with any multiple sink
solution.

On the face of it - type is irrelevant. If I am missing something -
this patch needs a better explanation.


>
> >
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Tested-by: Linu Cherian <lcherian@marvell.com>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etm-perf.c | 48 +++++++++++++++++++-----
> >>   1 file changed, 38 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> index bdc34ca..eb9e7e9 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> >> @@ -204,6 +204,13 @@ static void etm_free_aux(void *data)
> >>      schedule_work(&event_data->work);
> >>   }
> >>
> >> +static bool sinks_match(struct coresight_device *a, struct coresight_device *b)
> >> +{
> >> +    if (!a || !b)
> >> +            return false;
> >> +    return (sink_ops(a) == sink_ops(b));
> >
> > Yes
>
> I think we can tighten this by verifying the dev->sub_type matches too.
>
> >
> >> +}
> >> +
> >>   static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>                         int nr_pages, bool overwrite)
> >>   {
> >> @@ -212,6 +219,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>      cpumask_t *mask;
> >>      struct coresight_device *sink = NULL;
> >
> >          struct coresight_device *user_sink = NULL;
> >
> >>      struct etm_event_data *event_data = NULL;
> >> +    bool sink_forced = false;
> >>
> >>      event_data = alloc_event_data(cpu);
> >>      if (!event_data)
> >> @@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>      if (event->attr.config2) {
> >>              id = (u32)event->attr.config2;
> >>              sink = coresight_get_sink_by_id(id);
> >
> >                  user_sink = coresight_get_sink_by_id(id);
> >
> >> +            sink_forced = true;

The comment for this block uses the term "selected sink", and the
functions use _default_sink . This may read better if we rename the
bool to "selected_sink" rather than "sink_forced"

Regards

Mike
> >>      }
> >>
> >>      mask = &event_data->mask;
> >> @@ -235,7 +244,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>       */
> >>      for_each_cpu(cpu, mask) {
> >>              struct list_head *path;
> >> -            struct coresight_device *csdev;
> >
> >                  struct coresight_device *last_sink = NULL;
> >
> >> +            struct coresight_device *csdev, *new_sink;
> >>
> >>              csdev = per_cpu(csdev_src, cpu);
> >>              /*
> >> @@ -249,21 +258,35 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>              }
> >>
> >>              /*
> >> -             * No sink provided - look for a default sink for one of the
> >> -             * devices. At present we only support topology where all CPUs
> >> -             * use the same sink [N:1], so only need to find one sink. The
> >> -             * coresight_build_path later will remove any CPU that does not
> >> -             * attach to the sink, or if we have not found a sink.
> >> +             * No sink provided - look for a default sink for all the devices.
> >> +             * We only support multiple sinks, only if all the default sinks
> >> +             * are of the same type, so that the sink buffer can be shared
> >> +             * as the event moves around. We don't trace on a CPU if it can't
> >
> > s/can't/can't./
> >
> >> +             *
> >
> > Extra line
> >
>
> OK
>
> >>               */
> >> -            if (!sink)
> >> -                    sink = coresight_find_default_sink(csdev);
> >> +            if (!sink_forced) {
> >> +                    new_sink = coresight_find_default_sink(csdev);
> >> +                    if (!new_sink) {
> >> +                            cpumask_clear_cpu(cpu, mask);
> >> +                            continue;
> >> +                    }
> >> +                    /* Skip checks for the first sink */
> >> +                    if (!sink) {
> >> +                           sink = new_sink;
> >> +                    } else if (!sinks_match(new_sink, sink)) {
> >> +                            cpumask_clear_cpu(cpu, mask);
> >> +                            continue;
> >> +                    }
> >> +            } else {
> >> +                    new_sink = sink;
> >> +            }
> >
> >                  if (!user_sink) {
> >                          /* find default sink for this CPU */
> >                          sink = coresight_find_default_sink(csdev);
> >                          if (!sink) {
> >                                  cpumask_clear_cpu(cpu, mask);
> >                                  continue;
> >                          }
> >
> >                          /* Chech new sink with last sink */
> >                          if (last_sink && !sink_match(last_sink, sink)) {
> >                                  cpumask_clear_cpu(cpu, mask);
> >                                  continue;
> >                          }
> >
> >                          last_sink = sink;
> >                  } else {
> >                          sink = user_sink;
> >                  }
> >
>
> Agreed, it is much better readable.
>
> Suzuki



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
