Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA340352FF1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 21:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236560AbhDBTuf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Apr 2021 15:50:35 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:41867 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbhDBTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 15:50:32 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D4CED100002;
        Fri,  2 Apr 2021 19:50:26 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andre Heider <a.heider@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gerald@gk2.net>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: Re: [PATCH mvebu v2 01/10] arm64: dts: marvell: armada-37xx: add
 syscon compatible to NB clk node
In-Reply-To: <20210114124032.12765-2-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210114124032.12765-2-pali@kernel.org>
Date:   Fri, 02 Apr 2021 21:50:26 +0200
Message-ID: <87k0pkcvp9.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

> From: Marek Behún <kabel@kernel.org>
>
> Add "syscon" compatible to the North Bridge clocks node to allow the
> cpufreq driver to access these registers via syscon API.
>
> This is needed for a fix of cpufreq driver.
>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Fixes: e8d66e7927b2 ("arm64: dts: marvell: armada-37xx: add nodes...")
> Cc: stable@vger.kernel.org
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index d5b6c0a1c54a..a89e47d95eef 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -156,7 +156,8 @@
>  			};
>  
>  			nb_periph_clk: nb-periph-clk@13000 {
> -				compatible = "marvell,armada-3700-periph-clock-nb";
> +				compatible = "marvell,armada-3700-periph-clock-nb",
> +					     "syscon";
>  				reg = <0x13000 0x100>;
>  				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
>  				<&tbg 3>, <&xtalclk>;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
