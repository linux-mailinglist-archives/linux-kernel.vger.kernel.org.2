Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6579D3BB48C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhGEAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 20:50:12 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:53539 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbhGEAuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 20:50:11 -0400
Date:   Mon, 05 Jul 2021 00:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1625446052;
        bh=6b16QE5YQHT72Z9ghl2TeHay/lu1wSrBZbhnT2txrMI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=sPH3SIpc+HDSyLnmdcaST2qeMedh8vZYY1vXW7OiDySNzLDTt/IAQdn5eUaKWIpQD
         lvnGqJbOzhehCpUiLP5WLNfYE+PzN8xdAPgD1GgUOiVEIp/Y8DGYx4/+cKyBCojzTi
         BxSVAdHu/wIL23bUET368aGPu6mgx76HGgeWPyAQ=
To:     "Luke D. Jones" <luke@ljones.dev>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, corentin.chary@gmail.com,
        mgross@linux.intel.com, jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH 2/3] asus-wmi: Add dgpu disable method
Message-ID: <knw744OJB1AYrrFpo77N1Eei0JZC3SjKzg6SMoMhOsEchAiE8-klOIPTyFCAUSiVeTopPNqgFSefQJ2av6Gs_cS4TuIRXVQcHUxvw8YvSl0=@protonmail.com>
In-Reply-To: <20210704222148.880848-3-luke@ljones.dev>
References: <20210704222148.880848-1-luke@ljones.dev> <20210704222148.880848-3-luke@ljones.dev>
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

I have added a couple comments inline.


2021. j=C3=BAlius 5., h=C3=A9tf=C5=91 0:21 keltez=C3=A9ssel, Luke D. Jones =
=C3=ADrta:

> In Windows the ASUS Armory Crate progrm can enable or disable the
                                        ^
"program"


> dGPU via a WMI call. This functions much the same as various Linux
> methods in software where the dGPU is removed from the device tree.
>
> However the WMI call saves the state of dGPU enabled or not and this

I think "[...] the WMI call saves whether the dGPU is enabled or not, and [=
...]"
might be better.
Or "[...] the WMI call saves the state of the dGPU (enabled or not) and [..=
.]".


> then changes the dGPU visibility in Linux with no way for Linux
> users to re-enable it. We expose the WMI method so users can see
> and change the dGPU ACPI state.
>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/platform/x86/asus-wmi.c            | 98 ++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  3 +
>  2 files changed, 101 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 2468076d6cd8..8dc3f7ed021f 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -210,6 +210,9 @@ struct asus_wmi {
>  =09u8 fan_boost_mode_mask;
>  =09u8 fan_boost_mode;
>
> +=09bool dgpu_disable_available;
> +=09u8 dgpu_disable_mode;
> +
>  =09bool throttle_thermal_policy_available;
>  =09u8 throttle_thermal_policy_mode;
>
> @@ -427,6 +430,93 @@ static void lid_flip_tablet_mode_get_state(struct as=
us_wmi *asus)
>  =09}
>  }
>
> +/* dGPU ****************************************************************=
****/
> +static int dgpu_disable_check_present(struct asus_wmi *asus)
> +{
> +=09u32 result;
> +=09int err;
> +
> +=09asus->dgpu_disable_available =3D false;
> +
> +=09err =3D asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_DGPU, &result);
> +=09if (err) {
> +=09=09if (err =3D=3D -ENODEV)
> +=09=09=09return 0;
> +=09=09return err;
> +=09}
> +
> +=09if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> +=09=09asus->dgpu_disable_available =3D true;
> +=09=09asus->dgpu_disable_mode =3D result & ASUS_WMI_DSTS_STATUS_BIT;
> +

Aren't braces missing here?


> +=09return 0;
> +}
> +
> +static int dgpu_disable_write(struct asus_wmi *asus)
> +{
> +=09int err;
> +=09u8 value;
> +=09u32 retval;
> +
> +=09value =3D asus->dgpu_disable_mode;
> +
> +=09err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, value, &retval);
> +
> +=09sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> +=09=09=09"dgpu_disable");

A similar line with the exact same length in patch 3/3 is not broken in two=
.
And shouldn't the notification be sent if the operation succeeded?


> +
> +=09if (err) {
> +=09=09pr_warn("Failed to set dgpu disable: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09if (retval > 1 || retval < 0) {
> +=09=09pr_warn("Failed to set dgpu disable (retval): 0x%x\n",
> +=09=09=09retval);
> +=09=09return -EIO;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static ssize_t dgpu_disable_show(struct device *dev,
> +=09=09=09=09   struct device_attribute *attr, char *buf)
> +{
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +=09u8 mode =3D asus->dgpu_disable_mode;
> +
> +=09return scnprintf(buf, PAGE_SIZE, "%d\n", mode);

You could use `sysfs_emit()`.


> +}
> +
> +static ssize_t dgpu_disable_store(struct device *dev,
> +=09=09=09=09    struct device_attribute *attr,
> +=09=09=09=09    const char *buf, size_t count)
> +{
> +=09int result;
> +=09u8 disable;
> +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> +
> +=09result =3D kstrtou8(buf, 10, &disable);

You could use `kstrtobool()`. I think that would be better since it accepts
'y', 'n', etc. in addition to 0 and 1.


> +=09if (result < 0)
> +=09=09return result;
> +
> +=09if (disable > 1 || disable < 0)
> +=09=09return -EINVAL;
> +
> +=09asus->dgpu_disable_mode =3D disable;
> +=09/*
> +=09 * The ACPI call used does not save the mode unless the call is run t=
wice.
> +=09 * Once to disable, then once to check status and save - this is two =
code
> +=09 * paths in the method in the ACPI dumps.
> +=09*/
> +=09dgpu_disable_write(asus);
> +=09dgpu_disable_write(asus);

Is there any reason the potential error codes are not returned?


> +
> +=09return count;
> +}
> +
> +static DEVICE_ATTR_RW(dgpu_disable);
> +
>  /* Battery *************************************************************=
*******/
>
>  /* The battery maximum charging percentage */
> @@ -2412,6 +2502,7 @@ static struct attribute *platform_attributes[] =3D =
{
>  =09&dev_attr_camera.attr,
>  =09&dev_attr_cardr.attr,
>  =09&dev_attr_touchpad.attr,
> +=09&dev_attr_dgpu_disable.attr,
>  =09&dev_attr_lid_resume.attr,
>  =09&dev_attr_als_enable.attr,
>  =09&dev_attr_fan_boost_mode.attr,
> @@ -2438,6 +2529,8 @@ static umode_t asus_sysfs_is_visible(struct kobject=
 *kobj,
>  =09=09devid =3D ASUS_WMI_DEVID_LID_RESUME;
>  =09else if (attr =3D=3D &dev_attr_als_enable.attr)
>  =09=09devid =3D ASUS_WMI_DEVID_ALS_ENABLE;
> +=09else if (attr =3D=3D &dev_attr_dgpu_disable.attr)
> +=09=09ok =3D asus->dgpu_disable_available;
>  =09else if (attr =3D=3D &dev_attr_fan_boost_mode.attr)
>  =09=09ok =3D asus->fan_boost_mode_available;
>  =09else if (attr =3D=3D &dev_attr_throttle_thermal_policy.attr)
> @@ -2699,6 +2792,10 @@ static int asus_wmi_add(struct platform_device *pd=
ev)
>  =09if (err)
>  =09=09goto fail_platform;
>
> +=09err =3D dgpu_disable_check_present(asus);
> +=09if (err)
> +=09=09goto fail_dgpu_disable;
> +

Should this really be considered a "fatal" error?


>  =09err =3D fan_boost_mode_check_present(asus);
>  =09if (err)
>  =09=09goto fail_fan_boost_mode;
> @@ -2799,6 +2896,7 @@ static int asus_wmi_add(struct platform_device *pde=
v)
>  fail_sysfs:
>  fail_throttle_thermal_policy:
>  fail_fan_boost_mode:
> +fail_dgpu_disable:
>  fail_platform:
>  fail_panel_od:
>  =09kfree(asus);
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index 428aea701c7b..a528f9d0e4b7 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -90,6 +90,9 @@
>  /* Keyboard dock */
>  #define ASUS_WMI_DEVID_KBD_DOCK=09=090x00120063
>
> +/* dgpu on/off */
> +#define ASUS_WMI_DEVID_DGPU=09=090x00090020
> +
>  /* DSTS masks */
>  #define ASUS_WMI_DSTS_STATUS_BIT=090x00000001
>  #define ASUS_WMI_DSTS_UNKNOWN_BIT=090x00000002
> --
> 2.31.1


Regards,
Barnab=C3=A1s P=C5=91cze
