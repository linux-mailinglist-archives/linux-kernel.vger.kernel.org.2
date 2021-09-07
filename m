Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD38402C93
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 18:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243976AbhIGQIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 12:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238483AbhIGQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 12:08:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A082561130;
        Tue,  7 Sep 2021 16:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631030830;
        bh=+lJkGZeGmmojxoICOoYZ2t3AkosVDnXKocMMyh1szbs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QNp9p1TUa3ei4z9ns0GgLtkR1OizOQ1pIKoqKY9MUoxNy8GDuZPe4KneNrFTgnfgT
         E5kOgdQcr4hRziJAzNysLzkRrlDhNh15STVAo5CHzaCvancScfsROamjR1oK+tA2Bc
         VttM+LqvNou2xrah3U5hbymBHgQCcn7wSOV1TrHBYiYB93nN0ihhLs0bzLBRyq7HkS
         wQbGox70OLqF1/49ssoeu1lXRI9v6lv58EBotXOr3odPC4xUwuM9eCPaWPxZJEGSJw
         PF2ikN6g2TRR30hkCYKlox6Qhfh1OGRVI/AyA47mAOeTg1hZgJNoiphaF5Cm41JVmh
         XYLmMUswh8UOg==
Received: by mail-ej1-f51.google.com with SMTP id h9so20719281ejs.4;
        Tue, 07 Sep 2021 09:07:10 -0700 (PDT)
X-Gm-Message-State: AOAM533VPeo9Ezno4RL9reWqBnHumhKbEaJx/o+mGibZpGze6yLVwNsU
        uzuya6GdNYTa2PLkNXQUCsgWSasOOahwFC3uHg==
X-Google-Smtp-Source: ABdhPJyY5G5Fp3aIZKKQwfIH3FO1wAURJJPIvo91MbXQo53v/T6+cQCTl2RcTXSYs4lmdwE+fxWw+K47Vu/yjAvvJpc=
X-Received: by 2002:a17:906:26c4:: with SMTP id u4mr18904991ejc.511.1631030829293;
 Tue, 07 Sep 2021 09:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210906071539.12953-1-nancy.lin@mediatek.com> <20210906071539.12953-5-nancy.lin@mediatek.com>
In-Reply-To: <20210906071539.12953-5-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 8 Sep 2021 00:06:58 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9pvtP-Ri4UHjRGDvA3j0F7J+HsRqOiNzPbEeE=NmAsqA@mail.gmail.com>
Message-ID: <CAAOTY_9pvtP-Ri4UHjRGDvA3j0F7J+HsRqOiNzPbEeE=NmAsqA@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] dt-bindings: reset: mt8195: add vdosys1 reset
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

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B49=E6=9C=886=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add vdosys1 reset control bit for MT8195 platform.
>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> ---
>  include/dt-bindings/reset/mt8195-resets.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/dt-bindings/reset/mt8195-resets.h b/include/dt-bindi=
ngs/reset/mt8195-resets.h
> index a26bccc8b957..eaaa882c09bd 100644
> --- a/include/dt-bindings/reset/mt8195-resets.h
> +++ b/include/dt-bindings/reset/mt8195-resets.h
> @@ -26,4 +26,16 @@
>
>  #define MT8195_TOPRGU_SW_RST_NUM               16
>
> +/* VDOSYS1 */
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE0_DL_ASYNC 25
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE1_DL_ASYNC 26
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE2_DL_ASYNC 27
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE3_DL_ASYNC 28
> +#define MT8195_VDOSYS1_SW0_RST_B_MERGE4_DL_ASYNC 29
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE0_DL_ASYNC 51
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_FE1_DL_ASYNC 52
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE0_DL_ASYNC 53
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_GFX_FE1_DL_ASYNC 54
> +#define MT8195_VDOSYS1_SW1_RST_B_HDR_VDO_BE_DL_ASYNC 55

Maybe you should align the indent style with TOPRGU.

Regards,
Chun-Kuang.

> +
>  #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8195 */
> --
> 2.18.0
>
