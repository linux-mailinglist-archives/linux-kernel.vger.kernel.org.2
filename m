Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBCE36EE13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhD2QYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbhD2QY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:24:28 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCEC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:23:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id f75-20020a9d03d10000b0290280def9ab76so56752451otf.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8kA1nA6ez8GVSpcYT5oYjc8axAEtsKpaYmy0o7ewtQ=;
        b=UemxAc3nBUhoStCY+5eaTBJdKaNUQuiJnDiJLkTnfwXM00EwLQoXe1kiBv9U81LRI3
         TV9h8nxmy+TEACZY7eDK3efcOgpl6ZRO/p5yQrq29yu55NjWtOpBcU2vkx+eK3qktRLC
         t7xtu0tp0aFGXnyAQqlw43DryH7aSlI9S6wjrXiiBd2yoBHS+SG3c4LQTmrcnJat6gVy
         QrcsOXHi+U4DT0w4sfmL/NVJqpOF5X6gehC+ZcoxeLbje4Q7n2ShtF9tBnjyrQc335al
         h14a2E5vGmzbMplyYl1O7fAFpaLMfXSsVVWiwrH7MA+wlqDmcynG2YYlzuMZhZHKuZfp
         pCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8kA1nA6ez8GVSpcYT5oYjc8axAEtsKpaYmy0o7ewtQ=;
        b=WQRSpN/nlqirdPaICFx6Id4NtX+tVst6UBB31hNw70EVLlXvOyrnHeFNN+OTyKsenG
         fLLFTycfys/qAn1nizOQVYcTmxzRn8ItAlEu6jMCuIKds0zGn/XESAREWafOTx4B0vkb
         4ul/8c8XH0IFENRHC0otfxb6BHm3aLbYenThGzKDOkrZYH3hwGcSFscJXIeTHFAnSPPq
         kMcq9gqforJr6cIG8w49zB5rsvPbhlGwfcTAg4pRfcg0lAW3j/cjDxsHhD5wibWAXqJv
         zUNVOBJwR0OUYCwTdAY4KQ3D1JNmrm5R5lkNBayjgWf9L0CyJL8f/CbfsBsi33HaKqag
         VZUg==
X-Gm-Message-State: AOAM532JexPCXx2fsQWKDcfahLm0YMd2VYCilud4eIy/aY8CD3G0FPbz
        wGi8NYW1T46j92YnmGJ2A1uo/xx2+jHzOUXDoe9h/TyPfxAGWg==
X-Google-Smtp-Source: ABdhPJxVwwWkxsw6FKByqMz8rfOcZyIFcq+eCWSSVPh4iq7muettmAZQdnhXaqnsF4dT0Etk89a1R2E7+whZMQeJ/OI=
X-Received: by 2002:a9d:6b0e:: with SMTP id g14mr181079otp.214.1619713418279;
 Thu, 29 Apr 2021 09:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210429155713.28808-1-michael@walle.cc> <20210429155713.28808-3-michael@walle.cc>
In-Reply-To: <20210429155713.28808-3-michael@walle.cc>
From:   Alexander Williams <awill@google.com>
Date:   Thu, 29 Apr 2021 09:23:26 -0700
Message-ID: <CACqsJN8mrHUB9Ls3PG5R_B84+xUjf-2VakA=09mP_bodWnUgmw@mail.gmail.com>
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

Hi Michael,

On Thu, Apr 29, 2021 at 8:57 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support to show the manufacturer, the partname and JEDEC identifier
> as well as to dump the SFDP table. Not all flashes list their SFDP table
> contents in their datasheet. So having that is useful. It might also be
> helpful in bug reports from users.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Pratyush, Heiko, I've dropped your Acked and Tested-by because there
> were some changes.
>
>  .../ABI/testing/sysfs-bus-spi-devices-spi-nor | 31 +++++++
>  drivers/mtd/spi-nor/Makefile                  |  2 +-
>  drivers/mtd/spi-nor/core.c                    |  1 +
>  drivers/mtd/spi-nor/core.h                    |  2 +
>  drivers/mtd/spi-nor/sysfs.c                   | 92 +++++++++++++++++++
>  5 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> new file mode 100644
> index 000000000000..4c88307759e2
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-spi-devices-spi-nor
> @@ -0,0 +1,31 @@
> +What:          /sys/bus/spi/devices/.../jedec_id
> +Date:          April 2021
> +KernelVersion: 5.14
> +Contact:       linux-mtd@lists.infradead.org
> +Description:   (RO) The JEDEC ID of the SPI NOR flash as reported by the
> +               flash device.
> +
> +
> +What:          /sys/bus/spi/devices/.../manufacturer
> +Date:          April 2021
> +KernelVersion: 5.14
> +Contact:       linux-mtd@lists.infradead.org
> +Description:   (RO) Manufacturer of the SPI NOR flash.
> +
> +
> +What:          /sys/bus/spi/devices/.../partname
> +Date:          April 2021
> +KernelVersion: 5.14
> +Contact:       linux-mtd@lists.infradead.org
> +Description:   (RO) Part name of the SPI NOR flash.
> +
> +
> +What:          /sys/bus/spi/devices/.../sfdp
> +Date:          April 2021
> +KernelVersion: 5.14
> +Contact:       linux-mtd@lists.infradead.org
> +Description:   (RO) This attribute is only present if the SPI NOR flash
> +               device supports the "Read SFDP" command (5Ah).
> +
> +               If present, it contains the complete SFDP (serial flash
> +               discoverable parameters) binary data of the flash.
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 136f245c91dc..6b904e439372 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -spi-nor-objs                   := core.o sfdp.o swp.o otp.o
> +spi-nor-objs                   := core.o sfdp.o swp.o otp.o sysfs.o
>  spi-nor-objs                   += atmel.o
>  spi-nor-objs                   += catalyst.o
>  spi-nor-objs                   += eon.o
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 20c7ee604731..57d8a4dae5fd 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3349,6 +3349,7 @@ static struct spi_mem_driver spi_nor_driver = {
>                 .driver = {
>                         .name = "spi-nor",
>                         .of_match_table = spi_nor_of_table,
> +                       .dev_groups = spi_nor_sysfs_groups,

Putting these in the driver's dev_groups does create a divergence between
different spi-nor controllers. For all the controllers supported in
drivers/mtd/spi-nor/controllers/, would their drivers need to add the same sysfs
groups to get the same support?

- Alex
