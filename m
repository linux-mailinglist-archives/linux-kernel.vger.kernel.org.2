Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF09428575
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 05:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhJKDIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 23:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45425 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231966AbhJKDIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633921611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQlWWNm8nIIxCQWMb6EGZQHK9gk6FB/0D1OfhEh8hqw=;
        b=KwJjzMoxfsXlrJq9kuxo3B4ujAtB5t+THvoQj95sVbuY0/B3HAXfNudBj69Dnze7yV5I73
        2vYfMd3Tbh/wMu/5Dj0mYcPK45ljwCaE0uMPF5TuuTFLOJhzPVsFXJjCjMKQQxAaTZTDBi
        KnjMZvXgIPpQ5ZmfGB3cZfEMS/HZveo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-QwfpLThQNCSYjrInSsOS7Q-1; Sun, 10 Oct 2021 23:06:50 -0400
X-MC-Unique: QwfpLThQNCSYjrInSsOS7Q-1
Received: by mail-pl1-f200.google.com with SMTP id p2-20020a170902bd0200b0013da15f4ab0so7227286pls.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 20:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UQlWWNm8nIIxCQWMb6EGZQHK9gk6FB/0D1OfhEh8hqw=;
        b=Q1/wOZBFDcCoOS4WV3tDkQoeBMYWGjO9DTzB1D5QcKSQ3RMyvTsJg82Cl57DL1otGv
         M6aKKVxGIX90an1xQuHmnyUCM53rq5cEU08iJr8KIHIMidyua++kzqnt+oeEHeiWIl0+
         eKtLPOKJ10hvpUAa/3tm7E0u3KiTB6nt8BaH+8TS1W67+NGxgtRGXsoEEdA6/z4lt4S1
         f07ncXq5bXAablOu5uwaTRCU1w4FXyGc5sNWmdam6dQorQvXKeBjcJLDHRFvPI8qxZ0Z
         ZdCvJYt8wAhZ7AEpWMeYmXBENN6sYNkI+zAl9xcZ/euKeot+q5IZPkyTVr/WYOgtp+A6
         c5PA==
X-Gm-Message-State: AOAM532NLR/b2CXOpr+4u6K83AGNiV4Z6IxNKOzIPlp88yPRP5yx+Mkj
        WbgkVtvbERD4oV/r0SWs9uaaMfprHSZvQIAQY2ysC3lJi4abwPZKIeANHoCUoFSUrvUknZtbR9V
        UsETfwp4K9ufg2UrqXZdoXCw/
X-Received: by 2002:a17:903:2451:b0:13f:297b:829e with SMTP id l17-20020a170903245100b0013f297b829emr8976528pls.45.1633921608790;
        Sun, 10 Oct 2021 20:06:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz522aC78Wz+FanCjWbLjzHnHSGJZv8uq5qq+u1k0QNh4wUny/4WSnXaCkLiou5iG+lw3yODA==
X-Received: by 2002:a17:903:2451:b0:13f:297b:829e with SMTP id l17-20020a170903245100b0013f297b829emr8976514pls.45.1633921608552;
        Sun, 10 Oct 2021 20:06:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a67sm5739308pfa.128.2021.10.10.20.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 20:06:48 -0700 (PDT)
Subject: Re: [PATCH v4 5/7] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max,min}
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <e971b011b9224a4da4fcab6e904fcee0b7393ac6.1632882380.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <514a4a6e-89d5-3200-bb31-3660389f5315@redhat.com>
Date:   Mon, 11 Oct 2021 11:06:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e971b011b9224a4da4fcab6e904fcee0b7393ac6.1632882380.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/9/29 ÏÂÎç2:11, Wu Zongyong Ð´µÀ:

> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>


Commit log please.


> ---
>   drivers/virtio/virtio_vdpa.c | 25 ++++++++++++++++++++-----
>   1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..8aa4ebe2a2a2 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   	/* Assume split virtqueue, switch to packed if necessary */
>   	struct vdpa_vq_state state = {0};
>   	unsigned long flags;
> -	u32 align, num;
> +	u32 align, max_num, min_num = 0;
> +	bool may_reduce_num = true;
>   	int err;
>   
>   	if (!name)
> @@ -163,22 +164,36 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>   	if (!info)
>   		return ERR_PTR(-ENOMEM);
>   
> -	num = ops->get_vq_num_max(vdpa);
> -	if (num == 0) {
> +	max_num = ops->get_vq_num_max(vdpa);
> +	if (max_num == 0) {
>   		err = -ENOENT;
>   		goto error_new_virtqueue;
>   	}
>   
> +	if (ops->get_vq_num_min)
> +		min_num = ops->get_vq_num_min(vdpa);
> +	if (min_num > max_num) {
> +		err = -ENOENT;
> +		goto error_new_virtqueue;
> +	}


If we really want to do this, let's move this to vdpa core during device 
probing.

Or just leave it as is (device risk itself).

Thanks


> +
> +	may_reduce_num = (max_num == min_num) ? false : true;
> +
>   	/* Create the vring */
>   	align = ops->get_vq_align(vdpa);
> -	vq = vring_create_virtqueue(index, num, align, vdev,
> -				    true, true, ctx,
> +	vq = vring_create_virtqueue(index, max_num, align, vdev,
> +				    true, may_reduce_num, ctx,
>   				    virtio_vdpa_notify, callback, name);
>   	if (!vq) {
>   		err = -ENOMEM;
>   		goto error_new_virtqueue;
>   	}
>   
> +	if (virtqueue_get_vring_size(vq) < min_num) {
> +		err = -EINVAL;
> +		goto err_vq;
> +	}
> +
>   	/* Setup virtqueue callback */
>   	cb.callback = virtio_vdpa_virtqueue_cb;
>   	cb.private = info;

