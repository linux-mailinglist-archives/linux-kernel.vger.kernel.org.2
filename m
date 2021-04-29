Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDD636E7F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhD2J1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbhD2J1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:27:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01616C06138C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:26:54 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id c8-20020a9d78480000b0290289e9d1b7bcso46778248otm.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=/xAiHztyUuN/FsmpHQ3gXXUPKCX34aNrHw1aDjDoTfU=;
        b=chPP59Nu2SbTsV3p4ulH+kzrGlUYHaBQAFZpjruV7uaEABaxFfDEz9AhkpwJ0KPeRP
         l9YrQ9wfTNo4a8tWiq+TO1RrYtly7U5JCgvTrn1xE5G9/yjMtL+Rqls+kexugKlt+qc1
         XrYcRH3l4lDuDZuZPeY3kk2QjimgTJSmTQ9ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=/xAiHztyUuN/FsmpHQ3gXXUPKCX34aNrHw1aDjDoTfU=;
        b=SPvzoJeA4IdIgX4YbNPOfGdUS0ULzKDuxvXl4Mz7jPhurViToaI+Uw86kbYgwvBAwl
         P8lzShTqm1iSu+VLCDd5SCSsKYh4YJbFZEkycwR+/Tom1XO2Oc9NGBMaKkRw93JXaYLB
         owxM6dpg0ZBoo41hxiOOJuxfUJv9RvtcylecUoN4j3JLEHzTxPYHskE0HqdyEcQ//wpY
         52xZf5nb/fU+/O+VmcMp5eXRFO1QqpR8Mz2p00xRKuFrNA1pbPfLVnjfB9oBb3IAwUE9
         P38M+PKY/gsIZ8lWUkB5/TlXAgHOj8Fd4WBZTvS0XuMj1nJO+SQR8zz1FGefXM1u30vm
         qftw==
X-Gm-Message-State: AOAM532L/jw2L1Ub3gNZ2uPiLlhpAokJ0l6GZYP0PiG212z5ngNd+/JR
        7geHK5ZpS9j9hPT4xoVQLQhm/1lM9kYwSNFOWOUXTg==
X-Google-Smtp-Source: ABdhPJwMdo9sTU3ZFF0d1RMCRrisFLkJhIb73t4yUXRRMw+EIrmzJCVcRYLC9lPzjtJuWZmWVz6bDANSRalp++kUmpE=
X-Received: by 2002:a9d:5e19:: with SMTP id d25mr9296287oti.308.1619688412449;
 Thu, 29 Apr 2021 02:26:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 29 Apr 2021 11:26:51 +0200
MIME-Version: 1.0
In-Reply-To: <9ccdef6e1a1b47bd8d99594831f51094@codeaurora.org>
References: <1618604877-28297-1-git-send-email-khsieh@codeaurora.org>
 <161895606268.46595.2841353121480638642@swboyd.mtv.corp.google.com>
 <e3c3ef96ac507da6f138106f70c78ed2@codeaurora.org> <ddc1e372c5f864cd62c4e056ef2e6404@codeaurora.org>
 <CAE-0n53JNCc3JdONogGNArnsYLDr9E2fXZ2ODKBy7Jy3yVMr6g@mail.gmail.com> <9ccdef6e1a1b47bd8d99594831f51094@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 29 Apr 2021 11:26:51 +0200
Message-ID: <CAE-0n533ZCaQkP7+XN+Ee9CG-r7vJD7LHG7_H8v7sVpimmQabg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dp: service only one irq_hpd if there are
 multiple irq_hpd pending
To:     khsieh@codeaurora.org
Cc:     aravindh@codeaurora.org, robdclark@gmail.com, sean@poorly.run,
        abhinavk@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting khsieh@codeaurora.org (2021-04-28 10:38:11)
> On 2021-04-27 17:00, Stephen Boyd wrote:
> > Quoting aravindh@codeaurora.org (2021-04-21 11:55:21)
> >> On 2021-04-21 10:26, khsieh@codeaurora.org wrote:
> >> >>
> >> >>> +
> >> >>>         mutex_unlock(&dp->event_mutex);
> >> >>>
> >> >>>         return 0;
> >> >>> @@ -1496,6 +1502,9 @@ int msm_dp_display_disable(struct msm_dp *dp,
> >> >>> struct drm_encoder *encoder)
> >> >>>         /* stop sentinel checking */
> >> >>>         dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> >> >>>
> >> >>> +       /* link is down, delete pending irq_hdps */
> >> >>> +       dp_del_event(dp_display, EV_IRQ_HPD_INT);
> >> >>> +
> >> >>
> >> >> I'm becoming convinced that the whole kthread design and event queue
> >> >> is
> >> >> broken. These sorts of patches are working around the larger problem
> >> >> that the kthread is running independently of the driver and irqs can
> >> >> come in at any time but the event queue is not checked from the irq
> >> >> handler to debounce the irq event. Is the event queue necessary at
> >> >> all?
> >> >> I wonder if it would be simpler to just use an irq thread and process
> >> >> the hpd signal from there. Then we're guaranteed to not get an irq
> >> >> again
> >> >> until the irq thread is done processing the event. This would
> >> >> naturally
> >> >> debounce the irq hpd event that way.
> >> > event q just like bottom half of irq handler. it turns irq into event
> >> > and handle them sequentially.
> >> > irq_hpd is asynchronous event from panel to bring up attention of hsot
> >> > during run time of operation.
> >> > Here, the dongle is unplugged and main link had teared down so that no
> >> > need to service pending irq_hpd if any.
> >> >
> >>
> >> As Kuogee mentioned, IRQ_HPD is a message received from the panel and
> >> is
> >> not like your typical HW generated IRQ. There is no guarantee that we
> >> will not receive an IRQ_HPD until we are finished with processing of
> >> an
> >> earlier HPD message or an IRQ_HPD message. For example - when you run
> >> the protocol compliance, when we get a HPD from the sink, we are
> >> expected to start reading DPCD, EDID and proceed with link training.
> >> As
> >> soon as link training is finished (which is marked by a specific DPCD
> >> register write), the sink is going to issue an IRQ_HPD. At this point,
> >> we may not done with processing the HPD high as after link training we
> >> would typically notify the user mode of the newly connected display,
> >> etc.
> >
> > Given that the irq comes in and is then forked off to processing at a
> > later time implies that IRQ_HPD can come in at practically anytime.
> > Case
> > in point, this patch, which is trying to selectively search through the
> > "event queue" and then remove the event that is no longer relevant
> > because the display is being turned off either by userspace or because
> > HPD has gone away. If we got rid of the queue and kthread and processed
> > irqs in a threaded irq handler I suspect the code would be simpler and
> > not have to search through an event queue when we disable the display.
> > Instead while disabling the display we would make sure that the irq
> > thread isn't running anymore with synchronize_irq() or even disable the
> > irq entirely, but really it would be better to just disable the irq in
> > the hardware with a register write to some irq mask register.
> >
> > This pushes more of the logic for HPD and connect/disconnect into the
> > hardware and avoids reimplementing that in software: searching through
> > the queue, checking for duplicate events, etc.
>
> I wish we can implemented as you suggested. but it more complicate than
> that.
> Let me explain below,
> we have 3 transactions defined as below,
>
> plugin transaction: irq handle do host dp ctrl initialization and link
> training. If sink_count = 0 or link train failed, then transaction
> ended. otherwise send display up uevent to frame work and wait for frame
> work thread to do mode set, start pixel clock and start video to end
> transaction.

Why do we need to wait for userspace to start video? HPD is indicating
that we have something connected, so shouldn't we merely signal to
userspace that something is ready to display and then enable the irq for
IRQ_HPD?

>
> unplugged transaction: irq handle send display off uevent to frame
> work and wait for frame work to disable pixel clock ,tear down main
> link and dp ctrl host de initialization.

What do we do if userspace is slow and doesn't disable the display
before the cable is physically plugged in again?

>
> irq_hpd transaction: This only happen after plugin transaction and
> before unplug transaction. irq handle read panel dpcd register and
> perform requesting action. Action including perform dp compliant
> phy/link testing.
>
> since dongle can be plugged/unplugged at ant time, three conditions have
> to be met to avoid race condition,
> 1) no irq lost
> 2) irq happen timing order enforced at execution
> 3) no irq handle done in the middle transaction
>
> for example we do not want to see
> plugin --> unplug --> plugin --> unplug become plugin --> plugin-->
> unplug
>
> The purpose of this patch is to not handle pending irq_hpd after either
> dongle or monitor had been unplugged until next plug in.
>

I'm not suggesting to block irq handling entirely for long running
actions. A plug irq due to HPD could still notify userspace that the
display is connected but when an IRQ_HPD comes in we process it in the
irq thread instead of trying to figure out what sort of action is
necessary to quickly fork it off to a kthread to process later.

The problem seems to be that this quick forking off of the real IRQ_HPD
processing is letting the event come in, and then an unplug to come in
after that, and then a plug in to come in after that, leading to the
event queue getting full of events that are no longer relevant but still
need to be processed. If this used a workqueue instead of an open-coded
one, I'd say we should cancel any work items on the queue if an unplug
irq came in. That way we would make sure that we're not trying to do
anything with the link when it isn't present anymore.

But even then it doesn't make much sense. Userspace could be heavily
delayed after the plug in irq, when HPD is asserted, and not display
anything. The user could physically unplug and plug during that time so
we really need to not wait at all or do anything besides note the state
of the HPD when this happens. The IRQ_HPD irq is different. I don't
think we care to keep getting them if we're not done processing the
previous irq. I view it as basically an "edge" irq that we see, process,
and then if another one comes in during the processing time we ignore
it. There's only so much we can do, hence the suggestion to use a
threaded irq.

This is why IRQ_HPD is yanking the HPD line down to get the attention of
the source, but HPD high and HPD low for an extended period of time
means the cable has been plugged or unplugged. We really do care if the
line goes low for a long time, but if it only temporarily goes low for
an IRQ_HPD then we either saw it or we didn't have time to process it
yet.

It's like a person at your door ringing the doorbell. They're there (HPD
high), and they're ringing the doorbell over and over (IRQ_HPD) and
eventually they go away when you don't answer (HPD low). We don't have
to keep track of every single doorbell/IRQ_HPD event because it's mostly
a ping from the sink telling us we need to go do something, i.e. a
transitory event. The IRQ_HPD should always work once HPD is there, but
once HPD is gone we should mask it and ignore that irq until we see an
HPD high again.
