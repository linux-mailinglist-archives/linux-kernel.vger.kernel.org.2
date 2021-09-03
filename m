Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27626400585
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350976AbhICTHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:07:14 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:34660 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350972AbhICTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:07:13 -0400
Received: by mail-vs1-f41.google.com with SMTP id x137so176120vsx.1;
        Fri, 03 Sep 2021 12:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABDbT8IoH3N9gd+Y63uECbNi/NCZYOelz//HTakCyVY=;
        b=bNlQyFaUaQInXlcPJ4aqvTJe8T8VgW3tdsQ6vlN7MCdjTJA46S+YNs31VAIn3h5QrM
         Z3qLGS0Srmi6TLilJ7aYdcEOudZQWxHarvyRgBL8UX2K4Z33vPdrMlC0kOy9oX4m+CT+
         ewSke3deajZ1rijvDWjbflcV7XDV6u89gh5pxDc+etixgWOeL5WqNmh7egfwUAcyFV7r
         BG2xZjr1b2gnU/4PGGRHlK9h9irAFimLyIm3NSiagV4SjPYSKijGl6RO+GPVXmxnkZQO
         ekhFBsD8fE3X00gRGl0MFXj+/IceTCyiFgqrr7tgkUJfQYBsbezKCn17xuvsZ78GTqs7
         7c/A==
X-Gm-Message-State: AOAM530TYKj0ZuQwJcgbatHKt5WgEirnuilcY8JNNOHzo8M2k0EDNtZ2
        U2gokKc6znNwK1gwjAh5F80f+diUEe2ugAh2p+I=
X-Google-Smtp-Source: ABdhPJyA+vwFT4aqEWmB7h8rGNZZVao3SlVmke21AZgP6ubwvXlx1jIEuiR+RCyUbYnqgM3JgJP0IP/yE+LtKbMtyrc=
X-Received: by 2002:a67:3289:: with SMTP id y131mr502481vsy.37.1630695972911;
 Fri, 03 Sep 2021 12:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-2-saravanak@google.com> <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
 <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com> <CAGETcx9W6FYCD62+QytwK5FThpz0EyKn0G6Ay2B5jKgiqkZT1g@mail.gmail.com>
In-Reply-To: <CAGETcx9W6FYCD62+QytwK5FThpz0EyKn0G6Ay2B5jKgiqkZT1g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Sep 2021 21:06:00 +0200
Message-ID: <CAMuHMdWNP1yn0ouJzgYpvQkdAHAA4_gf8z+iZWpbftvGN5a+qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Saravana Kannan <saravanak@google.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

On Fri, Sep 3, 2021 at 7:09 PM Saravana Kannan <saravanak@google.com> wrote:
> On Fri, Sep 3, 2021 at 7:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Sep 3, 2021 at 11:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> > > > fw_devlink could end up creating device links for bus only devices.
> > > > However, bus only devices don't get probed and can block probe() or
> > > > sync_state() [1] call backs of other devices. To avoid this, set up
> > > > these devices to get probed by the simple-pm-bus.
> > > >
> > > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Tested-by: Saravana Kannan <saravanak@google.com>
> > >
> > > Again, this looks like a nice solution to the problem.
> > >
> > > One question though. The Kconfig SIMPLE_PM_BUS, should probably be
> > > "default y" - or something along those lines to make sure fw_devlink
> > > works as expected.
> >
> > I would love for SIMPLE_PM_BUS to go away, and all of its functionality
> > to be usurped by the standard simple-bus handling.
>
> What if SIMPLE_PM_BUS *is* the standard simple-bus handling?
> Insert "I'm the captain now" meme.

No objections from my side.  In fact that's how I wanted it to be
from the beginning, but the DT people wanted a separate compatible
value (and a separate driver).  The only difference is the presence
of pm_runtime_*() calls.

> I think SIMPLE_PM_BUS config should just go away and we should compile
> the driver in if CONFIG_OF is selected.

I think there would be no need for a separate driver, if the standard
simple-bus handling would take care of it.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
