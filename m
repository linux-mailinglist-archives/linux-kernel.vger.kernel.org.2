Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CE34686C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 20:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhCWTEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 15:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbhCWTEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 15:04:36 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:04:35 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id u10so19119329ilb.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o99hGRoYvVR79FDdobQlJcPIWJf5+SkiNU6VLZRrYBM=;
        b=HYR7+dKJHgKZBTMux3CFxX3E+EcCQPurYR2skbb9VgeSLu9X0ek3/amHJQWaPS8K7U
         2dK6dt4s5MD7JoWyJYj8TvigUwIsb7kqsWEbquUwR1rul+n0H6UtD+CVZKFvtRFlAooI
         oxt4zX6fNO3EG4EElil3Ts01ghPWbi6emZ4iSqOUG99Dq4qeJ8xb0F2bRlRXlENCnQXS
         /UBk7ho0Njn6GBjZqDQhDPT+xwbcGr9Yci6j7cPi4AtRhk7FXqPBE75E1Uwpbllbv+v5
         /8/ui2jey3HRhJvWXq7zloNSnlSDkIhvLPz5KB8NOtwSA5JEL6sGCVIMwuE/Devsl3kJ
         tAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o99hGRoYvVR79FDdobQlJcPIWJf5+SkiNU6VLZRrYBM=;
        b=qdi5Fv9EXe4gefPfuiXTwzqGJ+oBfbR+26ia8joQawUio27X4Q+rmsBw+dd1iaVZqq
         Kc04XPsl0qYqfAXoooMp4OxbyXdffXczJXOPGGQTO3wGarTOJuXFgoORIcuecwm87sjO
         c3tx87RuQ6mGvdazV2OmnwtLVfW00fuCyqcCJ/pW1QpX0+wE3nzZw5DEjUMip0KNmUuH
         xU9BbQQnSgDAnlmNc9/UfgZebPIC3QDHO7g7mgWQcS5S4ZGrqI9tqrtNtzu2RpTE1xz3
         AkzoL5IuPQiwMqh2Ct2MNO/Q8YQIHmbpwEmLe4EGQvAmHNIUy8xlyviPOwRWf699vlmd
         SuXg==
X-Gm-Message-State: AOAM533aXJ4ZApbutOgxEaNsG1FIWaRPnALu/ZLlwHJ+WeFHJ/Vd4xIZ
        8ZcrRwKVrbgdTRMQ6P4qh0GuTlP3sF/dLD2kNQh/o3lt53z8ijkZ
X-Google-Smtp-Source: ABdhPJxYNLxwRIYqv8/zeV+uJu4WVhxWW0by+i/Ac7OSmaMfdj4MMsLkMzkN5YlROZxvRidsK9kXiQ0XoENPfPyYd2E=
X-Received: by 2002:a05:6e02:148b:: with SMTP id n11mr6277042ilk.6.1616526275211;
 Tue, 23 Mar 2021 12:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210323143144.12730-1-michael@walle.cc> <20210323143144.12730-3-michael@walle.cc>
In-Reply-To: <20210323143144.12730-3-michael@walle.cc>
From:   Heiko Thiery <heiko.thiery@gmail.com>
Date:   Tue, 23 Mar 2021 20:04:24 +0100
Message-ID: <CAEyMn7YsEK_HawpQKMJMn_pqAmC3Qied1PUE5J0yS48VLyYkig@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: add initial sysfs support
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Di., 23. M=C3=A4rz 2021 um 15:34 Uhr schrieb Michael Walle <michael@wall=
e.cc>:
>
> Add support to show the name and JEDEC identifier as well as to dump the
> SFDP table. Not all flashes list their SFDP table contents in their
> datasheet. So having that is useful. It might also be helpful in bug
> reports from users.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Tested-by: Heiko Thiery <heiko.thiery@gmail.com>

> ---
>  drivers/mtd/spi-nor/Makefile |  2 +-
>  drivers/mtd/spi-nor/core.c   |  5 +++
>  drivers/mtd/spi-nor/core.h   |  3 ++
>  drivers/mtd/spi-nor/sysfs.c  | 86 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 95 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/spi-nor/sysfs.c
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 653923896205..aff308f75987 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -spi-nor-objs                   :=3D core.o sfdp.o
> +spi-nor-objs                   :=3D core.o sfdp.o sysfs.o
>  spi-nor-objs                   +=3D atmel.o
>  spi-nor-objs                   +=3D catalyst.o
>  spi-nor-objs                   +=3D eon.o
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index fbc34158a883..02523ddac612 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3708,6 +3708,10 @@ static int spi_nor_probe(struct spi_mem *spimem)
>         if (ret)
>                 return ret;
>
> +       ret =3D spi_nor_sysfs_create(nor);
> +       if (ret)
> +               return ret;
> +
>         return mtd_device_register(&nor->mtd, data ? data->parts : NULL,
>                                    data ? data->nr_parts : 0);
>  }
> @@ -3717,6 +3721,7 @@ static int spi_nor_remove(struct spi_mem *spimem)
>         struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
>
>         spi_nor_restore(nor);
> +       spi_nor_sysfs_remove(nor);
>
>         /* Clean up MTD stuff. */
>         return mtd_device_unregister(&nor->mtd);
> diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> index 08d2469837da..599035200a03 100644
> --- a/drivers/mtd/spi-nor/core.h
> +++ b/drivers/mtd/spi-nor/core.h
> @@ -486,4 +486,7 @@ static struct spi_nor __maybe_unused *mtd_to_spi_nor(=
struct mtd_info *mtd)
>         return mtd->priv;
>  }
>
> +int spi_nor_sysfs_create(struct spi_nor *nor);
> +void spi_nor_sysfs_remove(struct spi_nor *nor);
> +
>  #endif /* __LINUX_MTD_SPI_NOR_INTERNAL_H */
> diff --git a/drivers/mtd/spi-nor/sysfs.c b/drivers/mtd/spi-nor/sysfs.c
> new file mode 100644
> index 000000000000..c62cc4d6bce6
> --- /dev/null
> +++ b/drivers/mtd/spi-nor/sysfs.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mtd/spi-nor.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +#include <linux/sysfs.h>
> +
> +#include "core.h"
> +
> +static ssize_t name_show(struct device *dev,
> +                        struct device_attribute *attr, char *buf)
> +{
> +       struct spi_device *spi =3D to_spi_device(dev);
> +       struct spi_mem *spimem =3D spi_get_drvdata(spi);
> +       struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> +
> +       return sysfs_emit(buf, "%s\n", nor->info->name);
> +}
> +static DEVICE_ATTR_RO(name);
> +
> +static ssize_t jedec_id_show(struct device *dev,
> +                            struct device_attribute *attr, char *buf)
> +{
> +       struct spi_device *spi =3D to_spi_device(dev);
> +       struct spi_mem *spimem =3D spi_get_drvdata(spi);
> +       struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> +
> +       return sysfs_emit(buf, "%*phN\n", nor->info->id_len, nor->info->i=
d);
> +}
> +static DEVICE_ATTR_RO(jedec_id);
> +
> +static struct attribute *spi_nor_sysfs_entries[] =3D {
> +       &dev_attr_name.attr,
> +       &dev_attr_jedec_id.attr,
> +       NULL
> +};
> +
> +static ssize_t sfdp_read(struct file *filp, struct kobject *kobj,
> +                        struct bin_attribute *bin_attr, char *buf,
> +                        loff_t off, size_t count)
> +{
> +       struct spi_device *spi =3D to_spi_device(kobj_to_dev(kobj));
> +       struct spi_mem *spimem =3D spi_get_drvdata(spi);
> +       struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> +       struct sfdp *sfdp =3D nor->sfdp;
> +       size_t sfdp_size =3D sfdp->num_dwords * sizeof(*sfdp->dwords);
> +
> +       return memory_read_from_buffer(buf, count, &off, nor->sfdp->dword=
s,
> +                                      sfdp_size);
> +}
> +static BIN_ATTR_RO(sfdp, 0);
> +
> +static struct bin_attribute *spi_nor_sysfs_bin_entries[] =3D {
> +       &bin_attr_sfdp,
> +       NULL
> +};
> +
> +static umode_t spi_nor_sysfs_is_bin_visible(struct kobject *kobj,
> +                                           struct bin_attribute *attr, i=
nt n)
> +{
> +       struct spi_device *spi =3D to_spi_device(kobj_to_dev(kobj));
> +       struct spi_mem *spimem =3D spi_get_drvdata(spi);
> +       struct spi_nor *nor =3D spi_mem_get_drvdata(spimem);
> +
> +       if (attr =3D=3D &bin_attr_sfdp && !nor->sfdp)
> +               return 0;
> +
> +       return 0444;
> +}
> +
> +static struct attribute_group spi_nor_sysfs_attr_group =3D {
> +       .name           =3D NULL,
> +       .is_bin_visible =3D spi_nor_sysfs_is_bin_visible,
> +       .attrs          =3D spi_nor_sysfs_entries,
> +       .bin_attrs      =3D spi_nor_sysfs_bin_entries,
> +};
> +
> +int spi_nor_sysfs_create(struct spi_nor *nor)
> +{
> +       return sysfs_create_group(&nor->dev->kobj, &spi_nor_sysfs_attr_gr=
oup);
> +}
> +
> +void spi_nor_sysfs_remove(struct spi_nor *nor)
> +{
> +       sysfs_remove_group(&nor->dev->kobj, &spi_nor_sysfs_attr_group);
> +}
> --
> 2.20.1
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

Thank you!
