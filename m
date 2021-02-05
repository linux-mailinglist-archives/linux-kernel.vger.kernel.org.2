Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8A2311796
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhBFAEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:04:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47900 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhBENsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:48:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 115DkRuB093953;
        Fri, 5 Feb 2021 07:46:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612532787;
        bh=cB0WfTEJ3j7OEluhrKCZveupuzZyWbr/N7XfkmnBgmY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=n/tLzFscrErJMCS0yYLR15tgBOTcIO/+yQiXgLgOtd8bDCXK3T68yhJa3Xz5TKyik
         d/LXwQsdss99IlzmzzU0Zg9064h7E/rvIlo8/pp6ZnX1ZOS7N03w1m4bSuFk5imJEe
         5St5bMdL/N7ZruQGgjb3TKilT6pFQhEh/ygdOTAs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 115DkRQK039984
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Feb 2021 07:46:27 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 5 Feb
 2021 07:46:26 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 5 Feb 2021 07:46:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 115DkQ0M067702;
        Fri, 5 Feb 2021 07:46:26 -0600
Date:   Fri, 5 Feb 2021 19:16:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Get rid of duplicated argument in
 spi_nor_parse_sfdp()
Message-ID: <20210205134625.6zmeit7ecqtzwyin@ti.com>
References: <20210204174507.593419-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210204174507.593419-1-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/21 07:45PM, Tudor Ambarus wrote:
> spi_nor_parse_sfdp(nor, nor->params);
> passes for the second argument a member within the first argument.
> Drop the second argument and obtain it directly from the first,
> and do it across all the children functions. This is a follow up for
> 'commit 69a8eed58cc0 ("mtd: spi-nor: Don't copy self-pointing struct around")'
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c     | 10 ++--
>  drivers/mtd/spi-nor/core.h     |  6 +--
>  drivers/mtd/spi-nor/issi.c     |  3 +-
>  drivers/mtd/spi-nor/macronix.c |  3 +-
>  drivers/mtd/spi-nor/sfdp.c     | 87 +++++++++++++---------------------
>  drivers/mtd/spi-nor/sfdp.h     |  3 +-
>  drivers/mtd/spi-nor/spansion.c | 12 ++---
>  drivers/mtd/spi-nor/winbond.c  |  3 +-
>  8 files changed, 49 insertions(+), 78 deletions(-)
> 
[...]
> @@ -945,13 +935,11 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
>   * @nor:		pointer to a 'struct spi_nor'.
>   * @param_header:	pointer to the 'struct sfdp_parameter_header' describing
>   *			the 4-Byte Address Instruction Table length and version.
> - * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
>  static int spi_nor_parse_4bait(struct spi_nor *nor,
> -			       const struct sfdp_parameter_header *param_header,
> -			       struct spi_nor_flash_parameter *params)
> +			       const struct sfdp_parameter_header *param_header)
>  {
>  	static const struct sfdp_4bait reads[] = {
>  		{ SNOR_HWCAPS_READ,		BIT(0) },
> @@ -975,8 +963,8 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>  		{ 0u /* not used */,		BIT(11) },
>  		{ 0u /* not used */,		BIT(12) },
>  	};
> -	struct spi_nor_pp_command *params_pp = params->page_programs;
> -	struct spi_nor_erase_map *map = &params->erase_map;
> +	struct spi_nor_pp_command *params_pp = nor->params->page_programs;
> +	struct spi_nor_erase_map *map = &nor->params->erase_map;
>  	struct spi_nor_erase_type *erase_type = map->erase_type;
>  	u32 *dwords;
>  	size_t len;
> @@ -1013,7 +1001,7 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>  		const struct sfdp_4bait *read = &reads[i];
>  
>  		discard_hwcaps |= read->hwcaps;
> -		if ((params->hwcaps.mask & read->hwcaps) &&
> +		if ((nor->params->hwcaps.mask & read->hwcaps) &&
>  		    (dwords[0] & read->supported_bit))
>  			read_hwcaps |= read->hwcaps;
>  	}
> @@ -1029,8 +1017,8 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>  		/*
>  		 * The 4 Byte Address Instruction (Optional) Table is the only
>  		 * SFDP table that indicates support for Page Program Commands.
> -		 * Bypass the params->hwcaps.mask and consider 4BAIT the biggest
> -		 * authority for specifying Page Program support.
> +		 * Bypass the nor->params->hwcaps.mask and consider 4BAIT the
> +		 * biggest authority for specifying Page Program support.
>  		 */
>  		discard_hwcaps |= program->hwcaps;
>  		if (dwords[0] & program->supported_bit)
> @@ -1064,12 +1052,12 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>  	 * Discard all operations from the 4-byte instruction set which are
>  	 * not supported by this memory.
>  	 */
> -	params->hwcaps.mask &= ~discard_hwcaps;
> -	params->hwcaps.mask |= (read_hwcaps | pp_hwcaps);
> +	nor->params->hwcaps.mask &= ~discard_hwcaps;
> +	nor->params->hwcaps.mask |= (read_hwcaps | pp_hwcaps);
>  
>  	/* Use the 4-byte address instruction set. */
>  	for (i = 0; i < SNOR_CMD_READ_MAX; i++) {
> -		struct spi_nor_read_command *read_cmd = &params->reads[i];
> +		struct spi_nor_read_command *read_cmd = &nor->params->reads[i];

Nitpick: 'nor->params' is used in multiple places in this function. 
Might be worth it to make it a local variable.

Either way,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

>  
>  		read_cmd->opcode = spi_nor_convert_3to4_read(read_cmd->opcode);
>  	}
[...]

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
