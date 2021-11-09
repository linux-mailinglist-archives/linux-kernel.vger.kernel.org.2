Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ABD44AEBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbhKINbT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Nov 2021 08:31:19 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49259 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235585AbhKINbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:31:18 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 51995C0004;
        Tue,  9 Nov 2021 13:28:29 +0000 (UTC)
Date:   Tue, 9 Nov 2021 14:28:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: rawnand: denali: Add the dependency on HAS_IOMEM
Message-ID: <20211109142828.3e4ec837@xps13>
In-Reply-To: <20211109125457.213-1-caihuoqing@baidu.com>
References: <20211109125457.213-1-caihuoqing@baidu.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cai,

caihuoqing@baidu.com wrote on Tue, 9 Nov 2021 20:54:55 +0800:

> The helper function devm_platform_ioremap_resource_xxx()
> needs HAS_IOMEM enabled, so add the dependency on HAS_IOMEM.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---

 Can you please add a Fixes tag?

>  drivers/mtd/nand/raw/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 67b7cb67c030..0a45d3c6c15b 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -26,7 +26,7 @@ config MTD_NAND_DENALI_PCI
>  config MTD_NAND_DENALI_DT
>  	tristate "Denali NAND controller as a DT device"
>  	select MTD_NAND_DENALI
> -	depends on HAS_DMA && HAVE_CLK && OF
> +	depends on HAS_DMA && HAVE_CLK && OF && HAS_IOMEM
>  	help
>  	  Enable the driver for NAND flash on platforms using a Denali NAND
>  	  controller as a DT device.


Thanks,
Miquèl
