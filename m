Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A9842CFDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJNB1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229904AbhJNB1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634174716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oe2+e2ZyBa4Rnil+iy4posUTlRQh41TaKCJ4rWYXRrA=;
        b=EEnbb9FC6ATLc7PSS4u7VpnC/6Cl3VCQYBe2TmRC3BfZ+gGljVU0aVokp1xaCu1LoY8MCf
        PHEEAx7Zxxpg7o1s7wp7Ycc5ykPH1h4K04PEua0XbxVrUoq60n0OPkYlybJuxc9FjB9vzG
        WTrRwkbc4QJjDWAsIKq0FR6VS0P9CqQ=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-TaXQfFuqOMW0-FxMJ3x0NQ-1; Wed, 13 Oct 2021 21:25:15 -0400
X-MC-Unique: TaXQfFuqOMW0-FxMJ3x0NQ-1
Received: by mail-yb1-f197.google.com with SMTP id i21-20020a253b15000000b005b9c0fbba45so5224630yba.20
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oe2+e2ZyBa4Rnil+iy4posUTlRQh41TaKCJ4rWYXRrA=;
        b=wKDKXeHkca4gWq2oqQacpc/COxfvLeqidbBD4vf/La5ED69HKn+uqvvTzCU+BTX4Xm
         HE2bHRFYOei67tfr5zpP5m8k6F5hvwcUmGtxes2cBWEoXVnwm8J6KaXY+JMuzL3nKz7D
         R71P7iLwOb9KLJ6XFEmHKka5OrmXs2kWdn5xmO5EQN3I5OTJE1+0yaASX6yIVqJ2zrVW
         anzQq4RrYgY1V26VOiX9Mvf6ej9Bcu9EhgczbWGTx5C+78lix9AzR2LfH+ELLx77bf2m
         MjF4gYUZaU2ol53QSS7HMqCqwBjd8YVVJmDBRPp9O7VzKEZJ1qaTv644SCrlOg0PDTPS
         OrMw==
X-Gm-Message-State: AOAM530cXzuKAQVXtdIyD7tgAETws7Z2NA9+FNbLxNVuEDVzvBxG/xFo
        JdDNU9mFVkyM5eJwELEgM3OunyjHQlyWwvXqvdQNktfrFZ9Z9xlLygqCWLRjicxZEa5Zv7QcEhW
        K8gO2Az/fOGPxXAvbRFa8QYRjA9VDsdG4nTTdkRbF
X-Received: by 2002:a25:496:: with SMTP id 144mr3095591ybe.522.1634174715137;
        Wed, 13 Oct 2021 18:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhy4o4ssfv/yWhLhk2a3KWBDRE5rw6FITQZS+vijVKSeE8TNlCQMZF3TrqoFMLlTlGgxLncIMb4rODHJE6t84=
X-Received: by 2002:a25:496:: with SMTP id 144mr3095570ybe.522.1634174714947;
 Wed, 13 Oct 2021 18:25:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20211013150421uscas1p297a8bd51cf3f3b68dcef3a1c87da2959@uscas1p2.samsung.com>
 <20211013150413.320133-1-a.manzanares@samsung.com>
In-Reply-To: <20211013150413.320133-1-a.manzanares@samsung.com>
From:   Yi Zhang <yi.zhang@redhat.com>
Date:   Thu, 14 Oct 2021 09:25:03 +0800
Message-ID: <CAHj4cs_2Dip8PzoiHoXaHNyicBxWp5uxnfQj_yXLGwwwBMtq=Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: Cleanup per-namespace chardev deletion
To:     Adam Manzanares <a.manzanares@samsung.com>
Cc:     "sagi@grimberg.me" <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verified this patch on top of 5.15.0-rc5.

Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Wed, Oct 13, 2021 at 11:04 PM Adam Manzanares
<a.manzanares@samsung.com> wrote:
>
> Decrease reference count of chardevice during char device deletion in order to
> fix a kmemleak. Add relese function for the device associated chardev and moved
> ida_simple_remove into the release function.
>
> Fixes: 2637bae (nvme: introduce generic per-namespace chardev)
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
> ---
>  drivers/nvme/host/core.c      | 21 ++++++++++++---------
>  drivers/nvme/host/multipath.c |  2 --
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f9a25c61fb8b..3bc4bb620ab7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3583,10 +3583,15 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
>         return 0;
>  }
>
> +static void nvme_cdev_rel(struct device *dev)
> +{
> +       ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
> +}
> +
>  void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
>  {
>         cdev_device_del(cdev, cdev_device);
> -       ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(cdev_device->devt));
> +       put_device(cdev_device);
>  }
>
>  int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
> @@ -3599,14 +3604,14 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
>                 return minor;
>         cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
>         cdev_device->class = nvme_ns_chr_class;
> +       cdev_device->release = nvme_cdev_rel;
>         device_initialize(cdev_device);
>         cdev_init(cdev, fops);
>         cdev->owner = owner;
>         ret = cdev_device_add(cdev, cdev_device);
> -       if (ret) {
> +       if (ret)
>                 put_device(cdev_device);
> -               ida_simple_remove(&nvme_ns_chr_minor_ida, minor);
> -       }
> +
>         return ret;
>  }
>
> @@ -3638,11 +3643,9 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
>                            ns->ctrl->instance, ns->head->instance);
>         if (ret)
>                 return ret;
> -       ret = nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> -                           ns->ctrl->ops->module);
> -       if (ret)
> -               kfree_const(ns->cdev_device.kobj.name);
> -       return ret;
> +
> +       return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
> +                            ns->ctrl->ops->module);
>  }
>
>  static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index fb96e900dd3a..bd490a7c4808 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -434,8 +434,6 @@ static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
>                 return ret;
>         ret = nvme_cdev_add(&head->cdev, &head->cdev_device,
>                             &nvme_ns_head_chr_fops, THIS_MODULE);
> -       if (ret)
> -               kfree_const(head->cdev_device.kobj.name);
>         return ret;
>  }
>
> --
> 2.25.1
>


-- 
Best Regards,
  Yi Zhang

