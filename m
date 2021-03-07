Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2384D3302CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 16:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbhCGPzn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 7 Mar 2021 10:55:43 -0500
Received: from aposti.net ([89.234.176.197]:34186 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230410AbhCGPzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 10:55:11 -0500
Date:   Sun, 07 Mar 2021 15:54:57 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH -next] phy: ingenic: Fix a typo in ingenic_usb_phy_probe()
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>,
        =?UTF-8?b?5ryG6bmP5oyv?= <aric.pzqi@ingenic.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Message-Id: <L7WLPQ.OX36H4LIU83T3@crapouillou.net>
In-Reply-To: <20210305034933.3240914-1-weiyongjun1@huawei.com>
References: <20210305034933.3240914-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le ven. 5 mars 2021 à 3:49, 'Wei Yongjun <weiyongjun1@huawei.com> a 
écrit :
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix the return value check typo which testing the wrong variable
> in ingenic_usb_phy_probe().
> 
> Fixes: 31de313dfdcf ("PHY: Ingenic: Add USB PHY driver using generic 
> PHY framework.")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/phy/ingenic/phy-ingenic-usb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/ingenic/phy-ingenic-usb.c 
> b/drivers/phy/ingenic/phy-ingenic-usb.c
> index ea127b177f46..28c28d816484 100644
> --- a/drivers/phy/ingenic/phy-ingenic-usb.c
> +++ b/drivers/phy/ingenic/phy-ingenic-usb.c
> @@ -352,8 +352,8 @@ static int ingenic_usb_phy_probe(struct 
> platform_device *pdev)
>  	}
> 
>  	priv->phy = devm_phy_create(dev, NULL, &ingenic_usb_phy_ops);
> -	if (IS_ERR(priv))
> -		return PTR_ERR(priv);
> +	if (IS_ERR(priv->phy))
> +		return PTR_ERR(priv->phy);
> 
>  	phy_set_drvdata(priv->phy, priv);
> 
> 


