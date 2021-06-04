Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C084739B068
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhFDCds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:33:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39689 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhFDCdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622773922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ER+R9Jl5XhwxccKJlvpYXmmwxORWURurFR7gOzA5Ic=;
        b=FMk9ISbfdNLlo+s+4ap9rguVry2j/OWRhI5H0dinQb2NiXua+ah/rGlutE8fuHp0pB61yV
        bHqmrcu0z/0n92IzDcuSVMpkZVZb3xFdp9vbzea5FOFe8q/A+wAxQSh5DxNTrRy7F1lA7p
        Mx04U+g9wVqLvHzDvjbq8gwDtaCuaWc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-TbTmMwILMoShXTYjdGk-OQ-1; Thu, 03 Jun 2021 22:32:01 -0400
X-MC-Unique: TbTmMwILMoShXTYjdGk-OQ-1
Received: by mail-pg1-f200.google.com with SMTP id 28-20020a63135c0000b029021b78388f01so5065226pgt.23
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1ER+R9Jl5XhwxccKJlvpYXmmwxORWURurFR7gOzA5Ic=;
        b=J+jA4G9Cfso/DIvKCwo1qIf9YgPGbS2mv5KfbNGP997xY7PjZT6jzIRslMRBacJxNy
         ZE3UarzYSeTlQa1eEU60kE/6xg0PrTSud910saelE8ltrtLCIVd0Pk4JbmYpeOvtDBOl
         kzrGvQ3ao/M/jJJI1X82ztyRZJLIyX9HFKqqIMg59Ya2aBg3bbr91ptNVdEXZrhHrYu0
         Iahg0A3rsgPIL6djhUTWitPYOePTDoOYyI9s3AEFmTOpDdxsTK6BSZsXBngg6ZOVhN1X
         VFnqHlaqeYHNH8aZCwjmWrXX5BOAh0g6kFXI2oMcRdMUYMxzvlACWeW1W/0LbvdiciSc
         BnSA==
X-Gm-Message-State: AOAM53300dq4MHm0Al9B73Uh7q+9TwFypemSTH526zFSszp824vUnp2S
        TRP9h0auxaYB4BR1NOwDktt16Usf1Awep7a5ErERsCRx/Ljf1CgcdBFScwb6BvZwhTrD1qOVibR
        j6oR0eBmPC5eC/nynfxjG/h07EXgNzP8T8l4UOI30iwLBETO0ezUesf8vutq3txqDAnRcie5qRp
        gH
X-Received: by 2002:a63:803:: with SMTP id 3mr2524815pgi.344.1622773919697;
        Thu, 03 Jun 2021 19:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTA1Z9LbyV3J3zEgf7+sU1jjmtq1JtXpQlvGr520SAKpAwmN2o24N1cV3orayvrMF19LfnZA==
X-Received: by 2002:a63:803:: with SMTP id 3mr2524794pgi.344.1622773919394;
        Thu, 03 Jun 2021 19:31:59 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l8sm363994pgq.49.2021.06.03.19.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 19:31:58 -0700 (PDT)
Subject: Re: [PATCH v2] vdpa/mlx5: Add support for doorbell bypassing
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210603081153.5750-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <21c3bf84-7caf-cc64-2432-b19f46622fb9@redhat.com>
Date:   Fri, 4 Jun 2021 10:31:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603081153.5750-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/3 ÏÂÎç4:11, Eli Cohen Ð´µÀ:
> Implement mlx5_get_vq_notification() to return the doorbell address.
> Since the notification area is mapped to userspace, make sure that the
> BAR size is at least PAGE_SIZE large.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 --> v1:
>    Make sure SF bar size is not smaller than PAGE_SIZE
> v1 --> v2:
>    Remove test on addr alignment since it's alrady done by the caller.


Acked-by: Jason Wang <jasowang@redhat.com>


>
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>   drivers/vdpa/mlx5/core/resources.c |  1 +
>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 14 ++++++++++++++
>   3 files changed, 16 insertions(+)
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
> index 689d3fa61e08..bc33f2c523d3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1879,8 +1879,22 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>   
>   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>   {
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>   	struct vdpa_notification_area ret = {};
> +	struct mlx5_vdpa_net *ndev;
> +	phys_addr_t addr;
>   
> +	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
> +	 * notification to avoid the risk of mapping pages that contain BAR of more
> +	 * than one SF
> +	 */
> +	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
> +		return ret;
> +
> +	ndev = to_mlx5_vdpa_ndev(mvdev);
> +	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> +	ret.addr = addr;
> +	ret.size = PAGE_SIZE;
>   	return ret;
>   }
>   

