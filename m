Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD473956FC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhEaIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230361AbhEaIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622449795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=inr+zuiQM4jK2t4kQOlK3qn2dW0FR37ENWGawz0lq4U=;
        b=Vs8VqNEC5ciKUA67yic/MzAdy+KLXdbY/Har0NMXYzavw8q2WR5QaD3+SPmglIkSv83rmo
        MTRI9M5zOvC8tZL1kB4GjFv1PKFn/gtItIqEVKg5Hb4ZKk/fVzOAMzlTVnlRVgYXzdiT6y
        Qy5ZLO3V2RbLv2QO+/2jjsfoyHpiwT4=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-ju0DPZ7eN-WzYnf5BVOH6g-1; Mon, 31 May 2021 04:29:52 -0400
X-MC-Unique: ju0DPZ7eN-WzYnf5BVOH6g-1
Received: by mail-pg1-f200.google.com with SMTP id 15-20020a630c4f0000b029021a6da9af28so6815718pgm.22
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=inr+zuiQM4jK2t4kQOlK3qn2dW0FR37ENWGawz0lq4U=;
        b=Q/Ylg8O0Fu4G08qFu2exXhe6uNQNZ2q9DqT+8/Eu2KyAtw6Y4w2PqSzcYXZvP4cdg1
         twoAUzm0eXBES/MLGYoJNzByTGX069W2O7y+8VPf+Z2M8ckqtblaQ56PmjJrKB+yI3l0
         Td5iuZxnUahSGAH6IYGrJaIHKHXnQ8HamK/EWSJ8WEYQqnHyshYaXh0NL9nv5ar2WtnX
         SOk2PC3LCYZVWzJuOB7OS2rGLGjlwWcCvAgP6hmu8fqWUcJVgThahTTaVWPCnwWaKQHw
         DbleYi+hWvUbNAY0eU/sSxYfSnsemjfzGZklENefGJRmNQhYyRAL/i1DMpnD5l6uuQpK
         MVIg==
X-Gm-Message-State: AOAM532BagQ+xvuoEeULOlyllycEJW5cRT/mAp0NslMIPuLiN/zIpk7Q
        ytpu1zNFRsvYIW3QFjVnhU3UKhgme7/AYfgqJYR9cuSIkB5+NN9Z1NvZ3fWLECF7jFp4yom0wEJ
        cmrDjzOZw8cN1mP7oEgIX2yiuy+/2rIj4vUnjYVgZHyPQnVM8swWx862uqLjO8Rva3zgvfN5MBq
        5o
X-Received: by 2002:a62:c541:0:b029:2e8:c7c7:d96e with SMTP id j62-20020a62c5410000b02902e8c7c7d96emr15691279pfg.26.1622449790705;
        Mon, 31 May 2021 01:29:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvMO2iCf1DBX0Bz84EkdLoS9QITer2XbpKjMQiElMdzUPSCzek7QWcLvYxad6JYHkCnpiRPg==
X-Received: by 2002:a62:c541:0:b029:2e8:c7c7:d96e with SMTP id j62-20020a62c5410000b02902e8c7c7d96emr15691247pfg.26.1622449790317;
        Mon, 31 May 2021 01:29:50 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a21sm10305056pfk.152.2021.05.31.01.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 01:29:49 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Fix possible failure in umem size
 calculation
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210530090349.8360-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ecf0afb2-14cc-2350-894c-017ebffcdf35@redhat.com>
Date:   Mon, 31 May 2021 16:29:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530090349.8360-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/30 ÏÂÎç5:03, Eli Cohen Ð´µÀ:
> umem size is a 32 bit unsigned value so assigning it to an int could
> cause false failures. Set the calculated value inside the function and
> modify function name to reflect the fact it updates the size.
>
> This bug was found during code review but never had real impact to this
> date.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> V0 --> V1:
>    Add more info in changelog
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 53312f0460ad..fdf3e74bffbd 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
>   	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
>   }
>   
> -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> -		     struct mlx5_vdpa_umem **umemp)
> +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> +			  struct mlx5_vdpa_umem **umemp)
>   {
>   	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
>   	int p_a;
> @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
>   		*umemp = &mvq->umem3;
>   		break;
>   	}
> -	return p_a * mvq->num_ent + p_b;
> +	(*umemp)->size = p_a * mvq->num_ent + p_b;
>   }
>   
>   static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
>   	void *in;
>   	int err;
>   	__be64 *pas;
> -	int size;
>   	struct mlx5_vdpa_umem *umem;
>   
> -	size = umem_size(ndev, mvq, num, &umem);
> -	if (size < 0)
> -		return size;
> -
> -	umem->size = size;
> -	err = umem_frag_buf_alloc(ndev, umem, size);
> +	set_umem_size(ndev, mvq, num, &umem);
> +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
>   	if (err)
>   		return err;
>   

