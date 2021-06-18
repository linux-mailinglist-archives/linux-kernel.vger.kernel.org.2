Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDE83AC500
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhFRHaG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Jun 2021 03:30:06 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:40217 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFRHaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:30:04 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7A333200002;
        Fri, 18 Jun 2021 07:27:53 +0000 (UTC)
Date:   Fri, 18 Jun 2021 09:27:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <nagasure@xilinx.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: rawnand: arasan: Fix missing
 clk_disable_unprepare() on error in anfc_probe()
Message-ID: <20210618092752.5f117365@xps13>
In-Reply-To: <1623816404-66213-1-git-send-email-zou_wei@huawei.com>
References: <1623816404-66213-1-git-send-email-zou_wei@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zou,

Zou Wei <zou_wei@huawei.com> wrote on Wed, 16 Jun 2021 12:06:44 +0800:

> Fix the missing clk_disable_unprepare() before return
> from anfc_probe() in the error handling case.
> 
> Fixes: 61622f6791a1 ("mtd: rawnand: arasan: Use the right DMA mask")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Thanks for the patch, 61622f6791a1 being problematic because of the
mask not being correctly declared I prefer to fix this patch inline and
if you don't mind I'll include the goto change as well.

> ---
>  drivers/mtd/nand/raw/arasan-nand-controller.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/nand/raw/arasan-nand-controller.c
> index 8317d97..9cbcc69 100644
> --- a/drivers/mtd/nand/raw/arasan-nand-controller.c
> +++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
> @@ -1452,7 +1452,7 @@ static int anfc_probe(struct platform_device *pdev)
>  
>  	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
>  	if (ret)
> -		return ret;
> +		goto disable_bus_clk;
>  
>  	ret = anfc_parse_cs(nfc);
>  	if (ret)

Thanks,
Miquèl
