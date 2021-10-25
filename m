Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B864390F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJYISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhJYISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:18:01 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99283C061764
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:15:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z20so16340673edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycWo5sClTH2wJULOC25SBAkYNhAKYFWwgFptgtA3l78=;
        b=7VRUGM/F74dFjuuVH1F1iXmq+48MEi9+M6qdtP0/HtrPTAgsl/VePP63oUq003ILTL
         nHDVCVGD0cdTpbha+0my3XeSWHuiKCP78epihZS8dcrNVClvteGokwWgIkBnYxociwJd
         o7wVBUQnJEhcXJ+eiQsyvuf6NiUKLlIApIfhNm+hyjmMn4U8rfpEMDjaZkoLMhVOglLU
         C3C4KWuJTZSJY4tjNbMjsxBs5Dq8JOWMWkRvOdCo+g5Wb1gJLqOOZJRugO4vMba8e8if
         AecSuwMUVfDpLwxfKpdRC2mdw/j7stKjQlQmWot4AkRbGw5JE96LeP/RozglgqnxsdWQ
         hVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycWo5sClTH2wJULOC25SBAkYNhAKYFWwgFptgtA3l78=;
        b=DIilbNiw8GXD0FvCZOFiTSN+FOuX66+6duYAHHmO4dGPrZxl72gyFDQM7RV0LOeOYm
         euxzCOBtKdCv+mhtfu2d2fS7FY7gGU2lvDhHsPHGnoS53KQzVhYNv0AikKyoqX3ah8W6
         q0yjuhOsq1MbvPpuJKPW7aEgorBfSiXeWBc/CUdXvYiSWbzL+cXIYFAOh7CG52+gRvHF
         R5bZS8ll0zjM6gAMjrmDezdB2YoPxN9513nl6YHiEzGv4vDKKTNEGqrL+NfD/Ui44gDJ
         ABRJcwFzaLFuAzVBN6QAodBIY5iPfWej/AhYkIqbMepDgA3a7pRUAda9BChQcuH75zN+
         Vzfw==
X-Gm-Message-State: AOAM531WeGwzEL9Sx1IZZMjJCDR5ivp7Lk1Yh9CW027rTKcbNcoLSsRS
        dI7+geSwzTUZUmibQK2LwphDlcPeKGiZQEg60rReyQ609Yc=
X-Google-Smtp-Source: ABdhPJy3plOH2IZ9tT3bcGsMcRts0TqYy2sZv+1hbFfOGpM22QC1Y9qlw8eAt9MBzbg8y4KlaZnIvu4aRYtxohSimfc=
X-Received: by 2002:a17:907:3f8c:: with SMTP id hr12mr20667768ejc.77.1635149738000;
 Mon, 25 Oct 2021 01:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20211022134438.12083-1-asmaa@nvidia.com>
In-Reply-To: <20211022134438.12083-1-asmaa@nvidia.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 25 Oct 2021 10:15:27 +0200
Message-ID: <CAMRc=Mfzh8MK=aNzd=hKUOUrQO03K0tWmeMRkt5t8ubVmj4ATw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: mlxbf2.c: Add check for bgpio_init failure
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 3:44 PM Asmaa Mnebhi <asmaa@nvidia.com> wrote:
>
> Add a check if bgpio_init fails.
>
> Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> ---
>  drivers/gpio/gpio-mlxbf2.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
> index 177d03ef4529..40a052bc6784 100644
> --- a/drivers/gpio/gpio-mlxbf2.c
> +++ b/drivers/gpio/gpio-mlxbf2.c
> @@ -256,6 +256,11 @@ mlxbf2_gpio_probe(struct platform_device *pdev)
>                         NULL,
>                         0);
>
> +       if (ret) {
> +               dev_err(dev, "bgpio_init failed\n");
> +               return ret;
> +       }
> +
>         gc->direction_input = mlxbf2_gpio_direction_input;
>         gc->direction_output = mlxbf2_gpio_direction_output;
>         gc->ngpio = npins;
> --
> 2.30.1
>

Queued for fixes, thanks!

Bart
