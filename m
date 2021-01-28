Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A7D30771C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 14:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbhA1Nbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 08:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhA1Nb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 08:31:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A893C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:30:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so4589155wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boundarydevices.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=94FMt5sdOQuvuur1w1p4IxKcptSx9rGgTLf5Xxc88cE=;
        b=Tg1GhLVbO1HpM1UYAbNZrOTCbj57bouBNfEz7xkktaLQisi+PU6CVuJq5A6s8XixsY
         eSZ28Z+P/1dXc7FwrT6Fa1rQDa7f9xyrHRzZlV4fluStCiEOr3Cv2ulVFTIUqgCeLsHH
         Q9/ou1cTESQTHEpZGKDV1upPCsi+F0SzfpKL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=94FMt5sdOQuvuur1w1p4IxKcptSx9rGgTLf5Xxc88cE=;
        b=LcF6vKPzWoHAbj3OvIqEP+BlloOHs+NV7N1qKMRM0Bn9Z9Qx02m/yaHdgDMzFVk9u3
         oRtZPVTktsxN6VBPLJAIDgaV7z0UB+PycP8XjxhYXhoqgRc2XSDjHJ2Yh2UNTCPVX1+S
         0bFbte6wFq6zPwOuQ+J3CspGJEvvMyLQM9rzsFl0Szch8cTCbcQNprGV458HKC1ybD+y
         QQFNCL1ILhS8YN3Bna9cvlxiZcrlBIgNozbdnrfZMzM5mDJ6C3/f+S6eoaiRs496V0vb
         Qxrk+9eSnNmSiD8q69O6ENXqfy0lTU1eOwt+hSROkIUreNzANWnonYUHPWnMvAGMd5Q7
         UIqw==
X-Gm-Message-State: AOAM533WEsFIrqXcNKcsUen3dmHyzTw0Yb9YmOg8FH1PhoHiGUoewGtj
        91eP7IcDAp/fCkW5wQ6txP1T4A==
X-Google-Smtp-Source: ABdhPJx4hoGuJUwRAjCeV2TM+T4nHcjhcKWZYU/NeIX3pdgYLRh3ne2/SpQJEWn2xbHSd+7moJLbdQ==
X-Received: by 2002:a1c:5412:: with SMTP id i18mr8635150wmb.152.1611840647150;
        Thu, 28 Jan 2021 05:30:47 -0800 (PST)
Received: from p1g2 (2a01cb000f9f0e008f0bd0d6ec94dd0e.ipv6.abo.wanadoo.fr. [2a01:cb00:f9f:e00:8f0b:d0d6:ec94:dd0e])
        by smtp.gmail.com with ESMTPSA id y24sm5817751wmi.47.2021.01.28.05.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 05:30:46 -0800 (PST)
Date:   Thu, 28 Jan 2021 14:30:44 +0100
From:   Gary Bisson <gary.bisson@boundarydevices.com>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     troy.kisky@boundarydevices.com, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mq-nitrogen: add USB support
Message-ID: <YBK8hAxvjJBuMdl2@p1g2>
References: <20210126215511.1056600-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126215511.1056600-1-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrien,

Thanks for improving Nitrogen upstream, much appreciated.

On Tue, Jan 26, 2021 at 10:55:11PM +0100, Adrien Grassein wrote:
> add USB support for imx8mq-nitrogen. It consists
> in 2 phys: OTG and host.
> 
> The OTG port uses a dedicated regulator for vbus.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../boot/dts/freescale/imx8mq-nitrogen.dts    | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> index 81d269296610..fb8acd83a280 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
> @@ -34,6 +34,17 @@ power {
>  		};
>  	};
>  
> +	reg_usb_otg_vbus: regulator-usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reg_usbotg_vbus>;
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
>  	reg_vref_0v9: regulator-vref-0v9 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vref-0v9";
> @@ -190,6 +201,25 @@ &uart2 {
>  	status = "okay";
>  };
>  
> +&usb_dwc3_0 {
> +	dr_mode = "otg";
> +	status = "okay";

Please add a pinctrl here to mux GPIO1_IO13 as over current pin.
But I confirm the port is working.

> +};
> +
> +&usb3_phy0 {
> +	vbus-supply = <&reg_usb_otg_vbus>;
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};

The Host port doesn't work for me. This is because of the missing reset
signal. Maybe it's time to revive the gpio-reset driver [1]?

Anyway, here is how to fix the USB Host ports:
# gpioset 0 14=1

I guess it'd be best to have a proper reset solution before merging the
host port addition.

Regards,
Gary

[1] https://patchwork.kernel.org/project/linux-arm-kernel/patch/1374834384-8071-1-git-send-email-p.zabel@pengutronix.de/
