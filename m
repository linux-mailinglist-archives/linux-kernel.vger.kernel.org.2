Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F386331C25D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhBOTUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:20:12 -0500
Received: from z11.mailgun.us ([104.130.96.11]:55637 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229764AbhBOTUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:20:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613416783; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=j/f3tmtSL2nPpj1djxZ+o8iXqVNVb7TVceUokeZt5Wc=;
 b=DXp0OVnDppev+Y5nOmdCaB9zZ8mh/cb8oBc70ub2fw9SpEF8M9ijDRzGgK1HTYJMAr/TEN/8
 mRdJRDIx2M5xchHwcTytTzAMmhtcuBPl0tQ75LwAqUd7oxTWxGEDWWmWnvthW3JIhwdWdscg
 FyNyT7MG5v/gY9VIZtJug0ujJsM=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 602ac92c81f6c45dce37db96 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Feb 2021 19:19:08
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 300C9C43466; Mon, 15 Feb 2021 19:19:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3C8EC433C6;
        Mon, 15 Feb 2021 19:19:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 16 Feb 2021 00:49:05 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, boris.brezillon@collabora.com,
        mani@kernel.org, krzk@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20210215094055.1c3847f8@xps13>
References: <1613337451-8002-1-git-send-email-mdalam@codeaurora.org>
 <20210215094055.1c3847f8@xps13>
Message-ID: <e4658795d5a00960b32116a81d43222f@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-15 14:10, Miquel Raynal wrote:
> Hello,
> 
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Mon, 15 Feb 2021
> 02:47:31 +0530:
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
>> [V5]
>>  * Added helper function to update location register value.
> 
> 
> Please don't forget the "v5" in the message object.
> 
>>  /*
>> @@ -1094,11 +1141,16 @@ static void config_nand_page_read(struct 
>> qcom_nand_controller *nandc)
>>   * before reading each codeword in NAND page.
>>   */
>>  static void
>> -config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>> +config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc, 
>> bool last_cw)
>>  {
>> -	if (nandc->props->is_bam)
>> -		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>> -			      NAND_BAM_NEXT_SGL);
>> +	if (nandc->props->is_bam) {
>> +		if (nandc->props->qpic_v2 && last_cw)
>> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0, 4,
>> +				      NAND_BAM_NEXT_SGL);
>> +		else
>> +			write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>> +				      NAND_BAM_NEXT_SGL);
> 
> I guess write_reg_dma should be updated as well.

   Updated in V6 patch , please check.
> 
> 
> [...]
> 
>> 
>> -	config_nand_cw_read(nandc, false);
>> +	config_nand_cw_read(nandc, false, cw == ecc->steps - 1 ? true : 
>> false);
>> 
>>  	read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>>  	reg_off += data_size1;
>> @@ -1873,18 +1938,31 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>> 
>>  		if (nandc->props->is_bam) {
>>  			if (data_buf && oob_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
>> -				nandc_set_read_loc(nandc, 1, data_size,
>> -						   oob_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
> 
> I would like the helper to handle this condition. I would prefer to
> avoid yet an extra indentation level.

   Updated in V6 patch , please check.
> 
>> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
>> +					nandc_set_read_loc(chip, i, 1, data_size,
>> +							   oob_size, 1);
>> +				} else {
>> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 0);
>> +					nandc_set_read_loc(chip, i, 1, data_size,
>> +							   oob_size, 1);
>> +				}
>>  			} else if (data_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
>> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
>> +				else
>> +					nandc_set_read_loc(chip, i, 0, 0, data_size, 1);
>>  			} else {
>> -				nandc_set_read_loc(nandc, 0, data_size,
>> -						   oob_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
>> +					nandc_set_read_loc(chip, i, 0, data_size,
>> +							   oob_size, 1);
>> +				else
>> +					nandc_set_read_loc(chip, i, 0, data_size,
>> +							   oob_size, 1);
>>  			}
>>  		}
>> 
>> -		config_nand_cw_read(nandc, true);
>> +		config_nand_cw_read(nandc, true, i == ecc->steps - 1 ? true : 
>> false);
> 
> 	i == (ecc->steps - 1)
> 
> is already a boolean, you don't need
> 
> 	"? true : false"
> 

    Updated in V6 patch.

>> 
>>  		if (data_buf)
>>  			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
>> @@ -1946,7 +2024,7 @@ static int copy_last_cw(struct qcom_nand_host 
>> *host, int page)
>>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
>>  	update_rw_regs(host, 1, true);
>> 
>> -	config_nand_single_cw_page_read(nandc, host->use_ecc);
>> +	config_nand_single_cw_page_read(nandc, host->use_ecc, true);
> 
> Maybe it's best to just forward the codeword and let the code that
> needs to know if it is the last one or not do the comparison.
> 

   Updated in V6 patch, please check.
>> 
>>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
>> 
> 
> Thanks,
> Miquèl
