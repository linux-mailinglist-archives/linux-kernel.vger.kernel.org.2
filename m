Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BF38B2F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243800AbhETPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 11:23:08 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:40617 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhETPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:22:57 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 445162224A;
        Thu, 20 May 2021 17:21:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1621524094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mZw769Li8RrpESRx7xXi26AWpGToFQSlDv5uLSxVFM=;
        b=YVH55aXL69KVBr8AcSFoOJFg7ZZ+rkD3sy6OEZEzRbixvcBB4jlK1QJsFfgkM8XyBKHgTC
        cInnYQEtKLnVrRMgVNAW0ObrDII/MUUZDytqJHjDyceirt+yCfJ6r1nr7Dk0jUtHImjvrh
        VwdLapQiaYOUZHPPm5gHdoPHbIObdK4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 May 2021 17:21:34 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: implement OTP erase for Winbond and
 similar flashes
In-Reply-To: <20210520134940.fpyt52mwpdotrp4a@ti.com>
References: <20210510202056.30000-1-michael@walle.cc>
 <20210520122256.fhkzpqmu7nxwjoqt@ti.com>
 <20a7e9725d54c9566ca06c062c15f015@walle.cc>
 <20210520134940.fpyt52mwpdotrp4a@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <bdf79e0b9cbe291a48ab27b69f15eb04@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-05-20 15:49, schrieb Pratyush Yadav:
> On 20/05/21 03:20PM, Michael Walle wrote:
>> Am 2021-05-20 14:22, schrieb Pratyush Yadav:
>> > On 10/05/21 10:20PM, Michael Walle wrote:
..
>> > > +int spi_nor_otp_erase_secr(struct spi_nor *nor, loff_t addr)
>> > > +{
>> > > +	int ret;
>> > > +
>> > > +	ret = spi_nor_write_enable(nor);
>> > > +	if (ret)
>> > > +		return ret;
>> > > +
>> > > +	if (nor->spimem) {
>> > > +		struct spi_mem_op op =
>> > > +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_ESECR, 0),
>> > > +				   SPI_MEM_OP_ADDR(3, addr, 0),
>> >
>> > Only 3 address bytes needed? Can the OTP region ever require 4 byte
>> > addressing? For example, say the flash is switched to 4 byte addressing
>> > for the main region. Would it still expect 3 byte addressing for OTP
>> > ops?
>> 
>> It seems you're right. Looking at larger flashes there are sometimes
>> 4 bytes. See for example ch 8.2.44
>> 
>> https://www.winbond.com/resource-files/w25m512jwxiq%20spi%20rev%20c%2012242018.pdf
>> 
>> Thus it seems it should be fixed for the programming and reading,
>> too. Unfortunately, I cannot test any of this.
> 
> I don't think any such flash is supported currently, right? So in that
> case we won't at least introduce any new regressions when making this
> untested change. Whenever someone adds support for one of these 
> flashes,
> we can ask them to test this as well.

yep.

..

>> > > +static int spi_nor_mtd_otp_lock_erase(struct mtd_info *mtd, loff_t
>> > > from,
>> >
>> > spi_nor_mtd_otp_lock_or_erase()? Or would it make it too long?
>> 
>> I'm fine with both, its just that the read/write doesn't have an
>> "or" neither ;)
>> 
>> > Anyway, maybe I am bikeshedding too much, but I don't like that you
>> > combine two completely independent operations into the same function
>> > because they have some common parts. You should make them two separate
>> > functions and see how many of the common parts can be split into
>> > independent subroutines.
>> 
>> Given that the whole boilerplate before and after the erase/lock is
>> exactly the same, even the while loop is the same, I don't see how
>> it can easily be split. Well, you could rename the function to some
>> generic spi_nor_mtd_walk() - which would imply it might also be
>> used for read/write, which is not true - and provide a callback
>> function. But I don't see how this is would make it easier to read.
>> And this is just an implemention local to this module.
> 
> My suggestion was to make two copies of the same code, and then see if
> you can consolidate some in a clean subroutine. If that is not 
> possible,
> then you can just leave the code duplicated in two places. It is not
> that much duplication so it should be fine IMO.
> 
> But I won't press too much on this point. I will leave it to your
> judgement on what works better. Just want to make sure you understand 
> my
> point completely.

I get your point. But I really don't like the code duplication.

>> > > +				      size_t len, bool is_erase)
>> > >  {
>> > >  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>> > >  	const struct spi_nor_otp_ops *ops = nor->params->otp.ops;
>> > >  	const size_t rlen = spi_nor_otp_region_len(nor);
>> > >  	unsigned int region;
>> > > +	loff_t rstart;
>> > >  	int ret;
>> > >
>> > >  	if (from < 0 || (from + len) > spi_nor_otp_size(nor))
>> > > @@ -337,7 +382,13 @@ static int spi_nor_mtd_otp_lock(struct mtd_info
>> > > *mtd, loff_t from, size_t len)
>> > >
>> > >  	while (len) {
>> > >  		region = spi_nor_otp_offset_to_region(nor, from);
>> > > -		ret = ops->lock(nor, region);
>> > > +
>> > > +		if (is_erase) {
>> > > +			rstart = spi_nor_otp_region_start(nor, region);
>> > > +			ret = ops->erase(nor, rstart);
>> >
>> > This further highlights my point. There are subtle differences between
>> > erase and lock and having them in the same function might not be the
>> > best idea.

Maybe the argument for the locking is wrong. Future will tell. The
start address of a region and the number of a region is actually
equivalent. So maybe ->lock should also take the start address.
But then you'd go from address -> region -> address -> region.

At the moment its modelled after how winbond and macronix flashes
implement these ops.

See here for an old version of the support for macronix(-like)
flashes:
https://lore.kernel.org/linux-mtd/20200911222634.31804-4-michael@walle.cc/

-michael
