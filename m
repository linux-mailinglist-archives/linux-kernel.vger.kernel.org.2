Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83138B7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 21:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbhETTtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 15:49:41 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:48955 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233763AbhETTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 15:49:38 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7D2E52224F;
        Thu, 20 May 2021 21:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621540095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FB7IPwoGcrWte7J69DSJxA9Wwq6HCVigxcRMGRBdIAI=;
        b=n2Kp6EEeT/QURJUM+g/xBrQ3CDr0H2MaO/OdCvfrgT+LrI59KfWwlLk77SkAw5GY3GeLa2
        wV2CfFbsEaaSKGt5HLgxCefDcZpofWBIK2ExmrpJ3oJhgX/EGgH74JbMd9NqvsO4Qt1Rm1
        9wwkLsMbT7Gd1FThhOxP71wGcz3c5W8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 21:48:15 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v3 2/3] mtd: spi-nor: otp: use more consistent wording
In-Reply-To: <20210520173906.3h3m6lykfpnmznkx@ti.com>
References: <20210520155854.16547-1-michael@walle.cc>
 <20210520155854.16547-3-michael@walle.cc>
 <20210520173906.3h3m6lykfpnmznkx@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1752653b57961170ee8b7efec4f79023@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-20 19:39, schrieb Pratyush Yadav:
> On 20/05/21 05:58PM, Michael Walle wrote:
>> Use the wording as used in the datasheet to describe the access 
>> methods
>> of the security registers (aka OTP storage). This will also match the
>> function names.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/otp.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> index 91a4c510ed51..ec0c1b33f7cc 100644
>> --- a/drivers/mtd/spi-nor/otp.c
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -15,14 +15,16 @@
>>  #define spi_nor_otp_n_regions(nor) 
>> ((nor)->params->otp.org->n_regions)
>> 
>>  /**
>> - * spi_nor_otp_read_secr() - read OTP data
>> + * spi_nor_otp_read_secr() - read security register
>>   * @nor:	pointer to 'struct spi_nor'
>>   * @addr:       offset to read from
>>   * @len:        number of bytes to read
>>   * @buf:        pointer to dst buffer
>>   *
>> - * Read OTP data from one region by using the SPINOR_OP_RSECR 
>> commands. This
>> - * method is used on GigaDevice and Winbond flashes.
>> + * Read a security register by using the SPINOR_OP_RSECR commands. 
>> This method
>> + * is used on GigaDevice and Winbond flashes to access OTP data.
>> + *
>> + * Please note, the read must not span multiple registers.
> 
> Security register is a very vague term. It in no way tells you that it
> means OTP data unless you already know. If I read this for the first
> time, I would think it is some sort of password or access 
> enable/disable
> type of register, and not OTP data region.

Hence why I didn't use that wording. Also if I read register I think
of some small amount of bits, not a whole 256bytes. But it is like it 
is.

-michael
