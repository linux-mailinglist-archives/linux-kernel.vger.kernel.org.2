Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0F3FF1F4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbhIBQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346545AbhIBQ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:58:51 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03160C06179A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:57:53 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v26so5108747ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CdoDsPx4iZ3TYUBbTyYxIiN1dx31m8cBOT+Ft8CmZg=;
        b=rLceyf8D0TrrwOWDocXtLORSpkXNOrPp19+SVh/W9DnhzcB0sVabWKqLehGnRXQR24
         GbDFm2wVJLpjWDjLd6Kx7X48yzGknBT94TiXlqyDZMSzHDeHMBzfRCZtHAty/xUpOgcq
         1Vb1df0K+NqGdjpmCHewWPlGfYO9QvN4Oozs6sJXQUSiJ6ocSKoSkVcb6YV1EmRu0y2l
         kyeyTHX48FR7OMMXB7XD2BnUtMDCT0pTsdgeqgcfM0rW0JU3J5QtcumgH10ifmfFmuwU
         U4GflpcIPuuGNqA3mD1IozdGsJqkRQ+qganoPYEfIGNFlBUQ66IWGqxQs5aGqtY2M6xr
         uaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CdoDsPx4iZ3TYUBbTyYxIiN1dx31m8cBOT+Ft8CmZg=;
        b=rvv4nlMGN2a39J1Fzn/d6O+DczKtkEIjKomDiEbdxvG1vIbVsoQ847nwaaDMIGKAQY
         Y9Lub5PK4Ji2HOhmmgnvih70hplO7hpyGVHSMURQcgDwZPZSsV52ADTmxvhfiLQf/Ekq
         YCgcYV5NvatmVtgbDQYgM6E+hsCDUkZfHFFjfdR7tN/khq9IU9piea1C2lWl3c1wO1VB
         agwDkOg6K1pZxFtXarEZpEv4kqDpYhdKMEl2fLpFlE9HDX7L5ulqfrCHVP7eWwjCD0/i
         3O5ggWLbUGl6lX0o0NAo109WMwTBWUoCwIeeFwd4Hr9CXnprvvxSMEhLVohEQjBzFj6p
         nDPg==
X-Gm-Message-State: AOAM5332OK0MLh05LUe8d4fpleZtPNswn4X+O4IkTVupdNdM1B8CCLUg
        EkyF54G5T2UZj5KDCUoa8ttDgSBQj54EO5LulYw+7g==
X-Google-Smtp-Source: ABdhPJyUB3nxok2NTKDn/g8+SXd4RmBib0Bt4hhmNlzH6hQptjNBzGzivM76xyWw6wPbcBIZt9BCUsZhKaEsG7ahXdI=
X-Received: by 2002:a25:d2c8:: with SMTP id j191mr5833153ybg.412.1630601871177;
 Thu, 02 Sep 2021 09:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <20210902025528.1017391-3-saravanak@google.com> <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 09:57:15 -0700
Message-ID: <CAGETcx-rOakAX_apu2ecu6jWCwzO0RgMkwdfzyF+UaxQfVj4CA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 7:24 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Sep 1, 2021 at 9:55 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > We don't want fw_devlink creating device links for bus devices as
> > they'll never probe. So mark those device node with this flag.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/platform.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > index 74afbb7a4f5e..42b3936d204a 100644
> > --- a/drivers/of/platform.c
> > +++ b/drivers/of/platform.c
> > @@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
> >         if (!dev || !of_match_node(matches, bus))
> >                 return 0;
> >
> > +       /*
> > +        * If the bus node has only one compatible string value and it has
> > +        * matched as a bus node, it's never going to get probed by a device
> > +        * driver. So flag it as such so that fw_devlink knows not to create
> > +        * device links with this device.
> > +        *
> > +        * This doesn't catch all devices that'll never probe, but this is good
> > +        * enough for now.
> > +        *
> > +        * This doesn't really work for PPC because of how it uses
> > +        * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
> > +        */
> > +       if (!IS_ENABLED(CONFIG_PPC) &&
> > +           of_property_count_strings(bus, "compatible") == 1)
> > +               bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
>
> This looks fragile relying on 1 compatible string, and the DT flags in
> this code have been fragile too. I'm pretty sure we have cases of
> simple-bus or simple-mfd that also have another compatible.
>
> Couldn't we solve this with a simple driver?

Oh, I didn't think you'd like that. I'd lean towards that option too
if we can address some of the other concerns below.

> Make 'simple-pm-bus'
> driver work for other cases?

> BTW, this patch doesn't even work for
> simple-pm-bus.

How do you mean? Because simple-pm-bus already has a driver and
doesn't set "matches" param when it calls of_platform_populate() and
this flag won't be set. So at least for simple-pm-bus I don't see any
issue.

I was trying to reuse of_default_bus_match_table without explicitly
referring to it, but if it's confusing I can add a separate list of
compatible strings and use those here instead of using "matches".

> A driver for simple-bus may cause issues if there's a
> more specific driver to bind to as we don't handle that. It's simply
> whichever matches first.

Right, this is my worry. Especially for devices like this (there are
plenty of cases like this) which have a driver that probes them but
also lists simple-bus
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/arm-realview-pb11mp.dts?id=73f3af7b4611d77bdaea303fb639333eb28e37d7#n299

So as long as there's a compatible string that's not one of the
"transparent" busses, this driver shouldn't match. So, I don't think I
can get away from checking the compatible strings.

How about I check here to make sure all the "compatible" strings are
from an approved transparent bus list, and if it's true, I use
driver_override to force match it to a transparent bus driver? Would
you be okay with that?

-Saravana
