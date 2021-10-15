Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09AB42EC62
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236948AbhJOIcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:32:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234171AbhJOIc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634286623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RellDte0zX0H6EBtcv6aJfrwrLR3zqUQWiXwLFeHX28=;
        b=DCjDoz/ymGyz6heRfBh2BNpr2H0/1rXTaeyFAde9m7crdkZ9Ts+j6X50OT27ITjYKeLId/
        45y1D1sB7ZJ60ObvTPP2qGqJFHdn71xpS6639X7hcyv2adgPbedIf854J9AICIYXZ8ibxK
        vGy9uJctEm8B7jt5Wv5hd7l3TGlm0Lc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-RKd29lrMOMiyz_sTMRjV0w-1; Fri, 15 Oct 2021 04:30:19 -0400
X-MC-Unique: RKd29lrMOMiyz_sTMRjV0w-1
Received: by mail-pl1-f200.google.com with SMTP id k18-20020a170902c41200b0013f24806d35so3631745plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RellDte0zX0H6EBtcv6aJfrwrLR3zqUQWiXwLFeHX28=;
        b=RvmlkyjLS58jXNPTdhY22U03xYgPWsmmgFOm5d7JfOmD/F5Og/JxMoDMm7ZxX2xIsd
         gRtT1SwBfY8se7Fel3xFD4dZNTVzmCRxeXLZ9X7dPUTFKCdaUc9GA2bE5J++V9kJ10hP
         1O1veuN4Wn5XCXp4ptunr8jQLQ+BbLI2UmLrlFk70m7cox11n/McUCzliS6pGVC4hA29
         UbwpnUcJei4Q5loDsxWa3bJHIlCctX4XdssJycaojrPoTnJDaVN+4ageWZMgH24qokzY
         jo0iXGnldk0FMk+zUEP/sLJNMbTfSOLBKx69vobB6acBht75tJqIjH8twzBLVgmmPQF2
         MHyg==
X-Gm-Message-State: AOAM533Zpo15Aj8VUIXORa4rED9beSG3w9PTsY4m9rCK0iYZAX8ZqIz0
        AQka1CMt4XHazhZql+S8yTg6l0QpaG8Y6bwp3ZPsJgIXvf3xKbgB0BvE7xvz5ik97/Y3YuyKo2q
        H2ELaAcueUy6RryosAlhVRYOt
X-Received: by 2002:a63:1950:: with SMTP id 16mr8153919pgz.346.1634286618466;
        Fri, 15 Oct 2021 01:30:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbABnhLHpf7APWDI+RKZdiwFZSAfJs/yrcMCfsG+yMNY3x84Rr3xP8R5MGC5PDyUyHBxKwug==
X-Received: by 2002:a63:1950:: with SMTP id 16mr8153898pgz.346.1634286618133;
        Fri, 15 Oct 2021 01:30:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u11sm4691374pfg.2.2021.10.15.01.30.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 01:30:17 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] virtio_vdpa: setup correct vq size with callbacks
 get_vq_num_{max,min}
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, mst@redhat.com
Cc:     wei.yang1@linux.alibaba.com
References: <cover.1632882380.git.wuzongyong@linux.alibaba.com>
 <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <4fae24ebd63ac4ec513bfe0688051469ea0588c0.1634281805.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <8dcb7f03-2d68-9e74-7f54-4d3ffbe49069@redhat.com>
Date:   Fri, 15 Oct 2021 16:30:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <4fae24ebd63ac4ec513bfe0688051469ea0588c0.1634281805.git.wuzongyong@linux.alibaba.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/10/15 ÏÂÎç3:14, Wu Zongyong Ð´µÀ:
> For the devices which implement the get_vq_num_min callback, the driver
> should not negotiate with virtqueue size with the backend vdpa device if
> the value returned by get_vq_num_min equals to the value returned by
> get_vq_num_max.
> This is useful for vdpa devices based on legacy virtio specfication.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>   drivers/virtio/virtio_vdpa.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..e42ace29daa1 100644
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
> @@ -163,22 +164,32 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
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


Under which condition can we hit this error?

Thanks


> +
>   	/* Setup virtqueue callback */
>   	cb.callback = virtio_vdpa_virtqueue_cb;
>   	cb.private = info;

