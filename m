Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAAE34D30D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbhC2PAe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Mar 2021 11:00:34 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33369 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhC2PAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:00:15 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C8E37240018;
        Mon, 29 Mar 2021 15:00:12 +0000 (UTC)
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
Subject: Re: [PATCH mvebu v2 09/10] cpufreq: armada-37xx: Remove
 cur_frequency variable
In-Reply-To: <20210114124032.12765-10-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210114124032.12765-10-pali@kernel.org>
Date:   Mon, 29 Mar 2021 17:00:12 +0200
Message-ID: <87mtumdmyr.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> Variable cur_frequency in armada37xx_cpufreq_driver_init() is unused.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory

> ---
>  drivers/cpufreq/armada-37xx-cpufreq.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> index f08281fc525c..f13646d143de 100644
> --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> @@ -389,7 +389,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  	struct armada_37xx_dvfs *dvfs;
>  	struct platform_device *pdev;
>  	unsigned long freq;
> -	unsigned int cur_frequency, base_frequency;
> +	unsigned int base_frequency;
>  	struct regmap *nb_clk_base, *nb_pm_base, *avs_base;
>  	struct device *cpu_dev;
>  	int load_lvl, ret;
> @@ -450,14 +450,6 @@ static int __init armada37xx_cpufreq_driver_init(void)
>  		return -EINVAL;
>  	}
>  
> -	/* Get nominal (current) CPU frequency */
> -	cur_frequency = clk_get_rate(clk);
> -	if (!cur_frequency) {
> -		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
> -		clk_put(clk);
> -		return -EINVAL;
> -	}
> -
>  	dvfs = armada_37xx_cpu_freq_info_get(base_frequency);
>  	if (!dvfs) {
>  		clk_put(clk);
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
