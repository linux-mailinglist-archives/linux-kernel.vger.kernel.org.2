Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8233D3ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235314AbhGWMQW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jul 2021 08:16:22 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44479 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbhGWMQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:16:19 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 786BDC000C;
        Fri, 23 Jul 2021 12:56:50 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: armada-3720-turris-mox: remove
 mrvl,i2c-fast-mode
In-Reply-To: <20210628151229.25214-1-pali@kernel.org>
References: <20210628121015.22660-1-pali@kernel.org>
 <20210628151229.25214-1-pali@kernel.org>
Date:   Fri, 23 Jul 2021 14:56:50 +0200
Message-ID: <87lf5x194d.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

> Some SFP modules are not detected when i2c-fast-mode is enabled even when
> clock-frequency is already set to 100000. The I2C bus violates the timing
> specifications when run in fast mode. So disable fast mode on Turris Mox.
>
> Same change was already applied for uDPU (also Armada 3720 board with SFP)
> in commit fe3ec631a77d ("arm64: dts: uDPU: remove i2c-fast-mode").
>
> Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Reviewed-by: Marek Behún <kabel@kernel.org>

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 6bcc319a0161..85f15f2a4740 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -119,6 +119,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
>  	clock-frequency = <100000>;
> +	/delete-property/ mrvl,i2c-fast-mode;
>  	status = "okay";
>  
>  	rtc@6f {
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
