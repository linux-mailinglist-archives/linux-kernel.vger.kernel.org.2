Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4284108FC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 02:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240852AbhISAhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 20:37:32 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:21854 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhISAhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 20:37:31 -0400
Date:   Sun, 19 Sep 2021 00:35:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1632011760;
        bh=lkCFplV3aH3ww0qVmsgzw+bfFrt6wTRsV4S3HHrE0Qc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=WqTL7blI64SkpZxVRlKtiLLyldtAoamVL/jGSwSx3k3wNB/Dfqhxg2tycBxWBVLvd
         U91zyuXzLHUMHe8vqc99cXjDQCvvwk1vRrpqOdsXn2ij5tHStHT4kez0O/pu3VGAF1
         Ty4fJ62ozsdVfZ5kWum1YdSNZQAAf3jG+yJhV0RI=
To:     Kelly Anderson <kelly@xilka.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     ike.pan@canonical.com, hdegoede@redhat.com, mgross@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH] add platform support for Ideapad 5 Pro 16ACH6-82L5
Message-ID: <3Soz67mh7ym93lrTM_rsCqDig9DuBcTXQH5aSd5e25ydtipCsnR5RA53p07q0f1AnPZOS18BqklcSxPEQnmtCoStolX6n4vLOAqkPcg-rgE=@protonmail.com>
In-Reply-To: <5753131.lOV4Wx5bFT@comer.internal>
References: <5753131.lOV4Wx5bFT@comer.internal>
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

+CC Mark Pearson - because he added to code originally to the thinkpad_acpi
driver with the DYTC version limitation.

Please also check the coding style guide [1].


2021. szeptember 19., vas=C3=A1rnap 0:59 keltez=C3=A9ssel, Kelly Anderson =
=C3=ADrta:
> Adding support specifically for Ideapad 5 Pro 16ACH6-82L5 by adding a
> whitelist function that can validate notebooks for which dytc_version
> is less than 5, and seem to work fine at dytc_version 4. This code has
> been tested to work properly on the specified system.
>
> Signed-off-by: Kelly Anderson <kelly@xilka.com>
>
>  drivers/platform/x86/ideapad-laptop.c | 37 ++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86=
/ideapad-laptop.c
> index e7a1299e3776..92b8f7dc79f5 100644
> --- a/drivers/platform/x86/ideapad-laptop.c
> +++ b/drivers/platform/x86/ideapad-laptop.c
> @@ -868,7 +868,28 @@ static void dytc_profile_refresh(struct ideapad_priv=
ate *priv)
>  =09}
>  }
>
> -static int ideapad_dytc_profile_init(struct ideapad_private *priv)
> +static int ideapad_dytc_v4_whitelist(struct platform_device *pdev)

Please use `bool`.


> +{
> +=09const char *vendor =3D dmi_get_system_info(DMI_SYS_VENDOR);
> +=09const char *product =3D dmi_get_system_info(DMI_PRODUCT_NAME);
> +
> +=09if ( product ) {
> +=09=09if ( vendor ) {
> +=09=09=09dev_info(&pdev->dev, "DYTC Vendor: %s\n", vendor);
> +=09=09}
> +
> +=09=09dev_info(&pdev->dev, "DYTC Product: %s\n", product);
> +
> +=09=09if ( ! strncmp(product, "82L5", 4) ) /* IdeaPad 5 Pro 16ACH6 */ {
> +=09=09=09return 1;
> +=09=09}

Have you checked if you can use `dmi_check_system()`?


> +=09}
> +
> +=09return 0;
> +}
> +
> +static int ideapad_dytc_profile_init(struct platform_device *pdev,
> +=09=09=09=09struct ideapad_private *priv)
>  {
>  =09int err, dytc_version;
>  =09unsigned long output;
> @@ -883,11 +904,21 @@ static int ideapad_dytc_profile_init(struct ideapad=
_private *priv)
>
>  =09/* Check DYTC is enabled and supports mode setting */
>  =09if (!test_bit(DYTC_QUERY_ENABLE_BIT, &output))
> +=09{
> +=09=09dev_info(&pdev->dev, "DYTC_QUERY_ENABLE_BIT returned false\n");
>  =09=09return -ENODEV;
> +=09}
>
>  =09dytc_version =3D (output >> DYTC_QUERY_REV_BIT) & 0xF;
> +
>  =09if (dytc_version < 5)
> -=09=09return -ENODEV;
> +=09{
> +=09=09if ( dytc_version < 4 || ! ideapad_dytc_v4_whitelist(pdev) )
> +=09=09{
> +=09=09=09dev_info(&pdev->dev, "DYTC_VERSION is less than 4 or is not whi=
telisted: %d\n", dytc_version);
> +=09=09=09return -ENODEV;
> +=09=09}
> +=09}
>
>  =09priv->dytc =3D kzalloc(sizeof(*priv->dytc), GFP_KERNEL);
>  =09if (!priv->dytc)
> @@ -1595,7 +1626,7 @@ static int ideapad_acpi_add(struct platform_device =
*pdev)
>  =09ideapad_sync_rfk_state(priv);
>  =09ideapad_sync_touchpad_state(priv);
>
> -=09err =3D ideapad_dytc_profile_init(priv);
> +=09err =3D ideapad_dytc_profile_init(pdev, priv);

The platform device is already available via `priv->platform_device`.


>  =09if (err) {
>  =09=09if (err !=3D -ENODEV)
>  =09=09=09dev_warn(&pdev->dev, "Could not set up DYTC interface: %d\n", e=
rr);
> --
> 2.33.0

[1]: https://www.kernel.org/doc/html/latest/process/coding-style.html


Regards,
Barnab=C3=A1s P=C5=91cze
