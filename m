Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4E3420D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbhJDNQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235903AbhJDNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633353177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nKy01q7QzviKlAmThKzHSK4Bhyjv5rNTrVc1mM+/eWA=;
        b=W/06WMdChXuj3ST6mH6+TaPyMI9BqkXViAUcvmGjwTp5dfRsEgpl118pG/eDGRvj8ZIJAr
        jjikMEGgL7QB4J1W4wXHhszEydWVgJKmHSdWRRSOd5Er5liLLoGOgueY9d93zVg4V9GKy1
        MW15Mh9wTT5DBK+gOTFQ6SwUmQqAHV0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-Ik-wAsqmMFWjbYjvE1829A-1; Mon, 04 Oct 2021 09:12:56 -0400
X-MC-Unique: Ik-wAsqmMFWjbYjvE1829A-1
Received: by mail-wr1-f70.google.com with SMTP id x14-20020a5d60ce000000b00160b27b5fd1so296637wrt.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 06:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nKy01q7QzviKlAmThKzHSK4Bhyjv5rNTrVc1mM+/eWA=;
        b=oe4VOFLaakBlOB0beRPPVRDsTZpbwDC4Y/K0gv9mdPFOaX7o4Ow+pOqRXqbKkBw1Nr
         iL5+MOHEBYSPYNh+0aCyIHQ9DSI/7XObrhO2o8/iRKXk4sPKvDmLubPy80mqk6Fo7flR
         x4J6rI7Q7kZ2mApH2K8jKmevcAKJx8LiXZamKCwteg3U1FdtCZ4YLSNLCTB18i/Z7jhp
         iRr1S/yZSfFc+pLWFgwbqRD3BeFMGclri1DG8QiKHJhjaQGaS6II4AWqrDSlhd2BUv6s
         kshiL6fmkW+n51J7bltGKahEJGTBktY4bUqScUPO4KErgESukARCXYGLMNvzTyAaJraX
         Cvvg==
X-Gm-Message-State: AOAM533ErM8OdF1jjpJcno5k40AOjCub2McwtlS4SY0b4JLgr/ORpktb
        ASwEahJz95ZFIwIPj5vmVPAgUcSw60tqpLqWhTMdwI1p0C9ldmhDWqU7MoAo+1SKwK3A189t4Wu
        eutrOxKrdfezU3/5C6pCOGQih
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr18259711wmj.160.1633353173565;
        Mon, 04 Oct 2021 06:12:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/7JuPoRusQE9dAIOzDjog1WyyGeLCBRPdpk0zlyBG1OwcmknElq3co39nZNsk8nASzG7jSQ==
X-Received: by 2002:a7b:cde8:: with SMTP id p8mr18259681wmj.160.1633353173364;
        Mon, 04 Oct 2021 06:12:53 -0700 (PDT)
Received: from redhat.com ([2.55.134.94])
        by smtp.gmail.com with ESMTPSA id s3sm14366860wrm.40.2021.10.04.06.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:12:52 -0700 (PDT)
Date:   Mon, 4 Oct 2021 09:12:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 9/9] vhost: use kernel_worker to check RLIMITs and
 inherit v2 cgroups
Message-ID: <20211004091216-mutt-send-email-mst@kernel.org>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-10-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-10-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:18PM -0500, Mike Christie wrote:
> For vhost workers we use the kthread API which inherit's its values from
> and checks against the kthreadd thread. This results in cgroups v2 not
> working and the wrong RLIMITs being checked. This patch has us use the
> kernel_copy_process function which will inherit its values/checks from the
> thread that owns the device.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Feel free to merge with other bits.

> ---
>  drivers/vhost/vhost.c | 68 ++++++++++++++++---------------------------
>  drivers/vhost/vhost.h |  7 ++++-
>  2 files changed, 31 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index c9a1f706989c..7a5142dcde1b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -22,7 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kthread.h>
> -#include <linux/cgroup.h>
>  #include <linux/module.h>
>  #include <linux/sort.h>
>  #include <linux/sched/mm.h>
> @@ -344,17 +343,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
>  static int vhost_worker(void *data)
>  {
>  	struct vhost_worker *worker = data;
> -	struct vhost_dev *dev = worker->dev;
>  	struct vhost_work *work, *work_next;
>  	struct llist_node *node;
>  
> -	kthread_use_mm(dev->mm);
> -
>  	for (;;) {
>  		/* mb paired w/ kthread_stop */
>  		set_current_state(TASK_INTERRUPTIBLE);
>  
> -		if (kthread_should_stop()) {
> +		if (test_bit(VHOST_WORKER_FLAG_STOP, &worker->flags)) {
>  			__set_current_state(TASK_RUNNING);
>  			break;
>  		}
> @@ -376,8 +372,9 @@ static int vhost_worker(void *data)
>  				schedule();
>  		}
>  	}
> -	kthread_unuse_mm(dev->mm);
> -	return 0;
> +
> +	complete(worker->exit_done);
> +	do_exit(0);
>  }
>  
>  static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
> @@ -517,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
>  
> -struct vhost_attach_cgroups_struct {
> -	struct vhost_work work;
> -	struct task_struct *owner;
> -	int ret;
> -};
> -
> -static void vhost_attach_cgroups_work(struct vhost_work *work)
> -{
> -	struct vhost_attach_cgroups_struct *s;
> -
> -	s = container_of(work, struct vhost_attach_cgroups_struct, work);
> -	s->ret = cgroup_attach_task_all(s->owner, current);
> -}
> -
> -static int vhost_attach_cgroups(struct vhost_dev *dev)
> -{
> -	struct vhost_attach_cgroups_struct attach;
> -
> -	attach.owner = current;
> -	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
> -	vhost_work_queue(dev, &attach.work);
> -	vhost_work_dev_flush(dev);
> -	return attach.ret;
> -}
> -
>  /* Caller should have device mutex */
>  bool vhost_dev_has_owner(struct vhost_dev *dev)
>  {
> @@ -579,6 +551,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
>  	dev->mm = NULL;
>  }
>  
> +static void vhost_worker_stop(struct vhost_worker *worker)
> +{
> +	DECLARE_COMPLETION_ONSTACK(exit_done);
> +
> +	worker->exit_done = &exit_done;
> +	set_bit(VHOST_WORKER_FLAG_STOP, &worker->flags);
> +	wake_up_process(worker->task);
> +	wait_for_completion(worker->exit_done);
> +}
> +
>  static void vhost_worker_free(struct vhost_dev *dev)
>  {
>  	struct vhost_worker *worker = dev->worker;
> @@ -588,7 +570,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
>  
>  	dev->worker = NULL;
>  	WARN_ON(!llist_empty(&worker->work_list));
> -	kthread_stop(worker->task);
> +	vhost_worker_stop(worker);
>  	kfree(worker);
>  }
>  
> @@ -603,27 +585,27 @@ static int vhost_worker_create(struct vhost_dev *dev)
>  		return -ENOMEM;
>  
>  	dev->worker = worker;
> -	worker->dev = dev;
>  	worker->kcov_handle = kcov_common_handle();
>  	init_llist_head(&worker->work_list);
>  
> -	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
> +	/*
> +	 * vhost used to use the kthread API which ignores all signals by
> +	 * default and the drivers expect this behavior. So we do not want to
> +	 * ineherit the parent's signal handlers and set our worker to ignore
> +	 * everything below.
> +	 */
> +	task = kernel_worker(vhost_worker, worker, NUMA_NO_NODE,
> +			     CLONE_FS | CLONE_CLEAR_SIGHAND,
> +			     KERN_WORKER_NO_FILES | KERN_WORKER_NO_SIGS);
>  	if (IS_ERR(task)) {
>  		ret = PTR_ERR(task);
>  		goto free_worker;
>  	}
>  
>  	worker->task = task;
> -	wake_up_process(task); /* avoid contributing to loadavg */
> -
> -	ret = vhost_attach_cgroups(dev);
> -	if (ret)
> -		goto stop_worker;
> -
> +	kernel_worker_start(task, "vhost-%d", current->pid);
>  	return 0;
>  
> -stop_worker:
> -	kthread_stop(worker->task);
>  free_worker:
>  	kfree(worker);
>  	dev->worker = NULL;
> diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
> index 102ce25e4e13..09748694cb66 100644
> --- a/drivers/vhost/vhost.h
> +++ b/drivers/vhost/vhost.h
> @@ -25,11 +25,16 @@ struct vhost_work {
>  	unsigned long		flags;
>  };
>  
> +enum {
> +	VHOST_WORKER_FLAG_STOP,
> +};
> +
>  struct vhost_worker {
>  	struct task_struct	*task;
> +	struct completion	*exit_done;
>  	struct llist_head	work_list;
> -	struct vhost_dev	*dev;
>  	u64			kcov_handle;
> +	unsigned long		flags;
>  };
>  
>  /* Poll a file (eventfd or socket) */
> -- 
> 2.25.1

