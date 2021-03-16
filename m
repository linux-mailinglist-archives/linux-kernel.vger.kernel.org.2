Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F5E33D215
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 11:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhCPKok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 06:44:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60202 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbhCPKm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 06:42:57 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12GAgQak029751;
        Tue, 16 Mar 2021 05:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615891346;
        bh=woWUaDHqVhUcUtdUKUvj06vRIr/+mBAcjXA8swBJfz0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=tR5YiqdCx3SQLgf4rimr8J7hFqWHPBLmYenarpdx29h4mG+p+2Fi/g3o9/xjQeyxa
         l+tJ62QKDU6NgAO3Cc4yyDEYhYEtKTtdZlnKPUUG+/JgkI0ef2PwA5m7a88gmrOdJ7
         TRTB5wLLe4JRYB2froHpDCxkB2eJpHXpd9Hc2udw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12GAgQa1091537
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Mar 2021 05:42:26 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 16
 Mar 2021 05:42:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 16 Mar 2021 05:42:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12GAgPNe023921;
        Tue, 16 Mar 2021 05:42:26 -0500
Date:   Tue, 16 Mar 2021 16:12:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/3] mtd: spi-nor: sfdp: remember sfdp_size
Message-ID: <20210316104223.42tdob3uwjxc5vdz@ti.com>
References: <20210312190548.6954-1-michael@walle.cc>
 <20210312190548.6954-2-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210312190548.6954-2-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/21 08:05PM, Michael Walle wrote:
> Save the sftp_size in the spi_nor struct so we can use it to dump the
> SFDP table without parsing the headers again.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/sfdp.c  | 12 ++++++++++++
>  include/linux/mtd/spi-nor.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 25142ec4737b..b1814afefc33 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -16,6 +16,7 @@
>  	(((p)->parameter_table_pointer[2] << 16) | \
>  	 ((p)->parameter_table_pointer[1] <<  8) | \
>  	 ((p)->parameter_table_pointer[0] <<  0))
> +#define SFDP_PARAM_HEADER_PARAM_LEN(p) ((p)->length * 4)
>  
>  #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
>  #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
> @@ -1263,6 +1264,7 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	struct sfdp_parameter_header *param_headers = NULL;
>  	struct sfdp_header header;
>  	struct device *dev = nor->dev;
> +	size_t param_max_offset;
>  	size_t psize;
>  	int i, err;
>  
> @@ -1285,6 +1287,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>  	    bfpt_header->major != SFDP_JESD216_MAJOR)
>  		return -EINVAL;
>  
> +	nor->sfdp_size = SFDP_PARAM_HEADER_PTP(bfpt_header) +
> +			 SFDP_PARAM_HEADER_PARAM_LEN(bfpt_header);
> +
>  	/*
>  	 * Allocate memory then read all parameter headers with a single
>  	 * Read SFDP command. These parameter headers will actually be parsed
> @@ -1311,6 +1316,13 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
>  		}
>  	}
>  
> +	for (i = 0; i < header.nph; i++) {
> +		param_header = &param_headers[i];
> +		param_max_offset = SFDP_PARAM_HEADER_PTP(param_header) +
> +				   SFDP_PARAM_HEADER_PARAM_LEN(param_header);
> +		nor->sfdp_size = max(nor->sfdp_size, param_max_offset);
> +	}
> +

I don't see any mention in the SFDP spec (JESD216D-01) that parameter 
tables have to be contiguous. In fact, it says that "Parameter tables 
may be located anywhere in the SFDP space. They do not need to 
immediately follow the parameter headers". But I guess we can just say 
the sysfs entry exports the entire SFDP space instead of just the tables 
so that is OK.

This patch looks good to me other than the small nitpick that we can 
merge this loop and the one below that tries to find the latest BFPT 
version.

>  	/*
>  	 * Check other parameter headers to get the latest revision of
>  	 * the basic flash parameter table.
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index a0d572855444..a58118b8b002 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -404,6 +404,7 @@ struct spi_nor {
>  	bool			sst_write_second;
>  	u32			flags;
>  	enum spi_nor_cmd_ext	cmd_ext_type;
> +	size_t			sfdp_size;

Documentation for this variable missing.

>  
>  	const struct spi_nor_controller_ops *controller_ops;
>  
> -- 
> 2.20.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
