Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D331471C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBIDgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24375 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhBIDZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612841055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEaydSkEX8erChBy2g+JUKqaHNN0oPrHU7w4kkEF1Es=;
        b=JC+2TZNuydDbW9Zvey3D0BGWRSfGLHxA8IpTDPJQRqemv3G3Rm54/6mvLMP55KidELM74W
        O+R22icXFNxlH2S4/DXjf1hvvDXn2oZxsKx9eJKXKCtw5Hd4xHvPScNYnoB/+rF1v28B6r
        6ruoKb28VaKcWVpbBOZacNMZA/JJkc0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-T_dfgWtlPb2WaT3yA5OSDQ-1; Mon, 08 Feb 2021 22:24:11 -0500
X-MC-Unique: T_dfgWtlPb2WaT3yA5OSDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C697192D787;
        Tue,  9 Feb 2021 03:24:10 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 889B419C66;
        Tue,  9 Feb 2021 03:24:05 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
Date:   Tue, 9 Feb 2021 11:24:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208133312-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/9 上午2:38, Michael S. Tsirkin wrote:
> On Mon, Feb 08, 2021 at 05:17:41PM +0100, Stefano Garzarella wrote:
>> It's legal to have 'offset + len' equal to
>> sizeof(struct virtio_net_config), since 'ndev->config' is a
>> 'struct virtio_net_config', so we can safely copy its content under
>> this condition.
>>
>> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index dc88559a8d49..10e9b09932eb 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>>   	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>   	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>>   
>> -	if (offset + len < sizeof(struct virtio_net_config))
>> +	if (offset + len <= sizeof(struct virtio_net_config))
>>   		memcpy(buf, (u8 *)&ndev->config + offset, len);
>>   }
> Actually first I am not sure we need these checks at all.
> vhost_vdpa_config_validate already validates the values, right?


I think they're working at different levels. There's no guarantee that 
vhost-vdpa is the driver for this vdpa device.


>
> Second, what will happen when we extend the struct and then
> run new userspace on an old kernel? Looks like it will just
> fail right? So what is the plan?


In this case, get_config() should match the spec behaviour. That is to 
say the size of config space depends on the feature negotiated.

Thanks


>   I think we should
> allow a bigger size, and return the copied config size to userspace.
>
>
>> -- 
>> 2.29.2

