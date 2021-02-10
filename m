Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A283167F8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBJN0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBJN0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:26:15 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA730C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:25:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l12so2991380edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5P3pXqsbExwoBP/miAImNEdFWZXxnHrDvNJnbzyXCU=;
        b=dOPtjQucHUQBnPjtYZ6SUrbg/sixrKkmgFF2h4JYMQnw/WPBs5hZfAEOazfKi1N8OA
         nNHL+QhlgZmPibA9meGj1nzLhnMZ6E60gGy8HHfHAkmdH+rJPqnb+56inCFiJqrA8jWI
         eCVn9vwqgzMFKNdxOkVxRVeMe9mfTAAybqeGShTNgRMiwsUzAJatyDktIPkcLTDJT6gD
         OWtSfGmAafaO3rKQzqtAzbph+4pt+0UZS7V79jDtIIIqHHL2/Z3TQFRUIdlqcfIoKYGw
         sc2R+cnnJljZcSU+Bra491nqkXMmpPrR9YljVQihJse7PKwDCqCXaKqnGd5EqsEErtfQ
         WYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5P3pXqsbExwoBP/miAImNEdFWZXxnHrDvNJnbzyXCU=;
        b=tyaQI0OXIidsBoe2UJzqg35jSj2mOC0Rg1BALhYNYF68ujO3KfditkZ0QWKNtSpGRY
         BuW6b+EMDjt3mlq4kZ1nC0mcs+tyVDxIMlm4QSe6x8rgTn0H3WL0Tozz29KrfoG9x4CM
         YiZ88Ny6iXfgsLE7ptPt70t0ga0aHK66apdbMD4iBAwyPEu6WCu6qCqtbOmfz0mu28YK
         aa3yAg1xMKd8XUeFWBP+9nHEtfSiFww37eeS/Hm/6vuj6QLDKowY6NstkRf04mUGxpYn
         TsNyIA8ILLfqT/ejOHdxqc+5RsKxtBXscdWpy9ymcARWJEuk1NOFUV/pAJTTLXNAEbJR
         kuPg==
X-Gm-Message-State: AOAM533egkKYOB89NqC+zuotOItqneCSVprSs7Crcq0GID9tIii/t6+0
        XtyrpHe8ZlrysCg+ULFlejQGKgaxIypxHD72HHgtJg==
X-Google-Smtp-Source: ABdhPJx0XjOijGpI4Y3SIRmENJCxby/axDriiAPKWAWAH1+8PiBt6viO3sEYajqmpp9hEQdUYN9THF+FyETxh470V+s=
X-Received: by 2002:a50:fe11:: with SMTP id f17mr3135651edt.88.1612963532354;
 Wed, 10 Feb 2021 05:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20210208145153.422093-1-geert+renesas@glider.be>
In-Reply-To: <20210208145153.422093-1-geert+renesas@glider.be>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 10 Feb 2021 14:25:21 +0100
Message-ID: <CAMpxmJV5vMuyA8bc4MJfwPAKM-0vKQP2oAPZTigGtDtHvoaByg@mail.gmail.com>
Subject: Re: [PATCH] gpio: GPIO_MXS should not default to y, unconditionally
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 8, 2021 at 3:51 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Merely enabling CONFIG_COMPILE_TEST should not enable additional code.
> To fix this, restrict the automatic enabling of GPIO_MXS to ARCH_MXS,
> and ask the user in case of compile-testing.
>
> Fixes: 6876ca311bfca5d7 ("gpio: mxs: add COMPILE_TEST support for GPIO_MXS")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/gpio/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 5fdf526fe973da38..412728ff2ab45c0d 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -442,8 +442,9 @@ config GPIO_MXC
>         select GENERIC_IRQ_CHIP
>
>  config GPIO_MXS
> -       def_bool y
> +       bool "Freescale MXS GPIO support" if COMPILE_TEST
>         depends on ARCH_MXS || COMPILE_TEST
> +       default y if ARCH_MXS
>         select GPIO_GENERIC
>         select GENERIC_IRQ_CHIP
>
> --
> 2.25.1
>

Applied, thanks!

Bartosz
