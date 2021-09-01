Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E43FD41A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 08:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242460AbhIAG7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 02:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242438AbhIAG7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 02:59:18 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C92C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:58:22 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id z18so3194366ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 23:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BLKyKpQsO6O3NpQVimbLxdB6cts9oQ6ypPbghBZuLE=;
        b=iXfTN/uzZtyBpMVQ69U3wuenVxX07PvzYxp2Cu6zaHLAo8e7N25FOi//UaILirdFn1
         6iIEogIgbInao3BYmmL4vp0beAdZLPhWtlZMn3ok827rkrgoe/39+fmLdyL5Rulzht4c
         fz2bpOKu2ah3giSRrGDW1rQdLQy9vieQEKWkaqdzwYrQuAUvrlqImRppZmb1rbcG3x9r
         6IP4H3J8MhxsLtRunetfRuh38ZpKPkJjAlkimvhYud2/Q4yqp3c6UZC4HcHCnxnM9VnP
         n6Es65gwus740TC8GGJnFnLzG96lymGtNKZnijKdnWmCDCIpeNmI9cWFZe/sfqSAhuxD
         c5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BLKyKpQsO6O3NpQVimbLxdB6cts9oQ6ypPbghBZuLE=;
        b=OmuEwHLoT1KWAAkFVfaFzIBAW1juFKglqD2e5a80v5MKakcMaJKYGnYFfXUsQ71VeS
         2WhsxAAfWDQqnbkmA2Ej1r3M8H72PsVa4IW2ROPH51kInzlRe9rzxSXnxe3sb7NgxbWE
         s9clH25o1lK27IO/upaNdR9N+1ANmi0vxalE1oeZflhGXuc7XlBzgNSee8RuN6JM37gw
         /OOCDfmzCB276/T2Qw9V89C6PXz5qYsjPugQ2dkEEcNxZaviovVYx2SiYzzGGFwUplf1
         NDH4Gc0V6FKReZwTKHJqgOznJLQyUA06kZg0fvseHSWprKleAz8PiwIKoXVlHgMu+upo
         J1Mw==
X-Gm-Message-State: AOAM532KyS4oNfngUEGgCL3/bGjN7nklkzlvkvxbZLpt/nrSiqSONTTV
        xSU4mN6CQN35gUgwMnHUI4rVuN2+mb6gD97bPJWElQ==
X-Google-Smtp-Source: ABdhPJystAIueIkYCReB/PKq27J/SMDQnMOWpDq+7pnK+bZpgXzBpZQa3z5X+8FoNReA6S+GK10bqwQk/jH5446T6ds=
X-Received: by 2002:a25:d213:: with SMTP id j19mr37171725ybg.20.1630479501331;
 Tue, 31 Aug 2021 23:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <YS8cncQxUZDRuhUG@kroah.com>
In-Reply-To: <YS8cncQxUZDRuhUG@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 31 Aug 2021 23:57:45 -0700
Message-ID: <CAGETcx8d0KR3BeLxa6eKr_QkNgg=+dcq18tAu2A5M6W9pMFOHw@mail.gmail.com>
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

On Tue, Aug 31, 2021 at 11:24 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Aug 31, 2021 at 03:45:10PM -0700, Saravana Kannan wrote:
> > Devices that are not on a bus will never have a driver bound to it. So,
> > fw_devlink should not create device links for it as it can cause probe
> > issues[1] or sync_state() call back issues[2].
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/core.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index f6360490a4a3..304a06314656 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1719,8 +1719,24 @@ static int fw_devlink_create_devlink(struct device *con,
> >       struct device *sup_dev;
> >       int ret = 0;
> >
> > +     /*
> > +      * If a consumer device is not on a bus (i.e. a driver will never bind
> > +      * to it), it doesn't make sense for fw_devlink to create device links
> > +      * for it.
> > +      */
> > +     if (con->bus == NULL)
> > +             return -EINVAL;
> > +
>
> Why would a device not be on a bus that has to do with a driver needing
> it?  What types of devices are these?

I'm not sure what you are asking, because it seems like a question
you'd know the answer to. What I'm trying to say is that
bus_probe_device() is obviously only possible if the device is on a
bus. And fw_devlink creates managed device links that track if a
device is bound to a driver. So it doesn't make sense to create the
device link if the device is not on a bus.

There are plenty of examples for this -- like all the devices that get
added to a class? For example the platform bus or the mdio bus itself
are devices that are added to a class instead of a bus.

Not sure if I answered your question. Let me know.

-Saravana
