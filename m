Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A288387391
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347309AbhERHyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241636AbhERHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:54:20 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A686C061573;
        Tue, 18 May 2021 00:53:03 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso7856937otb.13;
        Tue, 18 May 2021 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rGv0FmALESIZu7llY+EMbaYCEoxoOIO2gHNKCIWLvI=;
        b=vI66NO6Vw3e5NcCzcfe0XTdNHFS+g80f0VoczlEzxF9TDzJyOqo7nAilYxBfboXFfe
         q0gDCN+V4Ub9joT/pGpiheSEGtysnPBZUPMS9kyTAvucLps+ShQc/Cdqa+xtvZADuTIE
         ihUnxyIiFsQqXTfOGpa0KOToZd1EA5f2TG/0UYwPlKAHCiO0qyYzAddskxaCeNZrIand
         967vd+si0Qy45naMf5DQQQZCm8915eVA3DA9GmroR+e57czRdjdr2z/8BhpVnQC89AX4
         1xWURvf1zG2/Ydd3bUs5y49QQrTHeMyOjQ6IL5tCELchb7SxobUIXHZ7ftsev4tuBIhu
         jS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rGv0FmALESIZu7llY+EMbaYCEoxoOIO2gHNKCIWLvI=;
        b=iKQGQkU5MbhB3NOfZ0CRXbxkWEGOtFjSPXA3zbDrmtXFCojE7DnkJjwRtZ+IXfbXpF
         MAS9SEIwJUzUqQ3hf4/qBT5dosIsjULK/Pew0GJJlpae8bh+5BGb1E0OMKmf2O/ETylF
         +diQdOJd5NDQrOkg+XXHjTmu0qluHwZ46Nn4iiZu7KOcqPwxLPyI67aWLYYt0QX8FdgH
         JU6w+HxnQudXK4K0mh0WJJBOrpz2WeduNG7G5jEjaDQcAPTdmjxJysfQxTjyXSWjYA1u
         EozE3hZz9j9MmBvU3WnBzmhrmzWufquJUDJBgcFuyvgcTrFEoD0627j4ubLPuVioaMZE
         fDYQ==
X-Gm-Message-State: AOAM5333Nxln7DZVenufRa+d5veZkdfYw/iPcQy/RfJF/aAiDyea4hGH
        3RQ8Ai4uvOjULLKRn0KcMwyJTsyBjhI/ENNPupc=
X-Google-Smtp-Source: ABdhPJyLAPb+grp7Yjm8V0fDqiJUnzWpkXIM1iTLq1/47N7a+mOGEDsbONUJ+7Uk2UZpVBiapx5lgjwPfwMuSJtyutg=
X-Received: by 2002:a05:6830:1646:: with SMTP id h6mr3212192otr.118.1621324382740;
 Tue, 18 May 2021 00:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-4-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-4-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:52:00 +0800
Message-ID: <CAA+hA=R1-JJ+uwa0qio-twUnFW7CYDPaj26CmwuoFcP0oXcNtQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] arm64: dts: freescale: Add adma subsystem dtsi for imx8dxl
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
        Abel Vesa <abel.vesa@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 1:15 AM <abelvesa@kernel.org> wrote:
>
> From: Abel Vesa <abel.vesa@nxp.com>
>
> Override the I2Cs, LPUARTs, audio_ipg_clk and dma_ipg_clk with
> the i.MX8DXL specific properties.
>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Please add dt-binding update as well.
Better along with this patch series

> ---
>  .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> new file mode 100644
> index 000000000000..12ccbc6587ca
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2021 NXP
> + */
> +
> +&audio_ipg_clk {
> +       clock-frequency = <160000000>;
> +};
> +
> +&dma_ipg_clk {
> +       clock-frequency = <160000000>;
> +};
> +
> +&i2c0 {
> +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> +       interrupts = <GIC_SPI 222 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&i2c1 {
> +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> +       interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&i2c2 {
> +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> +       interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&i2c3 {
> +       compatible = "fsl,imx8dxl-lpi2c", "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
> +       interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lpuart0 {
> +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +       interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lpuart1 {
> +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +       interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lpuart2 {
> +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +       interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> +&lpuart3 {
> +       compatible = "fsl,imx8dxl-lpuart", "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +       interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
> +};
> +
> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
