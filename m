Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2F5395421
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 05:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhEaDIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 23:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229952AbhEaDIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 23:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622430426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTL2/UjTdSDOPQHR1aCCCG4K/bbvo6rC4h36u+FwzVY=;
        b=h/L5EzfpSWF3vCJVePQ0SeGOJGDQwWlA/eY/0nuGZY4+j2smaRbk0VTfUPIsjbFLZkAWNa
        6VktGHQD52dQj4SxKeVraDzabbigH43Nps3jJ/19VLBY6MAvo/vMLIRLVyEyC14L7h0jkW
        SiAP4szLiwHWH6vTN5xvDEuKOVJOdWc=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-eOK51-GLOdiLJq2vgRcibQ-1; Sun, 30 May 2021 23:07:04 -0400
X-MC-Unique: eOK51-GLOdiLJq2vgRcibQ-1
Received: by mail-pf1-f199.google.com with SMTP id g12-20020a056a000b8cb02902e9e0e19fdcso220842pfj.14
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 20:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hTL2/UjTdSDOPQHR1aCCCG4K/bbvo6rC4h36u+FwzVY=;
        b=QPs/qcHY/GSlIX0Vp6QzsrcTj8HiA9XgLvHM8Bv8hgnQHAFDwGk7VE4fH9I+PY/GNr
         x4jcQR4HIIN3Sccp7XUWSNKxmotqNQeBZIvMkxqOmkHUB/SQV5qaj9kD9PEJgCvwQjWK
         ukuizwclpdpoxAP/S7aatNqWX0GvFp7qWhSiNQEP9wvrR9Xwo8mFXxzd/UK1qgcIpXun
         svgBIx5AxL52vngHuEC1Fh74XNH8BLSsXTqAKkPOqY/axNC3toKUgDUcdEhAdVf0qr8o
         bdyvirjRX7eL043x/CqSqIyDKaywxOZHggVQx6l3U58fDGvE1+jvoiUvAsq0jL9/Nfxa
         XiqA==
X-Gm-Message-State: AOAM533owkz6ZLNo8MxGOQ4bsStIlMRXHkBaiJSkXgwTqK6OD1o6Ez82
        /m3I2WTtuAb0p789y1a7axVsXfVGjy9HzQGQ8Zqleb5+gpEuVVu+nwrYzpFYds05GG2MBxj07cF
        CNqI5nJ8uoS+2V+zwiRHIC4YhRU5Tc+VA7vFa6/04eZbtV3IpSEQcKBJK9eq1e1zbaAMws+YOXZ
        HE
X-Received: by 2002:a62:784d:0:b029:2e9:a58e:8006 with SMTP id t74-20020a62784d0000b02902e9a58e8006mr9607582pfc.22.1622430423015;
        Sun, 30 May 2021 20:07:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSXSRoiyGyb8UjJ1wU1rpb9kNRkk78MgyQIEwemII8V7lJwu5BlyWD/0iUDxZIE8BXUTNp5w==
X-Received: by 2002:a62:784d:0:b029:2e9:a58e:8006 with SMTP id t74-20020a62784d0000b02902e9a58e8006mr9607551pfc.22.1622430422615;
        Sun, 30 May 2021 20:07:02 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id t24sm9532418pji.56.2021.05.30.20.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 May 2021 20:07:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
From:   Jason Wang <jasowang@redhat.com>
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
 <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
Message-ID: <c9c2a453-7ceb-a0ad-7731-d150b3bc1e53@redhat.com>
Date:   Mon, 31 May 2021 11:06:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/5/31 上午11:02, Jason Wang 写道:
>
> 在 2021/5/30 下午3:54, Eli Cohen 写道:
>> Currently all resources must be created with uid != 0 which is essential
>> userspace processes allocating virtquueue resources. Since this is a
>> kernel implementation, it is perfectly legal to open resources with
>> uid == 0.
>>
>> In case frimware supports, avoid allocating user context.
>
>
> Typo "frimware".
>
> Otherwise.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> (I don't see any code to check the firmware capability, is this 
> intended?)


Speak too fast. I see the MLX5_CAP_GEN(), so it's fine.

Thanks


>
> Thanks
>
>
>>
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/core/resources.c | 6 ++++++
>>   include/linux/mlx5/mlx5_ifc.h      | 4 +++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/core/resources.c 
>> b/drivers/vdpa/mlx5/core/resources.c
>> index 6521cbd0f5c2..836ab9ef0fa6 100644
>> --- a/drivers/vdpa/mlx5/core/resources.c
>> +++ b/drivers/vdpa/mlx5/core/resources.c
>> @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, 
>> u16 *uid)
>>       void *in;
>>       int err;
>>   +    if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
>> +        return 0;
>> +
>>       /* 0 means not supported */
>>       if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
>>           return -EOPNOTSUPP;
>> @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev 
>> *mvdev, u32 uid)
>>       u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
>>       u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
>>   +    if (!uid)
>> +        return;
>> +
>>       MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
>>       MLX5_SET(destroy_uctx_in, in, uid, uid);
>>   diff --git a/include/linux/mlx5/mlx5_ifc.h 
>> b/include/linux/mlx5/mlx5_ifc.h
>> index 9c68b2da14c6..606d2aeacad4 100644
>> --- a/include/linux/mlx5/mlx5_ifc.h
>> +++ b/include/linux/mlx5/mlx5_ifc.h
>> @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
>>       u8         uar_4k[0x1];
>>       u8         reserved_at_241[0x9];
>>       u8         uar_sz[0x6];
>> -    u8         reserved_at_250[0x8];
>> +    u8         reserved_at_248[0x2];
>> +    u8         umem_uid_0[0x1];
>> +    u8         reserved_at_250[0x5];
>>       u8         log_pg_sz[0x8];
>>         u8         bf[0x1];

