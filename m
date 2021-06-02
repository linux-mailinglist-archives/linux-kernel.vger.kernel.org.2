Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1061C398F48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 17:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbhFBPyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 11:54:35 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]:41726 "EHLO
        mail-qv1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbhFBPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:54:34 -0400
Received: by mail-qv1-f51.google.com with SMTP id x2so888722qvo.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvvPoZSmeOhoOWxm8/PZCNGxhArABKqYDVldZtK3gXs=;
        b=fqSfFAyMMR4rpm+DVHsJ6NRNdU4CgJlg205vDbxpccSzn6kavaetdI45xsMorfqmJ8
         r2L0A5062mV72VWsKqBZS2186v/cHtgrYF0G0KOE/+u9wq5mD2zeCDqMbhmScrfGuzs8
         Px+PUn7yO0dcYi7x1qN0P/mEpVeKLVGuxFM0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvvPoZSmeOhoOWxm8/PZCNGxhArABKqYDVldZtK3gXs=;
        b=KgHGuXxFmv5nkxaU1zhKt1YoVN65UxPvKND1IVgAdJOCUE9wLmVz8a1yN8LbM6R36w
         I+pTaVegEW8XK+qT1H57RzBP5EfH34d9X6J//qHV9sFuE07Q3fa79GTxX8uXy7SvdfbF
         xbbEgQe3WB2d8mLnzOjSQESBok60L43v4T21i0RkrMDgeMICOamBLeQlj4wzkUFnYb9J
         g8ZkrBChaMAJCdL9pE6geLD28fIo3G8+5COVTohTaC/0lyDo1SSaIQbJKLBGeULN/Xsj
         oqrxJLPp5/407XWNX+prWPLpcSqXapc5CsVsx4IhWyiD/XWOiESciF2Ad4/G02gAKAWv
         kpQQ==
X-Gm-Message-State: AOAM531+v3fIiAEoE87Ax5tWcq6x/6oetWfjmS0ud8m2ZQdpK9uDJQUK
        W+r6EGKivNeF60o2OguhNB2bJ2lTd9SBwg==
X-Google-Smtp-Source: ABdhPJwiSeSnF0nNx2TrUk0TbJ2Tg+nB60r2arJ+VBH0JnRFHFj8SRXqtHEpW4mxERkVB/zXd+Pipg==
X-Received: by 2002:a0c:c348:: with SMTP id j8mr10139648qvi.57.1622649110777;
        Wed, 02 Jun 2021 08:51:50 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id u2sm61278qkk.75.2021.06.02.08.51.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 08:51:50 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id y2so4435690ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 08:51:49 -0700 (PDT)
X-Received: by 2002:a5b:54a:: with SMTP id r10mr46474150ybp.476.1622649109527;
 Wed, 02 Jun 2021 08:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210519054030.3217704-1-swboyd@chromium.org> <CAD=FV=UarqLwPu6mJ7QU8qXWoaizqMHHbjqF4q=KPYvDZrhT-A@mail.gmail.com>
In-Reply-To: <CAD=FV=UarqLwPu6mJ7QU8qXWoaizqMHHbjqF4q=KPYvDZrhT-A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 2 Jun 2021 08:51:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqAX7o+caB-AyNkmBQNeq7iaoUgmwKknq1kXhsJCMw=w@mail.gmail.com>
Message-ID: <CAD=FV=XqAX7o+caB-AyNkmBQNeq7iaoUgmwKknq1kXhsJCMw=w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Update flash freq to
 match reality
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn,

On Wed, May 19, 2021 at 9:05 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, May 18, 2021 at 10:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > This spi flash part is actually being clocked at 37.5MHz, not 25MHz,
> > because of the way the clk driver is rounding up the rate that is
> > requested to the nearest supported frequency. Let's update the frequency
> > here, and remove the TODO because this is the fastest frequency we're
> > going to be able to use here.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > index 24d293ef56d7..af3c0e1e2223 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> > @@ -335,8 +335,7 @@ flash@0 {
> >                 compatible = "jedec,spi-nor";
> >                 reg = <0>;
> >
> > -               /* TODO: Increase frequency after testing */
> > -               spi-max-frequency = <25000000>;
> > +               spi-max-frequency = <37500000>;
> >                 spi-tx-bus-width = <2>;
> >                 spi-rx-bus-width = <2>;
> >         };
>
> Thanks. Looks right to me. I confirmed that the clock is 150 MHz in my
> "clk_summary" which is 4x 37.5.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

If you agree, I think this patch is ready to land.

-Doug
