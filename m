Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD03A392702
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 07:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhE0FuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 01:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232773AbhE0FuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 01:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622094528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hrDilVfh/qqPx2XPO3E6zbGSUURQs7c8ZBAfRTr1MU=;
        b=F2WKeBmSLPTW9cRWG1ZkFmFGgVbCKH9DswlwtkA0zVquT3xDzlIjGUiXbjVNcEW0AXQFkB
        nO5lF+pCjb9nh9nD3pZWvck3/58J93liHys/niJiIUVz8Jdsc9yEZuoKs4qrO00feqI7Cs
        xyAs06QtI6VXv3XFTTVgUTFG3nAuCQc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-q7BdS3SHMyKJSSpv928BkQ-1; Thu, 27 May 2021 01:48:47 -0400
X-MC-Unique: q7BdS3SHMyKJSSpv928BkQ-1
Received: by mail-pf1-f197.google.com with SMTP id g144-20020a6252960000b029023d959faca6so2180184pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 22:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0hrDilVfh/qqPx2XPO3E6zbGSUURQs7c8ZBAfRTr1MU=;
        b=O7VL6f4HNbDmhei5d/YF4ovERWQJwBlbw5uGGZNNjvYBLCcCr0meavk9pFYlORh7MM
         oJ6X7RkievkDPvlHOFhGyD0yQ5aX+ND8WchW6SzwcIvbZylchmY8xNHKHFT9h5gmaaKB
         ztpPkiyKRMBANePVswOXpJoKfgY0hfrl5FYVHnzHsuENxSfiRkvYAF1TqQq9pOOF89NR
         xUVbG26josfde2FmUdVUwnbQZzqmDXifx92fQCIczlw2HvDuw5hlmdUSmvaIuGKVZZJ9
         MxJmscfTay8RaQvDvENzU7Wr0fuhGNljsQ0OyQJApS+6++JVo15vM2/a23DamT10WhSa
         UXig==
X-Gm-Message-State: AOAM530NjFgqeY+wAhq989Ggrzo90GyqFCUdzQTfxtSGU5dpT/Sq3D+9
        SKFOkEq0JeXYeOOox5dB8R3ZIOfqdcEIsaetjRC0Bfe/FSc/OGWmPx1Q5Mw3kojcw7Mdgu46dI1
        M4jKACVdVtR0UIM3+DpaUL3Yp
X-Received: by 2002:a63:6cc1:: with SMTP id h184mr2135505pgc.367.1622094525878;
        Wed, 26 May 2021 22:48:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhiC4pUyikKRVg/fGg/BEWY/NKv/DsEJoI/3n+vZ8sn2JoDl+AANg2WvJ/mb0S+nQ+EAS4Ag==
X-Received: by 2002:a63:6cc1:: with SMTP id h184mr2135485pgc.367.1622094525472;
        Wed, 26 May 2021 22:48:45 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id o186sm873098pfg.170.2021.05.26.22.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 22:48:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] virtio_blk: implement blk_mq_ops->poll()
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, slp@redhat.com,
        sgarzare@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
References: <20210520141305.355961-1-stefanha@redhat.com>
 <20210520141305.355961-4-stefanha@redhat.com>
 <eefac014-0361-b554-ffdc-2ce920810fa5@redhat.com>
 <YKy8Znh/MqHWSmON@stefanha-x1.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c51191b8-d741-2abc-0446-8a139e2ea401@redhat.com>
Date:   Thu, 27 May 2021 13:48:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKy8Znh/MqHWSmON@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/25 下午4:59, Stefan Hajnoczi 写道:
> On Tue, May 25, 2021 at 11:21:41AM +0800, Jason Wang wrote:
>> 在 2021/5/20 下午10:13, Stefan Hajnoczi 写道:
>>> Request completion latency can be reduced by using polling instead of
>>> irqs. Even Posted Interrupts or similar hardware support doesn't beat
>>> polling. The reason is that disabling virtqueue notifications saves
>>> critical-path CPU cycles on the host by skipping irq injection and in
>>> the guest by skipping the irq handler. So let's add blk_mq_ops->poll()
>>> support to virtio_blk.
>>>
>>> The approach taken by this patch differs from the NVMe driver's
>>> approach. NVMe dedicates hardware queues to polling and submits
>>> REQ_HIPRI requests only on those queues. This patch does not require
>>> exclusive polling queues for virtio_blk. Instead, it switches between
>>> irqs and polling when one or more REQ_HIPRI requests are in flight on a
>>> virtqueue.
>>>
>>> This is possible because toggling virtqueue notifications is cheap even
>>> while the virtqueue is running. NVMe cqs can't do this because irqs are
>>> only enabled/disabled at queue creation time.
>>>
>>> This toggling approach requires no configuration. There is no need to
>>> dedicate queues ahead of time or to teach users and orchestration tools
>>> how to set up polling queues.
>>>
>>> Possible drawbacks of this approach:
>>>
>>> - Hardware virtio_blk implementations may find virtqueue_disable_cb()
>>>     expensive since it requires DMA.
>>
>> Note that it's probably not related to the behavior of the driver but the
>> design of the event suppression mechanism.
>>
>> Device can choose to ignore the suppression flag and keep sending
>> interrupts.
> Yes, it's the design of the event suppression mechanism.
>
> If we use dedicated polling virtqueues then the hardware doesn't need to
> check whether interrupts are enabled for each notification. However,
> there's no mechanism to tell the device that virtqueue interrupts are
> permanently disabled. This means that as of today, even dedicated
> virtqueues cannot suppress interrupts without the device checking for
> each notification.


This can be detected via a transport specific way.

E.g in the case of MSI, VIRTIO_MSI_NO_VECTOR could be a hint.


>
>>>    If such devices become popular then
>>>     the virtio_blk driver could use a similar approach to NVMe when
>>>     VIRTIO_F_ACCESS_PLATFORM is detected in the future.
>>>
>>> - If a blk_poll() thread is descheduled it not only hurts polling
>>>     performance but also delays completion of non-REQ_HIPRI requests on
>>>     that virtqueue since vq notifications are disabled.
>>
>> Can we poll only when only high pri requests are pending?
> Yes, that's what this patch does.
>
>> If the backend is a remote one, I think the polling may cause more cpu
>> cycles.
> Right, but polling is only done when userspace sets the RWF_HIPRI
> request flag. Most applications don't support it and for those that do
> it's probably an option that the user needs to enable explicitly.


I see.


>
> Stefan
>
>>> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
>>> index fc0fb1dcd399..f0243dcd745a 100644
>>> --- a/drivers/block/virtio_blk.c
>>> +++ b/drivers/block/virtio_blk.c
>>> @@ -29,6 +29,16 @@ static struct workqueue_struct *virtblk_wq;
>>>    struct virtio_blk_vq {
>>>    	struct virtqueue *vq;
>>>    	spinlock_t lock;
>>> +
>>> +	/* Number of non-REQ_HIPRI requests in flight. Protected by lock. */
>>> +	unsigned int num_lopri;
>>> +
>>> +	/* Number of REQ_HIPRI requests in flight. Protected by lock. */
>>> +	unsigned int num_hipri;
>>> +
>>> +	/* Are vq notifications enabled? Protected by lock. */
>>> +	bool cb_enabled;
>>
>> We had event_flag_shadow, is it sufficient to introduce a new helper
>> virtqueue_cb_is_enabled()?
> Yes, I'll try that in the next revision.
>
>>> +
>>>    	char name[VQ_NAME_LEN];
>>>    } ____cacheline_aligned_in_smp;
>>> @@ -171,33 +181,67 @@ static inline void virtblk_request_done(struct request *req)
>>>    	blk_mq_end_request(req, virtblk_result(vbr));
>>>    }
>>> -static void virtblk_done(struct virtqueue *vq)
>>> +/* Returns true if one or more requests completed */
>>> +static bool virtblk_complete_requests(struct virtqueue *vq)
>>>    {
>>>    	struct virtio_blk *vblk = vq->vdev->priv;
>>>    	struct virtio_blk_vq *vbq = &vblk->vqs[vq->index];
>>>    	bool req_done = false;
>>> +	bool last_hipri_done = false;
>>>    	struct virtblk_req *vbr;
>>>    	unsigned long flags;
>>>    	unsigned int len;
>>>    	spin_lock_irqsave(&vbq->lock, flags);
>>> +
>>>    	do {
>>> -		virtqueue_disable_cb(vq);
>>> +		if (vbq->cb_enabled)
>>> +			virtqueue_disable_cb(vq);
>>>    		while ((vbr = virtqueue_get_buf(vq, &len)) != NULL) {
>>>    			struct request *req = blk_mq_rq_from_pdu(vbr);
>>> +			if (req->cmd_flags & REQ_HIPRI) {
>>> +				if (--vbq->num_hipri == 0)
>>> +					last_hipri_done = true;
>>> +			} else
>>> +				vbq->num_lopri--;
>>> +
>>>    			if (likely(!blk_should_fake_timeout(req->q)))
>>>    				blk_mq_complete_request(req);
>>>    			req_done = true;
>>>    		}
>>>    		if (unlikely(virtqueue_is_broken(vq)))
>>>    			break;
>>> -	} while (!virtqueue_enable_cb(vq));
>>> +
>>> +		/* Enable vq notifications if non-polled requests remain */
>>> +		if (last_hipri_done && vbq->num_lopri > 0) {
>>> +			last_hipri_done = false;
>>> +			vbq->cb_enabled = true;
>>> +		}
>>> +	} while (vbq->cb_enabled && !virtqueue_enable_cb(vq));
>>>    	/* In case queue is stopped waiting for more buffers. */
>>>    	if (req_done)
>>>    		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
>>>    	spin_unlock_irqrestore(&vbq->lock, flags);
>>> +
>>> +	return req_done;
>>> +}
>>> +
>>> +static int virtblk_poll(struct blk_mq_hw_ctx *hctx)
>>> +{
>>> +	struct virtio_blk *vblk = hctx->queue->queuedata;
>>> +	struct virtqueue *vq = vblk->vqs[hctx->queue_num].vq;
>>> +
>>> +	if (!virtqueue_more_used(vq))
>>
>> I'm not familiar with block polling but what happens if a buffer is made
>> available after virtqueue_more_used() returns false here?
> Can you explain the scenario, I'm not sure I understand? "buffer is made
> available" -> are you thinking about additional requests being submitted
> by the driver or an in-flight request being marked used by the device?


Something like that:

1) requests are submitted
2) poll but virtqueue_more_used() return false
3) device make buffer used

In this case, will poll() be triggered again by somebody else? (I think 
interrupt is disabled here).

Thanks



>
> Stefan

