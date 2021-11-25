Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6B845DE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 16:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356303AbhKYP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 10:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234943AbhKYP47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 10:56:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0323061107;
        Thu, 25 Nov 2021 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637855628;
        bh=WQKBVuM8/HahVHD2Ha+5Ib66vd148D5kd4JIoF5YXYw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NJkIymGInuducGSTAKj/FQ8gLVkz2guOuDv+NT8zNFhcLJ4OYAtEIftb7v5XFBcgX
         JZ1x/jgUqfHXU9vVfmZSYZy+b6Vg/gw9woBsTGPEL9+Vv12wpZ6iUXQIt7lCnN8yln
         0GIaZUtswzpAGLUtFCwwUNzktWCSwsj3XmnCEx1tqK4MOe/+N6++JLBF/TshxWVyZc
         Chsh5hPgEKTETRUaPkgZ17zyJMxFNCoQWkQXk9ODLTxZam0Yr7erF/f/XmtfmW/B2s
         ky4iDsYpMMQyo5zvVp/y9/lzZbQ5joAp6UYTWD9IERHDzmy6/XjtkNkO8RQSZ0RKKq
         7BH3JvLwRkKng==
Received: by mail-ed1-f42.google.com with SMTP id t5so27696777edd.0;
        Thu, 25 Nov 2021 07:53:47 -0800 (PST)
X-Gm-Message-State: AOAM531AkcTxxShINyYq2yRWmvtFRSpy3PoyJKYGFyDNfxpbLdFLQLQu
        m3IzgXR/j75j4L8LfnYXqw9Je201N4IRbOLgcw==
X-Google-Smtp-Source: ABdhPJyWuSCxWweua9Qb5oiDhlo9g8K+nlZBzMrHfDLk16MCEQQl+zFjUJxBfRZ+oWeUyMxTWfL4Uc81RcQThqCEADs=
X-Received: by 2002:a17:906:79c8:: with SMTP id m8mr30595476ejo.511.1637855626321;
 Thu, 25 Nov 2021 07:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20211026155911.17651-1-jason-jh.lin@mediatek.com> <20211026155911.17651-12-jason-jh.lin@mediatek.com>
In-Reply-To: <20211026155911.17651-12-jason-jh.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 25 Nov 2021 23:53:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY__8Bh_Me8sDYgAM4ZQiDxkz55BZyrwNuVRqxyfK79rYkg@mail.gmail.com>
Message-ID: <CAAOTY__8Bh_Me8sDYgAM4ZQiDxkz55BZyrwNuVRqxyfK79rYkg@mail.gmail.com>
Subject: Re: [PATCH v12 11/16] drm/mediatek: remove unused define in mtk_drm_ddp_comp.c
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fei Shao <fshao@chromium.org>,
        Moudy Ho <moudy.ho@mediatek.com>, roy-cw.yeh@mediatek.com,
        Fabien Parent <fparent@baylibre.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>, singo.chang@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason:

When I apply this patch to mediatek-drm-next, I get this error:

Applying: drm/mediatek: remove unused define in mtk_drm_ddp_comp.c
error: patch failed: drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c:53

Please rebase this patch onto mediatek-drm-next.

Regards,
Chun-Kuang.

jason-jh.lin <jason-jh.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B410=E6=9C=88=
26=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8811:59=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Remove the unsed define in mtk_drm_ddp_comp.c
>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index f3db96a1b24d..839ffae3019c 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -21,8 +21,6 @@
>  #include "mtk_drm_crtc.h"
>
>  #define DISP_OD_EN                             0x0000
> -#define DISP_OD_INTEN                          0x0008
> -#define DISP_OD_INTSTA                         0x000c
>  #define DISP_OD_CFG                            0x0020
>  #define DISP_OD_SIZE                           0x0030
>  #define DISP_DITHER_5                          0x0114
> @@ -39,8 +37,6 @@
>  #define DITHER_ENGINE_EN                       BIT(1)
>  #define DISP_DITHER_SIZE                       0x0030
>
> -#define LUT_10BIT_MASK                         0x03ff
> -
>  #define OD_RELAYMODE                           BIT(0)
>
>  #define UFO_BYPASS                             BIT(2)
> @@ -53,18 +49,12 @@
>
>  #define DISP_DITHERING                         BIT(2)
>  #define DITHER_LSB_ERR_SHIFT_R(x)              (((x) & 0x7) << 28)
> -#define DITHER_OVFLW_BIT_R(x)                  (((x) & 0x7) << 24)
>  #define DITHER_ADD_LSHIFT_R(x)                 (((x) & 0x7) << 20)
> -#define DITHER_ADD_RSHIFT_R(x)                 (((x) & 0x7) << 16)
>  #define DITHER_NEW_BIT_MODE                    BIT(0)
>  #define DITHER_LSB_ERR_SHIFT_B(x)              (((x) & 0x7) << 28)
> -#define DITHER_OVFLW_BIT_B(x)                  (((x) & 0x7) << 24)
>  #define DITHER_ADD_LSHIFT_B(x)                 (((x) & 0x7) << 20)
> -#define DITHER_ADD_RSHIFT_B(x)                 (((x) & 0x7) << 16)
>  #define DITHER_LSB_ERR_SHIFT_G(x)              (((x) & 0x7) << 12)
> -#define DITHER_OVFLW_BIT_G(x)                  (((x) & 0x7) << 8)
>  #define DITHER_ADD_LSHIFT_G(x)                 (((x) & 0x7) << 4)
> -#define DITHER_ADD_RSHIFT_G(x)                 (((x) & 0x7) << 0)
>
>  struct mtk_ddp_comp_dev {
>         struct clk *clk;
> --
> 2.18.0
>
