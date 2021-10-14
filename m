Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B82942D066
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 04:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNCab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 22:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhJNCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 22:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634178502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P1vAasFCi1yTdsgtadRT4Vzr5q4cOBpL6MRDEc7M/lE=;
        b=WcEVp5gGzVqwrkj3/dHtGMYJjjGtaxRFzpXY0rr4yFrxj5VbKaEESeA5XUUwVGhJG2YIiJ
        GRe6Q3WVpK+qc0TmcqkcPk0wxcB+cvA146dzM9tPpFqRTAbdJ0C8Rj7vWSYnOrQip2cENn
        j09Eg3PyrH1IyhnMewSnhgWUbe8AYHc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-TUZEHmfSMtiqWPdRn0cnQA-1; Wed, 13 Oct 2021 22:28:21 -0400
X-MC-Unique: TUZEHmfSMtiqWPdRn0cnQA-1
Received: by mail-lf1-f70.google.com with SMTP id d12-20020a0565123d0c00b003fdb52f1cdcso1415307lfv.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 19:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1vAasFCi1yTdsgtadRT4Vzr5q4cOBpL6MRDEc7M/lE=;
        b=2m/+UcA2jSrm1EhFJI/DKDj8T8CYXhvx05GxuHD7zhJwUBEivFJwuAiwQkzEkJG5Ak
         U7GUaTMZ2gC9uTwWo5xjVLw4rSZ0jo00TmrvOexYnhe0yxRyrRAn8al+C5/BnEzUDXLn
         KeL2rlOE64r2dGRJQI0sUdSWF8BW+/4nLpbPLZ1zRQBrzfkiM4rvOHuEe437htQlIkxu
         GhOV/Ibl6FGkxqHw2mW1tDUhSuBR6YLq3xptIanCej2SoLkNEQ0jsIbv/oYRIZTd7ps9
         z7YoDcxkZ4zkZs5daKEaPNtGfQQP3nF+W1wZvPcLKX0/8ITNpS9H/6Yp196MjrkUzsiB
         B2CA==
X-Gm-Message-State: AOAM5309IOuqsolXYK/H/boUNzxeGV9ZNMhtHnTBzhPcDXwHfzDjeY/g
        W2uMEpagwunORKZ+7navPLDeLC4b+G2XGp7AOaIoboRZtbLvgD+e64mXcXEy3Y1Ku+yPFqzuO6Q
        wtLobnZX/ToWWgBi2402Cgm+eh4OpLdoQZsVk58L+
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2694120lfr.348.1634178499921;
        Wed, 13 Oct 2021 19:28:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9pxV7x1HBT4oxol3ePyrSgQibEXDD9D8upQ79p3LIv4kV1qwZLq2/dBjeTUeShMCPm/x77qn/0iQhiCSrGDo=
X-Received: by 2002:ac2:5e78:: with SMTP id a24mr2694102lfr.348.1634178499672;
 Wed, 13 Oct 2021 19:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211012065227.9953-1-jasowang@redhat.com> <20211012065227.9953-4-jasowang@redhat.com>
 <20211013054334-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211013054334-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 14 Oct 2021 10:28:06 +0800
Message-ID: <CACGkMEvYu4rMnhLtQfPo-BKME+cT9Sk1b39++f3BXZm1fTQHMQ@mail.gmail.com>
Subject: Re: [PATCH V2 03/12] virtio-console: switch to use .validate()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Amit Shah <amit@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 5:51 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Oct 12, 2021 at 02:52:18PM +0800, Jason Wang wrote:
> > This patch switches to use validate() to filter out the features that
> > is not supported by the rproc.
>
> are not supported
>
> >
> > Cc: Amit Shah <amit@kernel.org>
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
>
> Does this have anything to do with hardening?
>
> It seems cleaner to not negotiate features we do not use,
> but given we did this for many years ... should we bother
> at this point?

It looks cleaner to do all the validation in one places:

1) check unsupported feature for rproc
2) validate the max_nr_ports (as has been done in patch 4)

>
>
> > ---
> >  drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
> >  1 file changed, 26 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7eaf303a7a86..daeed31df622 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
> >
> >       vdev = port->portdev->vdev;
> >
> > -     /* Don't test F_SIZE at all if we're rproc: not a valid feature! */
> > -     if (!is_rproc_serial(vdev) &&
> > -         virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> > +     if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
> >               hvc_resize(port->cons.hvc, port->cons.ws);
> >  }
> >
> > @@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
> >       kfree(portdev);
> >  }
> >
> > +static int virtcons_validate(struct virtio_device *vdev)
> > +{
> > +     if (is_rproc_serial(vdev)) {
> > +             /* Don't test F_SIZE at all if we're rproc: not a
> > +              * valid feature! */
>
>
> This comment needs to be fixed now. And the format's wrong
> since you made it a multi-line comment.
> Should be
>         /*
>          * like
>          * this
>          */

Ok.

>
> > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
> > +             /* Don't test MULTIPORT at all if we're rproc: not a
> > +              * valid feature! */
> > +             __virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
> > +     }
> > +
> > +     /* We only need a config space if features are offered */
> > +     if (!vdev->config->get &&
> > +         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > +          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > +             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > +                     __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  /*
> >   * Once we're further in boot, we get probed like any other virtio
> >   * device.
>
> This switches the order of tests around, so if an rproc device
> offers VIRTIO_CONSOLE_F_SIZE or VIRTIO_CONSOLE_F_MULTIPORT
> without get it will now try to work instead of failing.

Ok, so we can fail the validation in this case.

Thanks

>
> Which is maybe a worthy goal, but given rproc does not support
> virtio 1.0 it also risks trying to drive something completely
> unreasonable.
>
> Overall does not feel like hardening which is supposed to make
> things more strict, not less.
>
>
> > @@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
> >       bool multiport;
> >       bool early = early_put_chars != NULL;
> >
> > -     /* We only need a config space if features are offered */
> > -     if (!vdev->config->get &&
> > -         (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
> > -          || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
> > -             dev_err(&vdev->dev, "%s failure: config access disabled\n",
> > -                     __func__);
> > -             return -EINVAL;
> > -     }
> > -
> >       /* Ensure to read early_put_chars now */
> >       barrier();
> >
> > @@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
> >       multiport = false;
> >       portdev->max_nr_ports = 1;
> >
> > -     /* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
> > -     if (!is_rproc_serial(vdev) &&
> > -         virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> > +     if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
> >                                struct virtio_console_config, max_nr_ports,
> >                                &portdev->max_nr_ports) == 0) {
> >               multiport = true;
> > @@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
> >       .driver.name =  KBUILD_MODNAME,
> >       .driver.owner = THIS_MODULE,
> >       .id_table =     id_table,
> > +     .validate =     virtcons_validate,
> >       .probe =        virtcons_probe,
> >       .remove =       virtcons_remove,
> >       .config_changed = config_intr,
> > --
> > 2.25.1
>

