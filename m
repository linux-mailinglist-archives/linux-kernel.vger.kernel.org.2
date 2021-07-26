Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD72B3D573E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 12:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhGZJf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhGZJf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:35:56 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB1C061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:16:25 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id l18so11003917ioh.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKm9EcDme8pJHFOXtEbqZSQVHJJ+TbQM1VPZ24DBvwA=;
        b=X+IoIMuJH2ZijTePJyIs6T3oSX69YS0Rj+602X5tzCjx1R7H5deruUXBy88v3d7stV
         sb1n7pGVe21QI9HvlAGYNsQ7Eyg3+ET0x6wnD2ErXuHKI5mWGP7NWYiDZLLNL18AQBTu
         a4w0ONGnjsYzXIt+fiFQIThJpIJbBpxgjYNxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKm9EcDme8pJHFOXtEbqZSQVHJJ+TbQM1VPZ24DBvwA=;
        b=sNSrOgn4opXBjApFspcSrGppuGi23Ya08VLN2yW4ns/eU3QsR7n0ZB3JK0G9usicaP
         EeQGokWQLEf4jN3pc2vRLTnrB7ezlK56E/A/EVT2Wpzd0pYIDiSx4sCdCHSGdFDysRKI
         w6eXvHjvMo1dpSjmh39Fgpz/ypqRLCEDaedBqcR7+vSXLCzFHeCu7I/5SCbVkFcGk5MF
         4DHM/vE8+Z6Yk0NOj+mQOIgS3rit5qoFf6m+JNxgaXbvdY/aknouEMYhnoZsguF0+PZI
         OwEE2TDoB3HKWqpGY7We3fMy/OAQs4gApmZiW7pj7F2IX8RkjGno321jZlSI0DMU2Yqj
         IRJw==
X-Gm-Message-State: AOAM531aH8ctVAqosaDwzeD7Tb5d5Dzt4cVwbL+wsFcyHxVAFkVfTU1h
        0lt9Er+off+pRI5k/KL2qz6mID8D/voJzAujCpw7pQ==
X-Google-Smtp-Source: ABdhPJyhs6/VJlK39tRjkVThyIrMjZQOguga/L0sVp4xovp5RErc5dbjNDeDpRT7Q/vE8sdHiDz2tR0mQ4+gi3ZYr1E=
X-Received: by 2002:a02:6946:: with SMTP id e67mr15605786jac.4.1627294584585;
 Mon, 26 Jul 2021 03:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210726050831.1917982-1-hsinyi@chromium.org> <CAFqH_53zJp7ejwXn3qqiVPnoTy6W3WonvvDxsZDCjmaQA57h6A@mail.gmail.com>
In-Reply-To: <CAFqH_53zJp7ejwXn3qqiVPnoTy6W3WonvvDxsZDCjmaQA57h6A@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 26 Jul 2021 18:15:58 +0800
Message-ID: <CAJMQK-jkUCVgRXL5dcDUd6vpEojEG6heuAXgvbYwikz_sPjnHQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: kukui: Use aliases to mmc nodes
To:     Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 5:32 PM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Hsin-Yi,
>
> Thank you for the patch.
>
> Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 26 de jul.
> 2021 a les 7:08:
> >
> > Use aliases to mmc nodes so the partition name for eMMC and SD card will
> > be consistent across boots.
> >
>
> This definitely helps with my "troubles" flashing the kernel to the
> correct place" so
>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>
> Btw, I think that a similar patch should be send for Elm, could you
> take care of it?
>
It's sent here:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210726101451.2118076-1-hsinyi@chromium.org/

Thanks!

> Thanks,
>   Enric
>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index ae549d55a94fc..ed499e17b6570 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -13,6 +13,8 @@
> >  / {
> >         aliases {
> >                 serial0 = &uart0;
> > +                mmc0 = &mmc0;
> > +                mmc1 = &mmc1;
> >         };
> >
> >         chosen {
> > --
> > 2.32.0.432.gabb21c7263-goog
> >
