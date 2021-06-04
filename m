Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F106239C2A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhFDVmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhFDVm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:42:27 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4616CC061767
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 14:40:32 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso10419084otl.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=BpMcjydtHCRL730GVRWjY//UbSmPvtwxP7/K1Agu+es=;
        b=UxKRPxOAnoysgy7It+V1V2RJRi777Ms5P8JtBDsykQRSfMlkL94+Am4b2Wi7wnGkbT
         skxXt4KIsARqkX8dVSp/LrvnbDOfVUrWcbwIR8+yDnC5s0S5qmaJgUNMwegjjXLO1isR
         XTqTRAsAdZitbd6GkHMBT37ZbIfixWzCHhtqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=BpMcjydtHCRL730GVRWjY//UbSmPvtwxP7/K1Agu+es=;
        b=mHUfqzMMtH1Ljbh4Ij1yn/y7XDxjyoTPRdBgVwRlLj06H30Tca8MgEqhhAy9jQLIag
         BcW7zcGzNKYNV44pOKAk6nmsuvIFCe7cuEbc6N0XNc1SHBiHGd75gxtg0XWMfp72nq01
         dEs63QfjrKfLJSqJjJ6tXQdQHSkLsvEvhCCLVJwOVtQsdv/r5XxaZ5AdM7JHOV+EAx0P
         h4nw1qAaYjITgZ49VWyuZZEQQXTN6reWy8SahOdeLPKDfVoy2YBcr8uoBOaDXdnEYHS7
         NQfDQnpJHNRqhtMo6A+XAZIR0XvPvkRhkDdV1XsGJKi5n6C0Q8eHITak7ZH84Lq6oa7q
         3m9g==
X-Gm-Message-State: AOAM531buhsce+dxdcxi6JFuX+enmeU3r6VDc540xo61Y8kJRz1JT3vJ
        9m+RK2hr9iFSCF/7hQIKrA9is+C8bT7q2n3TUAQASA==
X-Google-Smtp-Source: ABdhPJxoE4JA5ILCRd7HRVnYqwxGrlvLKLv96Ivb5McvBbqSIznJP5Cl3i+9rnvbOKiRr7OD+jsQ0AhuqFlu/Gzkii0=
X-Received: by 2002:a05:6830:3154:: with SMTP id c20mr5408138ots.233.1622842831621;
 Fri, 04 Jun 2021 14:40:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Jun 2021 21:40:31 +0000
MIME-Version: 1.0
In-Reply-To: <1622804618-18480-2-git-send-email-sanm@codeaurora.org>
References: <1622804618-18480-1-git-send-email-sanm@codeaurora.org> <1622804618-18480-2-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 4 Jun 2021 21:40:31 +0000
Message-ID: <CAE-0n52CK3wk+xtaB8yaVV3kJiL=dgi2z9TsxQ7_2t_tdjuBBA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm64: dts: qcom: sc7280: Add USB related nodes
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2021-06-04 04:03:37)
> Add nodes for DWC3 USB controller, QMP and HS USB PHYs in sc7280 SOC.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> changed usb3-phy to lanes in qmp phy node as it was causing probe failure.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 149 +++++++++++++++++++++++++++++++++++
>  1 file changed, 149 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0b6f119..d70d5fb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -973,6 +973,110 @@
>                         };
>                 };
>
> +               usb_1_hsphy: phy@88e3000 {
> +                       compatible = "qcom,sc7280-usb-hs-phy",
> +                                    "qcom,usb-snps-hs-7nm-phy";
> +                       reg = <0 0x088e3000 0 0x400>;
> +                       status = "disabled";
> +                       #phy-cells = <0>;
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "ref";
> +
> +                       resets = <&gcc GCC_QUSB2PHY_PRIM_BCR>;
> +               };
> +
> +               usb_2_hsphy: phy@88e4000 {
> +                       compatible = "qcom,sc7280-usb-hs-phy",
> +                                    "qcom,usb-snps-hs-7nm-phy";
> +                       reg = <0 0x088e4000 0 0x400>;
> +                       status = "disabled";
> +                       #phy-cells = <0>;
> +
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>;
> +                       clock-names = "ref";
> +
> +                       resets = <&gcc GCC_QUSB2PHY_SEC_BCR>;
> +               };
> +
> +               usb_1_qmpphy: phy-wrapper@88e9000 {
> +                       compatible = "qcom,sm8250-qmp-usb3-phy";

Is this another combo usb/dp phy?

> +                       reg = <0 0x088e9000 0 0x200>,
> +                             <0 0x088e8000 0 0x20>;
> +                       reg-names = "reg-base", "dp_com";
> +                       status = "disabled";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +
> +                       clocks = <&gcc GCC_USB3_PRIM_PHY_AUX_CLK>,
> +                                <&rpmhcc RPMH_CXO_CLK>,
> +                                <&gcc GCC_USB3_PRIM_PHY_COM_AUX_CLK>;
> +                       clock-names = "aux", "ref_clk_src", "com_aux";
> +
> +                       resets = <&gcc GCC_USB3_DP_PHY_PRIM_BCR>,

This makes me think yes. In which case, can we put the final node in
place instead of having to tack on DP phy at a later time?

> +                                <&gcc GCC_USB3_PHY_PRIM_BCR>;
> +                       reset-names = "phy", "common";
> +
> +                       usb_1_ssphy: lanes@88e9200 {

phy@88e9200?

> +                               reg = <0 0x088e9200 0 0x200>,
> +                                     <0 0x088e9400 0 0x200>,
> +                                     <0 0x088e9c00 0 0x400>,
> +                                     <0 0x088e9600 0 0x200>,
> +                                     <0 0x088e9800 0 0x200>,
> +                                     <0 0x088e9a00 0 0x100>;
> +                               #phy-cells = <0>;
> +                               #clock-cells = <1>;
> +                               clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
> +                               clock-names = "pipe0";
> +                               clock-output-names = "usb3_phy_pipe_clk_src";
> +                       };
> +               };
> +
