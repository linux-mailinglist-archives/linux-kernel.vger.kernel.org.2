Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B014037250D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhEDE31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhEDE3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:29:24 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6D4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 21:28:29 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id g4-20020a9d6b040000b029029debbbb3ecso7145555otp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=YxkbdlOp5+Lo050c9r95i26GLhZwLMxMbGicLv3SLBk=;
        b=LaLN6EPNmpQKO0FOAM/EVCMUQPOueL2iwIzYlDXI6HXAesLKRrwzls4twMJyrZN4pN
         voHeh0oPk87Fn+pId/0z9P9oofP+a3OuLZUva1XcmjywI9or/8vXJ2yMJkMKZqs0ccKs
         YkCiKPZGNE10D4MT7V/SvhLreKRm73/GEuO4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=YxkbdlOp5+Lo050c9r95i26GLhZwLMxMbGicLv3SLBk=;
        b=Nq2tfyMBx0YoTR1vpi9ngqSkd4csHdXK2Ta8xxM6J50jnuIoxObkE/MtTIoxlCSflP
         3yN7keTJ/IVtcAXK5ixIOqKNIe7dEb1h7nNboGryZJU5PXg11z6UASCx41951tuWJ3w/
         IDbSwd/vu++jPpEH/5rsNTYQ7czFDLhRne8R6EasqaI+871EJ2S89pLjYWcEkyP2ou9E
         CnFe+fMQIhKGx3g049wd9vwR49J8A1zei43AmgR5a6yhEeg+ysLzgbAvtSi3fSRiPyDw
         xJrpOjhqTkMm/EpZHw6AoI52ARUiH8PeZ+zMoRBUqJVv90ChGyCLGGDGT082z4kikaAy
         0zNw==
X-Gm-Message-State: AOAM533hX356xus/whO5T6x584kGwDPs70aPd50VbU8AoIWQv9j9UhD3
        4Iow8lQBb2nDbnit7zGlATTND5G3KCK6eOS+znoi5g==
X-Google-Smtp-Source: ABdhPJzOnGLQwrB1rXv0pQSwc7aFbEvRVhHO9wl3G9S9o9ZCW+CvbD0VN3vXyQzETmA5N/jlH1zkPOppv8dUOSIz0lg=
X-Received: by 2002:a9d:222a:: with SMTP id o39mr16975857ota.246.1620102509142;
 Mon, 03 May 2021 21:28:29 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 3 May 2021 21:28:28 -0700
MIME-Version: 1.0
In-Reply-To: <9564c684fb1c14a1df0068d42c749a8e@codeaurora.org>
References: <1618604877-28297-1-git-send-email-khsieh@codeaurora.org>
 <161895606268.46595.2841353121480638642@swboyd.mtv.corp.google.com>
 <e3c3ef96ac507da6f138106f70c78ed2@codeaurora.org> <ddc1e372c5f864cd62c4e056ef2e6404@codeaurora.org>
 <CAE-0n53JNCc3JdONogGNArnsYLDr9E2fXZ2ODKBy7Jy3yVMr6g@mail.gmail.com>
 <9ccdef6e1a1b47bd8d99594831f51094@codeaurora.org> <CAE-0n533ZCaQkP7+XN+Ee9CG-r7vJD7LHG7_H8v7sVpimmQabg@mail.gmail.com>
 <d88cd3e0af511ed60c12ce616ce22415@codeaurora.org> <CAE-0n50J1JkaBa5XQmHS8Fe2W5R2fXKpLoTWbH0RshRZivGZWw@mail.gmail.com>
 <9564c684fb1c14a1df0068d42c749a8e@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 3 May 2021 21:28:28 -0700
Message-ID: <CAE-0n53sXZ_pUwMZjVfD26n4dY2bd-R8onaU38b+RBp_Hc9xjg@mail.gmail.com>
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

Quoting khsieh@codeaurora.org (2021-05-03 12:23:31)
> On 2021-04-29 20:11, Stephen Boyd wrote:
> > Quoting khsieh@codeaurora.org (2021-04-29 10:23:31)
> >> On 2021-04-29 02:26, Stephen Boyd wrote:
> >> > Quoting khsieh@codeaurora.org (2021-04-28 10:38:11)
> >> >> On 2021-04-27 17:00, Stephen Boyd wrote:
> >> >> > Quoting aravindh@codeaurora.org (2021-04-21 11:55:21)
> >> >> >> On 2021-04-21 10:26, khsieh@codeaurora.org wrote:
> >> >> >> >>
> >> >> >> >>> +
> >> >> >> >>>         mutex_unlock(&dp->event_mutex);
> >> >> >> >>>
> >> >> >> >>>         return 0;
> >> >> >> >>> @@ -1496,6 +1502,9 @@ int msm_dp_display_disable(struct msm_dp *dp,
> >> >> >> >>> struct drm_encoder *encoder)
> >> >> >> >>>         /* stop sentinel checking */
> >> >> >> >>>         dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> >> >> >> >>>
> >> >> >> >>> +       /* link is down, delete pending irq_hdps */
> >> >> >> >>> +       dp_del_event(dp_display, EV_IRQ_HPD_INT);
> >> >> >> >>> +
> >> >> >> >>
> >> >> >> >> I'm becoming convinced that the whole kthread design and event queue
> >> >> >> >> is
> >> >> >> >> broken. These sorts of patches are working around the larger problem
> >> >> >> >> that the kthread is running independently of the driver and irqs can
> >> >> >> >> come in at any time but the event queue is not checked from the irq
> >> >> >> >> handler to debounce the irq event. Is the event queue necessary at
> >> >> >> >> all?
> >> >> >> >> I wonder if it would be simpler to just use an irq thread and process
> >> >> >> >> the hpd signal from there. Then we're guaranteed to not get an irq
> >> >> >> >> again
> >> >> >> >> until the irq thread is done processing the event. This would
> >> >> >> >> naturally
> >> >> >> >> debounce the irq hpd event that way.
> >> >> >> > event q just like bottom half of irq handler. it turns irq into event
> >> >> >> > and handle them sequentially.
> >> >> >> > irq_hpd is asynchronous event from panel to bring up attention of hsot
> >> >> >> > during run time of operation.
> >> >> >> > Here, the dongle is unplugged and main link had teared down so that no
> >> >> >> > need to service pending irq_hpd if any.
> >> >> >> >
> >> >> >>
> >> >> >> As Kuogee mentioned, IRQ_HPD is a message received from the panel and
> >> >> >> is
> >> >> >> not like your typical HW generated IRQ. There is no guarantee that we
> >> >> >> will not receive an IRQ_HPD until we are finished with processing of
> >> >> >> an
> >> >> >> earlier HPD message or an IRQ_HPD message. For example - when you run
> >> >> >> the protocol compliance, when we get a HPD from the sink, we are
> >> >> >> expected to start reading DPCD, EDID and proceed with link training.
> >> >> >> As
> >> >> >> soon as link training is finished (which is marked by a specific DPCD
> >> >> >> register write), the sink is going to issue an IRQ_HPD. At this point,
> >> >> >> we may not done with processing the HPD high as after link training we
> >> >> >> would typically notify the user mode of the newly connected display,
> >> >> >> etc.
> >
> > I re-read this. I think you're saying that IRQ_HPD can come in after
> > HPD
> > goes high and we finish link training? That sounds like we should
> > enable
> > IRQ_HPD in the hardware once we finish link training, instead of having
> > it enabled all the time. Then we can finish the threaded irq handler
> > and
> > the irq should be pending again once IRQ_HPD is sent over. Is there
> > ever
> > a need to be processing some IRQ_HPD and then get another IRQ_HPD while
> > processing the first one?
> yes, for example
> 1) plug dongle only
> 2) plug hdmi monitor into dongle (generated irq_hpd with sinc_count = 1)
> 3) unplug hdmi monitor out of the dongle (generate irq_hpd with
> sinc_count = 0)
> 4) go back to 2) for n times
> 5) unplug dongle
>
> This patch is not fix this problem either.
> The existing code has major issue which is handle irq_hpd with
> sink_count = 0 same way as handle of dongle unplugged.
> I think this cause external dp display failed to work and cause crash at
> suspend/resume test case.
> I will drop this patch.
> I am working on handle irq_hpd with sink_count = 0 as asymmetric as
> opposite to  irq_hpd with sink_count = 1.
> This means irq_hdp sink_count = 0 handle only tear down the main link
> but keep phy/aux intact.
> I will re submit patch for review.
>

Ok makes sense. I'll look out for the next revision of this patch.
