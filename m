Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7044EADB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhKLPzc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 12 Nov 2021 10:55:32 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44379 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbhKLPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:55:31 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1AF05E000A;
        Fri, 12 Nov 2021 15:52:37 +0000 (UTC)
Date:   Fri, 12 Nov 2021 16:52:36 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 4/4] mtd: rawnand: fsmc: Fix timing computation
Message-ID: <20211112165236.12d71bc0@xps13>
In-Reply-To: <20211112143855.2678989-5-herve.codina@bootlin.com>
References: <20211112143855.2678989-1-herve.codina@bootlin.com>
        <20211112143855.2678989-5-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

herve.codina@bootlin.com wrote on Fri, 12 Nov 2021 15:38:55 +0100:

> The timing setting were incorrect on some nands leading to a
> fallback to mode 0 timing on some Micron nand or to incorrect
> data reads on some Winbond NAND.

In general I prefer when acronyms use upper cases (NANDs, MTD, etc).
Please also do the change in the other commits.

Saying "timing setting were incorrect on some nands" is inaccurate. I
think we can clearly state that "Under certain circumstances, the
timing settings calculated by the FSMC NAND controller driver were
inaccurate." (no need to precise a NAND device here).

> The timing computation did not take into account the following
> constraint given in SPEAr3xx reference manual:
>   twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL
> 
> This patch adds this constraint and fixes the issues on both

We generally use the declarative tense here, such as "Add this
constraint and fixes..." even though I would happily reformulate with
something like "Enhance the timings calculation by taking into account
this additional constraint."

And then you can provide your results, how it behaved with the two
NANDs and what improvement you bring with this additional calculation.

> nands having the both nands working at mode 3 timing.
> The change has no impact on slower timing mode such as mode 0.
> Indeed, on mode 0 timing, computed values are the same with and
> without the patch.

A few visual changes explained below otherwise the logic is fine.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/mtd/nand/raw/fsmc_nand.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
> index bff09219ce3a..a3aa66f30869 100644
> --- a/drivers/mtd/nand/raw/fsmc_nand.c
> +++ b/drivers/mtd/nand/raw/fsmc_nand.c
> @@ -278,7 +278,7 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
>  {
>  	unsigned long hclk = clk_get_rate(host->clk);
>  	unsigned long hclkn = NSEC_PER_SEC / hclk;
> -	u32 thiz, thold, twait, tset;
> +	u32 thiz, thold, twait, tset, tmp;
>  
>  	if (sdrt->tRC_min < 30000)
>  		return -EOPNOTSUPP;
> @@ -310,13 +310,6 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
>  	else if (tims->thold > FSMC_THOLD_MASK)
>  		tims->thold = FSMC_THOLD_MASK;
>  
> -	twait = max(sdrt->tRP_min, sdrt->tWP_min);
> -	tims->twait = DIV_ROUND_UP(twait / 1000, hclkn) - 1;
> -	if (tims->twait == 0)
> -		tims->twait = 1;
> -	else if (tims->twait > FSMC_TWAIT_MASK)
> -		tims->twait = FSMC_TWAIT_MASK;
> -
>  	tset = max(sdrt->tCS_min - sdrt->tWP_min,
>  		   sdrt->tCEA_max - sdrt->tREA_max);
>  	tims->tset = DIV_ROUND_UP(tset / 1000, hclkn) - 1;
> @@ -325,6 +318,24 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
>  	else if (tims->tset > FSMC_TSET_MASK)
>  		tims->tset = FSMC_TSET_MASK;
>  
> +	twait = max(sdrt->tRP_min, sdrt->tWP_min);
> +
> +	/* According to SPEAr300 Reference Manual (RM0082) which gives more

           ^
Should be:

	/*
	 * According to...

> +	 * information related to FSMSC timings than the SPEAr600 one (RM0305),
> +	 *   twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL
> +	 * With TOUTDEL = 7ns (Output delay from the flip-flops to the board)
> +	 * and TINDEL = 5ns (Input delay from the board to the flipflop)

These two information should be placed close to TOUTDEL and TINDEL
definitions (see my comment below).

> +	 */
> +	tmp = sdrt->tCEA_max - (tims->tset + 1)*hclkn*1000 + 7000 + 5000;

                                               ^
The style here is wrong, you need spaces before and after a "*".

Please also enclose these two multiplications with parenthesis to make
it clear that you do not intend to multiply 7000 nor 5000.

Finally, do not use open coded values, please define them at the top so
that your code matches your commit message (using TOUTDEL and TINDEL).
You can even add a comment explaining from where you got these values.

> +	if (twait < tmp)
> +		twait = tmp;

I don't like the tmp naming, you could call this variable twait_min and
use a min() calculation here to fit the manual better.

> +
> +	tims->twait = DIV_ROUND_UP(twait / 1000, hclkn) - 1;
> +	if (tims->twait == 0)
> +		tims->twait = 1;
> +	else if (tims->twait > FSMC_TWAIT_MASK)
> +		tims->twait = FSMC_TWAIT_MASK;
> +
>  	return 0;
>  }
>  


Thanks,
Miquèl
