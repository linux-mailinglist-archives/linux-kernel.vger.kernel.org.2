Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B6339B075
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 04:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFDCgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 22:36:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhFDCgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 22:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622774075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ATIV3lDYkeBG2ItauQh63eZvgnQmlyDQqyjAxJgLIM4=;
        b=GoLV3pOQKVc9PnTbkiODNpQvVHBgYRq45lhMv5aw3zDDi3WBug2wvHqDe7JjHejPh3ME3N
        un8jwapTuYz29mysngMifnd2lL4x0hWqiaiRa/yukwefx9Oi7vyelMrWdeuBAMqj3x78YW
        leGocvqaef3shlOZG47va1CcwnBky6I=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-lesbuJTsNBOfMu3lrUDdGw-1; Thu, 03 Jun 2021 22:34:34 -0400
X-MC-Unique: lesbuJTsNBOfMu3lrUDdGw-1
Received: by mail-pg1-f197.google.com with SMTP id 4-20020a6317440000b029021689797ccaso5090949pgx.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 19:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ATIV3lDYkeBG2ItauQh63eZvgnQmlyDQqyjAxJgLIM4=;
        b=MRFqHcfqf8WuY6xez0qIewDDk/mNjEntdn7MojyRFAvDq2cOto6bmvsM6Ddn6FVqFT
         Jj0MVcDREpbfYm5aSD2MeynXxm9X21rtVFE62zAEGWIkDJdcOyvJwnmeZ9ilQaiS42qd
         FJ0csySnNfDWy3911TmmziK7AttlkC4g0nCLFviA8bLB8V4M1PZXpGJ6wi0Oixs38tcH
         kFsFy+fup7SQ7lM4sCvw/mYlen1aHg1JSSNybWdvucAtWP8MIfTfCj10uPLxMG4Jpi63
         VE+8099BysyHcnbpAew/Sm3FrhVVB6RswVWmVY7v0cEbyO9eHtIBJpkdFpjr++PE//Sn
         4kGg==
X-Gm-Message-State: AOAM530n7iKbkgj++Bd0JcpmK1dtSQDtKYJMZyAB9S403/fQJ5+M74yD
        TimElTFkvVQaeyUWmRNanOntb/RnC1FBb5pz/6dyJuyW3MNY9qPPwZix+cR9+JkTEdmBndPrUho
        6uH3lwZ312d87Nx3veupmTO+HkmkS+rk6npS3KIZKGgDGDucP6KPS/mbPQwzp36D3C14sUW2u1A
        19
X-Received: by 2002:a17:90a:5649:: with SMTP id d9mr14107896pji.98.1622774073346;
        Thu, 03 Jun 2021 19:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Q0BWP9i4OnI6AKwpvD0HX9L9iAxi9+TEns1urhL0IXPFrDoiP/Mia4Ml/0TabthZet7qBw==
X-Received: by 2002:a17:90a:5649:: with SMTP id d9mr14107874pji.98.1622774073089;
        Thu, 03 Jun 2021 19:34:33 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 11sm318521pfh.182.2021.06.03.19.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 19:34:32 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Clear vq ready indication upon device reset
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210603081026.5640-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9ec6480d-3eee-c644-2a06-8a180aa9fb07@redhat.com>
Date:   Fri, 4 Jun 2021 10:34:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603081026.5640-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/3 ÏÂÎç4:10, Eli Cohen Ð´µÀ:
> After device reset, the virtqueues are not ready so clear the ready
> field.
>
> Failing to do so can result in virtio_vdpa failing to load if the device
> was previously used by vhost_vdpa and the old values are ready.
> virtio_vdpa expects to find VQs in "not ready" state.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 --> v1:
>    Make sure clear of ready is done only in reset flow
>
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 02a05492204c..eaeae67e0ff0 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1766,6 +1766,14 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev)
>   	mutex_unlock(&ndev->reslock);
>   }
>   
> +static void clear_vqs_ready(struct mlx5_vdpa_net *ndev)
> +{
> +	int i;
> +
> +	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--)
> +		ndev->vqs[i].ready = false;


The patch looks correct but I wonder the reason for the decreasing used 
in the loop.

Usually, it means it has some reason that must be done in that way.

Thanks


> +}
> +
>   static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   {
>   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -1776,6 +1784,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
>   	if (!status) {
>   		mlx5_vdpa_info(mvdev, "performing device reset\n");
>   		teardown_driver(ndev);
> +		clear_vqs_ready(ndev);
>   		mlx5_vdpa_destroy_mr(&ndev->mvdev);
>   		ndev->mvdev.status = 0;
>   		ndev->mvdev.mlx_features = 0;

