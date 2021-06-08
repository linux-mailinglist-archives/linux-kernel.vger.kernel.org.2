Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B187B39EEFA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 08:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhFHGw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 02:52:59 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37701 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230333AbhFHGw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 02:52:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623135064; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=n87uwvqbLJztRaQiw/G8q/CEOFnnS1bJEZqwQkh7Nbw=;
 b=a9ZRuhWA6/dyWdZu95m90zYMRKRtQhJcUiViapt9lbqS4tih/mB8zJ5ODVmc7+q7o6E/k69Z
 TsTl8PiJPrs+ttXhBX/GGYZScRggWWErEkbn+abn/ox2VQ89MRKNNzAY4AehK2eZsrtwM+MC
 nEtixp3+s4kNjE4IS/D91J8XZjg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60bf1342f726fa4188786395 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 08 Jun 2021 06:50:42
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F4B1C4338A; Tue,  8 Jun 2021 06:50:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9D16C433D3;
        Tue,  8 Jun 2021 06:50:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 08 Jun 2021 12:20:40 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: avoid writing to obsolete register
In-Reply-To: <20210607115041.21e21e19@xps13>
References: <1623059017-5058-1-git-send-email-mdalam@codeaurora.org>
 <20210607115041.21e21e19@xps13>
Message-ID: <f30e4b983e92dd474a208039bcfdf0ad@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-07 15:20, Miquel Raynal wrote:
> Hello,
> 
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon,  7 Jun 2021
> 15:13:37 +0530:
> 
>> QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
>> Avoid writing this register if QPIC version is V2.0 or newer.
>> 
>> Also fixed nandc undeclared issue reported by,
>> 
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> This tag should only be added when you fix something that is already in
> mainline. The Reported-by here points to v2, which makes no sense.
> Please drop it.

  updated this V4 patch.
> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
>> [V3]
>>  * Fixed nandc undeclared issue.
>>  drivers/mtd/nand/raw/qcom_nandc.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index a64fb6c..ee5985d 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -734,6 +734,7 @@ static void update_rw_regs(struct qcom_nand_host 
>> *host, int num_cw, bool read, i
>>  {
>>  	struct nand_chip *chip = &host->chip;
>>  	u32 cmd, cfg0, cfg1, ecc_bch_cfg;
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> 
>>  	if (read) {
>>  		if (host->use_ecc)
>> @@ -762,7 +763,8 @@ static void update_rw_regs(struct qcom_nand_host 
>> *host, int num_cw, bool read, i
>>  	nandc_set_reg(chip, NAND_DEV0_CFG0, cfg0);
>>  	nandc_set_reg(chip, NAND_DEV0_CFG1, cfg1);
>>  	nandc_set_reg(chip, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
>> -	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>> +	if (!nandc->props->qpic_v2)
>> +		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>>  	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
>>  	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
>>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
>> @@ -1133,7 +1135,8 @@ static void config_nand_page_read(struct 
>> nand_chip *chip)
>> 
>>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>> -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>> +	if (!nandc->props->qpic_v2)
>> +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>>  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
>>  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>> @@ -1191,8 +1194,9 @@ static void config_nand_page_write(struct 
>> nand_chip *chip)
>> 
>>  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>> -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
>> -		      NAND_BAM_NEXT_SGL);
>> +	if (!nandc->props->qpic_v2)
>> +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
>> +			      NAND_BAM_NEXT_SGL);
>>  }
>> 
>>  /*
>> @@ -1248,7 +1252,8 @@ static int nandc_param(struct qcom_nand_host 
>> *host)
>>  					| 2 << WR_RD_BSY_GAP
>>  					| 0 << WIDE_FLASH
>>  					| 1 << DEV0_CFG1_ECC_DISABLE);
>> -	nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << 
>> ECC_CFG_ECC_DISABLE);
>> +	if (!nandc->props->qpic_v2)
>> +		nandc_set_reg(chip, NAND_EBI2_ECC_BUF_CFG, 1 << 
>> ECC_CFG_ECC_DISABLE);
>> 
>>  	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>>  	if (!nandc->props->qpic_v2) {
>> @@ -2689,7 +2694,8 @@ static int qcom_nand_attach_chip(struct 
>> nand_chip *chip)
>>  				| ecc_mode << ECC_MODE
>>  				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
>> 
>> -	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
>> +	if (!nandc->props->qpic_v2)
>> +		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
>> 
>>  	host->clrflashstatus = FS_READY_BSY_N;
>>  	host->clrreadstatus = 0xc0;
> 
> 
> Thanks,
> Miquèl
