Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580BA32BE69
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573436AbhCCRVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1383275AbhCCNqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 08:46:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C1EE64EEA;
        Wed,  3 Mar 2021 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614779111;
        bh=vcOcMotciu5ev+6msPGDhqupM3rgbuHyeJ5jMbXEUuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tpojaUtJKSpgEz4hnrArr/FSBJiq8sfBF53SO7fYK6k2WeaIJD1u3Yj6vvyK0hvBo
         OdK8NFuH9CbygrWKAfWOinjDsupbGHLf58BEmmp1vbwIZHPhbVoWe+UpdN3dyE0nB9
         5zhSz+Fq8XVJI0abuSP4xie+3o85kP9rvkwX+G9smlZ8SaNh5z/0hgDBbMScPDcDkQ
         +xt5TRkeNPBt+ZHlzXA969mV9PyoNLnTiznnOASpuU8XT193HjnXhVXPhkXg/Qz6IP
         d243PDnr+oN4rcylgoS4JfCa5QQYgKiReO7EWuVMVnyjby+QPAytGnUOmMMlTh2zF0
         o1axH2PfEkEHA==
Date:   Wed, 3 Mar 2021 21:45:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     arnd@arndb.de, olof@lixom.net, robh+dt@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v3 2/3] ARM: dts: imx7d: remarkable2: Enable the power
 button
Message-ID: <20210303134505.GK15865@dragon>
References: <20210204030316.489-1-alistair@alistair23.me>
 <20210204030316.489-2-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204030316.489-2-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 07:03:15PM -0800, Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx7d-remarkable2.dts b/arch/arm/boot/dts/imx7d-remarkable2.dts
> index 0aae13f5eed6..0978e26f5db5 100644
> --- a/arch/arm/boot/dts/imx7d-remarkable2.dts
> +++ b/arch/arm/boot/dts/imx7d-remarkable2.dts
> @@ -62,6 +62,10 @@ &sdma {
>  	status = "okay";
>  };
>  
> +&snvs_pwrkey {
> +	status = "okay";
> +};
> +

Please merge it into patch #1.

Shawn

>  &uart1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_uart1>;
> -- 
> 2.30.0
> 
