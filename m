Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9FB372607
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 08:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhEDG7G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 May 2021 02:59:06 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:46183 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhEDG7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 02:59:03 -0400
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E1695240002;
        Tue,  4 May 2021 06:58:06 +0000 (UTC)
Date:   Tue, 4 May 2021 08:58:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: avoid write to obsolete register
Message-ID: <20210504085805.73e60979@xps13>
In-Reply-To: <2667b47434a8f2892ea3d5f304380960@codeaurora.org>
References: <1619205694-25645-1-git-send-email-mdalam@codeaurora.org>
        <2667b47434a8f2892ea3d5f304380960@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

mdalam@codeaurora.org wrote on Mon, 03 May 2021 20:24:54 +0530:

> On 2021-04-24 00:51, Md Sadre Alam wrote:
> > QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
> > Avoid writing this register if QPIC version is V2.0 or newer.
> > 
> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> > ---
> >  drivers/mtd/nand/raw/qcom_nandc.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> > b/drivers/mtd/nand/raw/qcom_nandc.c
> > index fd4c318..8c5205c 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -714,7 +714,8 @@ static void update_rw_regs(struct qcom_nand_host
> > *host, int num_cw, bool read)
> >  	nandc_set_reg(nandc, NAND_DEV0_CFG0, cfg0);
> >  	nandc_set_reg(nandc, NAND_DEV0_CFG1, cfg1);
> >  	nandc_set_reg(nandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
> > -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
> > +	if (!nandc->props->qpic_v2)
> > +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
> >  	nandc_set_reg(nandc, NAND_FLASH_STATUS, host->clrflashstatus);
> >  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
> >  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
> > @@ -1083,7 +1084,8 @@ static void config_nand_page_read(struct
> > qcom_nand_controller *nandc)
> >  {
> >  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
> >  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> > -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
> > +	if (!nandc->props->qpic_v2)
> > +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
> >  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
> >  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
> >  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
> > @@ -1132,8 +1134,9 @@ static void config_nand_page_write(struct
> > qcom_nand_controller *nandc)
> >  {
> >  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
> >  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
> > -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
> > -		      NAND_BAM_NEXT_SGL);
> > +	if (!nandc->props->qpic_v2)
> > +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
> > +			      NAND_BAM_NEXT_SGL);
> >  }
> > 
> >  /*
> > @@ -1187,7 +1190,8 @@ static int nandc_param(struct qcom_nand_host > *host)
> >  					| 2 << WR_RD_BSY_GAP
> >  					| 0 << WIDE_FLASH
> >  					| 1 << DEV0_CFG1_ECC_DISABLE);
> > -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << > ECC_CFG_ECC_DISABLE);
> > +	if (!nandc->props->qpic_v2)
> > +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << > ECC_CFG_ECC_DISABLE);
> > 
> >  	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
> >  	if (!nandc->props->qpic_v2) {
> > @@ -2628,7 +2632,8 @@ static int qcom_nand_attach_chip(struct nand_chip > *chip)
> >  				| ecc_mode << ECC_MODE
> >  				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
> > 
> > -	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
> > +	if (!nandc->props->qpic_v2)
> > +		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
> > 
> >  	host->clrflashstatus = FS_READY_BSY_N;
> >  	host->clrreadstatus = 0xc0;  
> 
> 
> ping! Hi Miquel could you review this change and let me know if more info needed.

Come on, that's only 6 days of work and we are in the middle of the
merge window... 

BTW "avoid write to" in the title is incorrect "writing to" would be
nicer.

Thanks,
Miquèl
