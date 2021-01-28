Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927123080BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 22:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhA1Vto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 16:49:44 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:31811 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1Vtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 16:49:43 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611870556; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=QPIEjZKvgdeO2BUqX8enyP4sqNbzs/o8VkfIbx9QDCk=;
 b=vc5RnckovSRpOR9m9hr3t/ltHzhPqspGufKRpvLdnrN0ekaiS4CqPdfgyCJAdz3bKB8Zhdvk
 5Y+nWrF9pf+aZus7kyfXFwnLZHrZDySq3WafkMY121Vk8dobNwnTHzMB6CAh6oaceteGJFif
 0Gu1lFMCkCpVsYHJPwUNJISkizo=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60133141d08556f455303700 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 Jan 2021 21:48:48
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B76D6C43465; Thu, 28 Jan 2021 21:48:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82169C433CA;
        Thu, 28 Jan 2021 21:48:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 29 Jan 2021 03:18:46 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     manivannan.sadhasivam@linaro.org, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210114165325.3d510355@xps13>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
 <20210114165325.3d510355@xps13>
Message-ID: <769ea3fe77eab9b37d863251e97bcb29@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-14 21:23, Miquel Raynal wrote:
> Hello,
> 
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Sun, 10 Jan 2021
> 09:31:45 +0530:
> 
>> From QPIC version 2.0 onwards new register got added to
> 
>                                 a
> 
>> read last codeword. This change will update the same.
> 
>        the?           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                       Please reword this sentence.

   Fixed this in V4 patch.
> 
>> For first three code word READ_LOCATION_n register will be
>> use.For last code word READ_LOCATION_LAST_CW_n register will be
>> use.
> 
> "For the first three codewords, READ_LOCATION_n registers will be used.
> The last codeword register will be accessed through
> READ_LOCATION_LAST_CW_n."
> 
> Also, please specify what these registers store.

   The location register is mainly use for reading controller
   buffer via BAM mode. The bits of the register 
"NAND_READ_LOCATION_LAST_CW_n, n=0..4"
   as follow:
   [9:0]-bits : (OFFSET) This bit defines the offset from the buffer base 
address to be picked up for DMA.
   [25:16]-bits: (SIZE) This bit of every register will define the size 
of the chunk for DMA.
   31-bit :      (LAST) If this bit is set, the controller takes the 
particular register to specify the last chunk
                       of data made available for DMA. This chunk is part 
of the internal buffer of the controller.

> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> 
> Could someone please test this patch?

   I have tested this patch on IPQ5018 platform and its working fine.
> 
>> ---
>> [V3]
>>  * Added else condition for last code word in update_rw_regs().
>>  drivers/mtd/nand/raw/qcom_nandc.c | 84 
>> ++++++++++++++++++++++++++++++++-------
>>  1 file changed, 70 insertions(+), 14 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 667e4bf..50ff6e3 100644
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
>> @@ -187,6 +191,12 @@ nandc_set_reg(nandc, 
>> NAND_READ_LOCATION_##reg,			\
>>  	      ((size) << READ_LOCATION_SIZE) |			\
>>  	      ((is_last) << READ_LOCATION_LAST))
>> 
>> +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
>> +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
>> +	      ((offset) << READ_LOCATION_OFFSET) |		\
>> +	      ((size) << READ_LOCATION_SIZE) |			\
>> +	      ((is_last) << READ_LOCATION_LAST))
>> +
>>  /*
>>   * Returns the actual register address for all NAND_DEV_ registers
>>   * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and 
>> NAND_DEV_CMD_VLD)
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
>> @@ -719,9 +741,14 @@ static void update_rw_regs(struct qcom_nand_host 
>> *host, int num_cw, bool read)
>>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>> 
>> -	if (read)
>> -		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
>> -				   host->cw_data : host->cw_size, 1);
>> +	if (read) {
>> +		if (nandc->props->qpic_v2)
>> +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
>> +					host->cw_data : host->cw_size, 1);
>> +		else
>> +			nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
>> +					host->cw_data : host->cw_size, 1);
>> +	}
>>  }
>> 
>>  /*
>> @@ -1096,9 +1123,13 @@ static void config_nand_page_read(struct 
>> qcom_nand_controller *nandc)
>>  static void
>>  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>>  {
>> -	if (nandc->props->is_bam)
>> +	if (nandc->props->is_bam) {
>> +		if (nandc->props->qpic_v2)
>> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
>> +				      1, NAND_BAM_NEXT_SGL);
>>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>>  			      NAND_BAM_NEXT_SGL);
>> +	}
>> 
>>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> @@ -1633,16 +1664,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, 
>> struct nand_chip *chip,
>>  	}
>> 
>>  	if (nandc->props->is_bam) {
>> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> 
> You repeat many times this logic, a helper to avoid this extra
> indentation level with the if/else block is needed.

   Fixed this V4 patch.
> 
>>  		read_loc += data_size1;
>> 
>> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>>  		read_loc += oob_size1;
>> 
>> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>>  		read_loc += data_size2;
>> 
>> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>>  	}
> 
> Thanks,
> Miquèl
