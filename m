Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AFC4599FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 03:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhKWCNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 21:13:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231879AbhKWCNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 21:13:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637633431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sOzKcfc1mb/QfFCcqk6Ete8PuEFAKr8bz+8/GvBKxk=;
        b=EC1coBgr2dFAPetxPu0EloOYJP0FPTYm3uMoLG2sbmN91vdOjm/w1jlheE632i4xHr9d5Y
        r7m08wUtwAXPejqJVq7/Uh4mQkIuxcMXLOyMTCkZXcjIyXJgx0xg9yWxvww1eVmyIEIxjl
        MKiLkLCw28AD8FYvKxAEg0hmr2s39/g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-1dWPbN15Pu-xVW31QFqYBQ-1; Mon, 22 Nov 2021 21:10:30 -0500
X-MC-Unique: 1dWPbN15Pu-xVW31QFqYBQ-1
Received: by mail-lf1-f69.google.com with SMTP id h40-20020a0565123ca800b00402514d959fso13431457lfv.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Nov 2021 18:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1sOzKcfc1mb/QfFCcqk6Ete8PuEFAKr8bz+8/GvBKxk=;
        b=Qsaqm2g9LUe+zCk40BDbeByraUjipb05S63wuEyUvbCd0QzhM0p/X09DFzkO1HYZjV
         RvnRjLfL4lphy2WU+XWjuE3EqMeDfVggQulFPTNoJm4kCOnePZW+v4MSglQub4mIgVvN
         fTIolZMTvyx9nmZwJnnZLMipPXc8cHJz2OnvpvnFzcSorZDGZAS4Pvh9rz7hToMNVYlq
         RzqUbZ51rYf87hqcu2lfw111wpE/dvY1viuDeNA/gMuVmNyU+oXU6+DoNdnsME8uvB7R
         XQqwiObcVLZWYpCiaNfwDAWMzkOqdZDY1wf2rNWbxj5QTNZ9NU/qE2hVw1QGa+egJe4B
         v4Pg==
X-Gm-Message-State: AOAM533mnvCJc0j8n/ajE2NXXRtE/Nha4kYcahX6v5AxwGaiKN8ozzXl
        ny8XHPGKt4eifygvQsBdVDCrQJi6D+VTyip9yzQaUq6TAWpJt5yP8nZurtk0ee6jIFj1PoFmVUa
        2q6Q/Uft8dUqSEMruzePecg80KB96k8CGs0NKmIgs
X-Received: by 2002:a2e:915a:: with SMTP id q26mr1082228ljg.277.1637633428631;
        Mon, 22 Nov 2021 18:10:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIxxkaUjeVw+D8UMGoyZ19ATnr7cJFS0YGB7JG9SltIKNzY6nQ7dCY65IYPG0XZgJFRYEMQQdmQj4SV8bnDbY=
X-Received: by 2002:a2e:915a:: with SMTP id q26mr1082206ljg.277.1637633428448;
 Mon, 22 Nov 2021 18:10:28 -0800 (PST)
MIME-Version: 1.0
References: <20211122122221.56-1-longpeng2@huawei.com>
In-Reply-To: <20211122122221.56-1-longpeng2@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 23 Nov 2021 10:10:17 +0800
Message-ID: <CACGkMEsYEg06vaLJnYeCzcUXneTxWM7kR1Y-DqXicc4WG3z7ew@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim: avoid putting an uninitialized iova_domain
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     mst <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 8:22 PM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> The system will crash if we put an uninitialized iova_domain, this
> could happen when an error occurs before initializing the iova_domain
> in vdpasim_create().
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> RIP: 0010:__cpuhp_state_remove_instance+0x96/0x1c0
> ...
> Call Trace:
>  <TASK>
>  put_iova_domain+0x29/0x220
>  vdpasim_free+0xd1/0x120 [vdpa_sim]
>  vdpa_release_dev+0x21/0x40 [vdpa]
>  device_release+0x33/0x90
>  kobject_release+0x63/0x160
>  vdpasim_create+0x127/0x2a0 [vdpa_sim]
>  vdpasim_net_dev_add+0x7d/0xfe [vdpa_sim_net]
>  vdpa_nl_cmd_dev_add_set_doit+0xe1/0x1a0 [vdpa]
>  genl_family_rcv_msg_doit+0x112/0x140
>  genl_rcv_msg+0xdf/0x1d0
>  ...
>
> So we must make sure the iova_domain is already initialized before
> put it.
>
> In addition, we may get the following warning in this case:
> WARNING: ... drivers/iommu/iova.c:344 iova_cache_put+0x58/0x70
>
> So we must make sure the iova_cache_put() is invoked only if the
> iova_cache_get() is already invoked. Let's fix it together.
>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/vdpa_sim/vdpa_sim.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 5f484fff8dbe..41b0cd17fcba 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -591,8 +591,11 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>                 vringh_kiov_cleanup(&vdpasim->vqs[i].in_iov);
>         }
>
> -       put_iova_domain(&vdpasim->iova);
> -       iova_cache_put();
> +       if (vdpa_get_dma_dev(vdpa)) {
> +               put_iova_domain(&vdpasim->iova);
> +               iova_cache_put();
> +       }
> +
>         kvfree(vdpasim->buffer);
>         if (vdpasim->iommu)
>                 vhost_iotlb_free(vdpasim->iommu);
> --
> 2.27.0
>

