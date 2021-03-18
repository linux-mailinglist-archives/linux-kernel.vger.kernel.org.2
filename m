Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBFC33FC59
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 01:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhCRAlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 20:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhCRAlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:41:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F15464F30;
        Thu, 18 Mar 2021 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616028099;
        bh=aW5f462X/+nQqIhoFPP4SR6iv2e/m+Gbr4HadtAx6cM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MEhLDb4ckb148NPNK29xr2etYjyxHvgx6tMH78prIIK+USr16mkUU5MoWiWoyeDd6
         2NRWgmw8GboHr30cgBexd4X7vKUBCQQ9J4nNCHsjapD5zpVUe7uiJvfigrKnGTL4ZG
         BZ78mpiJE4ld7XybI2HbF6qFtJg88b+fL8gE4ZgEEyGsPeRz3jewiGNjQFccF3IF3b
         Ta69l9NKUPJpzdUJ+rJcuoGX2VFCB4P3wCUeTKCjkCKmhL+uOH3WCNWoGuOwHRm0U4
         u1Ela704zLNrNaFAjIsVSO47pR517UVfFC6/f4ZqU35YaJh5Y+fh/qu+kpedhMHTyb
         ze3zpbP4e+/mg==
Received: by mail-ed1-f50.google.com with SMTP id y6so4520142eds.1;
        Wed, 17 Mar 2021 17:41:39 -0700 (PDT)
X-Gm-Message-State: AOAM533l2A/4aBh1HTQ+Ld+Acpo5+PBUGPrY0nijF/NJtIKip5yhMIsR
        ewoFblHnqyUC7FIJ6BRDBbhGg9PXJWmG1wJpcg==
X-Google-Smtp-Source: ABdhPJwMzddDsRL8I33MhffqwoNiBgxeGM1JoCsyv0MHPlhw5w9VDGlLglkIdTIDlBT3lzFYudhs/kFq9pB2MXCDdrk=
X-Received: by 2002:a50:ec07:: with SMTP id g7mr468206edr.72.1616028097740;
 Wed, 17 Mar 2021 17:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201027160631.608503-1-fparent@baylibre.com> <20201030191714.GA4171611@bogus>
 <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com> <CAOwMV_wWqCsVTmt-0DDeB-WHdQKiKqT63O6sX2nFM27t34Osug@mail.gmail.com>
In-Reply-To: <CAOwMV_wWqCsVTmt-0DDeB-WHdQKiKqT63O6sX2nFM27t34Osug@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 18 Mar 2021 08:41:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9b_88qzEov0mMzrrR-61TvS9-7QY=gaCzUY=KaSqPWfw@mail.gmail.com>
Message-ID: <CAAOTY_9b_88qzEov0mMzrrR-61TvS9-7QY=gaCzUY=KaSqPWfw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Ping again.

Regards,
Chun-Kuang.

Fabien Parent <fparent@baylibre.com> =E6=96=BC 2021=E5=B9=B42=E6=9C=8824=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=886:21=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Matthias,
>
> Pinging you in case you didn't see @Chun-Kuang Hu's question for you.
>
> Thanks,
> Best regards,
> Fabien
>
> On Sun, Jan 10, 2021 at 12:18 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> =
wrote:
> >
> > Hi, Matthias:
> >
> > Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8831=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:17=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Tue, 27 Oct 2020 17:06:29 +0100, Fabien Parent wrote:
> > > > Add binding documentation for MT8167 SoC.
> >
> > Even though the title need to change to 'mt8167', this patch looks
> > good to me. How do you think about this patch? One drm patch [1]
> > depend on this patch, if you like this patch, could you applied this
> > patch first?
> >
> > [1] https://patchwork.kernel.org/project/linux-mediatek/patch/202010231=
33130.194140-6-fparent@baylibre.com/
> >
> > Regards,
> > Chun-Kuang.
> >
> > > >
> > > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > > ---
> > > >  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          |=
 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > >
> > > Acked-by: Rob Herring <robh@kernel.org>
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
