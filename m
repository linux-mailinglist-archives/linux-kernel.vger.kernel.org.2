Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4433AE4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhFUIdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhFUIdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:33:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3567B611B0;
        Mon, 21 Jun 2021 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624264258;
        bh=Pcp9QiM+wz7CqD5bvb3BMwJt+gIRXZRnTztLDJ83g+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QHSxNvauWjwV7G/MVQCUFDF4AEQQxLF+0R7Xab0uLxKtcbFyoJFSahAm7ZnQELhpj
         UoHMAo+cJSsWyj2PAj88Ev1g1nJZB/gRPwwekwBvYOn+MGzEOj238IZ6TiU6LQT/ot
         PNGM/Rwx9wwORH9PYFs1AiM+LeHqwEFQyDoVvueUkyxkhwIseMGsOJAGu+MhGdZwbt
         /vfQc6GNgi/YFLDESSULQLas3Dl0Ex1W2R/SdmNHmANFMmz7VSPItrqakLvecHzB1Z
         2Q9zFCRPBB4QU2RrA4aSXaReL3fRIqhirpge5uwJdStnaHNyiVUTJOWva99iwB/Xu+
         XcvRQcu6kUP6g==
Received: by mail-ej1-f51.google.com with SMTP id ho18so27378744ejc.8;
        Mon, 21 Jun 2021 01:30:58 -0700 (PDT)
X-Gm-Message-State: AOAM530M5csFxItKB7p+d/FUm9PUIukQ70xg+g59fi3t4h7bL8dFBN+5
        im69b/sXXoKwMkn8YF6jPlSL7Ddu9HVpl/Qmtg==
X-Google-Smtp-Source: ABdhPJxibsmUgw7bInJG+XOFJhr1Nt7qCfnwC1CYZF9N3JnhGELXNshHIqQDQ+WlAFaPaLzrPKSpgopFFw64Q3Y4LO0=
X-Received: by 2002:a17:906:dbcd:: with SMTP id yc13mr23909438ejb.267.1624264256796;
 Mon, 21 Jun 2021 01:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <1624187698-29040-1-git-send-email-yongqiang.niu@mediatek.com> <1624187698-29040-2-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1624187698-29040-2-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 21 Jun 2021 16:30:43 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-UJ0N7pzASDMS3ca4xf9HFpi9ZN_hTx2ND2WZk3ddz+A@mail.gmail.com>
Message-ID: <CAAOTY_-UJ0N7pzASDMS3ca4xf9HFpi9ZN_hTx2ND2WZk3ddz+A@mail.gmail.com>
Subject: Re: [PATCH v6, 1/2] soc: mediatek: mmsys: add comp OVL_2L2/POSTMASK/RDMA4
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
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=
=8820=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=887:15=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add some more ddp component
> OVL_2L2 is ovl which include 2 layers overlay
> POSTMASK control round corner for display frame
> RDMA4 read dma buffer
>
> Change-Id: I464ea2dce6a312de8fad2cdbd94a4c71ab45af8f

Remove this.

Regards,
Chun-Kuang.

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 2228bf6..4bba275 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -29,13 +29,16 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
>         DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_OVL_2L2,
>         DDP_COMPONENT_OVL1,
> +       DDP_COMPONENT_POSTMASK0,
>         DDP_COMPONENT_PWM0,
>         DDP_COMPONENT_PWM1,
>         DDP_COMPONENT_PWM2,
>         DDP_COMPONENT_RDMA0,
>         DDP_COMPONENT_RDMA1,
>         DDP_COMPONENT_RDMA2,
> +       DDP_COMPONENT_RDMA4,
>         DDP_COMPONENT_UFOE,
>         DDP_COMPONENT_WDMA0,
>         DDP_COMPONENT_WDMA1,
> --
> 1.8.1.1.dirty
>
