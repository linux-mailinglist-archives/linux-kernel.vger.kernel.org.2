Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8213C5E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 16:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhGLOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 10:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhGLOuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 10:50:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08E4C611C1;
        Mon, 12 Jul 2021 14:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626101251;
        bh=GNc7iEYnBjS+TNAD0DgnhNoeKiMhXXlDvGKvY8DoZQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hfzOTcL4oK1IocXnx1Wq7lqzjwGJwnbHvjCA3/7lrwqKbAJ/ScbvxhKybAAaQ/Gi6
         4KqLLt9Q9s+DD5gcsJObTWDN23anRPJYI22GiDJjj+tfSK9ePDv7wk0OKb/aPBo79a
         0oCLEMOU/AJiY4MFIlbWzHNzzGdhnBCEILwbyY4LGVptCpVjAgDjisuNqzHSGp5l2q
         1MgzktbTqbyMNF44av/NHwXX6DKmKeelHjbsMCXq+alV734bnq0HCcNDC7YLg1dnZG
         Eq3lebipgdKtxN7aZ8uZdA4zWYjbtyIpuqEUwnM9Ji1sUAD3Q6MqaUsKcEstj2QYuo
         l2A8RNOg9eb1Q==
Received: by mail-ej1-f42.google.com with SMTP id he13so35051653ejc.11;
        Mon, 12 Jul 2021 07:47:30 -0700 (PDT)
X-Gm-Message-State: AOAM531Y1N8OTRuM+yuB04Up492+txVCgDJ0yge6gpUnpzFwKeeqfAx6
        lUbQabkGsL2es5fIrjJiBEvqSdxqsj9IFybzRA==
X-Google-Smtp-Source: ABdhPJz9wP8zZM8xJ1hflPWLyv4neAHs8saPkzoZPDHElB1yvcecZ7bIL4bSeSE95OMDgqTedtJuc4UOl39QeqziLFw=
X-Received: by 2002:a17:907:62a1:: with SMTP id nd33mr53383549ejc.303.1626101249542;
 Mon, 12 Jul 2021 07:47:29 -0700 (PDT)
MIME-Version: 1.0
References: <1625986431-27399-1-git-send-email-yongqiang.niu@mediatek.com> <1625986431-27399-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1625986431-27399-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 12 Jul 2021 22:47:18 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-15k_Fq4svKfaKukuYxc4DRfqP1kRudR9wgSrkc-+ZoQ@mail.gmail.com>
Message-ID: <CAAOTY_-15k_Fq4svKfaKukuYxc4DRfqP1kRudR9wgSrkc-+ZoQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/mediatek: adjust rdma fifo threshold calculate formula
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
=8811=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=882:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> the orginal formula will caused rdma fifo threshold config overflow
> and no one could come out a solution for all SoC,
> set threshold to 70% of max fifo size to make sure it will
> not overflow, and 70% is a empirical value

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/m=
ediatek/mtk_disp_rdma.c
> index f123fc0..f1f6a2e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> @@ -164,10 +164,10 @@ void mtk_rdma_config(struct device *dev, unsigned i=
nt width,
>         /*
>          * Enable FIFO underflow since DSI and DPI can't be blocked.
>          * Keep the FIFO pseudo size reset default of 8 KiB. Set the
> -        * output threshold to 6 microseconds with 7/6 overhead to
> -        * account for blanking, and with a pixel depth of 4 bytes:
> +        * output threshold to 70% of max fifo size to make sure the
> +        * threhold will not overflow
>          */
> -       threshold =3D width * height * vrefresh * 4 * 7 / 1000000;
> +       threshold =3D rdma_fifo_size * 7 / 10;
>         reg =3D RDMA_FIFO_UNDERFLOW_EN |
>               RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
>               RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
> --
> 1.8.1.1.dirty
>
