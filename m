Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0B9326D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 16:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhB0PVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 10:21:19 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40753 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhB0PVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 10:21:17 -0500
Received: by mail-wr1-f51.google.com with SMTP id d11so11455390wrj.7;
        Sat, 27 Feb 2021 07:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yaNTFS+340Vt0SfHg02Hzl/o/FQqiqR0CoAa7HcgvLU=;
        b=qdWsqATM1vNAcWztxRuPmDXtUScQ+e3Vc+vp+hmBZEftcWQrpuYAuib6hqsjud8Mmi
         lP5LYN1Ka/ILmh5YgvZcaK211YIlPSGxQJxorfTxz+EZ403uwxXmWhKtfM2xJnHwCbb5
         Hh66ZYrOTwdyQDx8r7ALraUGil7KeZAlZGpkghesWPnMM1GNjAQK/1oXqrobgM/T1k1u
         u7n/TqfnnqgbbCPT7F2845WxsglCyB8tQlka0Q3WeUoXdREiRazR+JeyNetogbTAmKkf
         KTRiyYDWJFaS1AZTI3J18N93K/ZJbiafmQq29t2Qzz9aSVbOd8EZFWXjZ/sAMxze9Rxc
         GQxw==
X-Gm-Message-State: AOAM533B7m5ZQ2PXWzicWSSQi6V5eywuVdd4kxXIkxjuW9mrN9lgkiR9
        8sjFjDZRj/2t0bJ/8EGi9SfMbD6wcV4=
X-Google-Smtp-Source: ABdhPJw+jXTJvtD1JNUOXH8nWOaM5VP9UpZlWrMMltmabIvJ1wAP7XNUSVQ2g8rKv+YHaLZollruhw==
X-Received: by 2002:a5d:4fca:: with SMTP id h10mr8677873wrw.70.1614439234153;
        Sat, 27 Feb 2021 07:20:34 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id g11sm16366161wmk.32.2021.02.27.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 07:20:32 -0800 (PST)
Date:   Sat, 27 Feb 2021 16:20:31 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula@amarulasolutions.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matteo Lisi <matteo.lisi@engicam.com>
Subject: Re: [PATCH v4 3/5] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini
 C.TOUCH 2.0
Message-ID: <20210227152031.5ot5wrxvzfpo6vyo@kozik-lap>
References: <20210225192404.262453-1-jagan@amarulasolutions.com>
 <20210225192404.262453-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225192404.262453-4-jagan@amarulasolutions.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 12:54:02AM +0530, Jagan Teki wrote:
> Engicam C.TOUCH 2.0 is an EDIMM compliant general purpose Carrier
> board.
> 
> Genaral features:
> - Ethernet 10/100
> - Wifi/BT
> - USB Type A/OTG
> - Audio Out
> - CAN
> - LVDS panel connector
> 
> i.Core MX8M Mini is an EDIMM SoM based on NXP i.MX8M Mini from Engicam.
> 
> i.Core MX8M Mini needs to mount on top of this Carrier board for
> creating complete i.Core MX8M Mini C.TOUCH 2.0 board.
> 
> Add support for it.
> 
> Signed-off-by: Matteo Lisi <matteo.lisi@engicam.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +/* SD */
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>, <&pinctrl_usdhc1_gpio>;
> +	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +	max-frequency = <50000000>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	pm-ignore-notify;
> +	keep-power-in-suspend;
> +	status = "okay";
> +};
> -- 
> 2.25.1
> 
