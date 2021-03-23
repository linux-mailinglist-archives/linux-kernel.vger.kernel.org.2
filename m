Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8476E346105
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbhCWOHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:07:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232291AbhCWOHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:07:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26F4A6199F;
        Tue, 23 Mar 2021 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616508460;
        bh=Lbt+Ns9+KwjwTnENT6kYFkr1cRFMherBenpyTZyWXhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FXOzDGkRQhjEERi6vXNwDo6MQdQDTZUiQXYTGxfgmsalUtwTdS3Kpm0ZtOIzXEdYQ
         O7rB0FP0GwyjTPW4gLC1xhp+/NyD35xx6smWywCWVNchCnZC9Gi8KahW6fWJ+vD+sN
         67ipO8d6Rp7O/g4BZjm5NVxBsf2rsaJg5bDSLWUA=
Date:   Tue, 23 Mar 2021 15:07:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, kernel@pengutronix.de,
        andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] driver core: add helper for deferred probe reason
 setting
Message-ID: <YFn2Kffl0F8yeclC@kroah.com>
References: <20210319110459.19966-1-a.fatoum@pengutronix.de>
 <20210319110459.19966-2-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319110459.19966-2-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 12:04:58PM +0100, Ahmad Fatoum wrote:
> We now have three places within the same file doing the same operation
> of freeing this pointer and setting it anew. A helper make this
> arguably easier to read, so add one.
> 
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>  - no change
> ---
>  drivers/base/dd.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index e2cf3b29123e..4201baa1cc13 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -69,6 +69,12 @@ static char async_probe_drv_names[ASYNC_DRV_NAMES_MAX_LEN];
>   */
>  static bool defer_all_probes;
>  
> +static void __device_set_deferred_probe_reason(const struct device *dev, char *reason)
> +{
> +	kfree(dev->p->deferred_probe_reason);
> +	dev->p->deferred_probe_reason = reason;
> +}
> +
>  /*
>   * deferred_probe_work_func() - Retry probing devices in the active list.
>   */
> @@ -97,8 +103,7 @@ static void deferred_probe_work_func(struct work_struct *work)
>  
>  		get_device(dev);
>  
> -		kfree(dev->p->deferred_probe_reason);
> -		dev->p->deferred_probe_reason = NULL;
> +		__device_set_deferred_probe_reason(dev, NULL);
>  
>  		/*
>  		 * Drop the mutex while probing each device; the probe path may
> @@ -140,8 +145,7 @@ void driver_deferred_probe_del(struct device *dev)
>  	if (!list_empty(&dev->p->deferred_probe)) {
>  		dev_dbg(dev, "Removed from deferred list\n");
>  		list_del_init(&dev->p->deferred_probe);
> -		kfree(dev->p->deferred_probe_reason);
> -		dev->p->deferred_probe_reason = NULL;
> +		__device_set_deferred_probe_reason(dev, NULL);
>  	}
>  	mutex_unlock(&deferred_probe_mutex);
>  }
> @@ -220,11 +224,12 @@ void device_unblock_probing(void)
>  void device_set_deferred_probe_reason(const struct device *dev, struct va_format *vaf)
>  {
>  	const char *drv = dev_driver_string(dev);
> +	char *reason;
>  
>  	mutex_lock(&deferred_probe_mutex);
>  
> -	kfree(dev->p->deferred_probe_reason);
> -	dev->p->deferred_probe_reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);
> +	reason = kasprintf(GFP_KERNEL, "%s: %pV", drv, vaf);

No error checking?

:(

