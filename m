Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91433445E2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 04:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhKEDE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 23:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230456AbhKEDEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 23:04:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636081306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcVO00wDG3/7AXHkZK3miwrP0gG7cy3EGjc+undENaY=;
        b=SgpEzgIrZ1m5lXgFqt3zQBegswZxoMnmVw+tS8X3YNVmQSIjpbUX1d01xluufJE39mpScg
        HE/fP8yDsHkDxpWNhW8W718xKp+EnEhNLkVXIk//DetKf9JwNWWheR7mSvEQGXetCbqHo0
        DX24yVDMC/AEtDUmd4xvDYqYJe+DwT8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-iEyPolouN_W8oG4lzTphAA-1; Thu, 04 Nov 2021 23:01:43 -0400
X-MC-Unique: iEyPolouN_W8oG4lzTphAA-1
Received: by mail-lf1-f69.google.com with SMTP id d10-20020a0565123d0a00b004002359a671so2909653lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Nov 2021 20:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcVO00wDG3/7AXHkZK3miwrP0gG7cy3EGjc+undENaY=;
        b=swK8uXgOTDrC/1+1ziuWD4koGYEyNuWe4Cv+FHQmnEWhzq9JphZZuIdXYgalngO1sX
         zYolPf1evHBGCgbMysCs5I8rjSg+AT3SJfPXqRJzmavjEnYFG1RNYSu5gFO92ZWFRna1
         5eNabWi/zMwaFqg22xVRQ5ey9/CatWZyiLI3g1JvzqVZOpeXGxQU3RMQdiW/z/yBMJjH
         MFCRj+H8Rm4lO8cAYmzIM5h5E3F9ocwdKONfZG65SdSOAKJ7QwkFXGFf0dmhwRChwOIL
         URLbTMaxK+6DQkEvETC0PMtBJF6T0l0ygF0/GVmmFrj185jy+Bkne5pZoFSE5EkaZ6OA
         cfag==
X-Gm-Message-State: AOAM53377KeYzRNAPbnbysg0TRduqM23F72BCE0DfJlPtog7o+lbp5db
        HnboqiLKgAKUY8xzCBigcJB00wkiZUIeob33gOYSl1Ljv1EuP+EHBSQ2vUrfg+6avr9Y62CNPJ3
        wHJAYT2LYcwSKmh0o9/HPn61lDtq71rH3K8BhwXGN
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr1340973lfv.481.1636081301366;
        Thu, 04 Nov 2021 20:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwezlMuIYNRg+i0rnCYAaH8TrP3L2Sehq7N5kofOgk9vnvg0RBzhfss1WoHy/9cYyAadcV9heoPm4Q4BfWNPe0=
X-Received: by 2002:a05:6512:3d09:: with SMTP id d9mr1340957lfv.481.1636081301154;
 Thu, 04 Nov 2021 20:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211104161729.258294-1-sgarzare@redhat.com>
In-Reply-To: <20211104161729.258294-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 5 Nov 2021 11:01:30 +0800
Message-ID: <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
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

On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> `driver_override` allows to control which of the vDPA bus drivers
> binds to a vDPA device.
>
> If `driver_override` is not set, the previous behaviour is followed:
> devices use the first vDPA bus driver loaded (unless auto binding
> is disabled).
>
> Tested on Fedora 34 with driverctl(8):
>   $ modprobe virtio-vdpa
>   $ modprobe vhost-vdpa
>   $ modprobe vdpa-sim-net
>
>   $ vdpa dev add mgmtdev vdpasim_net name dev1
>
>   # dev1 is attached to the first vDPA bus driver loaded
>   $ driverctl -b vdpa list-devices
>     dev1 virtio_vdpa
>
>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>
>   $ driverctl -b vdpa list-devices
>     dev1 vhost_vdpa [*]
>
>   Note: driverctl(8) integrates with udev so the binding is
>   preserved.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  include/linux/vdpa.h |  2 ++
>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..ae34015b37b7 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>   * struct vdpa_device - representation of a vDPA device
>   * @dev: underlying device
>   * @dma_dev: the actual device that is performing DMA
> + * @driver_override: driver name to force a match

This seems useless?

>   * @config: the configuration ops for this device.
>   * @cf_mutex: Protects get and set access to configuration layout.
>   * @index: device index
> @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
>  struct vdpa_device {
>         struct device dev;
>         struct device *dma_dev;
> +       const char *driver_override;
>         const struct vdpa_config_ops *config;
>         struct mutex cf_mutex; /* Protects get/set config */
>         unsigned int index;
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..659231bbfee8 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
>                 drv->remove(vdev);
>  }
>
> +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
> +{
> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> +
> +       /* Check override first, and if set, only use the named driver */
> +       if (vdev->driver_override)
> +               return strcmp(vdev->driver_override, drv->name) == 0;
> +
> +       /* Currently devices must be supported by all vDPA bus drivers */
> +       return 1;
> +}
> +
> +static ssize_t driver_override_store(struct device *dev,
> +                                    struct device_attribute *attr,
> +                                    const char *buf, size_t count)
> +{
> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> +       const char *driver_override, *old;
> +       char *cp;
> +
> +       /* We need to keep extra room for a newline */
> +       if (count >= (PAGE_SIZE - 1))
> +               return -EINVAL;
> +
> +       driver_override = kstrndup(buf, count, GFP_KERNEL);
> +       if (!driver_override)
> +               return -ENOMEM;
> +
> +       cp = strchr(driver_override, '\n');
> +       if (cp)
> +               *cp = '\0';
> +
> +       device_lock(dev);
> +       old = vdev->driver_override;
> +       if (strlen(driver_override)) {
> +               vdev->driver_override = driver_override;
> +       } else {
> +               kfree(driver_override);
> +               vdev->driver_override = NULL;
> +       }
> +       device_unlock(dev);
> +
> +       kfree(old);
> +
> +       return count;
> +}
> +
> +static ssize_t driver_override_show(struct device *dev,
> +                                   struct device_attribute *attr, char *buf)
> +{
> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
> +       ssize_t len;
> +
> +       device_lock(dev);
> +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
> +       device_unlock(dev);
> +
> +       return len;
> +}
> +static DEVICE_ATTR_RW(driver_override);
> +
> +static struct attribute *vdpa_dev_attrs[] = {
> +       &dev_attr_driver_override.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group vdpa_dev_group = {
> +       .attrs  = vdpa_dev_attrs,
> +};
> +__ATTRIBUTE_GROUPS(vdpa_dev);
> +
>  static struct bus_type vdpa_bus = {
>         .name  = "vdpa",
> +       .dev_groups = vdpa_dev_groups,

This reminds me that we probably need to document the sysfs interface
in Documentation/ABI/testing/sysfs-bus-vdpa.

But it's not the fault of this patch which look good.

Thanks

> +       .match = vdpa_dev_match,
>         .probe = vdpa_dev_probe,
>         .remove = vdpa_dev_remove,
>  };
> @@ -68,6 +141,7 @@ static void vdpa_release_dev(struct device *d)
>
>         ida_simple_remove(&vdpa_index_ida, vdev->index);
>         mutex_destroy(&vdev->cf_mutex);
> +       kfree(vdev->driver_override);
>         kfree(vdev);
>  }
>
> --
> 2.31.1
>

