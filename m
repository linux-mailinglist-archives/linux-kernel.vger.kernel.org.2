Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E244606A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 09:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbhKEIHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 04:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229473AbhKEIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 04:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636099501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XCMVMpxrIHYy5glS6Ql48RFNndwZCFbpRRPCZXnVaeE=;
        b=YXcaUCHlUvcmQno07m1Gd5wnLaeNfa1f86u9mHqa3cKGEh2+Mr1xR6ACZcYJBdqobjagRK
        1CiNKccst/ajdzNxBhUm2dSlbThhodDpCf5iR2ZViEDRbd7EZxo7RBQHNem5JewMeX5KIo
        sil+OMNNEhZhBihQdSvXe8H6E5CjzDI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-RkRvkVV-MoensM1R_APcVA-1; Fri, 05 Nov 2021 04:05:00 -0400
X-MC-Unique: RkRvkVV-MoensM1R_APcVA-1
Received: by mail-ed1-f70.google.com with SMTP id m8-20020a056402510800b003e29de5badbso8095019edd.18
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 01:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCMVMpxrIHYy5glS6Ql48RFNndwZCFbpRRPCZXnVaeE=;
        b=7R9qrwGi3X7U1idFu6hLyCzzm+v5Eh/P0o8jdT58W/UNWtLaeeO4HvJ2d2rNoK72yZ
         krauUtAjvEmnZ5SNKkBsOoltEvU7mOZdfUjsw0OZZpWYJWAc7pEpSqyWxx1j5hZXAX73
         h9VHS/oVax7Mz4mrCHK5ZCkSZ4xKpn4pPi9ZTxJZFc0mPNgN2jq31CXy1Wes3Nm7THRK
         egqxJVrk8ltJI3RJbHv/pbXreYLg/Jqaog21zGqTk+1ozRHVdOjZDb/akGxTxRQcvZqC
         YKi7OUCoXYNmO+oGMW0RFQv7eJRzEpqnbr6D5LQDzmfkmliYSlFgYLgnxw3pRb95LNQH
         OfWA==
X-Gm-Message-State: AOAM533TiB3y/WbpAFkKorFACbrDa8tH4CasxKFubqDWAzgecEWpRWLu
        010LEDQ4Oa0y+QIWA/gZ24zSMFOQjQmnKRZB2Ef3NhhFLEDDJ4RP42HmrKXwyXLR9xC6HKwXIGV
        AczNMvUsBr46bfOZDaFKjPMqY
X-Received: by 2002:a17:906:a182:: with SMTP id s2mr70153844ejy.176.1636099498558;
        Fri, 05 Nov 2021 01:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSTcJO6+jWKa3gHLxkTXZen/dGH+uiq5xtfJ9LgobdkY8UNBy/j2NC/TfFpcHFa9el2YpYmA==
X-Received: by 2002:a17:906:a182:: with SMTP id s2mr70153817ejy.176.1636099498327;
        Fri, 05 Nov 2021 01:04:58 -0700 (PDT)
Received: from steredhat (host-87-10-72-39.retail.telecomitalia.it. [87.10.72.39])
        by smtp.gmail.com with ESMTPSA id gn26sm418635ejc.14.2021.11.05.01.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 01:04:57 -0700 (PDT)
Date:   Fri, 5 Nov 2021 09:04:54 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        Parav Pandit <parav@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa: add driver_override support
Message-ID: <20211105080454.wpvtwa7el45kayem@steredhat>
References: <20211104161729.258294-1-sgarzare@redhat.com>
 <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEsTxO0-pASV_4MohEs0dkP+7eahVuWiSZSOcffuG5ZV3A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 11:01:30AM +0800, Jason Wang wrote:
>On Fri, Nov 5, 2021 at 12:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> `driver_override` allows to control which of the vDPA bus drivers
>> binds to a vDPA device.
>>
>> If `driver_override` is not set, the previous behaviour is followed:
>> devices use the first vDPA bus driver loaded (unless auto binding
>> is disabled).
>>
>> Tested on Fedora 34 with driverctl(8):
>>   $ modprobe virtio-vdpa
>>   $ modprobe vhost-vdpa
>>   $ modprobe vdpa-sim-net
>>
>>   $ vdpa dev add mgmtdev vdpasim_net name dev1
>>
>>   # dev1 is attached to the first vDPA bus driver loaded
>>   $ driverctl -b vdpa list-devices
>>     dev1 virtio_vdpa
>>
>>   $ driverctl -b vdpa set-override dev1 vhost_vdpa
>>
>>   $ driverctl -b vdpa list-devices
>>     dev1 vhost_vdpa [*]
>>
>>   Note: driverctl(8) integrates with udev so the binding is
>>   preserved.
>>
>> Suggested-by: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  include/linux/vdpa.h |  2 ++
>>  drivers/vdpa/vdpa.c  | 74 ++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
>> index c3011ccda430..ae34015b37b7 100644
>> --- a/include/linux/vdpa.h
>> +++ b/include/linux/vdpa.h
>> @@ -64,6 +64,7 @@ struct vdpa_mgmt_dev;
>>   * struct vdpa_device - representation of a vDPA device
>>   * @dev: underlying device
>>   * @dma_dev: the actual device that is performing DMA
>> + * @driver_override: driver name to force a match
>
>This seems useless?

I'm a bit lost, do you mean we should remove the documentation of 
`driver_override`?

>
>>   * @config: the configuration ops for this device.
>>   * @cf_mutex: Protects get and set access to configuration layout.
>>   * @index: device index
>> @@ -76,6 +77,7 @@ struct vdpa_mgmt_dev;
>>  struct vdpa_device {
>>         struct device dev;
>>         struct device *dma_dev;
>> +       const char *driver_override;
>>         const struct vdpa_config_ops *config;
>>         struct mutex cf_mutex; /* Protects get/set config */
>>         unsigned int index;
>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
>> index 7332a74a4b00..659231bbfee8 100644
>> --- a/drivers/vdpa/vdpa.c
>> +++ b/drivers/vdpa/vdpa.c
>> @@ -52,8 +52,81 @@ static void vdpa_dev_remove(struct device *d)
>>                 drv->remove(vdev);
>>  }
>>
>> +static int vdpa_dev_match(struct device *dev, struct device_driver *drv)
>> +{
>> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> +
>> +       /* Check override first, and if set, only use the named driver */
>> +       if (vdev->driver_override)
>> +               return strcmp(vdev->driver_override, drv->name) == 0;
>> +
>> +       /* Currently devices must be supported by all vDPA bus 
>> drivers */
>> +       return 1;
>> +}
>> +
>> +static ssize_t driver_override_store(struct device *dev,
>> +                                    struct device_attribute *attr,
>> +                                    const char *buf, size_t count)
>> +{
>> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> +       const char *driver_override, *old;
>> +       char *cp;
>> +
>> +       /* We need to keep extra room for a newline */
>> +       if (count >= (PAGE_SIZE - 1))
>> +               return -EINVAL;
>> +
>> +       driver_override = kstrndup(buf, count, GFP_KERNEL);
>> +       if (!driver_override)
>> +               return -ENOMEM;
>> +
>> +       cp = strchr(driver_override, '\n');
>> +       if (cp)
>> +               *cp = '\0';
>> +
>> +       device_lock(dev);
>> +       old = vdev->driver_override;
>> +       if (strlen(driver_override)) {
>> +               vdev->driver_override = driver_override;
>> +       } else {
>> +               kfree(driver_override);
>> +               vdev->driver_override = NULL;
>> +       }
>> +       device_unlock(dev);
>> +
>> +       kfree(old);
>> +
>> +       return count;
>> +}
>> +
>> +static ssize_t driver_override_show(struct device *dev,
>> +                                   struct device_attribute *attr, char *buf)
>> +{
>> +       struct vdpa_device *vdev = dev_to_vdpa(dev);
>> +       ssize_t len;
>> +
>> +       device_lock(dev);
>> +       len = snprintf(buf, PAGE_SIZE, "%s\n", vdev->driver_override);
>> +       device_unlock(dev);
>> +
>> +       return len;
>> +}
>> +static DEVICE_ATTR_RW(driver_override);
>> +
>> +static struct attribute *vdpa_dev_attrs[] = {
>> +       &dev_attr_driver_override.attr,
>> +       NULL,
>> +};
>> +
>> +static const struct attribute_group vdpa_dev_group = {
>> +       .attrs  = vdpa_dev_attrs,
>> +};
>> +__ATTRIBUTE_GROUPS(vdpa_dev);
>> +
>>  static struct bus_type vdpa_bus = {
>>         .name  = "vdpa",
>> +       .dev_groups = vdpa_dev_groups,
>
>This reminds me that we probably need to document the sysfs interface
>in Documentation/ABI/testing/sysfs-bus-vdpa.
>

Yeah, I'd like to add more documentation. We should also document the 
device life cycle and management API.

It's on my to-do list, I'm prioritizing it!

>But it's not the fault of this patch which look good.

Thanks,
Stefano

