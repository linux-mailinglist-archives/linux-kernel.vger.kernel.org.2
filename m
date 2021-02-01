Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776F130B1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBAUtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 15:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhBAUtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 15:49:40 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0CBC061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 12:49:00 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i71so4712593ybg.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 12:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JNW21lR2R+YyWCMWh0lJTjefxlo7cRO01En7hjDMgNc=;
        b=u1UXL9AjqeH8m2JBUfnFhpU5Db/XfsrTwp8rjv7D0By+TcLlxJ/uptc59Q3FxPE1Ub
         Bss1gKFrFI6a0zSR5rjpZF84tAVXvHTcaC5R9+EeuRpAkAWqwOAgAmUfoZLLe92jCTBl
         nEAzMc5Z8olMmgiEwy2ShYN+AGHvQ9pt8EpIb0L8M/Rohx97LXecy/7jnuVPTkeTKsub
         WFRFPIUTjuMl2YiQPFFuRy99H6riRnE5rcqk1S+o9nqc+btbGNG80O9IAnMVyPZrG5i9
         EMPJcsjhzj/IPGjZmp81sqFKmbMLA/4CCQmPXw1qiXGnMy5unayv6STSraieXiBXjCmD
         yW1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JNW21lR2R+YyWCMWh0lJTjefxlo7cRO01En7hjDMgNc=;
        b=Km5jlICxxGqnC0Z7J7Eqr/kyqKqx60P7/LgtkOc6nEiZX/HX9my0UnBQ/FvOEU2FZR
         sgvEoaCvIFugnKS+Ss06v7MPUn+cM2iCFbIL95mTV6HkK+KRGh8gxg3lHyuW/l59Humw
         l90MtFukqCvpSGopC3HJhvbErvXc64fzf2L0vYHRZBsycsiwLZFM3SJ1QcO58HmjIbC2
         KmIEKHjItVCqiWp5RxeL+ll9kppKVI2BpRH6OZQYUtsFkvpgjXaMbLEM7x/D6BTzfPWj
         x5ph4FMe98UXGBmL5smIFVMef7pQf2gFHyMIqMIjS9Zg/7Y4P6k/8ZQLtE6s5VcpUVr7
         IYcQ==
X-Gm-Message-State: AOAM530ijqxTUz9EJZ3CguFDjy3pHzQyCwURB749fqFYEpABtpwxmf32
        2niE12apoOWvYW5NuvJXwiFxBYl97E9CYTb92BrIcA==
X-Google-Smtp-Source: ABdhPJzOz0NvQtmaO25zRRp0VLpVvczqldHxJ1yNi7nJR5iLEN4/+wiz9xyKvSbin1MWCFJ4YjjfBmffX1F4DS7QRFE=
X-Received: by 2002:a25:3345:: with SMTP id z66mr27785968ybz.466.1612212539488;
 Mon, 01 Feb 2021 12:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
 <20210130040344.2807439-3-saravanak@google.com> <CAMuHMdVWJZrGDvtMiyaAOfnZP5jBJec42oQvYeZSgt9ZLhqDvA@mail.gmail.com>
In-Reply-To: <CAMuHMdVWJZrGDvtMiyaAOfnZP5jBJec42oQvYeZSgt9ZLhqDvA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Feb 2021 12:48:23 -0800
Message-ID: <CAGETcx8KYGHkSdgjxJ55_gdAP7wh_CykKuXq_qXBfFdtsQ4Jsg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] driver core: fw_devlink: Handle missing drivers
 for optional suppliers
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 2:32 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Sat, Jan 30, 2021 at 5:03 AM Saravana Kannan <saravanak@google.com> wrote:
> > After a deferred probe attempt has exhaused all the devices that can be
> > bound, any device that remains unbound has one/both of these conditions
> > true:
> >
> > (1) It is waiting on its supplier to bind
> > (2) It does not have a matching driver
> >
> > So, to make fw_devlink=on more forgiving of missing drivers for optional
> > suppliers, after we've done a full deferred probe attempt, this patch
> > deletes all device links created by fw_devlink where the supplier hasn't
> > probed yet and the supplier itself is not waiting on any of its
> > suppliers. This allows consumers to probe during another deferred probe
> > attempt if they were waiting on optional suppliers.
> >
> > When modules are enabled, we can't differentiate between a driver
> > that'll never be registered vs a driver that'll be registered soon by
> > loading a module. So, this patch doesn't do anything for the case where
> > modules are enabled.
>
> For the modular case, can't you do a probe regardless? Or limit it
> to devices where the missing provider is a DMAC or IOMMU driver?
> Many drivers can handle missing DMAC controller drivers, and are even
> supposed to work that way.  They may even retry obtaining DMA releases
> later.

I don't want to handle this at a property/provider-type level. It'll
be a whack-a-mole that'll never end -- there'll be some driver that
would work without some resource. Letting it probe is not difficult (I
just need to drop these device links), but the problem is that a lot
of drivers are not written properly to be able to handle getting
deferred and then getting reattempted before the supplier. Either
because:

1. They were never built and tested as a module
2. The supplier gets deferred and the consumer doesn't have proper
deferred probe implementation and when we drop the device links, the
consumer might be attempted before the supplier and things go bad.

One hack I'm thinking of is that with CONFIG_MODULES, I can drop these
unmet device links after a N-second timeout, but having the timeout
extended everytime a new driver is registered. So as long as no two
modules are loaded further than N seconds apart during boot up, it
would all just work out fine. But it doesn't solve the problem fully
either. But maybe it'll be good enough? I haven't analyzed this fully
yet -- so apologies in advance if it's stupid.

-Saravana
