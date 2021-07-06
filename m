Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0F63BDB34
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGFQPy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jul 2021 12:15:54 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:62375 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:15:52 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 705A840009;
        Tue,  6 Jul 2021 16:13:09 +0000 (UTC)
Date:   Tue, 6 Jul 2021 18:13:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dan Brown <dan_brown@ieee.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: nand_bbt: Skip bad blocks when searching
 for the BBT in NAND
Message-ID: <20210706181308.1aa21d00@xps13>
In-Reply-To: <20210625123821.207458-1-s.riedmueller@phytec.de>
References: <20210625123821.207458-1-s.riedmueller@phytec.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

Stefan Riedmueller <s.riedmueller@phytec.de> wrote on Fri, 25 Jun 2021
14:38:21 +0200:

> The blocks containing the bad block table can become bad as well. So
> make sure to skip any blocks that are marked bad when searching for the
> bad block table.
> 
> Otherwise in very rare cases where two BBT blocks wear out it might
> happen that an obsolete BBT is used instead of a newer available
> version.
> 
> This only applies to drivers which make use of a bad block marker in flash.
> Other drivers won't be able to identify bad BBT blocks and thus can't skip
> these.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Besides the alignment of the helper parameters (nitpick) the patch
looks good to me. If we can get someone to test it before the merge
window closes it's perfect. Otherwise I'll apply it and we'll let robots
do the job.

> ---
> 
> Hi,
> 
> this is the second approach of this patch. The first one [1] unfortunately lead
> to boot failures on i.MX 27 boards [2] since the i.MX 27 driver uses the bad
> block marker position for the bad block table marker which lead to falsely
> identifying all BBT blocks as bad.
> 
> This new patch now skips the check for bad BBT blocks if the BBT marker
> position in OOB overlaps with the bad block marker position or if a driver
> can't use bad block markers in flash at all (NAND_BBT_NO_OOB_BBM or
> NAND_NO_BBM_QUIRK are set). This hopefully makes sure we don't break drivers
> which cannot check for bad BBT blocks due to the limitations mentioned before.
> 
> I was only able to test this patch on a phyCORE-i.MX 6 and a phyCARD-i.MX 27.
> Therfore would really appreciate more people testing this to make sure I have
> not missed another use case where the bad block marker position in OOB is used
> in a different way than for the BBM.
> 
> Regards,
> Stefan
> 
> [1] https://lore.kernel.org/linux-mtd/20210325102337.481172-1-s.riedmueller@phytec.de/
> [2] https://lore.kernel.org/linux-mtd/CAOMZO5DufVR=+EzCa1-MPUc+ZefZVTXb5Kgu3Wxms7cxw9GmGg@mail.gmail.com/
> 
>  drivers/mtd/nand/raw/nand_bbt.c | 34 +++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
> index dced32a126d9..2a30714350ee 100644
> --- a/drivers/mtd/nand/raw/nand_bbt.c
> +++ b/drivers/mtd/nand/raw/nand_bbt.c
> @@ -447,6 +447,36 @@ static int scan_block_fast(struct nand_chip *this, struct nand_bbt_descr *bd,
>  	return 0;
>  }
>  
> +/* Check if a potential BBT block is marked as bad */
> +static int bbt_block_checkbad(struct nand_chip *this,
> +				      struct nand_bbt_descr *td,
> +				      loff_t offs, uint8_t *buf)
> +{
> +	struct nand_bbt_descr *bd = this->badblock_pattern;
> +
> +	/*
> +	 * No need to check for a bad BBT block if the BBM area overlaps with
> +	 * the bad block table marker area in OOB since writing a BBM here
> +	 * invalidates the bad block table marker anyway.
> +	 */
> +	if (!(td->options & NAND_BBT_NO_OOB) &&
> +	    td->offs >= bd->offs && td->offs < bd->offs + bd->len)
> +		return 0;
> +
> +	/*
> +	 * There is no point in checking for a bad block marker if writing
> +	 * such marker is not supported
> +	 */
> +	if (this->bbt_options & NAND_BBT_NO_OOB_BBM ||
> +	    this->options & NAND_NO_BBM_QUIRK)
> +		return 0;
> +
> +	if (scan_block_fast(this, bd, offs, buf) > 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  /**
>   * create_bbt - [GENERIC] Create a bad block table by scanning the device
>   * @this: NAND chip object
> @@ -560,6 +590,10 @@ static int search_bbt(struct nand_chip *this, uint8_t *buf,
>  			int actblock = startblock + dir * block;
>  			loff_t offs = (loff_t)actblock << this->bbt_erase_shift;
>  
> +			/* Check if block is marked bad */
> +			if (bbt_block_checkbad(this, td, offs, buf))
> +				continue;
> +
>  			/* Read first page */
>  			scan_read(this, buf, offs, mtd->writesize, td);
>  			if (!check_pattern(buf, scanlen, mtd->writesize, td)) {

Thanks,
Miquèl
