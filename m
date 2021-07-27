Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142843D7001
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhG0HJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 03:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0HJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:09:56 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3CC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 00:09:57 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 204F922234;
        Tue, 27 Jul 2021 09:09:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1627369794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOJFW/hcqRz7AGRgmL25IuiXB0pKdensyRUsdiGJkUc=;
        b=FRBttgS1hRR69hjIKmi0XFB4cO3NI6oDhr6RpxoZAuCt0K7N0h3I9jS9ueGlrgYQ70SFNu
        btGz4vze57Q466VTcBdC8Qwa82G8pu13diNNG7qBhRojLDvUdaA44WJcXGVvycpAA576I1
        919MAB1DGYKZ9Tqvx1NmFVn7172rwyw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Jul 2021 09:09:53 +0200
From:   Michael Walle <michael@walle.cc>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: spi-nor: micron-st: sync flags of mt25ql02g and
 mt25qu02g with other mt25q
In-Reply-To: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
References: <c7b6c666aef9a8a2195acabe9954a417f04b6582.1627039534.git.matthias.schiffer@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f3dbab898e9f1946129e5733095bdf3c@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-07-23 13:27, schrieb Matthias Schiffer:
> All mt25q variants have the same features.
> 
> Unlike the smaller variants, no n25q with 2G exists, so we don't need 
> to
> match on the extended ID to distinguish n25q and mt25q series for these
> models.

But why shouldn't we? What if there will be another flash with
the same first three id bytes?

> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index c224e59820a1..d5baa8762c8d 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -181,11 +181,11 @@ static const struct flash_info st_parts[] = {
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      NO_CHIP_ERASE) },
>  	{ "mt25ql02g",   INFO(0x20ba22, 0, 64 * 1024, 4096,
> -			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
> -			      NO_CHIP_ERASE) },

This bothers me. I'm not sure how this will work. I see that
chip erase is command 0xc7, but both the new and the old flash
just supports 0xc3 (DIE ERASE). Did you test these changes?

> +			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "mt25qu02g",   INFO(0x20bb22, 0, 64 * 1024, 4096,
>  			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> -			      SPI_NOR_QUAD_READ | NO_CHIP_ERASE) },
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> 
>  	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
>  	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },

-michael
