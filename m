Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822BA45E3BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351602AbhKZAlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244362AbhKZAjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:39:43 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10141C0613E1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:33:43 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r26so15627970oiw.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wx6Lre/FTRaYP7Is5riEW5pRWhsJX4cKj5NqRQzThSc=;
        b=NRSbnWOxKZkNVWUQAQwSoDFrn2GECScFvopaEjnHRamjfijmCRYWeYsJ00frHFcjkk
         usiUMEJK595ZJaVYGufyFOWpOvmJ2Otpz8XvKNt3V4uP1QRG0rfTsirYe7kKKCiKHY0l
         Ok98HXXplUNDbyIDCpEd2YBdmNxGBKGtN+5IBjlZ4jJMWgwEcwib32Zz/zcmse59w0WD
         C/3hG+QF5cBSLv06oZvS+4z9PxYhQm54q5VjqVR3rxOzeVloztXiI8Hreqh7OKjPTSiY
         MTA6AvZKCvSUHtuoVe2HeKCcCntSdORm3XjBRHaIOOVHG34jgU1XQYERMG2HK8b08r6M
         TfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wx6Lre/FTRaYP7Is5riEW5pRWhsJX4cKj5NqRQzThSc=;
        b=S697w41yhBCHkTDvH95Y4iNPRj0zC8I4G3kOgjm61TCLoVCtovwrWKMAfeBbv6uF+G
         VGFVTvnzJjA6V0nEB61Q0FoI2DYaj6fLlBiv50H14Rl1oE5zyBGQU8ydWvgzXVYarPaA
         ayZCUUqCKzoG0F9ZaSMp9r+VlYAi+qSNzGCjDCXp9IIzZqEdhUYNLQMMSVg1IxE+TWvW
         URLRiwMyJKd8x5bVtjtiUT3o47d+I3dgQy6ssJYhbhCVd30yWdHHB8mUxV4HjiF2jIKO
         v66a6AehI1iqSb58OAvsH3UNpZY/5Uo9O2grb5t3nNXLZgE1es/RWhTOd0ZIi2WNKrl2
         8YFA==
X-Gm-Message-State: AOAM5322K+rZvdil64G+mDbE6gyDQdv0hEgAo/rrWfOVdvZzL5YMRtPX
        IrbrUNEXIEEc8ZN6yJmv5o8xs8ULo6ZUqOILaF06yw==
X-Google-Smtp-Source: ABdhPJwgB6TLAOnlEmGYCT6cRaq84tftvhq3x9i14xmCeBq8BnVeKoXTirpt/FSbuhEm+BGOR1qfH64xNOMA8+zN0cg=
X-Received: by 2002:a54:4791:: with SMTP id o17mr20157592oic.114.1637886822370;
 Thu, 25 Nov 2021 16:33:42 -0800 (PST)
MIME-Version: 1.0
References: <20211123155144.21708-1-lakshmi.sowjanya.d@intel.com> <20211123155144.21708-3-lakshmi.sowjanya.d@intel.com>
In-Reply-To: <20211123155144.21708-3-lakshmi.sowjanya.d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Nov 2021 01:33:31 +0100
Message-ID: <CACRpkdanKspORKBa2ETRvQyBkzgCssca-fFE+QcybZY=GYmMAQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] pinctrl: Add Intel Thunder Bay pinctrl driver
To:     lakshmi.sowjanya.d@intel.com
Cc:     linux-gpio@vger.kernel.org, bgolaszewski@baylibre.com,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        tamal.saha@intel.com, pandith.n@intel.com,
        kenchappa.demakkanavar@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lakshmi,

thanks for your patch! Interesting chip! This is looking very good.

I bet Andy will also give you some attention to details unless you
had some already internally at Intel.

On Tue, Nov 23, 2021 at 4:52 PM <lakshmi.sowjanya.d@intel.com> wrote:

This caught my eye:

> +#define THB_BOARD_SPECIFIC_GPIO_REQUIREMENTS_HANDLE    (1u)

We don't do this kind of conditionals, either it is there or not.
Drop this define since it is always 1

> +#if (THB_BOARD_SPECIFIC_GPIO_REQUIREMENTS_HANDLE)
> +
> +static u32 thb_gpio_board_requirements_handle(struct gpio_chip *chip)
> +{
> +       u32 offset, reg;
> +
> +       /* 0x43 = register Offset for gpio_power_int_setup/4u */
> +       offset = 0x43;
> +       reg = thb_gpio_read_reg(chip, offset);
> +
> +       /* Keeping all power interrupts to Level-High triggered as suggested by HW team */
> +       reg |= 0x1E;
> +
> +       return thb_gpio_write_reg(chip, offset, reg);
> +}

This looks like something that can just be inlined into probe(), some HW
set-up?

> +       struct gpio_chip *chip = &tpc->chip;
(..)
> +       chip->get               = thunderbay_gpio_get_value;
> +       chip->set               = thunderbay_gpio_set_value;

It should be trivial to also implement

.set_config = gpiochip_generic_config

just like the other Intel drivers. This is great because it will make
things like the generic bit-banged GPIO I2C bus use the open drain
hardware support from the chip. (Etc)

> +       /* Register pin mapping between GPIO and PinControl */
> +       ret = gpiochip_add_pin_range(chip, dev_name(tpc->dev), 0, 0, chip->ngpio);
> +       if (ret) {
> +               dev_err(tpc->dev, "Failed to add gpiochip pin range\n");
> +               return ret;
> +       }

It's usually better to put these ranges into the device tree. The
gpiolib core will handle it. See gpio-ranges in
Documentation/devicetree/bindings/gpio/gpio.txt

> +#if (THB_BOARD_SPECIFIC_GPIO_REQUIREMENTS_HANDLE)
> +       /* function to handle THB board specific requirements */
> +       ret = thb_gpio_board_requirements_handle(chip);
> +#endif

Just inline that function's code in here.

Yours,
Linus Walleij
