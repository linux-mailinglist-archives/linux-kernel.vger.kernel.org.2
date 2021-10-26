Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5043AB64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 06:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234611AbhJZEo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 00:44:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233481AbhJZEo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 00:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635223322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqjO2zU/25UEIyy0nM2px/ntQerARAVZfBrLiW6eI5I=;
        b=OYm/2RcoQtz5dwmjci40tWBPB1ziEy59ZxfLBDpap8NimlDvOW40Pw9/nqY6vh9gCQgY2H
        nPXD425EwIk0Pp+G1l+Y/egH3cfIEAl/EVkpw0WXdZYv1bmkGIK766AeD6FCoq26Ms/aPh
        Wf8fhwbnN0eMKjXpbyOtXm78DfdkfUs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-jPt8VvZzOOOOY95g5z_FsA-1; Tue, 26 Oct 2021 00:41:59 -0400
X-MC-Unique: jPt8VvZzOOOOY95g5z_FsA-1
Received: by mail-lf1-f72.google.com with SMTP id k15-20020a0565123d8f00b003ffb31e2ea9so1300375lfv.17
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 21:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqjO2zU/25UEIyy0nM2px/ntQerARAVZfBrLiW6eI5I=;
        b=sP74ceKmzYw3VtFbYjINWKk46kTdmkeJdUzOjbad1ODEuJcl8guM0ameUfyGKOGGUT
         UTpVE9Eiyuu5kNElDqdbHwGOiJ/zj4gdtSXj3SMxanYNU+esCwd+6y4fLf9Kl3BdFuA6
         1cr16R2WVrBbLaG/VGKTEHCIZxCWM3LQI65HWCX1M1U9hpYQV249X4JaYkjswcSA6RtQ
         aho9BbY+49UrhyL+ZGjhihkpWy9lSBh1suk7muW4FEI8lTyp73lz9n3P1AhqMEBnhNwR
         TIVXdR9vJvTYQxG8oCYo/ggQgRD4091SpIciV04LX6Q3E9IlP6xxfSg9Q1cP4yEXDBdj
         klhw==
X-Gm-Message-State: AOAM530coAYlgTsnpRxBi3jYA5kLelD6A0m7gewlkJMnFeEdYFy7kNQo
        eJxbDC8t8kKd/Drxdddgu0D3mcfzJcty/hFfklp8Af2Peprzy6iBFBrXSScwc7KKGE6IS+tfvou
        G7HXGSiJlf5/lsmCblRCiOwaMr6pJkD9aw2VL7fC7
X-Received: by 2002:a2e:8605:: with SMTP id a5mr4832676lji.107.1635223318076;
        Mon, 25 Oct 2021 21:41:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhBUrLrGkrgB1yPRLALBD2sN4GQjQAwKYR9S4o58PDSHxoybsZIT8tkvnEx4edZQAzxkZe7XGOFh9gKFHWQ6Y=
X-Received: by 2002:a2e:8605:: with SMTP id a5mr4832648lji.107.1635223317869;
 Mon, 25 Oct 2021 21:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211025075825.1603118-1-mst@redhat.com>
In-Reply-To: <20211025075825.1603118-1-mst@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 26 Oct 2021 12:41:47 +0800
Message-ID: <CACGkMEucDHon_2uBqZpcSc8hNdOzJGRCz6U_ZmFaP6pbU5sBQw@mail.gmail.com>
Subject: Re: [PATCH] virtio_blk: corrent types for status handling
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Feng Li <lifeng1519@gmail.com>,
        Israel Rukshin <israelr@nvidia.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 3:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> virtblk_setup_cmd returns blk_status_t in an int, callers then assign it
> back to a blk_status_t variable. blk_status_t is either u32 or (more
> typically) u8 so it works, but is inelegant and causes sparse warnings.
>
> Pass the status in blk_status_t in a consistent way.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: b2c5221fd074 ("virtio-blk: avoid preallocating big SGL for data")
> Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..c7d05ff24084 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -208,8 +208,9 @@ static void virtblk_cleanup_cmd(struct request *req)
>                 kfree(bvec_virt(&req->special_vec));
>  }
>
> -static int virtblk_setup_cmd(struct virtio_device *vdev, struct request *req,
> -               struct virtblk_req *vbr)
> +static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
> +                                     struct request *req,
> +                                     struct virtblk_req *vbr)
>  {
>         bool unmap = false;
>         u32 type;
> @@ -317,14 +318,15 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
>         unsigned long flags;
>         unsigned int num;
>         int qid = hctx->queue_num;
> -       int err;
>         bool notify = false;
> +       blk_status_t status;
> +       int err;
>
>         BUG_ON(req->nr_phys_segments + 2 > vblk->sg_elems);
>
> -       err = virtblk_setup_cmd(vblk->vdev, req, vbr);
> -       if (unlikely(err))
> -               return err;
> +       status = virtblk_setup_cmd(vblk->vdev, req, vbr);
> +       if (unlikely(status))
> +               return status;
>
>         blk_mq_start_request(req);
>
> --
> MST
>

