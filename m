Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D94E4260B9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbhJGXxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:53:51 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:55548 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235212AbhJGXxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=0rTewvTn7wvPrU49mGtxMSiIC3GvG3uEdCDWIJLYZlY=; b=iDNv5SmtdL/sto2WTJBuv+Qy9K
        qWsec2pgRPVUMa38yi8FO7+5r+S9plISdXi586uZpllPSo6oIvkJTy4UfuZ0aFsASeOmcdZIOBQjy
        cNqEGAddjJI3nEQ5AiLm02W3Jancv/gV51TmTal2XlvSRE+wSRu9ursCYyc0MeBjc/vM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1mYdAt-00A0Tc-JC; Fri, 08 Oct 2021 01:51:43 +0200
Date:   Fri, 8 Oct 2021 01:51:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        robh+dt@kernel.org, kostap@marvell.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB device
 tree
Message-ID: <YV+IDzEdYuy+s/Ak@lunn.ch>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007230619.957016-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 12:06:19PM +1300, Chris Packham wrote:
> The CN9130-CRB boards have a MV88E6393X switch connected to eth0.  Add
> the necessary dts nodes and properties for this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> This is taken from the Marvell SDK. I've re-ordered the port entries to
> be in ascending order.
> 
>  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 125 ++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> index e7918f325646..171f7394948e 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> @@ -185,6 +185,131 @@ &cp0_mdio {
>  	phy0: ethernet-phy@0 {
>  		reg = <0>;
>  	};
> +
> +	switch6: switch0@6 {
> +		/* Actual device is MV88E6393X */
> +		compatible = "marvell,mv88e6190";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <6>;

Is the interrupt output connected to a GPIO?

> +
> +		dsa,member = <0 0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port@0 {
> +				reg = <0>;
> +				label = "notused-port0";
> +				phy-mode = "10gbase-kr";
> +				status = "disabled";

What is meant by not used? Does it go to a header? Is it not wired at
all? You don't need to list a port if it is not actually used. So
maybe you just want to delete this port all together?

> +
> +			};
> +
> +			port@1 {
> +				reg = <1>;
> +				label = "wan1";
> +				phy-handle = <&switch0phy1>;
> +			};
> +


> +
> +			port@8 {
> +				reg = <8>;
> +				label = "lan8";
> +				phy-handle = <&switch0phy8>;
> +			};
> +
> +			port@9 {
> +				reg = <9>;
> +				label = "wanp9";

Do these names correspond to some labeling? Ether the case or the silk
screen? wanp9 is an odd name. Is it connected to a header?

> +				phy-mode = "10gbase-kr";
> +				fixed-link {
> +					speed = <10000>;
> +					full-duplex;
> +				};
> +			};

  Andrew
