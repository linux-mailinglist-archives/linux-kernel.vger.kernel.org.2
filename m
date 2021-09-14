Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5D340B5E7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhINRca convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Sep 2021 13:32:30 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36093 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:32:29 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 59185E0008;
        Tue, 14 Sep 2021 17:31:09 +0000 (UTC)
Date:   Tue, 14 Sep 2021 19:31:08 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Bert Vermeulen <bert@biot.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx
Message-ID: <20210914193108.78df5367@xps13>
In-Reply-To: <20210908201624.237634-1-bert@biot.com>
References: <20210908201624.237634-1-bert@biot.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bert,

Richard, a question for you below!

bert@biot.com wrote on Wed,  8 Sep 2021 22:16:19 +0200:

> This adds a new vendor Etron, and support for a 2Gb chip.
> 
> The datasheet is available at
> https://www.etron.com/cn/products/EM73%5B8%5DC%5BD_E_F%5DVC%20SPI%20NAND%20Flash_Promotion_Rev%201_00A.pdf
> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
> v2:
> - Made ooblayout_free/_ecc depend on chip-specific parameters, instead of
>   hardcoded to this 2Gb chip only
> - Fixed manufacturer ordering
> - Fixed minor formatting issues as reported
> - Removed debug comment
> 
>  drivers/mtd/nand/spi/Makefile |   2 +-
>  drivers/mtd/nand/spi/core.c   |   1 +
>  drivers/mtd/nand/spi/etron.c  | 104 ++++++++++++++++++++++++++++++++++
>  include/linux/mtd/spinand.h   |   1 +
>  4 files changed, 107 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/etron.c

[...]

> +static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
> +{
> +	switch (status & STATUS_ECC_MASK) {
> +	case STATUS_ECC_NO_BITFLIPS:
> +		return 0;
> +
> +	case STATUS_ECC_HAS_BITFLIPS:
> +		/* Between 1-7 bitflips were corrected */
> +		return 7;

Mmmh this is a bit problematic, having no intermediate value means a
single bitflip will trigger UBI to move the data around as its
threshold will be reached. Richard, any feedback on this?

> +
> +	case STATUS_ECC_MASK:
> +		/* Maximum bitflips were corrected */
> +		return 8;
> +
> +	case STATUS_ECC_UNCOR_ERROR:
> +		return -EBADMSG;
> +	}
> +
> +	return -EINVAL;
> +}

Thanks,
Miquèl
