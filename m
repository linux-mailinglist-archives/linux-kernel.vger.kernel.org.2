Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F5932D71A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhCDPto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 10:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbhCDPtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:49:23 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF6C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 07:48:43 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id u3so28974298ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 07:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C2GfwX8BAsutusYxwRoGwg9Tjy9ZmGXPqTmJyveNAWY=;
        b=Varx3y3jXJVUubA3WfuStWPFpbarbln1G5ZoZ8EhzOFuHj8d+REr+pacf9Oi3KX/iZ
         cw/a8PANrcwTCJceTanz7vcs0rEhHJ0XLO+9s80Mjp+MKgL7p38c7HTg2LJAxR9ODdI9
         f+cEn09FAaXpD2nNX52eTdkxcBrVkqBrYpTwmxOEBeIq9w8+9qnyQYfaOl756mCjcKT0
         ZmfaOXHOOgWdhZmXNBCOLcOMyocEJ0f2M6G0XxpUKXZGL0WhJKilBa68glK4nM4FkZ/J
         gUrgGNFRcX6UncJqpqThPmhWJYwHP/DUlhmbiM7918ZwZuqsItyR8pogrQyeWNqYT3eh
         k9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2GfwX8BAsutusYxwRoGwg9Tjy9ZmGXPqTmJyveNAWY=;
        b=KXaZ/Ak7WpYJ7Ln2QFnOk7FXEo/2f+kE33ScHIC1+b+ThZQtP8Pk8OlmAS9YLsUSyT
         930Q+HO6VcpPNpmRiCVAGemzL2/DWmw1JEaOHh+mVa0Y5EznnJ6udxdfFrYUxwC7MKL7
         7axfV98Uqz4nt1rdWELARfdKeykv2B5qTGCs+6mF0hjl2Q/DDI+xyxNEdCwgyqOebjZt
         d6yRP5Px7q/hENehigBggdffyL+tU6pg9HrphpQpvT8Fo7M9fPbYKgLRbS+WWHDvohXI
         JXPnKdhtzbji7WVSWYLU6RBKtKPAwj0Lbi4nw4OJHAAkYpmlkSo5A27w0osyFUp1dl+y
         E+Aw==
X-Gm-Message-State: AOAM5308xUFp1+wqvqkq3n/mW2RapoggAFSNuLRX/r2zj5GO1VAVhiR0
        euUoml859aS2LXr4iLH7jNd42sc+v2Ebatj5jpngfA==
X-Google-Smtp-Source: ABdhPJyoPLo40CyXER4Db7DYGJtecHOzhyXxbovtbc2ozdql8F1XjOp0z4j+PCuluuP6b727HNgT2ZD5ML5iWBCNeeg=
X-Received: by 2002:a25:c283:: with SMTP id s125mr6540496ybf.310.1614872922114;
 Thu, 04 Mar 2021 07:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20210304035958.3657121-1-saravanak@google.com>
 <CAGETcx8KQ7cm7irv-vsBzqYfZqSMz4c3_hD_V55gxjVM1vd=PA@mail.gmail.com> <20210304141205.GC1463@shell.armlinux.org.uk>
In-Reply-To: <20210304141205.GC1463@shell.armlinux.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Mar 2021 07:48:06 -0800
Message-ID: <CAGETcx_WHkZOtF+iv4gx3KnNDYiAg1Ys8MQbW89E4H2bRAUCkw@mail.gmail.com>
Subject: Re: [PATCH v2] amba: Remove deferred device addition
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Mar 4, 2021 at 6:12 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 03, 2021 at 08:08:44PM -0800, Saravana Kannan wrote:
> > Marek,
> >
> > I tested it and saw the device get added before the resources were
> > available and the uevent file looked okay. Would you mind testing it
> > further?
>
> To put it bluntly, if you have tested this, the testing was not very
> effective. Deleting the lines that are removed by the patch so we can
> see what the new code looks like below:
>
> > > +int amba_device_add(struct amba_device *dev, struct resource *parent)
> > >  {
> > > +       int ret;
> > >
> > >         WARN_ON(dev->irq[0] == (unsigned int)-1);
> > >         WARN_ON(dev->irq[1] == (unsigned int)-1);
> > >
> > >         ret = request_resource(parent, &dev->res);
> > >         if (ret)
> > > +               return ret;
> > >
> > > +       /* If primecell ID isn't hard-coded, figure it out */
> > > +       if (dev->periphid) {
> > > +               ret = amba_read_periphid(dev);
>
> So, if the peripheral ID has _already_ been set, we attempt to read the
> peripheral ID from the device. Isn't that just wrong?
>
> > > +               if (ret && ret != -EPROBE_DEFER)
> > > +                       goto err_release;
> > >                 /*
> > > +                * AMBA device uevents require reading its pid and cid
> > > +                * registers.  To do this, the device must be on, clocked and
> > > +                * out of reset.  However in some cases those resources might
> > > +                * not yet be available.  If that's the case, we suppress the
> > > +                * generation of uevents until we can read the pid and cid
> > > +                * registers.  See also amba_match().
> > >                  */
> > > +               if (ret)
> > > +                       dev_set_uevent_suppress(&dev->dev, true);
> > >         }
>
> If the peripheral ID has not been set, we don't attempt to read it, and
> we generate an add event when the amba device is added with a zero
> peripheral ID.
>
> I guess that if() statement should be negated - and with such an error,
> I fail to see how this code could have been properly tested.

Yeah, the if() needs to be flipped. I even flipped it and then
unflipped it before I sent the patch. Thanks for catching it.

It worked in my testing because the device didn't have hard coded PID.
So it worked out fine.

But I now realize I still have a chicken-and-egg problem if ALL amba
drivers are modules. amba_match() will never be called because none of
the amba drivers have been loaded. None of the amba drivers would be
loaded (depending on the set up) because none of the uevents were sent
out. But there's a simple fix for this. I'll send that as part of v3.

Marek,

It'd still be nice if you can test this with the if() above flipped.
If all your amba drivers are modules and loaded based on uevents,
manually loading one of them will kick off everything.

-Saravana
