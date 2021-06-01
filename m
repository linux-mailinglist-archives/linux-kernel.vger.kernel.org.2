Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C843338F80D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhEYCZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:25:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230026AbhEYCZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621909431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pA/QwPywSWTHg158KqGHIXsGw9/je8wyRbMc2/UDcTk=;
        b=ZgDC0thzPH0b8KZIUTWuC2WiGfkDZq6B8B+FwKro2xZBmOP1Km+GCDtmhglbHdBuJbdF/q
        /E5dXq0z5hS7ziHynGDZ3Om8sjTCEhHld2YRxutBKPN1nJ6BoO6i9oDwhNjKptmt7R1RH4
        FjsxB7XF9IAjakKntQQ5kG8xjqK6fIw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-ycm7dmFoMCKHfsfQK41NWQ-1; Mon, 24 May 2021 22:23:49 -0400
X-MC-Unique: ycm7dmFoMCKHfsfQK41NWQ-1
Received: by mail-pg1-f198.google.com with SMTP id s7-20020a6352470000b029021b9013c124so1870038pgl.19
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:23:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pA/QwPywSWTHg158KqGHIXsGw9/je8wyRbMc2/UDcTk=;
        b=W1RGlL56KE0951nT5E9DeVYYvVMsMADkF7LIbv0oxnwQLCxt5GRLHTVCWChp4Ob+fA
         y5XnzBNxzOlX4QMOo2StrALcJu9x814TAEOWsi755CTj5/iSNxI2Hiy/UwfeKkASx9jq
         vOUWAZ5DwSfNXploDm7X/rsDKKmOpZ6FnTk4hiEy7PSRFU8Da3jyke0FlYG8h4/hLFoK
         RZnsRJV3Fkrcc6CDXwxlHSuWg0QDgIkD2g4naEFbebRgP1GO/uuxb0rrA2JJoerwn6+r
         gu+g8Vx7zIjv7W7zj7fNZUC7va2KHR9C7fNWfrWcJMdWu1cIEDV1NWjELFmeqOB6U7bB
         Mo3g==
X-Gm-Message-State: AOAM531N+pES3Ph0q89c9H6AHoSRHoDk29wwBR+lmF+aCzCpS+wpac66
        7ujvQWhrqjlRiVijxhMs02B1WWsKwEsDFEJ1A7acp3F7uxUF+wbR+KEv3ws4e8BtdMXOBVYutJx
        ut7xDJiK1+ThvUk5lS5BPy0AT
X-Received: by 2002:a63:fc11:: with SMTP id j17mr16218464pgi.355.1621909428729;
        Mon, 24 May 2021 19:23:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoau2gtzCYKkkHEUElyjNoBWmK5Hyy0SWIBWDEmY6XbWsJabWGUYCvDE2GIyPl+Z1OhgooGA==
X-Received: by 2002:a63:fc11:: with SMTP id j17mr16218447pgi.355.1621909428470;
        Mon, 24 May 2021 19:23:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c1sm8206959pfo.181.2021.05.24.19.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 19:23:48 -0700 (PDT)
Subject: Re: [PATCH 1/3] virtio: add virtioqueue_more_used()
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-2-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <dc4a4d96-53b1-5358-cfdd-61795283fd88@redhat.com>
Date:   Tue, 25 May 2021 10:23:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520141305.355961-2-stefanha@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


�� 2021/5/20 ����10:13, Stefan Hajnoczi д��:
> Add an API to check whether there are pending used buffers. There is
> already a similar API called virtqueue_poll() but it only works together
> with virtqueue_enable_cb_prepare(). The patches that follow add blk-mq
> ->poll() support to virtio_blk and they need to check for used buffers
> without re-enabling virtqueue callbacks, so introduce an API for it.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Typo in the subject.


> ---
>   include/linux/virtio.h       |  2 ++
>   drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
>   2 files changed, 19 insertions(+)
>
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index b1894e0323fa..c6ad0f25f412 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -63,6 +63,8 @@ bool virtqueue_kick_prepare(struct virtqueue *vq);
>   
>   bool virtqueue_notify(struct virtqueue *vq);
>   
> +bool virtqueue_more_used(const struct virtqueue *vq);
> +
>   void *virtqueue_get_buf(struct virtqueue *vq, unsigned int *len);
>   
>   void *virtqueue_get_buf_ctx(struct virtqueue *vq, unsigned int *len,
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 71e16b53e9c1..7c3da75da462 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2032,6 +2032,23 @@ static inline bool more_used(const struct vring_virtqueue *vq)
>   	return vq->packed_ring ? more_used_packed(vq) : more_used_split(vq);
>   }
>   
> +/**
> + * virtqueue_more_used - check if there are used buffers pending
> + * @_vq: the struct virtqueue we're talking about.
> + *
> + * Returns true if there are used buffers, false otherwise. May be called at
> + * the same time as other virtqueue operations, but actually calling
> + * virtqueue_get_buf() requires serialization so be mindful of the race between
> + * calling virtqueue_more_used() and virtqueue_get_buf().
> + */
> +bool virtqueue_more_used(const struct virtqueue *_vq)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +	return more_used(vq);
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_more_used);


It's worth to mention that the function is not serialized (no barriers).

Thanks


> +
>   irqreturn_t vring_interrupt(int irq, void *_vq)
>   {
>   	struct vring_virtqueue *vq = to_vvq(_vq);

