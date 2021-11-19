Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26644456BB3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbhKSIfK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Nov 2021 03:35:10 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57241 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKSIfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:35:09 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 94574E000B;
        Fri, 19 Nov 2021 08:32:05 +0000 (UTC)
Date:   Fri, 19 Nov 2021 09:32:04 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/4] mtd: rawnand: fsmc: Fix timing computation
Message-ID: <20211119093204.1511b4b8@xps13>
In-Reply-To: <20211119073909.1492538-5-herve.codina@bootlin.com>
References: <20211119073909.1492538-1-herve.codina@bootlin.com>
        <20211119073909.1492538-5-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

herve.codina@bootlin.com wrote on Fri, 19 Nov 2021 08:39:09 +0100:

> Under certain circumstances, the timing settings calculated by
> the FSMC NAND controller driver were inaccurate.
> These settings lead to incorrect data reads or fallback to

led to

oneOf:
  - fallbacks to timing mode 0
  - fallbacks to mode 0
but "mode X timing" does not look good :) (same below, it applies all
over this commit log)

> mode 0 timings depending on NAND chip used.

depending on the NAND chip used

> 
> The timing computation did not take into account the following
> constraint given in SPEAr3xx reference manual:
>   twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL

See below for the style request (this really is nitpicking, I'm sorry)

> 
> Enhance the timings calculation by taking into account this
> additional constraint.
> 
> The change has no impact on slow timing mode such as mode 0.

This change?
slow timing modes

> Indeed, on mode 0 timing, computed values are the same with and
> without the patch.
> 
> The NAND that previously used the mode 0 fallback timing is
> working in mode 3 timing.

I believe we should be more generic:
"NANDs which previously stayed in mode 0 because of ... can now work
at higher speeds and NANDs which were not working at all because of the
corrupted data returned interact at high speeds without troubles.

Overall improvement on a <flash name/type>:"

> The read/writes accesses performances (flash_speed tool result)
> are the following:
>                         mode0       mode3
> eraseblock write speed  3220 KiB/s  4511 KiB/s
> eraseblock read speed   4491 KiB/s  7529 KiB/s
> 
> The NAND where data reads were previously incorrect are correct
> and this NAND is also working at mode 3 timing.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v1 to v2:
> - Commit log reword
> - Added performance details in commit log
> - Used #define for TOUTDEL and TINDEL and
>   Fixed coding style
> - Used max3()
> 
>  drivers/mtd/nand/raw/fsmc_nand.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
> index 0a6c9ef0ea8b..56b9da252346 100644
> --- a/drivers/mtd/nand/raw/fsmc_nand.c
> +++ b/drivers/mtd/nand/raw/fsmc_nand.c
> @@ -94,6 +94,14 @@
>  
>  #define FSMC_BUSY_WAIT_TIMEOUT	(1 * HZ)
>  
> +/*
> + * According to SPEAr300 Reference Manual (RM0082)
> + *  TOUDEL = 7ns (Output delay from the flip-flops to the board)
> + *  TINDEL = 5ns (Input delay from the board to the flipflop)
> + */
> +#define TOUTDEL	7000
> +#define TINDEL	5000
> +
>  struct fsmc_nand_timings {
>  	u8 tclr;
>  	u8 tar;
> @@ -278,7 +286,7 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
>  {
>  	unsigned long hclk = clk_get_rate(host->clk);
>  	unsigned long hclkn = NSEC_PER_SEC / hclk;
> -	u32 thiz, thold, twait, tset;
> +	u32 thiz, thold, twait, tset, twait_min;
>  
>  	if (sdrt->tRC_min < 30000)
>  		return -EOPNOTSUPP;
> @@ -310,13 +318,6 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
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
> @@ -325,6 +326,21 @@ static int fsmc_calc_timings(struct fsmc_nand_data *host,
>  	else if (tims->tset > FSMC_TSET_MASK)
>  		tims->tset = FSMC_TSET_MASK;
>  
> +	/*
> +	 * According to SPEAr300 Reference Manual (RM0082) which gives more
> +	 * information related to FSMSC timings than the SPEAr600 one (RM0305),
> +	 *   twait >= tCEA - tset*TCLK + TOUTDEL + TINDEL

It is certainly best if in plain text we follow the same spacing
convention than in the code: (tset * TCLK). Same applies to your commit
log.

> +	 */
> +	twait_min = sdrt->tCEA_max - ((tims->tset + 1) * hclkn * 1000)
> +		    + TOUTDEL + TINDEL;
> +	twait = max3(sdrt->tRP_min, sdrt->tWP_min, twait_min);
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

Otherwise looks good.

Thanks,
Miquèl
