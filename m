Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB68936EF0A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhD2RjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240999AbhD2RjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:39:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84CDC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:38:26 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id l17so35949066oil.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzmdyPVT6sF8v5IJxrF0ePBnI6iwiF+lddMno83ShcM=;
        b=h2MphwvCyxDj6JAzFv1sqfR7f2S7DjxL7DslZPuSUkInGLmoVHo+4sF9OqLaJY7PI/
         lLcbVYel4gRASRQJDGDVw5o0M4K6J5/8imPRIX5B11M/CwaJkzkCQ3Ms+y0EUqZYpCFR
         gtMyhVcaZFewikF0FoUawV5I4aZ6tk5YNiYHhDWwBzrGcZl/26fB/UMFkQnr0P6+5u9i
         4D3QKXvp3qXmbvoUhg9wsfH99sxU//gdu19oICCDKcJX6JX72PBk45YnirA5y3UNWN5I
         5Ne9QYOtB+UAp+gJdAqu5sg4PZOR/AKLHdy170FgTnjsICAeU8momD0fbgK+IfQA3+61
         941g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzmdyPVT6sF8v5IJxrF0ePBnI6iwiF+lddMno83ShcM=;
        b=LiKy0Dm0dJyP8jRSJco5MtqNdSUpIv2FlTmyxF9pwhw43xyYd81j3xfXtECLXjhACu
         Tncd+VVQf+0o+crXhbNoknQrmJDdmmnI1YH8T580kR5zLXveH7p4CbNR3CTcPmQ3u6bU
         jVRCGN+gUbnePv1sr99a08iRn+EnE9grktIZBBXNUOdHjDtlaUQMhqXou3AY5yxZbHKG
         qC++DcrB2yOe9uQyUoMmUkKTo0XMFZ0gbEqDfFxx9mnOtWDPXkuZFWrFQjlAxeTOSICG
         St8ItbzfvQRpwwfoMwMu2QJB5G7OWhWL1Xlm/JH0NI8PcKp6XOP/3NBgw7a0KUCRRjfs
         v5MA==
X-Gm-Message-State: AOAM533WOFzv23lzflrzynujc90xmr+1dyE/NQQ+6YebOryTuuu191dW
        yWT7evN3u8Kgey0uaSCpk6/p/zPTOxtS1bZ0XEh4Xw==
X-Google-Smtp-Source: ABdhPJw6pE5/BebvKhqFJnBOpU/gbbxqWhhs79qAZMJEcLTmylOvep5ffGlmZR/pcmieWSBqS89v/KWGGwr+pGHsCio=
X-Received: by 2002:aca:f0e:: with SMTP id 14mr7712111oip.16.1619717906062;
 Thu, 29 Apr 2021 10:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210429155713.28808-1-michael@walle.cc> <20210429155713.28808-3-michael@walle.cc>
 <CACqsJN8mrHUB9Ls3PG5R_B84+xUjf-2VakA=09mP_bodWnUgmw@mail.gmail.com> <04bc3eda0fa5a84ffff4b2f05721e2ac@walle.cc>
In-Reply-To: <04bc3eda0fa5a84ffff4b2f05721e2ac@walle.cc>
From:   Alexander Williams <awill@google.com>
Date:   Thu, 29 Apr 2021 10:38:14 -0700
Message-ID: <CACqsJN_TU08bzG5mZ5PgtYsJVVJHDdyUPB6yAO9CxpqTfby=-w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mtd: spi-nor: add initial sysfs support
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 9:44 AM Michael Walle <michael@walle.cc> wrote:
>
> Hi Alex,
>
> Am 2021-04-29 18:23, schrieb Alexander Williams:
> > On Thu, Apr 29, 2021 at 8:57 AM Michael Walle <michael@walle.cc> wrote:
> >>
> >> Add support to show the manufacturer, the partname and JEDEC
> >> identifier
> >> as well as to dump the SFDP table. Not all flashes list their SFDP
> >> table
> >> contents in their datasheet. So having that is useful. It might also
> >> be
> >> helpful in bug reports from users.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >> ---
> >> Pratyush, Heiko, I've dropped your Acked and Tested-by because there
> >> were some changes.
> >>
> >>  .../ABI/testing/sysfs-bus-spi-devices-spi-nor | 31 +++++++
> >>  drivers/mtd/spi-nor/Makefile                  |  2 +-
> >>  drivers/mtd/spi-nor/core.c                    |  1 +
> >>  drivers/mtd/spi-nor/core.h                    |  2 +
> >>  drivers/mtd/spi-nor/sysfs.c                   | 92
> >> +++++++++++++++++++
> >>  5 files changed, 127 insertions(+), 1 deletion(-)
> >>  create mode 100644
> >> Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> >>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> >> b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> >> new file mode 100644
> >> index 000000000000..4c88307759e2
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> >> @@ -0,0 +1,31 @@
> >> +What:          /sys/bus/spi/devices/.../jedec_id
> >> +Date:          April 2021
> >> +KernelVersion: 5.14
> >> +Contact:       linux-mtd@lists.infradead.org
> >> +Description:   (RO) The JEDEC ID of the SPI NOR flash as reported by
> >> the
> >> +               flash device.
> >> +
> >> +
> >> +What:          /sys/bus/spi/devices/.../manufacturer
> >> +Date:          April 2021
> >> +KernelVersion: 5.14
> >> +Contact:       linux-mtd@lists.infradead.org
> >> +Description:   (RO) Manufacturer of the SPI NOR flash.
> >> +
> >> +
> >> +What:          /sys/bus/spi/devices/.../partname
> >> +Date:          April 2021
> >> +KernelVersion: 5.14
> >> +Contact:       linux-mtd@lists.infradead.org
> >> +Description:   (RO) Part name of the SPI NOR flash.
> >> +
> >> +
> >> +What:          /sys/bus/spi/devices/.../sfdp
> >> +Date:          April 2021
> >> +KernelVersion: 5.14
> >> +Contact:       linux-mtd@lists.infradead.org
> >> +Description:   (RO) This attribute is only present if the SPI NOR
> >> flash
> >> +               device supports the "Read SFDP" command (5Ah).
> >> +
> >> +               If present, it contains the complete SFDP (serial
> >> flash
> >> +               discoverable parameters) binary data of the flash.
> >> diff --git a/drivers/mtd/spi-nor/Makefile
> >> b/drivers/mtd/spi-nor/Makefile
> >> index 136f245c91dc..6b904e439372 100644
> >> --- a/drivers/mtd/spi-nor/Makefile
> >> +++ b/drivers/mtd/spi-nor/Makefile
> >> @@ -1,6 +1,6 @@
> >>  # SPDX-License-Identifier: GPL-2.0
> >>
> >> -spi-nor-objs                   := core.o sfdp.o swp.o otp.o
> >> +spi-nor-objs                   := core.o sfdp.o swp.o otp.o sysfs.o
> >>  spi-nor-objs                   += atmel.o
> >>  spi-nor-objs                   += catalyst.o
> >>  spi-nor-objs                   += eon.o
> >> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> >> index 20c7ee604731..57d8a4dae5fd 100644
> >> --- a/drivers/mtd/spi-nor/core.c
> >> +++ b/drivers/mtd/spi-nor/core.c
> >> @@ -3349,6 +3349,7 @@ static struct spi_mem_driver spi_nor_driver = {
> >>                 .driver = {
> >>                         .name = "spi-nor",
> >>                         .of_match_table = spi_nor_of_table,
> >> +                       .dev_groups = spi_nor_sysfs_groups,
> >
> > Putting these in the driver's dev_groups does create a divergence
> > between
> > different spi-nor controllers. For all the controllers supported in
> > drivers/mtd/spi-nor/controllers/, would their drivers need to add the
> > same sysfs
> > groups to get the same support?
>
> Well, one supports it and one does not, no? If support is added later,
> we should keep an eye on it. Unfortunately, I don't have any hardware
> to see if just adding the .dev_groups to another driver will just work.

Right, I didn't mean to indicate opposition. Since mtd/spi-nor has certainly
got its set of quirky controllers and drivers (e.g. intel-spi does not support
reading the sfdp in its driver, currently), it might make sense to make these
attributes dependent on the driver. This mechanism also makes the attributes
available at KOBJ_BIND time, so spi_nor_scan() will have run, getting rid of
a pesky race condition with user space.

This comment was just to point out the implications and make sure you and
maintainers are okay with that approach.

- Alex
