Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1613D38C8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 12:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGWJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:53:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231688AbhGWJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627036412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IWXyBqJzTfNuRmfNKIdetBtP1RNy5LmtjYqPiHgsQrU=;
        b=cp48jOk+g7Ot3kFvLXWnTfzUIP7gMls5vnN5CY7Sd0Hf4X1644+kMvHBPWQ4MULZBuxMI8
        HMuLH+hkREopDQALaylPKRX1/z2fcNWYH3HrG5oAQ2jbaSppI1CvbgObod7OEmD1/Y5mbi
        I2Ee0soSsPXLRRXPnQBeHlkpGnSmoZs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413--dVxtIvQPmaI9UN2jemYuA-1; Fri, 23 Jul 2021 06:33:31 -0400
X-MC-Unique: -dVxtIvQPmaI9UN2jemYuA-1
Received: by mail-ed1-f72.google.com with SMTP id b4-20020a05640202c4b02903948bc39fd5so508947edx.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 03:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IWXyBqJzTfNuRmfNKIdetBtP1RNy5LmtjYqPiHgsQrU=;
        b=AUkkgdxT80Ukt+uYkqWfMtgWq6iYPbs9L1OyppASq6tNoOt3JeruCKi5bSSikC8Bz8
         Ltq1ZyfcVcx5+jY+gL6cYG3TQA9rDu2XRAD8co7ObCH7Z31yhzi9JiDo4uMaNjALeWTs
         HRplkGd9C5S0XtBPuVrOufFcm5SbOzjXYhSkYBaOQ3UFbLO20WmZqveJ4+gmmWXl8lMZ
         oZGTODbJVYrSJlZdxnOYKJek3x6bp6mLnjZlbcNDmU2gJzCZN0V2mmBG6zYqRnlf+hPk
         T6q+ij+nnuyjnL/7tlA6KYj/QvcKEZuzH5TAfkTCpYmJfual01adt0FsemM35djtae/7
         yaFw==
X-Gm-Message-State: AOAM5331pbWhNcJb4mb3AcY1q9vzBTk6Kp9aOSTYlvKbwpD80MF3/b3i
        GSzKnMIUAP55nq5wvTaZwlb5seCptFp4e+rZihRfFqXqQn14gS3MXyI907Ad9+Fq52no5BQuxhs
        I6/dQsEyy8oKAAG5sfis/5jbh
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr4786527eds.45.1627036410182;
        Fri, 23 Jul 2021 03:33:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRTzuSNg37MjiloriLMkgLspNTzQ30700CgwYyTWYABO4p2OU/0d1DQ2yMLQ5IlbC1/5DVhA==
X-Received: by 2002:aa7:d84a:: with SMTP id f10mr4786499eds.45.1627036409965;
        Fri, 23 Jul 2021 03:33:29 -0700 (PDT)
Received: from redhat.com ([2.55.16.196])
        by smtp.gmail.com with ESMTPSA id cq22sm13751399edb.77.2021.07.23.03.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 03:33:29 -0700 (PDT)
Date:   Fri, 23 Jul 2021 06:33:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH V2.1 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210723062427-mutt-send-email-mst@kernel.org>
References: <026ad5f274d64d46590623f9f3a04b8abfbe62d7.1626947324.git.viresh.kumar@linaro.org>
 <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3606cdcc637682a3eb401d617e6e247431b78ec6.1627019436.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2021 at 11:41:31AM +0530, Viresh Kumar wrote:
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2->V2.1
> - Remove list of virtio device and use of_device_is_compatible() instead.
> 
>  drivers/virtio/virtio.c | 56 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 53 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 4b15c00c0a0a..7c56b3416895 100644
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
> @@ -319,6 +323,42 @@ void unregister_virtio_driver(struct virtio_driver *driver)
>  }
>  EXPORT_SYMBOL_GPL(unregister_virtio_driver);
>  
> +static int virtio_device_of_init(struct virtio_device *dev)
> +{
> +	struct device_node *np, *pnode = dev->dev.parent->of_node;

dev_of_node? I think gcc will then be smart enough to
make this a nop with !IS_ENABLED(CONFIG_OF).


> +	int ret, count;
> +	char compat[12];

I think this assumes device id is 16 bits but it's defined as u32
just in case.
If it's ever extended we will then get
into need to handle snprintf errors which is currently missing.
To keep things simple we can do
	char compat[] = "virtio,XXXXXXXX";

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
> +	snprintf(compat, sizeof(compat), "virtio,%x", dev->id.device);

worth checking this returns < sizeof(compat) and BUG_ON.

> +
> +	if (!of_device_is_compatible(np, compat)) {
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
> @@ -343,6 +383,10 @@ int register_virtio_device(struct virtio_device *dev)
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
> @@ -362,10 +406,16 @@ int register_virtio_device(struct virtio_device *dev)
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
> -- 
> 2.31.1.272.g89b43f80a514

