Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BC402747
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245750AbhIGKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbhIGKhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:37:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91140C061757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 03:36:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c8so18629115lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39dcuRpzaRC5BdwM3JqFxL9Y6Q3cQwXZto24BgL4zlw=;
        b=WRPwsUgs3jtAT985APtpAk7gOLDCyjfqConNDw11zz00sChZxuthXUGYMXMobYeT6M
         VpMPeE4+aAP/7PFEWpW8s+uoC+BF2cF4tOVrebQAFyWaqHmG/IjgTepK4IvgA1kWTTsK
         hLK98/P7/EVpFMY5VCM+9gimM1MGCgUGuxyXCA+3xG+tMKIiCN55tbN3z2gSRJRJ8XJC
         D618HhXkEfoa+AtVON0zbllCFLG0x6/yVkz9U9zEDrPn+ccRk7scvDsHcMvp3/DG3UYc
         iHUdVdX9poEASUwIJqZpv672VVlyEyVGetdOZiLhAnFOYkDaApJKquA3w6M4FtPs8yxE
         tcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39dcuRpzaRC5BdwM3JqFxL9Y6Q3cQwXZto24BgL4zlw=;
        b=jNyse4TiC9GNLrDons+kwaFHPs0eTa5IMcfdtPqEpF461u0u9Zj5Ij4PJfOe7QjJAT
         /fIH10NT7u8Mum7AEqWO1PV2k1EC/6pOtamNZibceHqIm1Ny1yY0szkcPNPD0TPZe+F5
         Utwk6rrNAkszoUuQll4vKSFghxfi3Ga9n1gWhPl3W69scSYWytFmBANunPwUrJPo7S3L
         2S06n5TzsPFRyewB7TVAfBsiA6YG8DZHg5KkLlXv3zZESIYyIpveafwpXPyQ1ERV+rY+
         Zz4EaCI31gClmzWR/44/X0C/dD59q/b0kPTZkComoQQkJB5ztIYlx8h2LdwZbAbZW2JE
         sXbg==
X-Gm-Message-State: AOAM5327shPFQhnHyU8CwpQJicMjOHOuiZsjbOD4cVz1g4xT9mHrHGih
        oOvsJO9KyWYV5ILFaKFmU6f0ixs9I5Fa7MnWNQ6ixw==
X-Google-Smtp-Source: ABdhPJwwA0NSPTO/J8/Y+LSVPXUrJzOZ6ZFh4DSu0zI1UQW0yIXFDmNMkzM2NaFOX+3m36whk5wogBMs2rmww/YsDKo=
X-Received: by 2002:a05:6512:1528:: with SMTP id bq40mr1777835lfb.71.1631010986959;
 Tue, 07 Sep 2021 03:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-2-saravanak@google.com> <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
 <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com>
In-Reply-To: <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Sep 2021 12:35:50 +0200
Message-ID: <CAPDyKFrGyOWSxe=0DGWNQ75YQgXVa62WF8=pOHNCWUh5PLcdqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sept 2021 at 16:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Sep 3, 2021 at 11:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> > > fw_devlink could end up creating device links for bus only devices.
> > > However, bus only devices don't get probed and can block probe() or
> > > sync_state() [1] call backs of other devices. To avoid this, set up
> > > these devices to get probed by the simple-pm-bus.
> > >
> > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Tested-by: Saravana Kannan <saravanak@google.com>
> >
> > Again, this looks like a nice solution to the problem.
> >
> > One question though. The Kconfig SIMPLE_PM_BUS, should probably be
> > "default y" - or something along those lines to make sure fw_devlink
> > works as expected.
>
> I would love for SIMPLE_PM_BUS to go away, and all of its functionality
> to be usurped by the standard simple-bus handling.
>
> In the modern world, everything uses power management and Runtime
> PM, and the distinction between "simple-bus" and "simple-pm-bus"
> is purely artificial.

I think it's not that easy, but maybe I am wrong.

Today we have an opt-in way of supporting runtime PM (and power
management). In most cases it's up to drivers or subsystem level code
to decide if runtime PM should be enabled for the device.

Would it really be okay to enable runtime PM for all of them?

Kind regards
Uffe
