Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07513309DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCHJCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:02:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35588 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCHJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:01:43 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12891Udw040839;
        Mon, 8 Mar 2021 03:01:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1615194090;
        bh=SBc4yIYAS87btCmSKNU3cwCzlARC1dC5epWFyEK4swc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=CrRU1R4LXw0lZ6GKiU8VGPr7D1yUCi7kVXJ2nCN+s+tgIF3I93LyyMWIF4GSuVoca
         iwJdw/7vzuaA467dRhvjhgxORgFO6LRdsmrQN67xtAfNV1bH84pp8WMS1IuaFtLMcy
         KJCCUweSYACPft1Gm42F/JU2dKpheSQ3vzPtWShA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12891U3S060588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Mar 2021 03:01:30 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Mar
 2021 03:01:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Mar 2021 03:01:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12891TdT085976;
        Mon, 8 Mar 2021 03:01:30 -0600
Date:   Mon, 8 Mar 2021 14:31:28 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Michael Walle <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: use is_power_of_2()
Message-ID: <20210308090126.y3scr752sdm6oi5e@ti.com>
References: <20210305234552.19204-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210305234552.19204-1-michael@walle.cc>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/21 12:45AM, Michael Walle wrote:
> There is already a function to check if an integer is a power of 2. Use
> it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/mtd/spi-nor/core.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0522304f52fa..4a315cb1c4db 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2336,11 +2336,8 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  		 * If page_size is a power of two, the offset can be quickly
>  		 * calculated with an AND operation. On the other cases we
>  		 * need to do a modulus operation (more expensive).
> -		 * Power of two numbers have only one bit set and we can use
> -		 * the instruction hweight32 to detect if we need to do a
> -		 * modulus (do_div()) or not.
>  		 */
> -		if (hweight32(nor->page_size) == 1) {
> +		if (is_power_of_2(nor->page_size)) {
>  			page_offset = addr & (nor->page_size - 1);
>  		} else {
>  			uint64_t aux = addr;

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
