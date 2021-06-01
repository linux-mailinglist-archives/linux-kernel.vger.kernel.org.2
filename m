Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79079396AC4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 03:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhFAB4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 21:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232042AbhFAB4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 21:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622512504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ASyMBPQPEsfDziJ+K95xbpCDWyQpQmjYvWNZlEBpeY=;
        b=A3y0G6cH6WZOjoCXP863mCQgWDYZ2yXJqtzquDQUcMmXT7JurZDAI+QxgjEiDfVnQcJbEm
        J37QdjzhlUzkYbvFNHy+cEMBmrJkKGg3ldDTUbqgzqa7m3d2RWSqrbyVtIfD8lB5RQIdyw
        Jd9IT4COtGC+W/OWqsHVms2daHvPTvc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-vzU-poZ7NQq18O8tqT5Mcw-1; Mon, 31 May 2021 21:55:02 -0400
X-MC-Unique: vzU-poZ7NQq18O8tqT5Mcw-1
Received: by mail-pl1-f200.google.com with SMTP id 62-20020a1709020544b02900f0a8e26363so3786971plf.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 18:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7ASyMBPQPEsfDziJ+K95xbpCDWyQpQmjYvWNZlEBpeY=;
        b=o7rxCCY9v1v1s8reZ2B942bupAbN4RCLPpdYDf2+FiZws5623YyH/LqZigOu7op9bp
         3KPwe0UGzBUG84zPWDJzypeWgueRTbL4CwygFfl4CPi3MfOmE1AIxqbX6uGCQlhmoKxa
         trZ9H9Wf7xRXY0YZLFmM7+yVyFpifj8lxcR6su/0YivJ4RXPqzjGGX6JmjLOh+WmT15A
         iw72BtOrz2dnfxbYScl+ByRCXPFDR/8RXh8qfF9QXdlfHU8q1QHsWzYmyVRm6Vs+Fq2Z
         KZM21kK5Bd66l38zREJrER6ogriulH/9UtKjvxFox7lp+msgIl8fIKadPWJ+G3CV1HxU
         dDFA==
X-Gm-Message-State: AOAM531TjGFXW/evki9954v5Q21b2zyRN1056o4xRU/MwDKMXFPWPyjF
        aCiCIi/cAxOq8J52RyLtkN2gOdaEK0xoQ1pzptu3vk7qf96BguJg8fdUqvl1B1GGdQC//zUQIFf
        w8tZRN2G/IxEo65VIKY+NMn+b8zmFmD2tVo73X83uUKb26jykbZihLcvIppdqXiNv3tBdIFRP87
        mT
X-Received: by 2002:a17:902:4:b029:fa:670f:f20f with SMTP id 4-20020a1709020004b02900fa670ff20fmr23126206pla.11.1622512501346;
        Mon, 31 May 2021 18:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwackNHk9NU70dohTROxE93bBTCw+m7dTBc2owq9+YhG/iJRBmDXtt6soLUeratGznqq9fVOQ==
X-Received: by 2002:a17:902:4:b029:fa:670f:f20f with SMTP id 4-20020a1709020004b02900fa670ff20fmr23126187pla.11.1622512501000;
        Mon, 31 May 2021 18:55:01 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 195sm154446pfz.24.2021.05.31.18.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 18:55:00 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] vdpa/mlx5: Support creating resources with uid ==
 0
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210531160404.31368-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <09bf796a-2c89-496d-a304-e889f3519a5c@redhat.com>
Date:   Tue, 1 Jun 2021 09:54:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210531160404.31368-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/1 ÉÏÎç12:04, Eli Cohen Ð´µÀ:
> Currently all resources must be created with uid != 0 which is essential
> when userspace processes are allocating virtquueue resources. Since this
> is a kernel implementation, it is perfectly legal to open resources with
> uid == 0.
>
> In case firmware supports, avoid allocating user context.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> v0 --> v1:
>    Fix typo and modify phrasing
>
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

