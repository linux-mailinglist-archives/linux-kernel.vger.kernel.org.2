Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B15F3931A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhE0PEr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 May 2021 11:04:47 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54615 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhE0PEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:04:45 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id D2B14100007;
        Thu, 27 May 2021 15:03:10 +0000 (UTC)
Date:   Thu, 27 May 2021 17:03:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: ensure return variable is
 initialized
Message-ID: <20210527170309.4d99bc31@xps13>
In-Reply-To: <20210527145048.795954-1-colin.king@canonical.com>
References: <20210527145048.795954-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Colin King <colin.king@canonical.com> wrote on Thu, 27 May 2021
15:50:48 +0100:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there are corner cases where spec_times is NULL and
> chip->parameters.onfi or when best_mode is zero where ret is

                       ^
something is missing here, the sentence is not clear

> not assigned a value and an uninitialized return value can be
> returned. Fix this by ensuring ret is initialized to -EINVAL.

I don't see how this situation can happen.

In both cases, no matter the value of best_mode, the for loop will
always execute at least one time (mode 0) so ret will be populated.

Maybe the robot does not know that best_mode cannot be negative and
should be defined unsigned, but the current patch is invalid.

> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 9d3194bf2aef ("mtd: rawnand: Allow SDR timings to be nacked")
> Fixes: a9ecc8c814e9 ("mtd: rawnand: Choose the best timings, NV-DDR included")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 57a583149cc0..18db742f650c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -926,7 +926,7 @@ int nand_choose_best_sdr_timings(struct nand_chip *chip,
>  				 struct nand_sdr_timings *spec_timings)
>  {
>  	const struct nand_controller_ops *ops = chip->controller->ops;
> -	int best_mode = 0, mode, ret;
> +	int best_mode = 0, mode, ret = -EINVAL;
>  
>  	iface->type = NAND_SDR_IFACE;
>  
> @@ -977,7 +977,7 @@ int nand_choose_best_nvddr_timings(struct nand_chip *chip,
>  				   struct nand_nvddr_timings *spec_timings)
>  {
>  	const struct nand_controller_ops *ops = chip->controller->ops;
> -	int best_mode = 0, mode, ret;
> +	int best_mode = 0, mode, ret = 0;
>  
>  	iface->type = NAND_NVDDR_IFACE;
>  

Thanks,
Miquèl
