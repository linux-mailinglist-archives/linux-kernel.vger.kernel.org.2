Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E7A31E8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhBRKda convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Feb 2021 05:33:30 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52827 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhBRJVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:21:12 -0500
X-Originating-IP: 86.210.203.113
Received: from xps13 (lfbn-tou-1-972-113.w86-210.abo.wanadoo.fr [86.210.203.113])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 809DD60008;
        Thu, 18 Feb 2021 09:20:20 +0000 (UTC)
Date:   Thu, 18 Feb 2021 10:20:19 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mdalam@codeaurora.org
Cc:     richard@nod.at, boris.brezillon@collabora.com, mani@kernel.org,
        krzk@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
Message-ID: <20210218102019.44973727@xps13>
In-Reply-To: <6f21a0cc139546c6351eb4e195dd43bd@codeaurora.org>
References: <1613416602-1175-1-git-send-email-mdalam@codeaurora.org>
 <20210216091613.1d0e7470@xps13>
 <6f21a0cc139546c6351eb4e195dd43bd@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> >> >> +/* helper to configure location register values */  
> >> +static void nandc_set_read_loc(struct nand_chip *chip, int cw, int >> reg,
> >> +			       int offset, int size, int is_last)  
> > 
> > You know cw, you have access to chip->ecc.steps, so you can derive by
> > yourself if is_last is set or not. No need to forward it through
> > function calls.  
> 
> 
>    This "is_last" is not for last code word, it will indicate the Location register "NAND_READ_LOCATION_n" last bit.

Ok, I've mixed two things. Let's keep this boolean as it is for now and
just do the minimum changes to support the LOCATION_LAST_cw registers.

Nevertheless, can't you calculate is_last from nandc_set_read_loc() ?

I also think a bit of renaming (in a different patch) would be welcome
to avoid such confusions.

Just to be clear: I think you should take a step back, and try to
simplify a bit this driver. I understand you know every character by
heart but with an external eye it's not that easy to understand what
you want to do and why:
- write small commits with a single, atomic change
- try to reduce the number of parameters when it is possible
- try to use meaningful names (is_last vs. LAST_CW)
- try to avoid extra indentation level when possible


[...]

> >> @@ -1094,11 +1144,19 @@ static void
config_nand_page_read(struct
>> qcom_nand_controller *nandc)
> >>   * before reading each codeword in NAND page.
> >>   */
> >>  static void
> >> -config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
> >> +config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
> >>  {
> >> -	if (nandc->props->is_bam)
> >> -		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> >> -			      NAND_BAM_NEXT_SGL);
> >> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> >> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> >> +
> >> +	if (nandc->props->is_bam) {
> >> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> >> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0, 4,
> >> +				      NAND_BAM_NEXT_SGL);
> >> +		else
> >> +			write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> >> +				      NAND_BAM_NEXT_SGL);
> >> +	}  
> > 
> > Same here, I am pretty sure we can abstract the complexity.
> >   
>     Here I did this because , i need pointer to struct nand_ecc_ctrl structure
>     to access ecc->steps for CW comparison for last code word. cw == (ecc->steps - 1)
> 
>     So i think no separate patch needed for conversion of nanc-->chip.
>     Please let me know if still separate patch needed for nanc-->chip conversion.

I was talking about the extra indentation level.

the "qpic_v2 && cv == ..." condition can be checked by write_reg_dma
directly.

You could even introduce a helper returning the boolean value of which
register should be used.

Regarding the use of nand_chip instead of nandc, if there are too many
changes involved, I prefer a separate patch.

> 
> >> >>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);  
> >>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> >> @@ -1117,11 +1175,11 @@ config_nand_cw_read(struct >> qcom_nand_controller *nandc, bool use_ecc)
> >>   * single codeword in page
> >>   */
> >>  static void
> >> -config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
> >> -				bool use_ecc)
> >> +config_nand_single_cw_page_read(struct nand_chip *chip,
> >> +				bool use_ecc, int cw)
> >>  {
> >> -	config_nand_page_read(nandc);
> >> -	config_nand_cw_read(nandc, use_ecc);
> >> +	config_nand_page_read(chip);
> >> +	config_nand_cw_read(chip, use_ecc, cw);
> >>  }  
> >> >>  /*  
> >> @@ -1205,7 +1263,7 @@ static int nandc_param(struct qcom_nand_host >> *host)
> >>  		nandc_set_reg(nandc, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
> >>  	}  
> >> >> -	nandc_set_read_loc(nandc, 0, 0, 512, 1);  
> >> +	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);  
> >> >>  	if (!nandc->props->qpic_v2) {  
> >>  		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
> >> @@ -1215,7 +1273,7 @@ static int nandc_param(struct qcom_nand_host >> *host)
> >>  	nandc->buf_count = 512;
> >>  	memset(nandc->data_buffer, 0xff, nandc->buf_count);  
> >> >> -	config_nand_single_cw_page_read(nandc, false);  
> >> +	config_nand_single_cw_page_read(chip, false, 0);  
> >> >>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,  
> >>  		      nandc->buf_count, 0);
> >> @@ -1617,7 +1675,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, >> struct nand_chip *chip,
> >>  	clear_bam_transaction(nandc);
> >>  	set_address(host, host->cw_size * cw, page);
> >>  	update_rw_regs(host, 1, true);
> >> -	config_nand_page_read(nandc);
> >> +	config_nand_page_read(chip);  
> >> >>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);  
> >>  	oob_size1 = host->bbm_size;
> >> @@ -1633,19 +1691,19 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, >> struct nand_chip *chip,
> >>  	}  
> >> >>  	if (nandc->props->is_bam) {  
> >> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> >> +		nandc_set_read_loc(chip, cw, 0, read_loc, data_size1, 0);
> >>  		read_loc += data_size1;  
> >> >> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);  
> >> +		nandc_set_read_loc(chip, cw, 1, read_loc, oob_size1, 0);
> >>  		read_loc += oob_size1;  
> >> >> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);  
> >> +		nandc_set_read_loc(chip, cw, 2, read_loc, data_size2, 0);
> >>  		read_loc += data_size2;  
> >> >> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);  
> >> +		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
> >>  	}  
> >> >> -	config_nand_cw_read(nandc, false);  
> >> +	config_nand_cw_read(chip, false, cw);  
> >> >>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);  
> >>  	reg_off += data_size1;
> >> @@ -1856,7 +1914,7 @@ static int read_page_ecc(struct qcom_nand_host >> *host, u8 *data_buf,
> >>  	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
> >>  	int i, ret;  
> >> >> -	config_nand_page_read(nandc);  
> >> +	config_nand_page_read(chip);  
> >> >>  	/* queue cmd descs for each codeword */  
> >>  	for (i = 0; i < ecc->steps; i++) {
> >> @@ -1873,18 +1931,16 @@ static int read_page_ecc(struct qcom_nand_host >> *host, u8 *data_buf,  
> >> >>  		if (nandc->props->is_bam) {  
> >>  			if (data_buf && oob_buf) {
> >> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> >> -				nandc_set_read_loc(nandc, 1, data_size,
> >> -						   oob_size, 1);
> >> +				nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
> >> +				nandc_set_read_loc(chip, i, 1, data_size, oob_size, 1);
> >>  			} else if (data_buf) {
> >> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
> >> +				nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
> >>  			} else {
> >> -				nandc_set_read_loc(nandc, 0, data_size,
> >> -						   oob_size, 1);
> >> +				nandc_set_read_loc(chip, i, 0, data_size, oob_size, 1);
> >>  			}
> >>  		}  
> >> >> -		config_nand_cw_read(nandc, true);  
> >> +		config_nand_cw_read(chip, true, i);  
> >> >>  		if (data_buf)  
> >>  			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
> >> @@ -1946,7 +2002,7 @@ static int copy_last_cw(struct qcom_nand_host >> *host, int page)
> >>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
> >>  	update_rw_regs(host, 1, true);  
> >> >> -	config_nand_single_cw_page_read(nandc, host->use_ecc);  
> >> +	config_nand_single_cw_page_read(chip, host->use_ecc, ecc->steps - >> 1);  
> >> >>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
> >> > > Thanks,  
> > Miquèl  

Thanks,
Miquèl
