Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A11437C19
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbhJVRmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhJVRmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:42:39 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82783C061766
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:40:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3574326pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=liWZli0eAF8afgakhBPCOuJHOqUaz+9glMsUeQZ0bBE=;
        b=gh/gv+dOl3T/Yz05wZAfdRzAQ4bnQBamqpZxekxHgeqJ2A79ET86YbMYyM1JZ2iFmu
         Cjpnhc0niQwAJKYkuGzKVLSvsdyxdBUaZZPv+N4kgz8Vhn3pZsZxqMRQ/gOHyd3cb8ot
         PISuK6HiPDwX2jOiQbiVy/2wAp8HHQxSbCvog1OQLw5YYrEceThndvKImgBFIsU5BKuS
         Vyacuioa2wnsH4ODtvE+/aYsXk9Qg/0rulnzNOyOEc3LFsQR+baYe1mYxGiz6CiNecsD
         ebVdw/TQ3UNceLFu7ZoOW0+dfxv4pgfyI4qiOUgUkw1fvKJtQllDW4Kn8dqMfU3mllHr
         MtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=liWZli0eAF8afgakhBPCOuJHOqUaz+9glMsUeQZ0bBE=;
        b=IsWJdygt1a4cUDW7cqFhrFAT384pROP78dFWxKbtPPUcB4dHChrNVQ4+Dc9qyJxRm0
         WYT0S4zM4gsSop2SQEu+l463uu3yo9Hp0BGYZ3d3TCsRG49+j7rmMMObvHmdXYlxWVt7
         Sr46MVv8jIiSqy8ycd/6sHRpG5jBoZS83+AzTQEzKg+sc6ze9ksQiqn61RrdRNbPpvuV
         WL2db8GpQhAmTYekvNYbxXMkLalF+tFLL1peVNGE1/HUgDLSIGheFgUoKo/kDFlSyG4n
         zQMqKh/HEqVRLZ7dgawExT9WPRy4GhWyT1nVxLqDgx40p0ASG6UwF6pDmbSdNlsIc4Fn
         I+lQ==
X-Gm-Message-State: AOAM532j9J3xaOcSyqk8L/zlhq3/YZIIcHbf2ytC99vKbI8vWOYVXSMn
        YN6vLcSXIgE8854rTcneQUL1ug==
X-Google-Smtp-Source: ABdhPJz1BO5gT/0qxla2xBJC7oQyx8/tu9cL5I+Ak00IcmUjFcs98nrq0S0UY2+Ty/lGxPN/egORYQ==
X-Received: by 2002:a17:90a:6583:: with SMTP id k3mr16418390pjj.147.1634924420954;
        Fri, 22 Oct 2021 10:40:20 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id p16sm9142083pgd.78.2021.10.22.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 10:40:19 -0700 (PDT)
Date:   Fri, 22 Oct 2021 11:40:17 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Rob Herring <robh@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <stefanos@xilinx.com>,
        Bruce Ashfield <bruce.ashfield@xilinx.com>
Subject: Re: [RFC PATCH 5/7] remoteproc: virtio: Create platform device for
 the remoteproc_virtio
Message-ID: <20211022174017.GB3659113@p14s>
References: <20211001101234.4247-1-arnaud.pouliquen@foss.st.com>
 <20211001101234.4247-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001101234.4247-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The title mentions the creation of a "platform device" but this patch adds a
platform driver interface.

On Fri, Oct 01, 2021 at 12:12:32PM +0200, Arnaud Pouliquen wrote:
> Define a platform device for the remoteproc virtio to prepare the
> management of the remoteproc virtio as a platform device.

The above should be:

"Define a platform driver to prepare for the managemnt of remoteproc virtio
devices as platform devices."

> 
> The platform device allows to pass rproc_vdev_data platform data to
> specify properties that are stored in the rproc_vdev structure.
> 
> Such approach will allow to preserve legacy remoteproc virtio device
> creation but also to probe the device using device tree mechanism.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/remoteproc_internal.h |  6 +++
>  drivers/remoteproc/remoteproc_virtio.c   | 65 ++++++++++++++++++++++++
>  include/linux/remoteproc.h               |  2 +
>  3 files changed, 73 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
> index 4ce012c353c0..1b963a8912ed 100644
> --- a/drivers/remoteproc/remoteproc_internal.h
> +++ b/drivers/remoteproc/remoteproc_internal.h
> @@ -24,6 +24,12 @@ struct rproc_debug_trace {
>  	struct rproc_mem_entry trace_mem;
>  };
>  
> +struct rproc_vdev_data {
> +	u32 rsc_offset;
> +	unsigned int id;
> +	unsigned int index;
> +};
> +
>  /* from remoteproc_core.c */
>  void rproc_release(struct kref *kref);
>  int rproc_of_parse_firmware(struct device *dev, int index,
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index c9eecd2f9fb2..9b2ab79e4c4c 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -4,6 +4,7 @@
>   *
>   * Copyright (C) 2011 Texas Instruments, Inc.
>   * Copyright (C) 2011 Google, Inc.
> + * Copyright (C) 2021 STMicroelectronics
>   *
>   * Ohad Ben-Cohen <ohad@wizery.com>
>   * Brian Swetland <swetland@google.com>
> @@ -13,6 +14,7 @@
>  #include <linux/dma-map-ops.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/export.h>
> +#include <linux/of_platform.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/remoteproc.h>
>  #include <linux/virtio.h>
> @@ -571,3 +573,66 @@ void rproc_vdev_release(struct kref *ref)
>  
>  	rproc_rvdev_remove_device(rvdev);
>  }
> +
> +static int rproc_virtio_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct rproc_vdev_data *vdev_data = dev->platform_data;
> +	struct rproc_vdev *rvdev;
> +	struct rproc *rproc;
> +
> +	if (!vdev_data)
> +		return -EINVAL;
> +
> +	rvdev = devm_kzalloc(dev, sizeof(*rvdev), GFP_KERNEL);
> +	if (!rvdev)
> +		return -ENOMEM;
> +
> +	rproc = container_of(dev->parent, struct rproc, dev);
> +
> +	rvdev->rsc_offset = vdev_data->rsc_offset;
> +	rvdev->id = vdev_data->id;
> +	rvdev->index = vdev_data->index;
> +
> +	rvdev->pdev = pdev;
> +	rvdev->rproc = rproc;
> +
> +	platform_set_drvdata(pdev, rvdev);
> +
> +	return rproc_rvdev_add_device(rvdev);
> +}
> +
> +static int rproc_virtio_remove(struct platform_device *pdev)
> +{
> +	struct rproc_vdev *rvdev = dev_get_drvdata(&pdev->dev);
> +	struct rproc *rproc = rvdev->rproc;
> +	struct rproc_vring *rvring;
> +	int id;
> +
> +	for (id = 0; id < ARRAY_SIZE(rvdev->vring); id++) {
> +		rvring = &rvdev->vring[id];
> +		rproc_free_vring(rvring);
> +	}
> +
> +	rproc_remove_subdev(rproc, &rvdev->subdev);
> +	rproc_unregister_rvdev(rvdev);
> +	dev_dbg(&pdev->dev, "virtio dev %d removed\n",  rvdev->index);
> +
> +	return 0;
> +}
> +
> +/* Platform driver */
> +static const struct of_device_id rproc_virtio_match[] = {
> +	{ .compatible = "rproc-virtio", },
> +	{},
> +};
> +
> +static struct platform_driver rproc_virtio_driver = {
> +	.probe		= rproc_virtio_probe,
> +	.remove		= rproc_virtio_remove,
> +	.driver		= {
> +		.name	= "rproc-virtio",
> +		.of_match_table	= rproc_virtio_match,
> +	},
> +};
> +builtin_platform_driver(rproc_virtio_driver);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index e0600e1e5c17..542a3d4664f2 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -616,6 +616,7 @@ struct rproc_vring {
>   * struct rproc_vdev - remoteproc state for a supported virtio device
>   * @refcount: reference counter for the vdev and vring allocations
>   * @subdev: handle for registering the vdev as a rproc subdevice
> + * @pdev: remoteproc virtio platform device
>   * @dev: device struct used for reference count semantics
>   * @id: virtio device id (as in virtio_ids.h)
>   * @node: list node
> @@ -628,6 +629,7 @@ struct rproc_vdev {
>  	struct kref refcount;
>  
>  	struct rproc_subdev subdev;
> +	struct platform_device *pdev;
>  	struct device dev;
>  
>  	unsigned int id;
> -- 
> 2.17.1
> 
