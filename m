Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18C731090F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 11:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhBEK2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 05:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbhBEKYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 05:24:13 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA08C06178B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 02:23:32 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hs11so11151604ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 02:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NbV2xopYqB8k/nP0Sr0amuc+ZFTqwUx+Yh7SdhQe2o=;
        b=ojysRCSzQ2JR3ZrCBE9WeDUJTjUfiR9y9PFcSY5g1LxEXvVpreDdQhmW+25Nulw5jl
         IdsBu9xWfj+m3JfgxULlT5BtYZyaOZI29NV5fN7OzlX7XP04oAQVw7pV7ImtjVp44kLA
         LCM8n9bqpfc14tim0qpBVQTw7M2pfPqN9lJEyoIHWHH8b9vC0/TMOAcMHWLTAof+A2cD
         CekbUw7kk8OcAbMDLzeFyuW1aXwcJC4sAhrcEQtZRxVrzxTavlHKNJ2yJ0CuIIse4nZn
         f2FCfekMI3o/mPIaeDsuMfgPmbPfcSJcZsuTpx1FcJhO7HX9BuLGzdn+pRjqb9twfaIw
         /aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NbV2xopYqB8k/nP0Sr0amuc+ZFTqwUx+Yh7SdhQe2o=;
        b=Pu3FO3C2sSMuJ92/ox5XBOGMapxsCmWA6/9woH9yyXfj7+OiJZCEbgp90DPiCmkNQV
         st45HUmXr97rAmg/gYoRAaQY/dHkieIBPR2EAXTpQ4bmowOqX/V/ZlhXC4JFBfeoWAbN
         Pa/VGfyhcNOYxq4Y7dDjnP6DJsULkehlcgnTZVSlA0uMHr6evQdBHMTC2MYYc5t/mD2C
         fu3lrCsWSl1M56LZkHQ9pb+Zj5fWBRl1612WhrorZBKbMq17cXcDh7sCML+5qyfHm2HS
         VZG9S5zeTd2hBIopT7MiDLnB4BCkbK+I9L9FJba3kuObGTM8Mi41Iz9lo2/RWMCtudGa
         6cZA==
X-Gm-Message-State: AOAM532TG2CQnJbLN5kczknpFAhgMxlDK8jgQR8MfHaYc2yQZ8jMxxMM
        z63dDsxbzsMxWXjjrUbch+og5WidckmubbHvWwtheQ==
X-Google-Smtp-Source: ABdhPJxnjm8ihCs8rUXwvRXjUsXaQBKeDXV+Mj9gCJSzaZ/rIzdy0xAVwEgkFp3QZPYthE6CST+2Ba7gMH8DV4Uapak=
X-Received: by 2002:a17:906:3105:: with SMTP id 5mr3521744ejx.168.1612520611002;
 Fri, 05 Feb 2021 02:23:31 -0800 (PST)
MIME-Version: 1.0
References: <1611930410-25747-1-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1611930410-25747-1-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 5 Feb 2021 11:23:20 +0100
Message-ID: <CAMpxmJXydD6cJW+0uvNbA4AKu4_CvFRpZMZujw7WnC7stzhjKw@mail.gmail.com>
Subject: Re: [PATCH V5 0/5] gpio-xilinx: Update on xilinx gpio driver
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com, sgoud@xilinx.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 3:27 PM Srinivas Neeli
<srinivas.neeli@xilinx.com> wrote:
>
> This patch series does the following:
> -Simplify with dev_err_probe().
> -Reduce spinlock array to array.
> -Add interrupt support
> -Add support for suspend and resume
> -Add check for gpio-width
> ---
> Changes in V5:
> -Removed IRQ_DOMAIN_HIERARCHY from Kconfig and of_gpio.h
>  from includes.
> -Added check for #gpio-cells.
> Changes in V4:
> -Created new patch to simplify code with dev_err_probe().
> -Updated minor review comments.
> -Created new patch to check gpio-width.
> Changes in V3:
> -Created separate patch to arrange headers in sorting order.
> -Updated dt-bindings.
> -Created separate patch for Clock changes and runtime resume.
>  and suspend.
> -Created separate patch for spinlock changes.
> -Created separate patch for remove support.
> -Fixed coverity errors.
> -Updated minor review comments.
>
> Changes in V2:
> -Added check for return value of platform_get_irq() API.
> -Updated code to support rising edge and falling edge.
> -Added xgpio_xlate() API to support switch.
> -Added MAINTAINERS fragment.
>
> Tested Below scenarios:
> -Tested Loop Back.(channel 1.0 connected to channel 2.0)
> -Tested External switch(Used DIP switch)
> -Tested Cascade scenario(Here gpio controller acting as
>  an interrupt controller).
> ---
>
> Srinivas Neeli (5):
>   gpio: gpio-xilinx: Simplify with dev_err_probe()
>   gpio: gpio-xilinx: Reduce spinlock array to array
>   gpio: gpio-xilinx: Add interrupt support
>   gpio: gpio-xilinx: Add support for suspend and resume
>   gpio: gpio-xilinx: Add check if width exceeds 32
>
>  drivers/gpio/Kconfig       |   2 +
>  drivers/gpio/gpio-xilinx.c | 369 ++++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 349 insertions(+), 22 deletions(-)
>
> --
> 2.7.4
>

Series applied, thanks!

Bartosz
