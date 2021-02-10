Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584BD316856
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhBJNwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhBJNvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:51:00 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F18C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:50:19 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id sa23so4368290ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTNJEfoQUaDnKZJmRpNWMQ9bWqNkHovtgW4jAdcH7YU=;
        b=Dlz7MKU/9UeXQKBzTFiSk719BaoT1HYGidmcF6MAEEDd9enG8a3UcEQ7clv++YknVd
         LZ3yUZNHrgCDUARz/tWhiIfs0Gvt4eTl+1Y8mF3Cle0a3hQiG0XBkC44dFLIjtZG7yRs
         pYt5fMdv4UPd8GujBGOQCd/Z1N4H0dJJLtLHEpPDc0y8ESV7CjMY53WoGJSVwtONeHAk
         8Elj1AidnO70XGmtuj+I5r+m6KB+Pm756uQ8o2xKYKzSwC0aLn8B2gxxWigsDlzDLMz0
         fpv/HelKiQTe08dYWfAI3xom+B0jTAxzOs1MHIw5jRi570NuTVHhv7XyTE2OE0aqQxWC
         BdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTNJEfoQUaDnKZJmRpNWMQ9bWqNkHovtgW4jAdcH7YU=;
        b=d8wpCbS0k4WMCsh85mg11aWbqtnf/fHNZ3syZnY7gonlU2Csv0/zHhZooNbTr8Dxy+
         Wt8vEzNhtXkWtpS8RAjCbMKAG9JUSMqCGVCnS3FbMsGIwgEORG1Pud9cniiMMYTnMwdi
         VgXnGJANrXZ6Ai6HqIsFpI944omMceVU152jvqocbWb2ABayQqU4LGxEcCdyI6tXLyte
         111FunI56exIvqWGz0sPLbxu2jbefM2VXlT9L93yB+bj2VxJesnw+IbQBSNZT6y/1JRL
         KM6XBBO+lntno19i9BEHp09wNBIKl0eNyhGe4RLqsmCYdH/Q21PElghR/c1k46odSPIz
         CcUQ==
X-Gm-Message-State: AOAM530W8Q83/UEmaBM4z0fqQ9TwW3GLTxa3cYT4acp7patH+WwbgWgC
        G0SSC4gTh7AaQqiwcws1RpQunhGBhE2F92AiExFuqw==
X-Google-Smtp-Source: ABdhPJwRaTDjhBuZQGy2fNZbRshWThFtyxyfeLUOVTfCnfenIP1OwfkLDCKxNSDplkwzPsnz7QCMYvtDO5tQRPO1u4Y=
X-Received: by 2002:a17:907:2d09:: with SMTP id gs9mr2883611ejc.363.1612965018296;
 Wed, 10 Feb 2021 05:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20210209133110.7383-1-nikita.shubin@maquefel.me>
In-Reply-To: <20210209133110.7383-1-nikita.shubin@maquefel.me>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 10 Feb 2021 14:50:07 +0100
Message-ID: <CAMpxmJUKkhhJOMf0WUintH=xPXO7+qLz-R2AyK5wygECzip3Nw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] gpio: ep93xx: fixes series patch
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 2:31 PM Nikita Shubin <nikita.shubin@maquefel.me> wrote:
>
> v2:
> https://lore.kernel.org/linux-gpio/20210127104617.1173-1-nikita.shubin@maquefel.me/
>
> v3:
> https://lore.kernel.org/linux-gpio/20210128122123.25341-1-nikita.shubin@maquefel.me/
>
> v4:
> https://lore.kernel.org/linux-gpio/20210205080507.16007-1-nikita.shubin@maquefel.me/
>
> v5:
> https://lore.kernel.org/linux-gpio/20210208085954.30050-1-nikita.shubin@maquefel.me/
>
> v5->v6 changes
>
> [PATCH v6 2/7] gpio: ep93xx: Fix single irqchip with multi gpiochips
> Andy Shevchenko:
> - add devm_kasprintf() return value check and move it out from
>   ep93xx_init_irq_chip()
> - removed ep93xx_gpio_irq_chip
> - pass girq->chip instead of removed ep93xx_gpio_irq_chip to
>   irq_set_chip_and_handler for port F
>
> Tested all patches on ts7250 board.

Series applied, thanks everyone for reviews and testing!

Bartosz
