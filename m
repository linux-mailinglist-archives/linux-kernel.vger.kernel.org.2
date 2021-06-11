Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C13A41A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 14:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhFKMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 08:05:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56456 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbhFKMF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 08:05:58 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15BC3mhB056805;
        Fri, 11 Jun 2021 07:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1623413028;
        bh=DBEGw1E0ljrhKOmGyJHk8mVIK0GZZzfn8jadLcCmSoE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UDHRMMVw/IVN3ZhSDoJBOXXEanxMk3vtnkAhepxYZJLASXJGFyPxF/fGb4HjI/dWJ
         CZ3tzRNI/he+H2wcUfg1DTWTc4FtOBiGzlon2jthZsjsSrDPC2zPsI+nkjWq7+Y0HJ
         ReFOLpQMBdu6rQlaQE5SeoMftQg7j1s2WjjvXMRo=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15BC3mro016805
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jun 2021 07:03:48 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 11
 Jun 2021 07:03:48 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 11 Jun 2021 07:03:48 -0500
Received: from [10.250.234.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15BC3hjF092989;
        Fri, 11 Jun 2021 07:03:44 -0500
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
Message-ID: <8607134e-dd03-0f44-d636-840c1f56d2a5@ti.com>
Date:   Fri, 11 Jun 2021 17:33:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
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

Applied to spi-nor/next, thanks!
[2/2] mtd: spi-nor: macronix: Fix name for mx66l51235f
      https://git.kernel.org/mtd/c/d406f49b05

--
Regards
Vignesh
