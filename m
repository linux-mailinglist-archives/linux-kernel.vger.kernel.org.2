Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7449D31484D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 06:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBIFnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 00:43:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10698 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhBIFns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 00:43:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602220ec0000>; Mon, 08 Feb 2021 21:43:08 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 9 Feb
 2021 05:43:07 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 9 Feb 2021 05:43:05 +0000
Date:   Tue, 9 Feb 2021 07:43:02 +0200
From:   Eli Cohen <elic@nvidia.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209054302.GA210455@mtl-vdi-166.wap.labs.mlnx>
References: <20210208161741.104939-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210208161741.104939-1-sgarzare@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612849388; bh=sduqI8fisHYZb6O+x6CK5wcwpqTRCTMEItaSkCAkKSw=;
        h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:User-Agent:
         X-Originating-IP:X-ClientProxiedBy;
        b=fdaSdR23QzPNqU2UVYqyoiKDNhkZ227BCw4j8NLMhmjyXAm6AU+ZN91zy325/QlXF
         LKqu0PCEqoAgEQAEH599QTVoiXnkLXAnbXxxvbQcAF6vXn7druRBel4eZCHJBdO3wY
         VlLFMh4vr4OLRL0T2tcklUfYl0CWNVyADQk33HFRNnrKPEHCZhYw0cy9xnxSTZAeC+
         4nt8/HXTEnmjnFUyHMdivtN2pGQJ0X58muq8vRMgOElPzckrqPkFmfqLZzr89RSru8
         wVOovJQxs/QddSYaT4KHJUenI2g1j3XGHZf4Ur6hm3aNWBqK4HztD4ltSscmj/hbYR
         XKMhku+uKpSGw==
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

Acked-by: Eli Cohen <elic@nvidia.com>

BTW, same error in vdpa_sim you may want to fix.

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
>  
> -- 
> 2.29.2
> 
