Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAB371730
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhECO4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:56:09 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39834 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhECO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:56:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620053712; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3Fk+kDMYxkaBQhIOQ4tkY93cPnBbUwngSdDbYFdBEWY=;
 b=jgYm7Lx+Zxmo3LeP8bHtvSuKXjJ9BdJEkkoeD2LEa9rIPHnoW2VYbInmxHyDH63CdfrFBhI7
 VofxBrcpvPFgojGUw0B+kRQ4+5THFyuXxrHovxeZkOjBwPK+QQoFM0CoiQH4UUzzG01WBvtY
 MorP0K7S4BVAUuLW6b6KjF6Tn2A=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60900ec19a9ff96d95353c77 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 May 2021 14:54:57
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 854F4C433D3; Mon,  3 May 2021 14:54:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D322C433F1;
        Mon,  3 May 2021 14:54:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 03 May 2021 20:24:54 +0530
From:   mdalam@codeaurora.org
To:     miquel.raynal@bootlin.com, mani@kernel.org,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: avoid write to obsolete register
In-Reply-To: <1619205694-25645-1-git-send-email-mdalam@codeaurora.org>
References: <1619205694-25645-1-git-send-email-mdalam@codeaurora.org>
Message-ID: <2667b47434a8f2892ea3d5f304380960@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-24 00:51, Md Sadre Alam wrote:
> QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
> Avoid writing this register if QPIC version is V2.0 or newer.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> b/drivers/mtd/nand/raw/qcom_nandc.c
> index fd4c318..8c5205c 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -714,7 +714,8 @@ static void update_rw_regs(struct qcom_nand_host
> *host, int num_cw, bool read)
>  	nandc_set_reg(nandc, NAND_DEV0_CFG0, cfg0);
>  	nandc_set_reg(nandc, NAND_DEV0_CFG1, cfg1);
>  	nandc_set_reg(nandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
> -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>  	nandc_set_reg(nandc, NAND_FLASH_STATUS, host->clrflashstatus);
>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
> @@ -1083,7 +1084,8 @@ static void config_nand_page_read(struct
> qcom_nand_controller *nandc)
>  {
>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
> +	if (!nandc->props->qpic_v2)
> +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
>  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
> @@ -1132,8 +1134,9 @@ static void config_nand_page_write(struct
> qcom_nand_controller *nandc)
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
> @@ -1187,7 +1190,8 @@ static int nandc_param(struct qcom_nand_host 
> *host)
>  					| 2 << WR_RD_BSY_GAP
>  					| 0 << WIDE_FLASH
>  					| 1 << DEV0_CFG1_ECC_DISABLE);
> -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << 
> ECC_CFG_ECC_DISABLE);
> +	if (!nandc->props->qpic_v2)
> +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << 
> ECC_CFG_ECC_DISABLE);
> 
>  	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>  	if (!nandc->props->qpic_v2) {
> @@ -2628,7 +2632,8 @@ static int qcom_nand_attach_chip(struct nand_chip 
> *chip)
>  				| ecc_mode << ECC_MODE
>  				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
> 
> -	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
> +	if (!nandc->props->qpic_v2)
> +		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
> 
>  	host->clrflashstatus = FS_READY_BSY_N;
>  	host->clrreadstatus = 0xc0;


ping! Hi Miquel could you review this change and let me know if more 
info needed.
