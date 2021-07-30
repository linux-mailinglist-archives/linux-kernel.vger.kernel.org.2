Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5244F3DBBD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 17:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbhG3PM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 11:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbhG3PM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 11:12:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795D0C0613C1;
        Fri, 30 Jul 2021 08:12:51 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id s48so16486915ybi.7;
        Fri, 30 Jul 2021 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MFWb5ReFHG9Qg18Snz/SW+OnDom1C9cZbldQUCdkKvw=;
        b=o5kQpx8LrRodDLjVZrkuF/iDFyMtWzz9ew64tl4B5afEttXbhuZezzXzWft2zUP5Dy
         UcN2rCB/wGoYCpULEhl5jMLPgQZDa1fgwF9HREgevvbX6nd0C9nUrXKxWY3Nz25m0z94
         HQx+3zVqw3JWzep0eFZn340khidKXdzBvQGvX3jURa/0y2d8Dnlbq8bZePvtOoRAwLSr
         hAU/Rmg+fcqL8WdI6EJOq+qZ8HdKFh+2fzjtu6S+zZR9bqDDzC6Q1Dt+msn0q5BQpFnV
         QYLOWucAIZcqyvWvtnuXxgLwdMXa1QGlHfB/UvamVEXzjm8OAaG930RNcIewhNhrmOYr
         mDtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MFWb5ReFHG9Qg18Snz/SW+OnDom1C9cZbldQUCdkKvw=;
        b=XaRo4mIM/0l3LS5vGZKNJovmbt1nk+CFvTsqeS+rPa0g3tXtJEu8gtirnP8poUWfpk
         f+2ajtJ3OgLVX/oFNEOR9CE+P7K6wc3Nc6P3nNd5xrxkUuLwVrVP59ugJrpXP/j56LEI
         T85LDevthEFmg1piuLOEDKTtpgPoBg4Ow+2wP+1MlRJmpOU93HFVO9okKSTsDoJ3sw5I
         UbLrWQi5ekW0yNM6EpV3+972+6WmWBlMY8aX/VJQ4Z0Sj9UhOP6NVKJafXfmty88QebH
         Hxvd57RohahI295u51PS1zr9rHAcJV3fdym5a/o7YEt2413nmvD6R2ccwh+bC1DlZrSu
         H7wg==
X-Gm-Message-State: AOAM530IGI4989Xm375VDzNBinxYm38MtalBgk9rL+tzzLnHZjcsUY4O
        FrOdqBWlAY7RfC02JLZHGesSoP+3oZWEp2a8mJjTvOa9saI=
X-Google-Smtp-Source: ABdhPJwSbNJMRFq5P7d/BDOUhlE2m8nVbAT/REQJMtWGEvx4/xrIgzApd253SEcgaC/ectgWIbIlw72jEiK4DfRcLKE=
X-Received: by 2002:a25:2985:: with SMTP id p127mr3850822ybp.386.1627657970588;
 Fri, 30 Jul 2021 08:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210730140210.728367-1-pgwipeout@gmail.com> <9bb0e700-eb12-af14-76d6-3a90d434339b@arm.com>
In-Reply-To: <9bb0e700-eb12-af14-76d6-3a90d434339b@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 30 Jul 2021 11:12:39 -0400
Message-ID: <CAMdYzYpXwWdddVFFFQ=0MY0zCOR++n3gurkg-q7Jtrr7X_icQA@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add thermal fan control to rockpro64
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 10:33 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Peter,
>
> On 2021-07-30 15:02, Peter Geis wrote:
> > The rockpro64 had a fan node since
> > commit 5882d65c1691 ("arm64: dts: rockchip: Add PWM fan for RockPro64")
> > however it was never tied into the thermal driver for automatic control.
> >
> > Add the links to the thermal node to permit the kernel to handle this
> > automatically.
> > Borrowed from the (rk3399-khadas-edge.dtsi).
> >
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >
> > Changelog:
> > v2:
> > Adjusted fan setpoints for less noise
> >
> >   .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 57 +++++++++++++++++++
> >   1 file changed, 57 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > index 6bff8db7d33e..0d79e6ae1c3a 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> > @@ -69,6 +69,7 @@ diy_led: led-1 {
> >
> >       fan: pwm-fan {
> >               compatible = "pwm-fan";
> > +             cooling-levels = <0 100 150 200 255>;
> >               #cooling-cells = <2>;
> >               fan-supply = <&vcc12v_dcin>;
> >               pwms = <&pwm1 0 50000 0>;
> > @@ -245,6 +246,34 @@ &cpu_b1 {
> >       cpu-supply = <&vdd_cpu_b>;
> >   };
> >
> > +&cpu_thermal {
> > +     trips {
> > +             cpu_warm: cpu_warm {
> > +                     temperature = <55000>;
> > +                     hysteresis = <2000>;
> > +                     type = "active";
> > +             };
>
> (Heh, it still tickles me to see these points I arbitrarily made up
> being faithfully copied around - I guess that means I got them right!)

On the rockpro64 these points work quite nicely, I compile the kernel
natively so I hit the first one easily.

>
> > +
> > +             cpu_hot: cpu_hot {
> > +                     temperature = <65000>;
> > +                     hysteresis = <2000>;
> > +                     type = "active";
> > +             };
> > +     };
> > +
> > +     cooling-maps {
> > +             map2 {
> > +                     trip = <&cpu_warm>;
> > +                     cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> > +             };
> > +
> > +             map3 {
> > +                     trip = <&cpu_hot>;
> > +                     cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> > +             };
> > +     };
> > +};
> > +
> >   &emmc_phy {
> >       status = "okay";
> >   };
> > @@ -281,6 +310,34 @@ &gpu {
> >       status = "okay";
> >   };
> >
> > +&gpu_thermal {
> > +     trips {
> > +             gpu_warm: gpu_warm {
> > +                     temperature = <55000>;
> > +                     hysteresis = <2000>;
> > +                     type = "active";
> > +             };
> > +
> > +             gpu_hot: gpu_hot {
> > +                     temperature = <65000>;
> > +                     hysteresis = <2000>;
> > +                     type = "active";
> > +             };
> > +     };
> > +
> > +     cooling-maps {
> > +             map1 {
> > +                     trip = <&gpu_warm>;
> > +                     cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> > +             };
> > +
> > +             map2 {
> > +                     trip = <&gpu_hot>;
> > +                     cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> > +             };
> > +     };
> > +};
>
> Unless something's changed since commit a793e19c15f2 ("arm64: dts:
> rockchip: Fix NanoPC-T4 cooling maps"), multiple cooling maps don't
> actually share a singe cooling device properly[1]. The Khadas Edge DT
> dates from right around the same time so I guess it crossed over with
> that discussion and never got fixed.
>
> In hindsight, I do seem to remember my fan being a bit more jumpy around
> the trip points than it is today, which may well have been the two maps
> fighting each other...
>
> Robin.
>
> [1]
> https://lore.kernel.org/linux-rockchip/55b9018e-672e-522b-d0a0-c5655be0f353@linaro.org/

Interesting, so instead of "or-ing" the signals to the fan, the
thermal just fights with itself?
That explains interesting states where it can't decide if it wants to
run or not.

I'll pull the gpu portion and submit a v3, thanks!

>
> > +
> >   &i2c0 {
> >       clock-frequency = <400000>;
> >       i2c-scl-rising-time-ns = <168>;
> >
