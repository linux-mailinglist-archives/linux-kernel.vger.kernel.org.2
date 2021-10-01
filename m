Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AAA41F67B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355544AbhJAUuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355537AbhJAUuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:50:06 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30093C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:48:21 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g6so6029131ybb.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3sCpjKGQkaEMg1uSoIVvCfGHALm/i1fzSFSvlQulsY0=;
        b=bukPY1QYNVX0sBxqjZ3JHjE2pidCTzXDeMncGdjBiIkwzzNSFVZ8jz6mW4YshfI5Hg
         PL9IqHZ0x8yqqYYTSWw9tN6EXKxC2kdSS31CT966jDxFg49smBN7jILOIhoILJK6WmHw
         8nc33JxCTExGn2mhQCNGdQ5J4nU7YRdUgeH/IVrsaaIR043NkOyYj9fMoI/sqJuJNmEw
         z5y4DOr5ei2eRdxbova84nmELAUzG3HdlzCkpHigdH6EZtyvSTJDPN3YORaN7cQ2lWL2
         MEn+wfQEA/tEKYShSX9nbz/j3+XIN9XvdMyOkrONg/vQbYxlmslQsQVmdOL+v5nVM8EN
         GBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3sCpjKGQkaEMg1uSoIVvCfGHALm/i1fzSFSvlQulsY0=;
        b=c9SQO/vcUK3KukLoOzemLLY3fi7FRBOASQDo213pCF7E1VmsMiO61sjzTTFtksgQhL
         fdEADxUmnJ53eOtdAdpfbjjDG7L6yICE4Y88x3FAnk76ZMWmeTScaoXs3Ka+nNDMb95g
         19ndlb29rRMcOlwB6MUxk1UrG+u/M4lYe9N1VWWjCTy348hMNvsRsr2nF8XiFZmtU0XA
         2Mm4RDcRJrAxmj2985fM22c/yGu+x7WAscrVGh+/BqL8h4RsVMTeCD62PNbeiHT0UiaB
         HN02LxLTb4M2kCvg8zAtUbEffZRhIZaGM+syx2/+y7+bxCtjV1VtvBsNec5Xahs8Dhhv
         0SJQ==
X-Gm-Message-State: AOAM532Kw5Y+0WbgSmm5OHjw2Ant5y9llZvfEKsuC4nNU1f7emf5SvjT
        0gN9jQX9TZ9A4+tVKZTtrXFyxUye2V0xvURvTAAwbZIZ65nG2Q==
X-Google-Smtp-Source: ABdhPJxZDfAQALE870igQE1UXi2L5Dx5bbmDkHdR8SdZzduO5C0oT52BMvp2xo81r7Afd6bPJ2JdvVgL1LpCMFrD2EY=
X-Received: by 2002:a25:2610:: with SMTP id m16mr8051322ybm.508.1633121300223;
 Fri, 01 Oct 2021 13:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210930085714.2057460-1-yangyingliang@huawei.com>
In-Reply-To: <20210930085714.2057460-1-yangyingliang@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 1 Oct 2021 13:47:44 -0700
Message-ID: <CAGETcx_5bheQH_702zNawkHKW=5_aAmFckck0D6HfuHFY2oo9g@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix possible memory leak in device_link_add()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 1:52 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
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

Thanks for the fix!

Reviewed-by: Saravana Kannan <saravanak@google.com>

Btw, can you also let us know why the device_register() is failing? It
really shouldn't be failing.

-Saravana
