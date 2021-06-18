Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10803AC7FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 11:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhFRJwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 05:52:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47126 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFRJwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 05:52:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15I9ngak043474;
        Fri, 18 Jun 2021 04:49:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624009782;
        bh=iqV8NYyu2Z+wt7+T9yDBVD8D5iDgl5KwgdPNRoxTtgo=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=yOYougPeo5VAzEsmWB+G1Hl7fHj/fdGGu6Y1MipvVb8K1FaRcih4/eOwoAj/VlGLc
         MSbXXHTcxsM+TTU27B5GiqcirYXOuKjoOLPAUJmAGbehah9QXrHejRbs8e1qC5+tgT
         qbRbS0OK7X0FJL1OlrHZiIJS5F2MjWBKTLJ+a7tc=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15I9ngEW007211
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Jun 2021 04:49:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 18
 Jun 2021 04:49:41 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 18 Jun 2021 04:49:41 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15I9nfK3015641;
        Fri, 18 Jun 2021 04:49:41 -0500
Date:   Fri, 18 Jun 2021 15:19:40 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Colin King <colin.king@canonical.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  mtd: spi-nor: remove redundant continue statement
Message-ID: <20210618094938.ev3awgs6lhzncg7a@ti.com>
References: <20210618093331.100006-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210618093331.100006-1-colin.king@canonical.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/21 10:33AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The continue statement at the end of a for-loop has no effect,
> invert the if expression and remove the continue.
> 
> Addresses-Coverity: ("Continue has no effect")

I haven't seen this tag used much before. I am not sure how useful it is.

Other than this,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/spi-nor/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 970ed6e3f3ba..cc08bd707378 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1411,9 +1411,7 @@ spi_nor_find_best_erase_type(const struct spi_nor_erase_map *map,
>  			continue;
>  
>  		spi_nor_div_by_erase_size(erase, addr, &rem);
> -		if (rem)
> -			continue;
> -		else
> +		if (!rem)
>  			return erase;
>  	}
>  

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
