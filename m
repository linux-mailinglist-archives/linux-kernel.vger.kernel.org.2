Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327453CF439
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhGTFWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 01:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbhGTFWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 01:22:32 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FD9C061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:03:10 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id b6so18179095iln.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86QVHJVxOCndQaXxHRwaOxxcq7eMK28HT05PxvcoBYI=;
        b=bu4dAUXhDfU3dlbFBsoThBblvvUC91XDro9V2evK/M12RqO1wW4gp88UdAm/F2rtFC
         Q/1ToZcP/0N8Nvxc65pfwLiL5UsrZuJIsOZIglgaGTuSjDq2XEYJy8yhmbnivp59FXrO
         5dgDFoUDO3t/Gm2bavuKXttbdx1eZLMxFrMqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86QVHJVxOCndQaXxHRwaOxxcq7eMK28HT05PxvcoBYI=;
        b=VInIdcu+jTzRgYX0cMc5uw/LuoBYeK6ot+l3RGd46yaetlxZjBD+raMEmXg/yuJNZh
         avgcrk42I3txHLOqFA+DLIQAI02Ch4cQGf9IyV6c+wI+B1kG8gjGYgSJcd41+bFTBP+P
         m+4DNUU2EFqr/A5rKINQOeEDG3WAyPOo0f1MD9P/Fs2D2I0Ze4jNsUd9gey9RqBHed9s
         lXqKh3K5DCRIdRG940Rl+p/R5QD/f06OgfQYvVcHZOAJnTeD1jT5AoLQLuYECE1LvnID
         xGhcMCSS4e0xVdGzfgtGiRMiQP31WbOylLOOdL2yFVXMBPX04srkQapxOYIBjLzA8tH5
         JtYA==
X-Gm-Message-State: AOAM531IAjyeqWJvV21CnJy4zI1FrOUdNJWfhMsCgFAxNM938U8NREs2
        haFe7k+BfuL0PLTl9CYk45buubrWhvH6LfnWKk0C4A==
X-Google-Smtp-Source: ABdhPJwFk6YVkmc9gpzvQzRgdkNx/5Ot14DkNuPE+cqjEdJYOOoLrPx04nhKCCVAgpn8DccUvt9FPHZ2ECPmqkXRtQk=
X-Received: by 2002:a92:d305:: with SMTP id x5mr20209347ila.150.1626760989584;
 Mon, 19 Jul 2021 23:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <1626760277-5733-1-git-send-email-yongqiang.niu@mediatek.com> <1626760277-5733-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1626760277-5733-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 20 Jul 2021 14:02:43 +0800
Message-ID: <CAJMQK-jK0WRgU47YZ8+Jdt50y2CnkUjHKT2C+xfTvgst9bTmTg@mail.gmail.com>
Subject: Re: [PATCH v3] Fixes: a6b7c98afdca(drm/mediatek: add
 mtk_dither_set_common() function)
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
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 1:51 PM Yongqiang Niu
<yongqiang.niu@mediatek.com> wrote:
>
> dither 6 setting is missed in a6b7c98afdca
> bit 1 is lfsr_en( "Enables LFSR-type dithering"), need enable
> bit 2 is rdither_en(Enables running order dithering), need disable
>

Fixes tag should be here, and the title of this patch should be the
same as v2: drm/mediatek: add dither 6 setting

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
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
> @@ -135,6 +136,7 @@ void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
>
>         if (bpc >= MTK_MIN_BPC) {
>                 mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_5);
> +               mtk_ddp_write(cmdq_pkt, 0x3002, cmdq_reg, regs, DISP_DITHER_6);
>                 mtk_ddp_write(cmdq_pkt, 0, cmdq_reg, regs, DISP_DITHER_7);
>                 mtk_ddp_write(cmdq_pkt,
>                               DITHER_LSB_ERR_SHIFT_R(MTK_MAX_BPC - bpc) |
> --
> 1.8.1.1.dirty
>
