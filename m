Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4073C31EF21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhBRTAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:00:47 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44694 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbhBRRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:19:25 -0500
Received: by mail-oi1-f172.google.com with SMTP id r75so2738841oie.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T24WpJH5lkaYN9mFqUukSnEjH7aHwERP905dAXP1ng4=;
        b=DmdtIAyffkb6YdYQMvoD/FjuxI43k0tj69c0BPEwAVAWfNkZsOEGFiB8FNlTxKPlIQ
         70mxc4yRbLVmEkfl546eHmoNPuVFKOa4NsA46pWo/2o4VMO/4z85JcoRukd8S1HE48dr
         DioyqVzdPUBZoXy13BWAzhCv54H2Czg7VxaidenLDBVuJPMbOL1+KWOTkuXvG1tC0u4e
         GfoYSxJkgOvqTlzfa0rQfWn4MonqKOln1r3pceiP1rMn/HrrfSRGaQswtcQSAQgjP0l3
         5DxSTix4rJYoKBFDr6zX7EYtrplEG1Sus2Ggy1YyE+mcvZXjk4x4+z5lkFuhflzNcJz5
         nGGA==
X-Gm-Message-State: AOAM532EfBo/J8MI3p48jZB0Ea71iLlnMUNLGEZzzrtECwWsozw8zVNs
        c5xGLRRbGyRxJ67dXVRkLUa5BdAHid3FU8lG5t93TW+1
X-Google-Smtp-Source: ABdhPJylgc8LV+xBcWPI2t/0nto6O4JdYrt5ohA8WpxJHFqcR0mKM8FvZzkD76RiKdx5sENqchyJ41EX7UpJFLZHvss=
X-Received: by 2002:a54:400b:: with SMTP id x11mr3521747oie.71.1613668718881;
 Thu, 18 Feb 2021 09:18:38 -0800 (PST)
MIME-Version: 1.0
References: <20210217235130.1744843-1-saravanak@google.com>
In-Reply-To: <20210217235130.1744843-1-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 18 Feb 2021 18:18:27 +0100
Message-ID: <CAJZ5v0gdSbpjjD3=EC5i1Cw-t7fNzqv7oGm4rHzaOxUqC0c81A@mail.gmail.com>
Subject: Re: [PATCH] driver core: Avoid pointless deferred probe attempts
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
>
> There's no point in adding a device to the deferred probe list if we
> know for sure that it doesn't have a matching driver. So, check if a
> device can match with a driver before adding it to the deferred probe
> list.

What if a matching driver module loads in the meantime?

>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Geert,
>
> Can you give this a shot for your I2C DMA issue with fw_devlink=on?
>
> -Saravana
>
>  drivers/base/dd.c      | 6 ++++++
>  include/linux/device.h | 4 ++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 9179825ff646..f18963f42e21 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -123,6 +123,9 @@ static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
>
>  void driver_deferred_probe_add(struct device *dev)
>  {
> +       if (!dev->can_match)
> +               return;
> +
>         mutex_lock(&deferred_probe_mutex);
>         if (list_empty(&dev->p->deferred_probe)) {
>                 dev_dbg(dev, "Added to deferred list\n");
> @@ -726,6 +729,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
>         if (!device_is_registered(dev))
>                 return -ENODEV;
>
> +       dev->can_match = true;
>         pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
>                  drv->bus->name, __func__, dev_name(dev), drv->name);
>
> @@ -829,6 +833,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>                 return 0;
>         } else if (ret == -EPROBE_DEFER) {
>                 dev_dbg(dev, "Device match requests probe deferral\n");
> +               dev->can_match = true;
>                 driver_deferred_probe_add(dev);
>         } else if (ret < 0) {
>                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> @@ -1064,6 +1069,7 @@ static int __driver_attach(struct device *dev, void *data)
>                 return 0;
>         } else if (ret == -EPROBE_DEFER) {
>                 dev_dbg(dev, "Device match requests probe deferral\n");
> +               dev->can_match = true;
>                 driver_deferred_probe_add(dev);
>         } else if (ret < 0) {
>                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7619a84f8ce4..1f9cc1ba78bc 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -438,6 +438,9 @@ struct dev_links_info {
>   * @state_synced: The hardware state of this device has been synced to match
>   *               the software state of this device by calling the driver/bus
>   *               sync_state() callback.
> + * @can_match: The device has matched with a driver at least once or it is in
> + *             a bus (like AMBA) which can't check for matching drivers until
> + *             other devices probe successfully.
>   * @dma_coherent: this particular device is dma coherent, even if the
>   *             architecture supports non-coherent devices.
>   * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
> @@ -544,6 +547,7 @@ struct device {
>         bool                    offline:1;
>         bool                    of_node_reused:1;
>         bool                    state_synced:1;
> +       bool                    can_match:1;
>  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
>      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> --
