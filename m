Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3275A3160A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbhBJIL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:11:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233572AbhBJIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612944594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQF1nvM4WzcF6b0r2/8bKOmWIMtX32r3vBelIGsxbzc=;
        b=gSlnaaTkzLm3df25zsqcyFSTQf6OdBY8S+wfLXf0FZmgExY4+/cA5ZUOnN7KGNvjdHLhSx
        oDQPmmPC10ArGt6Tq2V5sebFW5xyinl1qTQHVHvbS6gcEjW6t752Cg+fRJZiF2jHXSXXo8
        Z8SzZoQW2ltNLJle2ERZJVJhfm2Asks=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-fxTGGyKxMs6dGfNlV7pjSA-1; Wed, 10 Feb 2021 03:09:52 -0500
X-MC-Unique: fxTGGyKxMs6dGfNlV7pjSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B96B192CC44;
        Wed, 10 Feb 2021 08:09:51 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6512E5D9C0;
        Wed, 10 Feb 2021 08:09:45 +0000 (UTC)
Subject: Re: [PATCH] virtio-mmio: Use to_virtio_mmio_device() to simply code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b7043be4-46cf-e72c-b3aa-4a8d487e82ad@redhat.com>
Date:   Wed, 10 Feb 2021 16:09:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210030401.5532-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/10 上午11:04, Tang Bin wrote:
> The file virtio_mmio.c has defined the function to_virtio_mmio_device,
> so use it instead of container_of() to simply code. And remove
> superfluous blank lines in this file.
>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
>   drivers/virtio/virtio_mmio.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 627ac0487..449d0f209 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -69,14 +69,10 @@
>   #include <uapi/linux/virtio_mmio.h>
>   #include <linux/virtio_ring.h>
>   
> -
> -


It's better not mix the patch with style changes.

Other looks good.

Thanks


>   /* The alignment to use between consumer and producer parts of vring.
>    * Currently hardcoded to the page size. */
>   #define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE
>   
> -
> -
>   #define to_virtio_mmio_device(_plat_dev) \
>   	container_of(_plat_dev, struct virtio_mmio_device, vdev)
>   
> @@ -100,8 +96,6 @@ struct virtio_mmio_vq_info {
>   	struct list_head node;
>   };
>   
> -
> -
>   /* Configuration interface */
>   
>   static u64 vm_get_features(struct virtio_device *vdev)
> @@ -264,8 +258,6 @@ static void vm_reset(struct virtio_device *vdev)
>   	writel(0, vm_dev->base + VIRTIO_MMIO_STATUS);
>   }
>   
> -
> -
>   /* Transport interface */
>   
>   /* the notify function used when creating a virt queue */
> @@ -307,8 +299,6 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
>   	return ret;
>   }
>   
> -
> -
>   static void vm_del_vq(struct virtqueue *vq)
>   {
>   	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> @@ -512,13 +502,11 @@ static const struct virtio_config_ops virtio_mmio_config_ops = {
>   	.bus_name	= vm_bus_name,
>   };
>   
> -
>   static void virtio_mmio_release_dev(struct device *_d)
>   {
>   	struct virtio_device *vdev =
>   			container_of(_d, struct virtio_device, dev);
> -	struct virtio_mmio_device *vm_dev =
> -			container_of(vdev, struct virtio_mmio_device, vdev);
> +	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
>   	struct platform_device *pdev = vm_dev->pdev;
>   
>   	devm_kfree(&pdev->dev, vm_dev);
> @@ -608,8 +596,6 @@ static int virtio_mmio_remove(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -
> -
>   /* Devices list parameter */
>   
>   #if defined(CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES)

