Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2E3DE63C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhHCFhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbhHCFhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:37:22 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE3BC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 22:37:12 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e21so22339952pla.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 22:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TzgmYchbci/zhvlgXLAGmYsl7UzG8nnyQecH+/1YGbQ=;
        b=ES55ynagZ88pg0GPjV6f9YmdPOu1QNR8D/oRa8bNQ/T4u9Nxk+qPpJ5UcbEoQilUyZ
         u3+F/HwsLgeupDpIDbgs1unBMYXyLlltf0CudKw6Ac1QXWjntXx+kNos74b2LiMtNEcv
         es9C9D3nxwbVWjEvI1IPePrzDYu2Oqq5AJMmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TzgmYchbci/zhvlgXLAGmYsl7UzG8nnyQecH+/1YGbQ=;
        b=KKpV9YzMF7WExpyuu5ORRKSRQoScdKv+ZqjniKk6AKfLrzkeH8IL4dCcs7BhtJK7Tg
         nq4WXBgeLgVlpc23ZQUec6+RY5mswWjCNlZ9J+2PzTurRtoBaCOkstW5mN6/KRfBU2Xs
         cjHAFZvsMk5kHr7aN09te7WmqutgfmQL3pSBOwljkGhobT30vLeIlwPX/g0ZKkxQC56D
         EdFRZZy0vPRKr/ilB87NDmEKtaKxaUVxEEQn6JfDcIUlFmTjLhg3rgdw8UuQxCpnBEkd
         J/0Mm/wHEsE9irloKO4hnESmLoCwYfsuZwGmCMiLdCvoLratKi1TzZCOV45JMrpnU/Et
         QGBA==
X-Gm-Message-State: AOAM533BfcXvnuiM8/V4Jar8GjZR+OG1UooiZgtoN/79YlooHu2JUJTx
        ytB+wgSBmcuTKDSENCp5iGBEmXZyw0DJlznpQw2Wqw==
X-Google-Smtp-Source: ABdhPJwy22hM/0nLperLTs7oqlOkW3eLaO6jLCVztbfyp37svS9AhfV/dPAYrDNKRL8a0yAc2zvp451Ro7v8cSdVagE=
X-Received: by 2002:a17:902:b788:b029:12c:2888:9589 with SMTP id
 e8-20020a170902b788b029012c28889589mr17319543pls.60.1627969031860; Mon, 02
 Aug 2021 22:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210715121209.31024-1-yong.wu@mediatek.com> <20210715121209.31024-12-yong.wu@mediatek.com>
 <CAATdQgAfo9oNR5=ogEottHajODngi1ahvKUnEOUczzjreYpPcQ@mail.gmail.com>
 <1626935902.27875.7.camel@mhfsdcap03> <1627540902.13818.3.camel@mhfsdcap03>
In-Reply-To: <1627540902.13818.3.camel@mhfsdcap03>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Tue, 3 Aug 2021 13:37:01 +0800
Message-ID: <CAATdQgCf2sNwZWBKOC=HJU7Ur+7J6+uc75UD6xjfMF71Dxr18Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] memory: mtk-smi: mt8195: Add initial setting for smi-larb
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 29, 2021 at 2:41 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Hi Ikjoon,
>
> Just a ping.
>
> On Thu, 2021-07-22 at 14:38 +0800, Yong Wu wrote:
> > On Wed, 2021-07-21 at 21:40 +0800, Ikjoon Jang wrote:
> > > On Thu, Jul 15, 2021 at 8:23 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > >
> > > > To improve the performance, We add some initial setting for smi larbs.
> > > > there are two part:
> > > > 1), Each port has the special ostd(outstanding) value in each larb.
> > > > 2), Two general setting for each larb.

Honestly, I think nobody outside Mediatek will understand this.
Can you please update this to be more generic?
Like "Apply default bus settings for mt8195, without this, XXX
problems can happen.. "?

Or for example, adding brief descriptions on what
MTK_SMI_FLAG_LARB_THRT_EN, MTK_SMI_FLAG_LARB_SW_FLAG,
and MTK_SMI_FLAG_LARB_SW_FLAG[] are for would be better if it's available.

> > > >
> > > > In some SoC, this setting maybe changed dynamically for some special case
> > > > like 4K, and this initial setting is enough in mt8195.
> > > >
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > [...]
> > > >  struct mtk_smi {
> > > > @@ -213,12 +228,22 @@ static void mtk_smi_larb_config_port_mt8173(struct device *dev)
> > > >  static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> > > >  {
> > > >         struct mtk_smi_larb *larb = dev_get_drvdata(dev);
> > > > -       u32 reg;
> > > > +       u32 reg, flags_general = larb->larb_gen->flags_general;
> > > > +       const u8 *larbostd = larb->larb_gen->ostd[larb->larbid];
> > > >         int i;
> > > >
> > > >         if (BIT(larb->larbid) & larb->larb_gen->larb_direct_to_common_mask)
> > > >                 return;
> > > >
> > > > +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_THRT_EN))
> > > > +               writel_relaxed(SMI_LARB_THRT_EN, larb->base + SMI_LARB_CMD_THRT_CON);
> > > > +
> > > > +       if (MTK_SMI_CAPS(flags_general, MTK_SMI_FLAG_LARB_SW_FLAG))
> > > > +               writel_relaxed(SMI_LARB_SW_FLAG_1, larb->base + SMI_LARB_SW_FLAG);
> > > > +
> > > > +       for (i = 0; i < SMI_LARB_PORT_NR_MAX && larbostd && !!larbostd[i]; i++)
> > > > +               writel_relaxed(larbostd[i], larb->base + SMI_LARB_OSTDL_PORTx(i));
> > >
> > > All other mtk platform's larbs have the same format for SMI_LARB_OSTDL_PORTx()
> > > registers at the same offset? or is this unique feature for mt8195?
> >
> > All the other Platform's larbs have the same format at the same offset.
>
> In this case, Do you have some other further comment? If no, I will keep
> the current solution for this.

Sorry for the late response,
I have no further comments or any objections on here. Please go ahead for v3.
I just had no idea on the register definitions and wanted to be sure that
newly added register definitions are common to all MTK platforms.

Thanks!

>
> Thanks.
>
> >
> > >
> > > > +
> > > >         for_each_set_bit(i, (unsigned long *)larb->mmu, 32) {
> > > >                 reg = readl_relaxed(larb->base + SMI_LARB_NONSEC_CON(i));
> > > >                 reg |= F_MMU_EN;
> > > > @@ -227,6 +252,51 @@ static void mtk_smi_larb_config_port_gen2_general(struct device *dev)
> > > >         }
> > > >  }
> > > >
> >
> > [...]
> >
>
