Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83C74304FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 23:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbhJPVEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhJPVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 17:04:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA22C061765;
        Sat, 16 Oct 2021 14:02:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d3so52830462edp.3;
        Sat, 16 Oct 2021 14:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8RptWSTYh1UiIYmEmk7oOt0TCMDLze5CjXcCV1alrU=;
        b=b7eVvyby3iXfNWRtTVB07EYk0yXX4uoCIjrQGSn0qUIi4NVbxrdyUTRSQmuOhsLIOG
         DUw+k8mEuFccYZPEyr/M8vvmeMXqlJYn2t63oHTa1pifFTtDnvY+x7HuZnmfmjV265Lu
         AVEISten7LBM0c2ps1lu3Xrqxje3/2KRTC2MP0D/KK+jZk64HOUY7mkT3E3SLVoLfYUZ
         APvR2K6TObeaTxC4Pt11uFxFpdyXh0jD4VBPa0srr4568lgDnHUR5mOiOD3XqqLFrl5g
         WfnzSFay9M4H7cNjGB2Gp0dPplPcKZ12pGErPWYzseArlC5kQr4/sPu2oWdB/ZSVXaKK
         bv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8RptWSTYh1UiIYmEmk7oOt0TCMDLze5CjXcCV1alrU=;
        b=fA0KhJFW2ewU9NqXssaM2RtgSdF0X54zdZNgBj6NtTVudCTVOKtOp1F2Zc/yElImYl
         fVhmzPoUvpws+rRcJSjJvkPAP5dTBJvzsK2CgCYp0pddyIQLBZpqZwB1uVdf1KJY/3h7
         nmzZQEJGWnUxMGY5S4lODBXpqIPw/MQi9jdEsuDQib0Vs6qSxp2s1CRvt7aKRcMAUgMK
         wNou3/3PI8EGmAvO/BjClp4usoXB8UkS46klT4fAeoE5gdFLV5uIheY+hJvSSewnDq2q
         6wZSY5FZiN+lk0UBKIX6LlECDOGRFrN294knStwemPZDy3u5ej4V6/TmZJxM5HCJ07tX
         TkPg==
X-Gm-Message-State: AOAM533Rky5T81IpF5ijK09Iaspoj8b63c9ixYq/TjfovZRenHDZZ1n0
        k5HrlB7Vn7S/7m+tXwY3fSKKOMksjs8V/xIYDro=
X-Google-Smtp-Source: ABdhPJyGqgZMYbjFw3DiUaBm0clqq3FWSpQe5aQRGmEpmn/CVgAGggoizx+RSeG4mRwAm++rD0/ArXtNweosmUXx1v0=
X-Received: by 2002:a05:6402:3586:: with SMTP id y6mr29561747edc.292.1634418162208;
 Sat, 16 Oct 2021 14:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211009162700.1452857-1-aford173@gmail.com> <20211009162700.1452857-6-aford173@gmail.com>
In-Reply-To: <20211009162700.1452857-6-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Sat, 16 Oct 2021 16:02:31 -0500
Message-ID: <CAHCN7x+N2D85=KVxyZM1noG8ovBuasHkVHG3vzXOGzW3wxZFCw@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 9, 2021 at 11:27 AM Adam Ford <aford173@gmail.com> wrote:
>
> This adds the description for the i.MX8MN disp blk-ctrl.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---

Does anyone from NXP have any feedback on this?
I tried to look at the ISI driver and power domain and understand it,
but it's not present in the 8mm, so I went off my best understanding
of the datasheet.

adam

>  drivers/soc/imx/imx8m-blk-ctrl.c | 75 +++++++++++++++++++++++++++++++-
>  1 file changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
> index e172d295c441..8d3bf7690383 100644
> --- a/drivers/soc/imx/imx8m-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8m-blk-ctrl.c
> @@ -14,6 +14,7 @@
>  #include <linux/clk.h>
>
>  #include <dt-bindings/power/imx8mm-power.h>
> +#include <dt-bindings/power/imx8mn-power.h>
>
>  #define BLK_SFT_RSTN   0x0
>  #define BLK_CLK_EN     0x4
> @@ -498,6 +499,75 @@ static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
>         .num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
>  };
>
> +
> +static int imx8mn_disp_power_notifier(struct notifier_block *nb,
> +                                     unsigned long action, void *data)
> +{
> +       struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
> +                                                power_nb);
> +
> +       if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
> +               return NOTIFY_OK;
> +
> +       /* Enable bus clock and deassert bus reset */
> +       regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
> +       regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
> +
> +       /*
> +        * On power up we have no software backchannel to the GPC to
> +        * wait for the ADB handshake to happen, so we just delay for a
> +        * bit. On power down the GPC driver waits for the handshake.
> +        */
> +       if (action == GENPD_NOTIFY_ON)
> +               udelay(5);
> +
> +
> +       return NOTIFY_OK;
> +}
> +
> +static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
> +       [IMX8MN_DISPBLK_PD_MIPI_DSI] = {
> +               .name = "dispblk-mipi-dsi",
> +               .clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
> +               .num_clks = 2,
> +               .gpc_name = "mipi-dsi",
> +               .rst_mask = BIT(0) | BIT(1),
> +               .clk_mask = BIT(0) | BIT(1),
> +       },
> +       [IMX8MN_DISPBLK_PD_MIPI_CSI] = {
> +               .name = "dispblk-mipi-csi",
> +               .clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
> +               .num_clks = 2,
> +               .gpc_name = "mipi-csi",
> +               .rst_mask = BIT(2) | BIT(3),
> +               .clk_mask = BIT(2) | BIT(3),
> +       },
> +       [IMX8MN_DISPBLK_PD_LCDIF] = {
> +               .name = "dispblk-lcdif",
> +               .clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
> +               .num_clks = 3,
> +               .gpc_name = "lcdif",
> +               .rst_mask = BIT(4) | BIT(5),
> +               .clk_mask = BIT(4) | BIT(5),
> +       },
> +       [IMX8MN_DISPBLK_PD_ISI] = {
> +               .name = "dispblk-isi",
> +               .clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
> +                                               "disp_apb_root"},
> +               .num_clks = 4,
> +               .gpc_name = "isi",
> +               .rst_mask = BIT(6) | BIT(7),
> +               .clk_mask = BIT(6) | BIT(7),
> +       },
> +};
> +
> +static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
> +       .max_reg = 0x84,
> +       .power_notifier_fn = imx8mn_disp_power_notifier,
> +       .domains = imx8mn_disp_blk_ctl_domain_data,
> +       .num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
> +};
> +
>  static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>         {
>                 .compatible = "fsl,imx8mm-vpu-blk-ctrl",
> @@ -505,7 +575,10 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
>         }, {
>                 .compatible = "fsl,imx8mm-disp-blk-ctrl",
>                 .data = &imx8mm_disp_blk_ctl_dev_data
> -       } ,{
> +       }, {
> +               .compatible = "fsl,imx8mn-disp-blk-ctrl",
> +               .data = &imx8mn_disp_blk_ctl_dev_data
> +       }, {
>                 /* Sentinel */
>         }
>  };
> --
> 2.25.1
>
