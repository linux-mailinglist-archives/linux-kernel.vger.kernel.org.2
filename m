Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596B63A10CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbhFIKEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235098AbhFIKEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:04:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7578C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:02:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z1so24820634ils.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hxhSa0kvLC7oP/RrEKCgojf2CT4psCrXq+njT9seZ0A=;
        b=UhlRk1H5gURKZzZL61G0sM0838VcqS9EvsL0IWAzaEgAilG0YWIVhX0lUeqgyP9GIx
         Tg8VZ/diEezSUdH8c3083XiOh8gno54pl5MABAA2mnzJ19+ik/TjMO2IjLHtXBzh3lQn
         KxDPtlxEZY8BfUSa9vP/HRQcEuanMqUHs2f1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hxhSa0kvLC7oP/RrEKCgojf2CT4psCrXq+njT9seZ0A=;
        b=OIRDAEZHG81OSGxuQ3O+LPzz01bcnzQKwte/hKMB6jVnJafZycy18BsBmOZQv2jm1l
         w72GoZv6jGpe8X29s9xh9BjyzU88urZfYOWLOBBtdhh9YD/29165+3Nm1/AJyoSIP0h+
         6LZtQmy7dhNokf+MQZTYxL90RBKChEuYOfgMeKh9Z32+TneBpgfUez8A0e6mQqbfpJDh
         Ak/hlhzLNyFnf0p/qUar5ErFEBtYcwGLqcBX4whktmn8fm9NtFdpZL4mCZQGSTJd+gDB
         qQqaIJQavu+hrY2tAgSPsFwkCCcHqGECjtFSxwqrFd7pN5a1qpKXIyvzV6zI3YoQ/UKF
         FyHg==
X-Gm-Message-State: AOAM530IASfQfC42ZGjN7kiuhfw1KO1dCm6s6MlnKI3dxWJxrbu6MTou
        SwQp3bG/yPn3USA08NQfUeIAcw6jswNw3w==
X-Google-Smtp-Source: ABdhPJwdlLzWSOpM2TYM11Wow3qD0BLRpGb4DWO2+NFPFiY0zJ99wbq9HOLgVSbKstOuLHBBXyj5aQ==
X-Received: by 2002:a02:4b44:: with SMTP id q65mr17024785jaa.28.1623232969081;
        Wed, 09 Jun 2021 03:02:49 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id q23sm1240247ior.46.2021.06.09.03.02.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:02:48 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id b9so24769664ilr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:02:48 -0700 (PDT)
X-Received: by 2002:a05:6e02:ca8:: with SMTP id 8mr23794380ilg.115.1623232967763;
 Wed, 09 Jun 2021 03:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com> <20210517173314.140912-9-gene.chen.richtek@gmail.com>
In-Reply-To: <20210517173314.140912-9-gene.chen.richtek@gmail.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 9 Jun 2021 18:02:11 +0800
X-Gmail-Original-Message-ID: <CAC=S1niBX4cL7EaROvG9NKSrnFFqCj+EPAZx0KASNTcF9F6E0Q@mail.gmail.com>
Message-ID: <CAC=S1niBX4cL7EaROvG9NKSrnFFqCj+EPAZx0KASNTcF9F6E0Q@mail.gmail.com>
Subject: Re: [PATCH v8 08/10] mfd: mt6360: Fix flow which is used to check ic exist
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     lee.jones@linaro.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:36 AM Gene Chen <gene.chen.richtek@gmail.com> wrote:
>
> From: Gene Chen <gene_chen@richtek.com>
>
> Fix flow which is used to check ic exist.
>
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/mt6360-core.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> index 50a170065a98..cdd99770f94a 100644
> --- a/drivers/mfd/mt6360-core.c
> +++ b/drivers/mfd/mt6360-core.c
> @@ -293,6 +293,25 @@ static const struct mfd_cell mt6360_devs[] = {
>                     NULL, 0, 0, "mediatek,mt6360-tcpc"),
>  };
>
> +static int mt6360_check_vendor_info(struct mt6360_ddata *ddata)
> +{
> +       u32 info;
> +       int ret;
> +
> +       ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &info);
> +       if (ret < 0)

A dev_err() to indicate the read info error? (it used to be there)

> +               return ret;
> +
> +       if ((info & CHIP_VEN_MASK) != CHIP_VEN_MT6360) {
> +               dev_err(ddata->dev, "Device not supported\n");
> +               return -ENODEV;
> +       }
> +
> +       ddata->chip_rev = info & CHIP_REV_MASK;
> +
> +       return 0;
> +}
> +
>  static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>         MT6360_PMU_SLAVEID,
>         MT6360_PMIC_SLAVEID,
> @@ -303,7 +322,6 @@ static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
>  static int mt6360_probe(struct i2c_client *client)
>  {
>         struct mt6360_ddata *ddata;
> -       unsigned int reg_data;
>         int i, ret;
>
>         ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> @@ -319,17 +337,9 @@ static int mt6360_probe(struct i2c_client *client)
>                 return PTR_ERR(ddata->regmap);
>         }
>
> -       ret = regmap_read(ddata->regmap, MT6360_PMU_DEV_INFO, &reg_data);
> -       if (ret) {
> -               dev_err(&client->dev, "Device not found\n");
> +       ret = mt6360_check_vendor_info(ddata);
> +       if (ret)
>                 return ret;
> -       }
> -
> -       ddata->chip_rev = reg_data & CHIP_REV_MASK;
> -       if (ddata->chip_rev != CHIP_VEN_MT6360) {
> -               dev_err(&client->dev, "Device not supported\n");
> -               return -ENODEV;
> -       }
>
>         ret = devm_regmap_add_irq_chip(&client->dev, ddata->regmap, client->irq,
>                                        0, 0, &mt6360_irq_chip,
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
