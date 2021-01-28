Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F2F307167
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhA1IZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbhA1IZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:25:07 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78288C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:24:21 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id c18so5278388ljd.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ULE4+q7ZKmkGfyu8JC5m51bVDpO57/QqEwGtSZ6HkKY=;
        b=rtL9q5B0KQOwsaH+TV5aQqslftG8dM7kBPsVzpjblYGDYx7vqAAaxwtcziduV5tjMM
         BvoYSpyEEik9g0MbadHzDWsWTSXaSZAvuZliatTyTfAVbDRMfLrfWVQNwtIbVG8flSnk
         12jKtvOW66KOy4kF9anxD/fO0DSZD7VOKHIX7YLgHtV6aXbBhhm6PdB7BZG11iyqq5sI
         ikv61ZCYhz8pfynURGij7CnsR/Wgg+rqya6iqMmnXqFq7tY5JWoZVzADrStLtiER2BKY
         oHEoD3WtYpuCHoNJKMIjXB3Q5OW+iVC/Q1mQfpZHWOnUR1enAe5gYgm0ljkFjj0+PcVc
         P7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ULE4+q7ZKmkGfyu8JC5m51bVDpO57/QqEwGtSZ6HkKY=;
        b=EtENs7fggkVrpcZ1weJuH4f6OHuvObRMeE3oiGj3KQRnJQow+4bGttRwVr0OFovx4K
         RHwYwzBrJ8/vM1IHbD5ILPC4YJvx5h5mGWh+phM60BtS6ayx7dXHgjBGNzXrD+gYggGr
         SN90h3YJyBlauPhBpsbDvQO5IbPSdIgjWbWs46k1dAdG3u/Hfo7hztVJollxIuyoPTLl
         VOLUk20t5Rr+ag8GMJZuHMLr6FqWDHcmRYxRvYsQSQssceCCBYP68EjrLurpddvLmJpA
         lZuxxZ6qP49NbtQebR7QO4hit34BxB/EyPCt8JGkKdYnj8B/oiyynlHB/BJ1rFw61Zwq
         uUlA==
X-Gm-Message-State: AOAM531fC+IVy4IlBd3YXO7s2OdJBKBtfrlUTZf6Y8sGS55zUr2KuLEF
        VKs0FDhMRqx4grd3LJ4srBvpzF+YkpB//B0VDbakaw==
X-Google-Smtp-Source: ABdhPJyys3EbAeJalI9BEq3UYfuRIoJnwLqvWqCoBn0U3X0Up2cu3YQVgCqCcSkXBWZSbhKc4+8kNevH2EGGbivK/kk=
X-Received: by 2002:a2e:8746:: with SMTP id q6mr7797139ljj.326.1611822259811;
 Thu, 28 Jan 2021 00:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20210126131239.8335-1-o.rempel@pengutronix.de> <20210126131239.8335-3-o.rempel@pengutronix.de>
In-Reply-To: <20210126131239.8335-3-o.rempel@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Jan 2021 09:24:08 +0100
Message-ID: <CACRpkdYSdtwSZxicJ1Rxp_XkK1BstpnzMcV0JqXg+cac_+gSSw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] counter: add IRQ or GPIO based pulse counter
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleksij,

thanks for your patch!

On Tue, Jan 26, 2021 at 2:15 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> +       priv->irq = platform_get_irq(pdev,  0);
> +       if (priv->irq < 0) {
> +               dev_err(dev, "failed to map GPIO to IRQ: %d\n", priv->irq);
> +               return priv->irq;
> +       }
> +
> +       priv->gpio = devm_gpiod_get_optional(dev, NULL, GPIOD_IN);
> +       if (IS_ERR(priv->gpio))
> +               return dev_err_probe(dev, PTR_ERR(priv->gpio), "failed to get gpio\n");

I would attempt to get the IRQ from the GPIO if not defined explicitly
in the device tree.

priv->gpio = devm_gpiod_get_optional(...)
if (priv->gpio) {
    /* Attempt to look up IRQ */
    irq = gpiod_to_irq(priv->irq);
}
priv->irq = platfform_get_irq(...)
if (priv->irq < 0 && irq > 0) {
    /* Use the GPIO-related IRQ */
    priv->irq = irq;
} else if (priv->irq < 0) {
   /* Error */
}

This way the example in the device tree binding which only defines
a GPIO and no interrupt will work if the GPIO chip provides an
IRQ mapping.

Yours.
Linus Walleij
