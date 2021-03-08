Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60733056A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 01:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhCHAi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 19:38:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhCHAie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:38:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C51165092;
        Mon,  8 Mar 2021 00:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615163913;
        bh=DKh9NYmnenN8IlnzPu/ApReyI2TlyulvzQsaCmAg7zU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dm2zHgg2hdzvQyTBfSbhIxcNnpQZxoZBpukzxagXVJVAmnsCBw7L0MA7LJg/RK9oD
         y31YjT6iqV+2iqbRPgDwWQbnUzfbbbwXjFPQfJoTk+KEjX1a951s5Ly3jWjOUEHJ/A
         AYQljp7eA1MFRrkLEwYFdTjqOY/mbt5xdah9gI0GNfM8Vp+52aNm1CU55aekphGhL0
         KsTM76QSqoKPnGUJFUWrEC5tXsanNrKw1S48b5WZCqR9ZLco52YHeL8xlgiDLMhd/G
         Adl+yByKhLTsTDtcrvOS3pxljc+9g6HHKuVER3uya2R2jJ/2WHJgUGfAaw5nSp+APz
         7bJ2Hn5ORGkYg==
Date:   Mon, 8 Mar 2021 08:38:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 2/4] ARM: dts: imx: ba16: improve PHY information
Message-ID: <20210308003827.GL543@dragon>
References: <20210223183346.138575-1-sebastian.reichel@collabora.com>
 <20210223183346.138575-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223183346.138575-3-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 07:33:44PM +0100, Sebastian Reichel wrote:
> Add PHY voltage supply information fixing the following kernel message:
> 
> 2188000.ethernet supply phy not found, using dummy regulator
> 
> Also add PHY clock information to avoid depending on the bootloader
> programming correct values.
> 
> The bootloader also sets some reserved registers in the PHY as
> advised by Qualcomm, which is not supported by the bindings/kernel
> driver, so the reset GPIO has not been added intentionally.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm/boot/dts/imx6q-ba16.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
> index 4793ef5171aa..a684d999e605 100644
> --- a/arch/arm/boot/dts/imx6q-ba16.dtsi
> +++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
> @@ -177,6 +177,18 @@ &fec {
>  	pinctrl-0 = <&pinctrl_enet>;
>  	phy-mode = "rgmii-id";
>  	status = "okay";
> +	phy-supply = <&reg_3p3v>;
> +	phy-handle = <&phy0>;

Please keep 'status' at end.

Shawn

> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		phy0: ethernet-phy@4 {
> +			reg = <4>;
> +			qca,clk-out-frequency = <125000000>;
> +		};
> +	};
>  };
>  
>  &hdmi {
> -- 
> 2.30.0
> 
