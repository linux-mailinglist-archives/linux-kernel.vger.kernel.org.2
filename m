Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DF5420D86
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhJDNQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhJDNOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633353136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUUYscVcsLmm5Q6i3ivEPSHGrVAU4eh3GbR7e1/whh8=;
        b=Fxj5EvDNedg5SGz3Rs8L48/8itWwZcAk/zwMwqHgG++UXXMFOlUB+lTCN/v6TgE+CADnaq
        EWht+74X3xxPg33G7FEyQXQc0DxK73wqHsjPUDpt7g9tT96pZQotfv567ByZdK8Oeq2g2h
        805Rfv9Ulyejcy6yx2pE+zXTKm7zN7w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-H545gCdAOTOv5WiXoRG7Hw-1; Mon, 04 Oct 2021 09:12:15 -0400
X-MC-Unique: H545gCdAOTOv5WiXoRG7Hw-1
Received: by mail-wm1-f72.google.com with SMTP id h24-20020a7bc938000000b0030d400be5b5so5444467wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUUYscVcsLmm5Q6i3ivEPSHGrVAU4eh3GbR7e1/whh8=;
        b=UChlxsRv7VJt2yG8EmGTw5mkF80mRddg/2a6MWPA8xSEicCEYM/oNW12JpFqYvYgGq
         b4RueKxMC4vueUugWtGzcB3Dq0ALG8XnsclwWaTLTn37WYIz5VLom0aIM3vMnbqBDyeo
         9BhRJQV2DSdQ0VoHuDcSeVqWNyiYAaLw7gBoobA3uhkYPj840hIhULhhciYi9YYIlO43
         Am0/of1aF8eO/Y6WUTfBqlC3eHqLJs+7GLWKxi44P7qDWKPONg7x/isLBYrjf9Btd9cA
         rTe/8cRsjQEAmeVNGgXSy2AHmrm83t4wctra8E3ZPeXemMiWZWf7A5P896pbKq6tXpi0
         rCjQ==
X-Gm-Message-State: AOAM533y0PV9d42gOhtGbEOiTc6rpb6HyMXUm+5XorCxPBM74NV0XMQ5
        3/14zOijFo1MJd/7vidwlyblYNsJ2gTaDfdBB80SKqrVOHDdvBfgf2x724mFx6G2Pln9NAz/J9b
        Kzqy1ZyqPUG6ptMtoLZG5cEJ0
X-Received: by 2002:adf:db0c:: with SMTP id s12mr14216745wri.322.1633353133717;
        Mon, 04 Oct 2021 06:12:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWW03vBSxWj/RDj66K104aRZdZf0X4HrIo2FmCZFDXO+lybEOup7KtowBgvSU1AWcTnfh0dQ==
X-Received: by 2002:adf:db0c:: with SMTP id s12mr14216699wri.322.1633353133427;
        Mon, 04 Oct 2021 06:12:13 -0700 (PDT)
Received: from redhat.com ([2.55.134.94])
        by smtp.gmail.com with ESMTPSA id d3sm16788063wrb.36.2021.10.04.06.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:12:12 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:12:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 8/9] vhost: move worker thread fields to new struct
Message-ID: <20211004091151-mutt-send-email-mst@kernel.org>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-9-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-9-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:17PM -0500, Mike Christie wrote:
> This is just a prep patch. It moves the worker related fields to a new
> vhost_worker struct and moves the code around to create some helpers that
> will be used in the next patches.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with other bits.

> ---
>  drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
>  drivers/vhost/vhost.h | 11 +++--
>  2 files changed, 72 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 59edb5a1ffe2..c9a1f706989c 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
>  		 * sure it was not in the list.
>  		 * test_and_set_bit() implies a memory barrier.
>  		 */
> -		llist_add(&work->node, &dev->work_list);
> -		wake_up_process(dev->worker);
> +		llist_add(&work->node, &dev->worker->work_list);
> +		wake_up_process(dev->worker->task);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(vhost_work_queue);
> @@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
>  /* A lockless hint for busy polling code to exit the loop */
>  bool vhost_has_work(struct vhost_dev *dev)
>  {
> -	return !llist_empty(&dev->work_list);
> +	return dev->worker && !llist_empty(&dev->worker->work_list);
>  }
>  EXPORT_SYMBOL_GPL(vhost_has_work);
>  
> @@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  
>  static int vhost_worker(void *data)
>  {
> -	struct vhost_dev *dev = data;
> +	struct vhost_worker *worker = data;
> +	struct vhost_dev *dev = worker->dev;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> @@ -358,7 +359,7 @@ static int vhost_worker(void *data)
>  			break;
>  		}
>  
> -		node = llist_del_all(&dev->work_list);
> +		node = llist_del_all(&worker->work_list);
>  		if (!node)
>  			schedule();
>  
> @@ -368,7 +369,7 @@ static int vhost_worker(void *data)
>  		llist_for_each_entry_safe(work, work_next, node, node) {
>  			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>  			__set_current_state(TASK_RUNNING);
> -			kcov_remote_start_common(dev->kcov_handle);
> +			kcov_remote_start_common(worker->kcov_handle);
>  			work->fn(work);
>  			kcov_remote_stop();
>  			if (need_resched())
> @@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
>  	dev->byte_weight = byte_weight;
>  	dev->use_worker = use_worker;
>  	dev->msg_handler = msg_handler;
> -	init_llist_head(&dev->work_list);
>  	init_waitqueue_head(&dev->wait);
>  	INIT_LIST_HEAD(&dev->read_list);
>  	INIT_LIST_HEAD(&dev->pending_list);
> @@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm = NULL;
>  }
>  
> +static void vhost_worker_free(struct vhost_dev *dev)
> +{
> +	struct vhost_worker *worker = dev->worker;
> +
> +	if (!worker)
> +		return;
> +
> +	dev->worker = NULL;
> +	WARN_ON(!llist_empty(&worker->work_list));
> +	kthread_stop(worker->task);
> +	kfree(worker);
> +}
> +
> +static int vhost_worker_create(struct vhost_dev *dev)
> +{
> +	struct vhost_worker *worker;
> +	struct task_struct *task;
> +	int ret;
> +
> +	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
> +	if (!worker)
> +		return -ENOMEM;
> +
> +	dev->worker = worker;
> +	worker->dev = dev;
> +	worker->kcov_handle = kcov_common_handle();
> +	init_llist_head(&worker->work_list);
> +
> +	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
> +	if (IS_ERR(task)) {
> +		ret = PTR_ERR(task);
> +		goto free_worker;
> +	}
> +
> +	worker->task = task;
> +	wake_up_process(task); /* avoid contributing to loadavg */
> +
> +	ret = vhost_attach_cgroups(dev);
> +	if (ret)
> +		goto stop_worker;
> +
> +	return 0;
> +
> +stop_worker:
> +	kthread_stop(worker->task);
> +free_worker:
> +	kfree(worker);
> +	dev->worker = NULL;
> +	return ret;
> +}
> +
>  /* Caller should have device mutex */
>  long vhost_dev_set_owner(struct vhost_dev *dev)
>  {
> -	struct task_struct *worker;
>  	int err;
>  
>  	/* Is there an owner already? */
> @@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
>  
>  	vhost_attach_mm(dev);
>  
> -	dev->kcov_handle = kcov_common_handle();
>  	if (dev->use_worker) {
> -		worker = kthread_create(vhost_worker, dev,
> -					"vhost-%d", current->pid);
> -		if (IS_ERR(worker)) {
> -			err = PTR_ERR(worker);
> -			goto err_worker;
> -		}
> -
> -		dev->worker = worker;
> -		wake_up_process(worker); /* avoid contributing to loadavg */
> -
> -		err = vhost_attach_cgroups(dev);
> +		err = vhost_worker_create(dev);
>  		if (err)
> -			goto err_cgroup;
> +			goto err_worker;
>  	}
>  
>  	err = vhost_dev_alloc_iovecs(dev);
>  	if (err)
> -		goto err_cgroup;
> +		goto err_iovecs;
>  
>  	return 0;
> -err_cgroup:
> -	if (dev->worker) {
> -		kthread_stop(dev->worker);
> -		dev->worker = NULL;
> -	}
> +err_iovecs:
> +	vhost_worker_free(dev);
>  err_worker:
>  	vhost_detach_mm(dev);
> -	dev->kcov_handle = 0;
>  err_mm:
>  	return err;
>  }
> @@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	dev->iotlb = NULL;
>  	vhost_clear_msg(dev);
>  	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
> -	WARN_ON(!llist_empty(&dev->work_list));
> -	if (dev->worker) {
> -		kthread_stop(dev->worker);
> -		dev->worker = NULL;
> -		dev->kcov_handle = 0;
> -	}
> +	vhost_worker_free(dev);
>  	vhost_detach_mm(dev);
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 638bb640d6b4..102ce25e4e13 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -25,6 +25,13 @@ struct vhost_work {
>  	unsigned long		flags;
>  };
>  
> +struct vhost_worker {
> +	struct task_struct	*task;
> +	struct llist_head	work_list;
> +	struct vhost_dev	*dev;
> +	u64			kcov_handle;
> +};
> +
>  /* Poll a file (eventfd or socket) */
>  /* Note: there's nothing vhost specific about this structure. */
>  struct vhost_poll {
> @@ -148,8 +155,7 @@ struct vhost_dev {
>  	struct vhost_virtqueue **vqs;
>  	int nvqs;
>  	struct eventfd_ctx *log_ctx;
> -	struct llist_head work_list;
> -	struct task_struct *worker;
> +	struct vhost_worker *worker;
>  	struct vhost_iotlb *umem;
>  	struct vhost_iotlb *iotlb;
>  	spinlock_t iotlb_lock;
> @@ -159,7 +165,6 @@ struct vhost_dev {
>  	int iov_limit;
>  	int weight;
>  	int byte_weight;
> -	u64 kcov_handle;
>  	bool use_worker;
>  	int (*msg_handler)(struct vhost_dev *dev,
>  			   struct vhost_iotlb_msg *msg);
> -- 
> 2.25.1

