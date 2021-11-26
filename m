Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9746645EAA3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376418AbhKZJrv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 04:47:51 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49451 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376270AbhKZJpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:45:49 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 600F0240012;
        Fri, 26 Nov 2021 09:42:32 +0000 (UTC)
Date:   Fri, 26 Nov 2021 10:42:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        tony@atomide.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: nand: omap2: Add support for NAND Controller
 on AM64 SoC
Message-ID: <20211126104231.7cc43149@xps13>
In-Reply-To: <e52141a6-96fc-97d6-95d7-3e26276fbac3@kernel.org>
References: <20211123103609.14063-1-rogerq@kernel.org>
        <20211123103609.14063-5-rogerq@kernel.org>
        <20211124131552.6b9bc506@xps13>
        <e52141a6-96fc-97d6-95d7-3e26276fbac3@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

rogerq@kernel.org wrote on Thu, 25 Nov 2021 16:12:01 +0200:

> Hi Miquel,
> 
> On 24/11/2021 14:15, Miquel Raynal wrote:
> > Hi Roger,
> > 
> > rogerq@kernel.org wrote on Tue, 23 Nov 2021 12:36:09 +0200:
> >   
> >> AM64 SoC has an issue which prevents proper 8-bit and 16-bit
> >> reads from GPMC. We are limited to do 32-bit reads only.  
> > 
> > First, thanks for this series!  
> 
> No problem. Just my job :)
> 
> >   
> >> Force 32-bit only reads on affected platforms.
> >>  
> > 
> > Please change the commit title prefix to: "mtd: rawnand: omap2:" in
> > patch 2, 3, 4.  
> 
> OK.
> 
> >    
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >>  drivers/mtd/nand/raw/omap2.c | 35 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >> diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
> >> index f1fc146e09b9..d952de771b35 100644
> >> --- a/drivers/mtd/nand/raw/omap2.c
> >> +++ b/drivers/mtd/nand/raw/omap2.c
> >> @@ -28,6 +28,7 @@
> >>  
> >>  #include <linux/omap-gpmc.h>
> >>  #include <linux/platform_data/mtd-nand-omap2.h>
> >> +#include <linux/sys_soc.h>
> >>  
> >>  #define	DRIVER_NAME	"omap2-nand"
> >>  #define	OMAP_NAND_TIMEOUT_MS	5000
> >> @@ -181,6 +182,7 @@ struct omap_nand_info {
> >>  	void (*data_out)(struct nand_chip *chip,
> >>  			 const void *buf, unsigned int len,
> >>  			 bool force_8bit);
> >> +	bool force_32bit;  
> > 
> > I believe we should have a driver capability instead of something in
> > the info structure. You can save the value here as well in the probe if
> > you want, but I would like this limitation to be tied to the
> > compatible.  
> 
> I will discuss about this at the end.
> >   
> >>  };
> >>  
> >>  static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
> >> @@ -2070,6 +2072,25 @@ static void omap_nand_data_in(struct nand_chip *chip, void *buf,
> >>  	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
> >>  	u32 alignment = ((uintptr_t)buf | len) & 3;
> >>  
> >> +	if (info->force_32bit) {  
> > 
> > I am a little bit bothered by this limitation. The force8_bit flag does
> > not require the driver to read only 8-bits of the fifo register, it
> > actually requires to use only the first 8-bits of the NAND bus (which
> > can also be 16-bit wide). The older implementation just limited the
> > number of bits reads to be 8 with ioread8, which seems to be a fine
> > solution but would require more accesses than using ioread16 (or
> > ioread32) when reading more than 1 byte on platforms with only 8-bit
> > busses.  
> 
> I didn't understand the purpose of force8_bit flag. 

Only access the lowest byte on the bus. This is only needed for
meta-data reads (like status reads or ids) where the upper byte would
be a duplicate.

> How should the driver/controller behave if we get a data_in() call with len 8 and force8_bit flag set?
> 
> e.g. if 16-bit NAND ID area contains (little-endian) 2c d3 d0 a6 66 45 67 a3 4f 4e 46 49 ab ef 90 d3
> what should data_in(len = 8, force_8_bit = 1) return in buffer?
> 
> Based on what you said earlier my guess is it should return 2c d0 66 67 4f 46 ab 90?

If on a 16-bit bus, you would receive 2c 2c d3 d3 d0 d0 a6 a6 etc and
of course that's not what you want.

> > My point here is that:
> > 1- the limited controllers cannot be used with a 16-bit bus
> > 2- non-limited controllers can use ioread16 if the bus width is 8-bits  
> 
> Sorry, I did not understand this either. The TI GPMC controller has a configuration setting where we
> set the NAND device bus width (8-bit or 16-bit). Then it automatically converts ioread16 or
> ioread32 to appropriate number of 8-bit accesses or 16-bit accesses to the NAND chip.

Ok great, in this case you should configure the bus width depending
on the actual used width (8 or 16 bits). When an 8-bit access is
requested with force_8bit, you should ensure the buswidth is changed
to 8 and then use ioread8/16/32 as you wish and then return the bus
back into its default state.

> 
> > 
> > I guess it's fine not to change the logic to avoid breaking boards so
> > we can just ignore [2] but I belive we should check chip->options &
> > NAND_BUSWIDTH_16 in ->attach_chip() and refuse probing if this flag is
> > set.
> >   
> >> +		u32 val;
> >> +		int left;
> >> +		u8 *ptr;
> >> +
> >> +		ioread32_rep(info->fifo, buf, len >> 2);
> >> +		left = len & 0x3;
> >> +		if (left) {
> >> +			val = ioread32(info->fifo);
> >> +			ptr = (u8 *)(buf + (len - left));
> >> +			while (left--) {
> >> +				*ptr++ = val & 0xff;
> >> +				val >>= 8;
> >> +			}
> >> +		}
> >> +
> >> +		return;
> >> +	}
> >> +
> >>  	if (force_8bit || (alignment & 1))
> >>  		ioread8_rep(info->fifo, buf, len);
> >>  	else if (alignment & 3)
> >> @@ -2169,8 +2190,15 @@ static const struct nand_controller_ops omap_nand_controller_ops = {
> >>  static struct nand_controller omap_gpmc_controller;
> >>  static bool omap_gpmc_controller_initialized;
> >>  
> >> +static const struct of_device_id omap_nand_ids[];
> >> +  
> > 
> > I believe this change should be dropped.
> >   
> >>  static int omap_nand_probe(struct platform_device *pdev)
> >>  {
> >> +	const struct soc_device_attribute k3_soc_devices[] = {
> >> +		{ .family = "AM64X", .revision = "SR1.0" },
> >> +		{ /* sentinel */ }
> >> +	};
> >> +
> >>  	struct omap_nand_info		*info;
> >>  	struct mtd_info			*mtd;
> >>  	struct nand_chip		*nand_chip;
> >> @@ -2186,6 +2214,12 @@ static int omap_nand_probe(struct platform_device *pdev)
> >>  
> >>  	info->pdev = pdev;
> >>  
> >> +	/* Some SoC's have 32-bit at least, read limitation */
> >> +	if (soc_device_match(k3_soc_devices)) {
> >> +		dev_info(&pdev->dev, "force 32-bit\n");
> >> +		info->force_32bit = true;
> >> +	}
> >> +  
> > 
> > As suggested above, just adding a capability structure tied to the
> > compatible string and retrieved with of_device_get_match_data() should
> > be enough and replace this manual tree research.  
> 
> The trouble comes when TI updates the silicon revision to "SR2.0" and that has the issue fixed
> but still uses the same compatible. So compatible string by itself is not sufficient to identify
> the troubled devices. soc_device_match() was the easiest way to address this.

This is precisely what compatibles are for, I believe we should declare
the necessary additional compatibles and fix the device trees that are
wrong.

> >>  	err = omap_get_dt_info(dev, info);
> >>  	if (err)
> >>  		return err;
> >> @@ -2286,6 +2320,7 @@ static int omap_nand_remove(struct platform_device *pdev)
> >>  
> >>  static const struct of_device_id omap_nand_ids[] = {
> >>  	{ .compatible = "ti,omap2-nand", },
> >> +	{ .compatible = "ti,am64-nand", },
> >>  	{},
> >>  };
> >>  MODULE_DEVICE_TABLE(of, omap_nand_ids);  
> > 
> > The conversion to exec_op looks fine otherwise :)  
> 
> Thanks :)
> 
> > 
> > Thanks,
> > Miquèl
> >   
> 
> cheers,
> -roger


Thanks,
Miquèl
