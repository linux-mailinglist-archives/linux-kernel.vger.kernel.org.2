Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22F0438D69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhJYCTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhJYCTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635128248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYNZwC/fZIiCDsDJV++nVrgkwMv82Wn8FjvaRuBUZEE=;
        b=EPpdudTB5aC5bDJUeVeUiDu5FMnbR5x+cXFKdJNlLTCZkta7lEWcg6OjTjHWFo+XETsx1g
        xP+EJcQj3/UWZEz4gwiEo7X1VNupCdV70hc1YfG+AEuUd48NCueHvWnC7mTm6JpRPKkc3h
        RwUFW6YQX0bIlTKYpYerL1U2EorlLmk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-k5rpUJknPdqF6xLZ3I_9TQ-1; Sun, 24 Oct 2021 22:17:27 -0400
X-MC-Unique: k5rpUJknPdqF6xLZ3I_9TQ-1
Received: by mail-lj1-f199.google.com with SMTP id 136-20020a2e098e000000b002110b902242so2215775ljj.20
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:17:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYNZwC/fZIiCDsDJV++nVrgkwMv82Wn8FjvaRuBUZEE=;
        b=7HD0TbdyYHfe4LCaYq6u/6unveKWIAe8MmeyUN+tunswYA7UtnagYwHWglyjz6OCpC
         1ZT4UvLCtTOqfqDPDGctGV4g/VOLcVrU/OncX8WgwL/eaJhejRA0CCHMG3b6ZTNHc6yj
         2wBJ6Nye/3RYfu/UdUbohRlCwM2Og5KkTq2Uj9UHMiPFJRw77wR9XR1HteOHYhAXP/9K
         t5LkGA9VJzD+Z7bxQjPXUZeF88B8UXnGN/9/Ggla47/F3K4HGd8ydxCXawHWC1tq5wgg
         ypJD+t+Um/RBx9yykhy5eH3SfoMACx3j/sy4uy37Js8eHmn8Ffk1M2aCXQaF8XdmvdOG
         qtLg==
X-Gm-Message-State: AOAM530PdPFS5BuO99QBr8dSfl2cL0Q8z1pweFNupBhT41S2syqTOKtl
        nSjZ8qxiTPJ4CqVUMAsmrxza6v1s03ZpqDLcWC6+0PczuPsr+GDT6ZBDgwf+UhTqK2W4HxG9Ra/
        GuUItZDuFrxCyDsIPD5H68kEk51cxwpIxa2yhajld
X-Received: by 2002:a2e:7212:: with SMTP id n18mr15985533ljc.369.1635128245585;
        Sun, 24 Oct 2021 19:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFukfsVribLNvTMwxoWwh/QVqaKbDCRMQhMmgOcWV1PaxOsT5eTeUPQu0mgIIqEqBlIWmq4kTr9AmMRYYklcA=
X-Received: by 2002:a2e:7212:: with SMTP id n18mr15985502ljc.369.1635128245356;
 Sun, 24 Oct 2021 19:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <7e4d859949fa37fce2289a4b287843cdeffcaf8a.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <7e4d859949fa37fce2289a4b287843cdeffcaf8a.1634870456.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Oct 2021 10:17:14 +0800
Message-ID: <CACGkMEsHNStd_rF3s7h+mD9zQBAiLpvMGAhQmGyV+o3KryTpww@mail.gmail.com>
Subject: Re: [PATCH v6 4/8] vdpa: add new callback get_vq_num_min in vdpa_config_ops
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:44 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> This callback is optional. For vdpa devices that not support to change
> virtqueue size, get_vq_num_min and get_vq_num_max will return the same
> value, so that users can choose a correct value for that device.
>
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  include/linux/vdpa.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index a896ee021e5f..30864848950b 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -171,6 +171,9 @@ struct vdpa_map_file {
>   * @get_vq_num_max:            Get the max size of virtqueue
>   *                             @vdev: vdpa device
>   *                             Returns u16: max size of virtqueue
> + * @get_vq_num_min:            Get the min size of virtqueue (optional)
> + *                             @vdev: vdpa device
> + *                             Returns u16: min size of virtqueue
>   * @get_device_id:             Get virtio device id
>   *                             @vdev: vdpa device
>   *                             Returns u32: virtio device id
> @@ -266,6 +269,7 @@ struct vdpa_config_ops {
>         void (*set_config_cb)(struct vdpa_device *vdev,
>                               struct vdpa_callback *cb);
>         u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> +       u16 (*get_vq_num_min)(struct vdpa_device *vdev);
>         u32 (*get_device_id)(struct vdpa_device *vdev);
>         u32 (*get_vendor_id)(struct vdpa_device *vdev);
>         u8 (*get_status)(struct vdpa_device *vdev);
> --
> 2.31.1
>

