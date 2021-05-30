Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA06E395021
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhE3IiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:38:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3IiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622363784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rPWV5Lhhmpc5MWX7kc/tOx8+hiom19SEKERJ7ungmEA=;
        b=iwbfgkTC7XP9EjFTCJrMLRXL/So4mcpbjlR4fBj2mw+tkbq2khhG7rxHLuaQPJ/9DdPCLD
        APoK7fJU+oYvGPFzmw5ri+ypLHZtEEZD/BUqNs75PpVa+v7u+iK29D4RKxxll++Ak8LJ1k
        R+HZZMQTTY0HX4fZRfwLVO7qkSc48Fc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-r8cQxg3OO6iKlyhKr9KlqQ-1; Sun, 30 May 2021 04:36:23 -0400
X-MC-Unique: r8cQxg3OO6iKlyhKr9KlqQ-1
Received: by mail-wm1-f70.google.com with SMTP id 19-20020a05600c2313b0290193637766d9so3481712wmo.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rPWV5Lhhmpc5MWX7kc/tOx8+hiom19SEKERJ7ungmEA=;
        b=PsQxgTJP/Ufj0IEunk1NUoLWTov347kKl9zE/AB0/6/chKjplpsKjul7rrgiJiCgXu
         +whUl6E7A8BkHCibm1Aaal5dAlao/Ctx82yr9ICW5CAJ3hHcCiE5sGfMDbMmOHYQ0NSr
         D49prp/ghOuxnHg8dzqt00eGHVbBXAaYMnDlgxGkP+9NfPyFWEqSObakqvPhU2HYmRK1
         CvcQpD4FIxCQRtRvD8LRPSmM2SctFQdgeNUiBxzGJ5cP7D4/6/Y1V8Q+89qApp/gu/vQ
         0bFeGVTRszPnWZYTT2pJ14q0FFf5Gt5lhSU2nJl4FIDizSV1CsU+sH8i+XxjjTrcK7Li
         5j2g==
X-Gm-Message-State: AOAM532IxL4Nz7+ophhJh/YoXI0Ek0k7hCEjq/hBCp5GFuyk7PEDQ4Lc
        qECmR54F4QOrePBmCPTwSxDOkqSXVqx32tALyQt2kGKq7mCk/TqnAbu1qbVgZ7xcw4phiZwK34E
        q9ap79E4D7iXXCjdbWWD38p4d
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr17461979wri.66.1622363781411;
        Sun, 30 May 2021 01:36:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfJVD9JxGTr+o5E29mqDZk0lMDbrZDUMhLuU2yvl6llrQHJ68BCSV+ZNO9mXeb+n23IwdYAQ==
X-Received: by 2002:adf:e0c6:: with SMTP id m6mr17461970wri.66.1622363781286;
        Sun, 30 May 2021 01:36:21 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id g6sm11946594wmg.10.2021.05.30.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:36:20 -0700 (PDT)
Date:   Sun, 30 May 2021 04:36:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530043536-mutt-send-email-mst@kernel.org>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
 <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530041624-mutt-send-email-mst@kernel.org>
 <20210530082646.GA120333@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530082646.GA120333@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 11:26:46AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:19:01AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 11:15:36AM +0300, Eli Cohen wrote:
> > > On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> > > > On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > > > > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > > > > 
> > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > 
> > > > could you clarify the impact of the bug please?
> > > > 
> > > 
> > > I leads to firmware failure to create the virtqueue resource when you
> > > try to use a 1:1 mapping MR. This kind of usage is presented in the
> > > virtio_vdpa support I sent earlier.
> > 
> > OK pls include this info in the commit log.
> OK
> 
> > And is 1:1 the only case where
> > sizes differ? Is it true that in other cases sizes are all the same?
> > 
> The sizes are calculated based on firmware published paramters and a
> formula provided by the spec. They do differ but it so happened that
> size1 was larger than size2 and size3 so we did not see failures till
> now.

can this have a security impact? e.g. can guest access addresses
outside of it's memory with this?

> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 189e4385df40..53312f0460ad 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > > > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > > > > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > > > > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > > > > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> > > > >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > > > >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> > > > >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > > > > -- 
> > > > > 2.31.1
> > > > 
> > 

