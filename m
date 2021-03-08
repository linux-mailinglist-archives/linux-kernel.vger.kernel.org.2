Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01C330977
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhCHIgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhCHIfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:35:40 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00CEC06174A;
        Mon,  8 Mar 2021 00:35:39 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E2648A3;
        Mon,  8 Mar 2021 09:35:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615192536;
        bh=WDZupoFFnNhIFYFmfE1Z4g7GUN7Xt55IBvQe7FlXbQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uj0J9hgv2jAXrd8A7CnIhzAF38nCavZwtt2m5BUXoZ1XPuFFcxHRtY8EDaXFcQaVp
         nsyDn4imRpsTHZjiePZaTS9RwncNCgAX/1lm7/snYa5gFIKnAF0q6YaZLv7TYvbfpi
         FX/sInY8OgUHTsldIxTos9dXmL98SZk9f3KLKJ0U=
Date:   Mon, 8 Mar 2021 10:35:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     quanyang.wang@windriver.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: zynqmp: Add compatible strings for si5328
Message-ID: <YEXhuGeMoXbfWI6I@pendragon.ideasonboard.com>
References: <20210308070843.2096992-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210308070843.2096992-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quanyang,

Thank you for the patch.

On Mon, Mar 08, 2021 at 03:08:43PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The function of_i2c_get_board_info will call of_modalias_node to check
> if a device_node contains "compatible" string. So let's assign the
> proper string "silabs,si5328" to clock-generator@69's compatible
> property to eliminate the error info as below:

As far as I can tell, "silabs,si5328" isn't documented in
Documentation/devicetree/bindings/. We need DT bindings before making
use of the compatible string.

> i2c i2c-10: of_i2c: modalias failure on /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
> i2c i2c-10: Failed to create I2C device for /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
> 
> Fixes: 82a7ebf00224 ("arm64: dts: zynqmp: Add DT description for si5328 for zcu102/zcu106")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 12e8bd48dc8c..a73841ad24ce 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -590,6 +590,7 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				#clock-cells = <1>;
> +				compatible = "silabs,si5328";
>  				clocks = <&refhdmi>;
>  				clock-names = "xtal";
>  				clock-output-names = "si5328";
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 18771e868399..24ce64364d63 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -591,6 +591,7 @@ si5328: clock-generator@69 {/* SI5328 - u20 */
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				#clock-cells = <1>;
> +				compatible = "silabs,si5328";
>  				clocks = <&refhdmi>;
>  				clock-names = "xtal";
>  				clock-output-names = "si5328";

-- 
Regards,

Laurent Pinchart
