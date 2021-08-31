Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5652F3FC6BE
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 14:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhHaLna convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 Aug 2021 07:43:30 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37937 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241524AbhHaLn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 07:43:29 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 3EDC41BF210;
        Tue, 31 Aug 2021 11:42:32 +0000 (UTC)
Date:   Tue, 31 Aug 2021 13:42:31 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, stable@kernel.org
Subject: Re: [PATCH V2] mtd: rawnand: qcom: Update code word value for raw
 read
Message-ID: <20210831134231.14413a4f@xps13>
In-Reply-To: <1630400200-2522-1-git-send-email-mdalam@codeaurora.org>
References: <1630400200-2522-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Md,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 31 Aug 2021
14:26:40 +0530:

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
> Cc: stable@kernel.org

You miss the Fixes tag which is certainly the most important.

> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> 
> [V2]
>  * Added stable tags

The changelog should not be part of the commit message.
You should put it...

> ---

...here.

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
