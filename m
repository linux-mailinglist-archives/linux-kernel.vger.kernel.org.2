Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41CE3FBE48
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhH3V3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:29:37 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:54621 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhH3V3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:29:20 -0400
Date:   Mon, 30 Aug 2021 21:28:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630358901;
        bh=vkuGuP/vzCeZHlpmlGQR07LhNNfjlcDjRRVi3GDIDC0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=ZO5V7UNXQwdskKqbpSsbXFfGLyJtuDIb8MosMvmUjPaZm9L1I27t+dxHfA0JjvIhE
         8y20qnIG3Y46AJoIUfE7joN3mDcgY1QyXR6dZAyyUFTwS4eYmU74MFpinQaqCJCr7h
         lRi64+bm4Xr/AgzPklLpN+QdsCcGTeuxz8Efpm18=
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        linux@roeck-us.net, platform-driver-x86@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v7] asus-wmi: Add support for custom fan curves
Message-ID: <1o94oJFiia_xvrFrSPI_zG1Xfv4FAlJNY96x39rg-zX3-3N5Czw4KmTiJtzCy1So7kYXLu0FTkRkmwUUudeuTyLHSsx5sJGhfsZaYrXKEic=@protonmail.com>
In-Reply-To: <20210830113137.1338683-2-luke@ljones.dev>
References: <20210830113137.1338683-1-luke@ljones.dev> <20210830113137.1338683-2-luke@ljones.dev>
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


2021. augusztus 30., h=C3=A9tf=C5=91 13:31 keltez=C3=A9ssel, Luke D. Jones =
=C3=ADrta:
> Add support for custom fan curves found on some ASUS ROG laptops.
>
> These laptops have the ability to set a custom curve for the CPU
> and GPU fans via an ACPI method call. This patch enables this,
> additionally enabling custom fan curves per-profile, where profile
> here means each of the 3 levels of "throttle_thermal_policy".
>
> This patch adds two blocks of attributes to the hwmon sysfs,
> 1 block each for CPU and GPU fans.
>
> When the user switches profiles the associated curve data for that
> profile is then show/store enabled to allow users to rotate through
> the profiles and set a fan curve for each profile which then
> activates on profile switch if enabled.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 568 ++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 566 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index cc5811844012..b594c2475034 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> [...]
> +/*
> + * Returns as an error if the method output is not a buffer. Typically t=
his

It seems to me it will simply leave the output buffer uninitialized if some=
thing
other than ACPI_TYPE_BUFFER and ACPI_TYPE_INTEGER is encountered and return=
 0.


> + * means that the method called is unsupported.
> + */
> +static int asus_wmi_evaluate_method_buf(u32 method_id,
> +=09=09u32 arg0, u32 arg1, u8 *ret_buffer)
> +{
> +=09struct bios_args args =3D {
> +=09=09.arg0 =3D arg0,
> +=09=09.arg1 =3D arg1,
> +=09=09.arg2 =3D 0,
> +=09};
> +=09struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args };
> +=09struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09acpi_status status;
> +=09union acpi_object *obj;
> +=09u32 int_tmp =3D 0;
> +
> +=09status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> +=09=09=09=09     &input, &output);
> +
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09obj =3D (union acpi_object *)output.pointer;
> +
> +=09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +=09=09int_tmp =3D (u32) obj->integer.value;
> +=09=09if (int_tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
> +=09=09=09return -ENODEV;
> +=09=09return int_tmp;

Is anything known about the possible values? You are later
using it as if it was an errno (e.g. in `custom_fan_check_present()`).

And `obj` is leaked in both of the previous two returns.


> +=09}
> +
> +=09if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
> +=09=09memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);

I would suggest you add a "size_t size" argument to this function, and
return -ENOSPC/-ENODATA depending on whether the returned buffer is too
big/small. Maybe return -ENODATA if `obj` is NULL, too.


> +
> +=09kfree(obj);
> +
> +=09return 0;
> +}
> [...]
> +static ssize_t fan_curve_show(struct device *dev,
> +=09=09=09=09struct device_attribute *attr, char *buf)
> +{
> +=09struct fan_curve_data *data =3D fan_curve_attr_data_select(dev, attr)=
;
> +=09int value;
> +
> +=09int index =3D to_sensor_dev_attr_2(attr)->index;
> +=09int nr =3D to_sensor_dev_attr_2(attr)->nr;
> +=09int pwm =3D nr & FAN_CURVE_PWM_MASK;
> +
> +=09if (pwm)
> +=09=09value =3D 255 * data->percents[index] / 100;
> +=09else
> +=09=09value =3D data->temps[index];
> +
> +=09return scnprintf(buf, PAGE_SIZE, "%d\n", value);

sysfs_emit()


> +}
> +
> +/*
> + * "dev" is the related WMI method such as ASUS_WMI_DEVID_CPU_FAN_CURVE.
> + */
> +static int fan_curve_write(struct asus_wmi *asus, u32 dev,
> +=09=09=09=09=09struct fan_curve_data *data)
> +{
> +=09int ret, i, shift =3D 0;
> +=09u32 arg1, arg2, arg3, arg4;
> +
> +=09arg1 =3D arg2 =3D arg3 =3D arg4 =3D 0;
> +
> +=09for (i =3D 0; i < FAN_CURVE_POINTS / 2; i++) {
> +=09=09arg1 +=3D data->temps[i] << shift;
> +=09=09arg2 +=3D data->temps[i + 4] << shift;
> +=09=09arg3 +=3D data->percents[0] << shift;
> +=09=09arg4 +=3D data->percents[i + 4] << shift;
> +=09=09shift +=3D 8;
> +=09}
> +
> +=09return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
> +=09=09=09=09=09arg1, arg2, arg3, arg4, &ret);
> +}
> +
> +/*
> + * Called only by throttle_thermal_policy_write()
> + */

Am I correct in thinking that the firmware does not actually
support specifying fan curves for each mode, only a single one,
and the fan curve switching is done by this driver when
the performance mode is changed?


> +static int fan_curve_write_data(struct asus_wmi *asus)
> +{
> +=09struct fan_curve_data *cpu;
> +=09struct fan_curve_data *gpu;
> +=09int err, mode;
> +
> +=09mode =3D asus->throttle_thermal_policy_mode;
> +=09cpu =3D &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_CPU];
> +=09gpu =3D &asus->throttle_fan_curves[mode][FAN_CURVE_DEV_GPU];
> +
> +=09if (cpu->enabled) {
> +=09=09err =3D fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, cpu);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09if (gpu->enabled) {
> +=09=09err =3D fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, gpu);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09return 0;
> +}
> [...]
> +static ssize_t fan_curve_store(struct device *dev,
> +=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09const char *buf, size_t count)
> +{
> +=09struct fan_curve_data *data =3D fan_curve_attr_data_select(dev, attr)=
;
> +=09u8 value, old_value;
> +=09int err;
> +
> +=09int index =3D to_sensor_dev_attr_2(attr)->index;
> +=09int nr =3D to_sensor_dev_attr_2(attr)->nr;
> +=09int pwm =3D nr & FAN_CURVE_PWM_MASK;
> +
> +=09err =3D kstrtou8(buf, 10, &value);
> +=09if (err < 0)
> +=09=09return err;
> +
> +=09if (pwm) {
> +=09=09old_value =3D data->percents[index];
> +=09=09data->percents[index] =3D 100 * value / 255;
> +=09} else {
> +=09=09old_value =3D data->temps[index];
> +=09=09data->temps[index] =3D value;
> +=09}
> +=09/*
> +=09 * The check here forces writing a curve graph in reverse,
> +=09 * from highest to lowest.
> +=09 */
> +=09err =3D fan_curve_verify(data);
> +=09if (err) {
> +=09=09if (pwm) {
> +=09=09=09dev_err(dev, "a fan curve percentage was higher than the next i=
n sequence\n");
> +=09=09=09data->percents[index] =3D old_value;
> +=09=09} else {
> +=09=09=09dev_err(dev, "a fan curve temperature was higher than the next =
in sequence\n");
> +=09=09=09data->temps[index] =3D old_value;
> +=09=09}
> +=09=09return err;
> +=09}

Are such sequences rejected by the firmware itself?
Or is this just an extra layer of protection?


> +
> +=09return count;
> +}
> +
> +static ssize_t fan_curve_enable_show(struct device *dev,
> +=09=09=09=09struct device_attribute *attr, char *buf)
> +{
> +=09struct fan_curve_data *data =3D fan_curve_attr_data_select(dev, attr)=
;
> +
> +=09return scnprintf(buf, PAGE_SIZE, "%d\n", data->enabled);

sysfs_emit()


> +}
> +
> +static ssize_t fan_curve_enable_store(struct device *dev,
> +=09=09=09=09struct device_attribute *attr,
> +=09=09=09=09const char *buf, size_t count)
> +{
> +=09struct fan_curve_data *data =3D fan_curve_attr_data_select(dev, attr)=
;
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int err;
> +
> +=09err =3D kstrtobool(buf, &value);
> +=09if (err < 0)
> +=09=09return err;
> +
> +=09data->enabled =3D value;
> +=09throttle_thermal_policy_write(asus);
> +
> +=09return count;
> +}
> +
> +/* CPU */
> +// TODO: enable
> +static SENSOR_DEVICE_ATTR_RW(pwm1_enable, fan_curve_enable,
> +=09=09=09=09FAN_CURVE_DEV_CPU);

FYI, the pwmX_enable attributes can be created by the hwmon
subsystem itself if you use [devm_]hwmon_device_register_with_info()
with appropriately populated `struct hwmon_chip_info`.


> [...]
> +static const struct attribute_group fan_curve_attribute_group =3D {
> +=09.is_visible =3D fan_curve_sysfs_is_visible,
> +=09.attrs =3D fan_curve_attributes

Small thing, but it is customary to put commas after non-terminating
entries in initializers / enum definitions.


> +};
> +__ATTRIBUTE_GROUPS(fan_curve_attribute);
> +
> +static int asus_wmi_fan_curve_init(struct asus_wmi *asus)
> +{
> +=09struct device *dev =3D &asus->platform_device->dev;
> +=09struct device *hwmon;
> +
> +=09hwmon =3D devm_hwmon_device_register_with_groups(dev, "asus", asus,
> +=09=09=09=09=09=09fan_curve_attribute_groups);
> +
> +=09if (IS_ERR(hwmon)) {
> +=09=09pr_err("Could not register asus fan_curve device\n");

I think `dev_err()` would be better.


> +=09=09return PTR_ERR(hwmon);
> +=09}
> +
> +=09return 0;
> +}
> [...]
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index 17dc5cb6f3f2..a571b47ff362 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -77,6 +77,8 @@
>  #define ASUS_WMI_DEVID_THERMAL_CTRL=090x00110011
>  #define ASUS_WMI_DEVID_FAN_CTRL=09=090x00110012 /* deprecated */
>  #define ASUS_WMI_DEVID_CPU_FAN_CTRL=090x00110013
> +#define ASUS_WMI_DEVID_CPU_FAN_CURVE=090x00110024
> +#define ASUS_WMI_DEVID_GPU_FAN_CURVE=090x00110025
>
>  /* Power */
>  #define ASUS_WMI_DEVID_PROCESSOR_STATE=090x00120012
> --
> 2.31.1


Best regards,
Barnab=C3=A1s P=C5=91cze
