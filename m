Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079D0395022
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhE3Iiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22573 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229500AbhE3Iio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622363826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IQkEWOyD2gUPYpz6u2yU+abakR+lg4Bi7q8CPHtEjSY=;
        b=YOskvroJSJARnduet9Hp8Z+EsmwubshfM4WJVWHClXdDLDt1+leqv2XBKEEqW2nW+ylgg5
        ZmghhMW8+up7w6MdswV+ZZ3WIMNoilGUl/oD0x3RSAeBEiLY/zMmGGwzFqJcHrQ8BNlcf4
        Eu7nwc0fLBROAoYj7Lh0YXtmckKuRvE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-EFmZ55FNMx2YO6F1NsBFJQ-1; Sun, 30 May 2021 04:37:04 -0400
X-MC-Unique: EFmZ55FNMx2YO6F1NsBFJQ-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso2009608wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQkEWOyD2gUPYpz6u2yU+abakR+lg4Bi7q8CPHtEjSY=;
        b=FU6vWvMxqyUCULc54IQT16dZ49WIVEXzSaVJ5jKtLrup1xwrt7etQO0OMNG8cBWae4
         zmzwBT4Nw0mTqFYrxsnwivHlmDX4rFmcYn1ctUAZPPumegE8Jq5LfwMvTL6OQI3hojEO
         DfqtvY6gCxl0PNVTzG/sZhgB5DV7hCy9Q0jAY4Uexg2SsoSF1u40cHWmhKQo7sihN1n/
         FjC86GLng1lu1PSLkFAlVmDqP3OISndVIL6zIeTgfmO6IPPAOv7/E2ZbHfODwemlmnoq
         dM1YFfCCNs6cauwidXnvbS3ZdVdUG5JIPkWafejvROPe7orlXLYoAK5+chnQuOFRR+ET
         X8Cw==
X-Gm-Message-State: AOAM5332YL8iJqROcrHZjSPJLZME3/65JO0KlNcJG1HM0kP7NV8AATuh
        IvRUZ0Kyt07uTgW2T207Diyl+nR0Kh0wMVMBqjH2VrkyX8+EsFYvmYOXmiz0v+AZaOAXNCa0jBY
        UDWnqQ3SMLLz0qtaeNshGd+3z
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr21318795wmq.48.1622363823612;
        Sun, 30 May 2021 01:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQuGYN7KsWAuWSTpviYAWENL+DHUSH/CxEH7tJEOWJ8LpEljHIYJ9S98xmXuElv9d6z5Ma4g==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr21318782wmq.48.1622363823451;
        Sun, 30 May 2021 01:37:03 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
        by smtp.gmail.com with ESMTPSA id z188sm11865697wme.38.2021.05.30.01.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:37:02 -0700 (PDT)
Date:   Sun, 30 May 2021 04:36:59 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530043634-mutt-send-email-mst@kernel.org>
References: <20210530063214.183335-1-elic@nvidia.com>
 <20210530040523-mutt-send-email-mst@kernel.org>
 <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530042055-mutt-send-email-mst@kernel.org>
 <20210530082748.GB120333@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210530082748.GB120333@mtl-vdi-166.wap.labs.mlnx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 11:27:48AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:21:07AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 11:17:21AM +0300, Eli Cohen wrote:
> > > On Sun, May 30, 2021 at 04:05:57AM -0400, Michael S. Tsirkin wrote:
> > > > On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> > > > > umem size is a 32 bit unsigned value so assigning it to an int could
> > > > > cause false failures. Set the calculated value inside the function and
> > > > > modify function name to reflect the fact it updates the size.
> > > > > 
> > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > 
> > > > could you clarify the impact of the bug please?
> > > > 
> > > 
> > > This was found by code revew. I did not see it causing trouble becuase
> > > umem sizes are small enough to fit in int. Nevertheless it's a bug that
> > > deserves a fix.
> > 
> > ok pls include this info in the commit log.
> > 
> 
> Not sure what info do you want me to include. Seems to me that the
> changelog already provides the required information.


that this was found by code review and has no practical impact.

> > > > 
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
> > > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 53312f0460ad..fdf3e74bffbd 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
> > > > >  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
> > > > >  }
> > > > >  
> > > > > -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > > -		     struct mlx5_vdpa_umem **umemp)
> > > > > +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > > +			  struct mlx5_vdpa_umem **umemp)
> > > > >  {
> > > > >  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
> > > > >  	int p_a;
> > > > > @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
> > > > >  		*umemp = &mvq->umem3;
> > > > >  		break;
> > > > >  	}
> > > > > -	return p_a * mvq->num_ent + p_b;
> > > > > +	(*umemp)->size = p_a * mvq->num_ent + p_b;
> > > > >  }
> > > > >  
> > > > >  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> > > > > @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> > > > >  	void *in;
> > > > >  	int err;
> > > > >  	__be64 *pas;
> > > > > -	int size;
> > > > >  	struct mlx5_vdpa_umem *umem;
> > > > >  
> > > > > -	size = umem_size(ndev, mvq, num, &umem);
> > > > > -	if (size < 0)
> > > > > -		return size;
> > > > > -
> > > > > -	umem->size = size;
> > > > > -	err = umem_frag_buf_alloc(ndev, umem, size);
> > > > > +	set_umem_size(ndev, mvq, num, &umem);
> > > > > +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
> > > > >  	if (err)
> > > > >  		return err;
> > > > >  
> > > > > -- 
> > > > > 2.31.1
> > > > 
> > 

