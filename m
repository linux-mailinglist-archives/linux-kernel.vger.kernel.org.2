Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCB392A25
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 10:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235614AbhE0I5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 04:57:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:32790 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbhE0I5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 04:57:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14R8tNFO022640;
        Thu, 27 May 2021 03:55:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622105723;
        bh=K6eMFOHEUvNcLz89WRRcZR6IpOH/ULeDLIn6bsztCY8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mTM0XOQUc4CFJH+VzkzmKD5KL8ATuZXxivK51Wxkt4c7lSyjwTLq//pGgXmURnc50
         NW9SPfqQZJS9YXEQF+zzkYrxtFRGnN97+oz9Sl5xvNXyf4cSP7s4uc/UN93yiPcwau
         7Db6ELXuLQ6cKB+zPyN5TmNoCQQzErwUgzKljEjw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14R8tNPI030193
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 May 2021 03:55:23 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 03:55:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 27 May 2021 03:55:22 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14R8tHRm083184;
        Thu, 27 May 2021 03:55:18 -0500
Subject: Re: [PATCH 2/2] mtd: spi-nor: macronix: Fix name for mx66l51235f
To:     Tudor Ambarus <tudor.ambarus@microchip.com>, <michael@walle.cc>,
        <p.yadav@ti.com>, <masonccyang@mxic.com.tw>,
        <zhengxunli@mxic.com.tw>, <ycllin@mxic.com.tw>,
        <juliensu@mxic.com.tw>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210402082031.19055-1-tudor.ambarus@microchip.com>
 <20210402082031.19055-3-tudor.ambarus@microchip.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <6c673b45-ce66-bdce-a860-5c32b9149bd5@ti.com>
Date:   Thu, 27 May 2021 14:25:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210402082031.19055-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/2/21 1:50 PM, Tudor Ambarus wrote:
> According to macronix website, there is no mx66l51235l part number.
> The chip detected as such is actually mx66l51235f. Rename the flash.
> Do not update the mx66l51235l name from the spi_nor_dev_ids[], since
> there are dt that are using this compatible.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  drivers/mtd/spi-nor/macronix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> index 42c2cf31702e..c8167de55e55 100644
> --- a/drivers/mtd/spi-nor/macronix.c
> +++ b/drivers/mtd/spi-nor/macronix.c
> @@ -72,7 +72,7 @@ static const struct flash_info macronix_parts[] = {
>  			      SECT_4K | SPI_NOR_DUAL_READ |
>  			      SPI_NOR_QUAD_READ) },
>  	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
> -	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
> +	{ "mx66l51235f", INFO(0xc2201a, 0, 64 * 1024, 1024,
>  			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>  			      SPI_NOR_4B_OPCODES) },
>  	{ "mx66u51235f", INFO(0xc2253a, 0, 64 * 1024, 1024,
> 
