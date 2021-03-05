Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A46632E010
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 04:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhCEDZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 22:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEDZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 22:25:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D73FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 19:25:45 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 133so449453ybd.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 19:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ay5J86kgYWbdIWMdruKR+P2kKShrDefEb66DCFFN0wQ=;
        b=MRDBxpu1ZHSKCl7DmLcbOSZCSDYVcZO0KHqaJHPQX+7eYwU0mqajcELZqHq2/Bn7L7
         45CNx/x663c/tjPyi78wPVf7FBbigVfTPjEQXTnFHVxBdWRGTNKuwhv/+a8lid6lty90
         D15/wFb6icLsJ5FC4Q42VQq1WTBzCE2x8e50CFTZG7GXDGe5Rfca7kV0aDsLQFXjM8nI
         5SmFUTez/YRB5eD44mxdP6d/yTHCHz6rGjQ7REtjxoD38pf1dFZmJM6EuR7LIlKFWQL0
         Boet8NLso0d9RANdK7WwzzakoIPFUOOE0na7h7LD2kbve3YiZQpve4v1uaTSOR7SZIRe
         LSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ay5J86kgYWbdIWMdruKR+P2kKShrDefEb66DCFFN0wQ=;
        b=GjxvhUAzK0T75P9Ofp/Ic3ukj5klpUiLgkX5hBkksZBDHSCvVahjVpscSB5vqQZfOG
         V4Bkj5BkcZJAyDpLtZI/VWCSNTQfQI0+cV6FzWdY5F5eu9/NiY3DFoqGxIs3SOqOPS/f
         CLZft9lrDvvxMl4YwYwOMAy9tX//6wXc9sN2JXmySIgYSQPQrjU+TtSwNCj7mLqaLPEb
         Ke7JggN8EmzxxPHokLz2YgCHFmHNahvfFYg8JEkSuf0fyv3HyJYZfDna3MOdw5vwZNPp
         BqnWOHfvcsX5CPBI4w6DNeJolGokl6egY9tgv1b950lffbvqequDx2CZZ0rQiezmzPHb
         1ILg==
X-Gm-Message-State: AOAM530O+evHX8fUNUpzWm2WqVaESNee+zt3LAlSwjeQktWfBaaOj96T
        hmtJqAbUVSSdgcm2Z+dB+G242LXMw5nfjBgzKC1ZeA==
X-Google-Smtp-Source: ABdhPJye95kyOm6bVXDLiKp+DMuFYzAP5ryTHY7gwMfbopP2BYHfZPoEoxM/kuiQI4zRwQANtANd2KiXXvdCnZGX3Co=
X-Received: by 2002:a25:ca8f:: with SMTP id a137mr10830265ybg.228.1614914744122;
 Thu, 04 Mar 2021 19:25:44 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <b2dd44c2720fb96093fc4feeb64f0f4e@walle.cc> <CAGETcx_xCpid3QW0gQJWLL6ZfT-VJJq-SYX4tG09GRQWucw=qg@mail.gmail.com>
 <CAGETcx__oG2XrQ8RwZ57cVgV+Ukfni4qUQCe11kbL8E1U+4a_g@mail.gmail.com>
 <12f31a46e8dc3f0e53c1a7440a4ce087@walle.cc> <CAGETcx8hAX2iv3KakM+pXeBPu_RFsUFLBBZvwDVxG95mAY=woA@mail.gmail.com>
 <85f883921c73a9ac77b8263b958a5c71@walle.cc>
In-Reply-To: <85f883921c73a9ac77b8263b958a5c71@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Mar 2021 19:25:08 -0800
Message-ID: <CAGETcx9zkjgF=AjCkNcPKLriNk30PGugXKTNRhzTFm5cDQHm0A@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 2:21 AM Michael Walle <michael@walle.cc> wrote:
>
> Am 2021-03-03 10:28, schrieb Saravana Kannan:
> > On Wed, Mar 3, 2021 at 12:59 AM Michael Walle <michael@walle.cc> wrote:
> >>
> >> Am 2021-03-02 23:47, schrieb Saravana Kannan:
> >> > On Tue, Mar 2, 2021 at 2:42 PM Saravana Kannan <saravanak@google.com>
> >> > wrote:
> >> >>
> >> >> On Tue, Mar 2, 2021 at 2:24 PM Michael Walle <michael@walle.cc> wrote:
> >> >> >
> >> >> > Am 2021-03-02 22:11, schrieb Saravana Kannan:
> >> >> > > I think Patch 1 should fix [4] without [5]. Can you test the series
> >> >> > > please?
> >> >> >
> >> >> > Mh, I'm on latest linux-next (next-20210302) and I've applied patch 3/3
> >> >> > and
> >> >> > reverted commit 7007b745a508 ("PCI: layerscape: Convert to
> >> >> > builtin_platform_driver()"). I'd assumed that PCIe shouldn't be working,
> >> >> > right? But it is. Did I miss something?
> >> >>
> >> >> You need to revert [5].
> >> >
> >> > My bad. You did revert it. Ah... I wonder if it was due to
> >> > fw_devlink.strict that I added. To break PCI again, also set
> >> > fw_devlink.strict=1 in the kernel command line.
> >>
> >> Indeed, adding fw_devlink.strict=1 will break PCI again. But if
> >> I then apply 1/3 and 2/3 again, PCI is still broken. Just to be clear:
> >> I'm keeping the fw_devlink.strict=1 parameter.
> >
> > Thanks for your testing! I assume you are also setting fw_devlink=on?
>
> I've applied patch 3/3 and added nothing to the commandline, so yes.
>
> > Hmmm... ok. In the working case, does your PCI probe before IOMMU? If
> > yes, then your results make sense.
>
> Yes that was the conclusion last time. That the probe is deferred and
> the __init section is already discarded when there might a second
> try of the probe.

Long response below, but the TL;DR is:
The real fix for your case was the implementation of fw_devlink.strict
and NOT Patch 1 of this series. So, sorry for wasting your test
effort.

During the earlier debugging (for take I), this is what I thought:

With fw_devlink=permissive, your boot sequence was (Case 1):
1. IOMMU probe
2. PCI builtin_platform_driver_probe() attempt
    - Driver core sets up PCI with IOMMU
    - PCI probe succeeds.
    - PCI works with IOMMU. <---- Remember this point.

And with fw_devlink=on, I thought the IOMMU probe order was
unnecessarily changed and caused this (Case 2):
1. IOMMU probe reordered for some reason to be attempted before its
suppliers. Gets deferred.
2. PCI probe attempt
    - fw_devlink + device links defers the probe because IOMMU isn't ready.
    - builtin_platform_driver_probe() replaces drv->probe with
platform_probe_fail()
3. IOMMU deferred probe succeeds eventually.
4. PCI deferred probe is attempted
    - platform_probe_fail() which is a stub just returns -ENXIO

And if this was the case, patch 1 in this series would have fixed it
by removing unnecessary reordering of probes.

But what was really happening was (after I went through your logs
again and looked at the code):
With fw_devlink=permissive, your boot sequence was really (Case 3):
1. PCI builtin_platform_driver_probe() attempt
    - Driver core does NOT set up PCI with IOMMU
    - PCI probe succeeds.
    - PCI works without IOMMU. <---- Remember this point.
2. IOMMU probes

And with fw_devlink=on what was happening was (Case 4):
1. PCI builtin_platform_driver_probe() attempt
    - fw_devlink + device links defers the probe because it thinks
IOMMU is mandatory and isn't ready.
    - builtin_platform_driver_probe() replaces drv->probe with
platform_probe_fail()
2. IOMMU probes.
3. PCI deferred probe is attempted
    - platform_probe_fail() which is a stub just returns -ENXIO
4. PCI is broken now.

In your case IOMMU is not mandatory and PCI works without IOMMU even
when fw_devlink=off/permissive. So the real fix for your case is the
addition of fw_devlink.strict and defaulting it to 0. Because of my
misunderstanding of your case, I didn't realize I already fixed your
case and I thought Patch 1 in this series would fix your case.

Patch 1 in this series is still important for other reasons, just not for you.

> So I guess, Patch 1/3 and Patch 2/3 doesn't fix that and the drivers
> still need to be converted to builtin_platform_driver(), right?

So there is no real issue between fw_devlink=on and
builtin_platform_driver_probe() anymore. At least none that I know of
or has been reported.

If you really want your PCI to work _with_ IOMMU, then
builtin_platform_driver_probe() is wrong even with fw_devlink=off. And
if you wanted PCI to work with IOMMU support and fw_devlink wasn't
available, you'll have to play initcall chicken with the IOMMU driver
or implement some IOMMU check + deferred probing in your PCI probe
function.

However, with fw_devlink=on, all you have to do is set fw_devlink=on
and fw_devlink.strict=1 and use builtin_platform_driver() and not have
to care about initcall orders or figure out how to defer when IOMMU
isn't ready yet.

-Saravana
