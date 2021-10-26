Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB0C43AA53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhJZCcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 22:32:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229998AbhJZCcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635215392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bK/ePsOXvnwATuPJ538FYYy/I3va7wErG+x6S0m8LPc=;
        b=VhJZZ5g6OtQiAkdrgxfLgy49izVCiJt6Vi3Y3ol5N8y8nY1PpR0WUqPN6vTBYZMTbOWL2l
        yuqwEE+7M3HT4nUUbfCd85XNapHuctiJGfHAhnBOnt0vANKR+468d12MaWfCp86TvY2GoS
        ixZChhVFowxzC8gSqBg6vNMiFsrSnhI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-0oJc5VpQPoKLKotItGw8ZA-1; Mon, 25 Oct 2021 22:29:48 -0400
X-MC-Unique: 0oJc5VpQPoKLKotItGw8ZA-1
Received: by mail-lj1-f198.google.com with SMTP id h5-20020a2e9005000000b00210d01099b3so3665389ljg.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bK/ePsOXvnwATuPJ538FYYy/I3va7wErG+x6S0m8LPc=;
        b=ei+X9ZZ6Z3t3idYEINBODQK20ocl+pqjkmp0Icci890mLUq3gtttjQJaOJL630I6iQ
         L4X5SH2cIiZyUN4Sq+jRzLyu1HczaGsc2ARedflEflJt/8Ac5tHhA4nAbN+KPiISqtOG
         UIn7V9TM3vjjk4df+IW6Y/BYcDkmsRyC6CCZsq5+PyM2wUwd8FPj7wTk4YPb/nY9JwG5
         EBmqSVQ2hXhds6qdCrBaxSwPsupjfiMOxYbS3/NdVnTdJHCVCppIwVPAleHPikNdMhLu
         0RjXovh7eWqdOblOQGYy7gsZQluCKaoGA57Y9SNVUguiLCEUwBomNBr8uSVxQyMgxThK
         /uaA==
X-Gm-Message-State: AOAM530yMuSMK7oQQeh6/EO9G+JWdSibXtyTbhXFugiqoIRqPdqhUbjA
        HKkCByyVrKhGXZsKMGhkImwrfZV8cvJvZGKDApRyl/D/EL4jnqyG3/TtuFrNElCzJM/GNkmMDFE
        PZ2dcjV9VyXo4Iepao8fxOApRm5MU6EsVw7W9BUeg
X-Received: by 2002:a2e:8846:: with SMTP id z6mr1572337ljj.277.1635215386593;
        Mon, 25 Oct 2021 19:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynH2p5Q/d3q8po75eyLScuoBHurmQzxoMQYZvDuVwpXkiyjRKbg3lG4lyNps31IP9RfRnyLeR+hJ3uxAAQOeI=
X-Received: by 2002:a2e:8846:: with SMTP id z6mr1572308ljj.277.1635215386353;
 Mon, 25 Oct 2021 19:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211025102240.22801-1-colin.i.king@gmail.com>
In-Reply-To: <20211025102240.22801-1-colin.i.king@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Oct 2021 10:29:35 +0800
Message-ID: <CACGkMEv2UOaf0phkXYsV=L3fn3BCxXUj-Vx3o1MeYQhvY_B-wg@mail.gmail.com>
Subject: Re: [PATCH][next] virtio_blk: Fix spelling mistake: "advertisted" -> "advertised"
To:     Colin Ian King <colin.i.king@googlemail.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 6:22 PM Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> There is a spelling mistake in a dev_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..9dd0099d2bd2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -560,7 +560,7 @@ static int init_vq(struct virtio_blk *vblk)
>         if (err)
>                 num_vqs = 1;
>         if (!err && !num_vqs) {
> -               dev_err(&vdev->dev, "MQ advertisted but zero queues reported\n");
> +               dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
>                 return -EINVAL;
>         }
>
> --
> 2.32.0
>

