Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9B1351C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbhDASR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237047AbhDAR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:59:21 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFC2C08EADA;
        Thu,  1 Apr 2021 06:32:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so2138321oto.2;
        Thu, 01 Apr 2021 06:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D15YRcEUCjfq7EWQOO7TKl7m2YFXC98HVx6M41I7s3I=;
        b=WTU3P7XCoIgCm2V9V1l7AGVKxB97sdRdXPK8FC7u/gf9iO2rA4j40yrk36j0JR525D
         NGEPSQtCIDnZX8RBzZZQCdxv6ryoSVyBRaZqliIizPEcN/5dGqMIg5mxd0KzRpunULzF
         fY3Lyqh32sKpmcVGqUlgyy+KYr17qUyRTatmL0SWR6O44TrGBby+HIC6TVb2MYkTPSn1
         DUs/vnEQb6BCNql5OVA9eQQk+H9P8rY1Inyx5Ok+03/3R0X64hqmmDfbnOIe6V2AbLHg
         Owf1kQ7fsxBJQ/SfOy6CNFyA9KdmGQD+hGiv9xQfeVxLU/mbk1bhBqR1niGzn2gtHW0W
         /tqw==
X-Gm-Message-State: AOAM530B7/KxD/aiwwC2X3pkaFRt0ZSVctKcC+RocWvbd8y8uBwxI8qN
        zOTYu9Wm6RxFuqV2+S4s2okB0rYcufPPVBnY2QU=
X-Google-Smtp-Source: ABdhPJzzQ49TNZkbu1Jslr5W0ro3FdLCPHYWklO/x0qvqwljg5dZ9XMMMabbgkgmaz7sXXbjQCW8Sal0tBiVKjZd3eQ=
X-Received: by 2002:a05:6830:55b:: with SMTP id l27mr6299744otb.260.1617283929839;
 Thu, 01 Apr 2021 06:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210401130138.2164928-1-yuyufen@huawei.com>
In-Reply-To: <20210401130138.2164928-1-yuyufen@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 1 Apr 2021 15:31:56 +0200
Message-ID: <CAJZ5v0j1-AA2fWmB0Cr=pr6d+qt_J7Vxr=RPnbvVBfqQYY3KuQ@mail.gmail.com>
Subject: Re: [PATCH] drivers core: don't do anything in device_del() when
 device_add() fail
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 1, 2021 at 2:56 PM Yufen Yu <yuyufen@huawei.com> wrote:
>
> Recently, our syzbot test reported NULL pointer dereference in
> device_del() by injecting memory allocation fail in device_add().
>
> For now, callers of device_add(), such as add_disk(), may ignore
> device_add()'s fail and go on working. In unregister path, it will
> call device_del() from del_gendisk(). That can cause various NULL
> pointer dereference, including dev->p is NULL in kill_device(),
> 'name' is NULL in sysfs_remove_link(), kobj->sd is 'NULL' when call
> dpm_sysfs_remove(), and so on.
>
> To avoid these kernel panic, we call device_del() only when device_add()
> is success.

The patch looks reasonable to me, but the above is not what it does.

It causes device_del() to be a no-op for devices that have not been
successfully added.

> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  drivers/base/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index f29839382f81..a10ec5dbc577 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3380,6 +3380,9 @@ void device_del(struct device *dev)
>         struct class_interface *class_intf;
>         unsigned int noio_flag;
>
> +       if (!dev->p)
> +               return;
> +
>         device_lock(dev);
>         kill_device(dev);
>         device_unlock(dev);
> --
