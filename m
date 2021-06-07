Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01539D55B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFGGuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 02:50:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51988 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbhFGGuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:50:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1576lqB9078633;
        Mon, 7 Jun 2021 01:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623048472;
        bh=/egmoX3I90I/Gz07AopX4CzQsPsjx31j/llTXwlpz7k=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=gjgnBH8tml4Bd6Gtid2iJiD+FAUlPT6zRZzAYE38nYEP3rKJ0Stc2zQukVBNMo+Fp
         1cT6DEgeohrgO5IvoAKRCT5o/pmAl9LdpfDX5n/WcPkB7rHoAnjdul8vhZr2wR5hzW
         8ur05ZF/VudvEuwvqDtbFTVfPip7gCRN/Xc1mRoE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1576lq6s056325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 01:47:52 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 01:47:52 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 01:47:52 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1576ln8D086300;
        Mon, 7 Jun 2021 01:47:50 -0500
Subject: Re: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
To:     Michael Walle <michael@walle.cc>
CC:     <Tudor.Ambarus@microchip.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <p.yadav@ti.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-4-michael@walle.cc>
 <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
 <e117bc50b9f9e10549c25602b66cfe26@walle.cc>
 <1549db61-500a-e5df-9303-823b41457861@ti.com>
 <4ba7994b0cc8d436012a776ca14addca@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <3e46bc75-6ace-f7c0-1b14-aae812554ac9@ti.com>
Date:   Mon, 7 Jun 2021 12:17:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4ba7994b0cc8d436012a776ca14addca@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 11:38 AM, Michael Walle wrote:
> Am 2021-06-07 07:46, schrieb Vignesh Raghavendra:
>> On 6/4/21 6:45 PM, Michael Walle wrote:
>>> Am 2021-06-04 15:07, schrieb Tudor.Ambarus@microchip.com:
>>>> On 6/4/21 1:02 PM, Michael Walle wrote:
>>>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>>>> know the content is safe
>>>>>
>>>>> SPI NOR flashes will just ignore program commands if the OTP region is
>>>>> locked. Thus, a user might not notice that the intended write
>>>>> didn't end
>>>>> up in the flash. Return -EROFS to the user in this case. From what
>>>>> I can
>>>>> tell, chips/cfi_cmdset_0001.c also return this error code.
>>>>>
>>>>> One could optimize spi_nor_mtd_otp_range_is_locked() to read the
>>>>> status
>>>>> register only once and not for every OTP region, but for that we would
>>>>> need some more invasive changes. Given that this is
>>>>> one-time-programmable memory and the normal access mode is reading, we
>>>>> just live with the small overhead.
>>>>>
>>>>> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
>>>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>>>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
>>>>> ---
>>>>>  drivers/mtd/spi-nor/otp.c | 36 ++++++++++++++++++++++++++++++++++++
>>>>>  1 file changed, 36 insertions(+)
>>>>>
>>>>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>>>>> index 3898ed67ba1c..063f8fb68649 100644
>>>>> --- a/drivers/mtd/spi-nor/otp.c
>>>>> +++ b/drivers/mtd/spi-nor/otp.c
>>>>> @@ -249,6 +249,32 @@ static int spi_nor_mtd_otp_info(struct mtd_info
>>>>> *mtd, size_t len,
>>>>>         return ret;
>>>>>  }
>>>>>
>>>>> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor,
>>>>> loff_t ofs,
>>>>> +                                          size_t len)
>>>>> +{
>>>>> +       const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>>>>> +       unsigned int region;
>>>>> +       int locked;
>>>>> +
>>>>> +       if (!len)
>>>>> +               return 0;
>>>>> +
>>>>
>>>> You won't need this if you put patch 4/5 before this one. With this:
>>>
>>> This patch will get backported to the stable kernels. Patch 4 on the
>>> other hand does not.
>>>
>>
>> I don't see why 4/5 cannot be marked for backport too as it makes 3/5
>> much cleaner?
> 
> What kind of problem does 4/5 fix? I can't see how that patch would
> apply to any rule in Documentation/process/stable-kernel-rules.rst.
> 

Looking further, I don't see the need for 4/5 to be a separate patch.
Patch 4/5 is simplifying spi_nor_mtd_otp_range_is_locked() by ensuring
'len' passed is never 0 which can be done in 3/5 when introducing
spi_nor_mtd_otp_range_is_locked().

So why not squashed it into 3/5.

> But sure, adding the same Fixes: tag, I can swap those two.
> 
> -michael
