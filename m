Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879BF357448
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 20:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355289AbhDGS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 14:28:03 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:47240 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355247AbhDGS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 14:28:02 -0400
Date:   Wed, 07 Apr 2021 18:27:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1617820070;
        bh=Jk0xI9tlvfC+MCDNtP4LJv7vGZLfrd+LYFVei0pI8Xc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=l5Il6UPVPe6INlITp75jEL9aoix4z+UmtR6FXZKfsVBl1ijmqAuDqNrzzfE/3HX3u
         m9fulOB1oBbJORDaCIsUVc3zNhNTKrWLfnPI3ioix1WUJMAh+IFTWqao4gJJc66XJ7
         2jn4Eglb7qlALjgNkSelaAJayfsRadMsDCEWnOvY=
To:     =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <eAi-yoXOCIOZAGOkYXGYZrUI6OuRrL5Fn9xBzHI1tJSgURTkMRifhlz9OHPB5FUxYLLzMARFmIP0HHR5oPgQMS0LJkga6deoVol0MYQuceA=@protonmail.com>
In-Reply-To: <20210405204810.339763-1-linux@weissschuh.net>
References: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com> <20210405204810.339763-1-linux@weissschuh.net>
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


2021. =C3=A1prilis 5., h=C3=A9tf=C5=91 22:48 keltez=C3=A9ssel, Thomas Wei=
=C3=9Fschuh =C3=ADrta:

> Changes since v1:
> * Incorporate feedback from Barnab=C3=A1s P=C5=91cze
>   * Use a WMI driver instead of a platform driver
>   * Let the kernel manage the driver lifecycle
>   * Fix errno/ACPI error confusion
>   * Fix resource cleanup
>   * Document reason for integer casting
>
> Thank you Barnab=C3=A1s for your review, it is much appreciated.
>
> -- >8 --
>
> Tested with a X570 I Aorus Pro Wifi.
> The mainboard contains an ITE IT8688E chip for management.
> This chips is also handled by drivers/hwmon/i87.c but as it is also used
> by the firmware itself it needs an ACPI driver.

I gather this means you're getting the

  ACPI Warning: SystemIO range ... conflicts with ...
  ACPI: If an ACPI driver is available for this device, you should use it i=
nstead of the native driver

warning?


>
> Unfortunately not all sensor registers are handled by the firmware and ev=
en
> less are exposed via WMI.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/platform/x86/Kconfig        |  11 +++
>  drivers/platform/x86/Makefile       |   1 +
>  drivers/platform/x86/gigabyte-wmi.c | 138 ++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/platform/x86/gigabyte-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ad4e630e73e2..96622a2106f7 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -123,6 +123,17 @@ config XIAOMI_WMI
>  =09  To compile this driver as a module, choose M here: the module will
>  =09  be called xiaomi-wmi.
>
> +config GIGABYTE_WMI
> +=09tristate "Gigabyte WMI temperature driver"
> +=09depends on ACPI_WMI
> +=09depends on HWMON
> +=09help
> +=09  Say Y here if you want to support WMI-based temperature reporting o=
n
> +=09  Gigabyte mainboards.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called gigabyte-wmi.
> +
>  config ACERHDF
>  =09tristate "Acer Aspire One temperature and fan driver"
>  =09depends on ACPI && THERMAL
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 60d554073749..1621ebfd04fd 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_INTEL_WMI_THUNDERBOLT)=09+=3D intel-wmi-th=
underbolt.o
>  obj-$(CONFIG_MXM_WMI)=09=09=09+=3D mxm-wmi.o
>  obj-$(CONFIG_PEAQ_WMI)=09=09=09+=3D peaq-wmi.o
>  obj-$(CONFIG_XIAOMI_WMI)=09=09+=3D xiaomi-wmi.o
> +obj-$(CONFIG_GIGABYTE_WMI)=09=09+=3D gigabyte-wmi.o
>
>  # Acer
>  obj-$(CONFIG_ACERHDF)=09=09+=3D acerhdf.o
> diff --git a/drivers/platform/x86/gigabyte-wmi.c b/drivers/platform/x86/g=
igabyte-wmi.c
> new file mode 100644
> index 000000000000..8618363e3ccf
> --- /dev/null
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *  Copyright (C) 2021 Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/hwmon.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
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
> +static int gigabyte_wmi_perform_query(enum gigabyte_wmi_commandtype comm=
and,
> +=09=09struct gigabyte_wmi_args *args, struct acpi_buffer *out)
> +{
> +=09const struct acpi_buffer in =3D {
> +=09=09.length =3D sizeof(*args),
> +=09=09.pointer =3D args,
> +=09};
> +
> +=09acpi_status ret =3D wmi_evaluate_method(GIGABYTE_WMI_GUID, 0x0, comma=
nd, &in, out);

Ideally, you'd use the WMI device that was passed to the probe method to do=
 the query
using `wmidev_evaluate_method()`. You can pass the WMI device pointer
to `devm_hwmon_device_register_with_info()` in the `drvdata` argument,
then in the ->read() callback you can retrieve it:

  static int gigabyte_wmi_hwmon_read(struct device *dev, ...)
  {
    struct wmi_device *wdev =3D dev_get_drvdata(dev);

and then you can pass that to the other functions.


> +=09if (ret =3D=3D AE_OK) {
> +=09=09return 0;
> +=09} else {
> +=09=09return -EIO;
> +=09};

The `;` is not needed. And please use `ACPI_FAILURE()` or `ACPI_SUCCESS()`
to check the returned value. For example:

  acpi_status ret =3D ...;
  if (ACPI_FAILURE(ret))
    return -EIO;

  return 0;


> +}
> +
> +static int gigabyte_wmi_query_integer(enum gigabyte_wmi_commandtype comm=
and,
> +=09=09struct gigabyte_wmi_args *args, u64 *res)
> +{
> +=09union acpi_object *obj;
> +=09struct acpi_buffer result =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09int ret;
> +
> +=09ret =3D gigabyte_wmi_perform_query(command, args, &result);
> +=09if (ret) {
> +=09=09goto out;

I believe if this branch is taken, no buffer is allocated (due to the failu=
re),
so you can just `return ret;` here and do away with the goto completely - i=
f I'm not mistaken.


> +=09}
> +=09obj =3D result.pointer;
> +=09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +=09=09*res =3D obj->integer.value;
> +=09=09ret =3D 0;
> +=09} else {
> +=09=09ret =3D -EIO;
> +=09}
> +out:
> +=09kfree(result.pointer);
> +=09return ret;
> +}
> +
> +static int gigabyte_wmi_temperature(u8 sensor, long *res)
> +{
> +=09struct gigabyte_wmi_args args =3D {
> +=09=09.arg1 =3D sensor,
> +=09};
> +=09u64 temp;
> +=09acpi_status ret;
> +
> +=09ret =3D gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, &a=
rgs, &temp);
> +=09if (ret =3D=3D 0)
> +=09=09*res =3D (s8) temp * 1000; // value is a signed 8-bit integer
> +=09return ret;
> +}
> +
> +static int gigabyte_wmi_hwmon_read(struct device *dev, enum hwmon_sensor=
_types type,
> +=09=09u32 attr, int channel, long *val)
> +{
> +=09return gigabyte_wmi_temperature(channel, val);
> +}
> +
> +static umode_t gigabyte_wmi_hwmon_is_visible(const void *data, enum hwmo=
n_sensor_types type,
> +=09=09u32 attr, int channel)
> +{
> +=09return 0444;
> +}
> +
> +static const struct hwmon_channel_info *gigabyte_wmi_hwmon_info[] =3D {
> +=09HWMON_CHANNEL_INFO(temp,
> +=09=09=09HWMON_T_INPUT,
> +=09=09=09HWMON_T_INPUT,
> +=09=09=09HWMON_T_INPUT,
> +=09=09=09HWMON_T_INPUT,
> +=09=09=09HWMON_T_INPUT,
> +=09=09=09HWMON_T_INPUT),
> +=09NULL,
            ^
Minor thing: usually commas after sentinel values are omitted.


> +};
> +
> +static const struct hwmon_ops gigabyte_wmi_hwmon_ops =3D {
> +=09.read =3D gigabyte_wmi_hwmon_read,
> +=09.is_visible =3D gigabyte_wmi_hwmon_is_visible,
> +};
> +
> +static const struct hwmon_chip_info gigabyte_wmi_hwmon_chip_info =3D {
> +=09.ops =3D &gigabyte_wmi_hwmon_ops,
> +=09.info =3D gigabyte_wmi_hwmon_info,
> +};
> +
> +static int gigabyte_wmi_probe(struct wmi_device *wdev, const void *conte=
xt)
> +{
> +=09struct device *hwmon_dev =3D devm_hwmon_device_register_with_info(&wd=
ev->dev,
> +=09=09=09"gigabyte_wmi", NULL,
> +=09=09=09&gigabyte_wmi_hwmon_chip_info, NULL);
> +
> +=09return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct wmi_device_id gigabyte_wmi_id_table[] =3D {
> +=09{ GIGABYTE_WMI_GUID, NULL },
> +=09{ },
           ^
Same here.


> +};
> +
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
> +MODULE_DESCRIPTION("Gigabyte Temperature WMI Driver");

It's a very minor thing, but could you please
synchronize this description with the Kconfig?


> +MODULE_LICENSE("GPL");
>
> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> --
> 2.31.1


Regards,
Barnab=C3=A1s P=C5=91cze
