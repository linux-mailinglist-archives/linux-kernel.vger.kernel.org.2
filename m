Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692E130BA4B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhBBIuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:50:37 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39549 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhBBIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:50:05 -0500
Received: by mail-oi1-f180.google.com with SMTP id w124so21957889oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:49:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2X1791o3tepawwAHUZzWOxIBj8ziwa6OFbhVOgbKr2Q=;
        b=n8gylYfEnBTdHqpbWl/5kgZwU3mck6TeoLXjhUZPBA9Q10vpDyqaiKhTRujyrM4y0n
         vyIqRB+wsibjwAMNJEQG9sng3dMJ1frOncQfRC7+UsC7b7dd7jOYreQSkL2eTYSbfcKu
         HRGK/Y9b19w39RxDIPFzXjMtbdC/JuFXM8E9PkxhuhmJxxrZ/PgOtD1jfpZ8Pr+2JZkg
         2s76O+0LtaVVKU62yih5L6/N4pph2n8hHFqKqfZx6Tn98jG1awtcWyugCXmvK//b7p3v
         bITWr4auCCqtqmMuqxYSZBvcqLafWDepggnBfBC8xjpUp0sF5z4X27ARWiHw53Sk/MrS
         +n8Q==
X-Gm-Message-State: AOAM533U89QT+pXqBZBYmT+NxKnNdhDvNEcl/rfVKiaCtRf+AOnz6dB/
        CkEiQpcqi3XUGlO206Jyzka+ulPTPj689KX1sINYIn1ZsAU=
X-Google-Smtp-Source: ABdhPJykgdegxex+ewpT6HdxPeoK66Eeb1qlhiNfilnwH/mlMY9GyOrNJcZHr0t9gp9wSI2Kh5Mz7aMliw/hC+u1wEM=
X-Received: by 2002:aca:1219:: with SMTP id 25mr2040548ois.54.1612255764523;
 Tue, 02 Feb 2021 00:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
 <20210130040344.2807439-3-saravanak@google.com> <CAMuHMdVWJZrGDvtMiyaAOfnZP5jBJec42oQvYeZSgt9ZLhqDvA@mail.gmail.com>
 <CAGETcx8KYGHkSdgjxJ55_gdAP7wh_CykKuXq_qXBfFdtsQ4Jsg@mail.gmail.com>
In-Reply-To: <CAGETcx8KYGHkSdgjxJ55_gdAP7wh_CykKuXq_qXBfFdtsQ4Jsg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 2 Feb 2021 09:49:13 +0100
Message-ID: <CAMuHMdXft=pJXXqY-i_GQTr8FtFJePQ_drVHRMPAFUqSy4aNKA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] driver core: fw_devlink: Handle missing drivers
 for optional suppliers
To:     Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Mon, Feb 1, 2021 at 9:49 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 1, 2021 at 2:32 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sat, Jan 30, 2021 at 5:03 AM Saravana Kannan <saravanak@google.com> wrote:
> > > After a deferred probe attempt has exhaused all the devices that can be
> > > bound, any device that remains unbound has one/both of these conditions
> > > true:
> > >
> > > (1) It is waiting on its supplier to bind
> > > (2) It does not have a matching driver
> > >
> > > So, to make fw_devlink=on more forgiving of missing drivers for optional
> > > suppliers, after we've done a full deferred probe attempt, this patch
> > > deletes all device links created by fw_devlink where the supplier hasn't
> > > probed yet and the supplier itself is not waiting on any of its
> > > suppliers. This allows consumers to probe during another deferred probe
> > > attempt if they were waiting on optional suppliers.
> > >
> > > When modules are enabled, we can't differentiate between a driver
> > > that'll never be registered vs a driver that'll be registered soon by
> > > loading a module. So, this patch doesn't do anything for the case where
> > > modules are enabled.
> >
> > For the modular case, can't you do a probe regardless? Or limit it
> > to devices where the missing provider is a DMAC or IOMMU driver?
> > Many drivers can handle missing DMAC controller drivers, and are even
> > supposed to work that way.  They may even retry obtaining DMA releases
> > later.
>
> I don't want to handle this at a property/provider-type level. It'll
> be a whack-a-mole that'll never end -- there'll be some driver that
> would work without some resource. Letting it probe is not difficult (I
> just need to drop these device links), but the problem is that a lot
> of drivers are not written properly to be able to handle getting
> deferred and then getting reattempted before the supplier. Either
> because:
>
> 1. They were never built and tested as a module
> 2. The supplier gets deferred and the consumer doesn't have proper
> deferred probe implementation and when we drop the device links, the
> consumer might be attempted before the supplier and things go bad.

You may be a bit too pessimistic here: we had deferred probing for
years.  With devices with complex dependencies, it's not uncommon for a
driver to be probed 3 or 4 times, before it succeeds (and FTR, would be
happy to see this fixed).  So most drivers should handle this already.
And if they don't, they're already broken.

> One hack I'm thinking of is that with CONFIG_MODULES, I can drop these
> unmet device links after a N-second timeout, but having the timeout
> extended everytime a new driver is registered. So as long as no two
> modules are loaded further than N seconds apart during boot up, it
> would all just work out fine. But it doesn't solve the problem fully
> either. But maybe it'll be good enough? I haven't analyzed this fully
> yet -- so apologies in advance if it's stupid.

So you would introduce an additional delay when e.g. mounting the root
file system, as the SDHI driver probe may be postponed due to the DMAC
driver not being available?

Let's consider the possible combinations here:
  1. If both provider and consumer are built-in, there's no issue.
  2. If the provider is built-in, and the consumer is modular, it should
     just work, too.
  3. If the consumer is built-in, but the provider is modular (or not
     available), what to do?
     Wouldn't it be safe to assume the user did intend the consumer to
     probe without the provider, and thus continue, if possible (e.g.
     for an optional DMA channel)?  Else the user would have configured
     the provider driver built-in, too.
  4. If both provider and consumer are modular, perhaps userspace should
     try to load the modules in the right order, i.e. provider drivers
     first?

For DMACs, it's the consumer that knows if it can work without the DMAC
driver present, and fall back to PIO, or not.  So we could add a flag
for that to struct driver.
For IOMMUs, it's different: the consumer drivers are not aware of it,
only the driver/IOMMU subsystem is.  And whether to work in the absence
of an IOMMU driver is more like a system (security) policy decision.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
