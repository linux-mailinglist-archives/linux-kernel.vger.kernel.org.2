Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CC9320FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 04:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhBVDr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 22:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229996AbhBVDr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 22:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613965560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqlQReWjU6B7KnkKCdLl5ChxN886RQ4Qyk81WJRNAlE=;
        b=QvMXF85viyuyBfghcMA4W6oD9FCoS3FQWq84kXqztV8twO9ElGHRtSuHAUcJpN67JgD4Vw
        50VcwTAYYGJnHaQAdvRkLqk6c/Pd0yCnBrX39GdJOGM/Y4Rn4yvh1buSvxizQIUu/trpf3
        SzBLdZQm3mNBuj5IAgpDMx+oEM2zSO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-3CzHHRC5Oe2noS9NGNWvVQ-1; Sun, 21 Feb 2021 22:45:35 -0500
X-MC-Unique: 3CzHHRC5Oe2noS9NGNWvVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF0A118449E7;
        Mon, 22 Feb 2021 03:45:33 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-112.pek2.redhat.com [10.72.13.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A91610074E2;
        Mon, 22 Feb 2021 03:45:28 +0000 (UTC)
Subject: Re: [PATCH] virtio: remove export for virtio_config_{enable, disable}
To:     Xianting Tian <xianting_tian@126.com>, mst@redhat.com
Cc:     guoren@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6bc59452-5d9e-851a-6c03-3611c4c388f0@redhat.com>
Date:   Mon, 22 Feb 2021 11:45:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/21 12:28 上午, Xianting Tian wrote:
> virtio_config_enable(), virtio_config_disable() are only used inside
> drivers/virtio/virtio.c, so it doesn't need export the symbols.
>
> Signed-off-by: Xianting Tian <xianting_tian@126.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/virtio/virtio.c | 6 ++----
>   include/linux/virtio.h  | 2 --
>   2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 42e09cc..4b15c00 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -141,15 +141,14 @@ void virtio_config_changed(struct virtio_device *dev)
>   }
>   EXPORT_SYMBOL_GPL(virtio_config_changed);
>   
> -void virtio_config_disable(struct virtio_device *dev)
> +static void virtio_config_disable(struct virtio_device *dev)
>   {
>   	spin_lock_irq(&dev->config_lock);
>   	dev->config_enabled = false;
>   	spin_unlock_irq(&dev->config_lock);
>   }
> -EXPORT_SYMBOL_GPL(virtio_config_disable);
>   
> -void virtio_config_enable(struct virtio_device *dev)
> +static void virtio_config_enable(struct virtio_device *dev)
>   {
>   	spin_lock_irq(&dev->config_lock);
>   	dev->config_enabled = true;
> @@ -158,7 +157,6 @@ void virtio_config_enable(struct virtio_device *dev)
>   	dev->config_change_pending = false;
>   	spin_unlock_irq(&dev->config_lock);
>   }
> -EXPORT_SYMBOL_GPL(virtio_config_enable);
>   
>   void virtio_add_status(struct virtio_device *dev, unsigned int status)
>   {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 55ea329..b1894e0 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -132,8 +132,6 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
>   void virtio_break_device(struct virtio_device *dev);
>   
>   void virtio_config_changed(struct virtio_device *dev);
> -void virtio_config_disable(struct virtio_device *dev);
> -void virtio_config_enable(struct virtio_device *dev);
>   int virtio_finalize_features(struct virtio_device *dev);
>   #ifdef CONFIG_PM_SLEEP
>   int virtio_device_freeze(struct virtio_device *dev);

