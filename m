Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05490371E00
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhECRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234047AbhECQ5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:57:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB66C613E9;
        Mon,  3 May 2021 16:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620060422;
        bh=iPg8jBVzACvtxro+PBWxTxGIHPUG4kFtNrGMH6DiwJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X6bk8ZsFhhQnP1duUqTJt0hZF54ljp486uPCGNeL0MT7W6jOUKWSRsNJtO7wbCj3T
         svRBALzjohPxD8LNmZeXXfqVHXx73HrvEkmC93VfVNHOx0gK0zEjev2RMAIXwm6g+z
         9ecG17e4R2uSO6d443q8S2AkEdxZkxcrocjBHjQE4zCrL+UnJMNPvs0ervWSDTBLt8
         CaHeMLbUMIhTxag8XALWXha/eJZhqzbXToRoPrK+MZIno8XYa5KaIOUlo5vIs4CuKu
         rH+YIZawB+qooG3HCyzufMa2Es0Eq3eS4/+Jty/jxtJO9QU7dssxFIlYkklrr5PAtX
         LgeVDcBbRhVUQ==
Date:   Mon, 3 May 2021 22:16:52 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: avoid write to obsolete register
Message-ID: <20210503164652.GA3958@thinkpad>
References: <1619205694-25645-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619205694-25645-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 24, 2021 at 12:51:34AM +0530, Md Sadre Alam wrote:
> QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
> Avoid writing this register if QPIC version is V2.0 or newer.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index fd4c318..8c5205c 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -714,7 +714,8 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
>  	nandc_set_reg(nandc, NAND_DEV0_CFG0, cfg0);
>  	nandc_set_reg(nandc, NAND_DEV0_CFG1, cfg1);
>  	nandc_set_reg(nandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
> -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>  	nandc_set_reg(nandc, NAND_FLASH_STATUS, host->clrflashstatus);
>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
> @@ -1083,7 +1084,8 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
>  {
>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
> +	if (!nandc->props->qpic_v2)
> +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
>  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
> @@ -1132,8 +1134,9 @@ static void config_nand_page_write(struct qcom_nand_controller *nandc)
>  {
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
> @@ -1187,7 +1190,8 @@ static int nandc_param(struct qcom_nand_host *host)
>  					| 2 << WR_RD_BSY_GAP
>  					| 0 << WIDE_FLASH
>  					| 1 << DEV0_CFG1_ECC_DISABLE);
> -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << ECC_CFG_ECC_DISABLE);
>  
>  	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>  	if (!nandc->props->qpic_v2) {
> @@ -2628,7 +2632,8 @@ static int qcom_nand_attach_chip(struct nand_chip *chip)
>  				| ecc_mode << ECC_MODE
>  				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
>  
> -	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
> +	if (!nandc->props->qpic_v2)
> +		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
>  
>  	host->clrflashstatus = FS_READY_BSY_N;
>  	host->clrreadstatus = 0xc0;
> -- 
> 2.7.4
> 
