Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D240413B09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 21:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbhIUT5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 15:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232052AbhIUT5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 15:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632254165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oLzwRXGzw6x+C1v9j0yrnbrduVN9978/t8EjVYLLyME=;
        b=FpItfJjY9ixQKF+Fbik9AlBIbs1uFIbATbRTsueLrWUvjjm4bRXA9HJ6jz3QMYZgXVL2vi
        zkNjZXgAYSQxK9b7gUDm6df+HKHbl6xNnFTwBSJoyB8HbsjzzvHcwgho/TZnHYYdRbebCX
        F4eKp2KT80PXuv0H4ydk6L6DmRkgzVg=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-s7b5WObMPSizqbayLneECQ-1; Tue, 21 Sep 2021 15:56:04 -0400
X-MC-Unique: s7b5WObMPSizqbayLneECQ-1
Received: by mail-oo1-f71.google.com with SMTP id a24-20020a4a9b18000000b002a989240dc3so98639ook.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 12:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLzwRXGzw6x+C1v9j0yrnbrduVN9978/t8EjVYLLyME=;
        b=wNXM4C60fUlfFVbux6bV2PjShnZV9hCEmjMPzJYTenCQ2Ulbk1NPiGZa0LHq/UM/3b
         /LKwFlnkagssC/ySXHlNvtFX5QHYTDqDhKGftn4UGX6OyWnVIMaR1z3ZjrefBC16XiQI
         1RlnZevxoIzvyIh0a6gY9GUL/pLCOIem/aMWfdMNpzPlA8PnKqmbpa7+ehSkg+/NjDoO
         NsYA4AAuXkqwwMLDjslw2Ju+90WjICTArmpd+cIbcyYoacPLflfLfD+iQRo+XaoI0YG7
         0GAR/M3ahbyOqRLogwyb45DoPPWIzuS+HOBT3cm2Gjx3yZVyeWf9vkgUEHYk46U4P12k
         f2+Q==
X-Gm-Message-State: AOAM531RQV4mZkrXC0wrMI6tuoM5aR3MBj2Y5g20itJUS8pJsYQ6OIw/
        vlbMhAk38H1h73ko9qcKQkLtK58VfNdveh5Ov3eT3E+U11zTLY/d/GTzVMKkn0QekIYTMcME0Pm
        qnN2xwbTEoHaD6f7Ph30x/rHS
X-Received: by 2002:a05:6808:57:: with SMTP id v23mr5129805oic.172.1632254164031;
        Tue, 21 Sep 2021 12:56:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoOu2++jQHPmZljv5zNozGgELfd2kP7Ma8jcLIdKYbhKK+ntKv4cH2e/ruocpLeO/GYmaibg==
X-Received: by 2002:a05:6808:57:: with SMTP id v23mr5129791oic.172.1632254163793;
        Tue, 21 Sep 2021 12:56:03 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id a8sm471046otv.14.2021.09.21.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 12:56:03 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:56:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Liu Yi L <yi.l.liu@intel.com>
Cc:     jgg@nvidia.com, hch@lst.de, jasowang@redhat.com, joro@8bytes.org,
        jean-philippe@linaro.org, kevin.tian@intel.com, parav@mellanox.com,
        lkml@metux.net, pbonzini@redhat.com, lushenming@huawei.com,
        eric.auger@redhat.com, corbet@lwn.net, ashok.raj@intel.com,
        yi.l.liu@linux.intel.com, jun.j.tian@intel.com, hao.wu@intel.com,
        dave.jiang@intel.com, jacob.jun.pan@linux.intel.com,
        kwankhede@nvidia.com, robin.murphy@arm.com, kvm@vger.kernel.org,
        iommu@lists.linux-foundation.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, baolu.lu@linux.intel.com,
        david@gibson.dropbear.id.au, nicolinc@nvidia.com
Subject: Re: [RFC 02/20] vfio: Add device class for /dev/vfio/devices
Message-ID: <20210921135601.3393f51b.alex.williamson@redhat.com>
In-Reply-To: <20210919063848.1476776-3-yi.l.liu@intel.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
        <20210919063848.1476776-3-yi.l.liu@intel.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2021 14:38:30 +0800
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch introduces a new interface (/dev/vfio/devices/$DEVICE) for
> userspace to directly open a vfio device w/o relying on container/group
> (/dev/vfio/$GROUP). Anything related to group is now hidden behind
> iommufd (more specifically in iommu core by this RFC) in a device-centric
> manner.
> 
> In case a device is exposed in both legacy and new interfaces (see next
> patch for how to decide it), this patch also ensures that when the device
> is already opened via one interface then the other one must be blocked.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio.c  | 228 +++++++++++++++++++++++++++++++++++++++----
>  include/linux/vfio.h |   2 +
>  2 files changed, 213 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 02cc51ce6891..84436d7abedd 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
...
> @@ -2295,6 +2436,52 @@ static struct miscdevice vfio_dev = {
>  	.mode = S_IRUGO | S_IWUGO,
>  };
>  
> +static char *vfio_device_devnode(struct device *dev, umode_t *mode)
> +{
> +	return kasprintf(GFP_KERNEL, "vfio/devices/%s", dev_name(dev));
> +}

dev_name() doesn't provide us with any uniqueness guarantees, so this
could potentially generate naming conflicts.  The similar scheme for
devices within an iommu group appends an instance number if a conflict
occurs, but that solution doesn't work here where the name isn't just a
link to the actual device.  Devices within an iommu group are also
likely associated within a bus_type, so the potential for conflict is
pretty negligible, that's not the case as vfio is adopted for new
device types.  Thanks,

Alex

