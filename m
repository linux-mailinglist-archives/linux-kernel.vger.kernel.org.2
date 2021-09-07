Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BF9402380
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhIGGgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:36:53 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46291 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231429AbhIGGgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:36:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630996547; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Xc048QqgaI2ANyWI4pqRHNZXsACOQ6mJX1gQ/QPaTW4=;
 b=a0/dFf7jn/mxBlpeiw1Ens/5sl8WRIi5tUwtkgfufuvBl7PAkSINsIKfjauxzU7SZfcDwp3C
 xevu0Imz2Tj1YSUq3Xi/1W6Qakxpy1uB8/4tzN53uehohPzWkqLOPuR0klGibcI2EchSEGgQ
 Sw0MJE00JQMulqAt6Qyg56Y1hbU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 613708416fc2cf7ad9580159 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Sep 2021 06:35:45
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3224AC43616; Tue,  7 Sep 2021 06:35:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42F04C4338F;
        Tue,  7 Sep 2021 06:35:42 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Sep 2021 12:05:42 +0530
From:   mdalam@codeaurora.org
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org,
        stable@kernel.org
Subject: Re: [PATCH V4] mtd: rawnand: qcom: Update code word value for raw
 read
In-Reply-To: <20210902091730.GA10844@workstation>
References: <1630561763-18486-1-git-send-email-mdalam@codeaurora.org>
 <20210902091730.GA10844@workstation>
Message-ID: <3ea25e979fc8c965820596ec86c61172@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-02 14:47, Manivannan Sadhasivam wrote:
> On Thu, Sep 02, 2021 at 11:19:23AM +0530, Md Sadre Alam wrote:
>> From QPIC V2 onwards there is a separate register to read
>> last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
>> 
>> qcom_nandc_read_cw_raw() is used to read only one code word
>> at a time. If we will configure number of code words to 1 in
>> in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
>> its reading the last code word, since from QPIC V2 onwards
>> we are having separate register to read the last code word,
>> we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
>> register to fetch data from controller buffer to system
>> memory.
>> 
>> Fixes: 503ee5aa ("mtd: rawnand: qcom: update last code word register")
> 
> Commit hash should be of 12 digits.

   Updated in patch V5
> 
>> Cc: stable@kernel.org
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
>> [V4]
>>  * Added commit message
>>  * Added changelog
>> 
>>  In commit 503ee5aa added QPIC V2 support. Since QPIC V2 onwards there
>>  is separate register to get last CW data. If total number of CW 
>> configred is 1
>>  then , QPIC controller treat this as last CW and software shhould 
>> copy data to memory
>>  via QPIC_NAND_READ_LOCATION_LAST_CW_n register instead of 
>> QPIC_NAND_READ_LOCATION_n.
>>  Since in raw read we are configuring total number of CW 1, this 
>> change fixes
>>  this if total number of CW 1 then make this as last CW.  raw_cw = 
>> ecc->steps - 1;
>>  since ecc->steps holds total number of CWs.
>> 
> 
> This is not a changelog. Changelog should mention what has been changed
> between versions from v1 to v4. For example:
> 
> Changes in v4:
> 
> * Incorporated AAA comments from X
> * Changed a local variable
> 
> Changes in v3:
> 
> * Incorporated BBB comments from X
> 
> Changes in v2:
> 
> * Incorporated CCC comments from X

  Updated in patch V5
> 
>>  drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index ef0bade..04e6f7b 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -1676,13 +1676,17 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, 
>> struct nand_chip *chip,
>>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	int data_size1, data_size2, oob_size1, oob_size2;
>>  	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
>> +	int raw_cw = cw;
>> 
>>  	nand_read_page_op(chip, page, 0, NULL, 0);
>>  	host->use_ecc = false;
>> 
>> +	if (nandc->props->qpic_v2)
>> +		raw_cw = ecc->steps - 1;
>> +
> 
> Sorry, I don't understand how it can work. For reading a codeword like
> 0, you are reading the last codeword here if the controller is v2. And
> you'll continue to read the last codeword only for any codeword
> requested :/

   This case is only applicable when we will configure number of code 
words to 1.
   These registers "QPIC_NAND_READ_LOCATION_LAST_CW_n" & 
"QPIC_NAND_READ_LOCATION_n"
   are only used to copy data into memory i.e our local buffer. So this 
last CW interpretation from
   QPIC controller to memory not for Flash to QPIC controller.
   If number of CW configured to 1 means QPIC will treat this a last CW , 
so copy the data from QPIC to local memory
   buffer , we have to use QPIC_NAND_READ_LOCATION_LAST_CW_n register 
instead of QPIC_NAND_READ_LOCATION_n regsiter,
   Since there is separate register from QPIC V2 onwards to read get last 
CW "QPIC_NAND_READ_LOCATION_LAST_CW_n".


> 
> Thanks,
> Mani
> 
>>  	clear_bam_transaction(nandc);
>>  	set_address(host, host->cw_size * cw, page);
>> -	update_rw_regs(host, 1, true, cw);
>> +	update_rw_regs(host, 1, true, raw_cw);
>>  	config_nand_page_read(chip);
>> 
>>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>> @@ -1711,7 +1715,7 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, 
>> struct nand_chip *chip,
>>  		nandc_set_read_loc(chip, cw, 3, read_loc, oob_size2, 1);
>>  	}
>> 
>> -	config_nand_cw_read(chip, false, cw);
>> +	config_nand_cw_read(chip, false, raw_cw);
>> 
>>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>>  	reg_off += data_size1;
>> --
>> 2.7.4
>> 
