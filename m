Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2953084F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 06:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhA2FNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 00:13:25 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:33967 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhA2FNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 00:13:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611897160; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=M4x1gFjbxaSmRjiYzlWH8xYLz+ryQTEPMObAc2+bJWg=;
 b=ZYBvs8U5iccyr1RDE62SeoG6vg6Rd34Ccq+aenF12cVCujIFwuDaScC2k8CuQHsF2lQX6vHB
 JDbmbOoYmolAVBnYY4pbMjc35Xy9QGsXb4fp650kokAviL1oNJkfNpB89Vs7YPhszDKk56Gt
 NFlgAGCl9xm2EmhcDn0M8Wz+P3g=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60139922bcde412162827529 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 Jan 2021 05:12:02
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53E04C43466; Fri, 29 Jan 2021 05:12:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCBB8C433C6;
        Fri, 29 Jan 2021 05:11:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Jan 2021 10:41:59 +0530
From:   mdalam@codeaurora.org
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210128075248.GA31543@thinkpad>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
 <20210128075248.GA31543@thinkpad>
Message-ID: <b46d212665a3054d736de2cae61e209c@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28 13:22, Manivannan Sadhasivam wrote:
> On Sun, Jan 10, 2021 at 09:31:45AM +0530, Md Sadre Alam wrote:
>> From QPIC version 2.0 onwards new register got added to
>> read last codeword. This change will update the same.
>> 
>> For first three code word READ_LOCATION_n register will be
>> use.For last code word READ_LOCATION_LAST_CW_n register will be
>> use.
>> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> 
> I gave this patch a try on SDX55 board but not able to resolve an issue 
> and
> I think it is related to reading the last code word which this patch is 
> trying
> to address. For my patch on supporting QPIC v2 IP, I tested with 
> SDX55-MTP board
> and I never hit any issue. But on my new dev board (Telit FN980), there 
> seems to
> be an issue while populating the partitions and tracing down that bug 
> lands me
> in copy_last_cw() function.
> 
> The issue only happens while creating the 3rd partition on Telit board 
> whose
> size differs when compared with MTP. The board just reboots into QDL 
> mode
> whenever it tries to read the last code word.
> 
> Below is the snippet of partition layout:
> 
> Telit partitions:
> 
> [    1.082015] 0: sbl offs=0x00000000 size=0x0000000a attr:0x000000ff
> [    1.082702] 1: mibib offs=0x0000000a size=0x0000000a attr:0x000000ff
> [    1.083488] 2: ico offs=0x00000014 size=0x00000014 attr:0x000000ff
> [    1.084572] 3: efs2 offs=0x00000028 size=0x0000002c attr:0x000000ff
> [    1.085316] 4: tz offs=0x00000054 size=0x00000007 attr:0x000000ff
> [    1.086089] 5: tz_devcfg offs=0x0000005b size=0x00000004 
> attr:0x000000ff
> ....
> 
> MTP partitions:
> 
> [    1.573871] 0: sbl offs=0x00000000 size=0x0000000a attr:0x000000ff
> [    1.581139] 1: mibib offs=0x0000000a size=0x0000000a attr:0x000000ff
> [    1.587362] 2: efs2 offs=0x00000014 size=0x0000002c attr:0x000000ff
> [    1.593853] 3: tz offs=0x00000040 size=0x00000007 attr:0x000000ff
> [    1.599860] 4: tz_devcfg offs=0x00000047 size=0x00000004 
> attr:0x000000ff
> ...
> 
> So until I figure this out, please keep this patch on hold!

   There was some corner case I missed in V3 patch. I have fixed this in 
V4 patch.
   I have done some tress testing as well with V4 patch on IPQ5018 
platform using "nand-utils"
   and "mtd_test.ko" , Now its working fine. Can you test with V4 patch 
once.
> 
> Thanks,
> Mani
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
>> 
>>  	config_nand_cw_read(nandc, false);
>> @@ -1873,14 +1916,27 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>> 
>>  		if (nandc->props->is_bam) {
>>  			if (data_buf && oob_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
>> -				nandc_set_read_loc(nandc, 1, data_size,
>> -						   oob_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
>> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);
>> +					nandc_set_read_loc_last(nandc, 1, data_size,
>> +								oob_size, 1);
>> +				} else {
>> +					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
>> +					nandc_set_read_loc(nandc, 1, data_size,
>> +							   oob_size, 1);
>> +				}
>>  			} else if (data_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
>> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
>> +				else
>> +					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>>  			} else {
>> -				nandc_set_read_loc(nandc, 0, data_size,
>> -						   oob_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
>> +					nandc_set_read_loc_last(nandc, 0, data_size,
>> +								oob_size, 1);
>> +				else
>> +					nandc_set_read_loc(nandc, 0, data_size,
>> +							   oob_size, 1);
>>  			}
>>  		}
>> 
>> --
>> 2.7.4
>> 
