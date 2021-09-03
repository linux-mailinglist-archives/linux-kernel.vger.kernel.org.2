Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DEB3FF856
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 02:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhICAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 20:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbhICAVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 20:21:43 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7837C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 17:20:44 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so1093749ooe.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 17:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=KZY9HfqHiSoNHjeSLVuBihtvknh5wu9WNFSouW+rATM=;
        b=D0qjoQiNwAYpcfOgVhGLLMbD7hbXN3XvkTH9FnUwI0Q428HD4YkA8c3/Zla5grl9fu
         m/HDwft+OJzHFsdYOmCCIflhEYF9DGUQKAWkAhX6Md83y94zqL6lLdhu2sqv+fLOuepA
         q2KyEhBDfmYqZSRaJwY+uEzIECx14ek5INU1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=KZY9HfqHiSoNHjeSLVuBihtvknh5wu9WNFSouW+rATM=;
        b=rr4LBjbVfZX3DKFNoygeEGLKbRtD9QOllZK1ZK1SaegXpekay58FMjaeB6blCnWFIM
         pSgSfeEZAVX0ipBw/jou/zG5ZlCzdSQOEnqwIJ0KHRBamWyzBbEL9QIiZHawWu4lGC2i
         Z+KnbyedmsC7ibYMfUffILdkwX9ARsIX1hgP2BKGurc/IPYm6x6R4XzCZjPLwn5oIN1E
         FC0qFBx8d9vLns+uT+X20eUoN2VzM69289PO2fYPMnnn3ADpPC4HOWllYzg7DdqgMwH0
         ZsPCauUFj4SX6KIDIW5AZ7XAy9ufFxDIRy5vuxdHHmkiwTsiZh6x1miG46a56OfH8Gco
         1eeA==
X-Gm-Message-State: AOAM5328BMhiEadtgSk1DcizR8F886/y4/N/dl6a67jCTT9n86JaXX7s
        tVrrMgElaeNxUJQ11zZDimsqw+RH1tb1rNmm/UGu6Q==
X-Google-Smtp-Source: ABdhPJyoPheulxLZu0NElkoIkQ1VrzjxZsb0OAYE6ld1C+M37o2esEitl4dHPHp9WE5Yj6vxPUnnDaUDYMpe0PbZnIA=
X-Received: by 2002:a4a:a98c:: with SMTP id w12mr658431oom.29.1630628444025;
 Thu, 02 Sep 2021 17:20:44 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Sep 2021 17:20:43 -0700
MIME-Version: 1.0
In-Reply-To: <20210902154711.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
References: <20210902154711.1.I9777d0036ecbb749a4fb9ebb892f94c6e3a51772@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 2 Sep 2021 17:20:43 -0700
Message-ID: <CAE-0n51s1s6L7G1vxbC8PEZ=FBr9mSch81KUBO6fK_jfO8S_CQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180-trogdor: Delete ADC config for
 unused thermistors
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2021-09-02 15:47:44)
> The charger thermistor on Lazor, CoachZ rev1 and Pompom rev1+2 is
> either the wrong part or not stuffed at all, the same is true for
> the skin temperature thermistor on CoachZ rev1. The corresponding
> thermal zones are already disabled for these devices, in addition
> delete the ADC nodes of the thermistors.
>
> For Lazor and CoachZ rev1 also disable the PM6150 ADC thermal
> monitor since there are no other temperatures to monitor.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  .../arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi   | 10 ++++++++++
>  .../arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts |  8 ++++++++
>  .../arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dts |  8 ++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> index 21b516e0694a..edfcd47e1a00 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
> @@ -23,6 +23,18 @@ &charger_thermal {
>         status = "disabled";
>  };
>
> +&pm6150_adc {
> +       /delete-node/ skin-temp-thermistor@4e;
> +       /delete-node/ charger-thermistor@4f;

Is there any other child node? I only see two, unless I missed
something. In which case the whole node can be disabled?

> +};
> +
> +&pm6150_adc_tm {
> +       status = "disabled";
> +
> +       /delete-node/ charger-thermistor@0;
> +       /delete-node/ skin-temp-thermistor@1;
> +};
> +
>  /*
>   * CoachZ rev1 is stuffed with a 47k NTC as thermistor for skin temperature,
>   * which currently is not supported by the PM6150 ADC driver. Disable the
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> index 00535aaa43c9..57f7b19f83b0 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor.dtsi
> @@ -54,6 +54,16 @@ &panel {
>         compatible = "boe,nv133fhm-n62";
>  };
>
> +&pm6150_adc {
> +       /delete-node/ charger-thermistor@4f;

Same question here.

> +};
> +
> +&pm6150_adc_tm {
> +       status = "disabled";
> +
> +       /delete-node/ charger-thermistor@0;
> +};
> +
>  &trackpad {
>         interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
>  };
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> index e122a6b481ff..76a130bad60a 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dts
> @@ -26,6 +26,14 @@ &charger_thermal {
>         status = "disabled";
>  };
>
> +&pm6150_adc {
> +       /delete-node/ charger-thermistor@4f;

I see there's a 5v choke so this looks good as still enabled.

> +};
> +
> +&pm6150_adc_tm {
> +       /delete-node/ charger-thermistor@0;
> +};
> +
>  &pp3300_hub {
>         /* pp3300_l7c is used to power the USB hub */
>         /delete-property/regulator-always-on;
