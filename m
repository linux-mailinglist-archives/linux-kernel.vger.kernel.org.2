Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548FD30A9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhBAOas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:30:48 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42672 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhBAOao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:30:44 -0500
Received: by mail-ot1-f47.google.com with SMTP id f6so16375184ots.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:30:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4a6WyHi1fTY9B5OfxgOlcMOAurztWAvUVTB16LYh9g=;
        b=saY2phts6zPanJvGie53UbWQcYgoDd2AGAplz81FHRTwxZN2UTtLdgHFtg/pvy85A7
         wNKZ2h1Tv1rrZrxYjSgiThvwql/QpoFSLm3jE9OBb/kZYLugw9eiUf/1YBIznBsblipu
         sF9HJtaSRQVHupl37pRbQHEqy9PYytPee70NxY7jvmXvo7NP1Z5xI+UQyOpxizvFFFGZ
         xrdUtQOIBQbSTjesF+0QXr3dAiFR0tH+jLc+lctY9xZMzOUNkPsFELLFRVoMANckH3Kf
         xuLq0Ini3JRzfFgtpXVoUzghnbjiVUiBoqgdCGPO9Kv1WP/xGB5yQADTYEFXLjkk3Fbo
         lh6g==
X-Gm-Message-State: AOAM533VEZWH8nspaZWloiOeRSIIePy0pDrbXKpQ5SqxFYKWbisOnO5P
        FJkCW5HQ+p67c7YRkYV6xFnPNmaXdIrBZ7k5gSOZJsUD
X-Google-Smtp-Source: ABdhPJzR+PWZavRi0lp9V4VXfkbSKlpuPRNTBPKFH0qBukON7r6+zcERUoHFjhGu1ZBWuRJf+S/vEbFz6510cc1YSno=
X-Received: by 2002:a9d:7a4a:: with SMTP id z10mr12241100otm.206.1612189803781;
 Mon, 01 Feb 2021 06:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com> <20210130040344.2807439-2-saravanak@google.com>
In-Reply-To: <20210130040344.2807439-2-saravanak@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 15:29:52 +0100
Message-ID: <CAJZ5v0i+c+vQ0i3UUzPT9s89OVbVvMQW1ZZ8=cCUYHXq936vzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: fw_devlink: Detect supplier devices
 that will never be added
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 5:03 AM Saravana Kannan <saravanak@google.com> wrote:
>
> During the initial parsing of firmware by fw_devlink, fw_devlink might
> infer that some supplier firmware nodes would get populated as devices.
> But the inference is not always correct. This patch tries to logically
> detect and fix such mistakes as boot progresses or more devices probe.
>
> fw_devlink makes a fundamental assumption that once a device binds to a
> driver, it will populate (i.e: add as struct devices) all the child
> firmware nodes that could be populated as devices.

That is unless they have been populated earlier.

> So, whenever a device probes, we check all its child firmware nodes. If
> a child firmware node has a corresponding device populated, we don't
> modify the child node or its descendants. However, if a child firmware
> node has not been populated as a device, we go an delete all the fwnode
> links where the child node or its descendants are suppliers. This
> ensures that no other device is blocked on a firmware node that will
> never be populated as a device.
>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Looks reasonable to me:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 30 +++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 484a942884ba..f380133df63b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -148,6 +148,20 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
>         fwnode_links_purge_consumers(fwnode);
>  }
>
> +static void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
> +{
> +       struct fwnode_handle *child;
> +
> +       /* Don't purge consumer links of an added child */
> +       if (fwnode->dev)
> +               return;
> +
> +       fwnode_links_purge_consumers(fwnode);
> +
> +       fwnode_for_each_available_child_node(fwnode, child)
> +               fw_devlink_purge_absent_suppliers(child);
> +}
> +
>  #ifdef CONFIG_SRCU
>  static DEFINE_MUTEX(device_links_lock);
>  DEFINE_STATIC_SRCU(device_links_srcu);
> @@ -1154,12 +1168,22 @@ void device_links_driver_bound(struct device *dev)
>         LIST_HEAD(sync_list);
>
>         /*
> -        * If a device probes successfully, it's expected to have created all
> +        * If a device binds successfully, it's expected to have created all
>          * the device links it needs to or make new device links as it needs
> -        * them. So, it no longer needs to wait on any suppliers.
> +        * them. So, fw_devlink no longer needs to create device links to any
> +        * of the device's suppliers.
> +        *
> +        * Also, if a child firmware node of this bound device is not added as
> +        * a device by now, assume it is never going to be added and make sure
> +        * other devices don't defer probe indefinitely by waiting for such a
> +        * child device.
>          */
> -       if (dev->fwnode && dev->fwnode->dev == dev)
> +       if (dev->fwnode && dev->fwnode->dev == dev) {
> +               struct fwnode_handle *child;
>                 fwnode_links_purge_suppliers(dev->fwnode);
> +               fwnode_for_each_available_child_node(dev->fwnode, child)
> +                       fw_devlink_purge_absent_suppliers(child);
> +       }
>         device_remove_file(dev, &dev_attr_waiting_for_supplier);
>
>         device_links_write_lock();
> --
> 2.30.0.365.g02bc693789-goog
>
