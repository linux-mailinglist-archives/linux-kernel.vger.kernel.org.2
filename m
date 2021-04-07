Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8F5356797
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbhDGJEs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Apr 2021 05:04:48 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47629 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhDGJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:04:47 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 51ECDFF80F;
        Wed,  7 Apr 2021 09:04:31 +0000 (UTC)
Date:   Wed, 7 Apr 2021 11:04:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Fix the issue for clearing status process
Message-ID: <20210407110430.327bc46f@xps13>
In-Reply-To: <e52bf38913c20467e96c66ddf058129a5f063273.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
        <e52bf38913c20467e96c66ddf058129a5f063273.1616635406.git.ytc-mb-yfuruyama7@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Tue,  6 Apr
2021 10:47:26 +0900:

Could you add "mtd: nand: bbt:" as prefix for the title (same for the
other patch, even though you're not the original author).

> In the unlikely event of bad block,
> it should update its block status to BBT, 
> In this case, there are 2 kind of issue for handling
> a) Mark bad block status to BBT:  It was fixed by Patric's patch
> b) Clear status to BBT:  I posted patch for this issue 
> 
> Patch:
> Issue of handing BBT (Bad Block Table) for 
> some particular blocks (Ex:10, 11)
> Updating status is, first clear status, second set bad block status.
> Patrick's patch is only fixed the issue for setting status process,
> so this patch fix the clearing status process.

This commit message is not clearly describing the situation, could you
please reword it?

> 
> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
> ---
>  drivers/mtd/nand/bbt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/bbt.c b/drivers/mtd/nand/bbt.c
> index 64af6898131d..0780896eaafe 100644
> --- a/drivers/mtd/nand/bbt.c
> +++ b/drivers/mtd/nand/bbt.c
> @@ -112,11 +112,13 @@ int nanddev_bbt_set_block_status(struct nand_device *nand, unsigned int entry,
>  			     ((entry * bits_per_block) / BITS_PER_LONG);
>  	unsigned int offs = (entry * bits_per_block) % BITS_PER_LONG;
>  	unsigned long val = status & GENMASK(bits_per_block - 1, 0);
> +	unsigned long shift = ((bits_per_block + offs <= BITS_PER_LONG) ?
> +					(offs + bits_per_block - 1) : (BITS_PER_LONG - 1));

Given the fact that we do arithmetic operations (&, |) on an unsigned
long value I don't think the operation tampers with the next entry in
the pos array. 

I'm fine fixing it but I don't think this implementation works. It is
fine if offs is 29 or 30 but not if it is 31 (assuming 32-bits
arithmetic, it's the same for the 64-bit case).

>  
>  	if (entry >= nanddev_neraseblocks(nand))
>  		return -ERANGE;
>  
> -	pos[0] &= ~GENMASK(offs + bits_per_block - 1, offs);

Would something like the following work?

	pos[0] &= ~GENMASK(MIN(offs + bits_per_block - 1, BITS_PER_LONG - 1), offs)

Again, I am not convinced it is worth darkening the logic unless I am
not understanding it correctly.

> +	pos[0] &= ~GENMASK(shift, offs);
>  	pos[0] |= val << offs;
>  
>  	if (bits_per_block + offs > BITS_PER_LONG) {

Thanks,
Miquèl
