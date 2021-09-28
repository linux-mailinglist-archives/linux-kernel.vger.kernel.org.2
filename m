Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3582D41A4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 03:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbhI1BxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 21:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238489AbhI1BxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 21:53:20 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49121C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 18:51:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 71so2427162ybe.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 18:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCkVRX97AO58vMSzB6rxBPstvtvKySLspcCyTvRfATY=;
        b=Ulj5PK+zka/euanCaQqe3SYCQRdXYFX5Dx+Tn9DSqALUJqoAK2kSt6KM301PJe0z1a
         6xt5HR00yOsSXkXOsRdTtWd+9Qet2FNvdii7hOhvURR0/RPtVdHDqdZYxgRXEJfQUrQk
         xr0c52WaJMoxw+SJxJjzTZBl96TsF24866EtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fCkVRX97AO58vMSzB6rxBPstvtvKySLspcCyTvRfATY=;
        b=k29Hv/p/Ik+HRYrBPvlxCYFFgU0TnwDilR77sstjxHf+IpBKDO/FrgkPxBvfvu+q6j
         rtGnAkZIt5+hUnf/tCcxJw9pye56bCEmWIC7SLYKJBydJBbJv7WhkiqQ0j7Kqmp0IEfE
         +u+WuFupJFE0/B2ShQruO2N6Vl+z9jbfgjzHivom+t3xz2QQVqkdNACYFMLVg68erbTW
         fEV0WT+KFgyFs64Q0/11ihroITOWY9rw8C3SmMmXF1J14RITLirjEiRF8mBCz55gu4Pj
         Uae+nagCFruN9P2YLpR4aYywFG6vG/vjAXFXrhpOGpsTdZL+aVI5NnetLaFpnPaUpBaZ
         6/Mw==
X-Gm-Message-State: AOAM532z+tdK59CVSLUnmytJAxHrvF82+mhq6ofeVo4y8K7CXO2Jh/cw
        biTF7QG++Cs2PdqWvbnuicwmJGq5MKxpJL+7olB1fQ==
X-Google-Smtp-Source: ABdhPJzGaNVhLfeD2+RwSw09ku1RC+tEo5n8XvZzZjMOU+SYxBtB+Aa3wU/1bYnRVWeVvwXzdgdQqd0PR5gb9LVn9A0=
X-Received: by 2002:a25:2610:: with SMTP id m16mr3425680ybm.508.1632793901622;
 Mon, 27 Sep 2021 18:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210924165322.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <CAE-0n53uBf-qbPptg-=9TX3=FGG4PvtVARfipxriJRE6cdWt4A@mail.gmail.com>
In-Reply-To: <CAE-0n53uBf-qbPptg-=9TX3=FGG4PvtVARfipxriJRE6cdWt4A@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Mon, 27 Sep 2021 18:51:31 -0700
Message-ID: <CA+cxXh=Mq8akELw4N8reZ7iBrEZ=Yzw=Yc_J+EVC8eF18eZveQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, Sep 27, 2021 at 12:59 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-24 16:54:13)
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
> > new file mode 100644
> > index 000000000000..7b1034a5a8e9
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
> > @@ -0,0 +1,87 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Google Trogdor dts fragment for the boards with TI sn65dsi86 edp bridge
> > + *
> > + * Copyright 2021 Google LLC.
> > + */
> > +
> > +&dsi0_out {
> > +       remote-endpoint = <&sn65dsi86_in>;
> > +       data-lanes = <0 1 2 3>;
> > +};
> > +
> > +&edp_brij_i2c {
> > +       sn65dsi86_bridge: bridge@2d {
> > +               compatible = "ti,sn65dsi86";
> > +               reg = <0x2d>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&edp_brij_en>, <&edp_brij_irq>;
>
> Why not move edp_brij_en as well? I think you want to reuse the node
> name for the other bridge, but it doesn't make sense unless that other
> patch is part of this series.

Yes, I posted v2 with the other patch enabling the second source edp bridge.

>
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
> > +
> > +               interrupt-parent = <&tlmm>;
> > +               interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> > +
> > +               enable-gpios = <&tlmm 104 GPIO_ACTIVE_HIGH>;
