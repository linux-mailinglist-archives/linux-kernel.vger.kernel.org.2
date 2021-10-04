Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D4F4218D2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 22:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJDU6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbhJDU6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 16:58:13 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70BAC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 13:56:23 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id r1so17187888qta.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1eQiWMZ4lymZhXSohlx4RiHi1Znkn0XwFspzyAQ+6Iw=;
        b=yAj0KI/Q4RAtOOwCLsC+i6W48grzLyHT6dYmBvRQ80kX4+c6EJhAiV63SRn7d7PMCp
         IomeYeocu716ENOjAmxvDgQwOYqr+OmL5Mf3fm8h9RlXpNfecoRWuiloIIV9hzPQfA/Q
         t6LdNbGcfFB0Sfn/SF7S+dbscHu1phxbLpYSE907d54wt7MbORsLhRkoZ527iRDjP1Mg
         QVZlPS+BJvEO9b3jyje9Lnu2yF9F02ne+U/1skn8S+jyeVmFo0I5XW0IM8coNfwwTjOX
         Tx0j8OJ2Mx3fqYk66PX2Hbr5UDe30WRM12n1GR6gpejN2iW83OpVHuQ/D1KxC7v8jXIt
         QVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1eQiWMZ4lymZhXSohlx4RiHi1Znkn0XwFspzyAQ+6Iw=;
        b=p9fvUNH4NA4sZUCTTACNq3u/iGa4OYmyBZ0zQlE6EM42a7Ve70jMiNplI8O8Vp6KM8
         j3CfRL5+ErPcZzmLqL8AHgAifbehTvddmtefpC2SKdeyI0btp5GzXB4aluDxjH42KyqB
         XF/1av4BaxTII+6Y4pE/W0EEOHXWFeNFazkx+okHsw8fiwlevzAFdgfHlWkGsAqvAdqr
         yBeFo+fYfHpu77qjPV4aAtVPKvzWbNbm/CyJK4QadiDrmni3qGlwwakGS+zMOSLZHQjv
         E8zbLOB7hMbjBl32uqBkII8bH+nswX+WuLlD9yaaGxftWuEV0dYEZuJO5w7kJJXnQpWy
         3MnA==
X-Gm-Message-State: AOAM530Cq2f7iGiMhge2e5avKkl9QS4sSxanqJz6943OUOqgSaXvjZI5
        Ww0v/SMdVPycdpl7kkpxdZ4d8XbXHUH60FiF7jT4OA==
X-Google-Smtp-Source: ABdhPJzTTTgb2VURiv0i9cfBWf1L2Z4r4TEETUlviwbAf6zzaXeUYI6x+ysMDBZNIHCcQYpLwm0LwzHbahxq5Onevlo=
X-Received: by 2002:ac8:1011:: with SMTP id z17mr15928369qti.388.1633380982877;
 Mon, 04 Oct 2021 13:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org> <YVSzJZ8G43CLml3L@google.com>
 <YVtg3lcR1HMqVdAJ@ripper>
In-Reply-To: <YVtg3lcR1HMqVdAJ@ripper>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 4 Oct 2021 23:56:11 +0300
Message-ID: <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Oct 2021 at 23:13, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Wed 29 Sep 11:40 PDT 2021, Matthias Kaehlcke wrote:
>
> > On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
> > > Downstream defines four ADC channels related to thermal sensors external
> > > to the PM8998 and two channels for internal voltage measurements.
> > >
> > > Add these to the upstream SDM845 MTP, describe the thermal monitor
> > > channels and add thermal_zones for these.
> > >
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >
> > > In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
> > >
> > > Changes since v1:
> > > - Enable the pm8998_adc_tm and describe the ADC channels
> > > - Add thermal-zones for the new channels
> > >
> > >  arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
> > >  1 file changed, 128 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> [..]
> > > +&pm8998_adc {
> > > +   adc-chan@4c {
> > > +           reg = <ADC5_XO_THERM_100K_PU>;
> > > +           label = "xo_therm";
> > > +   };
> > > +
> > > +   adc-chan@4d {
> > > +           reg = <ADC5_AMUX_THM1_100K_PU>;
> > > +           label = "msm_therm";
> > > +   };
> > > +
> > > +   adc-chan@4f {
> > > +           reg = <ADC5_AMUX_THM3_100K_PU>;
> > > +           label = "pa_therm1";
> > > +   };
> > > +
> > > +   adc-chan@51 {
> > > +           reg = <ADC5_AMUX_THM5_100K_PU>;
> > > +           label = "quiet_therm";
> > > +   };
> > > +
> > > +   adc-chan@83 {
> > > +           reg = <ADC5_VPH_PWR>;
> > > +           label = "vph_pwr";
> > > +   };
> > > +
> > > +   adc-chan@85 {
> > > +           reg = <ADC5_VCOIN>;
> > > +           label = "vcoin";
> > > +   };
> > > +};
> > > +
> > > +&pm8998_adc_tm {
> > > +   status = "okay";
> > > +
> > > +   xo-thermistor@1 {
> > > +           reg = <1>;
> > > +           io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
> > > +           qcom,ratiometric;
> > > +           qcom,hw-settle-time-us = <200>;
> > > +   };
> > > +
> > > +   msm-thermistor@2 {
> > > +           reg = <2>;
> > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
> > > +           qcom,ratiometric;
> > > +           qcom,hw-settle-time-us = <200>;
> > > +   };
> > > +
> > > +   pa-thermistor@3 {
> > > +           reg = <3>;
> > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
> > > +           qcom,ratiometric;
> > > +           qcom,hw-settle-time-us = <200>;
> > > +   };
> > > +
> > > +   quiet-thermistor@4 {
> > > +           reg = <4>;
> > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
> > > +           qcom,ratiometric;
> > > +           qcom,hw-settle-time-us = <200>;
> > > +   };
> > > +};
> > > +
> >
> > The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
> > and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
> > several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
> > redundancy bothered me earlier, it's not really clear to me whether it's
> > needed/recommended or not. Do you happen to have any insights on this?
>
> Hmm, you're right and I missed this in defining my channels. I've not
> looked at this detail, just got reasonable readings from my thermal
> zones and was happy about that.
>
> Dmitry, do you have any further insights why these properties are
> supposed to be duplicated between the adc channel and the thermal zones?

Because both ADC channel and thermal zone registers should be
programmed accordingly.

One not-so-perfect approach would be to use io-channels property to
locate the adc's adc-chan node and to parse it. However this way
thermal driver would have to know the exact structure of adc's device
tree nodes.
Another (even worse) solution would be to introduce qcom-specific API
to query these properties from the IIO channel.

Selecting between these two options I decided to follow the downstream
path and just to duplicate these few properties.

-- 
With best wishes
Dmitry
