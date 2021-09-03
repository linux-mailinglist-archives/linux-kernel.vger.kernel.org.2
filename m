Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F135E40056E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350577AbhICTB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350562AbhICTB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 15:01:56 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D5C061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 12:00:55 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id n18so6375058pgm.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/RAyYN7XSWdMXJkR/E7oV/FAskQ62li2eXUaN70sJiQ=;
        b=LlSfdxokQTHak+lCCI/rYOtrG3FYCueY+bffw3RtBxX8x1AOgO1F0SSTERzIsZ3kmE
         Fay2nHsEaXJpEDLLuBsP/1QftwcjzJZCWn3sfaX01bEOSD4c6n1x3wbwIl6w+IuIXu/F
         SHHh2aE2gKbO966yYee7W5oKwJc2l4rMheo0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RAyYN7XSWdMXJkR/E7oV/FAskQ62li2eXUaN70sJiQ=;
        b=Z3M3VygfrVU6DiOKYjdvCdDtXxt3fjv+2jtNUKJHhwn63aMaQNrA1kC5PrYRBFJ4ad
         kKmlfNAYohHiehoOQlDFrPMKs81K+eIN96vY+gDwuhD3yS8/MsitSUprYv1Uck5wqvFJ
         Wv8UI0WtNhiGX6EZlFcr6cj46n9V740YJpPpZqJJyjgOy/M/Xn3RYiQHzoim3zSMiaPP
         tgH9NFgbac4DWDQWhM1ZwIrG8h0xXDpzf1BwYAQnMgtw4B+n2asi/d+IHjc7NCTG2p1D
         aVfA5gNTpI/AE0mxhpy+/ZLqRHEbNyGIhM+eiIY5EcHCdvOwmncv4rEBSTDNRxQJb/m+
         OHWg==
X-Gm-Message-State: AOAM533RAwb8UgMV1eSoLZzue31AHXEpW+o0acdaSNssa1dMrIOmpmpE
        NVGIumcrwUt9GvrCOGbQQarGpA==
X-Google-Smtp-Source: ABdhPJxTKBNFM52lTpurPfhlKUeZfeipurGeOuwOfFDVCXHJ8EDkoOeCLegHdP7fE/3OLWlLR7rPaw==
X-Received: by 2002:a65:6287:: with SMTP id f7mr443437pgv.444.1630695655326;
        Fri, 03 Sep 2021 12:00:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:80b3:9f00:3170:fd8b])
        by smtp.gmail.com with UTF8SMTPSA id i5sm124517pgp.53.2021.09.03.12.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 12:00:54 -0700 (PDT)
Date:   Fri, 3 Sep 2021 12:00:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Delete ADC config for
 unused thermistors
Message-ID: <YTJw5VwHFoCX4WJe@google.com>
References: <20210902154711.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
 <CAE-0n51s1s6L7G1vxbC8PEZ=FBr9mSch81KUBO6fK_jfO8S_CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE-0n51s1s6L7G1vxbC8PEZ=FBr9mSch81KUBO6fK_jfO8S_CQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 05:20:43PM -0700, Stephen Boyd wrote:
> Quoting Matthias Kaehlcke (2021-09-02 15:47:44)
> > The charger thermistor on Lazor, CoachZ rev1 and Pompom rev1+2 is
> > either the wrong part or not stuffed at all, the same is true for
> > the skin temperature thermistor on CoachZ rev1. The corresponding
> > thermal zones are already disabled for these devices, in addition
> > delete the ADC nodes of the thermistors.
> >
> > For Lazor and CoachZ rev1 also disable the PM6150 ADC thermal
> > monitor since there are no other temperatures to monitor.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >
> >  .../arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts | 12 ++++++++++++
> >  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi   | 10 ++++++++++
> >  .../arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts |  8 ++++++++
> >  .../arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts |  8 ++++++++
> >  4 files changed, 38 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> > index 21b516e0694a..edfcd47e1a00 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> > @@ -23,6 +23,18 @@ &charger_thermal {
> >         status = "disabled";
> >  };
> >
> > +&pm6150_adc {
> > +       /delete-node/ skin-temp-thermistor@4e;
> > +       /delete-node/ charger-thermistor@4f;
> 
> Is there any other child node? I only see two, unless I missed
> something. In which case the whole node can be disabled?

Right, the ADC itself can also be disabled in this case.

> 
> > +};
> > +
> > +&pm6150_adc_tm {
> > +       status = "disabled";
> > +
> > +       /delete-node/ charger-thermistor@0;
> > +       /delete-node/ skin-temp-thermistor@1;
> > +};
> > +
> >  /*
> >   * CoachZ rev1 is stuffed with a 47k NTC as thermistor for skin temperature,
> >   * which currently is not supported by the PM6150 ADC driver. Disable the
> > diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> > index 00535aaa43c9..57f7b19f83b0 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> > @@ -54,6 +54,16 @@ &panel {
> >         compatible = "boe,nv133fhm-n62";
> >  };
> >
> > +&pm6150_adc {
> > +       /delete-node/ charger-thermistor@4f;
> 
> Same question here.

Yes, the ADC can be disabled here too.
