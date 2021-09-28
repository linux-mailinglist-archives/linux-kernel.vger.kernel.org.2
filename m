Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712E441BAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 01:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbhI1XOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhI1XOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 19:14:07 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F6DC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:12:27 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b82so1229688ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 16:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pOdOmaZeHSF1Li4O+vfzWzIn7J4ES2tgo5Y2gh1hPm8=;
        b=Xq0w/CSJ42qnLcAxw851YfM8Bk+H3MCmvwd6AAQr+bOHCG+a/yQ3TU/MoSEAffmHvt
         EY8TRMcl0e9y1NI+QM8cKvLbbhZ0zmRf8Y7Ek2JzgnCc+5D/+sGGhpqI+kP116QaYTaD
         b7uQmGwGJ/149ePJtaXK7HMbybDfhfMx55oPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pOdOmaZeHSF1Li4O+vfzWzIn7J4ES2tgo5Y2gh1hPm8=;
        b=0XkEA/lt6yc6uV1qY4SjMfl4YHFVbdF8jqFdpm+chEZzkeBWec+0Xwdr4F8G8ebogM
         VV8i+WoDqJzsX+KE7N84I5F4LMoavQCvSS/P059DbMpmRHnTjld5fIzbFsp5YTEQouFC
         gvSw1MwNhVBGWgFpfQmosq1HLACbXcbPysn0c6POPYyD+LyIYaHq/fzvsYgE4ShDav8p
         692rYrzs+IUKNukSC9rvYLBc5uMUT4zuuedGFrt2gmFYtEZH4VYe1xd7Ebi1N3nXd0bL
         he/yFHZBSfMcS0adWavzkwCPbbO6m3KLP8jTb6IT49a+DKtckrQfJWnL79xLRX5yusfA
         sZDw==
X-Gm-Message-State: AOAM5320iUUIsZ/x2NLE9n9e+ik1rm6HAcE/vPFedJRN0MR5L7WmOPCU
        P4cbw9Y8UZwX1mSLsdqQZg7CvlUjoCnimyKWtBoGww==
X-Google-Smtp-Source: ABdhPJzH2wRPvaXG9zSbeWeGet3Akiwkc2bWJiSFXuPEJRtQbROL1ub01UhQrPEt19FSDojqFU4jiuVHzME8LRH1kHM=
X-Received: by 2002:a25:6a55:: with SMTP id f82mr9698121ybc.217.1632870746431;
 Tue, 28 Sep 2021 16:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210927184858.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <CAE-0n506JaDYzX_AXnL_eq9hDSPF1Lfxyd7chr=uYkxFkJHy6w@mail.gmail.com>
In-Reply-To: <CAE-0n506JaDYzX_AXnL_eq9hDSPF1Lfxyd7chr=uYkxFkJHy6w@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Tue, 28 Sep 2021 16:12:15 -0700
Message-ID: <CA+cxXhnbFvMxfTMNODqR-Gyio+xJA6BmQYNo3jWcHtFHT=4NSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
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

Hi Stephen,

On Tue, Sep 28, 2021 at 1:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Philip Chen (2021-09-27 18:49:39)
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
> I still don't see edp_brij_en used in the second patch so why didn't
> this pinctrl node move to this file like edp_brij_irq did?

edp_brij_en is also used in patch 2/2 (ps8640 support).
So I don't want to move it to this file.

>
> > +               gpio-controller;
> > +               #gpio-cells = <2>;
