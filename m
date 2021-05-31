Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C539541C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhEaDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhEaDEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622430151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlzLP9cDBuypH+co4NfKjwM55SCL4ZjJRzPsMReFNRo=;
        b=WsLtgt9aRC9XWv5eEj2myKMYMjutDFTt7mNgkwW4sexxA2G1DArT97yskaOj7sRzSOjbQX
        maJPO8SAe0sStcXK6QlmXZymyzkawqI9ItZdOcLqaxMOJTix5/klWla9Guloi5Qg2a/CJz
        Yfc/hsjbbZLiGietuaDgNnt9NdZll7M=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-cWNUQVaTPDWo6IvBzxALMQ-1; Sun, 30 May 2021 23:02:30 -0400
X-MC-Unique: cWNUQVaTPDWo6IvBzxALMQ-1
Received: by mail-pf1-f198.google.com with SMTP id h185-20020a6283c20000b02902d40a248917so5208252pfe.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 20:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=RlzLP9cDBuypH+co4NfKjwM55SCL4ZjJRzPsMReFNRo=;
        b=FZQulVP+ZCv0TtFBwaZmHGoWVNj2tjnBKcgRqCxIw80N0VxIGH1rtLyPO/IcfvF7Xk
         3ZM5CizGaJlgZaNsA9VLULnhYGJfb0D46BVk5urijy1H2uokTXcA78wl402MmYLPa/gj
         86HtMX4czyAh416g/9GBfGp6uGiqmiI+DF5P+OMTlQD+pPfccL2RRQy/GSJjAeG5quPw
         KhIwBPG54TYpdJaJStnfiHGJ7RvdZbNpgTuOr8yUl617X6sF4wscc0jd6vMvryGBbRDo
         6umSyqirq2CDIzi+0VVnzKvRsnaOxx02X3s/car+zolzNCe8WsfM1RX/VPNmNVhorltJ
         XbQw==
X-Gm-Message-State: AOAM533HYnKqCdmpWIWB6bpz2y4Af5uJntgMXITfmZibzVxaMxRXm7j0
        +F/aXXm+p08K5FtU13n/dELzXTiD3MKZNtwzirFMuipuIZaFlsefuLis9+KjbPO7ZIOxveNKfpJ
        ImTQRGSHyFy4U8k+L5Bm1yGN1YCucjfKqoBhwQdHDxsMNaiV3w8jtMMnvXa71K0fWNx5DifO4UX
        1K
X-Received: by 2002:a17:90a:b294:: with SMTP id c20mr16794750pjr.236.1622430148855;
        Sun, 30 May 2021 20:02:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjtTbccwyZv6xn0V6J4JGVL5xRVBUofxiR5wbmsLL5CF8elClM8l9yQI5vGTq+9Jo/DURJQw==
X-Received: by 2002:a17:90a:b294:: with SMTP id c20mr16794708pjr.236.1622430148409;
        Sun, 30 May 2021 20:02:28 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h24sm9669974pfn.180.2021.05.30.20.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 20:02:27 -0700 (PDT)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
Date:   Mon, 31 May 2021 11:02:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210530075415.4644-2-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/5/30 ÏÂÎç3:54, Eli Cohen Ð´µÀ:
> Currently all resources must be created with uid != 0 which is essential
> userspace processes allocating virtquueue resources. Since this is a
> kernel implementation, it is perfectly legal to open resources with
> uid == 0.
>
> In case frimware supports, avoid allocating user context.


Typo "frimware".

Otherwise.

Acked-by: Jason Wang <jasowang@redhat.com>

(I don't see any code to check the firmware capability, is this intended?)

Thanks


>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>   drivers/vdpa/mlx5/core/resources.c | 6 ++++++
>   include/linux/mlx5/mlx5_ifc.h      | 4 +++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> index 6521cbd0f5c2..836ab9ef0fa6 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
>   	void *in;
>   	int err;
>   
> +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> +		return 0;
> +
>   	/* 0 means not supported */
>   	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
>   		return -EOPNOTSUPP;
> @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
>   	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
>   	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
>   
> +	if (!uid)
> +		return;
> +
>   	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
>   	MLX5_SET(destroy_uctx_in, in, uid, uid);
>   
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index 9c68b2da14c6..606d2aeacad4 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
>   	u8         uar_4k[0x1];
>   	u8         reserved_at_241[0x9];
>   	u8         uar_sz[0x6];
> -	u8         reserved_at_250[0x8];
> +	u8         reserved_at_248[0x2];
> +	u8         umem_uid_0[0x1];
> +	u8         reserved_at_250[0x5];
>   	u8         log_pg_sz[0x8];
>   
>   	u8         bf[0x1];

