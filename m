Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA433ECFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 09:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbhHPHtT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Aug 2021 03:49:19 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44071 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhHPHtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 03:49:14 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 5374F1BF207;
        Mon, 16 Aug 2021 07:48:39 +0000 (UTC)
Date:   Mon, 16 Aug 2021 09:48:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        Anton Vasilyev <vasilyev@ispras.ru>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: intel: Fix error handling in probe
Message-ID: <20210816094838.78c8e248@xps13>
In-Reply-To: <20210812110100.1279-1-novikov@ispras.ru>
References: <20210812110100.1279-1-novikov@ispras.ru>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeny,

Evgeny Novikov <novikov@ispras.ru> wrote on Thu, 12 Aug 2021 14:01:00
+0300:

> ebu_nand_probe() did not invoke ebu_dma_cleanup() and
> clk_disable_unprepare() on some error handling paths. The patch fixes
> that.
> 
> Found by Linux Driver Verification project (linuxtesting.org).

LGTM

Can you add a Fixes: tag and possibly a Cc: stable tag as well?
(same for "mtd: rawnand: mxic: Enable and prepare clocks in probe")

> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> Co-developed-by: Anton Vasilyev <vasilyev@ispras.ru>
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
>  drivers/mtd/nand/raw/intel-nand-controller.c | 27 +++++++++++++-------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
> index 8b49fd56cf96..29e8a546dcd6 100644
> --- a/drivers/mtd/nand/raw/intel-nand-controller.c
> +++ b/drivers/mtd/nand/raw/intel-nand-controller.c
> @@ -631,19 +631,26 @@ static int ebu_nand_probe(struct platform_device *pdev)
>  	ebu_host->clk_rate = clk_get_rate(ebu_host->clk);
>  
>  	ebu_host->dma_tx = dma_request_chan(dev, "tx");
> -	if (IS_ERR(ebu_host->dma_tx))
> -		return dev_err_probe(dev, PTR_ERR(ebu_host->dma_tx),
> -				     "failed to request DMA tx chan!.\n");
> +	if (IS_ERR(ebu_host->dma_tx)) {
> +		ret = dev_err_probe(dev, PTR_ERR(ebu_host->dma_tx),
> +				    "failed to request DMA tx chan!.\n");
> +		goto err_disable_unprepare_clk;
> +	}
>  
>  	ebu_host->dma_rx = dma_request_chan(dev, "rx");
> -	if (IS_ERR(ebu_host->dma_rx))
> -		return dev_err_probe(dev, PTR_ERR(ebu_host->dma_rx),
> -				     "failed to request DMA rx chan!.\n");
> +	if (IS_ERR(ebu_host->dma_rx)) {
> +		ret = dev_err_probe(dev, PTR_ERR(ebu_host->dma_rx),
> +				    "failed to request DMA rx chan!.\n");
> +		ebu_host->dma_rx = NULL;
> +		goto err_cleanup_dma;
> +	}
>  
>  	resname = devm_kasprintf(dev, GFP_KERNEL, "addr_sel%d", cs);
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, resname);
> -	if (!res)
> -		return -EINVAL;
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto err_cleanup_dma;
> +	}
>  	ebu_host->cs[cs].addr_sel = res->start;
>  	writel(ebu_host->cs[cs].addr_sel | EBU_ADDR_MASK(5) | EBU_ADDR_SEL_REGEN,
>  	       ebu_host->ebu + EBU_ADDR_SEL(cs));
> @@ -653,7 +660,8 @@ static int ebu_nand_probe(struct platform_device *pdev)
>  	mtd = nand_to_mtd(&ebu_host->chip);
>  	if (!mtd->name) {
>  		dev_err(ebu_host->dev, "NAND label property is mandatory\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_cleanup_dma;
>  	}
>  
>  	mtd->dev.parent = dev;
> @@ -681,6 +689,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
>  	nand_cleanup(&ebu_host->chip);
>  err_cleanup_dma:
>  	ebu_dma_cleanup(ebu_host);
> +err_disable_unprepare_clk:
>  	clk_disable_unprepare(ebu_host->clk);
>  
>  	return ret;

Thanks,
Miquèl
