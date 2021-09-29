Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279A041C9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbhI2QKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344611AbhI2QKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:10:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8329F615A7;
        Wed, 29 Sep 2021 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632931742;
        bh=dijA/w5Ov8JsJ92OsBZBg2039bqDhk6Rb6AyNDbPn44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F/l734se74TwmNKqonr45ks6Q850RYvThvXxxdhTyJf3RZw1rzmHm3f7Rq9l4TUbH
         fCysjvBQWOc0oroYUgIl8V24IheYEjz/xul/maQHbKIuA3dZbOEHR2gT16yODw6rm1
         zPYdjJjh+cZ/tQsX2hXR4jU27EPuJG0V8gOdWwXEZ6enjVntGut2AW04aaIAv5b1sU
         rEZ2oJjqzcqpRmnxCPLNc7xqE3BifgIvrvORJApCCs674vkO5pDWID5V24/iPO7OWm
         /X5UYk8JAvcdEZojKGLgFtk+TI+8C06JdmyrCjjdItiybmC3AKcCoVNIoSE7EJKq2l
         4IZZ5MbZW1gkw==
Received: by mail-ed1-f41.google.com with SMTP id bd28so10484450edb.9;
        Wed, 29 Sep 2021 09:09:02 -0700 (PDT)
X-Gm-Message-State: AOAM533VDs/brX/1UDJ0JEbcn63icQo4cgetb+gUo5rQGcJ2Zcb8YfxR
        +RxXsVTEeWD4bEWTRHky/uE1ozeKjLJu+o/Liw==
X-Google-Smtp-Source: ABdhPJzrMbYO0rSYnqgmEqL2Di5ODf2KFSFLA0nJG3BUUjFxO4DRvWKc4rYXRSAUryn3020YRQn63vQqdkNzIXSPDII=
X-Received: by 2002:a17:906:7250:: with SMTP id n16mr562242ejk.147.1632931694940;
 Wed, 29 Sep 2021 09:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210929115409.21254-1-zev@bewilderbeest.net>
In-Reply-To: <20210929115409.21254-1-zev@bewilderbeest.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 29 Sep 2021 11:08:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ@mail.gmail.com>
Message-ID: <CAL_JsqJH+b5oFuSP+KBLBsN5QTA6xASuqXJWXUaDkHhugXPpnQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Dynamic aspeed-smc flash chips via "reserved" DT status
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 6:54 AM Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hello,
>
> This patch series aims to improve a scenario that arises in OpenBMC
> and which isn't handled very well at the moment.  Certain devices, the
> example at hand being the flash chip used to store the host's firmware
> (e.g. the BIOS), may be shared between the BMC and the host system but
> only available to one or the other at any given time.  The device may
> thus be effectively off-limits to the BMC when it boots, and only
> usable after userspace performs the necessary steps to coordinate
> appropriately with the host (tracking its power state, twiddling
> GPIOs, sending IPMI commands, etc.).
>
> Neither the "okay" nor the "disabled" device-tree status values works
> nicely for the flash device this case -- an "okay" device gets probed
> automatically as soon as the device and a driver for it are available,
> and a "disabled" one gets forgotten about entirely, whereas we want
> the BMC's kernel to be aware of the existence of the device, but not
> try to actually do anything with it (i.e. probe it) until explicitly
> requested to do so by userspace.

While Linux treats 'disabled' as gone forever, that's not exactly what
the spec says. Either disabled or reserved could change in theory. But
I do agree 'reserved' is the right choice for your use.

> However, while there's no support for it currently in the kernel tree,
> the device-tree spec [0] also lists "reserved" as a possible status
> value, and its description seems like a fairly reasonable fit for this
> situation:
>
>   Indicates that the device is operational, but should not be used.
>   Typically this is used for devices that are controlled by another
>   software component, such as platform firmware.
>
> These patches start making use of this status value in the aspeed-smc
> driver.  The first patch adds a companion routine to
> of_device_is_available() that checks for a "reserved" status instead
> of "okay".  The second patch is a small MTD adjustment to allow an
> unregistered device to be cleanly re-registered.  Patches 3 through 5
> modify the aspeed-smc driver to allow individual chips to be attached
> and detached at runtime, and to avoid automatically attaching any
> marked as reserved.  Finally, patch 6 employs the newly-supported
> status in adding support for the BIOS flash device to the ASRock Rack
> e3c246d4i BMC.

I'm not sure this should be MTD specific. There's other cases where we
may want devices to become available. So the question is whether there
should be a more generic mechanism rather than each subsystem coming
up with their own thing.

There's out of tree support for applying overlays which could be used
here. The issue with it is we don't want it to be unconstrained where
an overlay can make any change anywhere in a DT.

Another possibility is making 'status' writeable from userspace. It is
just a sysfs file. That too may need to be opt-in.

Rob
