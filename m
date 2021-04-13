Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47DC35D8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239742AbhDMHaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239467AbhDMHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618298982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YudAFqILa3mOOE+t1TyWZ2gFUm2V6rY++OIJXhuuw1I=;
        b=PFxka6pHgvz5qZczc6+NdNBHWr25k0QU9EZqoFW6QRqc73Lf/+NEY/yPfhpb5hGH/AS4dg
        WDavg64yk3L98eHDiYrW3QdYPPInqzHtm7qX4b6RtCb0h0I61px+32TWAA5+gtRMQawsgI
        hIsyCsfy226TfyFkR4FbDIkW40tJeKQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-DoNNe2QCPQ24YbMrYB4YNw-1; Tue, 13 Apr 2021 03:29:38 -0400
X-MC-Unique: DoNNe2QCPQ24YbMrYB4YNw-1
Received: by mail-ed1-f72.google.com with SMTP id r4-20020a0564022344b0290382ce72b7f9so796178eda.19
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YudAFqILa3mOOE+t1TyWZ2gFUm2V6rY++OIJXhuuw1I=;
        b=aerS6dsRaqcUVIjr2yUGBCemZ7QE+RlCxyycY8s1TBOYlEXY164rsAvA7QizqIVb6z
         QxsBYJ1KbdDC95yFlZqFUzyGEJTU+UhC8P0bYsXBVu2G6mIYnZ79zrR6f4eyspdq+PzR
         vZtuiIV6XnRjwq0texgPU4zauNBmmpQgPunu8HnhkOf6a1RjcNB/4VNJejPIJs7QYAKE
         OTdYj5ZiALtcDRBLa/4UOhyiO4fT396n5fRO3Wt9a+W2UcQRMcQplR/TnWl7FykZzdZq
         /T6i5Pg0Mi4tb8ETeIIl/H/X/UQ3gAGiGh+pnDvawF0W3US2Ul0+PocKOn/SIEVfVJ+g
         CSLA==
X-Gm-Message-State: AOAM533eNyQ1MEcc9Q5Dw7BHLaaK4vPITqi1cyYLxi6R88/CzSKpPGQr
        O5ri8310QvrmkGI5SG9G0huRCaeLwTkIMRQP+S9bvudAVAZ4Gft2R79/USXsuTFzTmjTY5H0t3g
        4ThBOxKwC5s/efH0F7ZknowrK
X-Received: by 2002:a05:6402:3445:: with SMTP id l5mr33576461edc.27.1618298977496;
        Tue, 13 Apr 2021 00:29:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQrY+VYWzozoHawW7aNAan46NiQL9riVrwylV8GXb98pXD2+8ryZFNg9lKT4PGXF62dZbE/g==
X-Received: by 2002:a05:6402:3445:: with SMTP id l5mr33576447edc.27.1618298977323;
        Tue, 13 Apr 2021 00:29:37 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id gt37sm7169639ejc.12.2021.04.13.00.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:29:37 -0700 (PDT)
Date:   Tue, 13 Apr 2021 09:29:34 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vdpa/mlx5: Fix resource leak of mgtdev due to
 incorrect kfree
Message-ID: <20210413072934.ibz7iersn5byad3h@steredhat>
References: <20210412162804.1628738-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210412162804.1628738-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 05:28:04PM +0100, Colin King wrote:
>From: Colin Ian King <colin.king@canonical.com>
>
>Static analysis is reporting a memory leak on mgtdev, it appears
>that the wrong object is being kfree'd. Fix this by kfree'ing
>mgtdev rather than mdev.
>
>Addresses-Coverity: ("Resource leak")
>Fixes: c8a2d4c73e70 ("vdpa/mlx5: Enable user to add/delete vdpa device")
>Signed-off-by: Colin Ian King <colin.king@canonical.com>
>---
> drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>index 10c5fef3c020..25533db01f5f 100644
>--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>@@ -2089,7 +2089,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
> 	return 0;
>
> reg_err:
>-	kfree(mdev);
>+	kfree(mgtdev);
> 	return err;
> }
>
>-- 
>2.30.2
>

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

