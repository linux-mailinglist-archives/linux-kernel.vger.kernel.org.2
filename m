Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30C532BCA5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243419AbhCCO1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842955AbhCCKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:59 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3EFC0698D8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:21:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id n195so23773411ybg.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cb0CPh6MQvHb78KliABlu/smpYzuaZLhWVWV2xEzvyI=;
        b=lk7+J3MigtqLzHlTuJoPU1mUP8yjLKsUZgG8+B9TQsSkqNjkkjRSATenfjDbeYDYU7
         48lFm6OEUGXxyZhOtvvL51FRECK3U87sk69eNK2+oPWr5uiPfIHYnnkZxUHCyjuh4a3B
         9/mC0tThOMj/0v8XMHkn3b91QXx5TDv9cRNd6l9kyO5XMT8gojmVSzvDoArqb3n0V9EG
         QR7UdjuWvt4RCKWWhvaJcZSqN5ghjo23mZUEOESmFBPWDqc2hSvCyPpeVXWKV//Pfqsg
         DME7J0x8zMfJouGLRiTse+NwSwl5texR1VYPADa4/FDh6jXe3WnxchLVQmFA6z+A81bk
         9I2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cb0CPh6MQvHb78KliABlu/smpYzuaZLhWVWV2xEzvyI=;
        b=bTR6iu+bndKPeuGFnPAxMfxNxH0d7FmInDaTNeJLnvEzRH6M+U6+zuOsgDY8pRhyWt
         EiXtO323T+g0bZSmB3HLjZIb+SbTD8takxybJVidxLwdVGZRn8zu3LQ3qjT2vednpFDi
         DENx7OBHoYT0LYMoJCeO8vkRcfo6E9g46YHTbmVPOPSDm8JE5qzhqleLtHAY/qhaerYV
         8ItR5ZFgBtBFoSjtGxD+Sys7uawMJqrd6sWEV84nL+amIy1kziPr2O9ue8AYV3JLk1UM
         2rKwx/l29EPMXypIttJi60gBsoM5IZtbs0f+lR8wF7Tgbuk5X/xbOUAsY0NgZu9YZKBf
         E4MA==
X-Gm-Message-State: AOAM531LVtNQiP9GSFHOx2LlnxAGm+deNhqx2jSZUUIe/qnhhjQhygHI
        pAHx8tEYTGULWYHxDWtSzS7mDSiVooByjdHwewxZjQ==
X-Google-Smtp-Source: ABdhPJwhn7nLcQpjtaM8JLG6kJhREbyQfF02PudXsMtNjbo0c0jNmilSmiA5WJWjJYQfQc/GcCEDqLti1Vt3iWT26Vs=
X-Received: by 2002:a25:86d2:: with SMTP id y18mr37073408ybm.466.1614763295636;
 Wed, 03 Mar 2021 01:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20210303083215.3257304-1-saravanak@google.com>
In-Reply-To: <20210303083215.3257304-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Mar 2021 01:20:59 -0800
Message-ID: <CAGETcx8rnzEiURC39Eoc7HZ7YATikpNmF8b+n19kDwPthmj++g@mail.gmail.com>
Subject: Re: [PATCH v1] RFC: amba: Remove amba specific deferred probe handling
To:     Russell King <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 12:32 AM Saravana Kannan <saravanak@google.com> wrote:
>
> The addition/probe of amba devices has its own weird deferred probe
> mechanism that needs to be maintained separately. It doesn't
> automatically get any bugs fixes or improvements to the common deferred
> probe mechanism.
>
> It also has an arbitrary 5 second periodic attempt. So, even if the
> resources are available, there can be an arbitrary delay before amba
> devices are probed.
>
> This patch used a proxy/stub device so that amba devices can hook into
> the common deferred probe mechanism. This also means amba devices get
> probed as soon as their resources are available.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>
> We talked about this almost a year ago[1] and it has been nagging me all
> this time. So, finally got around to giving it a shot. This actually
> seems to work -- I tested it on a device that was lying around.

Btw, what really is the requirement wrt the uevents? Will this whole
thing work if I figure out a way to do this:

1. Add an amba device without the AMBA_ID and MODALIAS uevent vars and
without periphid set.
2. Once the resources (clocks, etc) are available, set periphid and
add those uevents.
3. Trigger a normal deferred probe attempt.

Will userspace properly load the right driver and will things work if
there is a couple of seconds of (theoretical) delay between (1) and
(2)? If so, that might be pretty easy to do without a stub device too.

-Saravana

>
> Thoughts?
>
> [1] - https://lore.kernel.org/linux-arm-kernel/CAGETcx8Cn-b6L2y10LKb91S3n06b6+Be2z_A0402EyNy-8yECg@mail.gmail.com/
>
> -Saravana
>
>  drivers/amba/bus.c       | 116 ++++++++++++++++++---------------------
>  include/linux/amba/bus.h |   1 +
>  2 files changed, 53 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 939ca220bf78..393d189b6bca 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -24,6 +24,9 @@
>
>  #define to_amba_driver(d)      container_of(d, struct amba_driver, drv)
>
> +static int amba_proxy_probe(struct amba_device *adev,
> +                           const struct amba_id *id);
> +
>  /* called on periphid match and class 0x9 coresight device. */
>  static int
>  amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
> @@ -46,6 +49,8 @@ amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
>  static const struct amba_id *
>  amba_lookup(const struct amba_id *table, struct amba_device *dev)
>  {
> +       if (!table)
> +               return NULL;
>         while (table->mask) {
>                 if (((dev->periphid & table->mask) == table->id) &&
>                         ((dev->cid != CORESIGHT_CID) ||
> @@ -185,6 +190,9 @@ static int amba_probe(struct device *dev)
>         const struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
>         int ret;
>
> +       if (!pcdev->periphid)
> +               return pcdrv->probe(pcdev, 0);
> +
>         do {
>                 ret = of_clk_set_defaults(dev->of_node, false);
>                 if (ret < 0)
> @@ -224,6 +232,9 @@ static int amba_remove(struct device *dev)
>         struct amba_device *pcdev = to_amba_device(dev);
>         struct amba_driver *drv = to_amba_driver(dev->driver);
>
> +       if (!pcdev->periphid)
> +               return 0;
> +
>         pm_runtime_get_sync(dev);
>         if (drv->remove)
>                 drv->remove(pcdev);
> @@ -325,9 +336,20 @@ struct bus_type amba_bustype = {
>  };
>  EXPORT_SYMBOL_GPL(amba_bustype);
>
> +static struct amba_driver amba_proxy_drv = {
> +       .drv = {
> +               .name = "amba-proxy",
> +       },
> +       .probe = amba_proxy_probe,
> +};
> +
>  static int __init amba_init(void)
>  {
> -       return bus_register(&amba_bustype);
> +       int ret = bus_register(&amba_bustype);
> +
> +       if (ret)
> +               return ret;
> +       return amba_driver_register(&amba_proxy_drv);
>  }
>
>  postcore_initcall(amba_init);
> @@ -490,58 +512,19 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>         goto err_release;
>  }
>
> -/*
> - * Registration of AMBA device require reading its pid and cid registers.
> - * To do this, the device must be turned on (if it is a part of power domain)
> - * and have clocks enabled. However in some cases those resources might not be
> - * yet available. Returning EPROBE_DEFER is not a solution in such case,
> - * because callers don't handle this special error code. Instead such devices
> - * are added to the special list and their registration is retried from
> - * periodic worker, until all resources are available and registration succeeds.
> - */
> -struct deferred_device {
> -       struct amba_device *dev;
> -       struct resource *parent;
> -       struct list_head node;
> -};
> -
> -static LIST_HEAD(deferred_devices);
> -static DEFINE_MUTEX(deferred_devices_lock);
> -
> -static void amba_deferred_retry_func(struct work_struct *dummy);
> -static DECLARE_DELAYED_WORK(deferred_retry_work, amba_deferred_retry_func);
> -
> -#define DEFERRED_DEVICE_TIMEOUT (msecs_to_jiffies(5 * 1000))
> -
> -static int amba_deferred_retry(void)
> +static int amba_proxy_probe(struct amba_device *adev,
> +                           const struct amba_id *id)
>  {
> -       struct deferred_device *ddev, *tmp;
> -
> -       mutex_lock(&deferred_devices_lock);
> -
> -       list_for_each_entry_safe(ddev, tmp, &deferred_devices, node) {
> -               int ret = amba_device_try_add(ddev->dev, ddev->parent);
> -
> -               if (ret == -EPROBE_DEFER)
> -                       continue;
> -
> -               list_del_init(&ddev->node);
> -               kfree(ddev);
> -       }
> -
> -       mutex_unlock(&deferred_devices_lock);
> +       int ret;
>
> -       return 0;
> -}
> -late_initcall(amba_deferred_retry);
> +       if (!adev->other_dev)
> +               return -ENODEV;
>
> -static void amba_deferred_retry_func(struct work_struct *dummy)
> -{
> -       amba_deferred_retry();
> +       ret = amba_device_try_add(adev->other_dev, adev->dev.platform_data);
> +       if (ret != -EPROBE_DEFER)
> +               adev->other_dev = NULL;
>
> -       if (!list_empty(&deferred_devices))
> -               schedule_delayed_work(&deferred_retry_work,
> -                                     DEFERRED_DEVICE_TIMEOUT);
> +       return ret;
>  }
>
>  /**
> @@ -557,25 +540,30 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
>  {
>         int ret = amba_device_try_add(dev, parent);
>
> +       /*
> +        * Registration of AMBA device require reading its pid and cid
> +        * registers.  To do this, the device must be turned on (if it is a
> +        * part of power domain) and have clocks enabled. However in some cases
> +        * those resources might not be yet available. Returning EPROBE_DEFER
> +        * is not a solution in such case, because callers don't handle this
> +        * special error code. Instead, create a dummy proxy device that'll
> +        * keep deferring probe until all the resources are available and then
> +        * add the real device.
> +        */
>         if (ret == -EPROBE_DEFER) {
> -               struct deferred_device *ddev;
> +               struct amba_device *proxy_dev;
>
> -               ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
> -               if (!ddev)
> +               proxy_dev = amba_device_alloc(NULL, 0, 0);
> +               if (!proxy_dev)
>                         return -ENOMEM;
>
> -               ddev->dev = dev;
> -               ddev->parent = parent;
> -               ret = 0;
> -
> -               mutex_lock(&deferred_devices_lock);
> -
> -               if (list_empty(&deferred_devices))
> -                       schedule_delayed_work(&deferred_retry_work,
> -                                             DEFERRED_DEVICE_TIMEOUT);
> -               list_add_tail(&ddev->node, &deferred_devices);
> -
> -               mutex_unlock(&deferred_devices_lock);
> +               proxy_dev->other_dev = dev;
> +               proxy_dev->dev.platform_data = parent;
> +               proxy_dev->driver_override = "amba-proxy";
> +               dev_set_name(&proxy_dev->dev, "proxy:%s", dev_name(&dev->dev));
> +               ret = device_add(&proxy_dev->dev);
> +               if (ret)
> +                       put_device(&proxy_dev->dev);
>         }
>         return ret;
>  }
> diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
> index 6cc93ab5b809..432b32cf8fcc 100644
> --- a/include/linux/amba/bus.h
> +++ b/include/linux/amba/bus.h
> @@ -71,6 +71,7 @@ struct amba_device {
>         struct amba_cs_uci_id   uci;
>         unsigned int            irq[AMBA_NR_IRQS];
>         char                    *driver_override;
> +       struct amba_device      *other_dev;
>  };
>
>  struct amba_driver {
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
