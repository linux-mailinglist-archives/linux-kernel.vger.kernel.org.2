Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F59408806
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhIMJUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhIMJUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:20:40 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:19:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k17so5406681pls.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 02:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/KLMhu/ohKTdcErkhutjcvNbaBuyL81b9h2OgPrIAGs=;
        b=0nRXlrxU0h72/63M9Z//j1oUioUEAaM+i5ApthV6Y6lkH/EExd7NOO9yr4vV4wgDNy
         bPRLPTKfpDYsCESaZiV2ZnTya9oO/cvVWeYUWVWCDWsqN4hgD6OhUU/+7nWrCeQACVrj
         Ng9tOjvqGrzA7ezlFKTNwqvCGL9I7gYNe6l7oGdArV3/eMLtbXxGC+8j1o1poMN3JBjm
         uSomnaR+AeYmB3bnxhpAvi9nuZ7FVpjatWQ9DdigYpQHkh1YOAzCo0x6jo1vcFUn1WFa
         xsMcSqIckKjfo3/7e6i8S6BIeDrXis8u9S6H1ZGWzHGN/RgTRu8Oa9fTXdCfIzfaw8/w
         1Dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/KLMhu/ohKTdcErkhutjcvNbaBuyL81b9h2OgPrIAGs=;
        b=FXzayUxmKYVtObw42Jt6cA4HN9ena4ZSbjSa+SjJQ6UEYZooHw9vy1nJitc+KkTRGD
         YuqqJB7JZHaOJ6LVu1ZB9Q0N1KBFuaI1D63IGwnubdKwR4oXa7bxJ9/u+h49fgJgcqW3
         97cBCdBq6OoBUgnXke9cvoGJ07DCJwdtNe2EpRI3A0VeEQeCBe9YtlF7FNLVd8n1i3iw
         cUY9lt8wICwsf/5J7euC3sKjifeuCYFbdH0uQoBwVR91tyT/8a/SKKGvuzd9+0TlQOav
         dgALLPvZPvNCmNAz0tv5pgWiaY76aFGLCLQqHpG3csEvtKTY/bqtJH/VVxYIv/CxjaJk
         L6aQ==
X-Gm-Message-State: AOAM531SyOaeY45J9OBegeI3FTaNNrzY8Lje3lqqELVPMgceRkTySkVw
        2D4K0EtnSxe117hny7kSHD+r0A==
X-Google-Smtp-Source: ABdhPJyY3G84sKYfeqnJEQmI31QLTRG3fjL7QKVWFJ//gBCJGS4TbYjUbyn/1EcTU7tcRuRvFNJWLw==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id rm13mr12074738pjb.4.1631524764063;
        Mon, 13 Sep 2021 02:19:24 -0700 (PDT)
Received: from [192.168.10.23] (124-171-108-209.dyn.iinet.net.au. [124.171.108.209])
        by smtp.gmail.com with ESMTPSA id m1sm6457153pfc.30.2021.09.13.02.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Sep 2021 02:19:23 -0700 (PDT)
Message-ID: <d5f87715-5a3e-1e85-68ba-3e4d35163c68@ozlabs.ru>
Date:   Mon, 13 Sep 2021 19:19:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:92.0) Gecko/20100101
 Thunderbird/92.0
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/07/2021 14:51, Viresh Kumar wrote:
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/virtio/virtio.c | 57 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..d001e84a5b23 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -4,6 +4,7 @@
>  #include <linux/virtio_config.h>
>  #include <linux/module.h>
>  #include <linux/idr.h>
> +#include <linux/of.h>
>  #include <uapi/linux/virtio_ids.h>
>  
>  /* Unique numbering for virtio devices. */
> @@ -292,6 +293,9 @@ static int virtio_dev_remove(struct device *_d)
>  
>  	/* Acknowledge the device's existence again. */
>  	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> +
> +	of_node_put(dev->dev.of_node);
> +
>  	return 0;
>  }
>  
> @@ -319,6 +323,43 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +static int virtio_device_of_init(struct virtio_device *dev)
> +{
> +	struct device_node *np, *pnode = dev_of_node(dev->dev.parent);
> +	char compat[] = "virtio,XXXXXXXX"; /* Reserve enough space 32-bit id */
> +	int ret, count;
> +
> +	if (!pnode)
> +		return 0;
> +
> +	count = of_get_available_child_count(pnode);
> +	if (!count)
> +		return 0;
> +
> +	/* There can be only 1 child node */
> +	if (WARN_ON(count > 1))
> +		return -EINVAL;
> +
> +	np = of_get_next_available_child(pnode, NULL);
> +	if (WARN_ON(!np))
> +		return -ENODEV;
> +
> +	BUG_ON(snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device) >=
> +	       sizeof(compat));
> +
> +	if (!of_device_is_compatible(np, compat)) {


This broke powerpc/pseries as there these virtio devices are PCI so
there is no "compat" - PCI vendor id/device ids play role of "compat".
Thanks,




> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	dev->dev.of_node = np;
> +	return 0;
> +
> +out:
> +	of_node_put(np);
> +	return ret;
> +}
> +
>  /**
>   * register_virtio_device - register virtio device
>   * @dev        : virtio device to be registered
> @@ -343,6 +384,10 @@ int register_virtio_device(struct virtio_device *dev)
>  	dev->index = err;
>  	dev_set_name(&dev->dev, "virtio%u", dev->index);
>  
> +	err = virtio_device_of_init(dev);
> +	if (err)
> +		goto out_ida_remove;
> +
>  	spin_lock_init(&dev->config_lock);
>  	dev->config_enabled = false;
>  	dev->config_change_pending = false;
> @@ -362,10 +407,16 @@ int register_virtio_device(struct virtio_device *dev)
>  	 */
>  	err = device_add(&dev->dev);
>  	if (err)
> -		ida_simple_remove(&virtio_index_ida, dev->index);
> +		goto out_of_node_put;
> +
> +	return 0;
> +
> +out_of_node_put:
> +	of_node_put(dev->dev.of_node);
> +out_ida_remove:
> +	ida_simple_remove(&virtio_index_ida, dev->index);
>  out:
> -	if (err)
> -		virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
> +	virtio_add_status(dev, VIRTIO_CONFIG_S_FAILED);
>  	return err;
>  }
>  EXPORT_SYMBOL_GPL(register_virtio_device);
> 

-- 
Alexey
