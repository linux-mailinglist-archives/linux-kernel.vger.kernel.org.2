Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7836233D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbhDPPBJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Apr 2021 11:01:09 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55405 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhDPPBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:01:08 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 8DB402000E;
        Fri, 16 Apr 2021 15:00:41 +0000 (UTC)
Date:   Fri, 16 Apr 2021 17:00:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fix an error code in
 nand_setup_interface()
Message-ID: <20210416170040.4e467039@xps13>
In-Reply-To: <YHaEEYg2DUFwnxSo@mwanda>
References: <YHaEEYg2DUFwnxSo@mwanda>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Dan Carpenter <dan.carpenter@oracle.com> wrote on Wed, 14 Apr 2021
08:56:33 +0300:

> We should return an error code if the timing mode is not acknowledged
> by the NAND chip.

This truly is questionable (and I am not yet decided whether the answer
should be yes or no).

Returning an error here would produce the entire boot sequence to fail,
even though the NAND chip would work in mode 0.

Not returning an error would print the below warning (so the
user/developer is warned) and continue the boot with the slowest
timing interface.

Honestly I would be more in favor of letting things as they are
because I don't think this may be considered as a buggy situation, but I
am open to discussion.

> Fixes: 415ae78ffb5d ("mtd: rawnand: check ONFI timings have been acked by the chip")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> From static analysis.  Not tested.
> 
>  drivers/mtd/nand/raw/nand_base.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index fb072c444495..d83c0503f96f 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -880,6 +880,7 @@ static int nand_setup_interface(struct nand_chip *chip, int chipnr)
>  	if (tmode_param[0] != chip->best_interface_config->timings.mode) {
>  		pr_warn("timing mode %d not acknowledged by the NAND chip\n",
>  			chip->best_interface_config->timings.mode);
> +		ret = -EINVAL;
>  		goto err_reset_chip;
>  	}
>  

Thanks,
Miquèl
