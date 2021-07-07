Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB153BE72B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhGGLed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhGGLed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:34:33 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C90C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:31:52 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B2D4122239;
        Wed,  7 Jul 2021 13:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1625657510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ZkSO/jnFm2eNMsJZIihGEEoHvApT4t/5TAFIaDlWPQ=;
        b=QRICd7/tEKMmnydSGrR3nOBZsajiArNaSdb+ANhmm3P6QJoCrgiVjSIKB2VBy8EnSTgXSJ
        um/frCtugGLFzBvaoTTS1ypxYq12O0iEtpVmEycrtRvzAzrEvV2jPpeF1iApW37hwGqn30
        lW+L5arCklnx1bIr+mk35vPiA0gSuOg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 07 Jul 2021 13:31:49 +0200
From:   Michael Walle <michael@walle.cc>
To:     Steam Lin <lstfazz@gmail.com>
Cc:     tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd:spi-nor:Update Winbond SPI NOR Flash device ID
In-Reply-To: <20210707101628.GA27472@pn10-Veriton-X4610>
References: <20210707101628.GA27472@pn10-Veriton-X4610>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <35c2e5faa770e228bd16a2186c8caf78@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-07-07 12:16, schrieb Steam Lin:
> This patch is to update Winbond SPI NOR device
> ID information.
> Add new 3.3V and 1.8V device in the ID table.
> 
> Signed-off-by: Steam Lin <Stlin2@winbond.com>
> ---
>  drivers/mtd/spi-nor/winbond.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/winbond.c 
> b/drivers/mtd/spi-nor/winbond.c
> index 9a81c67a60c6..01aa49954793 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -102,6 +102,20 @@ static const struct flash_info winbond_parts[] = {
>  			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
>  	{ "w25q512jvq", INFO(0xef4020, 0, 64 * 1024, 1024,
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25h512jvm", INFO(0xef9020, 0, 64 * 1024, 1024,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q01jvq", INFO(0xef4021, 0, 64 * 1024, 2048,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q02jvq", INFO(0xef4022, 0, 64 * 1024, 4096,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25h01jvm", INFO(0xef9021, 0, 64 * 1024, 2048,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25h02jvm", INFO(0xef9022, 0, 64 * 1024, 4096,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q512nwq", INFO(0xef6020, 0, 64 * 1024, 1024,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "w25q512nwm", INFO(0xef8020, 0, 64 * 1024, 1024,
> +			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  };

Nice to see patches from the vendor! Did you test these devices? We
only accept new IDs which are actually tested. And are you aware of any
ID collisions of these chips? Eg. sometimes the JWM reused the ID of the
FW variant. How can we distinguish these?

Also, you will have to supply SFDP data for all these chips, please have
a look at [1] how to do that.

[1] 
https://lore.kernel.org/linux-mtd/7038f037de3e224016d269324517400d@walle.cc/


-michael
