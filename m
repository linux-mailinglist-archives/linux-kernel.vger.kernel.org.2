Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C2144AECB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 14:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhKINev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 08:34:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230147AbhKINeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 08:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636464723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xi/depsgTJUGfIh8T6IcJPvCD2eD2wiILUV+a1Lv1R8=;
        b=X/uQIh+M+SjBSztL4V3/rb1vU8WAMYSSZST3WHG6pWw2bddRuHAynbRPn+Gv7uXKBxg3n2
        L04tUdn1nFV4YRPRY0waqLflNa/bS+m86gflTwBnKcOs7THTziAZnPpvWOZLTdxhSPl0xK
        gwEV41lz83dV+0S9nBj6/QH/KtnUkdA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-2xdzJDDRMoud0lpnexOqIQ-1; Tue, 09 Nov 2021 08:32:02 -0500
X-MC-Unique: 2xdzJDDRMoud0lpnexOqIQ-1
Received: by mail-ed1-f69.google.com with SMTP id t20-20020a056402525400b003e2ad6b5ee7so17933545edd.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 05:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xi/depsgTJUGfIh8T6IcJPvCD2eD2wiILUV+a1Lv1R8=;
        b=QTKv64oAgFEHlEV9JojXow50XECR5imiibQUwO/ClEQGthGPRG83NERMTTfM+ltEGg
         tPiZxlA8MPyihhv4PE/HRw7PTu0Z5E+46BRMgsjWNvdWnKAppNIV8AHQCur8Nt3+QZwx
         Wa5NApTSeiN3SOGbsK/cdlZrM4X0Ta9Uo4c+tdVNDa+hBk+wz3PU/7FzW/hu3PULp1In
         orkP5VOvtsFVMtaqJDli/WJMSQoTW+sjonEkfwE41QJujVz7tQbku38zz2gQeVlx9Wev
         FgZ5zVwzMMRkG3zIaXSpzUAXt9slvE3PZR4NxBwf8049zGYlCF++WU+XWKMy20CoWsJl
         cWjw==
X-Gm-Message-State: AOAM532iToa76DdVQzHcDh6VaI+C9W098hId7S+NvA7DB1PYHEFZFzp3
        bOrtKN+/zSgk909Yh769LV83ASEfsljUwLEvZyEpICDVJR4me/2NGnMkc+XMyI0YxDdl3zQLQlA
        AoOF4YASA4f9cZkC1FBtaAD1s
X-Received: by 2002:a17:906:dc91:: with SMTP id cs17mr9797709ejc.461.1636464721445;
        Tue, 09 Nov 2021 05:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSkw/5polRto4zRzObbvs88GZHehaeUwO1dovVj2zF7aswVXR/RIJcrS7mrkuWA1iEOzCQJw==
X-Received: by 2002:a17:906:dc91:: with SMTP id cs17mr9797675ejc.461.1636464721226;
        Tue, 09 Nov 2021 05:32:01 -0800 (PST)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id s12sm11032987edc.48.2021.11.09.05.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 05:32:00 -0800 (PST)
Date:   Tue, 9 Nov 2021 14:31:59 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Parav Pandit <parav@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211109133159.vfw3gyjwlw6xryy7@steredhat>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
 <CAGxU2F4NQz74f8sw51Ownm-25Jd7K=B_gK_-nRDKmmYvPx=+=w@mail.gmail.com>
 <20211109081042-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211109081042-mutt-send-email-mst@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 08:10:58AM -0500, Michael S. Tsirkin wrote:
>On Mon, Nov 08, 2021 at 06:05:29PM +0100, Stefano Garzarella wrote:
>> On Fri, Nov 5, 2021 at 4:01 AM Jason Wang <jasowang@redhat.com> wrote:
>> >
>> > On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >
>> > > `driver_override` allows to control which of the vDPA bus drivers
>> > > binds to a vDPA device.
>> > >
>> > > If `driver_override` is not set, the previous behaviour is followed:
>> > > devices use the first vDPA bus driver loaded (unless auto binding
>> > > is disabled).
>> > >
>> > > Tested on Fedora 34 with driverctl(8):
>> > >   $ modprobe virtio-vdpa
>> > >   $ modprobe vhost-vdpa
>> > >   $ modprobe vdpa-sim-net
>> > >
>> > >   $ vdpa dev add mgmtdev vdpasim_net name dev1
>> > >
>> > >   # dev1 is attached to the first vDPA bus driver loaded
>> > >   $ driverctl -b vdpa list-devices
>> > >     dev1 virtio_vdpa
>> > >
>> > >   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>> > >
>> > >   $ driverctl -b vdpa list-devices
>> > >     dev1 vhost_vdpa [*]
>> > >
>> > >   Note: driverctl(8) integrates with udev so the binding is
>> > >   preserved.
>> > >
>> > > Suggested-by: Jason Wang <jasowang@redhat.com>
>> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> > > ---
>> > >  include/linux/vdpa.h |  2 ++
>> > >  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>> > >  2 files changed, 76 insertions(+)
>> > >
>> > > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> > > index c3011ccda430..ae34015b37b7 100644
>> > > --- a/include/linux/vdpa.h
>> > > +++ b/include/linux/vdpa.h
>> > > @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>> > >   * struct vdpa_device - representation of a vDPA device
>> > >   * @dev: underlying device
>> > >   * @dma_dev: the actual device that is performing DMA
>> > > + * @driver_override: driver name to force a match
>> >
>> > This seems useless?
>> >
>> > >   * @config: the configuration ops for this device.
>> > >   * @cf_mutex: Protects get and set access to configuration layout.
>> > >   * @index: device index
>> > > @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
>> > >  struct vdpa_device {
>> > >         struct device dev;
>> > >         struct device *dma_dev;
>> > > +       const char *driver_override;
>> > >         const struct vdpa_config_ops *config;
>> > >         struct mutex cf_mutex; /* Protects get/set config */
>> > >         unsigned int index;
>> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> > > index 7332a74a4b00..659231bbfee8 100644
>> > > --- a/drivers/vdpa/vdpa.c
>> > > +++ b/drivers/vdpa/vdpa.c
>> > > @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
>> > >                 drv->remove(vdev);
>> > >  }
>> > >
>> > > +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
>> > > +{
>> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> > > +
>> > > +       /* Check override first, and if set, only use the named driver */
>> > > +       if (vdev->driver_override)
>> > > +               return strcmp(vdev->driver_override, drv->name) == 0;
>> > > +
>> > > +       /* Currently devices must be supported by all vDPA bus drivers */
>> > > +       return 1;
>> > > +}
>> > > +
>> > > +static ssize_t driver_override_store(struct device *dev,
>> > > +                                    struct device_attribute *attr,
>> > > +                                    const char *buf, size_t count)
>> > > +{
>> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> > > +       const char *driver_override, *old;
>> > > +       char *cp;
>> > > +
>> > > +       /* We need to keep extra room for a newline */
>> > > +       if (count >= (PAGE_SIZE - 1))
>> > > +               return -EINVAL;
>> > > +
>> > > +       driver_override = kstrndup(buf, count, GFP_KERNEL);
>> > > +       if (!driver_override)
>> > > +               return -ENOMEM;
>> > > +
>> > > +       cp = strchr(driver_override, '\n');
>> > > +       if (cp)
>> > > +               *cp = '\0';
>> > > +
>> > > +       device_lock(dev);
>> > > +       old = vdev->driver_override;
>> > > +       if (strlen(driver_override)) {
>> > > +               vdev->driver_override = driver_override;
>> > > +       } else {
>> > > +               kfree(driver_override);
>> > > +               vdev->driver_override = NULL;
>> > > +       }
>> > > +       device_unlock(dev);
>> > > +
>> > > +       kfree(old);
>> > > +
>> > > +       return count;
>> > > +}
>> > > +
>> > > +static ssize_t driver_override_show(struct device *dev,
>> > > +                                   struct device_attribute *attr, char *buf)
>> > > +{
>> > > +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> > > +       ssize_t len;
>> > > +
>> > > +       device_lock(dev);
>> > > +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
>> > > +       device_unlock(dev);
>> > > +
>> > > +       return len;
>> > > +}
>> > > +static DEVICE_ATTR_RW(driver_override);
>> > > +
>> > > +static struct attribute *vdpa_dev_attrs[] = {
>> > > +       &dev_attr_driver_override.attr,
>> > > +       NULL,
>> > > +};
>> > > +
>> > > +static const struct attribute_group vdpa_dev_group = {
>> > > +       .attrs  = vdpa_dev_attrs,
>> > > +};
>> > > +__ATTRIBUTE_GROUPS(vdpa_dev);
>> > > +
>> > >  static struct bus_type vdpa_bus = {
>> > >         .name  = "vdpa",
>> > > +       .dev_groups = vdpa_dev_groups,
>> >
>> > This reminds me that we probably need to document the sysfs interface
>> > in Documentation/ABI/testing/sysfs-bus-vdpa.
>> >
>> > But it's not the fault of this patch which look good.
>>
>> Michael, Jason, about Documentation/ABI/testing/sysfs-bus-vdpa, do you
>> think is better to send a follow up patch/series, maybe including also
>> others entries (e.g. bind, unbind) or a v2 including the documentation
>> of `driver_ovveride`?
>>
>> Thanks,
>> Stefano
>
>I'd include it as a patch in series.
>

Okay, so I'll send the documentation in a followup series.

Thanks,
Stefano

