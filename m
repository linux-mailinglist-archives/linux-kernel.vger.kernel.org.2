Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6E33F7B91
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242356AbhHYRa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:30:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48239 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S242307AbhHYRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:30:25 -0400
Received: (qmail 198861 invoked by uid 1000); 25 Aug 2021 13:29:37 -0400
Date:   Wed, 25 Aug 2021 13:29:37 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable()
 in probe
Message-ID: <20210825172937.GD192480@rowland.harvard.edu>
References: <20210825170902.11234-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825170902.11234-1-novikov@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 08:09:02PM +0300, Evgeny Novikov wrote:
> ehci_orion_drv_probe() did not account for possible errors of
> clk_prepare_enable() that in particular could cause invocation of
> clk_disable_unprepare() on clocks that were not prepared/enabled yet,
> e.g. in remove or on handling errors of usb_add_hcd() in probe. Though,
> there were several patches fixing different issues with clocks in this
> driver, they did not solve this problem.
> 
> Add handling of errors of clk_prepare_enable() in ehci_orion_drv_probe()
> to avoid calls of clk_disable_unprepare() without previous successful
> invocation of clk_prepare_enable().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Fixes: 8c869edaee07 ("ARM: Orion: EHCI: Add support for enabling clocks")
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Do you intend to submit patches for the other EHCI drivers that don't 
check for errors in clk_prepare_enable()?  It looks like 
ehci-atmel.c, ehci-mv.c, and ehci-spear.c all need some attention.

The same is true for a bunch of the OHCI drivers: ohci-at91.c, 
ohci-exynos.c, ohci-s3c2410.c, and ohci-spear.c.

Didn't the Linux Driver Verification project identify this problem in 
all of these drivers?

Alan Stern

>  drivers/usb/host/ehci-orion.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
> index a319b1df3011..3626758b3e2a 100644
> --- a/drivers/usb/host/ehci-orion.c
> +++ b/drivers/usb/host/ehci-orion.c
> @@ -264,8 +264,11 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  	 * the clock does not exists.
>  	 */
>  	priv->clk = devm_clk_get(&pdev->dev, NULL);
> -	if (!IS_ERR(priv->clk))
> -		clk_prepare_enable(priv->clk);
> +	if (!IS_ERR(priv->clk)) {
> +		err = clk_prepare_enable(priv->clk);
> +		if (err)
> +			goto err_put_hcd;
> +	}
>  
>  	priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
>  	if (IS_ERR(priv->phy)) {
> @@ -311,6 +314,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
>  err_dis_clk:
>  	if (!IS_ERR(priv->clk))
>  		clk_disable_unprepare(priv->clk);
> +err_put_hcd:
>  	usb_put_hcd(hcd);
>  err:
>  	dev_err(&pdev->dev, "init %s fail, %d\n",
> -- 
> 2.26.2
> 
