Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856AF3F8D94
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243265AbhHZSHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbhHZSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:07:47 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42233C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:07:00 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso4668212ots.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=iDcfALxS7ByXsLTcygSiTE5KZoBVvL1dJ5SQ9WFxeXw=;
        b=KP/AXzf4Kf8O33BenwJXPa4AGRe8qX8UGMH7hQ3lCQPmHBtfgqoF81Vdxp9GuRKmVt
         JCpHzaf1Je60ZFI5ErVxgtdT5dE6eWyTGG0A6N+Sy7CYKaa0TewR+HJ8PbO+F3udo5Ow
         +Ngrg1UV7K5orFGM2iZesofpa9DEdzgHna9Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=iDcfALxS7ByXsLTcygSiTE5KZoBVvL1dJ5SQ9WFxeXw=;
        b=LrL+UBDcz3YEwHfM0TOjIMoQ83Ngfa2gRR8R+7nEoU88/JzObikCwKujiRJYbAicX9
         jK3fHpUDgDd39wdWOM20u51T32uRlCXe7P+A5nZfPt4jCXC5xhse53o6iFi+abANNkBC
         h/4cgoz+eCJ+KoZ1ojqQVHmeO0d1lBv7Z63qdXZe1MgbF/JmwSXZwlWChAEoGBLvqLjd
         4kjvtgQXh5ZT9kuA/x78jNHAdzNqbfbR+qHtJPgNBto0aD8J7gSy+uF3ussL73fF/mUd
         ETgIPBhOVXK/pNSZRE6GayT8rmqfPBCFVcC9jmAko17A/06zWiE5Q9ZXdm/yVwixxB8k
         qnkA==
X-Gm-Message-State: AOAM533PbMqbKmpJ955hpz7fXnPZkD0EK0jEJJgKJBntRvdjO+CSc6/z
        xp3ZYlEa9iPRnugYFRp3PzZEfz9Xv9UL1sK569Mg9uXFc3o=
X-Google-Smtp-Source: ABdhPJxxPrSqGTyaYVZpZnL5e+CzVpcreV6iVDVWMMVq5TCa7ulq66CSbIOHcde0IJi3HPymgMPyxeruGoRPTZwp//k=
X-Received: by 2002:a05:6830:2b24:: with SMTP id l36mr4344238otv.25.1630001219637;
 Thu, 26 Aug 2021 11:06:59 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 18:06:59 +0000
MIME-Version: 1.0
In-Reply-To: <1629983731-10595-4-git-send-email-rajpat@codeaurora.org>
References: <1629983731-10595-1-git-send-email-rajpat@codeaurora.org> <1629983731-10595-4-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 18:06:59 +0000
Message-ID: <CAE-0n51BUENLOP2vxg+HTfNyGZ9216tTpSQQot9_aZvJW_s-Ow@mail.gmail.com>
Subject: Re: [PATCH V6 3/7] arm64: dts: sc7280: Add QUPv3 wrapper_0 nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajesh Patil <rajpat@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, msavaliy@qti.qualcomm.com,
        skakit@codeaurora.org, Roja Rani Yarubandi <rojay@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajesh Patil (2021-08-26 06:15:27)
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index f8dd5ff..da3cf19 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -434,6 +434,25 @@
>                 };
>         };
>
> +       qup_opp_table: qup-opp-table {

Surely this could be placed under /soc@0/geniqup@9c0000 alongside the
other devices and the node name could be opp-table?

> +               compatible = "operating-points-v2";
> +
> +               opp-75000000 {
> +                       opp-hz = /bits/ 64 <75000000>;
> +                       required-opps = <&rpmhpd_opp_low_svs>;
> +               };
> +
> +               opp-100000000 {
> +                       opp-hz = /bits/ 64 <100000000>;
> +                       required-opps = <&rpmhpd_opp_svs>;
> +               };
> +
> +               opp-128000000 {
> +                       opp-hz = /bits/ 64 <128000000>;
> +                       required-opps = <&rpmhpd_opp_nom>;
> +               };
> +       };
> +
>         soc: soc@0 {
>                 #address-cells = <2>;
>                 #size-cells = <2>;
> @@ -536,24 +555,425 @@
>                 qupv3_id_0: geniqup@9c0000 {
>                         compatible = "qcom,geni-se-qup";
>                         reg = <0 0x009c0000 0 0x2000>;
> -                       clock-names = "m-ahb", "s-ahb";
>                         clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
>                                  <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> +                       clock-names = "m-ahb", "s-ahb";
>                         #address-cells = <2>;
>                         #size-cells = <2>;
>                         ranges;
> +                       iommus = <&apps_smmu 0x123 0x0>;
>                         status = "disabled";
>
[...]
> @@ -1575,11 +1995,311 @@
>                                 function = "qspi_data";
>                         };
>
> +                       qup_i2c0_data_clk:qup-i2c0-data-clk {

Please unstick the colon from the node name.

	qup_i2c0_data_clk: qup-i2c0-data-clk {

	};

> +                               pins = "gpio0", "gpio1";
> +                               function = "qup00";
> +                       };
> +
> +                       qup_i2c1_data_clk:qup-i2c1-data-clk {
> +                               pins = "gpio4", "gpio5";
> +                               function = "qup01";
> +                       };
> +
> +                       qup_i2c2_data_clk:qup-i2c2-data-clk {
> +                               pins = "gpio8", "gpio9";
> +                               function = "qup02";
> +                       };
> +
> +                       qup_i2c3_data_clk:qup-i2c3-data-clk {
> +                               pins = "gpio12", "gpio13";
> +                               function = "qup03";
> +                       };
> +
> +                       qup_i2c4_data_clk:qup-i2c4-data-clk {
> +                               pins = "gpio16", "gpio17";
> +                               function = "qup04";
> +                       };
> +
> +                       qup_i2c5_data_clk:qup-i2c5-data-clk {
> +                               pins = "gpio20", "gpio21";
> +                               function = "qup05";
> +                       };
> +
> +                       qup_i2c6_data_clk:qup-i2c6-data-clk {
> +                               pins = "gpio24", "gpio25";
> +                               function = "qup06";
> +                       };
> +
> +                       qup_i2c7_data_clk:qup-i2c7-data-clk {
> +                               pins = "gpio28", "gpio29";
> +                               function = "qup07";
> +                       };
> +

For all of these.
