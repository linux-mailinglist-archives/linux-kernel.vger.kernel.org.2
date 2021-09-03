Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E819400143
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhICOaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:30:22 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:46982 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349458AbhICOaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:30:19 -0400
Received: by mail-vs1-f41.google.com with SMTP id s15so4489691vst.13;
        Fri, 03 Sep 2021 07:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OH/yNneTW8ywoSU/FMn8PAE6gbwXxPiCtJG6BV80nas=;
        b=m1yUU6HJsFy5DV3tfZev5Uo6XqRBb5Ns6My7+se/SqnsIzP5D4B1mVq67GMg9UtHHU
         8rue3Q+fG7oaxkF4iFS0OpcABBhxA+eO20rZ441SSYQfFS2IpeUgujxAHhCMerq+36bQ
         HzT8WmLZucJ9xl7csbxwrTEjkypDqNP9RbBZueXupi6axX1h5CgzjZV+Saxf1V+ORHKD
         jOunddsYvGVATxhy0/QQ9Q7CN8oyIqNaqPhqrAJEXTvR01Gx3ABx7m/vrSgSAn2GJJir
         6aVWxXaHDX26WAfEUFt8PaTBrfHnwYZEwj1Z2HHpC1AAn0NLU8RMk0cMZqsBAM2RI7oC
         9NAQ==
X-Gm-Message-State: AOAM5317G1u26BDjXG74XdNqohdgRO6XiSCqJHEmaxPmNAde4cHcwsrR
        ZF9DdtcxYGK/hht0KXDkLka2z/eYzfpWqNv3vi8=
X-Google-Smtp-Source: ABdhPJxsBMD7/twadRD30kYlp1FDjI2SD++y9JBHgqnwGoCvtFrt1Btu9MZ/e6T7FAU7oxPwAUF3GMMrJ/u+Uotz0GE=
X-Received: by 2002:a67:dd85:: with SMTP id i5mr2873897vsk.41.1630679359064;
 Fri, 03 Sep 2021 07:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-2-saravanak@google.com> <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
In-Reply-To: <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Sep 2021 16:29:07 +0200
Message-ID: <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Ulf Hansson <ulf.hansson@linaro.org>
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

Hi Ulf,

On Fri, Sep 3, 2021 at 11:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> > fw_devlink could end up creating device links for bus only devices.
> > However, bus only devices don't get probed and can block probe() or
> > sync_state() [1] call backs of other devices. To avoid this, set up
> > these devices to get probed by the simple-pm-bus.
> >
> > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Tested-by: Saravana Kannan <saravanak@google.com>
>
> Again, this looks like a nice solution to the problem.
>
> One question though. The Kconfig SIMPLE_PM_BUS, should probably be
> "default y" - or something along those lines to make sure fw_devlink
> works as expected.

I would love for SIMPLE_PM_BUS to go away, and all of its functionality
to be usurped by the standard simple-bus handling.

In the modern world, everything uses power management and Runtime
PM, and the distinction between "simple-bus" and "simple-pm-bus"
is purely artificial.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
