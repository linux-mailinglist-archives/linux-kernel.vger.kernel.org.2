Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0713FA010
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 21:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhH0Thf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 15:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhH0The (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 15:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C021460FDA;
        Fri, 27 Aug 2021 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630093005;
        bh=fmL6BQuBnKkD0TelF5G9tZjoYlli2l9Xzul4RuYUBeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwFDrTSvVjwNVRpVQoUZ6n1bdnKC4JAlKSKfVN4pclc4Leh3GJhT2McT7Q2Wbp56c
         8u/WTDENzYKKzr+mrpnH+F9wGiUM927pYCl742Ekvr4NV665U1uIRw0lQ8YlP5g6ul
         my9v5FdUfzA7TNI/soYH8Xf0EM9Fk6B4ml+5ej9Y=
Date:   Fri, 27 Aug 2021 21:36:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
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
Subject: Re: [PATCH v3] amba: Remove deferred device addition
Message-ID: <YSk+xbOOAH2D9w3Y@kroah.com>
References: <CGME20210304195109eucas1p1779060378305d0f9a1eb0c7ddefd1db3@eucas1p1.samsung.com>
 <20210304195101.3843496-1-saravanak@google.com>
 <30b4141e-11bd-45a2-b890-fddf444548ea@samsung.com>
 <CAGETcx87v5=jDqCmdJL9VShAv+OzOGyF43mahxdk9A-RzNJYkA@mail.gmail.com>
 <077fcc5b-cd09-d587-6906-d10bcc991eaf@samsung.com>
 <CAGETcx-bmeXK4Ws2=Zeth2yiNJ0hXHZEs4GxqL7jY3+71hhF=g@mail.gmail.com>
 <CAGETcx8b228nDUho3cX9AAQ-pXOfZTMv8cj2vhdx9yc_pk8q+A@mail.gmail.com>
 <YSioUM7/w4VefjKg@kroah.com>
 <CAGETcx_JpY2PHCbP8fEgfkeZeddhM13a6Q1gu5YNQNmB99ypYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_JpY2PHCbP8fEgfkeZeddhM13a6Q1gu5YNQNmB99ypYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 12:15:10PM -0700, Saravana Kannan wrote:
> On Fri, Aug 27, 2021 at 1:54 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 24, 2021 at 12:26:16PM -0700, Saravana Kannan wrote:
> > > On Mon, Mar 8, 2021 at 11:15 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Sun, Mar 7, 2021 at 11:28 PM Marek Szyprowski
> > > > <m.szyprowski@samsung.com> wrote:
> > > > >
> > > > > Hi Saravana,
> > > > >
> > > > > On 05.03.2021 19:02, Saravana Kannan wrote:
> > > > > > On Fri, Mar 5, 2021 at 3:45 AM Marek Szyprowski
> > > > > > <m.szyprowski@samsung.com> wrote:
> > > > > >> On 04.03.2021 20:51, Saravana Kannan wrote:
> > > > > >>> The uevents generated for an amba device need PID and CID information
> > > > > >>> that's available only when the amba device is powered on, clocked and
> > > > > >>> out of reset. So, if those resources aren't available, the information
> > > > > >>> can't be read to generate the uevents. To workaround this requirement,
> > > > > >>> if the resources weren't available, the device addition was deferred and
> > > > > >>> retried periodically.
> > > > > >>>
> > > > > >>> However, this deferred addition retry isn't based on resources becoming
> > > > > >>> available. Instead, it's retried every 5 seconds and causes arbitrary
> > > > > >>> probe delays for amba devices and their consumers.
> > > > > >>>
> > > > > >>> Also, maintaining a separate deferred-probe like mechanism is
> > > > > >>> maintenance headache.
> > > > > >>>
> > > > > >>> With this commit, instead of deferring the device addition, we simply
> > > > > >>> defer the generation of uevents for the device and probing of the device
> > > > > >>> (because drivers needs PID and CID to match) until the PID and CID
> > > > > >>> information can be read. This allows us to delete all the amba specific
> > > > > >>> deferring code and also avoid the arbitrary probing delays.
> > > > > >>>
> > > > > >>> Cc: Rob Herring <robh@kernel.org>
> > > > > >>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > > >>> Cc: John Stultz <john.stultz@linaro.org>
> > > > > >>> Cc: Saravana Kannan <saravanak@google.com>
> > > > > >>> Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > >>> Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > >>> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > > > > >>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > >>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > >>> Cc: Russell King <linux@armlinux.org.uk>
> > > > > >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > >>> ---
> > > > > >>>
> > > > > >>> v1 -> v2:
> > > > > >>> - Dropped RFC tag
> > > > > >>> - Complete rewrite to not use stub devices.
> > > > > >>> v2 -> v3:
> > > > > >>> - Flipped the if() condition for hard-coded periphids.
> > > > > >>> - Added a stub driver to handle the case where all amba drivers are
> > > > > >>>     modules loaded by uevents.
> > > > > >>> - Cc Marek after I realized I forgot to add him.
> > > > > >>>
> > > > > >>> Marek,
> > > > > >>>
> > > > > >>> Would you mind testing this? It looks okay with my limited testing.
> > > > > >> It looks it works fine on my test systems. I've checked current
> > > > > >> linux-next and this patch. You can add:
> > > > > >>
> > > > > >> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > > Hi Marek,
> > > > > >
> > > > > > Thanks! Does your test set up have amda drivers that are loaded based
> > > > > > on uevents? That's the one I couldn't test.
> > > > >
> > > > > I've checked both, the built-in and all amba drivers compiled as
> > > > > modules, loaded by udev. Both works fine here.
> > > > >
> > > > > >> I've briefly scanned the code and I'm curious how does it work. Does it
> > > > > >> depend on the recently introduced "fw_devlink=on" feature? I don't see
> > > > > >> other mechanism, which would trigger matching amba device if pm domains,
> > > > > >> clocks or resets were not available on time to read pid/cid while adding
> > > > > >> a device...
> > > > > > No, it does not depend on fw_devlink or device links in any way.
> > > > > >
> > > > > > When a device is attempted to be probed (when it's added or during
> > > > > > deferred probe), it's matched with all the drivers on the bus.
> > > > > > When a new driver is registered to a bus, all devices in that bus are
> > > > > > matched with the driver to see if they'll work together.
> > > > > > That's how match is called. And match() can return -EPROBE_DEFER and
> > > > > > that'll cause the device to be put in the deferred probe list by
> > > > > > driver core.
> > > > > >
> > > > > > The tricky part in this patch was the uevent handling and the
> > > > > > chicken-and-egg issue I talk about in the comments.
> > > > >
> > > > > Thanks for the explanation. This EPROBE_DEFER support in match()
> > > > > callback must be something added after I crafted that periodic retry
> > > > > based workaround.
> > > > >
> > > >
> > > > I think it got in just a few months before your patches, but your
> > > > patches worked :) I actually don't like match returning -EPROBE_DEFER,
> > > > but I can work around it for some of my fw_devlink optimization plans.
> > > >
> > > > More context here:
> > > > https://lore.kernel.org/lkml/CAGETcx_qO4vxTSyBtBR2k7fd_3rGJF42iBbJH37HPNw=FheDKg@mail.gmail.com/
> > >
> > > I just noticed that this still hasn't been picked up.
> > >
> > > Russell/Greg, can we please pick this up. This finally cleans up
> > > deferred probing of AMBA devices so that they don't have any special
> > > case.
> >
> > Now picked up, thanks.
> 
> This patch is apparently causing issues in a specific platform.
> https://lore.kernel.org/lkml/df8e7756-8b0d-d7de-a9ff-3f6eb0ffa8a5@huawei.com/
> 
> Even though it worked fine for Marek:
> https://lore.kernel.org/lkml/077fcc5b-cd09-d587-6906-d10bcc991eaf@samsung.com/#t
> 
> Here's my current analysis:
> https://lore.kernel.org/lkml/CAGETcx-N4+u0iw9n5ncx_9MNnTa3ViyesxsDD7xN3jtEPT-uBw@mail.gmail.com/
> 
> I'll leave it up to you on how to proceed -- revert or wait for another fix.

I've dropped it from my tree for now.  Let me know when you have
something that works better.

thanks,

greg k-h
