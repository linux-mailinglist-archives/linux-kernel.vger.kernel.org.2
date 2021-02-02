Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7282030CBC7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbhBBTfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbhBBTeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:34:19 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90213C061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 11:33:38 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e132so1758556ybh.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 11:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19pezVk0QoKOTRujKHqImvij052toB7i96dgscsU07M=;
        b=AT5LlNEvnLfOQ+A4/wCpwc6dScKxQeYCUOVjf28Wgpsa2K0+c9Lt6tJVPPIOtZsIgb
         NvQKME92Kl+8ssx0f4Ft77lAzFSRKYTy4Tng87EKiyceIYV+Z7E1xIF2n9fP7St+DcYr
         hcyDAYOv/IpqcsdbUVf43OnycLNgPW21seBjAG/HDGBxRCU705M4BnCi5ATszhIpIl/W
         OMS5M9zpkZazcbXzBFwS8nxQl9AgN2jFP8e/Wfzfy6i6AovtVsXMuO3JEmdfzz+3NjOx
         8+B3Dpy9Y4LneaNOV0KWctkw729KKuRZ7j8MTiU3UacwAW5BjlIetetoEbajazGqoDLm
         UUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19pezVk0QoKOTRujKHqImvij052toB7i96dgscsU07M=;
        b=qwzDH2isktF8JmrtdlTMOIqmEgnRaveuXRUc+I0gL3rs+yC9GYbwHj8JLPL6KcRYMB
         fcmjrLPqAnsYKnOMpoCQndkq21zpv5+xi2fkTz+JT9fj+QVMPKCNAWQL1NAoTzKkVocI
         UCEgqHO7+UMivXEaAlIwcVcvbHLmx6kcA3+L7oYxm5sT93vTZzvtX6hG9VuRkUB4Klxz
         NB6lKL8KF4+x5kwbeHtLBut6r7+5/TDm5xuuvz1I7BOQp54t7bTwHn2cgzAIT8kKJvnh
         BFYUE5dvkMqkqPMe8nO+MRl5GqPuoPxualseBndYBf5JX7J5YOGDVG0uDu/+cuUs7+AZ
         09FA==
X-Gm-Message-State: AOAM530cTATF2XiwpeGEEQrl+inMv7oTOTsIJxn9vcgIX9eCi+Br39Sr
        kbWEOg4dtvIR9MMwbDgcxXQPINGPuCwkL13Qegx/Ww==
X-Google-Smtp-Source: ABdhPJyw3Pgdkhhb7YZGafFhRDXuoH71B0vAi7/f94ad8ZeujXQFx4KeQPkkkKEGyRqMSh/5u8zEil3vUUc0B5/0To8=
X-Received: by 2002:a25:f8a:: with SMTP id 132mr34946575ybp.228.1612294417635;
 Tue, 02 Feb 2021 11:33:37 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
 <20210130040344.2807439-3-saravanak@google.com> <CAMuHMdVWJZrGDvtMiyaAOfnZP5jBJec42oQvYeZSgt9ZLhqDvA@mail.gmail.com>
 <CAGETcx8KYGHkSdgjxJ55_gdAP7wh_CykKuXq_qXBfFdtsQ4Jsg@mail.gmail.com> <CAMuHMdXft=pJXXqY-i_GQTr8FtFJePQ_drVHRMPAFUqSy4aNKA@mail.gmail.com>
In-Reply-To: <CAMuHMdXft=pJXXqY-i_GQTr8FtFJePQ_drVHRMPAFUqSy4aNKA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Feb 2021 11:33:01 -0800
Message-ID: <CAGETcx-LrUMNxqMNm52XcgqFj2oUuzG8bXUq-hT4bKycSTPrUg@mail.gmail.com>
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
        Android Kernel Team <kernel-team@android.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 12:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Mon, Feb 1, 2021 at 9:49 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Mon, Feb 1, 2021 at 2:32 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sat, Jan 30, 2021 at 5:03 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > After a deferred probe attempt has exhaused all the devices that can be
> > > > bound, any device that remains unbound has one/both of these conditions
> > > > true:
> > > >
> > > > (1) It is waiting on its supplier to bind
> > > > (2) It does not have a matching driver
> > > >
> > > > So, to make fw_devlink=on more forgiving of missing drivers for optional
> > > > suppliers, after we've done a full deferred probe attempt, this patch
> > > > deletes all device links created by fw_devlink where the supplier hasn't
> > > > probed yet and the supplier itself is not waiting on any of its
> > > > suppliers. This allows consumers to probe during another deferred probe
> > > > attempt if they were waiting on optional suppliers.
> > > >
> > > > When modules are enabled, we can't differentiate between a driver
> > > > that'll never be registered vs a driver that'll be registered soon by
> > > > loading a module. So, this patch doesn't do anything for the case where
> > > > modules are enabled.
> > >
> > > For the modular case, can't you do a probe regardless? Or limit it
> > > to devices where the missing provider is a DMAC or IOMMU driver?
> > > Many drivers can handle missing DMAC controller drivers, and are even
> > > supposed to work that way.  They may even retry obtaining DMA releases
> > > later.
> >
> > I don't want to handle this at a property/provider-type level. It'll
> > be a whack-a-mole that'll never end -- there'll be some driver that
> > would work without some resource. Letting it probe is not difficult (I
> > just need to drop these device links), but the problem is that a lot
> > of drivers are not written properly to be able to handle getting
> > deferred and then getting reattempted before the supplier. Either
> > because:
> >
> > 1. They were never built and tested as a module
> > 2. The supplier gets deferred and the consumer doesn't have proper
> > deferred probe implementation and when we drop the device links, the
> > consumer might be attempted before the supplier and things go bad.
>
> You may be a bit too pessimistic here: we had deferred probing for
> years.  With devices with complex dependencies, it's not uncommon for a
> driver to be probed 3 or 4 times, before it succeeds (and FTR, would be
> happy to see this fixed).  So most drivers should handle this already.
> And if they don't, they're already broken.

I fully agree the drivers are broken and they should be fixed (like
we've been doing so far). I'd happily say "fix your driver" and just
mark properties (iommu, dmas) as "optional" and be done with it.
Actually, handling optional properties is pretty simple -- we just
need to stop parsing them (delete code/make it a flag).

But my understanding is, you can't set fw_devlink=on by default and
break devices that used to boot fine before. But we can't find the
broken drivers without setting fw_devlink=on by default. So it's a
catch-22. I'm happy to continue helping debug the issues if we are
okay with leaving fw_devlink=on in 5.12, but I'm not sure everyone
will agree to that.

Also, there's also no way to selectively enable fw_devlink on a
DT/board level (Rob will have to agree to a property in the chosen {}
node). So, without that, I'm forced to go for the lowest common
denominator.

>
> > One hack I'm thinking of is that with CONFIG_MODULES, I can drop these
> > unmet device links after a N-second timeout, but having the timeout
> > extended everytime a new driver is registered. So as long as no two
> > modules are loaded further than N seconds apart during boot up, it
> > would all just work out fine. But it doesn't solve the problem fully
> > either. But maybe it'll be good enough? I haven't analyzed this fully
> > yet -- so apologies in advance if it's stupid.
>
> So you would introduce an additional delay when e.g. mounting the root
> file system, as the SDHI driver probe may be postponed due to the DMAC
> driver not being available?

Honestly I'm thinking of deleting/adding a conditional for iommu/dma
parsing. So boards that know all iommus/dmas are needed can set some
flag if they want.

In your example, if the DMAC driver is needed for SDHI to work (mount
root), then I'd expect it to be loaded(ramdisk)/builtin before mount
root. And it'd just work. If the DMA is optional and SDHI should have
mounted root without it, then the solution is what I said above.

> Let's consider the possible combinations here:
>   1. If both provider and consumer are built-in, there's no issue.
>   2. If the provider is built-in, and the consumer is modular, it should
>      just work, too.
>   3. If the consumer is built-in, but the provider is modular (or not
>      available), what to do?
>      Wouldn't it be safe to assume the user did intend the consumer to
>      probe without the provider, and thus continue, if possible (e.g.
>      for an optional DMA channel)?  Else the user would have configured
>      the provider driver built-in, too.
>   4. If both provider and consumer are modular, perhaps userspace should
>      try to load the modules in the right order, i.e. provider drivers
>      first?

One of the main benefits/goal of fw_devlink is that it makes module
load ordering irrelevant. There are other correctness issues with
depending on module load ordering too. So I don't want to go down the
(fix your module load order) route.

>
> For DMACs, it's the consumer that knows if it can work without the DMAC
> driver present, and fall back to PIO, or not.  So we could add a flag
> for that to struct driver.

The whole point of fw_devlink is to figure stuff out without the
drivers being available (sync_state() is a whole another layer of
complexity). If the drivers come into picture, we don't really need
fw_devlink to parse dmas. The dma framework code can add device links
once a consumer starts using the dma (similar to how iommus do it).

> For IOMMUs, it's different: the consumer drivers are not aware of it,
> only the driver/IOMMU subsystem is.  And whether to work in the absence
> of an IOMMU driver is more like a system (security) policy decision.

I think some consumers can make this decision too. For example, not
supporting DRM content if the IOMMU isn't available, etc.

Long story short, I don't have a problem with saying fix the driver.
But I don't  think I can have fw_devlink=on by default with that
argument. And making it fw_devlink=on by default is my goal.

-Saravana
