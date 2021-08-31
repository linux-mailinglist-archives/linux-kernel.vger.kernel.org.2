Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3843FC48C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhHaI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 04:59:50 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:25146 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240485AbhHaI7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 04:59:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630400335; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=872jpT5jHze6g6lhPt8zyPTtyQ+QBI5L9Uk7NxSX3oQ=;
 b=q2BCKuIhnt5tvcbsOPLggh2xLhZttc7S2usHRffJDIdSkTUZ4buoYXzG6Un0tS8AJMGnY3Ek
 7xmZWaLHNeChP/jv1Spb87fLCftlBiHEs5K5iVtM0rC4nNm7yaPiy2BgtfmsID1pXjCFBRN6
 xrUhJlMwWegJ6q9ZCNZtnTIJJcY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 612def4e4f8fcf7054e6c5ec (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 31 Aug 2021 08:58:54
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E80A5C4360D; Tue, 31 Aug 2021 08:58:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22542C4338F;
        Tue, 31 Aug 2021 08:58:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 31 Aug 2021 14:28:53 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: Update code word value for raw read
In-Reply-To: <20210830095607.6be588fe@xps13>
References: <1629973862-7248-1-git-send-email-mdalam@codeaurora.org>
 <20210830095607.6be588fe@xps13>
Message-ID: <08fc4c79c5dbbf40780fb64d37276eb6@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-30 13:26, Miquel Raynal wrote:
> Hello
> 
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Thu, 26 Aug 2021
> 16:01:02 +0530:
> 
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
> 
> Fixes/Cc: stable tags are missing?

   Updated in V2 patch
> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
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
> 
> Thanks,
> Miquèl
