Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F403E3569
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbhHGNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHGNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 09:06:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF768C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 06:05:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gs8so20171488ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 06:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBXaWvPOl6I6bcA925OtEe/z9IAxFQ83nzsuTJQY88U=;
        b=fxL373qduGCoLF5NdCPJ8CauIF9rtY9gBa2BcROftxjq012XmxT6GfvEPvdarYWV7A
         ndaibe3bpFCJCz+mONsoGON5VAOXheRImPaYeiq2s9mijv9P8eauKJLX0c7ko7lSwCEA
         Yg+77Akkg7Hq8NIx7OcT6OH3LX2X1JmpXZxMhw32HUqJP/VomBnnmisIZooGyougZ0GL
         XV1mzRE3NPBzPKFfDI6qkkcv8hjpJP6dYIAP3MX+1gw/0kj51SPWM+qqDaLCUKZph4Fu
         SxMWaeS0gdeYDJt8PGU0d0SPRJQo5Wa8zReni4rPB+5mWWnQvI9mbCAW8LWXLjFPdYUL
         TjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBXaWvPOl6I6bcA925OtEe/z9IAxFQ83nzsuTJQY88U=;
        b=ZkSMmWfJoOar5Ld4rTrlun8ymPVE9bxx7gjPWDrQB33vr+UbcLX0lVQZ4J/CO0Oy6H
         VT8FCXGo3uEHazjxoaR47WfqhujQj0T/tI6NxsBahRpG0JOQPPd+ur69uJSIcqzRFTiv
         8sL0YYbOmEe/V3B8n9193mjC3lgpGVbrqZucbfNsr/2fbsdobttm/jmT+F7mg4skwBCp
         4nKaT6GC9ZV7Agsj2eTM55QD4rDBEEd+RG6Q4OmwnM9i0aVoHqNqSm+L4KfC5nt4q3E6
         mKYwnoZNdU9+TvtAruy7nWdsKwEP4xriAMVLV8tmGTV2KlbLoSA5vcnu6yECGm6S1fF8
         fuaw==
X-Gm-Message-State: AOAM5335dk8qZZ9osBzh5ICjCvZtSxQmP02ypyVF+vFOwTM1xixAMFiA
        Dt7gGsglhVCVwWp/cfCZZjuG4VaNtQcKCchhA1YX5IMJEWk=
X-Google-Smtp-Source: ABdhPJwAGdL3YdVWYfUy2ws/I3Wd7rN6nrVANlbHlFiqGtUTOJrFqQR8/sDlZ/MkAt2snTqSj/3YM3xICSiWDxBaV0s=
X-Received: by 2002:a17:907:f87:: with SMTP id kb7mr14742378ejc.58.1628341549394;
 Sat, 07 Aug 2021 06:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210807002722.2634585-1-jsavitz@redhat.com> <20210807002722.2634585-3-jsavitz@redhat.com>
In-Reply-To: <20210807002722.2634585-3-jsavitz@redhat.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Sat, 7 Aug 2021 14:05:38 +0100
Message-ID: <CALeDE9MeYEwScfoP8gApD95sv+ONWLw79v1F6g=aBg+QZZ-3nQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drivers/mfd: rpisense: Raspberry Pi senseHAT
 joystick driver
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Charles Mirabile <cmirabil@redhat.com>,
        linux-rpi-kernel@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 7, 2021 at 1:31 AM Joel Savitz <jsavitz@redhat.com> wrote:
>
> This patch implements support for the joystick, including a threaded
> IRQ routine.

If you look at this on it's own, remember the cover letter doesn't go
into git, it's not overly descriptive. We know it's a patch. What does
the "threaded IRQ routine" do in the context, why is that specifically
called out.

Something like:
A simple joystick with up/down/left/right and enter attached via i2c

> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  drivers/mfd/Makefile      |   1 +
>  drivers/mfd/rpisense-js.c | 132 ++++++++++++++++++++++++++++++++++++++

This driver should be in drivers/input/joystick/

>  2 files changed, 133 insertions(+)
>  create mode 100644 drivers/mfd/rpisense-js.c
>
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 76f9a9221241..71356153ccdc 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -264,6 +264,7 @@ obj-$(CONFIG_MFD_ROHM_BD957XMUF)    += rohm-bd9576.o
>  obj-$(CONFIG_MFD_STMFX)        += stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU)   += khadas-mcu.o
>  obj-$(CONFIG_MFD_RPISENSE)     += rpisense-core.o
> +obj-$(CONFIG_MFD_RPISENSE)     += rpisense-js.o

While it's unlikely that these will be used without one another I
still believe this needs it's own Kconfig entry.

>  obj-$(CONFIG_MFD_ACER_A500_EC) += acer-ec-a500.o
>  obj-$(CONFIG_MFD_QCOM_PM8008)  += qcom-pm8008.o
>
> diff --git a/drivers/mfd/rpisense-js.c b/drivers/mfd/rpisense-js.c
> new file mode 100644
> index 000000000000..c6c97bff118c
> --- /dev/null
> +++ b/drivers/mfd/rpisense-js.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Raspberry Pi Sense HAT joystick driver
> + * http://raspberrypi.org
> + *
> + * Copyright (C) 2015 Raspberry Pi
> + * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + *
> + * Original Author: Serge Schneider
> + * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
> + */
> +
> +#include <linux/module.h>
> +#include <linux/input.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/mfd/rpisense.h>
> +
> +static unsigned char keymap[] = {KEY_DOWN, KEY_RIGHT, KEY_UP, KEY_ENTER, KEY_LEFT,};
> +
> +static irqreturn_t rpisense_js_report(int n, void *cookie)
> +{
> +       int i;
> +       static s32 prev_keys;
> +       struct rpisense *rpisense = cookie;
> +       struct rpisense_js *rpisense_js = &rpisense->joystick;
> +       s32 keys = rpisense_get_joystick_state(rpisense);
> +       s32 changes = keys ^ prev_keys;
> +
> +       prev_keys = keys;
> +       for (i = 0; i < ARRAY_SIZE(keymap); ++i) {
> +               if (changes & (1<<i)) {
> +                       input_report_key(rpisense_js->keys_dev,
> +                                        keymap[i], keys & (1<<i));
> +               }
> +       }
> +       input_sync(rpisense_js->keys_dev);
> +       return IRQ_HANDLED;
> +}
> +
> +static int rpisense_js_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       int i;
> +       struct rpisense *rpisense = dev_get_drvdata(&pdev->dev);
> +       struct rpisense_js *rpisense_js = &rpisense->joystick;
> +
> +       rpisense_js->keys_desc = devm_gpiod_get(&rpisense->i2c_client->dev,
> +                                               "keys-int", GPIOD_IN);
> +       if (IS_ERR(rpisense_js->keys_desc)) {
> +               dev_warn(&pdev->dev, "Failed to get keys-int descriptor.\n");
> +               return PTR_ERR(rpisense_js->keys_desc);
> +       }
> +
> +
> +       rpisense_js->keys_dev = devm_input_allocate_device(&pdev->dev);
> +       if (rpisense_js->keys_dev == NULL) {
> +               dev_err(&pdev->dev, "Could not allocate input device.\n");
> +               return -ENOMEM;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(keymap); i++) {
> +               set_bit(keymap[i],
> +                       rpisense_js->keys_dev->keybit);
> +       }
> +
> +       rpisense_js->keys_dev->name = "Raspberry Pi Sense HAT Joystick";
> +       rpisense_js->keys_dev->phys = "rpi-sense-joy/input0";
> +       rpisense_js->keys_dev->id.bustype = BUS_I2C;
> +       rpisense_js->keys_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +       rpisense_js->keys_dev->keycode = keymap;
> +       rpisense_js->keys_dev->keycodesize = sizeof(unsigned char);
> +       rpisense_js->keys_dev->keycodemax = ARRAY_SIZE(keymap);
> +
> +       ret = input_register_device(rpisense_js->keys_dev);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Could not register input device.\n");
> +               return ret;
> +       }
> +
> +       ret = gpiod_direction_input(rpisense_js->keys_desc);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Could not set keys-int direction.\n");
> +               return ret;
> +       }
> +
> +       rpisense_js->keys_irq = gpiod_to_irq(rpisense_js->keys_desc);
> +       if (rpisense_js->keys_irq < 0) {
> +               dev_err(&pdev->dev, "Could not determine keys-int IRQ.\n");
> +               return rpisense_js->keys_irq;
> +       }
> +
> +       ret = devm_request_threaded_irq(&pdev->dev, rpisense_js->keys_irq,
> +               NULL, rpisense_js_report, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +               "keys", rpisense);
> +
> +       if (ret) {
> +               dev_err(&pdev->dev, "IRQ request failed.\n");
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id rpisense_js_id[] = {
> +       { .compatible = "rpi,rpi-sense-js" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, rpisense_js_id);
> +#endif
> +
> +static struct platform_device_id rpisense_js_device_id[] = {
> +       { .name = "rpi-sense-js" },
> +       { },
> +};
> +MODULE_DEVICE_TABLE(platform, rpisense_js_device_id);
> +
> +static struct platform_driver rpisense_js_driver = {
> +       .probe = rpisense_js_probe,
> +       .driver = {
> +               .name = "rpi-sense-js",
> +       },
> +};
> +
> +module_platform_driver(rpisense_js_driver);
> +
> +MODULE_DESCRIPTION("Raspberry Pi Sense HAT joystick driver");
> +MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");

If you're leaving Serge as the module author should be copied in the
patch series.

> +MODULE_LICENSE("GPL");
> --
> 2.27.0
>
>
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
