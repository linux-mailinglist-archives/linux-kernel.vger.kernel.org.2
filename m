Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347FE33D9C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhCPQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 12:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237746AbhCPQqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 12:46:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C82D650B1;
        Tue, 16 Mar 2021 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615913181;
        bh=s3E3QMpaycAIIQfC/2DCwVEI36zTW6CIY99qfYo7Uss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=le3dAURpm9dyANMjW3ndnXD4V/FfomxJLSeiVLaVJwoHA6UT8YtDtfofC+vELmFsN
         ++rb6pbaaFX2oVRMKL30AxmzLTfuf2wdF7qHqDv7xoHn71vqEzgLxKf+TK+cgHc95z
         xtLaj2aTUId+Vc6iNOMSG+Y1owJRipkWP+gH7Z+k=
Date:   Tue, 16 Mar 2021 17:46:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        bobo.shaobowang@huawei.com, rdunlap@infradead.org
Subject: Re: [PATCH v5 2/3] misc/pvpanic: probe multiple instances
Message-ID: <YFDg2gcNSEbf5Qle@kroah.com>
References: <1615897229-4055-1-git-send-email-mihai.carabas@oracle.com>
 <1615897229-4055-3-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615897229-4055-3-git-send-email-mihai.carabas@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 02:20:28PM +0200, Mihai Carabas wrote:
> Create the mecahism that allows multiple pvpanic instances to call
> pvpanic_probe and receive panic events. A global list will retain all the
> mapped addresses where to write panic events.
> 
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/misc/pvpanic/pvpanic-mmio.c |  11 ++--
>  drivers/misc/pvpanic/pvpanic.c      | 105 +++++++++++++++++++++++++++++-------
>  drivers/misc/pvpanic/pvpanic.h      |   6 +--
>  3 files changed, 92 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
> index 801d892..62ab8d7 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -54,7 +54,7 @@ static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
>  
>  	events = tmp;
>  
> -	pvpanic_set_events(events);
> +	pvpanic_set_events(base, events);
>  
>  	return count;
>  
> @@ -72,7 +72,6 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> -	void __iomem *base;
>  
>  	res = platform_get_mem_or_io(pdev, 0);
>  	if (!res)
> @@ -97,17 +96,13 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
>  	capability &= ioread8(base);
>  	events = capability;
>  
> -	pvpanic_probe(base, capability);
> -
> -	return 0;
> +	return pvpanic_probe(base, capability);
>  }
>  
>  static int pvpanic_mmio_remove(struct platform_device *pdev)
>  {
>  
> -	pvpanic_remove();
> -
> -	return 0;
> +	return pvpanic_remove(base);
>  }
>  
>  static const struct of_device_id pvpanic_mmio_match[] = {
> diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
> index 11d029c..73a82d9 100644
> --- a/drivers/misc/pvpanic/pvpanic.c
> +++ b/drivers/misc/pvpanic/pvpanic.c
> @@ -14,20 +14,35 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/types.h>
> +#include <linux/cdev.h>
> +#include <linux/list.h>
> +#include <linux/slab.h>
>  
>  #include <uapi/misc/pvpanic.h>
>  
>  #include "pvpanic.h"
>  
> -static void __iomem *base;
> -static unsigned int capability;
> -static unsigned int events;
> +struct pvpanic_instance {
> +	void __iomem *base;
> +	unsigned int capability;
> +	unsigned int events;
> +	struct list_head list;
> +};
> +
> +struct list_head pvpanic_list;
> +spinlock_t pvpanic_lock;
>  
>  static void
>  pvpanic_send_event(unsigned int event)
>  {
> -	if (event & capability & events)
> -		iowrite8(event, base);
> +	struct pvpanic_instance *pi_cur;
> +
> +	spin_lock(&pvpanic_lock);
> +	list_for_each_entry(pi_cur, &pvpanic_list, list) {
> +		if (event & pi_cur->capability & pi_cur->events)
> +			iowrite8(event, pi_cur->base);
> +	}
> +	spin_unlock(&pvpanic_lock);
>  }
>  
>  static int
> @@ -49,29 +64,81 @@
>  	.priority = 1, /* let this called before broken drm_fb_helper */
>  };
>  
> -void pvpanic_probe(void __iomem *pbase, unsigned int dev_cap)
> +int pvpanic_probe(void __iomem *pbase, unsigned int dev_cap)
>  {
> -	base = pbase;
> -	capability = dev_cap;
> -	events = capability;
> +	struct pvpanic_instance *pi;
> +
> +	if (!pbase)
> +		return -EINVAL;
> +
> +	pi = kmalloc(sizeof(*pi), GFP_ATOMIC);
> +	if (!pi)
> +		return -ENOMEM;
> +
> +	pi->base = pbase;
> +	pi->capability = dev_cap;
> +	pi->events = dev_cap;
> +	spin_lock(&pvpanic_lock);
> +	list_add(&pi->list, &pvpanic_list);
> +	spin_unlock(&pvpanic_lock);
>  
> -	if (capability)
> -		atomic_notifier_chain_register(&panic_notifier_list,
> -					       &pvpanic_panic_nb);
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pvpanic_probe);
>  
> -void pvpanic_remove(void)
> +int pvpanic_remove(void __iomem *pbase)
>  {
> -	if (capability)
> -		atomic_notifier_chain_unregister(&panic_notifier_list,
> -						 &pvpanic_panic_nb);
> -	base = NULL;
> +	struct pvpanic_instance *pi_cur, *pi_next;
> +
> +	if (!pbase)
> +		return -EINVAL;
> +
> +	spin_lock(&pvpanic_lock);
> +	list_for_each_entry_safe(pi_cur, pi_next, &pvpanic_list, list) {
> +		if (pi_cur->base == pbase) {
> +			list_del(&pi_cur->list);
> +			kfree(pi_cur);
> +			break;
> +		}
> +	}
> +	spin_unlock(&pvpanic_lock);
> +
> +	return 0;
>  }

As "remove" can not fail, this should just stay a void function.  People
are working to remove the int return value from remove calls in the
kernel right now, please do not add new ones if at all possible.

thanks,

greg k-h
