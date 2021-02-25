Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC4C32488D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 02:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhBYBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 20:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhBYBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 20:33:21 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 17:32:41 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id l8so3799689ybe.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 17:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b45aJW7f8rQdkS7Nlni9G/yBpxncwWdTo+O1NCFW2zY=;
        b=h+T/sLLO9QkDKE+5eFgv5SQfbMxydGxxTzV8DRJRUuHG33YUBoq6U4kM9ASQkJOQmG
         gkQniQBibdxbxsiVlwMAFRMnVRpEXmUe6L5Lve62t/q4O0piHUiZOi8X9TSm7jZq7+wO
         Wl52uOt4bqsl8jPgMGX9/e4rP/ioOHI8mhs0VVXfkRxuZ+EoZyHkv2dvY6k++/lMo/La
         heoIkcXhDgwdLl3e8q4b2GwC/LSi6C122jzSvN2K1+1fHFQJotBM6QFCcvBi3Lkl7CLb
         tD6FqxhQmnLD9p6mNU4uUH2a+j25vrUeZ66yataskcfY+NwscmMQMAmRvBdYmJNHPDNJ
         LXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b45aJW7f8rQdkS7Nlni9G/yBpxncwWdTo+O1NCFW2zY=;
        b=sWNZRWscGcRoc5OfudlhVC6Uo4Ea0BatuMwwpVmjxoFFAq6soFkmYI0qpVYMIa8s9Z
         56LxLCHEXzXgv/aUy6o6qUeQlO7tf9WvuNWnJrf11pE2GR580bVt4W8LAd5IZqFI1g1l
         snfJnsL+KzM2sdhXPRaRKZ3ROEoQ5ay/tvyIU1qbRRqmOF/4dtlhXTdb8sfUkGlR3grn
         ZH4r24HkH6wA3Cv7iZpBTx8a0wNZJhMwhHN2as1NgOwbnZ1SRg3bgLAdzlvDmXlCxfgI
         tAs887TId0y/txhvPiI7sw91fKOTOSSmnFxsX1Q/PjRRml9fnfpVjB7WkZobWFna7I21
         BM+A==
X-Gm-Message-State: AOAM532waYxY4Hj5LcQy4xU/8gM8yB1cXU2gkL71jqEjaJHzvOmDkK2b
        DzADsF9Y47zEmbLzRD5M8h5rUYyza/orFfLtGmBgYQ==
X-Google-Smtp-Source: ABdhPJw8QnC/GOla8bXOBSpK/QTLRs/XXchrHvkBGgCgAMZ1QFj0LQYqPkJE4y3TMKdYQyfvWJyJj06w5NdUZvr/w4w=
X-Received: by 2002:a25:86d2:: with SMTP id y18mr688353ybm.466.1614216760159;
 Wed, 24 Feb 2021 17:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20210217235130.1744843-1-saravanak@google.com>
 <CAJZ5v0gdSbpjjD3=EC5i1Cw-t7fNzqv7oGm4rHzaOxUqC0c81A@mail.gmail.com> <CAGETcx-M51sy86QGXQpnevXb0AniNPatVJwcM9tRQttVXH5JEg@mail.gmail.com>
In-Reply-To: <CAGETcx-M51sy86QGXQpnevXb0AniNPatVJwcM9tRQttVXH5JEg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 24 Feb 2021 17:32:04 -0800
Message-ID: <CAGETcx_s1Qm6fJjqWBnyzRe1rY++Ctr41QgEYdVaubxk0dnQPg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Avoid pointless deferred probe attempts
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 9:24 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Feb 18, 2021 at 9:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Feb 18, 2021 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > There's no point in adding a device to the deferred probe list if we
> > > know for sure that it doesn't have a matching driver. So, check if a
> > > device can match with a driver before adding it to the deferred probe
> > > list.
> >
> > What if a matching driver module loads in the meantime?
>
> Driver registration always triggers a match attempt and this flag will
> get set at that point. Yes, the user can disable autoprobe, but
> that'll block deferred probes too.
>

Let me know what you think Rafael.

-Saravana

>
> >
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > > Geert,
> > >
> > > Can you give this a shot for your I2C DMA issue with fw_devlink=on?
> > >
> > > -Saravana
> > >
> > >  drivers/base/dd.c      | 6 ++++++
> > >  include/linux/device.h | 4 ++++
> > >  2 files changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > index 9179825ff646..f18963f42e21 100644
> > > --- a/drivers/base/dd.c
> > > +++ b/drivers/base/dd.c
> > > @@ -123,6 +123,9 @@ static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
> > >
> > >  void driver_deferred_probe_add(struct device *dev)
> > >  {
> > > +       if (!dev->can_match)
> > > +               return;
> > > +
> > >         mutex_lock(&deferred_probe_mutex);
> > >         if (list_empty(&dev->p->deferred_probe)) {
> > >                 dev_dbg(dev, "Added to deferred list\n");
> > > @@ -726,6 +729,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
> > >         if (!device_is_registered(dev))
> > >                 return -ENODEV;
> > >
> > > +       dev->can_match = true;
> > >         pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
> > >                  drv->bus->name, __func__, dev_name(dev), drv->name);
> > >
> > > @@ -829,6 +833,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
> > >                 return 0;
> > >         } else if (ret == -EPROBE_DEFER) {
> > >                 dev_dbg(dev, "Device match requests probe deferral\n");
> > > +               dev->can_match = true;
> > >                 driver_deferred_probe_add(dev);
> > >         } else if (ret < 0) {
> > >                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > > @@ -1064,6 +1069,7 @@ static int __driver_attach(struct device *dev, void *data)
> > >                 return 0;
> > >         } else if (ret == -EPROBE_DEFER) {
> > >                 dev_dbg(dev, "Device match requests probe deferral\n");
> > > +               dev->can_match = true;
> > >                 driver_deferred_probe_add(dev);
> > >         } else if (ret < 0) {
> > >                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 7619a84f8ce4..1f9cc1ba78bc 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -438,6 +438,9 @@ struct dev_links_info {
> > >   * @state_synced: The hardware state of this device has been synced to match
> > >   *               the software state of this device by calling the driver/bus
> > >   *               sync_state() callback.
> > > + * @can_match: The device has matched with a driver at least once or it is in
> > > + *             a bus (like AMBA) which can't check for matching drivers until
> > > + *             other devices probe successfully.
> > >   * @dma_coherent: this particular device is dma coherent, even if the
> > >   *             architecture supports non-coherent devices.
> > >   * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
> > > @@ -544,6 +547,7 @@ struct device {
> > >         bool                    offline:1;
> > >         bool                    of_node_reused:1;
> > >         bool                    state_synced:1;
> > > +       bool                    can_match:1;
> > >  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> > >      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> > >      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> > > --
