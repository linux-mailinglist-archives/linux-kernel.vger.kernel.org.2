Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D189731EF29
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbhBRTDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbhBRR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:26:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3281C061797
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:25:33 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id u3so2894424ybk.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHBXPxPSl0jqL39Rbqs5J2y2vHaaMW9MKFhemVstOkY=;
        b=My6M3tU/Z1+MteiPujzQzYGtnc75WecZz0TrffNT0Hta0XzZu9Pr6A6ITiK5u+jhi5
         NDm/5jg4oTAs0G9/4HrPO09x+g3TKxK2u3UnV3hyz4Xsuzd1+AqQjV0DJhOho+JkBPz3
         IdGEOx7dld3R127V3dnZMYgz5rgediMc1BbRZM99FxTXmVSR2Up/Au7eFHB8yeks4mCx
         f7DSSIIN3tVYHqxn+j6H6H6VoG7qvkV7qabbqQpeXmwGOocV74PRhIeRSUzDlAaHD8TJ
         7q8mqLtfVGv1tMao16PHAdK6V3WAuyA13TII9vaSEjiFVkEelwLoPVE8UhLc3QOHAntk
         nBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHBXPxPSl0jqL39Rbqs5J2y2vHaaMW9MKFhemVstOkY=;
        b=QAONIwOXrTJ04JV+TuEG+dqne1UYEsTH58ht0wL9G4YAVXq4tNjS+hxX+bF0RtDe5z
         I5X1YFiu+fvZLlWf3EEqerEy0lPzbayiqJ+aL798AyCHuBqDNZzZy3Ekn2nZmgmADdZG
         7d1uuGZpojmucC3qdFl8UlOLzuY+2U92WJ7iGU/e4nb+tzEoTZlgwoiWP7+TSIGt7U7j
         m82IlM0fhZPKcqGMCfD79Pn1fAggd4plxOoybwQrk3GsgPHs9YZaNa+/vseIvNSAnbEi
         c2zWyyaXd3q7U9JJNJC/drzmG63LHq+LKtP7LxY3sZ0NPN/tPLVnFd2GxrgvywUCi9cd
         5ywg==
X-Gm-Message-State: AOAM530jf2WcDe08qJc+f1LBj2wBv5ZC+z/cROgyDEdz3Z//Sg00Icu7
        M+d0vCb2pUnAvj4P2EqPVne3PGKYqpdZb4ZDRzlNaA==
X-Google-Smtp-Source: ABdhPJye0QK2l3zbbYCtSbTWBP/ebIc35AEaLqTbU3Y/6ASey11vabgskLJk6woxWvmm2SvJs3c9ltr8EJP3uzUO4us=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr8708174ybi.32.1613669132783;
 Thu, 18 Feb 2021 09:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20210217235130.1744843-1-saravanak@google.com> <CAJZ5v0gdSbpjjD3=EC5i1Cw-t7fNzqv7oGm4rHzaOxUqC0c81A@mail.gmail.com>
In-Reply-To: <CAJZ5v0gdSbpjjD3=EC5i1Cw-t7fNzqv7oGm4rHzaOxUqC0c81A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 18 Feb 2021 09:24:56 -0800
Message-ID: <CAGETcx-M51sy86QGXQpnevXb0AniNPatVJwcM9tRQttVXH5JEg@mail.gmail.com>
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

On Thu, Feb 18, 2021 at 9:18 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Feb 18, 2021 at 12:51 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > There's no point in adding a device to the deferred probe list if we
> > know for sure that it doesn't have a matching driver. So, check if a
> > device can match with a driver before adding it to the deferred probe
> > list.
>
> What if a matching driver module loads in the meantime?

Driver registration always triggers a match attempt and this flag will
get set at that point. Yes, the user can disable autoprobe, but
that'll block deferred probes too.

-Saravana

>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > Geert,
> >
> > Can you give this a shot for your I2C DMA issue with fw_devlink=on?
> >
> > -Saravana
> >
> >  drivers/base/dd.c      | 6 ++++++
> >  include/linux/device.h | 4 ++++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > index 9179825ff646..f18963f42e21 100644
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -123,6 +123,9 @@ static DECLARE_WORK(deferred_probe_work, deferred_probe_work_func);
> >
> >  void driver_deferred_probe_add(struct device *dev)
> >  {
> > +       if (!dev->can_match)
> > +               return;
> > +
> >         mutex_lock(&deferred_probe_mutex);
> >         if (list_empty(&dev->p->deferred_probe)) {
> >                 dev_dbg(dev, "Added to deferred list\n");
> > @@ -726,6 +729,7 @@ static int driver_probe_device(struct device_driver *drv, struct device *dev)
> >         if (!device_is_registered(dev))
> >                 return -ENODEV;
> >
> > +       dev->can_match = true;
> >         pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
> >                  drv->bus->name, __func__, dev_name(dev), drv->name);
> >
> > @@ -829,6 +833,7 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
> >                 return 0;
> >         } else if (ret == -EPROBE_DEFER) {
> >                 dev_dbg(dev, "Device match requests probe deferral\n");
> > +               dev->can_match = true;
> >                 driver_deferred_probe_add(dev);
> >         } else if (ret < 0) {
> >                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > @@ -1064,6 +1069,7 @@ static int __driver_attach(struct device *dev, void *data)
> >                 return 0;
> >         } else if (ret == -EPROBE_DEFER) {
> >                 dev_dbg(dev, "Device match requests probe deferral\n");
> > +               dev->can_match = true;
> >                 driver_deferred_probe_add(dev);
> >         } else if (ret < 0) {
> >                 dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 7619a84f8ce4..1f9cc1ba78bc 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -438,6 +438,9 @@ struct dev_links_info {
> >   * @state_synced: The hardware state of this device has been synced to match
> >   *               the software state of this device by calling the driver/bus
> >   *               sync_state() callback.
> > + * @can_match: The device has matched with a driver at least once or it is in
> > + *             a bus (like AMBA) which can't check for matching drivers until
> > + *             other devices probe successfully.
> >   * @dma_coherent: this particular device is dma coherent, even if the
> >   *             architecture supports non-coherent devices.
> >   * @dma_ops_bypass: If set to %true then the dma_ops are bypassed for the
> > @@ -544,6 +547,7 @@ struct device {
> >         bool                    offline:1;
> >         bool                    of_node_reused:1;
> >         bool                    state_synced:1;
> > +       bool                    can_match:1;
> >  #if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> >      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> >      defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
> > --
