Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C736936CFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 02:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhD1ABg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbhD1ABf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 20:01:35 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509F8C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:00:51 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id i3-20020a4ad3830000b02901ef20f8cae8so6150978oos.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=4Obf/VhcHMC/s7ut1qxAeuquFWikXplkAVq56/wcC+Q=;
        b=L1jvMavzSKgEbkxWU0B7FE0fs8+hysy4W4ESPKY7Xw2JDG8HjSQfFaujI9XvkPeC15
         jusdZuhJJ1/X9Hbk0QT/dq6D63zM5V3UFyArwMhhK+dhLSQp43ZJYHM3wUyZUUh94+yX
         +MkhiViWH6ks4o1FGh+L0pCjQFIixGw+bN2BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=4Obf/VhcHMC/s7ut1qxAeuquFWikXplkAVq56/wcC+Q=;
        b=X2F7r9DoVq1Skeqv0dKf5qizF7zEn4PiXz1j9Ljp/x1UzdOEe2Yp9oIuMQXIk6krGi
         Hje2iuAgveGXNT6t/Bub84euVYcEPtzEsUcGkgHNpTIPsf49sPznPqkyFvmfAaLl2hv0
         3VykA6Bt/427UjPF8whblUmkX7CfaCG+2TqvuaM6xOkbVDDK+tWQ+MC077qAGGjX6ix9
         0cUVZTDMmc14BoTo/J8xJAcqcaUoSBo7BVCc9BHjkrXe9+hoyKWnJRyQnTEY2D+kgIFs
         ZGRaQk4wqWG+B4FdI21V1fRTUJ0PG92iTyjzfig7w7+9LXOztKDoeUeKk+KywHrlPB+i
         dsgg==
X-Gm-Message-State: AOAM5325KqC8NZXs6wRJj3KivvfUGuedtPzT5GTpBU8zGXXlVf8Vv4Il
        +50HKi7D/U5t8fxLU6zp+THnMh7W/AxX4mZPAahtB8u5Q/k=
X-Google-Smtp-Source: ABdhPJxZ/xayODb65B6TGi1x/D/08+OMUde7MGVwhOypaY+FO8rLDYgXzftNprJXZXTSM2cjylJY0nwXjNBXBdRKUXg=
X-Received: by 2002:a05:6820:381:: with SMTP id r1mr19990436ooj.79.1619568050218;
 Tue, 27 Apr 2021 17:00:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Apr 2021 17:00:49 -0700
MIME-Version: 1.0
In-Reply-To: <ddc1e372c5f864cd62c4e056ef2e6404@codeaurora.org>
References: <1618604877-28297-1-git-send-email-khsieh@codeaurora.org>
 <161895606268.46595.2841353121480638642@swboyd.mtv.corp.google.com>
 <e3c3ef96ac507da6f138106f70c78ed2@codeaurora.org> <ddc1e372c5f864cd62c4e056ef2e6404@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 27 Apr 2021 17:00:49 -0700
Message-ID: <CAE-0n53JNCc3JdONogGNArnsYLDr9E2fXZ2ODKBy7Jy3yVMr6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/msm/dp: service only one irq_hpd if there are
 multiple irq_hpd pending
To:     aravindh@codeaurora.org, khsieh@codeaurora.org
Cc:     robdclark@gmail.com, sean@poorly.run, abhinavk@codeaurora.org,
        airlied@linux.ie, daniel@ffwll.ch, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting aravindh@codeaurora.org (2021-04-21 11:55:21)
> On 2021-04-21 10:26, khsieh@codeaurora.org wrote:
> >>
> >>> +
> >>>         mutex_unlock(&dp->event_mutex);
> >>>
> >>>         return 0;
> >>> @@ -1496,6 +1502,9 @@ int msm_dp_display_disable(struct msm_dp *dp,
> >>> struct drm_encoder *encoder)
> >>>         /* stop sentinel checking */
> >>>         dp_del_event(dp_display, EV_DISCONNECT_PENDING_TIMEOUT);
> >>>
> >>> +       /* link is down, delete pending irq_hdps */
> >>> +       dp_del_event(dp_display, EV_IRQ_HPD_INT);
> >>> +
> >>
> >> I'm becoming convinced that the whole kthread design and event queue
> >> is
> >> broken. These sorts of patches are working around the larger problem
> >> that the kthread is running independently of the driver and irqs can
> >> come in at any time but the event queue is not checked from the irq
> >> handler to debounce the irq event. Is the event queue necessary at
> >> all?
> >> I wonder if it would be simpler to just use an irq thread and process
> >> the hpd signal from there. Then we're guaranteed to not get an irq
> >> again
> >> until the irq thread is done processing the event. This would
> >> naturally
> >> debounce the irq hpd event that way.
> > event q just like bottom half of irq handler. it turns irq into event
> > and handle them sequentially.
> > irq_hpd is asynchronous event from panel to bring up attention of hsot
> > during run time of operation.
> > Here, the dongle is unplugged and main link had teared down so that no
> > need to service pending irq_hpd if any.
> >
>
> As Kuogee mentioned, IRQ_HPD is a message received from the panel and is
> not like your typical HW generated IRQ. There is no guarantee that we
> will not receive an IRQ_HPD until we are finished with processing of an
> earlier HPD message or an IRQ_HPD message. For example - when you run
> the protocol compliance, when we get a HPD from the sink, we are
> expected to start reading DPCD, EDID and proceed with link training. As
> soon as link training is finished (which is marked by a specific DPCD
> register write), the sink is going to issue an IRQ_HPD. At this point,
> we may not done with processing the HPD high as after link training we
> would typically notify the user mode of the newly connected display,
> etc.

Given that the irq comes in and is then forked off to processing at a
later time implies that IRQ_HPD can come in at practically anytime. Case
in point, this patch, which is trying to selectively search through the
"event queue" and then remove the event that is no longer relevant
because the display is being turned off either by userspace or because
HPD has gone away. If we got rid of the queue and kthread and processed
irqs in a threaded irq handler I suspect the code would be simpler and
not have to search through an event queue when we disable the display.
Instead while disabling the display we would make sure that the irq
thread isn't running anymore with synchronize_irq() or even disable the
irq entirely, but really it would be better to just disable the irq in
the hardware with a register write to some irq mask register.

This pushes more of the logic for HPD and connect/disconnect into the
hardware and avoids reimplementing that in software: searching through
the queue, checking for duplicate events, etc.
