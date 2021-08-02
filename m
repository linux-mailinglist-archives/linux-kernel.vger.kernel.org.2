Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B299C3DE2CB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 01:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhHBXBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 19:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231126AbhHBXBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 19:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6557D60D07;
        Mon,  2 Aug 2021 23:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627945250;
        bh=e822VuDx6z8sMZ4u2JoN2zmm7TSpCXSrlQ2PRMcE4RA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JxOIrHwDEsSnb0iq0rIpsYlOLoG24P4miwqyD1FG7n4FWHzwDNfy/NHjYdDMu5Qji
         kXPSkX44FzNpdxEJtmmIARGgMRDYC9iIdUV2TyjtD0Sq+Kg/QNdoUV6RLsJm3/acl7
         25pdODPscvgAAJXGUOgPzTBKvkfiDzgA/ato56Vb671pWbF2IJGQzrlpL81XqgcdW3
         pRcpknNaL3LOwPZKRRkwGd2LdUK2o8yDLvrlVmcOBcoyoiz7VZp8vqJysP6tbh3Cse
         8+95COQy5cbA3qCXkRhDTUyY/YfbD6G1rfhrCL41k18t2xk1f7jCngE/ya9GL8S5ER
         FfHzzKXcHrclw==
Received: by mail-ed1-f52.google.com with SMTP id n2so26585463eda.10;
        Mon, 02 Aug 2021 16:00:50 -0700 (PDT)
X-Gm-Message-State: AOAM530l68U0ARElBsVYDOR4IUYkvt9fboaELtpiTOxi8cRAB/Wc5w1A
        BB3DeG/PyyO3L7DJ6pP2iVW/SsozrZpLVy8o7A==
X-Google-Smtp-Source: ABdhPJx6Gl9WihqORzSylHXdbZm8MM0D7sQz2BcZWhMz275j1ol0e9w/UzfEvJ6WuteyWfPe8BLhoqmL0forF5o0OZA=
X-Received: by 2002:a05:6402:718:: with SMTP id w24mr21831525edx.49.1627945249057;
 Mon, 02 Aug 2021 16:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <1626762588-6020-1-git-send-email-yongqiang.niu@mediatek.com> <1626762588-6020-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1626762588-6020-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 3 Aug 2021 07:00:37 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9ynURx3Arevk_Tdc2V2uobJbeRA_2JjmZtsc=wT2V6aA@mail.gmail.com>
Message-ID: <CAAOTY_9ynURx3Arevk_Tdc2V2uobJbeRA_2JjmZtsc=wT2V6aA@mail.gmail.com>
Subject: Re: [PATCH v5] drm/mediatek: add dither 6 setting
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B47=E6=9C=
=8820=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:30=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> dither 6 setting is missed in a6b7c98afdca
> bit 1 is lfsr_en( "Enables LFSR-type dithering"), need enable
> bit 2 is rdither_en(Enables running order dithering), need disable
>
> Fixes: a6b7c98afdca(drm/mediatek: add mtk_dither_set_common())
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index 99cbf44..7dd8e05 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -26,6 +26,7 @@
>  #define DISP_OD_CFG                            0x0020
>  #define DISP_OD_SIZE                           0x0030
>  #define DISP_DITHER_5                          0x0114
> +#define DISP_DITHER_6                          0x0118
>  #define DISP_DITHER_7                          0x011c
>  #define DISP_DITHER_15                         0x013c
>  #define DISP_DITHER_16                         0x0140
> @@ -135,6 +136,7 @@ void mtk_dither_set_common(void __iomem *regs, struct=
 cmdq_client_reg *cmdq_reg,
>
>         if (bpc >=3D MTK_MIN_BPC) {
>                 mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_5)=
;
> +               mtk_ddp_write(cmdq_pkt, 0x3002, cmdq_reg, regs, DISP_DITH=
ER_6);

Symbolized 0x3002. BIT(1) is lfsr_en.

Regards,
Chun-Kuang.

>                 mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_7)=
;
>                 mtk_ddp_write(cmdq_pkt,
>                               DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
> --
> 1.8.1.1.dirty
>
