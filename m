Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C593E8C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhHKIlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbhHKIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:41:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF013C0613D5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:41:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id z2so4133168lft.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RRXhxpsGGBaiNGCyD3hg6td+QSBXWB5z0qL251IrDq4=;
        b=eUmIOHzwisXtFKg49mSlkUJt8dGRHaqzBozWiWhzdPe8zHaOj6f30AKTlAcDd/lwb5
         t4zLhSo+WFWFP1R0ImhHYjgR4CCSbFHRxMLECl2Qshn1OxF5jzpVhIUE/4+FYbFet3f+
         gmve+QbPDuRAm+TQyHyiksrDXBapJDsvmXRBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RRXhxpsGGBaiNGCyD3hg6td+QSBXWB5z0qL251IrDq4=;
        b=tQqf2cqlOhSz4h2yXBYTj7TeNMeISDiGybw0lxs1tDf1UOnJPOioPXTBN3/gWHFeyA
         CQQ6ro4f5w+n6e95NnRCmhHMPorSOgLo6UAU4wdoXDqy/4byEJrNQyFRK6kbAVy2mSqR
         MMESNA3orjP5nsVY1SRNZ8OGKQ5woa4HTqn8krgnEIA+OkZDmYoyQPyye0KKljf+WM84
         IGJsIKbE7UDIGWhmDG1xzL2G1Lb6pXQAh7KWdFW2ANw1LsdyhqWrNd5K08FT2qzQnOZ9
         tnw6Gr0+4GKo7uIGfTEzgGg1i7aCeF5aTb9wvdk1FBIgvHOVi5g+TPknK2Wx7G/i2tKq
         YqbQ==
X-Gm-Message-State: AOAM531o2d8+JqTQJ0/eB+W1NPedxO2isyxB0oigsObs1owEG/p6IxCe
        +sV02QgpMrGu/QLkCHtV/cHjSA1wmEZY3ATdMp7bsg==
X-Google-Smtp-Source: ABdhPJwsZ0kR+wuRdn0H8ALHibyWYiHn6X3kKvBgnSFW7akG+ZYd5RyTPL8iL85Od9MwX7ggGlwRnvEVfNe08yrDK+g=
X-Received: by 2002:a19:c202:: with SMTP id l2mr24358532lfc.276.1628671276094;
 Wed, 11 Aug 2021 01:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <1626517079-9057-1-git-send-email-kewei.xu@mediatek.com> <1626517079-9057-4-git-send-email-kewei.xu@mediatek.com>
In-Reply-To: <1626517079-9057-4-git-send-email-kewei.xu@mediatek.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Wed, 11 Aug 2021 16:41:04 +0800
Message-ID: <CAGXv+5EGpUV0eaQ6duZ8y8u2dvc1y3uc2YwWP=07D+ZZpzMCvQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] i2c: mediatek: Reset the handshake signal between
 i2c and dma
To:     Kewei Xu <kewei.xu@mediatek.com>
Cc:     wsa@the-dreams.de, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-i2c@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        leilk.liu@mediatek.com, qii.wang@mediatek.com,
        yuhan.wei@mediatek.com, ot_daolong.zhu@mediatek.com,
        liguo.zhang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 17, 2021 at 6:29 PM Kewei Xu <kewei.xu@mediatek.com> wrote:
>
> Due to changes in the hardware design of the handshaking signal
> between i2c and dma, it is necessary to reset the handshaking
> signal before each transfer to ensure that the multi-msgs can
> be transferred correctly.

This also affects MT8192. Has this been tested on that SoC as well?

> Signed-off-by: Kewei Xu <kewei.xu@mediatek.com>
> ---
>  drivers/i2c/busses/i2c-mt65xx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 222ff765e55d..c0108387f34b 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -47,6 +47,9 @@
>  #define I2C_RD_TRANAC_VALUE            0x0001
>  #define I2C_SCL_MIS_COMP_VALUE         0x0000
>  #define I2C_CHN_CLR_FLAG               0x0000
> +#define I2C_CLR_DEBUGCTR               0x0000
> +#define I2C_RELIABILITY                        0x0010
> +#define I2C_DMAACK_ENABLE              0x0008
>
>  #define I2C_DMA_CON_TX                 0x0000
>  #define I2C_DMA_CON_RX                 0x0001
> @@ -850,6 +853,17 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>
>         reinit_completion(&i2c->msg_complete);
>
> +       if (i2c->dev_comp->apdma_sync) {
> +               mtk_i2c_writew(i2c, I2C_CLR_DEBUGCTR, OFFSET_DEBUGCTRL);
> +               writel(I2C_DMA_HANDSHAKE_RST | I2C_DMA_WARM_RST,
> +                      i2c->pdmabase + OFFSET_RST);
> +               writel(I2C_DMA_CLR_FLAG, i2c->pdmabase + OFFSET_RST);

I2C_DMA_WARM_RST is self-clearing. Is I2C_DMA_HANDSHAKE_RST not
self-clearing? If both are self-clearing, don't you need to wait and
check for them to cleared? If they aren't self-clearing, do you need
to delay some time for them to complete?

> +               mtk_i2c_writew(i2c, I2C_HANDSHAKE_RST, OFFSET_SOFTRESET);
> +               mtk_i2c_writew(i2c, I2C_CHN_CLR_FLAG, OFFSET_SOFTRESET);

Same here. No time delay needed?

> +               mtk_i2c_writew(i2c, I2C_RELIABILITY | I2C_DMAACK_ENABLE,
> +                              OFFSET_DEBUGCTRL);

A comment explaining what the section above does would be nice. AFAICU
this is force resetting the DMA handling.


Regards
ChenYu

> +       }
> +
>         control_reg = mtk_i2c_readw(i2c, OFFSET_CONTROL) &
>                         ~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
>         if ((i2c->speed_hz > I2C_MAX_FAST_MODE_PLUS_FREQ) || (left_num >= 1))
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
