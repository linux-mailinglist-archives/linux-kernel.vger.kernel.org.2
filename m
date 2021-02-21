Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F936320E0F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 22:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhBUVwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 16:52:07 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:19177 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbhBUVwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 16:52:01 -0500
Date:   Sun, 21 Feb 2021 21:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1613944278;
        bh=06kMre9nspAdj7Pyn5EepTnOrQ8OpQiYyAdF3Y+UGYw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=QnYdawNF7Liv9IOcd4GiWL/Gheih6hDp9twFrbFyjJMauPMIJXldsDWGxbIdOnqST
         a5CnDY6nLWf3h71XZf9nik956ywMZr14OZSitcZOR6buKMVgvrEY9of+YpYyUT2ajc
         aHymfvgsfQ/1UbP8d5LzsSQVu46j+ezwiHn9/iHA=
To:     Elia Devito <eliadevito@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 2/2] platform/x86: hp-wmi: add platform profile support
Message-ID: <nVb9zC39HBbC5-iweNmNol7ymCjT4iD91ydsZVuo_Upqh2_3eVKaF1X1rbYpZGva-NyrGUW_W2uJIc5RHu1KhBGy7-ejGNYZJyRttjhJT-s=@protonmail.com>
In-Reply-To: <20210221213006.4725-1-eliadevito@gmail.com>
References: <20210221210439.68590-1-eliadevito@gmail.com> <20210221213006.4725-1-eliadevito@gmail.com>
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


2021. febru=C3=A1r 21., vas=C3=A1rnap 22:30 keltez=C3=A9ssel, Elia Devito =
=C3=ADrta:

> Implement support for cool, balanced and performance thermal profile
>
> Signed-off-by: Elia Devito <eliadevito@gmail.com>
> ---
> the "quiet" profile will be implemented with a further patch
>
> v2: added platform_profile_remove() missing call
>
>  drivers/platform/x86/hp-wmi.c | 103 ++++++++++++++++++++++++++++++++--
>  1 file changed, 98 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.=
c
> index 6d7b91b8109b..a33203d61cf0 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -21,6 +21,7 @@
>  #include <linux/input.h>
>  #include <linux/input/sparse-keymap.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_profile.h>
>  #include <linux/acpi.h>
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
> @@ -119,6 +120,12 @@ enum hp_wireless2_bits {
>  =09HPWMI_POWER_FW_OR_HW=09=3D HPWMI_POWER_BIOS | HPWMI_POWER_HARD,
>  };
>
> +enum hp_thermal_profile {
> +=09HP_THERMAL_PROFILE_PERFORMANCE=09=3D 0x00,
> +=09HP_THERMAL_PROFILE_DEFAULT=09=09=3D 0x01,
> +=09HP_THERMAL_PROFILE_COOL=09=09=09=3D 0x02
> +};
> +
>  #define IS_HWBLOCKED(x) ((x & HPWMI_POWER_FW_OR_HW) !=3D HPWMI_POWER_FW_=
OR_HW)
>  #define IS_SWBLOCKED(x) !(x & HPWMI_POWER_SOFT)
>
> @@ -159,6 +166,8 @@ static const struct key_entry hp_wmi_keymap[] =3D {
>
>  static struct input_dev *hp_wmi_input_dev;
>  static struct platform_device *hp_wmi_platform_dev;
> +static struct platform_profile_handler platform_profile_handler;
> +static int platform_profile_support =3D 0;

I suggest you use `bool` and omit the initialization (checkpatch will warn =
you
about that).


>
>  static struct rfkill *wifi_rfkill;
>  static struct rfkill *bluetooth_rfkill;
> @@ -869,11 +878,80 @@ static int __init hp_wmi_rfkill2_setup(struct platf=
orm_device *device)
>  =09return err;
>  }
>
> -static int thermal_profile_setup(struct platform_device *device)
> +static int thermal_profile_get(void)
>  {
> -=09int err, tp;
> +=09int tp;
>
>  =09tp =3D hp_wmi_read_int(HPWMI_THERMAL_PROFILE_QUERY);
> +
> +=09return tp;
> +}

Is there any reason why you didn't write

  return hp_wmi_read_int(...);

?


> +
> +static int thermal_profile_set(int thermal_profile)
> +{
> +=09int err;
> +
> +=09err =3D hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE=
, &thermal_profile,
> +=09=09=09=09=09=09=09   sizeof(thermal_profile), 0);
> +=09if (err)
> +=09=09return err;
> +
> +=09return 0;
> +}

Here as well?


> +
> +static int platform_profile_get(struct platform_profile_handler *pprof,
> +=09=09=09=09enum platform_profile_option *profile)
> +{
> +=09int tp =3D thermal_profile_get();
> +
> +=09switch (tp) {
> +=09case HP_THERMAL_PROFILE_PERFORMANCE:
> +=09=09*profile =3D  PLATFORM_PROFILE_PERFORMANCE;
> +=09=09break;
> +=09case HP_THERMAL_PROFILE_DEFAULT:
> +=09=09*profile =3D  PLATFORM_PROFILE_BALANCED;
> +=09=09break;
> +=09case HP_THERMAL_PROFILE_COOL:
> +=09=09*profile =3D  PLATFORM_PROFILE_COOL;
> +=09=09break;
> +=09default:
> +=09=09return -EINVAL;

I think error values (tp < 0) could possibly be propagated.


> +=09}
> +
> +=09return 0;
> +}
> +
> +static int platform_profile_set(struct platform_profile_handler *pprof,
> +=09=09=09=09enum platform_profile_option profile)
> +{
> +=09int err, tp;
> +
> +=09switch (profile) {
> +=09case PLATFORM_PROFILE_PERFORMANCE:
> +=09=09tp =3D  HP_THERMAL_PROFILE_PERFORMANCE;
> +=09=09break;
> +=09case PLATFORM_PROFILE_BALANCED:
> +=09=09tp =3D  HP_THERMAL_PROFILE_DEFAULT;
> +=09=09break;
> +=09case PLATFORM_PROFILE_COOL:
> +=09=09tp =3D  HP_THERMAL_PROFILE_COOL;
> +=09=09break;
> +=09default:
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09err =3D thermal_profile_set(tp);
> +=09if (err)
> +=09=09return err;
> +
> +=09return 0;
> +}
> +
> +static int thermal_profile_setup(void)
> +{
> +=09int err, tp;
> +
> +=09tp =3D thermal_profile_get();
>  =09if (tp < 0)
>  =09=09return tp;
>
> @@ -881,11 +959,23 @@ static int thermal_profile_setup(struct platform_de=
vice *device)
>  =09 * call thermal profile write command to ensure that the firmware cor=
rectly
>  =09 * sets the OEM variables for the DPTF
>  =09 */
> -=09err =3D hp_wmi_perform_query(HPWMI_THERMAL_PROFILE_QUERY, HPWMI_WRITE=
, &tp,
> -=09=09=09=09=09=09=09   sizeof(tp), 0);
> +=09err =3D thermal_profile_set(tp);
>  =09if (err)
>  =09=09return err;
>
> +=09platform_profile_handler.profile_get =3D platform_profile_get,
> +=09platform_profile_handler.profile_set =3D platform_profile_set,
> +
> +=09set_bit(PLATFORM_PROFILE_COOL, platform_profile_handler.choices);
> +=09set_bit(PLATFORM_PROFILE_BALANCED, platform_profile_handler.choices);
> +=09set_bit(PLATFORM_PROFILE_PERFORMANCE, platform_profile_handler.choice=
s);
> +
> +=09err =3D platform_profile_register(&platform_profile_handler);
> +=09if (err)
> +=09=09return err;
> +
> +=09platform_profile_support =3D 1;
> +
>  =09return 0;
>  }
>
> @@ -900,7 +990,7 @@ static int __init hp_wmi_bios_setup(struct platform_d=
evice *device)
>  =09if (hp_wmi_rfkill_setup(device))
>  =09=09hp_wmi_rfkill2_setup(device);
>
> -=09thermal_profile_setup(device);
> +=09thermal_profile_setup();
>
>  =09return 0;
>  }
> @@ -1030,5 +1120,8 @@ static void __exit hp_wmi_exit(void)
>  =09=09platform_device_unregister(hp_wmi_platform_dev);
>  =09=09platform_driver_unregister(&hp_wmi_driver);
>  =09}
> +
> +=09if (platform_profile_support)
> +=09=09platform_profile_remove();

I personally don't like the asymmetry that hp_wmi_bios_setup() registers (e=
ven
if only indirectly), but hp_wmi_exit() removes. I'd put this in hp_wmi_bios=
_remove().


>  }
>  module_exit(hp_wmi_exit);
> --
> 2.29.2


Regards,
Barnab=C3=A1s P=C5=91cze
