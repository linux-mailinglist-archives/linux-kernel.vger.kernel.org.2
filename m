Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9232A893
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351917AbhCBRuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 12:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574432AbhCBPQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 10:16:43 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBEC0617AB;
        Tue,  2 Mar 2021 06:43:37 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f1so31668460lfu.3;
        Tue, 02 Mar 2021 06:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ehMk768PgaHXNDKEGxlTJz4HCadGsVKT4y8Pam5y8jk=;
        b=Cak8Jo5viyKK52oOim0l23vqCN/enz9J0cwGAAUInxi1rHEVBI0dAVlJK/O6sqsR3W
         vUZrISwpO6Kh57vR5nu1ZgeGsosQUXKiVHJFptxGlO1nY4VZsAveEJ5c+F1dwtUkCXwt
         zFWp+s1woKTPqyH6AHkjvFODPnd4V4AhhtBQ0PkfMZW5n3Q1l1kKI+hK5gDZ6jfXov+c
         MhKLiIfuCKiDMehNP/x9RkkbIvaHI1GcHP+ojdHO1jBLQ3N9++o82pQiCzyqJxj5BuAo
         3TLSGEnvD8wdFv0osE93KeHWNlPg7HFkv8fuCQk1HCPExSp0wW6uQfjp6t8gzG24oa5/
         KkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ehMk768PgaHXNDKEGxlTJz4HCadGsVKT4y8Pam5y8jk=;
        b=Z+E/77XmC9I8XgEcxB+F15GEpLX5E5m2jbgujdF0/7GHH76OZ1thrHfv6EHXQS0eSm
         wTGWoAm21PjKTSMFjLpGo3hgvhpv67OUTEa+4KIil/ryijH2saKj2i75Gf35kiqTJOWA
         qaRq3MWvans/yFmG0WPzJIs5IC9PMsxpAppkzk12RIkcgdAvpOUunltvxLZmv55qhJYg
         lMRnYXVOMg5vJbvDqVqE12fpnKD0ggEBeY5w2fgCGKxF5LvVxbOaHksWBRezbg+YehRW
         +7YCrBElJOzjpL0ThVQJe7I1bnrGeHtzS5eYIbPDjDBnKkJMRpGu6R9o1Wu8Y4xUO3dt
         x5Xg==
X-Gm-Message-State: AOAM533bExp2NylD6QSrxJduqQZJ60i/MBoHXVMYjFUjq6UJBxZTK4Rx
        bdFGgDio2Mq3wHwVR37cLO0PW4LlyhVTK6M3Ssc=
X-Google-Smtp-Source: ABdhPJzRI6Lp0cn6FbNf1ROo1ggRWQL+ogHxDx2OVGLxaKVt2gd8s0BKD4GnCwZMyEZvXDjvmnKudQ4aLaQ/9yR4t4Q=
X-Received: by 2002:a05:6512:b0d:: with SMTP id w13mr8351771lfu.500.1614696215995;
 Tue, 02 Mar 2021 06:43:35 -0800 (PST)
MIME-Version: 1.0
References: <20210222140756.713-1-heiko.thiery@gmail.com> <20210222140756.713-3-heiko.thiery@gmail.com>
In-Reply-To: <20210222140756.713-3-heiko.thiery@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 2 Mar 2021 11:43:24 -0300
Message-ID: <CAOMZO5C4bL72mksHG4GfikgLOxib-A659rac7VkpjGsm150O_A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: fsl: add support for Kontron
 pitx-imx8m board
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Feb 22, 2021 at 11:08 AM Heiko Thiery <heiko.thiery@gmail.com> wrote:

> +       reg_usdhc2_vmmc: regulator-v-3v3-sd {

reg_usdhc2_vmmc: regulator-usdhc2-vmmc {

> +       tpm_reset: tpm-reset {
> +               compatible = "gpio-reset";

I don't see this compatible string documented.

> +               reset-gpios = <&gpio3 2 GPIO_ACTIVE_LOW>;
> +               reset-delay-us = <2>;
> +               reset-post-delay-ms = <60>;
> +               #reset-cells = <0>;
> +       };
> +
> +       usb_hub_reset: usb-hub-reset {
> +               compatible = "gpio-reset";

Same here.

> +&fec1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_fec1>;
> +       phy-mode = "rgmii-id";
> +       phy-handle = <&ethphy0>;
> +       phy-reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;

This property is deprecated. Please consider using reset-gpios inside
ethernet-phy instead.

> +       /* TODO: configure audio, as of now just put a placeholder */
> +       wm8904: audio-codec@1a {
> +               compatible = "wlf,wm8904";
> +               reg = <0x1a>;
> +               clocks = <&clk IMX8MQ_CLK_SAI2_ROOT>;
> +               clock-names = "mclk";
> +               clock-frequency = <24000000>;

Not a valid property.

> +/* M.2 B-key slot */
> +&pcie0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pcie0>;
> +       disable-gpio = <&gpio5 29 GPIO_ACTIVE_LOW>;

Not a valid property.

> +       reset-gpio = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +       clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
> +                <&clk IMX8MQ_CLK_PCIE1_AUX>,
> +                <&clk IMX8MQ_CLK_PCIE1_PHY>,
> +                <&pcie0_refclk>;
> +       clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +       ext_osc = <1>;

Not a valid property.

> +/* Intel Ethernet Controller I210/I211 */
> +&pcie1 {
> +       clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
> +                <&clk IMX8MQ_CLK_PCIE2_AUX>,
> +                <&clk IMX8MQ_CLK_PCIE2_PHY>,
> +                <&pcie1_refclk>;
> +       clock-names = "pcie", "pcie_aux", "pcie_phy", "pcie_bus";
> +       ext_osc = <1>;

Not a valid property.
