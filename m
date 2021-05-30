Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB113395018
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhE3IWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3IWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622362872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JjXtEIwpf1mDFTTGUGvVGlffXEM2+LhLlHe+WZI3vjU=;
        b=EyposeYNK6Y/d28jShKlXD0vsiF6bh4g0Y7WF8iUx8dC1FN+YxxhDkBXx3m5aUQ0NvEHuV
        WkL92cPMQhs5SUs5y5dLDgNvs4YBz6H7LjUZfhCEbE+y2I15E9TWzMbpQ7K6wMApl3X66p
        JWtksQupo7DNX7zoqhNADVF0nmNaTHE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-HuCxbr7VOqG5YNqOfoJA6Q-1; Sun, 30 May 2021 04:21:10 -0400
X-MC-Unique: HuCxbr7VOqG5YNqOfoJA6Q-1
Received: by mail-wm1-f71.google.com with SMTP id n127-20020a1c27850000b02901717a27c785so3461323wmn.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjXtEIwpf1mDFTTGUGvVGlffXEM2+LhLlHe+WZI3vjU=;
        b=EaWKSrOspD4vT9qi8TsgLv7vBVxuTQ8CX+N3SW6ZaVPY8KgMC8Gn+LcPnVAJ6FqJl/
         w95kL2cTyuh5Sg/aQJ8C0tNX1FL2gv4uucyEVJ6/ml4DrGpvw0xYTIBWDFDTurVYJaVM
         7/67lagOovFGgMZL0Ot+BTMoqE/r1aqZsoY5d76r8uw+Vns00F+TvdGy9DyU0hJUp8nM
         KwXvLNgpjn2MLUWv7CR1gLEUOn7qtbQvSEVADHkTSMrAmyC1cp8sPKNt5C2MHzfi/YGS
         L/dkyfeyKbgUhVQTr1nap+yyQPvLL3uZuznVGyWfeQLGavoTGXXu092cDPkEZiSGX0P5
         GHTA==
X-Gm-Message-State: AOAM531U4CW096TBmF9VaWHnM1ID8ZN/by64OfOZlYFTRq10eGxFb6J4
        ItbmdnVF4RUjEfGBR0WQDfHZEzgLIiA/nuH+qrKgpXTu0PtrigeGv8pNxr6VuAfMgExUOkYkuXu
        hRynsn9vBkyBlXI2HH7lTBI0z
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr9586785wmo.89.1622362869829;
        Sun, 30 May 2021 01:21:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJOoBQqC4LDPf8WwUjin5hlkdERYH+wXkm89VqwFdihdZZfL9YaMISMYtQqrbV5FCOnYNHIg==
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr9586771wmo.89.1622362869701;
        Sun, 30 May 2021 01:21:09 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id u8sm1101825wrb.77.2021.05.30.01.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:21:09 -0700 (PDT)
Date:   Sun, 30 May 2021 04:21:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530042055-mutt-send-email-mst@kernel.org>
References: <20210530063214.183335-1-elic@nvidia.com>
 <20210530040523-mutt-send-email-mst@kernel.org>
 <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 11:17:21AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:05:57AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> > > umem size is a 32 bit unsigned value so assigning it to an int could
> > > cause false failures. Set the calculated value inside the function and
> > > modify function name to reflect the fact it updates the size.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > could you clarify the impact of the bug please?
> > 
> 
> This was found by code revew. I did not see it causing trouble becuase
> umem sizes are small enough to fit in int. Nevertheless it's a bug that
> deserves a fix.

ok pls include this info in the commit log.

> > 
> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
> > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 53312f0460ad..fdf3e74bffbd 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
> > >  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
> > >  }
> > >  
> > > -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > -		     struct mlx5_vdpa_umem **umemp)
> > > +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > +			  struct mlx5_vdpa_umem **umemp)
> > >  {
> > >  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
> > >  	int p_a;
> > > @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
> > >  		*umemp = &mvq->umem3;
> > >  		break;
> > >  	}
> > > -	return p_a * mvq->num_ent + p_b;
> > > +	(*umemp)->size = p_a * mvq->num_ent + p_b;
> > >  }
> > >  
> > >  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> > > @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> > >  	void *in;
> > >  	int err;
> > >  	__be64 *pas;
> > > -	int size;
> > >  	struct mlx5_vdpa_umem *umem;
> > >  
> > > -	size = umem_size(ndev, mvq, num, &umem);
> > > -	if (size < 0)
> > > -		return size;
> > > -
> > > -	umem->size = size;
> > > -	err = umem_frag_buf_alloc(ndev, umem, size);
> > > +	set_umem_size(ndev, mvq, num, &umem);
> > > +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
> > >  	if (err)
> > >  		return err;
> > >  
> > > -- 
> > > 2.31.1
> > 

