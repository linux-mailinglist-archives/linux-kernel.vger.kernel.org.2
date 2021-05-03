Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A210371129
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 07:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhECFHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 01:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhECFHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 01:07:32 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE34FC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 22:06:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p11so3151463iob.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 22:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=siZxirsKcvAyDsxwYv2Y0WOcvC8VgXLaF+KpmP1I61A=;
        b=mgS0glfnCT8eoMAEyZGezk85iJY7xyPQvKSfM5A9XtRTcW3dgMjOGbMHKPIE5fkok0
         p1WK5h3vXYXscSt46dYI3bmRSNiP0coNcJlGlZtzv74usrebeO0DsXBHxQpuAYXsjWX2
         81WuziISp7m7FqtuFssOmD0+g0Ih617T5D+Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=siZxirsKcvAyDsxwYv2Y0WOcvC8VgXLaF+KpmP1I61A=;
        b=kpGosQ0ZmpJhS50GZp9qBilajUsECbVaReAO8RdkVBn+09q/Go+wSMQS0xVVXd0FiK
         PYJnRoDSo6KvEA7XDB8FDcue+TkNHBXZMRVqu3Jtlkr1KG5wBSZFt9yqpzWkIJhX0cKT
         45Abm7SUuzOLOaL4GGIeeaOEb/BzflIWdeVn/k3zqL4lT6MkL5SiGrsZdDqICAI1HBM0
         fSjdR0mclqt1kW/C/PpOuDYMzKnJ7ksRy+/lozN5DJih9SI4AxiPk9WQqbg1pxi/pLTo
         7eT3/5mxstG+oBFy6+ga4ZK8GWlyz72BvmTAS9hpKthWUVz9bXIGydwByt2F2/FGPc6Q
         PO1g==
X-Gm-Message-State: AOAM532XQeUX+lOzuWVJ3e3wxkxwAVkgLTDK1diqL9lGIZ/Vq2FZM/fs
        GwHmLBzU1NgEo3eB0mYIfCwa3HHm2rSGd0z4au7Xjw==
X-Google-Smtp-Source: ABdhPJzn7Y0sAseQkQfOM+fsmzHK9fRfrpX2TeHpHY9qrHf8bXHvuPgZryeTezCNykMdNGD+4wYQGXMrCwf6UBCLsoc=
X-Received: by 2002:a05:6638:f11:: with SMTP id h17mr5692188jas.102.1620018399221;
 Sun, 02 May 2021 22:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210423065327.1596075-1-hsinyi@chromium.org> <846d2a7a-d9c2-7d9e-9d7e-843ff604be44@collabora.com>
In-Reply-To: <846d2a7a-d9c2-7d9e-9d7e-843ff604be44@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 3 May 2021 13:06:13 +0800
Message-ID: <CAJMQK-iUzarwbvY3R-ezZWmZaDK58JzhEtzG+uyuZAJbsKmE1g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: add mediatek,gce-events in mutex
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 9:00 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Hsin-Yi,
>
> Thank you for your patch.
>
> On 23/4/21 8:53, Hsin-Yi Wang wrote:
> > mediatek,gce-events is read by mutex node.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Although I know this property is used and needed I didn't find documentation
> about it. It would be really nice document in the bindings this mediatek property.
>
> In any case this patch LGTM, so
>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>

I added the bindings in v2, thanks.

> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index c5e822b6b77a..cf22d71161e5 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -1250,6 +1250,8 @@ mutex: mutex@14016000 {
> >                       reg = <0 0x14016000 0 0x1000>;
> >                       interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_LOW>;
> >                       power-domains = <&spm MT8183_POWER_DOMAIN_DISP>;
> > +                     mediatek,gce-events = <CMDQ_EVENT_MUTEX_STREAM_DONE0>,
> > +                                           <CMDQ_EVENT_MUTEX_STREAM_DONE1>;
> >               };
> >
> >               larb0: larb@14017000 {
> >
