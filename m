Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69407425CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhJGUFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 16:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhJGUFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 16:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 328D8610CC;
        Thu,  7 Oct 2021 20:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633637036;
        bh=tQrT1H6vAX9nQCz4/UDBS/7Ka8j9BQl8nLNXbURKSDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nml8N5qqjVN6g8w0QWjm28r40muERJvTDBtJlVP//mHm4s0tHUFPuxt57uMWKSCEQ
         yMH4MD9jY75zoV+M+Q71r/nRh0VUlXT1gmXy0wsBUG5BVjlWlb+Vy6iZvIKP0c8yWU
         rV8rKO/kskkzqUqKzNPluHfavLiBrTtaKK3CLm9BR1bgX5d2RDNl81xjt+R0fwf6sZ
         cHw6kcBLirU68a4v8+HKgirdWl4e+HhtVjlIzQjucZu73aGzjf/djJ0w5amLvEaqwN
         414d2CXmVLxr5XLDm5AGVPJfUvoEPcmduqXkSi2hdncHKLfXUcIBp6R6dtLtrz1e7S
         mcpMSf7yuR4sA==
Received: by mail-ed1-f53.google.com with SMTP id d3so128345edp.3;
        Thu, 07 Oct 2021 13:03:56 -0700 (PDT)
X-Gm-Message-State: AOAM531Jn2/OA5hN6sd+cpkpUASigNTttcZzIhJD+RLj+aIWUFHsZMrO
        sJRw9a+uSfAEMO1LJmZ/QHIQgReb6MyvCE0Jqw==
X-Google-Smtp-Source: ABdhPJy8X406aFLvUmYkMkdUnIEqcALE1K/+nEQVAeFie0M4tlomNRuuYu3oyJV5PQ2EW4dv9srP6exyuQeR2iodti4=
X-Received: by 2002:a17:907:7d8b:: with SMTP id oz11mr8581991ejc.84.1633637034696;
 Thu, 07 Oct 2021 13:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211007000954.30621-1-zev@bewilderbeest.net> <CAHp75VdYBB_FaMr-uKswdvDBdobTYZkiE6ncoALuG+YYVoMwyw@mail.gmail.com>
 <YV64ZbcsHvBObH2j@hatter.bewilderbeest.net> <YV7Miz9RMMx/17A0@kroah.com> <YV8VGeMreR6NJad4@hatter.bewilderbeest.net>
In-Reply-To: <YV8VGeMreR6NJad4@hatter.bewilderbeest.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 7 Oct 2021 15:03:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
Message-ID: <CAL_JsqLk-CqKVgWp3=XccHrCdQgdGoezB6=HAXMDe1Q5R4-0HA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Dynamic DT device nodes
To:     Zev Weiss <zev@bewilderbeest.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Axtens <dja@axtens.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 10:41 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> On Thu, Oct 07, 2021 at 03:31:39AM PDT, Greg Kroah-Hartman wrote:
> >On Thu, Oct 07, 2021 at 02:05:41AM -0700, Zev Weiss wrote:
> >> On Thu, Oct 07, 2021 at 12:04:41AM PDT, Andy Shevchenko wrote:
> >> > On Thu, Oct 7, 2021 at 3:10 AM Zev Weiss <zev@bewilderbeest.net> wrote:
> >> > > This patch series is in some ways kind of a v2 for the "Dynamic
> >> > > aspeed-smc flash chips via 'reserved' DT status" series I posted
> >> > > previously [0], but takes a fairly different approach suggested by Rob
> >> > > Herring [1] and doesn't actually touch the aspeed-smc driver or
> >> > > anything in the MTD subsystem, so I haven't marked it as such.
> >> > >
> >> > > To recap a bit of the context from that series, in OpenBMC there's a
> >> > > need for certain devices (described by device-tree nodes) to be able
> >> > > to be attached and detached at runtime (for example the SPI flash for
> >> > > the host's firmware, which is shared between the BMC and the host but
> >> > > can only be accessed by one or the other at a time).
> >> >
> >> > This seems quite dangerous. Why do you need that?
> >>
> >> Sometimes the host needs access to the flash (it's the host's firmware,
> >> after all), sometimes the BMC needs access to it (e.g. to perform an
> >> out-of-band update to the host's firmware).  To achieve the latter, the
> >> flash needs to be attached to the BMC, but that requires some careful
> >> coordination with the host to arbitrate which one actually has access to it
> >> (that coordination is handled by userspace, which then tells the kernel
> >> explicitly when the flash should be attached and detached).
> >>
> >> What seems dangerous?
> >>
> >> > Why can't device tree overlays be used?
> >>
> >> I'm hoping to stay closer to mainline.  The OpenBMC kernel has a documented
> >> policy strongly encouraging upstream-first development:
> >> https://github.com/openbmc/docs/blob/master/kernel-development.md
> >>
> >> I doubt Joel (the OpenBMC kernel maintainer) would be eager to start
> >> carrying the DT overlay patches; I'd likewise strongly prefer to avoid
> >> carrying them myself as additional downstream patches.  Hence the attempt at
> >> getting a solution to the problem upstream.
> >
> >Then why not work to get device tree overlays to be merged properly?

TBC, it's 'just' the general purpose userspace interface to apply
overlays that's missing.

I did suggest what's done here as overlays are kind of an overkill for
this usecase. Much easier to write to a sysfs file than write an
overlay, compile it with dtc, and provide it to the kernel all just to
enable a device.

Perhaps this could also be supported in the driver model directly.
Given the "what about ACPI question", that is probably what should be
done unless the answer is we don't care. I think we'd just need a flag
to create devices, but not bind automatically. Or maybe abusing
driver_override can accomplish that.

> >Don't work on a half-of-a-solution when the real solution is already
> >here.
> >
>
> I had been under the impression that the overlay patches had very dim
> prospects of ever being accepted and that this might be a more tractable
> alternative, but apparently was mistaken -- I'll look into what the
> outstanding issues were with that and perhaps take a stab at addressing
> them.

What's dim is the patches allowing any modification to any part of the
DT. Any changes to a DT need to work (i.e. have some effect). For
example, randomly changing/adding/removing properties wouldn't have
any effect because they've probably already be read and used.

What I've suggested before is some sort of registration of nodes
allowed to apply child nodes and properties to. That would serve the
add-on board usecases which have been the main driver of this to date.
That also got hung up on defining interface nodes to add-on boards.
Your scope is more limited and can be limited to that scope while
using the same configfs interface.

Rob
