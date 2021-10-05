Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79642330C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhJEVw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbhJEVwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:52:24 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E2C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 14:50:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c6-20020a9d2786000000b005471981d559so670757otb.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 14:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzyN7pjEwKRteTpFKR7X78nlUQwmeHl2aplCWsYfV8E=;
        b=frxwgOuQnmycJcFn150mApbcUK/ahHbFvLQev6YVd6AaSa6o7I4M5piwf5TT0Gam9y
         BNzaT95eFIGgen7DqC1kh2AOEiLQkaEz+K4zsySquMIQIwzHIs2XYFWhZDmRy+fnlB1O
         hPZxj8EGvMVOvKBgIt4faTXm/ha7rCHHRtZfoRIl0BeQa1vFNx3BqzO0f+Ww+CqMdEQU
         yjPAiBu77Qz3friKZFvwujM0thv0SyZP6Z5Jj7CSL1MxGV+n6aaVQqtyT0ST+fBce/if
         ioaOfwnUIocfnhlrdO9un3lzGcRPwSo3A01Dvc2xVoJ8hgYg9K0CBdVtWDmQc/o0aGi7
         RMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzyN7pjEwKRteTpFKR7X78nlUQwmeHl2aplCWsYfV8E=;
        b=u+a4Zw+BF9vPG2F3uJ/9GCMOna+s1K0Xh0L2MIWAQDY6UbWqRtBTOhd71vwGI+sRZ4
         o/QvMyE/jEkOCNUJZzVt9XX4khpHHgzCjQy2vc0nL/rQSD5TnbAXyi+OJ2EhaQrorfJ/
         jDI80lRLNbVkhWb95L/PGAD5ogIM852qK+W1I8tT/EF7wX1eZuNkA8kOKZtzAv+m1H6+
         r04H1nBHPXYqWQvCB/BKx8LDeKjSahuNP6xLNc/t+h8bhle6BRfJ0VgIAla5lUFlapZS
         QOHf9xhcZHBnjdkCCKhJ2hDLUYTN9R3hpCpfRB7muqZajle7sU5b6PTJAVWGNnxxS1pT
         4ZsA==
X-Gm-Message-State: AOAM530V6rbGrXQi8DMZmAeiFQYl7zc4q6RFXX0ABR91GIC0JwcVWnwt
        wB8TkDNH4N9s8r9tMmv8MDNvTg==
X-Google-Smtp-Source: ABdhPJycSgyQgdTpfBuf74cl5TEZzsO1NhbeIpZdioVzDSHi4AoKNbxtwbUqzIDATD0YyWRGI2VSWg==
X-Received: by 2002:a05:6830:1dad:: with SMTP id z13mr16842770oti.203.1633470632340;
        Tue, 05 Oct 2021 14:50:32 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id a9sm3749156otk.3.2021.10.05.14.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 14:50:31 -0700 (PDT)
Date:   Tue, 5 Oct 2021 14:52:13 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
Message-ID: <YVzJDU5ROmrI2rQb@ripper>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org>
 <YVSzJZ8G43CLml3L@google.com>
 <YVtg3lcR1HMqVdAJ@ripper>
 <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
 <f136fbb0-be3e-aee8-7a68-1d16148c80ff@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f136fbb0-be3e-aee8-7a68-1d16148c80ff@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 13:30 PDT 2021, Thara Gopinath wrote:

> 
> 
> On 10/4/21 4:56 PM, Dmitry Baryshkov wrote:
> > On Mon, 4 Oct 2021 at 23:13, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > > 
> > > On Wed 29 Sep 11:40 PDT 2021, Matthias Kaehlcke wrote:
> > > 
> > > > On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
> > > > > Downstream defines four ADC channels related to thermal sensors external
> > > > > to the PM8998 and two channels for internal voltage measurements.
> > > > > 
> > > > > Add these to the upstream SDM845 MTP, describe the thermal monitor
> > > > > channels and add thermal_zones for these.
> > > > > 
> > > > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > > ---
> > > > > 
> > > > > In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
> > > > > 
> > > > > Changes since v1:
> > > > > - Enable the pm8998_adc_tm and describe the ADC channels
> > > > > - Add thermal-zones for the new channels
> > > > > 
> > > > >   arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
> > > > >   1 file changed, 128 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> > > [..]
> > > > > +&pm8998_adc {
> > > > > +   adc-chan@4c {
> > > > > +           reg = <ADC5_XO_THERM_100K_PU>;
> > > > > +           label = "xo_therm";
> > > > > +   };
> > > > > +
> > > > > +   adc-chan@4d {
> > > > > +           reg = <ADC5_AMUX_THM1_100K_PU>;
> > > > > +           label = "msm_therm";
> > > > > +   };
> > > > > +
> > > > > +   adc-chan@4f {
> > > > > +           reg = <ADC5_AMUX_THM3_100K_PU>;
> > > > > +           label = "pa_therm1";
> > > > > +   };
> > > > > +
> > > > > +   adc-chan@51 {
> > > > > +           reg = <ADC5_AMUX_THM5_100K_PU>;
> > > > > +           label = "quiet_therm";
> > > > > +   };
> > > > > +
> > > > > +   adc-chan@83 {
> > > > > +           reg = <ADC5_VPH_PWR>;
> > > > > +           label = "vph_pwr";
> > > > > +   };
> > > > > +
> > > > > +   adc-chan@85 {
> > > > > +           reg = <ADC5_VCOIN>;
> > > > > +           label = "vcoin";
> > > > > +   };
> > > > > +};
> > > > > +
> > > > > +&pm8998_adc_tm {
> > > > > +   status = "okay";
> > > > > +
> > > > > +   xo-thermistor@1 {
> > > > > +           reg = <1>;
> > > > > +           io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
> > > > > +           qcom,ratiometric;
> > > > > +           qcom,hw-settle-time-us = <200>;
> > > > > +   };
> > > > > +
> > > > > +   msm-thermistor@2 {
> > > > > +           reg = <2>;
> > > > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
> > > > > +           qcom,ratiometric;
> > > > > +           qcom,hw-settle-time-us = <200>;
> > > > > +   };
> > > > > +
> > > > > +   pa-thermistor@3 {
> > > > > +           reg = <3>;
> > > > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
> > > > > +           qcom,ratiometric;
> > > > > +           qcom,hw-settle-time-us = <200>;
> > > > > +   };
> > > > > +
> > > > > +   quiet-thermistor@4 {
> > > > > +           reg = <4>;
> > > > > +           io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
> > > > > +           qcom,ratiometric;
> > > > > +           qcom,hw-settle-time-us = <200>;
> > > > > +   };
> > > > > +};
> > > > > +
> > > > 
> > > > The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
> > > > and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
> > > > several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
> > > > redundancy bothered me earlier, it's not really clear to me whether it's
> > > > needed/recommended or not. Do you happen to have any insights on this?
> > > 
> > > Hmm, you're right and I missed this in defining my channels. I've not
> > > looked at this detail, just got reasonable readings from my thermal
> > > zones and was happy about that.
> > > 
> > > Dmitry, do you have any further insights why these properties are
> > > supposed to be duplicated between the adc channel and the thermal zones?
> > 
> > Because both ADC channel and thermal zone registers should be
> > programmed accordingly.
> > 
> > One not-so-perfect approach would be to use io-channels property to
> > locate the adc's adc-chan node and to parse it. However this way
> > thermal driver would have to know the exact structure of adc's device
> > tree nodes.
> > Another (even worse) solution would be to introduce qcom-specific API
> > to query these properties from the IIO channel.
> > 
> > Selecting between these two options I decided to follow the downstream
> > path and just to duplicate these few properties.
> 
> I know I am joining late to this party, since v3 is out. But before I send
> my acked-by, wanted to check/state a few things.
> To me, the not-so-perfect approach that you mention here is actually not so
> bad, considering the thermal sensor driver already is aware of internals of
> the adc device. The duplicating of node is kind of confusing.
> Also did you explore using one of _channel_write apis in iio framework to
> move all the writes into the adc device instead of thermal sensor driver ?
> 

To me the TM hardware block seems to just duplicate some parts of the
ADC block. Without understanding why the two would need to be configured
in sync, I don't think we should tie them together further.

In particular, I get the same readings with or without configuring the
ADC channels, does this perhaps imply that the TM configuration is used
to configure the ADC during it's reads (i.e. we don't need to define the
ADC channels after all), or is this just a coincidence?

There are other things in the PMIC, using the ADC seemingly without you
having to explicitly configure the ADC and there's definitely things
pointing to the ADC being "timeshared" between various users.

Regards,
Bjorn
