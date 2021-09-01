Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F723FE51A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbhIAVzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 17:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhIAVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 17:55:30 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB1C061575
        for <linux-kernel@vger.kernel.org>; Wed,  1 Sep 2021 14:54:32 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q70so1471935ybg.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Sep 2021 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzWZpW/Xflc1H+ASOnQYbeGuxzVxMgF7Gs87eLhc5kU=;
        b=JkRAK6Pm7ampfbFOs6DYtjYB0pnCEfzfVIaUHo44OnGoyNvB+92RYWZ0/xmT9ETEtz
         aj+bOTCWXMjY38dRI17/30+fZLK9cQ0wXjlAjRGvSKSPo27utmholZQu+/tywIT2qXEH
         P+vxAaadz2VKgMnxn0xIduBkdliO2neAe/hL69MbkqK8CaYWgmqZZT6YPsFEjqCCtuct
         vGgXvdWefXE7CAeAMnE7vBHJYev/6oLWADHLFBL8arbDSSDqiIdfZHPDuYqSIuDJe9ry
         JOKaaKyg3uhATYrUjolYiapTlB/jpZICgMyRQcOFUZHhW5eai+t62EoTInVHnthQogud
         ZpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzWZpW/Xflc1H+ASOnQYbeGuxzVxMgF7Gs87eLhc5kU=;
        b=dnElXRUrzp+4gaLAjpln/us85McKVna/oxhpoc9rxvljlR3nV8JeA8VLFlllTVQRKS
         nKAaHIkHdgUpaoyixgSJIjMjd/R8zxxzoX24ZFuB2Dcmlnuq5f8BExbXETsOw+v8oaNt
         BqSvwPehO2Bt6dwoTGS5e3LFs5uoIWGclntxV5reUziFF+S3YgZxa5CGZP2EFqO35uKy
         Rl0BsYd6C674U0wpKlvC3AVGtjQFukUOCNkoE1O5DUhpLQIwsnvakBvnBYa92M9QxsS/
         I7TBPuVpLc+Dj7xe5VQFBfwlHNIhRdPJBH0nzlwrkp1Wz6uG7y/ULgryVOJliahP3C3o
         dsoQ==
X-Gm-Message-State: AOAM533hqzI6gm41V+RY1MRUYrHvn3bBAImqCg7HakuiBfSqB2s3CRU7
        s3MIBOX+Qj/gI3VvqbzKM0U70wJ6df5yw/G+m7l+zQ==
X-Google-Smtp-Source: ABdhPJyvQE0l51vewxnPd4rilCE4lt341yeBbELAKEXDmAXKrixsJ368V4O3fWo5a4B96ue3Dplvl9Nn4c4ctriesi4=
X-Received: by 2002:a25:9c01:: with SMTP id c1mr95596ybo.228.1630533271932;
 Wed, 01 Sep 2021 14:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210831224510.703253-1-saravanak@google.com> <CAPDyKFpQqKx2UDo4kc3eAxPfp47gOGbjtnm0fg1q+bshpb-vew@mail.gmail.com>
In-Reply-To: <CAPDyKFpQqKx2UDo4kc3eAxPfp47gOGbjtnm0fg1q+bshpb-vew@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 1 Sep 2021 14:53:56 -0700
Message-ID: <CAGETcx8Oc63WXy6VPNQ6uO1JhQpVFgcCYNhSJNbvDp1CD18KQg@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: fw_devlink: Don't create device links for
 devices not on a bus
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 1, 2021 at 8:45 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 1 Sept 2021 at 00:45, Saravana Kannan <saravanak@google.com> wrote:
> >
> > Devices that are not on a bus will never have a driver bound to it. So,
> > fw_devlink should not create device links for it as it can cause probe
> > issues[1] or sync_state() call back issues[2].
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx_xJCqOWtwZ9Ee2+0sPGNLM5=F=djtbdYENkAYZa0ynqQ@mail.gmail.com/
> > [2] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
>
> Unfortunately, this doesn't fix my problem in [2].
>
> When the "soctest" device is initialized, via of_platform_populate(),
> it will be attached to the platform bus, hence the check for the bus
> pointer that you suggest to add below, doesn't have an impact on my
> use case. I still get the below in the log:

*face palm* Right. I forgot that. I just read "bus" and my mind went
to busses added as devices. It apparently also didn't help [1] which
is surprising to me. I'll dig into that separately. I'll look into
fixing this. The annoying part is that some devices have compatible
property that's both "simple-bus" and some other string that a driver
actually matches with.

-Saravana

>
> "platform soctest: Linked as a sync state only consumer to pm_domain_test"
>
> Kind regards
> Uffe
>
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
> >         struct device *sup_dev;
> >         int ret = 0;
> >
> > +       /*
> > +        * If a consumer device is not on a bus (i.e. a driver will never bind
> > +        * to it), it doesn't make sense for fw_devlink to create device links
> > +        * for it.
> > +        */
> > +       if (con->bus == NULL)
> > +               return -EINVAL;
> > +
> >         sup_dev = get_dev_from_fwnode(sup_handle);
> >         if (sup_dev) {
> > +               /*
> > +                * If a supplier device is not on a bus (i.e. a driver will
> > +                * never bind to it), it doesn't make sense for fw_devlink to
> > +                * create device links for it.
> > +                */
> > +               if (sup_dev->bus == NULL)
> > +                       return -EINVAL;
> > +
> >                 /*
> >                  * If it's one of those drivers that don't actually bind to
> >                  * their device using driver core, then don't wait on this
> > --
> > 2.33.0.259.gc128427fd7-goog
> >
