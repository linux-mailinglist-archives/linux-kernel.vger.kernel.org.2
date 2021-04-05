Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC66353C63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhDEI2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 04:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhDEI2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 04:28:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690AC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 01:28:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lTKaX-00074a-E8; Mon, 05 Apr 2021 10:28:01 +0200
Subject: Re: [PATCH v3 2/2] driver core: add helper for deferred probe reason
 setting
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     kernel@pengutronix.de, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210323153714.25120-1-a.fatoum@pengutronix.de>
 <20210323153714.25120-2-a.fatoum@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <55ed4f2d-70f6-9ee0-731c-8a7b3a379aa0@pengutronix.de>
Date:   Mon, 5 Apr 2021 10:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210323153714.25120-2-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 23.03.21 16:37, Ahmad Fatoum wrote:
> We now have three places within the same file doing the same operation
> of freeing this pointer and setting it anew. A helper makes this
> arguably easier to read, so add one.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

are there still objections to this patch?
Patch 1 was applied, should I resend without?

Cheers,
Ahmad

> ---
> v2 -> v3:
>  - fixed typo in commit message (Andy)
>  - collected Andy's and Andrzej's Reviewed-by
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
> +	__device_set_deferred_probe_reason(dev, reason);
>  
>  	mutex_unlock(&deferred_probe_mutex);
>  }
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
