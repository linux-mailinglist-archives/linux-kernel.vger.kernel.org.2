Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923DE456C23
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 10:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhKSJME convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Nov 2021 04:12:04 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55357 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhKSJME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 04:12:04 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D73F060014;
        Fri, 19 Nov 2021 09:09:00 +0000 (UTC)
Date:   Fri, 19 Nov 2021 10:08:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/4] mtd: rawnand: Fix nand_choose_best_timings() on
 unsupported interface
Message-ID: <20211119100859.00b61e94@xps13>
In-Reply-To: <20211119073909.1492538-3-herve.codina@bootlin.com>
References: <20211119073909.1492538-1-herve.codina@bootlin.com>
        <20211119073909.1492538-3-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

herve.codina@bootlin.com wrote on Fri, 19 Nov 2021 08:39:07 +0100:

> When the NV-DDR interface is not supported by the NAND chip,
> the value of onfi->nvddr_timing_modes is 0. In this case,
> the best_mode variable value in nand_choose_best_nvddr_timings()
> is -1. The last for-loop is skipped and the function returns an
> uninitialized value.

Actually is not the first time this uninitialized value triggers bells
but, while I think in the SDR path it is still not needed,in the DDR
patch you are right that something is missing.

> If this returned value is 0, the nand_choose_best_sdr_timings()
> is not executed and no 'best timing' are set. This leads the host
> controller and the NAND chip working at default mode 0 timing
> even if a better timing can be used.
> 
> Fix this uninitialzed returned value.

typo                ^

> 
> nand_choose_best_sdr_timings() is pretty similar to
> nand_choose_best_nvddr_timings(). Even if onfi->sdr_timing_modes
> should never be seen as 0, nand_choose_best_sdr_timings() returned
> value is fixed.

I still don't think it really needed by let's keep so  everyone
(including robots) is happy :)

> 
> Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v1 to v2:
> - New patch in v2 series
> 
>  drivers/mtd/nand/raw/nand_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 5c6b065837ef..a130320de412 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -926,7 +926,7 @@ int nand_choose_best_sdr_timings(struct nand_chip *chip,
>  				 struct nand_sdr_timings *spec_timings)
>  {
>  	const struct nand_controller_ops *ops = chip->controller->ops;
> -	int best_mode = 0, mode, ret;
> +	int best_mode = 0, mode, ret = -EOPNOTSUPP;
>  
>  	iface->type = NAND_SDR_IFACE;
>  
> @@ -977,7 +977,7 @@ int nand_choose_best_nvddr_timings(struct nand_chip *chip,
>  				   struct nand_nvddr_timings *spec_timings)
>  {
>  	const struct nand_controller_ops *ops = chip->controller->ops;
> -	int best_mode = 0, mode, ret;
> +	int best_mode = 0, mode, ret = -EOPNOTSUPP;
>  
>  	iface->type = NAND_NVDDR_IFACE;
>  


Thanks,
Miquèl
