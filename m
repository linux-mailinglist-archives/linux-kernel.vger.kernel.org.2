Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA7435B593
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 16:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235556AbhDKOFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 10:05:35 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:12603 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhDKOFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 10:05:33 -0400
Date:   Sun, 11 Apr 2021 14:05:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1618149915;
        bh=O557wZuOyutkhxm660QDAP3vInKWKsr1zK3DiKxgzvM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=VU8RmlnGNDL9W4WNoI00O6ldYu/tpBzPi7yZwEAY0rbNi+bb3gyZNdXshS0rk7Ft2
         rTFAedhg6ZDENScaQJTd9/cv2L0RYrdWVaPZRdbTL5YRbfFSxoawhDI8scpmW/C/Yh
         ecwpHHAktZd0VltqoGvJLEmT9+a/0PZZFapf/1cc=
To:     =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v4] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <TbKK4TuRhSBhlwBiK7ukHwt6r_NQeiHDAJc6rMAubISp3_isxu_iNOzcQ8VkJkGGrYQiVmQNwRV1vRUUxUB73Y1ddbXJLbN4qi5K1yKYsiA=@protonmail.com>
In-Reply-To: <20210410181856.144988-1-linux@weissschuh.net>
References: <6a096978-67ad-6def-6ed0-9ad38a460e95@redhat.com> <20210410181856.144988-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


2021. =C3=A1prilis 10., szombat 20:18 keltez=C3=A9ssel, Thomas Wei=C3=9Fsch=
uh =C3=ADrta:

> [...]
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/g=
igabyte-wmi.c
> new file mode 100644
> index 000000000000..c17e51fcf000
> --- /dev/null
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (C) 2021 Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define GIGABYTE_WMI_GUID=09"DEADBEEF-2001-0000-00A0-C90629100000"
> +#define NUM_TEMPERATURE_SENSORS=096
> +
> +static bool force_load;
> +module_param(force_load, bool, 0444);
> +MODULE_PARM_DESC(force_load, "Force loading on unknown platform");
> +
> +static u8 usable_sensors_mask;
> +
> +enum gigabyte_wmi_commandtype {
> +=09GIGABYTE_WMI_BUILD_DATE_QUERY       =3D   0x1,
> +=09GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =3D   0x2,
> +=09GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =3D   0x4,
> +=09GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =3D   0x5,
> +=09GIGABYTE_WMI_TEMPERATURE_QUERY      =3D 0x125,
> +};
> +
> +struct gigabyte_wmi_args {
> +=09u32 arg1;
> +};
> +
> +static int gigabyte_wmi_perform_query(struct wmi_device *wdev,
> +=09=09=09=09      enum gigabyte_wmi_commandtype command,
> +=09=09=09=09      struct gigabyte_wmi_args *args, struct acpi_buffer *ou=
t)
> +{
> +=09const struct acpi_buffer in =3D {
> +=09=09.length =3D sizeof(*args),
> +=09=09.pointer =3D args,
> +=09};
> +
> +=09acpi_status ret =3D wmidev_evaluate_method(wdev, 0x0, command, &in, o=
ut);
> +
> +=09if ACPI_FAILURE(ret)

Please use `if (...)`.


> +=09=09return -EIO;
> +
> +=09return 0;
> +}
> [...]
> +static struct wmi_driver gigabyte_wmi_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D "gigabyte-wmi",
> +=09},
> +=09.id_table =3D gigabyte_wmi_id_table,
> +=09.probe =3D gigabyte_wmi_probe,
> +};
> +module_wmi_driver(gigabyte_wmi_driver);
> +
> +MODULE_DEVICE_TABLE(wmi, gigabyte_wmi_id_table);
> +MODULE_AUTHOR("Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>");
> +MODULE_DESCRIPTION("Gigabyte WMI temperature Driver");
                                                ^
It's a minor thing, but I think a lowercase 'd' would be better.


> +MODULE_LICENSE("GPL");
>
> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> --
> 2.31.1


Regards,
Barnab=C3=A1s P=C5=91cze
