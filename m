Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F433E91F0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhHKMvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhHKMvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:51:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A2C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:50:58 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d4so5422535lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XnUn5xinC7TQ7DvlWdoMJyb/x+Aa8xU1z0K8iDHsyQ=;
        b=AcGwxD/FnbxwTyP2occSnOgePQTrd8gNQMPZn1jZwyqRKXcEHH/I/Af5viIELcErf2
         xL6nKEJhaBUvsVQrW591BTCyqQSY96Hn+sEDyhHTQrlJw/lLG+ac2SywlO0aqM0lE5SO
         SV21UaDrPxaX+wx1AODnYn0fAWufXEXsKX+mFa295Y9SWUQoAId5iXP/nXVz3IZCuBPI
         /u68XZkSYbd4ehElQaRJp8FcfUvgKoiIPA0XW7Mlr8oku6VTMln47uo8V9ZoLdXyTXuK
         75vn+Pfx26FJFsymhCg9Aylg782SZUlm2rBXmBUHtHx/UX3W7+HFF5+hIvsaBqpy4rdx
         89aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XnUn5xinC7TQ7DvlWdoMJyb/x+Aa8xU1z0K8iDHsyQ=;
        b=r2St7md764936IE9MEFy0SbyHKsndKRfo2VfPby16ktfp1nXNp8lPefjQUDA4p05hk
         IrJtCIi7ZK0NI4D2qLp3FpZJGpoNMDgJtr5GDZ+OBjGhtcZk88cW+bkP2STo9hE3G/sx
         8dhyqvylhCESXlmI8U+5uTg6ioYPpz1l0lGSkHUrSiJeQ3VGyP6llHUFEymFsVOw2JBS
         dhbVLpmDYKGtgAj4/8DbdZGGlb//KJAt3Val2paoarGG32+hJRkviG7UoeQHzi07oE7d
         igE/QhwjVwDdwIjlIwV/h/4vXyB1Dp8c4xGZL51Ni8+xS/honJlgCxGxC6+KsyYoxw2I
         a1xw==
X-Gm-Message-State: AOAM531VN7b5foNy0t/e71AozrVs5Zk75033i/ZlUHOrkDjKJgZQxdfA
        DMd5CfaYoqctrKm+mdapgPT8YNQsrqp5MzZGliJ8Rg==
X-Google-Smtp-Source: ABdhPJwxNT+YoriB7cWMW6ao5YcwKQ6uFM5ecY9hyynvKPtHvY9BmvMGGjUuJzY+I0e+9bS3wnMJE2R7Kxtgv+mfR2E=
X-Received: by 2002:a19:ac04:: with SMTP id g4mr9257110lfc.29.1628686257120;
 Wed, 11 Aug 2021 05:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210804160019.77105-1-andriy.shevchenko@linux.intel.com> <20210804160019.77105-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210804160019.77105-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Aug 2021 14:50:46 +0200
Message-ID: <CACRpkdazSqdOaoCknv=0wo3vw-FjrZKAy0rgh1hFbgd6au0vYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: dwapb: Read GPIO base from gpio-base property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 6:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> For backward compatibility with some legacy devices introduce
> a new (*) property gpio-base to read GPIO base. This will allow
> further cleaning up of the driver.
>
> *) Note, it's not new for the GPIO library since the mockup driver
>    is using it already.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: added check to ensure that the property won't be used by FW (Serge)
>  drivers/gpio/gpio-dwapb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 4c7153cb646c..674e91e69cc5 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -584,6 +584,10 @@ static struct dwapb_platform_data *dwapb_gpio_get_pdata(struct device *dev)
>
>                 pp->gpio_base   = -1;
>
> +               /* For internal use only, new platforms mustn't exercise this */
> +               if (is_software_node(fwnode))
> +                       fwnode_property_read_u32(fwnode, "gpio-base", &pp->gpio_base);

You rewrite the code quicker than I can review  :D

So this is elegant, I would prefer "linux,gpio-base" but the
overall change is more important, with or without that change:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
