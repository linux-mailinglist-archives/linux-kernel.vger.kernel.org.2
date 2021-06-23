Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF33B1656
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhFWJAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhFWJAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:00:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC21C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:57:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id my49so2825856ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z6Z3rnoFwy3s+OnHi/sH1rvXTGduUYkOOkAbeaIPw4Q=;
        b=tdK9uAJWdmT+cTqTX4ozHwlgRi7wW7OUcIGpx+5Br2fodFNa+MnfUQZVAzgz1DMfXp
         n/6yy9sAzllko9mIwsv87gD1kCOH5+UvzuTO8Ov4YmQvbrKg9vhNxEnX9Bb3xpiNP2fH
         k9Oyze3A8ShMVN/bVHL82sBkwKgirt++Dw9dhx7H9AShjZynKsDqAx3QjkNyy+S3seYa
         O7aOzg7Mj0Cm2KxHYiHvi5dJSHR99JkBwPvAeetXr4PIjVliCzIaKYRVlGsyYaoAOytV
         AXOwIKzGUy2+Qw0GsQqKp2vE+Hbxv9yib/h1U+C6vqKY5DAWNhTnHvHGn5ed0S9mxQ6J
         iM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z6Z3rnoFwy3s+OnHi/sH1rvXTGduUYkOOkAbeaIPw4Q=;
        b=AHs5tXp39nKifgzidfKTYRlRBr4/SzolQpYVBg1OCLTG/Q0cuXEIU9I9hocX+aVHrz
         YGRGEkaOcktEOCYXcDU9VZKmeyErpxgLK9q/zPmXslfSH1aRsvJosBbQMNLkSD9Rsaki
         E47BM/c7m8sP5kavG/Wq7ss8XytPZnCL3bKRqMUdSjG5gcYIWftb8QkcIg8pESsOKwkp
         YSe0mrQDS4lDqP/DrrWMT+PL/OEuRuKgLsS3UIgVeiXVWjZdLmmF0H4OtFGuFsbkWJ6t
         smEr3jKk37IVSJvrkKijDjdAXbgbsnEmQPDzO31CU6cWcXZ1x/R4A8dIGjonnbSUKgKe
         xdjg==
X-Gm-Message-State: AOAM533HXclQ8eu0L/STe04om+ZPWRclsgPSLhLQXONLCVOhq2hJ92oX
        x8V75Omjq5P0cZkBmD/8lzFmgIt1IMHj4YdIXYDP0A==
X-Google-Smtp-Source: ABdhPJwy+pM9oZ1iyRoxUOJy65b7IRacVpAEIpAEHz2ud7J2MhpMBy54g7b0sAw4obchFDygfdWC6jUFii9npycxr4w=
X-Received: by 2002:a17:906:ca4a:: with SMTP id jx10mr8892678ejb.200.1624438666647;
 Wed, 23 Jun 2021 01:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200902150643.14839-1-krzk@kernel.org> <20200902150643.14839-2-krzk@kernel.org>
In-Reply-To: <20200902150643.14839-2-krzk@kernel.org>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 23 Jun 2021 10:57:35 +0200
Message-ID: <CAHTX3dK+M9eg+Xod9tYHiEXY_igjO6iocaO=e1Frqd1kzPKTrw@mail.gmail.com>
Subject: Re: [PATCH 2/9] i2c: xiic: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        linux-i2c@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

st 2. 9. 2020 v 17:10 odes=C3=ADlatel Krzysztof Kozlowski <krzk@kernel.org>=
 napsal:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and the error value gets printed.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/i2c/busses/i2c-xiic.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.=
c
> index 90c1c362394d..a97438f35c5d 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -787,11 +787,10 @@ static int xiic_i2c_probe(struct platform_device *p=
dev)
>         init_waitqueue_head(&i2c->wait);
>
>         i2c->clk =3D devm_clk_get(&pdev->dev, NULL);
> -       if (IS_ERR(i2c->clk)) {
> -               if (PTR_ERR(i2c->clk) !=3D -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "input clock not found.\n");
> -               return PTR_ERR(i2c->clk);
> -       }
> +       if (IS_ERR(i2c->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
> +                                    "input clock not found.\n");
> +
>         ret =3D clk_prepare_enable(i2c->clk);
>         if (ret) {
>                 dev_err(&pdev->dev, "Unable to enable clock.\n");
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I see that this didn't go through.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Wolfram: Can you please apply?

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
