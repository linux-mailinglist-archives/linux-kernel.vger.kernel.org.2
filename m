Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F85458775
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 01:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbhKVAtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 19:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhKVAtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 19:49:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6395604DA;
        Mon, 22 Nov 2021 00:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637542003;
        bh=DuHtiZB67B//Xt5quVyGUPNGVT/dcgLJ1kuqJjKwwFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJkLac4u0yeseK++S3IA26Yd4brapnpvMsbPxWttys61oEjFCTtrYFFab4n7MWPJT
         srKgIhmCt3/Q3RkBshUMCIVcxjqcbjRjpE4qAt1p9rXe2tNDpzO6jVtknlKatMf3yy
         +ygFAfC94UsDdE/ubCaqXPJ9FGExnKa110JYJwE6rZNTXW5fUa6cnbLr8Uo5Ro6zCL
         vzf+h/o2Ko2MkQ8IK+8MtAs3ciLzEok1961qFtH/dS3Za79uoRAOGS1EMufGE+EmMF
         o8DPk24HWFLwBDJmmqKPo3TZ3SURGbGXGZVbMA+JdqLV2BynO+pQUmie5Sst9evyts
         ViZ43J+h4I/1A==
Date:   Mon, 22 Nov 2021 08:46:38 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: Re: [PATCH v2 2/3] ARM: dts: imx6qdl: tqma6: add ERR006687 hardware
 workaround for "a" variant
Message-ID: <20211122004637.GQ31998@dragon>
References: <20211103115618.13927-1-matthias.schiffer@ew.tq-group.com>
 <20211103115618.13927-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103115618.13927-2-matthias.schiffer@ew.tq-group.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 12:56:17PM +0100, Matthias Schiffer wrote:
> The TQMa6x "a" has a workaround for ERR006687 implemented in hardware.
> Add the required pinmuxing and related setup to make use of this.
> 
> As board DTS files based on the TQMa6x SoMs will define their own
> pinmuxing for the FEC ethernet controller as well, we can't apply this
> pin group unconditionally; instead, it is the responsibility of the
> board DTs derived from imx6qdl-tqma6a.dtsi to include this group.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

"ARM: dts: imx6qdl-tqma6: ..." for subject prefix.

Shawn

> ---
> 
> v2: no changes
> 
>  arch/arm/boot/dts/imx6qdl-tqma6a.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
> index b679bec78e6c..bfb67da64b96 100644
> --- a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
> @@ -4,6 +4,12 @@
>   * Copyright 2013-2017 Markus Niebel <Markus.Niebel@tq-group.com>
>   */
>  
> +&fec {
> +	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> +	fsl,err006687-workaround-present;
> +};
> +
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_i2c1>;
> @@ -26,3 +32,17 @@
>  		pagesize = <32>;
>  	};
>  };
> +
> +&iomuxc {
> +	/*
> +	 * This pinmuxing is required for the ERR006687 workaround. Board
> +	 * DTS files that enable the FEC controller with
> +	 * fsl,err006687-workaround-present must include this group.
> +	 */
> +	pinctrl_enet_fix: enetfixgrp {
> +		fsl,pins = <
> +			/* ENET ping patch */
> +			MX6QDL_PAD_GPIO_6__ENET_IRQ 0x000b1
> +		>;
> +	};
> +};
> -- 
> 2.17.1
> 
