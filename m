Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7EF3AB44F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhFQNKp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Jun 2021 09:10:45 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33343 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhFQNKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:10:44 -0400
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 84A68240009;
        Thu, 17 Jun 2021 13:08:34 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 mvebu + mvebu/dt64 2/2] arm64: dts: marvell:
 armada-37xx: move firmware node to generic dtsi file
In-Reply-To: <20210520113844.32319-3-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113844.32319-1-pali@kernel.org>
 <20210520113844.32319-3-pali@kernel.org>
Date:   Thu, 17 Jun 2021 15:08:34 +0200
Message-ID: <87mtro1vvx.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
> the generic armada-37xx.dtsi file and use the generic compatible string
> 'marvell,armada-3700-rwtm-firmware' instead of the current one.
>
> Turris MOX DTS file contains also old compatible string for backward
> compatibility.
>
> The Turris MOX rWTM firmware can be used on any Armada 37xx device,
> giving them access to the rWTM hardware random number generator, which
> is otherwise unavailable.
>
> This change allows Linux to load the turris-mox-rwtm.ko module on these
> boards.
>
> Tested on ESPRESSObin v5 with both default Marvell WTMI firmware and
> CZ.NIC's firmware. With default WTMI firmware the turris-mox-rwtm fails
> to probe, while with CZ.NIC's firmware it registers the HW random number
> generator.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.4+: 46d2f6d0c99f ("arm64: dts: armada-3720-turris-mox: add firmware node")

Applied on mvebu/dt64 (I removed the Fixes line)

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 6 ++----
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 8 ++++++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 0753cc489638..6700f2212b61 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -109,10 +109,8 @@
>  	};
>  
>  	firmware {
> -		turris-mox-rwtm {
> -			compatible = "cznic,turris-mox-rwtm";
> -			mboxes = <&rwtm 0>;
> -			status = "okay";
> +		armada-3700-rwtm {
> +			compatible = "marvell,armada-3700-rwtm-firmware", "cznic,turris-mox-rwtm";
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 1b7f43e27589..847a2d12a4be 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -505,4 +505,12 @@
>  			};
>  		};
>  	};
> +
> +	firmware {
> +		armada-3700-rwtm {
> +			compatible = "marvell,armada-3700-rwtm-firmware";
> +			mboxes = <&rwtm 0>;
> +			status = "okay";
> +		};
> +	};
>  };
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
