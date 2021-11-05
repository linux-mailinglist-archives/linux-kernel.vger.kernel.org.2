Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0E14460A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhKEI3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:29:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232453AbhKEI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636100818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2czTQm0QJ9/x8jcZdwvnH7f3nSKUf/6fHpMFPR3kC4Y=;
        b=ElR8d9TPgSGaNBniMTu7escfvDltEG7jr5+hR2ApzDDokaTQm9eO1wjUw8GtpQhxD5MSle
        ggexr5g9+oLjxR+sA/CBFNoB71inP17q+iHYkEOe/2e7tEw6oCfNgmLo2Xmb9eThZQZEQh
        WPjbSw/td4qtTKidPXCZFNaeeLU+dA8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-I_OHIit3P-e3Tc-vuGBz-w-1; Fri, 05 Nov 2021 04:26:56 -0400
X-MC-Unique: I_OHIit3P-e3Tc-vuGBz-w-1
Received: by mail-lf1-f69.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso1859205lfv.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 01:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2czTQm0QJ9/x8jcZdwvnH7f3nSKUf/6fHpMFPR3kC4Y=;
        b=dYXolCM4YzmxTbgPyMDVvbUlPbqN/VKEeFQRtwjLrVjOVDo0CvfRS+Qx8OPPOP2Fx+
         A9MjjLI/yMx88Ao+C5SnK87t0NV8xubl/s6aFCId/HYsD898rEchLE11Hxswc7T30pLK
         2O+MKFlnqDcVEz5ruezg8x1Ai/NikDvgXgH2fmsAZ/hSPcjAF05xmpZ4GZHf9/5W3xAC
         Up7lG5UrOPN6/ypkOQwl3QZcVGhEXkVLSFHGWtMOdSA9dDs5+dlld4t5lgceOZBqXlKR
         lljqWvg2tlTaaAqpBsSJENrJEXhv2Sl8fgiceajvx+sZHuh+NaZqzCcjQanB2vcFOS4u
         hbXg==
X-Gm-Message-State: AOAM533TAgnZCGK6DgZWQviTpk/99ZZ3wmPNLnO022MMlg5AfOS/MZpW
        7ec2CkOJOIbli7ZR+c+G3lTou8BX2Ggp1GrwYGlj5ufTP2e7dKkwOw6OV5mr5Qh9wBA6gHdMiBN
        okB2I6wJtsX4eJHR65kV+Ta83x3oNzK2fTyFomSmi
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr2602783lfv.481.1636100815370;
        Fri, 05 Nov 2021 01:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1lk1IHmZF2VRD4tIl/fiY97kCzG9s/LGGkReF2P00eY1fmJoXffMV1n/dg4MqV0azD1df40tTorEe1M3GYYE=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr2602770lfv.481.1636100815144;
 Fri, 05 Nov 2021 01:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211104161729.258294-1-sgarzare@redhat.com> <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <20211105080454.wpvtwa7el45kayem@steredhat>
In-Reply-To: <20211105080454.wpvtwa7el45kayem@steredhat>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 5 Nov 2021 16:26:44 +0800
Message-ID: <CACGkMEvNZKc2K_bdKxiUmbLzoZL-Vdbc14+uw9Ro-2jzdFMRRw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: add driver_override support
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Parav Pandit <parav@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 4:05 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Fri, Nov 05, 2021 at 11:01:30AM +0800, Jason Wang wrote:
> >On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> `driver_override` allows to control which of the vDPA bus drivers
> >> binds to a vDPA device.
> >>
> >> If `driver_override` is not set, the previous behaviour is followed:
> >> devices use the first vDPA bus driver loaded (unless auto binding
> >> is disabled).
> >>
> >> Tested on Fedora 34 with driverctl(8):
> >>   $ modprobe virtio-vdpa
> >>   $ modprobe vhost-vdpa
> >>   $ modprobe vdpa-sim-net
> >>
> >>   $ vdpa dev add mgmtdev vdpasim_net name dev1
> >>
> >>   # dev1 is attached to the first vDPA bus driver loaded
> >>   $ driverctl -b vdpa list-devices
> >>     dev1 virtio_vdpa
> >>
> >>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
> >>
> >>   $ driverctl -b vdpa list-devices
> >>     dev1 vhost_vdpa [*]
> >>
> >>   Note: driverctl(8) integrates with udev so the binding is
> >>   preserved.
> >>
> >> Suggested-by: Jason Wang <jasowang@redhat.com>
> >> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> ---
> >>  include/linux/vdpa.h |  2 ++
> >>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 76 insertions(+)
> >>
> >> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >> index c3011ccda430..ae34015b37b7 100644
> >> --- a/include/linux/vdpa.h
> >> +++ b/include/linux/vdpa.h
> >> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
> >>   * struct vdpa_device - representation of a vDPA device
> >>   * @dev: underlying device
> >>   * @dma_dev: the actual device that is performing DMA
> >> + * @driver_override: driver name to force a match
> >
> >This seems useless?
>
> I'm a bit lost, do you mean we should remove the documentation of
> `driver_override`?

I misread the code which was misled by vdpa_mgmt_dev above:(

The code should be fine.

So:

Acked-by: Jason Wang <jasowang@redhat.com>

>
> >
> >>   * @config: the configuration ops for this device.
> >>   * @cf_mutex: Protects get and set access to configuration layout.
> >>   * @index: device index
> >> @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
> >>  struct vdpa_device {
> >>         struct device dev;
> >>         struct device *dma_dev;
> >> +       const char *driver_override;
> >>         const struct vdpa_config_ops *config;
> >>         struct mutex cf_mutex; /* Protects get/set config */
> >>         unsigned int index;
> >> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >> index 7332a74a4b00..659231bbfee8 100644
> >> --- a/drivers/vdpa/vdpa.c
> >> +++ b/drivers/vdpa/vdpa.c
> >> @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
> >>                 drv->remove(vdev);
> >>  }
> >>
> >> +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> >> +{
> >> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> >> +
> >> +       /* Check override first, and if set, only use the named driver */
> >> +       if (vdev->driver_override)
> >> +               return strcmp(vdev->driver_override, drv->name) == 0;
> >> +
> >> +       /* Currently devices must be supported by all vDPA bus
> >> drivers */
> >> +       return 1;
> >> +}
> >> +
> >> +static ssize_t driver_override_store(struct device *dev,
> >> +                                    struct device_attribute *attr,
> >> +                                    const char *buf, size_t count)
> >> +{
> >> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> >> +       const char *driver_override, *old;
> >> +       char *cp;
> >> +
> >> +       /* We need to keep extra room for a newline */
> >> +       if (count >= (PAGE_SIZE - 1))
> >> +               return -EINVAL;
> >> +
> >> +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> >> +       if (!driver_override)
> >> +               return -ENOMEM;
> >> +
> >> +       cp = strchr(driver_override, '\n');
> >> +       if (cp)
> >> +               *cp = '\0';
> >> +
> >> +       device_lock(dev);
> >> +       old = vdev->driver_override;
> >> +       if (strlen(driver_override)) {
> >> +               vdev->driver_override = driver_override;
> >> +       } else {
> >> +               kfree(driver_override);
> >> +               vdev->driver_override = NULL;
> >> +       }
> >> +       device_unlock(dev);
> >> +
> >> +       kfree(old);
> >> +
> >> +       return count;
> >> +}
> >> +
> >> +static ssize_t driver_override_show(struct device *dev,
> >> +                                   struct device_attribute *attr, char *buf)
> >> +{
> >> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> >> +       ssize_t len;
> >> +
> >> +       device_lock(dev);
> >> +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> >> +       device_unlock(dev);
> >> +
> >> +       return len;
> >> +}
> >> +static DEVICE_ATTR_RW(driver_override);
> >> +
> >> +static struct attribute *vdpa_dev_attrs[] = {
> >> +       &dev_attr_driver_override.attr,
> >> +       NULL,
> >> +};
> >> +
> >> +static const struct attribute_group vdpa_dev_group = {
> >> +       .attrs  = vdpa_dev_attrs,
> >> +};
> >> +__ATTRIBUTE_GROUPS(vdpa_dev);
> >> +
> >>  static struct bus_type vdpa_bus = {
> >>         .name  = "vdpa",
> >> +       .dev_groups = vdpa_dev_groups,
> >
> >This reminds me that we probably need to document the sysfs interface
> >in Documentation/ABI/testing/sysfs-bus-vdpa.
> >
>
> Yeah, I'd like to add more documentation. We should also document the
> device life cycle and management API.
>
> It's on my to-do list, I'm prioritizing it!
>
> >But it's not the fault of this patch which look good.
>
> Thanks,
> Stefano
>

