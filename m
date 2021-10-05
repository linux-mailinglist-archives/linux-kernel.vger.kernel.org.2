Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9624224D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhJELUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 07:20:07 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37455 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJELUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 07:20:06 -0400
Received: by mail-ot1-f50.google.com with SMTP id r43-20020a05683044ab00b0054716b40005so25375835otv.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 04:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDmU0VgBA9vOzJ9RSmX1fbVOE1mv6Y0iue/bMC74Urs=;
        b=WJZ/GU+smu4dvgIgYp5MRehFUFpuDSggEGvTPpdy0O0goLMuen0Aj9shj+ngLniuN6
         9qppTEj/iW3komADw6HWtDPpTUqQVTePA0OgluzEW4Qp3W88BMvVYidhZJf0xH3nzjad
         V4GmjXldbmnBLj7PD5j2TXSoNoPOzfBe3xdAPDcz2BL1AuL1Hlebv6PAdZG43mEqNYSg
         3uPPn0wxcwyeZsyr2qnEFfE94YS62SBOufq7AY2V9FKG9+FP/l6oIvGWTSC1CHKb8L1m
         3RcD4lU04aB674jzn9WBTLg3Ow5P5h3XhOdMku8vmzAlCldAJazK3DfXVx9xQ5uFbKrW
         hsRw==
X-Gm-Message-State: AOAM532oABS56GsXhGwwfmnfRz6FOKQZbvgBiQSaj4PXL95YvWfqDEhB
        fs+81/Nsb0q/T18yie5BSxz+3AdhfwCweHcnxDgQQFkA
X-Google-Smtp-Source: ABdhPJz7PCntfDMd9boPlYXoBVWeGh5ELMLfEfs7qyDGV2HcVHpZYQPAGFt1AeTF0eHhYncVvsuBvQrLZo9ArVbpJqI=
X-Received: by 2002:a05:6830:2784:: with SMTP id x4mr13878832otu.86.1633432695908;
 Tue, 05 Oct 2021 04:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210930085714.2057460-1-yangyingliang@huawei.com>
In-Reply-To: <20210930085714.2057460-1-yangyingliang@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 13:17:59 +0200
Message-ID: <CAJZ5v0hYrU+wRLPE_BaAL_RyVxJDdFjKJUb+tZqBTWaQNet22A@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix possible memory leak in device_link_add()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:52 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> I got memory leak as follows:
>
> unreferenced object 0xffff88801f0b2200 (size 64):
>   comm "i2c-lis2hh12-21", pid 5455, jiffies 4294944606 (age 15.224s)
>   hex dump (first 32 bytes):
>     72 65 67 75 6c 61 74 6f 72 3a 72 65 67 75 6c 61  regulator:regula
>     74 6f 72 2e 30 2d 2d 69 32 63 3a 31 2d 30 30 31  tor.0--i2c:1-001
>   backtrace:
>     [<00000000bf5b0c3b>] __kmalloc_track_caller+0x19f/0x3a0
>     [<0000000050da42d9>] kvasprintf+0xb5/0x150
>     [<000000004bbbed13>] kvasprintf_const+0x60/0x190
>     [<00000000cdac7480>] kobject_set_name_vargs+0x56/0x150
>     [<00000000bf83f8e8>] dev_set_name+0xc0/0x100
>     [<00000000cc1cf7e3>] device_link_add+0x6b4/0x17c0
>     [<000000009db9faed>] _regulator_get+0x297/0x680
>     [<00000000845e7f2b>] _devm_regulator_get+0x5b/0xe0
>     [<000000003958ee25>] st_sensors_power_enable+0x71/0x1b0 [st_sensors]
>     [<000000005f450f52>] st_accel_i2c_probe+0xd9/0x150 [st_accel_i2c]
>     [<00000000b5f2ab33>] i2c_device_probe+0x4d8/0xbe0
>     [<0000000070fb977b>] really_probe+0x299/0xc30
>     [<0000000088e226ce>] __driver_probe_device+0x357/0x500
>     [<00000000c21dda32>] driver_probe_device+0x4e/0x140
>     [<000000004e650441>] __device_attach_driver+0x257/0x340
>     [<00000000cf1891b8>] bus_for_each_drv+0x166/0x1e0
>
> When device_register() returns an error, the name allocated in dev_set_name()
> will be leaked, the put_device() should be used instead of kfree() to give up
> the device reference, then the name will be freed in kobject_cleanup() and the
> references of consumer and supplier will be decreased in device_link_release_fn().
>
> Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e65dd803a453..4a123e58711f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -809,9 +809,7 @@ struct device_link *device_link_add(struct device *consumer,
>                      dev_bus_name(supplier), dev_name(supplier),
>                      dev_bus_name(consumer), dev_name(consumer));
>         if (device_register(&link->link_dev)) {
> -               put_device(consumer);
> -               put_device(supplier);
> -               kfree(link);
> +               put_device(&link->link_dev);
>                 link = NULL;
>                 goto out;
>         }
> --
> 2.25.1
>
