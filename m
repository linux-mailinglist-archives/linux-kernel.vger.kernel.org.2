Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC1A34D2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC2O63 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Mar 2021 10:58:29 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56671 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbhC2O6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:58:18 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 4E187100008;
        Mon, 29 Mar 2021 14:58:12 +0000 (UTC)
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
Subject: Re: [PATCH mvebu v3 07/10] cpufreq: armada-37xx: Fix driver cleanup
 when registration failed
In-Reply-To: <20210222194158.12342-8-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
 <20210222194158.12342-8-pali@kernel.org>
Date:   Mon, 29 Mar 2021 16:58:11 +0200
Message-ID: <87sg4edn24.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> Commit 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for
> opp") changed calculation of frequency passed to the dev_pm_opp_add()
> function call. But the code for dev_pm_opp_remove() function call was not
> updated, so the driver cleanup phase does not work when registration fails.
>
> This fixes the issue by using the same frequency in both calls.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
> Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
> Tested-by: Philip Soares <philips@netisense.com>
> Fixes: 8db82563451f ("cpufreq: armada-37xx: fix frequency calculation for opp")
> Cc: stable@vger.kernel.org

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index c7683d447b11..1ab2113daef5 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -521,7 +521,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  remove_opp:
>  	/* clean-up the already added opp before leaving */
>  	while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
> -		freq = cur_frequency / dvfs->divider[load_lvl];
> +		freq = base_frequency / dvfs->divider[load_lvl];
>  		dev_pm_opp_remove(cpu_dev, freq);
>  	}
>  
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
