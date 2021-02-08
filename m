Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D243131AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBHMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:03:27 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbhBHLmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 06:42:55 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 118BfR6O078342;
        Mon, 8 Feb 2021 05:41:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612784487;
        bh=MZ32ADHMP4HrZdls4wTuSvREGiKYZ3Atrn/ctT/TVUc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jHS4lTaqa4w9bLDX+a0tS/8dYRm8pvqc3/mibz7aXWYv5vOj6j6leeNai72/CnTEU
         VggfnXWqWPIiRbSFTFILMfjt0Rxsai7+vsT63ivtfw1KZXH+8GK5ODsAndd00NQqm3
         b971cIFYKHeWCmxRHXTd0/kz4QWAon8c08mtWj+Y=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 118BfRHv047531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Feb 2021 05:41:27 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Feb
 2021 05:41:26 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Feb 2021 05:41:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 118BfQe8113623;
        Mon, 8 Feb 2021 05:41:26 -0600
Date:   Mon, 8 Feb 2021 17:11:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <Takahiro.Kuwano@infineon.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mtd: spi-nor: core: Add dbg msg for
 spi_nor_erase_multi_sectors()
Message-ID: <20210208114125.5bmdvywjcruvhu7a@ti.com>
References: <20210205135253.675793-1-tudor.ambarus@microchip.com>
 <20210205135253.675793-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210205135253.675793-2-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 03:52PM, Tudor Ambarus wrote:
> Useful when debugging non-uniform erase.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index bcaa161bc7db..7401c60b53e6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1622,6 +1622,9 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
>  			if (ret)
>  				goto destroy_erase_cmd_list;
>  
> +			dev_dbg(nor->dev, "erase_cmd->size = 0x%08x, erase_cmd->opcode = 0x%02x, erase_cmd->count = %d\n",
> +				cmd->size, cmd->opcode, cmd->count);
> +

I don't like the position of this debug message. This prints cmd->count 
_after_ the erase is done but _before_ cmd->count is updated. It might 
end up giving some wrong or misleading information. Can you either move 
it before the start of the erase or after all the bookkeeping is done?

>  			addr += cmd->size;
>  			cmd->count--;
>  		}
> -- 
> 2.25.1

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
