Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739BB40CAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhIOQqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhIOQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:46:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:45:23 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id q3so5923266edt.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yjDrpYKNuHJzJKyRxhO/knOzWnL7kiLXru/IY6Rh4eg=;
        b=WWpZtN78aUpTIuElwTJGOAxjrczueKqQggCwjeEflgkb0xGJAhSYJ/i4JVzeVokcr0
         vxbZg0lxQCriVFCGkTqRrD9cIIBquCoSblXq6NcAD3Uv8GqPfKgTQWoYNbO+3CYsj28T
         Ia9NUIFx2V2bB/MppwOrB9xobHsJtwcsYVcvq5i/3DZImXacR8XiJW+cBfKZSAgrkggs
         2l7JAY5xTlIdSjH/UZl5JnvPW9u19wvJFczA85zaDnVRtrVMDKLxPopQ4GbC9wgq2lkP
         uwdoGmdcoc16tND2F2g0Oyc2F971sb17dksLpJaQh3yumt4NbJjxTmCvU2PVX3HOt+RS
         Nszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yjDrpYKNuHJzJKyRxhO/knOzWnL7kiLXru/IY6Rh4eg=;
        b=Ym7B2w6bywnTHRlv2ZtSuAYQjWT7Uyrn8xJS4Nnqb262+zounz5cNfPjSdZ2sdSNt3
         mVhauzjpNAwDd+hgwVuzlapSKhxrIw9jNtOAg8Poc2GMSllbKYz/PkJC9Fn06iDLZJkB
         NjFPUTYkaXslEq6ABxub5GhnwaRzOqPFjLuP7aD4UYuVICAqpGxsn3lyvDlav7AUpM/P
         TxCRl7hmzzk8mQ+4tklB3nHczsv/fobLBjb6cfB0oQErMFzCJzdMAN1uafxKT/ZbJX3w
         76cHkpUoRpYfQpKg/HFe4Z0so8m97ZdyP7xVZ9hG1TjJlBCV8ntFO0bU/og9h3zGELWK
         WGNA==
X-Gm-Message-State: AOAM530SHmFLmgBubYFp9jPWlSFffMd7O5oBIycfZZDP1SY6pKj/Qoxp
        9j7X7q/8bcGMhfaWkMSCIyK1xFh4ijATGWeBu71xlv77UDGFnA==
X-Google-Smtp-Source: ABdhPJyY/5Ha5mNHn/Rc+FDTHzEYvC6y67UmYbly+9kCrNJilhnxCoaHFAmBEHMsKH4z53y5iiAhkwujn++7c668rfI=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr937027ejd.425.1631724322091;
 Wed, 15 Sep 2021 09:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210914144232.511697-1-geert@linux-m68k.org>
In-Reply-To: <20210914144232.511697-1-geert@linux-m68k.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Sep 2021 19:44:45 +0300
Message-ID: <CAHp75VfR47ybHHA-yKxrqCDLHdvdfKRPtiZXQfbmr-Q4cvs4XA@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: ht16k33: Make use of device properties
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 5:42 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> The device property API allows drivers to gather device resources from
> different sources, such as ACPI, and lift the dependency on Device Tree.
> Convert the driver to unleash the power of the device property API.


With or without the nit-pick below
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Suggested-by: Marek Beh=C3=BAn <kabel@kernel.org>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Compile-tested only for the !OF case.
>
> This depends on "[PATCH v6 00/19] auxdisplay: ht16k33: Add character disp=
lay
> support"
> (https://lore.kernel.org/r/20210914143835.511051-1-geert@linux-m68k.org)
>
>  drivers/auxdisplay/Kconfig   |  2 +-
>  drivers/auxdisplay/ht16k33.c | 25 +++++++++++--------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index e32ef7f9945d49b2..64012cda4d126707 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -169,7 +169,7 @@ config IMG_ASCII_LCD
>
>  config HT16K33
>         tristate "Holtek Ht16K33 LED controller with keyscan"
> -       depends on FB && OF && I2C && INPUT
> +       depends on FB && I2C && INPUT
>         select FB_SYS_FOPS
>         select FB_SYS_FILLRECT
>         select FB_SYS_COPYAREA
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index 89ee5b4b3dfccb68..e5b810e37e0337a6 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -12,7 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/i2c.h>
> -#include <linux/of.h>
> +#include <linux/property.h>
>  #include <linux/fb.h>
>  #include <linux/slab.h>
>  #include <linux/backlight.h>
> @@ -481,15 +481,13 @@ static int ht16k33_led_probe(struct device *dev, st=
ruct led_classdev *led,
>                              unsigned int brightness)
>  {
>         struct led_init_data init_data =3D {};
> -       struct device_node *node;
>         int err;
>
>         /* The LED is optional */
> -       node =3D of_get_child_by_name(dev->of_node, "led");
> -       if (!node)
> +       init_data.fwnode =3D device_get_named_child_node(dev, "led");
> +       if (!init_data.fwnode)
>                 return 0;
>
> -       init_data.fwnode =3D of_fwnode_handle(node);
>         init_data.devicename =3D "auxdisplay";
>         init_data.devname_mandatory =3D true;
>
> @@ -510,7 +508,6 @@ static int ht16k33_keypad_probe(struct i2c_client *cl=
ient,
>                                 struct ht16k33_keypad *keypad)
>  {
>         struct device *dev =3D &client->dev;
> -       struct device_node *node =3D dev->of_node;
>         u32 rows =3D HT16K33_MATRIX_KEYPAD_MAX_ROWS;
>         u32 cols =3D HT16K33_MATRIX_KEYPAD_MAX_COLS;
>         int err;
> @@ -529,11 +526,11 @@ static int ht16k33_keypad_probe(struct i2c_client *=
client,
>         keypad->dev->open =3D ht16k33_keypad_start;
>         keypad->dev->close =3D ht16k33_keypad_stop;
>
> -       if (!of_get_property(node, "linux,no-autorepeat", NULL))
> +       if (!device_property_present(dev, "linux,no-autorepeat"))

If it's boolean property one may use device_property_read_bool()...

>                 __set_bit(EV_REP, keypad->dev->evbit);

...or put it as a parameter to __assign_bit(), for example.

>
> -       err =3D of_property_read_u32(node, "debounce-delay-ms",
> -                                  &keypad->debounce_ms);
> +       err =3D device_property_read_u32(dev, "debounce-delay-ms",
> +                                      &keypad->debounce_ms);
>         if (err) {
>                 dev_err(dev, "key debounce delay not specified\n");
>                 return err;
> @@ -620,8 +617,8 @@ static int ht16k33_fbdev_probe(struct device *dev, st=
ruct ht16k33_priv *priv,
>                 goto err_fbdev_buffer;
>         }
>
> -       err =3D of_property_read_u32(dev->of_node, "refresh-rate-hz",
> -                                  &fbdev->refresh_rate);
> +       err =3D device_property_read_u32(dev, "refresh-rate-hz",
> +                                      &fbdev->refresh_rate);
>         if (err) {
>                 dev_err(dev, "refresh rate not specified\n");
>                 goto err_fbdev_info;
> @@ -727,8 +724,8 @@ static int ht16k33_probe(struct i2c_client *client)
>         if (err)
>                 return err;
>
> -       err =3D of_property_read_u32(dev->of_node, "default-brightness-le=
vel",
> -                                  &dft_brightness);
> +       err =3D device_property_read_u32(dev, "default-brightness-level",
> +                                      &dft_brightness);
>         if (err) {
>                 dft_brightness =3D MAX_BRIGHTNESS;
>         } else if (dft_brightness > MAX_BRIGHTNESS) {
> @@ -816,7 +813,7 @@ static struct i2c_driver ht16k33_driver =3D {
>         .remove         =3D ht16k33_remove,
>         .driver         =3D {
>                 .name           =3D DRIVER_NAME,
> -               .of_match_table =3D of_match_ptr(ht16k33_of_match),
> +               .of_match_table =3D ht16k33_of_match,
>         },
>         .id_table =3D ht16k33_i2c_match,
>  };
> --
> 2.25.1
>


--=20
With Best Regards,
Andy Shevchenko
