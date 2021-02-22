Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68933321B6F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBVP3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbhBVP2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614007640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TXZsMYpXn71LSKrMbfU4t7gfQPTn4Ouohxtv8HpftpQ=;
        b=gdAJB3bISNjWGv+eXrlk+0UoM71OC1XPoTBjXa/pCQ1/a2jllfDOkpwqM8dbb6I1Sj6gPt
        gaEoSJlFNxqDO6XUiMjTWJivnv//zhKKslbKv/9ALA70zxPfNrR2LoEJ8VC3BtDaOMamxk
        AWvbjv0tRehfIAmjfDsJOXftZbUrBA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-ruXTpb55Nee8j1UNks7pLQ-1; Mon, 22 Feb 2021 10:27:18 -0500
X-MC-Unique: ruXTpb55Nee8j1UNks7pLQ-1
Received: by mail-wm1-f72.google.com with SMTP id u15so5199207wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:27:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TXZsMYpXn71LSKrMbfU4t7gfQPTn4Ouohxtv8HpftpQ=;
        b=tVVwbjybFyKwB5m1gy0TR+bxwPKpioEzuvp/WsBf0Dq/T/G/By2skPQ2iWBJiYXnU1
         HighEMmY4SrkbyIP6osWBAwqYzIdukkeCiCLoyVMij/AsH12u4cUn3N1RaMSx/R7egdZ
         XTb8OS2zDPPUebblPpC1PAaFylzBiaRa/LMJqpG/W8XzGBDvWEy6ydHAl/mSx/w/oBYC
         OOVwOVh0f1ce846T3DfYCKHPP6d5rFGBLJOBzaKDNX2WnjU+llAoqotMqTsXKPFwOAfZ
         ytwjwesU1mJ9mKJ9r5+Lq+tS95rUYyYR4CwNeZ3TuLGV712WIHz7zHgYi3SQjA9VUDvO
         7fHw==
X-Gm-Message-State: AOAM53165/4c5wtyCTR+Dqj3QlC3Rd5PuXVYYhlZzT1H7JVp6zX8iO47
        YNjMqnH4rWIwP0d2lzTXr0tittxMs3eDZ43MbK+HLLlQGTtFgKZp/k0nwHn7N+aeD3/EahXVB0a
        ijrTpbRLo5ccWqHZFc86lGhpE
X-Received: by 2002:adf:e444:: with SMTP id t4mr10980956wrm.97.1614007637010;
        Mon, 22 Feb 2021 07:27:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhiINXVo9/Kl6zyPC/+Cx2AASIrpnH/QSMH0uXnxoLV5V5LDfLysUW9pHxz/qycFwCzMn7/A==
X-Received: by 2002:adf:e444:: with SMTP id t4mr10980943wrm.97.1614007636842;
        Mon, 22 Feb 2021 07:27:16 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id a3sm1755509wrt.68.2021.02.22.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:27:16 -0800 (PST)
Date:   Mon, 22 Feb 2021 16:27:14 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Xianting Tian <xianting_tian@126.com>
Cc:     mst@redhat.com, jasowang@redhat.com, guoren@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] virtio: remove export for virtio_config_{enable, disable}
Message-ID: <20210222152714.jhggub3lrv7xfwju@steredhat>
References: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1613838498-8791-1-git-send-email-xianting_tian@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 11:28:18AM -0500, Xianting Tian wrote:
>virtio_config_enable(), virtio_config_disable() are only used inside
>drivers/virtio/virtio.c, so it doesn't need export the symbols.
>
>Signed-off-by: Xianting Tian <xianting_tian@126.com>
>---
> drivers/virtio/virtio.c | 6 ++----
> include/linux/virtio.h  | 2 --
> 2 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
>index 42e09cc..4b15c00 100644
>--- a/drivers/virtio/virtio.c
>+++ b/drivers/virtio/virtio.c
>@@ -141,15 +141,14 @@ void virtio_config_changed(struct virtio_device *dev)
> }
> EXPORT_SYMBOL_GPL(virtio_config_changed);
>
>-void virtio_config_disable(struct virtio_device *dev)
>+static void virtio_config_disable(struct virtio_device *dev)
> {
> 	spin_lock_irq(&dev->config_lock);
> 	dev->config_enabled = false;
> 	spin_unlock_irq(&dev->config_lock);
> }
>-EXPORT_SYMBOL_GPL(virtio_config_disable);
>
>-void virtio_config_enable(struct virtio_device *dev)
>+static void virtio_config_enable(struct virtio_device *dev)
> {
> 	spin_lock_irq(&dev->config_lock);
> 	dev->config_enabled = true;
>@@ -158,7 +157,6 @@ void virtio_config_enable(struct virtio_device *dev)
> 	dev->config_change_pending = false;
> 	spin_unlock_irq(&dev->config_lock);
> }
>-EXPORT_SYMBOL_GPL(virtio_config_enable);
>
> void virtio_add_status(struct virtio_device *dev, unsigned int status)
> {
>diff --git a/include/linux/virtio.h b/include/linux/virtio.h
>index 55ea329..b1894e0 100644
>--- a/include/linux/virtio.h
>+++ b/include/linux/virtio.h
>@@ -132,8 +132,6 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
> void virtio_break_device(struct virtio_device *dev);
>
> void virtio_config_changed(struct virtio_device *dev);
>-void virtio_config_disable(struct virtio_device *dev);
>-void virtio_config_enable(struct virtio_device *dev);
> int virtio_finalize_features(struct virtio_device *dev);
> #ifdef CONFIG_PM_SLEEP
> int virtio_device_freeze(struct virtio_device *dev);
>-- 
>1.8.3.1
>

