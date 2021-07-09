Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F613C221F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 12:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhGIKWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 06:22:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57064 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGIKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 06:22:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 169AJYpf117376;
        Fri, 9 Jul 2021 05:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1625825974;
        bh=iqKr0hwTHm9gTdhTR5L91AWYelwae2Yw4pOENSOJ+Yk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=a5Sv58/tNAoVdZrRin+Z6N31jbaOkzW4OBph5QaTOxU16ioIZzFttkKkrQxeUqMtn
         /rH5ZGU3E7l/WvW8GQeK25ZuOAxBJZaAjUyC2OVMm8K/ySbiKZbbjSeu6JQ/VgskkY
         fdqpWpSk6QVpdN8AZRijdejL0Ry9083IEoKpO7Ok=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 169AJY0S031015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Jul 2021 05:19:34 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 9 Jul
 2021 05:19:33 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 9 Jul 2021 05:19:33 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 169AJX5I095119;
        Fri, 9 Jul 2021 05:19:33 -0500
Date:   Fri, 9 Jul 2021 15:49:32 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Evgeny Novikov <novikov@ispras.ru>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lee Jones <lee.jones@linaro.org>,
        Pan Bian <bianpan2016@163.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ldv-project@linuxtesting.org>
Subject: Re: [PATCH] mtd: spi-nor: hisi-sfc: Remove excessive
 clk_disable_unprepare()
Message-ID: <20210709101930.dxgr22tl46turyhg@ti.com>
References: <20210709093542.18718-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210709093542.18718-1-novikov@ispras.ru>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/21 12:35PM, Evgeny Novikov wrote:
> hisi_spi_nor_probe() invokes clk_disable_unprepare() on all paths after
> successful call of clk_prepare_enable(), so, there is no need in one
> more clk_disable_unprepare() in hisi_spi_nor_remove(). The patch fixes
> that.

This is true, but I think the patch should also mention that the clock 
is enabled by hispi_spi_nor_prep() and disabled by 
hispi_spi_nor_unprep(). So at remove time it is not possible to have the 
clock enabled.

The big point is not that the probe disabled the clock, but that every 
path would make sure to disable the clock, so it will already be 
disabled when remove is called.

> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 

Fixes tag?

With these comments addressed,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> ---
>  drivers/mtd/spi-nor/controllers/hisi-sfc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/controllers/hisi-sfc.c b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
> index 47fbf1d1e557..516e50269478 100644
> --- a/drivers/mtd/spi-nor/controllers/hisi-sfc.c
> +++ b/drivers/mtd/spi-nor/controllers/hisi-sfc.c
> @@ -477,7 +477,6 @@ static int hisi_spi_nor_remove(struct platform_device *pdev)
>  
>  	hisi_spi_nor_unregister_all(host);
>  	mutex_destroy(&host->lock);
> -	clk_disable_unprepare(host->clk);
>  	return 0;
>  }
>  
> -- 
> 2.26.2
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
