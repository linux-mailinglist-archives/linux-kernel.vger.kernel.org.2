Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42195399BF1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFCHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:50:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21828 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhFCHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622706553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t2A9CGiOMZhMhfDQcj3P5Ci9kIgs20PIu0iiJiXQ0zk=;
        b=Nb0nZnN84jVXZx8u11OBIzsrG8LPoVK5kojE4hYE+BixbfxQhTLSIyJJ2rWC5MyngGOpEk
        I6w7jRqEfr181W2bXcCP1BkFRoUeuogiUOhwY8KrpNfo5blFDiE7pbwg1y+HjHOhrj67lU
        BiswLtc+Zr6KU0M8wSlN4ERM4Btb0zw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-5xkFSvaJM9m22H_BIitDsg-1; Thu, 03 Jun 2021 03:49:10 -0400
X-MC-Unique: 5xkFSvaJM9m22H_BIitDsg-1
Received: by mail-pj1-f69.google.com with SMTP id f8-20020a17090a9b08b0290153366612f7so2783377pjp.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 00:49:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=t2A9CGiOMZhMhfDQcj3P5Ci9kIgs20PIu0iiJiXQ0zk=;
        b=T3h0/pGwI4ixYY7CgptRC/4wUjscctimaNgVgDencMQDGOWxKZrgA2toPNfrD6B4XS
         3vNJURRiyJd2t776Xc95468KTKa2Ha+NwgzQ8QsubzbACeBEJ2DYo8Tg1a7ADKMuzr7o
         IVYVFFSdpwQX0UlGgtWj2LkXZ+yb+tzjO2VyC9PvRQHB9h7Eza67kACr5iaDU1KC1NIH
         Rq4/mLB/nammlQqpu8doNjVMw9IfnqEBDrm7zwKpHhdmDM17Wi8oMEoFKZlGgWdQoaLD
         BAZnXr2QoCRdRE/5beJUUeFdc6znhPPKy6gRFVYO04wmEiYYtB05Yt+2KVUJVC5uCx8l
         0TDA==
X-Gm-Message-State: AOAM530IKOwvpE+oRneFz4wnhe/oNtcA0dI4MF50yBfgg0FsFDNnVvwo
        gMYqD1MRl6K2n/UMYLguhK/APyCES9KETL92GI+N2SCgE4DOg1cZyBCAgizOZmfwv7u6q6Hsvf2
        lNhe0IxQ+OD/1I/iTuxGrIubOgFj7dvEydJ6zw1UVLpiiUylFt5fx9ssm662/4Q1hT3ZZqYt1FE
        KF
X-Received: by 2002:a17:902:e5d1:b029:107:810b:9f09 with SMTP id u17-20020a170902e5d1b0290107810b9f09mr13402439plf.83.1622706548989;
        Thu, 03 Jun 2021 00:49:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG1kHzMlk/6bgLGiT7M+fez88v/bqO0OSrRP1I21Nb0TVRNHi1+b2//xRb2XxgVhHvx/ciHw==
X-Received: by 2002:a17:902:e5d1:b029:107:810b:9f09 with SMTP id u17-20020a170902e5d1b0290107810b9f09mr13402417plf.83.1622706548531;
        Thu, 03 Jun 2021 00:49:08 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a188sm1553571pfa.59.2021.06.03.00.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 00:49:08 -0700 (PDT)
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
To:     Eli Cohen <elic@nvidia.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210602095358.83318-1-elic@nvidia.com>
 <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
 <20210603073840.GB58414@mtl-vdi-166.wap.labs.mlnx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <3ec31690-4cd8-1ea8-31dd-dfd3a8a25180@redhat.com>
Date:   Thu, 3 Jun 2021 15:49:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603073840.GB58414@mtl-vdi-166.wap.labs.mlnx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/6/3 下午3:38, Eli Cohen 写道:
> On Thu, Jun 03, 2021 at 03:11:51PM +0800, Jason Wang wrote:
>> 在 2021/6/2 下午5:53, Eli Cohen 写道:
>>> Implement mlx5_get_vq_notification() to return the doorbell address.
>>> Since the notification area is mapped to userspace, make sure that the
>>> BAR size is at least PAGE_SIZE large.
>>>
>>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>>> ---
>>> v0 --> v1:
>>>     Make sure SF bar size is not smaller than PAGE_SIZE
>>>
>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
>>>    drivers/vdpa/mlx5/core/resources.c |  1 +
>>>    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 17 +++++++++++++++++
>>>    3 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> index 09a16a3d1b2a..0002b2136b48 100644
>>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>>> @@ -42,6 +42,7 @@ struct mlx5_vdpa_resources {
>>>    	u32 pdn;
>>>    	struct mlx5_uars_page *uar;
>>>    	void __iomem *kick_addr;
>>> +	u64 phys_kick_addr;
>>>    	u16 uid;
>>>    	u32 null_mkey;
>>>    	bool valid;
>>> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
>>> index 836ab9ef0fa6..d4606213f88a 100644
>>> --- a/drivers/vdpa/mlx5/core/resources.c
>>> +++ b/drivers/vdpa/mlx5/core/resources.c
>>> @@ -253,6 +253,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
>>>    		goto err_key;
>>>    	kick_addr = mdev->bar_addr + offset;
>>> +	res->phys_kick_addr = kick_addr;
>>>    	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
>>>    	if (!res->kick_addr) {
>>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> index 5500bcfe84b4..1936039e05bd 100644
>>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>>> @@ -1871,8 +1871,25 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
>>>    static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>>>    {
>>> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>>    	struct vdpa_notification_area ret = {};
>>> +	struct mlx5_vdpa_net *ndev;
>>> +	phys_addr_t addr;
>>> +
>>> +	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
>>> +	 * notification to avoid the risk of mapping pages that contain BAR of more
>>> +	 * than one SF
>>> +	 */
>>> +	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
>>> +		return ret;
>>> +
>>> +	ndev = to_mlx5_vdpa_ndev(mvdev);
>>> +	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
>>> +	if (addr & ~PAGE_MASK)
>>> +		return ret;
>>
>> This has been checked by vhost-vDPA, and it's better to leave those policy
>> checking to them driver instead of checking it in the parent.
>>
> Not in all invocations of get_vq_notification(). For example, in
> vhost_vdpa_fault() you call remap_pfn_range() with notify.addr >>
> PAGE_SHIFT so it it was not aligned you mask this misalignment.


In order to have vhost_vdpa_fault() works, it should first pass the 
check of vhost_vdpa_mmap().

Othewise we won't install vma->vm_ops so there won't be a page fault for 
the doorbell.

Thanks


>
>> Thanks
>>
>>
>>> +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
>>> +	ret.size = PAGE_SIZE;
>>>    	return ret;
>>>    }

