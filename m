Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4163FD44C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhIAHPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 03:15:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242416AbhIAHPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 03:15:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EACF36108E;
        Wed,  1 Sep 2021 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630480444;
        bh=qcziVJPLfsI4jgwvd3Jl+wq1EsG++hPVbp6IUaXpG+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XlM4WZ+zaIOvpAbDgwA+crg7DoMZ3BaqcovgkiTDFaOh5YSjT3T6GhHckZP8z+LaB
         xh8MkC2nD2efzEKjMCbXy+tpRhEMMvGspQkprk2tLrzbU9CBkokKsTtNmXYIA8fDEp
         TqIHM/lf+MLZX+q767TOEq3rPMnhlENd/TwH1Hi8=
Date:   Wed, 1 Sep 2021 09:14:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links
 for devices not on a bus
Message-ID: <YS8oOWjFe4yQ1Q/v@kroah.com>
References: <20210831224510.703253-1-saravanak@google.com>
 <YS8cncQxUZDRuhUG@kroah.com>
 <CAGETcx8d0KR3BeLxa6eKr_QkNgg=+dcq18tAu2A5M6W9pMFOHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8d0KR3BeLxa6eKr_QkNgg=+dcq18tAu2A5M6W9pMFOHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 11:57:45PM -0700, Saravana Kannan wrote:
> On Tue, Aug 31, 2021 at 11:24 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 31, 2021 at 03:45:10PM -0700, Saravana Kannan wrote:
> > > Devices that are not on a bus will never have a driver bound to it. So,
> > > fw_devlink should not create device links for it as it can cause probe
> > > issues[1] or sync_state() call back issues[2].
> > >
> > > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> > > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/core.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index f6360490a4a3..304a06314656 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -1719,8 +1719,24 @@ static int fw_devlink_create_devlink(struct device *con,
> > >       struct device *sup_dev;
> > >       int ret = 0;
> > >
> > > +     /*
> > > +      * If a consumer device is not on a bus (i.e. a driver will never bind
> > > +      * to it), it doesn't make sense for fw_devlink to create device links
> > > +      * for it.
> > > +      */
> > > +     if (con->bus == NULL)
> > > +             return -EINVAL;
> > > +
> >
> > Why would a device not be on a bus that has to do with a driver needing
> > it?  What types of devices are these?
> 
> I'm not sure what you are asking, because it seems like a question
> you'd know the answer to. What I'm trying to say is that
> bus_probe_device() is obviously only possible if the device is on a
> bus. And fw_devlink creates managed device links that track if a
> device is bound to a driver. So it doesn't make sense to create the
> device link if the device is not on a bus.
> 
> There are plenty of examples for this -- like all the devices that get
> added to a class? For example the platform bus or the mdio bus itself
> are devices that are added to a class instead of a bus.
> 
> Not sure if I answered your question. Let me know.

Sorry, that was a vague question.

I was trying to say, "how can a device that is not attached to a bus at
all even be called for this?"  Who would be making that type of
connection, what subsystem is causing this to happen?

thanks,

greg k-h
