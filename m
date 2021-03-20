Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD808342C8C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhCTLyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230064AbhCTLxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:53:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDDA96199E;
        Sat, 20 Mar 2021 07:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616223988;
        bh=JN7rk5whuNrffpk2EuJ5Ntk74ce7HEE/syfRYOG7JDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E+qM1cBo5TU+qCNTg+ue8y5JgFmbtOntPYieo8lo2Ox7YpdbLMwI43vZkEBqQPE+P
         gtBVyQtst6vhhfOIpErbTEwsTbHcLd2WuAhIg0hY5JTtxGIX53LJqConaJCtoGXIJk
         IdtTC5BoBnCqeLhTViXHAjrMdHLgVuQXWk2v9oiEobpxb8bvHj/oEONGu2OO901CPi
         kq7SObpxw/t4WeOnEnHZBQM0iYoh1q2slsBZ+vy3B/SngSgbkFsgH7XXdi/FtHeY4e
         YTVB/3eQpSS/B6o/kBE+QDYa/EtMHljstiN9yYnyhTAsF3AixPi22TFW8y3vQp8fzT
         iWqChXcWP+GNw==
Received: by mail-wr1-f42.google.com with SMTP id e9so11293292wrw.10;
        Sat, 20 Mar 2021 00:06:27 -0700 (PDT)
X-Gm-Message-State: AOAM533ULKCzhu4mM2takFmrx4rvTdQNcgQVeFhGPxdsJwt49mBIwhC8
        i0QMU3CKoMUVg9vMHj+ufU+v+Wa0on/FttldCw==
X-Google-Smtp-Source: ABdhPJzXUrqVy5h4sptnKXZVkSNgwo3z2RQgkTfp9fR4QtfZMZ8R2akBBZGTFtFYE3KwRyAbN9hhk2+W2QTOaLxW65Q=
X-Received: by 2002:a5d:664e:: with SMTP id f14mr1233975wrw.382.1616223986312;
 Sat, 20 Mar 2021 00:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <1616046056-29068-1-git-send-email-rex-bc.chen@mediatek.com>
 <1616046056-29068-2-git-send-email-rex-bc.chen@mediatek.com> <CAFqH_51qkjtRRS8yjiRXQhN7Hvn-rG34ieKxKnKmreJrOJVUow@mail.gmail.com>
In-Reply-To: <CAFqH_51qkjtRRS8yjiRXQhN7Hvn-rG34ieKxKnKmreJrOJVUow@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 20 Mar 2021 15:06:12 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9aXzjgvrafdrGDESNBtpjGGJoefBTSpX_0irP4sXyTLg@mail.gmail.com>
Message-ID: <CAAOTY_9aXzjgvrafdrGDESNBtpjGGJoefBTSpX_0irP4sXyTLg@mail.gmail.com>
Subject: Re: [v5, 1/2] drm/mediatek: mtk_dpi: Add check for max clock rate in mode_valid
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric:

Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2021=E5=B9=B43=E6=9C=
=8818=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8810:25=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Rex-BC Chen,
>
> Thank you for your patch.
>
> Missatge de Rex-BC Chen <rex-bc.chen@mediatek.com> del dia dj., 18 de
> mar=C3=A7 2021 a les 6:42:
> >
> > Add per-platform max clock rate check in mtk_dpi_bridge_mode_valid.
> >
> > Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dpi.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/media=
tek/mtk_dpi.c
> > index b05f900d9322..0b427ad0cd9b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > @@ -120,6 +120,7 @@ struct mtk_dpi_yc_limit {
> >  struct mtk_dpi_conf {
> >         unsigned int (*cal_factor)(int clock);
> >         u32 reg_h_fre_con;
> > +       u32 max_clock_khz;
> >         bool edge_sel_en;
> >  };
> >
> > @@ -557,9 +558,23 @@ static void mtk_dpi_bridge_enable(struct drm_bridg=
e *bridge)
> >         mtk_dpi_set_display_mode(dpi, &dpi->mode);
> >  }
> >
> > +static enum drm_mode_status
> > +mtk_dpi_bridge_mode_valid(struct drm_bridge *bridge,
> > +                         const struct drm_display_info *info,
> > +                         const struct drm_display_mode *mode)
> > +{
> > +       struct mtk_dpi *dpi =3D bridge_to_dpi(bridge);
> > +
> > +       if (dpi->conf->max_clock_khz && mode->clock > dpi->conf->max_cl=
ock_khz)
>
> Maybe I read this patch too fast, but why the &&? Shouldn't be more
> simple and readable
>
>           if (mode->clock > max_clock)
>

Agree. So I modify in mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Thanks,
>   Enric
>
>
> > +               return MODE_CLOCK_HIGH;
> > +
> > +       return MODE_OK;
> > +}
> > +
> >  static const struct drm_bridge_funcs mtk_dpi_bridge_funcs =3D {
> >         .attach =3D mtk_dpi_bridge_attach,
> >         .mode_set =3D mtk_dpi_bridge_mode_set,
> > +       .mode_valid =3D mtk_dpi_bridge_mode_valid,
> >         .disable =3D mtk_dpi_bridge_disable,
> >         .enable =3D mtk_dpi_bridge_enable,
> >  };
> > @@ -668,17 +683,20 @@ static unsigned int mt8183_calculate_factor(int c=
lock)
> >  static const struct mtk_dpi_conf mt8173_conf =3D {
> >         .cal_factor =3D mt8173_calculate_factor,
> >         .reg_h_fre_con =3D 0xe0,
> > +       .max_clock_khz =3D 300000,
> >  };
> >
> >  static const struct mtk_dpi_conf mt2701_conf =3D {
> >         .cal_factor =3D mt2701_calculate_factor,
> >         .reg_h_fre_con =3D 0xb0,
> >         .edge_sel_en =3D true,
> > +       .max_clock_khz =3D 150000,
> >  };
> >
> >  static const struct mtk_dpi_conf mt8183_conf =3D {
> >         .cal_factor =3D mt8183_calculate_factor,
> >         .reg_h_fre_con =3D 0xe0,
> > +       .max_clock_khz =3D 100000,
> >  };
> >
> >  static int mtk_dpi_probe(struct platform_device *pdev)
> > --
> > 2.18.0
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
