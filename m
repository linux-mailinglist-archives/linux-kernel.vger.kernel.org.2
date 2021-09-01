Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90F03FDDDD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244752AbhIAOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:37:18 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:52067 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbhIAOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:37:17 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 2C93CC0005;
        Wed,  1 Sep 2021 14:36:16 +0000 (UTC)
Date:   Wed, 1 Sep 2021 16:36:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org,
        stable@kernel.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: Update code word value for raw
 read
Message-ID: <20210901163615.090c6f24@xps13>
In-Reply-To: <1630493613-8158-1-git-send-email-mdalam@codeaurora.org>
References: <1630493613-8158-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Md Sadre Alam <mdalam@codeaurora.org> wrote on Wed,  1 Sep 2021
16:23:33 +0530:

> Fixes: 503ee5aa ("mtd: rawnand: qcom: update last code word register")
> Cc: stable@kernel.org
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
> [V3]
>  * Added Fixes tag
>  * Removed change log from commit message.
> 
>     From QPIC V2 onwards there is a separate register to read
>     last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
> 
>     qcom_nandc_read_cw_raw() is used to read only one code word
>     at a time. If we will configure number of code words to 1 in
>     in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
>     its reading the last code word, since from QPIC V2 onwards
>     we are having separate register to read the last code word,
>     we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
>     register to fetch data from controller buffer to system
>     memory.

Really?

It's not your first contribution, you know what a changelog is and what
a commit message is, right? So please, keep the commit message
("why" your change is needed) where it was and only put
the changelog (the differences between two versions) below the three
dashes '---'.

>  
>  drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index ef0bade..04e6f7b 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -1676,13 +1676,17 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>  	int data_size1, data_size2, oob_size1, oob_size2;
>  	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
> +	int raw_cw = cw;
>  
>  	nand_read_page_op(chip, page, 0, NULL, 0);
>  	host->use_ecc = false;
>  
> +	if (nandc->props->qpic_v2)
> +		raw_cw = ecc->steps - 1;
> +
>  	clear_bam_transaction(nandc);
>  	set_address(host, host->cw_size * cw, page);
> -	update_rw_regs(host, 1, true, cw);
> +	update_rw_regs(host, 1, true, raw_cw);
>  	config_nand_page_read(chip);
>  
>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
> @@ -1711,7 +1715,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
>  	}
>  
> -	config_nand_cw_read(chip, false, cw);
> +	config_nand_cw_read(chip, false, raw_cw);
>  
>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>  	reg_off += data_size1;

