Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49540C046
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 09:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236554AbhIOHOh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 15 Sep 2021 03:14:37 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53329 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbhIOHOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 03:14:37 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7E3842000E;
        Wed, 15 Sep 2021 07:13:16 +0000 (UTC)
Date:   Wed, 15 Sep 2021 09:13:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx
Message-ID: <20210915091315.2768e9a3@xps13>
In-Reply-To: <927c7c75-c0d3-b3fb-6b85-13dbc3c6edbe@biot.com>
References: <20210908201624.237634-1-bert@biot.com>
        <20210914193108.78df5367@xps13>
        <1517789471.73175.1631641788145.JavaMail.zimbra@nod.at>
        <927c7c75-c0d3-b3fb-6b85-13dbc3c6edbe@biot.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bert,

bert@biot.com wrote on Tue, 14 Sep 2021 22:03:49 +0200:

> On 9/14/21 7:49 PM, Richard Weinberger wrote:
> > ----- Ursprüngliche Mail -----  
> >> bert@biot.com wrote on Wed,  8 Sep 2021 22:16:19 +0200:
> >>   
> >>> This adds a new vendor Etron, and support for a 2Gb chip.
> >>> 
> >>> The datasheet is available at
> >>> https://www.etron.com/cn/products/EM73%5B8%5DC%5BD_E_F%5DVC%20SPI%20NAND%20Flash_Promotion_Rev%201_00A.pdf
> >>> 
> >>> Signed-off-by: Bert Vermeulen <bert@biot.com>
> >>> ---
> >>> v2:
> >>> - Made ooblayout_free/_ecc depend on chip-specific parameters, instead of
> >>>   hardcoded to this 2Gb chip only
> >>> - Fixed manufacturer ordering
> >>> - Fixed minor formatting issues as reported
> >>> - Removed debug comment
> >>> 
> >>>  drivers/mtd/nand/spi/Makefile |   2 +-
> >>>  drivers/mtd/nand/spi/core.c   |   1 +
> >>>  drivers/mtd/nand/spi/etron.c  | 104 ++++++++++++++++++++++++++++++++++
> >>>  include/linux/mtd/spinand.h   |   1 +
> >>>  4 files changed, 107 insertions(+), 1 deletion(-)
> >>>  create mode 100644 drivers/mtd/nand/spi/etron.c  
> >> 
> >> [...]
> >>   
> >>> +static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
> >>> +{
> >>> +	switch (status & STATUS_ECC_MASK) {
> >>> +	case STATUS_ECC_NO_BITFLIPS:
> >>> +		return 0;
> >>> +
> >>> +	case STATUS_ECC_HAS_BITFLIPS:
> >>> +		/* Between 1-7 bitflips were corrected */
> >>> +		return 7;  
> >> 
> >> Mmmh this is a bit problematic, having no intermediate value means a
> >> single bitflip will trigger UBI to move the data around as its
> >> threshold will be reached. Richard, any feedback on this?  
> > 
> > So, the NAND controller can only report "no bitflips", "some bitflips", "maximum biflips" and "no way to fix"?
> > If so, yes, this is problematic for UBI because it will trigger wear-leveling way too often.
> > On a medium aged NAND I'd expect to see STATUS_ECC_HAS_BITFLIPS almost always set. :-(  
> 
> Yes, that's all there is according to the datasheet. Can't be _that_
> unusual, since that's all the STATUS_ECC_* flags cover.

I forgot about that part which was reminded to me by Richard:

https://elixir.bootlin.com/linux/latest/source/drivers/mtd/mtdcore.c#L627
	/* default value if not set by driver */
	if (mtd->bitflip_threshold == 0)
		mtd->bitflip_threshold = mtd->ecc_strength;

So this is fine.

Thanks,
Miquèl
