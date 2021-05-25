Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7C38F814
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhEYC04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41122 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230100AbhEYC0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621909525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1qoKlOsGh04ss63Lt/Lntwf9cwsxjTtguPKVdlfA3Ng=;
        b=XT44TIXkrAAPWSDGaqDvDWkenuKetRqNR9d7/SheXZe4VAeCG+njkih9Rg7YtW82ffBPUQ
        My4sDe915n761znsrPLb9ua5c73ikeyeglkp2XX4r2QqJ9NEG0LON5LU3Xg/rHns29ZFQy
        tm3tam4bu+iwF+zBllmwt0Uus7in3w0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-kWDRtlksPXeHl-iONzhyvg-1; Mon, 24 May 2021 22:25:23 -0400
X-MC-Unique: kWDRtlksPXeHl-iONzhyvg-1
Received: by mail-pg1-f199.google.com with SMTP id q64-20020a6343430000b02902164088f2f0so19844932pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 19:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1qoKlOsGh04ss63Lt/Lntwf9cwsxjTtguPKVdlfA3Ng=;
        b=rTIq/A6z0NG66pLAYaEN2EmaNXazgi3v06cQC0ks3uIVATBm2CO4nuSTAYbpUDvi33
         Esg0m4XR2kRyzwCqBNMJf7Dsdz2evniU0Brm2hbL46titzYByjKVrrXjYRVYzb0ZB8NK
         25/5SjGyF/PMMDrpLTvjrt2C8ZTzv7rI4TunDjRiUmMMU2WNERkF6UoAfSasbf+8SNIt
         y+1UOLmox9FEUqWfg67yZSk7wNqYK1txFCGSf1rYcBmxa7gAA6mIkPxjTF0eXQnppzN3
         Tzi0KiQp4h62i9Jy3uzGpzq77dHnQAm9G+jX7X0S5nicIoczVxTSlxec5S16c/yXgkra
         hzPA==
X-Gm-Message-State: AOAM532keBiQ25RKQ71E8/YfccN/HR0ZxX6czzqWeFhBg1rWaABVTu5Y
        ndv6YuNvKVqUKrYnsELugI6vpqOgOv6A/Ekjqd7EjzeB7ffLwC9GZZcgmX4H4Qa0JCWPX1glLlu
        WyPh1sI7DbG91kI8nWpZs8gDJ
X-Received: by 2002:a17:90b:4a12:: with SMTP id kk18mr28055329pjb.99.1621909522560;
        Mon, 24 May 2021 19:25:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzRV+qJUokH6c8EHK6OUiQ6oCyA7PhcBNQL+CnWJHhK5yhITE+2ZcU/lrqFBmiLVDRSYo1z9w==
X-Received: by 2002:a17:90b:4a12:: with SMTP id kk18mr28055310pjb.99.1621909522344;
        Mon, 24 May 2021 19:25:22 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d15sm3912029pfd.35.2021.05.24.19.25.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 19:25:21 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtio_blk: avoid repeating vblk->vqs[qid]
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-3-stefanha@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <caf006e5-760f-23c9-64a6-35cd6e1f33f4@redhat.com>
Date:   Tue, 25 May 2021 10:25:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210520141305.355961-3-stefanha@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/20 ÏÂÎç10:13, Stefan Hajnoczi Ð´µÀ:
> struct virtio_blk_vq is accessed in many places. Introduce "vbq" local
> variables to avoid repeating vblk->vqs[qid] throughout the code. The
> patches that follow will add more accesses, making the payoff even
> greater.
>
> virtio_commit_rqs() calls the local variable "vq", which is easily
> confused with struct virtqueue. Rename to "vbq" for clarity.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/block/virtio_blk.c | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index b9fa3ef5b57c..fc0fb1dcd399 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -174,16 +174,16 @@ static inline void virtblk_request_done(struct request *req)
>   static void virtblk_done(struct virtqueue *vq)
>   {
>   	struct virtio_blk *vblk = vq->vdev->priv;
> +	struct virtio_blk_vq *vbq = &vblk->vqs[vq->index];
>   	bool req_done = false;
> -	int qid = vq->index;
>   	struct virtblk_req *vbr;
>   	unsigned long flags;
>   	unsigned int len;
>   
> -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> +	spin_lock_irqsave(&vbq->lock, flags);
>   	do {
>   		virtqueue_disable_cb(vq);
> -		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
> +		while ((vbr = virtqueue_get_buf(vq, &len)) != NULL) {
>   			struct request *req = blk_mq_rq_from_pdu(vbr);
>   
>   			if (likely(!blk_should_fake_timeout(req->q)))
> @@ -197,32 +197,32 @@ static void virtblk_done(struct virtqueue *vq)
>   	/* In case queue is stopped waiting for more buffers. */
>   	if (req_done)
>   		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
> -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +	spin_unlock_irqrestore(&vbq->lock, flags);
>   }
>   
>   static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
>   {
>   	struct virtio_blk *vblk = hctx->queue->queuedata;
> -	struct virtio_blk_vq *vq = &vblk->vqs[hctx->queue_num];
> +	struct virtio_blk_vq *vbq = &vblk->vqs[hctx->queue_num];
>   	bool kick;
>   
> -	spin_lock_irq(&vq->lock);
> -	kick = virtqueue_kick_prepare(vq->vq);
> -	spin_unlock_irq(&vq->lock);
> +	spin_lock_irq(&vbq->lock);
> +	kick = virtqueue_kick_prepare(vbq->vq);
> +	spin_unlock_irq(&vbq->lock);
>   
>   	if (kick)
> -		virtqueue_notify(vq->vq);
> +		virtqueue_notify(vbq->vq);
>   }
>   
>   static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			   const struct blk_mq_queue_data *bd)
>   {
>   	struct virtio_blk *vblk = hctx->queue->queuedata;
> +	struct virtio_blk_vq *vbq = &vblk->vqs[hctx->queue_num];
>   	struct request *req = bd->rq;
>   	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
>   	unsigned long flags;
>   	unsigned int num;
> -	int qid = hctx->queue_num;
>   	int err;
>   	bool notify = false;
>   	bool unmap = false;
> @@ -274,16 +274,16 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   			vbr->out_hdr.type |= cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_IN);
>   	}
>   
> -	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
> -	err = virtblk_add_req(vblk->vqs[qid].vq, vbr, vbr->sg, num);
> +	spin_lock_irqsave(&vbq->lock, flags);
> +	err = virtblk_add_req(vbq->vq, vbr, vbr->sg, num);
>   	if (err) {
> -		virtqueue_kick(vblk->vqs[qid].vq);
> +		virtqueue_kick(vbq->vq);
>   		/* Don't stop the queue if -ENOMEM: we may have failed to
>   		 * bounce the buffer due to global resource outage.
>   		 */
>   		if (err == -ENOSPC)
>   			blk_mq_stop_hw_queue(hctx);
> -		spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +		spin_unlock_irqrestore(&vbq->lock, flags);
>   		switch (err) {
>   		case -ENOSPC:
>   			return BLK_STS_DEV_RESOURCE;
> @@ -294,12 +294,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		}
>   	}
>   
> -	if (bd->last && virtqueue_kick_prepare(vblk->vqs[qid].vq))
> +	if (bd->last && virtqueue_kick_prepare(vbq->vq))
>   		notify = true;
> -	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
> +	spin_unlock_irqrestore(&vbq->lock, flags);
>   
>   	if (notify)
> -		virtqueue_notify(vblk->vqs[qid].vq);
> +		virtqueue_notify(vbq->vq);
>   	return BLK_STS_OK;
>   }
>   

