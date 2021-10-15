Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFD742FEF9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 01:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhJOXoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235944AbhJOXoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:44:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA12960F39;
        Fri, 15 Oct 2021 23:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634341324;
        bh=s/EKmy4kdrec5wksozYJUijeVa7Z4VkDJ4Jz3S63i6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HWOTazNEmWXmflTU4ywm4CJw1r7kVV8XwRuOJUSLHV3/5S7I8jMMvszvF2fC5WQXP
         z/YkyJWuLWvOsTubnysoIbdN57ujTVO1zHTqsZk8VdtA8X1kdyCiJI3gGc5JW6VXvt
         6f0OBhDeghrUvlIfp+UEJcBOwa77RtvmwNO6HHiyYOYAUrowh9OP54zS7yZRxULQDl
         OELv3W3zuIiXeWLUGJrl1UktkFRlQZLTkO+v0ouffDDX/X7X8CSnENIYaq0h/c64Yb
         ckT6TWzW3OOvL83u6wVvrX6CKWbKx7ncUbWsa3EoX0XriCow02rV4zqV/s8JtWicJT
         nuYFlVOyGJwCg==
Received: by mail-ed1-f43.google.com with SMTP id ec8so44131423edb.6;
        Fri, 15 Oct 2021 16:42:04 -0700 (PDT)
X-Gm-Message-State: AOAM531WiunNnIiPrDhCZQAc6zPOUgoYTBpMpFsxEzChUcW5fAiFwxhJ
        x9K5e3zt10Ehiq+aFOlM36sh1F4Ui6cmYeC/dQ==
X-Google-Smtp-Source: ABdhPJyifvWmqLk+jf2zlKQO8auioR0IRMCDcZBa/PLm7kRW/yXYG9c21iyijoGl/XAXZ85nuyr2xQmP2KuizDr574k=
X-Received: by 2002:a50:9993:: with SMTP id m19mr21431023edb.357.1634341323225;
 Fri, 15 Oct 2021 16:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211004062140.29803-1-nancy.lin@mediatek.com> <20211004062140.29803-5-nancy.lin@mediatek.com>
In-Reply-To: <20211004062140.29803-5-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 16 Oct 2021 07:41:52 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-9JdZfzF49E81Z046w=t0wDW7DScsVQQ2-L72mLXbjdg@mail.gmail.com>
Message-ID: <CAAOTY_-9JdZfzF49E81Z046w=t0wDW7DScsVQQ2-L72mLXbjdg@mail.gmail.com>
Subject: Re: [PATCH v6 04/16] dt-bindings: reset: mt8195: add vdosys1 reset
 control bit
To:     "Nancy.Lin" <nancy.lin@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        singo.chang@mediatek.com,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nancy:

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=882:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add vdosys1 reset control bit for MT8195 platform.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8195-resets.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindi=
ngs/reset/mt8195-resets.h
> index a26bccc8b957..aab8d74496a6 100644
> --- a/include/dt-bindings/reset/mt8195-resets.h
> +++ b/include/dt-bindings/reset/mt8195-resets.h
> @@ -26,4 +26,16 @@
>
>  #define MT8195_TOPRGU_SW_RST_NUM               16
>
> +/* VDOSYS1 */
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE0_DL_ASYNC          25
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE1_DL_ASYNC          26
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE2_DL_ASYNC          27
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE3_DL_ASYNC          28
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE4_DL_ASYNC          29
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE0_DL_ASYNC     51
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE1_DL_ASYNC     52
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE0_DL_ASYNC     53
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE1_DL_ASYNC     54
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_BE_DL_ASYNC      55
> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8195 */
> --
> 2.18.0
>
