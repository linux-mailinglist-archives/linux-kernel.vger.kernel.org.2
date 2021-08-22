Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693F83F3CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 03:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhHVBPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 21:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhHVBPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 21:15:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017F76128A;
        Sun, 22 Aug 2021 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629594877;
        bh=zCzuD/gSEAZz6whQU8OxleDxwzLhRBG1uIqnRGpvqP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o7jAL41cV1Q05ea7fZSRvzv0vZ5APxyLyXwqZQX5/Qab2O1tdaSDk66vm/LNZy8fo
         U0wrcOc69+Sfa1T/XIcGMMf8oR5/fPHm+Vk+TDsqcrYosh8V+5qdko8InUVg+19TwD
         zWTmsHpkn+PPv4mbUgW6RZ5P7yUSNikeFdOcZ6DKmhm3k0+s6Janm0YtbJ6PlFG3uR
         UQM+8zDahpFfnfm0AljOy2ZR4ana+oP+ZWw8HPdRCjHNHZQqFGLXKZfnSYqjRE7osf
         tzfLxf/C2/NFw/n/U1dSm6059t7bAu6T1APRfPPyg/S4WI0C35xLNLuyxptlp34MHe
         lbQJxoXBsePkQ==
Received: by mail-ej1-f43.google.com with SMTP id ia27so6244577ejc.10;
        Sat, 21 Aug 2021 18:14:36 -0700 (PDT)
X-Gm-Message-State: AOAM532DSMnfyJmLpdw40m9wqy0mmB+tbWHHlonspaFRNbFzgo1O4i02
        z1XQDbkozJwx/aJD32R1RH0Gqm1OpZBoEATK/Q==
X-Google-Smtp-Source: ABdhPJwurie+/j4gMgYRtvN6TgPa5fnIdmGdu2j/ak4r2YT1v1vuwSfGu0NBvpD/c6uzXnaqD7U33HlKS+77I74lBsU=
X-Received: by 2002:a17:906:b18e:: with SMTP id w14mr28931433ejy.63.1629594875631;
 Sat, 21 Aug 2021 18:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210818091847.8060-1-nancy.lin@mediatek.com> <20210818091847.8060-16-nancy.lin@mediatek.com>
In-Reply-To: <20210818091847.8060-16-nancy.lin@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 22 Aug 2021 09:14:24 +0800
X-Gmail-Original-Message-ID: <CAAOTY_99QLpRHLei2PzD8vsuoOaZae++NqczPCM+r9YMZ01btw@mail.gmail.com>
Message-ID: <CAAOTY_99QLpRHLei2PzD8vsuoOaZae++NqczPCM+r9YMZ01btw@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] drm/mediatek: add mediatek-drm of vdosys1
 support for MT8195
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

Nancy.Lin <nancy.lin@mediatek.com> =E6=96=BC 2021=E5=B9=B48=E6=9C=8818=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=885:18=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add driver data of mt8195 vdosys1 to mediatek-drm and modify drm for
> multi-mmsys support. The two mmsys (vdosys0 and vdosys1) will bring
> up two drm drivers, only one drm driver register as the drm device.
> Each drm driver binds its own component. The first bind drm driver
> will allocate the drm device, and the last bind drm driver registers
> the drm device to drm core. Each crtc path is created with the
> corresponding drm driver data.
>
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
>
>
> +static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor =3D {
> +       .clk_enable =3D mtk_ethdr_clk_enable,
> +       .clk_disable =3D mtk_ethdr_clk_disable,
> +       .config =3D mtk_ethdr_config,
> +       .start =3D mtk_ethdr_start,
> +       .stop =3D mtk_ethdr_stop,
> +       .layer_nr =3D mtk_ethdr_layer_nr,
> +       .layer_config =3D mtk_ethdr_layer_config,
> +       .enable_vblank =3D mtk_ethdr_enable_vblank,
> +       .disable_vblank =3D mtk_ethdr_disable_vblank,
> +};

I think ethdr is inside the group of ovl_adpator. I preter this
function is implemented by ovl_adaptor, and ovl_adaptor control rdma,
merge, ethdr.

Regards,
Chun-Kuang.

> +
>
