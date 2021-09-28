Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D8041B394
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241712AbhI1QO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241523AbhI1QO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:14:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7F0FA611C3;
        Tue, 28 Sep 2021 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632845568;
        bh=DFUNqDy3Ot4Tq/eu+piBAz26Q4OJcSk95Ec7Bn5i6Dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dac+fqiHI1x2PWBuvFfxKNJDpFWhm/YXuGKyIH0a3CYgDU/rJjao/sCWx0YisD96a
         fYoWfKjze8RtTP7gJnFx4BxwiDzBTL5eRZzL16tVn5hxZjPcTT/WhLUAWcMURXtPFd
         YUyCR52j/GFh34N4oHXz+4AkaPYW3JBkyfLqKqtqqDE7MXxXoSbFtSBrCj+1hffvDA
         v/m2efbsgzH/ZaSrMRNmXGKxBvIPzFiYhQXewvMzCZPeo02x7zK7zzqIXvSfC0oyid
         sVsL/Fz3ZwH7JcrPn4s59UyUMXeeNlST4Ru2/mDlDO+qHRWXAwmxYSohpy1Nc95TxR
         07tmeWhZ0/rIA==
Date:   Tue, 28 Sep 2021 21:42:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH 3/3] mtd: rawnand: qcom: Add support for page scope read
Message-ID: <20210928161219.GD12183@thinkpad>
References: <1631699851-12172-1-git-send-email-mdalam@codeaurora.org>
 <1631699851-12172-4-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631699851-12172-4-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 03:27:31PM +0530, Md Sadre Alam wrote:
> QPIC V2.0 onwards QPIC controller support enhanced read mode
> like page scope read and multi page read.
> 

Define page scope read.

> In QPIC V1, SW is needed to write EXEC_CMD register for each
> Code word and collect any Status related to that CW before
> issueing EXEC_CMD for next CW.
> 
> Page scope command is truly a page mode command where SW is
> required to issue EXEC_CMD only once for a page. Controller
> HW takes care of Codeword specific details and automatically
> returns status associated with each CW to BAM pipe, dedicated
> for status deposition.
> 
> With this command, SW now can issue one read command for a page
> and upon receiving completion interrupt, can process status,
> that have already been deposited in memory through status BAM pipe.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 77 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 07448c4..257dec7e 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -157,6 +157,10 @@
>  #define	OP_FETCH_ID			0xb
>  #define	OP_RESET_DEVICE			0xd
>  
> +/* Auto status val and mask */
> +#define	AUTO_STS_VAL			0x000B000B

Use non-cap hex.

> +#define PAGE_SCOPE_READ			BIT(23)
> +
>  /* Default Value for NAND_DEV_CMD_VLD */
>  #define NAND_DEV_CMD_VLD_VAL		(READ_START_VLD | WRITE_START_VLD | \
>  					 ERASE_START_VLD | SEQ_READ_START_VLD)
> @@ -336,6 +340,8 @@ struct nandc_regs {
>  
>  	__le32 erased_cw_detect_cfg_clr;
>  	__le32 erased_cw_detect_cfg_set;
> +
> +	__le32 auto_sts_en;
>  };
>  
>  /*
> @@ -421,6 +427,9 @@ struct qcom_nand_controller {
>  
>  	u32 cmd1, vld;
>  	const struct qcom_nandc_props *props;
> +
> +	__le32 *status_buf;
> +	int sts_buf_size;

Add kdoc for these two members.

>  };
>  
>  /*
> @@ -487,6 +496,7 @@ struct qcom_nandc_props {
>  	bool is_bam;
>  	bool is_qpic;
>  	bool qpic_v2;
> +	bool page_scope;
>  	u32 dev_cmd_reg_start;
>  };
>  
> @@ -656,6 +666,8 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
>  		return &regs->cfg1;
>  	case NAND_DEV0_ECC_CFG:
>  		return &regs->ecc_bch_cfg;
> +	case NAND_AUTO_STATUS_EN:
> +		return &regs->auto_sts_en;
>  	case NAND_READ_STATUS:
>  		return &regs->clrreadstatus;
>  	case NAND_DEV_CMD1:
> @@ -756,10 +768,13 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read, i
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>  
>  	if (read) {
> -		if (host->use_ecc)
> +		if (host->use_ecc) {
>  			cmd = OP_PAGE_READ_WITH_ECC | PAGE_ACC | LAST_PAGE;
> -		else
> +			if (nandc->props->qpic_v2 && nandc->props->page_scope)

Again, why you are checking for both conditions? Using "page_scope" is
sufficient enough.

> +				cmd |= PAGE_SCOPE_READ;
> +		} else {
>  			cmd = OP_PAGE_READ | PAGE_ACC | LAST_PAGE;
> +		}
>  	} else {
>  		cmd = OP_PROGRAM_PAGE | PAGE_ACC | LAST_PAGE;
>  	}

[...]

>  	if (use_ecc) {
> -		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
> -		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
> -			     NAND_BAM_NEXT_SGL);
> +		if (nandc->props->qpic_v2 && nandc->props->page_scope) {
> +			if (qcom_nandc_is_last_cw(ecc, cw))
> +				write_reg_dma(nandc, NAND_EXEC_CMD, 1,
> +					      NAND_BAM_NEXT_SGL);
> +		} else {
> +			write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +			read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
> +			read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
> +				     NAND_BAM_NEXT_SGL);
> +		}

You need to add a comment for this.

Thanks,
Mani
