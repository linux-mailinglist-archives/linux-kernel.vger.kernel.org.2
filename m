Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C854043CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349249AbhIIC4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:56:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34381 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349433AbhIIC40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631156117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bgl87DQRRkijdxiM7oIXHkWBZiVtL27pqax+4qDlhg4=;
        b=WrXABtbl5hLSlW77k+HSvAuixro/jQk9yUSaaRKtzpBQSktedbhxEjhTcTcPH+Aqo+p8pU
        pInFsykvR3om9yrcXJ47JWjCYrqn7aNzmju3Dc8ZarasdcwscPl//DjS3d9KsuCAhY0uFy
        jr+0eXG9QciFVtCVRrkBjoypxxRv7Xs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-8YuPTGTdOMCsAKuBBr4tXg-1; Wed, 08 Sep 2021 22:55:16 -0400
X-MC-Unique: 8YuPTGTdOMCsAKuBBr4tXg-1
Received: by mail-lf1-f69.google.com with SMTP id t3-20020a056512208300b003e74909096aso175189lfr.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 19:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgl87DQRRkijdxiM7oIXHkWBZiVtL27pqax+4qDlhg4=;
        b=tAYJn/qeMzC2XV1TKnushRVWx8gB62CaO8Zzv6/27uXL5cBcQZw+wz2CRhLBf9u+i8
         qoQ5rQioUzjYn59TFzho+0yUjaCtlZqc/82hpWXvl21NT7sY2z6tbj+B8y3Hf9KBEZJh
         XyqsPTdDdilD4RrM/qwwAXcu8LNfqcxBtisnf3/C7+SYdFcrlfjRCbWrTXx+9yQUvXfa
         ooidVoyfwmOXApinyYPcEOB81JTTQDK4sPgDM1aXHzNutj1mvyH4v64dsfJ3d2QUFMeV
         jwwmOkbAyNWYk1D1YruUWCZzivM2h80IsYpGBMmoTz+i2HUCtgkNNqgRws+0h1CpeBA2
         fUIA==
X-Gm-Message-State: AOAM53334qRbdX3rtyyyb3XscLxE8oN8y6q7jYAG9ZHAixxA92jqi1F1
        tYPUUAUY25K2tktZQwvGNywoIIAZ/ldG5PHnq3AzKCIFS+c5FLF6a8KO7WbqjIi+s/xx7rSokmA
        GywArGxmmML4VfUofGgjUWqvuxUXm7o8FYW1rNK0R
X-Received: by 2002:a19:6b18:: with SMTP id d24mr669709lfa.84.1631156114776;
        Wed, 08 Sep 2021 19:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhmyR+U2flIWze7kZBdb2cIbVOuqqDBkVuxY8OgBvAQGkyigpfw4hOpMgE2/3CRySLN5y8S4S+VnLYJ/w1Hb4=
X-Received: by 2002:a19:6b18:: with SMTP id d24mr669702lfa.84.1631156114587;
 Wed, 08 Sep 2021 19:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com> <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 9 Sep 2021 10:55:03 +0800
Message-ID: <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in vdpa_config_ops
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> This new callback is used to indicate whether the vring size can be
> change or not. It is useful when we have a legacy virtio pci device as
> the vdpa device for there is no way to negotiate the vring num by the
> specification.

So I'm not sure it's worth bothering. E.g what if we just fail
VHOST_SET_VRING_NUM it the value doesn't match what hardware has?

Thanks

>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
>  drivers/virtio/virtio_vdpa.c |  5 ++++-
>  include/linux/vdpa.h         |  4 ++++
>  include/uapi/linux/vhost.h   |  2 ++
>  4 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9479f7f79217..2204d27d1e5d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
>         return 0;
>  }
>
> +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> +                                                 u32 __user *argp)
> +{
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +       bool unchangeable = false;
> +
> +       if (ops->get_vq_num_unchangeable)
> +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> +
> +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>                                    void __user *argp)
>  {
> @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>         case VHOST_VDPA_GET_IOVA_RANGE:
>                 r = vhost_vdpa_get_iova_range(v, argp);
>                 break;
> +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> +               break;
>         default:
>                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>                 if (r == -ENOIOCTLCMD)
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..afb47465307a 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>         struct vdpa_vq_state state = {0};
>         unsigned long flags;
>         u32 align, num;
> +       bool may_reduce_num = true;
>         int err;
>
>         if (!name)
> @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>
>         /* Create the vring */
>         align = ops->get_vq_align(vdpa);
> +       if (ops->get_vq_num_unchangeable)
> +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
>         vq = vring_create_virtqueue(index, num, align, vdev,
> -                                   true, true, ctx,
> +                                   true, may_reduce_num, ctx,
>                                     virtio_vdpa_notify, callback, name);
>         if (!vq) {
>                 err = -ENOMEM;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 35648c11e312..f809b7ada00d 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -195,6 +195,9 @@ struct vdpa_iova_range {
>   *                             @vdev: vdpa device
>   *                             Returns the iova range supported by
>   *                             the device.
> + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> + *                             @vdev: vdpa device
> + *                             Returns boolean: unchangeable (true) or not (false)
>   * @set_map:                   Set device memory mapping (optional)
>   *                             Needed for device that using device
>   *                             specific DMA translation (on-chip IOMMU)
> @@ -262,6 +265,7 @@ struct vdpa_config_ops {
>                            const void *buf, unsigned int len);
>         u32 (*get_generation)(struct vdpa_device *vdev);
>         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..184f1f7f8498 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -150,4 +150,6 @@
>  /* Get the valid iova range */
>  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
>                                              struct vhost_vdpa_iova_range)
> +/* Check if the vring size can be change */
> +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
>  #endif
> --
> 2.31.1
>

