Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0252D3233AE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhBWWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbhBWWWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:22:08 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055B1C061793
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:21:21 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id f7so2452100ilk.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 14:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LEcALUw+Ty7WADH2Iskbz7Ee6By7axHCN5qWv+9W+/I=;
        b=E456ChIVK35vWmad5T2YGkGQ7KUKHuDky09HwMWP6Yz77TkwzKsi1qMLbHsqd3N+nm
         atwPSjj9pwAcAz3yoXPCWO2ADl63NiYWVshwYCRwAl60Cn1GCBrJB2dEstLEmKjbkntG
         Xc5ULLDqJpR5depbTcOc7zrpie7XgpFPny8boDXAdSqTSBH2KuATfy/EswPY4A4eMnrJ
         a98hLwgxnV4t4o3S3b0wxV/h+XbzTqSj6LDvl+kzb2pQCH+oS+ELRax67EqdBs9hxtvT
         aJDS6okh61l4d2SCFGB5nVo+YPkO/+JGrXrupbz0y/WuFZGOR9oHW+oyP72Xs7gLjsfu
         nzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LEcALUw+Ty7WADH2Iskbz7Ee6By7axHCN5qWv+9W+/I=;
        b=rEIcAoPPW+vkIMl1eF1M8BD7cwkphyEI+QTfTAwjsBDPqQQoWRRRd3ijtWf0ZJae9z
         736i0W+efiYAor+lAIERD1g7udfMnoBUtzWwhq+/joKJoXPglPzd549988g7L5SsjeGx
         qz4P7zKg0qG7jY/55+88aF6+tFtkBpdz2ONol2Gtc0OJYV1URDtdwmP0zllWN4UxpwO+
         /A8BEsRf/gVpghdfgfy5O/JmuK/yhrUgSbGAMYz0BnXzgRu5YUCaH2utS2SoQb6HvPDi
         ThUoDyqKEWyey+JuamkrejIhFPJ8FNjZap+nG6849a/IW8UEoRNi+J6bDc3Un7twIus8
         tMBQ==
X-Gm-Message-State: AOAM533bP8IiFnkdFBVlBXGbAK2xNxop9XETeuoeg3BEbnu8P1vzJQsz
        p++KLftlsqBrf8XhPMjMGPqRt0nAi8t2BlptqTYWbg==
X-Google-Smtp-Source: ABdhPJyUOVtj2PH6HPYVpWLVirmeiv0o+zvzSum7huMb/iyMDSQ9gsCDt50uMhWJ331RVrYvlXGupc5df9J51GgQhhI=
X-Received: by 2002:a92:8711:: with SMTP id m17mr20891909ild.48.1614118881378;
 Tue, 23 Feb 2021 14:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20201027160631.608503-1-fparent@baylibre.com> <20201030191714.GA4171611@bogus>
 <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com>
In-Reply-To: <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com>
From:   Fabien Parent <fparent@baylibre.com>
Date:   Tue, 23 Feb 2021 23:21:10 +0100
Message-ID: <CAOwMV_wWqCsVTmt-0DDeB-WHdQKiKqT63O6sX2nFM27t34Osug@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, DTML <devicetree@vger.kernel.org>,
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

Hi Matthias,

Pinging you in case you didn't see @Chun-Kuang Hu's question for you.

Thanks,
Best regards,
Fabien

On Sun, Jan 10, 2021 at 12:18 AM Chun-Kuang Hu <chunkuang.hu@kernel.org> wr=
ote:
>
> Hi, Matthias:
>
> Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8831=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:17=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, 27 Oct 2020 17:06:29 +0100, Fabien Parent wrote:
> > > Add binding documentation for MT8167 SoC.
>
> Even though the title need to change to 'mt8167', this patch looks
> good to me. How do you think about this patch? One drm patch [1]
> depend on this patch, if you like this patch, could you applied this
> patch first?
>
> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20201023133=
130.194140-6-fparent@baylibre.com/
>
> Regards,
> Chun-Kuang.
>
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > ---
> > >  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1=
 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > Acked-by: Rob Herring <robh@kernel.org>
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
