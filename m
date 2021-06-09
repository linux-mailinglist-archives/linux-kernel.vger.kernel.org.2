Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024223A1164
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238026AbhFIKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbhFIKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:48:53 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE7BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:46:59 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id b9so25002618ilr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+5GzVyM+TFuTZLW/qFX3WiZRW9D495A3O6aGgKjLxs=;
        b=icqvxZiYbmJBLHoQNod0FxFLxphOWacXqY4xuBdb5fqVvTYbUo37QfNhVZL+BVBc7v
         vv3ricSDDsmBFXoggCz0oXH5e33zFyx6ZkePhITrR1kcFEGVWqJ1B7d+62BnZo77+GEy
         n0fpiYQsT5Qk0tsjZc/uP4tlxLa24JdPBxt7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+5GzVyM+TFuTZLW/qFX3WiZRW9D495A3O6aGgKjLxs=;
        b=CYD9GsOIXwc3xo0AlX7Nt0njNpA7N/QTF6B43W8gdeol5IvuySmunpPZphpHm2DwRG
         yJMQCOSgybUL0UjolLjAYSmVvTYjpVlgU4/+gezyBrvJ6uA54oNScGHrhHbYCUcf8a+C
         8l6/vRs6Sn18/xjkoctf7qW5FbjF0Fxs2JAdf/OgOgpH+F+u9YMGpCHcuzNtaZ+nkC7r
         9ZxoDNRh+GZnH5M851nZKWhLHEXT2fVs+ZAiKxvuWaCymVQ9FRBoNZcO1Ge5gC0/9EEK
         Xfp5FJ0iSMCReS1thhSdzma5KuBILHDtY4lJ8O1KMCoOsNepimAuIBGALOZP7iLzJDQP
         py5g==
X-Gm-Message-State: AOAM533+LAioubRh3rVxicZ6+Pnp6D/Cr35k7LQESdAe1E8T7gyrSEuB
        LhLtConTTxfactfn6sO4r/1C7z5UWOA6rzQPGc9g3g==
X-Google-Smtp-Source: ABdhPJwgBjwFhsmtC1XmbGiOcK7Z4pF0o5B7kd44vj0dZ9UzBo2ihwDg/0svNbMUYUf6PM+t2LazOCf1UIXVUByntUc=
X-Received: by 2002:a05:6638:11:: with SMTP id z17mr24468108jao.102.1623235618594;
 Wed, 09 Jun 2021 03:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210609044854.393452-1-hsinyi@chromium.org> <7a96166f-70d9-bc0e-72cc-53a8612741e8@gmail.com>
In-Reply-To: <7a96166f-70d9-bc0e-72cc-53a8612741e8@gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 9 Jun 2021 18:46:32 +0800
Message-ID: <CAJMQK-gtQpHTJvjy240fN31G7=sz73w2jJQk6_zqdeAiYpXJsw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8183: add jpeg enc node for mt8183
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, maoguang.meng@mediatek.com,
        Yong Wu <yong.wu@mediatek.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 9, 2021 at 3:46 PM Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>
>
> On 09/06/2021 06:48, Hsin-Yi Wang wrote:
> > From: Maoguang Meng <maoguang.meng@mediatek.com>
> >
> > Add jpeg encoder device tree node.
> >
> > Signed-off-by: Maoguang Meng <maoguang.meng@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > v2: rebase to latest
> > v1: https://patchwork.kernel.org/project/linux-media/patch/20200914094012.5817-1-maoguang.meng@mediatek.com/
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index c5e822b6b77a3..fffe0c52909ce 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -1329,6 +1329,17 @@ larb4: larb@17010000 {
> >                       power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
> >               };
> >
> > +             venc_jpg: venc_jpg@17030000 {
> > +                     compatible = "mediatek,mt8183-jpgenc", "mediatek,mtk-jpgenc";
>
> We are missing "mediatek,mt8183-jpgenc" in mediatek-jpeg-encoder.txt. Would be
> great if you could help to convert it to yaml before adding the new compatible.
>
mediatek-jpeg-en(de)coder.txt converted to yaml:
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20210609104053.617751-1-hsinyi@chromium.org/


> Thanks!
> Matthias
> > +                     reg = <0 0x17030000 0 0x1000>;
> > +                     interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_LOW>;
> > +                     iommus = <&iommu M4U_PORT_JPGENC_RDMA>,
> > +                              <&iommu M4U_PORT_JPGENC_BSDMA>;
> > +                     power-domains = <&spm MT8183_POWER_DOMAIN_VENC>;
> > +                     clocks = <&vencsys CLK_VENC_JPGENC>;
> > +                     clock-names = "jpgenc";
> > +             };
> > +
> >               ipu_conn: syscon@19000000 {
> >                       compatible = "mediatek,mt8183-ipu_conn", "syscon";
> >                       reg = <0 0x19000000 0 0x1000>;
> >
