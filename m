Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE30E3545DE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbhDEROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:14:02 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:11030 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhDEROA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:14:00 -0400
Date:   Mon, 05 Apr 2021 17:13:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1617642831;
        bh=d0cPIyf07x8JEfdBgHPUUrzKxwY8wZu2hn0c7EYuUy4=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Gtv987Z59TduJbytHfpoM5PbOpzkJA2B5SqariJj7KmboFZD0wLHMcNKyd0+X8/7/
         XcLMA5I5dTK9nRX4GMGE0xbEieu39XBBtA1wbQe60Dha4g4w8znuwwc/zEjF5lFET+
         /0XsyWyd55H4s8OMPsb5Hm395qTh9A84MMIQQtCM=
To:     =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] platform/x86: add Gigabyte WMI temperature driver
Message-ID: <N6sOrC__lJeA1mtEKUtB18DPy9hp5bSjL9rq1TfOXiRE7IAO5aih5oyPEpq-vyqdZZsF4W8FIe-9GWB15lO-3fQlqjWQrMTlTJvqLBBGYOQ=@protonmail.com>
In-Reply-To: <20210405132007.290275-1-linux@weissschuh.net>
References: <20210405132007.290275-1-linux@weissschuh.net>
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


If you wanted to get some feedback regarding the code, then I added some co=
mments;
otherwise please disregard this email.

I think the two most important things are:

 * consider using `devm_hwmon_device_register_with_info()` instead of manua=
lly
   specifying the attributes;
 * consider getting rid of the platform {driver,device} and use a single
   WMI driver.


2021. =C3=A1prilis 5., h=C3=A9tf=C5=91 15:20 keltez=C3=A9ssel, Thomas Wei=
=C3=9Fschuh =C3=ADrta:

> Hi,
>
> this patch adds support for temperature readings on Gigabyte Mainboards.
> (At least on mine)
>
> The current code should be usable as is.
> I'd like for people to test it though and report their results with diffe=
rent
> hardware.
>
> Further development I have some general questions:
>
> The ASL IndexField does not cover all relevant registers, can it be exten=
ded by
> driver code?
>
> * Not all registers are exposed via ACPI methods, can they be accessed vi=
a ACPI directly?
> * Some registers are exposed via ACPI methods but are not reachable direc=
tly from the WMI dispatcher.
>   * Does ASL have some sort of reflection that could enable those methods=
?
>   * Is it possible to call those methods directly, bypassing WMI?
>
> I suspect the answer to be "no" for all of these, but maybe I am wrong.
>
> Furthermore there are WMI methods to return information about the install=
ed
> firmware.
>
> * Version
> * Build-date
> * Motherboard name
>
> Would it make sense to add this information as attributes to the
> platform_device?

I think if there aren't really users of the data, then just printing them
to the kernel message buffer is fine until there's a need
(in the probe function, for example). Does it provide information
that DMI doesn't?


>
> The ACPI tables can be found here:
> https://github.com/t-8ch/linux-gigabyte-wmi-driver/blob/main/ssdt8.dsl
>
> Thanks,
> Thomas
>
> -- >8 --
>
> Tested with a X570 I Aorus Pro Wifi.
> The mainboard contains a ITE IT8688E chip for management.
> This chips is also handled by drivers/hwmon/i87.c but as it is also used
> by the firmware itself it needs an ACPI driver.
>
> Unfortunately not all sensor registers are handled by the firmware and ev=
en
> less are exposed via WMI.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  drivers/platform/x86/Kconfig        |  10 ++
>  drivers/platform/x86/Makefile       |   1 +
>  drivers/platform/x86/gigabyte-wmi.c | 178 ++++++++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 drivers/platform/x86/gigabyte-wmi.c
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index ad4e630e73e2..40d593ff1f01 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -123,6 +123,16 @@ config XIAOMI_WMI
>  =09  To compile this driver as a module, choose M here: the module will
>  =09  be called xiaomi-wmi.
>
> +config GIGABYTE_WMI
> +=09tristate "Gigabyte WMI temperature driver"
> +=09depends on ACPI_WMI
> +=09depends on HWMON
> +=09help
> +=09  Say Y here if you want to support WMI-based temperature on Gigabyte=
 mainboards.

I'm not a native speaker, but maybe "WMI-based temperature reporting" would=
 be better?


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
> index 000000000000..a3749cf248cb
> --- /dev/null
> +++ b/drivers/platform/x86/gigabyte-wmi.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Gigabyte WMI temperature driver
> + *
> + * Copyright (C) 2021 Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/acpi.h>
> +#include <linux/platform_device.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>

It is usually preferred if the list is sorted alphabetically.


> +
> +#define GIGABYTE_WMI_GUID "DEADBEEF-2001-0000-00A0-C90629100000"
> +#define DRVNAME "gigabyte-wmi"
> +
> +MODULE_AUTHOR("Thomas Wei=C3=9Fschuh <thomas@weissschuh.net>");
> +MODULE_DESCRIPTION("Gigabyte Generic WMI Driver");

The Kconfig says "Gigabyte WMI **temperature** driver". Which one is it?


> +MODULE_LICENSE("GPL");
> +
> +MODULE_ALIAS("wmi:" GIGABYTE_WMI_GUID);
> +
> +enum gigabyte_wmi_commandtype {
> +=09GIGABYTE_WMI_BUILD_DATE_QUERY       =3D   0x1,
> +=09GIGABYTE_WMI_MAINBOARD_TYPE_QUERY   =3D   0x2,
> +=09GIGABYTE_WMI_FIRMWARE_VERSION_QUERY =3D   0x4,
> +=09GIGABYTE_WMI_MAINBOARD_NAME_QUERY   =3D   0x5,
> +=09GIGABYTE_WMI_TEMPERATURE_QUERY      =3D 0x125,
> +};
> +
> +static int gigabyte_wmi_temperature(u8 sensor, s8 *res);

If you change the order of functions, you can get rid of this forward decla=
ration.


> +
> +static ssize_t temp_show(struct device *dev, struct device_attribute *at=
tr,
> +=09=09=09 char *buf)
> +{
> +=09struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr=
);
> +=09int index =3D sattr->index;
> +=09s8 temp;
> +=09acpi_status res;
> +
> +=09res =3D gigabyte_wmi_temperature(index, &temp);
> +=09if (ACPI_FAILURE(res))
> +=09=09return -res;

ACPI errors and errnos are not compatible, you can't return it like that. O=
r,
technically, you can, but it does not make sense. E.g. it'd "convert"
AE_NO_MEMORY to EINTR since both have the numeric value 4.


> +
> +=09return sprintf(buf, "%d\n", temp * 1000);

Use `sysfs_emit()`.


> +}
> +
> +static SENSOR_DEVICE_ATTR_2_RO(temp1_input, temp, 0, 0);
> +static SENSOR_DEVICE_ATTR_2_RO(temp2_input, temp, 0, 1);
> +static SENSOR_DEVICE_ATTR_2_RO(temp3_input, temp, 0, 2);
> +static SENSOR_DEVICE_ATTR_2_RO(temp4_input, temp, 0, 3);
> +static SENSOR_DEVICE_ATTR_2_RO(temp5_input, temp, 0, 4);
> +static SENSOR_DEVICE_ATTR_2_RO(temp6_input, temp, 0, 5);
> +
> +static struct platform_device *gigabyte_wmi_pdev;
> +
> +
> +static struct attribute *gigabyte_wmi_hwmon_attributes_temp[] =3D {
> +=09&sensor_dev_attr_temp1_input.dev_attr.attr,
> +=09&sensor_dev_attr_temp2_input.dev_attr.attr,
> +=09&sensor_dev_attr_temp3_input.dev_attr.attr,
> +=09&sensor_dev_attr_temp4_input.dev_attr.attr,
> +=09&sensor_dev_attr_temp5_input.dev_attr.attr,
> +=09&sensor_dev_attr_temp6_input.dev_attr.attr,
> +=09NULL,
> +};
> +
> +static const struct attribute_group gigabyte_wmi_hwmon_group_temp =3D {
> +=09.attrs =3D gigabyte_wmi_hwmon_attributes_temp,
> +};
> +
> +static const struct attribute_group *gigabyte_wmi_hwmon_groups[] =3D {
> +=09&gigabyte_wmi_hwmon_group_temp,
> +=09NULL,
> +};

If you want to, you can get rid of these two definitions if you rename
`gigabyte_wmi_hwmon_attributes_temp` to `gigabyte_wmi_hwmon_temp_attrs`
and use

  ATTRIBUTE_GROUPS(gigabyte_wmi_hwmon_temp); // linux/sysfs.h

that'll define `gigabyte_wmi_hwmon_temp_group` and `gigabyte_wmi_hwmon_temp=
_groups`.


> +
> +static int gigabyte_wmi_probe(struct platform_device *pdev)
> +{
> +=09struct device *hwmon_dev;
> +=09struct device *dev =3D &pdev->dev;
> +
> +=09if (!wmi_has_guid(GIGABYTE_WMI_GUID))
> +=09=09return -ENODEV;
> +=09gigabyte_wmi_pdev =3D pdev;
> +
> +=09hwmon_dev =3D devm_hwmon_device_register_with_groups(dev,
> +=09=09=09=09=09"gigabyte_wmi",
> +=09=09=09=09=09NULL, gigabyte_wmi_hwmon_groups);

Is there a reason for not using `devm_hwmon_device_register_with_info()` an=
d
the hwmon_{chip,channel}_info, hwmon_ops stuff? That way you wouldn't need =
to
touch any of the sysfs things.


> +=09return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct platform_driver gigabyte_wmi_driver =3D {
> +=09.driver =3D {
> +=09=09.name=09=3D DRVNAME,
> +=09},
> +=09.probe=09=3D gigabyte_wmi_probe,
> +};

Is there any reason for using a platform driver instead of a `wmi_driver`?
I think you could get rid of both the `platform_driver` and the `platform_d=
evice`
and simply use a `wmi_driver`.


> +
> +struct args {
> +=09u32 arg1;
> +=09u32 arg2;
> +=09u32 arg3;
> +};
> +
> +static acpi_status gigabyte_wmi_perform_query(
> +=09=09enum gigabyte_wmi_commandtype command, struct args *args, struct a=
cpi_buffer *out)

Long function signatures are usually split up in such a way that the first =
argument
remains in line with the function name.


> +{
> +=09struct acpi_buffer in =3D {};
> +
> +=09if (!args) {
> +=09=09struct args empty_args =3D {};
> +
> +=09=09args =3D &empty_args;

I don't think this is correct. `args` will be a dangling pointer since `emp=
ty_args`
goes out of scope - if I'm not mistaken.


> +=09}
> +=09in.length =3D sizeof(*args);
> +=09in.pointer =3D args;
> +=09return wmi_evaluate_method(GIGABYTE_WMI_GUID, 0x0, command, &in, out)=
;
> +}
> +
> +static int gigabyte_wmi_query_integer(
> +=09=09enum gigabyte_wmi_commandtype command, struct args *args, u64 *res=
)
> +{
> +=09union acpi_object *obj;
> +=09struct acpi_buffer result =3D { ACPI_ALLOCATE_BUFFER, NULL };

The allocated buffer is not freed.


> +=09acpi_status ret;
> +
> +=09ret =3D gigabyte_wmi_perform_query(command, args, &result);
> +=09if (ACPI_FAILURE(ret))
> +=09=09return -ENXIO;
> +=09obj =3D result.pointer;
> +=09if (!obj || obj->type !=3D ACPI_TYPE_INTEGER) {
> +=09=09pr_warn("Unexpected result type %d for command %d", obj->type, com=
mand);
> +=09=09return -ENXIO;
> +=09}
> +=09*res =3D obj->integer.value;
> +=09return AE_OK;
> +}
> +
> +static int gigabyte_wmi_temperature(u8 sensor, s8 *res)
> +{
> +=09struct args args =3D {
> +=09=09.arg1 =3D sensor,
> +=09};
> +=09u64 temp;
> +=09acpi_status ret;
> +
> +=09ret =3D gigabyte_wmi_query_integer(GIGABYTE_WMI_TEMPERATURE_QUERY, &a=
rgs, &temp);
> +=09if (ret =3D=3D 0)
> +=09=09*res =3D (s8) temp;

That cast will be done no matter if it's explicitly specified,
so you might want to drop it.


> +=09return ret;
> +}
> +
> +static int __init gigabyte_wmi_init(void)
> +{
> +=09struct platform_device *pdev;
> +=09int err;
> +
> +=09err =3D platform_driver_register(&gigabyte_wmi_driver);
> +=09if (err)
> +=09=09return err;
> +=09pdev =3D platform_device_alloc(DRVNAME, -1);

Prefer `PLATFORM_DEVID_NONE` instead of -1.


> +=09if (!pdev) {
> +=09=09platform_driver_unregister(&gigabyte_wmi_driver);
> +=09=09return -ENOMEM;
> +=09}
> +=09return platform_device_add(pdev);

The driver is not unregistered if this fails.


> +}
> +module_init(gigabyte_wmi_init);
> +
> +static void __exit gigabyte_wmi_exit(void)
> +{
> +=09platform_device_unregister(gigabyte_wmi_pdev);
> +=09platform_driver_unregister(&gigabyte_wmi_driver);
> +}
> +module_exit(gigabyte_wmi_exit);
>
> base-commit: 144c79ef33536b4ecb4951e07dbc1f2b7fa99d32
> --
> 2.31.1
>


Regards,
Barnab=C3=A1s P=C5=91cze
