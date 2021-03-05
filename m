Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB832F219
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCESDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCESD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:03:26 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBBAC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 10:03:26 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id p186so2874604ybg.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djl9vEdDtCECHGkkot2m0e+U91r4xg0cdS4xkGZwStE=;
        b=jutvhuQuZAGRZfaHNBelrYZZYMaWa8pHyKIdYZpe8tw2JMdjFN6PmAPPYw1nKt8ogm
         jfkg1okzS9DRtxQ+SLQk6IJKEzOVQmnRXgT0bNlSNBGJCB0xdinbvliRgul69b34ZQIQ
         JHDol7I+bkeA7wA1GoElotFHHuzyzUuGMOdwapEmQIuuxPH6huvYfcHYg9ILx62ChXTm
         QOeR6k0HjFp7U+xy63m1z33bO9SQv8IL1mr5YuRYUaOlK/OLcYDXp/7TY9uVhCmsUX3V
         ZQ1Cu1/RMi/PovRRLf/ZoWv1ji5ci06jiBE4+WFbytQVbF/01PPMp4kUsdUlW610pPxU
         NYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djl9vEdDtCECHGkkot2m0e+U91r4xg0cdS4xkGZwStE=;
        b=pJ8CX74EsbDDB2gquokaMccOhwjr5vunN/WWaegkFviySQs7MW/I1ZROginW3BiaIm
         FAy8+MghaG3mOtabtpgrjZ7fEcwLLGp9re/trMHJcqJHQaF2JtWCwwKNIj0Q2ax3FYXs
         x6FdC0PNEZGbMMbaaIiZivcEJs3QNUbsAm8dNYvQyWLCa+CBB4hhhUlRQV+qzKFVyj3v
         rR27eHdZVDvaZLAKJe/qgRX4oE8WcymrOLnKa2Jev3GX7/YgwuTJWcozVYmbyCfScXjC
         sziUKke8juofR5t5Q9/sMgDmbpRBbG+1fVI74IS7wLZhW7LtbDGNGVIve+29SQGXkIxW
         th5g==
X-Gm-Message-State: AOAM533IdD5o+Dd/ANfszuWGnI89vhC5ynR4d6rwwNt/N4rVe1RpFuAC
        gzDmolCn61Nu0BgCAEezSjMsKY4Qd2AVKnrddfLkHg==
X-Google-Smtp-Source: ABdhPJxv2rZeVhmgXQg3h1RLek6c24WyokynKkq8b1tQowagFxkYNQDOAWjmwGskFgch+Hw4g9+ohcC0R4NXydS3OBo=
X-Received: by 2002:a25:c283:: with SMTP id s125mr14443325ybf.310.1614967405029;
 Fri, 05 Mar 2021 10:03:25 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3@eucas1p1.samsung.com>
 <20210304195101.3843496-1-saravanak@google.com> <30b4141e-11bd-45a2-b890-fddf444548ea@samsung.com>
In-Reply-To: <30b4141e-11bd-45a2-b890-fddf444548ea@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 5 Mar 2021 10:02:48 -0800
Message-ID: <CAGETcx87v5=jDqCmdJL9VShAv+OzOGyF43mahxdk9A-RzNJYkA@mail.gmail.com>
Subject: Re: [PATCH v3] amba: Remove deferred device addition
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 5, 2021 at 3:45 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 04.03.2021 20:51, Saravana Kannan wrote:
> > The uevents generated for an amba device need PID and CID information
> > that's available only when the amba device is powered on, clocked and
> > out of reset. So, if those resources aren't available, the information
> > can't be read to generate the uevents. To workaround this requirement,
> > if the resources weren't available, the device addition was deferred and
> > retried periodically.
> >
> > However, this deferred addition retry isn't based on resources becoming
> > available. Instead, it's retried every 5 seconds and causes arbitrary
> > probe delays for amba devices and their consumers.
> >
> > Also, maintaining a separate deferred-probe like mechanism is
> > maintenance headache.
> >
> > With this commit, instead of deferring the device addition, we simply
> > defer the generation of uevents for the device and probing of the device
> > (because drivers needs PID and CID to match) until the PID and CID
> > information can be read. This allows us to delete all the amba specific
> > deferring code and also avoid the arbitrary probing delays.
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1 -> v2:
> > - Dropped RFC tag
> > - Complete rewrite to not use stub devices.
> > v2 -> v3:
> > - Flipped the if() condition for hard-coded periphids.
> > - Added a stub driver to handle the case where all amba drivers are
> >    modules loaded by uevents.
> > - Cc Marek after I realized I forgot to add him.
> >
> > Marek,
> >
> > Would you mind testing this? It looks okay with my limited testing.
>
> It looks it works fine on my test systems. I've checked current
> linux-next and this patch. You can add:
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Hi Marek,

Thanks! Does your test set up have amda drivers that are loaded based
on uevents? That's the one I couldn't test.

> I've briefly scanned the code and I'm curious how does it work. Does it
> depend on the recently introduced "fw_devlink=on" feature? I don't see
> other mechanism, which would trigger matching amba device if pm domains,
> clocks or resets were not available on time to read pid/cid while adding
> a device...

No, it does not depend on fw_devlink or device links in any way.

When a device is attempted to be probed (when it's added or during
deferred probe), it's matched with all the drivers on the bus.
When a new driver is registered to a bus, all devices in that bus are
matched with the driver to see if they'll work together.
That's how match is called. And match() can return -EPROBE_DEFER and
that'll cause the device to be put in the deferred probe list by
driver core.

The tricky part in this patch was the uevent handling and the
chicken-and-egg issue I talk about in the comments.

Russell,

Does this look good now? Plan to pick it up some time?

Thanks,
Saravana

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
