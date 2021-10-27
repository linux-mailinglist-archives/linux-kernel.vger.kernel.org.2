Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA75843BFDD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbhJ0CfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 22:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232221AbhJ0CfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 22:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635301979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FpY57pN68hypRn3VPWxfGVMWd/Evtah6Ooz3LxnRlCk=;
        b=f6G5ozQStwr4ftPf7BPrRU35OZrKuVeJ/EExyLkxp4wCdfhRSONrX9Vh04DsRSTNqSanl+
        hCa58xJsZeB7VHZEeAt2GQPft0Qa3RqTWbQu03Y9Kk+QR44bO8ZLP4wk9S2NiOk58/R96G
        wdkMYrZ/7TD5PgWk29eHF8M+1mi+H5g=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-4pW-Dj7pMQWCg-UnAHZbFA-1; Tue, 26 Oct 2021 22:32:58 -0400
X-MC-Unique: 4pW-Dj7pMQWCg-UnAHZbFA-1
Received: by mail-lf1-f69.google.com with SMTP id b12-20020a0565120b8c00b003ffa7050931so646292lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 19:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpY57pN68hypRn3VPWxfGVMWd/Evtah6Ooz3LxnRlCk=;
        b=gvFuZI1TrcGyu+AAq3tsF6tTHJ6FtNlLomqL9Ix2Zy6HEvdzWKNbsznJAu72HVwPUy
         +y/g1rhGKVQYFlwr896jrd3WRHwlBpg496+NKyKi5bDn/xQZTVLlSoY86u/MvBmSlovi
         RGPZlqTQCTXidlg7uRzcvDOlyV/vVIUh2Dym3B0izzR1MfZYyhEpuvQG7lhtbFWB3OeH
         UW2INkc3Yzo+HQEPgbyPhr4PN3InlMchIiLZsi1/XYGcVCiG+PD4gILsCx/KwMN0GxGy
         OLBYOfZasbuk2lk8Sw0yyOQSo1C67Fqv9nXh0Na6hfpjB18o7PCkpwka3ylSY4otg5hx
         m2GQ==
X-Gm-Message-State: AOAM530XgyPhvGW9Im9oQBDbyLydR75n2s4K2W7EmAgsEGVEz/g9OHVu
        pvnO5VEz8rQoTHZ7dbhPeHCVAfp0VOEgRd/jCCiIGK6Dr1ssBmAbk8tWTMMR1oLLi4KP/pNHI4G
        leRHC9U+exP2IBbXcZPG7McYF0gGqRsPtzlqrZSmV
X-Received: by 2002:a05:6512:3d11:: with SMTP id d17mr21981073lfv.481.1635301976726;
        Tue, 26 Oct 2021 19:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcJzUayQqKMB7n4AC/Y6wG3Ef/heoMjTsB0jO3MjkD2lJ2F5C2jP8JhzR4d7qnIl4V2PhHCNZrWDAvoaUcqvA=
X-Received: by 2002:a05:6512:3d11:: with SMTP id d17mr21981052lfv.481.1635301976517;
 Tue, 26 Oct 2021 19:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211026133100.17541-1-vincent.whitchurch@axis.com>
In-Reply-To: <20211026133100.17541-1-vincent.whitchurch@axis.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Wed, 27 Oct 2021 10:32:45 +0800
Message-ID: <CACGkMEvV2HkXyv4RfB3pfmeaG8Nv4=XBG2Y1c+7mi0OnOUCWNA@mail.gmail.com>
Subject: Re: [PATCH] virtio-ring: fix DMA metadata flags
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, kernel@axis.com,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 9:31 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> The flags are currently overwritten, leading to the wrong direction
> being passed to the DMA unmap functions.
>
> Fixes: 72b5e8958738aaa4 ("virtio-ring: store DMA metadata in desc_extra for split virtqueue")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index dd95dfd85e98..3035bb6f5458 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -576,7 +576,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>         /* Last one doesn't continue. */
>         desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
>         if (!indirect && vq->use_dma_api)
> -               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags =
> +               vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
>                         ~VRING_DESC_F_NEXT;
>
>         if (indirect) {
> --
> 2.28.0
>

