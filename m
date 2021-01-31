Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77801309A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 05:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhAaEIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 23:08:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229468AbhAaEIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 23:08:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ECA464DE1;
        Sun, 31 Jan 2021 04:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612066080;
        bh=lKzleoYse1WWmJcEChAlbjscN0Xf+sfihtZYkKKf85s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RWQf8SYdSv6eW75bS6nIagPxR+FCSnmORl3bIgEGJ3vBtaqpCzaTrbdxvbVY+6Qo5
         2oyQr9/j5bAionYHmI5M/+bQpNcEntjzcy0pD9ipwyG2r4H/DEsHmhnXc0YC62+DP4
         aCUnNSHp+VTDWNdgzcvZROMdEFz/h6DkuNd+cRBRJ4Bc8pImCQropngMe6XXKPeCO5
         C2sK9omvgOlQwrrmDwPf1gZyxwGi4ozlCCzEQSOuQimsyfaR+4I+sH3XC0l4pkxfCR
         KuHs/1Dh0HXNOnTBZY1ixUy6WM0RBD0CICaqm6MsJ3ueg63cygUFBRocCI/ER9ElRk
         rZY4Bkzp+70SQ==
Received: by mail-ej1-f41.google.com with SMTP id r12so18970384ejb.9;
        Sat, 30 Jan 2021 20:08:00 -0800 (PST)
X-Gm-Message-State: AOAM531NnuzWJkxoy/N/Yj70f7w3KbfrQ5rZJDg9uNVqHMKXyYMTNanw
        XJ74gX/F2j3HlHXy6xkdQH2J89K73yCGR2yNJw==
X-Google-Smtp-Source: ABdhPJxQHiYJAWIUOtxU2P4rTwKUPjdQjw180RpM2UyZdDEwwxkcERAsh+oIHZQM95GqTQnSkSevj61XorkLzNvhgoY=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr11678160ejy.63.1612066079184;
 Sat, 30 Jan 2021 20:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20210129073436.2429834-1-hsinyi@chromium.org> <20210129073436.2429834-6-hsinyi@chromium.org>
In-Reply-To: <20210129073436.2429834-6-hsinyi@chromium.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 31 Jan 2021 12:07:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-e4CGXVfUdYBBx6ewEopZrfmuf2d6y77i=-hZ4P13N1g@mail.gmail.com>
Message-ID: <CAAOTY_-e4CGXVfUdYBBx6ewEopZrfmuf2d6y77i=-hZ4P13N1g@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] drm/mediatek: separate ccorr module
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Hsin-Yi:

Hsin-Yi Wang <hsinyi@chromium.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8829=E6=
=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=883:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
>
> ccorr ctm matrix bits will be different in mt8192
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/mediatek/Makefile           |   3 +-
>  drivers/gpu/drm/mediatek/mtk_disp_ccorr.c   | 222 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_disp_drv.h     |   9 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c |  95 +--------
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   8 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
>  6 files changed, 242 insertions(+), 96 deletions(-)
>  create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
>

[snip]

> +
> +void mtk_ccorr_config(struct device *dev, unsigned int w,
> +                            unsigned int h, unsigned int vrefresh,
> +                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> +{
> +       struct mtk_disp_ccorr *ccorr =3D dev_get_drvdata(dev);
> +
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, &ccorr->cmdq_reg, ccorr->reg=
s,
> +                     DISP_CCORR_SIZE);

You change w, h position here. Separate this modification to another patch.

> +       mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, &ccorr->cmdq_reg, ccorr-=
>regs,
> +                     DISP_CCORR_CFG);
> +}
> +

[snip]

> -static void mtk_ccorr_config(struct device *dev, unsigned int w,
> -                            unsigned int h, unsigned int vrefresh,
> -                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
> -{
> -       struct mtk_ddp_comp_dev *priv =3D dev_get_drvdata(dev);
> -
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, &priv->cmdq_reg, priv->regs,=
 DISP_CCORR_SIZE);
> -       mtk_ddp_write(cmdq_pkt, CCORR_ENGINE_EN, &priv->cmdq_reg, priv->r=
egs, DISP_CCORR_CFG);
> -}
> -
