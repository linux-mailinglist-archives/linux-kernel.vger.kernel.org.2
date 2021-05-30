Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7813395010
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhE3IHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:07:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3IHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:07:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622361963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NX5CisLnC1pyP4PekqKqumzxuKrlCViEzhuLDUOe43Y=;
        b=IRb5ukBfRvhE48E919vxaBl0NukPNnXGRaljE2apNEXAoY+grHIEA7lQINKORJ5NUG4Vq5
        BAuBTiRZDVaV2W/px1mInhMe2h2hjl5Pca6hHRRko+JvH0D4qpw2HRQAzS7bBB8/sIW6Xy
        m4er1bjYPVkSng6JkeN6fSzkCG7hai4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-GdKcsFaoMy29r_q38s73Jw-1; Sun, 30 May 2021 04:06:02 -0400
X-MC-Unique: GdKcsFaoMy29r_q38s73Jw-1
Received: by mail-wm1-f71.google.com with SMTP id w3-20020a1cf6030000b0290195fd5fd0f2so1962393wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NX5CisLnC1pyP4PekqKqumzxuKrlCViEzhuLDUOe43Y=;
        b=dhimpsPfOG6qLRJkxsu+XnE0PQEAr0COCAH4CM8Cv4v3Q8jBQ8iyPhX1Sb/+Z8jkdE
         ONiBLnByPrQcgunJr1qLFvOjs6Mk/HOM23NmEY8pEIrP2asZ2gvYCOfy2bx8rUXSawg/
         6ogkZT7+3rSRw610PZgaYJFbWfEh/2f3U5K90uhySNRqkzOq8hufYDr7AYGQt6ufHPG6
         ExspY4ET9L24LrYVRaY+iAvC8MsZFvanpGkJ91zLWyh2mCDTdgcAiUJt9Gd2rQDvzlJd
         urJ5Bhe4TWyRYAAsco+9xbIXifNkc0EkJkYVleeP56cFK1vvbFBt7IFrwwSp2rXmcDpd
         2yqw==
X-Gm-Message-State: AOAM532JWxd6QBaOU7CAp5tbKxrCiihoDLu9tE83yKL6kGvlX1pbm4gP
        wOeIZrX37PxLd3A6rQwzCIBjKkz9rLJI/MKHsCFuO8vACGkxRi308o6xgxcpjf6mHeS9pN8eW7/
        AJm+MIVASGss2aLbbdEQlc5TC
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16856543wrr.37.1622361960973;
        Sun, 30 May 2021 01:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzV9Wt0dtS5PjEX5+L92Ox40mbwufjCbQO/9Ony6WmOrZN5hMvfaOO8dN5dDeyPSfRFSHKAw==
X-Received: by 2002:adf:fd81:: with SMTP id d1mr16856533wrr.37.1622361960784;
        Sun, 30 May 2021 01:06:00 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id g23sm1945301wmk.3.2021.05.30.01.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:06:00 -0700 (PDT)
Date:   Sun, 30 May 2021 04:05:57 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530040523-mutt-send-email-mst@kernel.org>
References: <20210530063214.183335-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530063214.183335-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> umem size is a 32 bit unsigned value so assigning it to an int could
> cause false failures. Set the calculated value inside the function and
> modify function name to reflect the fact it updates the size.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

could you clarify the impact of the bug please?


> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 53312f0460ad..fdf3e74bffbd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
>  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
>  }
>  
> -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> -		     struct mlx5_vdpa_umem **umemp)
> +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> +			  struct mlx5_vdpa_umem **umemp)
>  {
>  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
>  	int p_a;
> @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
>  		*umemp = &mvq->umem3;
>  		break;
>  	}
> -	return p_a * mvq->num_ent + p_b;
> +	(*umemp)->size = p_a * mvq->num_ent + p_b;
>  }
>  
>  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
>  	void *in;
>  	int err;
>  	__be64 *pas;
> -	int size;
>  	struct mlx5_vdpa_umem *umem;
>  
> -	size = umem_size(ndev, mvq, num, &umem);
> -	if (size < 0)
> -		return size;
> -
> -	umem->size = size;
> -	err = umem_frag_buf_alloc(ndev, umem, size);
> +	set_umem_size(ndev, mvq, num, &umem);
> +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
>  	if (err)
>  		return err;
>  
> -- 
> 2.31.1

