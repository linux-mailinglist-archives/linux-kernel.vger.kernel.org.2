Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D89438D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 04:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbhJYCZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 22:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229706AbhJYCZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 22:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635128564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KyuFm/8mAjQNFS23VkPEB01/D6yLisum1kkP7ofok3s=;
        b=Kv0lQB43fLy35kR/sL0J/s64m4O50XT06yN8zt/f0pySYsF5U6FZF+PJn/32I0odkOm1zt
        5AbtwnHrrmkRAJHDxPth3xL0/Dst91pW611cIhGZ6UWXK8ZFcTlN31Yn+jurl0IKo42tDQ
        XcxNmop3I1SM0Zv5rFhEDtWnu3SGOAo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-3oZBP36aN4acDuvNEkpwhw-1; Sun, 24 Oct 2021 22:22:43 -0400
X-MC-Unique: 3oZBP36aN4acDuvNEkpwhw-1
Received: by mail-lf1-f69.google.com with SMTP id p10-20020a056512234a00b003fe188e9960so4524278lfu.19
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 19:22:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KyuFm/8mAjQNFS23VkPEB01/D6yLisum1kkP7ofok3s=;
        b=LJ9GrgNYVJtKCSBJi8GrxRJar39m790Q08JsGdZHFfXk2i4ebrUIDdiFSWqs/mFaoX
         lXAFLQIioCDkdjB9KsKntO4L6lnAHkUFPbpqbGrR8IKhAsJniWm42Q2Am87wzBzr2EK9
         x1HdwLhk/nEprYaShDvxvAe4hbPbxRCRNOdHPvcHCFsX5TuiNrcXKUV6YPPfLOP9o480
         qQIcgE9zTQtcdGvRaZdWcW7cevFj3Nu45BH/sLlBy9NyqXGkONernVZJgVCSyeY8+hYu
         g7eiyffpeo0H86GZKMHS2m2P35suSeBR0vIGqCuD4Nq4Bg4ry3GR8ob6GVyljrUwS/Ni
         ZAZQ==
X-Gm-Message-State: AOAM530mlCRhyx/RgF3iKWT+Cj2qQsThif1wn319HBXMosJLRjmD3a5S
        OLh7x+4ku+kJTj+Y7VGrWfV9/2UxoJbi4ayoePediPmKFNrYS8BD//UfzDPDAD8MhXLHEai1ujD
        CdAAqivVC2rS2nnuTTTQSIuGaPcREadM5MAxridUB
X-Received: by 2002:a2e:7105:: with SMTP id m5mr16376151ljc.420.1635128561276;
        Sun, 24 Oct 2021 19:22:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4utO5eZEoQTVrJtOjRrLjeX8X5Tdh3Qp+l8Pwh0LwpxH7OqWbDoVbH0crY/JRbeIOJQoAgUe2Ap4AeHH6X0s=
X-Received: by 2002:a2e:7105:: with SMTP id m5mr16376134ljc.420.1635128561062;
 Sun, 24 Oct 2021 19:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634281805.git.wuzongyong@linux.alibaba.com>
 <cover.1634870456.git.wuzongyong@linux.alibaba.com> <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <c75b4499f7ead922daa19bf67b32eed6f185d260.1634870456.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 25 Oct 2021 10:22:30 +0800
Message-ID: <CACGkMEtNECAUtpEvLvEpTFKfbYRC7YQKnHDnjxR3k9Hap1tmig@mail.gmail.com>
Subject: Re: [PATCH v6 6/8] virtio_vdpa: setup correct vq size with callbacks get_vq_num_{max,min}
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:45 AM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> For the devices which implement the get_vq_num_min callback, the driver
> should not negotiate with virtqueue size with the backend vdpa device if
> the value returned by get_vq_num_min equals to the value returned by
> get_vq_num_max.
> This is useful for vdpa devices based on legacy virtio specfication.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_vdpa.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..e42ace29daa1 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -145,7 +145,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>         /* Assume split virtqueue, switch to packed if necessary */
>         struct vdpa_vq_state state = {0};
>         unsigned long flags;
> -       u32 align, num;
> +       u32 align, max_num, min_num = 0;
> +       bool may_reduce_num = true;
>         int err;
>
>         if (!name)
> @@ -163,22 +164,32 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>         if (!info)
>                 return ERR_PTR(-ENOMEM);
>
> -       num = ops->get_vq_num_max(vdpa);
> -       if (num == 0) {
> +       max_num = ops->get_vq_num_max(vdpa);
> +       if (max_num == 0) {
>                 err = -ENOENT;
>                 goto error_new_virtqueue;
>         }
>
> +       if (ops->get_vq_num_min)
> +               min_num = ops->get_vq_num_min(vdpa);
> +
> +       may_reduce_num = (max_num == min_num) ? false : true;
> +
>         /* Create the vring */
>         align = ops->get_vq_align(vdpa);
> -       vq = vring_create_virtqueue(index, num, align, vdev,
> -                                   true, true, ctx,
> +       vq = vring_create_virtqueue(index, max_num, align, vdev,
> +                                   true, may_reduce_num, ctx,
>                                     virtio_vdpa_notify, callback, name);
>         if (!vq) {
>                 err = -ENOMEM;
>                 goto error_new_virtqueue;
>         }
>
> +       if (virtqueue_get_vring_size(vq) < min_num) {
> +               err = -EINVAL;
> +               goto err_vq;
> +       }

I wonder under which case can we hit this?

Thanks

> +
>         /* Setup virtqueue callback */
>         cb.callback = virtio_vdpa_virtqueue_cb;
>         cb.private = info;
> --
> 2.31.1
>

