Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A865439B9A0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFDNRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 09:17:25 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:41897 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhFDNRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 09:17:25 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BD23522236;
        Fri,  4 Jun 2021 15:15:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622812537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bVEBT+g85dZ4P1pZoeBaCIbosbJPMLvVQTMmrkOydI4=;
        b=oKE40u5LSfcMcKVYaq157QYuDsgNkPozqL8++U6sBoEykZPxhpn9Rs4L3f1bvUjTCvPi6p
        puM/dfpeTxypDcFAoA5uFWBV2FHyyapbvk6VCOIoykM9zmVmKT6UuP2Y8mjD0aGpfF3YGo
        0Fei8gyc046V0UgF3oTitI62I5xk5RE=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 04 Jun 2021 15:15:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        p.yadav@ti.com, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com
Subject: Re: [PATCH v5 3/5] mtd: spi-nor: otp: return -EROFS if region is
 read-only
In-Reply-To: <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
References: <20210604100252.9975-1-michael@walle.cc>
 <20210604100252.9975-4-michael@walle.cc>
 <c2b58dcc-5a60-792c-30ac-a3db327a85ed@microchip.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <e117bc50b9f9e10549c25602b66cfe26@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-06-04 15:07, schrieb Tudor.Ambarus@microchip.com:
> On 6/4/21 1:02 PM, Michael Walle wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the content is safe
>> 
>> SPI NOR flashes will just ignore program commands if the OTP region is
>> locked. Thus, a user might not notice that the intended write didn't 
>> end
>> up in the flash. Return -EROFS to the user in this case. From what I 
>> can
>> tell, chips/cfi_cmdset_0001.c also return this error code.
>> 
>> One could optimize spi_nor_mtd_otp_range_is_locked() to read the 
>> status
>> register only once and not for every OTP region, but for that we would
>> need some more invasive changes. Given that this is
>> one-time-programmable memory and the normal access mode is reading, we
>> just live with the small overhead.
>> 
>> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
>> ---
>>  drivers/mtd/spi-nor/otp.c | 36 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 36 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> index 3898ed67ba1c..063f8fb68649 100644
>> --- a/drivers/mtd/spi-nor/otp.c
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -249,6 +249,32 @@ static int spi_nor_mtd_otp_info(struct mtd_info 
>> *mtd, size_t len,
>>         return ret;
>>  }
>> 
>> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor, 
>> loff_t ofs,
>> +                                          size_t len)
>> +{
>> +       const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>> +       unsigned int region;
>> +       int locked;
>> +
>> +       if (!len)
>> +               return 0;
>> +
> 
> You won't need this if you put patch 4/5 before this one. With this:

This patch will get backported to the stable kernels. Patch 4 on the
other hand does not.

> 
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
>> +       /*
>> +        * If any of the affected OTP regions are locked the entire 
>> range is
>> +        * considered locked.
>> +        */
>> +       for (region = spi_nor_otp_offset_to_region(nor, ofs);
>> +            region <= spi_nor_otp_offset_to_region(nor, ofs + len - 
>> 1);
>> +            region++) {
>> +               locked = ops->is_locked(nor, region);
>> +               /* take the branch it is locked or in case of an error 
>> */
>> +               if (locked)
>> +                       return locked;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t 
>> ofs,
>>                                       size_t total_len, size_t 
>> *retlen,
>>                                       const u8 *buf, bool is_write)
>> @@ -271,6 +297,16 @@ static int spi_nor_mtd_otp_read_write(struct 
>> mtd_info *mtd, loff_t ofs,
>>         /* don't access beyond the end */
>>         total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - 
>> ofs);
>> 
>> +       if (is_write) {
>> +               ret = spi_nor_mtd_otp_range_is_locked(nor, ofs, 
>> total_len);
>> +               if (ret < 0) {
>> +                       goto out;
>> +               } else if (ret) {
>> +                       ret = -EROFS;
>> +                       goto out;
>> +               }
>> +       }
>> +
>>         *retlen = 0;
>>         while (total_len) {
>>                 /*
>> --
>> 2.20.1
>> 
