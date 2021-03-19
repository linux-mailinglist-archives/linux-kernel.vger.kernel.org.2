Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7810C341825
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 10:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCSJX5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 19 Mar 2021 05:23:57 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:58773 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhCSJXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 05:23:43 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8AD321C0006;
        Fri, 19 Mar 2021 09:23:39 +0000 (UTC)
Date:   Fri, 19 Mar 2021 10:23:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Patrick Doyle <pdoyle@irobot.com>
Subject: Re: [PATCH v1] mtd: nand: Fix BBT update issue
Message-ID: <20210319102117.47774faf@xps13>
In-Reply-To: <b04b128eaca91961597fa9586c7ccaa3934aaa03.1612501067.git.ytc-mb-yfuruyama7@kioxia.com>
References: <1613435875-6846-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
        <b04b128eaca91961597fa9586c7ccaa3934aaa03.1612501067.git.ytc-mb-yfuruyama7@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

+ Patrick

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Tue, 16 Feb
2021 09:37:55 +0900:

> Fixed issue of manages BBT (Bad Block Table).
> It didn't mark correctly when a specific block was bad block.
> 
> This issue occurs when the bad block mark (3-bit chunk) is 
> crosses over 32 bit (e.g. Block10, Block21...) unit.
> 

Thanks for the patch and sorry for the very long wait period, I wanted
to understand better the issue but I didn't had the time to do it.

Would you mind having a look at Patrick's fix merged in U-Boot a year
ago:

commit 06fc4573b9d0878dd1d3b302884601263fe6e85f
Author: Doyle, Patrick <pdoyle@irobot.com>
Date:   Wed Jul 15 14:46:34 2020 +0000

    Fix corner case in bad block table handling.
    
    In the unlikely event that both blocks 10 and 11 are marked as bad (on a
    32 bit machine), then the process of marking block 10 as bad stomps on
    cached entry for block 11.  There are (of course) other examples.
    
    Signed-off-by: Patrick Doyle <pdoyle@irobot.com>
    Reviewed-by: Richard Weinberger <richard@nod.at>

diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
index 84d60b86521..294daee7b22 100644
--- a/drivers/mtd/nand/bbt.c
+++ b/drivers/mtd/nand/bbt.c
@@ -127,7 +127,7 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
                unsigned int rbits = bits_per_block + offs - BITS_PER_LONG;
 
                pos[1] &= ~GENMASK(rbits - 1, 0);
-               pos[1] |= val >> rbits;
+               pos[1] |= val >> (bits_per_block - rbits);
        }
 
        return 0;

It looks both patches fix different errors but I wonder if merging Patrick's patch first would not make more sense. 

Ideally, could you please send a series with the two patches, perhaps
Patrick's patch first, then yours, adding a Fixes and Cc: stable tags
to both?

> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
> ---
>  drivers/mtd/nand/bbt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
> index 044adf913854..979c47e61381 100644
> --- a/drivers/mtd/nand/bbt.c
> +++ b/drivers/mtd/nand/bbt.c
> @@ -112,18 +112,20 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
>  			     ((entry * bits_per_block) / BITS_PER_LONG);
>  	unsigned int offs = (entry * bits_per_block) % BITS_PER_LONG;
>  	unsigned long val = status & GENMASK(bits_per_block - 1, 0);
> +	unsigned long shift = ((bits_per_block + offs <= BITS_PER_LONG) ?
> +					(offs + bits_per_block - 1) : (BITS_PER_LONG - 1));
>  
>  	if (entry >= nanddev_neraseblocks(nand))
>  		return -ERANGE;
>  
> -	pos[0] &= ~GENMASK(offs + bits_per_block - 1, offs);
> +	pos[0] &= ~GENMASK(shift, offs);
>  	pos[0] |= val << offs;
>  
>  	if (bits_per_block + offs > BITS_PER_LONG) {
>  		unsigned int rbits = bits_per_block + offs - BITS_PER_LONG;
>  
>  		pos[1] &= ~GENMASK(rbits - 1, 0);
> -		pos[1] |= val >> rbits;
> +		pos[1] |= (val >> (BITS_PER_LONG - offs));
>  	}
>  
>  	return 0;

Thanks,
Miquèl
