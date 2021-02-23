Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B333322A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBWM21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:28:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232568AbhBWM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:28:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614083195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dlRBImIxcwNi4rHuXYdMygYUREHsouYdgn7QLrLfVHk=;
        b=SNAR5QitWUemI5kFTYcxBO2qC/Cj43wOkA2S8/pupxhnfmokXvVx0q0Z4APPQodlU99wp6
        E3WIQPKgZ+ptBDG2QmZtWfgO+LYlDWjoJZjy7gnLHN16LsQpTH9Xn568rK1VGtbTZVJ3VA
        SG/Cm1KMrO5GMhUl/fmwbOhMjJ2Gq0g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-8sQeNnxvNQunzoOwsBaPbg-1; Tue, 23 Feb 2021 07:26:33 -0500
X-MC-Unique: 8sQeNnxvNQunzoOwsBaPbg-1
Received: by mail-wm1-f72.google.com with SMTP id h16so1112923wmq.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dlRBImIxcwNi4rHuXYdMygYUREHsouYdgn7QLrLfVHk=;
        b=IW+oPVTonTGoX9D0v6wS5in5pe3tdqNZYAfcIWmlZTJeWp0nKCRXccgF44+Lz6gQpO
         W8a7+JLu5D/ASRsDNIVyOzTHpXn5rvezPLTsUN7kXl+ifs1cHhpO2sKD7uNPsRaIbriQ
         H3BBpHbG4/QmH2db/l8TlJiSmn76TEv4FZYaYQ8S8njLA1iC5fj/R9Q1iNRDLLZROoeI
         WEGECVFi7/bmCh2U3TqV0bxludAf90M2LbkYe8zLgJrxXni3jU+WtYHk0lN4neDqLLwj
         bx9aXUpooGoysZW0w1+Vql4JfNpHCYLHMFPodmkBwHI7XElzIeUm1Dkdeh4dgGYXOUmz
         HYlA==
X-Gm-Message-State: AOAM530o8bYfPFA/rjfMu9pys87MV8HO9MYg2I6aG11EhX8RM9re8Thi
        ugCYbwFS5o7Q4wJtUDMzckLgy8unid1817KfqL6jZByU3Pv2qPkMJCAFIpw7PhqbT3YAzES2+Kz
        GePH1G8lRG76QEnZ8Z3i8cQgU
X-Received: by 2002:a5d:5109:: with SMTP id s9mr25259279wrt.325.1614083192189;
        Tue, 23 Feb 2021 04:26:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxocWMZ+yxHbiie9t5x9KGG8c7GcIkLf9fWyaLKqgKNZ40RLp7+9DospqS4cosjlYPsyzL2NQ==
X-Received: by 2002:a5d:5109:: with SMTP id s9mr25259260wrt.325.1614083191996;
        Tue, 23 Feb 2021 04:26:31 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id e17sm9660537wro.36.2021.02.23.04.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:26:31 -0800 (PST)
Date:   Tue, 23 Feb 2021 07:26:28 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     jasowang@redhat.com, elic@nvidia.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210223072047-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 06:54:58AM -0500, Si-Wei Liu wrote:
> Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> for legacy") made an exception for legacy guests to reset
> features to 0, when config space is accessed before features
> are set. We should relieve the verify_min_features() check
> and allow features reset to 0 for this case.
> 
> It's worth noting that not just legacy guests could access
> config space before features are set. For instance, when
> feature VIRTIO_NET_F_MTU is advertised some modern driver
> will try to access and validate the MTU present in the config
> space before virtio features are set. Rejecting reset to 0
> prematurely causes correct MTU and link status unable to load
> for the very first config space access, rendering issues like
> guest showing inaccurate MTU value, or failure to reject
> out-of-range MTU.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")

isn't this more

    vdpa: make sure set_features is invoked for legacy


> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

I think we at least need to correct the comment in
include/linux/vdpa.h then

Instead of "we assume a legacy guest" we'd say something like
"call set features in case it's a legacy guest".

Generally it's unfortunate. Need to think about what to do here.
Any idea how else we can cleanly detect a legacy guest?

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 7c1f789..540dd67 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
>  	return mvdev->mlx_features;
>  }
>  
> -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> -{
> -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> -		return -EOPNOTSUPP;
> -
> -	return 0;
> -}
> -
>  static int setup_virtqueues(struct mlx5_vdpa_net *ndev)
>  {
>  	int err;

Let's just set VIRTIO_F_ACCESS_PLATFORM in core?
Then we don't need to hack mlx5 ...


> @@ -1558,18 +1550,13 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> -	int err;
>  
>  	print_features(mvdev, features, true);
>  
> -	err = verify_min_features(mvdev, features);
> -	if (err)
> -		return err;
> -
>  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
>  	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
>  	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	return err;
> +	return 0;
>  }
>  
>  static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
> -- 
> 1.8.3.1

