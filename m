Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF36B347BC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236507AbhCXPJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37769 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236491AbhCXPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616598559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jqXvs+0nCxAmKCtC0cP0qRElEwb5kKKFxyyMwoEAD/A=;
        b=YLI01+/1zrxaPdUCXVMp/fa3Tg0qApxCHN3k4LkEnIqjA/MbiXgS0FIMKsNtubuAgCGoDE
        Iz0+6eg2hlAS0NEWxa69+xTnFBkPuN+km6Q57HIVPLDlwpXQ3Hyk+df4wLLFMkTgZYHSxU
        /YBxQtelv7CNVRMYwqm4Y+uf1L11SJY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-KcmV-SLRNxy7ImSKw6cpZw-1; Wed, 24 Mar 2021 11:09:17 -0400
X-MC-Unique: KcmV-SLRNxy7ImSKw6cpZw-1
Received: by mail-oo1-f71.google.com with SMTP id u30so1418681ooj.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jqXvs+0nCxAmKCtC0cP0qRElEwb5kKKFxyyMwoEAD/A=;
        b=NxJSs9s9AImHpLPHRduGGSv2rr+jfU/EoUy44gAUxevwaCufmEFszmntBrc4fZngR1
         R0BZiUNcyBDSI85C8zQ+1sbscdXUZpVKqavu2uU2VhsSpTWAREFr6jYWwhiUwCx1LNzz
         +dL4jliom78fRoPTOphtv2xt/n7dASJZPJPAYtarrAUYu1iselgBmRW/DoRNdyXtKzDe
         qNklUgUpfHOW8zKJJ9IXzV+ft/WUjq6eVGrgiMNRlKKM7CmCeyOyEFldtkYkQkQKlq1E
         WagxEzFdDm1HL9UHqoshglksQ4nhISt8mvU41EWFBqHXHLdkRLJwOAQQ3GyrUBHMIqEo
         n+1Q==
X-Gm-Message-State: AOAM532rEYCQxWC4drhiMOO/tFZPZTcQwd9dEc/OLtwLZ6UwDCwHLiSQ
        +sdrBJjdjA4dkDMBlJ4BcvM45uYE6NrF/iFoLGEzfiP+QSu8MBJzYoS405DVQR7jbBdNNB3FNx2
        uXRtKgyX9K0yU4WjwokMI043h
X-Received: by 2002:aca:6204:: with SMTP id w4mr2835028oib.86.1616598557120;
        Wed, 24 Mar 2021 08:09:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHPVgEdBZLrQFZ7Du7KylIQIiw5HTambi70oV6Rxz8VLEHPTtDJpdjuIgYn7pwxoFzoqH4cw==
X-Received: by 2002:aca:6204:: with SMTP id w4mr2835008oib.86.1616598556903;
        Wed, 24 Mar 2021 08:09:16 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id t22sm596856otl.49.2021.03.24.08.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 08:09:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] virtiofs: split requests that exceed virtqueue size
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, stefanha@redhat.com,
        vgoyal@redhat.com, jasowang@redhat.com, mst@redhat.com
References: <20210318135223.1342795-1-ckuehl@redhat.com>
 <20210318135223.1342795-3-ckuehl@redhat.com>
 <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <04e46a8c-df26-3b58-71f8-c0b94c546d70@redhat.com>
Date:   Wed, 24 Mar 2021 10:09:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YFNvH8w4l7WyEMyr@miu.piliscsaba.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/21 10:17 AM, Miklos Szeredi wrote:
> I removed the conditional compilation and renamed the limit.  Also made
> virtio_fs_get_tree() bail out if it hit the WARN_ON().  Updated patch below.

Hi Miklos,

Has this patch been queued?

Connor

> ---
> From: Connor Kuehl <ckuehl@redhat.com>
> Subject: virtiofs: split requests that exceed virtqueue size
> Date: Thu, 18 Mar 2021 08:52:22 -0500
> 
> If an incoming FUSE request can't fit on the virtqueue, the request is
> placed onto a workqueue so a worker can try to resubmit it later where
> there will (hopefully) be space for it next time.
> 
> This is fine for requests that aren't larger than a virtqueue's maximum
> capacity.  However, if a request's size exceeds the maximum capacity of the
> virtqueue (even if the virtqueue is empty), it will be doomed to a life of
> being placed on the workqueue, removed, discovered it won't fit, and placed
> on the workqueue yet again.
> 
> Furthermore, from section 2.6.5.3.1 (Driver Requirements: Indirect
> Descriptors) of the virtio spec:
> 
>    "A driver MUST NOT create a descriptor chain longer than the Queue
>    Size of the device."
> 
> To fix this, limit the number of pages FUSE will use for an overall
> request.  This way, each request can realistically fit on the virtqueue
> when it is decomposed into a scattergather list and avoid violating section
> 2.6.5.3.1 of the virtio spec.
> 
> Signed-off-by: Connor Kuehl <ckuehl@redhat.com>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>   fs/fuse/fuse_i.h    |    3 +++
>   fs/fuse/inode.c     |    3 ++-
>   fs/fuse/virtio_fs.c |   19 +++++++++++++++++--
>   3 files changed, 22 insertions(+), 3 deletions(-)
> 
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -555,6 +555,9 @@ struct fuse_conn {
>   	/** Maxmum number of pages that can be used in a single request */
>   	unsigned int max_pages;
>   
> +	/** Constrain ->max_pages to this value during feature negotiation */
> +	unsigned int max_pages_limit;
> +
>   	/** Input queue */
>   	struct fuse_iqueue iq;
>   
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -712,6 +712,7 @@ void fuse_conn_init(struct fuse_conn *fc
>   	fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
>   	fc->user_ns = get_user_ns(user_ns);
>   	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
> +	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
>   
>   	INIT_LIST_HEAD(&fc->mounts);
>   	list_add(&fm->fc_entry, &fc->mounts);
> @@ -1040,7 +1041,7 @@ static void process_init_reply(struct fu
>   				fc->abort_err = 1;
>   			if (arg->flags & FUSE_MAX_PAGES) {
>   				fc->max_pages =
> -					min_t(unsigned int, FUSE_MAX_MAX_PAGES,
> +					min_t(unsigned int, fc->max_pages_limit,
>   					max_t(unsigned int, arg->max_pages, 1));
>   			}
>   			if (IS_ENABLED(CONFIG_FUSE_DAX) &&
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -18,6 +18,12 @@
>   #include <linux/uio.h>
>   #include "fuse_i.h"
>   
> +/* Used to help calculate the FUSE connection's max_pages limit for a request's
> + * size. Parts of the struct fuse_req are sliced into scattergather lists in
> + * addition to the pages used, so this can help account for that overhead.
> + */
> +#define FUSE_HEADER_OVERHEAD    4
> +
>   /* List of virtio-fs device instances and a lock for the list. Also provides
>    * mutual exclusion in device removal and mounting path
>    */
> @@ -1413,9 +1419,10 @@ static int virtio_fs_get_tree(struct fs_
>   {
>   	struct virtio_fs *fs;
>   	struct super_block *sb;
> -	struct fuse_conn *fc;
> +	struct fuse_conn *fc = NULL;
>   	struct fuse_mount *fm;
> -	int err;
> +	unsigned int virtqueue_size;
> +	int err = -EIO;
>   
>   	/* This gets a reference on virtio_fs object. This ptr gets installed
>   	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
> @@ -1427,6 +1434,10 @@ static int virtio_fs_get_tree(struct fs_
>   		return -EINVAL;
>   	}
>   
> +	virtqueue_size = virtqueue_get_vring_size(fs->vqs[VQ_REQUEST].vq);
> +	if (WARN_ON(virtqueue_size <= FUSE_HEADER_OVERHEAD))
> +		goto out_err;
> +
>   	err = -ENOMEM;
>   	fc = kzalloc(sizeof(struct fuse_conn), GFP_KERNEL);
>   	if (!fc)
> @@ -1442,6 +1453,10 @@ static int virtio_fs_get_tree(struct fs_
>   	fc->delete_stale = true;
>   	fc->auto_submounts = true;
>   
> +	/* Tell FUSE to split requests that exceed the virtqueue's size */
> +	fc->max_pages_limit = min_t(unsigned int, fc->max_pages_limit,
> +				    virtqueue_size - FUSE_HEADER_OVERHEAD);
> +
>   	fsc->s_fs_info = fm;
>   	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
>   	if (fsc->s_fs_info) {
> 

