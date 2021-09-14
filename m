Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B540B8AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 22:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhINUFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 16:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 16:05:16 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 13:03:58 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mQEeq-00DMlg-86
        for linux-kernel@vger.kernel.org; Tue, 14 Sep 2021 22:03:56 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:9c5a:5ed4:98b1:9c44]
        by yawp.biot.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1mQEej-00DMlD-Qt; Tue, 14 Sep 2021 22:03:49 +0200
Subject: Re: [PATCH v2] mtd: spinand: Add support for Etron EM73D044VCx
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexander Lobakin <alobakin@pm.me>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
References: <20210908201624.237634-1-bert@biot.com>
 <20210914193108.78df5367@xps13>
 <1517789471.73175.1631641788145.JavaMail.zimbra@nod.at>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <927c7c75-c0d3-b3fb-6b85-13dbc3c6edbe@biot.com>
Date:   Tue, 14 Sep 2021 22:03:49 +0200
MIME-Version: 1.0
In-Reply-To: <1517789471.73175.1631641788145.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/21 7:49 PM, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> bert@biot.com wrote on Wed,  8 Sep 2021 22:16:19 +0200:
>> 
>>> This adds a new vendor Etron, and support for a 2Gb chip.
>>> 
>>> The datasheet is available at
>>> https://www.etron.com/cn/products/EM73%5B8%5DC%5BD_E_F%5DVC%20SPI%20NAND%20Flash_Promotion_Rev%201_00A.pdf
>>> 
>>> Signed-off-by: Bert Vermeulen <bert@biot.com>
>>> ---
>>> v2:
>>> - Made ooblayout_free/_ecc depend on chip-specific parameters, instead of
>>>   hardcoded to this 2Gb chip only
>>> - Fixed manufacturer ordering
>>> - Fixed minor formatting issues as reported
>>> - Removed debug comment
>>> 
>>>  drivers/mtd/nand/spi/Makefile |   2 +-
>>>  drivers/mtd/nand/spi/core.c   |   1 +
>>>  drivers/mtd/nand/spi/etron.c  | 104 ++++++++++++++++++++++++++++++++++
>>>  include/linux/mtd/spinand.h   |   1 +
>>>  4 files changed, 107 insertions(+), 1 deletion(-)
>>>  create mode 100644 drivers/mtd/nand/spi/etron.c
>> 
>> [...]
>> 
>>> +static int etron_ecc_get_status(struct spinand_device *spinand, u8 status)
>>> +{
>>> +	switch (status & STATUS_ECC_MASK) {
>>> +	case STATUS_ECC_NO_BITFLIPS:
>>> +		return 0;
>>> +
>>> +	case STATUS_ECC_HAS_BITFLIPS:
>>> +		/* Between 1-7 bitflips were corrected */
>>> +		return 7;
>> 
>> Mmmh this is a bit problematic, having no intermediate value means a
>> single bitflip will trigger UBI to move the data around as its
>> threshold will be reached. Richard, any feedback on this?
> 
> So, the NAND controller can only report "no bitflips", "some bitflips", "maximum biflips" and "no way to fix"?
> If so, yes, this is problematic for UBI because it will trigger wear-leveling way too often.
> On a medium aged NAND I'd expect to see STATUS_ECC_HAS_BITFLIPS almost always set. :-(

Yes, that's all there is according to the datasheet. Can't be _that_
unusual, since that's all the STATUS_ECC_* flags cover.

Incidentally I'm abusing STATUS_ECC_MASK here, since the 0b11 pattern is
missing from those flags.


-- 
Bert Vermeulen
bert@biot.com
