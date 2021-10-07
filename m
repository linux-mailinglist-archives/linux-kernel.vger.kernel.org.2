Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D15425FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 00:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhJGWbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 18:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbhJGWbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 18:31:12 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF22C061755
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 15:29:18 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v195so16926522ybb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfTVFiINmIY6UFMHbXcxPSbLfMBK2gvbq9x+fWTLigY=;
        b=fm8fNapj6cv7jEuvRUnTgxhkE/7LPu1Xhi5MQFHABrW45dz/chNi2zpSw+Mrupyp0F
         KeQ5yHXEkPxpzUdhd0ZlBL0F5rYVkSUXYjFs7fMSumZX/3ZUJMAj/gjJNSiPjfy/03E/
         5Qq4ZJ3ZP8vhVvHOslqM84evlajprp7bKAFvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfTVFiINmIY6UFMHbXcxPSbLfMBK2gvbq9x+fWTLigY=;
        b=XkZTTnRlXgKt5oIaAlV8WgTwIo7FowXLQSrtXqQmQtBws6PLtMIaG1ydVzzQGVWmFx
         3l41jK58f8/6v0HslYLIQc5178vYbHMYnr4I0j6QBtyGmnG4hPt2qkdWWsg57IhGnZff
         OSHb4RjuuB+V/twBrrDF1LgYvuWXRLnWdvIH4hh9EGFyRSlP9fLZNDaFlP7ktOX9MbCd
         YCHzcng8v8ToaF1AVXmTAhwgChc3YMXFW+SmC5DJMOL9H5tVscA24z1ogH1Plcr7AAeG
         HbHgODfMePPbIRI8v0QalFXsBjaOyQVbVhJup/8tP6cPjZYH9EMr6JvsJjbYR1hATCJ4
         SvMA==
X-Gm-Message-State: AOAM533DQHuOJKs3JIYHulr4sSuXlSKIHDZizokEV+iG4c+kBgJM8h0S
        xaU5fS2FCOOAtxPn0biyDVzDfKZsgX7mbOaQQWt1bw==
X-Google-Smtp-Source: ABdhPJxcAJ4KyzDkJW4oIS4zvj5BhTUN+q0gQP7cUPWu/LFMm+spExO4FNIlXXgO6PkpUlbbDS/bo6dPaBOOd3/+4Rk=
X-Received: by 2002:a25:54c5:: with SMTP id i188mr7898822ybb.43.1633645757774;
 Thu, 07 Oct 2021 15:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210929173343.v2.1.Ib7e63ae17e827ce0636a09d5dec9796043e4f80a@changeid>
 <CAD=FV=XP+mJCEG+=meCXDb06bmfPwze2SP9FaMuKZkSh25JCSg@mail.gmail.com>
In-Reply-To: <CAD=FV=XP+mJCEG+=meCXDb06bmfPwze2SP9FaMuKZkSh25JCSg@mail.gmail.com>
From:   Philip Chen <philipchen@chromium.org>
Date:   Thu, 7 Oct 2021 15:29:07 -0700
Message-ID: <CA+cxXhn3Bw4d_F2LwP34ko1UuDGHHoQWLxcdK17L-PoDJ3n+ug@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: sc7180: Factor out ti-sn65dsi86 support
To:     Doug Anderson <dianders@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Sep 30, 2021 at 9:22 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Sep 29, 2021 at 5:35 PM Philip Chen <philipchen@chromium.org> wrote:
> >
> > Factor out ti-sn65dsi86 edp bridge as a separate dts fragment.
> > This helps us introduce the second source edp bridge later.
> >
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Move edp_brij_i2c completely out of sc7180-trogdor.dtsi to the
> >   bridge dts fragment, so that we can cleanly assign different
> >   edp bridge in every board rev.
> >
> >  .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  |  1 +
> >  .../boot/dts/qcom/sc7180-trogdor-lazor.dtsi   |  1 +
> >  .../boot/dts/qcom/sc7180-trogdor-pompom.dtsi  |  1 +
> >  .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts |  1 +
> >  .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi | 90 +++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 86 ------------------
> >  6 files changed, 94 insertions(+), 86 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > index a758e4d22612..1d13fba3bd2f 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
> > @@ -11,6 +11,7 @@
> >  ap_h1_spi: &spi0 {};
> >
> >  #include "sc7180-trogdor.dtsi"
> > +#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
>
> It looks like you're missing homestar, aren't you? I'd expect that
> after applying your change that:
>
> git grep -A1 include.*sc7180-trogdor.dtsi
>
> ...should show your new include right after all includes of
> sc7180-trogdor.dtsi, but I don't see it for homestar.

I can't find homestar dts file in my upstream checkout.
But I found: https://patchwork.kernel.org/project/linux-arm-msm/patch/20210909122053.1.Ieafda79b74f74a2b15ed86e181c06a3060706ec5@changeid/
...Is it merged anywhere?

>
> Other than that this looks good to me. Feel free to add my Reviewed-by.
