Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0942CABC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239119AbhJMUQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhJMUQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:16:25 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B05C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:14:21 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso3510118otl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=QyTd56Yy55oJcpmoXXse3UQ4TanL7tsHe7pndupRnAM=;
        b=UkgUzXgrhkocHJb5SORkvSsGhkAluE52o5vGR5B/f7J0XVrXZDQnrqJ2kt91A1un3H
         h3tpGowokJymNG3IgJkju/eTuWrTzHaUEgIXfvWKsfKj8hUwi0p6VZwPd58V/kBk/TeH
         W+xJEtq6ROaCfFT7KZndQGTvZJm1CLF9y8pMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=QyTd56Yy55oJcpmoXXse3UQ4TanL7tsHe7pndupRnAM=;
        b=y1FgmMHSrCvSIBEXo2xth4DGjXB/Vh/th+OFAo33jJBXueoKapHqoJNyiA3q3EPRrV
         o7P2KzbhtERlPi/iaHlemaFcXnVDRxDm6L9j5T6CzvuWBVfe35OT/975Ok4lq1EzVi6d
         47//4WYglqSfp6x93VcPP9NA/wIGrwZURWhyJAuYQav6W7qPEHaZz/SRNxIkvVP78Pq5
         UhUCUldUZJc3LemlfKCuDS5OL3boOsVxeO4o1yJvqygivcjFqJq8urvpXV5jQLN3u6rb
         e1hFdcqjSFRbgazUUHdocerQ2/1wl/pDgVG550i25XegZthGe72h6aZerIstOw6hw/RY
         qxkw==
X-Gm-Message-State: AOAM533T05D9Sl1oZ7Et3R5uN6K/3ZIEBtGm5HM0XWNy85cIy4IaqmjA
        Y0tENjkWsTozPRQIvWVkOerjmqBG3edVYYFVjJqxow==
X-Google-Smtp-Source: ABdhPJytWQESFwO9jS9EtdyTNqqN92VtGeoE9cEZU0Mp7ZYuw/Y5egTeTQdvmNfwErFI0oZQLfUa5L7oHbKH+PA2/rM=
X-Received: by 2002:a9d:12f4:: with SMTP id g107mr1096988otg.77.1634156061042;
 Wed, 13 Oct 2021 13:14:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Oct 2021 15:14:20 -0500
MIME-Version: 1.0
In-Reply-To: <46cc793cf651822ef90c448682598a02@codeaurora.org>
References: <1634043698-20256-1-git-send-email-bgodavar@codeaurora.org>
 <CAE-0n52uUh5TrKpJq9-qkJTdWWU_EZFvoROWFeGEjuc1Ebc8xg@mail.gmail.com> <46cc793cf651822ef90c448682598a02@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 13 Oct 2021 15:14:20 -0500
Message-ID: <CAE-0n52+ONDV7YVWcUL1WYEyPhCyxh994613BWKAibsuDwDw6w@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
To:     bgodavar@codeaurora.org
Cc:     bjorn.andersson@linaro.org, johan.hedberg@gmail.com,
        marcel@holtmann.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        pharish@codeaurora.org, rjliao@codeaurora.org,
        hbandi@codeaurora.org, saluvala@codeaurora.org,
        abhishekpandit@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting bgodavar@codeaurora.org (2021-10-12 22:30:50)
> On 2021-10-12 22:54, Stephen Boyd wrote:
> > Quoting Balakrishna Godavarthi (2021-10-12 06:01:38)
> >> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> index 272d5ca..09adc802 100644
> >> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> >> +               compatible = "qcom,wcn6750-bt";
> >> +               pinctrl-names = "default";
> >> +               pinctrl-0 = <&bt_en_default>;
> >> +               enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> >> +               swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
> >
> > Is there any pinctrl config for gpio 86?
> >
> [Bala]: This is input GPIO to apps, BT SOC will handle configurations.

Ok. So there should be some pinctrl stating that the function is "gpio"
and the biasing is probably bias-disable. The BT SOC will handle setting
any pull, either up or down?

>
> >> +               vddaon-supply = <&vreg_s7b_0p9>;
> >> +               vddbtcxmx-supply = <&vreg_s7b_0p9>;
> >> +               vddrfacmn-supply = <&vreg_s7b_0p9>;
> >> +               vddrfa0p8-supply = <&vreg_s7b_0p9>;
> >> +               vddrfa1p7-supply = <&vreg_s1b_1p8>;
> >> +               vddrfa1p2-supply = <&vreg_s8b_1p2>;
> >> +               vddrfa2p2-supply = <&vreg_s1c_2p2>;
> >> +               vddasd-supply = <&vreg_l11c_2p8>;
> >> +               max-speed = <3200000>;
> >> +       };
> >>  };
> >>
> >>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
> >> @@ -504,6 +521,14 @@
> >>                  */
> >>                 bias-pull-up;
> >>         };
> >> +
> >> +       bt_en_default: bt_en_default {
> >
> > bt_en: bt-en {
> >
> > Node names shouldn't have underscores and 'default' is redundant.
> >
> [Bala]: will update in next patch.
>
> >> +               pins = "gpio85";
> >> +               function = "gpio";
> >> +               drive-strength = <2>;
> >> +               output-low;
> >> +               bias-pull-down;
> >
> > Why is there a pull down on an output gpio? Shouldn't this be
> > bias-disable?
> >
>
> [Bala]: BT_EN pin is OP of apps and input to BT SoC.
> by default we want the state of BT_EN to be low. so used pull down
> instead of bias-disable

The pin state will be low because of the 'output-low' property.

> as AFAIK bias-disable may trigger a tristate on BT_EN pin, which may
> trigger BT SoC enable
> if it is not actually triggered.

Is the pin ever "turned around" and made an input? If not then it will
be output and be driving low until the enable-gpios is set to output
active. The pull down is probably wasting power when the pin is being
driven either high or low.
