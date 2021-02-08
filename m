Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31149314013
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbhBHUNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:13:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235547AbhBHSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612809535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNdmFMG6UucVF40jTovWfbzmsjnpVcviTwo15N8yzyY=;
        b=FcZVj9exwOlJvlI6Jc5+XBWpH+Y3YSZ8FgbitHfrDeFjMFFcPLjVWpvUBsebxu1tlmTv1Q
        62mZvSi2Th+EdUO03wpaGgYlFaTDQE3Ja9MAxArFz2NgOzuL+oMCkDSV+GDtm3Ao/A5SM0
        bpfYo0De1vlRl+xKPl0ZplIy4whBFPU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-5_3QeFkGPWiWPcYgm0be0w-1; Mon, 08 Feb 2021 13:38:53 -0500
X-MC-Unique: 5_3QeFkGPWiWPcYgm0be0w-1
Received: by mail-ed1-f72.google.com with SMTP id w14so14620902edv.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 10:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNdmFMG6UucVF40jTovWfbzmsjnpVcviTwo15N8yzyY=;
        b=CDhWSxOpuUfZm7MhOH0N0yN7Di+RtvEcojY8Wjg9105p2BnttUvmS2M3FqkX/vJ8i8
         mmgsRBVfTOIc7NEfPRn1GyEPkSoM6Vy1GqnqJiDFwgcCR6N8Izg3eSinq5gDZMO9E3f4
         EtANrb91rfm3JbZ8JRI5X8mb/xWYyoybtmEjkWjFo5lHJJWlS0S+Ax9mvgFvw2GPoTWI
         Cly+vXpbHj1LpAtM79bwVj+EpJiyBU6/ie4mUECcVoiBOTDrOYgL0QDYv0Ff7sy7Ii3H
         EjkQ/yKe1VwyzMblpgRmElqKcQ5bFFy/Ler1jvpRxmNIseaZLqrqQJUDYtqdwEZbTilS
         bkJA==
X-Gm-Message-State: AOAM533F7rVdUg8XsN5gTKcQKZCf9urrsiOYc3HkkWEAyEgLSsDXqoEr
        FFS+3xYa3tY4Po9HXsl1HdXlZo+/4U/YwVyzq6n5H5d9aZLLjy8XNMsCtKCUBdRjz/0LtZ9R9Hz
        lUOYOdiTaLSidagGo2jcWlfmi
X-Received: by 2002:a17:906:f156:: with SMTP id gw22mr11877511ejb.406.1612809531880;
        Mon, 08 Feb 2021 10:38:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIJQXCgypIzsIrWdQRGjav+Gb4F5azrzmqGTldM/lo7PPYFTlalRzDBMMcvQnTQfoKq+bGaA==
X-Received: by 2002:a17:906:f156:: with SMTP id gw22mr11877498ejb.406.1612809531730;
        Mon, 08 Feb 2021 10:38:51 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
        by smtp.gmail.com with ESMTPSA id n5sm10076219edw.7.2021.02.08.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 10:38:50 -0800 (PST)
Date:   Mon, 8 Feb 2021 13:38:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210208133312-mutt-send-email-mst@kernel.org>
References: <20210208161741.104939-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208161741.104939-1-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
> It's legal to have 'offset + len' equal to
> sizeof(struct virtio_net_config), since 'ndev->config' is a
> 'struct virtio_net_config', so we can safely copy its content under
> this condition.
> 
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index dc88559a8d49..10e9b09932eb 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>  
> -	if (offset + len < sizeof(struct virtio_net_config))
> +	if (offset + len <= sizeof(struct virtio_net_config))
>  		memcpy(buf, (u8 *)&ndev->config + offset, len);
>  }

Actually first I am not sure we need these checks at all.
vhost_vdpa_config_validate already validates the values, right?

Second, what will happen when we extend the struct and then
run new userspace on an old kernel? Looks like it will just
fail right? So what is the plan? I think we should
allow a bigger size, and return the copied config size to userspace.


> -- 
> 2.29.2

