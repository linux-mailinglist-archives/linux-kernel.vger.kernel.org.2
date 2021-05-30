Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC831395015
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhE3IUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:20:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58932 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3IUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622362748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZrzgekDde8XcJc+H0wAf58TmREEJyXT/86BNmij9h/4=;
        b=itUNNhgBSg2msHcp2Pko0ofSgXhrLKvXx9A5dPkkILdQfixgOJY7G247TNeGjYNAV1ERAI
        2ZOWTHdh1Sel4zb6ErFlAb6tvSzjGBfiueOHCIQ3YECfksKdtwG7mTAS0ad3BiYuAYn2Sv
        U8Ft1IVIKA+xlQ0hgIWjLkV1Q07IACg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-QKNGqmITME2uPJc5EJcHVg-1; Sun, 30 May 2021 04:19:06 -0400
X-MC-Unique: QKNGqmITME2uPJc5EJcHVg-1
Received: by mail-wm1-f71.google.com with SMTP id h18-20020a05600c3512b029018434eb1bd8so3470374wmq.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZrzgekDde8XcJc+H0wAf58TmREEJyXT/86BNmij9h/4=;
        b=KfLLZmoNSGd3vtXu6+Bq777cQ2J+/Cng2AJ4XdQISYSgnmaqtrekxs4MRApidyRLyV
         4jB2GMTeDZjRaNPUxarJJA9Hvyvxp5p5pWuhRpp+6EpOL9xNf5TP7gMpC2z4Bou/2842
         JSwreVTQU2fu9hOnJ7OCJBnZ4yhZqHzDkxQDTcrR98Eeco7cHeWNXY3TKKvl5YD2cgjJ
         /4/cW5ZmnqdiRILgpNTy0XHbxt1i1FLUYoGA79N5tdK9C76eRuCaD0h4pZdnzh/r2N18
         JlwoGSLpFfqdUtoGzpxU0zR6QyG+/tIv8EZQkbosfxuYGHQRnxYulam5DrPz9MPKapgG
         TXLA==
X-Gm-Message-State: AOAM530cOg1XT+XbgyekLghAN4vUAXkoJ2E256vDS+Xlh9uFPlvAqn4G
        TH4XYcTXzLdEaLWiIHobHsJqAqeu/jFj5BJbTif3osfnScx93flY/AcOJG0Y+eO5MBWYQ2w4y5v
        /aJllT0o6FnTKPM0PxxOuvZPq
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr9401686wmg.121.1622362745454;
        Sun, 30 May 2021 01:19:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo/+Q9bh+z1Aiin4d0Fw94QcO8hSBoWoep74qVKoB+neJICUbCA6nlY1jCh4ZBOhBQIJJUUA==
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr9401672wmg.121.1622362745203;
        Sun, 30 May 2021 01:19:05 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id n20sm11262618wmk.12.2021.05.30.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:19:04 -0700 (PDT)
Date:   Sun, 30 May 2021 04:19:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530041624-mutt-send-email-mst@kernel.org>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
 <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 11:15:36AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > could you clarify the impact of the bug please?
> > 
> 
> I leads to firmware failure to create the virtqueue resource when you
> try to use a 1:1 mapping MR. This kind of usage is presented in the
> virtio_vdpa support I sent earlier.

OK pls include this info in the commit log. And is 1:1 the only case where
sizes differ? Is it true that in other cases sizes are all the same?

> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 189e4385df40..53312f0460ad 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> > >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> > >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > > -- 
> > > 2.31.1
> > 

