Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342AF3EF2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhHQT7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:59:28 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32BC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:58:55 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id b25-20020a4ac2990000b0290263aab95660so6231819ooq.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=79bivVt5C0iretm2RQAebwVshGza8l6WOkdkf2Tm6mk=;
        b=lPok6EhnosdIo1UrT0ck8CSjE0cGZvczyyWe/VT8d9qyyCiDSlpELBtSI9tXeNHlRy
         6883bonW9Jgs+OlxPI8JwC6Gh6YR8OHQOrecbAcNYEJ2ZI1sgGysSaKGkyIZ2vWsDD0t
         wwU0NYvrsvkx45/9BYSeqndn6tbuz4fjy6lCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=79bivVt5C0iretm2RQAebwVshGza8l6WOkdkf2Tm6mk=;
        b=sZu4ePPdIUJNj2jZGGl5ZJtEjkvXzR7iAlb2+/OVvd/YZdMEL933W7pMRmFJe8Xrgq
         lc1KPz5NMfbSczWqb3v1bFyBDN2u8YvE40NIsh3cto6/Fi0xNY0Rd7JZCJbUdwOvqLJz
         k8XNBIZtb9becNSDQYZVyR9kjFYoNjiTL51FSbPxtBb7HbCLbgbaVc5rT9Z7dbqJClOu
         qReJr1g7OrZXxKMrYyF4tRyzG6ntOj+ZZ7rD6jMT4xw2QEaax3IYJEjPyTEpzj3SHnFJ
         /r/O9hGH0ddwkouVN/1h6cxUfyTl5+g5iZsy88kxnUJ7rylQBF1JvlO4HI3UYqY/Oznz
         jdvQ==
X-Gm-Message-State: AOAM530E/gU64W9GGEgiDudmI1I+peAqyNvbvfdV0XM5I60yBDE1/r/J
        VZGwsMavWuwzKyh418fdO+gItFchGwvXZbHv+XNWgg==
X-Google-Smtp-Source: ABdhPJwt0EHKR2+b1AuRlsdVymYYGJh3wAbYghf4FpRsgsDEpEnaY/lC83xDjKek1m8USwAknSR098PzcIloPu3fBZ0=
X-Received: by 2002:a4a:c60e:: with SMTP id l14mr3855016ooq.80.1629230334756;
 Tue, 17 Aug 2021 12:58:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Aug 2021 15:58:54 -0400
MIME-Version: 1.0
In-Reply-To: <1625576413-12324-3-git-send-email-sanm@codeaurora.org>
References: <1625576413-12324-1-git-send-email-sanm@codeaurora.org> <1625576413-12324-3-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Tue, 17 Aug 2021 15:58:54 -0400
Message-ID: <CAE-0n52d7UOWQ+hohoyV81+aB1RnNPUEnjPCtr5=nH+a=WK35Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] arm64: dts: qcom: sc7280: Add USB related nodes
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
        Pratham Pratap <prathampratap@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2021-07-06 06:00:12)
> Add nodes for DWC3 USB controller, QMP and HS USB PHYs in sc7280 SOC.
>
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changed qmp usb phy to usb dp phy combo node as per Stephen's comments.
> Changed dwc to usb and added SC7280 compatible as per Bjorn's comments.
>
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index a8c274a..cd6908f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -1035,6 +1035,125 @@
>                         };
>                 };
>
[...]
> +
> +               usb_2: usb@8cf8800 {
> +                       compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
> +                       reg = <0 0x08cf8800 0 0x400>;
> +                       status = "disabled";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +                       dma-ranges;
> +
> +                       clocks = <&gcc GCC_CFG_NOC_USB3_SEC_AXI_CLK>,
> +                                <&gcc GCC_USB30_SEC_MASTER_CLK>,
> +                                <&gcc GCC_AGGRE_USB3_SEC_AXI_CLK>,
> +                                <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +                                <&gcc GCC_USB30_SEC_SLEEP_CLK>;
> +                       clock-names = "cfg_noc", "core", "iface","mock_utmi",
> +                                     "sleep";
> +
> +                       assigned-clocks = <&gcc GCC_USB30_SEC_MOCK_UTMI_CLK>,
> +                                         <&gcc GCC_USB30_SEC_MASTER_CLK>;
> +                       assigned-clock-rates = <19200000>, <200000000>;
> +
> +                       interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <&pdc 13 IRQ_TYPE_EDGE_RISING>,
> +                                    <&pdc 12 IRQ_TYPE_EDGE_RISING>;

I'm seeing this cause a warning at boot

[    4.724756] irq: type mismatch, failed to map hwirq-12 for
interrupt-controller@b220000!
[    4.733401] irq: type mismatch, failed to map hwirq-13 for
interrupt-controller@b220000!

> +                       interrupt-names = "hs_phy_irq",
> +                                         "dm_hs_phy_irq", "dp_hs_phy_irq";
> +
> +                       power-domains = <&gcc GCC_USB30_SEC_GDSC>;
> +
> +                       resets = <&gcc GCC_USB30_SEC_BCR>;
> +
> +                       usb_2_dwc3: usb@8c00000 {
> +                               compatible = "snps,dwc3";
> +                               reg = <0 0x08c00000 0 0xe000>;
> +                               interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
> +                               iommus = <&apps_smmu 0xa0 0x0>;
> +                               snps,dis_u2_susphy_quirk;
> +                               snps,dis_enblslpm_quirk;
> +                               phys = <&usb_2_hsphy>;
> +                               phy-names = "usb2-phy";
> +                               maximum-speed = "high-speed";
> +                       };
> +               };
> +
>                 dc_noc: interconnect@90e0000 {
>                         reg = <0 0x090e0000 0 0x5080>;
>                         compatible = "qcom,sc7280-dc-noc";
> @@ -1063,6 +1182,51 @@
>                         qcom,bcm-voters = <&apps_bcm_voter>;
>                 };
>
> +               usb_1: usb@a6f8800 {
> +                       compatible = "qcom,sc7280-dwc3", "qcom,dwc3";
> +                       reg = <0 0x0a6f8800 0 0x400>;
> +                       status = "disabled";
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       ranges;
> +                       dma-ranges;
> +
> +                       clocks = <&gcc GCC_CFG_NOC_USB3_PRIM_AXI_CLK>,
> +                                <&gcc GCC_USB30_PRIM_MASTER_CLK>,
> +                                <&gcc GCC_AGGRE_USB3_PRIM_AXI_CLK>,
> +                                <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +                                <&gcc GCC_USB30_PRIM_SLEEP_CLK>;
> +                       clock-names = "cfg_noc", "core", "iface", "mock_utmi",
> +                                     "sleep";
> +
> +                       assigned-clocks = <&gcc GCC_USB30_PRIM_MOCK_UTMI_CLK>,
> +                                         <&gcc GCC_USB30_PRIM_MASTER_CLK>;
> +                       assigned-clock-rates = <19200000>, <200000000>;
> +
> +                       interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
> +                                             <&pdc 14 IRQ_TYPE_EDGE_BOTH>,
> +                                             <&pdc 15 IRQ_TYPE_EDGE_BOTH>,

And this one too.

[    4.898667] irq: type mismatch, failed to map hwirq-14 for
interrupt-controller@b220000!
[    4.907241] irq: type mismatch, failed to map hwirq-15 for
interrupt-controller@b220000!

which looks like genirq code is complaining that the type is different
than what it is configured for. Are these trigger flags correct? If so,
then there' some sort of bug in the pdc driver.

> +                                             <&pdc 17 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupt-names = "hs_phy_irq", "dp_hs_phy_irq",
> +                                         "dm_hs_phy_irq", "ss_phy_irq";
> +
> +                       power-domains = <&gcc GCC_USB30_PRIM_GDSC>;
> +
> +                       resets = <&gcc GCC_USB30_PRIM_BCR>;
> +
> +                       usb_1_dwc3: usb@a600000 {
