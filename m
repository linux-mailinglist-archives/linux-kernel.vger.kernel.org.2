Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1413909B2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhEYTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:35:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44822 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhEYTfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:35:08 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14PJXRHf044419;
        Tue, 25 May 2021 14:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1621971207;
        bh=EihITSZ+agD5NRPVu+oqyk24Asa0tc2ILpQ40bXNrcA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kPxYpFZDUB8EPq/lPR3srxivyHfOM89VrLNj/S16j70XPmtRp56HlmI+12Q/TxME9
         +t2RuOY2of1TIbjvR0DQ04abHj7AcBfm4VBEh5o8MbdRJtpgF9PXLhUKqdljJIqqAO
         QiqA8YikYp/sKpO7IhyOH64mZNiF2WoJ0QFJ+CYI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14PJXRPK059214
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 May 2021 14:33:27 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 25
 May 2021 14:33:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 25 May 2021 14:33:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14PJXQ7a023176;
        Tue, 25 May 2021 14:33:27 -0500
Date:   Wed, 26 May 2021 01:03:26 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Message-ID: <20210525193323.xdvbq3tab6oxk6yh@ti.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210521194034.15249-4-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/21 09:40PM, Michael Walle wrote:
> SPI NOR flashes will just ignore program commands if the OTP region is
> locked. Thus, a user might not notice that the intended write didn't end
> up in the flash. Return -EROFS to the user in this case. From what I can
> tell, chips/cfi_cmdset_0001.c also return this error code.
> 
> One could optimize spi_nor_mtd_otp_range_is_locked() to read the status
> register only once and not for every OTP region, but for that we would
> need some more invasive changes. Given that this is
> one-time-programmable memory and the normal access mode is reading, we
> just live with the small overhead.

Ok.

> 
> Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/otp.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
> index 3898ed67ba1c..b87f96593c13 100644
> --- a/drivers/mtd/spi-nor/otp.c
> +++ b/drivers/mtd/spi-nor/otp.c
> @@ -249,6 +249,31 @@ static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
>  	return ret;
>  }
>  
> +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor, loff_t ofs,
> +					   size_t len)
> +{
> +	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
> +	unsigned int region;
> +	int locked;
> +
> +	if (!len)
> +		return 0;

I was inclined to say that the loop conditional below would take care of 
this but it can cause an underflow when ofs and len are both 0.

> +
> +	/*
> +	 * If any of the affected OTP regions are locked the entire range is
> +	 * considered locked.
> +	 */
> +	for (region = spi_nor_otp_offset_to_region(nor, ofs);
> +	     region <= spi_nor_otp_offset_to_region(nor, ofs + len - 1);
> +	     region++) {
> +		locked = ops->is_locked(nor, region);
> +		if (locked)
> +			return locked;
> +	}

Ok.

> +
> +	return 0;
> +}
> +
>  static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
>  				      size_t total_len, size_t *retlen,
>  				      const u8 *buf, bool is_write)
> @@ -271,6 +296,16 @@ static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
>  	/* don't access beyond the end */
>  	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
>  
> +	if (is_write) {
> +		ret = spi_nor_mtd_otp_range_is_locked(nor, ofs, total_len);
> +		if (ret < 0) {
> +			goto out;
> +		} else if (ret) {
> +			ret = -EROFS;

I wonder if we should have a dev_info() or dev_err() here. I think this 
warrants a dev_dbg() at least.

> +			goto out;
> +		}

So it returns -errno when the check for is_locked() fails and 1 or 0 
when it is locked or not. Ok.

It would be nice if you add a dev_dbg or dev_err() or dev_info() above. 
Nonetheless,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> +	}
> +
>  	*retlen = 0;
>  	while (total_len) {
>  		/*

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
