Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395A23FE8EC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 07:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhIBFy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 01:54:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12338 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbhIBFyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 01:54:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630562037; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mCYZzY8OT8rVEtmVK5dyJIyO9quIyexdFce4ZNsAP0U=;
 b=DSs5gxazDHdgo8allDmzWO50a2ginGl88IH6vxX45R3r/RYf5P4YB/V8JhqYh74q3UIFcLUG
 4M2I2p/o7xOykp1Jm0N9Pieo2xlQck6TlCr/9687NZPXopI6fARsa76q8kIpiEc4TY+CM8kA
 jaYv9RsVGZ0A59zlE7dzjCIiRFA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 613066eae0fcecca19a4f905 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 02 Sep 2021 05:53:46
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3C90C43460; Thu,  2 Sep 2021 05:53:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8A94DC4338F;
        Thu,  2 Sep 2021 05:53:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 02 Sep 2021 11:23:43 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org,
        stable@kernel.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: Update code word value for raw
 read
In-Reply-To: <20210901163615.090c6f24@xps13>
References: <1630493613-8158-1-git-send-email-mdalam@codeaurora.org>
 <20210901163615.090c6f24@xps13>
Message-ID: <b6473b7de57aa10682a5ca1651f6e620@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-01 20:06, Miquel Raynal wrote:
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Wed,  1 Sep 2021
> 16:23:33 +0530:
> 
>> Fixes: 503ee5aa ("mtd: rawnand: qcom: update last code word register")
>> Cc: stable@kernel.org
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
>> [V3]
>>  * Added Fixes tag
>>  * Removed change log from commit message.
>> 
>>     From QPIC V2 onwards there is a separate register to read
>>     last code word "QPIC_NAND_READ_LOCATION_LAST_CW_n".
>> 
>>     qcom_nandc_read_cw_raw() is used to read only one code word
>>     at a time. If we will configure number of code words to 1 in
>>     in QPIC_NAND_DEV0_CFG0 register then QPIC controller thinks
>>     its reading the last code word, since from QPIC V2 onwards
>>     we are having separate register to read the last code word,
>>     we have to configure "QPIC_NAND_READ_LOCATION_LAST_CW_n"
>>     register to fetch data from controller buffer to system
>>     memory.
> 
> Really?
> 
> It's not your first contribution, you know what a changelog is and what
> a commit message is, right? So please, keep the commit message
> ("why" your change is needed) where it was and only put
> the changelog (the differences between two versions) below the three
> dashes '---'.
> 
   Sorry for misinterpreting your comments.

   I have addressed your comment in patch V4

>> 
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
