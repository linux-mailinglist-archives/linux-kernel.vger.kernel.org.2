Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07439699F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 00:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhEaWTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 18:19:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhEaWS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 18:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622499438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vWZ8xCrJBhMcZuS98MgK+sFxBqjVnSvSx0xIJ+voYlE=;
        b=CskQYOD4fFsTJcHd8j3X8htYAzwmpL6s/uwV6Ci8HxWgcX6rF4pxUaA74FRWIAogW8qRN/
        dlavnhFKgMJ73UT8DOWprNk82uHK/kfIyxgBAam65Uppu4yiFWFVfPi9IlGGNLsjO8E6Nc
        o2tW+miXyYmcotbtTU7b1mZOYqb4VoQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-Vdng91i6Pw6v15hugeDLFw-1; Mon, 31 May 2021 18:17:17 -0400
X-MC-Unique: Vdng91i6Pw6v15hugeDLFw-1
Received: by mail-wm1-f70.google.com with SMTP id 128-20020a1c04860000b0290196f3c0a927so228450wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 15:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vWZ8xCrJBhMcZuS98MgK+sFxBqjVnSvSx0xIJ+voYlE=;
        b=qlzNh63xJN0EgzhYBrLFrnbmIhwUM3LJBeiGVgrp9X4d++sjWl1UeHmmet1YhhWjy/
         MksYMT7THgTK/hVu9hB+KSLlF2Jh/y+6XoGGrUGvnlaRlksR3VBLHRmkKgyC8/YCKlLW
         KopK5AzSJLzC5AvaQC50bXv7t7giv9uEsj5A74aTqDbJAum+/E9w1J+vKTHJO38G7tj7
         AdZHdEdO+XkjrJIoUuxW0sJSnfqXc61VprmyhmRmEj8hUSixFdiSRG/ZfnYLQWikeNb1
         sWbCzNJwidvvrADhFqpm5+lmaSr1yTYzpjRxjLFqJ8Y32K/6/Si5gPPuZDxlm2dThR4J
         ToOw==
X-Gm-Message-State: AOAM531b+QYP7FeNO6R43NLjPmwovJDg5lxlOom5N1S43LFwr6m9odkV
        EY8QhRYd9sxIEDCb9pbSLI1t5EMfehRmA+03W9H/k5a0zQYzVOQ76xX4jVDFGzUGLM65GRDdDqD
        HZsnp8wVkl/ycIkh5suCM7c/0
X-Received: by 2002:a5d:53cc:: with SMTP id a12mr23446293wrw.99.1622499436067;
        Mon, 31 May 2021 15:17:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXRodfWnHB+31Age1AmUO6iZTwwVWYMIm4yUA9myLBI4/b7iTAjqbakreBdELXdp88iTeueQ==
X-Received: by 2002:a5d:53cc:: with SMTP id a12mr23446288wrw.99.1622499435962;
        Mon, 31 May 2021 15:17:15 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1001])
        by smtp.gmail.com with ESMTPSA id m5sm649897wmq.6.2021.05.31.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 15:17:15 -0700 (PDT)
Date:   Mon, 31 May 2021 18:17:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] vdpa/mlx5: Support creating resources with uid ==
 0
Message-ID: <20210531181704-mutt-send-email-mst@kernel.org>
References: <20210531160404.31368-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531160404.31368-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 07:04:04PM +0300, Eli Cohen wrote:
> Currently all resources must be created with uid != 0 which is essential
> when userspace processes are allocating virtquueue resources. Since this
> is a kernel implementation, it is perfectly legal to open resources with
> uid == 0.
> 
> In case firmware supports, avoid allocating user context.
> 
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 --> v1:
>   Fix typo and modify phrasing

threading's broken now

>  drivers/vdpa/mlx5/core/resources.c | 6 ++++++
>  include/linux/mlx5/mlx5_ifc.h      | 4 +++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 6521cbd0f5c2..836ab9ef0fa6 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
>  	void *in;
>  	int err;
>  
> +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> +		return 0;
> +
>  	/* 0 means not supported */
>  	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
>  		return -EOPNOTSUPP;
> @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
>  	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
>  	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
>  
> +	if (!uid)
> +		return;
> +
>  	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
>  	MLX5_SET(destroy_uctx_in, in, uid, uid);
>  
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 9c68b2da14c6..606d2aeacad4 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
>  	u8         uar_4k[0x1];
>  	u8         reserved_at_241[0x9];
>  	u8         uar_sz[0x6];
> -	u8         reserved_at_250[0x8];
> +	u8         reserved_at_248[0x2];
> +	u8         umem_uid_0[0x1];
> +	u8         reserved_at_250[0x5];
>  	u8         log_pg_sz[0x8];
>  
>  	u8         bf[0x1];
> -- 
> 2.31.1

