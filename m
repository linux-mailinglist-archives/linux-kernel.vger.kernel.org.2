Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76EE399B4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:13:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhFCHNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622704321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/mZg6Rd+caE13qcrgBT5LqErzvWPmG8WQ41iAFGpAiA=;
        b=Da+BNEAqAZIwMAEVztddlXyI8coqCVzCluTndsHklipseYiDx24F/Yom1Dxe8WQrVLo++Q
        C2sOUCMa5Kojo/hmryzIWI+BNxKDZ9zREY2VAntD23hCVX7ChQleU07W4cUqLsMJytvZPm
        sVaEfQavXnngW4xvW58sZEHKKB8s+9k=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-8nvWUxOuM2WsL7ove5GLfQ-1; Thu, 03 Jun 2021 03:12:00 -0400
X-MC-Unique: 8nvWUxOuM2WsL7ove5GLfQ-1
Received: by mail-pf1-f198.google.com with SMTP id y11-20020aa79e0b0000b02902e9e0e19fdcso2980553pfq.14
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/mZg6Rd+caE13qcrgBT5LqErzvWPmG8WQ41iAFGpAiA=;
        b=pbSOnbmQ2IfugE5nkmUdOB4iJp0JzsC8Y7L0yMEmDei0MlB2960TQtWv1CYmthLbyx
         EpKFQaH4Ex/XApO2RjJGP4Df+cnB64we//lEIdZ7WaxA6OIuoqTcjN0NunVCx3Ms5CE+
         hu4SAZKCVlBTPP7//+1QaWohuQIrsCIMO7J15omQgwnHQtO+ldMHzfTERCmDvjnH1jx7
         EByYaRSfOXAswJJqr/DUNUYmhAS8DhWY/xx6LsQWuSD0lieNl9c7+ffHPvq/S4eMEuEq
         COYBgZBHnV0aaTA3Nv3/QS6E5MXLNKexdUFEFfYYumW3YhSd7TbS4EAkWdFO3dzWRyP2
         wPqw==
X-Gm-Message-State: AOAM531YzMvkVTeuEN4xD9ahERgx+AchYCZwUzKGX861FWOfrgMCK9ZY
        XECIodBM4Hljhjq3Jx2gOaMfOs0akjDX0zGuQs5Djo4faU/HnRGUseKP52N2yTtRvTgbv2JZzlB
        FSthjv+OZBAe5pMX8RAOBY9eMLVwWLhG/6PfPHfTVC7NB+aVy4d41ffU66cdxYi4GN6kcpfMnnR
        zI
X-Received: by 2002:a65:4286:: with SMTP id j6mr37621883pgp.11.1622704318676;
        Thu, 03 Jun 2021 00:11:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws8WyQDRQptqrThLm0iy+MBLiH7cbhLCecXzxmkaKE5c7hr5ROL7i8/p2U51RCVi/D5NwLYA==
X-Received: by 2002:a65:4286:: with SMTP id j6mr37621845pgp.11.1622704318264;
        Thu, 03 Jun 2021 00:11:58 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 60sm1300265pjz.42.2021.06.03.00.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:11:57 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210602095358.83318-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
Date:   Thu, 3 Jun 2021 15:11:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602095358.83318-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/2 ÏÂÎç5:53, Eli Cohen Ð´µÀ:
> Implement mlx5_get_vq_notification() to return the doorbell address.
> Since the notification area is mapped to userspace, make sure that the
> BAR size is at least PAGE_SIZE large.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 --> v1:
>    Make sure SF bar size is not smaller than PAGE_SIZE
>
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>   drivers/vdpa/mlx5/core/resources.c |  1 +
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 17 +++++++++++++++++
>   3 files changed, 19 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index 09a16a3d1b2a..0002b2136b48 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -42,6 +42,7 @@ struct mlx5_vdpa_resources {
>   	u32 pdn;
>   	struct mlx5_uars_page *uar;
>   	void __iomem *kick_addr;
> +	u64 phys_kick_addr;
>   	u16 uid;
>   	u32 null_mkey;
>   	bool valid;
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 836ab9ef0fa6..d4606213f88a 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -253,6 +253,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
>   		goto err_key;
>   
>   	kick_addr = mdev->bar_addr + offset;
> +	res->phys_kick_addr = kick_addr;
>   
>   	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
>   	if (!res->kick_addr) {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 5500bcfe84b4..1936039e05bd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1871,8 +1871,25 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>   {
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>   	struct vdpa_notification_area ret = {};
> +	struct mlx5_vdpa_net *ndev;
> +	phys_addr_t addr;
> +
> +	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
> +	 * notification to avoid the risk of mapping pages that contain BAR of more
> +	 * than one SF
> +	 */
> +	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
> +		return ret;
> +
> +	ndev = to_mlx5_vdpa_ndev(mvdev);
> +	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> +	if (addr & ~PAGE_MASK)
> +		return ret;


This has been checked by vhost-vDPA, and it's better to leave those 
policy checking to them driver instead of checking it in the parent.

Thanks


>   
> +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> +	ret.size = PAGE_SIZE;
>   	return ret;
>   }
>   

