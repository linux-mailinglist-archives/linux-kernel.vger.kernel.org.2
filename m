Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6625840C1DC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 10:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbhIOIgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 04:36:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28678 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236985AbhIOIgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 04:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631694888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Calh83N3mQvO0vV6rtapTNlgbimD7jhmGtdFhVLLmTc=;
        b=N6IQLXS88rTdgXxzx37vVXN4Gckf8N6UsLAkMJDS3K2PwERGTcBi0uKz8Uy8/ookFauSY2
        84yzVZVpGOY1udQWg786cp/i4GP6NivqUtjjz0zoMRJXnqNsHhuaoLSGpDDYYmwfOZYOha
        3bvAxBEYF0aNN/AE7kAamkhD6IHg1Ws=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-ycXP184mP-WSRXbXAPyuVw-1; Wed, 15 Sep 2021 04:34:47 -0400
X-MC-Unique: ycXP184mP-WSRXbXAPyuVw-1
Received: by mail-lf1-f70.google.com with SMTP id x14-20020ac2488e000000b003d91325c257so815759lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 01:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Calh83N3mQvO0vV6rtapTNlgbimD7jhmGtdFhVLLmTc=;
        b=MmTAt0kMp0mfhQAADJ7YFxhz0zqwDQNnM1X+TWxRdRtSgDIWV0G7LoeD9xCZl/dAW/
         0bwTxaj++8NomI/Wax/m+E/Y/v/2/Qw1KoVaI+LtFBY+T3KwXQjBO92YZ4AzojqE8+ke
         oqsMh6Aaup7M0/k1svOHhd3XnPh3XX7GVnay2SZnIhSUAC/r+NV9bCuphQo7xcsVuIa7
         KiEOtX6OZtayIF2Ek2PqmJnPoznHFiBbWHsSy8kvyy+3j0rghWAdOPi31OxkskdOYxEA
         QuAZ6wAgExXfjXY+1sn7CKSoWF296YhTMcQvhu6cleRwZlp2TaJWEa+SXvaagpI4xPNN
         J0Dg==
X-Gm-Message-State: AOAM531qskyjKyK/VSjcfvPX1VWwJI/LGTtAARCNtaw0HHUKPFySaILo
        pVMstdqvE/dRNUcKYjzaxIzzr2zflPns/u8mKDTGo1oc8lnv7RmeHQXhPjZe8lJPQHrx4PD7zt1
        WXR97ddqZl0yUpkvbqRnf7kNF8ZggcXEHYv1TWFlb
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr14431615lfg.498.1631694885844;
        Wed, 15 Sep 2021 01:34:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5T2fCC4WDDyvm7zt30dXfSgqUOh45aXS5KM/cPFmSoMTgX0M9wgyPpewRx4S6ju6OZ//YROQwKAJl9EmHr4Y=
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr14431604lfg.498.1631694885678;
 Wed, 15 Sep 2021 01:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <02637d38dcf4e4b836c5b3a65055fe92bf812b3b.1631687872.git.wuzongyong@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 15 Sep 2021 16:34:34 +0800
Message-ID: <CACGkMEvnG40752Ksw7AMQrg9NpkYz_0Hmw8nKEskLNNOuKNTGw@mail.gmail.com>
Subject: Re: [PATCH] vhost_vdpa: unset vq irq before freeing irq
To:     Wu Zongyong <wuzongyong@linux.alibaba.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mst <mst@redhat.com>, tiwei.bie@intel.com,
        wei.yang1@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 2:39 PM Wu Zongyong
<wuzongyong@linux.alibaba.com> wrote:
>
> Currently we unset vq irq after freeing irq and that will result in
> error messages:

Nit: I think for 'we', it actually means the parent driver can free
the irq during reset, set_status(0). vp_vdpa is one example for this.

>
>   pi_update_irte: failed to update PI IRTE
>   irq bypass consumer (token 000000005a07a12b) unregistration fails: -22
>
> This patch solves this.
>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>

Other than this.

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index f41d081777f5..15bae2290bf9 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -173,6 +173,10 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>         if (status != 0 && (ops->get_status(vdpa) & ~status) != 0)
>                 return -EINVAL;
>
> +       if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> +               for (i = 0; i < nvqs; i++)
> +                       vhost_vdpa_unsetup_vq_irq(v, i);
> +
>         if (status == 0) {
>                 ret = ops->reset(vdpa);
>                 if (ret)
> @@ -184,10 +188,6 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>                 for (i = 0; i < nvqs; i++)
>                         vhost_vdpa_setup_vq_irq(v, i);
>
> -       if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) && !(status & VIRTIO_CONFIG_S_DRIVER_OK))
> -               for (i = 0; i < nvqs; i++)
> -                       vhost_vdpa_unsetup_vq_irq(v, i);
> -
>         return 0;
>  }
>
> --
> 2.31.1
>

