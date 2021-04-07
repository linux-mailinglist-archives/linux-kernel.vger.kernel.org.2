Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4014635720D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 18:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354278AbhDGQT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 12:19:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56881 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbhDGQT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 12:19:57 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4FFBBC000C;
        Wed,  7 Apr 2021 16:19:45 +0000 (UTC)
Date:   Wed, 7 Apr 2021 18:19:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] memory: atmel-sdramc: check of_device_get_match_data()
 return value
Message-ID: <YG3boJNqAoNCBeIB@piout.net>
References: <20210407154447.70540-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407154447.70540-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/04/2021 17:44:47+0200, Krzysztof Kozlowski wrote:
> If the driver is probed, the of_device_get_match_data() should not
> return NULL, however for sanity check its return value.
> 

As you say, there is no way this will ever be the case, I don't see the
point of checking the return value, this adds 12 bytes for nothing...

Maybe coverity should be fixed as there are many drivers making the same
(true) assumption and I don't think this is worth the churn.

> Addresses-Coverity: Dereference null return value
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/memory/atmel-sdramc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/memory/atmel-sdramc.c b/drivers/memory/atmel-sdramc.c
> index 9c49d00c2a96..e09b2617f63d 100644
> --- a/drivers/memory/atmel-sdramc.c
> +++ b/drivers/memory/atmel-sdramc.c
> @@ -45,6 +45,8 @@ static int atmel_ramc_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  
>  	caps = of_device_get_match_data(&pdev->dev);
> +	if (!caps)
> +		return -EINVAL;
>  
>  	if (caps->has_ddrck) {
>  		clk = devm_clk_get(&pdev->dev, "ddrck");
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
