Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6D3F9BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhH0P1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 11:27:07 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:10821 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245373AbhH0P1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 11:27:05 -0400
Date:   Fri, 27 Aug 2021 15:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1630077972;
        bh=KziS1HVPgTA4nkhcBekE8/AWFEbj7WAlEPJ3jxpp6C8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=cZgLx8VDjklAoEb28zXbR/Yqou76O6bs2wdKhT0Su72unRYe9dk6HKmfWhq8Pbcos
         BVEs08KylOUxS0cTrgZpf7fTwmx9A29m3eOlIGBubYnnR4iETu2WPbZzKawE68fcTI
         /M37YiigandR0K2LUztFG9LewpeNsrPspN/Zjxxk=
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        hadess@hadess.net, platform-driver-x86@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v5] asus-wmi: Add support for custom fan curves
Message-ID: <l_wjZlSh5I-iPC46H7er23ScdheWKul7iVjIbCUAKyz1sMPoZsFiAMVZa7N2W8Kv8RnFiksYwnWkPv9X428OYZtN5Q1OtI0L8zyHc-6cs2g=@protonmail.com>
In-Reply-To: <20210826234259.5980-2-luke@ljones.dev>
References: <20210826234259.5980-1-luke@ljones.dev> <20210826234259.5980-2-luke@ljones.dev>
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


+CC Guenter Roeck as he may be able to tell us if there's an established
way to export fan curves.

I have added a couple comments.
There are places where spaces are used instead of tabs.


2021. augusztus 27., p=C3=A9ntek 1:42 keltez=C3=A9ssel, Luke D. Jones =
=C3=ADrta:
> Add support for custom fan curves found on some ASUS ROG laptops.
>
> These laptops have the ability to set a custom curve for the CPU
> and GPU fans via an ACPI method call. This patch enables this,
> additionally enabling custom fan curves per-profile, where profile
> here means each of the 3 levels of "throttle_thermal_policy".
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 616 ++++++++++++++++++++-
>  include/linux/platform_data/x86/asus-wmi.h |   2 +
>  2 files changed, 616 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index cc5811844012..944644ae0acd 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -108,6 +108,11 @@ module_param(fnlock_default, bool, 0444);
>
>  static const char * const ashs_ids[] =3D { "ATK4001", "ATK4002", NULL };
>
> +static int throttle_thermal_policy_write(struct asus_wmi*);
> +static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
> +=09=09=09=09=09=09=09=09size_t count, u32 dev, char **curve,
> +=09=09=09=09=09=09=09=09char *default_curve);
> +
>  static bool ashs_present(void)
>  {
>  =09int i =3D 0;
> @@ -122,7 +127,8 @@ struct bios_args {
>  =09u32 arg0;
>  =09u32 arg1;
>  =09u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
> -=09u32 arg4;
> +=09u32 arg3;
> +=09u32 arg4; /* Some ROG laptops require a full 5 input args */
>  =09u32 arg5;
>  } __packed;
>
> @@ -173,6 +179,21 @@ enum fan_type {
>  =09FAN_TYPE_SPEC83,=09/* starting in Spec 8.3, use CPU_FAN_CTRL */
>  };
>
> +struct fan_curve {
> +=09char *balanced;
> +=09char *balanced_default;
> +=09char *performance;
> +=09char *performance_default;
> +=09char *quiet;
> +=09char *quiet_default;
> +};
> +
> +struct enabled_fan_curves {
> +=09bool balanced;
> +=09bool performance;
> +=09bool quiet;
> +};
> +
>  struct asus_wmi {
>  =09int dsts_id;
>  =09int spec;
> @@ -220,6 +241,14 @@ struct asus_wmi {
>  =09bool throttle_thermal_policy_available;
>  =09u8 throttle_thermal_policy_mode;
>
> +=09bool cpu_fan_curve_available;
> +=09struct fan_curve cpu_fan_curve;
> +
> +    bool gpu_fan_curve_available;
> +=09struct fan_curve gpu_fan_curve;
> +
> +=09struct enabled_fan_curves enabled_fan_curve_profiles;

I would suggest something like the following:

  struct fan_curve {
    /* bool enabled; */
    u8 temps[FAN_CURVE_SIZE];
    u8 percents[FAN_CURVE_SIZE];
  };

  struct fan {
    bool available;
    struct fan_curve curves[NUM_PERF_PROFILES];
  };

  struct asus_wmi {
    ...

    struct fan fans[NUM_FANS];

    bool fan_curve_enabled_for_profile[NUM_PERF_PROFILES];
    /* or maybe you could add it as `bool enabled;` into the inner struct *=
/
  };

see the reason later.


> +
>  =09struct platform_profile_handler platform_profile_handler;
>  =09bool platform_profile_support;
>
> @@ -285,6 +314,85 @@ int asus_wmi_evaluate_method(u32 method_id, u32 arg0=
, u32 arg1, u32 *retval)
>  }
>  EXPORT_SYMBOL_GPL(asus_wmi_evaluate_method);
>
> +static int asus_wmi_evaluate_method5(u32 method_id,
> +=09=09u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4, u32 *retval)
> +{
> +=09struct bios_args args =3D {
> +=09=09.arg0 =3D arg0,
> +=09=09.arg1 =3D arg1,
> +=09=09.arg2 =3D arg2,
> +=09=09.arg3 =3D arg3,
> +=09=09.arg4 =3D arg4,
> +=09};
> +=09struct acpi_buffer input =3D { (acpi_size) sizeof(args), &args };
> +=09struct acpi_buffer output =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09acpi_status status;
> +=09union acpi_object *obj;
> +=09u32 tmp =3D 0;
> +
> +=09status =3D wmi_evaluate_method(ASUS_WMI_MGMT_GUID, 0, method_id,
> +=09=09=09=09     &input, &output);
> +
> +=09if (ACPI_FAILURE(status))
> +=09=09return -EIO;
> +
> +=09obj =3D (union acpi_object *)output.pointer;

Small thing, but this cast is unnecessary.


> +=09if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
> +=09=09tmp =3D (u32) obj->integer.value;

Same here.


> +
> +=09if (retval)
> +=09=09*retval =3D tmp;
> +
> +=09kfree(obj);
> +
> +=09if (tmp =3D=3D ASUS_WMI_UNSUPPORTED_METHOD)
> +=09=09return -ENODEV;
> +
> +=09return 0;
> +}
> +
> +/*
> + * Returns as an error if the method output is not a buffer. Typically t=
his
> + * means that the method called is unsupported.
> +*/
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
> +=09}
> +
> +=09if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
> +=09=09memcpy(ret_buffer, obj->buffer.pointer, obj->buffer.length);
> +=09}
> +
> +=09kfree(obj);
> +
> +=09return 0;
> +}
> +
>  static int asus_wmi_evaluate_method_agfn(const struct acpi_buffer args)
>  {
>  =09struct acpi_buffer input;
> @@ -1813,7 +1921,7 @@ static ssize_t fan1_label_show(struct device *dev,
>  =09=09=09=09=09  struct device_attribute *attr,
>  =09=09=09=09=09  char *buf)
>  {
> -=09return sprintf(buf, "%s\n", ASUS_FAN_DESC);
> +=09return sprintf(buf, "%s", ASUS_FAN_DESC);

What is the reason for this change?


>  }
>
>  static ssize_t asus_hwmon_temp1(struct device *dev,
> @@ -2043,6 +2151,458 @@ static ssize_t fan_boost_mode_store(struct device=
 *dev,
>  // Fan boost mode: 0 - normal, 1 - overboost, 2 - silent
>  static DEVICE_ATTR_RW(fan_boost_mode);
>
> +/* Custom fan curves per-profile ***************************************=
*******/
> +
> +/*
> + * Check if the ability to set fan curves on either fan exists, and stor=
e the
> + * defaults for recall later plus to provide users with a starting point=
.
> + *
> + * "dev" is either CPU_FAN_CURVE or GPU_FAN_CURVE.
> +*/
> +static int custom_fan_check_present(struct asus_wmi *asus,
> +=09=09=09=09=09=09=09=09=09bool *available, u32 dev)
> +{
> +=09struct fan_curve *curves =3D &asus->cpu_fan_curve;
> +=09u8 *buf =3D kzalloc(16 * sizeof(u8), GFP_KERNEL);

Is dynamic allocation needed here? No early return frees it.


> +=09/* 15 punctuation marks + 16 sets of numbers up to 3 char each */
> +=09int str_len =3D 15 + 16 * 3;

It appears to me that the terminating null byte is not accounted for. E.g.:

  255:255,255:255,255:255,255:255,255:255,255:255,255:255,255:255

is itself already 63 (=3D 15 + 16 x 3) characters.

And if the maximum length is known, and it's reasonably small, why is it no=
t
part of the struct as a char array? E.g.:

  struct fan_curve {
    char balanced[FAN_CURVE_STR_SIZE]; /* #define FAN_CURVE_STR_SIZE 64 */
    ...
  };

I would actually suggest storing the u8 array itself in the fan curve struc=
t,
and not a string representation of it. I think the data is easier to deal w=
ith
that way, and the price of formatting it for the sysfs attribute is not
significant.


> +=09int err;
> +
> +=09*available =3D false;
> +
> +=09if (dev =3D=3D ASUS_WMI_DEVID_GPU_FAN_CURVE)
> +=09=09curves =3D &asus->gpu_fan_curve;
> +
> +=09/* Balanced default */
> +=09err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 0, buf);
> +=09if (err) {
> +=09=09if (err =3D=3D -ENODEV)
> +=09=09=09return 0;
> +=09=09return err;
> +=09}
> +
> +=09curves->balanced =3D kzalloc(str_len * sizeof(char), GFP_KERNEL);
> +=09if (!curves->balanced)
> +=09=09return -ENOMEM;
> +
> +=09curves->balanced_default =3D kzalloc(str_len * sizeof(char), GFP_KERN=
EL);
> +=09if (!curves->balanced_default)
> +=09=09return -ENOMEM;
> +
> +=09sprintf(curves->balanced, "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,=
%d:%d",
> +=09=09buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
> +=09=09buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]=
);
> +=09sprintf(curves->balanced_default, curves->balanced);
> +
> +=09/* Quiet default */
> +=09err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 1, buf);
> +=09if (err) {
> +=09=09if (err =3D=3D -ENODEV)
> +=09=09=09return 0;
> +=09=09return err;
> +=09}
> +
> +=09curves->quiet =3D kzalloc(str_len * sizeof(char), GFP_KERNEL);
> +=09if (!curves->quiet)
> +=09=09return -ENOMEM;
> +
> +=09curves->quiet_default =3D kzalloc(str_len * sizeof(char), GFP_KERNEL)=
;
> +=09if (!curves->quiet_default)
> +=09=09return -ENOMEM;
> +
> +=09sprintf(curves->quiet, "%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:=
%d",
> +=09=09buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
> +=09=09buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]=
);
> +=09sprintf(curves->quiet_default, curves->quiet);
> +
> +=09/* Performance default */
> +=09err =3D asus_wmi_evaluate_method_buf(asus->dsts_id, dev, 2, buf);
> +=09if (err) {
> +=09=09if (err =3D=3D -ENODEV)
> +=09=09=09return 0;
> +=09=09return err;
> +=09}
> +
> +=09curves->performance =3D kzalloc(str_len * sizeof(char), GFP_KERNEL);
> +=09if (!curves->performance)
> +=09=09return -ENOMEM;
> +
> +=09curves->performance_default =3D kzalloc(str_len * sizeof(char), GFP_K=
ERNEL);
> +=09if (!curves->performance_default)
> +=09=09return -ENOMEM;
> +
> +=09sprintf(curves->performance,
> +=09=09"%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d,%d:%d",
> +=09=09buf[0], buf[8], buf[1], buf[9], buf[2], buf[10], buf[3], buf[11],
> +=09=09buf[4], buf[12], buf[5], buf[13], buf[6], buf[14], buf[7], buf[15]=
);
> +=09sprintf(curves->performance_default, curves->performance);

More or less the same code is repeated three times, I'd consider adding an =
e.g.

  void fan_curve_to_str(..., char[static FAN_CURVE_STR_SIZE]);

function.


> +
> +=09kfree(buf);
> +
> +=09*available =3D true;
> +=09return 0;
> +}
> +
> +/*
> + * The expected input is of the format
> + *     "30:1,49:2,59:3,69:4,79:31,89:49,99:56,109:58"
> + * where a pair is 30:1, with 30 =3D temperature, and 1 =3D percentage
> +*/
> +static int fan_curve_write(struct asus_wmi *asus, u32 dev, char *curve)
> +{
> +    char * buf, *set, *pair_tmp, *pair, *set_end, *pair_end;
> +    int err, ret;
> +
> +=09char *set_delimiter =3D ",";
> +=09char *pair_delimiter =3D ":";
> +=09bool half_complete =3D false;
> +=09bool pair_start =3D true;
> +=09u32 prev_percent =3D 0;
> +=09u32 prev_temp =3D 0;
> +=09u32 percent =3D 0;
> +=09u32 shift =3D 0;
> +=09u32 temp =3D 0;
> +    u32 arg1 =3D 0;
> +    u32 arg2 =3D 0;
> +    u32 arg3 =3D 0;
> +    u32 arg4 =3D 0;
> +
> +    buf =3D set_end =3D pair_end =3D kstrdup(curve, GFP_KERNEL);
> +
> +=09while( (set =3D strsep(&set_end, set_delimiter)) !=3D NULL ) {
> +=09=09pair_tmp =3D kstrdup(set, GFP_KERNEL);
> +        pair_start =3D true;
> +=09=09while( (pair =3D strsep(&pair_tmp, pair_delimiter)) !=3D NULL ) {
> +=09=09=09err =3D kstrtouint(pair, 10, &ret);
> +            if (err) {
> +                kfree(pair_tmp);
> +                kfree(buf);
> +                return err;
> +            }
> +
> +            if (pair_start) {
> +                temp =3D ret;
> +                pair_start =3D false;
> +            } else {
> +                percent =3D ret;
> +            }
> +=09=09}
> +=09=09kfree(pair_tmp);
> +
> +=09=09if (temp < prev_temp || percent < prev_percent || percent > 100) {
> +            pr_info("Fan curve invalid");
> +=09=09=09pr_info("A value is sequentially lower or percentage is > 100")=
;
> +            kfree(buf);
> +            return -EINVAL;
> +        }
> +
> +        prev_temp =3D temp;
> +        prev_percent =3D percent;
> +
> +        if (!half_complete) {
> +            arg1 +=3D temp << shift;
> +            arg3 +=3D percent << shift;
> +        } else {
> +            arg2 +=3D temp << shift;
> +            arg4 +=3D percent << shift;
> +        }

As far as I see using 64-bit integers would avoid the need for `half_comple=
te`, et al.


> +        shift +=3D 8;
> +
> +        if (shift =3D=3D 32) {
> +            shift =3D 0;
> +            half_complete =3D true;
> +        }
> +=09}
> +=09kfree(buf);
> +

If you don't insist on using commas, I think it is much simpler to
parse it using `sscanf()`, e.g.:

  unsigned int temp, prct;
  int at =3D 0, len;

  while (sscanf(&buf[at], "%u:%u %n", &temp, &prct, &len) =3D=3D 2) {
    /* process `temp` and `prct` */

    at +=3D len;
  }

  if (buf[at] !=3D '\0')
    /* error */;

This also has the advantage that you don't need dynamic memory allocation.


> +    return asus_wmi_evaluate_method5(ASUS_WMI_METHODID_DEVS, dev,
> +=09=09=09=09=09=09=09=09=09 arg1, arg2, arg3, arg4, &ret);
> +}
> +
> +static int fan_curve_cpu_write(struct asus_wmi *asus)
> +{
> +=09char *curve =3D NULL;
> +=09int err, mode;
> +
> +=09mode =3D asus->throttle_thermal_policy_mode;
> +
> +=09if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
> +=09=09=09=09=09&& asus->enabled_fan_curve_profiles.balanced) {
> +=09=09curve =3D asus->cpu_fan_curve.balanced;
> +=09} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
> +=09=09=09=09=09&& asus->enabled_fan_curve_profiles.performance) {
> +=09=09curve =3D asus->cpu_fan_curve.performance;
> +=09} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_SILENT
> +=09=09=09=09=09&& asus->enabled_fan_curve_profiles.quiet) {
> +=09=09curve =3D asus->cpu_fan_curve.quiet;
> +=09}
> +
> +=09if (curve !=3D NULL) {
> +=09=09err =3D fan_curve_write(asus, ASUS_WMI_DEVID_CPU_FAN_CURVE, curve)=
;
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +=09return 0;
> +}
> +
> +
> +static int fan_curve_gpu_write(struct asus_wmi *asus)
> +{
> +=09char *curve =3D NULL;
> +=09int err, mode;
> +
> +=09mode =3D asus->throttle_thermal_policy_mode;
> +
> +=09if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_DEFAULT
> +=09=09=09=09=09&& asus->enabled_fan_curve_profiles.balanced) {
> +=09=09curve =3D asus->gpu_fan_curve.balanced;
> +=09} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST
> +=09=09=09=09=09&& asus->enabled_fan_curve_profiles.performance) {
> +=09=09curve =3D asus->gpu_fan_curve.performance;
> +=09} else if (mode =3D=3D ASUS_THROTTLE_THERMAL_POLICY_SILENT
> +=09=09=09=09=09&& asus->enabled_fan_curve_profiles.quiet) {
> +=09=09curve =3D asus->gpu_fan_curve.quiet;
> +=09}
> +
> +=09if (curve !=3D NULL) {
> +=09=09err =3D fan_curve_write(asus, ASUS_WMI_DEVID_GPU_FAN_CURVE, curve)=
;
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +=09return 0;
> +}
> +
> +static ssize_t fan_curve_store(struct asus_wmi *asus, const char *buf,
> +=09=09=09=09=09=09=09=09size_t count, u32 dev, char **curve,
> +=09=09=09=09=09=09=09=09char *default_curve)
> +{
> +    int err;
> +
> +=09/* Allow a user to write "" or " " to erase a curve setting */
> +=09if (strlen(buf) <=3D 1 || strcmp(buf, " \n") =3D=3D 0) {
> +=09=09kfree(*curve);
> +=09=09*curve =3D kstrdup(default_curve, GFP_KERNEL);
> +=09=09err =3D throttle_thermal_policy_write(asus);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09return count;
> +=09}
> +
> +=09if (*curve)
> +=09=09kfree(*curve);
> +    *curve =3D kstrdup(buf, GFP_KERNEL);
> +
> +=09/* Maybe activate fan curve if in associated mode */
> +=09err =3D throttle_thermal_policy_write(asus);
> +=09if (err) {
> +=09=09kfree(*curve);
> +=09=09*curve =3D kstrdup(default_curve, GFP_KERNEL);
> +=09=09return err;
> +=09}
> +
> +    return count;
> +}
> +
> +/*
> + * CPU Fan Curves
> +*/
> +
> +static ssize_t cpu_fan_curve_balanced_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.balanced);
> +}
> +
> +static ssize_t cpu_fan_curve_balanced_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURV=
E,
> +=09=09=09=09=09=09=09&asus->cpu_fan_curve.balanced,
> +=09=09=09=09=09=09=09asus->cpu_fan_curve.balanced_default);
> +}
> +
> +static DEVICE_ATTR_RW(cpu_fan_curve_balanced);
> +
> +static ssize_t cpu_fan_curve_performance_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.performanc=
e);
> +}
> +
> +static ssize_t cpu_fan_curve_performance_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURV=
E,
> +=09=09=09=09=09=09=09&asus->cpu_fan_curve.performance,
> +=09=09=09=09=09=09=09asus->cpu_fan_curve.performance_default);
> +}
> +
> +static DEVICE_ATTR_RW(cpu_fan_curve_performance);
> +
> +static ssize_t cpu_fan_curve_quiet_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->cpu_fan_curve.quiet);
> +}
> +
> +static ssize_t cpu_fan_curve_quiet_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_CPU_FAN_CURV=
E,
> +=09=09=09=09=09=09=09&asus->cpu_fan_curve.quiet,
> +=09=09=09=09=09=09=09asus->cpu_fan_curve.quiet_default);
> +}
> +
> +static DEVICE_ATTR_RW(cpu_fan_curve_quiet);
> +
> +/*
> + * GPU Fan Curves
> +*/
> +
> +static ssize_t gpu_fan_curve_balanced_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.balanced);
> +}
> +
> +static ssize_t gpu_fan_curve_balanced_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURV=
E,
> +=09=09=09=09=09=09=09&asus->gpu_fan_curve.balanced,
> +=09=09=09=09=09=09=09asus->gpu_fan_curve.balanced_default);
> +}
> +
> +static DEVICE_ATTR_RW(gpu_fan_curve_balanced);
> +
> +static ssize_t gpu_fan_curve_performance_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.performanc=
e);
> +}
> +
> +static ssize_t gpu_fan_curve_performance_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURV=
E,
> +=09=09=09=09=09=09=09&asus->gpu_fan_curve.performance,
> +=09=09=09=09=09=09=09asus->gpu_fan_curve.performance_default);
> +}
> +
> +static DEVICE_ATTR_RW(gpu_fan_curve_performance);
> +
> +static ssize_t gpu_fan_curve_quiet_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09return scnprintf(buf, PAGE_SIZE, "%s", asus->gpu_fan_curve.quiet);
> +}
> +
> +static ssize_t gpu_fan_curve_quiet_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +    return fan_curve_store(asus, buf, count, ASUS_WMI_DEVID_GPU_FAN_CURV=
E,
> +=09=09=09=09=09=09=09&asus->gpu_fan_curve.quiet,
> +=09=09=09=09=09=09=09asus->gpu_fan_curve.quiet_default);
> +}
> +
> +static DEVICE_ATTR_RW(gpu_fan_curve_quiet);

Even though it is a hwmon thing, I think `SENSOR_ATTR_2()` (from linux/hwmo=
n-sysfs.h)
would be very useful here as you'd avoid creating n+1 functions, e.g:

  static ssize_t fan_curve_show(struct device *dev, struct device_attribute=
 *attr, char *buf)
  {
    struct sensor_device_attribute_2 *sattr =3D to_sensor_dev_attr_2(attr);
    struct asus_wmi *asus =3D dev_get_drvdata(dev);

    /*
     * if you stored fan curves in an array, you could then access the fan
     * curve in `asus->fans[sattr->index].curves[sattr->nr]`
     * /
  }

  static SENSOR_DEVICE_ATTR_2(some_name1, 0644, fan_curve_show, fan_curve_s=
tore,
                              FAN_CPU /* index in the "fans" array */,
                              ASUS_THROTTLE_THERMAL_POLICY_SILENT /* index =
in the "curves" array */);


> +
> +/*
> + * Profiles with enabled fan curve setting
> +*/
> +
> +static int enabled_fan_curve_profiles_write(struct asus_wmi *asus,
> +=09=09=09=09=09=09=09=09=09=09=09const char *names)
> +{
> +    char *buf, *set, *set_end;
> +    int err;
> +
> +    buf =3D set_end =3D kstrdup(names, GFP_KERNEL);
> +
> +=09/* Reset before checking */
> +=09asus->enabled_fan_curve_profiles.balanced =3D false;
> +=09asus->enabled_fan_curve_profiles.quiet =3D false;
> +=09asus->enabled_fan_curve_profiles.performance =3D false;
> +
> +=09while( (set =3D strsep(&set_end, " ")) !=3D NULL ) {
> +=09=09if (set =3D=3D NULL)

When is this possible?


> +=09=09=09set =3D buf;
> +
> +=09=09if (strcmp(set, "balanced") =3D=3D 0
> +=09=09=09=09|| strcmp(set, "balanced\n") =3D=3D 0)
> +=09=09=09asus->enabled_fan_curve_profiles.balanced =3D true;
> +
> +=09=09if (strcmp(set, "quiet") =3D=3D 0
> +=09=09=09=09|| strcmp(set, "quiet\n") =3D=3D 0)
> +=09=09=09asus->enabled_fan_curve_profiles.quiet =3D true;
> +
> +=09=09if (strcmp(set, "performance") =3D=3D 0
> +=09=09=09=09|| strcmp(set, "performance\n") =3D=3D 0)
> +=09=09=09asus->enabled_fan_curve_profiles.performance =3D true;

If you store the enabled curves in an array, and you have a list of profile=
 names,
then `sysfs_match_string()`, will be very helpful here. You could do someth=
ing like:

  int profile =3D sysfs_match_string(profile_names, set);
  if (profile < 0) {
    /* not found */
  }

  asus->fan_curve_enabled_for_profile[profile] =3D true;


> +=09}
> +
> +=09err =3D throttle_thermal_policy_write(asus);
> +=09if (err)
> +=09=09return err;
> +
> +=09kfree(buf);
> +
> +=09return 0;
> +}
> +
> +static ssize_t enabled_fan_curve_profiles_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09int len =3D 0;
> +
> +=09if (asus->enabled_fan_curve_profiles.balanced)
> +=09=09len +=3D sysfs_emit_at(buf, len, "balanced ");
> +
> +=09if (asus->enabled_fan_curve_profiles.performance)
> +=09=09len +=3D sysfs_emit_at(buf, len, "performance ");
> +
> +=09if (asus->enabled_fan_curve_profiles.quiet)
> +=09=09len +=3D sysfs_emit_at(buf, len, "quiet ");
> +
> +=09len +=3D sysfs_emit_at(buf, len, "\n");
> +=09return len;
> +}
> +
> +static ssize_t enabled_fan_curve_profiles_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +    struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09int err;
> +
> +=09err =3D enabled_fan_curve_profiles_write(asus, buf);
> +=09if (err)
> +=09=09return err;
> +
> +    return count;
> +}
> +
> +static DEVICE_ATTR_RW(enabled_fan_curve_profiles);
> +
>  /* Throttle thermal policy *********************************************=
*******/
>
>  static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> @@ -2092,6 +2652,26 @@ static int throttle_thermal_policy_write(struct as=
us_wmi *asus)
>  =09=09return -EIO;
>  =09}
>
> +=09if (asus->cpu_fan_curve_available) {
> +=09=09err =3D fan_curve_cpu_write(asus);
> +=09=09if (err) {
> +=09=09=09dev_warn(&asus->platform_device->dev,
> +=09=09=09=09"Failed to set custom CPU curve for thermal policy: %d\n",
> +=09=09=09=09err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
> +=09if (asus->gpu_fan_curve_available) {
> +=09=09err =3D fan_curve_gpu_write(asus);
> +=09=09if (err) {
> +=09=09=09dev_warn(&asus->platform_device->dev,
> +=09=09=09=09"Failed to set custom GPU curve for thermal policy: %d\n",
> +=09=09=09=09err);
> +=09=09=09return err;
> +=09=09}
> +=09}
> +
>  =09return 0;
>  }
>
> @@ -2711,6 +3291,13 @@ static struct attribute *platform_attributes[] =3D=
 {
>  =09&dev_attr_als_enable.attr,
>  =09&dev_attr_fan_boost_mode.attr,
>  =09&dev_attr_throttle_thermal_policy.attr,
> +=09&dev_attr_cpu_fan_curve_balanced.attr,
> +=09&dev_attr_cpu_fan_curve_performance.attr,
> +=09&dev_attr_cpu_fan_curve_quiet.attr,
> +    &dev_attr_gpu_fan_curve_balanced.attr,
> +=09&dev_attr_gpu_fan_curve_performance.attr,
> +=09&dev_attr_gpu_fan_curve_quiet.attr,
> +=09&dev_attr_enabled_fan_curve_profiles.attr,
>  =09&dev_attr_panel_od.attr,
>  =09NULL
>  };
> @@ -2741,6 +3328,20 @@ static umode_t asus_sysfs_is_visible(struct kobjec=
t *kobj,
>  =09=09ok =3D asus->fan_boost_mode_available;
>  =09else if (attr =3D=3D &dev_attr_throttle_thermal_policy.attr)
>  =09=09ok =3D asus->throttle_thermal_policy_available;
> +=09else if (attr =3D=3D &dev_attr_cpu_fan_curve_balanced.attr)
> +=09=09ok =3D asus->cpu_fan_curve_available;
> +=09else if (attr =3D=3D &dev_attr_cpu_fan_curve_performance.attr)
> +=09=09ok =3D asus->cpu_fan_curve_available;
> +=09else if (attr =3D=3D &dev_attr_cpu_fan_curve_quiet.attr)
> +=09=09ok =3D asus->cpu_fan_curve_available;
> +    else if (attr =3D=3D &dev_attr_gpu_fan_curve_balanced.attr)
> +=09=09ok =3D asus->gpu_fan_curve_available;
> +=09else if (attr =3D=3D &dev_attr_gpu_fan_curve_performance.attr)
> +=09=09ok =3D asus->gpu_fan_curve_available;
> +=09else if (attr =3D=3D &dev_attr_gpu_fan_curve_quiet.attr)
> +=09=09ok =3D asus->gpu_fan_curve_available;
> +=09else if (attr =3D=3D &dev_attr_enabled_fan_curve_profiles.attr)
> +=09=09ok =3D asus->cpu_fan_curve_available || asus->gpu_fan_curve_availa=
ble;
>  =09else if (attr =3D=3D &dev_attr_panel_od.attr)
>  =09=09ok =3D asus->panel_overdrive_available;
>
> @@ -3016,6 +3617,16 @@ static int asus_wmi_add(struct platform_device *pd=
ev)
>  =09else
>  =09=09throttle_thermal_policy_set_default(asus);
>
> +=09err =3D custom_fan_check_present(asus, &asus->cpu_fan_curve_available=
,
> +=09=09=09ASUS_WMI_DEVID_CPU_FAN_CURVE);
> +=09if (err)
> +=09=09goto fail_custom_fan_curve;
> +
> +    err =3D custom_fan_check_present(asus, &asus->gpu_fan_curve_availabl=
e,
> +=09=09=09ASUS_WMI_DEVID_GPU_FAN_CURVE);
> +=09if (err)
> +=09=09goto fail_custom_fan_curve;
> +
>  =09err =3D platform_profile_setup(asus);
>  =09if (err)
>  =09=09goto fail_platform_profile_setup;
> @@ -3109,6 +3720,7 @@ static int asus_wmi_add(struct platform_device *pde=
v)
>  =09asus_wmi_sysfs_exit(asus->platform_device);
>  fail_sysfs:
>  fail_throttle_thermal_policy:
> +fail_custom_fan_curve:
>  fail_platform_profile_setup:
>  =09if (asus->platform_profile_support)
>  =09=09platform_profile_remove();
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
