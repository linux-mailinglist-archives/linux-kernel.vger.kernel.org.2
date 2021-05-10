Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F637966A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbhEJRvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:51:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231594AbhEJRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620669014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HrqCS5Oeayu/GGO+Glv71VeHRsfWL2u3aYu2EPq2s/s=;
        b=ccNacxYB1+ZOaOUK9k2sfC61Xa+1HaVFdcywMmIijwcSbe6Om+vkJKW2NH6Rho36BJ03fx
        s8M1Hof2qHElqAkRCRelF2BNKMrneyEv61/pBSzyBFjgyTpAHmJL//xEFZc4mxqECPFUQm
        Of37icohipA0OZPccCfUtQHRAy10BiI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-UwadwnFzMtOwT-QSYQHE6A-1; Mon, 10 May 2021 13:50:13 -0400
X-MC-Unique: UwadwnFzMtOwT-QSYQHE6A-1
Received: by mail-qt1-f199.google.com with SMTP id b8-20020a05622a0208b02901b5b18f4f91so10946136qtx.18
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 10:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HrqCS5Oeayu/GGO+Glv71VeHRsfWL2u3aYu2EPq2s/s=;
        b=Z6P/KbYOrwggKLWgx4WK1SWK00b5I6N71opzWidTnzTYlHA3w4WQfdl+nAwZmUoYBB
         PWne2Bxg5/YE+WrIO/ESyBw78OPAwKVJ2t1FU+H8BqADIOYHoQHvQY1dW+M6QtF5jG8G
         FyetPlAeaI7cm3njNNtymtbjHZkswBHIPYEWmHQRdEsgCplfekbu7gYVmtjhm5Ry5qsu
         ZEo9XgVMXZPAxLZA1Fw1WRCYowJSNUYXJErIqDmVhCJHucuvTmAqdlYqIqufmV8Lg7yu
         btyOp1e8DC3seKaSS0WEBgEVjR4ExQkENVifsk3abJ9ccNKDGgVlY1H/Mhn+LRFwqYyA
         6VCQ==
X-Gm-Message-State: AOAM5301v+N8dpjF4whhc3fuUpeGY9Nv1DmxhWi9JnpK37GS1wJpY+EM
        VEoNmwAafcXiGgSncVnbQSFQ3EStRCXRyfKiVyJmYoWtV5Ybg0h8BfDHzP2qUlI8PaaNO6hS4kp
        Al7w3TAc13BLgGvFO5IeiVFOs
X-Received: by 2002:a05:622a:1704:: with SMTP id h4mr24083011qtk.30.1620669012583;
        Mon, 10 May 2021 10:50:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmt6+0BWlVnZlV/PtV9/dBz1kber3TFT7OWUo13/1RCo5dtYbA+CAwLxA56a9L0aqFp/U7hg==
X-Received: by 2002:a05:622a:1704:: with SMTP id h4mr24082994qtk.30.1620669012371;
        Mon, 10 May 2021 10:50:12 -0700 (PDT)
Received: from horse (pool-173-76-174-238.bstnma.fios.verizon.net. [173.76.174.238])
        by smtp.gmail.com with ESMTPSA id b7sm12167033qkj.126.2021.05.10.10.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:50:11 -0700 (PDT)
Date:   Mon, 10 May 2021 13:50:09 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtiofs: Enable multiple request queues
Message-ID: <20210510175009.GB177952@horse>
References: <20210507221527.699516-1-ckuehl@redhat.com>
 <20210510152506.GC150402@horse>
 <ddbc96c7-655c-e563-e26e-6550a0cdd7c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddbc96c7-655c-e563-e26e-6550a0cdd7c1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 11:15:21AM -0500, Connor Kuehl wrote:
> On 5/10/21 10:25 AM, Vivek Goyal wrote:
> > On Fri, May 07, 2021 at 03:15:27PM -0700, Connor Kuehl wrote:
> >> Distribute requests across the multiqueue complex automatically based
> >> on the IRQ affinity.
> > 
> > Hi Connor,
> > 
> > Thanks for the patch. I will look into it and also test it.
> > 
> > How did you test it? Did you modify vitiofsd to support multiqueue. Did
> > you also run some performance numbers. Does it provide better/worse
> > performance as compared to single queue.
> 
> Thanks, Vivek! I need to NACK this version of the patch for inclusion
> though since I think the way I did per-CPU state will not work for
> multiple virtio-fs mounts because it will be overwritten with each new
> mount, but for testing purposes this should be OK with just one mount.

Hi Connor,

Ok. Will wait for next version which fixes the multiple mount issue.

> 
> I need to do more benchmarking on this.

That would be nice.

> 
> I had to hack multiqueue support into virtiofsd, which runs against the
> warning in the virtiofsd source code that instructs people to *not*
> enable multiqueue due to thread-safety concerns. I didn't audit
> virtiofsd for correctness, so I also worry this has the potential of
> affecting benchmarks if there are races.

filesystem code already can handle multiple threads because on a single
queue we can have a thread pool processing requests in parallel. I am
not aware of any issues about supporting multiple queues. I think
may be fuse_virtio.c might require a little closer inspection to make
sure nothing is dependent on single queue. 

> 
> For testing, QEMU needs to be invoked with `num-request-queues` like
> this:
> 
> 	-device vhost-user-fs-pci,chardev=char0,tag=myfs,num-request-queues=2 
> 
> And obviously you can choose any value >= 1 for num-request-queues.
> 
> and I also made a quick-and-dirty hack to let me pass in the number of
> total queues to virtiofsd on the command line:

Ok. May be there is some inspiration to take from virtio-blk. How do they
specific number of queues by default and how many. I thought stefan mentioned
that by default there is one queue per vcpu.

Vivek

> 
> diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowlevel.c
> index 58e32fc963..cf8f132efd 100644
> --- a/tools/virtiofsd/fuse_lowlevel.c
> +++ b/tools/virtiofsd/fuse_lowlevel.c
> @@ -2565,9 +2565,9 @@ out1:
>      return NULL;
>  }
>  
> -int fuse_session_mount(struct fuse_session *se)
> +int fuse_session_mount(struct fuse_session *se, unsigned int num_queues)
>  {
> -    return virtio_session_mount(se);
> +    return virtio_session_mount(se, num_queues);
>  }
>  
>  int fuse_session_fd(struct fuse_session *se)
> diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowlevel.h
> index 3bf786b034..50bf86113d 100644
> --- a/tools/virtiofsd/fuse_lowlevel.h
> +++ b/tools/virtiofsd/fuse_lowlevel.h
> @@ -1842,7 +1842,7 @@ struct fuse_session *fuse_session_new(struct fuse_args *args,
>   *
>   * @return 0 on success, -1 on failure.
>   **/
> -int fuse_session_mount(struct fuse_session *se);
> +int fuse_session_mount(struct fuse_session *se, unsigned int num_queues);
>  
>  /**
>   * Enter a single threaded, blocking event loop.
> diff --git a/tools/virtiofsd/fuse_virtio.c b/tools/virtiofsd/fuse_virtio.c
> index 3e13997406..8622c3dce6 100644
> --- a/tools/virtiofsd/fuse_virtio.c
> +++ b/tools/virtiofsd/fuse_virtio.c
> @@ -747,20 +747,6 @@ static void fv_queue_set_started(VuDev *dev, int qidx, bool started)
>               started);
>      assert(qidx >= 0);
>  
> -    /*
> -     * Ignore additional request queues for now.  passthrough_ll.c must be
> -     * audited for thread-safety issues first.  It was written with a
> -     * well-behaved client in mind and may not protect against all types of
> -     * races yet.
> -     */
> -    if (qidx > 1) {
> -        fuse_log(FUSE_LOG_ERR,
> -                 "%s: multiple request queues not yet implemented, please only "
> -                 "configure 1 request queue\n",
> -                 __func__);
> -        exit(EXIT_FAILURE);
> -    }
> -
>      if (started) {
>          /* Fire up a thread to watch this queue */
>          if (qidx >= vud->nqueues) {
> @@ -997,7 +983,7 @@ static int fv_create_listen_socket(struct fuse_session *se)
>      return 0;
>  }
>  
> -int virtio_session_mount(struct fuse_session *se)
> +int virtio_session_mount(struct fuse_session *se, unsigned int num_queues)
>  {
>      int ret;
>  
> @@ -1048,8 +1034,8 @@ int virtio_session_mount(struct fuse_session *se)
>      se->vu_socketfd = data_sock;
>      se->virtio_dev->se = se;
>      pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
> -    if (!vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, NULL,
> -                 fv_set_watch, fv_remove_watch, &fv_iface)) {
> +    if (!vu_init(&se->virtio_dev->dev, num_queues, se->vu_socketfd,
> +		 fv_panic, NULL, fv_set_watch, fv_remove_watch, &fv_iface)) {
>          fuse_log(FUSE_LOG_ERR, "%s: vu_init failed\n", __func__);
>          return -1;
>      }
> diff --git a/tools/virtiofsd/fuse_virtio.h b/tools/virtiofsd/fuse_virtio.h
> index 111684032c..a0e78b9b84 100644
> --- a/tools/virtiofsd/fuse_virtio.h
> +++ b/tools/virtiofsd/fuse_virtio.h
> @@ -18,7 +18,7 @@
>  
>  struct fuse_session;
>  
> -int virtio_session_mount(struct fuse_session *se);
> +int virtio_session_mount(struct fuse_session *se, unsigned int num_queues);
>  void virtio_session_close(struct fuse_session *se);
>  int virtio_loop(struct fuse_session *se);
>  
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough_ll.c
> index 1553d2ef45..9fd4e34980 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -161,6 +161,7 @@ struct lo_data {
>      int allow_direct_io;
>      int announce_submounts;
>      bool use_statx;
> +    int num_vqs;
>      struct lo_inode root;
>      GHashTable *inodes; /* protected by lo->mutex */
>      struct lo_map ino_map; /* protected by lo->mutex */
> @@ -204,6 +205,7 @@ static const struct fuse_opt lo_opts[] = {
>      { "announce_submounts", offsetof(struct lo_data, announce_submounts), 1 },
>      { "killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 1 },
>      { "no_killpriv_v2", offsetof(struct lo_data, user_killpriv_v2), 0 },
> +    { "num_queues=%d", offsetof(struct lo_data, num_vqs), 2 },
>      FUSE_OPT_END
>  };
>  static bool use_syslog = false;
> @@ -3848,6 +3850,12 @@ int main(int argc, char *argv[])
>          exit(1);
>      }
>  
> +    if (lo.num_vqs < 2) {
> +        fuse_log(FUSE_LOG_ERR, "num_queues must be at least 2 (got %d)\n",
> +                 lo.num_vqs);
> +        exit(1);
> +    }
> +
>      lo.use_statx = true;
>  
>      se = fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
> @@ -3859,7 +3867,7 @@ int main(int argc, char *argv[])
>          goto err_out2;
>      }
>  
> -    if (fuse_session_mount(se) != 0) {
> +    if (fuse_session_mount(se, lo.num_vqs) != 0) {
>          goto err_out3;
>      }
>  
> 

