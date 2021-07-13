Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50343C6A0A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 07:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhGMF7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 01:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhGMF7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 01:59:14 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D8BC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:56:23 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y8so25700581iop.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 22:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7hjVuTD7ebpc67aOCyY+kA34+JT5DXa9Uos3O7Mgh8=;
        b=ELM5yK5EFrfdNW5bvfms+b5g0QQirYe1yUvvYIbXWoXjNQbVUZ21jod5KrwbzZsxHb
         6UY5EHCoza7kAvevxMzH7CXf6SveoQpJb/UjnYsDp67LsMab344x+fuusoP7Z2AEO+Up
         p4IusX1J7rTckbCBecwUWtCLdb/WIjWmkXKHdaTIb+/YsZX9mwFMn8rA8LiXDUlEdv1r
         ID9eB+RMnF7fmVHumLbgxfZQeR6VqkqSvkPRS5h/SlzfyAZEFZ+qKqMZh/0HUDjqJi8u
         lBgIetnrk7OKardnPlBRR6YmpshJfqFQ8zXrUeb0i2O67zzvI9SI+Vnrc9ZYp87tcc/B
         /O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7hjVuTD7ebpc67aOCyY+kA34+JT5DXa9Uos3O7Mgh8=;
        b=XyN5JZL5Pd52VOmKvd98oM0MzBBwU+6ZRbt2O586T6wwSnzrtN0+lBwR7RMmRprUgd
         OUOsoIQQxV1s3uPkmfpNnwlGfN3UngzBEGGtOAbAtg2Zi3Ok/SXo4z6xfe44xW0RzeBH
         HBAvevZ/FzAYHqaXIcCjnMnS/mzE27NtxlyeM7AODD/gpmHvhe6TbSa2nrbh7gxeNzpC
         TNJ6hs6Tn4IZj38EI38iA1Ep4utCghf0nI6DaymyvRSbhPetuMdpTEuzsTpWck37h8Ir
         NXmvqHT/FkoBgl/XcMG6RD2Ez5LXFOp4FcO+44Y/Ja788F+F+cOKaCCfq4X1f9745Vy4
         tgYg==
X-Gm-Message-State: AOAM533QSCv1R7ltP1VmLgwSW2ecYqDr8Y1gEh8SVd64NaIleBsdjhBr
        3exJTtraf4deEIapBJ1lYe5dAUnM1mpYoatZDEU=
X-Google-Smtp-Source: ABdhPJwMID8d0rgdBuuYtx5RGY+d7khg6d4NoN20ziURnsbUW1ORe01yCBLMqBf5DtFuhCRboQJa9ijjPqEepZ7GQ2Y=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr1903062iom.207.1626155783489;
 Mon, 12 Jul 2021 22:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210709071100.4057639-1-yangyingliang@huawei.com> <YOx392cwdEHMMnD0@slm.duckdns.org>
In-Reply-To: <YOx392cwdEHMMnD0@slm.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 13 Jul 2021 13:56:12 +0800
Message-ID: <CAJhGHyC+oyX6fqnR1-JPnNgPuDpikU6KYr1iXrj7BDZHnjPGTA@mail.gmail.com>
Subject: Re: [PATCH v2] workqueue: fix UAF in pwq_unbound_release_workfn()
To:     Tejun Heo <tj@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 1:12 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Yang.
>
> > +static void free_pwq(struct pool_workqueue *pwq)
> > +{
> > +     if (!pwq || --pwq->refcnt)
> > +             return;
> > +
> > +     put_unbound_pool(pwq->pool);
> > +     kmem_cache_free(pwq_cache, pwq);
> > +}
> > +
> > +static void free_wqattrs_ctx(struct apply_wqattrs_ctx *ctx)
> > +{
> > +     int node;
> > +
> > +     if (!ctx)
> > +             return;
> > +
> > +     for_each_node(node)
> > +             free_pwq(ctx->pwq_tbl[node]);
> > +     free_pwq(ctx->dfl_pwq);
> > +
> > +     free_workqueue_attrs(ctx->attrs);
> > +
> > +     kfree(ctx);
> > +}
>
> It bothers me that we're partially replicating the free path including pwq
> refcnting.

The replicating code can be reduced by merging
apply_wqattrs_cleanup() into apply_wqattrs_commit().

> Does something like the following work?

It works since it has a flush_scheduled_work() in
alloc_and_link_pwqs(). But I don't think it works for
workqueue_apply_unbound_cpumask() when apply_wqattrs_commit()
is not called.

If we want to reuse the current apply_wqattrs_cleanup(), I would prefer
something like this: (untested)

@@ -3680,15 +3676,21 @@ static void pwq_unbound_release_workfn(struct
work_struct *work)
                                                  unbound_release_work);
        struct workqueue_struct *wq = pwq->wq;
        struct worker_pool *pool = pwq->pool;
-       bool is_last;
+       bool is_last = false;

-       if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
-               return;
+       /*
+        * when @pwq is not linked, it doesn't hold any reference to the
+        * @wq, and @wq is invalid to access.
+        */
+       if (!list_empty(&pwq->pwqs_node)) {
+               if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
+                       return;

-       mutex_lock(&wq->mutex);
-       list_del_rcu(&pwq->pwqs_node);
-       is_last = list_empty(&wq->pwqs);
-       mutex_unlock(&wq->mutex);
+               mutex_lock(&wq->mutex);
+               list_del_rcu(&pwq->pwqs_node);
+               is_last = list_empty(&wq->pwqs);
+               mutex_unlock(&wq->mutex);
+       }

        mutex_lock(&wq_pool_mutex);
        put_unbound_pool(pool);

>
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 104e3ef04e33..0c0ab363edeb 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3693,7 +3693,7 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
>          * If we're the last pwq going away, @wq is already dead and no one
>          * is gonna access it anymore.  Schedule RCU free.
>          */
> -       if (is_last) {
> +       if (is_last && !list_empty(&wq->list)) {
>                 wq_unregister_lockdep(wq);
>                 call_rcu(&wq->rcu, rcu_free_wq);
>         }
> @@ -4199,6 +4199,10 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
>         }
>         put_online_cpus();
>
> +       if (ret) {
> +               flush_scheduled_work();
> +       }
> +
>         return ret;
>  }
>
> --
> tejun
