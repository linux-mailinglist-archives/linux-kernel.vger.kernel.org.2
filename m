Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651983873A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347358AbhERH5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347340AbhERH5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:57:51 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC4C061573;
        Tue, 18 May 2021 00:56:29 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so7890841oth.8;
        Tue, 18 May 2021 00:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eV5UeGE3IBd/TIBlyE+R6Ktv03bYUpvZbdBBEdJMQzQ=;
        b=jY0F9IxRD4ekkcpL37y0m+d6AmuFTNX8O0umjcxbJ3jJUkglW2/nKIhBx0QwAmJeES
         Ou7w8vRVKw+gNez6uTVnkIzC/BXDpObDb1/325flUqaKRrAWziyy7qcTT19zOBAzCYOK
         SHkFLnAwg/+w8CAz4O4VtuOGh2JNQFVoC+wk4sa6byGZHDsLEebe5U3lH0QUtdp68mJb
         UeuJv7xX25sHQltFuip6OHSqcERSHZ18VzkHGY23IkCVSabD1BtR3it/KFCmSCOJoMO4
         qoklw1mEEexzRxJZLpCpRKIdFyoFBhTwZdR8Z9fp3PCfyp67bVk3l+nnLo2EuJVOQIkc
         eX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV5UeGE3IBd/TIBlyE+R6Ktv03bYUpvZbdBBEdJMQzQ=;
        b=DHRMwinfCfmVOJewhYWWv7VHRmD3sqOoHSPhRq3PH8m0J+lOxIcGqwlduSXYzixlsz
         Fk0USkZwjaQ45ad6DKLX8HdY3PdSZ4bwHEYhhcZocVORI7BJe+zIEX5lsJs4jwAxFiHy
         GMCPYQhICYjCqpUOv6NY5IDiwTEr/CEq0gnuqcmv3AZyXqJxECwdjK9UWdCOLf1A5lwq
         Cu9gq+pU38SYQQ2rmuo543dy40uWDFpZYkQTjv0c+NUAGQad0Xwek8N7Yl0g9bfT1dr1
         k9YoEe8ciOwJkq+LZI2J59jQ072+aq4giu2l8BTkse/1BaR56NiskuTO+GgboKhMFLFd
         C/Sg==
X-Gm-Message-State: AOAM531vUgmEAnJBvFbtHfcDd9RkOb+OWAOLtR/G3mrTvfXt2fZeAwUR
        2Wxxe3ZJaoAlofd52kXay4SV+wdFUjTxOKDxNOk=
X-Google-Smtp-Source: ABdhPJxLc3looZn7M7xcGCA/jcvWbC7LmkpoidFEPt7TdytDDoufdjipEMQXoHTrS5rR3Y+DmY5/4GQhRSxZkg96mQM=
X-Received: by 2002:a05:6830:1646:: with SMTP id h6mr3222722otr.118.1621324589179;
 Tue, 18 May 2021 00:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-7-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-7-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:55:26 +0800
Message-ID: <CAA+hA=T_y7YsBZb67ypzxVfNb9F810jZOYPsfpE9Y-y=GQ1p6A@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: dts: freescale: Add lsio subsys dtsi for imx8dxl
To:     Abel Vesa <abelvesa@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:16 AM <abelvesa@kernel.org> wrote:
>
> From: Jacky Bai <ping.bai@nxp.com>
>
> On i.MX8DXL, the LSIO subsystem includes below devices:
>
> 1x Inline Encryption Engine (IEE)
> 1x FlexSPI
> 4x Pulse Width Modulator (PWM)
> 5x General Purpose Timer (GPT)
> 8x GPIO
> 14x Message Unit (MU)
> 256KB On-Chip Memory (OCRAM)
>
> compared to the common imx8-ss-lsio dtsi, some nodes' interrupt
> property need to be updated.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
> new file mode 100644
> index 000000000000..7496a38694df
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
> @@ -0,0 +1,68 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2021 NXP
> + */
> +&lsio_gpio0 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio1 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio2 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio3 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio4 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio5 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio6 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_gpio7 {
> +       compatible = "fsl,imx8dxl-gpio", "fsl,imx35-gpio";
> +       interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_mu0 {
> +       compatible = "fsl,imx8dxl-mu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +       interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_mu1 {
> +       compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +       interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_mu2 {
> +       compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +       interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_mu3 {
> +       compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +       interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lsio_mu4 {
> +       compatible = "fsl,imx8-mu-scu", "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +       interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +};

pls add the missing mu5/13

> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
