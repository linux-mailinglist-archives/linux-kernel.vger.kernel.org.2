Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5A431F9D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 14:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhBSNV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 08:21:28 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:54530 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbhBSNV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 08:21:26 -0500
Received: by mail-wm1-f46.google.com with SMTP id w4so7052246wmi.4;
        Fri, 19 Feb 2021 05:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ITWbuXNEnjZRpnwZ0WX5RTZmfhRXkr5o6ssa0kN9juc=;
        b=gJbR2eMSWWaFwd8692O97XUZfcAH3Wdh/6cEctiaU4p7RM/HoKX61b+fja9z7Ce609
         Fvq86yHiTPgUp5N4/7yzJOn6ac2ehtbD8FD6OZJGmbpO8gWXfmziX5Ew2Jjl/fi5MZ/p
         lKuO0gF7oaNvljvk7TfWHIJnTYt74SpgaerQ5GVTLZ9NZsAZvbOkQj7uiPwgYqFqsk7r
         NgilpsLTCJnS2Vo67/03KJrXhanBL7VAQA+9GoHi7WRwgF/56g8IWjrchRhuPSghwRfZ
         WQuint+hFu2+qOukzjF/Kb98Nfx1gsLKel7b7luRU7JCFy1oxkwusf4Wars3NBmvWT0e
         b9CQ==
X-Gm-Message-State: AOAM530H6UHkR73CWrQ6kzTcHzVZO5z/HaONzAE+kQrb03lHwgY0fD3i
        ndEdHCrYt6fZ88zLI3IO08Q=
X-Google-Smtp-Source: ABdhPJxdcPsani8gb6Vv9rFL9xfxRBV4C06VQAFyqjr86dFk82wnw3pO6Pjd8D45OO1VhqIZgXyQbg==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr8480445wml.85.1613740844038;
        Fri, 19 Feb 2021 05:20:44 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id q140sm14917808wme.0.2021.02.19.05.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 05:20:43 -0800 (PST)
Date:   Fri, 19 Feb 2021 14:20:41 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] arm64: dts: imx8mm-nitrogen-r2: add UARTs
Message-ID: <20210219132041.pdkyg63iw5apmgf5@kozik-lap>
References: <20210217161052.877877-1-adrien.grassein@gmail.com>
 <20210217161052.877877-5-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210217161052.877877-5-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 05:10:48PM +0100, Adrien Grassein wrote:
> Add description and pin muxing for UARTs.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 50 ++++++++++++++++++-
>  1 file changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> index c4bb22bb4e6a..8f210e21a1bd 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
> @@ -205,12 +205,33 @@ rtc@68 {
>  	};
>  };
>  
> +/* BT */
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
>  /* console */
>  &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart2>;
> -	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
> -	assigned-clock-parents = <&clk IMX8MM_CLK_24M>;

This is a separate patch.

Best regards,
Krzysztof
