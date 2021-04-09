Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A692F35973C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhDIILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhDIIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:10:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B16AC061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 01:10:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mh7so7227294ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YVthnjEf/a8GPOi8SrqVUE1vyVxElaU23WIQYqb2HU=;
        b=x/0c8Ccil2LJsxXwwB+e/85lG9nnTuQYOdZBaDebs2t+KZEvYo3zVbxW0Za5jhnKVz
         V/2deepKoQmyCQagA0AJK10gwd1SKf6D4A6wbwgpI+JX79sTWwUUwrqv6kI0hmDJnKHp
         QEHB5r2Hdgb38sFvdFqEN5e8Bt3fHjdHCvA1IzLsuGt9VAJt86DVirgVrnoiOFVcvr8n
         kn27zqdEU6T1DKivsyTDe8++WRNQiSLSBTvaWDAcS5fEY9pSCDwk/5IlM1PgFuYRX/SU
         gqTQIVUzfdjSllccfCrAB+JeM0HefnzM0x1JbtV3CF0EHUVXUK9Nvm/ONXStmpOMgCbN
         3NDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YVthnjEf/a8GPOi8SrqVUE1vyVxElaU23WIQYqb2HU=;
        b=EAwLxb719L0bJfLhjWOu0z2fMqtYm8Aph4GhE0HQOhdxGcfiS/sJDJAMzTtpt3MU44
         ie/85wXjpY6VTQNrbeWvhC3TN4IjAoCQ9p+1pROZCXIpvBGajRfYNQdaeMH8WcRkrVi2
         TMTtIACIOmiJQOSlVOtKAamiZm6fYPwhARNAEQZvGKwH+0HfwgrmzUpjasQxo5x+bNPn
         nKoLTHczxrf6J9H39ZkJDK/eu0MnSxGF5B9D6NbwOnv7Lj2tharIZtyn9awwM0EwUKAw
         i89pqKoWLKXkJnQsvh+6mBbxtzNIISbxkyM9I0ThTiH4b9Oh4Ez7AKwCXNvq/CHyphJ3
         fIoQ==
X-Gm-Message-State: AOAM533HIlgnqHLYsU32CFr0lE2FBbMV5s9FjOW/tjusYjsldv4FNfZ5
        YHfg8wnI9Vn/A+N4Rlmu1KnRXfg2ANdRvWWtMSviXA==
X-Google-Smtp-Source: ABdhPJysFMEKbL+MDsFNOhdnzV0UPwuitsyOKi5Mukeueoq/WaW9+ctP8vakiL7x3WUfqFtXHGc4rgybxJ1EMfkdkhc=
X-Received: by 2002:a17:906:b20f:: with SMTP id p15mr11727815ejz.64.1617955840044;
 Fri, 09 Apr 2021 01:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210408155506.12636-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210408155506.12636-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Apr 2021 10:10:29 +0200
Message-ID: <CAMRc=MdPYxvwUtG2LhOkqGMj1fttnJ8jv+15GeoSqqkLKdmM8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sim: Initialize attribute allocated on the heap
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 8, 2021 at 6:24 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The attributes on the heap must be initialized before use.
> Neglecting that will produce an Oops in some configurations:
>
>   BUG: key ffff000800eba398 has not been registered!
>
> Initialize attribute allocated on the heap.
>
> Fixes: 3f0279eb9e37 ("gpio: sim: new testing module")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-sim.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index ea17289a869c..92493b98c51b 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -284,6 +284,7 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>                 line_attr->offset = i;
>
>                 dev_attr = &line_attr->dev_attr;
> +               sysfs_attr_init(&dev_attr->attr);
>
>                 dev_attr->attr.name = devm_kasprintf(dev, GFP_KERNEL,
>                                                      "gpio%u", i);
> --
> 2.30.2
>

So writing tests really serves a purpose, heh? :)

Thanks for the patch and QA Andy and Naresh, patch applied.

Bartosz
