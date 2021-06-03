Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F077B399B2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbhFCHCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:02:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhFCHCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622703623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PueWFJYsB4q2dbMbGSJGobObFbdsaUmedr2PiYlLS3o=;
        b=FLa5ACR15wc9F88Qkr2wUbiEfOzR4Sozi/bBOYNBW6bKTImRavyHtTX713X/4scfzJENVi
        izb4lY6ZURZJynsfsiInomP1tdPNTHTXNlbN55lcL6yMHnqB8FynT0wIyViVX8lPr9z4Lg
        uoIUxoEB5lzNnZR50fiLzDlYOK13jro=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-dK3WdQHTOLuxkASdqNNj5w-1; Thu, 03 Jun 2021 03:00:20 -0400
X-MC-Unique: dK3WdQHTOLuxkASdqNNj5w-1
Received: by mail-pg1-f198.google.com with SMTP id v12-20020a63d54c0000b02902167d3d2f08so3400561pgi.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PueWFJYsB4q2dbMbGSJGobObFbdsaUmedr2PiYlLS3o=;
        b=JOTDEX/+ibHsQYdQ8DnhqoUVZ0J1m4/SIPRhTHxnYoyld86AvdUo1jRlFH16qfpiJ7
         eX82apKYihDJx4y2+V1yHyouLgJL1PJ5U6MHMj77PggcehZ558NKtDadTpUcP5VYyLTc
         +1zld4cz1N6PcjpWExo6to0jq1jV8xVVQft32IDPjMx/So02itbqRn6rTLo1Rkfayt+c
         PhoTINhb/ijah+HhMG3cAYY3+LM5TU8lzEiWX92hH3RFSn9AdBScQVrq6RIugRfnam+W
         oGXDTuTyDHTs9/wUaxGKVC4QPKtH8TP2e2zEUqHmCAMA7FyepmJ1wk2hCDMM9Es6QQbM
         OGRQ==
X-Gm-Message-State: AOAM531kFUPcxRAHFEC57ofcvogLekrYXJH4tStdA1zlyX+tEBhHj2jQ
        iPBC+B4NmvngEd8OIFL5d5zhq0Nj/WoZ29DstCd9nlUeUJCRMZhO9ORBI20nJqIZZy57fAjgzK6
        C6BXQEPXOrAeofzJOiV+qx7rR7Ibf12j2iF+Uz8y4lkXFlw0uPVK0b/d0h41bRQxk7jWuLWYLfF
        cz
X-Received: by 2002:a17:90a:ff94:: with SMTP id hf20mr9823068pjb.6.1622703619483;
        Thu, 03 Jun 2021 00:00:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwuFat3ur7ckvX8vpf934U3+NTqjjQzslUJJI4ns7h5rf5mia5EcivLXOiFvCSKUi6MFLcDMA==
X-Received: by 2002:a17:90a:ff94:: with SMTP id hf20mr9823035pjb.6.1622703619247;
        Thu, 03 Jun 2021 00:00:19 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id 19sm1128554pfn.43.2021.06.03.00.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:00:18 -0700 (PDT)
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
To:     Eli Cohen <elic@nvidia.com>, mst@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210602085924.62777-1-elic@nvidia.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
Date:   Thu, 3 Jun 2021 15:00:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602085924.62777-1-elic@nvidia.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/6/2 ÏÂÎç4:59, Eli Cohen Ð´µÀ:
> After device reset, the virtqueues are not ready so clear the ready
> field.
>
> Failing to do so can result in virtio_vdpa failing to load if the device
> was previously used by vhost_vdpa and the old values are ready.
> virtio_vdpa expects to find VQs in "not ready" state.
>
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Eli Cohen <elic@nvidia.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 02a05492204c..e8bc0842b44c 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -862,6 +862,7 @@ static void destroy_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq
>   		return;
>   	}
>   	umems_destroy(ndev, mvq);
> +	mvq->ready = false;
>   }
>   
>   static u32 get_rqpn(struct mlx5_vdpa_virtqueue *mvq, bool fw)

