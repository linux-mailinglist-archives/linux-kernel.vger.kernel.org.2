Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ABA322AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhBWMe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 07:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232673AbhBWMe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 07:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614083576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x3DW69ELSoGab9iFk3XQpMfjw5ZB9SvGphEN2R3aLT0=;
        b=iEi49+GEl0jT5xDnT3Bkd5YLhlhA1r8nyRkPiiPbIQtzvMtbxyyNaG4lAHUvIv2yGuDneo
        TqQxyeqdlUTJjvIwAcxGeyznCF9zljeLYvL4abueYvbb9tGWkRs9Cc4uSXXbf+q/VvVFJG
        3KcQ2zztVYi4m7MSJjyPT3q4LVpjMtg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-a3UbpaE0P4ipXZBWa_o7ug-1; Tue, 23 Feb 2021 07:32:53 -0500
X-MC-Unique: a3UbpaE0P4ipXZBWa_o7ug-1
Received: by mail-wm1-f71.google.com with SMTP id k18so618056wmi.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 04:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3DW69ELSoGab9iFk3XQpMfjw5ZB9SvGphEN2R3aLT0=;
        b=kVAgRTMfe8RFfxZYvLBHjiP8YSD96Jcmeu/gqHwAsuj8z622TNJTF2xJlMo4/QOki4
         35k5/6/lISIUT7+DiAdr69h+SShjiEf2rDwkU8bqILTELLYQSb5B+foFbjw4YKzoeJgq
         Pwbp6PNnDeDwlgyFsKGXnfO6ZIKQiBa6UArj1CKc4B52huverV2pJmA680aNHfmzCWWF
         w66iXfpqoeAr0H50o60hEQJ6Owyr4gpkIPn/tDRr1yPMdJbvlySNs2C7sB8KxOQZn3Vx
         m8U++VaY1QKxGbjdWV9IW8EcF16FHbGgDICadNYtcBQ+/Vwo3/zQv0AiR0V9GJZR4Lsp
         F7pw==
X-Gm-Message-State: AOAM532qE4LuOcYz750fFOC/Apb+wWILbVDWOgxLD3ZnGJ3nQvi0xoQ1
        atHIoWNjaocwWFYbmRJ6sHt1ezeHN6E4eNzAydIJKFx41shLd+RRUOFqpA2gclnowbUuuH2LMdv
        HDF1QMe6LWOEwG5qeKg6DUYDU
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr24660187wmc.3.1614083572529;
        Tue, 23 Feb 2021 04:32:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy/j0eRjoVScr7mxvXDLNHosb0ARMNPamB4G4SgA5hHEoAJqxPK6ghP73oKIZ48MV2ylGM7TQ==
X-Received: by 2002:a1c:f60b:: with SMTP id w11mr24660173wmc.3.1614083572413;
        Tue, 23 Feb 2021 04:32:52 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id v5sm2671407wmh.2.2021.02.23.04.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 04:32:52 -0800 (PST)
Date:   Tue, 23 Feb 2021 07:32:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Eli Cohen <elic@nvidia.com>
Cc:     jasowang@redhat.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        si-wei.liu@oracle.com
Subject: Re: [PATCH] vdpa/mlx5: Extract correct pointer from driver data
Message-ID: <20210223073225-mutt-send-email-mst@kernel.org>
References: <20210216055022.25248-1-elic@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216055022.25248-1-elic@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 07:50:21AM +0200, Eli Cohen wrote:
> struct mlx5_vdpa_net pointer was stored in drvdata. Extract it as well
> in mlx5v_remove().
> 
> Fixes: 74c9729dd892 ("vdpa/mlx5: Connect mlx5_vdpa to auxiliary bus")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Sorry which tree this is for? Couldn't apply.

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6b0a42183622..4103d3b64a2a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2036,9 +2036,9 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  
>  static void mlx5v_remove(struct auxiliary_device *adev)
>  {
> -	struct mlx5_vdpa_dev *mvdev = dev_get_drvdata(&adev->dev);
> +	struct mlx5_vdpa_net *ndev = dev_get_drvdata(&adev->dev);
>  
> -	vdpa_unregister_device(&mvdev->vdev);
> +	vdpa_unregister_device(&ndev->mvdev.vdev);
>  }
>  
>  static const struct auxiliary_device_id mlx5v_id_table[] = {
> -- 
> 2.29.2

