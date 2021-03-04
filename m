Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4365A32CB33
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 05:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhCDEKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 23:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhCDEKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 23:10:02 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B07DC061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 20:09:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u75so27022202ybi.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 20:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ub14bFhM7OB/2oBNrdSwzfGLsNJGvdrEXstpiuoOqcM=;
        b=BsZ9h2ywGkHZ1Pi+yEr6tHP0e1gWBTAv2lss4LSXr5Ql1W4zGkBgNYqYOPqxexLgB+
         e94q8eK7CJCR4MJyy/A8AtJu+/Cbq1ao9SXIM+LfMQli4UECdo0n1ea1Uoqr9oVcybVr
         HY6GcWMjUPl0SdjFi4kwtWFHCJ6OGmnvGixoGVzt6zETYHRFhZgEhhZYXUnFbIB+2088
         97CphjtrE2fOm/gUeduiCRCBunPTPaQQmfY52G6HDXHL91jlq+MBwoPFh3EcmK4qsYFd
         tjDAM2A8CbSP8OCzQQzxcKUCGVMvVhuqOqBdw4b6l2r3EPRsOflOhToKqKTnNzXgltYI
         eJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ub14bFhM7OB/2oBNrdSwzfGLsNJGvdrEXstpiuoOqcM=;
        b=DAhtpmsMZKRkQlO+ijj809rUpvBI/RD1CQh6AtkG3YYs3P3qye67PAYU+o0mKA6Xsz
         YyOXA4GvxokLk1c+7FxLqwJwFKzmFIw70rLotMQanJSha3r6LBNNrcKEhK6QL5hQdr83
         aEz63295cfQT/02+WHjiAF176pAraCIUCD2iqx1PihwO/UFsn8tUUxhDfTqqn0tIpdtS
         R3WNEZ8jlLO86d6dYrST109UFnxAAS/Emv0xWod2EVQnN196u2d9m0LJREBrC7LAj4bH
         3zJVWvduQt95psz5oCMZF1dpyC1ple6+JpjCJqLNiWpJqaouZk9jG0iq7YJ8tpH3Dg/e
         t0Zg==
X-Gm-Message-State: AOAM532ipKWgIBBE5+oMUVhtaV9K77tc2/lTkP2dHpDagjR6Qj7NIyVb
        JQ/o9LVPVA0FPsaVZ6uGwut1668xwtobqPf2YlbPtg==
X-Google-Smtp-Source: ABdhPJzgO+izY4xbZJl9GOjGWiJ+rECG9ag6AZZSHFUwSrTEJ8C/WyHbNaxnYNctwhwFpWAbJFOe2QsY7NbaZJMkGdE=
X-Received: by 2002:a25:ca8f:: with SMTP id a137mr3684760ybg.228.1614830961087;
 Wed, 03 Mar 2021 20:09:21 -0800 (PST)
MIME-Version: 1.0
References: <20210304035958.3657121-1-saravanak@google.com>
In-Reply-To: <20210304035958.3657121-1-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Mar 2021 20:08:44 -0800
Message-ID: <CAGETcx8KQ7cm7irv-vsBzqYfZqSMz4c3_hD_V55gxjVM1vd=PA@mail.gmail.com>
Subject: Re: [PATCH v2] amba: Remove deferred device addition
To:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 8:00 PM Saravana Kannan <saravanak@google.com> wrote:
>
> The uevents generated for an amba device need PID and CID information
> that's available only when the amba device is powered on, clocked and
> out of reset. So, if those resources aren't available, the information
> can't be read to generate the uevents. To workaround this requirement,
> if the resources weren't available, the device addition was deferred and
> retried periodically.
>
> However, this deferred addition retry isn't based on resources becoming
> available. Instead, it's retried every 5 seconds and causes arbitrary
> probe delays for amba devices and their consumers.
>
> Also, maintaining a separate deferred-probe like mechanism is
> maintenance headache.
>
> With this commit, instead of deferring the device addition, we simply
> defer the generation of uevents for the device and probing of the device
> (because drivers needs PID and CID to match) until the PID and CID
> information can be read. This allows us to delete all the amba specific
> deferring code and also avoid the arbitrary probing delays.
>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/amba/bus.c | 293 ++++++++++++++++++---------------------------
>  1 file changed, 115 insertions(+), 178 deletions(-)
>
> diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> index 939ca220bf78..fac4110b2f58 100644
> --- a/drivers/amba/bus.c
> +++ b/drivers/amba/bus.c
> @@ -149,11 +149,101 @@ static struct attribute *amba_dev_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(amba_dev);
>
> +static int amba_read_periphid(struct amba_device *dev)
> +{
> +       u32 size;
> +       void __iomem *tmp;
> +       u32 pid, cid;
> +       struct reset_control *rstc;
> +       int i, ret;
> +
> +       /*
> +        * Dynamically calculate the size of the resource
> +        * and use this for iomap
> +        */
> +       size = resource_size(&dev->res);
> +       tmp = ioremap(dev->res.start, size);
> +       if (!tmp)
> +               return -ENOMEM;
> +
> +       ret = dev_pm_domain_attach(&dev->dev, true);
> +       if (ret)
> +               goto err_pm;
> +
> +       ret = amba_get_enable_pclk(dev);
> +       if (ret)
> +               goto err_clk;
> +
> +       /*
> +        * Find reset control(s) of the amba bus and de-assert them.
> +        */
> +       rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
> +       if (IS_ERR(rstc)) {
> +               ret = PTR_ERR(rstc);
> +               if (ret != -EPROBE_DEFER)
> +                       dev_err(&dev->dev, "can't get reset: %d\n",
> +                               ret);
> +               goto err_reset;
> +       }
> +       reset_control_deassert(rstc);
> +       reset_control_put(rstc);
> +
> +       /*
> +        * Read pid and cid based on size of resource
> +        * they are located at end of region
> +        */
> +       for (pid = 0, i = 0; i < 4; i++)
> +               pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
> +                       (i * 8);
> +       for (cid = 0, i = 0; i < 4; i++)
> +               cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
> +                       (i * 8);
> +
> +       if (cid == CORESIGHT_CID) {
> +               /* set the base to the start of the last 4k block */
> +               void __iomem *csbase = tmp + size - 4096;
> +
> +               dev->uci.devarch =
> +                       readl(csbase + UCI_REG_DEVARCH_OFFSET);
> +               dev->uci.devtype =
> +                       readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
> +       }
> +
> +       amba_put_disable_pclk(dev);
> +
> +       if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> +               dev->periphid = pid;
> +               dev->cid = cid;
> +       }
> +
> +       if (!dev->periphid)
> +               ret = -ENODEV;
> +
> +       return ret;
> +
> +err_reset:
> +       amba_put_disable_pclk(dev);
> +err_clk:
> +       dev_pm_domain_detach(&dev->dev, true);
> +err_pm:
> +       iounmap(tmp);
> +       return ret;
> +}
> +
>  static int amba_match(struct device *dev, struct device_driver *drv)
>  {
>         struct amba_device *pcdev = to_amba_device(dev);
>         struct amba_driver *pcdrv = to_amba_driver(drv);
>
> +       if (!pcdev->periphid) {
> +               int ret = amba_read_periphid(pcdev);
> +
> +               if (ret)
> +                       return ret;
> +               dev_set_uevent_suppress(dev, false);
> +               kobject_uevent(&dev->kobj, KOBJ_ADD);

Greg,

This is the only "ugly" part of this patch. I hope this is not a
problem as this patch finally gets amba devices to behave normally and
deletes about 60 lines of code.

Marek,

I tested it and saw the device get added before the resources were
available and the uevent file looked okay. Would you mind testing it
further?

Thanks,
Saravana

> +       }
> +
>         /* When driver_override is set, only bind to the matching driver */
>         if (pcdev->driver_override)
>                 return !strcmp(pcdev->driver_override, drv->name);
> @@ -373,98 +463,43 @@ static void amba_device_release(struct device *dev)
>         kfree(d);
>  }
>
> -static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
> +/**
> + *     amba_device_add - add a previously allocated AMBA device structure
> + *     @dev: AMBA device allocated by amba_device_alloc
> + *     @parent: resource parent for this devices resources
> + *
> + *     Claim the resource, and read the device cell ID if not already
> + *     initialized.  Register the AMBA device with the Linux device
> + *     manager.
> + */
> +int amba_device_add(struct amba_device *dev, struct resource *parent)
>  {
> -       u32 size;
> -       void __iomem *tmp;
> -       int i, ret;
> +       int ret;
>
>         WARN_ON(dev->irq[0] == (unsigned int)-1);
>         WARN_ON(dev->irq[1] == (unsigned int)-1);
>
>         ret = request_resource(parent, &dev->res);
>         if (ret)
> -               goto err_out;
> -
> -       /* Hard-coded primecell ID instead of plug-n-play */
> -       if (dev->periphid != 0)
> -               goto skip_probe;
> -
> -       /*
> -        * Dynamically calculate the size of the resource
> -        * and use this for iomap
> -        */
> -       size = resource_size(&dev->res);
> -       tmp = ioremap(dev->res.start, size);
> -       if (!tmp) {
> -               ret = -ENOMEM;
> -               goto err_release;
> -       }
> -
> -       ret = dev_pm_domain_attach(&dev->dev, true);
> -       if (ret) {
> -               iounmap(tmp);
> -               goto err_release;
> -       }
> -
> -       ret = amba_get_enable_pclk(dev);
> -       if (ret == 0) {
> -               u32 pid, cid;
> -               struct reset_control *rstc;
> -
> -               /*
> -                * Find reset control(s) of the amba bus and de-assert them.
> -                */
> -               rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
> -               if (IS_ERR(rstc)) {
> -                       ret = PTR_ERR(rstc);
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(&dev->dev, "can't get reset: %d\n",
> -                                       ret);
> -                       goto err_reset;
> -               }
> -               reset_control_deassert(rstc);
> -               reset_control_put(rstc);
> +               return ret;
>
> +       /* If primecell ID isn't hard-coded, figure it out */
> +       if (dev->periphid) {
> +               ret = amba_read_periphid(dev);
> +               if (ret && ret != -EPROBE_DEFER)
> +                       goto err_release;
>                 /*
> -                * Read pid and cid based on size of resource
> -                * they are located at end of region
> +                * AMBA device uevents require reading its pid and cid
> +                * registers.  To do this, the device must be on, clocked and
> +                * out of reset.  However in some cases those resources might
> +                * not yet be available.  If that's the case, we suppress the
> +                * generation of uevents until we can read the pid and cid
> +                * registers.  See also amba_match().
>                  */
> -               for (pid = 0, i = 0; i < 4; i++)
> -                       pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) <<
> -                               (i * 8);
> -               for (cid = 0, i = 0; i < 4; i++)
> -                       cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
> -                               (i * 8);
> -
> -               if (cid == CORESIGHT_CID) {
> -                       /* set the base to the start of the last 4k block */
> -                       void __iomem *csbase = tmp + size - 4096;
> -
> -                       dev->uci.devarch =
> -                               readl(csbase + UCI_REG_DEVARCH_OFFSET);
> -                       dev->uci.devtype =
> -                               readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
> -               }
> -
> -               amba_put_disable_pclk(dev);
> -
> -               if (cid == AMBA_CID || cid == CORESIGHT_CID) {
> -                       dev->periphid = pid;
> -                       dev->cid = cid;
> -               }
> -
> -               if (!dev->periphid)
> -                       ret = -ENODEV;
> +               if (ret)
> +                       dev_set_uevent_suppress(&dev->dev, true);
>         }
>
> -       iounmap(tmp);
> -       dev_pm_domain_detach(&dev->dev, true);
> -
> -       if (ret)
> -               goto err_release;
> -
> - skip_probe:
>         ret = device_add(&dev->dev);
>         if (ret)
>                 goto err_release;
> @@ -477,106 +512,8 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
>                 return ret;
>
>         device_unregister(&dev->dev);
> -
>   err_release:
>         release_resource(&dev->res);
> - err_out:
> -       return ret;
> -
> - err_reset:
> -       amba_put_disable_pclk(dev);
> -       iounmap(tmp);
> -       dev_pm_domain_detach(&dev->dev, true);
> -       goto err_release;
> -}
> -
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
> -{
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
> -
> -       return 0;
> -}
> -late_initcall(amba_deferred_retry);
> -
> -static void amba_deferred_retry_func(struct work_struct *dummy)
> -{
> -       amba_deferred_retry();
> -
> -       if (!list_empty(&deferred_devices))
> -               schedule_delayed_work(&deferred_retry_work,
> -                                     DEFERRED_DEVICE_TIMEOUT);
> -}
> -
> -/**
> - *     amba_device_add - add a previously allocated AMBA device structure
> - *     @dev: AMBA device allocated by amba_device_alloc
> - *     @parent: resource parent for this devices resources
> - *
> - *     Claim the resource, and read the device cell ID if not already
> - *     initialized.  Register the AMBA device with the Linux device
> - *     manager.
> - */
> -int amba_device_add(struct amba_device *dev, struct resource *parent)
> -{
> -       int ret = amba_device_try_add(dev, parent);
> -
> -       if (ret == -EPROBE_DEFER) {
> -               struct deferred_device *ddev;
> -
> -               ddev = kmalloc(sizeof(*ddev), GFP_KERNEL);
> -               if (!ddev)
> -                       return -ENOMEM;
> -
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
> -       }
>         return ret;
>  }
>  EXPORT_SYMBOL_GPL(amba_device_add);
> --
> 2.30.1.766.gb4fecdf3b7-goog
>
