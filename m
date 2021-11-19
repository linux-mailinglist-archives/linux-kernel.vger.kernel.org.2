Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE515456B88
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhKSIVL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Nov 2021 03:21:11 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:34135 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhKSIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:21:11 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 04858FF804;
        Fri, 19 Nov 2021 08:18:07 +0000 (UTC)
Date:   Fri, 19 Nov 2021 09:18:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/4] mtd: rawnand: Fix nand_erase_op delay
Message-ID: <20211119091806.76900103@xps13>
In-Reply-To: <20211119073909.1492538-2-herve.codina@bootlin.com>
References: <20211119073909.1492538-1-herve.codina@bootlin.com>
        <20211119073909.1492538-2-herve.codina@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

herve.codina@bootlin.com wrote on Fri, 19 Nov 2021 08:39:06 +0100:

> NAND_OP_CMD() expect a delay parameter in nanoseconds.

expects

> The delay value is wrongly given in milliseconds.
> 
> Fix the conversion macro used in order to set this
> delay in nanoseconds.
> 

I believe you still miss the Fixes: tag here :)

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v1 -> v2:
> - Commit log reword
> 
>  drivers/mtd/nand/raw/nand_base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index 3d6c6e880520..5c6b065837ef 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -1837,7 +1837,7 @@ int nand_erase_op(struct nand_chip *chip, unsigned int eraseblock)
>  			NAND_OP_CMD(NAND_CMD_ERASE1, 0),
>  			NAND_OP_ADDR(2, addrs, 0),
>  			NAND_OP_CMD(NAND_CMD_ERASE2,
> -				    NAND_COMMON_TIMING_MS(conf, tWB_max)),
> +				    NAND_COMMON_TIMING_NS(conf, tWB_max)),
>  			NAND_OP_WAIT_RDY(NAND_COMMON_TIMING_MS(conf, tBERS_max),
>  					 0),
>  		};

Thanks,
Miquèl
