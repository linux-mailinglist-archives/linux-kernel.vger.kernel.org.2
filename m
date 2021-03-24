Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DAB347DF0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhCXQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:43:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233671AbhCXQmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:42:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FEA161A15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616604170;
        bh=FpJ4ufMl3GoETEBMXPsfhMl5UzmY31frNljvtIkqZOE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ip//tYNx0qxfnmr4eR3JAA2+Itc24es7mwJQjJL07abkvmQYpDXcO9J8WWxO268/I
         JFbBlzhLB4pjKpi3ajTdodXBCgK5RLYj6OXrTWOad//1IpkDWh8PA/DxmErNyoY6fi
         YSJc3LSD6udZE6sznr4+WullETs4zWCfSXkXwGFSkD4OUDddqbDe9Tu0zPZvKfF+g8
         J0gqhFSdJKUkkjV+UomcUJZTk8aF2So2W8338Pv32ORTAfG7CDwqERgQBkBNR7aapi
         eEZic2+cqlNuQNCc/cdhH59T6vYOv+iIzvLiP3V0CcGnlnZo+VcgAdOZFFs6mYNqF6
         tUS+8klPf5qIg==
Received: by mail-oi1-f177.google.com with SMTP id m13so21441648oiw.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:42:50 -0700 (PDT)
X-Gm-Message-State: AOAM53336HbYhFCezSjpiNK4Dj+9huecPJO/TJSzWE4JxmYzO0IJ6iXi
        k9OCMBUT5OJYiohetJACeNK/XDzk+E0aGvbTj8I=
X-Google-Smtp-Source: ABdhPJzT1TALAguRWsDlD8O6reb7Z/5YQKB/EH/94NPd80Aw6gOETK/aeiwvnSRsg6ZUwyQE7bBChezT8Gvob1FyBik=
X-Received: by 2002:a05:6808:3d9:: with SMTP id o25mr3096654oie.4.1616604169767;
 Wed, 24 Mar 2021 09:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210324121832.3714570-1-arnd@kernel.org> <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
In-Reply-To: <e1310273dcc577f3a772380ada7b6cc1906d680b.camel@perches.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 24 Mar 2021 17:42:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
Message-ID: <CAK8P3a0JyoAtTYTi+M_mJ3_KtUJ6NeJB=FNWhzezqcXMac++mQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] drm/imx: imx-ldb: fix out of bounds array access warning
To:     Joe Perches <joe@perches.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liu Ying <victor.liu@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 3:20 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2021-03-24 at 13:17 +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When CONFIG_OF is disabled, building with 'make W=3D1' produces warning=
s
> > about out of bounds array access:
> >
> > drivers/gpu/drm/imx/imx-ldb.c: In function 'imx_ldb_set_clock.constprop=
':
> > drivers/gpu/drm/imx/imx-ldb.c:186:8: error: array subscript -22 is belo=
w array bounds of 'struct clk *[4]' [-Werror=3Darray-bounds]
> >
> > Add an error check before the index is used, which helps with the
> > warning, as well as any possible other error condition that may be
> > triggered at runtime.
> >
> > The warning could be fixed by adding a Kconfig depedency on CONFIG_OF,
> > but Liu Ying points out that the driver may hit the out-of-bounds
> > problem at runtime anyway.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > v2: fix subject line
> >     expand patch description
> >     print mux number
> >     check upper bound as well
> []
> > diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ld=
b.c
> []
> > @@ -197,6 +197,12 @@ static void imx_ldb_encoder_enable(struct drm_enco=
der *encoder)
> >       int dual =3D ldb->ldb_ctrl & LDB_SPLIT_MODE_EN;
> >       int mux =3D drm_of_encoder_active_port_id(imx_ldb_ch->child, enco=
der);
> >
> > +     if (mux < 0 || mux >=3D ARRAY_SIZE(ldb->clk_sel)) {
> > +             dev_warn(ldb->dev, "%s: invalid mux %d\n",
> > +                      __func__, ERR_PTR(mux));
>
> This does not compile without warnings.
>
> drivers/gpu/drm/imx/imx-ldb.c: In function =E2=80=98imx_ldb_encoder_enabl=
e=E2=80=99:
> drivers/gpu/drm/imx/imx-ldb.c:201:22: warning: format =E2=80=98%d=E2=80=
=99 expects argument of type =E2=80=98int=E2=80=99, but argument 4 has type=
 =E2=80=98void *=E2=80=99 [-Wformat=3D]
>   201 |   dev_warn(ldb->dev, "%s: invalid mux %d\n",
>       |                      ^~~~~~~~~~~~~~~~~~~~~~
>
> If you want to use ERR_PTR, the %d should be %pe as ERR_PTR
> is converting an int a void * to decode the error type and
> emit it as a string.

Sorry about that.

I decided against using ERR_PTR() in order to also check for
positive array overflow, but the version I tested was different from
the version I sent.

v3 coming.

         Arnd
