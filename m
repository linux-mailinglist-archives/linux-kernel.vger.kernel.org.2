Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F33F17C4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhHSLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbhHSLMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:12:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F78EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 04:11:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mGfxG-0002xY-RD; Thu, 19 Aug 2021 13:11:26 +0200
Message-ID: <6e179b30d360e8151ad1aba5f49540009a2076a5.camel@pengutronix.de>
Subject: Re: [PATCH v1 3/3] arm64: dts: imx8mq: fix the schema check errors
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Richard Zhu <hongxing.zhu@nxp.com>, robh@kernel.org,
        galak@kernel.crashing.org, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Aug 2021 13:11:25 +0200
In-Reply-To: <20210819071408.3856475-4-hongxing.zhu@nxp.com>
References: <20210819071408.3856475-1-hongxing.zhu@nxp.com>
         <20210819071408.3856475-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, dem 19.08.2021 um 15:14 +0800 schrieb Richard Zhu:
> The ranges should be aligned to $ref: /schemas/pci/pci-bus.yaml#
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Same comment as on the last patch, but still:
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 91df9c5350ae..45895dad85e1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -1364,8 +1364,8 @@ pcie0: pcie@33800000 {
>  			#size-cells = <2>;
>  			device_type = "pci";
>  			bus-range = <0x00 0xff>;
> -			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000 /* downstream I/O 64KB */
> -			          0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
> +			ranges = <0x81000000 0 0x00000000 0x1ff80000 0 0x00010000>, /* downstream I/O 64KB */
> +				 <0x82000000 0 0x18000000 0x18000000 0 0x07f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
>  			num-viewport = <4>;
>  			interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1402,8 +1402,8 @@ pcie1: pcie@33c00000 {
>  			#address-cells = <3>;
>  			#size-cells = <2>;
>  			device_type = "pci";
> -			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000 /* downstream I/O 64KB */
> -				   0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
> +			ranges =  <0x81000000 0 0x00000000 0x27f80000 0 0x00010000>, /* downstream I/O 64KB */
> +				  <0x82000000 0 0x20000000 0x20000000 0 0x07f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
>  			num-viewport = <4>;
>  			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;


