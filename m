Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC9B3FE561
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 00:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhIAWS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 18:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhIAWS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 18:18:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C428EC061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 15:17:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id d16so1649365ljq.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mkYlGOOI2XHXAcC6fGXdIUjY7c89i+268urO+ZxZSA=;
        b=dHmcAmAm3IC0KEFZc/Rn/sHI/1Ppc9ONdyOVybNo80v2572pzhZgfuYafjS7y4Gxgy
         aMlwJZKKCMXQZ+0756LXhwAgVmseqvMLW2itbfrgvOiC8dwIq0KF9pTAgwA2l1ypUndy
         Gu6kfKsTK+dMiXKoLVZYxzMpFwA94ScgiEnAs3biHPu1guE7itjGuOfYqDvgWKrgn3y3
         2TGkGGJgopbx0TdT+LculIu7pE25U818HgQoWn1NhPIkKb3TkJZVFGeXnHejLeI6Yh6T
         MLmAwSSgNR0gJSxtR6fyAPDev9Ac/pTo7N7lRwbdW/pNftePluLfXPGVUlB4pDupOBII
         4RQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mkYlGOOI2XHXAcC6fGXdIUjY7c89i+268urO+ZxZSA=;
        b=ueenx1Ay0b7HfB+nMOmll9mpqYH3szfV8S2OG+TN75WFoUSVpg45kDshH80i0dtdAl
         ayO+MlrlUdkxFumaertbKT9eqgpKqOi4VhzPwXT3CaiBP4iXgPiHoTPAZ81cfoQNumF5
         mDg36Dysq0L1HUec3ucGAQRvrDYi9h2bKU4pLtXAVD2On3HjQRE7qzfa4EN6u0lqLYCe
         D3ZmIQQwmbBBBAZxqwNmLboBsP3wxVbbc9fCYVmM0dsA9KaE5/oVm5s0Ht31PEV2jNKo
         54GcYzaHgy0FzsH4/s1Uh0BsfBOGXe3eVGH1yy9a9uFADZdsLT7G3ZsiHASLXjT0sNBb
         VtOw==
X-Gm-Message-State: AOAM532bpMDYOJWL1o+Y0qqdngLq/MufG0FC1GU50rSPdz+yDyiN1oxE
        9Q28+8D6EJx8fTVDbLFExpC4SF8i/Lmk8Q90niQIYw==
X-Google-Smtp-Source: ABdhPJyXudFomOqqxKSGeG07GItGSLt2nHMj3AmpV06+0z2E5OcbIM24GMbV+v+JuJbJ3yDfBZG+vlkvvzWwmPsZudA=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr1495391ljn.364.1630534676921;
 Wed, 01 Sep 2021 15:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <CAPDyKFpQqKx2UDo4kc3eAxPfp47gOGbjtnm0fg1q+bshpb-vew@mail.gmail.com>
 <CAGETcx8Oc63WXy6VPNQ6uO1JhQpVFgcCYNhSJNbvDp1CD18KQg@mail.gmail.com>
In-Reply-To: <CAGETcx8Oc63WXy6VPNQ6uO1JhQpVFgcCYNhSJNbvDp1CD18KQg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Sep 2021 00:17:20 +0200
Message-ID: <CAPDyKFo7Y9NPm1UoKzsRNKZbvoqmCUCVg0UD8dwa5FLb1FOZkQ@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Sept 2021 at 23:54, Saravana Kannan <saravanak@google.com> wrote:
>
> On Wed, Sep 1, 2021 at 8:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 1 Sept 2021 at 00:45, Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Devices that are not on a bus will never have a driver bound to it. So,
> > > fw_devlink should not create device links for it as it can cause probe
> > > issues[1] or sync_state() call back issues[2].
> > >
> > > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> >
> > Unfortunately, this doesn't fix my problem in [2].
> >
> > When the "soctest" device is initialized, via of_platform_populate(),
> > it will be attached to the platform bus, hence the check for the bus
> > pointer that you suggest to add below, doesn't have an impact on my
> > use case. I still get the below in the log:
>
> *face palm* Right. I forgot that. I just read "bus" and my mind went
> to busses added as devices. It apparently also didn't help [1] which
> is surprising to me. I'll dig into that separately. I'll look into
> fixing this. The annoying part is that some devices have compatible
> property that's both "simple-bus" and some other string that a driver
> actually matches with.

Yes, that is my view of the problem as well.

So perhaps we should do a more fine grained check for when the
"simple-bus" compatible is present in the node, and then don't create
a fw_devlink if we reach an ascendant with only this compatible?

Would that work, do you think?

Kind regards
Uffe

>
> -Saravana
>
> >
> > "platform soctest: Linked as a sync state only consumer to pm_domain_test"
> >
> > Kind regards
> > Uffe
> >
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
> > >         struct device *sup_dev;
> > >         int ret = 0;
> > >
> > > +       /*
> > > +        * If a consumer device is not on a bus (i.e. a driver will never bind
> > > +        * to it), it doesn't make sense for fw_devlink to create device links
> > > +        * for it.
> > > +        */
> > > +       if (con->bus == NULL)
> > > +               return -EINVAL;
> > > +
> > >         sup_dev = get_dev_from_fwnode(sup_handle);
> > >         if (sup_dev) {
> > > +               /*
> > > +                * If a supplier device is not on a bus (i.e. a driver will
> > > +                * never bind to it), it doesn't make sense for fw_devlink to
> > > +                * create device links for it.
> > > +                */
> > > +               if (sup_dev->bus == NULL)
> > > +                       return -EINVAL;
> > > +
> > >                 /*
> > >                  * If it's one of those drivers that don't actually bind to
> > >                  * their device using driver core, then don't wait on this
> > > --
> > > 2.33.0.259.gc128427fd7-goog
> > >
