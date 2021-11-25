Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC8545DC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 15:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352462AbhKYORS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 09:17:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:41028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355618AbhKYOPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 09:15:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C59B6101D;
        Thu, 25 Nov 2021 14:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637849525;
        bh=yphTqVO3vqIdlcckcfNgEk3j7be4ZjIEdwtA7cNO2KQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=G+/EVsDX1YE+x5RZyYvp56vE/TUw9FqTrInQr8wHziyLIhto8jh0AdTu5hYoPDueU
         PfWs3p5bk1WgvVdvbEjv6Zgeg/7gkPVui9SG1sRrka1W/iMnC7J3AvazEnEQtnUWFy
         K/u3OvxuGcvYTX8PrIwaKQvNkvGxV8RFH4IrGDGycwXcI4wkpmR+lVagWTVcJrRIbP
         jZQEI8joAk3x7NlvcDmG0LKiQTtp3mXbYcFClr7S7XACjvmpeCp4I44udBkwuLthk+
         mv7HcuEz5EAnfc7t70SgFSitJlUlDfesUY2TvdBESuqbEUFxck0++DdHo8/Hqu8557
         AD7XRBbwny98A==
Subject: Re: [PATCH 4/4] mtd: nand: omap2: Add support for NAND Controller on
 AM64 SoC
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        tony@atomide.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211123103609.14063-1-rogerq@kernel.org>
 <20211123103609.14063-5-rogerq@kernel.org> <20211124131552.6b9bc506@xps13>
From:   Roger Quadros <rogerq@kernel.org>
Message-ID: <e52141a6-96fc-97d6-95d7-3e26276fbac3@kernel.org>
Date:   Thu, 25 Nov 2021 16:12:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124131552.6b9bc506@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 24/11/2021 14:15, Miquel Raynal wrote:
> Hi Roger,
> 
> rogerq@kernel.org wrote on Tue, 23 Nov 2021 12:36:09 +0200:
> 
>> AM64 SoC has an issue which prevents proper 8-bit and 16-bit
>> reads from GPMC. We are limited to do 32-bit reads only.
> 
> First, thanks for this series!

No problem. Just my job :)

> 
>> Force 32-bit only reads on affected platforms.
>>
> 
> Please change the commit title prefix to: "mtd: rawnand: omap2:" in
> patch 2, 3, 4.

OK.

>  
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/mtd/nand/raw/omap2.c | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
>> index f1fc146e09b9..d952de771b35 100644
>> --- a/drivers/mtd/nand/raw/omap2.c
>> +++ b/drivers/mtd/nand/raw/omap2.c
>> @@ -28,6 +28,7 @@
>>  
>>  #include <linux/omap-gpmc.h>
>>  #include <linux/platform_data/mtd-nand-omap2.h>
>> +#include <linux/sys_soc.h>
>>  
>>  #define	DRIVER_NAME	"omap2-nand"
>>  #define	OMAP_NAND_TIMEOUT_MS	5000
>> @@ -181,6 +182,7 @@ struct omap_nand_info {
>>  	void (*data_out)(struct nand_chip *chip,
>>  			 const void *buf, unsigned int len,
>>  			 bool force_8bit);
>> +	bool force_32bit;
> 
> I believe we should have a driver capability instead of something in
> the info structure. You can save the value here as well in the probe if
> you want, but I would like this limitation to be tied to the
> compatible.

I will discuss about this at the end.
> 
>>  };
>>  
>>  static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
>> @@ -2070,6 +2072,25 @@ static void omap_nand_data_in(struct nand_chip *chip, void *buf,
>>  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
>>  	u32 alignment = ((uintptr_t)buf | len) & 3;
>>  
>> +	if (info->force_32bit) {
> 
> I am a little bit bothered by this limitation. The force8_bit flag does
> not require the driver to read only 8-bits of the fifo register, it
> actually requires to use only the first 8-bits of the NAND bus (which
> can also be 16-bit wide). The older implementation just limited the
> number of bits reads to be 8 with ioread8, which seems to be a fine
> solution but would require more accesses than using ioread16 (or
> ioread32) when reading more than 1 byte on platforms with only 8-bit
> busses.

I didn't understand the purpose of force8_bit flag. 
How should the driver/controller behave if we get a data_in() call with len 8 and force8_bit flag set?

e.g. if 16-bit NAND ID area contains (little-endian) 2c d3 d0 a6 66 45 67 a3 4f 4e 46 49 ab ef 90 d3
what should data_in(len = 8, force_8_bit = 1) return in buffer?

Based on what you said earlier my guess is it should return 2c d0 66 67 4f 46 ab 90?

> 
> My point here is that:
> 1- the limited controllers cannot be used with a 16-bit bus
> 2- non-limited controllers can use ioread16 if the bus width is 8-bits

Sorry, I did not understand this either. The TI GPMC controller has a configuration setting where we
set the NAND device bus width (8-bit or 16-bit). Then it automatically converts ioread16 or
ioread32 to appropriate number of 8-bit accesses or 16-bit accesses to the NAND chip.

> 
> I guess it's fine not to change the logic to avoid breaking boards so
> we can just ignore [2] but I belive we should check chip->options &
> NAND_BUSWIDTH_16 in ->attach_chip() and refuse probing if this flag is
> set.
> 
>> +		u32 val;
>> +		int left;
>> +		u8 *ptr;
>> +
>> +		ioread32_rep(info->fifo, buf, len >> 2);
>> +		left = len & 0x3;
>> +		if (left) {
>> +			val = ioread32(info->fifo);
>> +			ptr = (u8 *)(buf + (len - left));
>> +			while (left--) {
>> +				*ptr++ = val & 0xff;
>> +				val >>= 8;
>> +			}
>> +		}
>> +
>> +		return;
>> +	}
>> +
>>  	if (force_8bit || (alignment & 1))
>>  		ioread8_rep(info->fifo, buf, len);
>>  	else if (alignment & 3)
>> @@ -2169,8 +2190,15 @@ static const struct nand_controller_ops omap_nand_controller_ops = {
>>  static struct nand_controller omap_gpmc_controller;
>>  static bool omap_gpmc_controller_initialized;
>>  
>> +static const struct of_device_id omap_nand_ids[];
>> +
> 
> I believe this change should be dropped.
> 
>>  static int omap_nand_probe(struct platform_device *pdev)
>>  {
>> +	const struct soc_device_attribute k3_soc_devices[] = {
>> +		{ .family = "AM64X", .revision = "SR1.0" },
>> +		{ /* sentinel */ }
>> +	};
>> +
>>  	struct omap_nand_info		*info;
>>  	struct mtd_info			*mtd;
>>  	struct nand_chip		*nand_chip;
>> @@ -2186,6 +2214,12 @@ static int omap_nand_probe(struct platform_device *pdev)
>>  
>>  	info->pdev = pdev;
>>  
>> +	/* Some SoC's have 32-bit at least, read limitation */
>> +	if (soc_device_match(k3_soc_devices)) {
>> +		dev_info(&pdev->dev, "force 32-bit\n");
>> +		info->force_32bit = true;
>> +	}
>> +
> 
> As suggested above, just adding a capability structure tied to the
> compatible string and retrieved with of_device_get_match_data() should
> be enough and replace this manual tree research.

The trouble comes when TI updates the silicon revision to "SR2.0" and that has the issue fixed
but still uses the same compatible. So compatible string by itself is not sufficient to identify
the troubled devices. soc_device_match() was the easiest way to address this.

> 
>>  	err = omap_get_dt_info(dev, info);
>>  	if (err)
>>  		return err;
>> @@ -2286,6 +2320,7 @@ static int omap_nand_remove(struct platform_device *pdev)
>>  
>>  static const struct of_device_id omap_nand_ids[] = {
>>  	{ .compatible = "ti,omap2-nand", },
>> +	{ .compatible = "ti,am64-nand", },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, omap_nand_ids);
> 
> The conversion to exec_op looks fine otherwise :)

Thanks :)

> 
> Thanks,
> Miquèl
> 

cheers,
-roger
