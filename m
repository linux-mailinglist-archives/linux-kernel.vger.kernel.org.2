Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B003D5714
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhGZJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhGZJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:28:12 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E3C061757;
        Mon, 26 Jul 2021 03:08:41 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so9430088oto.12;
        Mon, 26 Jul 2021 03:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1W8BM33E8I7Rg6qQkHpIq24nb3jtDXTVrJEtrhyQpY=;
        b=mhxSo+BtVhr0w+J9JSXO8eV4u/xQHPXbnkT1CJPffjjbaxEUzQHPRFm9j8Er6+4DyB
         7jFZhKMOOZ/9DEfrCUmxS3cO4159fI3JHkWf+itkWMBYAXmhPG4T6qO0/hJM/ecd6KRM
         +fBwalsP8KMrcDjZPg/r1d9qdCagN6ec2r9TQgaWMnpldEetamoI1WIPPPrwyFzhGQcR
         Jh/3NOTVKIMMWCUYMXSZHv8rD0/eOWpgxdbYDnwJNUITjcPzQHNjZaNc6zmZstvviRjl
         PbVDcIszcZEdawhBkh2zIjxEd2nqOiuIIUkx1TpoU8MGw265fNFfAYcCZ1x97CLBxr+T
         BeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1W8BM33E8I7Rg6qQkHpIq24nb3jtDXTVrJEtrhyQpY=;
        b=Hc/EY7pNz7Of2EEefIqCNFJi13jSUTuj3JH4lY1RfBvC0JfSKxPvNoYSlup2pLtzDZ
         YKuUwoB01Y+U3ikAuCzgbZv4u3363gP4SOFcbLnXkyBeTzjaAr496t2CNTS6oA0Zb5/v
         Dl1ujeokcG4bDlk7eRC/LScjz65d2Dwmxg6GJcJmoXBPHqks2ZTfTYzVlBgXObWFgJZA
         TnrL9JEG+cKBQjT66Ng3GcWV5WdyoNE232k10HZNqd3lA9ICcr/UqpNl201GeU9fDeHT
         tPD2O0vDg36l/RVjl3Mqw+OihYsDV0aEkHCa6Gj6D9ESamRNIZyLL5Je3D/wfJd4Bka4
         oMBQ==
X-Gm-Message-State: AOAM530Y0V05ukIGD73VCfW2Mkp6zGeMNZ61aS/vFp9kXOrycoZjCRJy
        PMHUyRcfIm6S2IRf+WtzRcjSLHSTjwwDO+X1CG0=
X-Google-Smtp-Source: ABdhPJwcFKNYI6+KwnCa9bmjN5KGLG4/G0IOcDqm6ZBsn9Z8heUe+7xQBKSswL+u6yHDGeIWzLR0FC8ZXJ5dmHqbbiY=
X-Received: by 2002:a9d:6490:: with SMTP id g16mr1584823otl.184.1627294120561;
 Mon, 26 Jul 2021 03:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210722092624.14401-1-jason-jh.lin@mediatek.com>
 <20210722092624.14401-2-jason-jh.lin@mediatek.com> <CAFqH_51qKkxMit5fkSh_AyeNAYwKnoPe09nwJLKaKez26+HUew@mail.gmail.com>
 <4c0fe16988c559a5a4b1ce714eeaa31f4628f68f.camel@mediatek.com>
In-Reply-To: <4c0fe16988c559a5a4b1ce714eeaa31f4628f68f.camel@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 26 Jul 2021 12:08:28 +0200
Message-ID: <CAFqH_512RCNBufS=zL5hQSQJya3565dm2D3zznWie9rKUN_sAw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: mediatek: mmsys: add mt8195 SoC binding
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        Jitao shi <jitao.shi@mediatek.com>, fshao@chromium.org,
        David Airlie <airlied@linux.ie>, singo.chang@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Fabien Parent <fparent@baylibre.com>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

Missatge de Jason-JH Lin <jason-jh.lin@mediatek.com> del dia dl., 26
de jul. 2021 a les 9:02:
>
> On Fri, 2021-07-23 at 13:13 +0200, Enric Balletbo Serra wrote:
> > Hi Jason,
> >
> > Thank you for your patch.
> >
> > Missatge de jason-jh.lin <jason-jh.lin@mediatek.com> del dia dj., 22
> > de jul. 2021 a les 11:26:
> > >
> > > There are 2 display hardware path in mt8195, namely vdosys0 and
> > > vdosys1, so add their definition in mtk-mmsys documentation.
> > >
> >
> > Just having 2 display hardware paths is not a reason to have two
> > compatibles, isn't the IP block the same? Why do you need to
> > introduce
> > the two compatibles?
> >
> > Thanks,
> >   Enric
> >
>
> Hi Enric,
>
> Thanks for reviewing my patch.
>
> The reason for using two compatibles is that vdosys0 and vdosys1 are
> different IP blocks.
>

With that there are different IP blocks, what do you mean? Do you mean
that there are two completely different blocks with completely
different functionalities?

Or that there is the same IP block twice? I mean, of course, the
registers are different but has exactly the same functionality.

> Because mmsys provides clock control, other display function blocks may
> use them as clock provider.
>
> E.g.
> 1. mmsys with compatible="mediatek,mt8195-vdosys0"
> [v4,1/6] arm64: dts: mt8195: add display node for vdosys0
>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210723090233.24007-2-jason-jh.lin@mediatek.com/
>
> ovl0: disp_ovl@1c000000 {
>         ...
>         clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
>         ...
> };
>
> 2. mmsys with compatible="mediatek,mt8195-vdosys1"
> [v2,06/14] arm64: dts: mt8195: add display node for vdosys1
>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210722094551.15255-7-nancy.lin@mediatek.com/
>
> vdo1_rdma0: vdo1_rdma@1c104000 {
>         ...
>         clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
>         ...
> };
>

Note that I am talking without knowing the hardware in detail, but I
am wondering why I can't have something like this, where every mmsys
is a clock and reset controller provider.

vdosys0: syscon@14000000 {
          compatible = "mediatek,mt8195-mmsys", "syscon";
          reg = <0 0x14000000 0 0x1000>;
          #clock-cells = <1>;
          #reset-cells = <1>;
};

vdosys1: syscon@15000000 {
          compatible = "mediatek,mt8195-mmsys", "syscon";
          reg = <0 0x15000000 0 0x1000>;
          #clock-cells = <1>;
          #reset-cells = <1>;
};

ovl0: disp_ovl@1c000000 {
        ...
       clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
        ...
};

vdo1_rdma0: vdo1_rdma@1c104000 {
        ...
        clocks = <&vdosys1 CLK_VDO1_MDP_RDMA0>;
        ...
};

What are the differences between vdosys0 and vdosys1 from a hardware
point of view?

Cheers,
  Enric

> Regards,
> Jason-JH.Lin
>
> > > Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> > > ---
> > > this patch is base on [1][2]
> > >
> > > [1] dt-bindings: arm: mediatek: mmsys: convert to YAML format
> > > -
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20210519161847.3747352-1-fparent@baylibre.com/__;!!CTRNKA9wMg0ARbw!ycgPEK4yBDojiiZJC2E9mGwvxJbaLqhyUxzJIq0ckEP-JVteBcjFdc6ixkNbmknH8f2P$
> > >
> > > [2] dt-bindings: arm: mediatek: mmsys: add MT8365 SoC binding
> > > -
> > > https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/patch/20210519161847.3747352-2-fparent@baylibre.com/__;!!CTRNKA9wMg0ARbw!ycgPEK4yBDojiiZJC2E9mGwvxJbaLqhyUxzJIq0ckEP-JVteBcjFdc6ixkNbmju2GBrD$
> > >
> > > ---
> > >  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        |
> > > 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > > l
> > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > > l
> > > index 2d4ff0ce387b..0789a9614f12 100644
> > > ---
> > > a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > > l
> > > +++
> > > b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yam
> > > l
> > > @@ -30,6 +30,8 @@ properties:
> > >                - mediatek,mt8173-mmsys
> > >                - mediatek,mt8183-mmsys
> > >                - mediatek,mt8365-mmsys
> > > +              - mediatek,mt8195-vdosys0
> > > +              - mediatek,mt8195-vdosys1
> > >            - const: syscon
> > >        - items:
> > >            - const: mediatek,mt7623-mmsys
> > > --
> > > 2.18.0
> > >
> --
