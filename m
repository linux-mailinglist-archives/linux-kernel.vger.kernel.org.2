Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEA35D573
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 04:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbhDMCur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 22:50:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238431AbhDMCur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 22:50:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618282228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyE+pkrv5YpxkS266b/YlxpyGvd3ASdLwkFrSnEarAM=;
        b=CiMjRWX5HS8zEjQCSZux4cvp04axodDK8JqyltPug6UI8RDwdfYxYFLzeUeOC9RBnYyZ9h
        g60VnNINkcGhYSKohx9pbZTimxomTIzgN4si3NidUhUHFrqDu1G0NnI+GxZMc9IK6XuRcn
        vW6u1FYjkGu0NhyQP8OFtDuor4lcryI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-vXD9VxVfMLC2zkix_baDKA-1; Mon, 12 Apr 2021 22:50:23 -0400
X-MC-Unique: vXD9VxVfMLC2zkix_baDKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B73AB6D249;
        Tue, 13 Apr 2021 02:50:22 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-128.pek2.redhat.com [10.72.13.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A247C19D61;
        Tue, 13 Apr 2021 02:50:16 +0000 (UTC)
Subject: Re: [PATCH][next] vdpa/mlx5: Fix resource leak of mgtdev due to
 incorrect kfree
To:     Colin King <colin.king@canonical.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210412162804.1628738-1-colin.king@canonical.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fac15f54-2c25-0017-f92a-bec88a28dea5@redhat.com>
Date:   Tue, 13 Apr 2021 10:50:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210412162804.1628738-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/4/13 上午12:28, Colin King 写道:
> From: Colin Ian King <colin.king@canonical.com>
>
> Static analysis is reporting a memory leak on mgtdev, it appears
> that the wrong object is being kfree'd. Fix this by kfree'ing
> mgtdev rather than mdev.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: c8a2d4c73e70 ("vdpa/mlx5: Enable user to add/delete vdpa device")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 10c5fef3c020..25533db01f5f 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2089,7 +2089,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>   	return 0;
>   
>   reg_err:
> -	kfree(mdev);
> +	kfree(mgtdev);
>   	return err;
>   }
>   


Acked-by: Jason Wang <jasowang@redhat.com>


