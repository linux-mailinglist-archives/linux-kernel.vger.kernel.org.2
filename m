Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF9B32A7C4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1839578AbhCBQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 11:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348281AbhCBOLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:11:21 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EFFC061794
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 06:02:15 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 2so19525311ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 06:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o7INF3juUNLA/dEPPd23yD+LmAjWEiZmMoeuwVdPOW0=;
        b=mj19Huw4fC9WNivCBbf7oQoawuHXVDTBbbEr8E/p3cBw//+tin1USrJIgedls64CLN
         wkFvO6zMYQfI9kwrMQP7HUssGPb44/KqdTBUWhS8NI3JypHjvswEJHeuqNO5nl/vJ7rF
         bkGcipeWG5KG5U4DayR/MFtea22YC+Xfzb0z7/yTBubKvLG+4vGENX48cXv4kW4Gnyww
         SEzY/LqQCwlQD6t2mk/vWOOlt8f4eDemm1/KvC0MdnE832djKnfBjQ1LK1NDyORKoxCe
         e6u3BCHEHD5+fDA9FVcGIkSuS+JpkejSR1luidCu83dEtQnPwo1ntw8UZr9G1NuWei40
         zqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o7INF3juUNLA/dEPPd23yD+LmAjWEiZmMoeuwVdPOW0=;
        b=VVCNagPnhMyII+CZDEXVoC73ozS4wt/MuIJ8S/EdxSlp8zEyTfFPI5V5N5iN4IEZW3
         tlRVhWdsCwTu4b+2Djn5I3Wav4w13SovLu3AFS3fFFkr+oTEv2Uo46ZS0Og5CREu15er
         0szTBkI8chelHu4eD1cl2XahN5ZRHZpjH8OJFVgEgWAzhk9+x2Zw0GHwEqoeTXLQlSV5
         xzW3NMMlB3DqiChsu7ETyx7A1j75JQhWlZqoiZ2RuAUJngRyuBjmKq8rW7zGHbnqPvOK
         8+q1fxtha4NtSV7rCdfSE1OFidWnUlE22WV3bXL0Wq6f1oEJNQ4UOdmTlhZIpzu2y+Aj
         NjFA==
X-Gm-Message-State: AOAM5324qZ1dafTnwce+Glgg3e8Jf2surt6cGPD0dW1xmQrGmZnmxNN1
        9UWli8sy2ynLYB/HUymcZmZwIXqILX4hYDLA0srqbA==
X-Google-Smtp-Source: ABdhPJywgWXlv71MK/GjOAyVdHmPDdmWh7ETJBLGAPYo7bSWNxpoYcaY7mqQqXb7ttmP7+LghHg0fpRHnqaHJLcGuqo=
X-Received: by 2002:a2e:9754:: with SMTP id f20mr9906273ljj.200.1614693731684;
 Tue, 02 Mar 2021 06:02:11 -0800 (PST)
MIME-Version: 1.0
References: <1614120685-7452-1-git-send-email-Asmaa@mellanox.com> <1614120685-7452-2-git-send-email-Asmaa@mellanox.com>
In-Reply-To: <1614120685-7452-2-git-send-email-Asmaa@mellanox.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 2 Mar 2021 15:02:00 +0100
Message-ID: <CACRpkdZK-iqkSD_+5y9YOSzPk9yAY2VYHSKP+tBr7kZM68g2RQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Support interrupts in gpio-mlxbf2.c
To:     Asmaa Mnebhi <Asmaa@mellanox.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Asmaa Mnebhi <asmaa@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Asmaa,

thanks for your patch!

Please send GPIO related patches to linux-gpio@vger.kernel.org!

On Tue, Feb 23, 2021 at 11:51 PM Asmaa Mnebhi <Asmaa@mellanox.com> wrote:
>
> From: Asmaa Mnebhi <asmaa@nvidia.com>
>
> There are 3 possible GPIO interrupts which can be
> supported on BlueField-2 boards. Some BlueField boards support:
> 1) PHY interrupt only
> 2) PHY interrupt and Reset interrupt
> 3) Low power interrupt only

Is this a property of the GPIO block or more of a property of the
chip?

> There is one hardware line shared among all GPIOs among other
> things. So the interrupt controller checks whether the
> hardware interrupt is from a GPIO first. Then it checks which
> GPIO block it is for. And within the GPIO block, it checks
> which GPIO pin it is for.

This is normal for cascaded GPIO interrupts.

> The "reset interrupt" and "low power interrupt" trigger a
> user space program.

Then they should be doing so using drivers in the proper kernel
subsystems, such as
drivers/power/reset/gpio-poweroff.c
drivers/power/reset/gpio-restart.c

Userspace has no business trying to intercept and take control
over such low level tasks as machine reset.

> The PHY interrupt is mapped to a linux
> IRQ and passed down to a PHY driver.

Then the phy driver should obtain its IRQ just like any other IRQ
in the system, the fact that it happens to be on a GPIO line
does not matter.

> The GPIO pin responsible for these interrupts may also change
> across boards.

That's fine, the hardware description model (I guess in your case
ACPI) should take care of that.

> The ACPI table contains a property which is assigned a valid
> GPIO pin number if the interrupt is supported on a particular
> BlueField-2 board. The bootloader will change that property
> based on the board id.

OK and then the kernel uses ACPI.

We have some ACPI experts on GPIO, and you must have noticed
that we have a special ACPI layer for gpiolib.

This is what should provide IRQ resources to your other drivers so they
can look them up with a simple
struct gpio_desc *gpiod = devm_gpiod_get(dev, ...)

NOTE: you are using GPIOLIB_IRQCHIP so you need to
add

select GPIOLIB_IRQCHIP

to Kconfig for this driver.

> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
> +
> +/*
> + *  Copyright (c) 2020-2021 NVIDIA Corporation.
> + */

Send this as a separate patch as it is only administrativa.
It's fine I think, you mostly wrote this driver.

> +#include <linux/gpio/consumer.h>

This looks weird but let's see!

> +#define DRV_VERSION "1.2"

We usually don't make this kind of stuff, skip this.
It's not like the API changes.

> +#define YU_CAUSE_GPIO_ADDR             0x2801530

Shouldn't this address come from ACPI?

> +#define YU_CAUSE_GPIO_ADDR_SIZE                0x4

Does this mean it is four bytes? That should be implied I think.

>  struct mlxbf2_gpio_context {
>         struct gpio_chip gc;
> +       struct irq_chip irq_chip;
>
>         /* YU GPIO blocks address */
>         void __iomem *gpio_io;
>
> +       /* YU cause gpio arm coalesce0 address */
> +       void __iomem *cause_gpio_arm_coalesce0_io;
> +
> +       /* YU GPIO pin responsible for low power mode */
> +       unsigned long low_pwr_pin;

I think this should be handled by a driver outside of GPIO
like those I pointed out. We need strict separation of concerns
between GPIO and other drivers.

> +       /* YU GPIO pin responsible for soft reset */
> +       unsigned long rst_pin;

Dito.

> +       /* YU GPIO pin connected to PHY INT_N signal */
> +       unsigned long phy_int_pin;

Dito. Should be handled by the PHY driver.

> +static void mlxbf2_gpio_send_work(struct work_struct *work)
> +{
> +       struct mlxbf2_gpio_context *gs;
> +
> +       gs = container_of(work, struct mlxbf2_gpio_context, send_work);
> +
> +       acpi_bus_generate_netlink_event("button/power.*", "Power Button",
> +                                       0x80, 1);
> +}

Uh oh that's interesting. I need someone from ACPI camp to look at this.

To me it seems more like something that either ACPI should handle internally
or, if that is impossible, something that could be added to
drivers/power/reset/gpio-poweroff.c

> +static bool mlxbf2_gpio_is_acpi_event(u32 gpio_block, unsigned long gpio_pin,
> +                         struct mlxbf2_gpio_context *gs)
> +{
> +       if (gpio_block & BIT(GPIO_BLOCK0)) {
> +               if (gpio_pin & BIT(gs->rst_pin))
> +                       return true;
> +       }
> +       if (gpio_block & BIT(GPIO_BLOCK16)) {
> +               if (gpio_pin & BIT(gs->low_pwr_pin))
> +                       return true;
> +       }
> +
> +       return false;
> +}
(...)
> +       if (mlxbf2_gpio_is_acpi_event(gpio_block, gpio_pin, gs))
> +               schedule_work(&gs->send_work);

So you determine that some line is an "ACPI event" using some hardware
registers? I don't know, this looks fragile.

> +static int mlxbf2_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
> +{
> +       struct mlxbf2_gpio_context *gs;
> +
> +       gs = gpiochip_get_data(chip);
> +
> +       return irq_create_mapping(gs->gc.irq.domain, gpio);
> +}

I would rather you use the built-in gpiolib irqchip IRQ domain
for this. I think you can just delete this. The core should provide it.

> +       spin_lock_init(&gs->gc.bgpio_lock);

Why? This should be initialized by the core as an effect
of bgpio_init().

> +       if (ret) {
> +               dev_err(dev, "bgpio_init failed\n");
> +               return ret;
> +       }

Maybe a separate patch adding some debug print? Not the biggest thing but...

>         gc->direction_input = mlxbf2_gpio_direction_input;
>         gc->direction_output = mlxbf2_gpio_direction_output;
>         gc->ngpio = npins;
>         gc->owner = THIS_MODULE;
> +       gc->to_irq = mlxbf2_gpio_to_irq;

Drop this.

> +       /*
> +        * PHY interrupt
> +        */
> +       ret = device_property_read_u32(dev, "phy-int-pin", &phy_int_pin);
> +       if (ret < 0)
> +               phy_int_pin = MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
> +
> +       /*
> +        * OCP3.0 supports the low power mode interrupt.
> +        */
> +       ret = device_property_read_u32(dev, "low-pwr-pin", &low_pwr_pin);
> +       if (ret < 0)
> +               low_pwr_pin = MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
> +
> +       /*
> +        * BlueSphere and the PRIS boards support the reset interrupt.
> +        */
> +       ret = device_property_read_u32(dev, "rst-pin", &rst_pin);
> +       if (ret < 0)
> +               rst_pin = MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
> +
> +       gs->phy_int_pin = phy_int_pin;
> +       gs->low_pwr_pin = low_pwr_pin;
> +       gs->rst_pin = rst_pin;

I see what you are doing but why on earth are these resources tied to
this interrupt controller? They should be resources for something else
in my mind, however I don't know much about ACPI.

> +               irq = platform_get_irq(pdev, 0);
> +               ret = devm_request_irq(dev, irq, mlxbf2_gpio_irq_handler,
> +                                      IRQF_ONESHOT | IRQF_SHARED, name, gs);

Why is it oneshot? That is usually just useful for threaded IRQs.

> +       if (phy_int_pin != MLXBF2_GPIO_MAX_PINS_PER_BLOCK) {
> +               /* Create phy irq mapping */
> +               mlxbf2_gpio_to_irq(&gs->gc, phy_int_pin);
> +               /* Enable sharing the irq domain with the PHY driver */
> +               irq_set_default_host(gs->gc.irq.domain);
> +       }

Ugh this is messy, we need to provide the IRQs out of the driver in
a clean way.

Yours,
Linus Walleij
