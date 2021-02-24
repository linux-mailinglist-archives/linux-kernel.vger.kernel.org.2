Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435B1323677
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 05:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhBXEku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 23:40:50 -0500
Received: from z11.mailgun.us ([104.130.96.11]:14811 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhBXEks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 23:40:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614141629; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=+B0mH6apvUdJkS+cEEk0LUEvE5wfHcYOXZMmbJjRkb0=;
 b=bZ+J3yD0QojS+3MW8LoYCDxc7NZgHO7omh+cCzBgj7i60DylYZk8o13HO+jh4VlZ7xHdMKt7
 jvox4WRCS57UA+ViEvB2U/cdP8oPpfdpl4LUzzHcmi556uZWGWT9q/4EAHHI7KVDMkjNvJCB
 Bo862zYFGeZX3uFDwHyEe8o3ssE=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6035d895090a7742874b9dfa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 04:39:49
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2FC35C433CA; Wed, 24 Feb 2021 04:39:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A7DCC433C6;
        Wed, 24 Feb 2021 04:39:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 24 Feb 2021 10:09:48 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org, mdalam=codeaurora.org@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
In-Reply-To: <a5650f33b493b987d45525ea57fdfd8a@codeaurora.org>
References: <1614024267-12529-1-git-send-email-mdalam@codeaurora.org>
 <20210223173449.1a55df1e@xps13>
 <a5650f33b493b987d45525ea57fdfd8a@codeaurora.org>
Message-ID: <38da9d1d4a96f1b42ba0b194da265e6b@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-24 01:13, mdalam@codeaurora.org wrote:
> On 2021-02-23 22:04, Miquel Raynal wrote:
>> Hello,
>> 
>> Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue, 23 Feb 2021
>> 01:34:27 +0530:
>> 
>>> From QPIC version 2.0 onwards new register got added to read last
>> 
>>                                a new
>> 
>>> codeword. This change will add the READ_LOCATION_LAST_CW_n register.
>> 
>>             Add support for this READ_LOCATION_LAST_CW_n register.
>> 
>>> 
>>> For first three code word READ_LOCATION_n register will be
>>> use.For last code word READ_LOCATION_LAST_CW_n register will be
>>> use.
>> 
>> "
>> In the case of QPIC v2, codewords 0, 1 and 2 will be accessed through
>> READ_LOCATION_n, while codeword 3 will be accessed through
>> READ_LOCATION_LAST_CW_n.
>> "
>> 
>> When I read my own sentence, I feel that there is something wrong.
>> If there are only 4 codewords, I guess a QPIC v2 is able to use
>> READ_LOCATION_3 or READ_LOCATION_LAST_CW_0 interchangeably. Isn't it?
>> 
>> I guess the point of having these "last_cw_n" registers is to support
>> up to 8 codewords, am I wrong? If this the case, the current patch
>> completely fails doing that I don't get the point of such change.
> 
> This register is only use to read last code word.
> 
> I have address all the comments from all the previous sub sequent
> patches and pushed
> all patches in only one series.
> 
> Please check.

  The registers READ_LOCATION & READ_LOCATION_LAST are not associated 
with number of code words.
  These two registers are used to access the location inside a code word. 
So whether we are having 4 code words
  or 8 code words it doesn't matter. If we wanted access the location 
within normal code word we have to
  use READ_LOCATION register and if we wanted to access location in last 
code word then we have to use
  READ_LOCATION_LAST.
> 
>> 
>>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>>> ---
>> 
>> [...]
>> 
>>>  /* helper to configure address register values */
>>> @@ -700,8 +727,9 @@ static void set_address(struct qcom_nand_host 
>>> *host, u16 column, int page)
>>>   *
>>>   * @num_cw:		number of steps for the read/write operation
>>>   * @read:		read or write operation
>>> + * @cw	:		which code word
>>>   */
>>> -static void update_rw_regs(struct qcom_nand_host *host, int num_cw, 
>>> bool read)
>>> +static void update_rw_regs(struct qcom_nand_host *host, int num_cw, 
>>> bool read, int cw)
>>>  {
>>>  	struct nand_chip *chip = &host->chip;
>>>  	struct qcom_nand_controller *nandc = 
>>> get_qcom_nand_controller(chip);
>>> @@ -740,7 +768,7 @@ static void update_rw_regs(struct qcom_nand_host 
>>> *host, int num_cw, bool read)
>>>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>>> 
>>>  	if (read)
>>> -		nandc_set_read_loc(chip, 0, 0, 0, host->use_ecc ?
>>> +		nandc_set_read_loc(chip, cw, 0, 0, host->use_ecc ?
>>>  				   host->cw_data : host->cw_size, 1);
>>>  }
>>> 
>>> @@ -1111,18 +1139,34 @@ static void config_nand_page_read(struct 
>>> nand_chip *chip)
>>>  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>>>  }
>>> 
>>> +/* helper to check which location register should be use for this
>> 
>>     /*
>>      * Check which location...
>> 
>>> + * code word. NAND_READ_LOCATION or NAND_READ_LOCATION_LAST_CW
>>> + */
>>> +static bool config_loc_last_reg(struct nand_chip *chip, int cw)
>>> +{
>>> +	struct qcom_nand_controller *nandc = 
>>> get_qcom_nand_controller(chip);
>>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>> +
>>> +	if (nandc->props->qpic_v2 && qcom_nandc_is_last_cw(ecc, cw))
>>> +		return true;
>> 
>> Not sure this is really useful, it's probably better to drop this
>> helper and just use...
>> 
>>> +
>>> +	return false;
>>> +}
>>>  /*
>>>   * Helper to prepare DMA descriptors for configuring registers
>>>   * before reading each codeword in NAND page.
>>>   */
>>>  static void
>>> -config_nand_cw_read(struct nand_chip *chip, bool use_ecc)
>>> +config_nand_cw_read(struct nand_chip *chip, bool use_ecc, int cw)
>>>  {
>>>  	struct qcom_nand_controller *nandc = 
>>> get_qcom_nand_controller(chip);
>>> +	int reg = NAND_READ_LOCATION_0;
>>> +
>>> +	if (config_loc_last_reg(chip, cw))
>> 
>> ...     if (nandc->props->qpic_v2 && qcom_nandc_is_lastcw()) here.
>> 
>>> +		reg = NAND_READ_LOCATION_LAST_CW_0;
>>> 
>>>  	if (nandc->props->is_bam)
>>> -		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>>> -			      NAND_BAM_NEXT_SGL);
>>> +		write_reg_dma(nandc, reg, 4, NAND_BAM_NEXT_SGL);
>>> 
>>>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>>> @@ -1142,12 +1186,12 @@ config_nand_cw_read(struct nand_chip *chip, 
>>> bool use_ecc)
>> 
>> Thanks,
>> Miquèl
