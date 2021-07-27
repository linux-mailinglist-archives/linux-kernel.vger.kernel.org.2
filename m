Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2093D7029
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbhG0HRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhG0HR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:17:28 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD69C061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:17:29 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 39A0C22234;
        Tue, 27 Jul 2021 09:17:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1627370247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnHLdYRwFXqB9sGtryvI3Km836ruQ7zDsaH1AHnvSZ8=;
        b=lyIgvKu6k6yDVCG1D7gJDVVMSgZWMjAOwk/FrJ2dlhdWhqqkl0iDnq2mNKz/B5N2vU/Ts9
        a7xdoFoQftMUqGx69pJChkVxcOP9fJ6/ERcj2DDHOicgsO5tc7WFM/xla5FcbNx+VzrbBq
        RZWW/o0v6WKZaAwe9UtDJPThYlS1J0Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Jul 2021 09:17:26 +0200
From:   Michael Walle <michael@walle.cc>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mtd: spi-nor: micron-st: add support for mt25ql01g
 and mt25qu01g
In-Reply-To: <a979f3a66e9e4391844d1fae144a32646933c86f.1627039534.git.matthias.schiffer@ew.tq-group.com>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
 <a979f3a66e9e4391844d1fae144a32646933c86f.1627039534.git.matthias.schiffer@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1b4e1495ab019778f671661cc7bdb539@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-07-23 13:27, schrieb Matthias Schiffer:
> Split these mt25q models from the older n25q models by matching their
> extended IDs to allow adding support for 4byte opcodes.

You will have to supply SFDP data for all these chips, please have
a look at [1] how to do that.

Also, we'll switch to SFDP parsing, have a look at [2].

> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index d5baa8762c8d..2fca5de2504f 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -172,11 +172,17 @@ static const struct flash_info st_parts[] = {
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>  			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
> +	{ "mt25ql01g",   INFO6(0x20ba21, 0x104400, 64 * 1024, 2048,
> +			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },

As mentioned in my other mail, I don't see this chip supporting 0xc7
(BULK ERASE). Is erasing the whole chip working?

Thanks,
-michael

>  	{ "n25q00",      INFO(0x20ba21, 0, 64 * 1024, 2048,
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>  			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6 |
>  			      NO_CHIP_ERASE) },
> +	{ "mt25qu01g",   INFO6(0x20bb21, 0x104400, 64 * 1024, 2048,
> +			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "n25q00a",     INFO(0x20bb21, 0, 64 * 1024, 2048,
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      NO_CHIP_ERASE) },

[1] 
https://lore.kernel.org/linux-mtd/7038f037de3e224016d269324517400d@walle.cc/
[2] 
https://lore.kernel.org/linux-mtd/20210727045222.905056-36-tudor.ambarus@microchip.com/
