Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC32B30F322
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhBDM2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 07:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbhBDM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 07:28:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8177BC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 04:28:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u14so3303924wri.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 04:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TDZoHybeOAwNYcjKpsDUUn6EnfSKA1LuHIoP1WZAHHQ=;
        b=jXGRuQ8Cdsjw0veZgcZIbEkGI0sElrQ5d0SpV1l0B1k5bgNOYnHVuErJSgWDHY+u5Z
         oQOtpzQCwWTxkePdyJH1hcpC9xBX6cgqe+24xlHz+Bq0ulOGZq7/yGIDqHAI4eiwuYdK
         Ki+vG/wk2Ap48BjaO1y9dPd11tGFZpVPnV30MJsXd0uxNs3AUludD13AFWAErYX03VlX
         bUl5p8NU6eOcg+F6Ynk292DdKRM+KSOREhuPSqLp3S7Xxy1u0E9ClNuIomYtIHZBX2A1
         pGxXiQDydctIpwvLlBxfg0Sl15cLk3lpzefl4FItR2zt7yc1AbHv9a1W74Cc4d+qASIf
         MC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TDZoHybeOAwNYcjKpsDUUn6EnfSKA1LuHIoP1WZAHHQ=;
        b=JXq0mGUCv+qI7sBbUQi3H5GhCW+6r61hVYQMKYEca4FLPbVAQoY26foA0Cn6utoTWk
         6oTL8R4Bxn7Yq4PFthr5HlV9BJoZv2KK1qNMYx5Uwv4Qd6BU11lp4HBxr2SxAv46eW4/
         Q2+tdB9q4BEeRmtD4YQ3YUP6scwSd7JBb7ZU1Gd5Q3S1VOG2VeCDLlLtWlAia6nJUXwN
         dJCjvvbuqpTMro/c6w2u+jCsdpEW82d2v18EHkwRXojQlfYTJ6BVT6RsdV3F4UXb84CZ
         1eJLmarnaj4/TiFO0hfJDq9lq94dXrXE2MZtnaYSYQn91Dlds+K4oqT9CKgQFk7OrpGO
         j/Aw==
X-Gm-Message-State: AOAM531jrdf8nrtwrrq1JhV4uivLAhpglSrpA/lzkODOjlEp0PF2gRZE
        bBOx0dKbsjVwZdaI5D8J0xZHZjAdt682l/7zQr06LKUxC18=
X-Google-Smtp-Source: ABdhPJwK57dP3vGIAfQxJ7zyTyO3gQo4BOe2XFKckFLvZDEHhjuUbuajQE/pNBOxXNwknSh2ZtncboudAyejWRBjfA0=
X-Received: by 2002:a5d:4d8d:: with SMTP id b13mr8729521wru.178.1612441689198;
 Thu, 04 Feb 2021 04:28:09 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-2-git-send-email-anshuman.khandual@arm.com>
 <20210201231720.GB1475392@xps15> <2438dab1-2d28-74f9-92b5-34d9aa09acda@arm.com>
 <CAJ9a7Vi1LXGL+Fjuv04KTQJ9N232MybTJWq6Yo=1vCk_3WYpRA@mail.gmail.com> <d70cc898-6ca0-4313-5eb3-77eb58317362@arm.com>
In-Reply-To: <d70cc898-6ca0-4313-5eb3-77eb58317362@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 4 Feb 2021 12:27:58 +0000
Message-ID: <CAJ9a7Vjwx7sdp5rpbx1TrYyaX7MPE3C=gue7EiJd+c9fngWczw@mail.gmail.com>
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

Hi Suzuki,.

On Tue, 2 Feb 2021 at 22:42, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 2/2/21 4:33 PM, Mike Leach wrote:
> > Hi,
> >
> > On Tue, 2 Feb 2021 at 09:42, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> On 2/1/21 11:17 PM, Mathieu Poirier wrote:
> >>> Hi Anshuman,
> >>>
> >>> I have started reviewing this set.  As it is quite voluminous comments will
> >>> come over serveral days.  I will let you know when I am done.
> >>>
> >>> On Wed, Jan 27, 2021 at 02:25:25PM +0530, Anshuman Khandual wrote:
> >>>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>>>
> >>>> When there are multiple sinks on the system, in the absence
> >>>> of a specified sink, it is quite possible that a default sink
> >>>> for an ETM could be different from that of another ETM. However
> >>>> we do not support having multiple sinks for an event yet. This
> >>>> patch allows the event to use the default sinks on the ETMs
> >>>> where they are scheduled as long as the sinks are of the same
> >>>> type.
> >>>>
> >>>> e.g, if we have 1x1 topology with per-CPU ETRs, the event can
> >>>> use the per-CPU ETR for the session. However, if the sinks
> >>>> are of different type, e.g TMC-ETR on one and a custom sink
> >>>> on another, the event will only trace on the first detected
> >>>> sink.
> >>>>
> >>>
> >>> I found the above changelog very confusing - I read it several times and still
> >>> couldn't get all of it.  In the end this patch prevents sinks of different types
> >>> from being used for session, and this is what the text should reflect.
> >>
> >> Sorry about that. Your inference is correct, but it is only a side effect
> >> of the primary motive. How about the following :
> >>
> >> "When a sink is not specified by the user, the etm perf driver
> >> finds a suitable sink automatically based on the first ETM, where
> >> this event could be scheduled. Then we allocate the sink buffer based
> >> on the selected sink. This is fine for a CPU bound event as the "sink"
> >> is always guaranteed to be reachable from the ETM (as this is the only
> >> ETM where the event is going to be scheduled). However, if we have a task
> >> bound event, the event could be scheduled on any of the ETMs on the
> >> system. In this case, currently we automatically select a sink and exclude
> >> any ETMs that are not reachable from the selected sink. This is
> >> problematic for 1x1 configurations as we end up in tracing the event
> >> only on the "first" ETM, as the default sink is local to the first
> >> ETM and unreachable from the rest.
> >> However, we could allow the other ETMs to trace if they all have a
> >> sink that is compatible with the "selected" sink and can use the
> >> sink buffer. This can be easily done by verifying that they are
> >> all driven by the same driver and matches the same subtype."
> >>
> >
> >
> > Not sure that the logic here makes total sense - I can't see _why_
> > multiple sinks need to be of the same type.
>
> Because we have a single "sink_config" (read, single sink specific
> buffer) for an event. i.e, we do the sink_ops->alloc_buffer() only once
> and rightly so. This allocates any buffers that is used by a given sink.
> e.g, for ETR it allocates an etr_perf_buffer. Now if we wanted the same
> event to run on an ETM with TRBE, the TRBE doesn't have any buffer set up to
> collect the trace and cant make any sense of etr_perf_buffer.
> However, if there is another ETM with a different ETR, the second
> ETR can make sense of the sink_config (etr_perf_buffer) and trace the event.
> Please remember that this only applies to task bound events where
> the event can be scheduled on different ETMs.
>

I have had a look around the ETR driver and can see the issue -
something very sink specific is being bound to the more generic event,
which does undermine the abstraction a little bit!
The ETR drivers refer to per-thread and cpu-wide - not cpu-bound /
task-bound - could do to get consistent terminology here. The cpu-wide
version is designed to be called multiple times - but obviously only
allocates a single buffer.

This implies that for the cpu-wide case, we could tolerate sinks of
differing types, as setup_aux will be called once per CPU. Whether we
want to is another question.

Given we don't yet have any systems that sport differing sink types,
its probably not worth allowing.
A short comment explaining the type matching is needed due to
underlying private data structure incompatibility would be useful
though.

Regards

Mike



> >
> > 1) This patch is designed to allow multiple sinks to be used in a 1:1
> > topology system - but there is no specific restriction here - and N:M
> > should work on the same basis
>
> Yes, this should work in any topology.
>
> > 2) This implies that multiple sinks will work within the coresight
> > infrastucture.
>
> I am afraid I don't understand the context here.
>
> > 3)  The sink interface -> struct coresight_ops_sink allows sinks to be
> > abstracted - therefore whichever sink is chosen the coresight
> > infrastructure calls the operations for the given sink.
>
> Correct. The patch is trying to ensure that a private data
> setup by one driver is not interpreted by another driver as
> its own private data. (the private data being sink_config)
>
> > 4) Each individual sink, will have its own hardware buffer - copied
> > into the perf buffers at some appropriate point.
>
> Correct. Supporting multiple types of sinks for a single event
> is complex and not worth the benefit of the extra complexity.
> Moreover we don't expect sane systems to have such a
> configuration.
>
> >
> > Thus if the users specifies a selected sink - we need to eliminate any
> > source that cannot reach it.
>
> Yes, we do that now.
>
> > If not we need to find the relevant default sink for the source, which
> > might be a shared ETR, or per CPU TRBE / ETR, and the abstraction
> > logic ought to handle getting the captured data to the correct place.
>
> The abstraction logic works fine, but the per-event private data is
> something that makes this complex.
>
> > If it doesn't then we are on shaky ground with any multiple sink
> > solution.
> >
> > On the face of it - type is irrelevant. If I am missing something -
> > this patch needs a better explanation.
>
> I hope the explanation above makes it clear. Please let me know
> otherwise.
>
> >>>> +}
> >>>> +
> >>>>    static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>>>                          int nr_pages, bool overwrite)
> >>>>    {
> >>>> @@ -212,6 +219,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>>>       cpumask_t *mask;
> >>>>       struct coresight_device *sink = NULL;
> >>>
> >>>           struct coresight_device *user_sink = NULL;
> >>>
> >>>>       struct etm_event_data *event_data = NULL;
> >>>> +    bool sink_forced = false;
> >>>>
> >>>>       event_data = alloc_event_data(cpu);
> >>>>       if (!event_data)
> >>>> @@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
> >>>>       if (event->attr.config2) {
> >>>>               id = (u32)event->attr.config2;
> >>>>               sink = coresight_get_sink_by_id(id);
> >>>
> >>>                   user_sink = coresight_get_sink_by_id(id);
> >>>
> >>>> +            sink_forced = true;
> >
> > The comment for this block uses the term "selected sink", and the
> > functions use _default_sink . This may read better if we rename the
> > bool to "selected_sink" rather than "sink_forced"
>
> I have removed the bool and replaced with the user_sink as Mathieu
> suggested.
>
> Thanks for the review
> Suzuki



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
