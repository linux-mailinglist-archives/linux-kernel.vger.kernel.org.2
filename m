Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C974634D2AC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhC2Oqo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 Mar 2021 10:46:44 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52709 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhC2Oqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:46:31 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 71A3A1BF20F;
        Mon, 29 Mar 2021 14:46:26 +0000 (UTC)
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
Subject: Re: [PATCH mvebu v3 03/10] clk: mvebu: armada-37xx-periph: remove
 .set_parent method for CPU PM clock
In-Reply-To: <20210222194158.12342-4-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
 <20210222194158.12342-1-pali@kernel.org>
 <20210222194158.12342-4-pali@kernel.org>
Date:   Mon, 29 Mar 2021 16:46:26 +0200
Message-ID: <874kguf265.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> From: Marek Behún <kabel@kernel.org>
>
> Remove the .set_parent method in clk_pm_cpu_ops.
>
> This method was supposed to be needed by the armada-37xx-cpufreq driver,
> but was never actually called due to wrong assumptions in the cpufreq
> driver. After this was fixed in the cpufreq driver, this method is not
> needed anymore.
>
> Signed-off-by: Marek Behún <kabel@kernel.org>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Tested-by: Pali Rohár <pali@kernel.org>
> Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
> Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
> Tested-by: Philip Soares <philips@netisense.com>
> Fixes: 2089dc33ea0e ("clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks")

Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory
> ---
>  drivers/clk/mvebu/armada-37xx-periph.c | 28 --------------------------
>  1 file changed, 28 deletions(-)
>
> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
> index f5746f9ea929..6507bd2c5f31 100644
> --- a/drivers/clk/mvebu/armada-37xx-periph.c
> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
> @@ -440,33 +440,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
>  	return val;
>  }
>  
> -static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
> -{
> -	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
> -	struct regmap *base = pm_cpu->nb_pm_base;
> -	int load_level;
> -
> -	/*
> -	 * We set the clock parent only if the DVFS is available but
> -	 * not enabled.
> -	 */
> -	if (IS_ERR(base) || armada_3700_pm_dvfs_is_enabled(base))
> -		return -EINVAL;
> -
> -	/* Set the parent clock for all the load level */
> -	for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
> -		unsigned int reg, mask,  val,
> -			offset = ARMADA_37XX_NB_TBG_SEL_OFF;
> -
> -		armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
> -
> -		val = index << offset;
> -		mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
> -		regmap_update_bits(base, reg, mask, val);
> -	}
> -	return 0;
> -}
> -
>  static unsigned long clk_pm_cpu_recalc_rate(struct clk_hw *hw,
>  					    unsigned long parent_rate)
>  {
> @@ -592,7 +565,6 @@ static int clk_pm_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>  static const struct clk_ops clk_pm_cpu_ops = {
>  	.get_parent = clk_pm_cpu_get_parent,
> -	.set_parent = clk_pm_cpu_set_parent,
>  	.round_rate = clk_pm_cpu_round_rate,
>  	.set_rate = clk_pm_cpu_set_rate,
>  	.recalc_rate = clk_pm_cpu_recalc_rate,
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
