Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73D3C9A25
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 10:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbhGOILS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 04:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhGOILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 04:11:17 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3494C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:08:23 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id p186so5415514iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAHsLlc57ZvN1lUjUQzrqKpVj/v8UeaYCY1iMesKsSU=;
        b=fLcg9nzMVsedI3cgplQqCEOfJFfcEdjAzVfTGDGklkvWnBk9WhXTpJTu2OfqBcqp3n
         2zP/GLgLbWd3n1DIEQU0kb4TuB5aHzQjhlXRgdXQ7hgNZeyb9EejDKncshDwktONukQX
         /5wKfzIh/v5iHvytIi03GPgFZWxE0yIH5mns9TlEWtKH54G2x4/xcHzhG4/ONaC4RprW
         idiWQuezvPagZGs+IWA3rVZJR1GBgTP06aXNilqnuenOujq1d6T+ih3bqxO5BsvoRw5i
         QCLp0UWqLQIA5lhJKAaX3VfhRr1YDNyTanA4Ya4jlXXNcdM9hTgIWg6BC6YShJZQRuR7
         lByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAHsLlc57ZvN1lUjUQzrqKpVj/v8UeaYCY1iMesKsSU=;
        b=g0mcGMniFx7s2YhmvgFeOSdmON1B0F41jyYrQLuJ/+F3ZtaFnFTl8DwHgtUcl8Fnsq
         DO9KbAH85dFnRu1mI0riwRzQr/yMfL8fSpHC7RGmOdd16my0uJaF+OWiQRgCAyUJVjjF
         mj1kHKXiXfQY2lN178mEgDXEZIJKX+Se34Z5i9n92tFU+/n8wG7JGZLeCy8wy6/44dEK
         Hr8G8c4DwUJt0xw32wvHi25IQonakRk+9GDNyVMHczceJ6/sQWoEZEHQW/Thb+zUWqRu
         njlUthY5Bi9MD7GN4mMuhi9FEof6ZupQEML1rFgz9YezmAeVhb9jwFgWAn1evwGmCskO
         j1Og==
X-Gm-Message-State: AOAM531/dYOulrxT9FqHJn5oreWi2Kv3FMz9d74Yvad6tI/d1DtsC97O
        NJtjPfUDDsCC0mOR4WVJG0zVOGTzZnXCKTTGFJg=
X-Google-Smtp-Source: ABdhPJzrMWEBioe9KYUTARgzUCYon0lQvfl7RSPuu2tUgqbj4Ix/B2PfQIUX8O5hyoWfgZptxcqHiCIuQW9LAkkYJDI=
X-Received: by 2002:a6b:f81a:: with SMTP id o26mr2249307ioh.56.1626336503190;
 Thu, 15 Jul 2021 01:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210714091934.3124170-1-yangyingliang@huawei.com>
In-Reply-To: <20210714091934.3124170-1-yangyingliang@huawei.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 15 Jul 2021 16:08:12 +0800
Message-ID: <CAJhGHyA+8p7mHR4o2VoAFTxKKtAC4Aeq1cwtszaVj-OS63KUgA@mail.gmail.com>
Subject: Re: [PATCH v3] workqueue: fix UAF in pwq_unbound_release_workfn()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Xu Qiang <xuqiang36@huawei.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 5:16 PM Yang Yingliang <yangyingliang@huawei.com> wrote:

>
> Fixes: 2d5f0764b526 ("workqueue: split apply_workqueue_attrs() into 3 stages")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v3:
>   drop the v2 and v1 changes, add check pwq in pwq_unbound_release_workfn()
> v2:
>   also use free_wqattrs_ctx() in workqueue_apply_unbound_cpumask()
> ---
>  kernel/workqueue.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>

I'm fine with the code.

Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

Hello, Pavel

Could you have a test again, please?

Thanks,
Lai

> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 50142fc08902..f148eacda55a 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -3676,15 +3676,21 @@ static void pwq_unbound_release_workfn(struct work_struct *work)
>                                                   unbound_release_work);
>         struct workqueue_struct *wq = pwq->wq;
>         struct worker_pool *pool = pwq->pool;
> -       bool is_last;
> +       bool is_last = false;
>
> -       if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> -               return;
> +       /*
> +        * when @pwq is not linked, it doesn't hold any reference to the
> +        * @wq, and @wq is invalid to access.
> +        */
> +       if (!list_empty(&pwq->pwqs_node)) {
> +               if (WARN_ON_ONCE(!(wq->flags & WQ_UNBOUND)))
> +                       return;
>
> -       mutex_lock(&wq->mutex);
> -       list_del_rcu(&pwq->pwqs_node);
> -       is_last = list_empty(&wq->pwqs);
> -       mutex_unlock(&wq->mutex);
> +               mutex_lock(&wq->mutex);
> +               list_del_rcu(&pwq->pwqs_node);
> +               is_last = list_empty(&wq->pwqs);
> +               mutex_unlock(&wq->mutex);
> +       }
>
>         mutex_lock(&wq_pool_mutex);
>         put_unbound_pool(pool);
> --
> 2.25.1
>
