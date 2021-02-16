Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6421431CFAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhBPRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:54:38 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:29418 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhBPRyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:54:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613498013; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=bcPIcgo03NFt9oPjZKquVA83F0QLcMCy2aa8bgBGqG8=;
 b=hl5huS0C9oi7Oz6FbQqNX5LQisyHqmL05ihnM+wmNkKUOpt61lr17M5seEKMSKiAPnw2r6Hn
 JJrfwKwUNXuUGOgkGrxRv+3Vk65hSO85v1nX9TTliX1EahOQH13nFcVhtHA1thpIeGNObove
 RQl32BRDTuL35vcj3EEW52udm7U=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 602c069d59e27801598e2607 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Feb 2021 17:53:33
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 873FAC433ED; Tue, 16 Feb 2021 17:53:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E281CC433CA;
        Tue, 16 Feb 2021 17:53:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 16 Feb 2021 23:23:30 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, boris.brezillon@collabora.com, mani@kernel.org,
        krzk@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210216091613.1d0e7470@xps13>
References: <1613416602-1175-1-git-send-email-mdalam@codeaurora.org>
 <20210216091613.1d0e7470@xps13>
Message-ID: <6f21a0cc139546c6351eb4e195dd43bd@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 13:46, Miquel Raynal wrote:
> Hello,
> 
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 16 Feb 2021
> 00:46:42 +0530:
> 
>> From QPIC version 2.0 onwards new register got added to
>> read last codeword. This change will add the READ_LOCATION_LAST_CW_n
>> register.
>> 
>> For first three code word READ_LOCATION_n register will be
>> use.For last code word READ_LOCATION_LAST_CW_n register will be
>> use.
>> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
>> [V6]
> 
> It is also very important that you mark the version in the subject:
> 
> 	[PATCH v6] mtd: rawnand: etc
> 
> Otherwise it is difficult to keep track on the changes.

   Sure I will follow the same.
> 
>>  * Updated write_reg_dma() function in "v6"
>>  * Removed extra indentation level in read_page_ecc() to read last 
>> code word in "v6"
>>  * Removed boolean check in config_nand_cw_read() in "v6"
>>  drivers/mtd/nand/raw/qcom_nandc.c | 118 
>> ++++++++++++++++++++++++++++----------
>>  1 file changed, 87 insertions(+), 31 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 667e4bf..bae352f 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -48,6 +48,10 @@
>>  #define	NAND_READ_LOCATION_1		0xf24
>>  #define	NAND_READ_LOCATION_2		0xf28
>>  #define	NAND_READ_LOCATION_3		0xf2c
>> +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
>> +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
>> +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
>> +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
>> 
>>  /* dummy register offsets, used by write_reg_dma */
>>  #define	NAND_DEV_CMD1_RESTORE		0xdead
>> @@ -181,8 +185,14 @@
>>  #define	ECC_BCH_4BIT	BIT(2)
>>  #define	ECC_BCH_8BIT	BIT(3)
>> 
>> -#define nandc_set_read_loc(nandc, reg, offset, size, is_last)	\
>> -nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
>> +#define nandc_set_read_loc_first(nandc, reg, offset, size, is_last)	\
>> +nandc_set_reg(nandc, reg,					\
>> +	      ((offset) << READ_LOCATION_OFFSET) |		\
>> +	      ((size) << READ_LOCATION_SIZE) |			\
>> +	      ((is_last) << READ_LOCATION_LAST))
>> +
>> +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
>> +nandc_set_reg(nandc, reg,					\
>>  	      ((offset) << READ_LOCATION_OFFSET) |		\
>>  	      ((size) << READ_LOCATION_SIZE) |			\
>>  	      ((is_last) << READ_LOCATION_LAST))
>> @@ -316,6 +326,10 @@ struct nandc_regs {
>>  	__le32 read_location1;
>>  	__le32 read_location2;
>>  	__le32 read_location3;
>> +	__le32 read_location_last0;
>> +	__le32 read_location_last1;
>> +	__le32 read_location_last2;
>> +	__le32 read_location_last3;
>> 
>>  	__le32 erased_cw_detect_cfg_clr;
>>  	__le32 erased_cw_detect_cfg_set;
>> @@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct 
>> nandc_regs *regs, int offset)
>>  		return &regs->read_location2;
>>  	case NAND_READ_LOCATION_3:
>>  		return &regs->read_location3;
>> +	case NAND_READ_LOCATION_LAST_CW_0:
>> +		return &regs->read_location_last0;
>> +	case NAND_READ_LOCATION_LAST_CW_1:
>> +		return &regs->read_location_last1;
>> +	case NAND_READ_LOCATION_LAST_CW_2:
>> +		return &regs->read_location_last2;
>> +	case NAND_READ_LOCATION_LAST_CW_3:
>> +		return &regs->read_location_last3;
>>  	default:
>>  		return NULL;
>>  	}
>> @@ -661,6 +683,26 @@ static void nandc_set_reg(struct 
>> qcom_nand_controller *nandc, int offset,
>>  		*reg = cpu_to_le32(val);
>>  }
>> 
>> +/* helper to configure location register values */
>> +static void nandc_set_read_loc(struct nand_chip *chip, int cw, int 
>> reg,
>> +			       int offset, int size, int is_last)
> 
> You know cw, you have access to chip->ecc.steps, so you can derive by
> yourself if is_last is set or not. No need to forward it through
> function calls.


   This "is_last" is not for last code word, it will indicate the 
Location register "NAND_READ_LOCATION_n" last bit.

   bit[31]: Indicate this is the last Read location needing processing.

> 
>> +{
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +
>> +	int loc = NAND_READ_LOCATION_0;
>> +
>> +	if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +		loc = NAND_READ_LOCATION_LAST_CW_0;
>> +
>> +	loc += reg * 4;
>> +
>> +	if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> 
> Just compute is_last a single time at the top of the helper and use it.

    This "is_last" is not for last code word, it will indicate the 
Location register last bit.

    bit[31]: Indicate this is the last Read location needing processing.
> 
>> +		return nandc_set_read_loc_last(nandc, loc, offset, size, is_last);
>> +	else
>> +		return nandc_set_read_loc_first(nandc, loc, offset, size, is_last);
>> +}
>> +
>>  /* helper to configure address register values */
>>  static void set_address(struct qcom_nand_host *host, u16 column, int 
>> page)
>>  {
>> @@ -685,6 +727,7 @@ static void update_rw_regs(struct qcom_nand_host 
>> *host, int num_cw, bool read)
>>  {
>>  	struct nand_chip *chip = &host->chip;
>>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	u32 cmd, cfg0, cfg1, ecc_bch_cfg;
>> 
>>  	if (read) {
>> @@ -719,9 +762,14 @@ static void update_rw_regs(struct qcom_nand_host 
>> *host, int num_cw, bool read)
>>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>> 
>> -	if (read)
>> -		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
>> -				   host->cw_data : host->cw_size, 1);
>> +	if (read) {
>> +		if (nandc->props->qpic_v2)
>> +			nandc_set_read_loc(chip, ecc->steps - 1, 0, 0, host->use_ecc ?
>> +					host->cw_data : host->cw_size, 1);
>> +		else
>> +			nandc_set_read_loc(chip, 0, 0, 0, host->use_ecc ?
>> +					host->cw_data : host->cw_size, 1);
> 
> Here you should not have this extra indentation level as well,
> nandc_set_read_log() should IMHO be able to hide the complexity of the
> versions.

    Yes , this one I will fix in next patch.
> 
>> +	}
>>  }
>> 
>>  /*
>> @@ -1079,8 +1127,10 @@ static int write_data_dma(struct 
>> qcom_nand_controller *nandc, int reg_off,
>>   * Helper to prepare DMA descriptors for configuring registers
>>   * before reading a NAND page.
>>   */
>> -static void config_nand_page_read(struct qcom_nand_controller *nandc)
>> +static void config_nand_page_read(struct nand_chip *chip)
>>  {
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +
> 
> I don't get why you change the parameter from nandc to chip. Honnestly
> I don't think it is a bad thing, I'm just curious to understand why. If
> you want to do that, please start with a first patch just doing the
> conversion, and then a second patch adding LAST_CW support. Otherwise
> it is blurry.

   Yes, here its not needed to change nandc to chip, i will revert this 
in next patch.
> 
>>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>>  	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>> @@ -1094,11 +1144,19 @@ static void config_nand_page_read(struct 
>> qcom_nand_controller *nandc)
>>   * before reading each codeword in NAND page.
>>   */
>>  static void
>> -config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>> +config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
>>  {
>> -	if (nandc->props->is_bam)
>> -		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>> -			      NAND_BAM_NEXT_SGL);
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +
>> +	if (nandc->props->is_bam) {
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0, 4,
>> +				      NAND_BAM_NEXT_SGL);
>> +		else
>> +			write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>> +				      NAND_BAM_NEXT_SGL);
>> +	}
> 
> Same here, I am pretty sure we can abstract the complexity.
> 
    Here I did this because , i need pointer to struct nand_ecc_ctrl 
structure
    to access ecc->steps for CW comparison for last code word. cw == 
(ecc->steps - 1)

    So i think no separate patch needed for conversion of nanc-->chip.
    Please let me know if still separate patch needed for nanc-->chip 
conversion.

>> 
>>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> @@ -1117,11 +1175,11 @@ config_nand_cw_read(struct 
>> qcom_nand_controller *nandc, bool use_ecc)
>>   * single codeword in page
>>   */
>>  static void
>> -config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
>> -				bool use_ecc)
>> +config_nand_single_cw_page_read(struct nand_chip *chip,
>> +				bool use_ecc, int cw)
>>  {
>> -	config_nand_page_read(nandc);
>> -	config_nand_cw_read(nandc, use_ecc);
>> +	config_nand_page_read(chip);
>> +	config_nand_cw_read(chip, use_ecc, cw);
>>  }
>> 
>>  /*
>> @@ -1205,7 +1263,7 @@ static int nandc_param(struct qcom_nand_host 
>> *host)
>>  		nandc_set_reg(nandc, NAND_DEV_CMD_VLD_RESTORE, nandc->vld);
>>  	}
>> 
>> -	nandc_set_read_loc(nandc, 0, 0, 512, 1);
>> +	nandc_set_read_loc(chip, 0, 0, 0, 512, 1);
>> 
>>  	if (!nandc->props->qpic_v2) {
>>  		write_reg_dma(nandc, NAND_DEV_CMD_VLD, 1, 0);
>> @@ -1215,7 +1273,7 @@ static int nandc_param(struct qcom_nand_host 
>> *host)
>>  	nandc->buf_count = 512;
>>  	memset(nandc->data_buffer, 0xff, nandc->buf_count);
>> 
>> -	config_nand_single_cw_page_read(nandc, false);
>> +	config_nand_single_cw_page_read(chip, false, 0);
>> 
>>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
>>  		      nandc->buf_count, 0);
>> @@ -1617,7 +1675,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, 
>> struct nand_chip *chip,
>>  	clear_bam_transaction(nandc);
>>  	set_address(host, host->cw_size * cw, page);
>>  	update_rw_regs(host, 1, true);
>> -	config_nand_page_read(nandc);
>> +	config_nand_page_read(chip);
>> 
>>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>>  	oob_size1 = host->bbm_size;
>> @@ -1633,19 +1691,19 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, 
>> struct nand_chip *chip,
>>  	}
>> 
>>  	if (nandc->props->is_bam) {
>> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
>> +		nandc_set_read_loc(chip, cw, 0, read_loc, data_size1, 0);
>>  		read_loc += data_size1;
>> 
>> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>> +		nandc_set_read_loc(chip, cw, 1, read_loc, oob_size1, 0);
>>  		read_loc += oob_size1;
>> 
>> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>> +		nandc_set_read_loc(chip, cw, 2, read_loc, data_size2, 0);
>>  		read_loc += data_size2;
>> 
>> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>> +		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
>>  	}
>> 
>> -	config_nand_cw_read(nandc, false);
>> +	config_nand_cw_read(chip, false, cw);
>> 
>>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>>  	reg_off += data_size1;
>> @@ -1856,7 +1914,7 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>>  	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
>>  	int i, ret;
>> 
>> -	config_nand_page_read(nandc);
>> +	config_nand_page_read(chip);
>> 
>>  	/* queue cmd descs for each codeword */
>>  	for (i = 0; i < ecc->steps; i++) {
>> @@ -1873,18 +1931,16 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>> 
>>  		if (nandc->props->is_bam) {
>>  			if (data_buf && oob_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
>> -				nandc_set_read_loc(nandc, 1, data_size,
>> -						   oob_size, 1);
>> +				nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
>> +				nandc_set_read_loc(chip, i, 1, data_size, oob_size, 1);
>>  			} else if (data_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>> +				nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
>>  			} else {
>> -				nandc_set_read_loc(nandc, 0, data_size,
>> -						   oob_size, 1);
>> +				nandc_set_read_loc(chip, i, 0, data_size, oob_size, 1);
>>  			}
>>  		}
>> 
>> -		config_nand_cw_read(nandc, true);
>> +		config_nand_cw_read(chip, true, i);
>> 
>>  		if (data_buf)
>>  			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
>> @@ -1946,7 +2002,7 @@ static int copy_last_cw(struct qcom_nand_host 
>> *host, int page)
>>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
>>  	update_rw_regs(host, 1, true);
>> 
>> -	config_nand_single_cw_page_read(nandc, host->use_ecc);
>> +	config_nand_single_cw_page_read(chip, host->use_ecc, ecc->steps - 
>> 1);
>> 
>>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
>> 
> 
> Thanks,
> Miquèl
