Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE05391533
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbhEZKnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:43:10 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:40833 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbhEZKnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:43:09 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C4C7422236;
        Wed, 26 May 2021 12:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1622025697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErwKEEinBftiXZT6dwCMASUMXD5Y2QAmtSkdKSxxN08=;
        b=ZhmjZvPFhlGK54bGH1oN+oddaIB/Cw85IIej2dmgiSSSlv1lSNtQh4WqoY0uPbDOMFfKfd
        onaNwNAGtRJDm45Oqyue4xROpZlR8xJ4GnhvdFsTiBXo0DRIl+9ECvkQM0IxQ7a3t/+Rpr
        SDmLczovZLTQSgELeFfsbXTPHrNvhaA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 May 2021 12:41:36 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
In-Reply-To: <20210525193323.xdvbq3tab6oxk6yh@ti.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-4-michael@walle.cc>
 <20210525193323.xdvbq3tab6oxk6yh@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <ca81f21648e55229c8d4533881566471@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-25 21:33, schrieb Pratyush Yadav:
> On 21/05/21 09:40PM, Michael Walle wrote:
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
> 
> Ok.
> 
>> 
>> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/mtd/spi-nor/otp.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>> 
>> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
>> index 3898ed67ba1c..b87f96593c13 100644
>> --- a/drivers/mtd/spi-nor/otp.c
>> +++ b/drivers/mtd/spi-nor/otp.c
>> @@ -249,6 +249,31 @@ static int spi_nor_mtd_otp_info(struct mtd_info 
>> *mtd, size_t len,
>>  	return ret;
>>  }
>> 
>> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor, 
>> loff_t ofs,
>> +					   size_t len)
>> +{
>> +	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>> +	unsigned int region;
>> +	int locked;
>> +
>> +	if (!len)
>> +		return 0;
> 
> I was inclined to say that the loop conditional below would take care 
> of
> this but it can cause an underflow when ofs and len are both 0.

Correct. I didn't want to put an extra check to the caller, because
as you noticed, it is checked by the loop there later.

>> +
>> +	/*
>> +	 * If any of the affected OTP regions are locked the entire range is
>> +	 * considered locked.
>> +	 */
>> +	for (region = spi_nor_otp_offset_to_region(nor, ofs);
>> +	     region <= spi_nor_otp_offset_to_region(nor, ofs + len - 1);
>> +	     region++) {
>> +		locked = ops->is_locked(nor, region);
>> +		if (locked)
>> +			return locked;
>> +	}
> 
> Ok.

Btw I didn't know if I should put a comment here that this if () handles
both locked state and errors. But it seems you've already found out by
looking at the caller ;) I'm not sure if this is obvious, though.

>> +
>> +	return 0;
>> +}
>> +
>>  static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t 
>> ofs,
>>  				      size_t total_len, size_t *retlen,
>>  				      const u8 *buf, bool is_write)
>> @@ -271,6 +296,16 @@ static int spi_nor_mtd_otp_read_write(struct 
>> mtd_info *mtd, loff_t ofs,
>>  	/* don't access beyond the end */
>>  	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
>> 
>> +	if (is_write) {
>> +		ret = spi_nor_mtd_otp_range_is_locked(nor, ofs, total_len);
>> +		if (ret < 0) {
>> +			goto out;
>> +		} else if (ret) {
>> +			ret = -EROFS;
> 
> I wonder if we should have a dev_info() or dev_err() here. I think this
> warrants a dev_dbg() at least.

Are you sure? Reporting something to the user via an error code is
enough IMHO. I wouldn't want my syslog to be cluttered with messages
I already know. I mean the program tell me "hey, you aren't allowed
to write there". Why would the kernel still need to tell me that again?
Without any connection to the caller, I don't get much out of the kernel
message by looking at it alone, just that someone tried to write there.

So definetly no dev_info() or dev_err(). But IMHO no dev_dbg() either.
Tudor, Vingesh, any opinions?


>> +			goto out;
>> +		}
> 
> So it returns -errno when the check for is_locked() fails and 1 or 0
> when it is locked or not. Ok.
> 
> It would be nice if you add a dev_dbg or dev_err() or dev_info() above.
> Nonetheless,
> 
> Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Thanks for reviewing!

-michael
