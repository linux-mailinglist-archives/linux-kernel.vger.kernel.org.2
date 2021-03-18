Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DEA34076A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCROLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:11:42 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37779 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCROLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:11:10 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 42A7DFF81E;
        Thu, 18 Mar 2021 14:11:03 +0000 (UTC)
Date:   Thu, 18 Mar 2021 15:11:03 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     'w00385741 <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] phy: sparx5_serdes: Fix return value check in
 sparx5_serdes_probe()
Message-ID: <YFNfd+zVwyxiuiuk@piout.net>
References: <20210318135647.1286295-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318135647.1286295-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 18/03/2021 13:56:47+0000, 'w00385741 wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> In case of error, the function devm_ioremap() returns NULL
> pointer not ERR_PTR(). The IS_ERR() test in the return value
> check should be replaced with NULL test.
> 
> Fixes: 2ff8a1eeb5aa ("phy: Add Sparx5 ethernet serdes PHY driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/phy/microchip/sparx5_serdes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
> index 06bcf0c166cf..dd854d825000 100644
> --- a/drivers/phy/microchip/sparx5_serdes.c
> +++ b/drivers/phy/microchip/sparx5_serdes.c
> @@ -2438,10 +2438,10 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
>  
>  	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	iomem = devm_ioremap(priv->dev, iores->start, iores->end - iores->start + 1);
> -	if (IS_ERR(iomem)) {
> +	if (!iomem) {
>  		dev_err(priv->dev, "Unable to get serdes registers: %s\n",
>  			iores->name);
> -		return PTR_ERR(iomem);
> +		return -ENOMEM;
>  	}

A better fix would use devm_platform_ioremap_resource and get rid of the
error messages

>  	for (idx = 0; idx < ARRAY_SIZE(sparx5_serdes_iomap); idx++) {
>  		struct sparx5_serdes_io_resource *iomap = &sparx5_serdes_iomap[idx];
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
