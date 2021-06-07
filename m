Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CE939D470
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 07:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFGFsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 01:48:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49986 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhFGFsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 01:48:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1575kBLg005472;
        Mon, 7 Jun 2021 00:46:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623044771;
        bh=b3YribPsLsUNBcVX/uBU0uUtAjN0H/Dr6M1HW8UYZKg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Rmu6KxldSL3T4RDaoN0NsYS+xvbdRRySK3B9EF9dwUXuFSLe7Wao3hpmkudAxDvXj
         QIj8bhXEUlL4q6ELOVBbrrGxsMOedRR/kGI60ALuLsqfqKD3KUUmGctEipKKN4UK2N
         q1QIJoKWuy56VwePeBFtsXY+0lIvl3U8TGepuEOA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1575kB1H106501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Jun 2021 00:46:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 7 Jun
 2021 00:46:11 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 7 Jun 2021 00:46:11 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1575k8o2089338;
        Mon, 7 Jun 2021 00:46:09 -0500
Subject: Re: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
To:     Michael Walle <michael@walle.cc>, <Tudor.Ambarus@microchip.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-4-michael@walle.cc>
 <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
 <e117bc50b9f9e10549c25602b66cfe26@walle.cc>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <1549db61-500a-e5df-9303-823b41457861@ti.com>
Date:   Mon, 7 Jun 2021 11:16:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e117bc50b9f9e10549c25602b66cfe26@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/4/21 6:45 PM, Michael Walle wrote:
> Am 2021-06-04 15:07, schrieb Tudor.Ambarus@microchip.com:
>> On 6/4/21 1:02 PM, Michael Walle wrote:
>>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>>> know the content is safe
>>>
>>> SPI NOR flashes will just ignore program commands if the OTP region is
>>> locked. Thus, a user might not notice that the intended write didn't end
>>> up in the flash. Return -EROFS to the user in this case. From what I can
>>> tell, chips/cfi_cmdset_0001.c also return this error code.
>>>
>>> One could optimize spi_nor_mtd_otp_range_is_locked() to read the status
>>> register only once and not for every OTP region, but for that we would
>>> need some more invasive changes. Given that this is
>>> one-time-programmable memory and the normal access mode is reading, we
>>> just live with the small overhead.
>>>
>>> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
>>> Signed-off-by: Michael Walle <michael@walle.cc>
>>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
>>> ---
>>>  drivers/mtd/spi-nor/otp.c | 36 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>>> index 3898ed67ba1c..063f8fb68649 100644
>>> --- a/drivers/mtd/spi-nor/otp.c
>>> +++ b/drivers/mtd/spi-nor/otp.c
>>> @@ -249,6 +249,32 @@ static int spi_nor_mtd_otp_info(struct mtd_info
>>> *mtd, size_t len,
>>>         return ret;
>>>  }
>>>
>>> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor,
>>> loff_t ofs,
>>> +                                          size_t len)
>>> +{
>>> +       const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>>> +       unsigned int region;
>>> +       int locked;
>>> +
>>> +       if (!len)
>>> +               return 0;
>>> +
>>
>> You won't need this if you put patch 4/5 before this one. With this:
> 
> This patch will get backported to the stable kernels. Patch 4 on the
> other hand does not.
> 

I don't see why 4/5 cannot be marked for backport too as it makes 3/5
much cleaner?

Regards
Vignesh
