Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EC39D912
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhFGJwg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Jun 2021 05:52:36 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:19451 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhFGJwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:52:35 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 3CA3624000B;
        Mon,  7 Jun 2021 09:50:42 +0000 (UTC)
Date:   Mon, 7 Jun 2021 11:50:41 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: avoid writing to obsolete
 register
Message-ID: <20210607115041.21e21e19@xps13>
In-Reply-To: <1623059017-5058-1-git-send-email-mdalam@codeaurora.org>
References: <1623059017-5058-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon,  7 Jun 2021
15:13:37 +0530:

> QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
> Avoid writing this register if QPIC version is V2.0 or newer.
> 
> Also fixed nandc undeclared issue reported by,
> 
> Reported-by: kernel test robot <lkp@intel.com>

This tag should only be added when you fix something that is already in
mainline. The Reported-by here points to v2, which makes no sense.
Please drop it.

> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
> [V3]
>  * Fixed nandc undeclared issue.
>  drivers/mtd/nand/raw/qcom_nandc.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index a64fb6c..ee5985d 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -734,6 +734,7 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
>  {
>  	struct nand_chip *chip = &host->chip;
>  	u32 cmd, cfg0, cfg1, ecc_bch_cfg;
> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  
>  	if (read) {
>  		if (host->use_ecc)
> @@ -762,7 +763,8 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
>  	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
>  	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
>  	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
> -	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>  	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
>  	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> @@ -1133,7 +1135,8 @@ static void config_nand_page_read(struct nand_chip *chip)
>  
>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
> +	if (!nandc->props->qpic_v2)
> +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
>  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
> @@ -1191,8 +1194,9 @@ static void config_nand_page_write(struct nand_chip *chip)
>  
>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
> -		      NAND_BAM_NEXT_SGL);
> +	if (!nandc->props->qpic_v2)
> +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
> +			      NAND_BAM_NEXT_SGL);
>  }
>  
>  /*
> @@ -1248,7 +1252,8 @@ static int nandc_param(struct qcom_nand_host *host)
>  					| 2 << WR_RD_BSY_GAP
>  					| 0 << WIDE_FLASH
>  					| 1 << DEV0_CFG1_ECC_DISABLE);
> -	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
>  
>  	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>  	if (!nandc->props->qpic_v2) {
> @@ -2689,7 +2694,8 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>  				| ecc_mode << ECC_MODE
>  				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
>  
> -	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
> +	if (!nandc->props->qpic_v2)
> +		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
>  
>  	host->clrflashstatus = FS_READY_BSY_N;
>  	host->clrreadstatus = 0xc0;


Thanks,
Miquèl
