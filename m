Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9763AB496
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhFQNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:24:52 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:53053 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFQNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:24:50 -0400
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 2B956E2511;
        Thu, 17 Jun 2021 13:14:43 +0000 (UTC)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 24805FF81E;
        Thu, 17 Jun 2021 13:14:18 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marcin Wojtas <mw@semihalf.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrew@lunn.ch, robh+dt@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: Re: [PATCH] arm64: dts: ensure backward compatibility of the AP807
 Xenon
In-Reply-To: <20210322003915.3199775-1-mw@semihalf.com>
References: <20210322003915.3199775-1-mw@semihalf.com>
Date:   Thu, 17 Jun 2021 15:14:18 +0200
Message-ID: <87k0ms1vmd.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcin,

> A recent switch to a dedicated AP807 compatible string for the Xenon
> SD/MMC controller result in the driver not being probed when
> using updated device tree with the older kernel revisions.
> It may also be problematic for other OSs/firmware that use
> Linux device tree sources as a reference. Resolve the problem
> with backward compatibility by restoring a previous compatible
> string as secondary one.
>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> index d9bbbfa4b4eb..4a23f65d475f 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> @@ -29,6 +29,7 @@ cpu_clk: clock-cpu {
>  };
>  
>  &ap_sdhci0 {
> -	compatible = "marvell,armada-ap807-sdhci";
> +	compatible = "marvell,armada-ap807-sdhci",
> +		     "marvell,armada-ap806-sdhci"; /* Backward compatibility */
>  };
>  
> -- 
> 2.29.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
