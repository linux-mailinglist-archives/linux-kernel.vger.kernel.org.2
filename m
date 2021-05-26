Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4905C39111D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhEZHAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbhEZHAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:00:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD6EC061574;
        Tue, 25 May 2021 23:58:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x8so34640424wrq.9;
        Tue, 25 May 2021 23:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asQJuRHZZL4WwtmJ8EQ2cq+NU+3PT+sXgIdxpI2y5c0=;
        b=F385HquhA8pQgP88kNeygvh0iA4qA0eo0+zfUoqUfyb/Ilh8JMYa6v4q/taec07Co3
         IcuQ+4UdLC1Fk5fSXWoGW3NPbh185kCXOFMIha7dUOAWkaGeSufoZpkzaRT3bmtcdBXf
         PrVgOxosF71VoQwtFWXl90LSW1bxDNsywtBL9aS060eqarf7+gKSNkCEuyeAjVadnjti
         mNEhauz0p/7ApXpSDQOluNiSF1mgadOqZ3DR0LTN4+HxlGgOeE1YHO05+bZJ0FZX0hgv
         zWT9/2Qny0sGMlJpG2MSAWZAY20/vBdLiBXfXR16SGF/ybOFaZXwyxtaQeSYCQVNwRNf
         oE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asQJuRHZZL4WwtmJ8EQ2cq+NU+3PT+sXgIdxpI2y5c0=;
        b=ZZbZjDDNQ5IjvzchAptGeoDCG03zYNwhFxoPzb9IgXkiFCOveciT1jiz66OO3v2ZgB
         UGVs80hOH3GHa2WpPb6mg8s8qqmTF/KuGWrSJH1sViBExOYKg1QnhTa9e9MffvY3MycW
         zxIwM1TdeP906CSU14Q36VK4VBpB55hMYt7jIjVCtafuqi1JtYX09MN7Atvh/TjUoh3u
         kcQHo71DDY4CkZG71aBDPeJa7fUISCIUealgTzQMjpO002vdtXgSeJmCfz2B/TbveJcq
         s1Tw+OydkA4fvPDfJNSrEDJCdmSwrAEYQCANXRPgXijsOqR1vMc8GNXO+R2ZF/JX4opd
         jyIw==
X-Gm-Message-State: AOAM530c1y7cNEUpInFvqP9zHtNnu+2i52eGhSmUGbakJZkN818hrbx5
        ev13CicHdV6gGvUkzHIWO9Gn6XXoEq4YQv6PgDA=
X-Google-Smtp-Source: ABdhPJy7ZFxxkadGoPDk+I+el8lclKSv52+ihny8Dho6WcbKbefxAsie+z0FxrKnPLtHJjlxJ55ehC5SZREwPguvS44=
X-Received: by 2002:a5d:514b:: with SMTP id u11mr30714820wrt.350.1622012323954;
 Tue, 25 May 2021 23:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210507101926.25631-1-peng.fan@oss.nxp.com> <20210507101926.25631-3-peng.fan@oss.nxp.com>
In-Reply-To: <20210507101926.25631-3-peng.fan@oss.nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 26 May 2021 09:58:32 +0300
Message-ID: <CAEnQRZB25yt7NxUMD22FsuhcOBryo8NS3kJ20xsb0hOvAc10og@mail.gmail.com>
Subject: Re: [PATCH 2/4] mailbox: imx: replace the xTR/xRR array with single register
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 7, 2021 at 3:33 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> The xTR/xRR registers are using 4 bytes stride and continuous.
> Considering we will support more TR and RR registers, use base + idx * 4
> method to calculate register address, not hardcoding in driver.
>
Peng, this means that for imx8ul the Tx registers are not continuous
right? Please make this clear in
the commit message.

> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/mailbox/imx-mailbox.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 2543c7b6948b..bd7758c32a80 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -76,8 +76,8 @@ struct imx_mu_dcfg {
>         int (*tx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp, void *data);
>         int (*rx)(struct imx_mu_priv *priv, struct imx_mu_con_priv *cp);
>         void (*init)(struct imx_mu_priv *priv);
> -       u32     xTR[4];         /* Transmit Registers */
> -       u32     xRR[4];         /* Receive Registers */
> +       u32     xTR;            /* Transmit Register0 */
> +       u32     xRR;            /* Receive Register0 */
>         u32     xSR;            /* Status Register */
>         u32     xCR;            /* Control Register */
>  };
> @@ -120,7 +120,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
>
>         switch (cp->type) {
>         case IMX_MU_TYPE_TX:
> -               imx_mu_write(priv, *arg, priv->dcfg->xTR[cp->idx]);
> +               imx_mu_write(priv, *arg, priv->dcfg->xTR + cp->idx * 4);
>                 imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
>                 break;
>         case IMX_MU_TYPE_TXDB:
> @@ -140,7 +140,7 @@ static int imx_mu_generic_rx(struct imx_mu_priv *priv,
>  {
>         u32 dat;
>
> -       dat = imx_mu_read(priv, priv->dcfg->xRR[cp->idx]);
> +       dat = imx_mu_read(priv, priv->dcfg->xRR + (cp->idx) * 4);
>         mbox_chan_received_data(cp->chan, (void *)&dat);
>
>         return 0;
> @@ -172,7 +172,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
>                 }
>
>                 for (i = 0; i < 4 && i < msg->hdr.size; i++)
> -                       imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
> +                       imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
>                 for (; i < msg->hdr.size; i++) {
>                         ret = readl_poll_timeout(priv->base + priv->dcfg->xSR,
>                                                  xsr,
> @@ -182,7 +182,7 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
>                                 dev_err(priv->dev, "Send data index: %d timeout\n", i);
>                                 return ret;
>                         }
> -                       imx_mu_write(priv, *arg++, priv->dcfg->xTR[i % 4]);
> +                       imx_mu_write(priv, *arg++, priv->dcfg->xTR + (i % 4) * 4);
>                 }
>
>                 imx_mu_xcr_rmw(priv, IMX_MU_xCR_TIEn(cp->idx), 0);
> @@ -204,7 +204,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
>         u32 xsr;
>
>         imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(0));
> -       *data++ = imx_mu_read(priv, priv->dcfg->xRR[0]);
> +       *data++ = imx_mu_read(priv, priv->dcfg->xRR);
>
>         if (msg.hdr.size > sizeof(msg) / 4) {
>                 dev_err(priv->dev, "Maximal message size (%zu bytes) exceeded on RX; got: %i bytes\n", sizeof(msg), msg.hdr.size << 2);
> @@ -218,7 +218,7 @@ static int imx_mu_scu_rx(struct imx_mu_priv *priv,
>                         dev_err(priv->dev, "timeout read idx %d\n", i);
>                         return ret;
>                 }
> -               *data++ = imx_mu_read(priv, priv->dcfg->xRR[i % 4]);
> +               *data++ = imx_mu_read(priv, priv->dcfg->xRR + (i % 4) * 4);
>         }
>
>         imx_mu_xcr_rmw(priv, IMX_MU_xCR_RIEn(0), 0);
> @@ -564,8 +564,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx6sx = {
>         .tx     = imx_mu_generic_tx,
>         .rx     = imx_mu_generic_rx,
>         .init   = imx_mu_init_generic,
> -       .xTR    = {0x0, 0x4, 0x8, 0xc},
> -       .xRR    = {0x10, 0x14, 0x18, 0x1c},
> +       .xTR    = 0x0,
> +       .xRR    = 0x10,
>         .xSR    = 0x20,
>         .xCR    = 0x24,
>  };
> @@ -574,8 +574,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx7ulp = {
>         .tx     = imx_mu_generic_tx,
>         .rx     = imx_mu_generic_rx,
>         .init   = imx_mu_init_generic,
> -       .xTR    = {0x20, 0x24, 0x28, 0x2c},
> -       .xRR    = {0x40, 0x44, 0x48, 0x4c},
> +       .xTR    = 0x20,
> +       .xRR    = 0x40,
>         .xSR    = 0x60,
>         .xCR    = 0x64,
>  };
> @@ -584,8 +584,8 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8_scu = {
>         .tx     = imx_mu_scu_tx,
>         .rx     = imx_mu_scu_rx,
>         .init   = imx_mu_init_scu,
> -       .xTR    = {0x0, 0x4, 0x8, 0xc},
> -       .xRR    = {0x10, 0x14, 0x18, 0x1c},
> +       .xTR    = 0x0
> +       .xRR    = 0x10
>         .xSR    = 0x20,
>         .xCR    = 0x24,
>  };
> --
> 2.30.0
>
