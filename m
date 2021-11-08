Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B280449A66
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 18:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239334AbhKHRIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 12:08:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236155AbhKHRIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 12:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636391136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NPqsXHRTDDOKAO8W4fUMxrj4GjcH6LfmhyAuBTyX3XQ=;
        b=OrdoNmJmMLuFUIoRVgvG5Elg45LGWOcwgCYs/pXs5mF8MxtfGA1C+hz4HlQDJIA22tAyja
        ZlsFSR9shrrSxGMFuDdWCw8tJQCdwB5eOU3Ewjx2/t8pmLEvT2HgdspoaqHd8C98GkxBoX
        PIZW0y1zvhyBqyZD0iNd9onDw3upWao=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-I5XETun-NX64R0WAYtJz0g-1; Mon, 08 Nov 2021 12:05:35 -0500
X-MC-Unique: I5XETun-NX64R0WAYtJz0g-1
Received: by mail-ed1-f70.google.com with SMTP id r25-20020a05640216d900b003dca3501ab4so15393994edx.15
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 09:05:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NPqsXHRTDDOKAO8W4fUMxrj4GjcH6LfmhyAuBTyX3XQ=;
        b=TRFuILGcwr/bZyQnx5tDJoyIapZ7xObiylXsDECnB56h3boGj4BThxfJLaJbns2dRd
         SuppV/lJLo34sqaAD/4NvP+J7m4S8PR/eSr4du1/x14VxJaLqjlE6KH8RasLOnJgYyuf
         UdKLmHzXlYWR4pw5V+EQcQxJui+ea/unErjTMCe8+BGdO03/mBsIlabplqspQtvTszNf
         fAYVtbn/Fpj4W4VqeunRkJ/DHclX7lnjcmNCV2DGyOf4H3K+Y9/UvO5/hTEZFAdrdSRE
         k5tKRgtBKpklgWiPm6Q1oo0kbi+HWvdjzIyakyp6ELmTAaVzL/lD31cVAVzH2rKygLWO
         dqsA==
X-Gm-Message-State: AOAM531wcTPmhHryzuOstdEszCHpCfquochLsUqa0d6410LK0qQwNxkg
        p9fxkhsVfpnBDoqRIWCtbdHRj0DW7IjdZByAeVKWTDkjDzIKeePTbEfAfT6szjLlMLCmy6xcJeK
        GxaKhdUPth79s0VSRA5b/m54S
X-Received: by 2002:aa7:c158:: with SMTP id r24mr773677edp.65.1636391133519;
        Mon, 08 Nov 2021 09:05:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdw4FnpJrfj9fDfoGHK7Ece1hu0YLzV6RUjD3WLZnwwX1Kp9CmaEpRsJ1TBVXOx89iy94Nng==
X-Received: by 2002:aa7:c158:: with SMTP id r24mr773644edp.65.1636391133325;
        Mon, 08 Nov 2021 09:05:33 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id h10sm9883575edk.41.2021.11.08.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:05:32 -0800 (PST)
Date:   Mon, 8 Nov 2021 18:05:29 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Parav Pandit <parav@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <CAGxU2F4NQz74f8sw51Ownm-25Jd7K=B_gK_-nRDKmmYvPx=+=w@mail.gmail.com>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 4:01 AM Jason Wang <jasowang@redhat.com> wrote:
>
> On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > `driver_override` allows to control which of the vDPA bus drivers
> > binds to a vDPA device.
> >
> > If `driver_override` is not set, the previous behaviour is followed:
> > devices use the first vDPA bus driver loaded (unless auto binding
> > is disabled).
> >
> > Tested on Fedora 34 with driverctl(8):
> >   $ modprobe virtio-vdpa
> >   $ modprobe vhost-vdpa
> >   $ modprobe vdpa-sim-net
> >
> >   $ vdpa dev add mgmtdev vdpasim_net name dev1
> >
> >   # dev1 is attached to the first vDPA bus driver loaded
> >   $ driverctl -b vdpa list-devices
> >     dev1 virtio_vdpa
> >
> >   $ driverctl -b vdpa set-override dev1 vhost_vdpa
> >
> >   $ driverctl -b vdpa list-devices
> >     dev1 vhost_vdpa [*]
> >
> >   Note: driverctl(8) integrates with udev so the binding is
> >   preserved.
> >
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  include/linux/vdpa.h |  2 ++
> >  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 76 insertions(+)
> >
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index c3011ccda430..ae34015b37b7 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
> >   * struct vdpa_device - representation of a vDPA device
> >   * @dev: underlying device
> >   * @dma_dev: the actual device that is performing DMA
> > + * @driver_override: driver name to force a match
>
> This seems useless?
>
> >   * @config: the configuration ops for this device.
> >   * @cf_mutex: Protects get and set access to configuration layout.
> >   * @index: device index
> > @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
> >  struct vdpa_device {
> >         struct device dev;
> >         struct device *dma_dev;
> > +       const char *driver_override;
> >         const struct vdpa_config_ops *config;
> >         struct mutex cf_mutex; /* Protects get/set config */
> >         unsigned int index;
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 7332a74a4b00..659231bbfee8 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
> >                 drv->remove(vdev);
> >  }
> >
> > +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> > +{
> > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > +
> > +       /* Check override first, and if set, only use the named driver */
> > +       if (vdev->driver_override)
> > +               return strcmp(vdev->driver_override, drv->name) == 0;
> > +
> > +       /* Currently devices must be supported by all vDPA bus drivers */
> > +       return 1;
> > +}
> > +
> > +static ssize_t driver_override_store(struct device *dev,
> > +                                    struct device_attribute *attr,
> > +                                    const char *buf, size_t count)
> > +{
> > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > +       const char *driver_override, *old;
> > +       char *cp;
> > +
> > +       /* We need to keep extra room for a newline */
> > +       if (count >= (PAGE_SIZE - 1))
> > +               return -EINVAL;
> > +
> > +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> > +       if (!driver_override)
> > +               return -ENOMEM;
> > +
> > +       cp = strchr(driver_override, '\n');
> > +       if (cp)
> > +               *cp = '\0';
> > +
> > +       device_lock(dev);
> > +       old = vdev->driver_override;
> > +       if (strlen(driver_override)) {
> > +               vdev->driver_override = driver_override;
> > +       } else {
> > +               kfree(driver_override);
> > +               vdev->driver_override = NULL;
> > +       }
> > +       device_unlock(dev);
> > +
> > +       kfree(old);
> > +
> > +       return count;
> > +}
> > +
> > +static ssize_t driver_override_show(struct device *dev,
> > +                                   struct device_attribute *attr, char *buf)
> > +{
> > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> > +       ssize_t len;
> > +
> > +       device_lock(dev);
> > +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> > +       device_unlock(dev);
> > +
> > +       return len;
> > +}
> > +static DEVICE_ATTR_RW(driver_override);
> > +
> > +static struct attribute *vdpa_dev_attrs[] = {
> > +       &dev_attr_driver_override.attr,
> > +       NULL,
> > +};
> > +
> > +static const struct attribute_group vdpa_dev_group = {
> > +       .attrs  = vdpa_dev_attrs,
> > +};
> > +__ATTRIBUTE_GROUPS(vdpa_dev);
> > +
> >  static struct bus_type vdpa_bus = {
> >         .name  = "vdpa",
> > +       .dev_groups = vdpa_dev_groups,
>
> This reminds me that we probably need to document the sysfs interface
> in Documentation/ABI/testing/sysfs-bus-vdpa.
>
> But it's not the fault of this patch which look good.

Michael, Jason, about Documentation/ABI/testing/sysfs-bus-vdpa, do you 
think is better to send a follow up patch/series, maybe including also 
others entries (e.g. bind, unbind) or a v2 including the documentation 
of `driver_ovveride`?

Thanks,
Stefano

