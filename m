Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 766B1402396
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhIGGtz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 7 Sep 2021 02:49:55 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52925 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhIGGty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:49:54 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D7FCF60007;
        Tue,  7 Sep 2021 06:48:45 +0000 (UTC)
Date:   Tue, 7 Sep 2021 08:48:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org,
        stable@kernel.org
Subject: Re: [PATCH V5] mtd: rawnand: qcom: Update code word value for raw
 read
Message-ID: <20210907084844.1ad92ef1@xps13>
In-Reply-To: <1630996771-29866-1-git-send-email-mdalam@codeaurora.org>
References: <1630996771-29866-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


mdalam@codeaurora.org wrote on Tue,  7 Sep 2021 12:09:31 +0530:

> From QPIC V2 onwards there is a separate register to read
> last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
> 
> qcom_nandc_read_cw_raw() is used to read only one code word
> at a time. If we will configure number of code words to 1 in
> in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
> its reading the last code word, since from QPIC V2 onwards
> we are having separate register to read the last code word,
> we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
> register to fetch data from controller buffer to system
> memory.
> 
> Fixes: 503ee5aad43054a26cfd5cc592a31270c05539cd ("mtd: rawnand: qcom: update last code word register")

Still wrong. It's 12 digits, as reported by Manivannan.

> Cc: stable@kernel.org
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
> Changes in V5:
> 
>  * Incorporated "hash commit" comment from Mani.
>  * Updated commit hash
> 
> Changes in V4:
> 
>  * Incorporated "Change log" comment from Miquèl
>  * Updated change log
> 
> Changes in V3:
>  
>  * Incorporated "Fixes tags are missing" comment from Miquèl
>  * Added Fixes tag Fixes:503ee5aa ("mtd: rawnand: qcom: update last code word register")
> 
> 
> Changes in V2:
> 
>  * Incorporated "stable tags are missing" comment from Miquèl
>  * Added stable tags Cc:stable@kernel.org
> 
>   
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


Thanks,
Miquèl
