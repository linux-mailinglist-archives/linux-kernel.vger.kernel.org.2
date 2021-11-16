Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B8453974
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 19:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239523AbhKPSjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 13:39:12 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45970 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239518AbhKPSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 13:39:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AGIa84N093057;
        Tue, 16 Nov 2021 12:36:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637087768;
        bh=kLxpBAPPzpG7Ic/v/YIsNbcHV9SUcEJevmIVMESsK/g=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CvD0OVkElgfloMpK9SIFH3azs9wfLLovSXB0PS/PqxjtxGRNafMxft5Yhwys1v7y4
         TH0ZjL6Mg/Sogb9UmWclPQbZoRsqoWQfUNYp7RWCfEWtM4z1GotSFfFHUhsJBXaRGk
         zN9O/vJqIYs063np+dfx99AQD8aVO3vvGWBVLVQQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AGIa8ai074142
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Nov 2021 12:36:08 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 16
 Nov 2021 12:36:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 16 Nov 2021 12:36:07 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AGIa7Gn073808;
        Tue, 16 Nov 2021 12:36:07 -0600
Date:   Wed, 17 Nov 2021 00:06:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <Alexander.Stein@tq-group.com>, <michael@walle.cc>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Message-ID: <20211116183604.otbvfiqlkowmidxr@ti.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com>
 <20211106075616.95401-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211106075616.95401-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/21 09:56AM, Tudor Ambarus wrote:
> When paring SFDP we may choose to mask out an erase type, passing
> an erase size of zero to spi_nor_set_erase_type().
> Fix shift-out-of-bounds and just clear the erase params when
> passing zero for erase size.
> While here avoid a superfluous dereference and use 'size' directly.
> 
> UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2237:24
> shift exponent 4294967295 is too large for 32-bit type 'int'
> 
> Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR flash memories")
> Reported-by: Alexander Stein <Alexander.Stein@tq-group.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 3d97c189c332..a1b5d5432f41 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2230,8 +2230,13 @@ void spi_nor_set_erase_type(struct spi_nor_erase_type *erase, u32 size,
>  	erase->size = size;
>  	erase->opcode = opcode;
>  	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */

The change itself looks fine to me. So,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

But I wonder if this code is doing the right thing. If a flash is 
setting an incorrect erase size, shouldn't we fail loudly to make sure 
the error is corrected, instead of working around it silently?

If you don't want to return an error here, how about:

	WARN_ON(ffs(size) != fls(size))

or even a dev_warn() print so the programmer is aware of this.

> -	erase->size_shift = ffs(erase->size) - 1;
> -	erase->size_mask = (1 << erase->size_shift) - 1;
> +	if (size) {
> +		erase->size_shift = ffs(size) - 1;
> +		erase->size_mask = (1 << erase->size_shift) - 1;
> +	} else {
> +		erase->size_shift = 0;
> +		erase->size_mask = 0;
> +	}
>  }
>  
>  /**
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
