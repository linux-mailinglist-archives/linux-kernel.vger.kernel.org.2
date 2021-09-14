Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA3740B63A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbhINRvK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Sep 2021 13:51:10 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35986 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhINRvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:51:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5C1986171AF2;
        Tue, 14 Sep 2021 19:49:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Zkvx2aJaA6pc; Tue, 14 Sep 2021 19:49:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 85FA16171AF9;
        Tue, 14 Sep 2021 19:49:48 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3WI4YRxwFkYj; Tue, 14 Sep 2021 19:49:48 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 571C96171AF2;
        Tue, 14 Sep 2021 19:49:48 +0200 (CEST)
Date:   Tue, 14 Sep 2021 19:49:48 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Bert Vermeulen <bert@biot.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1517789471.73175.1631641788145.JavaMail.zimbra@nod.at>
In-Reply-To: <20210914193108.78df5367@xps13>
References: <20210908201624.237634-1-bert@biot.com> <20210914193108.78df5367@xps13>
Subject: Re: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF92 (Linux)/8.8.12_GA_3809)
Thread-Topic: spinand: Add support for Etron EM73D044VCx
Thread-Index: uDL3zzNaZeNLZi7f2ywi+WlYy888Ew==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> An: "richard" <richard@nod.at>
> CC: "Bert Vermeulen" <bert@biot.com>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Patrice Chotard"
> <patrice.chotard@foss.st.com>, "Boris Brezillon" <boris.brezillon@collabora.com>, "Christophe Kerello"
> <christophe.kerello@foss.st.com>, "Mark Brown" <broonie@kernel.org>, "Alexander Lobakin" <alobakin@pm.me>,
> "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mtd" <linux-mtd@lists.infradead.org>
> Gesendet: Dienstag, 14. September 2021 19:31:08
> Betreff: Re: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx

> Hi Bert,
> 
> Richard, a question for you below!

:)
 
> bert@biot.com wrote on Wed,  8 Sep 2021 22:16:19 +0200:
> 
>> This adds a new vendor Etron, and support for a 2Gb chip.
>> 
>> The datasheet is available at
>> https://www.etron.com/cn/products/EM73%5B8%5DC%5BD_E_F%5DVC%20SPI%20NAND%20Flash_Promotion_Rev%201_00A.pdf
>> 
>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>> ---
>> v2:
>> - Made ooblayout_free/_ecc depend on chip-specific parameters, instead of
>>   hardcoded to this 2Gb chip only
>> - Fixed manufacturer ordering
>> - Fixed minor formatting issues as reported
>> - Removed debug comment
>> 
>>  drivers/mtd/nand/spi/Makefile |   2 +-
>>  drivers/mtd/nand/spi/core.c   |   1 +
>>  drivers/mtd/nand/spi/etron.c  | 104 ++++++++++++++++++++++++++++++++++
>>  include/linux/mtd/spinand.h   |   1 +
>>  4 files changed, 107 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mtd/nand/spi/etron.c
> 
> [...]
> 
>> +static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
>> +{
>> +	switch (status & STATUS_ECC_MASK) {
>> +	case STATUS_ECC_NO_BITFLIPS:
>> +		return 0;
>> +
>> +	case STATUS_ECC_HAS_BITFLIPS:
>> +		/* Between 1-7 bitflips were corrected */
>> +		return 7;
> 
> Mmmh this is a bit problematic, having no intermediate value means a
> single bitflip will trigger UBI to move the data around as its
> threshold will be reached. Richard, any feedback on this?

So, the NAND controller can only report "no bitflips", "some bitflips", "maximum biflips" and "no way to fix"?
If so, yes, this is problematic for UBI because it will trigger wear-leveling way too often.
On a medium aged NAND I'd expect to see STATUS_ECC_HAS_BITFLIPS almost always set. :-(

Thanks,
//richard
