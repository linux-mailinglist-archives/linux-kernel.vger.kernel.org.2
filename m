Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E054125D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384117AbhITSsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:48:42 -0400
Received: from mail-0301.mail-europe.com ([188.165.51.139]:58799 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383476AbhITSoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 14:44:37 -0400
Date:   Mon, 20 Sep 2021 18:43:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632163386;
        bh=/dCPObPUPU/gLuQE7BcDq2GKMnutPsgeme1TLL+i1X8=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=LXJlDbv/5HUdDFxFWVaJ5m4aeqMgCjK/JDv5MifAyIggBs09G1vantspUmWIZ7gAs
         H3vG8NnKotCXCGQhd7o4I0pg1yyS0NBlnKQxNbXCkPql09l/rRGrThwTljm5ekslF5
         YU2ZwkVoWQYGpf1igJ47A1Tw6ZNoijuUbqDrxE6s=
To:     =?utf-8?Q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, alex.hung@canonical.com,
        mgross@linux.intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tobias Gurtzick <magic@wizardtales.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] platform/x86/intel: hid: Add DMI switches allow list
Message-ID: <NgI8poho2fFBrbj2ivUSWphaZbwgMIxHVovWWqI2UWdJA8FNhlDtkFk-Y7cp4mYxiiOtkFQHoCQj-kkGh71lQfsvzJ1sg0IgixkJqdEdcnM=@protonmail.com>
In-Reply-To: <20210920160312.9787-1-jose.exposito89@gmail.com>
References: <20210920160312.9787-1-jose.exposito89@gmail.com>
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


2021. szeptember 20., h=C3=A9tf=C5=91 18:03 keltez=C3=A9ssel, Jos=C3=A9 Exp=
=C3=B3sito =C3=ADrta:
> Some devices, even non convertible ones, can send incorrect
> SW_TABLET_MODE reports.
>
> Add an allow list and accept such reports only from devices in it.
>
> Bug reported for Dell XPS 17 9710 on:
> https://gitlab.freedesktop.org/libinput/libinput/-/issues/662
>
> Reported-by: Tobias Gurtzick <magic@wizardtales.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Tobias Gurtzick <magic@wizardtales.com>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> ---
>  drivers/platform/x86/intel/hid.c | 33 +++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/inte=
l/hid.c
> index a33a5826e81a..24d26336e39a 100644
> --- a/drivers/platform/x86/intel/hid.c
> +++ b/drivers/platform/x86/intel/hid.c
> @@ -118,6 +118,24 @@ static const struct dmi_system_id dmi_vgbs_allow_lis=
t[] =3D {
>  =09{ }
>  };
>
> +/*
> + * Some devices, even non convertible ones, can send incorrect SW_TABLET=
_MODE
> + * reports. Accept such reports only from devices in this list.
> + */
> +static const struct dmi_system_id dmi_switches_auto_add_allow_list[] =3D=
 {
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "31" /* Convertible */),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_EXACT_MATCH(DMI_CHASSIS_TYPE, "32" /* Detachable */),
> +=09=09},
> +=09},
> +=09{} /* Array terminator */
> +};
> +
>  struct intel_hid_priv {
>  =09struct input_dev *input_dev;
>  =09struct input_dev *array;
> @@ -455,11 +473,16 @@ static void notify_handler(acpi_handle handle, u32 =
event, void *context)
>  =09 *
>  =09 * See dual_accel_detect.h for more info on the dual_accel check.
>  =09 */
> -=09if (!priv->switches && !priv->dual_accel && (event =3D=3D 0xcc || eve=
nt =3D=3D 0xcd)) {
> -=09=09dev_info(&device->dev, "switch event received, enable switches sup=
ports\n");
> -=09=09err =3D intel_hid_switches_setup(device);
> -=09=09if (err)
> -=09=09=09pr_err("Failed to setup Intel HID switches\n");
> +=09if (event =3D=3D 0xcc || event =3D=3D 0xcd) {
> +=09=09if (!dmi_check_system(dmi_switches_auto_add_allow_list))
> +=09=09=09return;

I think you should not check it every time. Maybe add a `bool` member
to `struct intel_hid_priv`. Or maybe better: rename `dual_accel` to somethi=
ng like
`autodetect_switch` and initialize it with `!dual_accel_detect() && dmi_che=
ck_system(...)`.


> +
> +=09=09if (!priv->switches && !priv->dual_accel) {
> +=09=09=09dev_info(&device->dev, "switch event received, enable switches =
supports\n");
> +=09=09=09err =3D intel_hid_switches_setup(device);
> +=09=09=09if (err)
> +=09=09=09=09pr_err("Failed to setup Intel HID switches\n");
> +=09=09}
>  =09}
>
>  =09if (priv->wakeup_mode) {
> --
> 2.25.1
>
>


Regards,
Barnab=C3=A1s P=C5=91cze
