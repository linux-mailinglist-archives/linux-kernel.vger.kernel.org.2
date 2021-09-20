Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A4412A75
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhIUBl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbhIUBjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:05 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A0C01AE48
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:37:04 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 67-20020a9d0449000000b00546e5a8062aso13047019otc.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Zsrlsd+FYG22wak0fSNc9tYLdNOZQjnNOfw0BjN2gWI=;
        b=C6jBCxJuR5p9hjcAyOzJ10X1JxfuXVcVcIed41n30NVMz+CAEF+amueSIPWlVngxOl
         9/H0nsuAY/V1ne5wLyLYeM07rRsBvbMSjAHlZ2BlAsRXm5Sh+lyqKow+wvoAi6mdKfPA
         nqdkWbDDeVskdzARIrLtJOy+96E7DZdp2V570=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Zsrlsd+FYG22wak0fSNc9tYLdNOZQjnNOfw0BjN2gWI=;
        b=z/6OwYwj56BjM/7e7EEUViV/nQue3fdBNx0FxgxHGWx9LWLe4Poo5XW6BVMTXSpMY0
         gg+RE3+691v0lNEMSOl5vPuaApvWaVB2qkLhztw9n2WdRyHjgQeS0yn24/GUo0qjTnJv
         NmdNL0inyaicysyWketakSSvBsjShmYZsJZ3K4oR09Qrd67dAcZxzDIwF2E+7Z8A2NIg
         gxGJgEN7IYYtSwZHOjnEz75A3A3c5wMxEYdwn5lUNbeHUpRkSoVPMJA5FNqv2lS2JXo4
         dU0KZB8W3iZPlIhYSU2ux6KPQmHExKdw456E294HHK2dUSLMQc4rEYV+bRBVcNBiKe2e
         YYuQ==
X-Gm-Message-State: AOAM531Hznbmu1L809VAzj5wwHqEnT0E1Ge5+gNWkBg4caWao8Wxb4eL
        5EZCh1f9ZbxzDfy15JVJPWZjVCxklr90U/OxlG6ZWQ==
X-Google-Smtp-Source: ABdhPJwnFR6SOnH84wihZZfbfEvXF/mSh/RHHBaMrdPVwNokuSmK/intbopTA06gDnMPTgyHG0pm8TCjSRegHDJP+l0=
X-Received: by 2002:a05:6830:1212:: with SMTP id r18mr21352018otp.159.1632166623978;
 Mon, 20 Sep 2021 12:37:03 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Sep 2021 12:37:03 -0700
MIME-Version: 1.0
In-Reply-To: <1631875538-22473-5-git-send-email-skakit@codeaurora.org>
References: <1631875538-22473-1-git-send-email-skakit@codeaurora.org> <1631875538-22473-5-git-send-email-skakit@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Mon, 20 Sep 2021 12:37:03 -0700
Message-ID: <CAE-0n53rto=_+9qtc0RL0tkDwBkd9HJL26TQV-m6Q8myiNSCVA@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7280: Add pm8008 regulators
 support for sc7280-idp
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <skakit@codeaurora.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mka@chromium.org,
        Das Srinagesh <gurus@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>, kgunda@codeaurora.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2021-09-17 03:45:38)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 52638e2..3b3af49 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -207,6 +207,97 @@
>         };
>  };
>
> +&i2c1 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       status = "okay";
> +
> +       pm8008_chip: pm8008@8 {
> +               compatible = "qcom,pm8008";
> +               reg = <0x8>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pm8008_active>;
> +       };
> +
> +       pm8008_ldo: pm8008@9 {
[...]
> +
> +                       pm8008_l7: regulator@4600 {
> +                               reg = <0x4600>;
> +                               regulator-name = "pm8008_l7";
> +                               regulator-min-microvolt = <3000000>;
> +                               regulator-max-microvolt = <3544000>;
> +                               qcom,min-dropout-voltage = <96000>;

Is this headroom? Is it actually configurable or is it merely a property
of the hardware? If it's the latter then it should be in the driver and
not in the DTS.

> +                       };
> +               };
> +       };
> +};
> +
>  &qfprom {
>         vcc-supply = <&vreg_l1c_1p8>;
>  };
> @@ -313,6 +404,18 @@
>
>  /* PINCTRL - additions to nodes defined in sc7280.dtsi */
>
> +&pm8350c_gpios {
> +       pm8008_reset {

Is this a pinctrl node?

> +               pm8008_active: pm8008_active {

Please use dashes in node names wherever an underscore goes.

> +                       pins = "gpio4";
> +                       function = "normal";
> +                       bias-disable;
> +                       output-high;
> +                       power-source = <0>;
> +               };
> +       };
> +};
