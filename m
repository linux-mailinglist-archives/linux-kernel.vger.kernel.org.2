Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009993A0E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237339AbhFIHzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:55:10 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:41805 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbhFIHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:55:08 -0400
Received: by mail-il1-f174.google.com with SMTP id t6so16952729iln.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaMmJ7k/BA6wFJk3ZATOxTWqaw6DpQ+qnTYlU65VAJg=;
        b=DxNoHnoQMTFxaXjpdN0XlT6hKe7ppTriU7fZPnvEO05MytIXZrM9OCTtH3lItbNDKz
         gl4v4h53dX3nd8HWtJt+JAy+2bVxxBh2BASVUYttK8YAM0I1AvEdjLN/IfPw1/6KwPSs
         X5/gB8jhEr54PpIfHjiMqE/nHS2RJeoFwN/H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaMmJ7k/BA6wFJk3ZATOxTWqaw6DpQ+qnTYlU65VAJg=;
        b=V67GVy+CNX7kGqAx6Fbu/JfTqrLq+VymOODiZjEPqnAWky92bzpbp9Hifvrxebr9xl
         cCV9OMn0Rg0CbYI/4LqWot+sHjPp74AjoiLFQOx3I1yv1QUUbrMFvzdmHrJXzts9e5r9
         znCtcairnxDL2HVPVENTFqUSL99tY/utOw0prh5nwrKzGQu3Q0HeL1IN/9qdP0jmY/7+
         tyxyP7jCUpQ8gXvgOg5DV956w4OUshFSeZD7DhKRbNpu62CDHrrP1UP1VoaxVy/NFgja
         CRFd1MvEiAXE3f0Z+mWBRTp3qQQDzH2FHgORVE2SlOxpnk5sghb41kJaWItLAkOVlMjP
         j2Og==
X-Gm-Message-State: AOAM531g9/A/tp9U3HgBum+1yKSYef3wf24d02Y8fEOefHVykePHzMwM
        MeHvG4yw/oF1T8OW3nFO+1UqQIrPk3o6Kw==
X-Google-Smtp-Source: ABdhPJw1TU2oPu3NjntbLhEwuvFzswxfB1591wGXT/Gywva7E+WsDZLWuhIMGvwZnQlPN4F2nAWiqg==
X-Received: by 2002:a02:c906:: with SMTP id t6mr24792451jao.117.1623225133754;
        Wed, 09 Jun 2021 00:52:13 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id s23sm1028291iol.49.2021.06.09.00.52.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 00:52:13 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id i13so18341022ilk.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 00:52:12 -0700 (PDT)
X-Received: by 2002:a92:d312:: with SMTP id x18mr22379736ila.90.1623225132502;
 Wed, 09 Jun 2021 00:52:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210602112050.12338-1-james.lo@mediatek.com> <20210602112050.12338-3-james.lo@mediatek.com>
In-Reply-To: <20210602112050.12338-3-james.lo@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 9 Jun 2021 15:51:36 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhUB=6y1SXUvAuhdj69S36FQnp9nr9V65TtS72pxuoRTg@mail.gmail.com>
Message-ID: <CAC=S1nhUB=6y1SXUvAuhdj69S36FQnp9nr9V65TtS72pxuoRTg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: pwrap: add pwrap driver for MT8195 SoC
To:     James Lo <james.lo@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henry Chen <henryc.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 2, 2021 at 7:21 PM James Lo <james.lo@mediatek.com> wrote:
>
> From: Henry Chen <henryc.chen@mediatek.com>
>
> MT8195 are highly integrated SoC and use PMIC_MT6359 for
> power management. This patch adds pwrap master driver to
> access PMIC_MT6359.
>
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 35 ++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index e4de75f35c33..952bc554f443 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -961,6 +961,23 @@ static int mt8183_regs[] = {
>         [PWRAP_WACS2_VLDCLR] =                  0xC28,
>  };
>
> +static int mt8195_regs[] = {
> +       [PWRAP_INIT_DONE2] =            0x0,
> +       [PWRAP_STAUPD_CTRL] =           0x4C,
> +       [PWRAP_TIMER_EN] =              0x3E4,
> +       [PWRAP_INT_EN] =                0x420,
> +       [PWRAP_INT_FLG] =               0x428,
> +       [PWRAP_INT_CLR] =               0x42C,
> +       [PWRAP_INT1_EN] =               0x450,
> +       [PWRAP_INT1_FLG] =              0x458,
> +       [PWRAP_INT1_CLR] =              0x45C,
> +       [PWRAP_WACS2_CMD] =             0x880,
> +       [PWRAP_SWINF_2_WDATA_31_0] =    0x884,
> +       [PWRAP_SWINF_2_RDATA_31_0] =    0x894,
> +       [PWRAP_WACS2_VLDCLR] =          0x8A4,
> +       [PWRAP_WACS2_RDATA] =           0x8A8,
> +};
> +
>  static int mt8516_regs[] = {
>         [PWRAP_MUX_SEL] =               0x0,
>         [PWRAP_WRAP_EN] =               0x4,
> @@ -1066,6 +1083,7 @@ enum pwrap_type {
>         PWRAP_MT8135,
>         PWRAP_MT8173,
>         PWRAP_MT8183,
> +       PWRAP_MT8195,
>         PWRAP_MT8516,
>  };
>
> @@ -1525,6 +1543,7 @@ static int pwrap_init_cipher(struct pmic_wrapper *wrp)
>                 break;
>         case PWRAP_MT6873:
>         case PWRAP_MT8183:
> +       case PWRAP_MT8195:
>                 break;
>         }
>
> @@ -2025,6 +2044,19 @@ static const struct pmic_wrapper_type pwrap_mt8183 = {
>         .init_soc_specific = pwrap_mt8183_init_soc_specific,
>  };
>
> +static struct pmic_wrapper_type pwrap_mt8195 = {
> +       .regs = mt8195_regs,
> +       .type = PWRAP_MT8195,
> +       .arb_en_all = 0x777f, /* NEED CONFIRM */
> +       .int_en_all = 0x180000, /* NEED CONFIRM */

Please get the confirmative values here then send the next patch, thanks.


> +       .int1_en_all = 0,
> +       .spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> +       .wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> +       .caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_ARB,
> +       .init_reg_clock = pwrap_common_init_reg_clock,
> +       .init_soc_specific = NULL,
> +};
> +
>  static struct pmic_wrapper_type pwrap_mt8516 = {
>         .regs = mt8516_regs,
>         .type = PWRAP_MT8516,
> @@ -2065,6 +2097,9 @@ static const struct of_device_id of_pwrap_match_tbl[] = {
>         }, {
>                 .compatible = "mediatek,mt8183-pwrap",
>                 .data = &pwrap_mt8183,
> +       }, {
> +               .compatible = "mediatek,mt8195-pwrap",
> +               .data = &pwrap_mt8195,
>         }, {
>                 .compatible = "mediatek,mt8516-pwrap",
>                 .data = &pwrap_mt8516,
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
