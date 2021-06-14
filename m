Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A633A5D50
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbhFNG7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:59:07 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:47295 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbhFNG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:59:05 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id BFB982225B;
        Mon, 14 Jun 2021 08:56:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1623653820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1AgvWwEgWNbd/ZFEwqZyF0GXiy7g1Jx3V20t6vTDlAs=;
        b=PKhJIU1/cFO6ly5cziLdB3k5N19D6kgoI3OGLCIasC5+h3qhqbETiSoEo9ukKb9YxDUth8
        mB8ae63ghOZtPxByjBS8PcQPU1T8iHK+x/zi+wSTfR+H+0X3ep8jOmTW0ezrMcsLAENBoA
        Xa6ITPxxKhtfSuh4aeEXDGXcJABPHqg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jun 2021 08:56:59 +0200
From:   Michael Walle <michael@walle.cc>
To:     Reto Schneider <code@reto-schneider.ch>
Cc:     linux-mtd@lists.infradead.org, Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for XM25QH64C
In-Reply-To: <20210613121248.1529292-1-code@reto-schneider.ch>
References: <20210613121248.1529292-1-code@reto-schneider.ch>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <1ba367f93650cb65122acd32fb4a4159@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reto,

Am 2021-06-13 14:12, schrieb Reto Schneider:
> From: Reto Schneider <reto.schneider@husqvarnagroup.com>
> 
> The data sheets can be found here:
> http://xmcwh.com/Uploads/2020-12-17/XM25QH64C_Ver1.1.pdf

Could you add that as a "Datasheet:" tag before your Sob tag?

> This chip has been (briefly) tested on the MediaTek MT7688 based 
> GARDENA
> smart gateway.

Could you also apply my SFDP patch [1] and send the dump? Unfortunately,
I can't think of a good way to do that along with the patch and if this
in some way regarded as copyrighted material. So feel free to send it to
me privately. I'm starting to build a database.

> Signed-off-by: Reto Schneider <reto.schneider@husqvarnagroup.com>

With that fixed:
Reviewed-by: Michael Walle <michael@walle.cc>

NB. XMC ignores the continuation codes and this particular device will
collide with M25PE64/M45PE64. Although I couldn't find any datasheet,
so I don't know if these devices actually exist.

-michael

[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=241877

> 
> ---
> 
>  drivers/mtd/spi-nor/xmc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
> index 2c7773b68993..b6ac37bd59b8 100644
> --- a/drivers/mtd/spi-nor/xmc.c
> +++ b/drivers/mtd/spi-nor/xmc.c
> @@ -12,6 +12,8 @@ static const struct flash_info xmc_parts[] = {
>  	/* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
>  	{ "XM25QH64A", INFO(0x207017, 0, 64 * 1024, 128,
>  			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ "XM25QH64C", INFO(0x204017, 0, 64 * 1024, 128,
> +			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "XM25QH128A", INFO(0x207018, 0, 64 * 1024, 256,
>  			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  };
