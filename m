Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63933D0FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbhGUNAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 09:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbhGUM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:59:58 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17DC00EE52
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:40:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p5-20020a17090a8685b029015d1a9a6f1aso959349pjn.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 06:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zLU7xCdFtfu9+Bw/8ezSHg3AfeYZUFk7U4CAtgzsSk=;
        b=DLHpRRbO2RjAuMVpphDwHJoRmp8oEEm2MATAeF6UdAuJwx6eZbHLhj/xa1KIBmUapU
         vvrK/O8gHWiQUba4dp6grGuRxiZInd+ONetpTm56l+rBFizt/z7Dy9AYvs9HhYvLMNfQ
         OprQNoqgEfTNr0CZ8TwU+aR/v2mVhyzcaf6M8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zLU7xCdFtfu9+Bw/8ezSHg3AfeYZUFk7U4CAtgzsSk=;
        b=M/YBYZ66aWA49kZAQUPTjbQHD9QPAQSeiJvTTiBUOmzXsza3g6rU5m8GAAKksG6SFt
         Im56owGX41A15Pp3r5q5kmakoVzvLXeyxniZTRxFTNtBYLyL7MJCpYVkhut6u6whQooe
         ROT23nc0v5F0k2Holf5UFdhTV+NHfvxDz/NdiaJwmE7yeb8BgYwt6u8gZ7foqnRHA+Dk
         eq2er9kQvWJsbggoL1NsfH7T8kXWgneC0ITigDnMpFlFFdFGb0b71CpGNiaBue7KeQRJ
         HSWNKj9xa8D5Q3bBk/6byAkDfjuQDq/MoV+pLndFPdW+mWoZnK2h0qmqhKYGgzc4Yv/C
         niEA==
X-Gm-Message-State: AOAM530iaa3QHWxr3bxW2ktPdtezWGHM1IIM6cClfA1nFr7z6dkBSdt6
        VioaRp+HRczDfjmVI7p4s0iXqRsxaxDC2ktCPvxsEw==
X-Google-Smtp-Source: ABdhPJx22xhPEIxOvOdw0zD9THkPvLXa3uzUD5hc6KKSjL7/wue/Gk1Ox9vE25uU+NrX5EvLd6pJ/RDET8kRqJVOJzU=
X-Received: by 2002:a17:90a:4f02:: with SMTP id p2mr3750645pjh.112.1626874829285;
 Wed, 21 Jul 2021 06:40:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-12-yong.wu@mediatek.com>
In-Reply-To: <20210715121209.31024-12-yong.wu@mediatek.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Wed, 21 Jul 2021 21:40:18 +0800
Message-ID: <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] memory: mtk-smi: mt8195: Add initial setting for smi-larb
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, ming-fan.chen@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> To improve the performance, We add some initial setting for smi larbs.
> there are two part:
> 1), Each port has the special ostd(outstanding) value in each larb.
> 2), Two general setting for each larb.
>
> In some SoC, this setting maybe changed dynamically for some special case
> like 4K, and this initial setting is enough in mt8195.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 74 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index c52bf02458ff..1d9e67520433 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -32,6 +32,14 @@
>  #define SMI_DUMMY                      0x444
>
>  /* SMI LARB */
> +#define SMI_LARB_CMD_THRT_CON          0x24
> +#define SMI_LARB_THRT_EN               0x370256
> +
> +#define SMI_LARB_SW_FLAG               0x40
> +#define SMI_LARB_SW_FLAG_1             0x1
> +
> +#define SMI_LARB_OSTDL_PORT            0x200
> +#define SMI_LARB_OSTDL_PORTx(id)       (SMI_LARB_OSTDL_PORT + (((id) & 0x1f) << 2))
>
>  /* Below are about mmu enable registers, they are different in SoCs */
>  /* mt2701 */
> @@ -67,6 +75,11 @@
>  })
>
>  #define SMI_COMMON_INIT_REGS_NR                6
> +#define SMI_LARB_PORT_NR_MAX           32
> +
> +#define MTK_SMI_FLAG_LARB_THRT_EN      BIT(0)
> +#define MTK_SMI_FLAG_LARB_SW_FLAG      BIT(1)
> +#define MTK_SMI_CAPS(flags, _x)                (!!((flags) & (_x)))
>
>  struct mtk_smi_reg_pair {
>         unsigned int            offset;
> @@ -97,6 +110,8 @@ struct mtk_smi_larb_gen {
>         int port_in_larb[MTK_LARB_NR_MAX + 1];
>         void (*config_port)(struct device *dev);
>         unsigned int                    larb_direct_to_common_mask;
> +       unsigned int                    flags_general;
> +       const u8                        (*ostd)[SMI_LARB_PORT_NR_MAX];
>  };
>
>  struct mtk_smi {
> @@ -213,12 +228,22 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
>  static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>  {
>         struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> -       u32 reg;
> +       u32 reg, flags_general = larb->larb_gen->flags_general;
> +       const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
>         int i;
>
>         if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
>                 return;
>
> +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_THRT_EN))
> +               writel_relaxed(SMI_LARB_THRT_EN, larb->base + SMI_LARB_CMD_THRT_CON);
> +
> +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_SW_FLAG))
> +               writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
> +
> +       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> +               writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));

All other mtk platform's larbs have the same format for SMI_LARB_OSTDL_PORTx()
registers at the same offset? or is this unique feature for mt8195?

> +
>         for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
>                 reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
>                 reg |= F_MMU_EN;
> @@ -227,6 +252,51 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
>         }
>  }
>
> +static const u8 mtk_smi_larb_mt8195_ostd[][SMI_LARB_PORT_NR_MAX] = {
> +       [0] = {0x0a, 0xc, 0x22, 0x22, 0x01, 0x0a,}, /* larb0 */
> +       [1] = {0x0a, 0xc, 0x22, 0x22, 0x01, 0x0a,}, /* larb1 */
> +       [2] = {0x12, 0x12, 0x12, 0x12, 0x0a,},      /* ... */
> +       [3] = {0x12, 0x12, 0x12, 0x12, 0x28, 0x28, 0x0a,},
> +       [4] = {0x06, 0x01, 0x17, 0x06, 0x0a,},
> +       [5] = {0x06, 0x01, 0x17, 0x06, 0x06, 0x01, 0x06, 0x0a,},
> +       [6] = {0x06, 0x01, 0x06, 0x0a,},
> +       [7] = {0x0c, 0x0c, 0x12,},
> +       [8] = {0x0c, 0x0c, 0x12,},
> +       [9] = {0x0a, 0x08, 0x04, 0x06, 0x01, 0x01, 0x10, 0x18, 0x11, 0x0a,
> +               0x08, 0x04, 0x11, 0x06, 0x02, 0x06, 0x01, 0x11, 0x11, 0x06,},
> +       [10] = {0x18, 0x08, 0x01, 0x01, 0x20, 0x12, 0x18, 0x06, 0x05, 0x10,
> +               0x08, 0x08, 0x10, 0x08, 0x08, 0x18, 0x0c, 0x09, 0x0b, 0x0d,
> +               0x0d, 0x06, 0x10, 0x10,},
> +       [11] = {0x0e, 0x0e, 0x0e, 0x0e, 0x0e, 0x0e, 0x01, 0x01, 0x01, 0x01,},
> +       [12] = {0x09, 0x09, 0x05, 0x05, 0x0c, 0x18, 0x02, 0x02, 0x04, 0x02,},
> +       [13] = {0x02, 0x02, 0x12, 0x12, 0x02, 0x02, 0x02, 0x02, 0x08, 0x01,},
> +       [14] = {0x12, 0x12, 0x02, 0x02, 0x02, 0x02, 0x16, 0x01, 0x16, 0x01,
> +               0x01, 0x02, 0x02, 0x08, 0x02,},
> +       [15] = {},
> +       [16] = {0x28, 0x02, 0x02, 0x12, 0x02, 0x12, 0x10, 0x02, 0x02, 0x0a,
> +               0x12, 0x02, 0x0a, 0x16, 0x02, 0x04,},
> +       [17] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
> +       [18] = {0x12, 0x06, 0x12, 0x06,},
> +       [19] = {0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x04, 0x01,
> +               0x01, 0x01, 0x04, 0x0a, 0x06, 0x01, 0x01, 0x01, 0x0a, 0x06,
> +               0x01, 0x01, 0x05, 0x03, 0x03, 0x04, 0x01,},
> +       [20] = {0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x04, 0x01,
> +               0x01, 0x01, 0x04, 0x0a, 0x06, 0x01, 0x01, 0x01, 0x0a, 0x06,
> +               0x01, 0x01, 0x05, 0x03, 0x03, 0x04, 0x01,},
> +       [21] = {0x28, 0x19, 0x0c, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04,},
> +       [22] = {0x28, 0x19, 0x0c, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04,},
> +       [23] = {0x18, 0x01,},
> +       [24] = {0x01, 0x01, 0x04, 0x01, 0x01, 0x01, 0x01, 0x01, 0x04, 0x01,
> +               0x01, 0x01,},
> +       [25] = {0x02, 0x02, 0x02, 0x28, 0x16, 0x02, 0x02, 0x02, 0x12, 0x16,
> +               0x02, 0x01,},
> +       [26] = {0x02, 0x02, 0x02, 0x28, 0x16, 0x02, 0x02, 0x02, 0x12, 0x16,
> +               0x02, 0x01,},
> +       [27] = {0x02, 0x02, 0x02, 0x28, 0x16, 0x02, 0x02, 0x02, 0x12, 0x16,
> +               0x02, 0x01,},
> +       [28] = {0x1a, 0x0e, 0x0a, 0x0a, 0x0c, 0x0e, 0x10,},
> +};
> +
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt2701 = {
>         .port_in_larb = {
>                 LARB0_PORT_OFFSET, LARB1_PORT_OFFSET,
> @@ -269,6 +339,8 @@ static const struct mtk_smi_larb_gen mtk_smi_larb_mt8192 = {
>
>  static const struct mtk_smi_larb_gen mtk_smi_larb_mt8195 = {
>         .config_port                = mtk_smi_larb_config_port_gen2_general,
> +       .flags_general              = MTK_SMI_FLAG_LARB_THRT_EN | MTK_SMI_FLAG_LARB_SW_FLAG,
> +       .ostd                       = mtk_smi_larb_mt8195_ostd,
>  };
>
>  static const struct of_device_id mtk_smi_larb_of_ids[] = {
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
