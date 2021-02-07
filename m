Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382AE312486
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 14:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhBGNMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 08:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhBGNMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 08:12:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961ECC061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 05:12:03 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j21so7938215wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 05:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SISOIgfsxj2z8VwmMOujp6fXedz5KiEYfI9wSyDzvC8=;
        b=P4s3pEQ6IBAC6p0W66KZ+YpQoB5L/STEiRT+HpSEyF8a4Buf+uBGMK7hwg0OHQWXiM
         lBfFugB60Ha4/KFYLslXclnx8NAAklo67yXfAe2C/qBcvL4yC93g4AykYrRB+xOwVWKf
         twHkNJvemF8Nqf+B2fpW79VF5NNHtEKgr5gYt98/qKJVza5AfEi4YSMM7KJZPUszSpGr
         MXUpFbk4StecqD7EIHJUGgclHLXsP+qIxe1gQ4UfW0BY0GifGGBS69M8LdW5iJjWH7lH
         xNzqbmy3KKWUj288/cJG9mLMBVL1+PCZN+0bsHs6mbIVjMlA957YCPc3iHkksjr810qt
         JlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SISOIgfsxj2z8VwmMOujp6fXedz5KiEYfI9wSyDzvC8=;
        b=VP2STc5yM7LfoU40LFGlUlR4xYBYLKf/C+/9HvjzJPctj7tbJgRwqJ2plosTHWvrUy
         rwKcZKR1RdDnClLS6uUoko4x0HuNyR/EuYUR0UgdQPdN/9vdtnqtBFddP9GoXYO4VXPK
         PZQmb4N8p1qMad0dYh+6d4Yqv5GRW0R/8rVDuhihKXEXcjY+VPxisYjoWer1PW+8itLS
         axKT0kH/cBBZeoT1k9XmxYQSAzCnblkP+viLAVFIosYEZ/UHHlcMzOn54MAjuvHLLVnK
         lnlU1N5apo1ClgT76Yx63g8qzv7FOBgKHcnXaMqPvvHTF2l2098TG8hNmAbbfTEJ3mC+
         XZgA==
X-Gm-Message-State: AOAM530udIJfvSSEyIqHs+TDWyAU5Pj63N45R2cQLlOpjEcwso6FHgTc
        giAnlUMjfVAdBECEQGU+QTcfJfCQO8uRvHT0dmo=
X-Google-Smtp-Source: ABdhPJzrZkHSlk4UmOBS7bvvUDYA/pEdWgg29Eivq3vpuXVWIHbEegYiV+Lm3MJjh0Saph3nqKpZfT3zj9L3CAEKEYY=
X-Received: by 2002:a1c:105:: with SMTP id 5mr11054556wmb.89.1612703522329;
 Sun, 07 Feb 2021 05:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20210127105121.20345-1-lukasz.luba@arm.com> <CAKGbVbsn=xVEa0=c3rywRShVZD18LkmLZ1qDUuDsrT5KnTjr6g@mail.gmail.com>
 <3d1b4696-0172-f88a-f41f-c66ac3baa429@arm.com> <CAKGbVbsuqsGYRqUyWRiC+h9o7kNMvB16-Y6378KG_rv0SG4VDQ@mail.gmail.com>
 <aab9c140-155e-894f-5b7d-749396a388fc@arm.com> <CAKGbVbvTzmj=3tAyNyDRU8autb+de8R9dc6ohBTuM5miJV4cWg@mail.gmail.com>
 <0afa6299-1c35-ab98-702e-8dcd168bcaac@arm.com> <deb2c075-4177-d487-b1cd-1c60790ca625@arm.com>
In-Reply-To: <deb2c075-4177-d487-b1cd-1c60790ca625@arm.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 7 Feb 2021 21:11:51 +0800
Message-ID: <CAKGbVbvwQJxdM9d1oTgCC+dfppGBCbfA3r6hG24N2zMjmWo5sQ@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Use delayed timer as default in devfreq profile
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, lima@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next.

Regards,
Qiang

On Thu, Feb 4, 2021 at 10:24 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 2/4/21 1:39 PM, Robin Murphy wrote:
> > On 2021-02-03 02:01, Qiang Yu wrote:
> >> On Tue, Feb 2, 2021 at 10:02 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>>
> >>>
> >>>
> >>> On 2/2/21 1:01 AM, Qiang Yu wrote:
> >>>> Hi Lukasz,
> >>>>
> >>>> Thanks for the explanation. So the deferred timer option makes a
> >>>> mistake that
> >>>> when GPU goes from idle to busy for only one poll periodic, in this
> >>>> case 50ms, right?
> >>>
> >>> Not exactly. Driver sets the polling interval to 50ms (in this case)
> >>> because it needs ~3-frame average load (in 60fps). I have discovered the
> >>> issue quite recently that on systems with 2 CPUs or more, the devfreq
> >>> core is not monitoring the devices even for seconds. Therefore, we might
> >>> end up with quite big amount of work that GPU is doing, but we don't
> >>> know about it. Devfreq core didn't check <- timer didn't fired. Then
> >>> suddenly that CPU, which had the deferred timer registered last time,
> >>> is waking up and timer triggers to check our device. We get the stats,
> >>> but they might be showing load from 1sec not 50ms. We feed them into
> >>> governor. Governor sees the new load, but was tested and configured for
> >>> 50ms, so it might try to rise the frequency to max. The GPU work might
> >>> be already lower and there is no need for such freq. Then the CPU goes
> >>> idle again, so no devfreq core check for next e.g. 1sec, but the
> >>> frequency stays at max OPP and we burn power.
> >>>
> >>> So, it's completely unreliable. We might stuck at min frequency and
> >>> suffer the frame drops, or sometimes stuck to max freq and burn more
> >>> power when there is no such need.
> >>>
> >>> Similar for thermal governor, which is confused by this old stats and
> >>> long period stats, longer than 50ms.
> >>>
> >>> Stats from last e.g. ~1sec tells you nothing about real recent GPU
> >>> workload.
> >> Oh, right, I missed this case.
> >>
> >>>
> >>>> But delayed timer will wakeup CPU every 50ms even when system is
> >>>> idle, will this
> >>>> cause more power consumption for the case like phone suspend?
> >>>
> >>> No, in case of phone suspend it won't increase the power consumption.
> >>> The device won't be woken up, it will stay in suspend.
> >> I mean the CPU is waked up frequently by timer when phone suspend,
> >> not the whole device (like the display).
> >>
> >> Seems it's better to have deferred timer when device is suspended for
> >> power saving,
> >> and delayed timer when device in working state. User knows this and
> >> can use sysfs
> >> to change it.
> >
> > Doesn't devfreq_suspend_device() already cancel any timer work either
> > way in that case?
>
> Correct, the governor should pause the monitoring mechanism (and timer).
>
> Regards,
> Lukasz
