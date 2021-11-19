Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCB457812
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 22:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhKSVXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 16:23:03 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42637 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbhKSVXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 16:23:00 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7110F22205;
        Fri, 19 Nov 2021 22:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1637356796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUkcSEJdODljw5mRoN1I+VbKsGyg8RbPSdW+5boz/Lk=;
        b=jXFH2YgXvQk0ZSq///qkQNrbyr1zUk2dvbckiq0uJOhENiUap00OA4TTkgpP3hXOwFLXna
        Wuxez7EJLb7al1CFnqF6rujeEakipr/t8Kc9JDEiiXt4qVojm/eacacxNL+K1a92YMVnZM
        rJvmmJXfrHVKW0He8+d/RuDHoVWLVIk=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Nov 2021 22:19:56 +0100
From:   Michael Walle <michael@walle.cc>
To:     Alexander A Sverdlin <alexander.sverdlin@nokia.com>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
In-Reply-To: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <9a158e2ef6635212c1e353590e3b773b@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2021-11-19 09:04, schrieb Alexander A Sverdlin:
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> 
> Ignore 6th ID byte, secure version of mt25qu256a has 0x73 as 6th byte.

What is the secure version? What is the difference? Do you have some
links to datasheets for both?

Also please provide the SFDP data for this flash, see [1].

-michael

[1] 
https://lore.kernel.org/linux-mtd/7038f037de3e224016d269324517400d@walle.cc/

> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> ---
>  drivers/mtd/spi-nor/micron-st.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/micron-st.c 
> b/drivers/mtd/spi-nor/micron-st.c
> index f3d19b7..509a732 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -155,9 +155,9 @@ static const struct flash_info st_parts[] = {
>  	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K |
>  			      USE_FSR | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
> -	{ "mt25qu256a",  INFO6(0x20bb19, 0x104400, 64 * 1024,  512,
> -			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> -			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "mt25qu256a",  INFO(0x20bb19, 0x1044, 64 * 1024,  512,
> +			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512,
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },
>  	{ "mt25ql512a",  INFO6(0x20ba20, 0x104400, 64 * 1024, 1024,
> @@ -167,9 +167,9 @@ static const struct flash_info st_parts[] = {
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
>  			      SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6) },
> -	{ "mt25qu512a",  INFO6(0x20bb20, 0x104400, 64 * 1024, 1024,
> -			       SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> -			       SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
> +	{ "mt25qu512a",  INFO(0x20bb20, 0x1044, 64 * 1024, 1024,
> +			      SECT_4K | USE_FSR | SPI_NOR_DUAL_READ |
> +			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
>  	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024,
>  			      SECT_4K | USE_FSR | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB |
