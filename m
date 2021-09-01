Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244293FE51B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbhIAV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhIAV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:57:24 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EAC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:56:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e133so1648861ybh.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGOZwKFIZJKRc0KzyCtMhzoWyBSfrrxa1cT/himHIqQ=;
        b=vHz9OuVznj+rdVFh4FTb75jFJP9jwJ7vEI3y1rw7lXl95LlV1V6mnsabp8PxV9Kp2k
         PiirtxZbI/WcTs3QPrZgv1h1Y6fsh5rQdWmnxLJD3tDJqKso6lX/MQTY725hf4OQD+BX
         BMZDmYEc1T058wMaDmTHZg1873N4rkZ1KT4xc9RCsYg6inKCwTFZ8TeunB4qDGlRYVDT
         RZQ8k2cPr82FYvnv75cYNo2To2JYjqaAOnx2cBAMCIUXms4mRSjCEdsdcP+Cf53zYFlV
         KqGBf74dKQC/12FR9YESpiIDIOKR/qvSHzzfxZxhAV+4vYtb/OK6GIwJW3l4V64QdmQ2
         yJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGOZwKFIZJKRc0KzyCtMhzoWyBSfrrxa1cT/himHIqQ=;
        b=EXyCcnT/76jVzvHbPN2X6D/UrtQRgmSm8adBlJYY0Mceoil4LDqEtAf2xT1CN8rjPl
         q/xYxeWKKvzAn3zNz5o6l1dDVc9duI0grhtIu4NDSMROt3mv5xu0VIrTP5646w7siDJd
         68BLK/XNHvJudabRYHeSRkkEzQTuz0+H0GHRVdNWYQgHf7E73O2bkVOL4SnhxKfkURo7
         i/NeJOJiHMwIZlqN9bDTdYgEw+cEPirL9kBSUy/aawVQoSV/O4qxJ/p+jmWpnFn1aEuW
         zPDwpoBKC4narfy/6VtQCHLrDVWCLpms6IaE8hglTymJ58yvPVb8K2Gmg0EVahSGWiTS
         BSag==
X-Gm-Message-State: AOAM530tcvtqAOVumwWOJ2AzQYEdVRmcDuTzIfrvArGlc+CJ8iGTxkVR
        phEYSY7egr0WAWb1jNFX/CBvkDxUlb6QXweGmMWTQQ==
X-Google-Smtp-Source: ABdhPJwGsd8ULaZP8Q9eEPzr0OBUJlJG/2LhCJeo+rg6vglH4/D/dd5jAeO4krITwCa5RtmXvrrrAHswiY8awjZW7mI=
X-Received: by 2002:a25:81ce:: with SMTP id n14mr133151ybm.32.1630533386596;
 Wed, 01 Sep 2021 14:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <YS8cncQxUZDRuhUG@kroah.com>
 <CAGETcx8d0KR3BeLxa6eKr_QkNgg=+dcq18tAu2A5M6W9pMFOHw@mail.gmail.com> <YS8oOWjFe4yQ1Q/v@kroah.com>
In-Reply-To: <YS8oOWjFe4yQ1Q/v@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 14:55:50 -0700
Message-ID: <CAGETcx8B-9GJr_wCRLqH=eBKY+f=Cd+LGWfM+GQGt6HzOj1TdQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 12:14 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 31, 2021 at 11:57:45PM -0700, Saravana Kannan wrote:
> > On Tue, Aug 31, 2021 at 11:24 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Aug 31, 2021 at 03:45:10PM -0700, Saravana Kannan wrote:
> > > > Devices that are not on a bus will never have a driver bound to it. So,
> > > > fw_devlink should not create device links for it as it can cause probe
> > > > issues[1] or sync_state() call back issues[2].
> > > >
> > > > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > > > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > > Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > > > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/base/core.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > > index f6360490a4a3..304a06314656 100644
> > > > --- a/drivers/base/core.c
> > > > +++ b/drivers/base/core.c
> > > > @@ -1719,8 +1719,24 @@ static int fw_devlink_create_devlink(struct device *con,
> > > >       struct device *sup_dev;
> > > >       int ret = 0;
> > > >
> > > > +     /*
> > > > +      * If a consumer device is not on a bus (i.e. a driver will never bind
> > > > +      * to it), it doesn't make sense for fw_devlink to create device links
> > > > +      * for it.
> > > > +      */
> > > > +     if (con->bus == NULL)
> > > > +             return -EINVAL;
> > > > +
> > >
> > > Why would a device not be on a bus that has to do with a driver needing
> > > it?  What types of devices are these?
> >
> > I'm not sure what you are asking, because it seems like a question
> > you'd know the answer to. What I'm trying to say is that
> > bus_probe_device() is obviously only possible if the device is on a
> > bus. And fw_devlink creates managed device links that track if a
> > device is bound to a driver. So it doesn't make sense to create the
> > device link if the device is not on a bus.
> >
> > There are plenty of examples for this -- like all the devices that get
> > added to a class? For example the platform bus or the mdio bus itself
> > are devices that are added to a class instead of a bus.
> >
> > Not sure if I answered your question. Let me know.
>
> Sorry, that was a vague question.
>
> I was trying to say, "how can a device that is not attached to a bus at
> all even be called for this?"

This code path is called for all device_add()s.

> Who would be making that type of
> connection, what subsystem is causing this to happen?

fw_devlink trying to interpret DT dependencies can sometimes end up in
this situation for some uncommon cases. But it's not helping [1] or
[2], so for now let's drop this patch. I'll come back to this if I
need this to fix any real issue.

-Saravana
