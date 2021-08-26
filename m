Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8783F8D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243257AbhHZSDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhHZSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:03:05 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A0C061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:02:18 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id p2so6100218oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=gM9UQ3luKM6FWAIK1n04nas0tD0/piW22rsZNRbG95w=;
        b=Yk9wa7PsI1JDzYJznsmi4lULZ30TTgiB5q3tk0Fr9+WQwYSGJYrt+DhQvZedn3m6RN
         C4rluFHGyIkD6BcpydfDdTh6L0ZffXZSvyv+RRzlkzFweIMvhXBJLbkvPuWaulAGgC3B
         DvixDneV1mp5EKYptJdXgu/8uL3E8GACmkw5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=gM9UQ3luKM6FWAIK1n04nas0tD0/piW22rsZNRbG95w=;
        b=cEovS2Tb+l5omkuT16bUCBAL1Px5P27AYe4QmstzrYEec6X+JesKfSFWNHfKL+msST
         0WGuW9iZeiu67UMcxOtxWmbBK6dR7sO1bOxpHQOgHrUbPynZ3P3zH/77YXunzYtbwwBY
         fzKKPBLqT+EHsS/aPPztqx0MahEzNCAqtbqmBGlVDmw/qIFLIS15rsYkbxg911z6zIFu
         9hKMc74iZy89ftZHEs7yjfZshOhXKThLGRja1R5c6pEbqEl1A3KPwGINFQkaM1+F/IO1
         5Qz+qtwRWO/C0eYpRV2J35NGAko0lACJN3l7WFXCXD8xpR+lT6MY5U1OOByI5lPX1+dm
         qnkA==
X-Gm-Message-State: AOAM530pH8IDPTzP1ubQ5OWIZwNY+XhhHXrVv6KK9g9Q5LvwJIX4jgtW
        q5jIW9QGNZIASKK9cv6nc1AwuG5hPeOuBClh8X9EUA==
X-Google-Smtp-Source: ABdhPJyNJiCTp6DQlklvNtQfWWztXYaKjt4Mbg9yx82+lZscI2OatspIL//FZ/NEC2rvIE1wyzT3pLaAogdTxObMVpY=
X-Received: by 2002:a54:468d:: with SMTP id k13mr12007332oic.125.1630000937901;
 Thu, 26 Aug 2021 11:02:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Aug 2021 18:02:17 +0000
MIME-Version: 1.0
In-Reply-To: <1629983731-10595-2-git-send-email-rajpat@codeaurora.org>
References: <1629983731-10595-1-git-send-email-rajpat@codeaurora.org> <1629983731-10595-2-git-send-email-rajpat@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 26 Aug 2021 18:02:17 +0000
Message-ID: <CAE-0n50-9df1riEwcbbS9Dxd5WhKFBKqXAHu-bkwdP4z1NKTWA@mail.gmail.com>
Subject: Re: [PATCH V6 1/7] arm64: dts: sc7280: Add QSPI node
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

Can you please Cc folks who have reviewed prior series when you send
again?

Quoting Rajesh Patil (2021-08-26 06:15:25)
> From: Roja Rani Yarubandi <rojay@codeaurora.org>
>
> Add QSPI DT node and qspi_opp_table for SC7280 SoC.

Might be worth adding here that we put the opp table in / because SPI
nodes assume any child node is a spi device and so we can't put the
table underneath the spi controller.

>
> Signed-off-by: Roja Rani Yarubandi <rojay@codeaurora.org>
> Signed-off-by: Rajesh Patil <rajpat@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 62 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 53a21d0..f8dd5ff 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1318,6 +1337,24 @@
>                         };
>                 };
>
> +               qspi: spi@88dc000 {
> +                       compatible = "qcom,qspi-v1";
> +                       reg = <0 0x088dc000 0 0x1000>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +                                <&gcc GCC_QSPI_CORE_CLK>;
> +                       clock-names = "iface", "core";
> +                       interconnects = <&gem_noc MASTER_APPSS_PROC 0
> +                                       &cnoc2 SLAVE_QSPI_0 0>;
> +                       interconnect-names = "qspi-config";
> +                       power-domains = <&rpmhpd SC7280_CX>;
> +                       operating-points-v2 = <&qspi_opp_table>;
> +                       status = "disabled";
> +

Nitpick: Drop newline above.

> +               };
> +
>                 dc_noc: interconnect@90e0000 {
>                         reg = <0 0x090e0000 0 0x5080>;
>                         compatible = "qcom,sc7280-dc-noc";
