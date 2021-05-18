Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144EA38739C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347337AbhERH4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhERH4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:56:45 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00636C061573;
        Tue, 18 May 2021 00:55:27 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so7895813otc.6;
        Tue, 18 May 2021 00:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Ku+2qffcgpQdd0AjY56gzrAJrKY2KJcMohJ2tJvXf4=;
        b=Na0zHLilOIyO08nKHQ9Rk7cEScz+Er3m/qzB/L01gvI3zl19eiI1nmCTiIFcqS1Pvm
         V7MurMFawVuQDx7L/e5tNc03CXvfaIerVbi85B5I3S/UjyJSRE3RC3ESDMzIfqhtdxxh
         5Zz8FUME2fZh4YcNXs7N2zL1sB0/OlaLlAQpX6/OznJroWFEOLulIDmqOLQnuiiYT/xu
         KQDioiGZKc6ANZQIONcJftfy1bcbQDDBVToeGW7q5OWo8NCcMuxAvZO6U9vQAApFyl7n
         KpKNOThP0UYI1o+PFIDkkoQ1h1h6GgLIa2NpMK2zVV0PeQ1wwa9HsKLEAGFx/zaNiZeJ
         /fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Ku+2qffcgpQdd0AjY56gzrAJrKY2KJcMohJ2tJvXf4=;
        b=rKhupbVfLaOLXyAZ+CUy1qPg5unXN65crEIjdl7qRpBIqXE8qAbUSd9/pdYEyKBR75
         ONTkh3LC9DdDPrlyTEqSie9oS5Q35P4pOe+jJUaQ6Vnr+5CBPBpyPZdRfwOsoJOlawVq
         792PVH1gkU9dXioYxyi6tIEA5a53kKa8Tc/30DZEP0SE4+hO4Amw9oAbesxYgzV00/BT
         5RbPeeR04zAzm6rhJsR4TaedrDO+kFLhXOXIdctG4PWXDBCt8MCd8CiUlC5pel2nvb07
         gSPjWrnXfg9ChR/SHM0fRyu9jLkwLx+no0lyO+VePl2FoRY2E+vUjyCEHvmhPvpPsOvk
         e30Q==
X-Gm-Message-State: AOAM532tHUp0ONLJptyLLocDfYw808Jl+SudTbIMx1/ZeUlWa2RUjf0K
        lzPr70SlqxsuAQZ9y69PZmDEEOaHh8H6pCpXBE4=
X-Google-Smtp-Source: ABdhPJz2bDQvDTNVzRCoGcczOCh+FXQKGpbraKCSNpVie7voi/8Wq+IKI3U4tO+fUQ4PrTwb/YLSJS64jOKrYbWc1ko=
X-Received: by 2002:a9d:4115:: with SMTP id o21mr3240707ote.52.1621324527407;
 Tue, 18 May 2021 00:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210517171205.1581938-1-abelvesa@kernel.org> <20210517171205.1581938-6-abelvesa@kernel.org>
In-Reply-To: <20210517171205.1581938-6-abelvesa@kernel.org>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Tue, 18 May 2021 15:54:25 +0800
Message-ID: <CAA+hA=RNfWYaE81yYv5Dyt8QSXd_NTGcwjWwitiRNe4ZOtRWvw@mail.gmail.com>
Subject: Re: [PATCH 5/7] arm64: dts: freescale: Add ddr subsys dtsi for imx8dxl
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
> Add the ddr subsys dtsi for i.MX8DXL. Additional db pmu is added
> compared to i.MX8QXP.
>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  .../boot/dts/freescale/imx8dxl-ss-ddr.dtsi    | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
> new file mode 100644
> index 000000000000..640b43f5ae97
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2021 NXP
> + */
> +
> +&ddr_subsys {
> +       db_ipg_clk: clock-db-ipg {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <456000000>;
> +               clock-output-names = "db_ipg_clk";
> +       };
> +
> +       db_pmu0: db-pmu@5ca40000 {
> +               compatible = "fsl,imx8dxl-db-pmu";
> +               reg = <0x5ca40000 0x10000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&db_pmu0_lpcg 1>, <&db_pmu0_lpcg 0>;

fix lpcg index

> +               clock-names = "ipg", "cnt";
> +               power-domains = <&pd IMX_SC_R_PERF>;
> +       };
> +
> +       db_pmu0_lpcg: clock-controller@5cae0000 {
> +               compatible = "fsl,imx8qxp-lpcg";
> +               reg = <0x5cae0000 0x10000>;
> +               #clock-cells = <1>;
> +               clocks = <&db_ipg_clk>, <&db_ipg_clk>;
> +               bit-offset = <0 16>;

fix lpcg index by using macro

> +               clock-output-names = "perf_lpcg_cnt_clk",
> +                                    "perf_lpcg_ipg_clk";
> +               power-domains = <&pd IMX_SC_R_PERF>;
> +       };
> +};
> --
> 2.31.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
