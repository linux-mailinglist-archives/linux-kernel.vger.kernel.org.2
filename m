Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DA6414582
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhIVJuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbhIVJuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:50:21 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81126C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:48:51 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id 72so7553632qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TNELiqg8mYuBEOOX1lFmtUFpNCtQ0aR3VKdc/pWD04=;
        b=txqDOfjsDTHdigncyRvnvPrZ9nafFGNC0Iurpw5yLidixM5bL3qITG9HtYWnUpIHwu
         S2VB88buG67cq4EJkar55oCyNYCqGt6rbSBWsRVGNu+eSYOL6bA1vhJEd+2fT2bJzYzI
         vlvIJo02xDM4cSuB/NZWLkX4VuK8cxsAk7js7FzjnbN8XEDvAmHGwXq0XYKzZPgEFXnh
         wkkLGojxJ6hh84tGJst0ksVz44AVZNlGmxJ2N/ikKC37g1EnGNsCfEW2JhN5ih9XXBh8
         e6GEZtgYvviOy8Z8L7C8EWyWSnNtte3qObuZ8RMvPejN5mdHFs1O7T/oMytMSqu+jk4X
         dQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TNELiqg8mYuBEOOX1lFmtUFpNCtQ0aR3VKdc/pWD04=;
        b=X2jvg/8vD+LRGeuWNiBuNtP+kwPjqU2BDrt2LHQ6WD97bKXRG+/LWZaDtk95Tn+kyS
         xpdKS6xi/f+ijEHd9sYv4LQlnc1g2ikDi1ADfnmeinQCgoEhfucwx0XKJQhorZp8KfSo
         3NrtwKvnHZPFbUoAtQV8FCmCgoEBExq0WTRuw51TEUrA7G8QcaYiVZF8NzE0gRxKXweh
         ofCdjimJ7W8nRuiAA1OyjRt3Gs15Dp8zB4b8sJx60KSAswERnIfeYB0KVVq+64+z3NAz
         j+uzOFRzejMe4pTI9YB6vzL3vmTBEy0NSixGbX0xiLcj0YrFz9IyFey5iNElVeJDzbmz
         +t/g==
X-Gm-Message-State: AOAM531yeQcEyF0b37N3xyVDss8YqIQ2wRgKGDLVs8e6eLZB9wszJimI
        vYqeDWGuxNGaew9qwTT8gwkY755qVldwNNItX7wUZnQDDCI=
X-Google-Smtp-Source: ABdhPJzz/h534pFTi2UUESL2RehEDCQ84tzrWAzf+oAj3jSNZ9WiDdtTX/S/8cuTGX0a2gOsbNhF3JQ/xQxdAFmTvDk=
X-Received: by 2002:a25:7146:: with SMTP id m67mr43675807ybc.353.1632304130711;
 Wed, 22 Sep 2021 02:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com> <20210920090522.23784-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210920090522.23784-4-wsa+renesas@sang-engineering.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 22 Sep 2021 11:48:40 +0200
Message-ID: <CAMpxmJX5=5j2fM1zk+Cfjj5-FPfG+312JUf8Q7pQJ5GCCqa0dA@mail.gmail.com>
Subject: Re: [PATCH 3/9] gpio: xilinx: simplify getting .driver_data
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 11:05 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>
> Build tested only. buildbot is happy.
>
>  drivers/gpio/gpio-xilinx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index a1b66338d077..b6d3a57e27ed 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -371,8 +371,7 @@ static int __maybe_unused xgpio_resume(struct device *dev)
>
>  static int __maybe_unused xgpio_runtime_suspend(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct xgpio_instance *gpio = platform_get_drvdata(pdev);
> +       struct xgpio_instance *gpio = dev_get_drvdata(dev);
>
>         clk_disable(gpio->clk);
>
> @@ -381,8 +380,7 @@ static int __maybe_unused xgpio_runtime_suspend(struct device *dev)
>
>  static int __maybe_unused xgpio_runtime_resume(struct device *dev)
>  {
> -       struct platform_device *pdev = to_platform_device(dev);
> -       struct xgpio_instance *gpio = platform_get_drvdata(pdev);
> +       struct xgpio_instance *gpio = dev_get_drvdata(dev);
>
>         return clk_enable(gpio->clk);
>  }
> --
> 2.30.2
>

Applied, thanks!

Bart
