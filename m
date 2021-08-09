Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6223E3DD0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 03:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhHIBwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 21:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhHIBwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 21:52:35 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C919C061757;
        Sun,  8 Aug 2021 18:52:16 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6D0C9466;
        Mon,  9 Aug 2021 03:52:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1628473934;
        bh=rJCHMhJ96HUgHt/ffb25OzYoSudh7C3dD1C9I9+f0lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pu9I9ort0ZE5403JARORx+g14DdisbkrNFrjbiiuTSVSZB+74ikVyCqP4VDqu7VcK
         8Y1R25JFvp/7yPfa/Q2rqd0fVKunpph/pMS4dNmpFnAt3tYBKwkldBmseTezr7XAlk
         Jjn/MiblDi9v1Dgoi8opaiNdDFjenYs5DsrWdbiE=
Date:   Mon, 9 Aug 2021 04:52:13 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: zynqmp: Remove not documented is-dual property
Message-ID: <YRCKTfxmo60uPzp5@pendragon.ideasonboard.com>
References: <876c53b92f99623bae45d5c0c5ae79ee3e24f745.1628239345.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <876c53b92f99623bae45d5c0c5ae79ee3e24f745.1628239345.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

Thank you for the patch.

On Fri, Aug 06, 2021 at 10:42:29AM +0200, Michal Simek wrote:
> Remove is-dual not documented property and also update comment about QSPI
> sizes to reflect dual configuration as 16MB + 16MB.
> Only single configuration is supported now.
> 
> Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 3 +--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 3 +--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index becfc23a5610..3d8d14ef1ede 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -937,9 +937,8 @@ &psgtr {
>  
>  &qspi {
>  	status = "okay";
> -	is-dual = <1>;
>  	flash@0 {
> -		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index d2219373580a..057c04352591 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -931,9 +931,8 @@ &psgtr {
>  
>  &qspi {
>  	status = "okay";
> -	is-dual = <1>;
>  	flash@0 {
> -		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> index dac5ba67a160..e1fff62a4cd5 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
> @@ -773,9 +773,8 @@ &psgtr {
>  
>  &qspi {
>  	status = "okay";
> -	is-dual = <1>;
>  	flash@0 {
> -		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
> +		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		reg = <0x0>;

-- 
Regards,

Laurent Pinchart
