Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CE031BC28
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 16:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhBOPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 10:20:14 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57366 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhBOPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 10:15:35 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 11FFEI1Q097085;
        Mon, 15 Feb 2021 09:14:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1613402058;
        bh=sAjhMQukniTDz7/55gYg+80QFN69a2eXbXOPEhJIJKA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ByQHz2dch4NtMEwEIPzLXhe0bJd+pOIf2Qbj1v3T0wmFo0GjKvcn4AapHVppPRPJB
         SZ+bC8Cfa930a2BYO7aZypP0Qj6rFRalg/I5kLDFti4jbOnSTndjxu3yRgqbCCGBOZ
         N14liJ8rmSILIoCEAJltUq2bc/JCQNOkblYvxMQc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 11FFEI92060419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Feb 2021 09:14:18 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 15
 Feb 2021 09:14:18 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 15 Feb 2021 09:14:18 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 11FFEHR3054258;
        Mon, 15 Feb 2021 09:14:17 -0600
Date:   Mon, 15 Feb 2021 20:44:16 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mathieu Dubois-Briand <mbriand@witekio.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] mtd: spi-nor: sfdp: Fix out of bound array access
Message-ID: <20210215151414.6542yhluvx3yvbia@ti.com>
References: <20210212154717.362233-1-mbriand@witekio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210212154717.362233-1-mbriand@witekio.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/21 04:47PM, Mathieu Dubois-Briand wrote:
> Fix array index: explicitly use the array length to access the last
> element, instead of an incorrectly set iteration variable.
> 
> It seems this code was correct before following commit, were the
> iteration counter is reused, leading to a value that may be out of
> bound.
> Fixes: dc92843159a7 ("mtd: spi-nor: fix erase_type array to indicate
> current map conf")
> 
> Signed-off-by: Mathieu Dubois-Briand <mbriand@witekio.com>
> ---
>  drivers/mtd/spi-nor/sfdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 6ee7719e5903..11cc5d19e286 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -881,7 +881,7 @@ spi_nor_init_non_uniform_erase_map(struct spi_nor *nor,
>  		if (!(regions_erase_type & BIT(erase[i].idx)))
>  			spi_nor_set_erase_type(&erase[i], 0, 0xFF);
>  
> -	spi_nor_region_mark_end(&region[i - 1]);
> +	spi_nor_region_mark_end(&region[region_count - 1]);

I'm not too familiar with the non-uniform erase code but this looks good 
at first look. Small nitpick: move this line just after the above for 
loop that initializes this array.

>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
