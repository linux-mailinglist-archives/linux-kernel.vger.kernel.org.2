Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA62539D89E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhFGJZU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Jun 2021 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFGJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 05:25:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37DC061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 02:23:25 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqBTf-0005q9-NM; Mon, 07 Jun 2021 11:23:23 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1lqBTf-0000J6-Er; Mon, 07 Jun 2021 11:23:23 +0200
Message-ID: <b3c26d2f29715bdd2771246b26b070fba1d457fe.camel@pengutronix.de>
Subject: Re: [PATCH -next] reset: lantiq: use
 devm_reset_controller_register()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Jun 2021 11:23:23 +0200
In-Reply-To: <20210517032648.2969609-1-yangyingliang@huawei.com>
References: <20210517032648.2969609-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-05-17 at 11:26 +0800, Yang Yingliang wrote:
> Use devm_reset_controller_register() for the reset controller
> registration.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/reset/reset-lantiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/reset-lantiq.c b/drivers/reset/reset-lantiq.c
> index ac41d093de13..b936cfe85641 100644
> --- a/drivers/reset/reset-lantiq.c
> +++ b/drivers/reset/reset-lantiq.c
> @@ -186,7 +186,7 @@ static int lantiq_rcu_reset_probe(struct platform_device *pdev)
>  	priv->rcdev.of_xlate = lantiq_rcu_reset_xlate;
>  	priv->rcdev.of_reset_n_cells = 2;
>  
> -	return reset_controller_register(&priv->rcdev);
> +	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
>  }
>  
>  static const struct of_device_id lantiq_rcu_reset_dt_ids[] = {

Thank you, applied to reset/next.

regards
Philipp
