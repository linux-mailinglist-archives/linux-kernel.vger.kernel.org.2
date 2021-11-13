Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8110644F314
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 13:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhKMM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 07:28:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhKMM2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 07:28:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AE2A61075;
        Sat, 13 Nov 2021 12:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636806352;
        bh=ez+K7Q6nN+J4K14Z0eLFaOK3VUeeeFzaYOkRWOtmpLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BxHIoKYCpbJqfGTsOTTlPnAtuoRcNOYyUazCOpGB3UY9D6wYSq/FEjIPjgBT3LXow
         65kUu1EI9p8uY3RHTOASUFqNyVluQzB0qyqGlexN/S7kg98A/Sp09bAbjVAHKNqfFr
         gI9nIlyW53diNXmtslHAKcbB0AbewFz0gT3Lkzv3mPivjEN0Q6jJndPggIxIigkpvz
         j9bbW6Z5KIBXJ5QIGhrT8reDdjo8qFPKf8uzAtYjD/m6yBs6jZydYniNMuM4MwkbfQ
         NKTfWd6f3S2kT5h94gGskBj8mxMpPR9vKGUulxDdN44u/xZswPmFCnJ4ouXIWtYCkq
         1UzpyYMGc00Dg==
Date:   Sat, 13 Nov 2021 20:25:44 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     gregkh@linuxfoundation.org, balbi@kernel.org,
        valentina.manea.m@gmail.com, shuah@kernel.org, johan@kernel.org,
        zhengyongjun3@huawei.com, colin.king@intel.com, trix@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: Remove redundant 'flush_workqueue()' calls
Message-ID: <20211113122544.GA3972@Peter>
References: <563123a8117d6cafae3f134e497587bd2b8bb7f4.1636734453.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <563123a8117d6cafae3f134e497587bd2b8bb7f4.1636734453.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-12 17:30:16, Christophe JAILLET wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> This was generated with coccinelle:
> 
> @@
> expression E;
> @@
> - 	flush_workqueue(E);
> 	destroy_workqueue(E);
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/usb/chipidea/otg.c           | 5 ++---

Acked-by: Peter Chen <peter.chen@kernel.or> # for chipidea part
>  drivers/usb/gadget/udc/mv_udc_core.c | 4 +---
>  drivers/usb/host/u132-hcd.c          | 1 -
>  drivers/usb/phy/phy-mv-usb.c         | 5 +----
>  drivers/usb/usbip/usbip_event.c      | 1 -
>  5 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> index 8dd59282827b..7b53274ef966 100644
> --- a/drivers/usb/chipidea/otg.c
> +++ b/drivers/usb/chipidea/otg.c
> @@ -255,10 +255,9 @@ int ci_hdrc_otg_init(struct ci_hdrc *ci)
>   */
>  void ci_hdrc_otg_destroy(struct ci_hdrc *ci)
>  {
> -	if (ci->wq) {
> -		flush_workqueue(ci->wq);
> +	if (ci->wq)
>  		destroy_workqueue(ci->wq);
> -	}
> +
>  	/* Disable all OTG irq and clear status */
>  	hw_write_otgsc(ci, OTGSC_INT_EN_BITS | OTGSC_INT_STATUS_BITS,
>  						OTGSC_INT_STATUS_BITS);
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index 7f24ce400b59..b6d34dda028b 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2084,10 +2084,8 @@ static int mv_udc_remove(struct platform_device *pdev)
>  
>  	usb_del_gadget_udc(&udc->gadget);
>  
> -	if (udc->qwork) {
> -		flush_workqueue(udc->qwork);
> +	if (udc->qwork)
>  		destroy_workqueue(udc->qwork);
> -	}
>  
>  	/* free memory allocated in probe */
>  	dma_pool_destroy(udc->dtd_pool);
> diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
> index ae882d76612b..d879d6af5710 100644
> --- a/drivers/usb/host/u132-hcd.c
> +++ b/drivers/usb/host/u132-hcd.c
> @@ -3211,7 +3211,6 @@ static void __exit u132_hcd_exit(void)
>  	platform_driver_unregister(&u132_platform_driver);
>  	printk(KERN_INFO "u132-hcd driver deregistered\n");
>  	wait_event(u132_hcd_wait, u132_instances == 0);
> -	flush_workqueue(workqueue);
>  	destroy_workqueue(workqueue);
>  }
>  
> diff --git a/drivers/usb/phy/phy-mv-usb.c b/drivers/usb/phy/phy-mv-usb.c
> index 576d925af77c..86503b7d695c 100644
> --- a/drivers/usb/phy/phy-mv-usb.c
> +++ b/drivers/usb/phy/phy-mv-usb.c
> @@ -648,10 +648,8 @@ static int mv_otg_remove(struct platform_device *pdev)
>  {
>  	struct mv_otg *mvotg = platform_get_drvdata(pdev);
>  
> -	if (mvotg->qwork) {
> -		flush_workqueue(mvotg->qwork);
> +	if (mvotg->qwork)
>  		destroy_workqueue(mvotg->qwork);
> -	}
>  
>  	mv_otg_disable(mvotg);
>  
> @@ -825,7 +823,6 @@ static int mv_otg_probe(struct platform_device *pdev)
>  err_disable_clk:
>  	mv_otg_disable_internal(mvotg);
>  err_destroy_workqueue:
> -	flush_workqueue(mvotg->qwork);
>  	destroy_workqueue(mvotg->qwork);
>  
>  	return retval;
> diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
> index 086ca76dd053..26513540bcdb 100644
> --- a/drivers/usb/usbip/usbip_event.c
> +++ b/drivers/usb/usbip/usbip_event.c
> @@ -137,7 +137,6 @@ int usbip_init_eh(void)
>  
>  void usbip_finish_eh(void)
>  {
> -	flush_workqueue(usbip_queue);
>  	destroy_workqueue(usbip_queue);
>  	usbip_queue = NULL;
>  }
> -- 
> 2.30.2
> 

-- 

Thanks,
Peter Chen

