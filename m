Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75424378A91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 14:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbhEJLr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 07:47:29 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:39075 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233646AbhEJK7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:59:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620644321; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1V1hjNy0ikjEDcGsAysvLfVX9zgO6KrdzGI0V4yHr2Y=;
 b=B/nRmcCcHIotBNMIZaaBkuskEBGydLlRR2rUikivGJu2kpS9sU2LHNCOk+4XpS2h9RRPgfvI
 kA8v6mwpMoAgK4kkTg411n+qUlSm3jRDe9X6ggP0vjbgSsI4V1ng2ulOQQxeUftAU0L6IYcL
 C+osmDgwNhbkj4IeRxa8HBT1Zng=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 609911e0e0e9c9a6b6adc929 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 May 2021 10:58:40
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 585B3C43143; Mon, 10 May 2021 10:58:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 44379C43145;
        Mon, 10 May 2021 10:58:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 10 May 2021 16:28:33 +0530
From:   mdalam@codeaurora.org
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     mani@kernel.org, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: avoid write to obsolete register
In-Reply-To: <20210504085805.73e60979@xps13>
References: <1619205694-25645-1-git-send-email-mdalam@codeaurora.org>
 <2667b47434a8f2892ea3d5f304380960@codeaurora.org>
 <20210504085805.73e60979@xps13>
Message-ID: <e5d79f2b18ffe2dcdaa7d2c827d8472f@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-04 12:28, Miquel Raynal wrote:
> Hello,
> 
> mdalam@codeaurora.org wrote on Mon, 03 May 2021 20:24:54 +0530:
> 
>> On 2021-04-24 00:51, Md Sadre Alam wrote:
>> > QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
>> > Avoid writing this register if QPIC version is V2.0 or newer.
>> >
>> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> > ---
>> >  drivers/mtd/nand/raw/qcom_nandc.c | 17 +++++++++++------
>> >  1 file changed, 11 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
>> > b/drivers/mtd/nand/raw/qcom_nandc.c
>> > index fd4c318..8c5205c 100644
>> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> > @@ -714,7 +714,8 @@ static void update_rw_regs(struct qcom_nand_host
>> > *host, int num_cw, bool read)
>> >  	nandc_set_reg(nandc, NAND_DEV0_CFG0, cfg0);
>> >  	nandc_set_reg(nandc, NAND_DEV0_CFG1, cfg1);
>> >  	nandc_set_reg(nandc, NAND_DEV0_ECC_CFG, ecc_bch_cfg);
>> > -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>> > +	if (!nandc->props->qpic_v2)
>> > +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, host->ecc_buf_cfg);
>> >  	nandc_set_reg(nandc, NAND_FLASH_STATUS, host->clrflashstatus);
>> >  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>> >  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>> > @@ -1083,7 +1084,8 @@ static void config_nand_page_read(struct
>> > qcom_nand_controller *nandc)
>> >  {
>> >  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>> >  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>> > -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>> > +	if (!nandc->props->qpic_v2)
>> > +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1, 0);
>> >  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1, 0);
>> >  	write_reg_dma(nandc, NAND_ERASED_CW_DETECT_CFG, 1,
>> >  		      NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
>> > @@ -1132,8 +1134,9 @@ static void config_nand_page_write(struct
>> > qcom_nand_controller *nandc)
>> >  {
>> >  	write_reg_dma(nandc, NAND_ADDR0, 2, 0);
>> >  	write_reg_dma(nandc, NAND_DEV0_CFG0, 3, 0);
>> > -	write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
>> > -		      NAND_BAM_NEXT_SGL);
>> > +	if (!nandc->props->qpic_v2)
>> > +		write_reg_dma(nandc, NAND_EBI2_ECC_BUF_CFG, 1,
>> > +			      NAND_BAM_NEXT_SGL);
>> >  }
>> >
>> >  /*
>> > @@ -1187,7 +1190,8 @@ static int nandc_param(struct qcom_nand_host > *host)
>> >  					| 2 << WR_RD_BSY_GAP
>> >  					| 0 << WIDE_FLASH
>> >  					| 1 << DEV0_CFG1_ECC_DISABLE);
>> > -	nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << > ECC_CFG_ECC_DISABLE);
>> > +	if (!nandc->props->qpic_v2)
>> > +		nandc_set_reg(nandc, NAND_EBI2_ECC_BUF_CFG, 1 << > ECC_CFG_ECC_DISABLE);
>> >
>> >  	/* configure CMD1 and VLD for ONFI param probing in QPIC v1 */
>> >  	if (!nandc->props->qpic_v2) {
>> > @@ -2628,7 +2632,8 @@ static int qcom_nand_attach_chip(struct nand_chip > *chip)
>> >  				| ecc_mode << ECC_MODE
>> >  				| host->ecc_bytes_hw << ECC_PARITY_SIZE_BYTES_BCH;
>> >
>> > -	host->ecc_buf_cfg = 0x203 << NUM_STEPS;
>> > +	if (!nandc->props->qpic_v2)
>> > +		host->ecc_buf_cfg = 0x203 << NUM_STEPS;
>> >
>> >  	host->clrflashstatus = FS_READY_BSY_N;
>> >  	host->clrreadstatus = 0xc0;
>> 
>> 
>> ping! Hi Miquel could you review this change and let me know if more 
>> info needed.
> 
> Come on, that's only 6 days of work and we are in the middle of the
> merge window...
> 
> BTW "avoid write to" in the title is incorrect "writing to" would be
> nicer.

  Updated commit message in V2 patch.
> 
> Thanks,
> Miquèl
