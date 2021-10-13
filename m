Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3442C409
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhJMOyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:54:18 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:60393 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhJMOyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:54:16 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id E7BEA40010;
        Wed, 13 Oct 2021 14:52:07 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        kostap@marvell.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 1/2] arm/arm64: dts: Enable 2.5G Ethernet port on
 CN9130-CRB
In-Reply-To: <20211007230619.957016-2-chris.packham@alliedtelesis.co.nz>
References: <20211007230619.957016-1-chris.packham@alliedtelesis.co.nz>
 <20211007230619.957016-2-chris.packham@alliedtelesis.co.nz>
Date:   Wed, 13 Oct 2021 16:52:02 +0200
Message-ID: <87czo9dlkd.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chris,

> Enable the 2.5G Ethernet port by setting the status to "okay" and the
> phy-mode to "2500base-x" on the cn9130-crb boards. Tested on a
> CN9130-CRB-A.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

As I am not sure that next week the pull request will be accepted when
you will send the v2 for the second patch, I already applied the one on
mvebu/dt64

Thanks,

Gregory


> ---
>
> The Marvell SDK adds 2500base-t and uses it in the equivalent dtsi but
> looking at the documentation for both the SoC and the PHY I think
> 2500base-x is correct for the system interface (the line side is
> 2500base-t).
>
>  arch/arm64/boot/dts/marvell/cn9130-crb.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> index 505ae69289f6..e7918f325646 100644
> --- a/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> +++ b/arch/arm64/boot/dts/marvell/cn9130-crb.dtsi
> @@ -214,8 +214,8 @@ &cp0_eth1 {
>  };
>  
>  &cp0_eth2 {
> -	/* This port uses "2500base-t" phy-mode */
> -	status = "disabled";
> +	status = "okay";
> +	phy-mode = "2500base-x";
>  	phy = <&nbaset_phy0>;
>  	phys = <&cp0_comphy5 2>;
>  };
> -- 
> 2.33.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
