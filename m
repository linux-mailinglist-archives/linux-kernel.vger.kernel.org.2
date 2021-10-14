Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F5E42D20F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 07:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhJNGAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 02:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229457AbhJNGAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 02:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634191095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9GNqF7oZ5ZxqDGvug1wa9zV0RT5V0MlCCCE4TEdHgM=;
        b=MXwgfTNwoEonm+BZhvqYojelcT73dxD4MpRaQdMCAsPu8CIgkbH5qqo9eX6EGs8A2w2wbH
        WwMi9iUu2qWpDmZlVsyKDqwArSAodljlMnd6OlNVkgzY95PzBNB/BBinUSC9giVygY/nuc
        +cEAui5f6Dj+ftG4ghscStCwrtUrgMo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-d9ZGnRf9NFixyAz-GIJiAA-1; Thu, 14 Oct 2021 01:58:13 -0400
X-MC-Unique: d9ZGnRf9NFixyAz-GIJiAA-1
Received: by mail-wr1-f72.google.com with SMTP id a15-20020a056000188f00b00161068d8461so3703272wri.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 22:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9GNqF7oZ5ZxqDGvug1wa9zV0RT5V0MlCCCE4TEdHgM=;
        b=RkSkoUynPrEJyIPg9LixN0Cs8Yr0P07Dl5titXl6dOQtQfbD4ZOK6cl3YqHi5/CgOL
         vdrqRN8DkTZduArcU/NICczEKLJSMJewQdHkUWS+wor3aXYHFlR+6EDUAGssbcWBsBgA
         nWWAP9XvpkN+t2ah+PJgqEg84+RTnjBjaEcBtQ05KMj/8Kdg2VDdRA2pYJR5Xq2R3Rwp
         zRd5VGPp7Cm9/+6AWiZVvR7NomJgdKitoqd8MEQitCEW7VrO+zJ4Ra6BTqr0vRRFGuqw
         QEaDY9YCb60dBWSdWOa9hTS/NAkT7nRXLf8vLhva2Tz1SO3x4A4NVprCvghzUKrlgQ3W
         91XA==
X-Gm-Message-State: AOAM530qypm6l+1nDnQNQeKd/GZkjNVF9fU7mU1IToTBHCLsd8A4GD1J
        zX9sZRZ/KsdPRXE77/vs0NSMv6oATlQ0Of6GRspKOBhww+5PDsSVDI7UgA1mRTcRczz3H1vio8+
        3O8j1s6db6h03gg9ufBKGuF3F
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr4220624wrw.407.1634191092125;
        Wed, 13 Oct 2021 22:58:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRsviF6B6TIbp4oMqx9j5CJVnbpO7qhFbnNiOh8GpPukKSxvqiwcjSFJhahubkVKwwS8mdhQ==
X-Received: by 2002:a5d:63ca:: with SMTP id c10mr4220609wrw.407.1634191091908;
        Wed, 13 Oct 2021 22:58:11 -0700 (PDT)
Received: from redhat.com ([2.55.16.227])
        by smtp.gmail.com with ESMTPSA id d9sm1488789wrm.96.2021.10.13.22.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 22:58:11 -0700 (PDT)
Date:   Thu, 14 Oct 2021 01:58:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Amit Shah <amit@kernel.org>
Subject: Re: [PATCH V2 03/12] virtio-console: switch to use .validate()
Message-ID: <20211014015616-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-4-jasowang@redhat.com>
 <20211013054334-mutt-send-email-mst@kernel.org>
 <CACGkMEvYu4rMnhLtQfPo-BKME+cT9Sk1b39++f3BXZm1fTQHMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvYu4rMnhLtQfPo-BKME+cT9Sk1b39++f3BXZm1fTQHMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 10:28:06AM +0800, Jason Wang wrote:
> On Wed, Oct 13, 2021 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 02:52:18PM +0800, Jason Wang wrote:
> > > This patch switches to use validate() to filter out the features that
> > > is not supported by the rproc.
> >
> > are not supported
> >
> > >
> > > Cc: Amit Shah <amit@kernel.org>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> >
> >
> > Does this have anything to do with hardening?
> >
> > It seems cleaner to not negotiate features we do not use,
> > but given we did this for many years ... should we bother
> > at this point?
> 
> It looks cleaner to do all the validation in one places:
> 
> 1) check unsupported feature for rproc
> 2) validate the max_nr_ports (as has been done in patch 4)
> 
> >
> >
> > > ---
> > >  drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
> > >  1 file changed, 26 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 7eaf303a7a86..daeed31df622 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
> > >
> > >       vdev = port->portdev->vdev;
> > >
> > > -     /* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > > -     if (!is_rproc_serial(vdev) &&
> > > -         virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > > +     if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > >               hvc_resize(port->cons.hvc, port->cons.ws);
> > >  }
> > >
> > > @@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
> > >       kfree(portdev);
> > >  }
> > >
> > > +static int virtcons_validate(struct virtio_device *vdev)
> > > +{
> > > +     if (is_rproc_serial(vdev)) {
> > > +             /* Don't test F_SIZE at all if we're rproc: not a
> > > +              * valid feature! */
> >
> >
> > This comment needs to be fixed now. And the format's wrong
> > since you made it a multi-line comment.
> > Should be
> >         /*
> >          * like
> >          * this
> >          */
> 
> Ok.
> 
> >
> > > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
> > > +             /* Don't test MULTIPORT at all if we're rproc: not a
> > > +              * valid feature! */
> > > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> > > +     }
> > > +
> > > +     /* We only need a config space if features are offered */
> > > +     if (!vdev->config->get &&
> > > +         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > > +          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > > +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > +                     __func__);
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /*
> > >   * Once we're further in boot, we get probed like any other virtio
> > >   * device.
> >
> > This switches the order of tests around, so if an rproc device
> > offers VIRTIO_CONSOLE_F_SIZE or VIRTIO_CONSOLE_F_MULTIPORT
> > without get it will now try to work instead of failing.
> 
> Ok, so we can fail the validation in this case.

We can. But if we are going to, then it's easier to just fail probe.
Or if you want to try and work around this case,
that's also reasonable but pls document in the commit log.


> Thanks
> 
> >
> > Which is maybe a worthy goal, but given rproc does not support
> > virtio 1.0 it also risks trying to drive something completely
> > unreasonable.
> >
> > Overall does not feel like hardening which is supposed to make
> > things more strict, not less.
> >
> >
> > > @@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
> > >       bool multiport;
> > >       bool early = early_put_chars != NULL;
> > >
> > > -     /* We only need a config space if features are offered */
> > > -     if (!vdev->config->get &&
> > > -         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > > -          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > > -             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > > -                     __func__);
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       /* Ensure to read early_put_chars now */
> > >       barrier();
> > >
> > > @@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
> > >       multiport = false;
> > >       portdev->max_nr_ports = 1;
> > >
> > > -     /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> > > -     if (!is_rproc_serial(vdev) &&
> > > -         virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > > +     if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > >                                struct virtio_console_config, max_nr_ports,
> > >                                &portdev->max_nr_ports) == 0) {
> > >               multiport = true;
> > > @@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
> > >       .driver.name =  KBUILD_MODNAME,
> > >       .driver.owner = THIS_MODULE,
> > >       .id_table =     id_table,
> > > +     .validate =     virtcons_validate,
> > >       .probe =        virtcons_probe,
> > >       .remove =       virtcons_remove,
> > >       .config_changed = config_intr,
> > > --
> > > 2.25.1
> >

