Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBA367786
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhDVCiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230338AbhDVCiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619059067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Inh19Rdi8OHMk1GcJYs3DU+EPz9TREj6IWlYcp5GPTY=;
        b=U9Ob/LSjbL9Jk4mlt2FtfQ7fK5M3qX6whcp6h9eJthAVAVbb7zQV1QhlcgTeUZQ+Zx5y6M
        W3T15137kMr7QoQFy+U9e9lnVnQEjQ8H6td7oQP31H3KW++yL6Vb+q9Rm6vM4ou8Jb2VXZ
        s3qplaLbUn5oGanSVpqxsaUe04Cbrd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-Gnon2iFYPoavERAheM8_FQ-1; Wed, 21 Apr 2021 22:37:43 -0400
X-MC-Unique: Gnon2iFYPoavERAheM8_FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 012CE802575;
        Thu, 22 Apr 2021 02:37:42 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-214.pek2.redhat.com [10.72.13.214])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D63F610A8;
        Thu, 22 Apr 2021 02:37:40 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210421104145.115907-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
Date:   Thu, 22 Apr 2021 10:37:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210421104145.115907-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/4/21 ÏÂÎç6:41, Eli Cohen Ð´µÀ:
> Implement mlx5_get_vq_notification() to return the doorbell address.
> Size is set to one system page as required.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>   drivers/vdpa/mlx5/core/resources.c | 1 +
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
>   3 files changed, 8 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index b6cc53ba980c..49de62cda598 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
>   	u32 pdn;
>   	struct mlx5_uars_page *uar;
>   	void __iomem *kick_addr;
> +	u64 phys_kick_addr;
>   	u16 uid;
>   	u32 null_mkey;
>   	bool valid;
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 6521cbd0f5c2..665f8fc1710f 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
>   		goto err_key;
>   
>   	kick_addr = mdev->bar_addr + offset;
> +	res->phys_kick_addr = kick_addr;
>   
>   	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
>   	if (!res->kick_addr) {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 10c5fef3c020..680751074d2a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>   {
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>   	struct vdpa_notification_area ret = {};
> +	struct mlx5_vdpa_net *ndev;
> +
> +	ndev = to_mlx5_vdpa_ndev(mvdev);
>   
> +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> +	ret.size = PAGE_SIZE;


Note that the page will be mapped in to guest, so it's only safe if the 
doorbeel exclusively own the page. This means if there're other 
registers in the page, we can not let the doorbell bypass to work.

So this is suspicious at least in the case of subfunction where we 
calculate the bar length in mlx5_sf_dev_table_create() as:

table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);

It looks to me this can only work for the arch with PAGE_SIZE = 4096, 
otherwise we can map more into the userspace(guest).

Thanks



>   	return ret;
>   }
>   

