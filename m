Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DB1390E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhEZCqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230312AbhEZCqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:46:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B52261434;
        Wed, 26 May 2021 02:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621997093;
        bh=rsTIIgQ3nqy4Xh20GrbgV6iG0hbzpPJ4x64TSBbYFzk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aUw7bzkvwfXwXcnX0Slx6qwQ0gJAzurxTvY/6anEvxSCUgDNwo6TiL5z/qDcIiN/n
         W8Qfhw6DQK146YWDr5wnl2Z0wcLGa/Rdr8IHiommUUeoVz55BGbNZVr6RVUS27kgJb
         Xkci9t+L6u7TfXgsUbCuUD7ynjf9280qRvmGxinoaubF1Cl8z+i4PSCuowzzMqpcnm
         +/Axvp/3LlZw3A0o5qG0J05BLrtmzO7RzHO+auUKaWCP954siMkCBxjOuMGqbSDq6y
         Rc4w5RZTU1G9mxAKgETSyqh376Mrgl3pmBwexauhUGsyej6ToClSMvZC/m7vYFOZGT
         nISKkkisEHaXg==
Received: by mail-ed1-f51.google.com with SMTP id i13so38657501edb.9;
        Tue, 25 May 2021 19:44:53 -0700 (PDT)
X-Gm-Message-State: AOAM5310zGZJhLdKrTo6O7ZkINftFbeqoBOLg2erm2NG1ENCFYnOl1mm
        wh5y+jD9mhXsmUcsdQojwrRdOR97nbi2eKgOpw==
X-Google-Smtp-Source: ABdhPJxwO04yl5WZa0+jOnbeZ7drXGaZrOwZtr9HVj+l8GtBtUXQE1ouzcgJ7WJCend58die4B49R8xq/+6Bkf17N/E=
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr36336665edw.162.1621997091699;
 Tue, 25 May 2021 19:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210525121448.30075-1-rex-bc.chen@mediatek.com>
 <20210525121448.30075-2-rex-bc.chen@mediatek.com> <CAAOTY__aasihVxC72f7b_R-=UcR85Z1G9M8TxUS9dBrad-aRxQ@mail.gmail.com>
 <c90629c915bc1c0d2e6b1070939a443ce5f8644c.camel@mediatek.com>
In-Reply-To: <c90629c915bc1c0d2e6b1070939a443ce5f8644c.camel@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Wed, 26 May 2021 10:44:41 +0800
X-Gmail-Original-Message-ID: <CAAOTY__3FWA37h5AoK_VR9LhyfHf3dGx2m-2P==2PNOpsxwyJQ@mail.gmail.com>
Message-ID: <CAAOTY__3FWA37h5AoK_VR9LhyfHf3dGx2m-2P==2PNOpsxwyJQ@mail.gmail.com>
Subject: Re: [v4,PATCH 1/3] drm/mediatek: dpi dual edge sample mode support
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jitao Shi <jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=8826=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:51=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> Hello CK,
>
> Thanks for your review.
>
> On Wed, 2021-05-26 at 08:01 +0800, Chun-Kuang Hu wrote:
> > Hi, Rex:
> >
> > Rex-BC Chen <rex-bc.chen@mediatek.com> =E6=96=BC 2021=E5=B9=B45=E6=9C=
=8825=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:15=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > >
> > > DPI can sample on falling, rising or both edge.
> > > When DPI sample the data both rising and falling edge.
> > > It can reduce half data io pins.
> > > Use num_output_fmts to determine whether it is dual edge mode.
> > >
> > > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_dpi.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > index bea91c81626e..d3b883c97aaf 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> > > @@ -83,6 +83,7 @@ struct mtk_dpi {
> > >         struct pinctrl *pinctrl;
> > >         struct pinctrl_state *pins_gpio;
> > >         struct pinctrl_state *pins_dpi;
> > > +       bool ddr_edge_sel;
> >
> > I would like to keep output_fmt instead of ddr_edge_sel.
> > Initialize output_fmt to MEDIA_BUS_FMT_RGB888_1X24 in this patch.
> >
> It means that I may initialize output_fmt in probe and set value in
> mtk_dpi_bridge_atomic_check() of patch[3/3]?

Yes.

> > >         int refcount;
> > >  };
> > >
