Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98FB3915C1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbhEZLPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:15:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49338 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbhEZLPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:15:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14QBDakQ106453;
        Wed, 26 May 2021 06:13:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622027616;
        bh=pkpy5vS1CMdOrnrcbFOZKe7b5M6sZdb+h+9h4pGCWLk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=eC1vcZUVNuLToFVk4BZXRvQrtlEPxnf44ThLsYbK036/eQ0oBOC5utpI7udRbVKwJ
         Hw/+79bPQiY+cyz9NC2R5piRPZk8u5zFpq4kGmLGXzcy7WVitV1FIYey6szQ37LNzu
         +xfKrVq7ugLmK4vyhP0y8diFbRZuDWpn0ESaZHMU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14QBDakc001847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 May 2021 06:13:36 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 06:13:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Wed, 26 May 2021 06:13:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14QBDZat034249;
        Wed, 26 May 2021 06:13:36 -0500
Date:   Wed, 26 May 2021 16:43:35 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/4] mtd: spi-nor: otp: return -EROFS if region is
 read-only
Message-ID: <20210526111333.suxmmtkngqeyuz62@ti.com>
References: <20210521194034.15249-1-michael@walle.cc>
 <20210521194034.15249-4-michael@walle.cc>
 <20210525193323.xdvbq3tab6oxk6yh@ti.com>
 <ca81f21648e55229c8d4533881566471@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ca81f21648e55229c8d4533881566471@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/21 12:41PM, Michael Walle wrote:
> Am 2021-05-25 21:33, schrieb Pratyush Yadav:
> > On 21/05/21 09:40PM, Michael Walle wrote:
> > > SPI NOR flashes will just ignore program commands if the OTP region is
> > > locked. Thus, a user might not notice that the intended write didn't
> > > end
> > > up in the flash. Return -EROFS to the user in this case. From what I
> > > can
> > > tell, chips/cfi_cmdset_0001.c also return this error code.
> > > 
> > > One could optimize spi_nor_mtd_otp_range_is_locked() to read the
> > > status
> > > register only once and not for every OTP region, but for that we would
> > > need some more invasive changes. Given that this is
> > > one-time-programmable memory and the normal access mode is reading, we
> > > just live with the small overhead.
> > 
> > Ok.
> > 
> > > 
> > > Fixes: 069089acf88b ("mtd: spi-nor: add OTP support")
> > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > ---
> > >  drivers/mtd/spi-nor/otp.c | 35 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 35 insertions(+)
> > > 
> > > diff --git a/drivers/mtd/spi-nor/otp.c b/drivers/mtd/spi-nor/otp.c
> > > index 3898ed67ba1c..b87f96593c13 100644
> > > --- a/drivers/mtd/spi-nor/otp.c
> > > +++ b/drivers/mtd/spi-nor/otp.c
> > > @@ -249,6 +249,31 @@ static int spi_nor_mtd_otp_info(struct mtd_info
> > > *mtd, size_t len,
> > >  	return ret;
> > >  }
> > > 
> > > +static int spi_nor_mtd_otp_range_is_locked(struct spi_nor *nor,
> > > loff_t ofs,
> > > +					   size_t len)
> > > +{
> > > +	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
> > > +	unsigned int region;
> > > +	int locked;
> > > +
> > > +	if (!len)
> > > +		return 0;
> > 
> > I was inclined to say that the loop conditional below would take care of
> > this but it can cause an underflow when ofs and len are both 0.
> 
> Correct. I didn't want to put an extra check to the caller, because
> as you noticed, it is checked by the loop there later.
> 
> > > +
> > > +	/*
> > > +	 * If any of the affected OTP regions are locked the entire range is
> > > +	 * considered locked.
> > > +	 */
> > > +	for (region = spi_nor_otp_offset_to_region(nor, ofs);
> > > +	     region <= spi_nor_otp_offset_to_region(nor, ofs + len - 1);
> > > +	     region++) {
> > > +		locked = ops->is_locked(nor, region);
> > > +		if (locked)
> > > +			return locked;
> > > +	}
> > 
> > Ok.
> 
> Btw I didn't know if I should put a comment here that this if () handles
> both locked state and errors. But it seems you've already found out by
> looking at the caller ;) I'm not sure if this is obvious, though.

I didn't catch this on the first read. I only figured it out when I 
looked at the return check below. So it is certainly not obvious.

> 
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t
> > > ofs,
> > >  				      size_t total_len, size_t *retlen,
> > >  				      const u8 *buf, bool is_write)
> > > @@ -271,6 +296,16 @@ static int spi_nor_mtd_otp_read_write(struct
> > > mtd_info *mtd, loff_t ofs,
> > >  	/* don't access beyond the end */
> > >  	total_len = min_t(size_t, total_len, spi_nor_otp_size(nor) - ofs);
> > > 
> > > +	if (is_write) {
> > > +		ret = spi_nor_mtd_otp_range_is_locked(nor, ofs, total_len);
> > > +		if (ret < 0) {
> > > +			goto out;
> > > +		} else if (ret) {
> > > +			ret = -EROFS;
> > 
> > I wonder if we should have a dev_info() or dev_err() here. I think this
> > warrants a dev_dbg() at least.
> 
> Are you sure? Reporting something to the user via an error code is
> enough IMHO. I wouldn't want my syslog to be cluttered with messages
> I already know. I mean the program tell me "hey, you aren't allowed
> to write there". Why would the kernel still need to tell me that again?
> Without any connection to the caller, I don't get much out of the kernel
> message by looking at it alone, just that someone tried to write there.
> 
> So definetly no dev_info() or dev_err(). But IMHO no dev_dbg() either.
> Tudor, Vingesh, any opinions?

Either is fine by me.

> 
> 
> > > +			goto out;
> > > +		}
> > 
> > So it returns -errno when the check for is_locked() fails and 1 or 0
> > when it is locked or not. Ok.
> > 
> > It would be nice if you add a dev_dbg or dev_err() or dev_info() above.
> > Nonetheless,
> > 
> > Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
> 
> Thanks for reviewing!
> 
> -michael

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
