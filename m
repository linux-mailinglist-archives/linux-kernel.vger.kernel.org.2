Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4B3131C1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhBHMEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:04:44 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43564 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhBHLn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:43:27 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 118Bf3VY095821;
        Mon, 8 Feb 2021 05:41:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612784463;
        bh=gPOYzQig2ofMeGL6mWafYiOOQyCf2dqSmSpIbpHmeWU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=MTBOcWuXClvQcebyokW0S4QjyWi61rKsrtU+UWEpOtZjKsdomQYkM26/k2QNNE4rY
         p/CyBMUivmqcKGibwW1q4WmlEOwNYCBQoyNEAv9aCnIKZO+VWyzUjNsC4Lj110iuko
         k9Yd7c27Qr4tjOrygMT2LiDfMLJVaw4igi7tneyo=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 118Bf3BI046924
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Feb 2021 05:41:03 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Feb
 2021 05:41:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Feb 2021 05:41:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 118Bf2T1082703;
        Mon, 8 Feb 2021 05:41:02 -0600
Date:   Mon, 8 Feb 2021 17:11:01 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <Takahiro.Kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mtd: spi-nor: core: Advance erase after the erase
 cmd has been completed
Message-ID: <20210208114101.txh7ao7bi66jezrb@ti.com>
References: <20210205135253.675793-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210205135253.675793-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 03:52PM, Tudor Ambarus wrote:
> Wait for the erase cmd to complete and then advance the erase.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0522304f52fa..bcaa161bc7db 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1618,12 +1618,12 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
>  			if (ret)
>  				goto destroy_erase_cmd_list;
>  
> -			addr += cmd->size;
> -			cmd->count--;
> -
>  			ret = spi_nor_wait_till_ready(nor);
>  			if (ret)
>  				goto destroy_erase_cmd_list;
> +
> +			addr += cmd->size;
> +			cmd->count--;
>  		}
>  		list_del(&cmd->list);
>  		kfree(cmd);
> @@ -1704,12 +1704,12 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  			if (ret)
>  				goto erase_err;
>  
> -			addr += mtd->erasesize;
> -			len -= mtd->erasesize;
> -
>  			ret = spi_nor_wait_till_ready(nor);
>  			if (ret)
>  				goto erase_err;
> +
> +			addr += mtd->erasesize;
> +			len -= mtd->erasesize;

Do these changes have any practical benefit? IMO they are worth doing 
even if there is none but I'm curious what prompted this patch.

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

>  		}
>  
>  	/* erase multiple sectors */

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
