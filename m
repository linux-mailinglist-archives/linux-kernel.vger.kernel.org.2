Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3A13E3DD7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhHIB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhHIB5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:57:25 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8209C061757;
        Sun,  8 Aug 2021 18:57:05 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2DB85466;
        Mon,  9 Aug 2021 03:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1628474224;
        bh=QDySkRfNlhrzD4my8PYiajvniAJkaxcCIIW8I51QkMU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpdrmmmGoH7gJHhyS42mZHme0uw4wZwtkkSm7A8EvXwYS8OrgvLaQnW1Hf0Bd4t79
         mC/7OKBZzFj8Uz/at/TFWRroS68LUNPGzJzhzxgyP5lAhn9QrNo5mJ9HOYvMNBvrMI
         7PjewUmgmNwQnmMcuE/gwerWAzZsHNKOBnhWO6Dc=
Date:   Mon, 9 Aug 2021 04:57:03 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: zynqmp: Fix serial compatible string
Message-ID: <YRCLb1grspPDh4vX@pendragon.ideasonboard.com>
References: <89b36e0a6187cc6b05b27a035efdf79173bd4486.1628240307.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89b36e0a6187cc6b05b27a035efdf79173bd4486.1628240307.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Fri, Aug 06, 2021 at 10:58:29AM +0200, Michal Simek wrote:
> Based on commit 65a2c14d4f00 ("dt-bindings: serial: convert Cadence UART
> bindings to YAML") compatible string should look like differently that's
> why fix it to be aligned with dt binding.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 6f0fcec28ae2..b5fde9dddca5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -786,7 +786,7 @@ ttc3: timer@ff140000 {
>  		};
>  
>  		uart0: serial@ff000000 {
> -			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
> +			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 21 4>;
> @@ -796,7 +796,7 @@ uart0: serial@ff000000 {
>  		};
>  
>  		uart1: serial@ff010000 {
> -			compatible = "cdns,uart-r1p12", "xlnx,xuartps";
> +			compatible = "xlnx,zynqmp-uart", "cdns,uart-r1p12";
>  			status = "disabled";
>  			interrupt-parent = <&gic>;
>  			interrupts = <0 22 4>;

-- 
Regards,

Laurent Pinchart
