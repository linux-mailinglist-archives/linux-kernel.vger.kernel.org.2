Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592A33C8567
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 15:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbhGNNjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 09:39:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231561AbhGNNjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 09:39:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E294613BE
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 13:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626269817;
        bh=wLjPnQ+yR3jTWMUmZ0pGpL7MPqw9qF3/J83KH2XMpXE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5hPVUqQ3d3dfyZ/U0dEgNXLn0rBynlc1sGv0zTGO6+TgXzxH0m9/or2kdcWJJhGF
         oWOaQEiXrvX58FVc3905/3wIzIDNYsahQ4qgCHSDSYOUnzCE5X1tstnxkfHRrO9Xst
         tS4DFHJxRi6/lfrNj7aUrpmuCbIR4sSQy0KlXR4HrMONLBX4ds/xPLq2DSB+Rt9Fvu
         HqXI9N23fG0/tFGBS61LS7Bq/vIHywaiA5LV/AI1GaY+DibhONCzF4yuyBYr7FL4ze
         iq8Cf62QVRdDieHKIIWUsBFSvYc+bh1+W7Z4/OYhAJB96daLviRqOtbwQ87UD5Zhp6
         ofZob6XSIQNZA==
Received: by mail-ej1-f51.google.com with SMTP id hr1so3416357ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 06:36:57 -0700 (PDT)
X-Gm-Message-State: AOAM530NFyqxLSXC5HbxmOUFbzt5QirvlM3+XkH8+gkDYU32s9uMTtA5
        0nXx4wkeKXXzcro7ciKJ7GoMKgI+K+xd6N4irw==
X-Google-Smtp-Source: ABdhPJzlvE5Rm4DlNJME78ghKYI8Djutdk8BzIoPPh9/qQPhj2ssRvKIpp6Tsa6Aoqz9ISeY0vu3pFE+9jArKNFQQX8=
X-Received: by 2002:a17:906:57d0:: with SMTP id u16mr12775224ejr.468.1626269815848;
 Wed, 14 Jul 2021 06:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626253775.git.mchehab+huawei@kernel.org> <1e7ec01a61916a03e7165e684d8d5b7dc58970f0.1626253775.git.mchehab+huawei@kernel.org>
In-Reply-To: <1e7ec01a61916a03e7165e684d8d5b7dc58970f0.1626253775.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 14 Jul 2021 07:36:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKkLZH7GnhFh=oznFnK+j2b7VVjsfWAWZq47TkqDayOw@mail.gmail.com>
Message-ID: <CAL_JsqJKkLZH7GnhFh=oznFnK+j2b7VVjsfWAWZq47TkqDayOw@mail.gmail.com>
Subject: Re: [PATCH v13 1/9] staging: hi6421-spmi-pmic: rename GPIO IRQ OF node
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 3:13 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Instead of using the standard name ("gpios"), use "interrupts".
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/staging/hikey9xx/hi6421-spmi-pmic.c              | 2 +-
>  drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> index 35ef3d4c760b..9a7e095246f7 100644
> --- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> +++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
> @@ -233,7 +233,7 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
>
>         ddata->dev = dev;
>
> -       ddata->gpio = of_get_gpio(np, 0);
> +       ddata->gpio = of_get_named_gpio_flags(np, "interrupts", 0, NULL);

It's an interrupt, you should be using platform_get_irq() and
devm_request_irq().

In general, you should not be using of_get_* for any resources, but
use the firmware agnostic flavors.

>         if (ddata->gpio < 0)
>                 return ddata->gpio;
>
> diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> index 8e355cddd437..252b600f02a8 100644
> --- a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> +++ b/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
> @@ -34,7 +34,7 @@ properties:
>
>    interrupt-controller: true
>
> -  gpios:
> +  interrupts:
>      maxItems: 1
>      description: GPIO used for IRQs
>
> @@ -71,7 +71,7 @@ examples:
>
>        #interrupt-cells = <2>;
>        interrupt-controller;
> -      gpios = <&gpio28 0 0>;
> +      interrupts = <&gpio28 0 0>;
>
>        regulators {
>          #address-cells = <1>;
> --
> 2.31.1
>
