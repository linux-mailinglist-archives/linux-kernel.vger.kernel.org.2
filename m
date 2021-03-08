Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98BE33080A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhCHGWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:22:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52586 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbhCHGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:21:54 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1286LcVH104367;
        Mon, 8 Mar 2021 00:21:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615184498;
        bh=3YivBEiBFMsnIaxDC1OW9wmRCl7kuhqwo1WQbmBUmvk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=X/s7HgJCIqGKxhB4SsWqVznksB1BZ5ePK2rilZU/35ipm1xeUZwzWqBzxvizG4Ws3
         OIWqhZSZi4yE2GNtnu8Q9dqjsx8Xo6SwyiygomDovOGcQ0vU6keBi1GMe0xEZ06rCN
         nwm4J1VK20A85lN7/Y6t+pDmgTLhceseFBHGCeOU=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1286LcM5056966
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 00:21:38 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 00:21:38 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 00:21:38 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1286Lbdp070808;
        Mon, 8 Mar 2021 00:21:38 -0600
Date:   Mon, 8 Mar 2021 11:51:37 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
CC:     <vigneshr@ti.com>, <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mtd: spi-nor: core: Add vdbg msg for
 spi_nor_erase_multi_sectors()
Message-ID: <20210308062135.g3y5hv6fcnruw7li@ti.com>
References: <20210306095002.22983-1-tudor.ambarus@microchip.com>
 <20210306095002.22983-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210306095002.22983-3-tudor.ambarus@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/21 11:49AM, Tudor Ambarus wrote:
> Useful when debugging non-uniform erase.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v2: 
> - s/dev_dbg/dev_vdb
> - move vdbg message the first thing in the while
> 
>  drivers/mtd/spi-nor/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index bcaa161bc7db..498da1ec3a89 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1610,6 +1610,9 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
>  	list_for_each_entry_safe(cmd, next, &erase_list, list) {
>  		nor->erase_opcode = cmd->opcode;
>  		while (cmd->count) {
> +			dev_vdbg(nor->dev, "erase_cmd->size = 0x%08x, erase_cmd->opcode = 0x%02x, erase_cmd->count = %d\n",

erase_cmd->count is an unsigned value (u32) so it should be %u instead 
of %d.

Other than this,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

> +				 cmd->size, cmd->opcode, cmd->count);
> +
>  			ret = spi_nor_write_enable(nor);
>  			if (ret)
>  				goto destroy_erase_cmd_list;
> -- 
> 2.25.1
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
