Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7BF33AD69
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhCOI2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:28:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbhCOI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:28:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12F8SQ1Q106679;
        Mon, 15 Mar 2021 03:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615796906;
        bh=cer44ESuwilc78S3ENaREQDsWOxzb4fnQ57VISjGvWg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=EbZGdYImfBTt4n86ogAWpVYogIMHsYM+HeZD/6QdC62pUjKpnzyyk8sbFGM57dvWE
         7TYikiI4Ut3GLQ4HK87s0NCsfaQtty52qyBgXsCOTtoIACQ3x4Gvi37ECQ8X5j8NEO
         4ulliRfgZlNbcZlzd2ys0rpePaCi8Krn65qKcZrc=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12F8SQ4I022066
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Mar 2021 03:28:26 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 15
 Mar 2021 03:28:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 15 Mar 2021 03:28:25 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12F8SOHM110233;
        Mon, 15 Mar 2021 03:28:25 -0500
Date:   Mon, 15 Mar 2021 13:58:24 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Update comment about the default flash
 parameters
Message-ID: <20210315082822.xmr2wdfjg633jpdp@ti.com>
References: <20210315055634.17332-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210315055634.17332-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/21 07:56AM, Tudor Ambarus wrote:
> s/legacy/default. spi_nor_info_init_params initializes some default
> flash parameters and settings that can be overwritten when parsing
> SFDP, or by fixup hooks. There's nothing legacy about them, they are
> just some default settings, if not otherwise discovered or specified.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> ---
>  drivers/mtd/spi-nor/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 4a315cb1c4db..26f681cd3a98 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2913,7 +2913,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
>  	struct device_node *np = spi_nor_get_flash_node(nor);
>  	u8 i, erase_mask;
>  
> -	/* Initialize legacy flash parameters and settings. */
> +	/* Initialize default flash parameters and settings. */
>  	params->quad_enable = spi_nor_sr2_bit1_quad_enable;
>  	params->set_4byte_addr_mode = spansion_set_4byte_addr_mode;
>  	params->setup = spi_nor_default_setup;
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
